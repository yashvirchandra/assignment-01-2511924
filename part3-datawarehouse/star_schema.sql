-- create database
create database retail_dw; 
-- using database
use retail_dw;

-- drop tables if exist
drop table if exists fact_sales;
drop table if exists dim_store;
drop table if exists dim_product;
drop table if exists dim_date;

------------------------------------------------

-- create dim_date
create table dim_date (
    date_id date primary key,
    day int,
    month int,
    year int
);

insert into dim_date (date_id, day, month, year)
select distinct
    transaction_date,
    day(transaction_date),
    month(transaction_date),
    year(transaction_date)
from clean_transactions;

-------------------------------------------------

-- create dim_store
create table dim_store (
    store_id int auto_increment primary key,
    store_name varchar(100),
    store_city varchar(100)
);

insert into dim_store (store_name, store_city)
select distinct
    store_name,
    store_city
from clean_transactions;

----------------------------------------------

-- create dim_product
create table dim_product (
    product_id int auto_increment primary key,
    product_name varchar(100),
    category varchar(50)
);

-- FIX: standardize category values properly
insert into dim_product (product_name, category)
select distinct
    product_name,
    case
        when lower(trim(category)) in ('grocery', 'groceries') then 'GROCERIES'
        else upper(trim(category))
    end
from clean_transactions;

-----------------------------------------------

-- create fact_sales
create table fact_sales (
    transaction_id varchar(50),
    date_id date,
    store_id int,
    product_id int,
    units_sold int,
    unit_price decimal(10,2),
    total_sales decimal(10,2)
);

insert into fact_sales (
    transaction_id,
    date_id,
    store_id,
    product_id,
    units_sold,
    unit_price,
    total_sales
)
select
    t.transaction_id,
    t.transaction_date,
    s.store_id,
    p.product_id,
    t.units_sold,
    t.unit_price,
    (t.units_sold * t.unit_price)
from clean_transactions t
join dim_store s
    on t.store_name = s.store_name
join dim_product p
    on t.product_name = p.product_name;

-----------------------------------------------------

-- add foreign keys
alter table fact_sales
add foreign key (date_id) references dim_date(date_id),
add foreign key (store_id) references dim_store(store_id),
add foreign key (product_id) references dim_product(product_id);
