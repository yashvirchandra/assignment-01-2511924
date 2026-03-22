-- =========================
-- SETTING UP DATBASE:-
-- =========================
create database if not exists schema_design;
use schema_design;

-- =========================
-- DROP TABLES (SAFE RESET TO REMOVE DUPLICATION):-
-- =========================
drop table if exists order_details;
drop table if exists orders;
drop table if exists sales_reps;
drop table if exists products;
drop table if exists customers;

-- =========================
-- CUSTOMERS TABLE:-
-- =========================
create table customers (
    customer_id varchar(10) primary key,
    customer_name varchar(100),
    customer_email varchar(100),
    customer_city varchar(50)
);

insert into customers
select distinct
    customer_id,
    customer_name,
    customer_email,
    customer_city
from your_raw_table;

-- =========================
-- PRODUCTS TABLE:-
-- =========================
create table products (
    product_id varchar(10) primary key,
    product_name varchar(100),
    unit_price decimal(10,2)
);

insert into products
select distinct
    product_id,
    product_name,
    unit_price
from your_raw_table;

-- =========================
-- SALES REPRESENTATIVES:-
-- =========================
create table sales_reps (
    sales_rep_id varchar(10) primary key,
    sales_rep_name varchar(100),
    sales_rep_email varchar(100)
);

insert into sales_reps
select distinct
    sales_rep_id,
    sales_rep_name,
    sales_rep_email
from your_raw_table;

-- =========================
-- ORDERS TABLE:-
-- =========================
create table orders (
    order_id varchar(10) primary key,
    customer_id varchar(10),
    sales_rep_id varchar(10),
    order_date date,
    foreign key (customer_id) references customers(customer_id),
    foreign key (sales_rep_id) references sales_reps(sales_rep_id)
);

insert into orders
select distinct
    order_id,
    customer_id,
    sales_rep_id,
    str_to_date(order_date, '%d-%m-%Y')
from your_raw_table;

-- =========================
-- ORDER DETAILS TABLE :-
-- =========================
create table order_details (
    order_id varchar(10),
    product_id varchar(10),
    quantity int,
    primary key (order_id, product_id),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

insert into order_details
select
    order_id,
    product_id,
    quantity
from your_raw_table;

-- =========================
-- TEST QUERIES:-
-- =========================

-- to View all tables I created
select * from customers;
select * from products;
select * from sales_reps;
select * from orders;
select * from order_details;
