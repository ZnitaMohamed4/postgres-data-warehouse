/*
=============================================================
Create Schemas
=============================================================
Purpose:
    Creates the 'bronze', 'silver' and 'gold' schemas
    (Medallion Architecture). Run while connected to
    'datawarehouse'.
=============================================================
*/

CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;