/*Marco Beltempo
12/13/2017
DBS501AA*/

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    v_flag        VARCHAR2(7);
    v_zip_count   NUMBER;
BEGIN
    add_zip('18104','Chicago','MI',v_flag,v_zip_count);
    dbms_output.put_line('FLAG: '
    || v_flag);
    dbms_output.put_line('ZIPNUM: '
    || v_zip_count);
END;
/
SELECT * FROM zipcode WHERE STATE = 'MI';
ROLLBACK;

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    v_flag        VARCHAR2(7);
    v_zip_count   NUMBER;
BEGIN
    add_zip('48104','Ann Arbor','MI',v_flag,v_zip_count);
    dbms_output.put_line('FLAG: '
    || v_flag);
    dbms_output.put_line('ZIPNUM: '
    || v_zip_count);
END;
/
SELECT * FROM zipcode WHERE STATE = 'MI';