/*pregunta 1
Selecciona el nombre de los productos vendidos por todos los empleados.*/
SELECT p.ProductName
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY p.ProductID, p.ProductName
HAVING COUNT(DISTINCT o.EmployeeID) = (
    SELECT COUNT(*) FROM Employees
);

/*pregunta 2
Selecciona el nombre de los clientes que compraron solo productos con un precio menor a 50.*/
SELECT c.CompanyName
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE o.CustomerID = c.CustomerID
      AND p.UnitPrice >= 50
);

/*pregunta 3
Selecciona el cargo (título) y el nombre de los empleados que han vendido al menos uno de los productos 'Gravad Lax' o 'Mishi Kobe Niku'.*/
SELECT DISTINCT e.Title, e.FirstName, e.LastName
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName IN ('Gravad Lax', 'Mishi Kobe Niku');


/*pregunta 4
Selecciona el nombre del empleado y el nombre del cliente para los pedidos enviados por Speedy Express a clientes que viven en Brussels (Bruselas).*/
SELECT e.FirstName, e.LastName, c.CompanyName
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Shippers s ON o.ShipVia = s.ShipperID
WHERE s.CompanyName = 'Speedy Express'
  AND c.City = 'Bruxelles';


/*pregunta 5
Selecciona el nombre, dirección, ciudad y región de los empleados que han gestionado pedidos con entrega en Belgium (Bélgica).*/
  SELECT DISTINCT e.FirstName, e.LastName, e.Address, e.City, e.Region
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.ShipCountry = 'Belgium';

