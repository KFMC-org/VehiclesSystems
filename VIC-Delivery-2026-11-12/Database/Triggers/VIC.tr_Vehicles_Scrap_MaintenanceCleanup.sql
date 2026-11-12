/* Extracted read-only from DATACORE on 2026-11-12. Definition only; no data. */
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER TRIGGER VIC.tr_Vehicles_Scrap_MaintenanceCleanup
ON VIC.Vehicles
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    -- PeriodicMaintenance START - cancel maintenance cycle when vehicle becomes scrapped (262)
    UPDATE p SET p.planActive = 0
    FROM VIC.VehicleMaintenancePlan p
    INNER JOIN inserted i ON p.chassisNumber_FK = i.chassisNumber
    INNER JOIN deleted d ON i.chassisNumber = d.chassisNumber
    WHERE i.vehicleStatusID_FK = 262 AND ISNULL(d.vehicleStatusID_FK,0) <> 262 AND p.planActive = 1;

    UPDATE vmg SET vmg.Active = 0
    FROM VIC.VehicleMaintenanceGroup vmg
    INNER JOIN inserted i ON vmg.chassisNumber_FK = i.chassisNumber
    INNER JOIN deleted d ON i.chassisNumber = d.chassisNumber
    WHERE i.vehicleStatusID_FK = 262 AND ISNULL(d.vehicleStatusID_FK,0) <> 262 AND vmg.Active = 1;

    UPDATE m SET m.Cancelled = 1,
        m.CancelReason = NCHAR(1575)+NCHAR(1604)+NCHAR(1605)+NCHAR(1585)+NCHAR(1603)+NCHAR(1576)+NCHAR(1577)+NCHAR(32)+NCHAR(1578)+NCHAR(1575)+NCHAR(1604)+NCHAR(1601)+NCHAR(1577),
        m.CancelDate = GETDATE(),
        m.MaintOrdActive = 0
    FROM VIC.VehicleMaintenance m
    INNER JOIN inserted i ON m.chassisNumber_FK = i.chassisNumber
    INNER JOIN deleted d ON i.chassisNumber = d.chassisNumber
    WHERE i.vehicleStatusID_FK = 262 AND ISNULL(d.vehicleStatusID_FK,0) <> 262
      AND m.MaintOrdTypeID_FK = 265 AND m.MaintOrdActive = 1;
    -- PeriodicMaintenance END
END
GO

