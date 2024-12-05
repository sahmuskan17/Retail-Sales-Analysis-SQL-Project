
CREATE TABLE RETAIL_SALES(
transactions_id	INT PRIMARY KEY,
sale_date	DATE,
sale_time	TIME,
customer_id	INT,
gender	VARCHAR(7),
age	INT,
category VARCHAR(20),	
quantiy	INT,
price_per_unit	FLOAT,
cogs	FLOAT,
total_sale FLOAT

)
SELECT * FROM RETAIL_SALES;

--Data Exploration & Cleaning
  --Determine the total number of records in the dataset.
  SELECT COUNT(*)
  FROM RETAIL_SALES;

  --Find out how many unique customers are in the dataset.
  SELECT COUNT(DISTINCT customer_id)
  FROM RETAIL_SALES;

  --Identify all unique product categories in the dataset.
  SELECT DISTINCT category
  FROM RETAIL_SALES;

  --Check for any null values in the dataset and delete records with missing data.
  SELECT * FROM RETAIL_SALES
  WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

	DELETE FROM RETAIL_SALES 
	WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

--Data Analysis & Findings
  --Write a SQL query to retrieve all columns for sales made on '2022-11-05:
  SELECT * FROM RETAIL_SALES
  WHERE sale_date='2022-11-05';

  --Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
  SELECT * FROM RETAIL_SALES
  WHERE category='Clothing' and
  quantiy>=4 and TO_CHAR(sale_date,'YYYY-MM')='2022-11';


  --Write a SQL query to calculate the total sales (total_sale) for each category.:
  SELECT category, SUM(total_sale) as total_sales
  from RETAIL_SALES
  group by category;


  --Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
  SELECT AVG(age) AS avg_age
  from RETAIL_SALES
  WHERE category='Beauty';

 --Write a SQL query to find all transactions where the total_sale is greater than 1000.:
 SELECT * FROM RETAIL_SALES
 WHERE total_sale>1000;

 --Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
 select category,gender,count(transactions_id) as total_transactions
 from retail_sales
 group by category,gender
 order by category asc;


 --Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select year,month,avg_sale from (

 SELECT EXTRACT(YEAR FROM sale_date) as year,
 EXTRACT(month FROM sale_date) as month ,
 avg(total_sale) as avg_sale,
 rank() over(partition by EXTRACT(YEAR FROM sale_date) order by avg(total_sale )) as rn
 from retail_sales
 group by month,year
 )
 where rn=1;

 
 --Write a SQL query to find the top 5 customers based on the highest total sales
 select customer_id,total_sale
 from retail_sales
 order by total_sale desc
 limit 5;


 --Write a SQL query to find the number of unique customers who purchased items from each category.:

 SELECT category,count(DISTINCT(customer_id)) as unique_cust
 from retail_sales
 group by category;

 --Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
 with cte as (
 select *,
 case when EXTRACT(HOUR FROM sale_time)<12 then 'Morning'
      when EXTRACT(HOUR FROM sale_time) between 12 and 17 then 'Afternoon'
	  ELSE 'Evening' end as shift
 from retail_sales)

 select shift,count(*) as no_of_orders
 from cte
 group by shift;
 
 



































































































