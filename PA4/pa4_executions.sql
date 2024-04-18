
SET @genreName = 'Fantasy';
SET @totalBooks = 0;
CALL count_books_by_genre_pocedure(@genreName, @genreId, @totalBooks);
SELECT @totalBooks AS 'Total Books in Genre';


SELECT COUNT(1) AS 'Total Books in Fantasy' FROM library.book2genre WHERE genre_id = 1;
SET @genreName = 'Fantasy';
SET @genreId = NULL;
SET @totalBooks = NULL;

CALL count_books_by_genre_pocedure_with_transaction(@genreName, @genreId, @totalBooks);
SELECT @genreId AS 'Genre ID', @totalBooks AS 'Total Books';

SET @genreName = 'Horror';
SET @genreId = NULL;
SET @totalBooks = NULL;

CALL count_books_by_genre_pocedure_with_transaction(@genreName, @genreId, @totalBooks);
