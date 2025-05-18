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