/*Marco Beltempo
9/29/2017
DBS501AA*/

SET SERVEROUTPUT  ON
SET VERIFY OFF

ACCEPT temp_type CHAR FORMAT 'A1' PROMPT 'Enter your input scale (C or F) for temperature:';
ACCEPT temp_value NUMBER PROMPT 'Enter your temperature value to be converted:';
DECLARE 
v_temp_type char(1) := '&temp_type';
v_temperature NUMBER(6,1) := '&temp_value';
BEGIN
  IF 
    UPPER(v_temp_type) LIKE 'C' THEN
    v_temperature := (v_temperature * (9/5)) + 32;
    DBMS_OUTPUT.PUT_LINE('Your converted temperature in F is exactly ' || v_temperature);
  ELSIF 
    UPPER(v_temp_type) LIKE 'F' THEN
    v_temperature := ((v_temperature - 32)) * (5/9);
    DBMS_OUTPUT.PUT_LINE('Your converted temperature in C is exactly ' || v_temperature);
  ELSE
      DBMS_OUTPUT.PUT_LINE('This is NOT a valid scale. Must be C or F.');
END IF;
      DBMS_OUTPUT.PUT_LINE('PL/SQL procedure successfully completed.');
END;
/
