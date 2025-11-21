/*
=========================================================
Security / Role-Based Access Control (RBAC)
=========================================================

### Step 1: Create Logins
----------------------------------
*/
-- Create a login with SQL Server Authentication
CREATE LOGIN SalesUser WITH PASSWORD = 'strongpassword';

/*
### Step 2: Create Users
----------------------------------
*/
USE OnlineRetail;
GO

-- Create a user in the database for the SQL Server Login
CREATE USER SalesUser FOR LOGIN SalesUser;


/*
### Step 3: Create Roles
----------------------------------
*/
-- Create roles in the database
CREATE ROLE SalesRole;
CREATE ROLE MarketingRole;

/*
### Step 4: Assign Users to Roles
----------------------------------
*/
-- Add users to roles
EXEC sp_addrolemember 'SalesRole', 'SalesUser';

/*
### Step 5: Grant Permissions
----------------------------------
			Grant the necessary permissions to the roles based on the access requirements
*/
-- GRANT SELECT permission on the Customers Table to the SalesRole
GRANT SELECT ON Customers TO SalesRole;

-- GRANT INSERT permission on the Orders Table to the SalesRole
GRANT INSERT ON Orders TO SalesRole;

-- GRANT UPDATE permission on the Orders Table to the SalesRole
GRANT UPDATE ON Orders TO SalesRole;

-- GRANT SELECT permission on the Products Table to the SalesRole
GRANT SELECT ON Products TO SalesRole;

SELECT * FROM Customers;
DELETE FROM Customers;

SELECT * FROM Orders;
DELETE FROM Orders;
INSERT INTO Orders(CustomerId, OrderDate, TotalAmount)
VALUES (1, GETDATE(), 600);

SELECT * FROM Products;
DELETE FROM Products;

/*
### Step 6: Revoke Permissions (if needed)
----------------------------------
*/
-- REVOKE INSERT permission on the Orders to the SalesRole
REVOKE INSERT ON Orders FROM SalesRole;

/* 
### Step 7: View Effective Permissions
----------------------------------
*/

SELECT * FROM fn_my_permissions(NULL,'DATABASE');
