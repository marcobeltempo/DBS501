/*Marco Beltempo
10/12/2017
DBS501AA*/

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
TYPE course_description_type
IS
  TABLE OF course.description%TYPE;
  course_description course_description_type;
  CURSOR c_description
  IS
    SELECT description
    FROM COURSE
    WHERE prerequisite IS NULL
    ORDER BY DESCRIPTION;
  v_counter NUMBER := 0 ;
BEGIN
  OPEN c_description;
  FETCH c_description BULK COLLECT INTO course_description;
  FOR i IN 1.. course_description.COUNT
  LOOP
    course_description.EXTEND;
    DBMS_OUTPUT.PUT_LINE('Course Description: ' || i || ': ' || course_description(i));
    v_counter := i;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('************************************');
  DBMS_OUTPUT.PUT_LINE('Total # of Courses without the Prerequisite is: ' || v_counter);
  CLOSE c_description;
END;
/