
-- 1. Msg 1785, Level 16, State 0, Line 85
--Introducing FOREIGN KEY constraint 'FK__Loan__Book_ID__59063A47' on table 'Loan' may cause cycles or multiple cascade paths. Specify ON DELETE NO ACTION or ON UPDATE NO ACTION, or modify other FOREIGN KEY constraints.
--Msg 1750, Level 16, State 1, Line 85
--Could not create constraint or index. See previous errors.

-- answer -- 
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

-- SQL Server does not allow multiple cascading paths 


 FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID) ON DELETE NO ACTION ON UPDATE NO ACTION
    
You need to manually delete the related Loan rows before deleting a Book

the meaning of ( ON DELETE NO ACTION )
-- Do nothing automatically if the parent row is deleted.
-- If you try to delete a parent row while it still has child rows, the database will throw an error.
-- Cannot delete or update a parent row: a foreign key constraint fails.

--------------------------------------------
--2. Msg 245, Level 16, State 1, Line 175
--Conversion failed when converting the varchar value 'Available' to data type bit.

-- ANSWER -- 

WE NEED TH CHANGE THE DATA TYPE OF AVAILABLE_STATUS

ALTER TABLE Book
ALTER COLUMN Available_State VARCHAR(40) DEFAULT 'TRUE';

-- 2.1 Msg 5074, Level 16, State 1, Line 191
The object 'DF__Book__Available___49C3F6B7' is dependent on column 'Available_State'.
Msg 4922, Level 16, State 9, Line 191
ALTER TABLE ALTER COLUMN Available_State failed because one or more objects access this column.


-- answer -- 

ALTER TABLE Book
DROP CONSTRAINT DF__Book__Available___49C3F6B7;

then 

ALTER TABLE Book
ALTER COLUMN Available_State VARCHAR(20);

then 

ALTER TABLE Book
ADD CONSTRAINT DF_Book_Available_State
DEFAULT 'TRUE' FOR Available_State;

--------
--Testing Case--

-- Errors in testing case -- 


--DML - Delete and Update

--Try deleting a member who: 
-- • Has existing loans 
DELETE FROM Members WHERE M_ID = 1;
--Error --
Msg 547, Level 16, State 0, Line 286
The DELETE statement conflicted with the REFERENCE constraint "FK__ReviewBook__M_ID__6754599E". The conflict occurred in database "LibraryDatabase", table "dbo.ReviewBook", column 'M_ID'.

--Solve --
You cant delete a member who has active loans

-- • Has written book reviews
DELETE FROM Members WHERE M_ID = 2;
-- Error --
Msg 547, Level 16, State 0, Line 288
The DELETE statement conflicted with the REFERENCE constraint "FK__ReviewBook__M_ID__6754599E". The conflict occurred in database "LibraryDatabase", table "dbo.ReviewBook", column 'M_ID'.
-- Solve --
You cant delete a member who has active loans

--Try deleting a book that: 
-- • Is currently on loan 
DELETE FROM Book WHERE Book_ID = 30;
-- Error --
Msg 547, Level 16, State 0, Line 306
The DELETE statement conflicted with the REFERENCE constraint "FK__Loan__Book_ID__5EBF139D". The conflict occurred in database "LibraryDatabase", table "dbo.Loan", column 'Book_ID'.

-- Solve --
Foreign key conflict with Loan

---• Has multiple reviews attached to it 
DELETE FROM Book WHERE Book_ID = 30;
-- Error --
Msg 547, Level 16, State 0, Line 315
The DELETE statement conflicted with the REFERENCE constraint "FK__Loan__Book_ID__5EBF139D". The conflict occurred in database "LibraryDatabase", table "dbo.Loan", column 'Book_ID'.
The statement has been terminated.
-- Solve --


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

