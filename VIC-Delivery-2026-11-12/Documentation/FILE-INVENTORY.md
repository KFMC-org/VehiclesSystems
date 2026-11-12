# جرد الملفات

## VehicleFiles — 26 ملفًا

### Controllers — 10

- `SmartFoundation.Mvc/Controllers/Vehicle/VehicleController.Base.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/Page/VehicleController.Custody.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/Page/VehicleController.GeneralMaintenance.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/Page/VehicleController.MaintenanceReport.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/Page/VehicleController.PeriodicMaintenance.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/Page/VehicleController.Scrap.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/Page/VehicleController.TransferApproval.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/Page/VehicleController.VehicleDetails.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/Page/VehicleController.Vehiclelist.cs`
- `SmartFoundation.Mvc/Controllers/Vehicle/Page/VehicleController.Violation.cs`

### Model — 1

- `SmartFoundation.Mvc/Models/VehicleDetailsDrawerViewModel.cs`

### Views — 10

- `SmartFoundation.Mvc/Views/Vehicle/Page/_VehicleDetailsDrawer.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/Page/Custody.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/Page/GeneralMaintenance.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/Page/MaintenanceReport.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/Page/PeriodicMaintenance.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/Page/Scrap.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/Page/TransferApproval.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/Page/VehicleDetails.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/Page/VehicleList.cshtml`
- `SmartFoundation.Mvc/Views/Vehicle/Page/Violation.cshtml`

### JavaScript — 3

- `SmartFoundation.Mvc/wwwroot/js/general-maintenance.js`
- `SmartFoundation.Mvc/wwwroot/js/scrap.js`
- `SmartFoundation.Mvc/wwwroot/js/vehicle-list-drawer.js`

### CSS — 2

- `SmartFoundation.Mvc/wwwroot/css/page-maintenance-report.css`
- `SmartFoundation.Mvc/wwwroot/css/page-periodic-maintenance.css`

نتيجة المقارنة مع المرجع ومستودع التسليم: **25** ملفًا جديدًا، و`VehicleController.Base.cs` موجود مسبقًا لكنه يحتاج دمج فرق VIC المحدود، وليس استبدالًا أعمى إذا تغير لدى الفريق.

يوجد أيضًا ملف توثيق `VehicleFiles/REMOVE-LEGACY-VIC-FILES.md` يسرد 24 ملف VIC قديمًا يجب إزالتها عند الانتقال إلى البنية الجديدة. لا يدخل هذا الملف التوثيقي ضمن عدد الملفات التطبيقية الـ26.

## SmartDynamicFields — 5 ملفات رسمية

- `SmartFoundation.UI/ViewModels/SmartDynamicFields/SmartDynamicFieldsConfig.cs`
- `SmartFoundation.UI/ViewComponents/SmartDynamicFields/SmartDynamicFieldsViewComponent.cs`
- `SmartFoundation.UI/Views/Shared/Components/SmartDynamicFields/Default.cshtml`
- `SmartFoundation.UI/wwwroot/js/sf-dynamic-fields.js`
- `SmartFoundation.UI/wwwroot/css/sf-dynamic-fields.css`

جميعها غير موجودة في المرجع وفي فرع `master` الذي تمت مراجعته. يوجد `SmartDynamicFields/README.md` للتوثيق ولا يدخل ضمن الملفات الخمسة البرمجية.

## SharedPatches — 3

- `001_sf-form_VIC_actions.patch`: يضيف فقط معالجات VIC للصيانة الدورية والعامة؛ لا يستبدل `sf-form.js`.
- `002_sf-drawer_VehicleDetails_styles.patch`: يضيف تنسيق رابط رقم الهيكل ومحتوى Drawer تفاصيل المركبة فقط؛ لا يستبدل SmartDrawer.
- `003_Reports_VIC_printing.patch`: يضيف قدرات Footer وتمديد الصفوف والتحكم بالارتفاع اللازمة لتقارير الصيانة، مع إبقاء قدرات التقارير الموجودة في المرجع.

## Database — 30 ملفًا بعد إضافة بيان Functions

- Schema: 1
- Tables: 1 جامع لتعريف 31 جدولًا
- StoredProcedures: 20
- Views: 2
- Functions: 1 ملف README يثبت عدم وجود Functions
- IndexesAndConstraints: 1
- Triggers: 1
- AgentJobs: 1
- SharedGatewayPatches: 2

راجع `DATABASE-INVENTORY.md` للأسماء والأعداد التفصيلية.
