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