/*
Purpose: Identify active requests and CPU consumers during a live incident.
*/
SET NOCOUNT ON;

SELECT TOP (50)
    r.session_id,
    r.status,
    r.command,
    DB_NAME(r.database_id) AS database_name,
    r.cpu_time,
    r.total_elapsed_time,
    r.logical_reads,
    r.reads,
    r.writes,
    r.wait_type,
    r.wait_time,
    r.blocking_session_id,
    s.host_name,
    s.program_name,
    s.login_name,
    SUBSTRING(t.text,
        (r.statement_start_offset / 2) + 1,
        ((CASE r.statement_end_offset WHEN -1 THEN DATALENGTH(t.text) ELSE r.statement_end_offset END - r.statement_start_offset) / 2) + 1
    ) AS running_statement,
    t.text AS full_batch_text
FROM sys.dm_exec_requests r
JOIN sys.dm_exec_sessions s
  ON r.session_id = s.session_id
OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.session_id <> @@SPID
ORDER BY r.cpu_time DESC;
