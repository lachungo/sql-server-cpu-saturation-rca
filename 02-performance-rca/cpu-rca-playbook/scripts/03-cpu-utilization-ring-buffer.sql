/*
Purpose: Review SQL Server CPU and system idle history from scheduler monitor ring buffer.
*/
SET NOCOUNT ON;

WITH RingBuffer AS
(
    SELECT
        DATEADD(ms, -1 * (si.ms_ticks - rb.[timestamp]), SYSDATETIME()) AS event_time,
        CONVERT(xml, rb.record) AS record_xml
    FROM sys.dm_os_ring_buffers rb
    CROSS JOIN sys.dm_os_sys_info si
    WHERE rb.ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR'
      AND rb.record LIKE '%<SystemHealth>%'
)
SELECT TOP (256)
    event_time,
    record_xml.value('(//SystemHealth/SystemIdle)[1]', 'int') AS system_idle_pct,
    record_xml.value('(//SystemHealth/ProcessUtilization)[1]', 'int') AS sql_process_cpu_pct,
    100 - record_xml.value('(//SystemHealth/SystemIdle)[1]', 'int')
        - record_xml.value('(//SystemHealth/ProcessUtilization)[1]', 'int') AS other_process_cpu_pct
FROM RingBuffer
ORDER BY event_time DESC;
