/*Marco Beltempo
9/22/2017
DBS501AA*/

DECLARE
  v_student_id student.student_id%TYPE;
  v_last_name lab1_tab.lname%TYPE;
BEGIN
  BEGIN
    SELECT s.last_name
    INTO v_last_name
    FROM student s, enrollment e
    WHERE s.student_id = e.student_id
    HAVING LENGTH(s.last_name) < 9 AND COUNT(*)=
      (SELECT MAX(COUNT(*))
      FROM student s,
        enrollment e
      WHERE s.student_id = e.student_id
      GROUP BY s.student_id
      )
    GROUP BY s.last_name;
  EXCEPTION
  WHEN TOO_MANY_ROWS THEN
    v_last_name := 'Multiple Names';
  END;
  
  INSERT INTO lab1_tab VALUES
    (Lab1_seq.NEXTVAL, v_last_name);
    
  BEGIN
    SELECT s.last_name
    INTO v_last_name
    FROM student s,
      enrollment e
    WHERE s.student_id = e.student_id
    HAVING COUNT(*)=
      (SELECT MIN(COUNT(*))
      FROM student s, enrollment e
      WHERE s.student_id = e.student_id
      GROUP BY s.student_id
      )
    GROUP BY s.last_name;
  EXCEPTION
  WHEN TOO_MANY_ROWS THEN
    v_last_name := 'Multiple Names';
  END;
  
  INSERT INTO lab1_tab VALUES
    (Lab1_seq.NEXTVAL, v_last_name);
    
  BEGIN
    SELECT i.last_name
    INTO v_last_name
    FROM instructor i, section s
    WHERE s.instructor_id = i.instructor_id
    HAVING UPPER(i.last_name) NOT LIKE '%S'
    AND COUNT(*) =
      (SELECT MIN(COUNT(*))
      FROM instructor i,section s
      WHERE s.instructor_id = i.instructor_id
      GROUP BY i.instructor_id
      )
    GROUP BY i.last_name;
  EXCEPTION
  WHEN TOO_MANY_ROWS THEN
    v_last_name := 'Multiple Names';
  END;
  
  INSERT INTO lab1_tab VALUES
    (v_student_id, v_last_name
    );
    
  BEGIN
    SELECT i.last_name
    INTO v_last_name
    FROM instructor i, section s
    WHERE s.instructor_id = i.instructor_id
    HAVING COUNT(*)=
      (SELECT MAX(COUNT(*))
      FROM instructor i, section s
      WHERE s.instructor_id = i.instructor_id
      GROUP BY i.instructor_id
      )
    GROUP BY i.last_name;
  EXCEPTION
  WHEN TOO_MANY_ROWS THEN
    v_last_name := 'Multiple Names';
  END;
  
  INSERT INTO lab1_tab VALUES
    (Lab1_seq.NEXTVAL, v_last_name
    );
    
END;
SELECT * FROM Lab1_tab;
