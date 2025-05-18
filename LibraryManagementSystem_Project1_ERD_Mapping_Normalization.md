# LibraryManagementSystem_Project1 ( ERD , Mapping , Normalization)

## Description of database:

 
The Library Management System is designed to manage books, members, staff, 
loans, and transactions efficiently. The system includes libraries where each library 
has a unique ID, name, location, contact number, and established year. Each library 
must manage books, where each book is identified by a unique ID, ISBN, title, genre, 
price, availability status, and shelf location. A book belongs to exactly one library, 
and a library may own many books. 
Members can register with personal information such as ID, full name, email, phone 
number, and membership start date. A member can borrow zero or more books. 
Each loan links one member with one book and includes loan date, due date, return 
date, and status. 
Each loan may have zero or more fine payments, where a payment is uniquely 
identified and includes payment date, amount, and method. Payment always 
corresponds to one specific loan. 
Staff work at a specific library, identified by staff ID, full name, position, and contact 
number. Each library must have at least one staff member, but each member of staff 
works at only one library. 
Members may also review books, where a review includes a rating, comments, and 
review date. Each review is linked to a specific book and a specific member. A 
member can provide multiple reviews, and a book may receive many reviews.

### PDF file:
[Real Life Web Application Simulation DB Project1](.\PDF\RealLifeWebApplicationSimulationDB_Project1.pdf)


--------------
## ERD Diagram :

![ERD Diagram](./image/LibraryManagementSystem.jpg)

--------------
## Mapping of ERD to Relational Schema:

![Mapping of ERD to Relational Schema](./image/LibraryManagementSystem_Mapping.jpg)

--------------

## Normalization:

### Library Table:
#### UNF :
#### Library Table
|L_ID  | L_Name                                | Location | ContactNumber      | EstablishedYear |
|------|---------------------------------------|----------|--------------------|-----------------|
| 1    | Children's Public Library             | Muscat   | 24557890 ,24559988 | 1990            |
| 2    | Sultan Qaboos cultural center library | Muscat   | 24557891           | 1995            |
| 3    | Public Knowledge Library              | Muscat   | 24557892, 24184752 | 2000            |

#### 1NF : ( Remove repeating groups )
##### Library Table
|L_ID  | L_Name                                | Location | EstablishedYear |
|------|---------------------------------------|----------|-----------------|
| 1    | Children's Public Library             | Muscat   | 1990            |
| 2    | Sultan Qaboos cultural center library | Muscat   | 1995            |
| 3    | Public Knowledge Library              | Muscat   | 2000            |


#### LibraryContactNumber Table
|L_ID   | ContactNumber      |
|-------|--------------------|
| 1     | 24557890           |
| 1     | 24559988           |
| 2     | 24557891           |
| 3     | 24557892           |
| 3     | 24184752           |

#### 2NF : ( Remove partial dependency ) Already satisfied ( L_ID is the primary key )
#### 3NF : ( Remove transitive dependency ) Already satisfied ( No transitive dependencies )
----------------------------
### Staff Table:
#### UNF :
|S_ID  | S_Name               | Position            | ContactNumber      | L_ID |
|------|----------------------|---------------------|--------------------|------|
| 1    | Salim Al Bulushi     | Librarian           | 92557890 ,99554874 | 1    |
| 2    | Fatima Al Shamsi     | Assistant Librarian | 92557891 ,99887766 | 1    |
| 3    | Ahmed Al Rashidi     | Librarian           | 92557892           | 2    |
| 4    | Aisha Al Busaidi     | Assistant Librarian | 92557893           | 2    |
| 5    | Khalid Al Balushi    | Librarian           | 92557894 ,99663322 | 3    |
| 6    | Layla Al Shamsi      | Assistant Librarian | 92557895 ,95115995 | 3    |

#### 1NF : ( Remove repeating groups )
##### Staff Table
|S_ID  | S_Name               | Position            | L_ID |
|------|----------------------|---------------------|------|
| 1    | Salim Al Bulushi     | Librarian           | 1    |
| 2    | Fatima Al Shamsi     | Assistant Librarian | 1    |
| 3    | Ahmed Al Rashidi     | Librarian           | 2    |
| 4    | Aisha Al Busaidi     | Assistant Librarian | 2    |
| 5    | Khalid Al Balushi    | Librarian           | 3    |
| 6    | Layla Al Shamsi      | Assistant Librarian | 3    |

#### StaffContactNumber Table
|S_ID   | ContactNumber      |
|-------|--------------------|
| 1     | 92557890           |
| 1     | 99554874           |
| 2     | 92557891           |
| 2     | 99887766           |
| 3     | 92557892           |
| 4     | 92557893           |
| 5     | 92557894           |
| 5     | 99663322           |
| 6     | 92557895           |
| 6     | 95115995           |

#### 2NF : ( Remove partial dependency ) Already satisfied ( S_ID is the primary key )
#### 3NF : ( Remove transitive dependency ) Already satisfied ( No transitive dependencies )

--------------------------


### Book Table:
#### UNF :

#### Book Table
|B_ID  | ISBN              | Title                                   | Genre       | Price | AvailabilityStatus | ShelfLocation | L_ID |
|------|-------------------|-----------------------------------------|-------------|-------|--------------------|---------------|------|
| 1    | 978-3-16-148410-0 | The Great Gatsby                        | Fiction     | 10.99 | Available          | A1            | 1    |
| 2    | 978-0-7432-7356-5 | A Brief History of Time                 | Non-Fiction | 15.99 | Available          | B2            | 1    |
| 3    | 978-0-06-112008-4 | To Kill a Mockingbird                   | Fiction     | 12.99 | Available          | C3            | 2    |
| 4    | 978-0-452-28423-4 | The Catcher in the Rye                  | Children    | 9.99  | Available          | D4            | 2    |
| 5    | 978-0-7432-7356-5 | The Art of War                          | Non-Fiction | 14.99 | Available          | E5            | 3    |
| 6    | 978-0-7432-7356-5 | The Alchemist                           | Fiction     | 11.99 | Available          | F6            | 3    |
| 7    | 978-0-7432-7356-5 | The Da Vinci Code                       | Reference   | 13.99 | Available          | G7            | 1    |
| 8    | 978-0-7432-7356-5 | The Power of Habit                      | Non-Fiction | 16.99 | Available          | H8            | 2    |
| 9    | 978-0-7432-7356-5 | The 7 Habits of Highly Effective People | Non-Fiction | 18.99 | Available          | I9            | 3    |
| 10   | 978-0-7432-7356-5 | The Fault in Our Stars                  | Fiction     | 10.99 | Available          | K11           | 2    |
| 11   | 978-0-7432-7356-5 | The Hunger Games                        | Reference   | 12.99 | Available          | L12           | 3    |
| 12   | 978-0-7432-7356-5 | The Book Thief                          | Children    | 11.99 | Available          | M13           | 1    |

#### 1NF : ( Remove repeating groups ) --> Already satisfied ( No repeating groups )
#### 2NF : ( Remove partial dependency ) Already satisfied ( B_ID is the primary key )
#### 3NF : ( Remove transitive dependency ) Already satisfied ( No transitive dependencies )
---------------------------
### LibraryBook Table
#### UNF :
#### LibraryBook Table
|L_ID   | B_ID  |
|-------|-------|
| 1     | 1     |
| 1     | 2     |
| 1     | 7     |
| 1     | 8     |
| 2     | 3     |
| 2     | 4     |
| 2     | 10    |
| 2     | 12    |
| 3     | 5     |
| 3     | 6     |
| 3     | 9     |
| 3     | 11    |
| 3     | 12    |

#### 2NF : ( Remove partial dependency ) Already satisfied ( L_ID and B_ID is the primary key )
#### 3NF : ( Remove transitive dependency ) Already satisfied ( No transitive dependencies )
--------------------------
### Member Table:
#### UNF :
#### Member Table
|M_ID  | F_Name               | L_Name               | Email                      | PhoneNumber          | MembershipStartDate |
|------|----------------------|----------------------|----------------------------|----------------------|---------------------|
| 1    | Ali                  | Alfarsi              | alialfarsi@gmail.com       | 92557890 ,99554874   | 2023-01-01          |
| 2    | Noor                 | Alhatmi              | nooralhatmi@gmail.com      | 92557891 ,99887766   | 2023-02-01          |
| 3    | Sara                 | Alwahabi             | saraalwahaibi@gmail.com    | 92557892 ,99663322   | 2023-03-01          |
| 4    | Ahmed                | Alnasri              | ahmedalnasri@gmail.com     | 92557893             | 2023-04-01          |
| 5    | Mohammed             | Alrashdi             | mohammedalrashdi@gmail.com | 92557894 ,99663322   | 2023-05-01          |
| 6    | Nasser               | Alsalmi              | nasseralsalmi@gmail.com    | 92557895 ,95115995   | 2023-06-01          |
| 7    | Layla                | Alqasmi              | laylaalqasmi @gmail.com    | 92557896             | 2023-07-01          |

#### 1NF : ( Remove repeating groups )
##### Member Table
|M_ID  | F_Name               | L_Name               | Email                      | MembershipStartDate |
|------|----------------------|----------------------|----------------------------|---------------------|
| 1    | Ali                  | Alfarsi              | alialfarsi@gmail.com       | 2023-01-01          |
| 2    | Noor                 | Alhatmi              | nooralhatmi@gmail.com      | 2023-02-01          |
| 3    | Sara                 | Alwahabi             | saraalwahaibi@gmail.com    | 2023-03-01          |
| 4    | Ahmed                | Alnasri              | ahmedalnasri@gmail.com     | 2023-04-01          |
| 5    | Mohammed             | Alrashdi             | mohammedalrashdi@gmail.com | 2023-05-01          |
| 6    | Nasser               | Alsalmi              | nasseralsalmi@gmail.com    | 2023-06-01          |
| 7    | Layla                | Alqasmi              | laylaalqasmi @gmail.com    | 2023-07-01          |
#### MemberPhoneNumber Table
|M_ID   | PhoneNumber          |
|-------|----------------------|
| 1     | 92557890             |
| 1     | 99554874             |
| 2     | 92557891             |
| 2     | 99887766             |
| 3     | 92557892             |
| 3     | 99663322             |
| 4     | 92557893             |
| 5     | 92557894             |
| 5     | 99663322             |
| 6     | 92557895             |
| 6     | 95115995             |
| 7     | 92557896             |
#### 2NF : ( Remove partial dependency ) Already satisfied ( M_ID is the primary key )
#### 3NF : ( Remove transitive dependency ) Already satisfied ( No transitive dependencies )

--------------------------

### Loan Table:
#### UNF :
#### Loan Table
 | M_ID  | B_ID  | LoanDate   | DueDate    | ReturnDate | Status     |
 |-------|-------|------------|------------|------------|------------|
 | 1     | 1     | 2023-01-10 | 2023-01-20 | 2023-01-15 | Returned   |
 | 2     | 2     | 2023-01-15 | 2023-01-25 | NULL       | Issued     |
 | 3     | 3     | 2023-02-01 | 2023-02-10 | 2023-02-20 | Overdue    |
 | 4     | 4     | 2023-02-05 | 2023-02-15 | NULL       | Issued     |
 | 5     | 5     | 2023-03-01 | 2023-03-10 | NULL       | Issued     |
 | 6     | 6     | 2023-03-05 | 2023-03-15 | NULL       | Issued     |



#### 1NF : ( Remove repeating groups ) Already satisfied ( No repeating groups )
#### 2NF : ( Remove partial dependency ) Already satisfied ( L_ID, M_ID and B_ID is the primary key )
#### 3NF : ( Remove transitive dependency ) Already satisfied ( No transitive dependencies )

--------------------------
### Payment Table:
#### UNF :
#### Payment Table
|P_ID  | LoanID | PaymentDate | Amount | PaymentMethod |M_ID  |B_ID  |
|------|--------|-------------|--------|----------------|------|------|
| 1    | 1      | 2023-01-15  | 5.00   | Cash           | 1    | 1    |
| 2    | 2      | 2023-01-20  | 10.00  | Credit Card    | 1    | 2    |
| 3    | 3      | 2023-02-10  | 15.00  | Debit Card     | 2    | 3    |
| 4    | 4      | 2023-02-15  | 20.00  | Cash           | 2    | 4    |
| 5    | 5      | 2023-03-05  | 25.00  | Credit Card    | 3    | 5    |
| 6    | 6      | 2023-03-15  | 30.00  | Debit Card     | 3    | 6    |

#### 1NF : ( Remove repeating groups ) Already satisfied ( No repeating groups )
#### 2NF : ( Remove partial dependency ) Already satisfied ( P_ID is the primary key )
#### 3NF : ( Remove transitive dependency ) Already satisfied ( No transitive dependencies )
--------------------------

### Review Table:
#### UNF :
#### Review Table
| M_ID  | B_ID  | Rating | Comments               | ReviewDate |	
|-------|-------|--------|------------------------|------------|
| 1     | 1     | 5      | Excellent book!        | 2023-01-15 |
| 1     | 2     | 4      | Very informative.      | 2023-01-20 |
| 2     | 3     | 3      | Good read.             | 2023-02-10 |
| 2     | 4     | 2      | Not my type.           | 2023-02-15 |
| 3     | 5     | 4      | Interesting concepts.  | 2023-03-05 |
| 3     | 6     | 5      | Loved it!              | 2023-03-15 |
| 4     | 7     | 3      | Average book.          | 2023-04-01 |
| 4     | 8     | 4      | Great for beginners.   | 2023-04-05 |

#### 1NF : ( Remove repeating groups ) Already satisfied ( No repeating groups )
#### 2NF : ( Remove partial dependency ) Already satisfied ( M_ID and B_ID is the primary key )
#### 3NF : ( Remove transitive dependency ) Already satisfied ( No transitive dependencies )

------------------------------------

## Creating Database 
```sql
-- Create database 
create database LibraryDatabase;

-- use database
use LibraryDatabase;


```


## DDL: Create Tables

```sql


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


```

## DML: Insert Data
```sql

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



```