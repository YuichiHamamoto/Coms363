-- create a database for library
create database library;
use library;

-- create a book table
CREATE TABLE Books (
isbn CHAR(10),
title VARCHAR(80),
author VARCHAR(80),
qty_available INTEGER,
year_pub INTEGER,
primary key (isbn)
);

CREATE TABLE Visitors (
card CHAR(10),
vname VARCHAR(80),
username VARCHAR(20),
phone CHAR(9),
vstatus VARCHAR(20),
max_book INTEGER,
primary key (card)
);

CREATE TABLE borrow (
card CHAR(10),
isbn CHAR(10),
taken_date DATE,
return_date DATE,
primary key (card, isbn, taken_date),
foreign key (card) references Visitors(card),
foreign key (isbn) references Books(isbn)
);