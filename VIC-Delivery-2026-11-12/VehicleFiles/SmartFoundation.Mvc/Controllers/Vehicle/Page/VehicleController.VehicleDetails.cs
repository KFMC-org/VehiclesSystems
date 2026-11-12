using Microsoft.AspNetCore.Mvc;
using SmartFoundation.Mvc.Models;
using SmartFoundation.UI.ViewModels.SmartCharts;
using SmartFoundation.UI.ViewModels.SmartPage;
using System.Data;

namespace SmartFoundation.Mvc.Controllers.Vehicle
{
    public partial class VehicleController : Controller
    {
        [HttpGet]
        public async Task<IActionResult> VehicleDetails(string? chassisNumber)
        {
            if (!InitPageContext(out IActionResult? redirectResult))
                return redirectResult!;

            if (string.IsNullOrWhiteSpace(usersId))
                return RedirectToAction("Index", "Login", new { logout = 4 });

            if (string.IsNullOrWhiteSpace(chassisNumber))
            {
                TempData["Error"] = "رقم الهيكل مطلوب";
                return RedirectToAction("Vehiclelist");
            }

            var details = await BuildVehicleDetailsPageAsync(chassisNumber.Trim());
            if (details is null)
            {
                TempData["Error"] = "لم يتم العثور على بيانات المركبة";
                return RedirectToAction("Vehiclelist");
            }

            return View("Page/VehicleDetails", details.Value.Page);
        }

        [HttpGet]
        [ResponseCache(NoStore = true, Location = ResponseCacheLocation.None)]
        public async Task<IActionResult> VehicleDetailsDrawer(string? chassisNumber)
        {
            if (!InitPageContext(out _))
                return Unauthorized();

            if (string.IsNullOrWhiteSpace(usersId))
                return Unauthorized();

            if (string.IsNullOrWhiteSpace(chassisNumber))
                return BadRequest("رقم الهيكل مطلوب");

            try
            {
                var details = await BuildVehicleDetailsPageAsync(chassisNumber.Trim());
                if (details is null)
                    return NotFound("لم يتم العثور على بيانات المركبة");

                return PartialView(
                    "~/Views/Vehicle/Page/_VehicleDetailsDrawer.cshtml",
                    details.Value.Drawer);
            }
            catch
            {
                return StatusCode(
                    StatusCodes.Status500InternalServerError,
                    "تعذر تحميل تفاصيل المركبة");
            }
        }

        private async Task<(SmartPageViewModel Page, VehicleDetailsDrawerViewModel Drawer)?>
            BuildVehicleDetailsPageAsync(string chassisNumber)
        {
            ControllerName = "Vehicle";
            PageName = "VehicleDetails";

            var profileParams = new object?[]
            {
                "Vehicle_Profile_Get", IdaraId, usersId, HostName,
                usersId,
                null,
                1,
                chassisNumber,
                20,
                20,
                10,
                50,
                IdaraId
            };

            DataSet ds = await _mastersServies.GetDataLoadDataSetAsync(profileParams);
            SplitDataSet(ds);

            if (dt1 == null || dt1.Rows.Count == 0)
                return null;

            var summaryRow = dt1.Rows[0];
            var summary = new Dictionary<string, object?>(StringComparer.OrdinalIgnoreCase);
            foreach (DataColumn column in dt1.Columns)
            {
                var value = summaryRow[column];
                summary[column.ColumnName] = value == DBNull.Value ? null : value;
            }

            object? Get(string key) => summary.TryGetValue(key, out var value) ? value : null;

            var vehicleStatusId = Get("vehicleStatusID_FK")?.ToString();
            var hasCustodyUser = !string.IsNullOrWhiteSpace(Get("CurrentUserID")?.ToString());
            var custodyStatusText = hasCustodyUser ? "عهدة نشطة" : "بدون عهدة";
            var currentUserDisplay = Get("CurrentUserDisplay")?.ToString();
            var custodyNote = hasCustodyUser
                ? $"المستخدم: {(string.IsNullOrWhiteSpace(currentUserDisplay) ? "لا يوجد مستخدم" : currentUserDisplay)}"
                : "لا توجد عهدة نشطة";

            var documentsCount = Get("DocumentsCount")?.ToString() ?? "0";
            var insuranceCount = Get("InsuranceCount")?.ToString() ?? "0";
            var maintenanceCount = Get("MaintenanceCount")?.ToString() ?? "0";
            var violationsCount = Get("ViolationsCount")?.ToString() ?? "0";

            var isActive = Get("isActive")?.ToString() == "1";
            var isActiveText = isActive ? "مفعل" : "موقوف";

            var chassisDisplay = Get("chassisNumber")?.ToString() ?? chassisNumber;
            var plateLetters = Get("plateLetters")?.ToString();
            var plateNumbers = Get("plateNumbers")?.ToString();
            var plateDisplay = (!string.IsNullOrWhiteSpace(plateLetters) ||
                                !string.IsNullOrWhiteSpace(plateNumbers))
                ? $"{plateLetters} {plateNumbers}".Trim()
                : null;

            var statusTone = vehicleStatusId switch
            {
                "260" => ChartTone.Success,
                "261" => ChartTone.Warning,
                "262" => ChartTone.Danger,
                _ => ChartTone.Neutral
            };

            var vehicleStatusText = Get("vehicleStatusName")?.ToString()
                ?? Get("VehicleStatusName")?.ToString()
                ?? vehicleStatusId switch
                {
                    "260" => "نشطة",
                    "261" => "غير نشطة",
                    "262" => "تالفة",
                    _ => "غير محددة"
                };

            string DisplayValue(string nameField, string idField)
            {
                var display = Get(nameField)?.ToString();
                if (!string.IsNullOrWhiteSpace(display))
                    return display;

                var id = Get(idField)?.ToString();
                return string.IsNullOrWhiteSpace(id) ? "—" : id;
            }

            var charts = new SmartChartsConfig
            {
                ChartsId = "vehicleDetailsKpi",
                Dir = "rtl",
                Cards = new List<ChartCardConfig>
                {
                    new ChartCardConfig
                    {
                        Id = "kpi_vehicle",
                        Type = ChartCardType.Kpi,
                        Title = "رقم الهيكل",
                        Tone = statusTone,
                        ColCss = "col-span-2",
                        Size = ChartCardSize.Sm,
                        Dir = "rtl",
                        Icon = "fa-solid fa-car",
                        BigValue = chassisDisplay,
                        Note = plateDisplay != null ? $"اللوحة: {plateDisplay}" : isActiveText
                    },
                    new ChartCardConfig
                    {
                        Id = "kpi_custody",
                        Type = ChartCardType.Kpi,
                        Title = "حالة العهدة",
                        Tone = hasCustodyUser ? ChartTone.Success : ChartTone.Neutral,
                        ColCss = "col-span-2",
                        Size = ChartCardSize.Sm,
                        Dir = "rtl",
                        Icon = "fa-solid fa-user-check",
                        BigValue = custodyStatusText,
                        Note = custodyNote
                    },
                    new ChartCardConfig
                    {
                        Id = "kpi_documents",
                        Type = ChartCardType.Kpi,
                        Title = "الوثائق",
                        Tone = ChartTone.Info,
                        ColCss = "col-span-2",
                        Size = ChartCardSize.Sm,
                        Dir = "rtl",
                        Icon = "fa-solid fa-file-lines",
                        BigValue = documentsCount,
                        Note = "وثائق مسجلة"
                    },
                    new ChartCardConfig
                    {
                        Id = "kpi_insurance",
                        Type = ChartCardType.Kpi,
                        Title = "التأمينات",
                        Tone = ChartTone.Info,
                        ColCss = "col-span-2",
                        Size = ChartCardSize.Sm,
                        Dir = "rtl",
                        Icon = "fa-solid fa-shield-halved",
                        BigValue = insuranceCount,
                        Note = "سجلات التأمين"
                    },
                    new ChartCardConfig
                    {
                        Id = "kpi_maintenance",
                        Type = ChartCardType.Kpi,
                        Title = "الصيانة",
                        Tone = ChartTone.Warning,
                        ColCss = "col-span-2",
                        Size = ChartCardSize.Sm,
                        Dir = "rtl",
                        Icon = "fa-solid fa-wrench",
                        BigValue = maintenanceCount,
                        Note = "أوامر الصيانة"
                    },
                    new ChartCardConfig
                    {
                        Id = "kpi_violations",
                        Type = ChartCardType.Kpi,
                        Title = "المخالفات",
                        Tone = ChartTone.Danger,
                        ColCss = "col-span-2",
                        Size = ChartCardSize.Sm,
                        Dir = "rtl",
                        Icon = "fa-solid fa-gavel",
                        BigValue = violationsCount,
                        Note = "المخالفات المسجلة"
                    }
                }
            };

            var page = new SmartPageViewModel
            {
                PageTitle = "تفاصيل المركبة",
                PanelTitle = $"بيانات المركبة — {chassisDisplay}",
                PanelIcon = "fa-solid fa-car",
                Charts = charts
            };

            var drawer = new VehicleDetailsDrawerViewModel
            {
                ChassisNumber = chassisDisplay,
                PlateDisplay = plateDisplay ?? "بدون لوحة",
                RecordStatus = isActive ? "مفعلة" : "موقوفة",
                RecordStatusTone = isActive ? "success" : "danger",
                CustodyStatus = custodyStatusText,
                CustodyTone = hasCustodyUser ? "success" : "neutral",
                Metrics = new List<VehicleDetailsMetricViewModel>
                {
                    new()
                    {
                        Title = "حالة العهدة",
                        Value = custodyStatusText,
                        Icon = "fa-solid fa-user-check",
                        Tone = hasCustodyUser ? "success" : "neutral"
                    },
                    new()
                    {
                        Title = "الوثائق",
                        Value = documentsCount,
                        Icon = "fa-solid fa-file-lines",
                        Tone = "info"
                    },
                    new()
                    {
                        Title = "التأمينات",
                        Value = insuranceCount,
                        Icon = "fa-solid fa-shield-halved",
                        Tone = "info"
                    },
                    new()
                    {
                        Title = "الصيانة",
                        Value = maintenanceCount,
                        Icon = "fa-solid fa-wrench",
                        Tone = "warning"
                    },
                    new()
                    {
                        Title = "المخالفات",
                        Value = violationsCount,
                        Icon = "fa-solid fa-gavel",
                        Tone = "danger"
                    },
                    new()
                    {
                        Title = "حالة المركبة",
                        Value = vehicleStatusText,
                        Icon = "fa-solid fa-car",
                        Tone = vehicleStatusId switch
                        {
                            "260" => "success",
                            "261" => "warning",
                            "262" => "danger",
                            _ => "neutral"
                        }
                    }
                },
                BasicFields = new List<VehicleDetailsFieldViewModel>
                {
                    new()
                    {
                        Label = "الشركة المصنعة",
                        Value = DisplayValue("manufacturerName", "ManufacturerNameID_FK")
                    },
                    new()
                    {
                        Label = "الموديل",
                        Value = DisplayValue("modelName", "vehicleModelID_FK")
                    },
                    new()
                    {
                        Label = "سنة الصنع",
                        Value = Get("yearModel")?.ToString() ?? "—",
                        LeftToRight = true
                    },
                    new()
                    {
                        Label = "اللون",
                        Value = DisplayValue("colorName", "vehicleColorID_FK")
                    },
                    new()
                    {
                        Label = "المالك",
                        Value = DisplayValue("ownerName", "ownerID_FK")
                    },
                    new()
                    {
                        Label = "الرقم العسكري",
                        Value = Get("armyNumber")?.ToString() ?? "—",
                        LeftToRight = true
                    }
                }
            };

            return (page, drawer);
        }
    }
}
