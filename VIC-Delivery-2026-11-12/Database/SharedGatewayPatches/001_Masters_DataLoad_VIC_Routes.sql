/*
    VIC merge snippets extracted from the live dbo.Masters_DataLoad definition.
    NOT a standalone procedure and must not replace the team's shared gateway.
    Merge each route into the existing @pageName_ chain after reviewing parameters.
    Only active (non-commented) VIC routes are included.
    Extracted read-only on 2026-11-12.
*/

-- =====================================================================
-- Route: TypesRoot_List
-- =====================================================================
    ELSE IF @pageName_ = 'TypesRoot_List'
    BEGIN
        EXEC [VIC].[TypesRoot_List_DL]
              @parentID   = @parameter_01
            , @activeOnly = @parameter_02
            , @search     = @parameter_03;
    END

-- =====================================================================
-- Route: Vehiclelist
-- =====================================================================
ELSE IF @pageName_ = 'Vehiclelist'
BEGIN
    EXEC [VIC].[VehicleDL]
          @ActionType    = N'LIST'
        , @idaraID_FK    = @idaraID
        , @ownerID_FK    = @parameter_01
        , @plateLetters  = @parameter_02
        , @plateNumbers  = @parameter_03
        , @hasCustody    = @parameter_04
        , @pageNumber    = @parameter_05
        , @pageSize      = @parameter_06;
END

-- =====================================================================
-- Route: Vehicle_Get
-- =====================================================================
ELSE IF @pageName_ = 'Vehicle_Get'
BEGIN
    EXEC [VIC].[VehicleDL]
          @ActionType    = N'GET'
        , @vehicleID     = @parameter_01
        , @chassisNumber = @parameter_02;
END

-- =====================================================================
-- Route: Vehicle_AvailableForPeriodic
-- =====================================================================
ELSE IF @pageName_ = 'Vehicle_AvailableForPeriodic'
BEGIN
    EXEC [VIC].[VehicleDL] @ActionType = N'AVAILABLE_FOR_PERIODIC', @idaraID_FK = @idaraID;
END

-- =====================================================================
-- Route: Vehicle_Search
-- =====================================================================

ELSE IF @pageName_ = 'Vehicle_Search'
BEGIN
    EXEC [VIC].[VehicleDL]
          @ActionType = N'SEARCH'
        , @q          = @parameter_01
        , @pageSize   = @parameter_02;
END

-- =====================================================================
-- Route: Vehicle_GetLookups
-- =====================================================================
ELSE IF @pageName_ = 'Vehicle_GetLookups'
BEGIN
    EXEC [VIC].[VehicleDL]
          @ActionType = N'AVAILABLE_FOR_CUSTODY'
        , @idaraID_FK = @idaraID;
END

-- =====================================================================
-- Route: Vehicle_Profile_Get
-- =====================================================================
ELSE IF @pageName_ = 'Vehicle_Profile_Get'
BEGIN
    EXEC [VIC].[VehicleDL]
          @ActionType      = N'GET_PROFILE'
        , @idaraID_FK      = @idaraID
        , @chassisNumber   = @parameter_04
        , @TopDocuments    = @parameter_05
        , @TopInsurance    = @parameter_06
        , @TopMaintenance  = @parameter_07
        , @TopViolations   = @parameter_08;
END

-- =====================================================================
-- Route: VehicleDocument_List
-- =====================================================================
    ELSE IF @pageName_ = 'VehicleDocument_List'
    BEGIN
        EXEC [VIC].[VehicleDL]
              @ActionType = N'LIST_DOCUMENTS'
            , @ActiveOnly = @parameter_01;
    END

-- =====================================================================
-- Route: VehicleDocuments_List
-- =====================================================================
    ELSE IF @pageName_ = 'VehicleDocuments_List'
    BEGIN
        EXEC [VIC].[VehicleDL]
              @ActionType    = N'LIST_DOCUMENTS'
            , @idaraID_FK    = @idaraID
            , @chassisNumber = @parameter_01
            , @pageNumber    = @parameter_02
            , @pageSize      = @parameter_03;
    END

-- =====================================================================
-- Route: VehicleDocumentType_List
-- =====================================================================
    ELSE IF @pageName_ = 'VehicleDocumentType_List'
    BEGIN
        EXEC [VIC].[VehicleDL]
              @ActionType = N'LIST_DOCUMENT_TYPES'
            , @ActiveOnly = @parameter_01;
    END

-- =====================================================================
-- Route: Admin_VehicleDocumentType
-- =====================================================================
    ELSE IF @pageName_ = 'Admin_VehicleDocumentType'
    BEGIN
        EXEC [VIC].[VehicleDL]
              @ActionType = N'LIST_DOCUMENT_TYPES'
            , @ActiveOnly = 0;
    END

-- =====================================================================
-- Route: VehicleInsurance_List
-- =====================================================================
ELSE IF @pageName_ = 'VehicleInsurance_List'
BEGIN
    EXEC [VIC].[VehicleDL]
          @ActionType      = N'LIST_INSURANCE'
        , @idaraID_FK      = @idaraID
        , @chassisNumber   = @parameter_01
        , @active          = @parameter_02
        , @InsuranceDays   = @parameter_03
        , @IncludeExpired  = @parameter_04
        , @pageNumber      = @parameter_07
        , @pageSize        = @parameter_08;
END

-- =====================================================================
-- Route: VehicleUser_Get
-- =====================================================================
else IF @pageName_ = 'VehicleUser_Get'
BEGIN
    EXEC [VIC].[VehicleUserDL]
          @ActionType    = 'GET'
        , @vehicleUserID = @parameter_01
        , @IdaraID_FK    = @idaraID;
END

-- =====================================================================
-- Route: VehicleUser_List
-- =====================================================================
else IF @pageName_ = 'VehicleUser_List'
BEGIN
    EXEC [VIC].[VehicleUserDL]
          @ActionType    = 'LIST'
        , @generalNo     = @parameter_01
        , @nationalID    = @parameter_02
        , @IdaraID_FK    = @idaraID
        , @userActive    = @parameter_03
        , @pageNumber    = @parameter_04
        , @pageSize      = @parameter_05;
END

-- =====================================================================
-- Route: VehicleUser_Search
-- =====================================================================
else IF @pageName_ = 'VehicleUser_Search'
BEGIN
    EXEC [VIC].[VehicleUserDL]
          @ActionType    = 'SEARCH'
        , @q             = @parameter_01
        , @generalNo     = @parameter_02
        , @IdaraID_FK    = @idaraID
        , @top           = @parameter_03;
END

-- =====================================================================
-- Route: VehicleUser_DDL
-- =====================================================================
else IF @pageName_ = 'VehicleUser_DDL'
BEGIN
    EXEC [VIC].[VehicleUserDL]
          @ActionType    = @parameter_01
        , @IdaraID_FK    = @idaraID;
END

-- =====================================================================
-- Route: Custody
-- =====================================================================
else IF @pageName_ = 'Custody'
BEGIN
    EXEC [VIC].[CustodyDL]
          @ActionType    = 'CURRENT_LIST'
        , @vehicleUserID = @parameter_01
        , @generalNo     = @parameter_02
        , @chassisNumber = @parameter_03
        , @pageNumber    = @parameter_04
        , @pageSize      = @parameter_05
        , @idaraID_FK    = @idaraID;
END

-- =====================================================================
-- Route: Custody_HistoryList
-- =====================================================================
else IF @pageName_ = 'Custody_HistoryList'
BEGIN
    EXEC [VIC].[CustodyDL]
          @ActionType    = 'HISTORY_LIST'
        , @chassisNumber = @parameter_01
        , @fromDate      = @parameter_02
        , @toDate        = @parameter_03
        , @generalNo     = @parameter_04
        , @searchUser    = @parameter_05
        , @pageNumber    = @parameter_06
        , @pageSize      = @parameter_07
        , @idaraID_FK    = @idaraID;
END

-- =====================================================================
-- Route: Custody_SearchUsers
-- =====================================================================
else IF @pageName_ = 'Custody_SearchUsers'
BEGIN
    EXEC [VIC].[CustodyDL]
          @ActionType    = 'SEARCH_USERS'
        , @chassisNumber = @parameter_01
        , @generalNo     = @parameter_02
        , @idaraID_FK    = @idaraID;
        --, @top           = @parameter_03;
END

-- =====================================================================
-- Route: Handover_Get
-- =====================================================================
    ELSE IF @pageName_ = 'Handover_Get'
    BEGIN
        EXEC [VIC].[CustodyDL]
              @ActionType      = N'GET_HANDOVER'
            , @vehicleHandoverID = @parameter_01;
    END

-- =====================================================================
-- Route: Handover_List
-- =====================================================================
    ELSE IF @pageName_ = 'Handover_List'
    BEGIN
        EXEC [VIC].[CustodyDL]
              @ActionType    = N'LIST_HANDOVER'
            , @requestID     = @parameter_01
            , @handoverTypeID = @parameter_02
            , @pageNumber    = @parameter_03
            , @pageSize      = @parameter_04
            , @idaraID_FK    = @parameter_05;
    END

-- =====================================================================
-- Route: Handover_Print_Get
-- =====================================================================
    ELSE IF @pageName_ = 'Handover_Print_Get'
    BEGIN
        EXEC [VIC].[CustodyDL]
              @ActionType      = N'PRINT_HANDOVER'
            , @vehicleHandoverID = @parameter_01;
    END

-- =====================================================================
-- Route: HandoverType_List
-- =====================================================================
    ELSE IF @pageName_ = 'HandoverType_List'
    BEGIN
        EXEC [VIC].[CustodyDL]
              @ActionType = N'LIST_HANDOVER_TYPE'
            , @activeOnly = @parameter_01;
    END

-- =====================================================================
-- Route: Scrap
-- =====================================================================
ELSE IF @pageName_ = 'Scrap'
BEGIN
    EXEC [VIC].[ScrapDL]
          @ActionType    = @parameter_01
        , @scrapID       = @parameter_02
        , @vehicleID     = @parameter_03
        , @chassisNumber = @parameter_04
        , @Status        = @parameter_05
        , @DateFrom      = @parameter_06
        , @DateTo        = @parameter_07
        , @pageNumber    = @parameter_08
        , @pageSize      = @parameter_09
        , @idaraID_FK    = @idaraID;
END

-- =====================================================================
-- Route: Violation_GetLookups
-- =====================================================================
ELSE IF @pageName_ = 'Violation_GetLookups'
BEGIN

    EXEC [VIC].[ViolationDL]
          @ActionType   = @parameter_01
        , @idaraID_FK   = @idaraID
        , @ActiveOnly   = 1;

END

-- =====================================================================
-- Route: Violation
-- =====================================================================
ELSE IF @pageName_ = 'Violation'
BEGIN

    EXEC VIC.ViolationDL
          @ActionType      = @parameter_01
        , @violationID     = @parameter_02
        , @chassisNumber   = @parameter_03
        , @violationTypeID = @parameter_04
        , @Paid            = @parameter_05
        , @FromDate        = @parameter_06
        , @ToDate          = @parameter_07
        , @Page            = @parameter_08
        , @PageSize        = @parameter_09
        , @idaraID_FK      = @idaraID;

END
--    -------------------------------------------------------------------
----                     PAGE: Violation_Get

-- =====================================================================
-- Route: Dashboard
-- =====================================================================
    ELSE IF @pageName_ = 'Dashboard'
    BEGIN
        EXEC [VIC].[DashboardDL]
              @ActionType          = N'VEHICLE_STATUS'
            , @idaraID_FK          = @idaraID
            , @onlyHasCustody      = @parameter_01
            , @onlyHasActiveInsurance = @parameter_02
            , @onlyHasDocExpiry    = @parameter_03
            , @onlyHasInsExpiry    = @parameter_04
            , @daysAhead           = @parameter_05;
    END

-- =====================================================================
-- Route: Dashboard_MaintenanceDue
-- =====================================================================
    ELSE IF @pageName_ = 'Dashboard_MaintenanceDue'
    BEGIN
        EXEC [VIC].[DashboardDL]
              @ActionType = N'MAINTENANCE_DUE'
            , @idaraID_FK = @idaraID
            , @daysAhead  = @parameter_01;
    END

-- =====================================================================
-- Route: Report_DocumentsExpiring
-- =====================================================================
    ELSE IF @pageName_ = 'Report_DocumentsExpiring'
    BEGIN
        EXEC [VIC].[ReportDL]
              @ActionType = N'DOCUMENTS_EXPIRING'
            , @idaraID_FK = @idaraID
            , @days       = @parameter_01;
    END

-- =====================================================================
-- Route: Report_InsuranceExpiring
-- =====================================================================
    ELSE IF @pageName_ = 'Report_InsuranceExpiring'
    BEGIN
        EXEC [VIC].[ReportDL]
              @ActionType    = N'INSURANCE_EXPIRING'
            , @idaraID_FK    = @idaraID
            , @days          = @parameter_01
            , @includeExpired = @parameter_02;
    END

-- =====================================================================
-- Route: Report_MaintenanceCostByVehicle
-- =====================================================================
    ELSE IF @pageName_ = 'Report_MaintenanceCostByVehicle'
    BEGIN
        EXEC [VIC].[ReportDL]
              @ActionType = N'MAINTENANCE_COST'
            , @idaraID_FK = @idaraID
            , @fromDate   = @parameter_01
            , @toDate     = @parameter_02;
    END

-- =====================================================================
-- Route: Report_UnpaidViolations
-- =====================================================================
    ELSE IF @pageName_ = 'Report_UnpaidViolations'
    BEGIN
        EXEC [VIC].[ReportDL]
              @ActionType = N'UNPAID_VIOLATIONS'
            , @idaraID_FK = @idaraID
            , @fromDate   = @parameter_01
            , @toDate     = @parameter_02;
    END

-- =====================================================================
-- Route: Report_VehiclesWithoutCustody
-- =====================================================================
    ELSE IF @pageName_ = 'Report_VehiclesWithoutCustody'
    BEGIN
        EXEC [VIC].[ReportDL]
              @ActionType       = N'VEHICLES_WITHOUT_CUSTODY'
            , @idaraID_FK       = @idaraID
            , @onlyActiveVehicles = @parameter_01;
    END

-- =====================================================================
-- Route: Report_VehicleTimeline
-- =====================================================================
    ELSE IF @pageName_ = 'Report_VehicleTimeline'
    BEGIN
        EXEC [VIC].[ReportDL]
              @ActionType   = N'VEHICLE_TIMELINE'
            , @vehicleID    = @parameter_01
            , @chassisNumber = @parameter_02;
    END

-- =====================================================================
-- Route: PeriodicMaintenance
-- =====================================================================
    ELSE IF @pageName_ = 'PeriodicMaintenance'
    BEGIN
        IF @parameter_01 = 'LIST_MONITORING'
        BEGIN
            EXEC [VIC].[MaintenanceDL]
                  @ActionType = @parameter_01
                , @idaraID_FK = @idaraID
                , @groupID    = @parameter_02;
        END
        ELSE IF @parameter_01 = 'LIST_HISTORY'
        BEGIN
            EXEC [VIC].[MaintenanceDL]
                  @ActionType = @parameter_01
                , @idaraID_FK = @idaraID
                , @pageNumber = @parameter_02
                , @pageSize   = @parameter_03;
        END
        ELSE IF @parameter_01 = 'LIST_GROUPS'
        BEGIN
            EXEC [VIC].[MaintenanceDL]
                  @ActionType = @parameter_01;
        END
        ELSE IF @parameter_01 = 'LIST_DETAILS'
        BEGIN
            EXEC [VIC].[MaintenanceDL]
                  @ActionType  = @parameter_01
                , @idaraID_FK  = @idaraID
                , @maintOrdID  = @parameter_02;
        END
        ELSE
        BEGIN
            EXEC [VIC].[MaintenanceDL]
                  @ActionType        = @parameter_01
                , @vehicleID         = @parameter_02
                , @idaraID_FK        = @idaraID
                , @maintOrdID        = @parameter_03
                , @maintOrdTypeID_FK = @parameter_04
                , @chassisNumber     = @parameter_05
                , @active            = @parameter_06
                , @fromDate          = @parameter_07
                , @toDate            = @parameter_08
                , @pageNumber        = @parameter_09
                , @pageSize          = @parameter_10
                , @maintDetailesID   = @parameter_11;
        END
    END

-- =====================================================================
-- Route: GeneralMaintenance
-- =====================================================================
    ELSE IF @pageName_ = 'GeneralMaintenance'
    BEGIN
        IF @parameter_01 = 'LIST_FAULTS'
        BEGIN
            EXEC [VIC].[MaintenanceDL]
                  @ActionType  = @parameter_01
                , @idaraID_FK  = @idaraID
                , @maintOrdID  = @parameter_02;
        END



        ELSE
        BEGIN
            EXEC [VIC].[MaintenanceDL]
                  @ActionType        = @parameter_01
                , @vehicleID         = @parameter_02
                , @idaraID_FK        = @idaraID
                , @maintOrdID        = @parameter_03
                , @maintOrdTypeID_FK = @parameter_04
                , @chassisNumber     = @parameter_05
                , @active            = @parameter_06
                , @fromDate          = @parameter_07
                , @toDate            = @parameter_08
                , @pageNumber        = @parameter_09
                , @pageSize          = @parameter_10
                , @maintDetailesID   = @parameter_11;
        END
    END

-- =====================================================================
-- Route: MaintenanceReport
-- =====================================================================
    ELSE IF @pageName_ = N'MaintenanceReport'
    BEGIN
        EXEC [VIC].[MaintenanceDL]
              @ActionType        = @parameter_01
            , @vehicleID         = @parameter_02
            , @idaraID_FK        = @idaraID
            , @maintOrdID        = @parameter_03
            , @maintOrdTypeID_FK = @parameter_04
            , @chassisNumber     = @parameter_05
            , @active            = @parameter_06
            , @fromDate          = @parameter_07
            , @toDate            = @parameter_08
            , @pageNumber        = @parameter_09
            , @pageSize          = @parameter_10
            , @maintDetailesID   = @parameter_11;
    END

-- =====================================================================
-- Route: PeriodicMaintenancePlan
-- =====================================================================
    ELSE IF @pageName_ = 'PeriodicMaintenancePlan'
    BEGIN
        EXEC [VIC].[MaintenancePlanDL]
              @ActionType        = @parameter_01
            , @vehicleID         = @parameter_02
            , @idaraID_FK        = @idaraID
            , @planID            = @parameter_03
            , @chassisNumber     = @parameter_04
            , @active            = @parameter_05
            , @pageNumber        = @parameter_06
            , @pageSize          = @parameter_07
            , @maintOrdTypeID_FK = @parameter_08;
    END

