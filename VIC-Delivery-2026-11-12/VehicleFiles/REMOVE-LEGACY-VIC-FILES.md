# إزالة ملفات VIC القديمة عند الدمج

البنية الجديدة في هذه الحزمة تنقل صفحات VIC إلى `Controllers/Vehicle/Page` و`Views/Vehicle/Page`. المرجع ما زال يحتوي البنية القديمة التالية؛ يجب حذفها في فرع الدمج بعد التأكد من عدم وجود تعديلات مستقلة لدى الفريق.

أثبت Build الاختباري أن إبقاء النسختين يسبب تكرار أعضاء `VehicleController`، ومنها `GetVehicleFull`, `SearchVehicleChassis`, `GetTypesRootOptions`, و`NormalizeDateForInput`.

## Controllers القديمة — 11

- `SmartFoundation.Mvc/Controllers/Vehicle/VehicleController.CustodyCurrentList.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/VehicleController.MaintenanceDashboard.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/VehicleController.MaintenanceDetails.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/VehicleController.MaintenanceOrders.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/VehicleController.MaintenancePlans.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/VehicleController.Scrap.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/VehicleController.TransferRequest_Pending_ByDept.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/VehicleController.TransferRequest_Vehicles_ByUserDept.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/VehicleController.Vehiclelist.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/VehicleController.VehiclesController.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/VehicleController.Violation.cs`

## Views القديمة — 13

- `SmartFoundation.Mvc/Views/Vehicle/Custody.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/CustodyCurrentList.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/Index.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/MaintenanceDashboard.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/MaintenanceDetails.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/MaintenanceOrders.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/MaintenancePlans.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/Profile.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/Scrap.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/TransferRequest_Pending_ByDept.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/TransferRequest_Vehicles_ByUserDept.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/VehicleList.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/Violation.cshtml`

لا تحذف `SmartFoundation.Mvc/Controllers/Vehicle/VehicleController.Base.cs`؛ استبدله أو ادمج فرق VIC الموجود في الحزمة حسب حالة فرع الفريق.
