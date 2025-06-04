use class12Homework;
GO
IF OBJECT_ID('dbo.usp_GetAllRoutinesWithParameters', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_GetAllRoutinesWithParameters;
GO
CREATE PROCEDURE usp_GetAllRoutinesWithParameters
    @DatabaseName SYSNAME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX) = N'';
    
    -- Table to store final results
    IF OBJECT_ID('tempdb..#RoutineParams') IS NOT NULL DROP TABLE #RoutineParams;

    CREATE TABLE #RoutineParams (
        DatabaseName SYSNAME,
        SchemaName SYSNAME,
        RoutineName SYSNAME,
        RoutineType NVARCHAR(20),
        ParameterName SYSNAME,
        DataType NVARCHAR(128),
        MaxLength INT
    );

    -- Cursor to loop over databases
    DECLARE @CurrentDb SYSNAME;

    DECLARE db_cursor CURSOR FOR
    SELECT name
    FROM sys.databases
    WHERE state_desc = 'ONLINE'
      AND name NOT IN ('master', 'tempdb', 'model', 'msdb')
      AND (@DatabaseName IS NULL OR name = @DatabaseName);

    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @CurrentDb;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @sql = '
        USE [' + QUOTENAME(@CurrentDb) + '];

        INSERT INTO #RoutineParams (DatabaseName, SchemaName, RoutineName, RoutineType, ParameterName, DataType, MaxLength)
        SELECT
            DB_NAME() AS DatabaseName,
            s.name AS SchemaName,
            o.name AS RoutineName,
            o.type_desc AS RoutineType,
            p.name AS ParameterName,
            t.name AS DataType,
            CASE
                WHEN t.name IN (''nvarchar'', ''nchar'') AND p.max_length > 0 THEN p.max_length / 2
                ELSE p.max_length
            END AS MaxLength
        FROM
            sys.objects o
            INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
            LEFT JOIN sys.parameters p ON o.object_id = p.object_id
            LEFT JOIN sys.types t ON p.user_type_id = t.user_type_id
        WHERE
            o.type IN (''P'', ''FN'', ''IF'', ''TF''); -- Procedures and Functions
        ';

        EXEC sp_executesql @sql;

        FETCH NEXT FROM db_cursor INTO @CurrentDb;
    END

    CLOSE db_cursor;
    DEALLOCATE db_cursor;

    -- Final output
    SELECT *
    FROM #RoutineParams
    ORDER BY DatabaseName, SchemaName, RoutineName, ParameterName;
END;