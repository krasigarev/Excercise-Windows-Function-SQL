SELECT
	ProductID,
	SUM(Sales) Sum_total
FROM orders
GROUP BY ProductID;


SELECT
	OrderID,
    OrderDate,
    ProductID,
    SUM(Sales) Total_sales
FROM orders
GROUP BY OrderID, OrderDate, ProductID;

SELECT
	OrderID,
    OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID)
FROM orders;

SELECT 
	OrderID,
    OrderDate,
    SUM(Sales) OVER() Total_sales
FROM orders;


SELECT 
	OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER(PARTITION BY ProductID, OrderDate) Total_sales,
    SUM(Sales) OVER(PARTITION BY ProductID) Total_sales_new,
    SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) Sales_status
FROM orders;

SELECT
	OrderID,
    OrderDate,
    Sales,
    RANK() OVER(ORDER BY Sales ASC) RankSales
FROM orders;


SELECT
	OrderID,
    OrderDate,
    OrderStatus,
    Sales,
    SUM(sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
    ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) Calc
FROM orders;

SELECT
	OrderID,
    OrderDate,
    OrderStatus,
    Sales,
    SUM(sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) TOTAL_SALES
FROM orders;

SELECT
	OrderID,
    OrderDate,
    OrderStatus,
    Sales,
    SUM(sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate) TOTAL_SALES
FROM orders;

SELECT
	OrderID,
    OrderDate,
    OrderStatus,
    ProductID,
    Sales,
    SUM(sales) OVER (PARTITION BY OrderStatus) TOTAL_SALES_WHERE
FROM orders
WHERE ProductID IN (101, 102);

SELECT
	CustomerID, 
    SUM(sales) TOTAL_SALES_RANK,
    RANK() OVER(ORDER BY CustomerID DESC) RANU_CUSTOMERS
FROM orders
GROUP BY CustomerID;

SELECT
	CustomerID, 
    SUM(sales) TOTAL_SALES_RANK,
    RANK() OVER(ORDER BY SUM(Sales) DESC) RANU_CUSTOMERS
FROM orders
GROUP BY CustomerID;