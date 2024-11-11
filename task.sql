CREATE TABLE CUSTOMER (
    CUST_ID INTEGER PRIMARY KEY,
    NAME VARCHAR2(255) NOT NULL,
    STATE_ID VARCHAR2(10) NOT NULL
);

CREATE TABLE BUSINESS (
    CUST_ID INTEGER PRIMARY KEY,
    INCORP_DATE DATE,
    NAME VARCHAR2(255) NOT NULL,
    STATE_ID VARCHAR2(10) NOT NULL,
    FOREIGN KEY (CUST_ID) REFERENCES CUSTOMER(CUST_ID)
);

CREATE TABLE BRANCH (
    BRANCH_ID INTEGER PRIMARY KEY,
    NAME VARCHAR2(255) NOT NULL,
    LOCATION VARCHAR2(255)
);

CREATE TABLE EMPLOYEE (
    EMP_ID INTEGER PRIMARY KEY,
    NAME VARCHAR2(255) NOT NULL,
    DEPARTMENT_ID INTEGER,
    BRANCH_ID INTEGER,
    JOIN_DATE DATE,
    SALARY NUMBER(14, 2),
    POSITION VARCHAR2(50),
    FOREIGN KEY (BRANCH_ID) REFERENCES BRANCH(BRANCH_ID)
);

CREATE TABLE DEPARTMENT (
    DEPARTMENT_ID INTEGER PRIMARY KEY,
    NAME VARCHAR2(255) NOT NULL,
    MANAGER_EMP_ID INTEGER,
    FOREIGN KEY (MANAGER_EMP_ID) REFERENCES EMPLOYEE(EMP_ID)
);

CREATE TABLE OFFICER (
    OFFICER_ID INTEGER PRIMARY KEY,
    NAME VARCHAR2(255) NOT NULL,
    BUSINESS_CUST_ID INTEGER,
    RANK VARCHAR2(50),
    DATE_APPOINTED DATE,
    FOREIGN KEY (BUSINESS_CUST_ID) REFERENCES BUSINESS(CUST_ID)
);

CREATE TABLE PRODUCT (
    PRODUCT_CD VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(255) NOT NULL,
    DESCRIPTION VARCHAR2(255),
    INTEREST_RATE NUMBER(5, 2),
    MIN_BALANCE NUMBER(14, 2)
);

CREATE TABLE PRODUCT_TYPE (
    PRODUCT_TYPE_ID INTEGER PRIMARY KEY,
    NAME VARCHAR2(255) NOT NULL,
    DESCRIPTION VARCHAR2(255)
);

CREATE TABLE ACCOUNT (
    ACCOUNT_ID INTEGER PRIMARY KEY,
    AVAIL_BALANCE NUMBER(14, 2),
    CLOSE_DATE DATE,
    LAST_ACTIVITY_DATE DATE NOT NULL,
    OPEN_DATE DATE,
    PENDING_BALANCE NUMBER(14, 2),
    STATUS VARCHAR2(10),
    CUST_ID INTEGER,
    OPEN_BRANCH_ID INTEGER NOT NULL,
    OPEN_EMP_ID INTEGER NOT NULL,
    PRODUCT_CD VARCHAR2(10) NOT NULL,
    ACCOUNT_TYPE VARCHAR2(50),
    INTEREST_ACCRUED NUMBER(14, 2),
    FOREIGN KEY (CUST_ID) REFERENCES CUSTOMER(CUST_ID),
    FOREIGN KEY (OPEN_BRANCH_ID) REFERENCES BRANCH(BRANCH_ID),
    FOREIGN KEY (OPEN_EMP_ID) REFERENCES EMPLOYEE(EMP_ID),
    FOREIGN KEY (PRODUCT_CD) REFERENCES PRODUCT(PRODUCT_CD)
);

CREATE TABLE ACC_TRANSACTION (
    TXN_ID INTEGER PRIMARY KEY,
    AMOUNT NUMBER(14, 2) NOT NULL,
    FUNDS_AVAIL_DATE TIMESTAMP,
    TXN_DATE TIMESTAMP NOT NULL,
    TXN_TYPE_CD VARCHAR2(10),
    ACCOUNT_ID INTEGER,
    EXECUTION_BRANCH_ID INTEGER,
    TELLER_EMP_ID INTEGER,
    STATUS VARCHAR2(50),
    REMARKS VARCHAR2(255),
    FOREIGN KEY (ACCOUNT_ID) REFERENCES ACCOUNT(ACCOUNT_ID),
    FOREIGN KEY (EXECUTION_BRANCH_ID) REFERENCES BRANCH(BRANCH_ID),
    FOREIGN KEY (TELLER_EMP_ID) REFERENCES EMPLOYEE(EMP_ID)
);