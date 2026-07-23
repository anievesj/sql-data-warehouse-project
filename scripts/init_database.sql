/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists.
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
    within the database: 'bronze', 'silver', and 'gold'.

WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists.
    All data in the database will be permanently deleted. Proceed with caution
    and ensure you have proper backups before running this script.

NOTE (PostgreSQL vs SQL Server):
    PostgreSQL has no USE or GO statements, and you cannot DROP or CREATE a database
    while connected to it. Because of that, this script is split into two parts that
    must be run against two different connections.
*/

-- =============================================================
-- PART 1: run this while connected to the 'postgres' database
-- (NOT 'DataWarehouse' — Postgres won't let you drop/create a
-- database you're currently connected to)
-- =============================================================

-- Terminate any active connections to 'DataWarehouse' so it can be dropped
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'DataWarehouse' AND pid <> pg_backend_pid();

-- Drop and recreate the 'DataWarehouse' database
DROP DATABASE IF EXISTS "DataWarehouse";

CREATE DATABASE "DataWarehouse";

-- =============================================================
-- PART 2: switch your connection to 'DataWarehouse' before running
-- this part (in psql: \c DataWarehouse; in a GUI tool, open a new
-- query against the DataWarehouse connection instead of postgres)
-- =============================================================

-- Create Schemas
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;
