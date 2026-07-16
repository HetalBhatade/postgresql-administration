PostgreSQL DBA Lab - Complete Setup Guide

==================================================================================================================
1. Create Database
==================================================================================================================
Creates a new database for the PostgreSQL DBA lab.

CREATE DATABASE companydb;

==================================================================================================================
2. Connect Database
==================================================================================================================
Connects the psql session to the new database.

\c companydb

==================================================================================================================
3. Create Schema
==================================================================================================================
Creates a separate schema to organize application objects.

CREATE SCHEMA company;

==================================================================================================================
4. Create Tables
==================================================================================================================
Creates all business and audit tables.

CREATE TABLE company.departments (
 dept_id SERIAL PRIMARY KEY,
 dept_name VARCHAR(50) NOT NULL,
 location VARCHAR(50));

CREATE TABLE company.employees (
 emp_id SERIAL PRIMARY KEY,
 first_name VARCHAR(50),
 last_name VARCHAR(50),
 email VARCHAR(100) UNIQUE,
 phone VARCHAR(20),
 hire_date DATE,
 salary NUMERIC(10,2),
 dept_id INT REFERENCES company.departments(dept_id),
 status VARCHAR(20) DEFAULT 'ACTIVE');

CREATE TABLE company.customers(
 customer_id SERIAL PRIMARY KEY,
 customer_name VARCHAR(100),
 city VARCHAR(50),
 state VARCHAR(50),
 email VARCHAR(100));

CREATE TABLE company.products(
 product_id SERIAL PRIMARY KEY,
 product_name VARCHAR(100),
 category VARCHAR(50),
 price NUMERIC(10,2),
 stock INT);

CREATE TABLE company.orders(
 order_id SERIAL PRIMARY KEY,
 customer_id INT REFERENCES company.customers(customer_id),
 order_date DATE,
 total_amount NUMERIC(12,2));

CREATE TABLE company.order_items(
 item_id SERIAL PRIMARY KEY,
 order_id INT REFERENCES company.orders(order_id),
 product_id INT REFERENCES company.products(product_id),
 quantity INT,
 unit_price NUMERIC(10,2));

CREATE TABLE company.payments(
 payment_id SERIAL PRIMARY KEY,
 order_id INT REFERENCES company.orders(order_id),
 payment_date DATE,
 amount NUMERIC(12,2),
 payment_mode VARCHAR(20));

CREATE TABLE company.audit_log(
 log_id SERIAL PRIMARY KEY,
 table_name TEXT,
 operation TEXT,
 changed_by TEXT,
 changed_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

==================================================================================================================
5. Create Indexes
==================================================================================================================
Improves query performance.

CREATE INDEX idx_emp_dept ON company.employees(dept_id);
CREATE INDEX idx_emp_salary ON company.employees(salary);
CREATE INDEX idx_orders_customer ON company.orders(customer_id);
CREATE INDEX idx_products_category ON company.products(category);
CREATE INDEX idx_orderitems_product ON company.order_items(product_id);

==================================================================================================================
6. Create View
==================================================================================================================
Creates reusable employee/department view.

CREATE VIEW company.employee_department AS
SELECT e.emp_id,e.first_name,e.last_name,d.dept_name,e.salary
FROM company.employees e
JOIN company.departments d ON e.dept_id=d.dept_id;

==================================================================================================================
7. Create Function
==================================================================================================================
Returns employee count.

CREATE OR REPLACE FUNCTION company.get_employee_count()
RETURNS INTEGER LANGUAGE plpgsql AS $$
BEGIN
 RETURN (SELECT COUNT(*) FROM company.employees);
END; $$;

==================================================================================================================
8. Create Trigger Function
==================================================================================================================
Logs DML operations into audit table.

CREATE OR REPLACE FUNCTION company.audit_employee()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
 INSERT INTO company.audit_log(table_name,operation,changed_by)
 VALUES('employees',TG_OP,current_user);
 RETURN NEW;
END; $$;

==================================================================================================================
9. Create Trigger
==================================================================================================================
Calls trigger function after INSERT/UPDATE/DELETE.

CREATE TRIGGER trg_employee_audit
AFTER INSERT OR UPDATE OR DELETE
ON company.employees
FOR EACH ROW
EXECUTE FUNCTION company.audit_employee();

==================================================================================================================
10. Insert Departments
==================================================================================================================
Load master data.

INSERT INTO company.departments(dept_name,location) VALUES
('HR','Mumbai'),('IT','Pune'),('Finance','Delhi'),('Sales','Bangalore'),('Marketing','Hyderabad');

==================================================================================================================
11. Insert Employees
==================================================================================================================
Generate 100000 employees.

INSERT INTO company.employees(first_name,last_name,email,phone,hire_date,salary,dept_id)
SELECT 'Emp'||g,'Last'||g,'emp'||g||'@company.com','9999999999',
CURRENT_DATE-(random()*3000)::int,
(random()*100000)::numeric(10,2),
(SELECT dept_id FROM company.departments ORDER BY random() LIMIT 1)
FROM generate_series(1,100000) g;

==================================================================================================================
12. Insert Customers
==================================================================================================================
Generate 50000 customers.

INSERT INTO company.customers(customer_name,city,state,email)
SELECT 'Customer'||g,'City'||(g%20),'State'||(g%5),'customer'||g||'@gmail.com'
FROM generate_series(1,50000) g;

==================================================================================================================
13. Insert Products
==================================================================================================================
Generate 10000 products.

INSERT INTO company.products(product_name,category,price,stock)
SELECT 'Product'||g,'Category'||(g%10),(random()*1000)::numeric(10,2),(random()*500)::int
FROM generate_series(1,10000) g;

==================================================================================================================
14. Verification
==================================================================================================================
Verify row counts.
SELECT COUNT(*) FROM company.employees;