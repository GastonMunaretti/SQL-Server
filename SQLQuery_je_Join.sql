Select 'A' AS [Conjunto A], 'A' As [Conjunto B]
Union
Select 'B' AS [Conjunto A], 'B' As [Conjunto B]
Union
Select 'C' AS [Conjunto A], 'E' As [Conjunto B]
Union
Select 'D' AS [Conjunto A], 'F' As [Conjunto B]

------------------------------------------------------------------------A JOIN B---------------------------------------------------------------------------

Select 'ESTO ES A JOIN B' AS TITULO

Select *

From   
(Select 'A' As 'Conjunto A'
Union  
Select 'B' As 'Conjunto A'
Union
Select 'C' As 'Conjunto A'
Union
Select 'D' As 'Conjunto A')  A

Join (Select 'A' As 'Conjunto B'
Union  
Select 'B' As 'Conjunto B'
Union
Select 'E' As 'Conjunto B'
Union
Select 'F' As 'Conjunto B')  B On
A.[Conjunto A] = B.[Conjunto B]

----------------------------------------------------------------------A LEFT JOIN B------------------------------------------------------------------------


Select 'ESTO ES A LEFT JOIN B' AS TITULO


Select *

From   
(Select 'A' As 'Conjunto A'
Union  
Select 'B' As 'Conjunto A'
Union
Select 'C' As 'Conjunto A'
Union
Select 'D' As 'Conjunto A')  A

Left Join (Select 'A' As 'Conjunto B'
Union  
Select 'B' As 'Conjunto B'
Union
Select 'E' As 'Conjunto B'
Union
Select 'F' As 'Conjunto B')  B On
A.[Conjunto A] = B.[Conjunto B]


----------------------------------------------------------------------A RIGHT JOIN B------------------------------------------------------------------------


Select 'ESTO ES A RIGHT JOIN B' AS TITULO


Select *

From   
(Select 'A' As 'Conjunto A'
Union  
Select 'B' As 'Conjunto A'
Union
Select 'C' As 'Conjunto A'
Union
Select 'D' As 'Conjunto A')  A

Right Join (Select 'A' As 'Conjunto B'
Union  
Select 'B' As 'Conjunto B'
Union
Select 'E' As 'Conjunto B'
Union
Select 'F' As 'Conjunto B')  B On
A.[Conjunto A] = B.[Conjunto B]

-------------------------------------------------------------------------FULL JOIN------------------------------------------------------------------------

Select 'ESTO ES FULL JOIN' AS TITULO


Select *

From   
(Select 'A' As 'Conjunto A'
Union  
Select 'B' As 'Conjunto A'
Union
Select 'C' As 'Conjunto A'
Union
Select 'D' As 'Conjunto A')  A

Full Join (Select 'A' As 'Conjunto B'
Union  
Select 'B' As 'Conjunto B'
Union
Select 'E' As 'Conjunto B'
Union
Select 'F' As 'Conjunto B')  B On
A.[Conjunto A] = B.[Conjunto B]

-----------------------------------------------------------------------A CROSS JOIN B----------------------------------------------------------------------

Select 'ESTO ES A CROSS JOIN B' AS TITULO


Select *

From   
(Select 'A' As 'Conjunto A'
Union  
Select 'B' As 'Conjunto A'
Union
Select 'C' As 'Conjunto A'
Union
Select 'D' As 'Conjunto A')  A

Cross Join (Select 'A' As 'Conjunto B'
Union  
Select 'B' As 'Conjunto B'
Union
Select 'E' As 'Conjunto B'
Union
Select 'F' As 'Conjunto B') B
