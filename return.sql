CREATE OR REPLACE FUNCTION return_book(
  p_loan_id  IN NUMBER,
  p_return_date IN DATE
) RETURN VARCHAR2 AS
  l_fine_amt  NUMBER;
BEGIN
  -- CHECKING LOAN RICORD
  SELECT COUNT(*)
  INTO l_fine_amt
  FROM BOOK_LOANS
  WHERE LOAN_ID = p_loan_id
    AND DATE_IN IS NULL;

  IF l_fine_amt = 0 THEN
    RETURN 'Loan record does not exist or book has already been returned.';
  END IF;

-- UPDATE FINE IF IT EXISTS
  UPDATE FINES
  SET FINE_AMT= ((DATE_IN)-(DATE_DUE))*5
  WHERE LOAN_ID=p_loan_id and PAID = 'N';

  -- Calculate FINE IF IT EXISTS
  SELECT SUM(FINE_AMT)
  INTO l_fine_amt
  FROM FINES
  WHERE LOAN_ID = p_loan_id
    AND PAID = 'N';

  -- Update loan record and copies table
  UPDATE BOOK_LOANS
  SET DATE_IN= p_return_date
  WHERE LOAN_ID = p_loan_id;

  UPDATE BOOKS_HAVE_COPIES
  SET Available = 'Y'
  WHERE BOOK_ID = (
    SELECT BOOK_ID
    FROM BOOKS_LOANS
    WHERE LOAN_ID = p_loan_id
  );

  -- Update fine record (if any)
  IF l_fine_amt IS NOT NULL AND l_fine_amt > 0 THEN
    UPDATE FINES
    SET PAID = 'Y'
    WHERE LOAN_ID = p_loan_id;
  END IF;

  RETURN 'Book has been successfully returned.';
END;