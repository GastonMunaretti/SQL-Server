
/*
CREATE TABLE categorias
(
    cate_codigo   INT NOT NULL PRIMARY KEY,
    cate_nombre   VARCHAR(20),
    cate_nivel    VARCHAR(10),
    -- Aqu� indicamos la pertenencia de categor�a
    cate_padre    INT,  
    -- Luego, se crea la clave for�nea recursiva
    CONSTRAINT   fk_categoria_padre                 
    FOREIGN KEY(cate_padre) REFERENCES categorias
);

*/

/*
INSERT INTO categorias 
VALUES
( 10    ,'COMIDA'       , 1 , NULL  ),
( 20    ,'ASEO'         , 1 , NULL  ),
( 30    ,'VESTUARIO'    , 1 , NULL  ),
( 1010  ,'LACTEOS'      , 2 , 10    ),
( 1020  ,'CONSERVAS'    , 2 , 10    ),
( 1030  ,'ABARROTES'    , 2 , 10    ),
( 2010  ,'DETERGENTE'   , 2 , 20    ),
( 2020  ,'SUAVIZANTE'   , 2 , 20    ),
( 2030  ,'CERAS'        , 2 , 20    ),
( 101010,'YOGURTH'      , 3 , 1010  ),
( 101020,'LECHE'        , 3 , 1010  ),
( 101030,'QUESOS'       , 3 , 1010  );

*/




















/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [cate_codigo]
      ,[cate_nombre]
      ,[cate_nivel]
      ,[cate_padre]
  FROM [Pruebas].[dbo].[categorias];



-- Desde el nivel superior a los inferiones 
WITH
categoriasCTE ( codigo, nombre, nivel, padre)
AS
(   SELECT cate_codigo, cate_nombre, cate_nivel, cate_padre 
    FROM categorias 
    WHERE cate_codigo = 10 -- Categor�a COMIDA
    UNION ALL
    -- Aqu� va la recursividad
    SELECT A.cate_codigo, A.cate_nombre, 
           A.cate_nivel,  A.cate_padre 
    FROM   categorias AS A 
           INNER JOIN categoriasCTE AS E -- Llamada a si misma
    ON (A.cate_padre = E.codigo) 
)
SELECT * FROM categoriasCTE;




-- Desde el nivel superior a los inferiores 
WITH
categoriasCTE( codigo, nombre, nivel, padre)
AS
(   SELECT cate_codigo, cate_nombre, cate_nivel, cate_padre 
    FROM categorias 
    WHERE cate_codigo = 101030 -- Categor�a QUESOS
    UNION ALL
    -- Aqu� va la recursividad
    SELECT A.cate_codigo, A.cate_nombre, 
           A.cate_nivel,  A.cate_padre 
    FROM   categorias AS A 
           INNER JOIN categoriasCTE AS E -- Llamada a si misma
    ON (A.cate_codigo = E.padre ) -- Uni�n invertida
)
SELECT * FROM categoriasCTE WHERE nivel=1;
