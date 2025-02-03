/**
    Name of Script: replace_examples.sql
    Author: Jacob Shuster
    Role: Consultant - 1099
    Umbrella Company: N/A
    Creation Date: 2024-12-29
    Script Cost: N/A
    Rate: 100.00 (Based on 2019*)

	GitHub: https://www.github.com/Jay-Shu/personalScripts.git
    Command: git clone https://www.github.com/Jay-Shu/personalScripts.git

    Changelog:
        2024-12-29:
		

    TO DO (Requested):
		N/A - No current modification requests pending.
	
	TO DO (SELF):
		N/A - No current modification requests pending.
		
    DISCLAIMER:
        After receipt, this Script is "as-is".
    
    Non-Billable Items:
        Notes.
        
    Accessing the below variables is @nameOfVariable. The variable will ONLY be accessible within the bounds of the GO
		Paramater. This is because each batch is committed before the next can complete.

    WARNING: DO NOT MODIFY SCRIPT WITHOUT CONSULTING THE CREATOR FIRST. AS SOME CHANGES MAY PREVENT THE SCRIPT FROM
		EXECUTING PROPERLY.

    Scalar Variables:
        @totalSysMem: Total System Memory of the Database Server where PACA will reside.
		@memoryForThreadStack: Memory required for your Database Server's Thread Stack. Refer to the table therein
			"Reserved Memory Calculator (Local Machine)" for determining what value that needs to be. This value is
			in KB therefore, must be converted to GB.
		@osMemoryRequirements: OS Memory Requirements, Refer to your OS Manufacturer's Technical Specifications to
			find this number.
		@memoryForOtherApplications: Find, record, and calculate the Memory required for any other applications
			running on the MS SQL Server.
		@memoryForMultipageAllocators: Refer to Changes to memory management starting with SQL Server 2012 (11.x).
			Specifically MPA, for memory allocations that request more than 8 KB. This is included within the
			Max Server Memory (MB) and Min Server Memory (MB) Configuration options and no longer independent.

		
	Citations:
		1. REPLICATE (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/functions/replicate-transact-sql?view=sql-server-ver16

	Author Notes:
		This is used for a replicate example of a pyramid

		Calculation for DECIMAL(X,Y): (10 ^ (x-y)) - (10 ^ -y) . Absolute and Negative Values.
		Logical Processing Order:	
    		FROM
    		ON
    		JOIN
    		WHERE
    		GROUP BY
    		WITH CUBE or WITH ROLLUP
    		HAVING
    		SELECT
    		DISTINCT
    		ORDER BY
    		TOP

		NTFS allocation unit size
			Volume alignment, commonly referred to as sector alignment, should be performed
			on the file system (NTFS) whenever a volume is created on a RAID device. Failure
			to do so can lead to significant performance degradation and is most commonly the
			result of partition misalignment with stripe unit boundaries. It can also lead
			to hardware cache misalignment, resulting in inefficient utilization of the array
			cache. When formatting the partition that will be used for SQL Server data files,
			it's recommended that you use a 64-KB allocation unit size (that is, 65,536 bytes)
			for data, logs, and tempdb. Be aware, however, that using allocation unit sizes
			greater than 4 KB results in the inability to use NTFS compression on the volume.
			While SQL Server does support read-only data on compressed volumes, it isn't recommended.

		Max Server Memeory Recommendation (initial reservation):
			1 GB of RAM for the OS.
			1 GB of RAM per every 4 GB of RAM installed (up to 16-GB RAM).
			1 GB of RAM per every 8 GB RAM installed (above 16-GB RAM).
		
		Reserved Memory Calculation:
			((total system memory) – (memory for thread stack) – (OS memory requirements) – (memory for other applications) – (memory for multipage allocators))

		total system memory: Total RAM on the System
		memory for thread stack:
			SQL Server Architecture		OS Architecture			Stack Size
			x86 (32-bit)				x86 (32-bit)			512 kb
			x86 (32-bit)				x64 (64-bit)			768 kb
			x64 (64-bit)				x64 (64-bit)			2048 kb
			IA64 (Itanium)				IA64 (Itanium)			4096 kb
		
		Reserved Memory Calculator (Local Machine):
			DECLARE	 @totalSysMem INT = 128,
			@memoryForThreadStack INT = 2048,
			@osMemoryRequirements INT = 4,
			@memoryForOtherApplications INT = 0,
			@memoryForMultipageAllocators INT = 0

		SELECT ((@totalSysMem) - ((@memoryForThreadStack/1000)/1000) - (@osMemoryRequirements) - (@memoryForOtherApplications) - (@memoryForMultipageAllocators))

		Finding your currently allocated memory:
			SELECT
  				physical_memory_in_use_kb/1024 AS sql_physical_memory_in_use_MB,
    			large_page_allocations_kb/1024 AS sql_large_page_allocations_MB,
    			locked_page_allocations_kb/1024 AS sql_locked_page_allocations_MB,
    			virtual_address_space_reserved_kb/1024 AS sql_VAS_reserved_MB,
    			virtual_address_space_committed_kb/1024 AS sql_VAS_committed_MB,
    			virtual_address_space_available_kb/1024 AS sql_VAS_available_MB,
    			page_fault_count AS sql_page_fault_count,
    			memory_utilization_percentage AS sql_memory_utilization_percentage,
    			process_physical_memory_low AS sql_process_physical_memory_low,
    			process_virtual_memory_low AS sql_process_virtual_memory_low
			FROM sys.dm_os_process_memory;
		Query hints are recommended as a last resort and only for experienced developers and database administrators.


**/



DECLARE @counterAsc INT = 0,
@printingcharAsc NVARCHAR(MAX),
@basestringAsc NVARCHAR(MAX)

WHILE (@counterAsc < 21)
BEGIN TRY
print @counterAsc
SELECT REPLICATE('* ',@counterAsc)
SET @counterAsc = @counterAsc + 1
END TRY
BEGIN CATCH
SELECT 
  ERROR_NUMBER() AS ErrorNumber
  ,ERROR_SEVERITY() AS ErrorSeverity
  ,ERROR_STATE() AS ErrorState
  ,ERROR_PROCEDURE() AS ErrorProcedure
  ,ERROR_LINE() AS ErrorLine
  ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH

DECLARE @counterDesc INT = 20,
@printingcharDesc NVARCHAR(MAX),
@basestringDesc NVARCHAR(MAX)

WHILE (@counterDesc != 0)
BEGIN TRY
print @counterDesc
SELECT REPLICATE('* ',@counterDesc)
SET @counterDesc = @counterDesc- 1
END TRY
BEGIN CATCH
SELECT 
  ERROR_NUMBER() AS ErrorNumber
  ,ERROR_SEVERITY() AS ErrorSeverity
  ,ERROR_STATE() AS ErrorState
  ,ERROR_PROCEDURE() AS ErrorProcedure
  ,ERROR_LINE() AS ErrorLine
  ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH