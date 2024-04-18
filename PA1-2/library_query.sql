-- top 5 the most poular genres
SELECT genre.genre_name, COUNT(1) AS Book_Count -- 1 
FROM library.books 
JOIN library.genre ON books.genre_id = genre.id
GROUP BY genre.genre_name
ORDER BY Book_Count DESC
LIMIT 5;


-- top 3 authors with the most expencive books
SELECT authors.id, authors.author_name, books.title, books.price
FROM library.authors
JOIN library.books ON authors.id = books.author_id
ORDER BY books.price DESC
LIMIT 3;

-- the total number of books that each customer has borrowed and cost of all these books for each customer
SELECT customer.customer_name, COUNT(1) AS Total_Books_Borrowed, SUM(books.price) AS Total_Price_Loaned
FROM library.customer 
JOIN library.loan ON customer.id = loan.customer_id
JOIN library.books ON loan.book_id = books.id
GROUP BY customer.customer_name;

-- books borrowed by customers and published before 1990
SELECT customer.customer_name AS Customer_Name, books.title AS Book_Title, books.price AS Book_Price
FROM library.customer 
JOIN library.loan ON customer.id = loan.customer_id
JOIN library.books ON loan.book_id = books.id
WHERE books.release_year < 1990;

-- names of authors whose books were not returned
SELECT DISTINCT authors.author_name
FROM library.authors 
INNER JOIN library.books ON authors.id = books.author_id
INNER JOIN library.loan ON books.id = loan.book_id
WHERE loan.return_date IS NULL
GROUP BY authors.author_name, books.title;

SELECT authors.author_name, YEAR(loan.due_date) AS return_year
FROM library.books 
INNER JOIN library.authors ON books.author_id = authors.id
INNER JOIN library.loan ON books.id = loan.book_id 
WHERE loan.return_date IS NULL AND YEAR(loan.due_date) 
IN (SELECT DISTINCT YEAR(due_date) FROM library.loan WHERE return_date IS NOT NULL)
ORDER BY return_year;

-- Second assignment
-- authors who have written books in multiple genres
SELECT DISTINCT authors.author_name
FROM library.authors 
INNER JOIN library.book2author ON authors.id = book2author.author_id
INNER JOIN library.books ON book2author.book_id = books.id
INNER JOIN library.book2genre ON books.id = book2genre.book_id
GROUP BY authors.id
HAVING COUNT(DISTINCT book2genre.genre_id) > 1;

-- customers who have borrowed the most books
SELECT customer.id, customer.customer_name, COUNT(books2loan.book_id) AS num_books_borrowed
FROM library.customer 
JOIN library.loan ON customer.id = loan.customer_id
JOIN library.books2loan ON loan.id = books2loan.loan_id
GROUP BY customer.id, customer.customer_name
ORDER BY num_books_borrowed DESC
LIMIT 5;


-- customers who have borrowed the books during the month
SELECT customer.id, customer.customer_name, 
    MONTH(loan.loan_date) AS loan_month,
    COUNT(books2loan.book_id) AS num_books_borrowed
FROM library.customer 
JOIN library.loan ON customer.id = loan.customer_id
JOIN library.books2loan ON loan.id = books2loan.loan_id
GROUP BY customer.id, customer.customer_name, loan_month
ORDER BY loan_month DESC, num_books_borrowed DESC;


SELECT customer.customer_name, SUM(books.price) AS total_price_paid
FROM library.customer 
INNER JOIN library.books2customer ON customer.id = books2customer.customer_id
INNER JOIN library.books ON books2customer.book_id = books.id
GROUP BY customer.customer_name
ORDER BY total_price_paid DESC;

SELECT books.title AS book_title, genre.genre_name
FROM library.books 
JOIN library.book2genre ON books.isbn = book2genre.isbn
JOIN library.genre ON book2genre.genre_id = genre.id
WHERE genre.genre_name = 'Fantasy';
