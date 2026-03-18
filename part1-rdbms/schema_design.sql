-- =========================
-- SETTING UP DATBASE:-
-- =========================
CREATE DATABASE IF NOT EXISTS schema_design;
USE schema_design;

-- =========================
-- DROP TABLES (SAFE RESET TO REMOVE DUPLICATION):-
-- =========================
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS sales_reps;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- =========================
-- CUSTOMERS TABLE:-
-- =========================
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    customer_city VARCHAR(50)
);

INSERT INTO customers
SELECT DISTINCT
    customer_id,
    customer_name,
    customer_email,
    cutomer_city
FROM your_raw_table;

-- =========================
-- PRODUCTS TABLE:-
-- =========================
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100),
    unit_price DECIMAL(10,2)
);

INSERT INTO products
SELECT DISTINCT
    product_id,
    product_name,
    unit_price
FROM your_raw_table;

-- =========================
-- SALES REPRESENTATIVES:-
-- =========================
CREATE TABLE sales_reps (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100),
    sales_rep_email VARCHAR(100)
);

INSERT INTO sales_reps
SELECT DISTINCT
    sales_rep_id,
    sales_rep_name,
    sales_rep_email
FROM your_raw_table;

-- =========================
-- ORDERS TABLE:-
-- =========================
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    sales_rep_id VARCHAR(10),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);

INSERT INTO orders
SELECT DISTINCT
    order_id,
    customer_id,
    sales_rep_id,
    STR_TO_DATE(order_date, '%d-%m-%Y')
FROM your_raw_table;

-- =========================
-- ORDER DETAILS TABLE :-
-- =========================
CREATE TABLE order_details (
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_details
SELECT
    order_id,
    product_id,
    quantity
FROM your_raw_table;

-- =========================
-- TEST QUERIES:-
-- =========================

-- to View all tables I created
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM sales_reps;
SELECT * FROM orders;
SELECT * FROM order_details;
