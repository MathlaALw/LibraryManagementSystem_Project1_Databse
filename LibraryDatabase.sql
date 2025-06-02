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
--------Modify payment table adding Amount ----------------
ALTER TABLE Payment
DROP COLUMN P_ID;

ALTER TABLE Payment
DROP CONSTRAINT PK__Payment__A3420A778982A628;

ALTER TABLE Payment
ADD Amount DECIMAL(10,2) CHECK (Amount > 0);

UPDATE Payment
SET Amount = 100.00;

ALTER TABLE Library
ADD TotalRevenue DECIMAL(10,2) CHECK (TotalRevenue > 0);

---------------
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
INSERT INTO Payment (P_Date , Method , Loan_Date ,M_ID ,Book_ID)
VALUES 
('2023-01-15','Cash','2023-01-10',1,30),
('2023-01-20','Credit Card','2023-01-15',2,31),
('2023-02-10','Debit Card','2023-02-01',3,33),
('2023-02-15','Cash','2023-02-05',4,34),
('2023-03-05','Credit Card','2023-03-01',5,35),
('2023-03-15','Debit Card','2023-03-05',6,36);

-- Review Table

SELECT * FROM ReviewBook;

INSERT INTO ReviewBook ( Book_ID, M_ID,Rating,Comments,Review_Date)
VALUES
(30,1,5,'Excellent book!','2023-01-15'),
(31,1,4,'Very informative.','2023-01-20'),
(32,2,3,'Good read.','2023-02-10'),
(33,2,2,'Not my type.','2023-02-15'),
(34,3,4,'Interesting concepts.','2023-03-05'),
(35,3,5,'Loved it!','2023-03-15'),
(36,4,3,'Average book.','2023-04-01'),
(37,4,4,'Great for beginners.','2023-04-05');


--- LibraryBook
INSERT INTO LibraryBook ( L_ID, Book_ID)
VALUES
(1,30),
(1,31),
(1,32),
(1,33),
(2,34),
(2,35),
(2,36),
(2,37),
(3,38),
(3,39),
(3,40),
(3,41);
----------------------
-- Testing Case -- 

--DML - Delete and Update

--Try deleting a member who: 
-- • Has existing loans 
DELETE FROM Members WHERE M_ID = 1;
--Error --
Msg 547, Level 16, State 0, Line 286
The DELETE statement conflicted with the REFERENCE constraint "FK__ReviewBook__M_ID__6754599E". The conflict occurred in database "LibraryDatabase", table "dbo.ReviewBook", column 'M_ID'.

You cant delete a member who has active loans

-- • Has written book reviews
DELETE FROM Members WHERE M_ID = 2;
-- Error --
Msg 547, Level 16, State 0, Line 288
The DELETE statement conflicted with the REFERENCE constraint "FK__ReviewBook__M_ID__6754599E". The conflict occurred in database "LibraryDatabase", table "dbo.ReviewBook", column 'M_ID'.

You cant delete a member who has active loans

--Try deleting a book that: 
-- • Is currently on loan 
DELETE FROM Book WHERE Book_ID = 30;
-- Error --
Msg 547, Level 16, State 0, Line 306
The DELETE statement conflicted with the REFERENCE constraint "FK__Loan__Book_ID__5EBF139D". The conflict occurred in database "LibraryDatabase", table "dbo.Loan", column 'Book_ID'.


Foreign key conflict with Loan

---• Has multiple reviews attached to it 
DELETE FROM Book WHERE Book_ID = 30;
-- Error --
Msg 547, Level 16, State 0, Line 315
The DELETE statement conflicted with the REFERENCE constraint "FK__Loan__Book_ID__5EBF139D". The conflict occurred in database "LibraryDatabase", table "dbo.Loan", column 'Book_ID'.
The statement has been terminated.


-- Try inserting a loan for: 
INSERT INTO Loan (Book_ID, M_ID, Loan_Date) VALUES (30, 80, '2024-05-18');
-- • A member who doesn’t exist 
-- Error --
Msg 515, Level 16, State 2, Line 324
Cannot insert the value NULL into column 'Due_Date', table 'LibraryDatabase.dbo.Loan'; column does not allow nulls. INSERT fails.
The statement has been terminated.



-- • A book that doesn’t exist 
INSERT INTO Loan (Book_ID, M_ID, Loan_Date) VALUES (30, 1, '2024-05-18');
-- Error --
Msg 515, Level 16, State 2, Line 334
Cannot insert the value NULL into column 'Due_Date', table 'LibraryDatabase.dbo.Loan'; column does not allow nulls. INSERT fails.
The statement has been terminated.



--Try updating a book’s genre to: 
-- • A value not included in your allowed genre list (e.g., 'Sci-Fi') 
UPDATE Book SET Genre = 'Sci-Fi' WHERE Book_ID = 30;
-- Error --
Msg 547, Level 16, State 0, Line 344
The UPDATE statement conflicted with the CHECK constraint "CK__Book__Genre__47DBAE45". The conflict occurred in database "LibraryDatabase", table "dbo.Book", column 'Genre'.
The statement has been terminated.


--Try inserting a payment with: 
-- • A zero or negative amount 
select * from Payment;
INSERT INTO Payment (P_Date,Method,Loan_Date,M_ID,Book_ID,Amount)
VALUES ('2023-01-10', 'Cash','2023-01-10',1, 30,0);
-- Error --
Msg 547, Level 16, State 0, Line 367
The INSERT statement conflicted with the CHECK constraint "CK__Payment__Amount__693CA210". The conflict occurred in database "LibraryDatabase", table "dbo.Payment", column 'Amount'.


-- • A missing payment method 
INSERT INTO Payment (Amount, Method, M_ID) VALUES (10.00, NULL, 1);
-- Error --

Cannot insert the value NULL into column 'Method'.


--Try inserting a review for: 
-- • A book that does not exist 
INSERT INTO ReviewBook (Book_ID, M_ID, Comments) VALUES (30, 1, 'Great book!');
-- Error --
Violation of PRIMARY KEY constraint 'PK__ReviewBo__A3A8E9A539D05CFC'. Cannot insert duplicate key in object 'dbo.ReviewBook'. The duplicate key value is (30, 1).



-- • A member who was never registered 
UPDATE Loan SET M_ID = 99 WHERE Loan_ID = 1;
-- Error --
Msg 207, Level 16, State 1, Line 390
Invalid column name 'Loan_ID'.


--Try updating a foreign key field (like MemberID in Loan) to a value that doesn’t exist. 

