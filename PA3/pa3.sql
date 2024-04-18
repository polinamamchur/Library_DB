-- = with non-correlated subqueries result
-- Select the book titles and their respective authors' names where the author's nationality is British.
SELECT books.title, authors.author_name
FROM library.books 
JOIN library.book2author ON books.id = book2author.book_id
JOIN library.authors ON book2author.author_id = authors.id
WHERE authors.nationality = 'British';

-- Update the price of all books published by HarperCollins to $24.00
UPDATE library.books 
JOIN library.publisher ON books.publisher_id = publisher.id
SET books.price = 24.00
WHERE publisher.publisher_name = 'HarperCollins';

-- Delete all loan entries where the return date is bigger than 2020-03-05
DELETE FROM library.books2loan
WHERE loan_id IN (SELECT id 
FROM library.loan 
WHERE return_date > '2020-03-05'
);

-- IN with non-correlated subqueries result
-- Select all books with a price greater than the average price
SELECT *
FROM library.books
WHERE price > ANY (
    SELECT AVG(price)
    FROM library.books
);

-- Increase the price by 10%
UPDATE library.books
SET price = price * 1.1  
WHERE genre_id IN (
    SELECT id
    FROM library.genre
    WHERE genre_name = 'Fantasy'
);

-- Delete all loan entries for books published after the year 2000
DELETE FROM library.loan
WHERE book_id IN (
    SELECT id
    FROM library.books
    WHERE release_year > 2000
);

-- NOT IN with non-correlated subqueries result
-- Select all books that are not in the 'Horror' genre
SELECT *
FROM library.books
WHERE genre_id NOT IN (
    SELECT id
    FROM library.genre
    WHERE genre_name = 'Horror'
);

-- Update the price of books that are not published by 'Penguin Classics' to increase by 15%
UPDATE library.books
SET price = price * 1.15
WHERE publisher_id NOT IN (
    SELECT id
    FROM library.publisher
    WHERE publisher_name = 'Penguin Classics'
);

-- Delete all all customer records where the email address does not belong to the domain 'example.com'
DELETE FROM library.customer
WHERE email NOT LIKE '%@example.com';

-- EXISTS with non-correlated subqueries result
-- Select all books that have at least one associated loan
SELECT *
FROM library.books 
WHERE EXISTS (
    SELECT 1
    FROM library.books2loan 
    WHERE books2loan.book_id = books.id
);

-- Update the price of books published by HarperCollins to increase by 10%
UPDATE library.books 
SET price = price * 1.1
WHERE EXISTS (
    SELECT 1
    FROM library.publisher 
    WHERE publisher.id = books.publisher_id
    AND publisher.publisher_name = 'HarperCollins'
);

-- Delete loans where the return date is not yet updated and the due date is past
DELETE FROM library.books2loan
WHERE loan_id IN (
    SELECT loan.id
    FROM library.loan 
    WHERE loan.return_date IS NULL
    AND loan.due_date < CURDATE()
);

-- NOT EXISTS with non-correlated subqueries result
-- books that are not classified under the genre 'Romance'
SELECT *
FROM library.books 
WHERE NOT EXISTS (
    SELECT 1
    FROM library.genre 
    WHERE genre.id = books.genre_id
    AND genre.genre_name = 'Romance'
);

-- increase the price of books by 10% for those books that are not on loan
UPDATE library.books 
SET price = price * 1.1
WHERE NOT EXISTS (
    SELECT 1
    FROM library.loan 
    WHERE loan.book_id = books.id
);

-- Delete customers who haven't borrowed any books
DELETE FROM library.customer 
WHERE NOT EXISTS (
    SELECT 1
    FROM library.books2customer 
    WHERE books2customer.customer_id = customer.id
);

-- = with correlated subqueries result
-- SELECT all columns where the genre of the book matches the genre ID of the 'Fantasy' 
SELECT *
FROM library.books 
WHERE books.genre_id = (
    SELECT id
    FROM library.genre 
    WHERE genre.genre_name = 'Fantasy'
);


-- UPDATE sets the price of a book with a specific ISBN to $16.50
UPDATE library.books 
SET price = 16.50
WHERE id = (
    SELECT id
    FROM (SELECT id
        FROM library.books
        WHERE isbn = '9780142437179'
    ) AS subquery
);

--  remove entries from the library.books2customer where the customer_id matches the ID of a specific customer
DELETE FROM library.books2customer
WHERE customer_id = (
    SELECT id
    FROM library.customer
    WHERE id = 2
);


-- IN with correlated subqueries result
-- the names of customers who have loans overdue
SELECT DISTINCT customer.customer_name
FROM library.customer 
WHERE EXISTS (
    SELECT 1
    FROM library.loan 
    WHERE loan.customer_id = customer.id
    AND loan.due_date < CURDATE() AND loan.return_date IS NULL
);

-- Update the release year of a book with a specific ISBN
UPDATE library.books
SET release_year = 1998
WHERE isbn IN (
    SELECT isbn FROM (
        SELECT isbn
        FROM library.books
        WHERE isbn = '9780747532743') 
);

-- Delete a loan record for a specific book and customer
DELETE FROM library.books2loan
WHERE loan_id IN (
    SELECT id
    FROM library.loan
    WHERE book_id = 1
    AND customer_id = 1
);

-- NOT IN with correlated subqueries result
-- the names of customers who haven't borrowed any books
SELECT customer.customer_name
FROM library.customer 
WHERE customer.id NOT IN (
    SELECT DISTINCT customer_id
    FROM library.loan
);

-- Update the edition of books that haven't been borrowed by any customer to edition 2
UPDATE library.books
SET edition = 2
WHERE id NOT IN (
    SELECT book_id
    FROM library.books2loan
);

-- Delete customers who haven't borrowed any books
DELETE FROM library.customer
WHERE id NOT IN (
    SELECT DISTINCT loan.customer_id
    FROM library.loan 
);

-- EXISTS with correlated subqueries result
-- the names of customers who have borrowed at least one book
SELECT customer.customer_name
FROM library.customer 
WHERE EXISTS (
    SELECT 1
    FROM library.loan 
    WHERE loan.customer_id = customer.id
);

-- Update the edition of books that have been borrowed by any customer to edition 2
UPDATE library.books 
SET edition = 2
WHERE EXISTS (
    SELECT 1
    FROM library.books2loan
    WHERE books2loan.book_id = books.id
);

DELETE FROM library.books2customer 
WHERE EXISTS (
    SELECT 1
    FROM library.customer 
    WHERE customer.id = books2customer.customer_id
    AND customer.id = 1
);


-- NOT EXISTS with correlated subqueries result
-- selects the names of customers who have not taken out any loans
SELECT customer.customer_name
FROM library.customer 
WHERE NOT EXISTS (
    SELECT 1
    FROM library.loan 
    WHERE loan.customer_id = customer.id
);

--  UPDATE increases the edition number of books by 1 for books that have not been loaned out
UPDATE library.books
SET edition = edition + 1
WHERE NOT EXISTS (
    SELECT 1
    FROM library.books2loan 
    WHERE books2loan.book_id = library.books.id
);

-- Delete customers who have not borrowed any books
DELETE FROM library.customer 
WHERE NOT EXISTS (
    SELECT 1
    FROM library.loan 
    WHERE loan.customer_id = customer.id
);

--  UNION / UNION ALL / INTERSECT / EXCEPT
-- UNION to get the titles of books borrowed by customers along with their names
SELECT books.title AS borrowed_books
FROM library.books 
JOIN library.books2loan ON books.id = books2loan.book_id
JOIN library.loan ON books2loan.loan_id = loan.id
JOIN library.customer ON loan.customer_id = customer.id
UNION
SELECT books.title AS borrowed_books
FROM library.books 
JOIN library.books2customer ON books.id = books2customer.book_id
JOIN library.customer ON books2customer.customer_id = customer.id;

-- UNION ALL to get the titles of books borrowed by customers(including duplicates)
SELECT books.title AS borrowed_books
FROM library.books 
JOIN library.books2loan ON books.id = books2loan.book_id
JOIN library.loan ON books2loan.loan_id = loan.id
JOIN library.customer ON loan.customer_id = customer.id
UNION ALL
SELECT books.title AS borrowed_books
FROM library.books 
JOIN library.books2customer ON books.id = books2customer.book_id
JOIN library.customer ON books2customer.customer_id = customer.id;

-- INTERSECT to get the titles of books borrowed by customers and those that are also listed in books2loan
SELECT books.title AS borrowed_books
FROM library.books 
JOIN library.books2loan ON books.id = books2loan.book_id
JOIN library.loan ON books2loan.loan_id = loan.id
JOIN library.customer ON loan.customer_id = customer.id
INTERSECT
SELECT books.title AS borrowed_books
FROM library.books 
JOIN library.books2customer ON books.id = books2customer.book_id
JOIN library.customer ON books2customer.customer_id = customer.id;

-- EXCEPT to get the titles of books borrowed by customers but not listed in books2loan
SELECT books.title AS borrowed_books
FROM library.books 
JOIN library.books2loan ON books.id = books2loan.book_id
JOIN library.loan ON books2loan.loan_id = loan.id
JOIN library.customer ON loan.customer_id = customer.id
EXCEPT
SELECT books.title AS borrowed_books
FROM library.books 
JOIN library.books2customer ON books.id = books2customer.book_id
JOIN library.customer ON books2customer.customer_id = customer.id;







