--Skills Used: Data Retrieval and Filtering, Statistical Analysis, Trend Analysis, Data Sorting, Data Aggregation and Counting, Variable Declaration and Calculation.
SELECT *
  FROM [dbo].[exchange_rates]

 --Checking for all available data for Nigeria's exchange rate (NGN)
SELECT *
  FROM [dbo].[exchange_rates]
 WHERE currency = 'NGN'
ORDER BY CONVERT(DATE, Date, 103) ASC;
  
  -- Checking for missing values
  SELECT 
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT date) AS UniqueDates,
    COUNT(DISTINCT currency) AS UniqueCurrencies,
    SUM(CASE WHEN value IS NULL THEN 1 ELSE 0 END) AS MissingValues
FROM [PortfolioProject].[dbo].[exchange_rates];

-- Checking for inconsistencies
SELECT 
    currency,
    MIN(value) AS MinValue,
    MAX(value) AS MaxValue
FROM [PortfolioProject].[dbo].[exchange_rates]
GROUP BY currency;

-- Time series analysis for Nigeria's exchange rate (NGN)
SELECT Date, Value
FROM [PortfolioProject].[dbo].[exchange_rates]
WHERE Currency = 'NGN'
ORDER BY CONVERT(DATE, Date, 103) ASC;

-- Calculating Descriptive statistics & Aggregations
SELECT currency, AVG(CAST(value AS DECIMAL(18, 2))) AS AvgValue, 
                 MIN(CAST(value AS DECIMAL(18, 2))) AS MinValue, 
                 MAX(CAST(value AS DECIMAL(18, 2))) AS MaxValue
FROM [PortfolioProject].[dbo].[exchange_rates] 
GROUP BY currency;

-- Calculating average, minimum, and maximum values for Nigeria's currency (NGN)
SELECT AVG(CAST(value AS DECIMAL(18, 2))) AS AvgValue, 
                 MIN(CAST(value AS DECIMAL(18, 2))) AS MinValue, 
                 MAX(CAST(value AS DECIMAL(18, 2))) AS MaxValue
FROM [PortfolioProject].[dbo].[exchange_rates]
WHERE Currency = 'NGN'

-- Calculating standard deviation for Nigeria's currency (NGN) by casting the 'value' column to a decimal data type.
DECLARE @AvgValue DECIMAL(18, 2);
DECLARE @Count INT;
-- Calculating average and count
SELECT @AvgValue = AVG(CAST(value AS DECIMAL(18, 2))),
       @Count = COUNT(*)
FROM [PortfolioProject].[dbo].[exchange_rates]
WHERE Currency = 'NGN';
-- Calculating standard deviation
SELECT SQRT(SUM(POWER(CAST(value AS DECIMAL(18, 2)) - @AvgValue, 2)) / @Count) AS StdDevValue
FROM [PortfolioProject].[dbo].[exchange_rates]
WHERE Currency = 'NGN';

-- Trend Analysis(Average value per month for NGN) for Nigeria's currency (NGN) 
SELECT 
    DATEPART(YEAR, CONVERT(DATE, date, 103)) AS Year,
    DATEPART(MONTH, CONVERT(DATE, date, 103)) AS Month,
    AVG(CAST(value AS DECIMAL(18, 2))) AS AvgValue
FROM [PortfolioProject].[dbo].[exchange_rates]
WHERE Currency = 'NGN'
GROUP BY DATEPART(YEAR, CONVERT(DATE, date, 103)), DATEPART(MONTH, CONVERT(DATE, date, 103))
ORDER BY Year, Month ASC;

