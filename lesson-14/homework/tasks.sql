use SqlLessonData;
Go
DECLARE @tableHTML NVARCHAR(MAX);

SET @tableHTML = 
N'<style>
    table {border-collapse: collapse; width: 100%;}
    th, td {border: 1px solid #dddddd; padding: 8px; text-align: left;}
    th {background-color: #f2f2f2;}
</style>
<h3>Index Metadata Report</h3>
<table>
<tr>
    <th>Table Name</th>
    <th>Index Name</th>
    <th>Index Type</th>
    <th>Column Name</th>
    <th>Column Type</th>
</tr>' +

CAST ((
    SELECT 
        td = t.name, '',
        td = ind.name, '',
        td = ind.type_desc, '',
        td = col.name, '',
        td = typ.name, ''
    FROM 
        sys.indexes ind 
    INNER JOIN 
        sys.index_columns ic ON ind.object_id = ic.object_id AND ind.index_id = ic.index_id 
    INNER JOIN 
        sys.columns col ON ic.object_id = col.object_id AND ic.column_id = col.column_id 
    INNER JOIN 
        sys.tables t ON ind.object_id = t.object_id 
    INNER JOIN 
        sys.types typ ON col.user_type_id = typ.user_type_id
    WHERE 
        ind.is_primary_key = 0 AND 
        ind.is_unique_constraint = 0
    ORDER BY 
        t.name, ind.name
    FOR XML PATH('tr'), TYPE
) AS NVARCHAR(MAX)) + 
N'</table>';


EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'ZenithProfile',
    @recipients = 'recipient@example.com',
    @subject = 'SQL Server Index Metadata Report',
    @body = @tableHTML,
    @body_format = 'HTML';


