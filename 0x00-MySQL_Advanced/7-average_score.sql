-- Create the stored procedure
DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;

DELIMITER //
CREATE PROCEDURE ComputeAverageScoreForUser(
    IN p_user_id INT
)
BEGIN
    -- Compute the average score and update the user's average_score column
    UPDATE users
    SET average_score = (
        SELECT AVG(score)
        FROM corrections
        WHERE user_id = p_user_id
    )
    WHERE id = p_user_id;
END //

DELIMITER ;

