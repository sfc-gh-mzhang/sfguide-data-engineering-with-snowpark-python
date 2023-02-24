/*-----------------------------------------------------------------------------
Hands-On Lab: Data Engineering with Snowpark
Script:       11_teardown.sql
Author:       Jeremiah Hansen
Last Updated: 1/9/2023
-----------------------------------------------------------------------------*/


USE ROLE ACCOUNTADMIN;

DROP DATABASE MZ_HOL_DB;
DROP WAREHOUSE MZ_HOL_WH;
DROP ROLE MZ_HOL_ROLE;

-- Drop the weather share
--DROP DATABASE FROSTBYTE_WEATHERSOURCE;
