/*-----------------------------------------------------------------------------
Hands-On Lab: Data Engineering with Snowpark
Script:       01_setup_snowflake.sql
Author:       Jeremiah Hansen
Last Updated: 1/1/2023
-----------------------------------------------------------------------------*/


-- ----------------------------------------------------------------------------
-- Step #1: Accept Anaconda Terms & Conditions
-- ----------------------------------------------------------------------------

-- See Getting Started section in Third-Party Packages (https://docs.snowflake.com/en/developer-guide/udf/python/udf-python-packages.html#getting-started)


-- ----------------------------------------------------------------------------
-- Step #2: Create the account level objects
-- ----------------------------------------------------------------------------
USE ROLE ACCOUNTADMIN;

-- Roles
SET MY_USER = CURRENT_USER();
CREATE OR REPLACE ROLE MZ_HOL_ROLE;
GRANT ROLE MZ_HOL_ROLE TO ROLE SYSADMIN;
GRANT ROLE MZ_HOL_ROLE TO USER IDENTIFIER($MY_USER);

GRANT EXECUTE TASK ON ACCOUNT TO ROLE MZ_HOL_ROLE;
GRANT MONITOR EXECUTION ON ACCOUNT TO ROLE MZ_HOL_ROLE;
GRANT IMPORTED PRIVILEGES ON DATABASE SNOWFLAKE TO ROLE MZ_HOL_ROLE;

-- Databases
CREATE OR REPLACE DATABASE MZ_HOL_DB;
GRANT OWNERSHIP ON DATABASE MZ_HOL_DB TO ROLE MZ_HOL_ROLE;

-- Warehouses
CREATE OR REPLACE WAREHOUSE MZ_HOL_WH WAREHOUSE_SIZE = XSMALL, AUTO_SUSPEND = 300, AUTO_RESUME= TRUE;
GRANT OWNERSHIP ON WAREHOUSE MZ_HOL_WH TO ROLE MZ_HOL_ROLE;


-- ----------------------------------------------------------------------------
-- Step #3: Create the database level objects
-- ----------------------------------------------------------------------------
USE ROLE MZ_HOL_ROLE;
USE WAREHOUSE MZ_HOL_WH;
USE DATABASE MZ_HOL_DB;

-- Schemas
CREATE OR REPLACE SCHEMA EXTERNAL;
CREATE OR REPLACE SCHEMA RAW_POS;
CREATE OR REPLACE SCHEMA RAW_CUSTOMER;
CREATE OR REPLACE SCHEMA HARMONIZED;
CREATE OR REPLACE SCHEMA ANALYTICS;

-- External Frostbyte objects
USE SCHEMA EXTERNAL;
CREATE OR REPLACE FILE FORMAT PARQUET_FORMAT
    TYPE = PARQUET
    COMPRESSION = SNAPPY
;
CREATE OR REPLACE STAGE FROSTBYTE_RAW_STAGE
    URL = 's3://sfquickstarts/data-engineering-with-snowpark-python/'
;

-- ANALYTICS objects
USE SCHEMA ANALYTICS;
-- This will be added in step 5
--CREATE OR REPLACE FUNCTION ANALYTICS.FAHRENHEIT_TO_CELSIUS_UDF(TEMP_F NUMBER(35,4))
--RETURNS NUMBER(35,4)
--AS
--$$
--    (temp_f - 32) * (5/9)
--$$;

CREATE OR REPLACE FUNCTION ANALYTICS.INCH_TO_MILLIMETER_UDF(INCH NUMBER(35,4))
RETURNS NUMBER(35,4)
    AS
$$
    inch * 25.4
$$;
