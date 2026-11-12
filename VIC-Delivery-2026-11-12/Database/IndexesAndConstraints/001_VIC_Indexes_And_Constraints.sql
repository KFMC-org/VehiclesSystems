/* VIC indexes and constraints extracted read-only from DATACORE on 2026-11-12. */
SET NOCOUNT ON;
GO

-- Default: [DF___DebugDet__Captu__5A90F20B] on [VIC].[_DebugDetailJson].[CapturedAt]
ALTER TABLE [VIC].[_DebugDetailJson] ADD  DEFAULT (sysutcdatetime()) FOR [CapturedAt]
GO

-- Default: [DF__GeneralMa__Activ__14F29DCA] on [VIC].[GeneralMaintenanceFault].[Active]
ALTER TABLE [VIC].[GeneralMaintenanceFault] ADD  DEFAULT ((1)) FOR [Active]
GO

-- Default: [DF__GeneralMa__entry__15E6C203] on [VIC].[GeneralMaintenanceFault].[entryDate]
ALTER TABLE [VIC].[GeneralMaintenanceFault] ADD  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_HandoverType_ed] on [VIC].[HandoverType].[entryDate]
ALTER TABLE [VIC].[HandoverType] ADD  CONSTRAINT [DF_HandoverType_ed]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_MaintenanceDetails_New_MaintDetailActive] on [VIC].[MaintenanceDetails].[MaintDetailActive]
ALTER TABLE [VIC].[MaintenanceDetails] ADD  CONSTRAINT [DF_MaintenanceDetails_New_MaintDetailActive]  DEFAULT ((1)) FOR [MaintDetailActive]
GO

-- Default: [DF__Maintenan__Group__644F666F] on [VIC].[MaintenanceGroup].[GroupActive]
ALTER TABLE [VIC].[MaintenanceGroup] ADD  DEFAULT ((1)) FOR [GroupActive]
GO

-- Check: [CK__Maintenan__Month__69141B8C] on [VIC].[MaintenanceGroupPeriod]
ALTER TABLE [VIC].[MaintenanceGroupPeriod]  WITH CHECK ADD CHECK  (([MonthNumber]>=(1) AND [MonthNumber]<=(12)))
GO

-- Default: [DF_MaintenanceTemplate_entryDate] on [VIC].[MaintenanceTemplate].[entryDate]
ALTER TABLE [VIC].[MaintenanceTemplate] ADD  CONSTRAINT [DF_MaintenanceTemplate_entryDate]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_MaintenanceTemplate_templateActive] on [VIC].[MaintenanceTemplate].[templateActive]
ALTER TABLE [VIC].[MaintenanceTemplate] ADD  CONSTRAINT [DF_MaintenanceTemplate_templateActive]  DEFAULT ((1)) FOR [templateActive]
GO

-- Default: [DF_MaintenanceTemplate_TemplateOrder] on [VIC].[MaintenanceTemplate].[TemplateOrder]
ALTER TABLE [VIC].[MaintenanceTemplate] ADD  CONSTRAINT [DF_MaintenanceTemplate_TemplateOrder]  DEFAULT ((1)) FOR [TemplateOrder]
GO

-- Default: [DF_TypesRoot_entryDate] on [VIC].[TypesRoot].[entryDate]
ALTER TABLE [VIC].[TypesRoot] ADD  CONSTRAINT [DF_TypesRoot_entryDate]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_VehicleDetailesExchang_entryDate] on [VIC].[VehicleDetailesExchang].[entryDate]
ALTER TABLE [VIC].[VehicleDetailesExchang] ADD  CONSTRAINT [DF_VehicleDetailesExchang_entryDate]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_vehicleDocument_entryDate] on [VIC].[vehicleDocument].[entryDate]
ALTER TABLE [VIC].[vehicleDocument] ADD  CONSTRAINT [DF_vehicleDocument_entryDate]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Check: [CK_vehicleDocument_DateRange] on [VIC].[vehicleDocument]
ALTER TABLE [VIC].[vehicleDocument]  WITH CHECK ADD  CONSTRAINT [CK_vehicleDocument_DateRange] CHECK  (([vehicleDocumentStartDate] IS NULL OR [vehicleDocumentEndDate] IS NULL OR [vehicleDocumentStartDate]<=[vehicleDocumentEndDate]))
ALTER TABLE [VIC].[vehicleDocument] CHECK CONSTRAINT [CK_vehicleDocument_DateRange]
GO

-- Default: [DF_VehicleHandover_entryDate] on [VIC].[VehicleHandover].[entryDate]
ALTER TABLE [VIC].[VehicleHandover] ADD  CONSTRAINT [DF_VehicleHandover_entryDate]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_VehicleInsurance_entryDate] on [VIC].[VehicleInsurance].[entryDate]
ALTER TABLE [VIC].[VehicleInsurance] ADD  CONSTRAINT [DF_VehicleInsurance_entryDate]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Check: [CK_VehicleInsurance_DateRange] on [VIC].[VehicleInsurance]
ALTER TABLE [VIC].[VehicleInsurance]  WITH CHECK ADD  CONSTRAINT [CK_VehicleInsurance_DateRange] CHECK  (([StartInsurance] IS NULL OR [EndInsurance] IS NULL OR [StartInsurance]<=[EndInsurance]))
ALTER TABLE [VIC].[VehicleInsurance] CHECK CONSTRAINT [CK_VehicleInsurance_DateRange]
GO

-- Default: [DF__VehicleMa__Cance__69D3359B] on [VIC].[VehicleMaintenance].[Cancelled]
ALTER TABLE [VIC].[VehicleMaintenance] ADD  DEFAULT ((0)) FOR [Cancelled]
GO

-- Default: [DF_VehicleMaintenance_entryDate] on [VIC].[VehicleMaintenance].[entryDate]
ALTER TABLE [VIC].[VehicleMaintenance] ADD  CONSTRAINT [DF_VehicleMaintenance_entryDate]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Check: [CK_VehicleMaintenance_DateRange] on [VIC].[VehicleMaintenance]
ALTER TABLE [VIC].[VehicleMaintenance]  WITH CHECK ADD  CONSTRAINT [CK_VehicleMaintenance_DateRange] CHECK  (([MaintOrdStartDate] IS NULL OR [MaintOrdEndDate] IS NULL OR [MaintOrdStartDate]<=[MaintOrdEndDate]))
ALTER TABLE [VIC].[VehicleMaintenance] CHECK CONSTRAINT [CK_VehicleMaintenance_DateRange]
GO

-- Default: [DF__VehicleMa__Activ__6DD8D0A9] on [VIC].[VehicleMaintenanceGroup].[Active]
ALTER TABLE [VIC].[VehicleMaintenanceGroup] ADD  DEFAULT ((1)) FOR [Active]
GO

-- Default: [DF__VehicleMa__Assig__6FC1191B] on [VIC].[VehicleMaintenanceGroup].[AssignedBy]
ALTER TABLE [VIC].[VehicleMaintenanceGroup] ADD  DEFAULT (suser_sname()) FOR [AssignedBy]
GO

-- Default: [DF__VehicleMa__Assig__6ECCF4E2] on [VIC].[VehicleMaintenanceGroup].[AssignedDate]
ALTER TABLE [VIC].[VehicleMaintenanceGroup] ADD  DEFAULT (getdate()) FOR [AssignedDate]
GO

-- Default: [DF_VehicleMaintenancePlan_entryDate] on [VIC].[VehicleMaintenancePlan].[entryDate]
ALTER TABLE [VIC].[VehicleMaintenancePlan] ADD  CONSTRAINT [DF_VehicleMaintenancePlan_entryDate]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_VehicleMaintenancePlan_planActive] on [VIC].[VehicleMaintenancePlan].[planActive]
ALTER TABLE [VIC].[VehicleMaintenancePlan] ADD  CONSTRAINT [DF_VehicleMaintenancePlan_planActive]  DEFAULT ((1)) FOR [planActive]
GO

-- Check: [CK_VehicleMaintenancePlan_PeriodMonths] on [VIC].[VehicleMaintenancePlan]
ALTER TABLE [VIC].[VehicleMaintenancePlan]  WITH CHECK ADD  CONSTRAINT [CK_VehicleMaintenancePlan_PeriodMonths] CHECK  (([periodMonths]>(0)))
ALTER TABLE [VIC].[VehicleMaintenancePlan] CHECK CONSTRAINT [CK_VehicleMaintenancePlan_PeriodMonths]
GO

-- Default: [DF_VehicleRequest_Active] on [VIC].[VehicleRequest].[Active]
ALTER TABLE [VIC].[VehicleRequest] ADD  CONSTRAINT [DF_VehicleRequest_Active]  DEFAULT ((1)) FOR [Active]
GO

-- Default: [DF_VehicleRequest_entryDate] on [VIC].[VehicleRequest].[entryDate]
ALTER TABLE [VIC].[VehicleRequest] ADD  CONSTRAINT [DF_VehicleRequest_entryDate]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_VehicleRequestHistory_ActionDate] on [VIC].[VehicleRequestHistory].[ActionDate]
ALTER TABLE [VIC].[VehicleRequestHistory] ADD  CONSTRAINT [DF_VehicleRequestHistory_ActionDate]  DEFAULT (getdate()) FOR [ActionDate]
GO

-- Default: [DF_VehicleRequestHistory_entryDate] on [VIC].[VehicleRequestHistory].[entryDate]
ALTER TABLE [VIC].[VehicleRequestHistory] ADD  CONSTRAINT [DF_VehicleRequestHistory_entryDate]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_Vehicles_entryDate] on [VIC].[Vehicles].[entryDate]
ALTER TABLE [VIC].[Vehicles] ADD  CONSTRAINT [DF_Vehicles_entryDate]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_Vehicles_isActive] on [VIC].[Vehicles].[isActive]
ALTER TABLE [VIC].[Vehicles] ADD  CONSTRAINT [DF_Vehicles_isActive]  DEFAULT ((1)) FOR [isActive]
GO

-- Check: [CK_VehicleScrap_Status] on [VIC].[VehicleScrap]
ALTER TABLE [VIC].[VehicleScrap]  WITH CHECK ADD  CONSTRAINT [CK_VehicleScrap_Status] CHECK  (([Status]=N'Cancelled' OR [Status]=N'Approved' OR [Status]=N'Draft'))
ALTER TABLE [VIC].[VehicleScrap] CHECK CONSTRAINT [CK_VehicleScrap_Status]
GO

-- Default: [DF_VehiclesDocumentType_ed] on [VIC].[VehiclesDocumentType].[entryDate]
ALTER TABLE [VIC].[VehiclesDocumentType] ADD  CONSTRAINT [DF_VehiclesDocumentType_ed]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_VehicleTransferRequest_entryDate] on [VIC].[VehicleTransferRequest].[entryDate]
ALTER TABLE [VIC].[VehicleTransferRequest] ADD  CONSTRAINT [DF_VehicleTransferRequest_entryDate]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF__VehicleTr__Actio__5C2434C2] on [VIC].[VehicleTransferRequestHistory].[ActionDate]
ALTER TABLE [VIC].[VehicleTransferRequestHistory] ADD  DEFAULT (getdate()) FOR [ActionDate]
GO

-- Default: [DF_VehicleTransferRequestHistory_ed] on [VIC].[VehicleTransferRequestHistory].[entryDate]
ALTER TABLE [VIC].[VehicleTransferRequestHistory] ADD  CONSTRAINT [DF_VehicleTransferRequestHistory_ed]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_VehicleTransferRequestType_ed] on [VIC].[VehicleTransferRequestType].[entryDate]
ALTER TABLE [VIC].[VehicleTransferRequestType] ADD  CONSTRAINT [DF_VehicleTransferRequestType_ed]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF__VehicleUs__entry__401205F9] on [VIC].[VehicleUser].[entryDate]
ALTER TABLE [VIC].[VehicleUser] ADD  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF__VehicleUs__userA__3F1DE1C0] on [VIC].[VehicleUser].[userActive]
ALTER TABLE [VIC].[VehicleUser] ADD  DEFAULT ((1)) FOR [userActive]
GO

-- Default: [DF__VehicleUs__detai__42EE72A4] on [VIC].[VehicleUserDetails].[detailsActive]
ALTER TABLE [VIC].[VehicleUserDetails] ADD  DEFAULT ((1)) FOR [detailsActive]
GO

-- Default: [DF__VehicleUs__entry__43E296DD] on [VIC].[VehicleUserDetails].[entryDate]
ALTER TABLE [VIC].[VehicleUserDetails] ADD  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_vehicleWithUsers_entryDate] on [VIC].[vehicleWithUsers].[entryDate]
ALTER TABLE [VIC].[vehicleWithUsers] ADD  CONSTRAINT [DF_vehicleWithUsers_entryDate]  DEFAULT (getdate()) FOR [entryDate]
GO

-- Default: [DF_vehicleWithUsers_OrgSnapshotDate] on [VIC].[vehicleWithUsers].[OrgSnapshotDate]
ALTER TABLE [VIC].[vehicleWithUsers] ADD  CONSTRAINT [DF_vehicleWithUsers_OrgSnapshotDate]  DEFAULT (getdate()) FOR [OrgSnapshotDate]
GO

-- Default: [DF_Violations_entrydate] on [VIC].[Violations].[entrydate]
ALTER TABLE [VIC].[Violations] ADD  CONSTRAINT [DF_Violations_entrydate]  DEFAULT (getdate()) FOR [entrydate]
GO

-- Index/Key: [PK__GeneralM__2C2940D39D44A2EC] on [VIC].[GeneralMaintenanceFault]
ALTER TABLE [VIC].[GeneralMaintenanceFault] ADD PRIMARY KEY CLUSTERED 
(
	[FaultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_HandoverType] on [VIC].[HandoverType]
ALTER TABLE [VIC].[HandoverType] ADD  CONSTRAINT [PK_HandoverType] PRIMARY KEY CLUSTERED 
(
	[handOverTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [IX_MaintenanceDetails_New_MaintOrdID] on [VIC].[MaintenanceDetails]
CREATE NONCLUSTERED INDEX [IX_MaintenanceDetails_New_MaintOrdID] ON [VIC].[MaintenanceDetails]
(
	[MaintOrdID_FK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_MaintenanceDetails_New] on [VIC].[MaintenanceDetails]
ALTER TABLE [VIC].[MaintenanceDetails] ADD  CONSTRAINT [PK_MaintenanceDetails_New] PRIMARY KEY CLUSTERED 
(
	[MaintDetailesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK__Maintena__149AF30A8712A6F7] on [VIC].[MaintenanceGroup]
ALTER TABLE [VIC].[MaintenanceGroup] ADD PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK__Maintena__E521BB3679CC1CEE] on [VIC].[MaintenanceGroupPeriod]
ALTER TABLE [VIC].[MaintenanceGroupPeriod] ADD PRIMARY KEY CLUSTERED 
(
	[PeriodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [UQ_GroupPeriod] on [VIC].[MaintenanceGroupPeriod]
ALTER TABLE [VIC].[MaintenanceGroupPeriod] ADD  CONSTRAINT [UQ_GroupPeriod] UNIQUE NONCLUSTERED 
(
	[GroupID_FK] ASC,
	[MonthNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_MaintenanceTemplate] on [VIC].[MaintenanceTemplate]
ALTER TABLE [VIC].[MaintenanceTemplate] ADD  CONSTRAINT [PK_MaintenanceTemplate] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_TypesRoot] on [VIC].[TypesRoot]
ALTER TABLE [VIC].[TypesRoot] ADD  CONSTRAINT [PK_TypesRoot] PRIMARY KEY CLUSTERED 
(
	[typesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleDetailesExchang] on [VIC].[VehicleDetailesExchang]
ALTER TABLE [VIC].[VehicleDetailesExchang] ADD  CONSTRAINT [PK_VehicleDetailesExchang] PRIMARY KEY CLUSTERED 
(
	[VehicleDetailesExchangID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_vehicleDocument] on [VIC].[vehicleDocument]
ALTER TABLE [VIC].[vehicleDocument] ADD  CONSTRAINT [PK_vehicleDocument] PRIMARY KEY CLUSTERED 
(
	[vehicleDocumentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleGender] on [VIC].[VehicleGender]
ALTER TABLE [VIC].[VehicleGender] ADD  CONSTRAINT [PK_VehicleGender] PRIMARY KEY CLUSTERED 
(
	[genderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [IX_VehicleHandover_chassis] on [VIC].[VehicleHandover]
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [IX_VehicleHandover_chassis] ON [VIC].[VehicleHandover]
(
	[chassisNumber_FK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [IX_VehicleHandover_vehicleID] on [VIC].[VehicleHandover]
CREATE NONCLUSTERED INDEX [IX_VehicleHandover_vehicleID] ON [VIC].[VehicleHandover]
(
	[vehicleID_FK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleHandover] on [VIC].[VehicleHandover]
ALTER TABLE [VIC].[VehicleHandover] ADD  CONSTRAINT [PK_VehicleHandover] PRIMARY KEY CLUSTERED 
(
	[VehicleHandoverID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleInsurance] on [VIC].[VehicleInsurance]
ALTER TABLE [VIC].[VehicleInsurance] ADD  CONSTRAINT [PK_VehicleInsurance] PRIMARY KEY CLUSTERED 
(
	[VehicleInsuranceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleMaintenance] on [VIC].[VehicleMaintenance]
ALTER TABLE [VIC].[VehicleMaintenance] ADD  CONSTRAINT [PK_VehicleMaintenance] PRIMARY KEY CLUSTERED 
(
	[MaintOrdID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK__VehicleM__360414FF4D6693D9] on [VIC].[VehicleMaintenanceGroup]
ALTER TABLE [VIC].[VehicleMaintenanceGroup] ADD PRIMARY KEY CLUSTERED 
(
	[RecID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [UQ_VehicleGroup] on [VIC].[VehicleMaintenanceGroup]
SET ANSI_PADDING ON

ALTER TABLE [VIC].[VehicleMaintenanceGroup] ADD  CONSTRAINT [UQ_VehicleGroup] UNIQUE NONCLUSTERED 
(
	[chassisNumber_FK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleMaintenancePlan] on [VIC].[VehicleMaintenancePlan]
ALTER TABLE [VIC].[VehicleMaintenancePlan] ADD  CONSTRAINT [PK_VehicleMaintenancePlan] PRIMARY KEY CLUSTERED 
(
	[PlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleNationality] on [VIC].[VehicleNationality]
ALTER TABLE [VIC].[VehicleNationality] ADD  CONSTRAINT [PK_VehicleNationality] PRIMARY KEY CLUSTERED 
(
	[nationalityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleRank] on [VIC].[VehicleRank]
ALTER TABLE [VIC].[VehicleRank] ADD  CONSTRAINT [PK_VehicleRank] PRIMARY KEY CLUSTERED 
(
	[rankID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleRegistration] on [VIC].[VehicleRegistration]
ALTER TABLE [VIC].[VehicleRegistration] ADD  CONSTRAINT [PK_VehicleRegistration] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleRequest] on [VIC].[VehicleRequest]
ALTER TABLE [VIC].[VehicleRequest] ADD  CONSTRAINT [PK_VehicleRequest] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleRequestHistory] on [VIC].[VehicleRequestHistory]
ALTER TABLE [VIC].[VehicleRequestHistory] ADD  CONSTRAINT [PK_VehicleRequestHistory] PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_Vehicles] on [VIC].[Vehicles]
SET ANSI_PADDING ON

ALTER TABLE [VIC].[Vehicles] ADD  CONSTRAINT [PK_Vehicles] PRIMARY KEY CLUSTERED 
(
	[chassisNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleScrap] on [VIC].[VehicleScrap]
ALTER TABLE [VIC].[VehicleScrap] ADD  CONSTRAINT [PK_VehicleScrap] PRIMARY KEY CLUSTERED 
(
	[ScrapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehiclesDocumentType] on [VIC].[VehiclesDocumentType]
ALTER TABLE [VIC].[VehiclesDocumentType] ADD  CONSTRAINT [PK_VehiclesDocumentType] PRIMARY KEY CLUSTERED 
(
	[vehicleDocumentTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleTransferRequest] on [VIC].[VehicleTransferRequest]
ALTER TABLE [VIC].[VehicleTransferRequest] ADD  CONSTRAINT [PK_VehicleTransferRequest] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK__VehicleT__4D7B4ADDBCF668C6] on [VIC].[VehicleTransferRequestHistory]
ALTER TABLE [VIC].[VehicleTransferRequestHistory] ADD PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleTransferRequestType] on [VIC].[VehicleTransferRequestType]
ALTER TABLE [VIC].[VehicleTransferRequestType] ADD  CONSTRAINT [PK_VehicleTransferRequestType] PRIMARY KEY CLUSTERED 
(
	[VehicleTransferRequestTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [IX_VehicleUser_Idara] on [VIC].[VehicleUser]
CREATE NONCLUSTERED INDEX [IX_VehicleUser_Idara] ON [VIC].[VehicleUser]
(
	[IdaraID_FK] ASC,
	[userActive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [IX_VehicleUser_NationalID] on [VIC].[VehicleUser]
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [IX_VehicleUser_NationalID] ON [VIC].[VehicleUser]
(
	[nationalID] ASC
)
WHERE ([nationalID] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleUser] on [VIC].[VehicleUser]
ALTER TABLE [VIC].[VehicleUser] ADD  CONSTRAINT [PK_VehicleUser] PRIMARY KEY CLUSTERED 
(
	[vehicleUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [UX_VehicleUser_GeneralNo] on [VIC].[VehicleUser]
CREATE UNIQUE NONCLUSTERED INDEX [UX_VehicleUser_GeneralNo] ON [VIC].[VehicleUser]
(
	[generalNo] ASC
)
WHERE ([generalNo] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [IX_VUD_User] on [VIC].[VehicleUserDetails]
CREATE NONCLUSTERED INDEX [IX_VUD_User] ON [VIC].[VehicleUserDetails]
(
	[vehicleUserID_FK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_VehicleUserDetails] on [VIC].[VehicleUserDetails]
ALTER TABLE [VIC].[VehicleUserDetails] ADD  CONSTRAINT [PK_VehicleUserDetails] PRIMARY KEY CLUSTERED 
(
	[vehicleUserDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [UX_VUD_OneActive] on [VIC].[VehicleUserDetails]
CREATE UNIQUE NONCLUSTERED INDEX [UX_VUD_OneActive] ON [VIC].[VehicleUserDetails]
(
	[vehicleUserID_FK] ASC
)
WHERE ([detailsActive]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [IX_vehicleWithUsers_active_chassis] on [VIC].[vehicleWithUsers]
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [IX_vehicleWithUsers_active_chassis] ON [VIC].[vehicleWithUsers]
(
	[chassisNumber_FK] ASC,
	[endDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [IX_vehicleWithUsers_vehicleID] on [VIC].[vehicleWithUsers]
CREATE NONCLUSTERED INDEX [IX_vehicleWithUsers_vehicleID] ON [VIC].[vehicleWithUsers]
(
	[vehicleID_FK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [IX_vehicleWithUsers_vehicleUserID] on [VIC].[vehicleWithUsers]
CREATE NONCLUSTERED INDEX [IX_vehicleWithUsers_vehicleUserID] ON [VIC].[vehicleWithUsers]
(
	[vehicleUserID_FK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_vehicleWithUsers] on [VIC].[vehicleWithUsers]
ALTER TABLE [VIC].[vehicleWithUsers] ADD  CONSTRAINT [PK_vehicleWithUsers] PRIMARY KEY CLUSTERED 
(
	[vehicleWithUsersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Index/Key: [PK_Violations] on [VIC].[Violations]
ALTER TABLE [VIC].[Violations] ADD  CONSTRAINT [PK_Violations] PRIMARY KEY CLUSTERED 
(
	[violationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO

-- Foreign key: [FK_MaintenanceDetails_New_VehicleMaintenance] on [VIC].[MaintenanceDetails]
ALTER TABLE [VIC].[MaintenanceDetails]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceDetails_New_VehicleMaintenance] FOREIGN KEY([MaintOrdID_FK])
REFERENCES [VIC].[VehicleMaintenance] ([MaintOrdID])
ALTER TABLE [VIC].[MaintenanceDetails] CHECK CONSTRAINT [FK_MaintenanceDetails_New_VehicleMaintenance]
GO

-- Foreign key: [FK__Maintenan__Group__681FF753] on [VIC].[MaintenanceGroupPeriod]
ALTER TABLE [VIC].[MaintenanceGroupPeriod]  WITH CHECK ADD FOREIGN KEY([GroupID_FK])
REFERENCES [VIC].[MaintenanceGroup] ([GroupID])
GO

-- Foreign key: [FK_vehicleDocument_DocType] on [VIC].[vehicleDocument]
ALTER TABLE [VIC].[vehicleDocument]  WITH CHECK ADD  CONSTRAINT [FK_vehicleDocument_DocType] FOREIGN KEY([vehicleDocumentTypeID_FK])
REFERENCES [VIC].[VehiclesDocumentType] ([vehicleDocumentTypeID])
ALTER TABLE [VIC].[vehicleDocument] CHECK CONSTRAINT [FK_vehicleDocument_DocType]
GO

-- Foreign key: [FK_vehicleDocument_Idara] on [VIC].[vehicleDocument]
ALTER TABLE [VIC].[vehicleDocument]  WITH CHECK ADD  CONSTRAINT [FK_vehicleDocument_Idara] FOREIGN KEY([IdaraID_FK])
REFERENCES [dbo].[Idara] ([idaraID])
ALTER TABLE [VIC].[vehicleDocument] CHECK CONSTRAINT [FK_vehicleDocument_Idara]
GO

-- Foreign key: [FK_vehicleDocument_Vehicles] on [VIC].[vehicleDocument]
ALTER TABLE [VIC].[vehicleDocument]  WITH CHECK ADD  CONSTRAINT [FK_vehicleDocument_Vehicles] FOREIGN KEY([chassisNumber_FK])
REFERENCES [VIC].[Vehicles] ([chassisNumber])
ALTER TABLE [VIC].[vehicleDocument] CHECK CONSTRAINT [FK_vehicleDocument_Vehicles]
GO

-- Foreign key: [FK_VehicleHandover_HandoverType] on [VIC].[VehicleHandover]
ALTER TABLE [VIC].[VehicleHandover]  WITH CHECK ADD  CONSTRAINT [FK_VehicleHandover_HandoverType] FOREIGN KEY([handOverTypeID_FK])
REFERENCES [VIC].[HandoverType] ([handOverTypeID])
ALTER TABLE [VIC].[VehicleHandover] CHECK CONSTRAINT [FK_VehicleHandover_HandoverType]
GO

-- Foreign key: [FK_VehicleHandover_Idara] on [VIC].[VehicleHandover]
ALTER TABLE [VIC].[VehicleHandover]  WITH CHECK ADD  CONSTRAINT [FK_VehicleHandover_Idara] FOREIGN KEY([IdaraID_FK])
REFERENCES [dbo].[Idara] ([idaraID])
ALTER TABLE [VIC].[VehicleHandover] CHECK CONSTRAINT [FK_VehicleHandover_Idara]
GO

-- Foreign key: [FK_VehicleHandover_Vehicles] on [VIC].[VehicleHandover]
ALTER TABLE [VIC].[VehicleHandover]  WITH CHECK ADD  CONSTRAINT [FK_VehicleHandover_Vehicles] FOREIGN KEY([chassisNumber_FK])
REFERENCES [VIC].[Vehicles] ([chassisNumber])
ALTER TABLE [VIC].[VehicleHandover] CHECK CONSTRAINT [FK_VehicleHandover_Vehicles]
GO

-- Foreign key: [FK_VehicleInsurance_Idara] on [VIC].[VehicleInsurance]
ALTER TABLE [VIC].[VehicleInsurance]  WITH CHECK ADD  CONSTRAINT [FK_VehicleInsurance_Idara] FOREIGN KEY([IdaraID_FK])
REFERENCES [dbo].[Idara] ([idaraID])
ALTER TABLE [VIC].[VehicleInsurance] CHECK CONSTRAINT [FK_VehicleInsurance_Idara]
GO

-- Foreign key: [FK_VehicleInsurance_Vehicles] on [VIC].[VehicleInsurance]
ALTER TABLE [VIC].[VehicleInsurance]  WITH CHECK ADD  CONSTRAINT [FK_VehicleInsurance_Vehicles] FOREIGN KEY([chassisNumber_FK])
REFERENCES [VIC].[Vehicles] ([chassisNumber])
ALTER TABLE [VIC].[VehicleInsurance] CHECK CONSTRAINT [FK_VehicleInsurance_Vehicles]
GO

-- Foreign key: [FK_VehicleMaintenance_Idara] on [VIC].[VehicleMaintenance]
ALTER TABLE [VIC].[VehicleMaintenance]  WITH CHECK ADD  CONSTRAINT [FK_VehicleMaintenance_Idara] FOREIGN KEY([IdaraID_FK])
REFERENCES [dbo].[Idara] ([idaraID])
ALTER TABLE [VIC].[VehicleMaintenance] CHECK CONSTRAINT [FK_VehicleMaintenance_Idara]
GO

-- Foreign key: [FK_VehicleMaintenance_Vehicles] on [VIC].[VehicleMaintenance]
ALTER TABLE [VIC].[VehicleMaintenance]  WITH CHECK ADD  CONSTRAINT [FK_VehicleMaintenance_Vehicles] FOREIGN KEY([chassisNumber_FK])
REFERENCES [VIC].[Vehicles] ([chassisNumber])
ALTER TABLE [VIC].[VehicleMaintenance] CHECK CONSTRAINT [FK_VehicleMaintenance_Vehicles]
GO

-- Foreign key: [FK__VehicleMa__Group__6CE4AC70] on [VIC].[VehicleMaintenanceGroup]
ALTER TABLE [VIC].[VehicleMaintenanceGroup]  WITH CHECK ADD FOREIGN KEY([GroupID_FK])
REFERENCES [VIC].[MaintenanceGroup] ([GroupID])
GO

-- Foreign key: [FK_VehicleMaintenancePlan_Vehicles] on [VIC].[VehicleMaintenancePlan]
ALTER TABLE [VIC].[VehicleMaintenancePlan]  WITH CHECK ADD  CONSTRAINT [FK_VehicleMaintenancePlan_Vehicles] FOREIGN KEY([chassisNumber_FK])
REFERENCES [VIC].[Vehicles] ([chassisNumber])
ALTER TABLE [VIC].[VehicleMaintenancePlan] CHECK CONSTRAINT [FK_VehicleMaintenancePlan_Vehicles]
GO

-- Foreign key: [FK_Vehicles_Idara] on [VIC].[Vehicles]
ALTER TABLE [VIC].[Vehicles]  WITH CHECK ADD  CONSTRAINT [FK_Vehicles_Idara] FOREIGN KEY([IdaraID_FK])
REFERENCES [dbo].[Idara] ([idaraID])
ALTER TABLE [VIC].[Vehicles] CHECK CONSTRAINT [FK_Vehicles_Idara]
GO

-- Foreign key: [FK_VehicleScrap_TypesRoot_ScrapType] on [VIC].[VehicleScrap]
ALTER TABLE [VIC].[VehicleScrap]  WITH CHECK ADD  CONSTRAINT [FK_VehicleScrap_TypesRoot_ScrapType] FOREIGN KEY([ScrapTypeID_FK])
REFERENCES [VIC].[TypesRoot] ([typesID])
ALTER TABLE [VIC].[VehicleScrap] CHECK CONSTRAINT [FK_VehicleScrap_TypesRoot_ScrapType]
GO

-- Foreign key: [FK_VehicleScrap_Vehicles] on [VIC].[VehicleScrap]
ALTER TABLE [VIC].[VehicleScrap]  WITH CHECK ADD  CONSTRAINT [FK_VehicleScrap_Vehicles] FOREIGN KEY([chassisNumber_FK])
REFERENCES [VIC].[Vehicles] ([chassisNumber])
ALTER TABLE [VIC].[VehicleScrap] CHECK CONSTRAINT [FK_VehicleScrap_Vehicles]
GO

-- Foreign key: [FK_VehicleTransferRequest_Idara] on [VIC].[VehicleTransferRequest]
ALTER TABLE [VIC].[VehicleTransferRequest]  WITH CHECK ADD  CONSTRAINT [FK_VehicleTransferRequest_Idara] FOREIGN KEY([IdaraID_FK])
REFERENCES [dbo].[Idara] ([idaraID])
ALTER TABLE [VIC].[VehicleTransferRequest] CHECK CONSTRAINT [FK_VehicleTransferRequest_Idara]
GO

-- Foreign key: [FK_VehicleTransferRequest_Vehicles] on [VIC].[VehicleTransferRequest]
ALTER TABLE [VIC].[VehicleTransferRequest]  WITH CHECK ADD  CONSTRAINT [FK_VehicleTransferRequest_Vehicles] FOREIGN KEY([chassisNumber_FK])
REFERENCES [VIC].[Vehicles] ([chassisNumber])
ALTER TABLE [VIC].[VehicleTransferRequest] CHECK CONSTRAINT [FK_VehicleTransferRequest_Vehicles]
GO

-- Foreign key: [FK_VehicleTransferRequestHistory_Request] on [VIC].[VehicleTransferRequestHistory]
ALTER TABLE [VIC].[VehicleTransferRequestHistory]  WITH CHECK ADD  CONSTRAINT [FK_VehicleTransferRequestHistory_Request] FOREIGN KEY([RequestID_FK])
REFERENCES [VIC].[VehicleTransferRequest] ([RequestID])
ALTER TABLE [VIC].[VehicleTransferRequestHistory] CHECK CONSTRAINT [FK_VehicleTransferRequestHistory_Request]
GO

-- Foreign key: [FK_VUD_Gender] on [VIC].[VehicleUserDetails]
ALTER TABLE [VIC].[VehicleUserDetails]  WITH CHECK ADD  CONSTRAINT [FK_VUD_Gender] FOREIGN KEY([genderID_FK])
REFERENCES [VIC].[VehicleGender] ([genderID])
ALTER TABLE [VIC].[VehicleUserDetails] CHECK CONSTRAINT [FK_VUD_Gender]
GO

-- Foreign key: [FK_VUD_Nationality] on [VIC].[VehicleUserDetails]
ALTER TABLE [VIC].[VehicleUserDetails]  WITH CHECK ADD  CONSTRAINT [FK_VUD_Nationality] FOREIGN KEY([nationalityID_FK])
REFERENCES [VIC].[VehicleNationality] ([nationalityID])
ALTER TABLE [VIC].[VehicleUserDetails] CHECK CONSTRAINT [FK_VUD_Nationality]
GO

-- Foreign key: [FK_VUD_Rank] on [VIC].[VehicleUserDetails]
ALTER TABLE [VIC].[VehicleUserDetails]  WITH CHECK ADD  CONSTRAINT [FK_VUD_Rank] FOREIGN KEY([rankID_FK])
REFERENCES [VIC].[VehicleRank] ([rankID])
ALTER TABLE [VIC].[VehicleUserDetails] CHECK CONSTRAINT [FK_VUD_Rank]
GO

-- Foreign key: [FK_VUD_User] on [VIC].[VehicleUserDetails]
ALTER TABLE [VIC].[VehicleUserDetails]  WITH CHECK ADD  CONSTRAINT [FK_VUD_User] FOREIGN KEY([vehicleUserID_FK])
REFERENCES [VIC].[VehicleUser] ([vehicleUserID])
ALTER TABLE [VIC].[VehicleUserDetails] CHECK CONSTRAINT [FK_VUD_User]
GO

-- Foreign key: [FK_vehicleWithUsers_Vehicles] on [VIC].[vehicleWithUsers]
ALTER TABLE [VIC].[vehicleWithUsers]  WITH CHECK ADD  CONSTRAINT [FK_vehicleWithUsers_Vehicles] FOREIGN KEY([chassisNumber_FK])
REFERENCES [VIC].[Vehicles] ([chassisNumber])
ALTER TABLE [VIC].[vehicleWithUsers] CHECK CONSTRAINT [FK_vehicleWithUsers_Vehicles]
GO

-- Foreign key: [FK_Violations_Idara] on [VIC].[Violations]
ALTER TABLE [VIC].[Violations]  WITH CHECK ADD  CONSTRAINT [FK_Violations_Idara] FOREIGN KEY([IdaraID_FK])
REFERENCES [dbo].[Idara] ([idaraID])
ALTER TABLE [VIC].[Violations] CHECK CONSTRAINT [FK_Violations_Idara]
GO
