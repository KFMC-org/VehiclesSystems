# الملفات والأنظمة المستبعدة

## استبعادات مقصودة

- جميع ملفات نظام الإسكان Housing، بما فيها Views المعدلة محليًا.
- تعديلات نظام المستودعات WH.
- ملفات المساعد الذكي أو AIChat.
- `appsettings.Development.json` و`appsettings.Production.json` وأي Connection Strings أو أسرار.
- مجلد `_deploy` المحلي وسكربتاته القديمة؛ استخدمت تعريفات قاعدة البيانات الفعلية بدلًا منه.
- بيانات قواعد البيانات والنسخ الاحتياطية وملفات السجل.
- `bin`, `obj`, `.git` وأي نواتج بناء.
- ملفات SmartFoundation المشتركة كاملة؛ عوضًا عنها توجد Patches دقيقة فقط.

## مكونات مشتركة لم تُنقل

- SmartDrawer الكامل وملفاته العامة؛ موجود أصلًا في المرجع.
- SmartCharts وتغييراته، ومنها `_LegendGuide.cshtml`، لعدم وجود استخدام VIC فعلي يتطلب نقلها.
- SmartRenderer وSmartTable/SmartTableDS؛ المرجع يملك الدعم المطلوب.
- `_Layout.cshtml`؛ صفحات VIC تحمل أصولها الخاصة ولا تتطلب استبداله.
- `sf-drawer.js` و`sf-drawer.css` كاملين؛ أُدرج فقط Patch تنسيق تفاصيل المركبة.
- `sf-form.js` كاملًا؛ أُدرجت معالجات VIC كـPatch.
- ملفات مكونات التقارير كاملة؛ أُدرج الفرق الإضافي فقط.
- النسخة المكررة `SmartFoundation.Mvc/wwwroot/js/sf-dynamic-fields.js`؛ النسخة الرسمية الوحيدة في التسليم هي نسخة `SmartFoundation.UI`.

## ملفات محلية غير مرتبطة بالتسليم

حالة `C:\GitHub\last` كانت تحتوي تغييرات كثيرة سابقة، منها Housing وWH وPermissions وSettings وCSS ومكونات عامة. لم تُحذف أو تُعدّل أو تُضمّن تلقائيًا. جرى انتقاء ملفات VIC بعد مقارنة المحتوى والاستخدام مع `C:\GitHub\laaaaaaast`.
