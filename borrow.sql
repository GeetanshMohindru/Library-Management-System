CREATE OR REPLACE FUNCTION borrow_book(
  p_card_no  IN NUMBER,
  p_book_id  IN NUMBER,
  p_due_date IN DATE
) RETURN VARCHAR2 AS
  l_loan_id  NUMBER;
  l_error    VARCHAR2(200);
BEGIN
  -- Check if borrower already has a loan
  SELECT COUNT(*)
  INTO l_error
  FROM BOOKS_LOANS
  WHERE CARD_NO = p_card_no
    AND DATE_IN IS NULL;

  IF l_error > 0 THEN
    RETURN 'Borrower already has a book on loan.';
  END IF;

  -- ChecKING IF THE BOOK IS AVAILABLE TO BE LOANED
  SELECT COUNT(*)
  INTO l_error
  FROM BOOK_HAVE_COPIES
  WHERE BOOKk_ID = p_book_id
    AND NOT EXISTS (
      SELECT 1
      FROM BOOK_LOANS
      WHERE BOOK_ID = p_book_id
        AND DATE_IN IS NULL
    );

  IF l_error = 0 THEN
    RETURN 'Book is not available for loan.';
  END IF;

  -- CREATING NEW LOAN RECORD
  SELECT MAX(Loan_ID) + 1
  INTO l_loan_id
  FROM BOOKS_LOANS;

  INSERT INTO BOOKS_LOANS (LOAN_ID, BOOK_ID, CARD_NO, DATE_OUT, DATE_DUE, DATE_IN)
  VALUES (l_loan_id, p_book_id, p_card_no, SYSDATE, p_due_date,NULL);

  RETURN 'Book has been successfully borrowed.';
END;


-- Testing 
DECLARE
  l_result VARCHAR2(200);
BEGIN
  l_result := borrow_book(12345, 9876, TO_DATE('2023-05-01', 'YYYY-MM-DD'));
  DBMS_OUTPUT.PUT_LINE(l_result);
END;