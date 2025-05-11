
-- Cleaning Nashville housing data 

SELECT
	*
FROM
	NashVilleHousing..[NashvilleHousingData ]

-- populate null property address data
SELECT 
	*
FROM
	NashVilleHousing..[NashvilleHousingData ]
WHERE
	PropertyAddress IS NULL



SELECT
	a.ParcelID,
	a.PropertyAddress,
	b.ParcelID,
	b.PropertyAddress,
	ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM
	NashVilleHousing..[NashvilleHousingData ] a
JOIN
	NashVilleHousing..[NashvilleHousingData ] b ON a.ParcelID = b.ParcelID
	AND a.UniqueID != b.UniqueID
WHERE 
	a.PropertyAddress IS NOT NULL


-- update null propertyaddress column values to populate with property address from
-- cases with the same parcelID
UPDATE a
SET
	PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM
	NashVilleHousing..[NashvilleHousingData ] a
JOIN NashVilleHousing..[NashvilleHousingData ] b
	ON a.ParcelID = b.ParcelID 
	AND a.UniqueID != b.UniqueID
WHERE
	a.PropertyAddress IS NULL


-- check if any null propery addresses left in data
SELECT
	PropertyAddress
FROM 
	NashVilleHousing..[NashvilleHousingData ]
WHERE
	PropertyAddress IS NULL


-- Break PropertyAddress column into multiple columns, Address, City, State

-- delimter is is comma ',' separating address and city
SELECT
	PropertyAddress
FROM 
	NashVilleHousing..[NashvilleHousingData ]

-- get address and city columns
SELECT
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+ 1, LEN(PropertyAddress)) AS City
FROM
	NashVilleHousing..[NashvilleHousingData ]


-- create columns and populate
ALTER TABLE NashVilleHousing..NashvilleHousingData
ADD PropertyAddressSplit nvarchar(255)

ALTER TABLE NashVilleHousing..NashvilleHousingData
ADD PropertyCity nvarchar(255)

UPDATE NashVilleHousing..[NashvilleHousingData ]
SET PropertyAddressSplit = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

UPDATE NashVilleHousing..[NashvilleHousingData ]
SET PropertyCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+ 1, LEN(PropertyAddress))


-- check columns were populated correctly
SELECT
	PropertyAddressSplit,
	PropertyCity
FROM
	NashVilleHousing..[NashvilleHousingData ]



-- Get owner address, city, state using PARSENAME function
SELECT
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS OwnerAddressSplit,
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS OwnerCity,
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS OwnerState
FROM
	NashVilleHousing..[NashvilleHousingData ]



-- create columns and populate
ALTER TABLE NashVilleHousing..NashvilleHousingData
ADD OwnerAddressSplit nvarchar(255)

ALTER TABLE NashVilleHousing..NashvilleHousingData
ADD OwnerCity nvarchar(255)

ALTER TABLE NashVilleHousing..NashvilleHousingData
ADD OwnerState nvarchar(50)

UPDATE NashVilleHousing..[NashvilleHousingData ]
SET OwnerAddressSplit = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

UPDATE NashVilleHousing..[NashvilleHousingData ]
SET OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

UPDATE NashVilleHousing..[NashvilleHousingData ]
SET OwnerState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


-- check columns were populated correctly
SELECT 
	OwnerAddressSplit,
	OwnerCity,
	OwnerState
FROM
	NashVilleHousing..[NashvilleHousingData ]


-- Change SoldAsVacant from 0 and 1 to Yes or No

SELECT
	DISTINCT(SoldAsVacant)
FROM
	NashVilleHousing..[NashvilleHousingData ]

-- Change SoldAsVacant datatype from bit to varchar
ALTER TABLE NashVilleHousing..[NashvilleHousingData ]
ALTER COLUMN SoldAsVacant varchar(5)

UPDATE 
	NashVilleHousing..[NashvilleHousingData ]
SET
	SoldAsVacant = CASE WHEN SoldAsVacant = '0' THEN 'No'
	WHEN SoldAsVacant = '1' THEN 'Yes'
	ELSE SoldAsVacant
	END



