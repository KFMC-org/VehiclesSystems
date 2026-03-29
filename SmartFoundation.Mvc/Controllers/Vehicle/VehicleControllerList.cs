using Microsoft.AspNetCore.Mvc;
using SmartFoundation.UI.ViewModels.SmartForm;
using SmartFoundation.UI.ViewModels.SmartPage;
using SmartFoundation.UI.ViewModels.SmartTable;
using System.Data;
using System.Linq;

namespace SmartFoundation.Mvc.Controllers.VIC
{
    public partial class VehicleController : Controller
    {
        public async Task<IActionResult> Vehicles(
              string? ownerID_FK = null
            , string? plateLetters = null
            , string? plateNumbers = null
            , string? hasCustody = null
            , int pageNumber = 1
            , int pageSize = 50
        )
        {
            if (!InitPageContext(out IActionResult? redirectResult))
                return redirectResult!;

            if (string.IsNullOrWhiteSpace(usersId))
                return RedirectToAction("Index", "Login", new { logout = 4 });

            ControllerName = "Vehicle";
            PageName = "Vehicles";

            var spParameters = new object?[]
            {
                PageName,
                IdaraId,
                usersId,
                HostName,
                string.IsNullOrWhiteSpace(ownerID_FK) ? null : ownerID_FK,       // @parameter_01
                string.IsNullOrWhiteSpace(plateLetters) ? null : plateLetters,   // @parameter_02
                string.IsNullOrWhiteSpace(plateNumbers) ? null : plateNumbers,   // @parameter_03
                string.IsNullOrWhiteSpace(hasCustody) ? null : hasCustody,       // @parameter_04
                pageNumber,                                                      // @parameter_05
                pageSize,                                                        // @parameter_06
                IdaraId                                                          // @parameter_07
            };

            var rowsList = new List<Dictionary<string, object?>>();
            var dynamicColumns = new List<TableColumn>();
            string rowIdField = "chassisNumber";

            DataSet ds = await _mastersServies.GetDataLoadDataSetAsync(spParameters);
            SplitDataSet(ds);

            if (permissionTable is null || permissionTable.Rows.Count == 0)
            {
                TempData["Error"] = "تم رصد دخول غير مصرح به انت لاتملك صلاحية للوصول الى هذه الصفحة";
                return RedirectToAction("Index", "Home");
            }

            bool canAccess = false;
            bool canSelect = false;
            bool canInsert = false;
            bool canUpdate = false;

            try
            {
                foreach (DataRow row in permissionTable.Rows)
                {
                    var permissionName = row["permissionTypeName_E"]?.ToString()?.Trim().ToUpper();

                    if (permissionName == "ACCESS") canAccess = true;
                    if (permissionName == "SELECT") canSelect = true;
                    if (permissionName == "INSERT") canInsert = true;
                    if (permissionName == "UPDATE") canUpdate = true;
                }

                if (!canAccess && !canSelect)
                {
                    TempData["Error"] = "تم رصد دخول غير مصرح به انت لاتملك صلاحية للوصول الى هذه الصفحة";
                    return RedirectToAction("Index", "Home");
                }

                var dataTable = dt2 ?? dt3 ?? dt1;

                if (dataTable != null && dataTable.Columns.Count > 0)
                {
                    var possibleIdNames = new[] { "chassisNumber", "ChassisNumber", "vehicleID", "VehicleID", "Id", "ID" };
                    rowIdField = possibleIdNames.FirstOrDefault(n => dataTable.Columns.Contains(n))
                                 ?? dataTable.Columns[0].ColumnName;

                    dynamicColumns.Add(new TableColumn
                    {
                        Field = "chassisNumber",
                        Label = "رقم الهيكل",
                        Type = "text",
                        Sortable = true,
                        Visible = true
                    });

                    dynamicColumns.Add(new TableColumn
                    {
                        Field = "plateLetters",
                        Label = "حروف اللوحة",
                        Type = "text",
                        Sortable = true,
                        Visible = true
                    });

                    dynamicColumns.Add(new TableColumn
                    {
                        Field = "plateNumbers",
                        Label = "أرقام اللوحة",
                        Type = "text",
                        Sortable = true,
                        Visible = true
                    });

                    dynamicColumns.Add(new TableColumn
                    {
                        Field = "armyNumber",
                        Label = "الرقم العسكري",
                        Type = "text",
                        Sortable = true,
                        Visible = true
                    });

                    dynamicColumns.Add(new TableColumn
                    {
                        Field = "yearModel",
                        Label = "سنة الصنع",
                        Type = "text",
                        Sortable = true,
                        Visible = true
                    });

                    dynamicColumns.Add(new TableColumn
                    {
                        Field = "ownerID_FK",
                        Label = "المالك",
                        Type = "text",
                        Sortable = true,
                        Visible = true
                    });

                    dynamicColumns.Add(new TableColumn
                    {
                        Field = "VehicleStatusName",
                        Label = "حالة المركبة",
                        Type = "text",
                        Sortable = true,
                        Visible = true
                    });

                    dynamicColumns.Add(new TableColumn
                    {
                        Field = "isActiveText",
                        Label = "حالة السجل",
                        Type = "text",
                        Sortable = true,
                        Visible = true
                    });

                    dynamicColumns.Add(new TableColumn
                    {
                        Field = "CurrentUserID",
                        Label = "المستخدم الحالي",
                        Type = "text",
                        Sortable = true,
                        Visible = true
                    });

                    dynamicColumns.Add(new TableColumn
                    {
                        Field = "CustodyStartDateText",
                        Label = "تاريخ بداية العهدة",
                        Type = "text",
                        Sortable = true,
                        Visible = true
                    });

                    foreach (DataRow r in dataTable.Rows)
                    {
                        var dict = new Dictionary<string, object?>(StringComparer.OrdinalIgnoreCase);

                        foreach (DataColumn c in dataTable.Columns)
                        {
                            var val = r[c];
                            dict[c.ColumnName] = val == DBNull.Value ? null : val;
                        }

                        object? Get(string key) => dict.TryGetValue(key, out var v) ? v : null;

                        var currentUserId = Get("CurrentUserID")?.ToString();

                        dict["isActiveText"] = (Get("isActive")?.ToString() == "1") ? "مفعل" : "موقوف";
                        dict["CustodyStartDateText"] = NormalizeDateForInput(Get("CustodyStartDate"));
                        dict["HasCustodyFlag"] = string.IsNullOrWhiteSpace(currentUserId) ? "0" : "1";

                        dict["p01"] = Get("chassisNumber");
                        dict["p02"] = Get("ownerID_FK");
                        dict["p16"] = Get("plateLetters");
                        dict["p17"] = Get("plateNumbers");
                        dict["p18"] = Get("armyNumber");
                        dict["p13"] = Get("yearModel");

                        rowsList.Add(dict);
                    }
                }
            }
            catch (Exception ex)
            {
                TempData["DataSetError"] = ex.Message;
            }

            var currentUrl = Request.Path + Request.QueryString;

            var insertFields = new List<FieldConfig>
            {
                new FieldConfig { Name = "pageName_", Type = "hidden", Value = "Vehicle_Upsert" },
                new FieldConfig { Name = "ActionType", Type = "hidden", Value = "INSERT" },
                new FieldConfig { Name = "idaraID", Type = "hidden", Value = IdaraId },
                new FieldConfig { Name = "entrydata", Type = "hidden", Value = usersId },
                new FieldConfig { Name = "hostname", Type = "hidden", Value = HostName },
                new FieldConfig { Name = "redirectUrl", Type = "hidden", Value = currentUrl },
                new FieldConfig { Name = "redirectAction", Type = "hidden", Value = "Vehicles" },
                new FieldConfig { Name = "redirectController", Type = "hidden", Value = ControllerName },
                new FieldConfig { Name = "__RequestVerificationToken", Type = "hidden", Value = (Request.Headers["RequestVerificationToken"].FirstOrDefault() ?? "") },

                new FieldConfig { Name = "p01", Label = "رقم الهيكل", Type = "text", ColCss = "4", Required = true },

                BuildTypesRootSelect("p02", "المالك"),
                BuildTypesRootSelect("p03", "الشركة المصنعة"),
                BuildTypesRootSelect("p04", "موديل المركبة"),
                BuildTypesRootSelect("p05", "فئة المركبة"),
                BuildTypesRootSelect("p06", "نوع الاستخدام"),
                BuildTypesRootSelect("p07", "لون المركبة"),
                BuildTypesRootSelect("p08", "بلد الصنع"),
                BuildTypesRootSelect("p09", "نوع التسجيل"),
                BuildTypesRootSelect("p10", "المنطقة"),
                BuildTypesRootSelect("p11", "نوع الوقود"),
                BuildTypesRootSelect("p12", "نوع المركبة"),

                new FieldConfig { Name = "p13", Label = "سنة الصنع", Type = "text", ColCss = "4" },
                new FieldConfig { Name = "p14", Label = "السعة", Type = "text", ColCss = "4" },
                new FieldConfig { Name = "p15", Label = "الرقم التسلسلي", Type = "text", ColCss = "4" },

                new FieldConfig { Name = "p16", Label = "حروف اللوحة", Type = "text", ColCss = "4" },
                new FieldConfig { Name = "p17", Label = "أرقام اللوحة", Type = "text", ColCss = "4" },
                new FieldConfig { Name = "p18", Label = "الرقم العسكري", Type = "text", ColCss = "4" },

                new FieldConfig { Name = "p19", Label = "الملاحظات", Type = "textarea", ColCss = "12", MaxLength = 1000 }
            };

            var updateFields = new List<FieldConfig>
            {
                new FieldConfig { Name = "pageName_", Type = "hidden", Value = "Vehicle_Upsert" },
                new FieldConfig { Name = "ActionType", Type = "hidden", Value = "UPDATE" },
                new FieldConfig { Name = "idaraID", Type = "hidden", Value = IdaraId },
                new FieldConfig { Name = "entrydata", Type = "hidden", Value = usersId },
                new FieldConfig { Name = "hostname", Type = "hidden", Value = HostName },
                new FieldConfig { Name = "redirectUrl", Type = "hidden", Value = currentUrl },
                new FieldConfig { Name = "redirectAction", Type = "hidden", Value = "Vehicles" },
                new FieldConfig { Name = "redirectController", Type = "hidden", Value = ControllerName },
                new FieldConfig { Name = "__RequestVerificationToken", Type = "hidden", Value = (Request.Headers["RequestVerificationToken"].FirstOrDefault() ?? "") },

                new FieldConfig { Name = rowIdField, Type = "hidden" },
                new FieldConfig { Name = "p01", Type = "hidden", MirrorName = rowIdField },

                new FieldConfig { Name = "p01_View", Label = "رقم الهيكل", Type = "text", ColCss = "4", Readonly = true },

                BuildTypesRootSelect("p02", "المالك"),
                BuildTypesRootSelect("p03", "الشركة المصنعة"),
                BuildTypesRootSelect("p04", "موديل المركبة"),
                BuildTypesRootSelect("p05", "فئة المركبة"),
                BuildTypesRootSelect("p06", "نوع الاستخدام"),
                BuildTypesRootSelect("p07", "لون المركبة"),
                BuildTypesRootSelect("p08", "بلد الصنع"),
                BuildTypesRootSelect("p09", "نوع التسجيل"),
                BuildTypesRootSelect("p10", "المنطقة"),
                BuildTypesRootSelect("p11", "نوع الوقود"),
                BuildTypesRootSelect("p12", "نوع المركبة"),

                new FieldConfig { Name = "p13", Label = "سنة الصنع", Type = "text", ColCss = "4" },
                new FieldConfig { Name = "p14", Label = "السعة", Type = "text", ColCss = "4" },
                new FieldConfig { Name = "p15", Label = "الرقم التسلسلي", Type = "text", ColCss = "4" },

                new FieldConfig { Name = "p16", Label = "حروف اللوحة", Type = "text", ColCss = "4" },
                new FieldConfig { Name = "p17", Label = "أرقام اللوحة", Type = "text", ColCss = "4" },
                new FieldConfig { Name = "p18", Label = "الرقم العسكري", Type = "text", ColCss = "4" },

                new FieldConfig { Name = "p19", Label = "الملاحظات", Type = "textarea", ColCss = "12", MaxLength = 1000 }
            };

            var toolbar = new TableToolbarConfig
            {
                ShowRefresh = false,
                ShowColumns = true,
                ShowExportCsv = false,
                ShowExportExcel = true,
                ShowExportPdf = true,
                ShowPrint1 = true,
                ShowAdd = canInsert,
                ShowEdit = canUpdate,
                ShowBulkDelete = false,
                ShowDelete = false
            };

            if (canInsert)
            {
                toolbar.Add = new TableAction
                {
                    Label = "إضافة مركبة",
                    Icon = "fa fa-plus",
                    Color = "success",
                    IsEdit = false,
                    OpenModal = true,
                    ModalTitle = "إضافة مركبة",
                    ModalMessage = "سيتم إضافة مركبة جديدة",
                    ModalMessageIcon = "fa-solid fa-circle-info",
                    ModalMessageClass = "bg-green-50 text-green-700",
                    OpenForm = new FormConfig
                    {
                        FormId = "InsertVehicleForm",
                        Title = "إضافة مركبة",
                        Method = "post",
                        ActionUrl = "/crud/insert",
                        SubmitText = "حفظ",
                        CancelText = "إلغاء",
                        Fields = insertFields
                    }
                };
            }

            if (canUpdate)
            {
                toolbar.Edit = new TableAction
                {
                    Label = "تعديل",
                    Icon = "fa fa-edit",
                    Color = "primary",
                    IsEdit = true,
                    OpenModal = true,
                    ModalTitle = "تعديل مركبة",
                    ModalMessage = "سيتم تحميل بيانات المركبة كاملة قبل التعديل",
                    ModalMessageIcon = "fa-solid fa-circle-info",
                    ModalMessageClass = "bg-blue-50 text-blue-700",
                    OpenForm = new FormConfig
                    {
                        FormId = "UpdateVehicleForm",
                        Title = "تعديل مركبة",
                        Method = "post",
                        ActionUrl = "/crud/update",
                        SubmitText = "حفظ",
                        CancelText = "إلغاء",
                        Fields = updateFields
                    },
                    RequireSelection = true,
                    MinSelection = 1,
                    MaxSelection = 1
                };
            }

            toolbar.Print1 = new TableAction
            {
                Label = "طباعة",
                Icon = "fa fa-print",
                Color = "secondary",
                RequireSelection = false,
                OnClickJs = @"
sfPrintWithBusy(table, {
  pdf: 1,
  busy: { title: 'طباعة بيانات المركبات' }
});
"
            };

            var dsModel = new SmartTableDsModel
            {
                PageTitle = "المركبات",
                PanelTitle = "المركبات",
                Columns = dynamicColumns,
                Rows = rowsList,
                RowIdField = rowIdField,
                PageSize = 10,
                PageSizes = new List<int> { 10, 25, 50, 100 },
                QuickSearchFields = new List<string>
                {
                    "chassisNumber",
                    "plateLetters",
                    "plateNumbers",
                    "armyNumber",
                    "ownerID_FK"
                },
                Searchable = true,
                AllowExport = true,
                ShowRowBorders = false,
                EnablePagination = true,
                ShowPageSizeSelector = true,
                ShowToolbar = true,
                EnableCellCopy = false,
                ShowFilter = true,
                FilterRow = true,
                FilterDebounce = 250,
                ShowColumnVisibility = true,
                Toolbar = toolbar,
                StyleRules = new List<TableStyleRule>
                {
                    new TableStyleRule
                    {
                        Target = "row",
                        Field = "vehicleStatusID_FK",
                        Op = "eq",
                        Value = "262",
                        CssClass = "row-red",
                        Priority = 1
                    },
                    new TableStyleRule
                    {
                        Target = "row",
                        Field = "vehicleStatusID_FK",
                        Op = "eq",
                        Value = "261",
                        CssClass = "row-yellow",
                        Priority = 2
                    },
                    new TableStyleRule
                    {
                        Target = "row",
                        Field = "HasCustodyFlag",
                        Op = "eq",
                        Value = "1",
                        CssClass = "row-blue",
                        Priority = 3
                    }
                }
            };

            ViewBag.VehicleGetUrl = Url.Action("GetVehicleFull", "Vehicle");
            ViewBag.TypesRootLookupUrl = Url.Action("GetTypesRootOptions", "Vehicle");

            var page = new SmartPageViewModel
            {
                PageTitle = dsModel.PageTitle,
                PanelTitle = dsModel.PanelTitle,
                PanelIcon = "fa fa-car",
                TableDS = dsModel
            };

            return View("VehicleList", page);
        }

        [HttpGet]
        public async Task<IActionResult> GetVehicleFull(string? chassisNumber)
        {
            if (!InitPageContext(out IActionResult? redirectResult))
                return Json(new { success = false, message = "تعذر تهيئة الصفحة" });

            if (string.IsNullOrWhiteSpace(usersId))
                return Json(new { success = false, message = "المستخدم غير معرف" });

            if (string.IsNullOrWhiteSpace(chassisNumber))
                return Json(new { success = false, message = "رقم الهيكل مطلوب" });

            try
            {
                var spParameters = new object?[]
                {
                    "Vehicle_Get",
                    IdaraId,
                    usersId,
                    HostName,
                    usersId,
                    null,
                    1,
                    chassisNumber,
                    IdaraId
                };

                DataSet ds = await _mastersServies.GetDataLoadDataSetAsync(spParameters);

                DataTable? dataTable = null;

                if (ds.Tables.Count == 1)
                    dataTable = ds.Tables[0];
                else if (ds.Tables.Count > 1)
                    dataTable = ds.Tables[1] ?? ds.Tables[0];

                if (dataTable == null || dataTable.Rows.Count == 0)
                    return Json(new { success = false, message = "لم يتم العثور على بيانات المركبة" });

                var row = dataTable.Rows[0];

                object? GetValue(string name)
                {
                    return dataTable.Columns.Contains(name) && row[name] != DBNull.Value
                        ? row[name]
                        : null;
                }

                var item = new Dictionary<string, object?>
                {
                    ["p01"] = GetValue("chassisNumber"),
                    ["p01_View"] = GetValue("chassisNumber"),
                    ["p02"] = GetValue("ownerID_FK"),
                    ["p03"] = GetValue("ManufacturerNameID_FK"),
                    ["p04"] = GetValue("vehicleModelID_FK"),
                    ["p05"] = GetValue("vehicleClassID_FK"),
                    ["p06"] = GetValue("TypeOfUseID_FK"),
                    ["p07"] = GetValue("vehicleColorID_FK"),
                    ["p08"] = GetValue("countryMadeID_FK"),
                    ["p09"] = GetValue("regstritionTypeID_FK"),
                    ["p10"] = GetValue("regionID_FK"),
                    ["p11"] = GetValue("fuelTypeID_FK"),
                    ["p12"] = GetValue("vehicleTypeID_FK"),
                    ["p13"] = GetValue("yearModel"),
                    ["p14"] = GetValue("capacity"),
                    ["p15"] = GetValue("serialNumber"),
                    ["p16"] = GetValue("plateLetters"),
                    ["p17"] = GetValue("plateNumbers"),
                    ["p18"] = GetValue("armyNumber"),
                    ["p19"] = GetValue("vehicleNote")
                };

                return Json(new { success = true, item });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }

        [HttpGet]
        public async Task<IActionResult> GetTypesRootOptions(int? parentID, string? q = null)
        {
            if (!InitPageContext(out IActionResult? redirectResult))
                return Json(new { success = false, items = new List<object>() });

            if (string.IsNullOrWhiteSpace(usersId))
                return Json(new { success = false, items = new List<object>() });

            if (parentID == null)
                return Json(new { success = true, items = new List<object>() });

            try
            {
                var spParameters = new object?[]
                {
                    "TypesRoot_List",
                    IdaraId,
                    usersId,
                    HostName,
                    parentID,
                    1,
                    string.IsNullOrWhiteSpace(q) ? null : q
                };

                DataSet ds = await _mastersServies.GetDataLoadDataSetAsync(spParameters);

                DataTable? dataTable = null;

                if (ds.Tables.Count == 1)
                    dataTable = ds.Tables[0];
                else if (ds.Tables.Count > 1)
                    dataTable = ds.Tables[1] ?? ds.Tables[0];

                var items = new List<object>();

                if (dataTable != null && dataTable.Rows.Count > 0)
                {
                    foreach (DataRow row in dataTable.Rows)
                    {
                        var value = dataTable.Columns.Contains("typesID")
                            ? row["typesID"]?.ToString() ?? ""
                            : "";

                        var text = dataTable.Columns.Contains("typesName_A")
                            ? row["typesName_A"]?.ToString() ?? ""
                            : "";

                        items.Add(new { value, text });
                    }
                }

                return Json(new { success = true, items });
            }
            catch
            {
                return Json(new { success = false, items = new List<object>() });
            }
        }

        private static FieldConfig BuildTypesRootSelect(string name, string label)
        {
            return new FieldConfig
            {
                Name = name,
                Label = label,
                Type = "select",
                ColCss = "4",
                Select2 = true,
                Placeholder = "اختر " + label,
                Options = new List<OptionItem>()
            };
        }
    }
}