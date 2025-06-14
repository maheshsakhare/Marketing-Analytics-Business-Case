SELECT *
FROM dbo.customer_reviews;

-- ************************************************
-- ************************************************

 -- Query to clean whitespace issues in the ReviewText column

 SELECT 
	ReviewID, -- select the unique identifier for each review.
	CustomerID, -- select the unique identifier for each customer.
	ProductID, -- select the unique identifier for each product.
	ReviewDate, -- select the date when review was written.
	Rating, -- Select the numerical rating given by the customer (e.g, 1 to 5 stars)
	-- Cleans up the review text by replacing double spaces with single spaces to esure text is more readble and standardize.
	REPLACE(ReviewText,'  ',' ') As ReviewText	
FROM 
	dbo.customer_reviews; -- specifies the source table from which to select the data
