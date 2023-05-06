-- script that creates a stored procedure ComputeAverageScoreForUser
-- Create the stored procedure
DELIMITER //

CREATE PROCEDURE AddBonus(
    IN p_user_id INT,
    IN p_project_name VARCHAR(255),
    IN p_score INT
)
BEGIN
    -- Check if the project exists
    SET @project_id := (SELECT id FROM projects WHERE name = p_project_name);

    -- If the project doesn't exist, create it
    IF @project_id IS NULL THEN
        INSERT INTO projects (name) VALUES (p_project_name);
        SET @project_id := LAST_INSERT_ID();
    END IF;

    -- Insert the correction
    INSERT INTO corrections (user_id, project_id, score)
    VALUES (p_user_id, @project_id, p_score);
END //

DELIMITER ;
