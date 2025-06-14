SELECT *
FROM dbo.customer_journey;

-- Comman Table Expression (CTE) to identify and tag duplicate records.
WITH DuplicateRecords As (
	SELECT
		JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		Stage,
		Action,
		Duration,
		-- Use ROW_NUMBER() to assign a unique row number to each record within the partiion defined below.
		ROW_NUMBER() OVER(
		-- PARTITION BY groups the rows based on the specified columns that should be unique
			PARTITION BY CustomerID,ProductID,VisitDate,Stage,Action
			-- ORDER BY defines how to order the rows witin each partiion (usually by a unique identifier like JourneyID)
			ORDER BY JourneyID
		) AS row_num --This creates a new column 'row_num' that number each row within its partition
	FROM
		dbo.customer_journey
)
SELECT *
FROM DuplicateRecords
WHERE row_num > 1 -- Filters out the first occurance (row_num =1) and only shows the duplicates (row_num >1)
ORDER BY JourneyID;

-- Outer query selects the final cleaned and standardized data
SELECT 
	JourneyID,
	CustomerID,
	ProductID,
	VisitDate,
	Stage,
	Action,
	COALESCE(Duration, avg_duration) AS Duration -- Replaces missing durations wih the average duration for the corresponding 
FROM
	(
		-- Subquery to process and clean the data
		SELECT
			JourneyID,
			CustomerID,
			ProductID,
			VisitDate,
			UPPER(Stage) AS Stage, -- Converts stage values	to uppercase for consistency in data analysis.
			Action,
			Duration,
			AVG(Duration) OVER ( PARTITION BY VisitDate) As avg_duration, --Calculates the average duration for each date,using grouping of VisitDate
			ROW_NUMBER() OVER(
				PARTITION BY CustomerID,ProductID,VisitDate,UPPER(Stage),Action -- Groups by these columns to identify duplicate values.
				ORDER BY JourneyID -- Order by journeyID to keep the first occurances of each duplicates
			) AS row_num
		FROM
			dbo.customer_journey
	) AS subquery
WHERE row_num = 1;
