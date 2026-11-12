/*
    VIC delivery package
    Source: DATACORE on alatif (read-only extraction)
    Extracted: 2026-11-12
    Contains definitions only; no operational data.
*/

SET NOCOUNT ON;
GO

IF SCHEMA_ID(N'VIC') IS NULL
    EXEC(N'CREATE SCHEMA [VIC] AUTHORIZATION [dbo];');
GO
