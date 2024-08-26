-- Modified by Deep Network GmbH to make it compatible with Synapse
CREATE PROCEDURE [tSQL_test_synapse].[ExpectNoException]
    @Message NVARCHAR(MAX)
AS
BEGIN
    IF (EXISTS (SELECT 1 FROM #ExpectException WHERE [ExpectException] = 0))
        BEGIN
            DELETE #ExpectException;
            THROW 50001, 'Each test can only contain one call to tSQLt.ExpectNoException.', 101;
        END;
    IF (EXISTS (SELECT 1 FROM #ExpectException WHERE [ExpectException] = 1))
        BEGIN
            DELETE #ExpectException;
            THROW 50001,
            'tSQL_test_synapse.ExpectNoException cannot follow tSQL_test_synapse.ExpectException inside a single test.',
            101;
        END;

    INSERT INTO #ExpectException ([ExpectException], [FailMessage])
    VALUES (0, @Message);
END;
