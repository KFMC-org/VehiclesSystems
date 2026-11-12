# تقرير حزمة تسليم VIC

تاريخ الإعداد: 2026-11-12

## النطاق

تحتوي الحزمة على تطويرات VIC فقط، ومكوّن SmartDynamicFields الرسمي، وتعريفات قاعدة البيانات الفعلية دون بيانات، مع Patches دقيقة للتعديلات اللازمة في الملفات المشتركة. لا تحتوي على نظام الإسكان أو نسخة كاملة من SmartFoundation.

## الملخص

- ملفات VIC التطبيقية: **26** ملفًا؛ منها **25** ملفًا غير موجود في المرجع وملف Vehicle مشترك المسار لكنه مختلف.
- ملفات SmartDynamicFields الرسمية: **5** ملفات جديدة، إضافة إلى دليل الاستخدام.
- Patches مشتركة للتطبيق: **3** ملفات Patch، ولا تستبدل أي ملف مشترك كاملًا.
- انتقال البنية الجديدة يتطلب إزالة **24** ملف VIC قديمًا موثقًا في `VehicleFiles/REMOVE-LEGACY-VIC-FILES.md`.
- Shared gateway snippets لقاعدة البيانات: **2** ملفا دمج لمسارات VIC النشطة فقط.
- قاعدة البيانات الحية: **31** جدولًا، **20** Stored Procedures، **2** Views، **0** Functions، **1** Trigger، **43** تعريف Index/Key، و**1** SQL Agent Job.
- لا توجد بيانات تشغيلية، نسخ احتياطية، أسرار اتصال، أو أوامر `DROP` خطرة.

## محتويات المجلدات

- `VehicleFiles`: ملفات Controllers وViews وModel وJavaScript وCSS الخاصة بـVIC بمساراتها الأصلية.
- `SmartDynamicFields`: الملفات الخمسة الرسمية ودليل دمج المكوّن.
- `SharedPatches`: إضافات دقيقة إلى ملفات مشتركة موجودة أصلًا لدى الفريق.
- `Database`: تعريفات مستخرجة قراءةً فقط من قاعدة `DATACORE` على الخادم `alatif`.
- `Documentation`: الجرد، التبعيات، الاستبعادات، وترتيب الدمج والتحقق.

## ملاحظات مهمة

- تعريفات SQL تمثل الحالة الفعلية التي أمكن قراءتها في 2026-11-12، ولم تُستخرج من `_deploy` القديمة بشكل أعمى.
- لم يُفترض أن ملفات `_deploy` مطبقة على القاعدة.
- توجد حالات عدم اتساق في بعض تعريفات SQL الحية موثقة في `DEPENDENCIES.md`. يجب حلها في بيئة دمج قبل النشر.
- ملفات gateway هي مقتطفات دمج وليست Stored Procedures مستقلة؛ لا تُنفذ منفردة ولا يُستبدل بها `dbo.Masters_CRUD` أو `dbo.Masters_DataLoad`.
- حزمة التسليم لم تُرفع بعد إلى GitHub ولم يُنشأ لها Commit.
- فرع `master` في مستودع VehiclesSystems أقدم من المرجع ولا يقبل Patch Drawer والتقارير مباشرة؛ راجع `TARGET-REPOSITORY-STATUS.md` قبل الرفع.

## القراءة المقترحة

1. `FILE-INVENTORY.md`
2. `DATABASE-INVENTORY.md`
3. `DEPENDENCIES.md`
4. `EXCLUSIONS.md`
5. `INTEGRATION-GUIDE.md`
6. `VALIDATION-REPORT.md`
7. `TARGET-REPOSITORY-STATUS.md`
