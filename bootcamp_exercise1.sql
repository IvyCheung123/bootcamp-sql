CREATE DATABASE BOOTCAMP_EXERCISE1;

USE BOOTCAMP_EXERCISE1;

-- 1. 
CREATE TABLE REGIONS (
region_id INT PRIMARY KEY,
region_name VARCHAR(25) NOT NULL
);

CREATE TABLE COUNTRIES (
country_id CHAR(2) PRIMARY KEY,
country_name VARCHAR(40) NOT NULL,
region_id INT,
FOREIGN KEY (region_id) REFERENCES REGIONS(region_id)
);

CREATE TABLE LOCATIONS (
location_id INT PRIMARY KEY,
street_address VARCHAR(25) NOT NULL,
postal_code VARCHAR(12),
city VARCHAR(30) NOT NULL,
state_province VARCHAR(12),
country_id CHAR(2),
FOREIGN KEY (country_id) REFERENCES COUNTRIES(country_id)
);

CREATE TABLE DEPARTMENTS (
department_id INT PRIMARY KEY,
department_name VARCHAR(30) NOT NULL,
manager_id INT UNIQUE,
location_id INT,
FOREIGN KEY (location_id) REFERENCES LOCATIONS(location_id)
);

CREATE TABLE JOBS (
job_id VARCHAR(10) PRIMARY KEY,
job_title VARCHAR(35) NOT NULL,
min_salary NUMERIC(10,2),
max_salary NUMERIC(10,2)
);

CREATE TABLE EMPLOYEES (
employee_id INT PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(25) NOT NULL,
email VARCHAR(25),
phone_number VARCHAR(20),
hire_date DATE NOT NULL,
job_id VARCHAR(10),
salary NUMERIC(10,2),
commission_pct NUMERIC(6,2) DEFAULT 0.00 CHECK (commission_pct >= 0.00 AND commission_pct <= 100.00),
manager_id INT,
department_id INT,
FOREIGN KEY (job_id) REFERENCES JOBS (job_id),
-- FOREIGN KEY (manager_id) REFERENCES DEPARTMENTS (manager_id), -- 6. AND 10.
FOREIGN KEY (department_id) REFERENCES DEPARTMENTS (department_id)
);

CREATE TABLE JOB_HISTORY (
employee_id INT NOT NULL,
start_date DATE NOT NULL,
end_date DATE,
job_id VARCHAR(10),
department_id INT,
PRIMARY KEY (employee_id, start_date),
FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id),
FOREIGN KEY (job_id) REFERENCES JOBS(job_id),
FOREIGN KEY (department_id) REFERENCES DEPARTMENTS(department_id)
);

-- 2. 
INSERT INTO REGIONS VALUES (1, 'Europe');
INSERT INTO REGIONS VALUES (2, 'North America');
INSERT INTO REGIONS VALUES (3, 'Asia');

INSERT INTO COUNTRIES VALUES ('DE', 'Germany', 1);
INSERT INTO COUNTRIES VALUES ('IT', 'Italy', 1);
INSERT INTO COUNTRIES VALUES ('JP', 'Japan', 3);
INSERT INTO COUNTRIES VALUES ('US', 'United State', 2);

INSERT INTO LOCATIONS (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1000, '1297 Via Cola di Rie', 989, 'Roma', NULL, 'IT');
INSERT INTO LOCATIONS (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1100, '93091 Calle della Te', '10934', 'Venice', NULL, 'IT');
INSERT INTO LOCATIONS (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo', 'JP');
INSERT INTO LOCATIONS (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');

INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) VALUES (10, 'Administration', 200, 1100);
INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) VALUES (20, 'Marketing', 201, 1200);
INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) VALUES (30, 'Purchasing', 202, 1400);

INSERT INTO JOBS (job_id, job_title, min_salary, max_salary) VALUES ('ST_CLERK', 'Stock Clerk', 20000, 40000);
INSERT INTO JOBS (job_id, job_title, min_salary, max_salary) VALUES ('MK_REP', 'Marketing Representative', 9000, 20000);
INSERT INTO JOBS (job_id, job_title, min_salary, max_salary) VALUES ('IT_PROG', 'IT Programmer', 16000, 35000);

INSERT INTO EMPLOYEES (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (100, 'Steven', 'King', 'SKING', '515-1234567', '1987-06-17', 'ST_CLERK', 24000.00, 0.00, 109, 10);
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515-1234568', '1987-06-18', 'MK_REP', 17000.00, 0.00, 103, 20);
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (102, 'Lex', 'De Haan', 'LDEHAAN', '515-1234569', '1987-06-19', 'IT_PROG', 17000.00, 0.00, 108, 30);
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (103, 'Alexander', 'Hunold', 'AHUNOLD', '590-4234567', '1987-06-20', 'MK_REP', 9000.00, 0.00, 105, 20);

INSERT INTO JOB_HISTORY (employee_id, start_date, end_date, job_id, department_id) VALUES (102, '1993-01-13', '1998-07-24', 'IT_PROG', 20);
INSERT INTO JOB_HISTORY (employee_id, start_date, end_date, job_id, department_id) VALUES (101, '1989-09-21', '1993-10-27', 'MK_REP', 10);
INSERT INTO JOB_HISTORY (employee_id, start_date, end_date, job_id, department_id) VALUES (101, '1993-10-28', '1997-03-15', 'MK_REP', 30);
INSERT INTO JOB_HISTORY (employee_id, start_date, end_date, job_id, department_id) VALUES (100, '1996-02-17', '1999-12-19', 'ST_CLERK', 30);
INSERT INTO JOB_HISTORY (employee_id, start_date, end_date, job_id, department_id) VALUES (103, '1998-03-24', '1999-12-31', 'MK_REP', 20);

-- 3. 
SELECT l.location_id, l.street_address, l.city, l.state_province , c.country_name
FROM LOCATIONS l INNER JOIN COUNTRIES c ON l.country_id = c.country_id;

-- 4. 
SELECT e.first_name, e.last_name, e.department_id FROM EMPLOYEES e;

-- 5. 
SELECT e.first_name, e.last_name, e.job_id, e.department_id
FROM EMPLOYEES e
INNER JOIN DEPARTMENTS d ON e.department_id = d.department_id
INNER JOIN LOCATIONS l ON d.location_id = l.location_id
INNER JOIN COUNTRIES c ON l.country_id = c.country_id
WHERE country_name = 'Japan';

-- 6. Find employee_id, last_name along with their manager_id and last_name
SELECT e.employee_id, e.last_name AS employee_last_name, e.manager_id, m.last_name AS manager_last_name
FROM EMPLOYEES e INNER JOIN EMPLOYEES m ON e.manager_id = m.employee_id;

-- 7. 
SELECT e.first_name, e.last_name, e.hire_date
FROM EMPLOYEES e
WHERE e.hire_date > (
SELECT e.hire_date
FROM EMPLOYEES e
WHERE e.first_name = 'Lex' AND e.last_name LIKE 'De%Haan'
);

-- 8. 
SELECT d.department_name, count(1) AS number_of_employees
FROM DEPARTMENTS d INNER JOIN EMPLOYEES e ON d.department_id = e.department_id
GROUP BY d.department_id;

-- 9. 
SELECT jh.employee_id, j.job_title , DATEDIFF(jh.end_date, jh.start_date) AS number_of_days_between_end_date_and_start_date
FROM JOB_HISTORY jh INNER JOIN JOBS j ON jh.job_id = j.job_id
WHERE jh.department_id = 30;

-- 10. Display all department_name, manager_name, city, country_name
SELECT d.department_name, CONCAT(m.first_name, ' ', m.last_name) AS manager_name , l.city, c.country_name
FROM DEPARTMENTS d LEFT JOIN EMPLOYEES m ON d.manager_id = m.employee_id
INNER JOIN LOCATIONS l ON d.location_id = l.location_id
INNER JOIN COUNTRIES c ON l.country_id = c.country_id;

-- 11. avg salary of each dept
SELECT d.department_name, ROUND(AVG(e.salary),2) AS avg_salary_of_department
FROM EMPLOYEES e INNER JOIN DEPARTMENTS d ON e.department_id = d.department_id
GROUP BY d.department_id;

-- 12. Perform normalization on JOBS
CREATE TABLE JOB_GRADES (
grade_level VARCHAR(2) PRIMARY KEY,
lowest_sal NUMERIC(10,2) NOT NULL,
highest_sal NUMERIC(10,2) NOT NULL
);

-- ST_CLERK   24000     20000     40000     A
-- MK_REP     17000      9000     20000     C
-- IT_PROG    17000     16000     35000     B
-- MK_REP      9000      9000     20000     C

INSERT INTO JOB_GRADES VALUES ('A', 20000, 40000);
INSERT INTO JOB_GRADES VALUES ('B', 16000, 35000);
INSERT INTO JOB_GRADES VALUES ('C', 9000, 20000);

ALTER TABLE JOBS 
DROP COLUMN min_salary,
DROP COLUMN max_salary;

ALTER TABLE JOBS
ADD COLUMN grade_level VARCHAR(2);

ALTER TABLE JOBS
ADD CONSTRAINT fk_grade_level FOREIGN KEY (grade_level) REFERENCES JOB_GRADES(grade_level);

UPDATE JOBS 
SET grade_level = 'A'
WHERE job_id = 'ST_CLERK';

UPDATE JOBS 
SET grade_level = 'B'
WHERE job_id = 'IT_PROG';

UPDATE JOBS 
SET grade_level = 'C'
WHERE job_id = 'MK_REP';

SELECT j.job_id, j.job_title, jg.*
FROM JOBS j INNER JOIN JOB_GRADES jg ON j.grade_level = jg.grade_level;

-- Re-execute all SQL from 1. to 12.
-- SET FOREIGN_KEY_CHECKS = 0;

-- DROP TABLE JOB_GRADES;
-- DROP TABLE JOB_HISTORY;
-- DROP TABLE EMPLOYEES;
-- DROP TABLE JOBS;
-- DROP TABLE DEPARTMENTS;
-- DROP TABLE LOCATIONS;
-- DROP TABLE COUNTRIES;
-- DROP TABLE REGIONS;

-- SET FOREIGN_KEY_CHECKS = 1;
