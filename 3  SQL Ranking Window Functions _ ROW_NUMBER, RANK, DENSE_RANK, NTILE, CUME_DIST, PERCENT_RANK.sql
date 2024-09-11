-- 3  SQL Ranking Window Functions -- ROW_NUMBER, RANK, DENSE_RANK, NTILE, CUME_DIST, PERCENT_RANK

-- ROW_NUMBER() -- RANK --- no graps in ranks

SELECT 
	OrderID,
    ProductID,
    Sales,
    ROW_NUMBER() OVER(ORDER BY Sales DESC) sales_rank
FROM orders;

-- RANK()  -- RANK  -- SHARED RANKING, (LEAVING GAPS(SKIPPING) - graps in ranks)

SELECT 
	OrderID,
    ProductID,
    Sales,
    ROW_NUMBER() OVER(ORDER BY Sales DESC) sales_rank_rows,
    RANK() OVER(ORDER BY Sales DESC) Sales_rank_Rank    
FROM orders;

-- DENSE_RANK() -- DENSE_RANK -- no SKIPPING rank ; no graps in ranks

SELECT 
	OrderID,
    ProductID,
    Sales,
    ROW_NUMBER() OVER(ORDER BY Sales DESC) sales_rank_rows,
    RANK() 		 OVER(ORDER BY Sales DESC) Sales_rank_Rank,
    DENSE_RANK() OVER(ORDER BY Sales DESC) Sales_rank_dense_rank
FROM orders;

-- TOP N ANALYSIS 

-- TOP HIGHEST 

SELECT * 
	FROM (
	SELECT 
		OrderID,
		ProductID,
		Sales,
		ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RANKBYPRODUCT
	FROM orders
)T WHERE RANKBYPRODUCT = 1;

-- TOP SMALLEST 

SELECT * 
	FROM (
	SELECT 
		OrderID,
		ProductID,
		Sales,
		ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales ASC) RANKBYPRODUCT
	FROM orders
)T WHERE RANKBYPRODUCT = 1;

-- BOTTOM-N ANALYSIS

SELECT *
FROM (
SELECT 
	CustomerID,
    SUM(Sales) tOTALsUM,
    ROW_NUMBER() OVER(ORDER BY SUM(Sales)) RANKcUSTOMERS
FROM orders
GROUP BY CustomerID
)T WHERE RANKcUSTOMERS <= 2;