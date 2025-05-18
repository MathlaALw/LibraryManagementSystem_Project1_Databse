
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

