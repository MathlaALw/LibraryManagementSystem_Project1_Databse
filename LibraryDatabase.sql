-- Create database 
create database LibraryDatabase;

-- use database
use LibraryDatabase;

------------------

-- DDL: Create Tables

-- Library Table
CREATE TABLE Library (
    L_ID INT IDENTITY PRIMARY KEY ,
    L_Name VARCHAR(250) NOT NULL,
    Location VARCHAR(300) NOT NULL,
    Establish_Year INT CHECK (Establish_Year > 1800)
	
);


-- Libraries Contact Number
CREATE TABLE LibrariesContactNumber (
    L_ID INT NOT NULL,
    Contact_Number VARCHAR(20) NOT NULL,
    FOREIGN KEY (L_ID) REFERENCES Library(L_ID) ON DELETE CASCADE ON UPDATE CASCADE
	
);

-- Staff Table
CREATE TABLE Staff (
    Staff_ID INT IDENTITY PRIMARY KEY,
    FName VARCHAR(150) NOT NULL,
    LName VARCHAR(150) NOT NULL,
    Position VARCHAR(150) NOT NULL,
    L_ID INT,
    FOREIGN KEY (L_ID) REFERENCES Library(L_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Staff Contact Number
CREATE TABLE StaffContactNumber (
    Staff_ID INT NOT NULL,
    Contact_Number VARCHAR(20) NOT NULL,
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Members Table
CREATE TABLE Members (
    M_ID INT IDENTITY PRIMARY KEY,
    FName VARCHAR(300) NOT NULL,
    LName VARCHAR(300) NOT NULL,
    Email VARCHAR(250) NOT NULL UNIQUE,
    Member_Start_Date DATE NOT NULL
);

-- Member Phone Numbers
CREATE TABLE MembersPhoneNumber (
    M_ID INT NOT NULL,
    Phone_Number VARCHAR(20) NOT NULL,
    FOREIGN KEY (M_ID) REFERENCES Members(M_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Book Table
CREATE TABLE Book (
    Book_ID INT IDENTITY PRIMARY KEY,
    ISBN VARCHAR(100) NOT NULL UNIQUE,
    Title VARCHAR(250) NOT NULL,
    Genre VARCHAR(200) CHECK (Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')),
    Price DECIMAL(6,2) CHECK (Price > 0),
    Available_State BIT DEFAULT 1,
    Shelf_Location VARCHAR(50),
    M_ID INT,
    FOREIGN KEY (M_ID) REFERENCES Members(M_ID) ON DELETE SET NULL ON UPDATE CASCADE
);


-- LibraryBook Relationship Table
CREATE TABLE LibraryBook (
    L_ID INT NOT NULL,
    Book_ID INT NOT NULL,
    FOREIGN KEY (L_ID) REFERENCES Library(L_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Loan Table
CREATE TABLE Loan (
    
    Due_Date DATE NOT NULL,
    Return_Date DATE,
    Status VARCHAR(40) CHECK (Status IN ('Issued', 'Returned', 'Overdue')) DEFAULT 'Issued',
    Loan_Date DATE NOT NULL,
    M_ID INT NOT NULL,
    Book_ID INT NOT NULL,
    PRIMARY KEY (Loan_Date, M_ID, Book_ID),
    FOREIGN KEY (M_ID) REFERENCES Members(M_ID) ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID) ON DELETE NO ACTION ON UPDATE NO ACTION
       
);

-- Payment Table
CREATE TABLE Payment (
    P_ID INT IDENTITY PRIMARY KEY,
    P_Date DATE NOT NULL,
    Method VARCHAR(200) NOT NULL,
    Loan_Date DATE NOT NULL,
    M_ID INT NOT NULL,
    Book_ID INT NOT NULL,
    FOREIGN KEY (Loan_Date, M_ID, Book_ID) REFERENCES Loan(Loan_Date, M_ID, Book_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- ReviewBook Table
CREATE TABLE ReviewBook (
    Book_ID INT NOT NULL,
    M_ID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comments VARCHAR(300) DEFAULT 'No comments',
    Review_Date DATE,
    PRIMARY KEY (Book_ID, M_ID),
    FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (M_ID) REFERENCES Members(M_ID) ON DELETE NO ACTION  ON UPDATE NO ACTION 
);


--------------

-- DML:Insert Data into Tables
-- Library Table
SELECT * FROM Library;
INSERT INTO Library ( L_Name , Location , Establish_Year)
VALUES 
('Childrens Public Library','Muscat','1990'),
('Sultan Qaboos cultural center library', 'Muscat','1995'),
('Public Knowledge Library','Muscat','2000');

-- Libraries Contact Number
SELECT * FROM LibrariesContactNumber;
INSERT INTO LibrariesContactNumber (L_ID, Contact_Number)
VALUES
(1,'24557890'),
(1,'24559988'),
(2,'24557891'),
(3,'24557892'),
(3,'24184752');

-- Staff Table
SELECT * FROM Staff;
INSERT INTO Staff(FName , LName , Position , L_ID)
VALUES
('Salim','Al Bulushi','Librarian',1),
('Fatima','Al Shamsi','Assistant Librarian',1),
('Ahmed','Al Rashidi','Librarian',2),
('Aisha','Al Busaidi','Assistant Librarian',2),
('Khalid','Al Balushi','Librarian',3),
('Layla','Al Shamsi','Assistant Librarian',3);

-- StaffContactNumber Table

SELECT * FROM StaffContactNumber;
INSERT INTO StaffContactNumber (Staff_ID ,Contact_Number)
VALUES
(1,'92557890'),
(1,'99554874'),
(2,'92557891'),
(2,'99887766'),
(3,'92557892'),
(4,'92557893'),
(5,'92557894'),
(5,'99663322'),
(6,'92557895'),
(6,'95115995');

-- Book Table

SELECT * FROM Book;
INSERT INTO Book (ISBN,Title,Genre,Price,Available_State,Shelf_Location,M_ID)
VALUES 
('978-3-16-148410-0','The Great Gatsby','Fiction',10.99,'TRUE','A1',1),
('978-1-7432-7356-5','A Brief History of Time','Non-fiction',15.99,'TRUE','B2',1),
('978-0-06-112008-4','To Kill a Mockingbird','Fiction',12.99,'TRUE','C3',2),
('978-0-452-28423-4','The Catcher in the Rye','Children',9.99,'TRUE','D4',2),
('978-0-7432-7356-5','The Art of War','Non-fiction',14.99,'FALSE','E5',3),
('978-0-7432-7357-5','The Alchemist','Fiction',11.99,'TRUE','F6',3),
('978-0-7432-7358-5','The Da Vinci Code','Reference',13.99,'TRUE','G7',1),
('978-0-7432-7359-5','The Power of Habit','Non-fiction',16.99,'TRUE','H8',2),
('978-0-7432-7360-5','The 7 Habits of Highly Effective People','Reference',18.99,'TRUE','I9',3),
('978-0-7432-7361-5','The Fault in Our Stars','Fiction',10.99,'TRUE','K11',2),
('978-0-7432-7362-5','The Hunger Games','Reference',12.99,'TRUE','L12',3),
('978-0-7432-7363-5','The Book Thief','Children',11.99,'TRUE','M13',1);



ALTER TABLE Book
ALTER COLUMN Available_State VARCHAR(20);
----

ALTER TABLE Book
DROP CONSTRAINT DF__Book__Available___49C3F6B7;

----THEN --

ALTER TABLE Book
ALTER COLUMN Available_State VARCHAR(20);

----THEN --

ALTER TABLE Book
ADD CONSTRAINT DF_Book_Available_State
DEFAULT 'TRUE' FOR Available_State;

-- Members Table

SELECT * FROM Members;
INSERT INTO Members ( FName ,LName ,Email ,Member_Start_Date)
VALUES
('Ali','Alfarsi','alialfarsi@gmail.com','2023-01-01'),
('Noor','Alhatmi','nooralhatmi@gmail.com','2023-02-01'),
('Sara','Alwahabi','saraalwahaibi@gmail.com','2023-03-01'),
('Ahmed','Alnasri','ahmedalnasri@gmail.com','2023-04-01'),
('Mohammed','Alrashdi','mohammedalrashdi@gmail.com','2023-05-01'),
('Nasser','Alsalmi','nasseralsalmi@gmail.com','2023-06-01'),
('Layla','Alqasmi','laylaalqasmi@gmail.com','2023-07-01');

-- MembersPhoneNumber Table
SELECT * FROM MembersPhoneNumber;
INSERT INTO MembersPhoneNumber (M_ID,Phone_Number)
VALUES
(1,'92557890'),
(1,'99554874'),
(2,'92557891'),
(2,'99887766'),
(3,'92557892'),
(3,'99663322'),
(4,'92557893'),
(5,'92557894'),
(5,'99663322'),
(6,'92557895'),
(6,'95115995'),
(7,'92557896');

-- Loan Table

SELECT * FROM Loan;


INSERT INTO Loan (Due_Date,Return_Date,Status,Loan_Date,M_ID,Book_ID)
values 
('2023-01-20','2023-01-15','Returned','2023-01-10',1,30),
('2023-01-25','2023-01-30','Issued','2023-01-15',2,31),
('2023-02-10','2023-02-20','Overdue','2023-02-01',3,33),
('2023-02-15','2023-02-20','Issued','2023-02-05',4,34),
('2023-03-10','2023-03-15','Issued','2023-03-01',5,35),
('2023-03-15','2023-03-20','Issued','2023-03-05',6,36);


----- Payment Table
SELECT * FROM Payment;