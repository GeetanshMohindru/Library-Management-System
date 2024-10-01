CREATE TABLE BOOKS(ISBN10 VARCHAR2(15), 
                             TITLE VARCHAR2(300), 
                             CONSTRAINT PK_ISBN_10 PRIMARY KEY (ISBN10));
     
CREATE TABLE AUTHOR_WRITES_BOOKS(AUTHOR_ID NUMBER, 
                                ISBN  VARCHAR2(20), 
                                 CONSTRAINT FK_AUTHOR_ID FOREIGN KEY (AUTHOR_ID)
                                  REFERENCES PROJECT1_AUTHORS (AUTHOR_ID), 
                                 CONSTRAINT FK_ISBN FOREIGN KEY (ISBN)
                                  REFERENCES BOOKS(ISBN10));
      
CREATE TABLE AUTHORS(AUTHOR_ID NUMBER, 
                              AUTHOR_NAME  VARCHAR2(200) NOT NULL, 
                              CONSTRAINT PK_AUTHOR_ID PRIMARY KEY (AUTHOR_ID));
     
CREATE TABLE LIBRARY_BRANCH(BRANCH_ID VARCHAR2(10), 
                                     BRANCH_NAME VARCHAR2(100) NOT NULL , 
                                     ADDRESS VARCHAR2(300), 
                                     CONSTRAINT PK_BRANCH_ID PRIMARY KEY (BRANCH_ID));
     

CREATE TABLE BORROWER(CARD_NO VARCHAR2(15), 
                                 SSN VARCHAR2(20), 
                                 FNAME VARCHAR2(100), 
                                 LNAME VARCHAR2(100), 
                                 ADDRESS VARCHAR2(300), 
                                 PHONE VARCHAR2(15), 
                                CONSTRAINT PK_CARD_NO PRIMARY KEY (CARD_NO));


CREATE TABLE BOOK_HAVE_COPIES(BOOK_ID VARCHAR2(10),
                                  AVAILIABLE CHAR(1),
                                  ISBN10 VARCHAR2(15),
                                  BRANCH_ID VARCHAR2(10) NOT NULL,
                                  CONSTRAINT PK_BOOK_ID PRIMARY KEY (BOOK_ID)
                                  CONSTRAINT FK_ISBN_NO FOREIGN KEY(ISBN_NO) REFERENCES(BOOKS)
                                  CONSTRAINT FK_BRANCH_ID FOREIGN KEY(BRANCH_ID) REFERENCES(LIBRARY_BRANCH));
                    

CREATE TABLE BOOK_LOANS(LOAN_ID VARCHAR2(10), 
                               BOOK_ID VARCHAR2(20), 
                               CARD_NO VARCHAR2(20), 
                               DATE_OUT DATE, 
                               DATE_DUE DATE,
                               DATE_IN DATE,
                               CONSTRAINT PK_LOAN_ID PRIMARY KEY (LOAN_ID),
                               CONSTRAINT FK_BOOK_ID FOREIGN KEY (BOOK_ID) REFERENCES BOOKS_HAVE_COPIES(BOOK_ID),
                               CONSTRAINT FK_CARD_NO FOREIGN KEY (CARD_NO) REFERENCES BORROWER(CARD_NO));
                               
CREATE TABLE FINES(LOAN_ID VARCHAR2(10) NOT NULL,
                            FINE_AMT FLOAT NOT NULL,
                            PAID CHAR(1),
                            CONSTRAINT FK_LOAN_ID FOREIGN KEY (LOAN_ID) REFERENCES BOOKS_LOANS(LOAN_ID));
                            
                            
                  