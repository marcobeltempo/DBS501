/*Marco Beltempo
9/22/2017
DBS501AA*/

SET SERVEROUTPUT ON
DECLARE
  v_course_name VARCHAR2(30);
  v_number      NUMBER(8,2);
  c_code        CONSTANT VARCHAR2(4) := '704B';
  v_valid       BOOLEAN;
  v_date        DATE := SYSDATE + 7;
BEGIN
  v_course_name := 'C++ advanced';
  DBMS_OUTPUT.PUT_LINE('Variable c_code: ' || c_code);
  DBMS_OUTPUT.PUT_LINE('Variable v_date: ' || v_date);
  IF UPPER(v_course_name) LIKE '%SQL%' THEN
    DBMS_OUTPUT.PUT_LINE('Course name: ' || v_course_name);
  ELSE
    IF UPPER(c_code) LIKE '704B' THEN
      IF LENGTH(v_course_name) > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Course name: ' || v_course_name || ' is located in room: ' || c_code);
      ELSE
        DBMS_OUTPUT.PUT_LINE('Course is unknown.');
        DBMS_OUTPUT.PUT_LINE('Room:' || c_code);
      END IF;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Course and location could not be determined.');
    END IF;
  END IF;
END;
/