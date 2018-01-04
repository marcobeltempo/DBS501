/*Marco Beltempo
10/4/2017
DBS501AA*/
SET SERVEROUTPUT  ON
SET VERIFY OFF

UPDATE departments
SET location_id      = 1400
WHERE department_id IN (40,70)
/

ACCEPT temp_loc_id PROMPT 'Enter valid Location ID: ' 
DECLARE 
v_location_id NUMERIC := '&temp_loc_id';
v_derpartment_id NUMBER;
v_emp_totalt NUMBER;
BEGIN
  SELECT COUNT(department_id)
  INTO v_derpartment_id
  FROM departments
  WHERE location_id = v_location_id;
  SELECT COUNT(e.employee_id)
  INTO v_emp_totalt
  FROM departments d,
    employees e
  WHERE location_id   = v_location_id
  AND e.department_id = d.department_id;
  FOR i IN 1..v_derpartment_id
  LOOP
    DBMS_OUTPUT.PUT_LINE('Outer Loop: Department #'||i);
    FOR j IN 1..v_emp_totalt
    LOOP
      DBMS_OUTPUT.PUT_LINE(' *Inner Loop: Employee #'||j);
    END LOOP;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('PL/SQL procedure successfully completed.');
END;
         /         
ROLLBACK /
