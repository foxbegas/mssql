EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'_DATABASE_'
GO
USE [master]
GO
ALTER DATABASE [_DATABASE_] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
/****** Object:  Database [_DATABASE_] ******/
DROP DATABASE [_DATABASE_]
GO
