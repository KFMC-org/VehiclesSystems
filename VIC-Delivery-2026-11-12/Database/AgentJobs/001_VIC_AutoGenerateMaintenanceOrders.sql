/*
    SQL Agent Job extracted read-only from msdb on 2026-11-12.
    Review the target database name before execution.
    No login, password, proxy, credential, or server-specific identifier is included.
*/

USE [msdb];
GO

DECLARE @JobName sysname = N'VIC - Auto Generate Maintenance Orders';
DECLARE @ScheduleName sysname = N'VIC - Daily 1 AM';

IF NOT EXISTS (SELECT 1 FROM dbo.sysjobs WHERE [name] = @JobName)
BEGIN
    EXEC dbo.sp_add_job
          @job_name = @JobName
        , @enabled = 1
        , @description = N'إنشاء أوامر الصيانة الدورية تلقائيًا من VIC.VehicleMaintenancePlan';
END;

IF NOT EXISTS
(
    SELECT 1
    FROM dbo.sysjobsteps s
    INNER JOIN dbo.sysjobs j ON j.job_id = s.job_id
    WHERE j.[name] = @JobName
      AND s.step_id = 1
)
BEGIN
    EXEC dbo.sp_add_jobstep
          @job_name = @JobName
        , @step_id = 1
        , @step_name = N'Execute MaintenancePlan_AutoGenerate_SP'
        , @subsystem = N'TSQL'
        , @database_name = N'DATACORE'
        , @command = N'
EXEC [VIC].[MaintenancePlanSP]
      @ActionType = N''AUTO_GENERATE''
    , @idaraID_FK = NULL
    , @entryData  = N''SYSTEM''
    , @hostName   = N''SQL-JOB'';'
        , @on_success_action = 1
        , @on_fail_action = 2;
END;

IF NOT EXISTS (SELECT 1 FROM dbo.sysschedules WHERE [name] = @ScheduleName)
BEGIN
    EXEC dbo.sp_add_schedule
          @schedule_name = @ScheduleName
        , @enabled = 1
        , @freq_type = 4
        , @freq_interval = 1
        , @freq_subday_type = 1
        , @freq_subday_interval = 0
        , @freq_recurrence_factor = 0
        , @active_start_date = 20260326
        , @active_end_date = 99991231
        , @active_start_time = 010000
        , @active_end_time = 235959;
END;

IF NOT EXISTS
(
    SELECT 1
    FROM dbo.sysjobs j
    INNER JOIN dbo.sysjobschedules js ON js.job_id = j.job_id
    INNER JOIN dbo.sysschedules s ON s.schedule_id = js.schedule_id
    WHERE j.[name] = @JobName
      AND s.[name] = @ScheduleName
)
BEGIN
    EXEC dbo.sp_attach_schedule
          @job_name = @JobName
        , @schedule_name = @ScheduleName;
END;

IF NOT EXISTS
(
    SELECT 1
    FROM dbo.sysjobservers js
    INNER JOIN dbo.sysjobs j ON j.job_id = js.job_id
    WHERE j.[name] = @JobName
)
BEGIN
    EXEC dbo.sp_add_jobserver @job_name = @JobName;
END;
GO
