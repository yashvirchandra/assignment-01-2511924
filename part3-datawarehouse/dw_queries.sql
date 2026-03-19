
-- q1: total sales revenue by product category for each month
select
    d.month,
    p.category,
    sum(f.total_sales) as total_revenue
from fact_sales f
join dim_product p
    on f.product_id = p.product_id
join dim_date d
    on f.date_id = d.date_id
group by
    d.month,
    p.category
order by
    d.month,
    total_revenue desc;

--------------------------------------------------

-- q2: top 2 performing stores by total revenue
select
    s.store_name,
    sum(f.total_sales) as total_revenue
from fact_sales f
join dim_store s
    on f.store_id = s.store_id
group by
    s.store_name
order by
    total_revenue desc
limit 2;

--------------------------------------------------

-- q3: month-over-month sales trend across all stores
select
    d.year,
    d.month,
    sum(f.total_sales) as total_revenue
from fact_sales f
join dim_date d
    on f.date_id = d.date_id
group by
    d.year,
    d.month
order by
    d.year,
    d.month;
