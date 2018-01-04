REM ******************************************************************
REM   file: studentcre.sql
REM  description: used for droping student schema objects. Note that
REM this script firstly drops the objects, then re-creates them and finally populates them
REM  edited by Nebojsa in Fall 2009
REM ******************************************************************

SET  ECHO  OFF
SET  DEFINE OFF

REM === Drop Tables ===

DROP TABLE COURSE CASCADE CONSTRAINTS;
DROP TABLE ENROLLMENT CASCADE CONSTRAINTS;
DROP TABLE GRADE CASCADE CONSTRAINTS;
DROP TABLE GRADE_CONVERSION CASCADE CONSTRAINTS;
DROP TABLE GRADE_TYPE CASCADE CONSTRAINTS;
DROP TABLE GRADE_TYPE_WEIGHT CASCADE CONSTRAINTS;
DROP TABLE INSTRUCTOR CASCADE CONSTRAINTS;
DROP TABLE SECTION CASCADE CONSTRAINTS;
DROP TABLE STUDENT CASCADE CONSTRAINTS;
DROP TABLE ZIPCODE CASCADE CONSTRAINTS;

REM === Drop Sequences ===

DROP SEQUENCE COURSE_NO_SEQ;
DROP SEQUENCE INSTRUCTOR_ID_SEQ;
DROP SEQUENCE SECTION_ID_SEQ;
DROP SEQUENCE STUDENT_ID_SEQ;


REM ==== cREATE 10 TABLES ============

PROMPT Creating Table 'INSTRUCTOR'
CREATE TABLE INSTRUCTOR
 (INSTRUCTOR_ID NUMBER(8,0) 
 ,SALUTATION VARCHAR2(5)
 ,FIRST_NAME VARCHAR2(25)
 ,LAST_NAME VARCHAR2(25)
 ,STREET_ADDRESS VARCHAR2(50)
 ,ZIP VARCHAR2(5)
 ,PHONE VARCHAR2(15)
 ,CREATED_BY VARCHAR2(30) 
 ,CREATED_DATE DATE 
 ,MODIFIED_BY VARCHAR2(30) 
 ,MODIFIED_DATE DATE 
 )
/

COMMENT ON TABLE INSTRUCTOR IS 'Profile information for an instructor.'
/

COMMENT ON COLUMN INSTRUCTOR.INSTRUCTOR_ID IS 'The unique ID for an instructor.'
/

COMMENT ON COLUMN INSTRUCTOR.SALUTATION IS 'This instructor''s title (Mr., Ms., Dr., Rev., etc.)'
/

COMMENT ON COLUMN INSTRUCTOR.FIRST_NAME IS 'This instructor''s first name.'
/

COMMENT ON COLUMN INSTRUCTOR.LAST_NAME IS 'This instructor''s last name'
/

COMMENT ON COLUMN INSTRUCTOR.STREET_ADDRESS IS 'This Instructor''s street address.'
/

COMMENT ON COLUMN INSTRUCTOR.ZIP IS 'The unique zip code number for this instructor.'
/

COMMENT ON COLUMN INSTRUCTOR.PHONE IS 'The phone number for this instructor including area code.'
/

COMMENT ON COLUMN INSTRUCTOR.CREATED_BY IS 'Audit column - indicates user who inserted data.'
/

COMMENT ON COLUMN INSTRUCTOR.CREATED_DATE IS 'Audit column - indicates date of insert.'
/

COMMENT ON COLUMN INSTRUCTOR.MODIFIED_BY IS 'Audit column - indicates who made last update.'
/

COMMENT ON COLUMN INSTRUCTOR.MODIFIED_DATE IS 'Audit column - date of last update.'
/

PROMPT Creating Table 'GRADE'
CREATE TABLE GRADE
 (STUDENT_ID NUMBER(8,0) 
 ,SECTION_ID NUMBER(8,0) 
 ,GRADE_TYPE_CODE CHAR(2) 
 ,GRADE_CODE_OCCURRENCE NUMBER(38,0) 
 ,NUMERIC_GRADE NUMBER(3,0) DEFAULT 0 
 ,COMMENTS VARCHAR2(2000)
 ,CREATED_BY VARCHAR2(30) 
 ,CREATED_DATE DATE 
 ,MODIFIED_BY VARCHAR2(30) 
 ,MODIFIED_DATE DATE 
 )
/

COMMENT ON TABLE GRADE IS 'The individual grades a student received for a particular section(class).'
/

COMMENT ON COLUMN GRADE.STUDENT_ID IS 'The unique ID for the student.'
/

COMMENT ON COLUMN GRADE.SECTION_ID IS 'The unique ID for a section.'
/

COMMENT ON COLUMN GRADE.GRADE_TYPE_CODE IS 'The code which identifies a category of grade.'
/

COMMENT ON COLUMN GRADE.GRADE_CODE_OCCURRENCE IS 'The sequence number of one grade type for one section. For example, there could be multiple assignments numbered 1, 2, 3, etc.'
/

COMMENT ON COLUMN GRADE.NUMERIC_GRADE IS 'Numeric grade value, i.e. 70, 75.'
/

COMMENT ON COLUMN GRADE.COMMENTS IS 'Instructor''s comments on this grade.'
/

COMMENT ON COLUMN GRADE.CREATED_BY IS 'Audit column - indicates user who inserted data.'
/

COMMENT ON COLUMN GRADE.CREATED_DATE IS 'Audit column - indicates date of insert.'
/

COMMENT ON COLUMN GRADE.MODIFIED_BY IS 'Audit column - indicates who made last update.'
/

COMMENT ON COLUMN GRADE.MODIFIED_DATE IS 'Audit column - date of last update.'
/

PROMPT Creating Table 'GRADE_TYPE'
CREATE TABLE GRADE_TYPE
 (GRADE_TYPE_CODE CHAR(2) 
 ,DESCRIPTION VARCHAR2(50) 
 ,CREATED_BY VARCHAR2(30) 
 ,CREATED_DATE DATE 
 ,MODIFIED_BY VARCHAR2(30) 
 ,MODIFIED_DATE DATE 
 )
/

COMMENT ON TABLE GRADE_TYPE IS 'Lookup table of a grade types (code) and its description.'
/

COMMENT ON COLUMN GRADE_TYPE.GRADE_TYPE_CODE IS 'The unique code which identifies a category of grade, i.e. MT, HW.'
/

COMMENT ON COLUMN GRADE_TYPE.DESCRIPTION IS 'The description for this code, i.e. Midterm, Homework.'
/

COMMENT ON COLUMN GRADE_TYPE.CREATED_BY IS 'Audit column - indicates user who inserted data.'
/

COMMENT ON COLUMN GRADE_TYPE.CREATED_DATE IS 'Audit column - indicates date of insert.'
/

COMMENT ON COLUMN GRADE_TYPE.MODIFIED_BY IS 'Audit column - indicates who made last update.'
/

COMMENT ON COLUMN GRADE_TYPE.MODIFIED_DATE IS 'Audit column - date of last update.'
/

PROMPT Creating Table 'GRADE_CONVERSION'
CREATE TABLE GRADE_CONVERSION
 (LETTER_GRADE VARCHAR2(2) 
 ,GRADE_POINT NUMBER(3,2) DEFAULT 0 
 ,MAX_GRADE NUMBER(3,0) 
 ,MIN_GRADE NUMBER(3,0) 
 ,CREATED_BY VARCHAR2(30) 
 ,CREATED_DATE DATE 
 ,MODIFIED_BY VARCHAR2(30)
 ,MODIFIED_DATE DATE  
 )
/

COMMENT ON TABLE GRADE_CONVERSION IS 'Converts a number grade to a letter grade.'
/

COMMENT ON COLUMN GRADE_CONVERSION.LETTER_GRADE IS 'The unique grade as a letter (A, A-, B, B+, etc.).'
/

COMMENT ON COLUMN GRADE_CONVERSION.GRADE_POINT IS 'The number grade on a scale from 0 (F) to 4 (A).'
/

COMMENT ON COLUMN GRADE_CONVERSION.MAX_GRADE IS 'The highest grade number which makes this letter grade.'
/

COMMENT ON COLUMN GRADE_CONVERSION.MIN_GRADE IS 'The lowest grade number which makes this letter grade.'
/

COMMENT ON COLUMN GRADE_CONVERSION.CREATED_BY IS 'Audit column - indicates user who inserted data.'
/

COMMENT ON COLUMN GRADE_CONVERSION.CREATED_DATE IS 'Audit column - indicates date of insert.'
/

COMMENT ON COLUMN GRADE_CONVERSION.MODIFIED_BY IS 'Audit column - indicates who made last update.'
/

COMMENT ON COLUMN GRADE_CONVERSION.MODIFIED_DATE IS 'Audit column - date of last update.'
/

PROMPT Creating Table 'GRADE_TYPE_WEIGHT'
CREATE TABLE GRADE_TYPE_WEIGHT
 (SECTION_ID NUMBER(8,0) 
 ,GRADE_TYPE_CODE CHAR(2) 
 ,NUMBER_PER_SECTION NUMBER(3,0) 
 ,PERCENT_OF_FINAL_GRADE NUMBER(3,0) 
 ,DROP_LOWEST CHAR(1) 
 ,CREATED_BY VARCHAR2(30) 
 ,CREATED_DATE DATE 
 ,MODIFIED_BY VARCHAR2(30) 
 ,MODIFIED_DATE DATE 
 )
/

COMMENT ON TABLE GRADE_TYPE_WEIGHT IS 'Information on how the final grade for a particular section is computed.  For example, the midterm constitutes 50%, the quiz 10% and the final examination 40% of the final grade.'
/

COMMENT ON COLUMN GRADE_TYPE_WEIGHT.SECTION_ID IS 'The unique section ID for a section.'
/

COMMENT ON COLUMN GRADE_TYPE_WEIGHT.GRADE_TYPE_CODE IS 'The code which identifies a category of grade.'
/

COMMENT ON COLUMN GRADE_TYPE_WEIGHT.NUMBER_PER_SECTION IS 'How many of these grade types can be used in this section.  That is, there may be 3 quizzes.'
/

COMMENT ON COLUMN GRADE_TYPE_WEIGHT.PERCENT_OF_FINAL_GRADE IS 'The precentage this category of grade contributes to the final grade.'
/

COMMENT ON COLUMN GRADE_TYPE_WEIGHT.DROP_LOWEST IS 'Is the lowest grade in this type removed when determining the final grade? (Y/N)'
/

COMMENT ON COLUMN GRADE_TYPE_WEIGHT.CREATED_BY IS 'Audit column - indicates user who inserted data.'
/

COMMENT ON COLUMN GRADE_TYPE_WEIGHT.CREATED_DATE IS 'Audit column - indicates date of insert.'
/

COMMENT ON COLUMN GRADE_TYPE_WEIGHT.MODIFIED_BY IS 'Audit column - indicates who made last update.'
/

COMMENT ON COLUMN GRADE_TYPE_WEIGHT.MODIFIED_DATE IS 'Audit column - date of last update.'
/

PROMPT Creating Table 'SECTION'
CREATE TABLE SECTION
 (SECTION_ID NUMBER(8,0) 
 ,COURSE_NO NUMBER(8,0) 
 ,SECTION_NO NUMBER(3,0) 
 ,START_DATE_TIME DATE
 ,LOCATION VARCHAR2(50)
 ,INSTRUCTOR_ID NUMBER(8,0) 
 ,CAPACITY NUMBER(3,0)
 ,CREATED_BY VARCHAR2(30) 
 ,CREATED_DATE DATE 
 ,MODIFIED_BY VARCHAR2(30) 
 ,MODIFIED_DATE DATE 
 )
/

COMMENT ON TABLE SECTION IS 'Information for an individual section (class) of a particular course.'
/

COMMENT ON COLUMN SECTION.SECTION_ID IS 'The unique ID for a section.'
/

COMMENT ON COLUMN SECTION.COURSE_NO IS 'The course number for which this is a section.'
/

COMMENT ON COLUMN SECTION.SECTION_NO IS 'The individual section number within this course.'
/

COMMENT ON COLUMN SECTION.START_DATE_TIME IS 'The date and time on which this section meets.'
/

COMMENT ON COLUMN SECTION.LOCATION IS 'The meeting room for the section.'
/

COMMENT ON COLUMN SECTION.INSTRUCTOR_ID IS 'The ID number of the instructor who teaches this section.'
/

COMMENT ON COLUMN SECTION.CAPACITY IS 'The maximum number of students allowed in this section.'
/

COMMENT ON COLUMN SECTION.CREATED_BY IS 'Audit column - indicates user who inserted data.'
/

COMMENT ON COLUMN SECTION.CREATED_DATE IS 'Audit column - indicates date of insert.'
/

COMMENT ON COLUMN SECTION.MODIFIED_BY IS 'Audit column - indicates who made last update.'
/

COMMENT ON COLUMN SECTION.MODIFIED_DATE IS 'Audit column - date of last update.'
/

PROMPT Creating Table 'COURSE'
CREATE TABLE COURSE
 (COURSE_NO NUMBER(38,0) 
 ,DESCRIPTION VARCHAR2(50) 
 ,COST NUMBER(9,2) 
 ,PREREQUISITE NUMBER(8,0)
 ,CREATED_BY VARCHAR2(30) 
 ,CREATED_DATE DATE 
 ,MODIFIED_BY VARCHAR2(30) 
 ,MODIFIED_DATE DATE 
 )
/

COMMENT ON TABLE COURSE IS 'Information for a course.'
/

COMMENT ON COLUMN COURSE.COURSE_NO IS 'The unique ID for a course.'
/

COMMENT ON COLUMN COURSE.DESCRIPTION IS 'The full name for this course.'
/

COMMENT ON COLUMN COURSE.COST IS 'The dollar amount charged for enrollment in this course.'
/

COMMENT ON COLUMN COURSE.PREREQUISITE IS 'The ID number of the course which must be taken as a prerequisite to this course.'
/

COMMENT ON COLUMN COURSE.CREATED_BY IS 'Audit column - indicates user who inserted data.'
/

COMMENT ON COLUMN COURSE.CREATED_DATE IS 'Audit column - indicates date of insert.'
/

COMMENT ON COLUMN COURSE.MODIFIED_BY IS 'Audit column - indicates who made last update.'
/

COMMENT ON COLUMN COURSE.MODIFIED_DATE IS 'Audit column - date of last update.'
/

PROMPT Creating Table 'ENROLLMENT'
CREATE TABLE ENROLLMENT
 (STUDENT_ID NUMBER(8,0) 
 ,SECTION_ID NUMBER(8,0) 
 ,ENROLL_DATE DATE 
 ,FINAL_GRADE NUMBER(3,0)
 ,CREATED_BY VARCHAR2(30) 
 ,CREATED_DATE DATE 
 ,MODIFIED_BY VARCHAR2(30) 
 ,MODIFIED_DATE DATE 
 )
/

COMMENT ON TABLE ENROLLMENT IS 'Information for a student registered for a particular section (class).'
/

COMMENT ON COLUMN ENROLLMENT.STUDENT_ID IS 'The unique ID for a student.'
/

COMMENT ON COLUMN ENROLLMENT.SECTION_ID IS 'The unique ID for a section.'
/

COMMENT ON COLUMN ENROLLMENT.ENROLL_DATE IS 'The date this student registered for this section.'
/

COMMENT ON COLUMN ENROLLMENT.FINAL_GRADE IS 'The final grade given to this student for all work in this section (class).'
/

COMMENT ON COLUMN ENROLLMENT.CREATED_BY IS 'Audit column - indicates user who inserted data.'
/

COMMENT ON COLUMN ENROLLMENT.CREATED_DATE IS 'Audit column - indicates date of insert.'
/

COMMENT ON COLUMN ENROLLMENT.MODIFIED_BY IS 'Audit column - indicates who made last update.'
/

COMMENT ON COLUMN ENROLLMENT.MODIFIED_DATE IS 'Audit column - date of last update.'
/

PROMPT Creating Table 'STUDENT'
CREATE TABLE STUDENT
 (STUDENT_ID NUMBER(8,0) 
 ,SALUTATION VARCHAR2(5)
 ,FIRST_NAME VARCHAR2(25)
 ,LAST_NAME VARCHAR2(25) 
 ,STREET_ADDRESS VARCHAR2(50)
 ,ZIP VARCHAR2(5) 
 ,PHONE VARCHAR2(15)
 ,EMPLOYER VARCHAR2(50)
 ,REGISTRATION_DATE DATE 
 ,CREATED_BY VARCHAR2(30) 
 ,CREATED_DATE DATE 
 ,MODIFIED_BY VARCHAR2(30) 
 ,MODIFIED_DATE DATE 
 )
/

COMMENT ON TABLE STUDENT IS 'Profile information for a student.'
/

COMMENT ON COLUMN STUDENT.STUDENT_ID IS 'The unique ID for a student.'
/

COMMENT ON COLUMN STUDENT.SALUTATION IS 'The student''s title (Ms., Mr., Dr., etc.).'
/

COMMENT ON COLUMN STUDENT.FIRST_NAME IS 'This student''s first name.'
/

COMMENT ON COLUMN STUDENT.LAST_NAME IS 'This student''s last name.'
/

COMMENT ON COLUMN STUDENT.STREET_ADDRESS IS 'The student''s street address.'
/

COMMENT ON COLUMN STUDENT.ZIP IS 'The postal zip code for this student.'
/

COMMENT ON COLUMN STUDENT.PHONE IS 'The phone number for this student including area code.'
/

COMMENT ON COLUMN STUDENT.EMPLOYER IS 'The name of the company where this student is employed.'
/

COMMENT ON COLUMN STUDENT.REGISTRATION_DATE IS 'The date this student registered in the program.'
/

COMMENT ON COLUMN STUDENT.CREATED_BY IS 'Audit column - indicates user who inserted data.'
/

COMMENT ON COLUMN STUDENT.CREATED_DATE IS 'Audit column - indicates date of insert.'
/

COMMENT ON COLUMN STUDENT.MODIFIED_BY IS 'Audit column - indicates who made last update.'
/

COMMENT ON COLUMN STUDENT.MODIFIED_DATE IS 'Audit column - date of last update.'
/

PROMPT Creating Table 'ZIPCODE'
CREATE TABLE ZIPCODE
 (ZIP VARCHAR2(5) 
 ,CITY VARCHAR2(25)
 ,STATE VARCHAR2(2)
 ,CREATED_BY VARCHAR2(30) 
 ,CREATED_DATE DATE 
 ,MODIFIED_BY VARCHAR2(30) 
 ,MODIFIED_DATE DATE 
 )
/

COMMENT ON TABLE ZIPCODE IS 'City, state and zip code information.'
/

COMMENT ON COLUMN ZIPCODE.ZIP IS 'The zip code number, unique for a city and state.'
/

COMMENT ON COLUMN ZIPCODE.CITY IS 'The city name for this zip code.'
/

COMMENT ON COLUMN ZIPCODE.STATE IS 'The postal abbreviation for the US state.'
/

COMMENT ON COLUMN ZIPCODE.CREATED_BY IS 'Audit column - indicates user who inserted data.'
/

COMMENT ON COLUMN ZIPCODE.CREATED_DATE IS 'Audit column - indicates date of insert.'
/

COMMENT ON COLUMN ZIPCODE.MODIFIED_BY IS 'Audit column - indicates who made last update.'
/

COMMENT ON COLUMN ZIPCODE.MODIFIED_DATE IS 'Audit column - date of last update.'
/


REM ===== Populates COURSE table ================

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-RR';

INSERT INTO course VALUES (10,'DP Overview',1195,NULL,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                                   
INSERT INTO course VALUES (20,'Intro to Computers',1195,NULL,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                            
INSERT INTO course VALUES (25,'Intro to Programming',1195,140,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                           
INSERT INTO course VALUES (80,'Structured Programming Techniques',1595,204,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                              
INSERT INTO course VALUES (100,'Hands-On Windows',1195,20,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                               
INSERT INTO course VALUES (120,'Intro to Java Programming',1195,80,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                      
INSERT INTO course VALUES (122,'Intermediate Java Programming',1195,120,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                 
INSERT INTO course VALUES (124,'Advanced Java Programming',1195,122,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                     
INSERT INTO course VALUES (125,'JDeveloper',1195,122,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                                    
INSERT INTO course VALUES (130,'Intro to Unix',1195,310,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                                 
INSERT INTO course VALUES (132,'Basics of Unix Admin',1195,130,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                          
INSERT INTO course VALUES (134,'Advanced Unix Admin',1195,132,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                           
INSERT INTO course VALUES (135,'Unix Tips and Techniques',1095,134,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                      
INSERT INTO course VALUES (140,'Structured Analysis',1195,20,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                            
INSERT INTO course VALUES (142,'Project Management',1195,20,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                             
INSERT INTO course VALUES (144,'Database Design',1195,420,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                               
INSERT INTO course VALUES (145,'Internet Protocols',1195,310,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                            
INSERT INTO course VALUES (146,'Java for C/C++ Programmers',1195,NULL,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                   
INSERT INTO course VALUES (147,'GUI Programming',1195,20,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                                
INSERT INTO course VALUES (204,'Intro to SQL',1195,20,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                                   
INSERT INTO course VALUES (210,'Oracle Tools',1195,220,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                                  
INSERT INTO course VALUES (220,'PL/SQL Programming',1195,80,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                             
INSERT INTO course VALUES (230,'Intro to Internet',1095,10,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                              
INSERT INTO course VALUES (240,'Intro to the Basic Language',1095,25,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                    
INSERT INTO course VALUES (310,'Operating Systems',1195,NULL,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                            
INSERT INTO course VALUES (330,'Network Administration',1195,130,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                        
INSERT INTO course VALUES (350,'JDeveloper Lab',1195,125,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                                
INSERT INTO course VALUES (420,'Database System Principles',1195,25,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                     
INSERT INTO course VALUES (430,'JDeveloper Techniques',1195,350,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                         
INSERT INTO course VALUES (450,'DB Programming in Java',NULL,350,'DSCHERER','29-MAR-99','ARISCHER','05-APR-99');                                                                                        

COMMIT;

REM ========== Populates ENROLLMENT table ==========

INSERT INTO enrollment VALUES (102,86,'30-JAN-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (102,89,'30-JAN-99',92,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                      
INSERT INTO enrollment VALUES (103,81,'30-JAN-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (104,81,'30-JAN-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (105,155,'30-JAN-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (106,99,'30-JAN-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (106,101,'30-JAN-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (107,87,'30-JAN-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (108,86,'30-JAN-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (109,99,'30-JAN-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (109,101,'30-JAN-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (110,95,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (110,154,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (111,133,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (111,142,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (112,95,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (112,154,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (113,128,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (113,156,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (114,128,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (114,156,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (117,94,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (117,130,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (118,90,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (119,103,'02-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (120,103,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (121,87,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (122,87,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (123,87,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (124,83,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (124,87,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (124,116,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (124,148,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (127,95,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (127,155,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (128,80,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (129,113,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (130,106,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (130,141,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (133,107,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (133,131,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (134,102,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (135,112,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (136,89,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (137,89,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (138,126,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (138,152,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (139,95,'04-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (140,94,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (141,100,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (142,143,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (143,85,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (144,152,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (145,106,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (146,147,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (147,117,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (147,120,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (148,123,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (149,147,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (150,89,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (151,89,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (152,89,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (153,144,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (154,88,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (156,147,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (157,147,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (158,84,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (159,85,'07-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (160,130,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (161,104,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (162,133,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (163,92,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (164,89,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (165,156,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (166,88,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (167,88,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (168,133,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (169,150,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (170,156,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (171,127,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (172,155,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (173,150,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (173,156,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (174,156,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (175,141,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (176,115,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (176,132,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (178,120,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (178,135,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (179,116,'10-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (180,116,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (180,119,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (181,117,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (182,117,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (184,116,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (184,138,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (184,146,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (185,116,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (186,107,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (187,120,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (188,117,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (189,116,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (189,137,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (190,117,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (191,117,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (192,117,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (193,119,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (194,116,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (195,141,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (196,108,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (197,109,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (198,108,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (199,84,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                    
INSERT INTO enrollment VALUES (199,142,'11-FEB-99',NULL,'JAYCAF','03-NOV-99','CBRENNAN','12-DEC-99');                                                                                                   
INSERT INTO enrollment VALUES (200,106,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (200,144,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (201,143,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (202,105,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (203,132,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (204,88,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (205,88,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (206,152,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (207,152,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (208,147,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (209,147,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (210,147,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (211,86,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (211,141,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (212,86,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (214,123,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (214,135,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (214,146,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (214,156,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (215,135,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (215,146,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (215,156,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (216,154,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (217,86,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (218,90,'13-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (220,119,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (221,104,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (223,104,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (223,119,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (224,89,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (225,89,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (227,89,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (227,96,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (228,148,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (229,111,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (230,86,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (232,91,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (232,147,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (232,149,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (233,90,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (233,112,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (234,137,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (235,83,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (235,150,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (236,138,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (236,140,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (237,85,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (237,141,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (238,85,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (238,103,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (238,141,'16-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (240,81,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (241,155,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (242,148,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (243,103,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (244,82,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (245,82,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (246,85,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (247,92,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (248,148,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (248,155,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (250,126,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (250,146,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (250,154,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (251,99,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (251,101,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (252,99,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (252,101,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (253,89,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (254,87,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (256,87,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (256,89,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (257,90,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (258,106,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (259,105,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (259,135,'19-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (260,105,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (260,148,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (261,105,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (262,100,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (263,105,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (264,116,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (265,92,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (266,92,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (267,95,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (267,125,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (268,126,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (269,126,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (270,126,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (270,153,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (271,91,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (271,145,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (272,153,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (273,151,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (274,151,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (275,153,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (276,99,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (276,101,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (277,99,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (277,101,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (278,99,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (278,101,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (279,99,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (279,101,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (280,99,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (280,101,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (281,99,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (281,101,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (282,99,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (282,101,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 
INSERT INTO enrollment VALUES (283,99,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                  
INSERT INTO enrollment VALUES (283,101,'21-FEB-99',NULL,'DSCHERER','14-DEC-99','BROSENZW','05-JAN-00');                                                                                                 

COMMIT;

REM  ============ Populates  GRADE table ===========

REM ******************************************************************
REM   file: insertGrade.sql
REM  description: used for loading Grade data
REM  created January 30, 2000
REM ******************************************************************


INSERT INTO grade VALUES (102,86,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (102,86,'HM',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (102,86,'HM',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (102,86,'HM',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (102,86,'HM',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (102,86,'MT',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (102,86,'PA',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (102,86,'QZ',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (102,86,'QZ',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (102,86,'QZ',3,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (102,86,'QZ',4,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (102,89,'FI',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (102,89,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (103,81,'FI',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (103,81,'HM',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (103,81,'HM',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (103,81,'HM',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (103,81,'HM',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (103,81,'MT',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (103,81,'PA',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (103,81,'QZ',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (103,81,'QZ',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (103,81,'QZ',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (103,81,'QZ',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (104,81,'FI',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (104,81,'HM',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (104,81,'HM',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (104,81,'HM',3,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (104,81,'HM',4,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (104,81,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (104,81,'PA',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (104,81,'QZ',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (104,81,'QZ',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (104,81,'QZ',3,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (104,81,'QZ',4,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (105,155,'PA',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (105,155,'PA',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (105,155,'PA',3,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (105,155,'PA',4,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (105,155,'PA',5,72,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (105,155,'PA',6,72,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (105,155,'PA',7,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (105,155,'PA',8,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (105,155,'PA',9,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (105,155,'PA',10,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (105,155,'PA',11,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (105,155,'PA',12,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (105,155,'PJ',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (106,99,'FI',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (106,99,'HM',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (106,99,'HM',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (106,99,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (106,99,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (106,99,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (106,99,'PA',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (106,99,'QZ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (106,99,'QZ',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (106,101,'FI',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (106,101,'HM',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (106,101,'HM',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (106,101,'HM',3,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (106,101,'HM',4,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (106,101,'MT',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (106,101,'PA',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (106,101,'QZ',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (106,101,'QZ',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (107,87,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (107,87,'HM',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (107,87,'HM',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (107,87,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (107,87,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (107,87,'HM',5,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (107,87,'HM',6,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (107,87,'HM',7,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (107,87,'HM',8,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (107,87,'HM',9,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (107,87,'HM',10,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (107,87,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (108,86,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (108,86,'HM',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (108,86,'HM',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (108,86,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (108,86,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (108,86,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (108,86,'PA',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (108,86,'QZ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (108,86,'QZ',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (108,86,'QZ',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (108,86,'QZ',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (109,99,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (109,99,'HM',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (109,99,'HM',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (109,99,'HM',3,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (109,99,'HM',4,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (109,99,'MT',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (109,99,'PA',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (109,99,'QZ',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (109,99,'QZ',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (109,101,'FI',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (109,101,'HM',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (109,101,'HM',2,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (109,101,'HM',3,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (109,101,'HM',4,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (109,101,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (109,101,'PA',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (109,101,'QZ',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (109,101,'QZ',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (110,95,'FI',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (110,95,'HM',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (110,95,'HM',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (110,95,'HM',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (110,95,'HM',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (110,95,'MT',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (110,95,'PA',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (110,95,'QZ',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (110,95,'QZ',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (110,154,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (110,154,'HM',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (110,154,'HM',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (110,154,'HM',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (110,154,'HM',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (110,154,'HM',5,95,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (110,154,'HM',6,95,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (110,154,'HM',7,95,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (110,154,'HM',8,95,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (110,154,'HM',9,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (110,154,'HM',10,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (110,154,'MT',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,133,'PA',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,133,'PA',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,133,'PA',3,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,133,'PA',4,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,133,'PA',5,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,133,'PA',6,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,133,'PA',7,70,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,133,'PA',8,70,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,133,'PA',9,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,133,'PA',10,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (111,133,'PA',11,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (111,133,'PA',12,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (111,133,'PJ',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,142,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,142,'HM',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,142,'HM',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,142,'HM',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,142,'HM',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,142,'MT',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,142,'PA',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,142,'QZ',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,142,'QZ',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,142,'QZ',3,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (111,142,'QZ',4,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (112,95,'FI',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (112,95,'HM',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (112,95,'HM',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (112,95,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (112,95,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (112,95,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (112,95,'PA',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (112,95,'QZ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (112,95,'QZ',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (112,154,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (112,154,'HM',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (112,154,'HM',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (112,154,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (112,154,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (112,154,'HM',5,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (112,154,'HM',6,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (112,154,'HM',7,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (112,154,'HM',8,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (112,154,'HM',9,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (112,154,'HM',10,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (112,154,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (113,128,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (113,128,'HM',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (113,128,'HM',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (113,128,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (113,128,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (113,128,'HM',5,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (113,128,'HM',6,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (113,128,'HM',7,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (113,128,'HM',8,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (113,128,'HM',9,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (113,128,'HM',10,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (113,128,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (113,156,'FI',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (113,156,'MT',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (114,128,'FI',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (114,128,'HM',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (114,128,'HM',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (114,128,'HM',3,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (114,128,'HM',4,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (114,128,'HM',5,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (114,128,'HM',6,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (114,128,'HM',7,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (114,128,'HM',8,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (114,128,'HM',9,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (114,128,'HM',10,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (114,128,'MT',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (114,156,'FI',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (114,156,'MT',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (117,94,'FI',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (117,94,'HM',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (117,94,'HM',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (117,94,'HM',3,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (117,94,'HM',4,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (117,94,'MT',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (117,94,'PA',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (117,94,'QZ',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (117,94,'QZ',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (117,94,'QZ',3,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (117,94,'QZ',4,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (117,130,'FI',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (117,130,'HM',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (117,130,'HM',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (117,130,'HM',3,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (117,130,'HM',4,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (117,130,'MT',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (117,130,'PA',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (117,130,'QZ',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (117,130,'QZ',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (118,90,'FI',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (118,90,'MT',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (119,103,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (119,103,'HM',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (119,103,'HM',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (119,103,'HM',3,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (119,103,'HM',4,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (119,103,'MT',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (119,103,'PA',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (119,103,'QZ',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (119,103,'QZ',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (120,103,'FI',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (120,103,'HM',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (120,103,'HM',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (120,103,'HM',3,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (120,103,'HM',4,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (120,103,'MT',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (120,103,'PA',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (120,103,'QZ',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (120,103,'QZ',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (121,87,'FI',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (121,87,'HM',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (121,87,'HM',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (121,87,'HM',3,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (121,87,'HM',4,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (121,87,'HM',5,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (121,87,'HM',6,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (121,87,'HM',7,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (121,87,'HM',8,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (121,87,'HM',9,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (121,87,'HM',10,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (121,87,'MT',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (122,87,'FI',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (122,87,'HM',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (122,87,'HM',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (122,87,'HM',3,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (122,87,'HM',4,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (122,87,'HM',5,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (122,87,'HM',6,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (122,87,'HM',7,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (122,87,'HM',8,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (122,87,'HM',9,78,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (122,87,'HM',10,78,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (122,87,'MT',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (123,87,'FI',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (123,87,'HM',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (123,87,'HM',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (123,87,'HM',3,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (123,87,'HM',4,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (123,87,'HM',5,89,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (123,87,'HM',6,89,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (123,87,'HM',7,89,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (123,87,'HM',8,79,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (123,87,'HM',9,79,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (123,87,'HM',10,89,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (123,87,'MT',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (124,83,'FI',1,99,NULL,'ARISCHER','09-AUG-99','ARISCHER','10-AUG-99');                                                                                                         
INSERT INTO grade VALUES (124,87,'FI',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (124,87,'HM',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (124,87,'HM',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (124,87,'HM',3,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (124,87,'HM',4,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (124,87,'HM',5,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (124,87,'HM',6,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (124,87,'HM',7,70,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (124,87,'HM',8,70,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (124,87,'HM',9,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (124,87,'HM',10,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,87,'MT',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (124,116,'FI',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,116,'HM',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,116,'HM',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,116,'HM',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,116,'HM',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,116,'MT',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,116,'PA',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,116,'QZ',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,116,'QZ',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,148,'FI',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,148,'HM',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,148,'HM',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,148,'HM',3,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,148,'HM',4,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,148,'HM',5,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,148,'HM',6,94,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,148,'HM',7,94,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,148,'HM',8,94,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,148,'HM',9,94,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (124,148,'HM',10,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (124,148,'MT',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (127,95,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (127,95,'HM',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (127,95,'HM',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (127,95,'HM',3,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (127,95,'HM',4,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (127,95,'MT',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (127,95,'PA',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (127,95,'QZ',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (127,95,'QZ',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (127,155,'PA',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (127,155,'PA',2,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (127,155,'PA',3,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (127,155,'PA',4,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (127,155,'PA',5,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (127,155,'PA',6,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (127,155,'PA',7,93,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (127,155,'PA',8,93,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (127,155,'PA',9,93,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (127,155,'PA',10,93,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (127,155,'PA',11,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (127,155,'PA',12,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (127,155,'PJ',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (128,80,'FI',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (128,80,'HM',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (128,80,'HM',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (128,80,'HM',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (128,80,'HM',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (128,80,'MT',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (128,80,'PA',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (128,80,'QZ',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (128,80,'QZ',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (128,80,'QZ',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (128,80,'QZ',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (129,113,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (129,113,'HM',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (129,113,'HM',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (129,113,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (129,113,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (129,113,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (129,113,'PA',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (129,113,'QZ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (129,113,'QZ',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (129,113,'QZ',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (129,113,'QZ',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,106,'FI',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,106,'HM',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,106,'HM',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,106,'HM',3,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,106,'HM',4,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,106,'MT',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,106,'PA',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,106,'QZ',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,106,'QZ',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,106,'QZ',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,106,'QZ',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,141,'FI',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,141,'HM',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,141,'HM',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,141,'HM',3,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,141,'HM',4,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,141,'MT',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,141,'PA',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,141,'QZ',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (130,141,'QZ',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,107,'FI',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,107,'HM',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,107,'HM',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,107,'HM',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,107,'HM',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,107,'MT',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,107,'PA',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,107,'QZ',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,107,'QZ',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,131,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,131,'HM',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,131,'HM',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,131,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,131,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,131,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,131,'PA',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,131,'QZ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,131,'QZ',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,131,'QZ',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (133,131,'QZ',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (134,102,'FI',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (134,102,'HM',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (134,102,'HM',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (134,102,'HM',3,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (134,102,'HM',4,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (134,102,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (134,102,'PA',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (134,102,'QZ',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (134,102,'QZ',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (134,102,'QZ',3,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (134,102,'QZ',4,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (135,112,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (135,112,'HM',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (135,112,'HM',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (135,112,'HM',3,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (135,112,'HM',4,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (135,112,'MT',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (135,112,'PA',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (135,112,'QZ',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (135,112,'QZ',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (136,89,'FI',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (136,89,'MT',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (137,89,'FI',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (137,89,'MT',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (138,126,'FI',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,126,'HM',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,126,'HM',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,126,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,126,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,126,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,126,'PA',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,126,'QZ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,126,'QZ',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,152,'FI',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,152,'HM',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,152,'HM',2,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,152,'HM',3,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,152,'HM',4,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,152,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,152,'PA',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,152,'QZ',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (138,152,'QZ',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (139,95,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (139,95,'HM',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (139,95,'HM',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (139,95,'HM',3,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (139,95,'HM',4,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (139,95,'MT',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (139,95,'PA',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (139,95,'QZ',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (139,95,'QZ',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (140,94,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (140,94,'HM',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (140,94,'HM',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (140,94,'HM',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (140,94,'HM',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (140,94,'MT',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (140,94,'PA',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (140,94,'QZ',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (140,94,'QZ',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (140,94,'QZ',3,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (140,94,'QZ',4,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (141,100,'FI',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (141,100,'HM',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (141,100,'HM',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (141,100,'HM',3,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (141,100,'HM',4,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (141,100,'MT',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (141,100,'PA',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (141,100,'QZ',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (141,100,'QZ',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (141,100,'QZ',3,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (141,100,'QZ',4,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (142,143,'FI',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (142,143,'HM',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (142,143,'HM',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (142,143,'HM',3,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (142,143,'HM',4,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (142,143,'HM',5,72,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (142,143,'HM',6,72,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (142,143,'HM',7,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (142,143,'HM',8,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (142,143,'HM',9,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (142,143,'HM',10,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (142,143,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (143,85,'FI',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (143,85,'HM',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (143,85,'HM',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (143,85,'HM',3,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (143,85,'HM',4,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (143,85,'MT',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (143,85,'PA',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (143,85,'QZ',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (143,85,'QZ',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (144,152,'FI',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (144,152,'HM',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (144,152,'HM',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (144,152,'HM',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (144,152,'HM',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (144,152,'MT',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (144,152,'PA',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (144,152,'QZ',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (144,152,'QZ',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (145,106,'FI',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (145,106,'HM',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (145,106,'HM',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (145,106,'HM',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (145,106,'HM',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (145,106,'MT',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (145,106,'PA',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (145,106,'QZ',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (145,106,'QZ',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (145,106,'QZ',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (145,106,'QZ',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (146,147,'FI',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (146,147,'HM',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (146,147,'HM',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (146,147,'HM',3,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (146,147,'HM',4,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (146,147,'MT',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (146,147,'PA',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (146,147,'QZ',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (146,147,'QZ',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (146,147,'QZ',3,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (146,147,'QZ',4,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,117,'FI',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,117,'HM',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,117,'HM',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,117,'HM',3,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,117,'HM',4,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,117,'MT',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,117,'PA',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,117,'QZ',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,117,'QZ',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,117,'QZ',3,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,117,'QZ',4,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,120,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,120,'HM',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,120,'HM',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,120,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,120,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,120,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,120,'PA',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,120,'QZ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,120,'QZ',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,120,'QZ',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (147,120,'QZ',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (148,123,'FI',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (148,123,'HM',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (148,123,'HM',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (148,123,'HM',3,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (148,123,'HM',4,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (148,123,'MT',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (148,123,'PA',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (148,123,'QZ',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (148,123,'QZ',2,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (149,147,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (149,147,'HM',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (149,147,'HM',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (149,147,'HM',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (149,147,'HM',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (149,147,'MT',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (149,147,'PA',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (149,147,'QZ',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (149,147,'QZ',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (149,147,'QZ',3,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (149,147,'QZ',4,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (150,89,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (150,89,'MT',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (151,89,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (151,89,'MT',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (152,89,'FI',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (152,89,'MT',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (153,144,'PA',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (153,144,'PA',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (153,144,'PA',3,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (153,144,'PA',4,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (153,144,'PA',5,72,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (153,144,'PA',6,72,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (153,144,'PA',7,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (153,144,'PA',8,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (153,144,'PA',9,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (153,144,'PA',10,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (153,144,'PA',11,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (153,144,'PA',12,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (153,144,'PJ',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (154,88,'PA',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (154,88,'PA',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (154,88,'PA',3,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (154,88,'PA',4,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (154,88,'PA',5,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (154,88,'PA',6,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (154,88,'PA',7,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (154,88,'PA',8,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (154,88,'PA',9,78,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (154,88,'PA',10,78,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (154,88,'PA',11,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (154,88,'PA',12,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (154,88,'PJ',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (156,147,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (156,147,'HM',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (156,147,'HM',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (156,147,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (156,147,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (156,147,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (156,147,'PA',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (156,147,'QZ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (156,147,'QZ',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (156,147,'QZ',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (156,147,'QZ',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (157,147,'FI',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (157,147,'HM',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (157,147,'HM',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (157,147,'HM',3,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (157,147,'HM',4,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (157,147,'MT',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (157,147,'PA',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (157,147,'QZ',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (157,147,'QZ',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (157,147,'QZ',3,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (157,147,'QZ',4,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (158,84,'FI',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (158,84,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (159,85,'FI',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (159,85,'HM',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (159,85,'HM',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (159,85,'HM',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (159,85,'HM',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (159,85,'MT',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (159,85,'PA',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (159,85,'QZ',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (159,85,'QZ',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (160,130,'FI',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (160,130,'HM',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (160,130,'HM',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (160,130,'HM',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (160,130,'HM',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (160,130,'MT',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (160,130,'PA',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (160,130,'QZ',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (160,130,'QZ',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (161,104,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (161,104,'HM',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (161,104,'HM',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (161,104,'HM',3,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (161,104,'HM',4,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (161,104,'MT',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (161,104,'PA',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (161,104,'QZ',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (161,104,'QZ',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (162,133,'PA',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (162,133,'PA',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (162,133,'PA',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (162,133,'PA',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (162,133,'PA',5,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (162,133,'PA',6,71,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (162,133,'PA',7,71,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (162,133,'PA',8,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (162,133,'PA',9,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (162,133,'PA',10,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (162,133,'PA',11,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (162,133,'PA',12,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (162,133,'PJ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (163,92,'FI',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (163,92,'MT',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (164,89,'FI',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (164,89,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (165,156,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (165,156,'MT',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (166,88,'PA',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (166,88,'PA',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (166,88,'PA',3,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (166,88,'PA',4,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (166,88,'PA',5,89,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (166,88,'PA',6,89,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (166,88,'PA',7,89,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (166,88,'PA',8,79,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (166,88,'PA',9,79,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (166,88,'PA',10,89,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (166,88,'PA',11,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (166,88,'PA',12,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (166,88,'PJ',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (167,88,'PA',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (167,88,'PA',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (167,88,'PA',3,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (167,88,'PA',4,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (167,88,'PA',5,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (167,88,'PA',6,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (167,88,'PA',7,70,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (167,88,'PA',8,70,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (167,88,'PA',9,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (167,88,'PA',10,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (167,88,'PA',11,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (167,88,'PA',12,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (167,88,'PJ',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (168,133,'PA',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (168,133,'PA',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (168,133,'PA',3,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (168,133,'PA',4,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (168,133,'PA',5,72,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (168,133,'PA',6,72,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (168,133,'PA',7,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (168,133,'PA',8,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (168,133,'PA',9,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (168,133,'PA',10,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (168,133,'PA',11,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (168,133,'PA',12,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (168,133,'PJ',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (169,150,'FI',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (169,150,'MT',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (170,156,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (170,156,'MT',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (171,127,'FI',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (171,127,'HM',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (171,127,'HM',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (171,127,'HM',3,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (171,127,'HM',4,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (171,127,'MT',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (171,127,'PA',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (171,127,'QZ',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (171,127,'QZ',2,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (171,127,'QZ',3,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (171,127,'QZ',4,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (172,155,'PA',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (172,155,'PA',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (172,155,'PA',3,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (172,155,'PA',4,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (172,155,'PA',5,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (172,155,'PA',6,94,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (172,155,'PA',7,94,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (172,155,'PA',8,94,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (172,155,'PA',9,94,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (172,155,'PA',10,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (172,155,'PA',11,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (172,155,'PA',12,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (172,155,'PJ',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (173,150,'FI',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (173,150,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (173,156,'FI',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (173,156,'MT',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (174,156,'FI',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (174,156,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (175,141,'FI',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (175,141,'HM',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (175,141,'HM',2,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (175,141,'HM',3,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (175,141,'HM',4,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (175,141,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (175,141,'PA',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (175,141,'QZ',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (175,141,'QZ',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,115,'PA',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,115,'PA',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,115,'PA',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,115,'PA',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,115,'PA',5,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,115,'PA',6,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,115,'PA',7,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,115,'PA',8,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,115,'PA',9,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,115,'PA',10,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (176,115,'PA',11,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (176,115,'PA',12,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (176,115,'PJ',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,132,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,132,'HM',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,132,'HM',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,132,'HM',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,132,'HM',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,132,'HM',5,95,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,132,'HM',6,95,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,132,'HM',7,95,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,132,'HM',8,95,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,132,'HM',9,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (176,132,'HM',10,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (176,132,'MT',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,120,'FI',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,120,'HM',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,120,'HM',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,120,'HM',3,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,120,'HM',4,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,120,'MT',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,120,'PA',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,120,'QZ',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,120,'QZ',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,120,'QZ',3,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,120,'QZ',4,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,135,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,135,'HM',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,135,'HM',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,135,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,135,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,135,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,135,'PA',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,135,'QZ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,135,'QZ',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,135,'QZ',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (178,135,'QZ',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (179,116,'FI',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (179,116,'HM',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (179,116,'HM',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (179,116,'HM',3,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (179,116,'HM',4,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (179,116,'MT',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (179,116,'PA',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (179,116,'QZ',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (179,116,'QZ',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,116,'FI',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,116,'HM',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,116,'HM',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,116,'HM',3,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,116,'HM',4,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,116,'MT',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,116,'PA',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,116,'QZ',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,116,'QZ',2,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,119,'FI',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,119,'HM',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,119,'HM',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,119,'HM',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,119,'HM',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,119,'MT',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,119,'PA',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,119,'QZ',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (180,119,'QZ',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (181,117,'FI',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (181,117,'HM',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (181,117,'HM',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (181,117,'HM',3,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (181,117,'HM',4,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (181,117,'MT',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (181,117,'PA',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (181,117,'QZ',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (181,117,'QZ',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (181,117,'QZ',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (181,117,'QZ',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (182,117,'FI',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (182,117,'HM',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (182,117,'HM',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (182,117,'HM',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (182,117,'HM',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (182,117,'MT',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (182,117,'PA',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (182,117,'QZ',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (182,117,'QZ',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (182,117,'QZ',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (182,117,'QZ',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,116,'FI',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,116,'HM',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,116,'HM',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,116,'HM',3,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,116,'HM',4,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,116,'MT',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,116,'PA',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,116,'QZ',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,116,'QZ',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,138,'FI',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,138,'HM',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,138,'HM',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,138,'HM',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,138,'HM',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,138,'MT',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,138,'PA',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,138,'QZ',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,138,'QZ',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,146,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,146,'HM',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,146,'HM',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,146,'HM',3,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,146,'HM',4,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,146,'MT',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,146,'PA',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,146,'QZ',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (184,146,'QZ',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (185,116,'FI',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (185,116,'HM',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (185,116,'HM',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (185,116,'HM',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (185,116,'HM',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (185,116,'MT',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (185,116,'PA',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (185,116,'QZ',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (185,116,'QZ',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (186,107,'FI',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (186,107,'HM',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (186,107,'HM',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (186,107,'HM',3,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (186,107,'HM',4,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (186,107,'MT',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (186,107,'PA',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (186,107,'QZ',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (186,107,'QZ',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (187,120,'FI',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (187,120,'HM',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (187,120,'HM',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (187,120,'HM',3,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (187,120,'HM',4,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (187,120,'MT',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (187,120,'PA',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (187,120,'QZ',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (187,120,'QZ',2,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (187,120,'QZ',3,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (187,120,'QZ',4,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (188,117,'FI',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (188,117,'HM',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (188,117,'HM',2,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (188,117,'HM',3,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (188,117,'HM',4,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (188,117,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (188,117,'PA',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (188,117,'QZ',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (188,117,'QZ',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (188,117,'QZ',3,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (188,117,'QZ',4,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,116,'FI',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,116,'HM',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,116,'HM',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,116,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,116,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,116,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,116,'PA',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,116,'QZ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,116,'QZ',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,137,'PA',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,137,'PA',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,137,'PA',3,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,137,'PA',4,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,137,'PA',5,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,137,'PA',6,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,137,'PA',7,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,137,'PA',8,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,137,'PA',9,78,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (189,137,'PA',10,78,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (189,137,'PA',11,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (189,137,'PA',12,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                         
INSERT INTO grade VALUES (189,137,'PJ',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (190,117,'FI',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (190,117,'HM',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (190,117,'HM',2,87,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (190,117,'HM',3,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (190,117,'HM',4,80,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (190,117,'MT',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (190,117,'PA',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (190,117,'QZ',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (190,117,'QZ',2,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (190,117,'QZ',3,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (190,117,'QZ',4,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (191,117,'FI',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (191,117,'HM',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (191,117,'HM',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (191,117,'HM',3,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (191,117,'HM',4,81,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (191,117,'MT',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (191,117,'PA',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (191,117,'QZ',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (191,117,'QZ',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (191,117,'QZ',3,86,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (191,117,'QZ',4,96,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (192,117,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (192,117,'HM',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (192,117,'HM',2,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (192,117,'HM',3,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (192,117,'HM',4,82,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (192,117,'MT',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (192,117,'PA',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (192,117,'QZ',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (192,117,'QZ',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (192,117,'QZ',3,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (192,117,'QZ',4,97,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (193,119,'FI',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (193,119,'HM',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (193,119,'HM',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (193,119,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (193,119,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (193,119,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (193,119,'PA',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (193,119,'QZ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (193,119,'QZ',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (194,116,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (194,116,'HM',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (194,116,'HM',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (194,116,'HM',3,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (194,116,'HM',4,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (194,116,'MT',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (194,116,'PA',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (194,116,'QZ',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (194,116,'QZ',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (195,141,'FI',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (195,141,'HM',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (195,141,'HM',2,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (195,141,'HM',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (195,141,'HM',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (195,141,'MT',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (195,141,'PA',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (195,141,'QZ',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (195,141,'QZ',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (196,108,'FI',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (196,108,'HM',1,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (196,108,'HM',2,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (196,108,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (196,108,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (196,108,'MT',1,77,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (196,108,'PA',1,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (196,108,'QZ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (196,108,'QZ',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (197,109,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (197,109,'HM',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (197,109,'HM',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (197,109,'HM',3,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (197,109,'HM',4,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (197,109,'MT',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (197,109,'PA',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (197,109,'QZ',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (197,109,'QZ',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (198,108,'FI',1,85,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (198,108,'HM',1,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (198,108,'HM',2,84,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (198,108,'HM',3,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (198,108,'HM',4,74,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (198,108,'MT',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (198,108,'PA',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (198,108,'QZ',1,92,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (198,108,'QZ',2,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (199,84,'FI',1,99,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (199,84,'MT',1,88,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                           
INSERT INTO grade VALUES (199,142,'FI',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (199,142,'HM',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (199,142,'HM',2,90,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (199,142,'HM',3,83,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (199,142,'HM',4,73,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (199,142,'MT',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (199,142,'PA',1,76,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (199,142,'QZ',1,91,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (199,142,'QZ',2,75,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (199,142,'QZ',3,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (199,142,'QZ',4,98,NULL,'CBRENNAN','11-FEB-00','JAYCAF','11-FEB-00');                                                                                                          
INSERT INTO grade VALUES (200,106,'FI',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,106,'HM',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,106,'HM',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,106,'HM',3,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,106,'HM',4,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,106,'MT',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,106,'PA',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,106,'QZ',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,106,'QZ',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,106,'QZ',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,106,'QZ',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,144,'PA',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,144,'PA',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,144,'PA',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,144,'PA',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,144,'PA',5,73,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,144,'PA',6,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,144,'PA',7,93,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,144,'PA',8,93,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,144,'PA',9,93,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (200,144,'PA',10,93,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (200,144,'PA',11,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (200,144,'PA',12,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (200,144,'PJ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (201,143,'FI',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (201,143,'HM',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (201,143,'HM',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (201,143,'HM',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (201,143,'HM',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (201,143,'HM',5,73,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (201,143,'HM',6,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (201,143,'HM',7,93,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (201,143,'HM',8,93,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (201,143,'HM',9,93,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (201,143,'HM',10,93,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (201,143,'MT',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (202,105,'FI',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (202,105,'HM',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (202,105,'HM',2,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (202,105,'HM',3,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (202,105,'HM',4,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (202,105,'MT',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (202,105,'PA',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (202,105,'QZ',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (202,105,'QZ',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (203,132,'FI',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (203,132,'HM',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (203,132,'HM',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (203,132,'HM',3,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (203,132,'HM',4,73,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (203,132,'HM',5,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (203,132,'HM',6,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (203,132,'HM',7,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (203,132,'HM',8,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (203,132,'HM',9,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (203,132,'HM',10,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (203,132,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (204,88,'PA',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (204,88,'PA',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (204,88,'PA',3,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (204,88,'PA',4,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (204,88,'PA',5,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (204,88,'PA',6,71,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (204,88,'PA',7,71,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (204,88,'PA',8,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (204,88,'PA',9,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (204,88,'PA',10,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (204,88,'PA',11,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (204,88,'PA',12,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (204,88,'PJ',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (205,88,'PA',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (205,88,'PA',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (205,88,'PA',3,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (205,88,'PA',4,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (205,88,'PA',5,72,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (205,88,'PA',6,72,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (205,88,'PA',7,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (205,88,'PA',8,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (205,88,'PA',9,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (205,88,'PA',10,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (205,88,'PA',11,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (205,88,'PA',12,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (205,88,'PJ',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (206,152,'FI',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (206,152,'HM',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (206,152,'HM',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (206,152,'HM',3,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (206,152,'HM',4,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (206,152,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (206,152,'PA',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (206,152,'QZ',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (206,152,'QZ',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (207,152,'FI',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (207,152,'HM',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (207,152,'HM',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (207,152,'HM',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (207,152,'HM',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (207,152,'MT',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (207,152,'PA',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (207,152,'QZ',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (207,152,'QZ',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (208,147,'FI',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (208,147,'HM',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (208,147,'HM',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (208,147,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (208,147,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (208,147,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (208,147,'PA',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (208,147,'QZ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (208,147,'QZ',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (208,147,'QZ',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (208,147,'QZ',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (209,147,'FI',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (209,147,'HM',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (209,147,'HM',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (209,147,'HM',3,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (209,147,'HM',4,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (209,147,'MT',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (209,147,'PA',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (209,147,'QZ',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (209,147,'QZ',2,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (209,147,'QZ',3,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (209,147,'QZ',4,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (210,147,'FI',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (210,147,'HM',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (210,147,'HM',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (210,147,'HM',3,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (210,147,'HM',4,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (210,147,'MT',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (210,147,'PA',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (210,147,'QZ',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (210,147,'QZ',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (210,147,'QZ',3,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (210,147,'QZ',4,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (211,86,'FI',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (211,86,'HM',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (211,86,'HM',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (211,86,'HM',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (211,86,'HM',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (211,86,'MT',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (211,86,'PA',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (211,86,'QZ',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (211,86,'QZ',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (211,86,'QZ',3,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (211,86,'QZ',4,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (211,141,'FI',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (211,141,'HM',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (211,141,'HM',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (211,141,'HM',3,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (211,141,'HM',4,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (211,141,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (211,141,'PA',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (211,141,'QZ',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (211,141,'QZ',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (212,86,'FI',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (212,86,'HM',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (212,86,'HM',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (212,86,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (212,86,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (212,86,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (212,86,'PA',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (212,86,'QZ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (212,86,'QZ',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (212,86,'QZ',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (212,86,'QZ',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (214,123,'FI',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,123,'HM',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,123,'HM',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,123,'HM',3,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,123,'HM',4,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,123,'MT',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,123,'PA',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,123,'QZ',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,123,'QZ',2,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,135,'FI',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,135,'HM',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,135,'HM',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,135,'HM',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,135,'HM',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,135,'MT',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,135,'PA',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,135,'QZ',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,135,'QZ',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,135,'QZ',3,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,135,'QZ',4,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,146,'FI',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,146,'HM',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,146,'HM',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,146,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,146,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,146,'MT',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,146,'PA',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,146,'QZ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,146,'QZ',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,156,'FI',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (214,156,'MT',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,135,'FI',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,135,'HM',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,135,'HM',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,135,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,135,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,135,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,135,'PA',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,135,'QZ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,135,'QZ',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,135,'QZ',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,135,'QZ',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,146,'FI',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,146,'HM',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,146,'HM',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,146,'HM',3,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,146,'HM',4,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,146,'MT',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,146,'PA',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,146,'QZ',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,146,'QZ',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,156,'FI',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (215,156,'MT',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (216,154,'FI',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (216,154,'HM',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (216,154,'HM',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (216,154,'HM',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (216,154,'HM',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (216,154,'HM',5,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (216,154,'HM',6,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (216,154,'HM',7,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (216,154,'HM',8,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (216,154,'HM',9,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (216,154,'HM',10,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (216,154,'MT',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (217,86,'FI',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (217,86,'HM',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (217,86,'HM',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (217,86,'HM',3,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (217,86,'HM',4,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (217,86,'MT',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (217,86,'PA',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (217,86,'QZ',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (217,86,'QZ',2,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (217,86,'QZ',3,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (217,86,'QZ',4,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (218,90,'FI',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (218,90,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (220,119,'FI',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (220,119,'HM',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (220,119,'HM',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (220,119,'HM',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (220,119,'HM',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (220,119,'MT',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (220,119,'PA',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (220,119,'QZ',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (220,119,'QZ',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (221,104,'FI',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (221,104,'HM',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (221,104,'HM',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (221,104,'HM',3,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (221,104,'HM',4,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (221,104,'MT',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (221,104,'PA',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (221,104,'QZ',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (221,104,'QZ',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,104,'FI',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,104,'HM',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,104,'HM',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,104,'HM',3,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,104,'HM',4,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,104,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,104,'PA',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,104,'QZ',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,104,'QZ',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,119,'FI',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,119,'HM',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,119,'HM',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,119,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,119,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,119,'MT',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,119,'PA',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,119,'QZ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (223,119,'QZ',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (224,89,'FI',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (224,89,'MT',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (225,89,'FI',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (225,89,'MT',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (227,89,'FI',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (227,89,'MT',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (227,96,'FI',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (227,96,'HM',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (227,96,'HM',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (227,96,'HM',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (227,96,'HM',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (227,96,'MT',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (227,96,'PA',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (227,96,'QZ',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (227,96,'QZ',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (228,148,'FI',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (228,148,'HM',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (228,148,'HM',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (228,148,'HM',3,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (228,148,'HM',4,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (228,148,'HM',5,95,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (228,148,'HM',6,95,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (228,148,'HM',7,95,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (228,148,'HM',8,95,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (228,148,'HM',9,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (228,148,'HM',10,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (228,148,'MT',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (229,111,'FI',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (229,111,'HM',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (229,111,'HM',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (229,111,'HM',3,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (229,111,'HM',4,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (229,111,'HM',5,95,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (229,111,'HM',6,95,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (229,111,'HM',7,95,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (229,111,'HM',8,95,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (229,111,'HM',9,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (229,111,'HM',10,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (229,111,'MT',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (230,86,'FI',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (230,86,'HM',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (230,86,'HM',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (230,86,'HM',3,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (230,86,'HM',4,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (230,86,'MT',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (230,86,'PA',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (230,86,'QZ',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (230,86,'QZ',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (230,86,'QZ',3,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (230,86,'QZ',4,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (232,91,'FI',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (232,91,'MT',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (232,147,'FI',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,147,'HM',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,147,'HM',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,147,'HM',3,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,147,'HM',4,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,147,'MT',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,147,'PA',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,147,'QZ',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,147,'QZ',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,147,'QZ',3,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,147,'QZ',4,73,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,149,'PA',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,149,'PA',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,149,'PA',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,149,'PA',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,149,'PA',5,73,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,149,'PA',6,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,149,'PA',7,93,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,149,'PA',8,93,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,149,'PA',9,93,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (232,149,'PA',10,93,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (232,149,'PA',11,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (232,149,'PA',12,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (232,149,'PJ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (233,90,'FI',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (233,90,'MT',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (233,112,'FI',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (233,112,'HM',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (233,112,'HM',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (233,112,'HM',3,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (233,112,'HM',4,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (233,112,'MT',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (233,112,'PA',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (233,112,'QZ',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (233,112,'QZ',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (234,137,'PA',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (234,137,'PA',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (234,137,'PA',3,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (234,137,'PA',4,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (234,137,'PA',5,89,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (234,137,'PA',6,89,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (234,137,'PA',7,89,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (234,137,'PA',8,79,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (234,137,'PA',9,79,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (234,137,'PA',10,89,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (234,137,'PA',11,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (234,137,'PA',12,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (234,137,'PJ',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (235,83,'FI',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (235,83,'MT',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (235,150,'FI',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (235,150,'MT',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,138,'FI',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,138,'HM',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,138,'HM',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,138,'HM',3,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,138,'HM',4,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,138,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,138,'PA',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,138,'QZ',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,138,'QZ',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,140,'FI',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,140,'HM',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,140,'HM',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,140,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,140,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,140,'MT',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,140,'PA',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,140,'QZ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (236,140,'QZ',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (237,85,'FI',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (237,85,'HM',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (237,85,'HM',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (237,85,'HM',3,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (237,85,'HM',4,73,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (237,85,'MT',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (237,85,'PA',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (237,85,'QZ',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (237,85,'QZ',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (237,141,'FI',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (237,141,'HM',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (237,141,'HM',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (237,141,'HM',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (237,141,'HM',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (237,141,'MT',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (237,141,'PA',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (237,141,'QZ',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (237,141,'QZ',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,85,'FI',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (238,85,'HM',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (238,85,'HM',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (238,85,'HM',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (238,85,'HM',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (238,85,'MT',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (238,85,'PA',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (238,85,'QZ',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (238,85,'QZ',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (238,103,'FI',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,103,'HM',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,103,'HM',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,103,'HM',3,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,103,'HM',4,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,103,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,103,'PA',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,103,'QZ',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,103,'QZ',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,141,'FI',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,141,'HM',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,141,'HM',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,141,'HM',3,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,141,'HM',4,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,141,'MT',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,141,'PA',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,141,'QZ',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (238,141,'QZ',2,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (240,81,'FI',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (240,81,'HM',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (240,81,'HM',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (240,81,'HM',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (240,81,'HM',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (240,81,'MT',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (240,81,'PA',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (240,81,'QZ',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (240,81,'QZ',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (240,81,'QZ',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (240,81,'QZ',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (241,155,'PA',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (241,155,'PA',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (241,155,'PA',3,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (241,155,'PA',4,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (241,155,'PA',5,95,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (241,155,'PA',6,95,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (241,155,'PA',7,95,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (241,155,'PA',8,95,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (241,155,'PA',9,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (241,155,'PA',10,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (241,155,'PA',11,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (241,155,'PA',12,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (241,155,'PJ',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (242,148,'FI',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (242,148,'HM',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (242,148,'HM',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (242,148,'HM',3,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (242,148,'HM',4,73,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (242,148,'HM',5,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (242,148,'HM',6,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (242,148,'HM',7,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (242,148,'HM',8,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (242,148,'HM',9,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (242,148,'HM',10,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (242,148,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (243,103,'FI',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (243,103,'HM',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (243,103,'HM',2,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (243,103,'HM',3,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (243,103,'HM',4,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (243,103,'MT',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (243,103,'PA',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (243,103,'QZ',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (243,103,'QZ',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (244,82,'PA',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (244,82,'PA',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (244,82,'PA',3,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (244,82,'PA',4,73,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (244,82,'PA',5,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (244,82,'PA',6,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (244,82,'PA',7,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (244,82,'PA',8,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (244,82,'PA',9,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (244,82,'PA',10,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (244,82,'PA',11,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (244,82,'PA',12,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (244,82,'PJ',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (245,82,'PA',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (245,82,'PA',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (245,82,'PA',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (245,82,'PA',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (245,82,'PA',5,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (245,82,'PA',6,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (245,82,'PA',7,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (245,82,'PA',8,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (245,82,'PA',9,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (245,82,'PA',10,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (245,82,'PA',11,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (245,82,'PA',12,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (245,82,'PJ',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (246,85,'FI',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (246,85,'HM',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (246,85,'HM',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (246,85,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (246,85,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (246,85,'MT',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (246,85,'PA',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (246,85,'QZ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (246,85,'QZ',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (247,92,'FI',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (247,92,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (248,148,'FI',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,148,'HM',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,148,'HM',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,148,'HM',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,148,'HM',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,148,'HM',5,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,148,'HM',6,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,148,'HM',7,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,148,'HM',8,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,148,'HM',9,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,148,'HM',10,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (248,148,'MT',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,155,'PA',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,155,'PA',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,155,'PA',3,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,155,'PA',4,73,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,155,'PA',5,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,155,'PA',6,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,155,'PA',7,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,155,'PA',8,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,155,'PA',9,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (248,155,'PA',10,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (248,155,'PA',11,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (248,155,'PA',12,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (248,155,'PJ',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,126,'FI',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,126,'HM',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,126,'HM',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,126,'HM',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,126,'HM',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,126,'MT',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,126,'PA',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,126,'QZ',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,126,'QZ',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,146,'FI',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,146,'HM',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,146,'HM',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,146,'HM',3,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,146,'HM',4,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,146,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,146,'PA',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,146,'QZ',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,146,'QZ',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,154,'FI',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,154,'HM',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,154,'HM',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,154,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,154,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,154,'HM',5,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,154,'HM',6,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,154,'HM',7,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,154,'HM',8,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,154,'HM',9,78,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (250,154,'HM',10,78,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (250,154,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (251,99,'FI',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (251,99,'HM',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (251,99,'HM',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (251,99,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (251,99,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (251,99,'MT',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (251,99,'PA',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (251,99,'QZ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (251,99,'QZ',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (251,101,'FI',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (251,101,'HM',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (251,101,'HM',2,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (251,101,'HM',3,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (251,101,'HM',4,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (251,101,'MT',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (251,101,'PA',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (251,101,'QZ',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (251,101,'QZ',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (252,99,'FI',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (252,99,'HM',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (252,99,'HM',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (252,99,'HM',3,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (252,99,'HM',4,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (252,99,'MT',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (252,99,'PA',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (252,99,'QZ',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (252,99,'QZ',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (252,101,'FI',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (252,101,'HM',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (252,101,'HM',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (252,101,'HM',3,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (252,101,'HM',4,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (252,101,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (252,101,'PA',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (252,101,'QZ',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (252,101,'QZ',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (253,89,'FI',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (253,89,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (254,87,'FI',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (254,87,'HM',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (254,87,'HM',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (254,87,'HM',3,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (254,87,'HM',4,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (254,87,'HM',5,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (254,87,'HM',6,71,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (254,87,'HM',7,71,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (254,87,'HM',8,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (254,87,'HM',9,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (254,87,'HM',10,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (254,87,'MT',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (256,87,'FI',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (256,87,'HM',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (256,87,'HM',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (256,87,'HM',3,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (256,87,'HM',4,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (256,87,'HM',5,72,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (256,87,'HM',6,72,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (256,87,'HM',7,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (256,87,'HM',8,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (256,87,'HM',9,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (256,87,'HM',10,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (256,87,'MT',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (256,89,'FI',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (256,89,'MT',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (257,90,'FI',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (257,90,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (258,106,'FI',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (258,106,'HM',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (258,106,'HM',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (258,106,'HM',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (258,106,'HM',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (258,106,'MT',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (258,106,'PA',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (258,106,'QZ',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (258,106,'QZ',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (258,106,'QZ',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (258,106,'QZ',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,105,'FI',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,105,'HM',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,105,'HM',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,105,'HM',3,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,105,'HM',4,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,105,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,105,'PA',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,105,'QZ',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,105,'QZ',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,135,'FI',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,135,'HM',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,135,'HM',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,135,'HM',3,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,135,'HM',4,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,135,'MT',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,135,'PA',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,135,'QZ',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,135,'QZ',2,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,135,'QZ',3,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (259,135,'QZ',4,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,105,'FI',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,105,'HM',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,105,'HM',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,105,'HM',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,105,'HM',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,105,'MT',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,105,'PA',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,105,'QZ',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,105,'QZ',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,148,'FI',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,148,'HM',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,148,'HM',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,148,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,148,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,148,'HM',5,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,148,'HM',6,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,148,'HM',7,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,148,'HM',8,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,148,'HM',9,78,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (260,148,'HM',10,78,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                       
INSERT INTO grade VALUES (260,148,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (261,105,'FI',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (261,105,'HM',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (261,105,'HM',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (261,105,'HM',3,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (261,105,'HM',4,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (261,105,'MT',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (261,105,'PA',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (261,105,'QZ',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (261,105,'QZ',2,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (262,100,'FI',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (262,100,'HM',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (262,100,'HM',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (262,100,'HM',3,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (262,100,'HM',4,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (262,100,'MT',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (262,100,'PA',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (262,100,'QZ',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (262,100,'QZ',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (262,100,'QZ',3,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (262,100,'QZ',4,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (263,105,'FI',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (263,105,'HM',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (263,105,'HM',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (263,105,'HM',3,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (263,105,'HM',4,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (263,105,'MT',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (263,105,'PA',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (263,105,'QZ',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (263,105,'QZ',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (264,116,'FI',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (264,116,'HM',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (264,116,'HM',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (264,116,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (264,116,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (264,116,'MT',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (264,116,'PA',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (264,116,'QZ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (264,116,'QZ',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (265,92,'FI',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (265,92,'MT',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (266,92,'FI',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (266,92,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (267,95,'FI',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (267,95,'HM',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (267,95,'HM',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (267,95,'HM',3,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (267,95,'HM',4,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (267,95,'MT',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (267,95,'PA',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (267,95,'QZ',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (267,95,'QZ',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (267,125,'FI',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (267,125,'HM',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (267,125,'HM',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (267,125,'HM',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (267,125,'HM',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (267,125,'MT',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (267,125,'PA',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (267,125,'QZ',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (267,125,'QZ',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (268,126,'FI',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (268,126,'HM',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (268,126,'HM',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (268,126,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (268,126,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (268,126,'MT',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (268,126,'PA',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (268,126,'QZ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (268,126,'QZ',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (269,126,'FI',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (269,126,'HM',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (269,126,'HM',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (269,126,'HM',3,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (269,126,'HM',4,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (269,126,'MT',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (269,126,'PA',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (269,126,'QZ',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (269,126,'QZ',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,126,'FI',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,126,'HM',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,126,'HM',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,126,'HM',3,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,126,'HM',4,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,126,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,126,'PA',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,126,'QZ',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,126,'QZ',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,153,'FI',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,153,'HM',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,153,'HM',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,153,'HM',3,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,153,'HM',4,73,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,153,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,153,'PA',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,153,'QZ',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,153,'QZ',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,153,'QZ',3,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (270,153,'QZ',4,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (271,91,'FI',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (271,91,'MT',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (271,145,'FI',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (271,145,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (272,153,'FI',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (272,153,'HM',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (272,153,'HM',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (272,153,'HM',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (272,153,'HM',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (272,153,'MT',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (272,153,'PA',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (272,153,'QZ',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (272,153,'QZ',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (272,153,'QZ',3,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (272,153,'QZ',4,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (273,151,'FI',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (273,151,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (274,151,'FI',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (274,151,'MT',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (275,153,'FI',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (275,153,'HM',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (275,153,'HM',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (275,153,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (275,153,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (275,153,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (275,153,'PA',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (275,153,'QZ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (275,153,'QZ',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (275,153,'QZ',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (275,153,'QZ',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (276,99,'FI',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (276,99,'HM',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (276,99,'HM',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (276,99,'HM',3,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (276,99,'HM',4,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (276,99,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (276,99,'PA',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (276,99,'QZ',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (276,99,'QZ',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (276,101,'FI',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (276,101,'HM',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (276,101,'HM',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (276,101,'HM',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (276,101,'HM',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (276,101,'MT',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (276,101,'PA',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (276,101,'QZ',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (276,101,'QZ',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (277,99,'FI',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (277,99,'HM',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (277,99,'HM',2,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (277,99,'HM',3,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (277,99,'HM',4,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (277,99,'MT',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (277,99,'PA',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (277,99,'QZ',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (277,99,'QZ',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (277,101,'FI',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (277,101,'HM',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (277,101,'HM',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (277,101,'HM',3,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (277,101,'HM',4,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (277,101,'MT',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (277,101,'PA',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (277,101,'QZ',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (277,101,'QZ',2,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (278,99,'FI',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (278,99,'HM',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (278,99,'HM',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (278,99,'HM',3,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (278,99,'HM',4,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (278,99,'MT',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (278,99,'PA',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (278,99,'QZ',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (278,99,'QZ',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (278,101,'FI',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (278,101,'HM',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (278,101,'HM',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (278,101,'HM',3,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (278,101,'HM',4,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (278,101,'MT',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (278,101,'PA',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (278,101,'QZ',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (278,101,'QZ',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (279,99,'FI',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (279,99,'HM',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (279,99,'HM',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (279,99,'HM',3,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (279,99,'HM',4,80,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (279,99,'MT',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (279,99,'PA',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (279,99,'QZ',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (279,99,'QZ',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (279,101,'FI',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (279,101,'HM',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (279,101,'HM',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (279,101,'HM',3,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (279,101,'HM',4,73,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (279,101,'MT',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (279,101,'PA',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (279,101,'QZ',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (279,101,'QZ',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (280,99,'FI',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (280,99,'HM',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (280,99,'HM',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (280,99,'HM',3,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (280,99,'HM',4,81,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (280,99,'MT',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (280,99,'PA',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (280,99,'QZ',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (280,99,'QZ',2,98,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (280,101,'FI',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (280,101,'HM',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (280,101,'HM',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (280,101,'HM',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (280,101,'HM',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (280,101,'MT',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (280,101,'PA',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (280,101,'QZ',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (280,101,'QZ',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (281,99,'FI',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (281,99,'HM',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (281,99,'HM',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (281,99,'HM',3,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (281,99,'HM',4,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (281,99,'MT',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (281,99,'PA',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (281,99,'QZ',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (281,99,'QZ',2,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (281,101,'FI',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (281,101,'HM',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (281,101,'HM',2,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (281,101,'HM',3,75,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (281,101,'HM',4,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (281,101,'MT',1,99,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (281,101,'PA',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (281,101,'QZ',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (281,101,'QZ',2,82,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (282,99,'FI',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (282,99,'HM',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (282,99,'HM',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (282,99,'HM',3,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (282,99,'HM',4,73,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (282,99,'MT',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (282,99,'PA',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (282,99,'QZ',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (282,99,'QZ',2,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (282,101,'FI',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (282,101,'HM',1,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (282,101,'HM',2,76,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (282,101,'HM',3,86,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (282,101,'HM',4,96,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (282,101,'MT',1,90,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (282,101,'PA',1,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (282,101,'QZ',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (282,101,'QZ',2,83,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (283,99,'FI',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (283,99,'HM',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (283,99,'HM',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (283,99,'HM',3,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (283,99,'HM',4,74,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (283,99,'MT',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (283,99,'PA',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (283,99,'QZ',1,92,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (283,99,'QZ',2,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                         
INSERT INTO grade VALUES (283,101,'FI',1,88,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (283,101,'HM',1,77,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (283,101,'HM',2,87,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (283,101,'HM',3,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (283,101,'HM',4,97,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (283,101,'MT',1,91,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (283,101,'PA',1,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (283,101,'QZ',1,85,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        
INSERT INTO grade VALUES (283,101,'QZ',2,84,NULL,'BROSENZW','23-MAR-00','DSCHERER','23-MAR-00');                                                                                                        

COMMIT;

REM  ============ Populates  GRADECONVERSION table ================


INSERT INTO grade_conversion VALUES ('A ',4,96,93,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                       
INSERT INTO grade_conversion VALUES ('A+',4.3,100,97,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                    
INSERT INTO grade_conversion VALUES ('A-',3.7,92,90,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                     
INSERT INTO grade_conversion VALUES ('AU',0,1,1,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                         
INSERT INTO grade_conversion VALUES ('B ',3,86,83,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                       
INSERT INTO grade_conversion VALUES ('B+',3.3,89,87,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                     
INSERT INTO grade_conversion VALUES ('B-',2.7,82,80,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                     
INSERT INTO grade_conversion VALUES ('C ',2,76,73,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                       
INSERT INTO grade_conversion VALUES ('C+',2.3,79,77,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                     
INSERT INTO grade_conversion VALUES ('C-',1.7,72,70,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                     
INSERT INTO grade_conversion VALUES ('D ',1,66,63,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                       
INSERT INTO grade_conversion VALUES ('D+',1.3,69,67,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                     
INSERT INTO grade_conversion VALUES ('D-',.7,62,60,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                      
INSERT INTO grade_conversion VALUES ('F ',0,59,2,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                        
INSERT INTO grade_conversion VALUES ('IN',0,0,0,'BMOTIVAL','01-JAN-93','BMOTIVAL','01-JAN-93');                                                                                                         

COMMIT;

REM  ============ Populates  GRADETYPE table ================

INSERT INTO grade_type VALUES ('FI','Final','MCAFFREY','31-DEC-98','MCAFFREY','31-DEC-98');                                                                                                             
INSERT INTO grade_type VALUES ('HM','Homework','MCAFFREY','31-DEC-98','MCAFFREY','31-DEC-98');                                                                                                          
INSERT INTO grade_type VALUES ('MT','Midterm','MCAFFREY','31-DEC-98','MCAFFREY','31-DEC-98');                                                                                                           
INSERT INTO grade_type VALUES ('PA','Participation','MCAFFREY','31-DEC-98','MCAFFREY','31-DEC-98');                                                                                                     
INSERT INTO grade_type VALUES ('PJ','Project','MCAFFREY','31-DEC-98','MCAFFREY','31-DEC-98');                                                                                                           
INSERT INTO grade_type VALUES ('QZ','Quiz','MCAFFREY','31-DEC-98','MCAFFREY','31-DEC-98');                                                                                                              

COMMIT;

REM  ============ Populates  GRADETYPEWEIGHT table ================

INSERT INTO grade_type_weight VALUES (79,'FI',1,25,'N','CBRENNAN','04-JAN-99','CBRENNAN','05-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (79,'HM',10,50,'Y','CBRENNAN','04-JAN-99','CBRENNAN','05-JAN-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (79,'MT',1,25,'N','CBRENNAN','04-JAN-99','CBRENNAN','05-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (80,'FI',1,30,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (80,'HM',4,20,'Y','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (80,'MT',1,20,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (80,'PA',1,10,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (80,'QZ',4,20,'Y','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (81,'FI',1,30,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (81,'HM',4,20,'Y','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (81,'MT',1,20,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (81,'PA',1,10,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (81,'QZ',4,20,'Y','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (82,'PA',12,25,'Y','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (82,'PJ',1,75,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (83,'FI',1,60,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (83,'HM',1,10,'Y','ALICE','07-AUG-99','ALICE','07-AUG-99');                                                                                                        
INSERT INTO grade_type_weight VALUES (83,'MT',1,40,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (84,'FI',1,60,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (84,'MT',1,40,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (85,'FI',1,50,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (85,'HM',4,10,'Y','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (85,'MT',1,25,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (85,'PA',1,5,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                   
INSERT INTO grade_type_weight VALUES (85,'QZ',2,10,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (86,'FI',1,30,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (86,'HM',4,20,'Y','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (86,'MT',1,20,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (86,'PA',1,10,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (86,'QZ',4,20,'Y','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (87,'FI',1,25,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (87,'HM',10,50,'Y','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (87,'MT',1,25,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (88,'PA',12,25,'Y','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (88,'PJ',1,75,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (89,'FI',1,60,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (89,'MT',1,40,'N','CBRENNAN','02-JAN-99','CBRENNAN','03-JAN-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (90,'FI',1,60,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (90,'MT',1,40,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (91,'FI',1,60,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (91,'MT',1,40,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (92,'FI',1,60,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (92,'MT',1,40,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (93,'FI',1,60,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (93,'MT',1,40,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (94,'FI',1,30,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (94,'HM',4,20,'Y','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (94,'MT',1,20,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (94,'PA',1,10,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (94,'QZ',4,20,'Y','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (95,'FI',1,50,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (95,'HM',4,10,'Y','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (95,'MT',1,25,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (95,'PA',1,5,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                   
INSERT INTO grade_type_weight VALUES (95,'QZ',2,10,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (96,'FI',1,50,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (96,'HM',4,10,'Y','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (96,'MT',1,25,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (96,'PA',1,5,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                   
INSERT INTO grade_type_weight VALUES (96,'QZ',2,10,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (97,'FI',1,50,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (97,'HM',4,10,'Y','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (97,'MT',1,25,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (97,'PA',1,5,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                   
INSERT INTO grade_type_weight VALUES (97,'QZ',2,10,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (98,'FI',1,50,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (98,'HM',4,10,'Y','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (98,'MT',1,25,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (98,'PA',1,5,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                   
INSERT INTO grade_type_weight VALUES (98,'QZ',2,10,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (99,'FI',1,50,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (99,'HM',4,10,'Y','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (99,'MT',1,25,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (99,'PA',1,5,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                   
INSERT INTO grade_type_weight VALUES (99,'QZ',2,10,'N','CBRENNAN','07-JAN-99','CBRENNAN','06-FEB-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (100,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (100,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (100,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (100,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (100,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (101,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (101,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (101,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (101,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (101,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (102,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (102,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (102,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (102,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (102,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (103,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (103,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (103,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (103,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (103,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (104,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (104,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (104,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (104,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (104,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (105,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (105,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (105,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (105,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (105,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (106,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (106,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (106,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (106,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (106,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (107,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (107,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (107,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (107,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (107,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (108,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (108,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (108,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (108,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (108,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (109,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (109,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (109,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (109,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (109,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (110,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (110,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (110,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (110,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (110,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (111,'FI',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (111,'HM',10,50,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (111,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (112,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (112,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (112,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (112,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (112,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (113,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (113,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (113,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (113,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (113,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (114,'FI',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (114,'HM',10,50,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (114,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (115,'PA',12,25,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (115,'PJ',1,75,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (116,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (116,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (116,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (116,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (116,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (117,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (117,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (117,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (117,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (117,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (118,'FI',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (118,'HM',10,50,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (118,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (119,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (119,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (119,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (119,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (119,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (120,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (120,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (120,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (120,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (120,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (121,'FI',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (121,'HM',10,50,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (121,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (122,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (122,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (122,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (122,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (122,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (123,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (123,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (123,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (123,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (123,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (124,'FI',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (124,'HM',10,50,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (124,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (125,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (125,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (125,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (125,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (125,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (126,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (126,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (126,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (126,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (126,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (127,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (127,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (127,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (127,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (127,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (128,'FI',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (128,'HM',10,50,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (128,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (129,'PA',12,25,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (129,'PJ',1,75,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (130,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (130,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (130,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (130,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (130,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (131,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (131,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (131,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (131,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (131,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (132,'FI',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (132,'HM',10,50,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (132,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (133,'PA',12,25,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (133,'PJ',1,75,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (134,'FI',1,60,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (134,'MT',1,40,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (135,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (135,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (135,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (135,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (135,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (136,'FI',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (136,'HM',10,50,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (136,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (137,'PA',12,25,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (137,'PJ',1,75,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (138,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (138,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (138,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (138,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (138,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (139,'FI',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (139,'HM',10,50,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (139,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (140,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (140,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (140,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (140,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (140,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (141,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (141,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (141,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (141,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (141,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (142,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (142,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (142,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (142,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (142,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (143,'FI',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (143,'HM',10,50,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (143,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (144,'PA',12,25,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (144,'PJ',1,75,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (145,'FI',1,60,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (145,'MT',1,40,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (146,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (146,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (146,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (146,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (146,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (147,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (147,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (147,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (147,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (147,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (148,'FI',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (148,'HM',10,50,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (148,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (149,'PA',12,25,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (149,'PJ',1,75,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (150,'FI',1,60,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (150,'MT',1,40,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (151,'FI',1,60,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (151,'MT',1,40,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (152,'FI',1,50,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (152,'HM',4,10,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (152,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (152,'PA',1,5,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                  
INSERT INTO grade_type_weight VALUES (152,'QZ',2,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (153,'FI',1,30,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (153,'HM',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (153,'MT',1,20,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (153,'PA',1,10,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (153,'QZ',4,20,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (154,'FI',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (154,'HM',10,50,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (154,'MT',1,25,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (155,'PA',12,25,'Y','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                
INSERT INTO grade_type_weight VALUES (155,'PJ',1,75,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (156,'FI',1,60,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 
INSERT INTO grade_type_weight VALUES (156,'MT',1,40,'N','CBRENNAN','09-JAN-99','CBRENNAN','02-APR-99');                                                                                                 

COMMIT;

REM =============Populates INSTRUCTOR table ==========


INSERT INTO instructor VALUES (101,'Mr','Fernand','Hanks','100 East 87th','10015','2125551212','ESILVEST','02-JAN-99','ESILVEST','02-JAN-99');                                                          
INSERT INTO instructor VALUES (102,'Mr','Tom','Wojick','518 West 120th','10025','2125551212','ESILVEST','02-JAN-99','ESILVEST','02-JAN-99');                                                            
INSERT INTO instructor VALUES (103,'Ms','Nina','Schorin','210 West 101st','10025','2125551212','ESILVEST','02-JAN-99','ESILVEST','02-JAN-99');                                                          
INSERT INTO instructor VALUES (104,'Mr','Gary','Pertez','34 Sixth Ave','10035','2125551212','ESILVEST','02-JAN-99','ESILVEST','02-JAN-99');                                                             
INSERT INTO instructor VALUES (105,'Ms','Anita','Morris','34 Maiden Lane','10015','2125551212','ESILVEST','02-JAN-99','ESILVEST','02-JAN-99');                                                          
INSERT INTO instructor VALUES (106,'Rev','Todd','Smythe','210 West 101st','10025','2125551212','ESILVEST','02-JAN-99','ESILVEST','02-JAN-99');                                                          
INSERT INTO instructor VALUES (107,'Dr','Marilyn','Frantzen','254 Bleeker','10005','2125551212','ESILVEST','02-JAN-99','ESILVEST','02-JAN-99');                                                         
INSERT INTO instructor VALUES (108,'Mr','Charles','Lowry','518 West 120th','10025','2125551212','ESILVEST','02-JAN-99','ESILVEST','02-JAN-99');                                                         
INSERT INTO instructor VALUES (109,'Hon','Rick','Chow','56 10th Avenue','10015','2125551212','ESILVEST','02-JAN-99','ESILVEST','02-JAN-99');                                                            
INSERT INTO instructor VALUES (110,'Ms','Irene','Willig','415 West 101st',NULL,'2125551212','ARISCHER','11-MAR-99','ARISCHER','11-MAR-99');                                                             

COMMIT;


REM =============Populates SECTION table ==========

INSERT INTO section VALUES (79,350,3,'14-APR-99','L509',107,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                          
INSERT INTO section VALUES (80,10,2,'24-APR-99','L214',102,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (81,20,2,'24-JUL-99','L210',103,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (82,20,4,'03-MAY-99','L214',104,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (83,20,7,'11-JUN-99','L509',105,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (84,20,8,'11-JUN-99','L210',106,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (85,25,1,'14-JUL-99','M311',107,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (86,25,2,'10-JUN-99','L210',108,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (87,25,3,'14-APR-99','L507',101,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (88,25,4,'04-MAY-99','L214',102,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (89,25,5,'15-MAY-99','L509',103,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (90,25,6,'12-JUN-99','L509',104,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (91,25,7,'12-JUN-99','L210',105,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (92,25,8,'13-JUN-99','L509',106,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (93,25,9,'13-JUN-99','L507',107,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                           
INSERT INTO section VALUES (94,146,2,'24-JUL-99','L507',102,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                          
INSERT INTO section VALUES (95,147,1,'14-APR-99','L509',103,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                          
INSERT INTO section VALUES (96,204,1,'14-APR-99','L210',104,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                          
INSERT INTO section VALUES (97,210,1,'07-MAY-99','L507',105,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                          
INSERT INTO section VALUES (98,220,1,'15-APR-99','L509',106,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                          
INSERT INTO section VALUES (99,230,1,'07-MAY-99','L500',107,12,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                          
INSERT INTO section VALUES (100,230,2,'09-JUN-99','L214',108,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (101,240,1,'16-APR-99','L509',101,10,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (102,240,2,'24-MAY-99','L214',102,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (103,310,1,'29-APR-99','L507',103,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (104,330,1,'14-JUL-99','L511',104,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (105,350,1,'09-MAY-99','L509',105,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (106,350,2,'03-JUN-99','L214',106,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (107,130,1,'14-JUL-99','L507',103,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (108,420,1,'07-MAY-99','M311',108,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (109,450,1,'14-APR-99','L507',101,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (110,134,2,'10-JUN-99','L509',102,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (111,134,3,'08-APR-00','L509',103,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (112,135,1,'16-MAY-99','L509',104,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (113,135,2,'02-JUN-99','L214',105,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (114,135,3,'15-APR-99','L509',106,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (115,135,4,'07-MAY-99','M200',107,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (116,140,1,'14-JUL-99','L509',108,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (117,140,2,'02-JUN-99','L210',101,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (118,140,3,'09-MAY-99','L507',102,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (119,142,1,'14-JUL-99','L211',103,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (120,142,2,'10-JUN-99','L214',104,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (121,142,3,'09-APR-99','L507',105,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (122,144,2,'15-APR-99','L214',106,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (123,145,1,'14-JUL-99','L214',107,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (124,145,3,'09-MAY-99','L210',108,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (125,146,1,'29-APR-99','L509',101,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (126,124,1,'14-JUL-99','M500',102,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (127,124,2,'24-JUL-99','H310',103,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (128,124,3,'09-APR-99','L214',104,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (129,124,4,'07-MAY-99','L210',105,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (130,125,1,'22-MAY-99','L509',106,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (131,125,2,'24-JUL-99','L509',107,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (132,125,3,'09-APR-99','L214',108,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (133,125,4,'03-MAY-99','L211',101,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (134,125,6,'11-JUN-99','L507',102,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (135,130,2,'15-APR-99','L214',104,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (136,130,3,'24-APR-99','L509',105,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (137,130,4,'03-MAY-99','L509',106,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (138,132,1,'21-MAY-99','L509',107,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (139,132,3,'09-JUN-99','L509',108,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (140,134,1,'16-APR-99','L509',101,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (141,100,1,'14-APR-99','L214',102,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (142,100,2,'24-JUL-99','L500',103,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (143,100,3,'03-JUN-99','L509',104,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (144,100,4,'04-MAY-99','L507',105,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (145,100,5,'15-MAY-99','L214',106,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (146,120,1,'16-MAY-99','L507',107,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (147,120,2,'24-JUL-99','L206',108,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (148,120,3,'24-MAY-99','L509',101,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (149,120,4,'04-MAY-99','L509',102,15,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (150,120,5,'15-MAY-99','L210',103,25,'CBRENNAN','02-JAN-99','CBRENNAN','02-JAN-99');                                                                                         
INSERT INTO section VALUES (151,120,7,'12-JUN-99','L507',104,25,'CBRENNAN','02-JAN-99','CBRENNAN','10-FEB-99');                                                                                         
INSERT INTO section VALUES (152,122,1,'29-APR-99','M311',105,25,'CBRENNAN','02-JAN-99','CBRENNAN','10-FEB-99');                                                                                         
INSERT INTO section VALUES (153,122,2,'24-JUL-99','L211',106,15,'CBRENNAN','02-JAN-99','CBRENNAN','10-FEB-99');                                                                                         
INSERT INTO section VALUES (154,122,3,'21-MAY-99','L507',107,25,'CBRENNAN','02-JAN-99','CBRENNAN','10-FEB-99');                                                                                         
INSERT INTO section VALUES (155,122,4,'04-MAY-99','L210',108,15,'CBRENNAN','02-JAN-99','ARISCHER','02-MAR-99');                                                                                         
INSERT INTO section VALUES (156,122,5,'15-MAY-99','L507',101,25,'CBRENNAN','02-JAN-99','ARISCHER','02-MAR-99');                                                                                         

COMMIT;


REM =============Populates STUDENT table ==========


INSERT INTO student VALUES (102,'Mr.','Fred','Crocitto','101-09 120th St.','11419','718-555-5555','Albert Hildegard Co.','22-JAN-99','BROSENZWEIG','19-JAN-99','BROSENZW','22-JAN-99');                 
INSERT INTO student VALUES (103,'Ms.','J.','Landry','7435 Boulevard East #45','07047','201-555-5555','Albert Hildegard Co.','22-JAN-99','BROSENZWEIG','19-JAN-99','BROSENZW','22-JAN-99');              
INSERT INTO student VALUES (104,'Ms.','Laetia','Enison','144-61 87th Ave','11435','718-555-5555','Albert Hildegard Co.','22-JAN-99','BROSENZWEIG','19-JAN-99','BROSENZW','22-JAN-99');                  
INSERT INTO student VALUES (105,'Mr.','Angel','Moskowitz','320 John St.','07024','201-555-5555','Alex. & Alexander','22-JAN-99','BROSENZWEIG','19-JAN-99','BROSENZW','22-JAN-99');                      
INSERT INTO student VALUES (106,'Ms.','Judith','Olvsade','29 Elmwood Ave.','07042','201-555-5555','Allied Corp.','22-JAN-99','BROSENZWEIG','19-JAN-99','BROSENZW','22-JAN-99');                         
INSERT INTO student VALUES (107,'Ms.','Catherine','Mierzwa','22-70 41st St.','11105','718-555-5555','Amer.Contract Desgn.','22-JAN-99','BROSENZWEIG','19-JAN-99','BROSENZW','22-JAN-99');               
INSERT INTO student VALUES (108,'Ms.','Judy','Sethi','Stratton Hall','02155','617-555-5555','Amer.Contract Desgn.','22-JAN-99','BROSENZWEIG','19-JAN-99','BROSENZW','22-JAN-99');                       
INSERT INTO student VALUES (109,'Mr.','Larry','Walter','38 Bay 26th ST. #2A','11214','718-555-5555','Amer.Health Found.','22-JAN-99','BROSENZWEIG','19-JAN-99','BROSENZW','22-JAN-99');                 
INSERT INTO student VALUES (110,'Ms.','Maria','Martin','1674 Woodbine St.','11385','718-555-5555','The Stock Exchange','25-JAN-99','BROSENZWEIG','22-JAN-99','BROSENZW','25-JAN-99');                   
INSERT INTO student VALUES (111,'Ms.','Peggy','Noviello','155 Union Ave #211','07070',NULL,'The Stock Exchange','25-JAN-99','BROSENZWEIG','22-JAN-99','BROSENZW','25-JAN-99');                          
INSERT INTO student VALUES (112,'Mr.','Thomas','Thomas','501 W Elm St.','07036','201-555-5555','The Stock Exchange','25-JAN-99','BROSENZWEIG','22-JAN-99','BROSENZW','25-JAN-99');                      
INSERT INTO student VALUES (113,'Mr.','Anil','Kulina','43-44 Kissena Blvd. #155','11355','718-555-5555','ARFBO','25-JAN-99','BROSENZWEIG','22-JAN-99','BROSENZW','25-JAN-99');                          
INSERT INTO student VALUES (114,'Ms.','Winsome','Laporte','268 E. 3rd St','11226','718-555-5555','ARFBO','25-JAN-99','BROSENZWEIG','22-JAN-99','BROSENZW','25-JAN-99');                                 
INSERT INTO student VALUES (117,'Mr.','N','Kuehn','44-25 59th St.','11377','718-555-5555','Beauty Products','25-JAN-99','BROSENZWEIG','22-JAN-99','BROSENZW','25-JAN-99');                              
INSERT INTO student VALUES (118,'Ms.','Hiedi','Lopez','168 Rowayton Ave','06853','203-555-5555','Banque de Paris','25-JAN-99','BROSENZWEIG','22-JAN-99','BROSENZW','25-JAN-99');                        
INSERT INTO student VALUES (119,'Mr.','Mardig','Abdou','160-04 32nd Ave.','11358','718-555-5555','Raymond Capital','25-JAN-99','BROSENZWEIG','22-JAN-99','BROSENZW','25-JAN-99');                       
INSERT INTO student VALUES (120,'Mr.','Ralph','Alexander','2054 73rd St','11214','718-555-5555','Raymond Capital','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                        
INSERT INTO student VALUES (121,'Ms.','Sean','Pineda','3 Salem Rd.','10956','212-555-5555','Burke & Co.','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                                 
INSERT INTO student VALUES (122,'Ms.','Julita','Lippen','51-76 Van Kleeck St.','11373','718-555-5555','Burke & Co.','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                      
INSERT INTO student VALUES (123,'Mr.','Pierre','Radicola','322 Atkins Ave.','11208','718-555-5555','Burke & Co.','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                         
INSERT INTO student VALUES (124,'Mr.','Daniel','Wicelinski','27 Brookdale Gdns.','07003','201-555-5555','Burke & Co.','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                    
INSERT INTO student VALUES (127,'Mr.','Gary','Aung','135-32 Louis Blvd','11413','718-555-5555','New York Pop','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                            
INSERT INTO student VALUES (128,'Mr.','Jeff','Runyan','109-15 Queens Blvd.','11375','718-555-5555','New York Pop','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                        
INSERT INTO student VALUES (129,'Mr.','Omaira','Grant','1065 Vermont St. 7F.','11207','718-555-5555','New York Pop','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                      
INSERT INTO student VALUES (130,'Ms.','Lula','Oates','11A Emory St.','07304','201-555-5555','New York Pop','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                               
INSERT INTO student VALUES (133,'Mr.','James','Reed','109-62 196th St','11412','718-555-5555','New York Pop','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                             
INSERT INTO student VALUES (134,'Ms.','Angela','Torres','509 2nd St #4L','11215','718-555-5555','New York Pop','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                           
INSERT INTO student VALUES (135,'Ms.','Michelle','Masser','379 Ovington Ave','11209','718-555-5555','New York Pop','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                       
INSERT INTO student VALUES (136,'Ms.','Hazel','Lasseter','9720 57th Ave #10G','11368','718-555-5555','DUCCA','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                             
INSERT INTO student VALUES (137,'Mr.','James','Miller','9830 57th Ave #3E','11368','718-555-5555','DUCCA','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                                
INSERT INTO student VALUES (138,'Mr.','John','Smith','45 Plaza St. West #2D','11217','718-555-5555','Hanon USA, Inc.','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                    
INSERT INTO student VALUES (139,'Mr.','Angelo','Garshman','82 Western Ave.','07307','201-555-5555','Chase.Young NY Inc','27-JAN-99','BROSENZWEIG','24-JAN-99','BROSENZW','27-JAN-99');                  
INSERT INTO student VALUES (140,'Mr.','Derrick','Baltazar','9111 Church Ave. #3N','11236','718-555-5555','Chase Young NY Inc','30-JAN-99','BROSENZWEIG','27-JAN-99','BROSENZW','30-JAN-99');            
INSERT INTO student VALUES (141,'Mr.','Robert','Boyd','96-04 57th Ave #12A','11368','718-555-5555','Chicago Pneumat.Tool','30-JAN-99','BROSENZWEIG','27-JAN-99','BROSENZW','30-JAN-99');                
INSERT INTO student VALUES (142,'Ms.','Monica','Waldman','257 Depot Rd.','11766','718-555-5555','Hallowhill Center','30-JAN-99','BROSENZWEIG','27-JAN-99','BROSENZW','30-JAN-99');                      
INSERT INTO student VALUES (143,'Mr.','Gerard','Biers','205 19th St.','11232','718-555-5555','Civil Court','30-JAN-99','BROSENZWEIG','27-JAN-99','BROSENZW','30-JAN-99');                               
INSERT INTO student VALUES (144,'Mr.','David','Essner','96 E. Ave.','06851','203-555-5555','Medical Presbyterian Hospital','30-JAN-99','BROSENZWEIG','27-JAN-99','BROSENZW','30-JAN-99');               
INSERT INTO student VALUES (145,'Mr.','Paul','Lefkowitz','2 World Trade Cnt. 18','10048','212-555-5555','Gleeson Law School','30-JAN-99','BROSENZWEIG','27-JAN-99','BROSENZW','30-JAN-99');             
INSERT INTO student VALUES (146,'Mr.','Joseph','German','19 75th St.','07047','201-555-5555','Anna Soehner','30-JAN-99','BROSENZWEIG','27-JAN-99','BROSENZW','30-JAN-99');                              
INSERT INTO student VALUES (147,'Ms.','Judy','Cahouet','6406 10th Ave','11219','718-555-5555','Competrol Real Estate','30-JAN-99','BROSENZWEIG','27-JAN-99','BROSENZW','30-JAN-99');                    
INSERT INTO student VALUES (148,'Mr.','D.','Orent','117 Knapp Ave.','07011','201-555-5555','Competrol Real Estate','30-JAN-99','BROSENZWEIG','27-JAN-99','BROSENZW','30-JAN-99');                       
INSERT INTO student VALUES (149,'Ms.','Judith','Prochaska','49 Martindale Rd','07078','201-555-5555','Competrol Real Estate','30-JAN-99','BROSENZWEIG','27-JAN-99','BROSENZW','30-JAN-99');             
INSERT INTO student VALUES (150,'Ms.','Regina','Gates','29 Cygnet Dr.','11787','718-555-5555','Coney I.Med. Group','30-JAN-99','BROSENZWEIG','30-JAN-99','BROSENZW','30-JAN-99');                       
INSERT INTO student VALUES (151,'Ms.','Arlyne','Sheppard','33-54 28th St #2C','11106','718-555-5555','Contnl Resources','30-JAN-99','BROSENZWEIG','30-JAN-99','BROSENZW','30-JAN-99');                  
INSERT INTO student VALUES (152,'Mr.','Thomas','Edwards','501 W. Elm','07036','201-555-5555','Contnl Resources','30-JAN-99','BROSENZWEIG','30-JAN-99','BROSENZW','30-JAN-99');                          
INSERT INTO student VALUES (153,'Ms.','Mrudula','Philpotts','86-16 60 Ave. #6L','11373','718-555-5555','Crow Construction','30-JAN-99','BROSENZWEIG','30-JAN-99','BROSENZW','30-JAN-99');               
INSERT INTO student VALUES (154,'Ms.','Dawn','Dennis','26 Indian Field Rd.','06830','203-555-5555','Cusack & Stiles','30-JAN-99','BROSENZWEIG','30-JAN-99','BROSENZW','30-JAN-99');                     
INSERT INTO student VALUES (156,'Mr.','Scott','Grant','8402 14th Ave.','11224','718-555-5555','Naiwa Securities','30-JAN-99','BROSENZWEIG','30-JAN-99','BROSENZW','30-JAN-99');                         
INSERT INTO student VALUES (157,'Ms.','Shirley','Jameson','101 Daniel St.','07008','201-555-5555','Christa Publishing','30-JAN-99','BROSENZWEIG','30-JAN-99','BROSENZW','30-JAN-99');                   
INSERT INTO student VALUES (158,'Mr.','Roy','Limate','5 Horizon Rd.','07024','201-555-5555','Documt.Mgmt.Group','30-JAN-99','BROSENZWEIG','30-JAN-99','BROSENZW','30-JAN-99');                          
INSERT INTO student VALUES (159,'Mr.','Thomas','Edwards','45 Maplewood Ave.','07040','201-555-5555','Kodiak Island','30-JAN-99','BROSENZWEIG','30-JAN-99','BROSENZW','30-JAN-99');                      
INSERT INTO student VALUES (160,'Mr.','John T.','Beitler','100 Plaza Dr, ITT CSI Emp. Dpt','07096','201-555-5555','Asylum Publishing','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');    
INSERT INTO student VALUES (161,'Ms.','Eilene','Grant','245 Henry St. #2I','11201','718-555-5555','Worldwide Delivery','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                   
INSERT INTO student VALUES (162,'Ms.','Genny','Andrew','5 Sylvan Ln.','06870','203-555-5555','Miro Life Insurance','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                       
INSERT INTO student VALUES (163,'Ms.','Nicole','Gillen','4301 N Ocean #103','10025','904-555-5555','Oil of America Corp.','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                
INSERT INTO student VALUES (164,'Ms.','Sylvia','Perrin','716a Union St.','11215','718-555-5555','Baxxon Corp.','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                           
INSERT INTO student VALUES (165,'Mr.','Peter','Daly','1219 Ave Y','11235','718-555-5555','Foster Wheeler','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                                
INSERT INTO student VALUES (166,'Ms.','May','Jodoin','162-01 78 th Ave','11366','718-555-5555','Gaum, Inc.','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                              
INSERT INTO student VALUES (167,'Mr.','Jim','Joas','53-33 192nd St.','11365','718-555-5555','Gaum, Inc.','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                                 
INSERT INTO student VALUES (168,'Ms.','Sally','Naso','812 79th St.','07047','201-555-5555','Motors National','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                             
INSERT INTO student VALUES (169,'Mr.','Frantz','McLean','23-08 Newtown Ave.','11102','718-555-5555','Guenther Soehner','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                   
INSERT INTO student VALUES (170,'Ms.','P.','Balterzar','30 Carriage Rd.','11576','718-555-5555','Parton Corp.','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                           
INSERT INTO student VALUES (171,'Ms.','Denise','Brownstein','104-36 196th St.','11412','718-555-5555','Nearst Corp.','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                     
INSERT INTO student VALUES (172,'Ms.','Maria','Arias','Box 216','11426','718-555-5555','Lising Corp.','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                                    
INSERT INTO student VALUES (173,'Mr.','Oscar','McGill','578 E 40th ST.','11218','718-555-5555','Nearst Corp.','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                            
INSERT INTO student VALUES (174,'Mr.','Michael','Brown','265 Hawthorne St #2D','11225','718-555-5555','Nearst Corp.','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                     
INSERT INTO student VALUES (175,'Ms.','Debra','Boyce','294 East 98 St.','11212','718-555-5555','Hoare Govett, Inc.','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                      
INSERT INTO student VALUES (176,'Ms.','Beth','Satterfield','140 Amity St','11201','718-555-5555','Hosp. Jt. Diseases','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                    
INSERT INTO student VALUES (178,'Mr.','Ricardo','Kurtz','31-21 30th St.','11106','718-555-5555','Electronic Engineers','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                   
INSERT INTO student VALUES (179,'Mr.','Simon','Ramesh','92-14 51st Ave','11373','718-555-5555','Electronic Engineers','02-FEB-99','BROSENZWEIG','02-FEB-99','BROSENZW','02-FEB-99');                    
INSERT INTO student VALUES (180,'Mr.','E.A.','Torres','1495 Union','11213','718-555-5555','Electronic Engineers','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                         
INSERT INTO student VALUES (181,'Mr.','Anthony','Bullock','53 Pauklie St.','11206','718-555-5555','Electronic Engineers','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                 
INSERT INTO student VALUES (182,'Mr.','Jeffrey','Delbrun','PO Box 1091','07024','201-555-5555','Electronic Engineers','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                    
INSERT INTO student VALUES (184,'Ms.','Salewa','Zuckerberg','1614 64th St.','11204','718-555-5555','Electronic Engineers','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                
INSERT INTO student VALUES (185,'Mr.','Dennis','Mehta','371 Monmouth St.','07302','201-555-5555','Electronic Engineers','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                  
INSERT INTO student VALUES (186,'Ms.','Christine','Sheppard','16 Seymour St.','07042','201-555-5555','Electronic Engineers','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');              
INSERT INTO student VALUES (187,'Mr.','O.','Garnes','125 Great Hills Rd','07078','201-555-5555','Electronic Engineers','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                   
INSERT INTO student VALUES (188,'Mr.','Phil','Gilloon','4244 Morestown Ct. E','43224','614-555-5555','The Electronic Publishing Company','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99'); 
INSERT INTO student VALUES (189,'Ms.','Deborah','Reyes','91 S 10th St','07107','201-555-5555','Electronic Engineers','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                     
INSERT INTO student VALUES (190,'Mr.','Alan','Affinito','735 W. Crescent Ave.','07401','201-555-5555','Electronic Engineers','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');             
INSERT INTO student VALUES (191,'Mr.','Steven','M. Orent','223 Crabapple Rd.','11303','718-555-5555','Electronic Engineers','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');              
INSERT INTO student VALUES (192,'Mr.','Frank','Viotty','299 Ocean Ae.','11230','718-555-5555','Electronic Engineers','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                     
INSERT INTO student VALUES (193,'Mr.','Al','Jamerncy','16 Eldor Ave.','10956','212-555-5555','Electronic Engineers','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                      
INSERT INTO student VALUES (194,'Ms.','Verona','Grant','17 Gould St.','07044','201-555-5555','Electronic Engineers','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                      
INSERT INTO student VALUES (195,'Ms.','Regina','Bose','29 Cygnet Dr.','11787','718-555-5555','Millhover Publishing','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                      
INSERT INTO student VALUES (196,'Mr.','Victor','Meshaj','22 Coach Lame Lane','06830','203-555-5555','Interchurch','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                        
INSERT INTO student VALUES (197,'Mr.','J.','Dalvi','Skaarup Oil Co. 66 Field Pt. R','06830','203-555-5555','Interchurch','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                 
INSERT INTO student VALUES (198,'Mr.','Edwin','Allende','276 Fillo St.','06850','203-555-5555','Interchurch','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                             
INSERT INTO student VALUES (199,'Mr.','J.','Segall','53-35 192 St.','11365','718-555-5555','Johnson & Higgins','03-FEB-99','BROSENZWEIG','03-FEB-99','BROSENZW','03-FEB-99');                           
INSERT INTO student VALUES (200,'Mr.','Gene','Bresser, HR Rep.','81 Shady Ln','07023','201-555-5555','Judicial Center','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','05-FEB-99');                   
INSERT INTO student VALUES (201,'Mr.','Michael','Lefbowitz','1438 E 100th St','11236','718-555-5555','Judicial Center','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');                   
INSERT INTO student VALUES (202,'Ms.','Mary','Axch','144-70 41st Ave. #4T','11355','718-555-5555','Kenyon & Kenyon','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');                      
INSERT INTO student VALUES (203,'Mr.','Angel','Cook','320 John St','07029','201-555-5555','Lambert, Brussels','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');                            
INSERT INTO student VALUES (204,'Mr.','Arun','Griffen','Box 86','11368','718-555-5555','Lambos, Flynn','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');                                   
INSERT INTO student VALUES (205,'Mr.','Alfred','Hutheesing','43-11 National St','11368','718-555-5555','Lambos, Flynn','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');                   
INSERT INTO student VALUES (206,'Mr.','Freedon','annunziato','45 Adelphi St. #2W','11205','718-555-5555','Lamont Doherty','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');                
INSERT INTO student VALUES (207,'Ms.','Bernadette','Montanez','7 St. Lukes Place #202','07042','201-555-5555','Lamont Doherty','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');           
INSERT INTO student VALUES (208,'Mr.','A.','Tucker','117 Olcott Way','06877','203-555-5555','Lowenthal & Horwalk','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');                        
INSERT INTO student VALUES (209,'Mr.','Lloyd','Kellam','156-02 Liberty Ave.','11433','718-555-5555','Lowenthal & Horwalk','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');                
INSERT INTO student VALUES (210,'Mr.','David','Thares','20 Charles Rd.','06798','203-555-5555','MGIC Indemnity','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');                          
INSERT INTO student VALUES (211,'Ms.','Jenny','Goldsmith','250 N. Van Dien Ave.','07450','201-555-5555','Man.School Music','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');               
INSERT INTO student VALUES (212,'Ms.','Barbara','Robichaud','132 S Mountain View Dr.','10965','212-555-5555','Man.School Music','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');          
INSERT INTO student VALUES (214,'Ms.','Yvonne','Williams','80-20 4th Ave.  #A3','11209','718-555-5555','Iarriott Hotels','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');                 
INSERT INTO student VALUES (215,'Mr.','Reynaldo','Chatman','9925 42nd Ave. #3B','11368','718-555-5555','Iarriott Hotels','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');                 
INSERT INTO student VALUES (216,'Mr.','Madhav','Dusenberry','6331 Durham Ave','07047','201-555-5555','Micro Rental','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');                      
INSERT INTO student VALUES (217,'Mr.','Jeffrey','Citron','PO Box 1091','07024','201-555-5555','Mitsukoshi USA Inc.','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');                      
INSERT INTO student VALUES (218,'Mr.','Eric','Da Silva','90-36 53rd Avenue, #3D','11373','718-555-5555','Mitsukoshi USA Inc.','05-FEB-99','BROSENZWEIG','05-FEB-99','BROSENZW','08-FEB-99');            
INSERT INTO student VALUES (220,'Mr.','Robert','Segall','36 Brookdale Dr.','06903','203-555-5555','Board Utilities','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');                      
INSERT INTO student VALUES (221,'Ms.','Sheradha','Malone','91-41 23rd Ave. 1st Floor','11369','718-555-5555','Board Utilities','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');           
INSERT INTO student VALUES (223,'Mr.','Frank','Pace','13 Burlington Dr.','10025','203-555-5555','Board Utilities','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');                        
INSERT INTO student VALUES (224,'Mr.','M.','Diokno','44-20 64th St #6L','11377','718-555-5555','Natnl Bank Hungary','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');                      
INSERT INTO student VALUES (225,'Mr.','Edgar','Moffat','172 Lincoln St','07042','201-555-5555','OPEIU','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');                                   
INSERT INTO student VALUES (227,'Ms.','Bessie','Heedles','932 Carnegie Ave.','07060','201-555-5555','Ogilvy & Bernard','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');                   
INSERT INTO student VALUES (228,'Mr.','Mohamed','Valentine','35-33 83rd St. #D 12','11372','718-555-5555','Omni Devel.& Markt.','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');          
INSERT INTO student VALUES (229,'Ms.','Adrienne','Lopez','755 Anderson Ave. #3-25','07010','201-555-5555','P&S 3-401','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');                    
INSERT INTO student VALUES (230,'Mr.','George','Kocka','24 Beaufield St.','02124','617-555-5555','PC Values','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');                             
INSERT INTO student VALUES (232,'Ms.','Janet','Jung','118-18 Union Tpke #3K','11415','718-555-5555','Plannning, Health S.','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');               
INSERT INTO student VALUES (233,'Ms.','Kathleen','Mulroy','770 Anderson Ave.','07010','201-555-5555','Hohenreuther','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');                      
INSERT INTO student VALUES (234,'Mr.','Joel','Brendler','111 Village Hill Dr.','11746','718-555-5555','Morninghill Presbyterian Hosp.','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');   
INSERT INTO student VALUES (235,'Mr.','Michael','Carcia','250 Senator St','11220','718-555-5555','KO Pictures, Inc.','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');                     
INSERT INTO student VALUES (236,'Mr.','Gerry','Tripp','35-15 84th St.','11372','718-555-5555','Schl.of Nursing','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');                          
INSERT INTO student VALUES (237,'Mr.','Rommel','Frost','P.O. Box 6294','07306','201-555-5555','Seligman Harris','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');                          
INSERT INTO student VALUES (238,'Mr.','Roger','Snow','1620 Cambridge Rd.','48104','517-555-5555','Seligman Harris','08-FEB-99','BROSENZWEIG','08-FEB-99','BROSENZW','11-FEB-99');                       
INSERT INTO student VALUES (240,'Ms.','Z.A.','Scrittorale','27 Arrowhead Wy.','06820','203-555-5555','Sibney Advertising','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                
INSERT INTO student VALUES (241,'Mr.','Joseph','Yourish','185 St. Marks Ave.','11238','718-555-5555','Simpson, Thatcher','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                 
INSERT INTO student VALUES (242,'Mr.','Daniel','Ordes','117 Knapp Ave.','07011','201-555-5555','St.Colg.Optometry','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                       
INSERT INTO student VALUES (243,'Mr.','Bharat','Roberts','175 Oakland Ave.','07306','201-555-5555','Steinhauer,Sheiman','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                  
INSERT INTO student VALUES (244,'Ms.','Sarah','Wilson','457 77th St.','11209','718-555-5555','Thacher, Proffitt','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                         
INSERT INTO student VALUES (245,'Mr.','Irv','Dalvi','1504 Harmon Cove Towers','07094','201-555-5555','Thacher, Proffitt','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                 
INSERT INTO student VALUES (246,'Ms.','Meryl','Owens','94 Sycamore Rd.','07012','201-555-5555','The COG Group,Inc.','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                      
INSERT INTO student VALUES (247,'Mr.','Frank','Bunnell','43 Lindstrom Rd.','06902','203-555-5555','The Plaza Penn Hotel','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                 
INSERT INTO student VALUES (248,'Ms.','Tamara','Zapulla','818 E. Ridgewood Ave.','07450','201-555-5555','Thyssen Stuttgart','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');              
INSERT INTO student VALUES (250,'Mr.','Evan','Fielding','194-07 58th Ave.','11365','718-555-5555','Toronto Neuenstadt','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                   
INSERT INTO student VALUES (251,'Ms.','Catherine','Frangopoulos','2270 41st Street','11105','718-555-5555','U.N.D.P.','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                    
INSERT INTO student VALUES (252,'Ms.','Nana','Barogh','4131 Hampton St.','11373','718-555-5555','U.N.D.P.','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                               
INSERT INTO student VALUES (253,'Mr.','Walter','Boremmann','88 Old Fields Rd','02563','617-555-5555','Union Bk.Bavaria','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                  
INSERT INTO student VALUES (254,'Ms.','Melvina','Chamnonkool','117-36 168th St.','11434','718-555-5555','Union Bk.Bavaria','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');               
INSERT INTO student VALUES (256,'Ms.','Lorrane','Velasco','200 Winston Dr. #2212','07010','201-555-5555','Union Bk.Bavaria','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');              
INSERT INTO student VALUES (257,'Ms.','Suzanne M.','Abid','279 Hempstead Ave.','11565','718-555-5555','Whitney Comm.','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                    
INSERT INTO student VALUES (258,'Ms.','Suzanna','Velasco','1033 Springfield Ave, UCC','07016','201-555-5555','Kirsten Stein','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');             
INSERT INTO student VALUES (259,'Mr.','George','Merriman','49 Adair Ct','11565','718-555-5555','Powerhouse Publishing','11-FEB-99','BROSENZWEIG','11-FEB-99','BROSENZW','14-FEB-99');                   
INSERT INTO student VALUES (260,'Ms.','Jean','Griffith','1219 Mooney Pl.','07065','201-555-5555','Willig Pub.','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                           
INSERT INTO student VALUES (261,'Mr.','Vinnie','Moon','32-67 35th St.','11106','718-555-5555','Kirsten Stein','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                            
INSERT INTO student VALUES (262,'Ms.','Donna','Walston','236 Washington Ave.','07024','201-555-5555','Willig Pub.','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                       
INSERT INTO student VALUES (263,'Mr.','Radharam','King','2416 38 Ave. #5G','11101','718-555-5555','Kirsten Stein','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                        
INSERT INTO student VALUES (264,'Ms.','Lorraine','Harty','17 Beach St.','07307','201-555-5555','A.D. Tihany, Intnl','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                      
INSERT INTO student VALUES (265,'Ms.','Adele','Rothstein','Box 6028','11106','718-555-5555','A.H.R.B.','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                                   
INSERT INTO student VALUES (266,'Ms.','Kate','Page','130 8th Ave 38F','11215','718-555-5555','A.H.R.B.','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                                  
INSERT INTO student VALUES (267,'Mr.','Julius','Kwong','3001 Edwin Ave. 2B','07024','201-555-5555','Adler & Shaykin','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                     
INSERT INTO student VALUES (268,'Mr.','Ronald','Tangaribuan','140 Hepburn Rd #9J','07012','201-555-5555','Alex. & Alexander','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');             
INSERT INTO student VALUES (269,'Ms.','Sharon','Thompson','390 Parkside Ave. #A4','11220','718-555-5555','Alex. & Alexander','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');             
INSERT INTO student VALUES (270,'Mr.','Charles','Caro','6 Buena Vista St.','06907','203-555-5555','Alex. & Alexander','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                    
INSERT INTO student VALUES (271,'Mr.','Jose','Benitez','69-68 St.','07093','201-555-5555','Amer. Intl Group','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                             
INSERT INTO student VALUES (272,'Ms.','Kevin','Porch','102 Maple St.','07070','201-555-5555','Diabetes Prevention Assoc.','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                
INSERT INTO student VALUES (273,'Ms.','Hedy','Naso','1072 Abbott Blvd.','07024','201-555-5555','Diabetes Prevention Assoc.','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');              
INSERT INTO student VALUES (274,'Mr.','John','De Simone','107-28 115th St','11419','718-555-5555','Diabetes Prevention Assoc.','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');           
INSERT INTO student VALUES (275,'Mr.','George','Ross','49 Adair Ct.','11565','718-555-5555','Associate Diabetics Foundation','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');             
INSERT INTO student VALUES (276,'Ms.','Florence','Valamas','88-20 86 Street','11432','718-555-5555','Amer.Legal Systems','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                 
INSERT INTO student VALUES (277,'Ms.','Evelyn','Liggons','67-19 49th Ave','11377','718-555-5555','Amer.Legal Systems','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                    
INSERT INTO student VALUES (278,'Mr.','Thomas E.','La Blank','49 Raleigh Rd','02189','617-555-5555','Amer.Legal Systems','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                 
INSERT INTO student VALUES (279,'Ms.','George','Korka','3 Aster Pl.','11746','718-555-5555','Amer.Legal Systems','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                         
INSERT INTO student VALUES (280,'Mr.','Bill','Engongoro','37-55 77th St #5G','11372','718-555-5555','Amer.Legal Systems','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                 
INSERT INTO student VALUES (281,'Ms.','Virginia','Ocampo','68 First Ave.','07094','201-555-5555','Amer.Legal Systems','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                    
INSERT INTO student VALUES (282,'Mr.','Jonathan','Jaele','1543 Nostrant Ave. #3C','11226','718-555-5555','Amer.Legal Systems','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');            
INSERT INTO student VALUES (283,'Ms.','Benita','Perkins','11 Mirrielees Circle','11021','718-555-5555','Amer.Legal Systems','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');              
INSERT INTO student VALUES (284,'Ms.','Salewa','Lindeman','1614 64th St.','11204','718-555-5555','Amer.Legal Systems','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                    
INSERT INTO student VALUES (285,'Mr.','Paul','Sikinger','38 Beaumont Pl','07104','201-555-5555','Amer.Legal Systems','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                     
INSERT INTO student VALUES (286,'Ms.','Robin','Kelly','200 Winston Dr. #2212','07010','201-555-5555','German Express Corp.','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');              
INSERT INTO student VALUES (288,'Ms.','Rosemary','Ellman','143.5 Bowers St.','07307','201-555-5555','Anaesthesiology Associates','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');         
INSERT INTO student VALUES (289,'Ms.','Shirley','Murray','PO Box 143','11224','718-555-5555','Arbank, T.A.S.','13-FEB-99','BROSENZWEIG','13-FEB-99','BROSENZW','16-FEB-99');                            
INSERT INTO student VALUES (290,'Mr.','Brian','Robles','45-08 11th St.','11101','718-555-5555','Asch & Basch, P.A.','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                      
INSERT INTO student VALUES (291,'Mr.','D.','Dewitt','4 Rockledge Rd','07042','201-555-5555','Assoc.Help Retarded','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                        
INSERT INTO student VALUES (292,'Mr.','Austin V.','Cadet','360 Sunset Rd.','07444','201-555-5555','Assoc.Help Retarded','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                  
INSERT INTO student VALUES (293,'Mr.','Frank','M. Orent','37-21 80th St. #6J','11372','718-555-5555','Assoc.Help Retarded','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');               
INSERT INTO student VALUES (294,'Ms.','Yvonne','Winnicki','8020 4th Ave.','11209','718-555-5555','Assoc.Help Retarded','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                   
INSERT INTO student VALUES (296,'Mr.','Mike','Madej','214 Cottage St.','06605','203-555-5555','TRS/Sanders','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                              
INSERT INTO student VALUES (298,'Ms.','Paula','Valentine','17 Orchard Farm','11050','718-555-5555','TRS/Sanders','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                         
INSERT INTO student VALUES (299,'Mr.','Brian','Saluja','604 McDough St.','11233','718-555-5555','Frontwater Music','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                       
INSERT INTO student VALUES (300,'Mr.','Frances','Lawson','70 Nevada Ave.','11042','718-555-5555','Frontwater Music','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                      
INSERT INTO student VALUES (301,'Mr.','Barry','Dunkon','1 Marine Pl','07047','201-555-5555','Banco Bueno','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                                
INSERT INTO student VALUES (302,'Ms.','Rita','Archor','30 Lakeview Dr.','06905','203-555-5555','Barnard Love','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                            
INSERT INTO student VALUES (303,'Mr.','George','Milano','#1 Baycoub Dr.','11360','718-555-5555','Barnard Love','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                           
INSERT INTO student VALUES (304,'Mr.','Kardik','Guarino','4141 48th St #3K','11104','718-555-5555','Faerber','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                             
INSERT INTO student VALUES (305,'Mr.','Preston','Larcia','131-57 230th','11413','718-555-5555','Schwaebische Landesbank','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                 
INSERT INTO student VALUES (306,'Mr.','Norman','Callender','6635 108th St.','11375','718-555-5555','Beketon Dickenson','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                   
INSERT INTO student VALUES (307,'Ms.','Salondra','Galik','114-19 131st St.','11420','718-555-5555','Schloomingdales','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                     
INSERT INTO student VALUES (309,'Ms.','Carlos','Airall','250 Sylvan Dr','11552','718-555-5555','Breed, Abbott, Tristan','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                  
INSERT INTO student VALUES (310,'Mr.','Joseph','Jimenes','221-07 Braddock Ave.','11428','718-555-5555','Breed, Abbott, Tristan','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');          
INSERT INTO student VALUES (311,'Mr.','Henry','Masser','5502 Tilden Ave.','11203','718-555-5555','Hurlington Industries','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                 
INSERT INTO student VALUES (312,'Ms.','Maria','Allende','2885 Bayview Ave.','11510','718-555-5555','HK Inc.','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                             
INSERT INTO student VALUES (313,'Mr.','John','Velie','135-24 233rd St.','11422','718-555-5555','TK Inc.','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                                 
INSERT INTO student VALUES (314,'Ms.','Bernice','Dermody','209 Carlton Ave.','11205','718-555-5555','New York Pop','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                       
INSERT INTO student VALUES (315,'Ms.','Daniel','McHowell','35 Sommerville St','11717','718-555-5555','Rischert & Assoc.','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                 
INSERT INTO student VALUES (317,'Ms.','Cathy','Austin','64-18 Madison St.','11385','718-555-5555','New York Culture','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                     
INSERT INTO student VALUES (319,'Mr.','George','Eakheit','40 Ramapo Rd','07421','201-555-5555','New York Culture','17-FEB-99','BROSENZWEIG','17-FEB-99','BROSENZW','20-FEB-99');                        
INSERT INTO student VALUES (320,'Mr.','Mark','Miller','40-44 70th St.','11377','718-555-5555','New York Culture','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                         
INSERT INTO student VALUES (321,'Ms.','Jeannette','Smagler','420 Greene Ave.','11216','718-555-5555','New York Culture','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                  
INSERT INTO student VALUES (322,'Mr.','Oscar','Archer','578 E 40th ST.','11218','718-555-5555','Capital Natnl Bank','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                      
INSERT INTO student VALUES (323,'Mr.','Gilbert','Ginestra','555 North Ave, 24C','07024','201-555-5555','Capital Natnl Bank','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');              
INSERT INTO student VALUES (324,'Mr.','Price','Marten','328 Fenimore St. #2','11225','718-555-5555','Xaticorp Retail','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                    
INSERT INTO student VALUES (325,'Ms.','Pat','Puetrino','Bldg #11, 1st St','10954','212-555-5555','Hayworth Business School','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');              
INSERT INTO student VALUES (326,'Mr.','Piotr','Padel','14 Spring Grove','06820','203-555-5555','Coley & McCarthy','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                        
INSERT INTO student VALUES (328,'Mr.','Lynwood A.','Thorton','68 Durand Pl','07111','201-555-5555','Colt Industries','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                     
INSERT INTO student VALUES (330,'Mr.','John','Tabs','8821 16th Avenue','11214','718-555-5555','Hayman Budget Offices','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                    
INSERT INTO student VALUES (331,'Ms.','Mei-Wah','Zopf','3448 76th ST.','11372','718-555-5555','Millerman Libraries','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                      
INSERT INTO student VALUES (332,'Ms.','Paula','Mwangi','321 Hill Ave.','13760','914-555-5555','Public Libraries','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                         
INSERT INTO student VALUES (333,'Mr.','Artie','Ward','951 Carroll St. #3B','11225','718-555-5555','Millerman Libraries','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                  
INSERT INTO student VALUES (334,'Ms.','Sarah','Annina','64 Janes Ln','06903','203-555-5555','Combustion Eng.','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                            
INSERT INTO student VALUES (335,'Ms.','Jane','Jackson','34 Park Row','07057','201-555-5555','Ray Reedy','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                                  
INSERT INTO student VALUES (336,'Mr.','Steven','Gallagher','522 60th St.','11228','718-555-5555','Combustion Eng.','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                       
INSERT INTO student VALUES (337,'Mr.','Preston','Cross','131-57 230th','11413','718-555-5555','Competrol Real Estate','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                    
INSERT INTO student VALUES (338,'Ms.','Helga','Towle','87B Hastings Ave.','07070','201-555-5555','Corp.Propty.Invstrs.','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                  
INSERT INTO student VALUES (339,'Mr.','Piang','Nyziak','646 Argyle Rd. B20','11230','718-555-5555','Cosmopolitan Reader, Inc.','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');           
INSERT INTO student VALUES (340,'Mr.','David','Eng','547 Crown St.','11213','718-555-5555','Counselor at Law','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                            
INSERT INTO student VALUES (341,'Mr.','Kevin','Porch','1531 John St.','07024','201-555-5555','Craftex Creations','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                         
INSERT INTO student VALUES (342,'Ms.','Marianne','De Armas','25 Duncan Ave.','07304','201-555-5555','Craftex Creations','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                  
INSERT INTO student VALUES (343,'Mr.','Ray','Schafer','73 Wilson St','11530','718-555-5555','Craftex Joice','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                              
INSERT INTO student VALUES (344,'Rev','R.','Sprouse','525 E. Front St.','07060','201-555-5555','Crane Co.','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                               
INSERT INTO student VALUES (345,'Mr.','Peter','Carey','23 School Lane','11743','718-555-5555','Crane Co.','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                                
INSERT INTO student VALUES (346,'Dr.','Joane','Buckberg','311 Temple Pl.','07090','201-555-5555','Crane Co.','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                             
INSERT INTO student VALUES (347,'Ms.','Edith','Daly','1763 E 28th St','11229','718-555-5555','Crane Co.','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                                 
INSERT INTO student VALUES (348,'Mr.','Morty','Miller','14 Side Hill Rd','06880','203-555-5555','Crane Co.','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                              
INSERT INTO student VALUES (349,'Ms.','Margaret','Mandel','1701 Albemarne Wd. F3','11226','718-555-5555','Crane Co.','19-FEB-99','BROSENZWEIG','19-FEB-99','BROSENZW','22-FEB-99');                     
INSERT INTO student VALUES (351,'Mr.','Alan','Galik','84-23 Mantuon St #4E','11435','718-555-5555','Credit for Everyone','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                 
INSERT INTO student VALUES (352,'Ms.','Debra','Shah','118-48 203rd St','11412','718-555-5555','DHJ Info Services','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                        
INSERT INTO student VALUES (353,'Mr.','Paul','Intal','62A Brookdale Grdns.','07003','201-555-5555','Dean Reynolds','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                       
INSERT INTO student VALUES (355,'Mr.','Romeo','Ittoop','837 Pavonia Ave.','07306','201-555-5555','Donaldson Lufkin','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                      
INSERT INTO student VALUES (356,'Mr.','John','Ancean','23 Pines Bridge Rd','06483','203-555-5555','Donaldson Lufkin','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                     
INSERT INTO student VALUES (357,'Mr.','Tom','Vargas','86 Harmon St.','11561','718-555-5555','Doyle & Assoc.','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                             
INSERT INTO student VALUES (358,'Ms.','Valerie','Avia','142-20 Franklin Ave. #3M','11355','718-555-5555','Drummond & Hill','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');               
INSERT INTO student VALUES (359,'Mr.','Fermin','Galik','54 Grand St.','11758','718-555-5555','Drummond & Hill','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                           
INSERT INTO student VALUES (360,'Mr.','Calvin','Kiraly','P.O. Box 1627','06820','203-555-5555','E.Asian Library','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                         
INSERT INTO student VALUES (361,'Mr.','Rawan','Rosenberg','94-31 59th Ave #5A','11373','718-555-5555','Millermont Public School','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');         
INSERT INTO student VALUES (362,'Mr.','Yu','Sentell','1679 Woodbine St.','11385','718-555-5555','Emerging Image, Inc.','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                   
INSERT INTO student VALUES (363,'Ms.','Bridget','Hagel','640 E 94th St','11236','718-555-5555','Emerging Image, Inc.','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                    
INSERT INTO student VALUES (364,'Mr.','Howard','Leopta','269 Vassar Ave','07112','201-555-5555','Miro Life Insurance','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                    
INSERT INTO student VALUES (365,'Ms.','Kathleen','Mastandora','Box 165','11222','718-555-5555','Mire Life Insurance','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                     
INSERT INTO student VALUES (366,'Mr.','Gabriel','Smith','451 E 26th St','11226','718-555-5555','Miro Life Insurance','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                     
INSERT INTO student VALUES (367,'Mr.','Raymond','Cheevens','2 Broadview Rd.','06880','203-555-5555','Miro Life Insurance','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                
INSERT INTO student VALUES (368,'Mr.','Kevin','Lin','1402 Easter Pkwy','11233','718-555-5555','Ettlinger & Amerbach','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                     
INSERT INTO student VALUES (369,'Ms.','Lorraine','Tucker','200 Winston Dr.','07010','201-555-5555','Ettlinger & Amerbach','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                
INSERT INTO student VALUES (370,'Mr.','John','Mithane','770 Amsterdam Ave. #20K','07010','201-555-5555','Euclid Partners Corp','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');           
INSERT INTO student VALUES (371,'Mr.','Craig','Anglin','199-46 21st Ave.','11357','718-555-5555','Baxxon Corp.','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                          
INSERT INTO student VALUES (372,'Ms.','Zalman','Draquez','5110 Ave. M','11234','718-555-5555','Baxxon Corp.','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                             
INSERT INTO student VALUES (373,'Ms.','Reeva','Yeroushalmi','4500 Beach 45th St.','11224','718-555-5555','Baxxon Corp.','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                  
INSERT INTO student VALUES (374,'Mr.','Leonard','Millstein','31 Thistle Lane','07430','201-555-5555','FGIC','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                              
INSERT INTO student VALUES (375,'Mr.','Jack','Kasperovich','98-17 162nd Ave.','11414','718-555-5555','Fashion Institute','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                 
INSERT INTO student VALUES (376,'Ms.','Lorelei','McNeal','432 Hunt Ln.','11030','718-555-5555','Finle & Co.','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                             
INSERT INTO student VALUES (378,'Mr.','William','Gallo','P O Box 6309','07306','201-555-5555','First Holland Corp.','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                      
INSERT INTO student VALUES (379,'Mr.','Craig','Padron','199-46 21st Ave.','11357','718-555-5555','German Natnl Bank','21-FEB-99','BROSENZWEIG','21-FEB-99','BROSENZW','24-FEB-99');                     
INSERT INTO student VALUES (380,'Mr.','Joel','Krot','111 Village Hill Dr.','11746','718-555-5555','Freeman, Davis','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');                       
INSERT INTO student VALUES (381,'Mr.','Allan','Simmons','2422 Brigham St.','11235','718-555-5555','Friedlander, Gaines','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');                  
INSERT INTO student VALUES (382,'Mr.','Michael','Miroff','1316 South End Prkwy.','07060','201-555-5555','Friedlander, Gaines','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');            
INSERT INTO student VALUES (383,'Ms.','Roger','Cowie','739 Willow St.','07016','201-555-5555','G.C.Osnos Co.','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');                            
INSERT INTO student VALUES (384,'Mr.','Asian','Chirichella','134-25 Franklin Ave. #512','11355','718-555-5555','Peo Capital Corp.','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');       
INSERT INTO student VALUES (385,'Ms.','Yvonne','Allende','8020 Fort Ave. #A3','11209','718-555-5555','Georval, Inc.','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');                     
INSERT INTO student VALUES (386,'Ms.','Sengita','MacDonald, Jr.','144-35 32nd Ave','11354','718-555-5555','Goddard Institute','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');            
INSERT INTO student VALUES (387,'Mr.','Paul','Braun','224 40th St','07111','201-555-5555','FBO, Inc.','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');                                    
INSERT INTO student VALUES (388,'Ms.','Anna','Bathmanapan','481 Van Buren St.#C1','11221','718-555-5555','FBO, Inc.','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');                     
INSERT INTO student VALUES (389,'Ms.','Shirley','Leung','88 Sherman St.','07055','201-555-5555','FBO, Inc.','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');                              
INSERT INTO student VALUES (390,'Mr.','V.','Greenberg','105-34 65th Ave.  #6B','11375','718-555-5555','Handler,Danas Realty','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');             
INSERT INTO student VALUES (391,'Mr.','Rafael A.','Torres','142-20 Franklin Ave. #2Q','11355','718-555-5555','Handler,Danas Realty','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');      
INSERT INTO student VALUES (392,'Mr.','V.','Saliternan','105-34 65th Ave.  #6B','11375','718-555-5555','Handler,Danas Realty','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');            
INSERT INTO student VALUES (393,'Mr.','Melvin','Martin','88 Sherman St.','07055','201-555-5555','Hanlon & McHeffey','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');                      
INSERT INTO student VALUES (394,'Ms.','Vera','Wetcel','172-12 133rd Ave.','11434','718-555-5555','Harold C.Hervon, PC','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');                   
INSERT INTO student VALUES (396,'Mr.','James E.','Norman','PO Box 809 Curran Hwy','01247','617-555-5555','Health & Hospitals','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');            
INSERT INTO student VALUES (397,'Ms.','Margaret','Lloyd','77-15 113th Street, #15','11375','718-555-5555','Health & Hospitals','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');           
INSERT INTO student VALUES (399,'Mr.','Jerry','Abdou','460 15th St. #4','10025','718-555-5555','Health Mgmt.Systems','23-FEB-99','BROSENZWEIG','23-FEB-99','BROSENZW','26-FEB-99');                     

COMMIT;

REM =============Populates ZIPCODE table ==========

INSERT INTO zipcode VALUES ('00914','Santurce','PR','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('01247','North Adams','MA','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('02124','Dorchester','MA','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('02155','Tufts Univ. Bedford','MA','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                          
INSERT INTO zipcode VALUES ('02189','Weymouth','MA','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('02563','Sandwich','MA','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('06401','Ansonia','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('06455','Middlefield','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('06483','Oxford','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('06520','New Haven','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('06605','Bridgeport','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('06798','Woodbury','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('06820','Georgetown','WV','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('06830','Greenwich','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('06850','Norwalk','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('06851','Norwalk','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('06853','Rowayton','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('06870','Old Greenwich','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                
INSERT INTO zipcode VALUES ('06877','Ridgefield','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('06880','Westport','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('06883','Weston','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('06897','Wilton','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('06902','Stamford','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('06903','Stamford','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('06905','Stamford','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('06907','Stamford','CT','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('07002','Bayonne','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('07003','Bloomfiel','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07006','North Caldwell','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                               
INSERT INTO zipcode VALUES ('07008','Carteret','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('07009','Cedar Grove','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('07010','Cliffside Park','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                               
INSERT INTO zipcode VALUES ('07011','Clifton','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('07012','Clifton','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('07014','Clifton','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('07016','Cranford','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('07021','Essex Fells','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('07023','Fanwood','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('07024','Ft. Lee','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('07029','Harrison','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('07030','Hoboken','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('07034','Lake Hiawatha','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                
INSERT INTO zipcode VALUES ('07035','Lincoln Pk.','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('07036','Lyndon','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('07040','Maplewood','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07042','Montclair','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07043','Upper Montclair','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                              
INSERT INTO zipcode VALUES ('07044','Verona','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('07047','North Bergen','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                 
INSERT INTO zipcode VALUES ('07054','Parsippany','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('07055','Passaic','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('07057','Wallington','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('07060','Plainfield','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('07065','Rahway','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('07066','Clark','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                        
INSERT INTO zipcode VALUES ('07070','Rutherford','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('07078','Short Hills','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('07079','S. Orange','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07087','Weehawken','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07090','Westfield','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07093','Guttenberg','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('07094','Secaucus','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('07096','Secaucus','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('07102','Newark','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('07104','Newark','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('07107','Newark','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('07109','Belleville','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('07111','Irvington','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07112','Newark','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('07302','Jersey City','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('07304','Jersey City','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('07306','Jersey City','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('07307','Jersey City','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('07401','Allendale','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07410','Fair Lawn','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07417','Franklin Lakes','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                               
INSERT INTO zipcode VALUES ('07421','Hewitt','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('07430','Mahwah','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('07444','Pompton Plains','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                               
INSERT INTO zipcode VALUES ('07450','Ridgewood','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07452','Glen Rock','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07458','Upper Saddle River','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                           
INSERT INTO zipcode VALUES ('07465','Wahnaque','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('07470','Wayne','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                        
INSERT INTO zipcode VALUES ('07480','W. Milford','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('07503','Paterson','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('07509','Patterson','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07601','Hackensack','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('07603','Bogota','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('07607','Maywood','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('07620','Alpine','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('07621','Bergenfield','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('07624','Closter','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('07628','Dumont','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('07631','Englewood','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07632','E. Cliffs','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('07640','Harrington Park','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                              
INSERT INTO zipcode VALUES ('07645','Montvale','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('07646','New Milford','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('07648','Norwood','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('07649','Oradell','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('07652','Paramus','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('07656','Park Ridge','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('10004','New York','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('10005','New York','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('10014','New York','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('10015','New York','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('10017','New York','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('10019','New York','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('10025','New York','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('10027','New York','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('10035','New York','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('10036','New York','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('10048','New York','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('10954','Nannet','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('10956','New City','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('10960','Central Nyack','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                
INSERT INTO zipcode VALUES ('10965','Pearl River','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('10983','Tappan','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('11021','Great Neck','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('11029','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11030','Manhasset','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('11040','New Hyde Park','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                
INSERT INTO zipcode VALUES ('11042','Long Beach','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('11050','Fort Washington','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                              
INSERT INTO zipcode VALUES ('11101','Long Island City','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                             
INSERT INTO zipcode VALUES ('11102','Astoria','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('11103','Astoria','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('11104','Sunnyside','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('11105','Astoria','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('11106','Long Island City','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                             
INSERT INTO zipcode VALUES ('11201','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11203','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11204','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11205','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11206','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11207','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11208','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11209','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11210','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11211','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11212','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11213','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11214','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11215','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11216','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11217','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11218','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11219','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11220','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11221','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11222','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11223','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11224','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11225','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11226','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11228','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11229','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11230','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11231','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11232','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11233','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11234','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11235','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11236','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11238','Brooklyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11295','West Islip','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('11303','Monbasset','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('11322','Jackson Hts.','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                 
INSERT INTO zipcode VALUES ('11354','Flushing','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11355','Flushing','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11357','Whitestone','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('11358','Flushing','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11360','Bayside','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('11361','Bayside','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('11362','Douglaston','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('11365','Fresh Meadows','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                
INSERT INTO zipcode VALUES ('11366','Flushing','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11368','Corona','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('11369','Elmhurst','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11370','Jackson Heights','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                              
INSERT INTO zipcode VALUES ('11372','Jackson Heights','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                              
INSERT INTO zipcode VALUES ('11373','Amherst','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('11374','Rego Park','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('11375','Forest Hills','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                 
INSERT INTO zipcode VALUES ('11377','Woodside','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11385','Ridgewood Queens','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                             
INSERT INTO zipcode VALUES ('11403','Holliswood','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('11412','Hollis','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('11413','Laurelton','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('11414','Howard Bank','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('11415','Kew Gardens','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('11418','Richmond Hills','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                               
INSERT INTO zipcode VALUES ('11419','Richmond Hill','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                
INSERT INTO zipcode VALUES ('11420','Jamaica','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('11422','Laurelton','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('11426','Bellrose','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11428','Queens Village','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                               
INSERT INTO zipcode VALUES ('11432','Jamaica','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('11433','Jamaica','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('11434','Jamaica','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('11435','Jamaica','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('11510','Baldwin','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('11530','Garden City','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                  
INSERT INTO zipcode VALUES ('11550','Hempstead','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('11552','West Hempstead','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                               
INSERT INTO zipcode VALUES ('11561','Long Beach','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('11565','Malverne','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11572','Jackson Heights','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                              
INSERT INTO zipcode VALUES ('11576','Roslyn','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                       
INSERT INTO zipcode VALUES ('11598','Woodmere','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('11694','Far Rockaway','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                 
INSERT INTO zipcode VALUES ('11717','Brentwood','NJ','AMORRISO','03-AUG-99','ARISCHER','18-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('11720','Centerach','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('11722','Central Islip','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                
INSERT INTO zipcode VALUES ('11743','Huntington','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('11746','Dix Hills','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('11758','Massapequa','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('11766','Huntington','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('11776','Port Jefferson','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                               
INSERT INTO zipcode VALUES ('11787','Smithtown','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                    
INSERT INTO zipcode VALUES ('11802','Hicksville','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('13760','Endicott','NY','AMORRISO','03-AUG-99','AMORRISO','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('30342','Atlanta','GA','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                      
INSERT INTO zipcode VALUES ('33431','Boca Raton','FL','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                   
INSERT INTO zipcode VALUES ('43224','Columbus','OH','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                     
INSERT INTO zipcode VALUES ('48104','Ann Arbor','MI','AMORRISO','03-AUG-99','ARISCHER','24-NOV-99');                                                                                                    

COMMIT;

REM ============= cREATES ALL CONSTRAINT FOR ALL tables ==========

PROMPT Creating Check Constraints on 'INSTRUCTOR'
ALTER TABLE INSTRUCTOR
 ADD CONSTRAINT INST_MODFIED_BY_NNULL CHECK ("MODIFIED_BY" IS NOT NULL)
 ADD CONSTRAINT INST_INSTRUCTOR_ID_NNULL CHECK ("INSTRUCTOR_ID" IS NOT NULL)
 ADD CONSTRAINT INST_CREATED_BY_NNULL CHECK ("CREATED_BY" IS NOT NULL)
 ADD CONSTRAINT INST_CREATED_DATE_NNULL CHECK ("CREATED_DATE" IS NOT NULL)
 ADD CONSTRAINT INST_MODIFIED_DATE_NNULL CHECK ("MODIFIED_DATE" IS NOT NULL)
/
 
PROMPT Creating Check Constraints on 'GRADE'
ALTER TABLE GRADE
 ADD CONSTRAINT GR_CREATED_DATE_NNULL CHECK ("CREATED_DATE" IS NOT NULL)
 ADD CONSTRAINT GR_STUDENT_ID_NNULL CHECK ("STUDENT_ID" IS NOT NULL)
 ADD CONSTRAINT GR_SECTION_ID_NNULL CHECK ("SECTION_ID" IS NOT NULL)
 ADD CONSTRAINT GR_GRADE_TYPE_CODE_NNULL CHECK ("GRADE_TYPE_CODE" IS NOT NULL)
 ADD CONSTRAINT GR_MODIFIED_DATE_NNULL CHECK ("MODIFIED_DATE" IS NOT NULL)
 ADD CONSTRAINT GR_CREATED_BY_NNULL CHECK ("CREATED_BY" IS NOT NULL)
 ADD CONSTRAINT GR_GRADE_CODE_OCCURRENCE_NNULL CHECK ("GRADE_CODE_OCCURRENCE" IS NOT NULL)
 ADD CONSTRAINT GR_MODIFIED_BY_NNULL CHECK ("MODIFIED_BY" IS NOT NULL)
/
 
PROMPT Creating Check Constraints on 'GRADE_TYPE'
ALTER TABLE GRADE_TYPE
 ADD CONSTRAINT GRTYP_DESCRIPTION_NNULL CHECK ("DESCRIPTION" IS NOT NULL)
 ADD CONSTRAINT GRTYP_MODIFIED_BY_NNULL CHECK ("MODIFIED_BY" IS NOT NULL)
 ADD CONSTRAINT GRTYP_CREATED_BY_NNULL CHECK ("CREATED_BY" IS NOT NULL)
 ADD CONSTRAINT GRTYP_GRADE_TYPE_CODE_NNULL CHECK ("GRADE_TYPE_CODE" IS NOT NULL)
 ADD CONSTRAINT GRTYP_MODIFIED_DATE_NNULL CHECK ("MODIFIED_DATE" IS NOT NULL)
 ADD CONSTRAINT GRTYP_CREATED_DATE_NNULL CHECK ("CREATED_DATE" IS NOT NULL)
 ADD CONSTRAINT GRTYP_GRADE_TYPE_CODE_LENGTH CHECK (LENGTH(grade_type_code)=2)
/
 
PROMPT Creating Check Constraints on 'GRADE_CONVERSION'
ALTER TABLE GRADE_CONVERSION
 ADD CONSTRAINT GRCON_MAX_GRADE_NNULL CHECK ("MAX_GRADE" IS NOT NULL)
 ADD CONSTRAINT GRCON_MODIFIED_DATE_NNULL CHECK ("MODIFIED_DATE" IS NOT NULL)
 ADD CONSTRAINT GRCON_CREATED_DATE_NNULL CHECK ("CREATED_DATE" IS NOT NULL)
 ADD CONSTRAINT GRCON_GRADE_POINT_NNULL CHECK ("GRADE_POINT" IS NOT NULL)
 ADD CONSTRAINT GRCON_MODIFIED_BY_NNULL CHECK ("MODIFIED_BY" IS NOT NULL)
 ADD CONSTRAINT GRCON_LETTER_GRADE_NNULL CHECK ("LETTER_GRADE" IS NOT NULL)
 ADD CONSTRAINT GRCON_MIN_GRADE_NNULL CHECK ("MIN_GRADE" IS NOT NULL)
 ADD CONSTRAINT GRCON_CREATED_BY_NNULL CHECK ("CREATED_BY" IS NOT NULL)
/
 
PROMPT Creating Check Constraints on 'GRADE_TYPE_WEIGHT'
ALTER TABLE GRADE_TYPE_WEIGHT
 ADD CONSTRAINT GRTW_NUMBER_PER_SECTION_NNULL CHECK ("NUMBER_PER_SECTION" IS NOT NULL)
 ADD CONSTRAINT GRTW_CREATED_DATE_NNULL CHECK ("CREATED_DATE" IS NOT NULL)
 ADD CONSTRAINT GRTW_PCT_OF_FINAL_GRADE_NNULL CHECK ("PERCENT_OF_FINAL_GRADE" IS NOT NULL)
 ADD CONSTRAINT GRTW_GRADE_TYPE_CODE_NNULL CHECK ("GRADE_TYPE_CODE" IS NOT NULL)
 ADD CONSTRAINT GRTW_SECTION_ID_NNULL CHECK ("SECTION_ID" IS NOT NULL)
 ADD CONSTRAINT GRTW_MODIFIED_BY_NNULL CHECK ("MODIFIED_BY" IS NOT NULL)
 ADD CONSTRAINT GRTW_CREATED_BY_NNULL CHECK ("CREATED_BY" IS NOT NULL)
 ADD CONSTRAINT GRTW_DROP_LOWEST_NNULL CHECK ("DROP_LOWEST" IS NOT NULL)
 ADD CONSTRAINT GRTW_MODIFIED_DATE_NNULL CHECK ("MODIFIED_DATE" IS NOT NULL)
/
 
PROMPT Creating Check Constraints on 'SECTION'
ALTER TABLE SECTION
 ADD CONSTRAINT SECT_CREATED_DATE_NNULL CHECK ("CREATED_DATE" IS NOT NULL)
 ADD CONSTRAINT SECT_MODIFIED_BY_NNULL CHECK ("MODIFIED_BY" IS NOT NULL)
 ADD CONSTRAINT SECT_SECTION_ID_NNULL CHECK ("SECTION_ID" IS NOT NULL)
 ADD CONSTRAINT SECT_SECTION_NO_NNULL CHECK ("SECTION_NO" IS NOT NULL)
 ADD CONSTRAINT SECT_CREATED_BY_NNULL CHECK ("CREATED_BY" IS NOT NULL)
 ADD CONSTRAINT SECT_INSTRUCTOR_ID_NNULL CHECK ("INSTRUCTOR_ID" IS NOT NULL)
 ADD CONSTRAINT SECT_MODIFIED_DATE_NNULL CHECK ("MODIFIED_DATE" IS NOT NULL)
 ADD CONSTRAINT SECT_COURSE_NO_NNULL CHECK ("COURSE_NO" IS NOT NULL)
/
 
PROMPT Creating Check Constraints on 'COURSE'
ALTER TABLE COURSE
 ADD CONSTRAINT CRSE_CREATED_DATE_NNULL CHECK ("CREATED_DATE" IS NOT NULL)
 ADD CONSTRAINT CRSE_MODIFIED_BY_NNULL CHECK ("MODIFIED_BY" IS NOT NULL)
 ADD CONSTRAINT CRSE_MODIFIED_DATE_NNULL CHECK ("MODIFIED_DATE" IS NOT NULL)
 ADD CONSTRAINT CRSE_DESCRIPTION_NNULL CHECK ("DESCRIPTION" IS NOT NULL)
 ADD CONSTRAINT CRSE_COURSE_NO_NNULL CHECK ("COURSE_NO" IS NOT NULL)
 ADD CONSTRAINT CRSE_CREATED_BY_NNULL CHECK ("CREATED_BY" IS NOT NULL)
/
 
PROMPT Creating Check Constraints on 'ENROLLMENT'
ALTER TABLE ENROLLMENT
 ADD CONSTRAINT ENR_MODIFIED_DATE_NNULL CHECK ("MODIFIED_DATE" IS NOT NULL)
 ADD CONSTRAINT ENR_STUDENT_ID_NNULL CHECK ("STUDENT_ID" IS NOT NULL)
 ADD CONSTRAINT ENR_ENROLL_DATE_NNULL CHECK ("ENROLL_DATE" IS NOT NULL)
 ADD CONSTRAINT ENR_MODIFIED_BY_NNULL CHECK ("MODIFIED_BY" IS NOT NULL)
 ADD CONSTRAINT ENR_SECTION_ID_NNULL CHECK ("SECTION_ID" IS NOT NULL)
 ADD CONSTRAINT ENR_CREATED_BY_NNULL CHECK ("CREATED_BY" IS NOT NULL)
 ADD CONSTRAINT ENR_CREATED_DATE_NNULL CHECK ("CREATED_DATE" IS NOT NULL)
/
 
PROMPT Creating Check Constraints on 'STUDENT'
ALTER TABLE STUDENT
 ADD CONSTRAINT STU_REGISTRATION_DATE_NNULL CHECK ("REGISTRATION_DATE" IS NOT NULL)
 ADD CONSTRAINT STU_CREATED_BY_NNULL CHECK ("CREATED_BY" IS NOT NULL)
 ADD CONSTRAINT STU_ZIP_NNULL CHECK ("ZIP" IS NOT NULL)
 ADD CONSTRAINT STU_LAST_NAME_NNULL CHECK ("LAST_NAME" IS NOT NULL)
 ADD CONSTRAINT STU_MODIFIED_DATE_NNULL CHECK ("MODIFIED_DATE" IS NOT NULL)
 ADD CONSTRAINT STU_STUDENT_ID_NNULL CHECK ("STUDENT_ID" IS NOT NULL)
 ADD CONSTRAINT STU_MODIFIED_BY_NNULL CHECK ("MODIFIED_BY" IS NOT NULL)
 ADD CONSTRAINT STU_CREATED_DATE_NNULL CHECK ("CREATED_DATE" IS NOT NULL)
/
 
PROMPT Creating Check Constraints on 'ZIPCODE'
ALTER TABLE ZIPCODE
 ADD CONSTRAINT ZIP_CREATED_BY_NNULL CHECK ("CREATED_BY" IS NOT NULL)
 ADD CONSTRAINT ZIP_MODIFIED_DATE_NNULL CHECK ("MODIFIED_DATE" IS NOT NULL)
 ADD CONSTRAINT ZIP_CREATED_DATE_NNULL CHECK ("CREATED_DATE" IS NOT NULL)
 ADD CONSTRAINT ZIP_ZIP_NNULL CHECK ("ZIP" IS NOT NULL)
 ADD CONSTRAINT ZIP_MODIFIED_BY_NNULL CHECK ("MODIFIED_BY" IS NOT NULL)
/

PROMPT Creating Primary Key on 'INSTRUCTOR'
ALTER TABLE INSTRUCTOR
 ADD CONSTRAINT INST_PK PRIMARY KEY 
  (INSTRUCTOR_ID)
/

PROMPT Creating Primary Key on 'GRADE'
ALTER TABLE GRADE
 ADD CONSTRAINT GR_PK PRIMARY KEY 
  (STUDENT_ID
  ,SECTION_ID
  ,GRADE_TYPE_CODE
  ,GRADE_CODE_OCCURRENCE)
/

PROMPT Creating Primary Key on 'GRADE_TYPE'
ALTER TABLE GRADE_TYPE
 ADD CONSTRAINT GRTYP_PK PRIMARY KEY 
  (GRADE_TYPE_CODE)
/

PROMPT Creating Primary Key on 'GRADE_CONVERSION'
ALTER TABLE GRADE_CONVERSION
 ADD CONSTRAINT GRCON_PK PRIMARY KEY 
  (LETTER_GRADE)
/

PROMPT Creating Primary Key on 'GRADE_TYPE_WEIGHT'
ALTER TABLE GRADE_TYPE_WEIGHT
 ADD CONSTRAINT GRTW_PK PRIMARY KEY 
  (SECTION_ID
  ,GRADE_TYPE_CODE)
/

PROMPT Creating Primary Key on 'SECTION'
ALTER TABLE SECTION
 ADD CONSTRAINT SECT_PK PRIMARY KEY 
  (SECTION_ID)
/

PROMPT Creating Primary Key on 'COURSE'
ALTER TABLE COURSE
 ADD CONSTRAINT CRSE_PK PRIMARY KEY 
  (COURSE_NO)
/

PROMPT Creating Primary Key on 'ENROLLMENT'
ALTER TABLE ENROLLMENT
 ADD CONSTRAINT ENR_PK PRIMARY KEY 
  (STUDENT_ID
  ,SECTION_ID)
/

PROMPT Creating Primary Key on 'STUDENT'
ALTER TABLE STUDENT
 ADD CONSTRAINT STU_PK PRIMARY KEY 
  (STUDENT_ID)
/

PROMPT Creating Primary Key on 'ZIPCODE'
ALTER TABLE ZIPCODE
 ADD CONSTRAINT ZIP_PK PRIMARY KEY 
  (ZIP)
/

PROMPT Creating Unique Keys on 'SECTION'
ALTER TABLE SECTION 
 ADD ( CONSTRAINT SECT_SECT2_UK UNIQUE 
  (SECTION_NO
  ,COURSE_NO))
/

PROMPT Creating Foreign Keys on 'INSTRUCTOR'
ALTER TABLE INSTRUCTOR ADD CONSTRAINT
 INST_ZIP_FK FOREIGN KEY 
  (ZIP) REFERENCES ZIPCODE
  (ZIP)
/

PROMPT Creating Foreign Keys on 'GRADE'
ALTER TABLE GRADE ADD CONSTRAINT
 GR_ENR_FK FOREIGN KEY 
  (STUDENT_ID
  ,SECTION_ID) REFERENCES ENROLLMENT
  (STUDENT_ID
  ,SECTION_ID) ADD CONSTRAINT
 GR_GRTW_FK FOREIGN KEY 
  (SECTION_ID
  ,GRADE_TYPE_CODE) REFERENCES GRADE_TYPE_WEIGHT
  (SECTION_ID
  ,GRADE_TYPE_CODE)
/

PROMPT Creating Foreign Keys on 'GRADE_TYPE_WEIGHT'
ALTER TABLE GRADE_TYPE_WEIGHT ADD CONSTRAINT
 GRTW_GRTYP_FK FOREIGN KEY 
  (GRADE_TYPE_CODE) REFERENCES GRADE_TYPE
  (GRADE_TYPE_CODE) ADD CONSTRAINT
 GRTW_SECT_FK FOREIGN KEY 
  (SECTION_ID) REFERENCES SECTION
  (SECTION_ID)
/

PROMPT Creating Foreign Keys on 'SECTION'
ALTER TABLE SECTION ADD CONSTRAINT
 SECT_INST_FK FOREIGN KEY 
  (INSTRUCTOR_ID) REFERENCES INSTRUCTOR
  (INSTRUCTOR_ID) ADD CONSTRAINT
 SECT_CRSE_FK FOREIGN KEY 
  (COURSE_NO) REFERENCES COURSE
  (COURSE_NO)
/

PROMPT Creating Foreign Keys on 'COURSE'
ALTER TABLE COURSE ADD CONSTRAINT
 CRSE_CRSE_FK FOREIGN KEY 
  (PREREQUISITE) REFERENCES COURSE
  (COURSE_NO)
/

PROMPT Creating Foreign Keys on 'ENROLLMENT'
ALTER TABLE ENROLLMENT ADD CONSTRAINT
 ENR_STU_FK FOREIGN KEY 
  (STUDENT_ID) REFERENCES STUDENT
  (STUDENT_ID) ADD CONSTRAINT
 ENR_SECT_FK FOREIGN KEY 
  (SECTION_ID) REFERENCES SECTION
  (SECTION_ID)
/

PROMPT Creating Foreign Keys on 'STUDENT'
ALTER TABLE STUDENT ADD CONSTRAINT
 STU_ZIP_FK FOREIGN KEY 
  (ZIP) REFERENCES ZIPCODE
  (ZIP)
/


REM ============= cREATES ALL SEQUENCES FOR ALL tables ==========


PROMPT Creating Sequence 'INSTRUCTOR_ID_SEQ'
CREATE SEQUENCE INSTRUCTOR_ID_SEQ
 INCREMENT BY 1
 START WITH 112
 NOMAXVALUE
 MINVALUE 1
 NOCYCLE
 NOCACHE
/

PROMPT Creating Sequence 'SECTION_ID_SEQ'
CREATE SEQUENCE SECTION_ID_SEQ
 INCREMENT BY 1
 START WITH 158
 NOMAXVALUE
 MINVALUE 1
 NOCYCLE
 NOCACHE
/

PROMPT Creating Sequence 'STUDENT_ID_SEQ'
CREATE SEQUENCE STUDENT_ID_SEQ
 INCREMENT BY 1
 START WITH 401
 NOMAXVALUE
 MINVALUE 1
 NOCYCLE
 NOCACHE
/

PROMPT Creating Sequence 'COURSE_NO_SEQ'
CREATE SEQUENCE COURSE_NO_SEQ
 INCREMENT BY 1
 START WITH 452
 NOMAXVALUE
 MINVALUE 1
 NOCYCLE
 NOCACHE
/

SET  DEFINE ON

REM ============== Counts # OF ROWS in all tables ============

SELECT 'Count of COURSE Table:', COUNT(*)
  FROM course
 GROUP BY 'Count of COURSE Table:';
SELECT 'Count of ENROLLMENT Table:', COUNT(*)
  FROM enrollment
 GROUP BY 'Count of ENROLLMENT Table:';
SELECT 'Count of GRADE Table:', COUNT(*)
  FROM GRADE
 GROUP BY 'Count of GRADE Table:';
SELECT 'Count of GRADE_CONVERSION Table:', COUNT(*)
  FROM GRADE_CONVERSION
 GROUP BY 'Count of GRADE_CONVERSION Table:';
SELECT 'Count of GRADE_TYPE Table:', COUNT(*)
  FROM GRADE_TYPE
 GROUP BY 'Count of GRADE_TYPE Table:';
SELECT 'Count of GRADE_TYPE_WEIGHT Table:', COUNT(*)
  FROM GRADE_TYPE_WEIGHT
 GROUP BY 'Count of GRADE_TYPE Table:';
SELECT 'Count of INSTRUCTOR Table:', COUNT(*)
  FROM INSTRUCTOR
 GROUP BY 'Count of INSTRUCTOR Table:';
SELECT 'Count of SECTION Table:', COUNT(*)
  FROM SECTION
 GROUP BY 'Count of SECTION Table:';
SELECT 'Count of STUDENT Table:', COUNT(*)
  FROM STUDENT
 GROUP BY 'Count of STUDENT Table:';
SELECT 'Count of ZIPCODE Table:', COUNT(*)
  FROM ZIPCODE
 GROUP BY 'Count of ZIPCODE Table:';