SHOW TABLES;
SELECT * FROM WalmartSalesdata;
SHOW DATABASES;
	CREATE DATABASE  SALES_DATA;
    
    
    -- Generic question
    

  SELECT distinct city from walmartsalesdata;

 SELECT DISTINCT Branch, City
FROM WalmartSalesData;

SELECT COUNT(DISTINCT `Product line`) AS unique_product_lines
FROM WalmartSalesData;

SELECT `Payment`, COUNT(*) AS payment_count
FROM WalmartSalesData
GROUP BY `Payment`
ORDER BY payment_count DESC
LIMIT 1;



SELECT `Product line`, SUM(`Quantity`) AS total_sold
FROM WalmartSalesData
GROUP BY `Product line`
ORDER BY total_sold DESC
LIMIT 1;

SELECT 
    MONTH(`Date`) AS month, 
    YEAR(`Date`) AS year, 
    SUM(`Total`) AS total_revenue
FROM WalmartSalesData
GROUP BY YEAR(`Date`), MONTH(`Date`)
ORDER BY year, month;

SELECT 
    MONTH(`Date`) AS month, 
    YEAR(`Date`) AS year, 
    SUM(`cogs`) AS total_cogs
FROM WalmartSalesData
GROUP BY YEAR(`Date`), MONTH(`Date`)
ORDER BY total_cogs DESC
LIMIT 1;


SELECT `Product line`, SUM(`Total`) AS total_revenue
FROM WalmartSalesData
GROUP BY `Product line`
ORDER BY total_revenue DESC
LIMIT 1;



SELECT `City`, SUM(`Total`) AS total_revenue
FROM WalmartSalesData
GROUP BY `City`
ORDER BY total_revenue DESC
LIMIT 1;


SELECT `Product line`, SUM(`Tax 5%`) AS total_vat
FROM WalmartSalesData
GROUP BY `Product line`
ORDER BY total_vat 
LIMIT 1;

SELECT 
    `Product line`, 
    SUM(`Total`) AS total_sales,
    CASE 
        WHEN SUM(`Total`) > (SELECT AVG(total_sales) 
                             FROM (SELECT SUM(`Total`) AS total_sales 
                                   FROM WalmartSalesData 
                                   GROUP BY `Product line`) AS avg_sales) 
        THEN 'Good' 
        ELSE 'Bad' 
    END AS performance
FROM WalmartSalesData
GROUP BY `Product line`;

SELECT 
    `Branch`, 
    SUM(`Quantity`) AS total_products_sold,
    CASE 
        WHEN SUM(`Quantity`) > (SELECT AVG(total_sold) 
                                FROM (SELECT SUM(`Quantity`) AS total_sold 
                                      FROM WalmartSalesData 
                                      GROUP BY `Branch`) AS avg_sales) 
        THEN 'Above Average' 
        ELSE 'Below Average' 
    END AS performance
FROM WalmartSalesData
GROUP BY `Branch`;


SELECT Gender, `Product line`, total_sold
FROM (
    SELECT 
        Gender, 
        `Product line`, 
        SUM(`Quantity`) AS total_sold,
        RANK() OVER (PARTITION BY Gender ORDER BY SUM(`Quantity`) DESC) AS rank_order
    FROM WalmartSalesData
    GROUP BY Gender, `Product line`
) ranked
WHERE rank_order = 1;



SELECT 
    `Product line`, 
    AVG(`Rating`) AS avg_rating
FROM WalmartSalesData
GROUP BY `Product line`
ORDER BY avg_rating DESC;

## Sales 

SELECT 
    DAYNAME(`Date`) AS weekday,
    CASE 
        WHEN HOUR(`Time`) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(`Time`) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day,
    COUNT(*) AS total_sales
FROM WalmartSalesData
GROUP BY weekday, time_of_day
ORDER BY FIELD(weekday, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'), 
         FIELD(time_of_day, 'Morning', 'Afternoon', 'Evening');


SELECT `Customer type`, SUM(`Total`) AS total_revenue
FROM WalmartSalesData
GROUP BY `Customer type`
ORDER BY total_revenue DESC
LIMIT 1;

SELECT `City`, SUM(`Tax 5%`) AS total_vat
FROM WalmartSalesData
GROUP BY `City`
ORDER BY total_vat DESC
LIMIT 1;


SELECT `Customer type`, SUM(`Tax 5%`) AS total_vat
FROM WalmartSalesData
GROUP BY `Customer type`
ORDER BY total_vat DESC
LIMIT 1;



## Customer

SELECT COUNT(DISTINCT `Customer type`) AS unique_customer_types
FROM WalmartSalesData;


SELECT COUNT(DISTINCT `Payment`) AS unique_payment_methods
FROM WalmartSalesData;


SELECT `Customer type`, COUNT(*) AS total_customers
FROM WalmartSalesData
GROUP BY `Customer type`
ORDER BY total_customers DESC
LIMIT 1;



SELECT `Customer type`, SUM(`Quantity`) AS total_quantity_purchased
FROM WalmartSalesData
GROUP BY `Customer type`
ORDER BY total_quantity_purchased DESC
LIMIT 1;



SELECT `Gender`, COUNT(*) AS total_customers
FROM WalmartSalesData
GROUP BY `Gender`
ORDER BY total_customers DESC
LIMIT 1;



 SELECT `Branch`, `Gender`, COUNT(*) AS total_customers
FROM WalmartSalesData
GROUP BY `Branch`, `Gender`
ORDER BY `Branch`, total_customers DESC;

SELECT 
    CASE 
        WHEN HOUR(`Time`) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(`Time`) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day,
    COUNT(`Rating`) AS total_ratings
FROM WalmartSalesData
GROUP BY time_of_day
ORDER BY total_ratings DESC
LIMIT 1;


SELECT 
    `Branch`,
    CASE 
        WHEN HOUR(`Time`) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(`Time`) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day,
    COUNT(`Rating`) AS total_ratings
FROM WalmartSalesData
GROUP BY `Branch`, time_of_day
ORDER BY `Branch`, total_ratings DESC;



SELECT 
    DAYNAME(`Date`) AS day_of_week,
    AVG(`Rating`) AS avg_rating
FROM WalmartSalesData
GROUP BY day_of_week
ORDER BY avg_rating DESC
LIMIT 1;



SELECT 
    `Branch`,
    DAYNAME(`Date`) AS day_of_week,
    AVG(`Rating`) AS avg_rating
FROM WalmartSalesData
GROUP BY `Branch`, day_of_week
ORDER BY `Branch`, avg_rating DESC;

















