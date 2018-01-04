/*Marco Beltempo
10/3/2017
DBS501AA*/

SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT temp_instruct_id NUMBER PROMPT 'Please enter the Instructor Id: ';
DECLARE
  v_total_courses NUMBER;
  v_message       VARCHAR2(150);
  v_instructor_id instructor.instructor_id%TYPE := '&temp_instruct_id';
  v_first_name instructor.first_name%TYPE;
  v_last_name instructor.last_name%TYPE;
BEGIN
  SELECT i.first_name,
    i.last_name
  INTO v_first_name,
    v_last_name
  FROM instructor i
  WHERE v_instructor_id = i.instructor_id
  GROUP BY i.first_name,
    i.last_name;
  BEGIN
    SELECT COUNT(*)
    INTO v_total_courses
    FROM section
    WHERE instructor_id = v_instructor_id;
  END;
  CASE
  WHEN v_total_courses >= 10 THEN
    v_message          := 'This instructor needs to rest in the next term.';
  WHEN v_total_courses  = 9 THEN
    v_message          := 'This instructor teaches enough sections.';
  ELSE
    v_message := 'This instructor may teach more sections.';
  END CASE;
  DBMS_OUTPUT.PUT_LINE('Instructor, ' || v_first_name || ' ' || v_last_name 
  || ' teaches ' || v_total_courses || ' section(s)' || chr(10) || v_message);
  DBMS_OUTPUT.PUT_LINE('PL/SQL procedure successfully completed.');
EXCEPTION
WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('This is not a valid instructor');
END;