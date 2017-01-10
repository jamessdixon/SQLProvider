connect hr/password;

CREATE TABLE "REGIONS"
  ( "REGION_ID" NUMBER CONSTRAINT "REGION_ID_NN" NOT NULL ENABLE
  , "REGION_NAME" VARCHAR2(25)
  , CONSTRAINT "REG_ID_PK" PRIMARY KEY ("REGION_ID") ENABLE
  );

CREATE TABLE "COUNTRIES"
  ( "COUNTRY_ID" CHAR(2) CONSTRAINT "COUNTRY_ID_NN" NOT NULL ENABLE
  , "COUNTRY_NAME" VARCHAR2(40)
  , "REGION_ID" NUMBER
  , "OTHER" VARCHAR2(2000)
  , CONSTRAINT "COUNTRY_C_ID_PK" PRIMARY KEY ("COUNTRY_ID") ENABLE
  )
  ORGANIZATION INDEX NOCOMPRESS;

CREATE TABLE "JOBS"
  ( "JOB_ID" VARCHAR2(10)
  , "JOB_TITLE" VARCHAR2(35) CONSTRAINT "JOB_TITLE_NN" NOT NULL ENABLE
  , "MIN_SALARY" NUMBER(6,0)
  , "MAX_SALARY" NUMBER(6,0)
  , CONSTRAINT "JOB_ID_PK" PRIMARY KEY ("JOB_ID") ENABLE
  );

CREATE TABLE "EMPLOYEES"
  ( "EMPLOYEE_ID" NUMBER(6,0)
  , "FIRST_NAME" VARCHAR2(20)
  , "LAST_NAME" VARCHAR2(25) CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL ENABLE
  , "EMAIL" VARCHAR2(25) CONSTRAINT "EMP_EMAIL_NN" NOT NULL ENABLE
  , "PHONE_NUMBER" VARCHAR2(20)
  , "HIRE_DATE" DATE CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL ENABLE
  , "JOB_ID" VARCHAR2(10) CONSTRAINT "EMP_JOB_NN" NOT NULL ENABLE
  , "SALARY" NUMBER(8,2)
  , "COMMISSION_PCT" NUMBER(2,2)
  , "MANAGER_ID" NUMBER(6,0)
  , "DEPARTMENT_ID" NUMBER(4,0)
  , CONSTRAINT "EMP_SALARY_MIN" CHECK (salary > 0) ENABLE
  , CONSTRAINT "EMP_EMAIL_UK" UNIQUE ("EMAIL") ENABLE
  , CONSTRAINT "EMP_EMP_ID_PK" PRIMARY KEY ("EMPLOYEE_ID") ENABLE
  );

CREATE TABLE "LOCATIONS"
  ( "LOCATION_ID" NUMBER(4,0)
  , "STREET_ADDRESS" VARCHAR2(40)
  , "POSTAL_CODE" VARCHAR2(12)
  , "CITY" VARCHAR2(30) CONSTRAINT "LOC_CITY_NN" NOT NULL ENABLE
  , "STATE_PROVINCE" VARCHAR2(25)
  , "COUNTRY_ID" CHAR(2)
  , CONSTRAINT "LOC_ID_PK" PRIMARY KEY ("LOCATION_ID") ENABLE
  );

CREATE TABLE "DEPARTMENTS"
  ( "DEPARTMENT_ID" NUMBER(4,0)
  , "DEPARTMENT_NAME" VARCHAR2(30) CONSTRAINT "DEPT_NAME_NN" NOT NULL ENABLE
  , "MANAGER_ID" NUMBER(6,0)
  , "LOCATION_ID" NUMBER(4,0)
  , CONSTRAINT "DEPT_ID_PK" PRIMARY KEY ("DEPARTMENT_ID") ENABLE
  );

CREATE TABLE "JOB_HISTORY"
  ( "EMPLOYEE_ID" NUMBER(6,0) CONSTRAINT "JHIST_EMPLOYEE_NN" NOT NULL ENABLE
  , "START_DATE" DATE CONSTRAINT "JHIST_START_DATE_NN" NOT NULL ENABLE
  , "END_DATE" DATE CONSTRAINT "JHIST_END_DATE_NN" NOT NULL ENABLE
  , "JOB_ID" VARCHAR2(10) CONSTRAINT "JHIST_JOB_NN" NOT NULL ENABLE
  , "DEPARTMENT_ID" NUMBER(4,0)
  , CONSTRAINT "JHIST_DATE_INTERVAL" CHECK (end_date > start_date) ENABLE
  , CONSTRAINT "JHIST_EMP_ID_ST_DATE_PK" PRIMARY KEY ("EMPLOYEE_ID", "START_DATE") ENABLE
  );

COMMIT;