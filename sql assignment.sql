CREATE DATABASE bi_assignment;
USE bi_assignment;

CREATE TABLE customers (
    customer_id VARCHAR(10),
    customer_name VARCHAR(100),
    customer_segment VARCHAR(20),
    acquisition_channel VARCHAR(50),
    registration_date DATE,
    is_loyalty_member VARCHAR(25)
);
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    customer_id VARCHAR(10),
    city VARCHAR(100),
    state VARCHAR(100),
    category VARCHAR(100),
    product_name VARCHAR(100),
    quantity INT,
    channel_name VARCHAR(50),
    MRP INT
);
CREATE TABLE product_catalog (
    category VARCHAR(100),
    product_name VARCHAR(100),
    brand VARCHAR(100),
    mrp INT,
    cost_price DECIMAL(10,2),
    shelf_life_days INT,
    is_hero_product VARCHAR(25)
);

CREATE TABLE product_pricing (
    product_name VARCHAR(100),
    channel VARCHAR(50),
    discount_pct INT
);

--QS1
SELECT c.customer_segment,
    COUNT(o.order_id) AS total_orders,
    AVG(o.MRP) AS avg_MRP
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY total_orders DESC;

 --QS2
 
 SELECT
    o.product_name,
    SUM(
        o.MRP * o.quantity *
        (1 - pp.discount_pct / 100.0)
    ) AS total_revenue
FROM orders o
JOIN product_pricing pp
    ON o.product_name = pp.product_name
   AND o.channel_name = pp.channel
GROUP BY o.product_name;

--QS3

SELECT
    o.channel_name,
    AVG(pp.discount_pct) AS avg_discount
FROM orders o
JOIN product_pricing pp
    ON o.product_name = pp.product_name
   AND o.channel_name = pp.channel
GROUP BY o.channel_name
ORDER BY avg_discount DESC
LIMIT 1;
ORDER BY total_revenue DESC;