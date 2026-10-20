/*
=============================================================
Create Database
=============================================================
Purpose:
    Drops and recreates the 'datawarehouse' database.
    Run while connected to the 'postgres' database.

WARNING:
    Deletes the 'datawarehouse' database and all its data
    permanently. Proceed with caution.
=============================================================
*/

DROP DATABASE IF EXISTS datawarehouse WITH (FORCE);
CREATE DATABASE datawarehouse;