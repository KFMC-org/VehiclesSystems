/* Extracted read-only from DATACORE on 2026-11-12. Definition only; no data. */
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE [VIC].[TypesRoot_List_DL]
(
      @parentID   INT = NULL
    , @activeOnly BIT = 0
    , @search     NVARCHAR(200) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @S NVARCHAR(200) = NULLIF(LTRIM(RTRIM(@search)), N'');

    SELECT
          t.typesID
        , t.typesName_A
        , t.typesName_E
        , t.typesDesc
        , t.typesActive
        , t.typesStartDate
        , t.typesEndDate
        , t.typesRoot_ParentID
    FROM VIC.TypesRoot t
    WHERE
        (
            (@parentID IS NULL AND t.typesRoot_ParentID IS NULL)
            OR
            (@parentID IS NOT NULL AND t.typesRoot_ParentID = @parentID)
        )
        AND (@activeOnly = 0 OR t.typesActive = 1)
        AND (
            @S IS NULL
            OR t.typesName_A LIKE '%' + @S + '%'
            OR t.typesName_E LIKE '%' + @S + '%'
        )
    ORDER BY t.typesName_A;
END
GO

