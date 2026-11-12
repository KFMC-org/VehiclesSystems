(function () {
    "use strict";

    const drawerId = "sf-vehicle-details-drawer";
    const detailsPath = "/vehicle/vehicledetails";
    const drawerEndpoint = "/Vehicle/VehicleDetailsDrawer";

    let activeRequest = null;
    let loadSequence = 0;

    function resolveDrawer() {
        const drawer = document.getElementById(drawerId);

        // Keep the fixed drawer relative to the viewport. SmartRenderer can live
        // inside transformed/scrollable layout containers that otherwise clip it.
        if (drawer && drawer.parentElement !== document.body) {
            document.body.appendChild(drawer);
        }

        return drawer;
    }

    function setHeader(drawer, chassisNumber) {
        const title = drawer.querySelector(".sf-drawer-title");
        const subtitle = drawer.querySelector(".sf-drawer-subtitle");

        if (title) title.textContent = "تفاصيل المركبة";
        if (subtitle) subtitle.textContent = `رقم الهيكل: ${chassisNumber}`;
    }

    function showState(drawer, message, tone) {
        const body = drawer.querySelector(".sf-drawer-body");
        if (!body) return null;

        body.replaceChildren();

        const state = document.createElement("div");
        state.className = "sf-drawer-empty";
        state.setAttribute("role", tone === "error" ? "alert" : "status");
        state.textContent = message;
        body.appendChild(state);

        return body;
    }

    function errorMessage(status) {
        switch (status) {
            case 400:
                return "رقم الهيكل غير صالح.";
            case 401:
                return "انتهت جلسة المستخدم. يرجى تسجيل الدخول مرة أخرى.";
            case 403:
                return "لا تملك صلاحية عرض تفاصيل المركبة.";
            case 404:
                return "لم يتم العثور على بيانات المركبة.";
            default:
                return "تعذر تحميل تفاصيل المركبة. حاول مرة أخرى.";
        }
    }

    async function copyText(value) {
        if (navigator.clipboard?.writeText) {
            await navigator.clipboard.writeText(value);
            return;
        }

        const input = document.createElement("textarea");
        input.value = value;
        input.style.position = "fixed";
        input.style.opacity = "0";
        document.body.appendChild(input);
        input.select();
        document.execCommand("copy");
        input.remove();
    }

    async function loadDetails(drawer, chassisNumber) {
        activeRequest?.abort();
        activeRequest = new AbortController();

        const requestSequence = ++loadSequence;
        const body = showState(drawer, "جارٍ تحميل تفاصيل المركبة…", "loading");
        body?.setAttribute("aria-busy", "true");

        try {
            const url = new URL(drawerEndpoint, window.location.origin);
            url.searchParams.set("chassisNumber", chassisNumber);

            const response = await fetch(url, {
                method: "GET",
                credentials: "same-origin",
                headers: {
                    "Accept": "text/html",
                    "X-Requested-With": "XMLHttpRequest"
                },
                signal: activeRequest.signal
            });

            if (!response.ok) {
                const error = new Error(`HTTP ${response.status}`);
                error.status = response.status;
                throw error;
            }

            const html = await response.text();
            if (requestSequence !== loadSequence ||
                !window.SmartDrawer?.isOpen(drawerId)) {
                return;
            }

            const targetBody = drawer.querySelector(".sf-drawer-body");
            if (!targetBody) throw new Error("Drawer body was not found");

            targetBody.innerHTML = html;
            targetBody.setAttribute("aria-busy", "false");

            window.Alpine?.initTree?.(targetBody);
            window.SmartCharts?.renderKpis?.();
        } catch (error) {
            if (error?.name === "AbortError" || requestSequence !== loadSequence) {
                return;
            }

            showState(drawer, errorMessage(error?.status), "error")
                ?.setAttribute("aria-busy", "false");
        } finally {
            if (requestSequence === loadSequence) activeRequest = null;
        }
    }

    document.addEventListener("click", event => {
        if (event.button !== 0 || event.metaKey || event.ctrlKey ||
            event.shiftKey || event.altKey) {
            return;
        }

        const target = event.target instanceof Element
            ? event.target
            : event.target?.parentElement;
        if (!(target instanceof Element)) return;

        const anchor = target.closest("a[href]");
        if (!anchor) return;

        let url;
        try {
            url = new URL(anchor.href, window.location.origin);
        } catch {
            return;
        }

        if (url.origin !== window.location.origin ||
            url.pathname.replace(/\/$/, "").toLowerCase() !== detailsPath) {
            return;
        }

        const chassisNumber = url.searchParams.get("chassisNumber")?.trim();
        const drawer = resolveDrawer();

        // Keep the normal details link as a progressive fallback.
        if (!chassisNumber || !drawer || !window.SmartDrawer) return;

        event.preventDefault();
        event.stopPropagation();
        event.stopImmediatePropagation();

        setHeader(drawer, chassisNumber);
        showState(drawer, "جارٍ تحميل تفاصيل المركبة…", "loading");

        if (!window.SmartDrawer.open(drawerId, { chassisNumber })) return;
        void loadDetails(drawer, chassisNumber);
    }, true);

    document.addEventListener("sf-drawer:close", event => {
        if (!(event.target instanceof Element) || event.target.id !== drawerId) return;

        activeRequest?.abort();
        activeRequest = null;
        loadSequence++;

        const drawer = event.target;
        const title = drawer.querySelector(".sf-drawer-title");
        const subtitle = drawer.querySelector(".sf-drawer-subtitle");

        if (title) title.textContent = "تفاصيل المركبة";
        if (subtitle) subtitle.textContent = "اختر رقم هيكل لعرض التفاصيل";
        showState(drawer, "اختر رقم هيكل لعرض تفاصيل المركبة", "empty");
    });

    document.addEventListener("click", async event => {
        const target = event.target instanceof Element
            ? event.target
            : event.target?.parentElement;
        const button = target?.closest?.("[data-copy-chassis]");

        if (!button) return;

        event.preventDefault();
        event.stopPropagation();

        const value = button.dataset.copyChassis;
        if (!value) return;

        try {
            await copyText(value);
            const icon = button.querySelector("i");
            button.classList.add("is-copied");
            button.setAttribute("aria-label", "تم نسخ رقم الهيكل");
            if (icon) icon.className = "fa-solid fa-check";

            window.setTimeout(() => {
                button.classList.remove("is-copied");
                button.setAttribute("aria-label", "نسخ رقم الهيكل");
                if (icon) icon.className = "fa-regular fa-copy";
            }, 1400);
        } catch {
            button.setAttribute("aria-label", "تعذر نسخ رقم الهيكل");
        }
    });

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", resolveDrawer, { once: true });
    } else {
        resolveDrawer();
    }
})();
