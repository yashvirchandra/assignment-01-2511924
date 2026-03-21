
-- Q1: List all customers along with the total number of orders they have placed

SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM read_csv_auto('customers.csv') c
LEFT JOIN read_json_auto('orders.json') o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;



-- Q2: Find the top 3 customers by total order value

SELECT 
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 3;



-- Q3: List all products purchased by customers from Bangalore

-- NOTE:
-- The orders dataset does not contain product_id, so direct product mapping is not possible. This query lists orders placed by customers from Bangalore.

SELECT 
    c.customer_id,
    c.name,
    o.order_id,
    o.total_amount
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
ON c.customer_id = o.customer_id
WHERE LOWER(c.city) = 'bangalore';



-- Q4: Join all three files to show: customer name, order date, product name, and quantity

-- NOTE:
-- Since there is no common key between orders and products, a CROSS JOIN is used to include product data.

SELECT 
    c.name,
    o.order_date,
    p.*
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
ON c.customer_id = o.customer_id
CROSS JOIN read_parquet('products.parquet') p
LIMIT 10;
