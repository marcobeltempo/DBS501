/*Marco Beltempo
10/12/2017
DBS501AA*/

SET SERVEROUTPUT ON;
SET VERIFY OFF;
ACCEPT v_zip_code PROMPT "Enter the first 3 digits of the zip code: ";
DECLARE
  CURSOR c_zip
  IS
    SELECT zip,
      COUNT(student_id) AS studentTotal
    FROM
      (SELECT DISTINCT s.zip,
        s.student_id
      FROM STUDENT s
      LEFT JOIN ENROLLMENT e
      ON s.student_id = e.student_id
      WHERE s.zip LIKE '&v_zip_code'
        || '%'
      )
  GROUP BY zip
  ORDER BY zip;
  r_student c_zip%ROWTYPE;
TYPE student_table_type
IS
  TABLE OF r_student%TYPE INDEX BY PLS_INTEGER;
  student_table student_table_type;
  v_total          NUMBER := 0;
  v_total_enrolled NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_total_enrolled
  FROM STUDENT
  WHERE zip LIKE '&v_zip_code'
    || '%';
  IF v_total_enrolled > 0 THEN
    OPEN c_zip;
    FETCH c_zip BULK COLLECT INTO student_table;
    FOR i IN 1..student_table.COUNT
    LOOP
      v_total := v_total + 1;
      DBMS_OUTPUT.PUT_LINE('Zip code: ' || student_table(i).zip|| ' has exactly ' || student_table(i).studentTotal || ' students enrolled.');
    END LOOP;
    CLOSE c_zip;
    DBMS_OUTPUT.PUT_LINE('************************************');
    DBMS_OUTPUT.PUT_LINE('Total # of zip codes under ' || '&v_zip_code' || ' is ' || v_total);
    DBMS_OUTPUT.PUT_LINE('Total # of Students under zip code ' || '&v_zip_code' || ' is ' || v_total_enrolled);
    CLOSE c_zip;
  ELSE
    DBMS_OUTPUT.PUT_LINE('This zip area is student empty. Please, try again.');
  END IF;
END;
/