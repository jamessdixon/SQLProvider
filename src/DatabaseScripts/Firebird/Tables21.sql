/********************* ROLES **********************/

/********************* UDFS ***********************/

/****************** SEQUENCES ********************/

/******************** DOMAINS *********************/

/******************* PROCEDURES ******************/

SET TERM ^ ;
CREATE PROCEDURE ADD_JOB_HISTORY (
    P_EMP_ID INTEGER,
    P_START_DATE timestamp,
    P_END_DATE timestamp,
    P_JOB_ID VARCHAR(10),
    P_DEPARTMENT_ID INTEGER )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE GET_EMPLOYEES
RETURNS (
    EMPLOYEE_ID INTEGER,
    FIRST_NAME VARCHAR(20),
    LAST_NAME VARCHAR(25),
    EMAIL VARCHAR(25),
    PHONE_NUMBER VARCHAR(20),
    HIRE_DATE timestamp,
    JOB_ID VARCHAR(10),
    SALARY INTEGER,
    COMMISSION_PCT INTEGER,
    MANAGER_ID INTEGER,
    DEPARTMENT_ID INTEGER )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

SET TERM ^ ;
CREATE PROCEDURE GET_EMPLOYEES_STARTING_AFTER (
    STARTDATE DATE )
RETURNS (
    EMPLOYEE_ID INTEGER,
    FIRST_NAME VARCHAR(20),
    LAST_NAME VARCHAR(25),
    EMAIL VARCHAR(25),
    PHONE_NUMBER VARCHAR(20),
    HIRE_DATE timestamp,
    JOB_ID VARCHAR(10),
    SALARY INTEGER,
    COMMISSION_PCT INTEGER,
    MANAGER_ID INTEGER,
    DEPARTMENT_ID INTEGER )
AS
BEGIN SUSPEND; END^
SET TERM ; ^

/******************** TABLES **********************/

CREATE TABLE CATEGORIES
(
  CATEGORYID INTEGER NOT NULL,
  CATEGORYNAME VARCHAR(15) NOT NULL,
  DESCRIPTION VARCHAR(1000),
  PICTURE BLOB SUB_TYPE 1,
  CONSTRAINT PK_CATEGORIES PRIMARY KEY (CATEGORYID)
);
CREATE TABLE COUNTRIES
(
  COUNTRY_ID CHAR(2) NOT NULL,
  COUNTRY_NAME VARCHAR(40),
  REGION_ID INTEGER,
  OTHER BLOB SUB_TYPE 1,
  CONSTRAINT INTEG_67 PRIMARY KEY (COUNTRY_ID)
);

CREATE TABLE DEPARTMENTS
(
  DEPARTMENT_ID INTEGER NOT NULL,
  DEPARTMENT_NAME VARCHAR(30) NOT NULL,
  MANAGER_ID INTEGER,
  LOCATION_ID INTEGER,
  CONSTRAINT INTEG_113 PRIMARY KEY (DEPARTMENT_ID)
);
CREATE TABLE EMPLOYEES
(
  EMPLOYEE_ID INTEGER NOT NULL,
  FIRST_NAME VARCHAR(20),
  LAST_NAME VARCHAR(25) NOT NULL,
  EMAIL VARCHAR(25) NOT NULL,
  PHONE_NUMBER VARCHAR(20),
  HIRE_DATE DATE NOT NULL,
  JOB_ID VARCHAR(10) NOT NULL,
  SALARY INTEGER,
  COMMISSION_PCT INTEGER,
  MANAGER_ID INTEGER,
  DEPARTMENT_ID INTEGER,
  CONSTRAINT INTEG_1023 PRIMARY KEY (EMPLOYEE_ID),
  CONSTRAINT INTEG_122 UNIQUE (EMAIL)
);
CREATE TABLE JOBS
(
  JOB_ID VARCHAR(10) NOT NULL,
  JOB_TITLE VARCHAR(35) NOT NULL,
  MIN_SALARY INTEGER,
  MAX_SALARY INTEGER,
  CONSTRAINT INTEG_115 PRIMARY KEY (JOB_ID)
);
CREATE TABLE JOB_HISTORY
(
  EMPLOYEE_ID INTEGER NOT NULL,
  START_DATE DATE NOT NULL,
  END_DATE DATE NOT NULL,
  JOB_ID VARCHAR(10) NOT NULL,
  DEPARTMENT_ID INTEGER,
  CONSTRAINT INTEG_1033 PRIMARY KEY (EMPLOYEE_ID,START_DATE)
);
CREATE TABLE LOCATIONS
(
  LOCATION_ID INTEGER NOT NULL,
  STREET_ADDRESS VARCHAR(40),
  POSTAL_CODE VARCHAR(12),
  CITY VARCHAR(30) NOT NULL,
  STATE_PROVINCE VARCHAR(25),
  COUNTRY_ID CHAR(2),
  CONSTRAINT INTEG_109 PRIMARY KEY (LOCATION_ID)
);
CREATE TABLE PRODUCTS
(
  PRODUCTID INTEGER NOT NULL,
  PRODUCTNAME VARCHAR(40) NOT NULL,
  SUPPLIERID INTEGER,
  CATEGORYID INTEGER,
  QUANTITYPERUNIT VARCHAR(20),
  UNITPRICE BLOB SUB_TYPE 1,
  UNITSINSTOCK BLOB SUB_TYPE 1,
  UNITSONORDER BLOB SUB_TYPE 1,
  REORDERLEVEL BLOB SUB_TYPE 1,
  DISCONTINUED BLOB SUB_TYPE 1 NOT NULL,
  DISCONTINUEDDATE BLOB SUB_TYPE 1,
  DISCONTINUED_DATE timestamp,
  VALOR INT,
  DP DOUBLE PRECISION,
  dec_ NUMERIC(15,4),
  CONSTRAINT PK_PRODUCTS PRIMARY KEY (PRODUCTID)
);
CREATE TABLE REGIONS
(
  REGION_ID INTEGER NOT NULL,
  REGION_NAME VARCHAR(25),
  REGION_DESCRIPTION BLOB SUB_TYPE 1,
  CONSTRAINT INTEG_138 PRIMARY KEY (REGION_ID)
);
CREATE TABLE SUPPLIERS
(
  SUPPLIERID INTEGER NOT NULL,
  COMPANYNAME VARCHAR(40) NOT NULL,
  CONTACTNAME VARCHAR(30),
  CONTACTTITLE VARCHAR(30),
  ADDRESS VARCHAR(60),
  CITY VARCHAR(15),
  REGION VARCHAR(15),
  POSTALCODE VARCHAR(10),
  COUNTRY VARCHAR(15),
  PHONE VARCHAR(24),
  FAX VARCHAR(24),
  HOMEPAGE BLOB SUB_TYPE 1,
  CONSTRAINT PK_SUPPLIERS PRIMARY KEY (SUPPLIERID)
);
/********************* VIEWS **********************/

/******************* EXCEPTIONS *******************/

/******************** TRIGGERS ********************/


SET TERM ^ ;
ALTER PROCEDURE ADD_JOB_HISTORY (
    P_EMP_ID INTEGER,
    P_START_DATE timestamp,
    P_END_DATE timestamp,
    P_JOB_ID VARCHAR(10),
    P_DEPARTMENT_ID INTEGER )
AS
BEGIN
  INSERT INTO JOB_HISTORY (employee_id, start_date, end_date, job_id, department_id) VALUES(:p_emp_id, :p_start_date, :p_end_date, :p_job_id, :p_department_id);
END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE GET_EMPLOYEES
RETURNS (
    EMPLOYEE_ID INTEGER,
    FIRST_NAME VARCHAR(20),
    LAST_NAME VARCHAR(25),
    EMAIL VARCHAR(25),
    PHONE_NUMBER VARCHAR(20),
    HIRE_DATE timestamp,
    JOB_ID VARCHAR(10),
    SALARY INTEGER,
    COMMISSION_PCT INTEGER,
    MANAGER_ID INTEGER,
    DEPARTMENT_ID INTEGER )
AS
BEGIN
  FOR SELECT 
    a.EMPLOYEE_ID, 
    a.FIRST_NAME, 
    a.LAST_NAME, 
    a.EMAIL, 
    a.PHONE_NUMBER, 
    a.HIRE_DATE, 
    a.JOB_ID, 
    a.SALARY, 
    a.COMMISSION_PCT, 
    a.MANAGER_ID, 
    a.DEPARTMENT_ID
  FROM EMPLOYEES a
  INTO 
    EMPLOYEE_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    EMAIL, 
    PHONE_NUMBER, 
    HIRE_DATE, 
    JOB_ID, 
    SALARY, 
    COMMISSION_PCT, 
    MANAGER_ID, 
    DEPARTMENT_ID 
  DO
  BEGIN
    SUSPEND;
  END
END^
SET TERM ; ^


SET TERM ^ ;
ALTER PROCEDURE GET_EMPLOYEES_STARTING_AFTER (
    STARTDATE DATE )
RETURNS (
    EMPLOYEE_ID INTEGER,
    FIRST_NAME VARCHAR(20),
    LAST_NAME VARCHAR(25),
    EMAIL VARCHAR(25),
    PHONE_NUMBER VARCHAR(20),
    HIRE_DATE timestamp,
    JOB_ID VARCHAR(10),
    SALARY INTEGER,
    COMMISSION_PCT INTEGER,
    MANAGER_ID INTEGER,
    DEPARTMENT_ID INTEGER )
AS
BEGIN
  FOR SELECT 
    a.EMPLOYEE_ID, 
    a.FIRST_NAME, 
    a.LAST_NAME, 
    a.EMAIL, 
    a.PHONE_NUMBER, 
    a.HIRE_DATE, 
    a.JOB_ID, 
    a.SALARY, 
    a.COMMISSION_PCT, 
    a.MANAGER_ID, 
    a.DEPARTMENT_ID
  FROM EMPLOYEES a
      WHERE HIRE_DATE >= :STARTDATE
  INTO 
    EMPLOYEE_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    EMAIL, 
    PHONE_NUMBER, 
    HIRE_DATE, 
    JOB_ID, 
    SALARY, 
    COMMISSION_PCT, 
    MANAGER_ID, 
    DEPARTMENT_ID do suspend;
END^
SET TERM ; ^


CREATE INDEX IDX_0_CATEGORIES ON CATEGORIES (CATEGORYNAME);
ALTER TABLE DEPARTMENTS ADD CONSTRAINT INTEG_142
  FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID);
ALTER TABLE DEPARTMENTS ADD CONSTRAINT INTEG_1046
  FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS (LOCATION_ID);
comment on column EMPLOYEES.EMAIL is 'Email is a max-25-char item, having at-sign and a dot';
ALTER TABLE EMPLOYEES ADD CONSTRAINT INTEG_139
  FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS (DEPARTMENT_ID);
ALTER TABLE EMPLOYEES ADD CONSTRAINT INTEG_140
  FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID);
ALTER TABLE EMPLOYEES ADD CONSTRAINT INTEG_141
  FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID);
ALTER TABLE EMPLOYEES ADD CONSTRAINT INTEG_121
  CHECK (SALARY > 0);
comment on table EMPLOYEES is 'Employees is a very important table, used in many places.';
ALTER TABLE JOB_HISTORY ADD CONSTRAINT INTEG_143
  FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID);
ALTER TABLE JOB_HISTORY ADD CONSTRAINT INTEG_144
  FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID);
ALTER TABLE JOB_HISTORY ADD CONSTRAINT INTEG_145
  FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS (DEPARTMENT_ID);
ALTER TABLE JOB_HISTORY ADD CONSTRAINT INTEG_132
  CHECK (end_date > start_date);
ALTER TABLE LOCATIONS ADD CONSTRAINT INTEG_147
  FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRIES (COUNTRY_ID);
ALTER TABLE PRODUCTS ADD CONSTRAINT PRODUCTS_FK_0
  FOREIGN KEY (SUPPLIERID) REFERENCES SUPPLIERS (SUPPLIERID) ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE PRODUCTS ADD CONSTRAINT PRODUCTS_FK_1
  FOREIGN KEY (CATEGORYID) REFERENCES CATEGORIES (CATEGORYID) ON UPDATE NO ACTION ON DELETE NO ACTION;
CREATE INDEX IDX_21_PRODUCTS ON PRODUCTS (SUPPLIERID);
CREATE INDEX IDX_22_PRODUCTS ON PRODUCTS (SUPPLIERID);
CREATE INDEX IDX_23_PRODUCTS ON PRODUCTS (PRODUCTNAME);
CREATE INDEX IDX_24_PRODUCTS ON PRODUCTS (CATEGORYID);
CREATE INDEX IDX_25_PRODUCTS ON PRODUCTS (CATEGORYID);
CREATE INDEX IDX_26_SUPPLIERS ON SUPPLIERS (POSTALCODE);
CREATE INDEX IDX_27_SUPPLIERS ON SUPPLIERS (COMPANYNAME);
GRANT EXECUTE
 ON PROCEDURE ADD_JOB_HISTORY TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE GET_EMPLOYEES TO  SYSDBA;

GRANT EXECUTE
 ON PROCEDURE GET_EMPLOYEES_STARTING_AFTER TO  SYSDBA;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON CATEGORIES TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON COUNTRIES TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON DEPARTMENTS TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON EMPLOYEES TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON JOBS TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON JOB_HISTORY TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON LOCATIONS TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON PRODUCTS TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON REGIONS TO  SYSDBA WITH GRANT OPTION;

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE
 ON SUPPLIERS TO  SYSDBA WITH GRANT OPTION;

