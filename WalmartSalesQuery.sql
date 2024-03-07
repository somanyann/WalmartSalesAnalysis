CREATE DATABASE WalmartSales_Analysis;

SELECT * FROM sales
WHERE Branch IS NULL;


/* Product Analysis
> Conduct analysis on the data to understand the different product lines, the products lines performing best and
the product lines that need to be improved. */

--1. How many unique product lines does the data have?
SELECT COUNT(DISTINCT Product_line)
FROM sales;

--2. What is the most common payment method?
SELECT Payment, COUNT(Payment) AS Payment_Count
FROM sales
GROUP BY Payment
ORDER BY Payment_Count DESC;

--3. What is the most selling product line?
SELECT Product_line, SUM(Quantity) AS Product_sales
FROM sales
GROUP BY Product_line
ORDER BY Product_sales DESC;

--4. What is the total revenue by month?
SELECT Date, DATENAME(MONTH, Date) AS Month_Name
FROM sales;

ALTER TABLE sales
ADD Mnth_Name TEXT;

ALTER TABLE sales
ALTER COLUMN Mnth_Name CHAR(10);

UPDATE sales
SET Mnth_Name = DATENAME(MONTH, Date);

SELECT Mnth_Name, ROUND(SUM(Total), 2) AS Revenue
FROM sales
GROUP BY Mnth_Name
ORDER BY Revenue DESC;

--5. What month had the largest COGS?
SELECT Mnth_Name, ROUND(SUM(cogs), 2) AS Total_COGS
FROM sales
GROUP BY Mnth_Name
ORDER BY Total_COGS DESC;

--6. What product line had the largest revenue?
SELECT Product_line, ROUND(SUM(Total), 2) AS Product_Total_Sales
FROM sales
GROUP BY Product_line
ORDER BY Product_Total_Sales DESC;

--5. What is the city with the largest revenue?
SELECT City, ROUND(SUM(Total), 2) AS RevenuebyCity
FROM sales
GROUP BY City
ORDER BY RevenuebyCity DESC;

--6. What product line had the largest VAT?
SELECT Product_line, ROUND(SUM(Tax), 2) AS VAT
FROM sales
GROUP BY Product_line
ORDER BY VAT DESC;

--7. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT Product_line,
CASE
	WHEN SUM(Total) > AVG(Total) THEN 'Good'
	ELSE 'Bad'
END AS Sales_Status
FROM sales
GROUP BY Product_line;

--8. Which branch sold more products than average product sold?
SELECT Branch, AVG(Quantity) AS AveragePrdctSold, SUM(Quantity) AS NumberPrdctSold
FROM sales
GROUP BY Branch
HAVING SUM(Quantity) > AVG(Quantity)
ORDER BY Branch;

--9. What is the most common product line by gender?
SELECT Gender, Product_line, COUNT(Product_line) AS CmnProductLine
FROM sales
GROUP BY Gender, Product_line
ORDER BY CmnProductLine DESC;

--10. What is the average rating of each product line?
SELECT Product_line, ROUND(AVG(Rating), 2) AS Average_Rating
FROM sales
GROUP BY Product_line
ORDER BY Average_Rating DESC;

/* Sales Analysis

> This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness
of each sales strategy the business applies and what modificatoins are needed to gain more sales. */

--1. Number of sales made in each time of the day per weekday
--2. Which of the customer types brings the most revenue?
--3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
--4. Which customer type pays the most in VAT?

/* Customer Analysis

> This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment. */
--1. How many unique customer types does the data have?
--2. How many unique payment methods does the data have?
--3. What is the most common customer type?
--4. Which customer type buys the most?
--5. What is the gender of most of the customers?
--6. What is the gender distribution per branch?
--7. Which time of the day do customers give most ratings?
--8. Which time of the day do customers give most ratings per branch?
--9. Which day fo the week has the best avg ratings?
--10. Which day of the week has the best average ratings per branch?