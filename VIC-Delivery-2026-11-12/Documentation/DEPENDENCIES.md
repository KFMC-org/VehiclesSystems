# التبعيات والتعارضات المتوقعة

## تبعيات موجودة أصلًا في SmartFoundation المرجعي

- بنية `VehicleController` الجزئية وخدمات `_mastersServies` وبوابتا `/crud/insert` وDataLoad.
- SmartPage وSmartRenderer وSmartTable/SmartTableDS ونظام Action metadata والنماذج الديناميكية.
- SmartDrawer الموجود أصلًا في المرجع. المطلوب فقط Patch التنسيق الخاص بتفاصيل المركبة.
- نظام التقارير الحالي. Patch التقارير إضافي ويجب دمجه مع الحفاظ على قدرات المرجع، ومنها ميزات Serial/Grouping الموجودة عند الفريق.
- Font Awesome وToastr عند توفرهما؛ يوجد fallback للرسائل في JavaScript الصفحة.

## تبعيات SmartDynamicFields

- يجب إضافة الملفات الخمسة إلى مشروع `SmartFoundation.UI` بنفس المسارات.
- يجب تحميل `_content/SmartFoundation.UI/css/sf-dynamic-fields.css` ثم `_content/SmartFoundation.UI/js/sf-dynamic-fields.js` قبل `general-maintenance.js` أو `scrap.js`.
- لا توجد حزمة JavaScript خارجية خاصة بالمكوّن.

## تبعيات قاعدة البيانات المشتركة

- `dbo.Idara(idaraID)` قبل إضافة Foreign Keys الخارجية.
- الكائنات المشتركة: `dbo.AuditLog`, `dbo.Distributor`, `dbo.UserDistributor`, `dbo.Users`, `dbo.UsersDetails`, و`dbo.V_getFullStructureForDSD`.
- يجب دمج مسارات VIC يدويًا داخل نسخ الفريق من `dbo.Masters_DataLoad` و`dbo.Masters_CRUD`؛ لا تستبدل الإجرائين.
- SQL Server Agent يجب أن يكون متاحًا ومفعّلًا إذا تقرر تثبيت Job التوليد التلقائي.

## تعارضات SQL المعروفة

التعريفات الحية ليست متسقة بالكامل: View حالة المركبات وإجراءا النقل يشيران إلى أعمدة لم تتطابق مع الجداول الفعلية عند فحص الربط. لذلك لا يُنصح بتنفيذ حزمة SQL آليًا كدفعة واحدة قبل مراجعة:

1. العقد المقصود لـ`VIC.vehicleWithUsers` وعمود `userID_FK`.
2. مصادر `RequestID_FK` التي يستخدمها `TransferRequestDL` و`TransferRequestSP`.
3. ترتيب إنشاء Views/Procedures بعد اعتماد التصحيح في بيئة الدمج.

لم تُعدّل التعريفات لإخفاء المشكلة، ولم تُنفذ أي محاولة إصلاح على القاعدة.

## تعارضات ملفات محتملة

- يجب إزالة ملفات VIC القديمة الـ24 المحددة في `VehicleFiles/REMOVE-LEGACY-VIC-FILES.md`؛ بقاؤها مع البنية الجديدة يمنع Build بسبب تكرار أعضاء Controller.
- `VehicleController.Base.cs` موجود في المرجع؛ انسخ فرق VIC المطلوب أو ادمجه بعناية إذا تغير الملف لدى الفريق.
- `sf-form.js`, `sf-drawer.css`, ومكونات التقارير ملفات مشتركة؛ استخدم ملفات Patch فقط.
- لا تنقل النسخة المكررة القديمة `SmartFoundation.Mvc/wwwroot/js/sf-dynamic-fields.js`.
- لا تستبدل SmartDrawer أو SmartCharts أو SmartRenderer أو SmartTable؛ المرجع يحتوي النسخ الأساسية اللازمة.

## فرق مستودع التسليم

فرع `master` في `KFMC-org/VehiclesSystems` لا يطابق المرجع: SmartDrawer و`sf-drawer.css` غير موجودين، وخط أساس التقارير مختلف. لذلك Patches الحزمة موجهة لنسخة SmartFoundation المرجعية، وليس للدمج الآلي المباشر في `master` الحالي. راجع `TARGET-REPOSITORY-STATUS.md`.
