USE master
GO
IF EXISTS (SELECT * FROM sysdatabases  WHERE NAME='Library')
	DROP DATABASE Library
GO
CREATE DATABASE Library
GO
USE Library
GO

CREATE TABLE Books(
	BookId INT PRIMARY KEY NOT NULL,
	Title VARCHAR(50) NOT NULL,
	Author VARCHAR(30) NOT NULL,
	ISBN INT NOT NULL, 
	PublisherId INT NOT NULL,  
	GenreId INT NOT NULL, 
	IssueYear INT NOT NULL
);

CREATE TABLE Readers(
	ReaderId INT PRIMARY KEY NOT NULL, 
	ReaderName VARCHAR(10) NOT NULL,
	ReaderAddress VARCHAR(30), 
	ReaderPhone VARCHAR(10) NOT NULL, 
	ReaderEmail VARCHAR(30)
);

CREATE TABLE Loans(
	LoanId INT PRIMARY KEY NOT NULL, 
	BookId INT NOT NULL, 
	ReaderId INT NOT NULL, 
	LoanDate DATE, 
	ReturnDate DATE
);

CREATE TABLE Reservations(
	ReservationId INT PRIMARY KEY NOT NULL, 
	BookId INT NOT NULL, 
	ReaderId INT NOT NULL
);

CREATE TABLE Publishers(
	PublisherId INT PRIMARY KEY NOT NULL, 
	PublisherName VARCHAR(20) NOT NULL, 
	PublisherAddress VARCHAR(30), 
	PublisherPhone VARCHAR(10) NOT NULL
);

CREATE TABLE Genre(
	GenreId INT PRIMARY KEY NOT NULL, 
	GenreName VARCHAR(30) NOT NULL
);

ALTER TABLE Books
ADD UNIQUE (ISBN);

ALTER TABLE Readers
ADD UNIQUE (ReaderName, ReaderAddress);

ALTER TABLE Publishers
ADD UNIQUE (PublisherAddress);

ALTER TABLE Loans
ADD CONSTRAINT checkDate CHECK (LoanDate < ReturnDate);

ALTER TABLE Readers
ADD CONSTRAINT checkPhoneR CHECK (ReaderPhone NOT LIKE '%[^0-9]%');

ALTER TABLE Publishers
ADD CONSTRAINT checkPhoneP CHECK (PublisherPhone NOT LIKE '%[^0-9]%');


ALTER TABLE Readers
ADD CONSTRAINT checkEmail CHECK (ReaderEmail LIKE '%_@_%._%');

ALTER TABLE Books
ADD CONSTRAINT fkPublisher FOREIGN KEY (PublisherId)
REFERENCES Publishers(PublisherId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Books
ADD CONSTRAINT fkGenre FOREIGN KEY (GenreId)
REFERENCES Genre(GenreId) 
ON UPDATE CASCADE
ON DELETE NO ACTION;

ALTER TABLE Loans
ADD CONSTRAINT fkBookLoan FOREIGN KEY (BookId)
REFERENCES Books(BookId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Reservations
ADD CONSTRAINT fkBookRes FOREIGN KEY (BookId)
REFERENCES Books(BookId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Loans
ADD CONSTRAINT fkReaderLoan FOREIGN KEY (ReaderId)
REFERENCES Readers(ReaderId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Reservations
ADD CONSTRAINT fkReaderRes FOREIGN KEY (ReaderId)
REFERENCES Readers(ReaderId)
ON DELETE CASCADE
ON UPDATE CASCADE;

INSERT INTO Books (BookId, Title, Author, ISBN, PublisherId, GenreId, IssueYear) VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', 9780060935467, 1, 1, 1980),
(2, '1984', 'George Orwell', 9780451524935, 2, 2, 1949), 
(3, 'The Great Gatsby', 'F. Scott Fitzgerald', 9780743273565, 3, 3, 1925),
(4, 'One Hundred Years of Solitude', 'Gabriel Garcia Marquez', 9780060883287, 4, 4, 1967),
(5, 'Pride and Prejudice', 'Jane Austen', 9780141439518, 5, 5, 1813),
(6, 'The Catcher in the Rye', 'J.D. Salinger', 9780316769488, 1, 6, 1951),
(7, 'The Hobbit', 'J.R.R. Tolkien', 9780547928227, 6, 7, 1937),
(8, 'Fahrenheit 451', '	Ray Bradbury', 9781451673319, 2, 2, 1953),
(9, 'Moby Dick', 'Herman Melville', 9781503280786, 7, 8, 1851),
(10, 'Crime and Punishment', 'Fyodor Dostoevsky', 9780486415871, 8, 9, 1866);

INSERT INTO Publishers (PublisherId, PublisherName, PublisherAddress, PublisherPhone) VALUES
(1, 'HarperCollins', '195 Broadway, New York, NY, USA', '+1 212-207-7000'),
(2, 'Penguin Books', '80 Strand, London, UK', '+44 20 7139 3000'),
(3, 'Scribner', '1230 Avenue of the Americas, New York, NY, USA', '+1 212-698-7000'),
(4, 'Harper & Row', '10 East 53rd Street, New York, NY, USA', '+1 212-207-7000'),
(5, 'T. Egerton, Whitehall', '32 Whitehall, London, UK', '+44 20 7139 3000'),
(6, 'Houghton Mifflin Harcourt', '125 High Street, Boston, MA, USA', '+1 617-351-5000'),
(7, 'CreateSpace Independent', '100 Enterprise Way, Scotts Valley, CA, USA', '+1 831-761-8200'),
(8, 'Dover Publications', '31 East 2nd Street, Mineola, NY, USA', '+1 516-294-7000');

INSERT INTO Genre (GenreId, GenreName) VALUES
(1,	'Fiction'),
(2,	'Dystopian'),
(3,	'Classic'),
(4,	'Magical Realism'),
(5,	'Romance'),
(6,	'Coming-of-age'),
(7,	'Fantasy'),
(8,	'Adventure'),
(9,	'Psychological');

INSERT INTO Readers (ReaderId, ReaderName, ReaderAddress, ReaderPhone, ReaderEmail) VALUES
(1, 'Ivan Ivanov', '1234 Sofia, Bulgaria', '+359 88 123 4567', 'ivan.ivanov@example.com'),
(2, 'Petya Petrova', '5678 Plovdiv, Bulgaria', '+359 89 234 5678', 'petya.petrova@example.com'),
(3, 'Georgi Georgiev', '9101 Varna, Bulgaria', '+359 87 345 6789', 'georgi.georgiev@example.com'),
(4, 'Maria Marinova', '1123 Burgas, Bulgaria', '+359 86 456 7890', 'maria.marinova@example.com'),
(5, 'Dimitar Dimitrov', '1345 Ruse, Bulgaria', '+359 85 567 8901', 'dimitar.dimitrov@example.com'),
(6, 'Elena Petrova', '1567 Stara Zagora, Bulgaria', '+359 84 678 9012', 'elena.petrova@example.com'),
(7, 'Nikolay Nikolov', '1789 Pleven, Bulgaria', '+359 83 789 0123', 'nikolay.nikolov@example.com'),
(8, 'Viktoria Vasileva', '1923 Blagoevgrad, Bulgaria', '+359 82 890 1234', 'viktoria.vasileva@example.com'),
(9, 'Kiril Kirilov', '2134 Veliko Tarnovo, Bulgaria', '+359 81 901 2345', 'kiril.kirilov@example.com'),
(10, 'Svetlana Svetoslavova', '2345 Haskovo, Bulgaria', '+359 80 012 3456', 'svetlana.svetoslavova@example.com');

INSERT INTO Loans (LoanId, BookId, ReaderId, LoanDate, ReturnDate) VALUES
(1, 1, 1, '2024-05-01', '2024-05-15'),
(2, 2, 2, '2024-05-02', '2024-05-16'),
(3, 3, 3, '2024-05-03', '2024-05-17'),
(4, 4, 4, '2024-05-04', '2024-05-18'),
(5, 5, 5, '2024-05-05', '2024-05-19'),
(6, 6, 6, '2024-05-06', '2024-05-20'),
(7, 7, 7, '2024-05-07', '2024-05-21'),
(8, 8, 8, '2024-05-08', '2024-05-22'),
(9, 9, 9, '2024-05-09', '2024-05-23'),
(10, 10, 10, '2024-05-10', '2024-05-24');

INSERT INTO Reservations (ReservationId, BookId, ReaderId) VALUES
(1, 1, 2),
(2, 3, 1),
(3, 5, 4),
(4, 7, 3),
(5, 9, 5),
(6, 2, 6),
(7, 4, 7),
(8, 6, 8),
(9, 8, 9),
(10, 10, 10);

