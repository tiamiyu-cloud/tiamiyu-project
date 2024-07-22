-- SQL PROJECT: DATABASE SYSTEM FOR A DITRIBUTION COMPANY

/* 
PROJECT OVERVIEW
-----------------

This project requires us to build a simple database to help 
manage the business of a Distribution Company. The imaginary 
company is located in two regions with five offices across 
both region. Each office has desinated Sales representative 
and headed by a mamanger. The Sales representative takes order 
on behalf of the customers and record on the orders tables. 

INSTRUCTIONS
----------------

The Database should contain the following tables
1) Offices
2) Sales representative
3) Customers
4) Products
5) Orders

TIME TO DESIGN THE DATABASE
*/ 

----------------------------------------------------------------------------------------------
-- DATABASE CREATION

-- DROP DATABASE IF EXISTS
DROP DATABASE IF EXISTS Distri_db;

-- CREATE A DATABASE FOR SPORT COMPLEX
CREATE DATABASE Distri_db;

-- TO BE SURE THE DATABASE WAS CREATED 
SHOW DATABASES;

-------------------------------------------------------------------------------------------------

-- TABLE CREATION
/* 
There would be five tables for the Dtabase:
1) Offices: This table contains information on the offices the company has.
2) Sales Representative: This table contains information of the sales representative and their sales performance.
3) Customers: The Customers table contains details of the customer. It contains 
		   information such as unique ID of the customers and their credit limit.
4) Products: This table contains information of all the products the company sells, prices and quantity on hand.  
5) Orders: This table contains records of orders taken by the Sales Representative on behalf of their customers. 

The next step is creating the tables for the database 
*/

-- TO MAKE IT THE ACTIVE DATABASE
USE Distri_db;

--  CREATE THE OFFICES TABLE

DROP TABLE IF EXISTS offices;
  CREATE TABLE offices (
  OFFICE int(11) NOT NULL,
  CITY varchar(30) NOT NULL,
  REGION varchar(50) NOT NULL,
  MGR int(11) DEFAULT NULL,
  TARGET decimal(18,2) DEFAULT NULL,
  SALES decimal(18,2) NOT NULL,
  PRIMARY KEY (OFFICE));
  
--  CREATE THE OFFICES TABLE

DROP TABLE IF EXISTS salesrep;
  CREATE TABLE salesrep (
  EMPL_ID int(11) NOT NULL,
  NAME varchar(30) NOT NULL,
  REP_OFFICE int(11) DEFAULT NULL,
  TITLE varchar(20) DEFAULT NULL,
  MANAGER int(11) DEFAULT NULL,
  QUOTA decimal(18,2) DEFAULT NULL,
  SALES decimal(18,2) NOT NULL,
  PRIMARY KEY (EMPL_ID),
  FOREIGN KEY (REP_OFFICE) REFERENCES offices (office) ON DELETE SET NULL);
  
--  CREATE THE CUSTOMERS TABLE
  
DROP TABLE IF EXISTS customers;
  CREATE TABLE customers (
  CUST_NUM int(11) NOT NULL,
  COMPANY varchar(50) NOT NULL,
  CUST_REP int(11) DEFAULT NULL,
  CREDIT_LIMIT decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (CUST_NUM),
  FOREIGN KEY (CUST_REP) REFERENCES salesrep (empl_id) ON DELETE SET NULL);
  
--  CREATE THE PRODUCTS TABLE
   
DROP TABLE IF EXISTS products;
  CREATE TABLE products (
  MFR_ID varchar(5) NOT NULL,
  PRODUCT_ID varchar(10) NOT NULL,
  DESCRIPTION varchar(50) NOT NULL,
  PRICE decimal(18,2) NOT NULL,
  QTY_ON_HAND int(11) NOT NULL,
  PRIMARY KEY (MFR_ID, PRODUCT_ID));
  
--  CREATE THE ORDERS TABLE
     
DROP TABLE IF EXISTS orders;
  CREATE TABLE orders (
  ORDER_NUM int(11) NOT NULL,
  ORDER_DATE date NOT NULL,
  CUSTOMER int(11) NOT NULL,
  REP int(11) DEFAULT NULL,
  MFR varchar(5) NOT NULL,
  PRODUCT_ID varchar(10) NOT NULL,
  QTY int(11) NOT NULL,
  AMOUNT decimal(18,2) NOT NULL,
  PRIMARY KEY (ORDER_NUM),
  FOREIGN KEY (CUSTOMER) REFERENCES customers (cust_num) ON DELETE CASCADE,
  FOREIGN KEY (REP) REFERENCES salesrep (empl_id) ON DELETE SET NULL);
  
-- FOREIGN KEY CONSTRAINTS IN THE TABLES EXPLAINED

-- SALSREP TABLE FOREIGN KEY: rep_office
/*
For the `rep_office` column as the foreign key, the rule that governs this is given below

THE RULE
When the record of the office table is deleted, the record in the salesrep table should 
be set to null

*/

-- CUSTOMERS TABLE FOREIGN KEY: cust_rep
/*
For the cust_rep column as the foreign key, the rule that governs this is given below

THE RULE
When the record of the salesrep tables is deleted, the record in the customers table
should be set to null

*/

-- ORDERS TABLE FOREIGN KEYS: customer and rep
/*
This table has two foreign keys, one on customers table and the other on salesrep 
tables

For the customer column as foreign key, the rule that governs this is given below

THE RULE
When the reord of the customers table is deleted, the record in the orders table
should also be deleted

When the record of the salesrep table is deleted, the record in the ordesr table
should set to null
*/

-- TO VERIFY IF ALL THE TABLES WERE CREATED 
SELECT * 
FROM information_schema.columns
WHERE TABLE_SCHEMA = "Distri_db";

-- To check if the tables were created and constraints are properly placed
DESCRIBE offices;
DESCRIBE salesrep;
DESCRIBE customers;
DESCRIBE products;
DESCRIBE ordres;

----------------------------------------------------------------------------------------------------

-- INSERTING DATA INTO THE TABLES
 /* 
 The tables are ready and the next step is to import values into them. 
 */  
 
 -- INSERTING DATA INTO THE OFFICES TABLE 
 INSERT INTO offices VALUES  (11,'New York','Eastern',106,575000.00,692637.00),
							 (12,'Chicago','Eastern',104,800000.00,735042.00),
                             (13,'Atlanta','Estern',105,350000.00,367922.00),
                             (21,'Los Angeles','Western',108,725000.00,835915.00),
                             (22,'Denver','Western',108,300000.00,186042.00);
                             
-- INSERTING DATA INTO THE SALESREP TABLE                             
INSERT INTO salesrep VALUES   (101,'Dan Roberts',12,'Sales rep',104,300000.00,305673.00),
							  (102,'Sue Smith',21,'Sales rep',108,350000.00,474050.00),
                              (103,'Paul Cruz',12,'Sales rep',104,275000.00,286775.00),
                              (104,'Bob Smith',12,'Sales Mgr',106,200000.00,142594.00),
                              (105,'Bill Adams',13,'Sales rep',104,350000.00,367911.00),
                              (106,'Sam Clark',11,'VP Sales',NULL,275000.00,299912.00),
                              (107,'Nancy Angelli',22,'Sales rep',108,300000.00,186042.00),
                              (108,'Larry Fitch',21,'Sales Mgr',106,350000.00,361865.00),
                              (109,'Mary Jones',11,'Sales rep',106,300000.00,392725.00),
                              (110,'Tom Snyder',NULL,'Sales rep',101,NULL,75985.00); 
                              
-- INSERTING DATA INTO THE CUSTOMERS TABLE 
INSERT INTO customers VALUES   (2101,'Jones Mfg.',106,65000.00),
							   (2102,'First Corp.',101,65000.00),
                               (2103,'Acme Mfg.',105,50000.00),
                               (2105,'AA Investments',101,45000.00),
                               (2106,'Fred Lewis Corp.',102,65000.00),
                               (2107,'Ace International',110,35000.00),
                               (2108,'Holm Landis',109,55000.00),
                               (2109,'Chen Associates',107,25000.00),
                               (2111,'JCP Inc.',103,50000.00),
                               (2112,'Zetacorp',108,50000.00),
                               (2113,'Ian & Schaidt',104,20000.00),
                               (2114,'Orion Corp.',102,20000.00),
                               (2115,'Smithson Corp.',101,20000.00),
                               (2117,'J.P. Sinclair',106,35000.00),
                               (2118,'Midwest Systems',108,60000.00),
                               (2119,'Solomon Inc.',109,25000.00),
                               (2120,'Rico Enterprises',102,50000.00),
                               (2121,'QMA Assoc',103,45000.00),
                               (2123,'Carter & Sons',102,40000.00),
                               (2124,'Peter Brothers',107,40000.00);
                               
-- INSERTING DATA INTO THE PRODUCTS TABLE                                
INSERT INTO products VALUES   ('ACI','41001','Size 1 widget',55.00,277),
							  ('ACI','41002','Size 2 widget',76.00,167),
                              ('ACI','41003','Size 3 widget',107.00,207),
                              ('ACI','41004','Size 4 widget',117.00,139),
                              ('ACI','4100X','Widget Adjuster',25.00,37),
                              ('ACI','4100Y','Widget Remover',2750.00,25),
                              ('ACI','4100Z','Widget Installer',2500.00,28),
                              ('BIC','41003','Handle',652.00,3),
                              ('BIC','41089','Retailer',225.00,78),
                              ('BIC','41672','Plate',180.00,0),
                              ('IKM','773C','300-lb Brace',975.00,28),
                              ('IKM','7756','500-lb Brace',1425.00,5),
                              ('IKM','779C','900-lb brace',1875.00,9),
                              ('IKM','887H','Brace Holder',54.00,223);
                              
-- INSERTING DATA INTO THE ORDERS TABLE                                
INSERT INTO orders VALUES   (112961,'2023-12-17',2117,106,'REI','2A44L',7,31500.00),
							(112963,'2024-01-14',2103,105,'ACI','41004',28,3276.00),
                            (112968,'2024-01-30',2102,101,'ACI','41004',34,3978.00),
                            (112975,'2024-02-15',2111,103,'REI','2A44G',6,2100.00),
                            (112979,'2024-01-22',2114,102,'ACI','4100Z',6,150.00),
                            (112983,'2024-01-20',2103,105,'ACI','41004',6,702.00),
                            (112987,'2024-02-18',2103,105,'ACI','4100Y',11,30250.00),
                            (112989,'2024-01-03',2101,106,'PEA','114',6,1458.00),
                            (112992,'2024-10-12',2118,105,'ACI','41002',10,760.00),
                            (112993,'2024-02-27',2106,102,'REI','2A45C',24,1896.00),
                            (113003,'2024-02-10',2108,109,'IKM','779C',3,5625.00),
                            (113007,'2024-03-02',2112,108,'IKM','773C',3,2925.00);
                            
-- TO BE SURE THE DATA WAS SUCCESSFULLY INSERTED INTO THE TABLES
SELECT * FROM offices;
SELECT * FROM salresrep;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

--------------------------------------------------------------------------------

-- CREATING VIEWS

/*
After the tables have been created and data inserted into each tables, we are ready to
create views.

The company wants a system where those from one region cannot see the sales performance 
of those from another region. This can only acheieved by creating view with the query 
that calculate the sales from the office tables and groupped it by region.
*/

DROP VIEW IF EXISTS western_route;
CREATE VIEW western_route AS (
SELECT region, SUM(sales) AS regional_sales
FROM offices
WHERE region = 'western'
);

DROP VIEW IF EXISTS eastern_route;
CREATE VIEW eastern_route AS (
SELECT region, SUM(sales) AS regional_sales
FROM offices
WHERE region = 'eastern'
);

-- To test if the view works
SELECT * FROM western_route;
SELECT * FROM eastern_route;

-------------------------------------------------------------------------------------

-- CREATING STORED PROCEDURES

-- STORED PROCEDURE 1: Stored Procedure to check quantity on hand before taking order

/*
This procedure would be used to check qty_on_hand of a product before taking new order 
into the orders table.
*/

-- To create the procedure
DROP PROCEDURE IF EXISTS check_before_order;
CREATE PROCEDURE check_before_order (
IN mfr VARCHAR(10),
IN product VARCHAR(10)
)
SELECT qty_on_hand INTO @qty_check
FROM products
WHERE mfr_id = mfr
AND product_id = product;
SELECT @qty_check AS qty_check;

-- To test the procedures
/*
Lets check the quantity on hand for product (ACI, 41001). Before that lets be sure of 
the actual quantity on hand of the products using the quary below.
*/

SELECT * FROM products;
-- Then we use the precedure to check
call check_before_order ('ACI', '41001');
select @qty_check as qty_check;

-- STORED PROCEDURE 2: Stored Procedure to insert new order

/*
This procedure would be used to insert new order into the orders table.
*/

-- To create the procedure
DROP PROCEDURE IF EXISTS take_orders;
create procedure take_orders (
IN o_number int,
IN o_date date,
IN o_customer int,
IN o_rep int,
IN o_mfr varchar(10),
IN o_product varchar(10),
IN o_quantity int,
IN o_amount decimal (10,2)
)
insert into orders (order_num, order_date, customer, rep, mfr, product_id, qty, amount)
values (o_number, o_date, o_customer, o_rep, o_mfr, o_product, o_quantity, o_amount);

-- To test the procedures
/*
This procedure would be used to take new orders. Before we run the procedure, lets be sure 
that the order to be taken is not already in the orders tables.
*/
SELECT * FROM orders;
-- Then we use the procedure
call take_orders (113070, '1990-02-02', 2109, 107, 'QSA', 'XK47', 1, 1500.00);
-- And then after that we check to see the effect of our procedure.
SELECT * FROM orders;

-- STORED PROCEDURE 3: Stored Procedure to check customer's credit limit
/*
This procedure would be used to check customer's credit limit before taking their orders.
Because customer are not allowed to take order above their credit limit.
*/

-- To create the procedure
DROP PROCEDURE IF EXISTS check_limit;
CREATE PROCEDURE check_limit (
IN customer_id INT
)
SELECT credit_limit - sum(amount) as credit_status
FROM orders
JOIN customers
ON cust_num = customer
WHERE customer = customer_id 
GROUP BY credit_limit INTO @credit;

-- To test the procedures
/*
this precedure is to check customer's credit limit, which means that customer is  not 
allowed to take order greater than their credit limit. This is calculated by subtracting 
the amount of their order from the credit limit. If the result is positive, they are 
qualified to take the order, else, they cannot take such order.
We will use customer number (2111) to check the procedure. Before then lets be sure of
our result by using the query below.
*/

SELECT credit_limit - sum(amount) as credit_status
FROM orders
JOIN customers
ON cust_num = customer
WHERE customer = 2111;

-- Then we go ahead to call our procedure and compare the results.
call check_limit (2111);
select @credit as credit;

---------------------------------------------------------------------------------------------------------------

-- SETTING UP TRIGGERS
-- TRIGGER 1: INITIATE UPDATE OF SALESREP TABLE WHEN NEW ORDER IS TAKEN

/*
Each time an order is taken in the orders table, salesrep table is updated. 
The sales column on the salesrep table will add the value of the order taken
to the record of the sales representative who took the order on behalf of the customer.
Updating Offices table after the Sales_rep is updated upon inserting in Orders table.
*/

-- SETTING UP THE TRIGGER

CREATE TRIGGER new_order
AFTER INSERT ON orders
FOR EACH ROW
UPDATE salesrep
SET sales = sales + new.amount
WHERE empl_id = new.rep;

-- TRIGGER 2: INITIATE UPDATE OF PRODUCTS TABLE WHEN NEW ORDER IS TAKEN

/*
Each time an order is taken in the orders table, products table is also updated. 
The qty_on_hand column on the products table reduces by the value of the order 
taken on the record of the product taken.
Updating Offices table after the Sales_rep is updated upon inserting in Orders table.
*/

CREATE TRIGGER new_order_2
AFTER INSERT ON orders
FOR EACH ROW
UPDATE products
SET qty_on_hand = qty_on_hand - new.qty
WHERE mfr_id = new.mfr
AND product_id = new.product_id;

-- TRIGGER 3: INITIATE UPDATE OF OFFICES TABLE WHEN NEW ORDER IS TAKEN

/*
After the salesrep and products table are updated upon taken an order, the offices 
table is also updated. The sales column on the offices table will add the value of 
the updated sales in the salesrep table on the record of office of the salesrep who 
took the order.
*/

CREATE TRIGGER update_office_sales
AFTER UPDATE
ON salesrep
FOR EACH ROW
UPDATE offices
SET sales = sales + new.sales
WHERE office = new.rep_office;

-- To test if it works. Lets take an order. We do this by calling our procedure to take order.

call take_orders (113070, '2024-02-02', 2109, 107, 'QSA', 'XK47', 1, 1500.00);

-- To check it.
SELECT * from salesrep;
SELECT * from products;
SELECT * from offices;

-- To reverse it all
ROLLBACK; 

----------------------------------------------------------------------------------------------------------

-- USER MANAGEMENT AND PRIVILEGES
/*
The next step is to create users, manage them and grant privileges to the users. User management 
plays a vital role in ensuring the security, integrity, and efficiency of a database system. 
They enforce access control, limiting database interactions to authorized individuals 
and preventing unauthorized access.

Admin: The user should be able to perform all activity on the database from creating, inserting, 
updating, querying, and deleting. The privilege is to be granted to President Sales who 
supervises the managers.

Manager: Should be able to check customer details on Customers table and insert on Orders table. 
They should also able to check the view. This privilege will be granted to Managers who supervising 
sales representatives.

Members: Should be able to check customer details on Customers table and insert on Orders table. 
This privilege will go to the sales representatives. For this user, a group will be created and 
the privilege granted to all Sales representative. This will reduce the stress or creating multiple 
users, which may also compromise security and integrity of a Database system.
*/

-- To create roles and users
/*  
For the admin, because the position of President Sales is already desgnated, we have to use
the actual person for it. To know who that is, we use the query below.
*/
SELECT * from salesrep;
-- The query returns Sam Clark as the designated person. So we will create and assign the role admin to the user.
CREATE ROLE distri_admin;
GRANT ALL PRIVILEGES ON distri_db TO distri_admin;
CREATE USER 'samclark'@'localhost' identified by '123admin';
GRANT distri_admin TO 'samclark'@'localhost';

/*
For the managers, we use the query below to identify who are designated managers.
In this case there are two regions, with different manager, so we will create two roles, 
one for each regions.
*/

SELECT * from salesrep;

-- ceate role to assign to the managers
CREATE ROLE western;
GRANT SELECT ON distri_db.western_route TO western; -- to be able to query the view
GRANT EXECUTE ON PROCEDURE check_limit TO western; 
GRANT EXECUTE ON PROCEDURE take_orders TO western; 
GRANT EXECUTE ON PROCEDURE check_before_order TO western; 

-- Now we create users, using the designated manager in the table and grant them the role
CREATE USER 'western_manager'@'localhost' identified by 'manager12345';
GRANT western TO 'western_manager'@'localhost';

--  For the other region.
CREATE ROLE eastern;
GRANT SELECT ON distri_db.eastern_route TO eastern; -- to be able to query the view
GRANT EXECUTE ON PROCEDURE check_limit TO eastern; 
GRANT EXECUTE ON PROCEDURE take_orders TO eastern; 
GRANT EXECUTE ON PROCEDURE check_before_order TO eastern; 
CREATE USER 'eastern_manager'@'localhost' identified by 'manager12345';
GRANT eastern TO 'eastern_manager'@'localhost';

/*
For the members, we grant similar privileges to that of the manager aside thay they 
cannot use the view.
*/

CREATE ROLE members;
GRANT EXECUTE ON PROCEDURE check_limit TO members; 
GRANT EXECUTE ON PROCEDURE take_orders TO members; 
GRANT EXECUTE ON PROCEDURE check_before_order TO members;
CREATE USER 'distri_member'@'localhost' identified by 'member12345';
GRANT eastern TO 'distri_member'@'localhost'; 

-- To be sure the privileges are accurately given
SHOW GRANTS FOR distri_admin;
SHOW GRANTS FOR western;
SHOW GRANTS FOR eastern;
SHOW GRANTS FOR members;

-- DATABASE BACKUP AND RECOVERY

/*
Database backup is crucial for data recovery and continuity, providing a safeguard against 
data loss due to accidental deletion, corruption, or system failures, ensuring the ability 
to restore databases to a previous state and minimizing downtime in the event of unexpected 
incidents.

We will be using mysqldump to take full logical backup and periodically flush logs in order 
to save server logs of specific period of time as decided my the management. This will enble 
us use Point-In-Time Recovery in case 
of data loss.

Point in time recovery (PITR) is a data recovery process to restore database to a specific 
point in time before the event that led to the data loss. This process uses full (logical backup) 
and transaction logs collected by the server. 
*/






