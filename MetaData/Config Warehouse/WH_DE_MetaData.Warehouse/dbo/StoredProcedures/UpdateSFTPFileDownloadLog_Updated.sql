CREATE    PROCEDURE [dbo].[UpdateSFTPFileDownloadLog_Updated]
    @LogID BIGINT,
    @FileName VARCHAR(255),
    @Status VARCHAR(20),
    @ErrorMessage VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate Status value (must be 'Success' or 'Failed')
    IF @Status NOT IN ('Success', 'Failed')
    BEGIN
        PRINT 'Invalid Status. Allowed values: Success, Failed';
        RETURN;
    END;

    -- Update the existing log entry with the file name and final status
    UPDATE dbo.SFTPFileDownloadLog
    SET FileName = @FileName, Status = @Status, ErrorMessage = @ErrorMessage
    WHERE LogID = @LogID;

    PRINT 'SFTP file download updated. LogID: ' + CAST(@LogID AS VARCHAR);
END;