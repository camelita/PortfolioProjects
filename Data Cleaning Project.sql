-- Cleaning Data in SQL Queries

Select *
From NashvilleHousing

-- Standardize Date Format
Select [Sale Date] Date, convert(Date,[Sale Date])
From NashvilleHousing

alter table NashvilleHousing 
alter column [Sale Date] Date

update NashvilleHousing
set [Sale Date] = convert(Date,[Sale Date])

--Populate Property Address Data

Select *
From NashvilleHousing
--where [Property Address] is null
order by [Parcel ID]



Select a.[Parcel ID], a.[Property Address], b.[Parcel ID], b.[Property Address], ISNULL(a.[Property Address], b.[Property Address])
From NashvilleHousing a
join NashvilleHousing b
on a.[Parcel ID] = b.[Parcel ID]
and a.[UniqueID] <> b.[UniqueID]
where a.[Property Address] is null

update a
set a.[Property Address] = ISNULL(a.[Property Address], b.[Property Address])
From NashvilleHousing a
join NashvilleHousing b
on a.[Parcel ID] = b.[Parcel ID]
and a.[UniqueID] <> b.[UniqueID]
where a.[Property Address] is null



--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)
Select [Property Address]
From PortfolioProject.dbo.NashvilleHousing
--Where PropertyAddress is null
--order by ParcelID


SELECT
  LEFT([Property Address], CHARINDEX(',', [Property Address] + ',') - 1) AS Address1,
  LTRIM(RIGHT([Property Address], LEN([Property Address]) - CHARINDEX(',', [Property Address]))) AS Address2

FROM PortfolioProject.dbo.NashvilleHousing;

ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING([Property Address], 1, CHARINDEX(',', [Property Address]) -1 )


ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING([Property Address], CHARINDEX(',', [Property Address]) + 1 , LEN([Property Address]))

Select *
From PortfolioProject.dbo.NashvilleHousing





Select [Address]
From PortfolioProject.dbo.NashvilleHousing


Select
PARSENAME(REPLACE([Address], ',', '.') , 3)
,PARSENAME(REPLACE([Address], ',', '.') , 2)
,PARSENAME(REPLACE([Address], ',', '.') , 1)
From PortfolioProject.dbo.NashvilleHousing



ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE([Address], ',', '.') , 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE([Address], ',', '.') , 2)



ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE([Address], ',', '.') , 1)



Select *
From PortfolioProject.dbo.NashvilleHousing



--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct([Sold As Vacant]), Count([Sold As Vacant])
From PortfolioProject.dbo.NashvilleHousing
Group by [Sold As Vacant]
order by 2

Select [Sold As Vacant]
, CASE When [Sold As Vacant] = 'Y' THEN 'Yes'
	   When [Sold As Vacant] = 'N' THEN 'No'
	   ELSE [Sold As Vacant]
	   END
From PortfolioProject.dbo.NashvilleHousing

Update NashvilleHousing
SET [Sold As Vacant] = CASE When [Sold As Vacant] = 'Y' THEN 'Yes'
	   When [Sold As Vacant] = 'N' THEN 'No'
	   ELSE [Sold As Vacant]
	   END

	   -----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY [Parcel ID],
				 [Property Address],
				 [Sale Price],
				 [Sale Date],
				 [Legal Reference]
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by [Property Address]


Select *
From PortfolioProject.dbo.NashvilleHousing


---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns



Select *
From PortfolioProject.dbo.NashvilleHousing


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN [Address], [Tax District], [Property Address], [Sale Date]
