
 -- Query to clean and normalize the engagement_data table
SELECT 
	EngagementID, --select unique identifier for each engagement record
	ContentID, --select unique identifier for each piece of cotent
	CampaignID, --select unique identifier for each marketing campaign
	ProductID, -- select unique identifier for each product
	UPPER(REPLACE(ContentType,'Socialmedia','Social Media')) AS ContentType, --Replaces 'SOCIALMEDIA' woth 'Social Media.
	LEFT(ViewsClicksCombined, CHARINDEX('-',ViewsClicksCombined)-1) AS Views,--Extract the view part from ViewClicksCombined
	RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks, --Extract the clicks part from ViewClicksCombined
	Likes,
	FORMAT(CONVERT(DATE,EngagementDate),'dd.MM.yyyy') As EngagementDate -- converts and Formats the Date as dd.MM.yyyy
FROM
	dbo.engagement_data --specifies the alia 'g' for the dim_geography table
WHERE
	ContentType != 'Newsletter'; -- Filter out rows where content type is 'Newsletter' as these are not relevant for our analysis.



