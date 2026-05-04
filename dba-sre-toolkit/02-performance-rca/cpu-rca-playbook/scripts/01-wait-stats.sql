/*
Purpose: Identify dominant SQL Server wait types.
Use this as an early signal. For CPU scheduler pressure, look for SOS_SCHEDULER_YIELD dominance.
*/
SET NOCOUNT ON;

SELECT TOP (25)
    wait_type,
    waiting_tasks_count,
    wait_time_ms,
    signal_wait_time_ms,
    wait_time_ms / 1000.0 AS wait_time_seconds,
    CAST(100.0 * wait_time_ms / NULLIF(SUM(wait_time_ms) OVER(), 0) AS decimal(6,2)) AS pct_of_total_wait_time
FROM sys.dm_os_wait_stats
WHERE wait_type NOT IN
(
    'SLEEP_TASK','BROKER_TASK_STOP','BROKER_TO_FLUSH','SQLTRACE_BUFFER_FLUSH',
    'CLR_AUTO_EVENT','CLR_MANUAL_EVENT','LAZYWRITER_SLEEP','SLEEP_SYSTEMTASK',
    'WAITFOR','HADR_FILESTREAM_IOMGR_IOCOMPLETION','CHECKPOINT_QUEUE',
    'REQUEST_FOR_DEADLOCK_SEARCH','XE_TIMER_EVENT','XE_DISPATCHER_WAIT',
    'FT_IFTS_SCHEDULER_IDLE_WAIT','LOGMGR_QUEUE','BROKER_EVENTHANDLER',
    'DISPATCHER_QUEUE_SEMAPHORE','BROKER_RECEIVE_WAITFOR','ONDEMAND_TASK_QUEUE',
    'DBMIRROR_EVENTS_QUEUE','DBMIRRORING_CMD','BROKER_TRANSMITTER',
    'SQLTRACE_INCREMENTAL_FLUSH_SLEEP','DIRTY_PAGE_POLL','HADR_TIMER_TASK'
)
ORDER BY wait_time_ms DESC;
