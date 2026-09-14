-- Skill Nexis Week 2: SQL for Data Analysis
-- Dataset: SQL_Sales_Dataset_200_Rows.xlsx
-- Table: sales
--
-- Required topics covered:
-- SELECT, WHERE, GROUP BY, ORDER BY, SUM, AVG, COUNT,
-- JOIN, subquery, CASE.
--

-- 01 Basic Select
SELECT * FROM sales LIMIT 10;

-- 02 Where
SELECT order_id, customer_name, total_price, region
FROM sales
WHERE total_price > 20000
ORDER BY total_price DESC;

-- 03 Group By Category
SELECT category,
       SUM(total_price) AS total_revenue,
       COUNT(*) AS order_count,
       AVG(total_price) AS average_order_value
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;

-- 04 Group By Region
SELECT region,
       SUM(total_price) AS total_revenue,
       COUNT(*) AS order_count,
       AVG(total_price) AS average_order_value
FROM sales
GROUP BY region
ORDER BY total_revenue DESC;

-- 05 Top Customers
SELECT customer_name,
       SUM(total_price) AS total_spent,
       COUNT(*) AS order_count,
       AVG(total_price) AS average_order_value
FROM sales
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- 06 Average Order Value
SELECT AVG(total_price) AS average_order_value
FROM sales;

-- 07 Count Orders
SELECT COUNT(*) AS total_orders
FROM sales;

-- 08 Order By Multiple Columns
SELECT order_id, customer_name, category, total_price, region
FROM sales
ORDER BY category ASC, total_price DESC;

-- 09 Subquery
SELECT customer_name, total_price
FROM sales
WHERE total_price > (
    SELECT AVG(total_price) FROM sales
)
ORDER BY total_price DESC;

-- 10 Case Statement
SELECT order_id, customer_name, total_price,
       CASE
           WHEN total_price >= 30000 THEN 'High'
           WHEN total_price >= 15000 THEN 'Medium'
           ELSE 'Low'
       END AS order_value_band
FROM sales
ORDER BY total_price DESC;

-- 11 Join
WITH customer_totals AS (
    SELECT customer_name,
           SUM(total_price) AS total_spent
    FROM sales
    GROUP BY customer_name
)
SELECT s.order_id, s.customer_name, s.total_price, ct.total_spent
FROM sales AS s
JOIN customer_totals AS ct
  ON s.customer_name = ct.customer_name
ORDER BY ct.total_spent DESC, s.total_price DESC
LIMIT 10;
