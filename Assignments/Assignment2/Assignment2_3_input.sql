--Author: marcobeltempo - https://github.com/marcobeltempo

SET SERVEROUTPUT ON
SET VERIFY OFF
SELECT MY_PACK.TOTAL_COST(:tmp_student_id) AS COST FROM DUAL;
SELECT MY_PACK.TOTAL_COST(194) AS COST FROM DUAL;
SELECT MY_PACK.TOTAL_COST(294) AS COST FROM DUAL;
SELECT MY_PACK.TOTAL_COST(494) AS COST FROM DUAL;