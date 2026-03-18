-- ========================================
-- E-COMMERCE DATA ANALYSIS PROJECT
-- Database: retail
-- Table: retail.retail_data
-- ========================================

USE retail;

-- ========================================
-- DATA OVERVIEW
-- ========================================

-- Total Rows
SELECT COUNT(*) AS total_rows
FROM retail.retail_data;

-- Preview Data
SELECT *
FROM retail.retail_data
LIMIT 10;


-- ========================================
-- SALES KPIs (CLEAN DATA ONLY)
-- ========================================

-- Total Revenue
SELECT SUM(TotalPrice) AS total_revenue
FROM retail.retail_data
WHERE Quantity > 0
AND CustomerID IS NOT NULL;

-- Total Orders
SELECT COUNT(DISTINCT InvoiceNo) AS total_orders
FROM retail.retail_data
WHERE Quantity > 0;

-- Total Customers
SELECT COUNT(DISTINCT CustomerID) AS total_customers
FROM retail.retail_data
WHERE CustomerID IS NOT NULL;

-- Average Order Value
SELECT 
SUM(TotalPrice) / NULLIF(COUNT(DISTINCT InvoiceNo), 0) AS avg_order_value
FROM retail.retail_data
WHERE Quantity > 0;


-- ========================================
-- PRODUCT ANALYSIS
-- ========================================

-- Top Selling Products
SELECT Description,
SUM(Quantity) AS total_sold
FROM retail.retail_data
WHERE Quantity > 0
AND Description IS NOT NULL
GROUP BY Description
ORDER BY total_sold DESC
LIMIT 10;

-- Highest Revenue Products
SELECT Description,
SUM(TotalPrice) AS revenue
FROM retail.retail_data
WHERE Quantity > 0
AND Description IS NOT NULL
GROUP BY Description
ORDER BY revenue DESC
LIMIT 10;


-- ========================================
-- CUSTOMER ANALYSIS
-- ========================================

-- Top Customers
SELECT CustomerID,
SUM(TotalPrice) AS total_spent
FROM retail.retail_data
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 10;

-- Repeat Customers
SELECT CustomerID,
COUNT(DISTINCT InvoiceNo) AS order_count
FROM retail.retail_data
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
HAVING order_count > 1
ORDER BY order_count DESC;


-- ========================================
-- COUNTRY ANALYSIS
-- ========================================

SELECT Country,
SUM(TotalPrice) AS revenue
FROM retail.retail_data
WHERE Quantity > 0
GROUP BY Country
ORDER BY revenue DESC;


-- ========================================
-- TIME ANALYSIS
-- ========================================


SELECT
DATE_FORMAT(InvoiceDate, '%Y-%m') AS month,
SUM(TotalPrice) AS revenue
FROM retail.retail_data
WHERE Quantity > 0
GROUP BY month
ORDER BY month;


-- ========================================
-- BONUS ANALYSIS (ADVANCED)
-- ========================================

-- Revenue per Customer
SELECT CustomerID,
SUM(TotalPrice) AS revenue_per_customer
FROM retail.retail_data
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY revenue_per_customer DESC;

-- Average Items per Order
SELECT 
AVG(order_quantity) AS avg_items_per_order
FROM (
    SELECT InvoiceNo,
    SUM(Quantity) AS order_quantity
    FROM retail.retail_data
    WHERE Quantity > 0
    GROUP BY InvoiceNo
) t;
