/*Marco Beltempo
10/12/2017
DBS501AA*/

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
TYPE course_description_type
IS
  TABLE OF course.description%TYPE INDEX BY PLS_INTEGER;
  course_description course_description_type;
  v_counter NUMBER := 0 ;
  CURSOR c_description
  IS
    SELECT description
    FROM COURSE
    WHERE prerequisite IS NULL
    ORDER BY DESCRIPTION;
BEGIN
  FOR courses IN c_description
  LOOP
    v_counter                     := v_counter + 1;
    course_description(v_counter) := courses.description;
    DBMS_OUTPUT.PUT_LINE('Course Decription: ' || v_counter || ': ' || courses.description);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('************************************');
  DBMS_OUTPUT.PUT_LINE('Total # of Courses without the Prerequisite is: ' || v_counter );
END;
/