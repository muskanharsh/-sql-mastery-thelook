-- Week 1, Day 1: Exploring TheLook Ecommerce Dataset
-- Tool: BigQuery | Project: sql-mastery-thelook

-- Query 1: See users table
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.users`
LIMIT 10;

-- Query 2: See orders table
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.orders`
LIMIT 10;

-- Query 3: Top 10 most expensive products
SELECT name, category, retail_price
FROM `bigquery-public-data.thelook_ecommerce.products`
ORDER BY retail_price DESC
LIMIT 10;

-- Query 4: Count users from each country
SELECT country, COUNT(*) AS total_users
FROM `bigquery-public-data.thelook_ecommerce.users`
GROUP BY country
ORDER BY total_users DESC;

-- Query 5: Total revenue by product category
SELECT p.category, ROUND(SUM(oi.sale_price),2) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p
ON oi.product_id = p.id
GROUP BY p.category
ORDER BY total_revenue DESC;
