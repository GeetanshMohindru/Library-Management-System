CREATE OR REPLACE FUNCTION search_books(
  p_title       IN VARCHAR2,
  p_author      IN VARCHAR2,
  p_branch_name IN VARCHAR2
) RETURN SYS_REFCURSOR AS
  l_books_cursor SYS_REFCURSOR;
BEGIN
  OPEN l_books_cursor FOR
    SELECT b.Title, a.Name, m.Branch_Name, m.Branch_Address
    FROM BOOKS b
    JOIN AUTHOR_WRITES_BOOKS ba ON b.ISBN_NO = ba.ISBN_NO
    JOIN AUTHORS a ON ba.A_ID = a.A_ID
    JOIN BOOKS_HAVE_COPIES c ON b.ISBN_NO = c.ISBN_NO
    JOIN LIBRARY_BRANCH m ON c.BRANCH_ID = m.BRANCH_ID
    WHERE b.TITLE LIKE '%' || p_title || '%'
      AND a.AUTHOR_NAME LIKE '%' || p_author || '%'
      AND m.BRANCH_NAME LIKE '%' || p_branch_name || '%';
  RETURN l_books_cursor;
END;

DECLARE
  l_books_cursor SYS_REFCURSOR;
BEGIN
  l_books_cursor := search_books('Harry Potter', 'J.K. Rowling', 'Main Library');
  -- THIS WILL PROCESS RESULTS OBTAINED FROM CURSOR
END;

-- Testing

DECLARE
  l_result VARCHAR2(200);
BEGIN
  l_result := return_book(1234, SYSDATE);
  DBMS_OUTPUT.PUT_LINE(l_result);
END;