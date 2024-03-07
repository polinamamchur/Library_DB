CREATE DATABASE library;
CREATE TABLE library.authors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(45) NOT NULL,
    birthday DATE NOT NULL,
    nationality VARCHAR(45) NOT NULL,
    biography TEXT NOT NULL
);

CREATE TABLE library.genre (
id INT AUTO_INCREMENT PRIMARY KEY,
genre_name VARCHAR(45) NOT NULL, 
genre_description VARCHAR(300) NOT NULL
);

CREATE TABLE library.publisher (
id INT AUTO_INCREMENT PRIMARY KEY,
publisher_name VARCHAR(45) NOT NULL,
book_name VARCHAR(45) NOT NULL,
address VARCHAR(100),
phone VARCHAR(45),
website VARCHAR(45),
book_id INT,
book_isbn VARCHAR(45)
);

CREATE TABLE library.books (
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(45) NOT NULL,
isbn VARCHAR(45) UNIQUE,
edition INT NOT NULL,
release_year INT,  
price DOUBLE, 
author_id INT,
genre_id INT NOT NULL,
publisher_id INT,
FOREIGN KEY (publisher_id) REFERENCES library.publisher(id)
);


CREATE TABLE library.customer (
customer_name VARCHAR(45) NOT NULL,
id INT AUTO_INCREMENT PRIMARY KEY,
address VARCHAR(100) NOT NULL,
phone VARCHAR(45) NOT NULL,
email VARCHAR(45) NOT NULL,
pass VARCHAR(32) NOT NULL
);


 CREATE TABLE library.loan (
id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT,
book_id INT NOT NULL, 
loan_date DATE NOT NULL,
due_date DATE NOT NULL,
return_date DATE,
FOREIGN KEY (customer_id) REFERENCES library.customer(id)
);


CREATE TABLE library.book2author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES library.books(id),
    FOREIGN KEY (author_id) REFERENCES library.authors(id)
);

CREATE TABLE library.book2genre (
    book_id INT,
    genre_id INT,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES library.books(id),
    FOREIGN KEY (genre_id) REFERENCES library.genre(id)
);


CREATE TABLE library.books2loan (
    book_id INT,
    loan_id INT,
    PRIMARY KEY (book_id, loan_id),
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (loan_id) REFERENCES loan(id)
);

CREATE TABLE library.books2customer (
	book_id INT,
    customer_id INT,
    PRIMARY KEY(book_id, customer_id),
    FOREIGN KEY (book_id) REFERENCES library.books(id),
    FOREIGN KEY (customer_id) REFERENCES library.customer(id)
);


-- 6.2. Create a clone table and 
-- CREATE TABLE library.books_clone LIKE library.books;

-- index the 'title' column 
-- CREATE INDEX idx_title ON library.books_clone (title);

-- Inserting data into library.authors
INSERT INTO library.authors (author_name, birthday, nationality, biography) VALUES
('J.K. Rowling', '1965-07-31', 'British', 'Joanne Rowling, better known by her pen name J.K. Rowling, is a British author, philanthropist, film producer, television producer, and screenwriter.'),
('George R.R. Martin', '1948-09-20', 'American', 'George Raymond Richard Martin, also known as GRRM, is an American novelist and short story writer in the fantasy, horror, and science fiction genres.'),
('Stephen King', '1947-09-21', 'American', 'Stephen Edwin King is an American author of horror, supernatural fiction, suspense, crime, science-fiction, and fantasy novels.'),
('J.R.R. Tolkien', '1892-01-03', 'British', 'John Ronald Reuel Tolkien was an English writer, poet, philologist, and academic, best known as the author of the high fantasy works The Hobbit and The Lord of the Rings.'),
('Harper Lee', '1926-04-28', 'American', 'Nelle Harper Lee was an American novelist best known for her 1960 novel To Kill a Mockingbird.'),
('Agatha Christie', '1890-09-15', 'British', 'Dame Agatha Mary Clarissa Christie, Lady Mallowan, was an English writer known for her sixty-six detective novels and fourteen short story collections.'),
('Leo Tolstoy', '1828-09-09', 'Russian', 'Count Lev Nikolayevich Tolstoy, usually referred to in English as Leo Tolstoy, was a Russian writer who is regarded as one of the greatest authors of all time.'),
('Virginia Woolf', '1882-01-25', 'British', 'Adeline Virginia Woolf was an English writer, considered one of the most important modernist 20th-century authors and also a pioneer in the use of stream of consciousness as a narrative device.'),
('Mark Twain', '1835-11-30', 'American', 'Samuel Langhorne Clemens, known by his pen name Mark Twain, was an American writer, humorist, entrepreneur, publisher, and lecturer.'),
('Ernest Hemingway', '1899-07-21', 'American', 'Ernest Miller Hemingway was an American novelist, short-story writer, journalist, and sportsman.');

-- Inserting data into library.genre
INSERT INTO library.genre (genre_name, genre_description) VALUES
('Fantasy', 'A genre of speculative fiction set in a fictional universe, often inspired by real-world myth and folklore.'),
('Horror', 'A genre of speculative fiction which is intended to frighten, scare, disgust, or startle its readers by inducing feelings of horror and terror.'),
('Fiction', 'A genre of literature that deals with imaginary and invented situations and characters.'),
('Mystery', 'A genre of fiction that revolves around the solution of a crime, usually a murder.'),
('Historical Fiction', 'A genre of fiction that takes place in the past. Often the settings are real historical events or periods.'),
('Modernist', 'A genre of literature that emerged in the late 19th and early 20th centuries, characterized by a deliberate break from traditional forms and styles.'),
('Adventure', 'A genre of fiction that focuses on the exploration of unknown territories and the overcoming of obstacles.'),
('Science Fiction', 'A genre of speculative fiction that typically deals with imaginative and futuristic concepts such as advanced science and technology, space exploration, time travel, parallel universes, and extraterrestrial life.'),
('Romance', 'A genre of fiction that focuses on romantic love and emotional relationships between characters.'),
('Thriller', 'A genre of fiction that is characterized by fast-paced plots, frequent action, and intense suspense.');

-- Inserting data into library.books
INSERT INTO library.books (title, isbn, edition, release_year, price, author_id, genre_id) VALUES
('Harry Potter and the Philosopher''s Stone', '9780747532743', 1, 1997, 20.00, 1, 1),
('A Game of Thrones', '9780553381689', 1, 1996, 25.00, 2, 1),
('The Shining', '9780307743657', 1, 1977, 18.00, 3, 2),
('The Lord of the Rings', '9780544003415', 1, 1954, 30.00, 4, 1),
('To Kill a Mockingbird', '9780061120084', 1, 1960, 22.00, 5, 3),
('Murder on the Orient Express', '9780007119295', 1, 1934, 15.00, 6, 4),
('War and Peace', '9780140447934', 1, 1869, 35.00, 7, 7),
('Mrs Dalloway', '9780156628709', 1, 1925, 16.00, 8, 8),
('The Adventures of Huckleberry Finn', '9780142437179', 1, 1884, 14.00, 9, 5),
('The Old Man and the Sea', '9780684801223', 1, 1952, 19.00, 10, 5);


-- Inserting data into library.publisher
INSERT INTO library.publisher (publisher_name, book_name, book_isbn, address, phone, website) VALUES
('Bloomsbury Publishing', 'Harry Potter and the Philosopher''s Stone', '9780747532743', '50 Bedford Square, London WC1B 3DP, United Kingdom', '+44 20 7631 5600', 'www.bloomsbury.com'),
('Bantam Spectra', 'A Game of Thrones', '9780553381689', 'Random House, 1745 Broadway, New York, NY 10019, United States', '+1 212-782-9000', 'www.randomhousebooks.com'),
('Anchor Books', 'The Shining', '9780307743657', 'New York, NY 10019, United States', '+1 212-782-9000', 'www.randomhousebooks.com'),
('Houghton Mifflin Harcourt', 'The Lord of the Rings', '9780544003415', '125 High Street, Boston, MA 02110, United States', '+1 617-351-5000', 'www.hmhco.com'),
('HarperCollins', 'To Kill a Mockingbird', '9780061120084', '195 Broadway, New York, NY 10007, United States', '+1 212-207-7000', 'www.harpercollins.com'),
('William Collins, Sons', 'Murder on the Orient Express', '9780007119295', '195 Broadway, New York, NY 10007, United States', '+1 212-207-7000', 'www.harpercollins.com'),
('William Clowes & Sons', 'War and Peace', '9780140447934', 'Suffolk, England, United Kingdom', '+44 1473 289200', 'www.penguin.co.uk'),
('Harvest Books', 'Mrs Dalloway', '9780156628709', '125 High Street, Boston, MA 02110, United States', '+1 617-351-5000', 'www.hmhco.com'),
('Penguin Classics', 'The Adventures of Huckleberry Finn', '9780142437179', '80 Strand, London WC2R 0RL, United Kingdom', '+44 20 7139 3000', 'www.penguin.co.uk'),
('Scribner', 'The Old Man and the Sea', '9780684801223', '1230 Avenue of the Americas, New York, NY 10020, United States', '+1 212-698-7000', 'www.simonandschuster.com');



-- Inserting data into library.customer
INSERT INTO library.customer (customer_name, address, phone, email, pass) VALUES
('John Doe', '123 Main St, Anytown, USA', '555-123-4567', 'johndoe@example.com', 'password123'),
('Jane Smith', '456 Elm St, Springfield, USA', '555-987-6543', 'janesmith@example.com', 'password456'),
('Alice Johnson', '789 Oak St, Lakeside, USA', '555-567-8901', 'alicejohnson@example.com', 'password789'),
('Bob Brown', '321 Pine St, Riverside, USA', '555-234-5678', 'bobbrown@example.com', 'passwordabc'),
('Emma Davis', '654 Birch St, Mountainview, USA', '555-876-5432', 'emmadavis@example.com', 'passworddef'),
('Michael Wilson', '987 Cedar St, Oceanview, USA', '555-345-6789', 'michaelwilson@example.com', 'passwordghi'),
('Sarah Martinez', '210 Maple St, Parkside, USA', '555-654-3210', 'sarahmartinez@example.com', 'passwordjkl'),
('David Thompson', '543 Walnut St, Hilltop, USA', '555-789-0123', 'davidthompson@example.com', 'passwordmno'),
('Emily Taylor', '876 Pineapple St, Beachside, USA', '555-012-3456', 'emilytaylor@example.com', 'passwordpqr'),
('Christopher Garcia', '109 Coconut St, Palmtree, USA', '555-890-1234', 'christophergarcia@example.com', 'passwordstu');


-- Inserting data into library.loan
INSERT INTO library.loan (customer_id, book_id, loan_date, due_date, return_date) VALUES
(1, 1, '2020-01-29', '2020-03-14', '2020-03-05'),
(2, 2, '2020-01-29', '2020-03-14', '2020-04-12'),
(3, 3, '2021-02-28', '2021-03-14', NULL),
(4, 4, '2021-02-28', '2021-03-14', '2021-04-10'),
(5, 5, '2022-02-28', '2022-03-14', '2022-05-13'),
(6, 6, '2022-02-28', '2022-03-14', NULL),
(7, 7, '2023-03-28', '2023-03-14', NULL),
(8, 8, '2023-03-28', '2023-03-14', NULL),
(9, 9, '2024-04-29', '2024-03-14', NULL),
(10, 10, '2024-05-29', '2024-03-14', NULL);

-- Inserting data into library.book2author
INSERT INTO library.book2author (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Inserting data into library.book2genre
INSERT INTO library.book2genre (book_id, genre_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(1, 2),
(2, 3),
(3, 4),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10)
ON DUPLICATE KEY UPDATE book_id = book_id;


-- Inserting data into library.books2loan
INSERT INTO library.books2loan (book_id, loan_id) VALUES
(1, 1),
(3, 1),
(4, 1),
(2, 2),
(3, 3),
(2, 1),
(3, 2),
(4, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10)
ON DUPLICATE KEY UPDATE book_id = book_id;


-- Inserting data into library.books2customer
INSERT INTO library.books2customer (book_id, customer_id) VALUES
(1, 1),
(3, 1),
(4, 1),
(2, 2),
(3, 3),
(2, 1),
(3, 2),
(4, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10)
ON DUPLICATE KEY UPDATE book_id = book_id;

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





