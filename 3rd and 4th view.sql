select * from restaurants

select * from customer

select * from staff

select * from orders

--3rd view

SELECT 
    r.name AS restaurant_name,
    r.cuisine AS cuisines_offered,
    COUNT(o.id) AS total_orders,
    AVG(o.qty) AS avg_quantity,
    SUM(o.qty) AS total_quantity,
    s.stafftype AS staff_role,
    COUNT(s.id) AS staff_count
FROM 
    restaurants as r
LEFT JOIN 
    orders as o 
	ON r.id = o.restaurantid
LEFT JOIN 
    staff as s 
	ON r.id = s.restaurantid
WHERE 
    r.rating >= 4 -- Filter by restaurant rating
GROUP BY 
    r.name, r.cuisine, s.stafftype
HAVING 
    SUM(o.qty) > 10 -- Ensure restaurants have handled more than 10 orders
ORDER BY 
    total_orders DESC; -- Order by the number of orders, descending

CREATE VIEW restaurant_summary AS
SELECT 
    r.name AS restaurant_name,
    r.cuisine AS cuisines_offered,
    COUNT(o.id) AS total_orders,
    AVG(o.qty) AS avg_quantity,
    SUM(o.qty) AS total_quantity,
    s.stafftype AS staff_role,
    COUNT(s.id) AS staff_count
FROM 
    restaurants as r
LEFT JOIN 
    orders as o ON r.id = o.restaurantid
LEFT JOIN 
    staff as s ON r.id = s.restaurantid
WHERE 
    r.rating >= 4 -- Filter by restaurant rating
GROUP BY 
    r.name, r.cuisine, s.stafftype
HAVING 
    SUM(o.qty) > 10 -- Ensure restaurants have handled more than 10 orders
ORDER BY 
    total_orders DESC; -- Order by the number of orders, descending

--- 4th view

SELECT 
    c.name AS customer_name,
    c.contact AS customer_contact,
    r.name AS restaurant_name,
    r.cuisine AS cuisines_offered,
    COUNT(o.id) AS total_orders,
    SUM(o.qty) AS total_items_ordered
FROM 
    customer as c
LEFT JOIN 
    orders as o ON c.id = o.cust_id
LEFT JOIN 
    restaurants as r ON r.id = o.restaurantid
WHERE 
    c.address LIKE '%Nagpur%' -- Filter customers based in Nagpur
GROUP BY 
    c.name, c.contact, r.name, r.cuisine
HAVING 
    COUNT(o.id) > 2 -- Only include customers with more than 2 orders
ORDER BY 
    total_items_ordered DESC; -- Sort by total items ordered, descending


CREATE VIEW customer_order_summary AS
SELECT 
    c.name AS customer_name,
    c.contact AS customer_contact,
    r.name AS restaurant_name,
    r.cuisine AS cuisines_offered,
    COUNT(o.id) AS total_orders,
    SUM(o.qty) AS total_items_ordered
FROM 
    customer as c
LEFT JOIN 
    orders as o ON c.id = o.cust_id
LEFT JOIN 
    restaurants as r ON r.id = o.restaurantid
WHERE 
    c.address LIKE '%Nagpur%' -- Filter customers based in Nagpur
GROUP BY 
    c.name, c.contact, r.name, r.cuisine
HAVING 
    COUNT(o.id) > 2 -- Only include customers with more than 2 orders
ORDER BY 
    total_items_ordered DESC; -- Sort by total items ordered, descending

--join

SELECT 
*
FROM 
    restaurant_summary as rs
INNER JOIN 
    customer_order_summary as cos
ON 
    rs.restaurant_name = cos.restaurant_name
ORDER BY 
    rs.total_orders DESC, cos.total_items_ordered DESC;

