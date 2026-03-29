(function () {
    console.log("maintenance-orders.js loaded");

    function qs(root, selector) {
        return root ? root.querySelector(selector) : null;
    }

    function qsa(root, selector) {
        return root ? Array.from(root.querySelectorAll(selector)) : [];
    }

    function escapeHtml(value) {
        return String(value ?? '')
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

    function getPreviewUrl() {
        return document.getElementById('mo-preview-url')?.value || '';
    }

    function getVehicleSearchUrl() {
        return document.getElementById('mo-vehicle-search-url')?.value || '';
    }

    function isTargetPage() {
        return !!document.getElementById('mo-page-flag');
    }

    function ensurePreviewBox(form) {
        let box = qs(form, '.maintenance-template-preview-wrap');
        if (box) return box;

        box = document.createElement('div');
        box.className = 'maintenance-template-preview-wrap';
        box.style.gridColumn = '1 / -1';
        box.style.width = '100%';
        box.style.marginTop = '12px';
        box.style.border = '1px solid #d1d5db';
        box.style.borderRadius = '8px';
        box.style.padding = '12px';
        box.style.background = '#fff';

        box.innerHTML = `
        <div style="font-weight:700; margin-bottom:10px;">بنود القالب</div>
        <div class="maintenance-template-preview-content" style="width:100%; overflow-x:auto;">
            اختر نوع الصيانة لعرض البنود.
        </div>
    `;

        const desc = qs(form, 'textarea[name="p05"]');
        const descWrap = desc ? desc.closest('.form-group, .sf-field-wrap, div') : null;

        if (descWrap && descWrap.parentNode) {
            descWrap.parentNode.insertBefore(box, descWrap.nextSibling);
        } else {
            const grid = qs(form, '.grid');
            if (grid) {
                grid.appendChild(box);
            } else {
                form.appendChild(box);
            }
        }

        return box;
    }

    function renderPreview(box, items) {
        const content = qs(box, '.maintenance-template-preview-content');
        if (!content) return;

        if (!items || !items.length) {
            content.innerHTML = 'لا يوجد بنود قالب لهذا النوع';
            return;
        }

        let html = `
        <table style="
            width:100%;
            border-collapse:collapse;
            table-layout:fixed;
            direction:rtl;
            text-align:right;
            background:#fff;
        ">
            <thead>
                <tr>
                    <th style="border:1px solid #d1d5db; padding:8px; background:#f9fafb; width:80%;">اسم البند</th>
                    <th style="border:1px solid #d1d5db; padding:8px; background:#f9fafb; width:20%;">الترتيب</th>
                </tr>
            </thead>
            <tbody>
    `;

        items.forEach(function (item) {
            const itemName =
                item.TemplateItemName_A ||
                item.templateItemName_A ||
                item.TemplateItemName ||
                item.templateItemName ||
                item.CheckItemName_A ||
                item.checkItemName_A ||
                item.ItemName ||
                item.itemName ||
                item.Name ||
                item.name ||
                '';

            const itemOrder =
                item.TemplateOrder ||
                item.templateOrder ||
                item.ItemOrder ||
                item.itemOrder ||
                item.SortOrder ||
                item.sortOrder ||
                item.OrderNo ||
                item.orderNo ||
                '';

            html += `
            <tr>
                <td style="border:1px solid #d1d5db; padding:8px; vertical-align:top; word-break:break-word;">
                    ${escapeHtml(itemName)}
                </td>
                <td style="border:1px solid #d1d5db; padding:8px; text-align:center; vertical-align:top;">
                    ${escapeHtml(itemOrder)}
                </td>
            </tr>
        `;
        });

        html += `
            </tbody>
        </table>
    `;

        content.innerHTML = html;
    }

    function loadPreview(form, selectEl) {
        const previewUrl = getPreviewUrl();
        if (!previewUrl || !form || !selectEl) return;

        const box = ensurePreviewBox(form);
        const content = qs(box, '.maintenance-template-preview-content');
        const val = (selectEl.value || '').trim();

        if (!val) {
            content.innerHTML = 'اختر نوع الصيانة لعرض البنود.';
            return;
        }

        content.innerHTML = 'جاري التحميل...';
        console.log('preview request', previewUrl, val);

        fetch(previewUrl + '?maintOrdTypeID=' + encodeURIComponent(val), {
            method: 'GET',
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
            .then(function (r) { return r.json(); })
            .then(function (d) {
                console.log('preview items', d ? d.items : null);


                if (!d || !d.success) {
                    content.innerHTML = 'تعذر تحميل البنود';
                    return;
                }

                renderPreview(box, d.items || []);
            })
            .catch(function (err) {
                console.error('preview error', err);
                content.innerHTML = 'تعذر تحميل البنود';
            });
    }

    function ensureResultsBox(input) {
        let wrap = input.parentElement ? input.parentElement.querySelector('.vehicle-search-wrap') : null;
        if (wrap) return wrap;

        wrap = document.createElement('div');
        wrap.className = 'vehicle-search-wrap mt-2';
        wrap.style.position = 'relative';

        const box = document.createElement('div');
        box.className = 'vehicle-search-results';
        box.style.display = 'none';
        box.style.position = 'absolute';
        box.style.top = '100%';
        box.style.left = '0';
        box.style.right = '0';
        box.style.background = '#fff';
        box.style.border = '1px solid #ddd';
        box.style.borderRadius = '6px';
        box.style.boxShadow = '0 4px 12px rgba(0,0,0,.08)';
        box.style.zIndex = '99999';
        box.style.maxHeight = '240px';
        box.style.overflowY = 'auto';

        wrap.appendChild(box);

        if (input.parentElement) {
            input.parentElement.appendChild(wrap);
        }

        return wrap;
    }

    function hideResults(input) {
        const wrap = input?.parentElement?.querySelector('.vehicle-search-wrap');
        const box = qs(wrap, '.vehicle-search-results');
        if (!box) return;

        box.style.display = 'none';
        box.innerHTML = '';
    }

    function showResults(input, items) {
        const wrap = ensureResultsBox(input);
        const box = qs(wrap, '.vehicle-search-results');
        if (!box) return;

        if (!items || !items.length) {
            box.innerHTML = '<div style="padding:8px;color:#666;font-size:12px;">لا توجد نتائج</div>';
            box.style.display = 'block';
            return;
        }

        let html = '';
        items.forEach(function (item) {
            html += `
                <button type="button"
                        class="vehicle-item"
                        data-value="${escapeHtml(item.value || '')}"
                        style="display:block;width:100%;text-align:right;background:#fff;border:0;border-bottom:1px solid #eee;padding:8px;cursor:pointer;">
                    ${escapeHtml(item.label || item.value || '')}
                </button>
            `;
        });

        box.innerHTML = html;
        box.style.display = 'block';

        qsa(box, '.vehicle-item').forEach(function (btn) {
            btn.addEventListener('click', function () {
                input.value = btn.getAttribute('data-value') || '';
                hideResults(input);
            });
        });
    }

    function bindVehicleSearch(form, inputSelector) {
        const input = qs(form, inputSelector);
        if (!input || input.dataset.vehicleBound === '1') return;

        input.dataset.vehicleBound = '1';
        let timer = null;

        input.addEventListener('input', function () {
            const vehicleSearchUrl = getVehicleSearchUrl();
            const q = (input.value || '').trim();
            console.log('vehicle input fired', q);

            if (timer) clearTimeout(timer);

            if (!q || !vehicleSearchUrl) {
                hideResults(input);
                return;
            }

            timer = setTimeout(function () {
                console.log('vehicle search request', vehicleSearchUrl, q);

                fetch(vehicleSearchUrl + '?q=' + encodeURIComponent(q), {
                    method: 'GET',
                    headers: { 'X-Requested-With': 'XMLHttpRequest' }
                })
                    .then(function (r) { return r.json(); })
                    .then(function (d) {
                        console.log('vehicle search response', d);

                        if (!d || !d.success) {
                            hideResults(input);
                            return;
                        }

                        showResults(input, d.items || []);
                    })
                    .catch(function (err) {
                        console.error('vehicle search error', err);
                        hideResults(input);
                    });
            }, 300);
        });

        input.addEventListener('blur', function () {
            setTimeout(function () {
                hideResults(input);
            }, 200);
        });
    }

    function bindPreview(form, selectSelector) {
        const selectEl = qs(form, selectSelector);
        if (!selectEl || selectEl.dataset.previewBound === '1') return;

        selectEl.dataset.previewBound = '1';
        console.log('preview bound on', selectSelector);

        let lastValue = null;

        function runPreviewCheck() {
            const currentValue = (selectEl.value || '').trim();

            if (currentValue !== lastValue) {
                lastValue = currentValue;
                console.log('preview value changed', currentValue);
                loadPreview(form, selectEl);
            }
        }

        // التغيير العادي
        selectEl.addEventListener('change', function () {
            console.log('native change fired', selectEl.value);
            runPreviewCheck();
        });

        // لو select2 / أي سكربت غيّر القيمة بدون change واضح
        if (window.jQuery) {
            window.jQuery(selectEl).on('change select2:select select2:close', function () {
                console.log('select2 event fired', selectEl.value);
                runPreviewCheck();
            });
        }

        // فحص دوري لأنه الأكثر ثباتًا مع المودال و select2
        const watcher = setInterval(function () {
            if (!document.body.contains(selectEl)) {
                clearInterval(watcher);
                return;
            }

            runPreviewCheck();
        }, 300);

        // أول تشغيل
        setTimeout(function () {
            runPreviewCheck();
        }, 300);
    }

    function bindInsertForm(form) {
        if (!form || form.dataset.maintenanceBound === '1') return;
        form.dataset.maintenanceBound = '1';
        console.log('insert form bound');

        bindPreview(form, 'select[name="p01"]');
        bindVehicleSearch(form, 'input[name="p02"]');
    }

    function bindUpdateForm(form) {
        if (!form || form.dataset.maintenanceBound === '1') return;
        form.dataset.maintenanceBound = '1';
        console.log('update form bound');

        bindPreview(form, 'select[name="p02"]');
        bindVehicleSearch(form, 'input[name="p03"]');
    }

    function bindAll() {
        if (!isTargetPage()) return;

        bindInsertForm(document.getElementById('InsertMaintenanceOrderForm'));
        bindUpdateForm(document.getElementById('UpdateMaintenanceOrderForm'));
    }

    document.addEventListener('DOMContentLoaded', bindAll);

    const observer = new MutationObserver(function () {
        bindAll();
    });

    observer.observe(document.body, {
        childList: true,
        subtree: true
    });
})();