-- Cleansed DIM_Customers Table
SELECT 
  CustomerKey, 
  --,[GeographyKey]
  --,[CustomerAlternateKey]
  --,[Title],
  c.FirstName AS [First Name], 
  --,[MiddleName],
  c.LastName AS [Last Name], 
  CONCAT(c.FirstName, ' ', c.LastName) AS [Full Name], 
  --,[NameStyle]
  --,[BirthDate]
  --,[MaritalStatus]
  --,[Suffix]
  CASE c.Gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender, 
  --,[EmailAddress]
  --,[YearlyIncome]
  --,[TotalChildren]
  --,[NumberChildrenAtHome]
  --,[EnglishEducation]
  --,[SpanishEducation]
  --,[FrenchEducation]
  --,[EnglishOccupation]
  --,[SpanishOccupation]
  --,[FrenchOccupation]
  --,[HouseOwnerFlag]
  --,[NumberCarsOwned]
  --,[AddressLine1]
  --,[AddressLine2]
  --,[Phone],
  [DateFirstPurchase] AS [Date First Purchase], --,[CommuteDistance]
  g.City AS [Customer City] -- Joined in Customer City from Geography Table
FROM 
  dbo.DimCustomer AS c 
  LEFT JOIN dbo.DimGeography AS g ON g.GeographyKey = c.GeographyKey 
ORDER BY 
  CustomerKey ASC -- Ordered List by CustomerKey
