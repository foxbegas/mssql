SELECT MAX(login_time) AS [Last Login Time], login_name [Login], program_name() [Client], host_name() [Host]
FROM sys.dm_exec_sessions
GROUP BY login_name;