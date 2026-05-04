/*
Purpose: Identify CPU scheduler pressure.
Runnable tasks consistently above 0 usually means workers are waiting for CPU time.
*/
SET NOCOUNT ON;

SELECT
    scheduler_id,
    cpu_id,
    status,
    is_online,
    current_tasks_count,
    runnable_tasks_count,
    current_workers_count,
    active_workers_count,
    work_queue_count,
    load_factor,
    yield_count
FROM sys.dm_os_schedulers
WHERE status = 'VISIBLE ONLINE'
ORDER BY runnable_tasks_count DESC, scheduler_id;

SELECT
    SUM(runnable_tasks_count) AS total_runnable_tasks,
    AVG(CAST(runnable_tasks_count AS decimal(10,2))) AS avg_runnable_tasks_per_scheduler,
    MAX(runnable_tasks_count) AS max_runnable_tasks_on_single_scheduler,
    COUNT(*) AS visible_online_schedulers
FROM sys.dm_os_schedulers
WHERE status = 'VISIBLE ONLINE';
