# Nashville Housing Data Cleaning Project

This repository contains SQL scripts used to clean the Nashville housing dataset. The primary goal of these scripts is to prepare the data for further analysis by addressing inconsistencies and structuring the information more effectively.

## Overview of Cleaning Steps

The SQL script performs the following data cleaning operations:

* **Populating Null Property Addresses:** Identifies and fills in missing `PropertyAddress` values based on matching `ParcelID` from other records.
* **Breaking Down Property Address:** Splits the `PropertyAddress` column into separate `PropertyAddressSplit` (street address) and `PropertyCity` columns.
* **Standardizing Owner Address:** Parses the `OwnerAddress` column into `OwnerAddressSplit`, `OwnerCity`, and `OwnerState` columns.
* **Standardizing SoldAsVacant Field:** Converts the `SoldAsVacant` column values from '0' and '1' to 'No' and 'Yes' respectively, and changes the column's data type.

## Contents

The repository includes the following file:

* `NashvilleHousingDataCleaning.sql`: The main SQL script containing all the data cleaning steps outlined above.
*  `Nashville Housing Data For Cleaning.csv`: The main data used in this repository. Data describes sales information about properties in Nashville, TN.

## Usage

To use this script, you will need:

1.  SQL Server installed.
2.  The `NashvilleHousingData` database with the `NashvilleHousingData` table loaded.

Simply execute the `NashvilleHousingDataCleaning.sql` script against your SQL Server database containing the `NashvilleHousingData` table.

## Notes

* The script assumes the `NashvilleHousingData` table exists in the `NashVilleHousing` database. Adjust the database and table names in the script if necessary.
* The script makes changes directly to the `NashvilleHousingData` table. It is recommended to back up your data before running the script.
