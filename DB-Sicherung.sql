--05.04.2019

--Sicherungsmodell auf Einfach setzen
USE [master]
GO
ALTER DATABASE [_DATABASE_] SET RECOVERY SIMPLE WITH NO_WAIT
GO

--Transaktionslogs verkleinern
USE [VivAmbulant]
GO
DBCC SHRINKFILE (N'_DATABASE_' , 0, TRUNCATEONLY)
GO

--Datenbanken sichern; Sicherungen auf Integrität überprüfen
BACKUP DATABASE [_DATABASE_] TO  DISK = N'Path:\to\Backup.bak' WITH NOFORMAT, NOINIT,  NAME = N'Vollständig Datenbank Sichern', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'_DATABASE_' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'_DATABASE_' )
if @backupSetId is null begin raiserror(N'Fehler beim Überprüfen. Sicherungsinformationen für die Datenbank "_DATABASE_" wurden nicht gefunden.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'Path:\to\Backup.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO

--Sicherungsmodell auf Vollständig setzen
USE [master]
GO
ALTER DATABASE [_DATABASE_] SET RECOVERY FULL WITH NO_WAIT
GO