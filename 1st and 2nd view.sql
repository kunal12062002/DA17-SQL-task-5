select * from sales 

select * from customer 

select * from product

---1st view

SELECT 
    cust.cust_id,
    cust.cust_name,
    cust.region,
    SUM(sales.sales * sales.qty) AS total_sales,
    AVG(sales.discount) AS avg_discount,
    COUNT(sales.order_id) AS total_orders
FROM 
    customer AS cust
JOIN 
    sales AS sales
ON 
    cust.cust_id = sales.cust_id
WHERE 
    cust.age >= 40
GROUP BY 
    cust.cust_id, cust.cust_name, cust.region
HAVING 
    SUM(sales.profit) > 1000
ORDER BY 
    total_sales asc;

create view cust_id_name_revenue as SELECT 
    cust.cust_id,
    cust.cust_name,
    cust.region,
    SUM(sales.sales * sales.qty) AS total_sales,
    AVG(sales.discount) AS avg_discount,
    COUNT(sales.order_id) AS total_orders
FROM 
    customer AS cust
JOIN 
    sales AS sales
ON 
    cust.cust_id = sales.cust_id
WHERE 
    cust.age >= 40
GROUP BY 
    cust.cust_id, cust.cust_name, cust.region
HAVING 
    SUM(sales.profit) > 1000
ORDER BY 
    total_sales asc;

---2nd view

SELECT 
    c.cust_id,
    c.cust_name,
    c.region,
    p.category,
    SUM(s.qty * s.profit) AS total_sales,
    AVG(s.discount) AS avg_discount,
    COUNT(DISTINCT s.order_id) AS unique_orders,
    MAX(s.order_date) AS most_recent_purchase
FROM 
    customer AS c
JOIN 
    sales AS s 
ON 
    c.cust_id = s.cust_id
JOIN 
    product AS p 
ON 
    s.product_id = p.product_id
WHERE 
    c.age >= 40
  AND 
    p.category IS NOT NULL
GROUP BY 
    c.cust_id, c.cust_name, c.region, p.category
HAVING 
    AVG(s.discount) < 10
ORDER BY 
    unique_orders ASC, total_sales asc ;

create view Region_wise_Product as SELECT 
    c.cust_id,
    c.cust_name,
    c.region,
    p.category,
    SUM(s.qty * s.profit) AS total_sales,
    AVG(s.discount) AS avg_discount,
    COUNT(DISTINCT s.order_id) AS unique_orders,
    MAX(s.order_date) AS most_recent_purchase
FROM 
    customer AS c
JOIN 
    sales AS s 
ON 
    c.cust_id = s.cust_id
JOIN 
    product AS p 
ON 
    s.product_id = p.product_id
WHERE 
    c.age >= 40
  AND 
    p.category IS NOT NULL
GROUP BY 
    c.cust_id, c.cust_name, c.region, p.category
HAVING 
    AVG(s.discount) < 10
ORDER BY 
    unique_orders ASC, total_sales asc ;

select * from Region_wise_Product

select * from cust_id_name_revenue

select c.cust_name,c.cust_name,r.category,r.total_sales from cust_id_name_revenue as c
join region_wise_product as r
on c.cust_id = r.cust_id

SELECT * FROM Region_wise_Product AS r
JOIN cust_id_name_revenue AS c
ON r.cust_id = c.cust_id
WHERE 
    r.region = c.region
ORDER BY 
    r.region ASC, r.total_sales DESC;

---insert, delete and update	

INSERT INTO sales (id,order_id, order_date, ship_date, cust_id, product_id, sales, qty, discount, profit, ship_mode) 
VALUES (10001,'CA-2016-152156', '2016-11-08', '2016-11-11', 'CG-12520', 'FUR-BO-10001798', 261.96, 10, 5, -100.9136, 'Third class');

INSERT INTO sales (id,order_id, order_date, ship_date, cust_id, product_id, sales, qty, discount, profit, ship_mode) 
VALUES (10002,'CA-2016-152156', '2016-11-08', '2016-11-11', 'PW-19240', 'FUR-BO-10001798', 261.96, 10, 5, -100.9136, 'Third class');

select * from sales where sales.cust_id = 'PW-19240'

select * from cust_id_name_revenue

delete 	from sales 
where id = '10002'

select * from product where product_id = 'FUR-BO-10001798'

UPDATE product
SET 
    product_name = 'Office Chair',
    category = 'khurchi',
    sub_category = 'Chairs'
where product_id = 'FUR-BO-10001798';
