-- SQL RETAIL SALES ANALYSIS
create database sql_project_2
--Create Table
DROP TABLE IF EXISTS retail_sales
CREATE TABLE retail_sales
(
 transactions_id INT PRIMARY KEY,
 sale_date DATE,
 sale_time TIME,
 customer_id INT,
 gender	VARCHAR(15),
 age INT,	
 category VARCHAR(15),	
 quantity INT,	
 price_per_unit FLOAT,	
 cogs	FLOAT,
 total_sale FLOAT);
 SELECT*FROM retail_sales
SELECT COUNT(*)FROM retail_sales

--Identifying and deleting Null rows
SELECT*FROM retail_sales
WHERE 
    transactions_id IS NULL
	OR
    sale_date IS NULL
	OR
    sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
    age IS NULL
	OR 
	category IS NULL
	OR
	quantity IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;
DELETE FROM retail_sales
WHERE transactions_id IS NULL
	OR
    sale_date IS NULL
	OR
    sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
    age IS NULL
	OR 
	category IS NULL
	OR
	quantity IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;
	
--Data Exploration

--How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

--How many unique customers we have?
SELECT COUNT (DISTINCT customer_id) as total_customers
FROM retail_sales

--How many categories of products are there?
SELECT DISTINCT category FROM retail_sales

--Data Analysis and Business Key Problems & Answer

-- Q.1.Write a query to retrieve all columns for sales made on '2022-11-05'
SELECT*FROM retail_sales
WHERE sale_date ='2022-11-05';

-- Q.2.Write a query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT*
FROM retail_sales
WHERE category = 'Clothing' 
  AND TO_CHAR (sale_date,'YYYY-MM')='2022-11'
  AND quantity >= 4;

-- Q.3.Write a query to calculate the total sales (total_sale) for each category
SELECT 
   category,
    SUM(total_sale) as net_sale,
    COUNT(*) as Total_orders
FROM retail_sales	
GROUP BY 1;

-- Q.4.Write a query to find the average age of customers who purchased items from the beauty category
SELECT ROUND(AVG(age),2)
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5.Write a query to find all transactions where the total_sale is greater than 1000
SELECT*FROM retail_sales
WHERE total_sale > 1000;

-- Q.6.Write a query to find the total number of transactions made by each gender in each year
--(The order of writing is v imp here )
SELECT 
   category,gender,
   COUNT(*) as total_transactions
FROM retail_sales
GROUP BY 1,2
ORDER BY 1;

-- Q.7.Write a query to calculate the average sale for each month.Find out the best selling month in each year
--answer(a)
SELECT
	EXTRACT (YEAR FROM sale_date) as year,
	EXTRACT (MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sales
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,3 DESC;
--ans(b)
SELECT DISTINCT ON (year)
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY 1, 2
ORDER BY 1, 3 DESC;

-- Q.8.Write a query to find the top 5 customers based on the highesttotal sales
SELECT customer_id,
       SUM(total_sale)as total_sales 
FROM retail_sales
GROUP BY 1
Order by 2 DESC
limit 5;

-- Q.9.Write a query to find the number of unique customers who purchased items from each category
SELECT category,
COUNT(DISTINCT customer_id) count_unique_cs
FROM retail_sales
GROUP BY 1;


-- Q.10.Write a query to create each shift and number of orders (Example Morning <=12,Afternoon Between 12 & 17,Evening > 17)
WITH hourly_sale
AS
(SELECT*,
	CASE
		WHEN EXTRACT (HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM sale_time) Between 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END	as shift
FROM retail_sales)
SELECT shift,COUNT(*)as total_orders
FROM hourly_sale
GROUP BY shift;

-- End of Project 





