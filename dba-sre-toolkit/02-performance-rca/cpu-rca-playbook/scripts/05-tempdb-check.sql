/*
Purpose: Rule out TempDB pressure and allocation hot spots.
*/
SET NOCOUNT ON;

USE tempdb;

SELECT
    SUM(user_object_reserved_page_count) * 8 / 1024.0 AS user_objects_mb,
    SUM(internal_object_reserved_page_count) * 8 / 1024.0 AS internal_objects_mb,
    SUM(version_store_reserved_page_count) * 8 / 1024.0 AS version_store_mb,
    SUM(unallocated_extent_page_count) * 8 / 1024.0 AS free_space_mb
FROM sys.dm_db_file_space_usage;

SELECT
    name,
    type_desc,
    size * 8 / 1024.0 AS size_mb,
    FILEPROPERTY(name, 'SpaceUsed') * 8 / 1024.0 AS used_mb
FROM sys.database_files;
