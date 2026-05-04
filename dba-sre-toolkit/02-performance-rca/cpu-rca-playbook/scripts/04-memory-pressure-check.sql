/*
Purpose: Rule out memory pressure and memory grant issues.
*/
SET NOCOUNT ON;

SELECT
    counter_name,
    cntr_value
FROM sys.dm_os_performance_counters
WHERE object_name LIKE '%Memory Manager%'
  AND counter_name IN
  (
    'Memory Grants Pending',
    'Memory Grants Outstanding',
    'Target Server Memory (KB)',
    'Total Server Memory (KB)'
  )
ORDER BY counter_name;

SELECT
    total_physical_memory_kb,
    available_physical_memory_kb,
    system_memory_state_desc
FROM sys.dm_os_sys_memory;
