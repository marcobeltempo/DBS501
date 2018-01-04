/*Marco Beltempo
12/22/2017
DBS501AA*/

SET SERVEROUTPUT ON;
SET VERIFY OFF;
SELECT LAB5.GET_DESCR(:tmp_section_id) AS "COURSE DESCRIPTION" FROM DUAL;
ACCEPT v_range NUMBER PROMPT "Enter number of business days to show: ";
DECLARE
v_sys_date DATE := TO_DATE('20-NOV-11');
v_range NUMBER;
BEGIN
DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
DBMS_OUTPUT.PUT_LINE('Executing default show_bizdays procedure');
LAB5.SHOW_BIZDAYS;
DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
DBMS_OUTPUT.PUT_LINE('Executing two param show_bizdays procedure');
LAB5.SHOW_BIZDAYS(v_sys_date + 7, 10);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
DBMS_OUTPUT.PUT_LINE('Executing one param overloaded show_bizdays procedure');
LAB5.SHOW_BIZDAYS(v_sys_date);
LAB5.GET_RANGE(&v_range);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
END;
/
ROLLBACK;