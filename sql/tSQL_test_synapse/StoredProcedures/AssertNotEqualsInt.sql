CREATE PROCEDURE [tSQL_test_synapse].[AssertNotEqualsInt]
    @expected int,
    @actual int
AS
BEGIN
    IF (
        (@expected = @actual)
        OR (@expected IS NULL AND @actual IS NULL)
    )
        BEGIN
            DECLARE @Msg nvarchar(MAX);
            SET
                @Msg = 'Expected actual value to not '
                + COALESCE('equal <' + CAST(@expected AS nvarchar(MAX)) + '>', 'be NULL')
                + '.';
            EXEC [tSQL_test_synapse].[Fail] @Msg;
        END
END;
