-- first part
DELIMITER //

CREATE PROCEDURE count_books_by_genre_pocedure(
    IN genreName VARCHAR(45),
    OUT genreId INT,
    INOUT totalBooks INT
)
BEGIN
    -- We find the genre ID by its name
    SELECT id INTO genreId FROM library.genre WHERE genre_name = genreName;
    
    -- We get the number of books in this genre and update the totalBooks parameter
    SELECT COUNT(1) INTO totalBooks FROM library.book2genre WHERE genre_id = genreId;
END//

DELIMITER ;



-- second part
DELIMITER //

CREATE PROCEDURE count_books_by_genre_pocedure_with_transaction(
    IN genreName VARCHAR(45),
    OUT genreId INT,
    INOUT totalBooks INT
)
BEGIN
    DECLARE rollbackAction BOOLEAN DEFAULT FALSE;

    -- Exception handling
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET rollbackAction = TRUE;
    START TRANSACTION;

    -- We find the genre ID by its name
    SELECT id INTO genreId FROM library.genre WHERE genre_name = genreName;

    -- We get the number of books in this genre and update the totalBooks parameter
    SELECT COUNT(1) INTO totalBooks FROM library.book2genre WHERE genre_id = genreId;

    -- Checking the condition and committing or rolling back the transaction
    IF rollbackAction THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END//

DELIMITER ;

