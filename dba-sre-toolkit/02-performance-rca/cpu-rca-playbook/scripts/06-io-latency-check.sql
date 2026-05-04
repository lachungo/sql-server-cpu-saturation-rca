/*
Purpose: Rule out database file I/O latency as the primary bottleneck.
*/
SET NOCOUNT ON;

SELECT TOP (50)
    DB_NAME(vfs.database_id) AS database_name,
    mf.type_desc,
    mf.physical_name,
    vfs.num_of_reads,
    vfs.io_stall_read_ms,
    CAST(vfs.io_stall_read_ms / NULLIF(vfs.num_of_reads, 0) AS decimal(18,2)) AS avg_read_latency_ms,
    vfs.num_of_writes,
    vfs.io_stall_write_ms,
    CAST(vfs.io_stall_write_ms / NULLIF(vfs.num_of_writes, 0) AS decimal(18,2)) AS avg_write_latency_ms
FROM sys.dm_io_virtual_file_stats(NULL, NULL) vfs
JOIN sys.master_files mf
  ON vfs.database_id = mf.database_id
 AND vfs.file_id = mf.file_id
ORDER BY
    COALESCE(vfs.io_stall_read_ms / NULLIF(vfs.num_of_reads, 0), 0)
  + COALESCE(vfs.io_stall_write_ms / NULLIF(vfs.num_of_writes, 0), 0) DESC;
