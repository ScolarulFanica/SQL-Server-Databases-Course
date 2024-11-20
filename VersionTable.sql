USE TableTennis
go

CREATE PROCEDURE main
@vers int
AS
BEGIN
	IF @vers>7 OR @vers <0
	BEGIN
		RAISERROR('The version number should be in the interval [1-7]!',10,1)
		RETURN;
	END;
	DECLARE @currentVersion INT
	DECLARE @procName NVARCHAR(50)
	SET @currentVersion = (SELECT TVersion FROM VersionTable)
	IF @vers > @currentVersion
	BEGIN
		WHILE @currentVersion < @vers
		BEGIN
			SET @currentVersion = @currentVersion + 1;
			SET @procName = 'do_proc_' + CAST(@currentVersion AS nvarchar(10));
			EXEC sp_executesql @procName;
		END
	END
	ELSE IF @vers < @currentVersion
	BEGIN
		WHILE @currentVersion > @vers
		BEGIN
			SET @procName = 'undo_proc_' + CAST(@currentVersion AS nvarchar(10));
			EXEC sp_executesql @procName;
			SET @currentVersion = @currentVersion - 1;
		END
	END
	ELSE PRINT 'The current version of the databse is already the same with the indicated version!'
	UPDATE VersionTable SET TVERSION = @vers
END
go

--DROP procedure main
