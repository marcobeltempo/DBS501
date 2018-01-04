/*Marco Beltempo
10/3/2017
DBS501AA*/
SET SERVEROUTPUT  ON
SET VERIFY OFF

ACCEPT temp_max_range INTEGER PROMPT 'Please enter a Positive Integer: '; 
DECLARE
v_max_range INTEGER := '&temp_max_range';
v_counter BINARY_INTEGER := 1;
v_even_sum NUMBER := 0;
v_odd_sum NUMBER := 0;
BEGIN
WHILE v_counter <= v_max_range LOOP
  IF REMAINDER(v_counter,2) = 0 THEN
    v_even_sum := v_even_sum + v_counter;
  ELSE 
    v_odd_sum := v_odd_sum + v_counter;
  END IF;
v_counter := v_counter + 1;
END LOOP;
IF REMAINDER(v_max_range,2) = 0 THEN
DBMS_OUTPUT.PUT_LINE ('The sum of the even integers between 1 '||
'and ' || v_max_range|| ' is: '|| v_even_sum);
ELSE
DBMS_OUTPUT.PUT_LINE ('The sum of the odd integers between 1 '||
'and ' || v_max_range|| ' is: '|| v_odd_sum);
END IF;
END;
/
