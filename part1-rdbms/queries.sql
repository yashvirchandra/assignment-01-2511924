-- Q1.3. SQL QUERIES :-
-- =========================
-- Q1: List all customers from Mumbai along with their total order value.
-- =========================
select 
    c.customer_name,
    sum(od.quantity * p.unit_price) as total_spent
from customers c
join orders o 
    on c.customer_id = o.customer_id
join order_details od 
    on o.order_id = od.order_id
join products p 
    on od.product_id = p.product_id
where c.customer_city = 'Mumbai'
group by c.customer_name;


-- =========================
-- Q2: Find the top 3 products by total quantity sold.
-- =========================
select 
    p.product_name,
    sum(od.quantity) as total_sold
from products p
join order_details od 
    on p.product_id = od.product_id
group by p.product_name
order by total_sold desc
limit 3;

-- =========================
-- Q3: List all sales representatives and the number of unique customers they have handled.
-- =========================
select 
    sr.sales_rep_name,
    count(distinct o.customer_id) as total_customers
from sales_reps sr
join orders o 
    on sr.sales_rep_id = o.sales_rep_id
group by sr.sales_rep_name;

-- =========================
-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending.
-- =========================
select 
    o.order_id,
    sum(od.quantity * p.unit_price) as total_value
from orders o
join order_details od 
    on o.order_id = od.order_id
join products p 
    on od.product_id = p.product_id
group by o.order_id
having total_value > 10000
order by total_value desc;;


-- =========================
-- Q5: Identify any products that have never been ordered.
-- =========================
select 
    p.product_name
from products p
left join order_details od 
    on p.product_id = od.product_id
where od.product_id is null;
