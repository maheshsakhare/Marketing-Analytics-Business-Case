SELECT *
FROM dbo.customers;
SELECT * 
FROM dbo.geography;

-- SQL Statement to join dim_customer with dim_geography to enrich customer data with geographic information
SELECT 
	c.CustomerID,-- select unique identifier for each customer
	c.CustomerName,-- select the names of each customer
	c.Email,-- select email of each customer
	c.Gender, -- select gender of each customer
	c.Age, -- select age of each customer.
	g.Country, -- select the country from the category table to enrich customer data
	g.City -- select the city from the geography table to enrich customer data
FROM
	dbo.customers AS c -- Specifies the alias 'c' for the dim customer_table
LEFT JOIN
-- RIGHT JOIN
-- INNER JOIN
-- FULL OUTER JOIN
	dbo.geography AS g  -- specifies the alia 'g' for the dim_geography table
ON 
	c.GeographyID = g.GeographyID; -- Joins the two tables on the GeographyID field match customer with their geographich information.

