CREATE DATABASE BOOTCAMP_EXERCISE3;

USE BOOTCAMP_EXERCISE3;

-- Question 1a
CREATE TABLE city ( -- TABLE city ...
id INT PRIMARY KEY,
city_name VARCHAR(50) NOT NULL
);

CREATE TABLE customer (
id INT PRIMARY KEY,
customer_name VARCHAR(255) NOT NULL,
city_id INT NOT NULL,
customer_address VARCHAR(255) NOT NULL,
contact_person VARCHAR(255),
email VARCHAR(128) NOT NULL,
phone VARCHAR(128) NOT NULL,
FOREIGN KEY (city_id) REFERENCES city(id)  -- TABLE city ...
);

CREATE TABLE product (
id INT PRIMARY KEY,
sku VARCHAR(32) NOT NULL,
product_name VARCHAR(128) NOT NULL,
product_description TEXT NOT NULL,
current_price DECIMAL(8,2) NOT NULL,
quantity_in_stock INT NOT NULL
);

CREATE TABLE invoice (
id INT PRIMARY KEY,
invoice_number VARCHAR(255) NOT NULL,
customer_id INT NOT NULL,
user_account_id INT NOT NULL,
total_price DECIMAL(8,2) NOT NULL,
time_issued DATETIME,
time_due DATETIME,
time_paid DATETIME,
time_canceled DATETIME,
time_refunded DATETIME,
FOREIGN KEY (customer_id) REFERENCES customer(id)
);

CREATE TABLE invoice_item (
id INT PRIMARY KEY,
invoice_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
price DECIMAL(8,2) NOT NULL,
line_total_price DECIMAL(8,2) NOT NULL,
FOREIGN KEY (invoice_id) REFERENCES invoice(id),
FOREIGN KEY (product_id) REFERENCES product(id)
);

-- Question 1b
INSERT INTO city (id, city_name) VALUES
(1, 'Vienna'),
(2, 'Berlin'),
(3, 'Hamburg'),
(4, 'London');

INSERT INTO customer (id, customer_name, city_id, customer_address, contact_person, email, phone) VALUES
(1, 'Drogerie Wien', 1, 'Deckergasse 15A', 'Emil Steinbach', 'emil@drogeriewien.com', '094234234'),
(2, 'Cosmetics Store', 4, 'Watling Street 347', 'Jeremy Corbyn', 'jeremy@c-store.org', '093923923'),
(3, 'Kosmetikstudio', 3, 'Rothenbaumchaussee 53', 'Willy Brandt', 'willy@kosmetiktstudio.com', '0941562222'),
(4, 'Neue Kosmetik', 1, 'Karlsplatz 2', NULL, 'info@neuekosmetik.com', '094109253'),
(5, 'Bio Kosmetik', 2, 'Motzstraße 23', 'Clara Zetkin', 'clara@biokosmetik.org', '093825825'),
(6, 'K-Wien', 1, 'Kärntner Straße 204', 'Maria Rauch-Kallat', 'maria@kwien.org', '093427002'),
(7, 'Natural Cosmetics', 4, 'Clerkenwell Road 14B', 'Glenda Jackson', 'glena.j@natural-cosmetics.com', '093555123'),
(8, 'Kosmetik Plus', 2, 'Unter den Linden 1', 'Angela Merkel', 'angela@k-plus.com', '094727727'),
(9, 'New Line Cosmetics', 4, 'Devonshire Street 92', 'Oliver Cromwell', 'oliver@nlc.org', '093202404');

INSERT INTO product (id, sku, product_name, product_description, current_price, quantity_in_stock) VALUES
(1, '330120', 'Game Of Thrones - URBAN DECAY', 'Game Of Thrones Eyeshadow Palette', 65, 122),
(2, '330121', 'Advanced Night Repair - ESTEE LAUDER', 'Advanced Night Repair Synchronized Recovery Complex II', 98, 51),
(3, '330122', 'Rose Deep Hydration - FRESH', 'Rose Deep Hydration Facial Toner', 45, 34),
(4, '330123', 'Pore-Perfecting Moisturizer - TATCHA', 'Pore-Perfecting Moisturizer & Cleanser Duo', 25, 393),
(5, '330124', 'Capture Youth - DIOR', 'Capture Youth Serum Collection', 95, 74),
(6, '330125', 'Slice of Glow - GLOW RECIPE', 'Slice of Glow Set', 45, 40),
(7, '330126', 'Healthy Skin - KIEHL S SINCE 1851', 'Healthy Skin Squad', 68, 154),
(8, '330127', 'Power Pair! - IT COSMETICS', 'IT is Your Skincare Power Pair! Best-Selling Moisturizer & Eye Cream Duo', 80, 0),
(9, '330128', 'Dewy Skin Mist - TATCHA', 'Limited Edition Dewy Skin Mist Mini', 20, 281),
(10, '330129', 'Silk Pillowcase - SLIP', 'Silk Pillowcase Duo + Scrunchies Kit', 170, 0);

INSERT INTO invoice (id, invoice_number, customer_id, user_account_id, total_price, time_issued, time_due, time_paid, time_canceled, time_refunded) VALUES
(1, 'in_25181b07ba800c8d2fc967fe991807d9', 7, 4, 1436, STR_TO_DATE('7/20/2019 3:05:07 PM', '%m/%d/%Y %h:%i:%s %p'), STR_TO_DATE('7/27/2019 3:05:07 PM', '%m/%d/%Y %h:%i:%s %p'), STR_TO_DATE('7/25/2019 9:24:12 AM', '%m/%d/%Y %h:%i:%s %p'), NULL, NULL),
(2, '8fba0000fd456b27502b9f81e9d52481', 9, 2, 1000, STR_TO_DATE('7/20/2019 3:07:11 PM', '%m/%d/%Y %h:%i:%s %p'), STR_TO_DATE('7/27/2019 3:07:11 PM', '%m/%d/%Y %h:%i:%s %p'), STR_TO_DATE('7/20/2019 3:10:32 PM', '%m/%d/%Y %h:%i:%s %p'), NULL, NULL),
(3, '3b6638118246b6bcfd3dfcd9be487599', 3, 2, 360, STR_TO_DATE('7/20/2019 3:06:15 PM', '%m/%d/%Y %h:%i:%s %p'), STR_TO_DATE('7/27/2019 3:06:15 PM', '%m/%d/%Y %h:%i:%s %p'), STR_TO_DATE('7/31/2019 9:22:11 PM', '%m/%d/%Y %h:%i:%s %p'), NULL, NULL),
(4, 'dfe7f0a01a682196cac0120a9adbb550', 5, 2, 1675, STR_TO_DATE('7/20/2019 3:06:34 PM', '%m/%d/%Y %h:%i:%s %p'), STR_TO_DATE('7/27/2019 3:06:34 PM', '%m/%d/%Y %h:%i:%s %p'), NULL, NULL, NULL),
(5, '2a24cc2ad4440d698878a0a1a71f70fa', 6, 2, 9500, STR_TO_DATE('7/20/2019 3:06:42 PM', '%m/%d/%Y %h:%i:%s %p'), STR_TO_DATE('7/27/2019 3:06:42 PM', '%m/%d/%Y %h:%i:%s %p'), NULL, STR_TO_DATE('7/22/2019 11:17:02 AM', '%m/%d/%Y %h:%i:%s %p'), NULL),
(6, 'cbd304872ca6257716bcab8fc43204d7', 4, 2, 150, STR_TO_DATE('7/20/2019 3:08:15 PM', '%m/%d/%Y %h:%i:%s %p'), STR_TO_DATE('7/27/2019 3:08:15 PM', '%m/%d/%Y %h:%i:%s %p'), STR_TO_DATE('7/27/2019 1:42:45 PM', '%m/%d/%Y %h:%i:%s %p'), NULL, STR_TO_DATE('7/27/2019 2:11:20 PM', '%m/%d/%Y %h:%i:%s %p'));

INSERT INTO invoice_item (id, invoice_id, product_id, quantity, price, line_total_price) VALUES
(1, 1, 1, 20, 65, 1300),
(2, 1, 7, 2, 68, 136),
(3, 1, 5, 10, 100, 1000),
(4, 3, 10, 2, 180, 360),
(5, 4, 1, 5, 65, 325),
(6, 4, 2, 10, 95, 950),
(7, 4, 5, 4, 100, 400),
(8, 5, 10, 100, 95, 9500),
(9, 6, 4, 6, 25, 150);

SELECT * FROM customer;
SELECT * FROM product;
SELECT * FROM invoice;
SELECT * FROM invoice_item;

-- Question 1c
SELECT 'customer' AS string, c.id AS id, c.customer_name AS name
FROM customer c
LEFT JOIN invoice i
ON c.id = i.customer_id
WHERE i.customer_id IS NULL
UNION
SELECT 'product' AS string, p.id AS id, p.product_name AS name
FROM product p
LEFT JOIN invoice_item ii
ON p.id = ii.product_id
WHERE ii.product_id IS NULL;

-- Question 2
CREATE TABLE EMPLOYEE (
ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
EMPLOYEE_NAME VARCHAR(30) NOT NULL,
SALARY NUMERIC(8,2),
PHONE NUMERIC(15),
EMAIL VARCHAR(50),
DEPT_ID INTEGER NOT NULL
);

CREATE TABLE DEPARTMENT (
ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
DEPT_CODE VARCHAR(3) NOT NULL,
DEPT_NAME VARCHAR(200) NOT NULL
);

-- Question 2a
INSERT INTO EMPLOYEE (ID, EMPLOYEE_NAME, SALARY, PHONE, EMAIL, DEPT_ID) VALUES
(1, 'JOHN', 20000, 90234567, 'JOHN@GMAIL.COM', 1),
(2, 'MARY', 10000, 90234561, 'MARY@GMAIL.COM', 1),
(3, 'STEVE', 30000, 90234562, 'STEVE@GMAIL.COM', 3),
(4, 'SUNNY', 40000, 90234563, 'SUNNY@GMAIL.COM', 4);

INSERT INTO DEPARTMENT (ID, DEPT_CODE, DEPT_NAME) VALUES
(1, 'HR', 'HUMAN RESOURCES'),
(2, '9UP', '9UP DEPARTMENT'),
(3, 'SA', 'SALES DEPARTMENT'),
(4, 'IT', 'INFORMATION TECHNOLOGY DEPARTMENT');

SELECT D.DEPT_CODE, COUNT(E.ID)
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E
ON D.ID = E.DEPT_ID
GROUP BY D.ID
ORDER BY COUNT(E.ID) DESC, D.DEPT_CODE ASC;

-- 'HR','2'
-- 'IT','1'
-- 'SA','1'
-- '9UP','0'

-- Question 2b
DELETE FROM DEPARTMENT WHERE ID = 5;
INSERT INTO DEPARTMENT VALUES (5, 'IT', 'INFORMATION TECHNOLOGY DEPARTMENT');

-- 'HR','2'
-- 'IT','1'
-- 'SA','1'
-- '9UP','0'
-- 'IT','0'
