-- CREATE OR REPLACE FUNCTION insert_data(
--   p_branch_id   IN LIBRARY_BRANCH.BRANCH_ID%TYPE,
--   p_branch_name IN LIBRARY_BRANCH.BRANCH_NAME%TYPE,
--   p_branch_addr IN LIBRARY_BRANCH.BRANCH_ADDRESS%TYPE,
--   p_book_id     IN BOOKS_HAVE_COPIES.BOOK_ID%TYPE,
--   p_available   IN BOOKS_HAVE_COPIES.
--   p_isbn        IN BOOKS.ISBN_NO%TYPE,
--   p_title       IN BOOKS.TITLE%TYPE,
--   p_author_id   IN AUTHORS.AUTHOR_ID%TYPE,
--   p_author_name IN AUTHORS.AUTHOR_NAME%TYPE,
--   p_loan_id     IN BOOKS_LOANS.LOAN_ID%TYPE,
--   p_card_no     IN BOOKS_LOANS.CARD_NO%TYPE,
--   p_issue_date  IN BOOKS_LOANS.DATE_OUT%TYPE,
--   p_due_date    IN BOOKS_LOANS.DATE_DUE%TYPE,
--   p_return_date IN BOOKS_LOANS.DATE_IN%TYPE,
--   p_fine_amt    IN FINES.FINE_AMT%TYPE,
--   p_fine_paid   IN FINES.PAID%TYPE,
--   p_borrower_ssn IN BORROWER.SSN%TYPE,
--   p_borrower_fname IN BORROWER.FNAME%TYPE,
--   p_borrower_lname IN BORROWER.LNAME%TYPE,
--   p_borrower_addr IN BORROWER.ADDRESS%TYPE,
--   p_borrower_phone IN BORROWER.PHONE%TYPE
-- ) RETURN VARCHAR2 AS
-- BEGIN
--   -- Insert data into Branches table
--   INSERT INTO LIBRARY_BRANCH (BRANCH_ID, BRANCH_NAME, BRANCH_ADDRESS)
--   VALUES (p_branch_id, p_branch_name, p_branch_addr);

--   -- Insert data into Copies table
--   INSERT INTO BOOKS_HAVE_COPIES (BOOKS_ID,AVAILABLE)
--   VALUES (p_book_id, p_branch_id, 'Y');

--   -- Insert data into Books table
--   INSERT INTO Books (Book_ID, ISBN_NO, Title)
--   VALUES (p_book_id, p_isbn, p_title);

--   -- Insert data into Authors table
--   INSERT INTO Authors (Author_ID, Author_Name)
--   VALUES (p_author_id, p_author_name);

--   -- Insert data into Book_Authors table
--   INSERT INTO Book_Authors (Book_ID, Author_ID)
--   VALUES (p_book_id, p_author_id);

--   -- Insert data into Borrowers table
--   INSERT INTO Borrowers (Card_No, SSN, Fname, Lname, Address, Phone)
--   VALUES (p_card_no, p_borrower_ssn, p_borrower_fname, p_borrower_lname, p_borrower_addr, p_borrower_phone);

--   -- Insert data into Loans table
--   INSERT INTO Loans (Loan_ID, Card_No, Copy_ID, Issue_Date, Due_Date, Return_Date)
--   VALUES (p_loan_id, p_card_no, p_copy_id, p_issue_date, p_due_date, p_return_date);

--   -- Insert data into Fines table
--   INSERT INTO Fines (Loan_ID, Fine_Amount, Paid)
--   VALUES (p_loan_id, p_fine_amt, p_fine_paid);

--   RETURN 'Data has been successfully inserted into all tables.';
-- END;


-- insertion

DECLARE
  i NUMBER := 1;
BEGIN
  WHILE i <= 200 LOOP
    -- Generate random values for the various tables
    DECLARE
      branch_id   NUMBER := FLOOR(DBMS_RANDOM.VALUE(100, 999));
      branch_name VARCHAR2(50) := 'Branch ' || branch_id;
      branch_addr VARCHAR2(100) := 'Address ' || branch_id;
    --   copy_id     NUMBER := FLOOR(DBMS_RANDOM.VALUE(1000, 9999));
      book_id     NUMBER := FLOOR(DBMS_RANDOM.VALUE(10000, 99999));
      isbn        VARCHAR2(13) := LPAD(book_id, 13, '0');
      title       VARCHAR2(100) := 'Book ' || book_id;
      author_id   NUMBER := FLOOR(DBMS_RANDOM.VALUE(1, 50));
      author_name VARCHAR2(50) := 'Author ' || author_id;
      loan_id     NUMBER := FLOOR(DBMS_RANDOM.VALUE(100000, 999999));
      card_no     NUMBER := FLOOR(DBMS_RANDOM.VALUE(100000, 999999));
      issue_date  DATE := SYSDATE - FLOOR(DBMS_RANDOM.VALUE(1, 100));
      due_date    DATE := issue_date + FLOOR(DBMS_RANDOM.VALUE(7, 30));
      return_date DATE := NULL;
      fine_amt    NUMBER := FLOOR(DBMS_RANDOM.VALUE(0, 50));
      fine_paid   CHAR(1) := CASE WHEN FLOOR(DBMS_RANDOM.VALUE(0, 1)) = 0 THEN 'N' ELSE 'Y' END;
      borrower_ssn NUMBER := FLOOR(DBMS_RANDOM.VALUE(100000000, 999999999));
      borrower_fname VARCHAR2(50) := 'Borrower ' || i || ' First Name';
      borrower_lname VARCHAR2(50) := 'Borrower ' || i || ' Last Name';
      borrower_addr VARCHAR2(100) := 'Borrower ' || i || ' Address';
      borrower_phone VARCHAR2(20) := '555-' || LPAD(FLOOR(DBMS_RANDOM.VALUE(0, 9999)), 4, '0');
    BEGIN

      -- Insert data into all the tables using the insert_data function
      INSERT INTO LIBRARY_BRANCH (BRANCH_ID, BRANCH_NAME, BRANCH_ADDRESS)
      VALUES (branch_id, branch_name, branch_addr);

      INSERT INTO BOOKS_HAVE_COPIES (Book_ID,ISBN10 BRANCH_ID, AVAILABLE)
      VALUES (book_id, isbn, branch_id, 'Y');

      INSERT INTO BOOKS (BOOK_ID, ISBN_NO, TITLE)
      VALUES (book_id, isbn, title);

      INSERT INTO AUTHORS (AUTHOR_ID, AUTHOR_NAME)
      VALUES (author_id, author_name);

      INSERT INTO AUTHOR_WRITES_BOOKS (ISBN, AUTHOR_ID)
      VALUES (isbn, author_id);

      INSERT INTO BORROWER (CARD_NO, SSN, FNAME, LNAME, ADDRESS, PHONE)
      VALUES (card_no, borrower_ssn, borrower_fname, borrower_lname, borrower_addr, borrower_phone);

      INSERT INTO BOOKS_LOANS (LOAN_ID, CARD_NO,DATE_OUT, DATE_DUE, DATE_IN)
      VALUES (loan_id, card_no,issue_date, due_date, return_date);

      INSERT INTO FINES (LOAN_ID, FINE_AMT, PAID)
      VALUES (loan_id, fine_amt, fine_paid);

      DBMS_OUTPUT.PUT_LINE('Data inserted for borrower ' || borrower_fname || ' ' || borrower_lname);
    END;

    i := i + 1
