-- window function -- count

SELECT
	OrderID,
    OrderDate,
	COUNT(*) OVER() Total_orders,
    COUNT(*) OVER(PARTITION BY CustomerID) Order_customer
FROM orders;

SELECT
	*,
	COUNT(*) OVER() Count_customers,
    COUNT(Score) OVER() count_score,
    COUNT(Country) OVER() count_con
FROM customers;

SELECT
	*,
    COUNT(*) OVER() Cus_count
FROM customers
WHERE Score IS NOT NULL;


SELECT
*
FROM (
	SELECT
		OrderID,
		COUNT(*) OVER (PARTITION BY OrderID) checkpk
	FROM ordersarchive
)t WHERE checkpk > 1;

-- window function -- sum

SELECT
	OrderID,
    OrderDate,
    Sales,
    ProductID,
    SUM(Sales) OVER() Total_sales,
    SUM(Sales) OVER(PARTITION BY ProductID) salesbyproducts
FROM orders;

SELECT
	OrderID,
    ProductID,
    Sales,
    SUM(Sales) OVER() Total_sales,
    round (cast(Sales as float) / SUM(Sales) OVER() * 100, 2) Precentge_sales
FROM orders;

-- window function -- average

SELECT
	OrderID,
    OrderDate,
    Sales,
    ProductID,
    AVG(Sales) OVER() Avgsales,
    AVG(Sales) OVER(PARTITION BY ProductID) AvgSalesByProduct
FROM orders;


SELECT
	CustomerID,
    LastName,
    Score,
    coalesce(score, 0) customerScore,
    AVG(Score) over() avgscore,
    AVG(coalesce(score, 0)) OVER() AvgScoreWIthoutNULL
FROM customers;

SELECT
*
FROM (
	SELECT
		OrderID,
		ProductID,
		Sales,
		AVG(Sales) OVER() AvgSales
	FROM orders
)t WHERE Sales >  AvgSales;

SELECT
	OrderID,
    OrderDate,
    ProductID,
    Sales,
    MIN(Sales) OVER() Min_sales,
    MAX(Sales) OVER() Max_sales,
    MIN(Sales) OVER(PARTITION BY ProductID) Min_sales1,
    MAX(Sales) OVER(PARTITION BY ProductID) Max_sales1
FROM orders;


SELECT
*
FROM (
	SELECT
		*,
		MAX(Salary) OVER() Max_salary
	FROM employees
)t WHERE Salary = Max_salary;

SELECT
	OrderID,
    OrderDate,
    ProductID,
    Sales,
    MIN(Sales) OVER() Min_sales,
    MAX(Sales) OVER() Max_sales,
    Sales - MIN(Sales) OVER() deviationfrommin,
    MAX(Sales) OVER() - Sales deviationfrommax
FROM orders;

-- RUNNING & ROLLING TOTAL

SELECT
	OrderID,
    OrderDate,
    ProductID,
    Sales,
	SUM(Sales) OVER( ORDER BY OrderID 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) TOTAL_SUM,
    SUM(Sales) OVER(ORDER BY OrderID 
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) SUM_3_TOTAL
FROM orders;

-- MOVING AVERAGE 

SELECT
	OrderID,
    ProductID,
    OrderDate,
    Sales,
    AVG(Sales) OVER() OVERALL_AVG,
    AVG(Sales) OVER(PARTITION BY ProductID) AVGBYPRODUCT,
    AVG(Sales) OVER(PARTITION BY ProductID  ORDER BY OrderDate) MOVINGAVG,
    AVG(Sales) OVER(PARTITION BY ProductID  ORDER BY OrderDate 
    ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) ROLLINGAVG
FROM orders;