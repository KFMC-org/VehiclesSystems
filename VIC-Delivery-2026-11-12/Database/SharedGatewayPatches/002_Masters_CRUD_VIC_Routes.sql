/*
    VIC merge snippets extracted from the live dbo.Masters_CRUD definition.
    NOT a standalone procedure and must not replace the team's shared gateway.
    Merge each route into the existing @pageName_ chain after reviewing parameters.
    Only active (non-commented) VIC routes are included.
    Extracted read-only on 2026-11-12.
*/

-- =====================================================================
-- Route: TypesRoot_Upsert
-- =====================================================================
ELSE IF @pageName_ = 'TypesRoot_Upsert'
BEGIN

    IF (
        SELECT COUNT(*)
        FROM DATACORE.dbo.V_GetListUserPermission v
        WHERE v.userID = @entrydata
          AND v.menuName_E = @pageName_
          AND v.permissionTypeName_E = @ActionType
    ) <= 0
    BEGIN
        SET @ok = 0;
        SET @msg = N'ليس لديك صلاحية لتنفيذ هذه العملية';
        GOTO Finish;
    END

    DELETE FROM @Result;

    IF @ActionType = 'INSERT'
    BEGIN
        INSERT INTO @Result (IsSuccessful, Message_)
        EXEC [VIC].[TypesRoot_Upsert_SP]
              @typesID            = NULL
            , @typesName_A        = @parameter_01
            , @typesName_E        = @parameter_02
            , @typesDesc          = @parameter_03
            , @typesActive        = @parameter_04
            , @typesStartDate     = @parameter_05
            , @typesEndDate       = @parameter_06
            , @typesRoot_ParentID = @parameter_07
            , @entryData          = @entrydata
            , @hostName           = @hostName;
    END
    ELSE IF @ActionType = 'UPDATE'
    BEGIN
        INSERT INTO @Result (IsSuccessful, Message_)
        EXEC [VIC].[TypesRoot_Upsert_SP]
              @typesID            = @parameter_01
            , @typesName_A        = @parameter_02
            , @typesName_E        = @parameter_03
            , @typesDesc          = @parameter_04
            , @typesActive        = @parameter_05
            , @typesStartDate     = @parameter_06
            , @typesEndDate       = @parameter_07
            , @typesRoot_ParentID = @parameter_08
            , @entryData          = @entrydata
            , @hostName           = @hostName;
    END
    ELSE
    BEGIN
        SET @ok = 0;
        SET @msg = N'نوع العملية غير معروف. ActionType';
        GOTO Finish;
    END

    SELECT TOP 1 @ok = IsSuccessful, @msg = Message_ FROM @Result;

    GOTO Finish;
END

-- =====================================================================
-- Route: Vehiclelist
-- =====================================================================
ELSE IF @pageName_ = 'Vehiclelist'
BEGIN
    IF (
        SELECT COUNT(*)
    FROM dbo.V_GetListUserPermission v
    WHERE v.userID = @entrydata
      AND v.menuName_E = @pageName_
      AND v.permissionTypeName_E = @ActionType
    ) <= 0
    BEGIN
        SET @ok = 0;
        SET @msg = N'ليس لديك صلاحية لتنفيذ هذه العملية';
        GOTO Finish;
    END

    DELETE FROM @Result;

    -- Vehicle INSERT
    IF @ActionType = 'VEHICLE_UPSERT_INSERT'
    BEGIN
        DECLARE @VehResultIns TABLE (IsSuccessful INT, Message_ NVARCHAR(4000), chassisNumber NVARCHAR(200), vehicleID BIGINT);

        INSERT INTO @VehResultIns
        EXEC [VIC].[VehicleSP]
              @ActionType             = N'UPSERT'
            , @vehicleID              = NULL
            , @chassisNumber          = @parameter_01
            , @ownerID_FK             = @parameter_02
            , @ManufacturerNameID_FK  = @parameter_03
            , @vehicleModelID_FK      = @parameter_04
            , @vehicleClassID_FK      = @parameter_05
            , @TypeOfUseID_FK         = @parameter_06
            , @vehicleColorID_FK      = @parameter_07
            , @countryMadeID_FK       = @parameter_08
            , @regstritionTypeID_FK   = @parameter_09
            , @regionID_FK            = @parameter_10
            , @fuelTypeID_FK          = @parameter_11
            , @vehicleTypeID_FK       = @parameter_12
            , @yearModel              = @parameter_13
            , @capacity               = @parameter_14
            , @serialNumber           = @parameter_15
            , @plateLetters           = @parameter_16
            , @plateNumbers           = @parameter_17
            , @armyNumber             = @parameter_18
            , @vehicleNote            = @parameter_19
            , @idaraID_FK             = @idaraID
            , @entryData              = @entrydata
            , @hostName               = @hostName;

        SELECT TOP 1 @ok = IsSuccessful, @msg = Message_ FROM @VehResultIns;
        GOTO Finish;
    END
    -- Vehicle UPDATE
    ELSE IF @ActionType = 'VEHICLE_UPSERT_UPDATE'
    BEGIN
        DECLARE @VehResultUpd TABLE (IsSuccessful INT, Message_ NVARCHAR(4000), chassisNumber NVARCHAR(200), vehicleID BIGINT);

        INSERT INTO @VehResultUpd
        EXEC [VIC].[VehicleSP]
              @ActionType             = N'UPSERT'
            , @vehicleID              = NULL
            , @chassisNumber          = @parameter_01
            , @ownerID_FK             = @parameter_02
            , @ManufacturerNameID_FK  = @parameter_03
            , @vehicleModelID_FK      = @parameter_04
            , @vehicleClassID_FK      = @parameter_05
            , @TypeOfUseID_FK         = @parameter_06
            , @vehicleColorID_FK      = @parameter_07
            , @countryMadeID_FK       = @parameter_08
            , @regstritionTypeID_FK   = @parameter_09
            , @regionID_FK            = @parameter_10
            , @fuelTypeID_FK          = @parameter_11
            , @vehicleTypeID_FK       = @parameter_12
            , @yearModel              = @parameter_13
            , @capacity               = @parameter_14
            , @serialNumber           = @parameter_15
            , @plateLetters           = @parameter_16
            , @plateNumbers           = @parameter_17
            , @armyNumber             = @parameter_18
            , @vehicleNote            = @parameter_19
            , @idaraID_FK             = @idaraID
            , @entryData              = @entrydata
            , @hostName               = @hostName;

        SELECT TOP 1 @ok = IsSuccessful, @msg = Message_ FROM @VehResultUpd;
        GOTO Finish;
    END
    -- Insurance INSERT / UPDATE
    ELSE IF @ActionType IN (N'VEHICLEINSURANCE_UPSERT_INSERT', N'VEHICLEINSURANCE_UPSERT_UPDATE')
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[VehicleSP]
              @ActionType            = N'UPSERT_INSURANCE'
            , @VehicleInsuranceID    = @parameter_01
            , @chassisNumber         = @parameter_02
            , @InsuranceOpertionType = @parameter_03
            , @InsuranceTypeID       = @parameter_04
            , @Source                = @parameter_05
            , @StartInsurance        = @parameter_06
            , @EndInsurance          = @parameter_07
            , @Amount                = @parameter_08
            , @InsuranceNote         = @parameter_09
            , @InsuranceActive       = @parameter_10
            , @idaraID_FK            = @idaraID
            , @entryData             = @entrydata
            , @hostName              = @hostName;
    END
    -- Insurance SetActive
    ELSE IF @ActionType = N'VEHICLEINSURANCE_SETACTIVE_UPDATE'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[VehicleSP]
              @ActionType          = N'SET_INSURANCE_ACTIVE'
            , @VehicleInsuranceID  = @parameter_01
            , @InsuranceActiveFlag = NULL
            , @idaraID_FK          = @idaraID
            , @entryData           = @entrydata
            , @hostName            = @hostName;
    END
    -- Document INSERT
    ELSE IF @ActionType = 'VEHICLEDOCUMENT_UPSERT_INSERT'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[VehicleSP]
              @ActionType            = N'UPSERT_DOCUMENT'
            , @vehicleID             = NULL
            , @chassisNumber         = @parameter_01
            , @vehicleDocumentID     = NULL
            , @vehicleDocumentTypeID = @parameter_02
            , @vehicleDocumentNo     = @parameter_03
            , @vehicleDocStartDate   = @parameter_04
            , @vehicleDocEndDate     = @parameter_05
            , @idaraID_FK            = @idaraID
            , @entryData             = @entrydata
            , @hostName              = @hostName;
    END
    -- Document UPDATE
    ELSE IF @ActionType = 'VEHICLEDOCUMENT_UPSERT_UPDATE'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[VehicleSP]
              @ActionType            = N'UPSERT_DOCUMENT'
            , @vehicleID             = NULL
            , @chassisNumber         = @parameter_02
            , @vehicleDocumentID     = @parameter_01
            , @vehicleDocumentTypeID = @parameter_03
            , @vehicleDocumentNo     = @parameter_04
            , @vehicleDocStartDate   = @parameter_05
            , @vehicleDocEndDate     = @parameter_06
            , @idaraID_FK            = @idaraID
            , @entryData             = @entrydata
            , @hostName              = @hostName;
    END
    ELSE
    BEGIN
        SET @ok = 0;
        SET @msg = N'نوع العملية غير معروف. ActionType=[' + ISNULL(@ActionType, N'NULL') + N']';
        GOTO Finish;
    END

    SELECT TOP 1 @ok = IsSuccessful, @msg = Message_ FROM @Result;
    GOTO Finish;
END

-- =====================================================================
-- Route: Custody
-- =====================================================================
ELSE IF @pageName_ = 'Custody'
BEGIN
    IF (
        SELECT COUNT(*)
        FROM DATACORE.dbo.V_GetListUserPermission v
        WHERE v.userID = @entrydata
          AND v.menuName_E = @pageName_
          AND v.permissionTypeName_E = @ActionType
    ) <= 0
    BEGIN
        SET @ok = 0;
        SET @msg = N'ليس لديك صلاحية لتنفيذ هذه العملية';
        GOTO Finish;
    END
    DELETE FROM @Result;
    IF @ActionType = 'INSERTCUSTODY'
    BEGIN
        DECLARE @CustodyInsertResult TABLE (IsSuccessful INT, Message_ NVARCHAR(4000), vehicleWithUsersID INT);
        INSERT INTO @CustodyInsertResult(IsSuccessful, Message_, vehicleWithUsersID)
        EXEC [VIC].[CustodySP]
              @ActionType             = 'INSERTCUSTODY'
            , @vehicleID              = @parameter_01
            , @chassisNumber          = @parameter_02
            , @vehicleUserID_FK       = @parameter_03
            , @startDate              = @parameter_04
            , @note                   = @parameter_05
            , @entryData              = @entrydata
            , @hostName               = @hostName
            , @idaraID_FK             = @idaraID
            , @createGeneralNo        = @parameter_06
            , @createNationalID       = @parameter_07
            , @createMobileNo         = @parameter_08
            , @createRankID_FK        = @parameter_09
            , @createNationalityID_FK = @parameter_10
            , @createGenderID_FK      = @parameter_11
            , @createFirstName_A      = @parameter_12
            , @createSecondName_A     = @parameter_13
            , @createThirdName_A      = @parameter_14
            , @createLastName_A       = @parameter_15;
        INSERT INTO @Result(IsSuccessful, Message_)
        SELECT IsSuccessful, Message_ FROM @CustodyInsertResult;
    END
    ELSE IF @ActionType = 'CLOSECUSTODY'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[CustodySP]
              @ActionType         = 'CLOSECUSTODY'
            , @vehicleWithUsersID = @parameter_01
            , @endDate            = @parameter_02
            , @note               = @parameter_03
            , @entryData          = @entrydata
            , @hostName           = @hostName
            , @idaraID_FK         = @idaraID;
    END
    ELSE IF @ActionType = 'UPSERT_HANDOVER_TYPE'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[CustodySP]
              @ActionType           = 'UPSERT_HANDOVER_TYPE'
            , @handOverTypeID_Param = @parameter_01
            , @handoverTypeNameA    = @parameter_02
            , @handoverTypeNameE    = @parameter_03
            , @active               = @parameter_04
            , @entryData            = @entrydata
            , @hostName             = @hostName
            , @idaraID_FK           = @idaraID;
    END
    ELSE
    BEGIN
        SET @ok = 0;
        SET @msg = N'نوع العملية غير معروف. ActionType=' + ISNULL(@ActionType, N'NULL');
        GOTO Finish;
    END
    SELECT TOP 1 @ok = IsSuccessful, @msg = Message_ FROM @Result;
    GOTO Finish;
END

-- =====================================================================
-- Route: VehicleUser_Upsert
-- =====================================================================
else IF @pageName_ = 'VehicleUser_Upsert'
BEGIN
    IF (
        SELECT COUNT(*)
        FROM DATACORE.dbo.V_GetListUserPermission v
        WHERE v.userID = @entrydata
          AND v.menuName_E = @pageName_
          AND v.permissionTypeName_E = @ActionType
    ) <= 0
    BEGIN
        SET @ok = 0;
        SET @msg = N'ليس لديك صلاحية لتنفيذ هذه العملية';
        GOTO Finish;
    END

    DELETE FROM @Result;

    IF @ActionType IN ('INSERT', 'UPDATE')
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[VehicleUserSP]
              @ActionType        = 'UPSERT'
            , @vehicleUserID     = @parameter_01
            , @generalNo         = @parameter_02
            , @nationalID        = @parameter_03
            , @mobileNo          = @parameter_04
            , @IdaraID_FK        = @idaraID
            , @userActive        = @parameter_05
            , @entryData         = @entrydata
            , @hostName          = @hostName
            , @rankID_FK         = @parameter_06
            , @nationalityID_FK  = @parameter_07
            , @genderID_FK       = @parameter_08
            , @firstName_A       = @parameter_09
            , @secondName_A      = @parameter_10
            , @thirdName_A       = @parameter_11
            , @lastName_A        = @parameter_12
            , @firstName_E       = @parameter_13
            , @secondName_E      = @parameter_14
            , @thirdName_E       = @parameter_15
            , @lastName_E        = @parameter_16
            , @note              = @parameter_17;
    END
    ELSE
    BEGIN
        SET @ok = 0;
        SET @msg = N'نوع العملية غير معروف. ActionType';
        GOTO Finish;
    END

    SELECT TOP 1 @ok = IsSuccessful, @msg = Message_ FROM @Result;
    GOTO Finish;
END

-- =====================================================================
-- Route: VehicleUser_SetActive
-- =====================================================================
else IF @pageName_ = 'VehicleUser_SetActive'
BEGIN
    IF (
        SELECT COUNT(*)
        FROM DATACORE.dbo.V_GetListUserPermission v
        WHERE v.userID = @entrydata
          AND v.menuName_E = @pageName_
          AND v.permissionTypeName_E = @ActionType
    ) <= 0
    BEGIN
        SET @ok = 0;
        SET @msg = N'ليس لديك صلاحية لتنفيذ هذه العملية';
        GOTO Finish;
    END

    DELETE FROM @Result;

    IF @ActionType = 'UPDATE'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[VehicleUserSP]
              @ActionType    = 'SET_ACTIVE'
            , @vehicleUserID = @parameter_01
            , @userActive    = @parameter_02
            , @entryData     = @entrydata
            , @hostName      = @hostName;
    END
    ELSE
    BEGIN
        SET @ok = 0;
        SET @msg = N'نوع العملية غير معروف. ActionType';
        GOTO Finish;
    END

    SELECT TOP 1 @ok = IsSuccessful, @msg = Message_ FROM @Result;
    GOTO Finish;
END

-- =====================================================================
-- Route: PeriodicMaintenance
-- =====================================================================
ELSE IF @pageName_ = 'PeriodicMaintenance'
BEGIN
    IF (
        SELECT COUNT(*)
        FROM dbo.V_GetListUserPermission v
        WHERE v.userID = @entrydata
          AND v.menuName_E = @pageName_
          AND v.permissionTypeName_E = @ActionType
    ) <= 0
    BEGIN
        SET @ok = 0;
        SET @msg = N'ليس لديك صلاحية لتنفيذ هذه العملية';
        GOTO Finish;
    END

    DELETE FROM @Result;

    IF @ActionType = 'INSERT_PERIODIC_ORDER'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[MaintenanceSP]
              @ActionType        = N'UPSERT_ORDER'
            , @maintOrdID        = NULL
            , @maintOrdTypeID_FK = 265
            , @vehicleID         = NULL
            , @chassisNumber     = @parameter_01
            , @maintOrdDesc      = @parameter_03
            , @maintOrdActive    = 1
            , @idaraID_FK        = @idaraID
            , @entryData         = @entrydata
            , @hostName          = @hostName
            , @groupID           = @parameter_02;
    END
    ELSE IF @ActionType = 'UPDATE_PERIODIC_ORDER'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[MaintenanceSP]
              @ActionType        = N'UPSERT_ORDER'
            , @maintOrdID        = @parameter_01
            , @maintOrdTypeID_FK = 265
            , @vehicleID         = NULL
            , @chassisNumber     = @parameter_02
            , @maintOrdStartDate = @parameter_03
            , @maintOrdEndDate   = @parameter_04
            , @maintOrdDesc      = @parameter_05
            , @maintOrdActive    = 1
            , @idaraID_FK        = @idaraID
            , @entryData         = @entrydata
            , @hostName          = @hostName;
    END
    ELSE IF @ActionType = 'MOVE_GROUP'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[MaintenancePlanSP]
              @ActionType    = N'MOVE_GROUP'
            , @chassisNumber = @parameter_01
            , @groupID       = @parameter_02
            , @idaraID_FK    = @idaraID
            , @entryData     = @entrydata
            , @hostName      = @hostName;
    END
    ELSE IF @ActionType = 'CLOSE_PERIODIC_ORDER'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[MaintenanceSP]
              @ActionType      = N'CLOSE_ORDER'
            , @maintOrdID      = @parameter_01
             , @workshopIDs    = @parameter_08
           , @maintOrdEndDate = @parameter_02
            , @odometer        = @parameter_03
            , @detailJson      = @parameter_04
            , @idaraID_FK      = @idaraID
            , @entryData       = @entrydata
            , @hostName        = @hostName;
    END
    ELSE IF @ActionType = 'UPSERT_PERIODIC_DETAIL'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[MaintenanceSP]
              @ActionType       = N'UPSERT_DETAIL'
            , @maintOrdID       = @parameter_01
            , @maintDetailesID  = @parameter_02
            , @typesID_FK       = @parameter_03
            , @CheckStatus_FK   = @parameter_04
            , @CorrectiveAction = @parameter_05
            , @Notes            = @parameter_06
            , @idaraID_FK       = @idaraID
            , @entryData        = @entrydata
            , @hostName         = @hostName;
    END
    ELSE IF @ActionType = 'DELETE_PERIODIC_DETAIL'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[MaintenanceSP]
              @ActionType      = N'DELETE_DETAIL'
            , @maintDetailesID = @parameter_01
            , @idaraID_FK      = @idaraID
            , @entryData       = @entrydata
            , @hostName        = @hostName;
    END
    ELSE
    BEGIN
        SET @ok = 0;
        SET @msg = N'نوع العملية غير معروف. ActionType';
        GOTO Finish;
    END

    SELECT TOP 1 @ok = IsSuccessful, @msg = Message_ FROM @Result;
    GOTO Finish;
END

-- =====================================================================
-- Route: GeneralMaintenance
-- =====================================================================
ELSE IF @pageName_ = 'GeneralMaintenance'
BEGIN
    IF (
        SELECT COUNT(*)
        FROM dbo.V_GetListUserPermission v
        WHERE v.userID = @entrydata
          AND v.menuName_E = @pageName_
          AND v.permissionTypeName_E = @ActionType
    ) <= 0
    BEGIN
        SET @ok = 0;
        SET @msg = N'ليس لديك صلاحية لتنفيذ هذه العملية';
        GOTO Finish;
    END

    DELETE FROM @Result;

    IF @ActionType = 'INSERT_GENERAL_ORDER'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[MaintenanceSP]
              @ActionType        = N'UPSERT_ORDER'
            , @maintOrdID        = NULL
            , @maintOrdTypeID_FK = 266
            , @vehicleID         = NULL
            , @chassisNumber     = @parameter_01
            , @maintOrdStartDate = @parameter_02
            , @maintOrdEndDate   = @parameter_03
            , @maintOrdDesc      = @parameter_04
            , @maintOrdActive    = 1
            , @idaraID_FK        = @idaraID
            , @entryData         = @entrydata
            , @hostName          = @hostName
            , @faultJson         = @parameter_09;
    END
    ELSE IF @ActionType = 'UPDATE_GENERAL_ORDER'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[MaintenanceSP]
              @ActionType        = N'UPSERT_ORDER'
            , @maintOrdID        = @parameter_01
            , @maintOrdTypeID_FK = 266
            , @vehicleID         = NULL
            , @chassisNumber     = @parameter_02
            , @maintOrdStartDate = @parameter_03
            , @maintOrdEndDate   = @parameter_04
            , @maintOrdDesc      = @parameter_05
            , @maintOrdActive    = 1
            , @idaraID_FK        = @idaraID
            , @entryData         = @entrydata
            , @hostName          = @hostName
            , @faultJson         = @parameter_09;
    END
    ELSE IF @ActionType = 'CLOSE_GENERAL_ORDER'
BEGIN
    INSERT INTO @Result(IsSuccessful, Message_)
    EXEC [VIC].[MaintenanceSP]
          @ActionType      = N'CLOSE_ORDER'
        , @maintOrdID      = @parameter_01
        , @maintOrdEndDate = @parameter_07
        , @actionJson      = @parameter_09
        , @workshopIDs     = @parameter_08   -- معرفات الورش
        , @idaraID_FK      = @idaraID
        , @entryData       = @entrydata
        , @hostName        = @hostName;
END
    ELSE
    BEGIN
        SET @ok = 0;
        SET @msg = N'نوع العملية غير معروف. ActionType';
        GOTO Finish;
    END

    SELECT TOP 1 @ok = IsSuccessful, @msg = Message_ FROM @Result;
    GOTO Finish;
END

-- =====================================================================
-- Route: Scrap
-- =====================================================================
ELSE IF @pageName_ = 'Scrap'
BEGIN

    IF (
        SELECT COUNT(*)
        FROM dbo.V_GetListUserPermission v
        WHERE v.userID = @entrydata
          AND v.menuName_E = @pageName_
          AND v.permissionTypeName_E = @ActionType
    ) <= 0
    BEGIN
        SET @ok = 0;
        SET @msg = N'ليس لديك صلاحية لتنفيذ هذه العملية';
        GOTO Finish;
    END

    DELETE FROM @Result;

    IF @ActionType = 'INSERT_SCRAP'
    BEGIN

        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[ScrapSP]
             @ActionType     = N'UPSERT'
            ,@ScrapID        = NULL
            ,@vehicleID      = @parameter_01
            ,@chassisNumber  = @parameter_02
            ,@idaraID_FK     = @idaraID
            ,@ScrapDate      = @parameter_03
            ,@ScrapTypeID_FK = @parameter_04
            ,@RefNo          = @parameter_05
            ,@Reason         = @parameter_06
            ,@Note           = @parameter_07
            ,@entryData      = @entrydata
            ,@hostName       = @hostName
            ,@actionByUserID = NULL
            ,@actionNote     = @parameter_08;

    END

    ELSE IF @ActionType = 'UPDATE_SCRAP'
    BEGIN

        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[ScrapSP]
             @ActionType     = N'UPSERT'
            ,@ScrapID        = @parameter_01
            ,@vehicleID      = NULL
            ,@chassisNumber  = @parameter_02
            ,@idaraID_FK     = @idaraID
            ,@ScrapDate      = @parameter_03
            ,@ScrapTypeID_FK = @parameter_04
            ,@RefNo          = @parameter_05
            ,@Reason         = @parameter_06
            ,@Note           = @parameter_07
            ,@entryData      = @entrydata
            ,@hostName       = @hostName
            ,@actionByUserID = NULL
            ,@actionNote     = @parameter_08;

    END

    ELSE IF @ActionType = 'APPROVE_SCRAP'
    BEGIN

        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[ScrapSP]
             @ActionType     = N'APPROVE'
            ,@ScrapID        = @parameter_01
            ,@actionByUserID = @entrydata
            ,@actionNote     = @parameter_20
            ,@idaraID_FK     = @idaraID
            ,@entryData      = @entrydata
            ,@hostName       = @hostName;

    END

    ELSE IF @ActionType = 'CANCEL_SCRAP'
    BEGIN

        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[ScrapSP]
             @ActionType     = N'CANCEL'
            ,@ScrapID        = @parameter_01
            ,@actionByUserID = @entrydata
            ,@actionNote     = @parameter_20
            ,@idaraID_FK     = @idaraID
            ,@entryData      = @entrydata
            ,@hostName       = @hostName;

    END

    ELSE
    BEGIN
        SET @ok = 0;
        SET @msg = N'نوع العملية غير معروف. ActionType';
        GOTO Finish;
    END

    SELECT TOP 1 @ok = IsSuccessful, @msg = Message_
    FROM @Result;

    GOTO Finish;
END

-- =====================================================================
-- Route: Violation
-- =====================================================================
ELSE IF @pageName_ = 'Violation'
BEGIN
    IF (
        SELECT COUNT(*)
        FROM dbo.V_GetListUserPermission v
        WHERE v.userID = @entrydata
          AND v.menuName_E = @pageName_
          AND v.permissionTypeName_E = @ActionType
    ) <= 0
    BEGIN
        SET @ok = 0;
        SET @msg = N'ليس لديك صلاحية لتنفيذ هذه العملية';
        GOTO Finish;
    END

    DELETE FROM @Result;

    IF @ActionType = 'ADD_VIOLATION'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[ViolationSP]
             @ActionType        = N'UPSERT'
            ,@violationID       = NULL
            ,@vehicleID         = @parameter_02
            ,@violationTypeID   = @parameter_03
            ,@violationDate     = @parameter_04
            ,@violationPrice    = @parameter_05
            ,@violationLocation = @parameter_06
            ,@idaraID_FK        = @idaraID
            ,@entryData         = @entrydata
            ,@hostName          = @hostName;
    END
    ELSE IF @ActionType = 'EDIT_VIOLATION'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[ViolationSP]
             @ActionType        = N'UPSERT'
            ,@violationID       = @parameter_01
            ,@vehicleID         = @parameter_02
            ,@violationTypeID   = @parameter_03
            ,@violationDate     = @parameter_04
            ,@violationPrice    = @parameter_05
            ,@violationLocation = @parameter_06
            ,@idaraID_FK        = @idaraID
            ,@entryData         = @entrydata
            ,@hostName          = @hostName;
    END
    ELSE IF @ActionType = 'SET_PAYMENT'
    BEGIN
        INSERT INTO @Result(IsSuccessful, Message_)
        EXEC [VIC].[ViolationSP]
             @ActionType     = N'SET_PAYMENT'
            ,@violationID    = @parameter_01
            ,@PaymentDate    = @parameter_10
            ,@entryPayment   = @parameter_11
            ,@idaraID_FK     = @idaraID
            ,@entryData      = @entrydata
            ,@hostName       = @hostName;
    END
    ELSE
    BEGIN
        SET @ok = 0;
        SET @msg = N'نوع العملية غير معروف. ActionType';
        GOTO Finish;
    END

    SELECT TOP 1
        @ok = IsSuccessful,
        @msg = Message_
    FROM @Result;

    GOTO Finish;
END

