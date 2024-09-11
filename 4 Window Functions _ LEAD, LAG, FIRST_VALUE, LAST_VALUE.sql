-- SQL Value Window Functions _ LEAD, LAG, FIRST_VALUE, LAST_VALUE

-- LEAD FUNCTION

SELECT 
	Sales,
    LEAD(Sales) OVER(ORDER BY OrderDate) LEAD_SALES,
    LEAD(Sales, 2, 0) OVER(ORDER BY OrderDate) LEAD_SALES_2STEP,
    LAG(Sales) OVER(ORDER BY OrderDate) LAG_SALES,
    LAG(Sales, 2, 0) OVER(ORDER BY OrderDate) LAG_SALES_2STEP
FROM orders;


SELECT
*,
Current_month_Sales - PreviousMonthSales AS MoM_change,
ROUND(CAST((Current_month_Sales - PreviousMonthSales) AS FLOAT)/ PreviousMonthSales * 100, 1) AS MoM_Perc
FROM (
	SELECT
		MONTH(OrderDate) OrderMonth,
		SUM(Sales) Current_month_Sales,
		LAG(SUM(Sales)) OVER (ORDER BY MONTH(OrderDate)) PreviousMonthSales
	FROM orders
	GROUP BY 
		MONTH(OrderDate)
)t