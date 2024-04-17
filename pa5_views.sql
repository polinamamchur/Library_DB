USE library;
CREATE VIEW rented_books_view AS
SELECT
    b.title AS title,
    GROUP_CONCAT(a.author_name SEPARATOR ', ') AS authors,
    CONCAT(p.publisher_name, ', ', b.release_year) AS publisher_info,
    DATE_FORMAT(l.loan_date, '%M, %d %Y') AS loan_date,
    DATEDIFF(MAX(l.due_date), l.loan_date) AS days_to_end_term
FROM
    library.books b
INNER JOIN
    library.book2author ba ON b.id = ba.book_id
INNER JOIN
    library.authors a ON ba.author_id = a.id
INNER JOIN
    library.publisher p ON b.id = p.id
INNER JOIN
    library.loan l ON b.id = l.book_id
WHERE
    l.return_date IS NULL
GROUP BY
    b.title, p.publisher_name, b.release_year, l.loan_date;


CREATE INDEX idx_loan_book_id ON library.loan (book_id);
CREATE INDEX idx_loan_return_date ON library.loan (return_date);
CREATE INDEX idx_books_id ON library.books (id);
CREATE INDEX idx_authors_id ON library.authors (id);
CREATE INDEX idx_publisher_id ON library.publisher (id);


DROP VIEW rented_books_view;
SELECT * FROM library.rented_books_view;


