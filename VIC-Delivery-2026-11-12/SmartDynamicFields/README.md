# مكوّن SmartDynamicFields

مكوّن رسمي قابل لإعادة الاستخدام لإدارة صفوف حقول ديناميكية داخل نموذج. الحزمة تنقل المكوّن نفسه فقط، بينما يبقى منطق الصلاحيات والحفظ وتنسيق بيانات الأعمال في الصفحة المستهلكة.

## الملفات

- `SmartFoundation.UI/ViewModels/SmartDynamicFields/SmartDynamicFieldsConfig.cs`: نماذج الإعداد والحقول والخيارات.
- `SmartFoundation.UI/ViewComponents/SmartDynamicFields/SmartDynamicFieldsViewComponent.cs`: التحقق من صحة الإعداد قبل العرض.
- `SmartFoundation.UI/Views/Shared/Components/SmartDynamicFields/Default.cshtml`: المضيف الذي يسلسل الإعداد إلى HTML.
- `SmartFoundation.UI/wwwroot/js/sf-dynamic-fields.js`: محرك الإضافة والحذف والترتيب والتحقق والمزامنة.
- `SmartFoundation.UI/wwwroot/css/sf-dynamic-fields.css`: تنسيق المكوّن.

لا يعتمد JavaScript على مكتبة خارجية؛ يعتمد على DOM APIs الحديثة. ملفات UI تُنشر كـRazor Class Library static web assets تحت `_content/SmartFoundation.UI`.

## الإعداد

يدعم الحقول: `Hidden`, `Text`, `Textarea`, `Number`, `Date`, `Select`, و`Checkbox`. أهم خيارات الإعداد:

- `Id`: معرّف فريد داخل الصفحة.
- `FormId`: النموذج المضيف عند الحقن داخل نموذج مولّد ديناميكيًا.
- `OutputName`: اسم الحقل المخفي الذي يستقبل JSON القياسي للصفوف.
- `RenderOutputInput`: إنشاء حقل الإخراج من المكوّن؛ اضبطه `false` إذا كان النموذج يحتوي الحقل أصلًا.
- `SyncOutputOnChange`: مزامنة JSON عند تغيّر القيم.
- `MinRows` و`MaxRows`: حدود عدد الصفوف.
- `AllowAdd`, `AllowRemove`, `AllowReorder`: العمليات المتاحة.
- `RowNumberProperty`: إضافة رقم تسلسلي لكل صف في JSON.
- `Fields` و`InitialRows`: تعريف الحقول والقيم الأولية.

مثال إعداد مختصر في Controller:

```csharp
var config = new SmartDynamicFieldsConfig
{
    Id = "faults",
    FormId = "maintenanceForm",
    OutputName = "p09",
    RenderOutputInput = false,
    MinRows = 1,
    MaxRows = 16,
    Fields = new()
    {
        new()
        {
            Name = "faultDescription",
            Label = "العطل",
            Type = SmartDynamicFieldType.Text,
            Required = true,
            MaxLength = 500
        }
    }
};
```

## التحميل والاستخدام

حمّل CSS قبل المحتوى، ثم JavaScript الخاص بالمكوّن قبل JavaScript الصفحة:

```html
<link rel="stylesheet" href="~/_content/SmartFoundation.UI/css/sf-dynamic-fields.css" />
<script src="~/_content/SmartFoundation.UI/js/sf-dynamic-fields.js"></script>
<script src="~/js/page-specific.js"></script>
```

الواجهات العامة في `window.SmartDynamicFields` هي: `init`, `initAll`, `mount`, `mountInForm`, `mountInFormWhenReady`, `destroy`, `getInstance`, `getRows`, `setRows`, `addRow`, `removeRow`, `validate`, و`sync`.

في النماذج التي ينشئها SmartRenderer/SmartTable داخل مودال، مرّر الإعداد في `action.meta.smartDynamicFields` ثم استعمل:

```javascript
await window.SmartDynamicFields.mountInFormWhenReady("maintenanceForm", config);
const instance = window.SmartDynamicFields.getInstance("faults");
if (!instance.validate({ report: true })) return;
const rows = instance.getRows();
instance.sync();
```

## استخدام VIC الحالي

- الصيانة العامة: `VehicleController.GeneralMaintenance.cs` يعرّف حقول الأعطال، و`general-maintenance.js` يهيئها ويحفظ JSON في `p09`. عند التعديل، تُحمّل الأعطال من `/Vehicle/GetGeneralFaults` وتُمرر في `initialRows`.
- الإسقاط: `VehicleController.Scrap.cs` يعرّف أسباب الإتلاف، و`scrap.js` يحول الصفوف إلى النص المتوافق مع عقد البوابة الحالي ويحفظه في `p06`.
- صفحتا `GeneralMaintenance.cshtml` و`Scrap.cshtml` تحملان أصول المكوّن قبل ملفات الصفحة.

## ضوابط الدمج

- لا تنسخ الملف القديم المكرر `SmartFoundation.Mvc/wwwroot/js/sf-dynamic-fields.js`؛ النسخة الرسمية هي نسخة `SmartFoundation.UI` الموجودة في هذه الحزمة.
- يجب أن يكون `Id` فريدًا، وأن يطابق `FormId` معرّف النموذج الفعلي.
- لا يطبق المكوّن صلاحيات ولا يرسل الطلب بنفسه؛ تظل هذه المسؤوليات في Controller وإجراءات الصفحة.
- حافظ على عقد الحفظ الحالي: `p09` للصيانة العامة و`p06` للإسقاط.
