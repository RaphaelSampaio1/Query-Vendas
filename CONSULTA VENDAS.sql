-- ME MOSTRE OS COMRRADORES QUE COMPRARAM MAIS DE UMA VEZ NA LOJA, E QUANTAS COMPRAS FIZERAM, ORDERNANDO-AS
-- DA PRIMEIRA ATÉ A ULTIMA


SELECT 
		CONCAT(PP.FirstName,' ',PP.LastName) Comprador,
		P.Name Produto,
		SS.OrderQty Quantidade,
		FORMAT(SUM(SS.LINETOTAL) OVER(PARTITION BY SS.PRODUCTID),'C') AS 'Valor Total Compra',
		ROW_NUMBER() OVER (PARTITION BY SS.OrderQty ORDER BY PP.BusinessEntityID) AS 'QTD Ordem',
		S.DueDate AS 'Data de Compra'		
FROM Sales.SalesOrderDetail SS
INNER JOIN Production.Product P
ON
		SS.ProductID = P.ProductID
JOIN SALES.SalesOrderHeader S
ON
		S.SalesOrderID = SS.SalesOrderID
JOIN Person.Person PP
ON
		PP.BusinessEntityID = S.SalesPersonID