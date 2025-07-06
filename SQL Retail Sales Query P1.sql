
DROP TABLE IF EXISTS retail_sales;

-- CREATE TABLE
CREATE TABLE retail_sales(
	transactions_id	INT PRIMARY KEY,
	sale_date	DATE,
	sale_time	TIME,
	customer_id INT,
	gender VARCHAR(15),
	age	INT,
	category VARCHAR(15),	
	quantiy INT,	
	price_per_unit FLOAT,	
	cogs	FLOAT,
	total_sale FLOAT
);

SELECT * FROM retail_sales
LIMIT 10;

SELECT COUNT(*) FROM retail_sales;

--Data Cleaning--

-- Check null values in all the columns
/*
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE customer_id IS NULL;

SELECT * FROM retail_sales
WHERE gender IS NULL

SELECT * FROM retail_sales
WHERE age IS NULL -- there's null values

SELECT * FROM retail_sales
WHERE category IS NULL

SELECT * FROM retail_sales
WHERE quantiy IS NULL --null values are present

SELECT * FROM retail_sales
WHERE price_per_unit IS NULL -- null values present

SELECT * FROM retail_sales
WHERE cogs IS NULL --null values present

SELECT * FROM retail_sales
WHERE total_sale IS NULL
*/

SELECT * FROM retail_sales
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
   quantiy IS NULL
   OR
   price_per_unit IS NULL;
   
   -- delete null values
DELETE FROM retail_sales
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
   quantiy IS NULL
   OR
   price_per_unit IS NULL;
   
   --Data Exploration--
   -- How many sales do we have
   SELECT COUNT(*) AS total_sale FROM retail_sales
   
   -- How many distinct customers do we have
    SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales;
	
	-- Business Key problems and Answers
	-- Q1 Retrieve all the columns for sales made on '22-11-05'
	SELECT * FROM retail_sales
	WHERE sale_date = '2022-11-05';
   
   -- Q2 Write a SQL query to retrieve all the transactions where category is 'clothing' and quantity sold is >= 4 in the month of Nov-2022
      
  SELECT  
* 
FROM 
  retail_sales 
WHERE 
  category = 'Clothing' 
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantiy >=4
GROUP BY 1;

 -- Q3 Write the SQL query to calculate the total sales(total_sale) for each category
 SELECT category, 
 SUM(total_sale) AS net_sale
 FROM retail_sales
 GROUP BY 1
 
 -- Q4 Write a SQL query to find the average age of customers who purchased items from 'Beauty' category
 SELECT ROUND(AVG(age), 2) AS avg_age FROM retail_sales WHERE category = 'Beauty';
   
   -- Q5 Write a SQL query to find all the transactions where the total_sale is greater than 1000
   SELECT transactions_id FROM retail_sales WHERE total_sale > 1000;
   
   -- Q6 Write a SQL query to find the total number of transactions(transactions_id) made by each gender in each category
   SELECT COUNT(transactions_id) AS total_transactions, gender, category FROM retail_sales GROUP BY gender, category ORDER BY 1;
   
   -- Q7 Write a SQL query to calculate the average sale for each month. Find the best selling month in each year
  SELECT year, month, avg_sale FROM
  (
      SELECT  
	  EXTRACT(YEAR FROM sale_date) AS year,
		 EXTRACT(MONTH FROM sale_date) AS month,
		 AVG(total_sale) AS avg_sale,
		 RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	  FROM retail_sales
	  GROUP BY 1, 2
	  )
  as t1
  WHERE rank = 1;

 
  
  -- Q8 Write a SQL query to find the top 5 customers based on the highest total sales
  SELECT 
  customer_id,
  SUM(total_sale) AS total_sales
  FROM retail_sales
  GROUP BY 1
  ORDER BY 2 DESC 
  LIMIT 5;
  
  -- Q9 Write a SQL query to find the number of unique customers who purchased the items from each category
  SELECT 
  COUNT(DISTINCT customer_id) AS unique_customers, 
  category 
  FROM retail_sales
  GROUP BY category;
  
  -- Q10 Write a SQL query to create each shift and number of orders(Example Morning < 12, Afternoon between 12 & 17 and Evening>17)
  SELECT
  CASE
  WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
  WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
  ELSE 'Evening'
  END AS shifts,
  COUNT(*) AS number_of_orders
  FROM retail_sales
  GROUP BY shifts
  ORDER BY 2 DESC;
  
  -- End of project
    