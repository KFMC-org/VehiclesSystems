/* VIC tables extracted read-only from DATACORE on 2026-11-12. Definitions only; no data. */
SET NOCOUNT ON;
GO

-- ============================================================
-- Table: [VIC].[_DebugDetailJson]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[_DebugDetailJson](
	[CapturedAt] [datetime2](7) NOT NULL,
	[ActionType] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaintOrdID] [int] NULL,
	[RawJson] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[GeneralMaintenanceFault]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[GeneralMaintenanceFault](
	[FaultID] [int] IDENTITY(1,1) NOT NULL,
	[MaintOrdID_FK] [int] NOT NULL,
	[LineNo] [int] NOT NULL,
	[FaultDescription] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CorrectiveAction] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Active] [bit] NULL,
	[entryDate] [datetime] NULL,
	[entryData] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[HandoverType]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[HandoverType](
	[handOverTypeID] [int] IDENTITY(1,1) NOT NULL,
	[handOverTypeName_A] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[handOverTypeName_E] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[active] [bit] NULL,
	[entryDate] [datetime] NOT NULL,
	[entryData] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[MaintenanceDetails]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[MaintenanceDetails](
	[MaintDetailesID] [int] IDENTITY(1,1) NOT NULL,
	[MaintOrdID_FK] [int] NULL,
	[typesID_FK] [int] NULL,
	[SupportID_FK] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CheckStatus_FK] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ActionState] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CorrectiveAction] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FSN] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaintLevel] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CurrentDate] [datetime] NULL,
	[Notes] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[entryDate] [datetime] NULL,
	[entryData] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaintDetailActive] [bit] NOT NULL
)

GO

-- ============================================================
-- Table: [VIC].[MaintenanceGroup]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[MaintenanceGroup](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupCode] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[GroupName_A] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[GroupActive] [bit] NOT NULL
)

GO

-- ============================================================
-- Table: [VIC].[MaintenanceGroupPeriod]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[MaintenanceGroupPeriod](
	[PeriodID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID_FK] [int] NOT NULL,
	[MonthNumber] [tinyint] NOT NULL
)

GO

-- ============================================================
-- Table: [VIC].[MaintenanceTemplate]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[MaintenanceTemplate](
	[TemplateID] [int] IDENTITY(1,1) NOT NULL,
	[MaintOrdTypeID_FK] [int] NOT NULL,
	[typesID_FK] [int] NOT NULL,
	[TemplateOrder] [int] NOT NULL,
	[templateActive] [bit] NOT NULL,
	[entryDate] [datetime] NOT NULL,
	[entryData] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[TypesRoot]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[TypesRoot](
	[typesID] [int] IDENTITY(1,1) NOT NULL,
	[typesName_A] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[typesName_E] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[typesDesc] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[typesActive] [bit] NULL,
	[typesStartDate] [datetime] NULL,
	[typesEndDate] [datetime] NULL,
	[typesRoot_ParentID] [int] NULL,
	[entryDate] [datetime] NULL,
	[entryData] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleDetailesExchang]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleDetailesExchang](
	[VehicleDetailesExchangID] [int] IDENTITY(1,1) NOT NULL,
	[VehicleHandoverID_FK] [int] NULL,
	[DetailesNote] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[entryDate] [datetime] NULL,
	[entryData] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[vehicleDocument]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[vehicleDocument](
	[vehicleDocumentID] [int] IDENTITY(1,1) NOT NULL,
	[vehicleDocumentTypeID_FK] [int] NULL,
	[chassisNumber_FK] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[vehicleDocumentNo] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[vehicleDocumentStartDate] [datetime] NULL,
	[vehicleDocumentEndDate] [datetime] NULL,
	[entryDate] [datetime] NULL,
	[entryData] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IdaraID_FK] [bigint] NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleGender]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleGender](
	[genderID] [int] IDENTITY(1,1) NOT NULL,
	[genderName_A] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[genderName_E] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[genderDescription] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleHandover]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleHandover](
	[VehicleHandoverID] [int] IDENTITY(1,1) NOT NULL,
	[handOverTypeID_FK] [int] NULL,
	[handoverDate] [datetime] NULL,
	[note] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[entryDate] [datetime] NULL,
	[entryData] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[chassisNumber_FK] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IdaraID_FK] [bigint] NULL,
	[vehicleID_FK] [int] NULL,
	[vehicleUserID_FK] [int] NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleInsurance]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleInsurance](
	[VehicleInsuranceID] [int] IDENTITY(1,1) NOT NULL,
	[InsuranceOpertionType_FK] [int] NULL,
	[InsuranceTypeID_FK] [int] NULL,
	[chassisNumber_FK] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Source] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StartInsurance] [datetime] NULL,
	[EndInsurance] [datetime] NULL,
	[Amount] [decimal](18, 2) NULL,
	[Note] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[active] [bit] NULL,
	[entryDate] [datetime] NULL,
	[entryData] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IdaraID_FK] [bigint] NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleMaintenance]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleMaintenance](
	[MaintOrdID] [int] IDENTITY(1,1) NOT NULL,
	[MaintOrdTypeID_FK] [int] NULL,
	[chassisNumber_FK] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaintOrdStartDate] [datetime] NULL,
	[MaintOrdEndDate] [datetime] NULL,
	[MaintOrdDesc] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaintOrdActive] [bit] NULL,
	[entryDate] [datetime] NULL,
	[entryData] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IdaraID_FK] [bigint] NULL,
	[odometer] [int] NULL,
	[jobOrderNumber]  AS (((case [MaintOrdTypeID_FK] when (265) then N'P' when (266) then N'G' else N'X' end+right(CONVERT([nvarchar](4),datepart(year,[entryDate])),(2)))+right(N'0'+CONVERT([nvarchar](2),datepart(month,[entryDate])),(2)))+right(N'00000000'+CONVERT([nvarchar](8),[MaintOrdID]),(8))) PERSISTED,
	[closeNote] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[workshopIDs] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Cancelled] [bit] NOT NULL,
	[CancelReason] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CancelDate] [datetime] NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleMaintenanceGroup]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleMaintenanceGroup](
	[RecID] [int] IDENTITY(1,1) NOT NULL,
	[chassisNumber_FK] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[GroupID_FK] [int] NOT NULL,
	[IdaraID_FK] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Active] [bit] NOT NULL,
	[AssignedDate] [datetime] NOT NULL,
	[AssignedBy] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleMaintenancePlan]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleMaintenancePlan](
	[PlanID] [int] IDENTITY(1,1) NOT NULL,
	[chassisNumber_FK] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[periodMonths] [int] NOT NULL,
	[nextDueDate] [datetime] NOT NULL,
	[planActive] [bit] NOT NULL,
	[IdaraID_FK] [bigint] NULL,
	[entryDate] [datetime] NOT NULL,
	[entryData] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleNationality]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleNationality](
	[nationalityID] [int] IDENTITY(1,1) NOT NULL,
	[nationalityName_A] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[nationalityName_E] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[nationalityDescription] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[nationalityActive] [bit] NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleRank]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleRank](
	[rankID] [int] IDENTITY(1,1) NOT NULL,
	[rankName_A] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[rankName_E] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[rankActive] [bit] NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleRegistration]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleRegistration](
	[ID] [int] NOT NULL,
	[VehicleCode] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VehicleType] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ArmyNumber] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Note] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[entryDate] [datetime] NULL,
	[entryData] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleRequest]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleRequest](
	[RequestID] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeUserID_FK] [bigint] NOT NULL,
	[DeptID_FK] [int] NOT NULL,
	[RequestTypeID_FK] [int] NULL,
	[NeedFromDate] [datetime] NULL,
	[NeedToDate] [datetime] NULL,
	[Purpose] [nvarchar](600) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Notes] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Active] [bit] NOT NULL,
	[DeptDecisionBy] [bigint] NULL,
	[DeptDecisionDate] [datetime] NULL,
	[DeptDecisionNote] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FleetDecisionBy] [bigint] NULL,
	[FleetDecisionDate] [datetime] NULL,
	[FleetDecisionNote] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AssignedChassisNumber] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AssignedCustodyID] [bigint] NULL,
	[AssignedDate] [datetime] NULL,
	[IdaraID_FK] [bigint] NULL,
	[entryDate] [datetime] NOT NULL,
	[entryData] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleRequestHistory]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleRequestHistory](
	[HistoryID] [bigint] IDENTITY(1,1) NOT NULL,
	[RequestID_FK] [bigint] NOT NULL,
	[Status] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ActionBy] [bigint] NULL,
	[ActionDate] [datetime] NOT NULL,
	[Notes] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[entryDate] [datetime] NOT NULL,
	[entryData] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[Vehicles]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[Vehicles](
	[vehicleID] [int] IDENTITY(1,1) NOT NULL,
	[ownerID_FK] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ManufacturerNameID_FK] [int] NULL,
	[vehicleModelID_FK] [int] NULL,
	[vehicleClassID_FK] [int] NULL,
	[TypeOfUseID_FK] [int] NULL,
	[vehicleColorID_FK] [int] NULL,
	[countryMadeID_FK] [int] NULL,
	[regstritionTypeID_FK] [int] NULL,
	[regionID_FK] [int] NULL,
	[fuelTypeID_FK] [int] NULL,
	[vehicleTypeID_FK] [int] NULL,
	[yearModel] [int] NULL,
	[capacity] [int] NULL,
	[chassisNumber] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[serialNumber] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[plateLetters] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[plateNumbers] [int] NULL,
	[armyNumber] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[vehicleNote] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[entryDate] [datetime] NULL,
	[entryData] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[isActive] [bit] NOT NULL,
	[IdaraID_FK] [bigint] NOT NULL,
	[vehicleStatusID_FK] [int] NULL,
	[scrapDate] [datetime] NULL,
	[scrapRefNo] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[scrapReason] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[scrapNote] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleScrap]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleScrap](
	[ScrapID] [bigint] IDENTITY(1,1) NOT NULL,
	[chassisNumber_FK] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IdaraID_FK] [bigint] NULL,
	[ScrapDate] [datetime] NULL,
	[ScrapTypeID_FK] [int] NULL,
	[RefNo] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Reason] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Note] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ApprovedByUserID] [bigint] NULL,
	[ApprovedDate] [datetime] NULL,
	[Status] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[entryDate] [datetime] NULL,
	[entryData] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Notes] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehiclesDocumentType]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehiclesDocumentType](
	[vehicleDocumentTypeID] [int] IDENTITY(1,1) NOT NULL,
	[vehicleDocumentTypeName_A] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[vehicleDocumentTypeName_E] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[vehicleDocumentTypeActive] [bit] NULL,
	[entryDate] [datetime] NOT NULL,
	[entryData] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleTransferRequest]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleTransferRequest](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[RequestTypeID_FK] [int] NULL,
	[chassisNumber_FK] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fromUserID_FK] [bigint] NULL,
	[toUserID_FK] [bigint] NULL,
	[deptID_FK] [int] NULL,
	[CreateByUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[aproveNote] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[active] [bit] NULL,
	[entryDate] [datetime] NULL,
	[entryData] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IdaraID_FK] [bigint] NULL,
	[vehicleID_FK] [int] NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleTransferRequestHistory]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleTransferRequestHistory](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[RequestID_FK] [int] NOT NULL,
	[Status] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ActionBy] [int] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[Notes] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[entryDate] [datetime] NOT NULL,
	[entryData] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleTransferRequestType]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleTransferRequestType](
	[VehicleTransferRequestTypeID] [int] IDENTITY(1,1) NOT NULL,
	[VehicleTransferRequestTypeNameA] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VehicleTransferRequestTypeNameE] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Active] [bit] NULL,
	[entryDate] [datetime] NOT NULL,
	[entryData] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleUser]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleUser](
	[vehicleUserID] [int] IDENTITY(1,1) NOT NULL,
	[generalNo] [bigint] NULL,
	[nationalID] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mobileNo] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IdaraID_FK] [bigint] NOT NULL,
	[userActive] [bit] NOT NULL,
	[entryDate] [datetime] NOT NULL,
	[entryData] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[VehicleUserDetails]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[VehicleUserDetails](
	[vehicleUserDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[vehicleUserID_FK] [int] NOT NULL,
	[generalNo_Snapshot] [bigint] NULL,
	[rankID_FK] [int] NULL,
	[nationalityID_FK] [int] NULL,
	[genderID_FK] [int] NULL,
	[firstName_A] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[secondName_A] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[thirdName_A] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[lastName_A] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[firstName_E] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[secondName_E] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[thirdName_E] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[lastName_E] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[note] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[detailsStartDate] [datetime] NULL,
	[detailsEndDate] [datetime] NULL,
	[detailsActive] [bit] NOT NULL,
	[IdaraID_FK] [bigint] NULL,
	[entryDate] [datetime] NOT NULL,
	[entryData] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[vehicleWithUsers]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[vehicleWithUsers](
	[vehicleWithUsersID] [int] IDENTITY(1,1) NOT NULL,
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL,
	[note] [nvarchar](1002) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[entryDate] [datetime] NULL,
	[entryData] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hostName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[chassisNumber_FK] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GeneralNo_Snapshot] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UserFullName_Snapshot] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeptID_Snapshot] [int] NULL,
	[DeptName_Snapshot] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SectionID_Snapshot] [int] NULL,
	[SectionName_Snapshot] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrgSnapshotDate] [datetime] NULL,
	[DSDID_Snapshot] [int] NULL,
	[OrganizationID_Snapshot] [int] NULL,
	[OrganizationName_Snap] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IdaraID_Snapshot] [int] NULL,
	[IdaraName_Snap] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DivisonID_Snapshot] [int] NULL,
	[DivisonName_Snap] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[vehicleUserID_FK] [int] NULL,
	[vehicleID_FK] [int] NULL,
	[RankName_Snapshot] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MilitaryUnitName_Snapshot] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

-- ============================================================
-- Table: [VIC].[Violations]
-- ============================================================
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [VIC].[Violations](
	[violationID] [int] IDENTITY(1,1) NOT NULL,
	[violationTypeRoot_FK] [int] NULL,
	[chassisNumber_FK] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[violationDate] [date] NULL,
	[violationPrice] [decimal](18, 2) NULL,
	[violationLocation] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PaymentDate] [datetime] NULL,
	[entryPayment] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[entrydata] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[entrydate] [datetime] NULL,
	[hostname] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IdaraID_FK] [bigint] NULL
)

GO
