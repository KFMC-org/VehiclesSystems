# جرد قاعدة بيانات VIC

## مصدر الجرد وحدوده

- المصدر: قاعدة `DATACORE` الفعلية على `alatif` باستخدام Integrated Security.
- تاريخ القراءة: 2026-11-12.
- العملية كانت قراءة تعريفات Metadata فقط؛ لم تُنفذ DDL أو DML ولم تتغير القاعدة.
- التعريفات لا تحتوي بيانات تشغيلية أو Connection Strings أو Credentials.
- ملفات `_deploy` المحلية لم تُعامل كمصدر حقيقة؛ قد تختلف عن القاعدة الفعلية.

## Schema

- `VIC`

## الجداول — 31

`_DebugDetailJson`, `GeneralMaintenanceFault`, `HandoverType`, `MaintenanceDetails`, `MaintenanceGroup`, `MaintenanceGroupPeriod`, `MaintenanceTemplate`, `TypesRoot`, `VehicleDetailesExchang`, `vehicleDocument`, `VehicleGender`, `VehicleHandover`, `VehicleInsurance`, `VehicleMaintenance`, `VehicleMaintenanceGroup`, `VehicleMaintenancePlan`, `VehicleNationality`, `VehicleRank`, `VehicleRegistration`, `VehicleRequest`, `VehicleRequestHistory`, `Vehicles`, `VehicleScrap`, `VehiclesDocumentType`, `VehicleTransferRequest`, `VehicleTransferRequestHistory`, `VehicleTransferRequestType`, `VehicleUser`, `VehicleUserDetails`, `vehicleWithUsers`, `Violations`.

ملف التعريف: `Database/Tables/001_VIC_Tables.sql`. جدول `_DebugDetailJson` تشخيصي ويجب أن يقرر الفريق حاجته قبل الإنتاج، لكنه أُدرج لأن المطلوب كان استخراج جميع جداول VIC.

## Stored Procedures — 20

`CustodyDL`, `CustodySP`, `DashboardDL`, `MaintenanceDL`, `MaintenancePlanDL`, `MaintenancePlanSP`, `MaintenanceSP`, `ReportDL`, `ScrapDL`, `ScrapSP`, `TransferRequestDL`, `TransferRequestSP`, `TypesRoot_List_DL`, `TypesRoot_Upsert_SP`, `VehicleDL`, `VehicleSP`, `VehicleUserDL`, `VehicleUserSP`, `ViolationDL`, `ViolationSP`.

كل إجراء في ملف مستقل داخل `Database/StoredProcedures` ويبدأ بـ`CREATE OR ALTER PROCEDURE`.

## Views — 2

- `VIC.V_ActiveTransferRequests`
- `VIC.V_Dashboard_VehicleStatus`

## Functions وSequences وTypes وSynonyms

- Functions: 0
- Sequences: 0
- User-Defined Types: 0
- Synonyms: 0

## Trigger — 1

- `VIC.tr_Vehicles_Scrap_MaintenanceCleanup`

## Indexes وConstraints

- 43 تعريف Index/Key إجمالًا: 30 Primary Keys، و2 Unique Constraints، و11 فهرسًا آخر.
- 26 Foreign Keys.
- 39 Default Constraints.
- 6 Check Constraints.

الملف: `Database/IndexesAndConstraints/001_VIC_Indexes_And_Constraints.sql`.

سبعة Foreign Keys تعتمد على `dbo.Idara(idaraID)` من جداول: `vehicleDocument`, `VehicleHandover`, `VehicleInsurance`, `VehicleMaintenance`, `Vehicles`, `VehicleTransferRequest`, و`Violations`.

## SQL Agent Job — 1

- الاسم: `VIC - Auto Generate Maintenance Orders`
- الحالة الحية: Enabled.
- Step واحد T-SQL يستدعي `VIC.MaintenancePlanSP` مع `ActionType = AUTO_GENERATE`.
- Schedule يومي الساعة 01:00 باسم `VIC - Daily 1 AM`.
- ملف الحزمة نظيف من هوية Owner/Server/Credentials، ويحتاج مراجعة اسم قاعدة الهدف؛ التعريف الحالي يشير إلى `DATACORE`.

## Shared gateways

- `001_Masters_DataLoad_VIC_Routes.sql`: 38 مسار VIC نشطًا مستخرجًا من `dbo.Masters_DataLoad`.
- `002_Masters_CRUD_VIC_Routes.sql`: 9 مسارات VIC نشطة مستخرجة من `dbo.Masters_CRUD`.

هذه مقتطفات دمج فقط. لا تنشئ إجراءً مستقلًا ولا تستبدل تعريفات الفريق المشتركة. رُتبت الرسائل العربية التالفة داخل نسخة التسليم فقط، ولم تتغير القاعدة الحية.

## تبعيات مشتركة ظهرت في Metadata

`dbo.AuditLog`, `dbo.Distributor`, `dbo.UserDistributor`, `dbo.Users`, `dbo.UsersDetails`, و`dbo.V_getFullStructureForDSD`، إضافة إلى `dbo.Idara` المشار إليه بالـForeign Keys.

## عدم اتساق يجب حله قبل النشر

- `VIC.V_Dashboard_VehicleStatus` يشير إلى `VIC.vehicleWithUsers.userID_FK`، بينما الجدول الفعلي لا يحتوي هذا العمود.
- `VIC.TransferRequestDL` و`VIC.TransferRequestSP` أعادا أخطاء ربط عند فحص إعادة الترجمة مرتبطة بـ`userID_FK` و`RequestID_FK`.
- الحزمة تحفظ التعريفات الحية كما هي ولا تخترع إصلاحًا. يجب مقارنة العقود المقصودة والجداول في بيئة الدمج قبل تشغيل هذه الكائنات على هدف نظيف.
