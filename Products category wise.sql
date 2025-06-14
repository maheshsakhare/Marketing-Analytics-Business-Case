select *
from dbo.products;

-- *********************************************************
-- *********************************************************

-- Query to categorize products based on their price.
SELECT 
	ProductID, -- select the unique identifier for each product.
	ProductName, -- Select the name of each product.
	Price, --Select the price of each product.
	-- Category, -- Select the product catefory for each product.

	CASE -- Categorises the product into price categories: Low,Medium,High
	WHEN Price < 50 THEN 'Low' --if the price is less than 50, categories as 'Low'.
	WHEN Price BETWEEN 50 AND 200 THEN 'Medium' -- If the price is between 50 and 200(inclusive),categories as 'Medium'.
	ELSE 'High' -- If the price is greater than 200, categorise as 'High'.
	END AS PriceCategory
FROM
dbo.products; -- Specifies the source table from which to select the data.

