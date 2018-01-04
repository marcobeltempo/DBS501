/*Marco Beltempo
12/22/2017
DBS501AA*/

create or replace FUNCTION get_descr (
    p_section_id   IN section.section_id%TYPE
) RETURN course.DESCRIPTION%TYPE IS
    v_description   course.DESCRIPTION%TYPE;
BEGIN
    SELECT
        C.DESCRIPTION
    INTO
        v_description
    FROM
        course C
        JOIN section S ON C.course_no = S.course_no
    WHERE
        S.section_id = p_section_id;
    RETURN v_description;
EXCEPTION
    WHEN no_data_found THEN
        RETURN 'There is NO such Section id: ' || p_section_id;
END get_descr;