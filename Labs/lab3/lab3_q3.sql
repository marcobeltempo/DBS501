/*Marco Beltempo
10/12/2017
DBS501AA*/

SET SERVEROUTPUT ON;
SET VERIFY OFF;
ACCEPT v_zip_code PROMPT "Enter the first 3 digits of the zip code: ";
DECLARE
TYPE r_student
IS RECORD
  (
    zip_code      NUMBER,
    student_count NUMBER);
  r_course r_student;
  v_total       NUMBER := 0;
  v_total_enrolled NUMBER;
  CURSOR c_zip
  IS
    SELECT zip,
      COUNT(student_id)
    FROM
      (SELECT DISTINCT s.zip,
        s.student_id
      FROM STUDENT s
      LEFT JOIN ENROLLMENT e
      ON s.student_id = e.student_id
      WHERE s.zip LIKE '&v_zip_code' || '%'
      )
  GROUP BY zip
  ORDER BY zip;
BEGIN
  SELECT COUNT(*) INTO v_total_enrolled FROM STUDENT WHERE zip LIKE '&v_zip_code' || '%';
  IF v_total_enrolled > 0 THEN
    OPEN c_zip;
    LOOP
      FETCH c_zip INTO r_course;
      EXIT
    WHEN c_zip%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Zip code: ' || r_course.zip_code || ' has exactly ' || r_course.student_count || ' students enrolled.');
      v_total := v_total + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('************************************');
    DBMS_OUTPUT.PUT_LINE('Total # of zip codes under ' || '&v_zip_code' || ' is ' || v_total);
    DBMS_OUTPUT.PUT_LINE('Total # of Students under zip code ' || '&v_zip_code' || ' is ' || v_total_enrolled);
  CLOSE c_zip;
  ELSE
    DBMS_OUTPUT.PUT_LINE('This zip area is student empty. Please, try again.');
  END IF;
END;
/