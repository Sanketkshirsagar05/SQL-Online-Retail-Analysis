--Query 21: Retrieve All Products with Category Names
--Using the vw_ProductDetails view to get a list of all products along with their category names.
SELECT * FROM vw_ProductDeails;

--Query 22: Retrieve Products within a Specific Price Range
--Using the vw_ProductDetails view to find products priced between $100 and $500.
SELECT * FROM vw_ProductDeails WHERE Price BETWEEN 10 AND 500;

--Query 23: Count the Number of Products in Each Category
--Using the vw_ProductDetails view to count the number of products in each category.
SELECT CategoryName, Count(ProductID) AS ProductCount
FROM vw_ProductDeails GROUP BY CategoryName; 

--Query 24: Retrieve Customers with More Than 1 Orders
--Using the vw_CustomerOrders view to find customers who have placed more than 1 orders.
SELECT * FROM vw_CustomerOrders WHERE TotalOrders > 1;

--Query 25: Retrieve the Total Amount Spent by Each Customer
--Using the vw_CustomerOrders view to get the total amount spent by each customer.
SELECT CustomerID, FirstName, LastName, TotalAmount FROM vw_CustomerOrders
ORDER BY TotalAmount DESC;

--Query 26: Retrieve Recent Orders Above a Certain Amount
--Using the vw_RecentOrders view to find recent orders where the total amount is greater than $1000.
SELECT * FROM vw_RecentOrders WHERE OrderAmount > 1000;

--Query 27: Retrieve the Latest Order for Each Customer
--Using the vw_RecentOrders view to find the latest order placed by each customer.
SELECT ro.OrderID, ro.OrderDate, ro.CustomerID, ro.FirstName, ro.LastName, ro.OrderAmount
FROM vw_RecentOrders ro
INNER JOIN 
(SELECT CustomerID, Max(OrderDate) as LatestOrderDate FROM vw_RecentOrders GROUP BY CustomerID)
latest
ON ro.CustomerID = latest.CustomerID AND ro.OrderDate = latest.LatestOrderDate
ORDER BY ro.OrderDate DESC;
GO

--Query 28: Retrieve Products in a Specific Category
--Using the vw_ProductDetails view to get all products in a specific category, such as 'Electronics'.
SELECT * FROM vw_ProductDeails WHERE CategoryName = 'Books';

--Query 29: Retrieve Total Sales for Each Category
--Using the vw_ProductDetails and vw_CustomerOrders views to calculate the total sales for each category.
SELECT pd.CategoryName, SUM(oi.Quantity * p.Price) AS TotalSales
FROM OrderItems oi
INNER JOIN Products p ON oi.ProductID = p.ProductID
INNER JOIN vw_ProductDeails pd ON p.ProductID = pd.ProductID
GROUP BY pd.CategoryName
ORDER BY TotalSales DESC;

--Query 30: Retrieve Customer Orders with Product Details
--Using the vw_CustomerOrders and vw_ProductDetails views to get customer orders along with the details 
-- of the products ordered.
SELECT co.CustomerID, co.FirstName, co.LastName, o.OrderID, o.OrderDate,
pd.ProductName, oi.Quantity, pd.Price
FROM Orders o 
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN vw_ProductDeails pd ON oi.ProductID = pd.ProductID
INNER JOIN vw_CustomerOrders co ON o.CustomerID = co.CustomerID
ORDER BY o.OrderDate DESC;

--Query 31: Retrieve Top 5 Customers by Total Spending
--Using the vw_CustomerOrders view to find the top 5 customers based on their total spending.
SELECT TOP 5 CustomerID, FirstName, LastName, TotalAmount 
FROM vw_CustomerOrders ORDER BY TotalAmount DESC;

--Query 32: Retrieve Products with Low Stock
--Using the vw_ProductDetails view to find products with stock below a certain threshold, such as 10 units.
SELECT * FROM vw_ProductDeails WHERE Stock < 50;

--Query 33: Retrieve Orders Placed in the Last 7 Days
--Using the vw_RecentOrders view to find orders placed in the last 7 days.
SELECT * from vw_RecentOrders WHERE OrderDate >= DATEADD(DAY, -7, GETDATE());

--Query 34: Retrieve Products Sold in the Last Month
--Using the vw_RecentOrders view to find products sold in the last month.
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity) AS TotalSold
FROM vw_RecentOrders ro
INNER JOIN OrderItems oi ON ro.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID
WHERE ro.OrderDate >= DATEADD(MONTH, -1, GETDATE())
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSold DESC;