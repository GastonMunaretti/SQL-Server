# -*- coding: utf-8 -*-
"""
Created on Wed Apr 22 20:03:15 2020

@author: Cuelo
"""

import pyodbc
import sys
import pandas as pd
import numpy as np


TablaOrigen = "SolicitudCompraCabecera"
SinonimoTablaNueva = "[dbo].[MOD_"+TablaOrigen+"]"    #Es el sinonimo de la tabla pasada desde sql al llamar al script
TablaNueva = "MOD_"+TablaOrigen                    # Nombre de la tabla

QueryVista = "Exec sp_columns SolicitudCompraCabecera"
lookup = "_LOOKUP"
codigo = "odigo"


# Conexion con base de datos
conn = pyodbc.connect('Driver={SQL Server};'
                          'Server=ARAXDEVSQL;'
                          'Database=ITCAXDEV;'
                          'Trusted_Connection=yes;')


# definir vista de origen

f = open(TablaOrigen, "w+")
cursor = conn.cursor()
cursor.execute(QueryVista)

# devuelve laws filas de la tabla
filas = cursor.fetchall()

# Se pasa a matriz para mejor tratamiento de los datos
matriz =np.array(filas)

#############################Codigo de prueba

#matriz[:,17]

################################################

# Se toman los datos de interes
tablita = matriz[:,[3,4,5,6,7,8,17]] #+ matriz[:,17]

tablita

# Se convierte a dataframe y se agregan los nombres de las columnas
data_look= pd.DataFrame(tablita,columns=['COLUMN_NAME', 'DATA_TYPE', 'TYPE_NAME','PRECISION','LENGTH','SCALE','ISNULLABLE'])
data=pd.DataFrame(tablita,columns=['COLUMN_NAME', 'DATA_TYPE', 'TYPE_NAME','PRECISION','LENGTH','SCALE','ISNULLABLE'])

for index, r in data.iterrows():   #eliminamos los _LOOKUP de las variables que lo contienen
   if lookup in r["COLUMN_NAME"]:
        r["COLUMN_NAME"] = r["COLUMN_NAME"][:-7]

data1=data.replace("YES","NULL")
data2=data1.replace("NO","NOT NULL")
data2  #datafrafe para crear las tablas



##############################################################################
# forma correcta de obtener los datos

#for index, row in data.iterrows():
#       print (row["COLUMN_NAME"] + "   "+ str(row["TYPE_NAME"])+ "   " + str(row["LENGTH"]))

##############################################################################
# Ejemplos de cadenas       
       
#texto = "dfjkdfjdfjkdfjkdfjdjdfjdfjdfjdfkdfjkdfjdfkjdfkjdfkjdfkjdfkjdfkfdjkdfjdfj"\
#        "kjkdfjkfdjdfjdfjkdfjdfkjdfkjfkjdfkjfdkdfjkdfjkdfjfdkjdfkjdkdjfkjdkjfkjdfkfd"\
#        "jksdjksdfjksdjksdjksdjsdkjskjdkjskjdkjsksdjksdjksdjsdkjsdkjsdjsdksdjksdjksdj"

#print(texto)

#hola = "Esta es:\nuna larga cadena que contiene\n\
#varias líneas de texto, tal y como se hace en C.\n\
#    Notar que los espacios en blanco al principio de la linea\
# son significantes."

#print (hola)

###############################################################################
str1="\n\
\n\
CREATE PROCEDURE [dbo].[INSERTAR_"+TablaNueva+"]\n"

#print(str1)



###############################################################################
retorno = ""

for index, r in data.iterrows(): 
        
    if r["TYPE_NAME"] == "numeric" or r["TYPE_NAME"] == "decimal":
        retorno+= "@r_DWH_" + r["COLUMN_NAME"] + "\t\t\t\t\t" + r["TYPE_NAME"] + "(" + str(r["PRECISION"]) + ","  + str(r["SCALE"]) + ")," +"\n"
    elif r["TYPE_NAME"] == "varchar" or r["TYPE_NAME"] == "nvarchar":
        retorno+= "@r_DWH_" + r["COLUMN_NAME"] + "\t\t\t\t\t" + r["TYPE_NAME"] + "(" + str(r["LENGTH"])  + ")," +"\n"      
    else: 
        retorno+= "@r_DWH_" + r["COLUMN_NAME"] + "\t\t\t\t\t" + r["TYPE_NAME"] + ",\n"

output1=retorno[:-2] #elimina los ultimos dos caracteres

#print(output1)
###############################################################################

str2=",\n\
@v_CantIns int = 0 OUTPUT,\n\
@v_CantUpd int = 0 OUTPUT \n\
AS\n\
\n\
BEGIN\n\
 \n\
  DECLARE @v_sqlcode int,@v_sqlerrm varchar(4000)\n\
--declara las variables de error \n\
  BEGIN TRY"
  
#print(str2)

###############################################################################
retorno3 = ""


retorno3 += "\t INSERT INTO " + TablaNueva + "(\n"

for index, r in data.iterrows():
   retorno3+=  "\t\t\t " + TablaNueva + "." + r["COLUMN_NAME"] + ",\n"
aux = retorno3[:-2] 
aux += ")\n\t values (\n"
for index, r in data.iterrows():
   aux+= "\t\t\t " + "@r_DWH_" + r["COLUMN_NAME"] + ",\n"
retorno3 = aux[:-2] + ")"

output3=retorno3 

#print(output3)

###############################################################################
str3="\n\
\n\
 --primero trata de insertar\n\
    SET @v_CantIns = @v_CantIns + 1\n\
  -- si logra insertar incrementa en 1 la cantidad de registros insertados\n\
  END TRY\n\
  BEGIN CATCH\n\
\n\
    IF (ERROR_NUMBER() = 2627)\n\
    BEGIN"

#print(str3)

###############################################################################
retorno4 = ""
aux_where = ""


retorno4 += "\t UPDATE " + TablaNueva + " SET \n"

for index, r in data.iterrows():
	if codigo in r["COLUMN_NAME"]:
		aux_where += TablaNueva + "." + r["COLUMN_NAME"] + " = " +  "@r_DWH_" + r["COLUMN_NAME"] +" AND "
	retorno4+=  "\t\t\t " + TablaNueva + "." + r["COLUMN_NAME"] + " = " +  "@r_DWH_" + r["COLUMN_NAME"] +",\n"
retorno4 += "\t\t\t " + TablaNueva + "." +"FecUltAct = GETDATE() ,\n"
retorno4 += "\t\t\t " + TablaNueva + "." +"UsuUltAct = SUSER_SNAME()\n\n"
retorno4 += "\t\t\t WHERE " + aux_where[:-4]

output4=retorno4

#print(output4)

###############################################################################
str4="     SET @v_CantUpd = @v_CantUpd + @@ROWCOUNT \n\
    END\n\
    ELSE\n\
    BEGIN\n\
      SET @v_sqlcode = 50000 + ERROR_NUMBER()\n\
      SET @v_sqlerrm = CAST(ERROR_NUMBER() AS VARCHAR) + ':'  + ERROR_MESSAGE()\n\
      RAISERROR (@v_sqlcode,-1,-1, @v_sqlerrm)\n\
    END\n\
 \n\
  END CATCH\n\
END"

#print(str4)

###############################################################################

query =  str1 + output1 +str2 + output3 + str3 + output4 + str4
#print(query)

###############################################################################

conn2 = pyodbc.connect('Driver={SQL Server};'
                          'Server=eze-devsql\developer;'
                          'Database=ModeloDeNegocio;'
                          'Trusted_Connection=yes;')

cursor2 = conn2.cursor()

try:
        cursor2 = conn2.cursor()
        cursor2.execute(query)
        cursor2.execute(" COMMIT ")
except pyodbc.Error as ex:
        print ("Error !!!!!" + ex.args[0])
f = open(TablaNueva, "w+")
f.write(query)
f.close()


###############################################################################
###############################################################################
###############################################################################
############################## MAP ############################################

str5 ="CREATE PROCEDURE [dbo].[MAP_" + TablaNueva + "]\n\
@pFRECUENCIA_COMMIT int = null,\n\
@pMAX_ERRORS int = null,\n\
@pNIVEL_AUDITORIA varchar(20) = null\n\
/*\n\
@pFRECUENCIA_COMMIT :  esta variable es opcional e indica cada tantas operaciones debe hacer un commit, el valor por defaul es 100\n\
@pMAX_ERRORS : esta variable es opcional e indica la maxima cantidad de errores que puede permitir el proceso, si las supera el proceso cancela por Demasiados errores el valor por default depende del proceso\n\
@pNIVEL_AUDITORIA : esta varible en este momento no se esta utilizando y es para definir el nivel de detalle con el que debe  loguear el proceso\n\
*/\n\
AS\n\
BEGIN\n\n\
  SET ANSI_DEFAULTS ON\n\
/* \n\
Cuando se habilita (ON), esta opción habilita las opciones siguientes de ISO:\n\
\n\
SET ANSI_NULLS\n\
SET CURSOR_CLOSE_ON_COMMIT\n\n\
SET ANSI_NULL_DFLT_ON\n\
SET IMPLICIT_TRANSACTIONS\n\n\
SET ANSI_PADDING\n\
SET QUOTED_IDENTIFIER\n\n\
SET ANSI_WARNINGS\n\
\n\
\n\
*/\n\
  SET CURSOR_CLOSE_ON_COMMIT OFF\n\
/*\n\
Si SET CURSOR_CLOSE_ON_COMMIT es OFF, no se cierra el cursor cuando se confirma una transacción.\n\
*/\n\
  SET CONCAT_NULL_YIELDS_NULL OFF\n\
/*\n\
Cuando SET CONCAT_NULL_YIELDS_NULL es ON, al concatenar un valor NULL con una cadena se produce como resultado NULL. Por ejemplo, SELECT 'abc' + NULL produce NULL. Cuando SET CONCAT_NULL_YIELDS_NULL es OFF, al concatenar un valor NULL con una cadena se obtiene la propia cadena (el valor NULL se trata como una cadena vacía). Por ejemplo, SELECT 'abc' + NULL produce abc.\n\
*/\n\
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED\n\
/*\n\
Especifica que las instrucciones no pueden leer datos que hayan sido modificados, pero no confirmados, por otras transacciones. Esto evita las lecturas de datos sucios. Otras transacciones pueden cambiar datos entre cada una de las instrucciones de la transacción actual, dando como resultado lecturas no repetibles o datos ficticios. \n\
*/\n\
  SET NOCOUNT ON\n\
 /*\n\
SET NOCOUNT ON impide el envío al cliente de mensajes DONE_IN_PROC por cada instrucción de un procedimiento almacenado. \n\
*/\n\n\
SET DATEFORMAT ymd\n\n\
\
  DECLARE @cPROC_NAME          varchar(100),\n\
          @cFILE_NAME          varchar(30),\n\
          @vTIPO_ACTUALIZACION varchar(20),\n\
          @v_CantReg           int,\n\
          @v_CantIns           int,\n\
          @v_CantUpd           int,\n\
          @v_CantErrors        int,\n\
          @vFRECUENCIA_COMMIT  int,\n\
          @vMAX_ERRORS         int,\n\
          @vNIVEL_AUDITORIA    varchar(20),\n\
          @v_sqlcode           int,\n\
          @v_sqlerrm           varchar(4000),\n\
          @vRUN_ID             int,\n\
          @v_shortsqlerrm      varchar(100),\n\
          @vValues             varchar(4000)\n\
\n\
/* \n\
  definicion de varibles generales del stored procedure\n\
*/\n\
\n\
  SET @cFILE_NAME ='SinonimoTablaNueva'\n\
  SET @cPROC_NAME = 'MAP_"+TablaNueva+"'\n\
  SET @v_sqlcode = 50000\n\
  SET @v_shortsqlerrm = ''\n\
\n\
/* \n\
  seteo de varibles generales del stored procedure\n\
*/\n\
"
print(str5)



###############################################################################
retorno5 = "\nDECLARE "

for index, r in data.iterrows():     
    if r["TYPE_NAME"] == "numeric" or r["TYPE_NAME"] == "decimal":
        retorno5+= "@r_Input1_" + r["COLUMN_NAME"] + "\t\t\t\t\t" + r["TYPE_NAME"] + "(" + str(r["PRECISION"]) + ","  + str(r["SCALE"]) + ")," +"\n"
    elif r["TYPE_NAME"] == "varchar" or r["TYPE_NAME"] == "nvarchar":
        retorno5+= "@r_Input1_" + r["COLUMN_NAME"] + "\t\t\t\t\t" + r["TYPE_NAME"] + "(" + str(r["LENGTH"])  + ")," +"\n"      
    else: 
        retorno5+= "@r_Input1_" + r["COLUMN_NAME"] + "\t\t\t\t\t" + r["TYPE_NAME"] + ",\n"

output5=retorno5[:-2] #elimina los ultimos dos caracteres

print(output5)



###############################################################################
retorno6 = "\n DECLARE "


for index, r in data.iterrows():     
    if r["TYPE_NAME"] == "numeric" or r["TYPE_NAME"] == "decimal":
        retorno6+= "@r_DWH_" + r["COLUMN_NAME"] + "\t\t\t\t\t" + r["TYPE_NAME"] + "(" + str(r["PRECISION"]) + ","  + str(r["SCALE"]) + ")," +"\n"
    elif r["TYPE_NAME"] == "varchar" or r["TYPE_NAME"] == "nvarchar":
        retorno6+= "@r_DWH_" + r["COLUMN_NAME"] + "\t\t\t\t\t" + r["TYPE_NAME"] + "(" + str(r["LENGTH"])  + ")," +"\n"      
    else: 
        retorno6+= "@r_DWH_" + r["COLUMN_NAME"] + "\t\t\t\t\t" + r["TYPE_NAME"] + ",\n"

output6=retorno6[:-2] #elimina los ultimos dos caracteres

print(output6)
###############################################################################

str6 = "\n\nBEGIN TRY\n\
-- se define para artapar todos los errores del proceso de mapeo\n\
\n\
    SET @v_CantReg = 0\n\
    SET @v_CantIns = 0\n\
    SET @v_CantUpd = 0\n\
    SET @v_CantErrors = 0\n\
\n\
    -- Inicializacion de variables\n\
\n\
\n\
    SET @vFRECUENCIA_COMMIT  = isnull(@pFRECUENCIA_COMMIT,  100);\n\
    SET @vMAX_ERRORS         = isnull(@pMAX_ERRORS,  0);\n\
\n\
    -- asginacion de los default en caso de no haber enviado los parametros al stored procedure\n\
\n\
    EXECUTE AU_MAP_RT_MAP_START @vRUN_ID OUTPUT, \n\
                                @cPROC_NAME,\n\
                                @vMAX_ERRORS,\n\
                                @vFRECUENCIA_COMMIT,\n\
                                'RRHH Ausentismo' \n\
\n\
   COMMIT\n\
\n\
/*\n\
  loguae el comienzo del proceso en la tabla au_jobs_procs y trae como parametro de salida @vRUN_ID \n\
  que es el ID del proceso en la tabla au_jobs_procs, para poderlo actualizar despues   \n\
*/ \n\
 \n\
	 /*\n\
	  Update A\n\
	  Set	 A.Activo = 0\n\
	  From	 MOD_Areas A\n\
			 Left JOin dbo.organigrama B On\n\
				A.CodigoArea = B.Id_Cuadro\n\
	  Where	 A.Activo is null\n\
	 */\n\
\n\
\n\
	  DECLARE	c_Input1 CURSOR FAST_FORWARD FOR\n\
\n\
      SELECT	*\n\
\n\
      FROM		"+TablaOrigen+"\n\
\n\
-- se define el cursor de entrada\n\
\n\
    OPEN c_Input1\n\
\n\
-- se abre al cursor\n\
"
print(str6)




###############################################################################
retorno7 = " FETCH c_Input1 INTO \n"


for index, r in data.iterrows():     
    retorno7+=  "\t\t" +"@r_Input1_" + r["COLUMN_NAME"] +  ",\n"
   

output7=retorno7[:-2] + "\n"#elimina los ultimos dos caracteres

print(output7)


###############################################################################


str7 = "\nWHILE (@@FETCH_STATUS = 0)\n\
    BEGIN\n\
-- se entra en un bucle hasta que se lean todas las filas del cursor de entrada\n\
\n\
      SET @v_CantReg = @v_CantReg + 1;\n\
\n\
      -- se incrementa en 1 el contador de registros leidos\n\
      BEGIN TRY\n\
       /*\n\
         se define para artapar los errores que se producen en los insert o en la asignacion de valores\n\
      */\n\
        SET @v_sqlcode = 50000\n\
        SET @v_sqlerrm = ''\n\
"
print(str7)

#############################################dbo.MOD_Cursos_LOOKUP#############
retorno8 = ""


for index, r in data_look.iterrows():  
    if lookup in r["COLUMN_NAME"]:
        NombreColumna = r["COLUMN_NAME"][:-7]
        retorno8+=  "\t\tSET " + "@r_DWH_" + NombreColumna +" = dbo.MOD_"+ NombreColumna[2:] +"_LOOKUP(@r_Input1_" + NombreColumna +  ")\n"
    else:
        retorno8+=  "\t\tSET " + "@r_DWH_" + r["COLUMN_NAME"] +" =  @r_Input1_" + r["COLUMN_NAME"] +  "\n"
   

output8=retorno8 #elimina los ultimos dos caracteres

print(output8)



###############################################################################

retorno9 = "\nEXECUTE INSERTAR_"+TablaNueva+" \n"


for index, r in data.iterrows():     
    retorno9+=  "\t\t" + "@r_DWH_" + r["COLUMN_NAME"] +  ",\n"
   

output9=retorno9 +"\t\t"+ "@v_CantIns OUTPUT,\n" +"\t\t"+ "@v_CantUpd OUTPUT"  #elimina los ultimos dos caracteres

print(output9)

###############################################################################
# data.iloc[0,0] Extraer un solo dato
data["TYPE_NAME"]
###########################
str8 = " \n\
      END TRY\n\
      BEGIN CATCH\n\
       \n\
        SET @v_sqlcode = ERROR_NUMBER()\n\
        SET @v_sqlerrm = ERROR_MESSAGE()\n\
        /*\n\
          Guarda los valores de ERROR_NUMBER() y ERROR_MESSAGE()\n\
          ERROR_NUMBER(): Devuelve el número de error del error que ha provocado la ejecución del bloque CATCH de una construcción TRY…CATCH.\n\
\n\
          ERROR_MESSAGE(): Devuelve el texto del mensaje del error que ha provocado la ejecución del bloque CATCH de una construcción TRY…CATCH.\n\
\n\
       */\n\
        IF XACT_STATE() = -1\n\
        BEGIN\n\
          ROLLBACK\n\
        END  \n\
        /*\n\
        Función escalar que notifica el estado de la transacción de usuario de una solicitud que se está ejecutando                 actualmente.Cuando tiene el valor -1 la solicitud actual tiene una transacción de usuario activa, pero se ha         producido un error por el cual la transacción se clasificó como no confirmable. La solicitud no puede confirmar la transacción o revertirla a un punto de retorno; sólo puede solicitar que la transacción se revierta completamente\n\
        */ \n\
        SET @v_CantErrors = @v_CantErrors + 1;\n\
        -- se incrementa en uno la cantidad de errores\n\
\n\
        SET @vValues = 'Codigo' + CAST(@r_DWH_"+ data.iloc[0,0] +" as VARCHAR(50))  \n\
        EXECUTE AU_MAP_RT_MAP_ERROR @vRUN_ID, @v_CantReg, @v_sqlcode, @v_sqlerrm, @vValues\n\
        -- loguea el error en la tabla au_errors\n\
      END CATCH\n\
\n\
\n\
      IF (@v_CantReg % @vFRECUENCIA_COMMIT) = 0\n\
      BEGIN\n\
\n\
          EXECUTE AU_MAP_RT_PROC_UPD_STATS @vRUN_ID,\n\
                                           @v_CantReg,\n\
                                           0,\n\
                                           @v_CantIns,\n\
                                           @v_CantUpd,\n\
                                           0,\n\
                                           @v_CantErrors\n\
\n\
        COMMIT\n\
\n\
      END\n\
      /*\n\
    verifica si tiene que realizar un commit y en ese caso tambien actualiza  los valores de cantidad de registros leidos,insertados,modificados y cantidad de errores en la\n\
       tabla au_jobs_procs \n\
       */\n\
\n\
      IF @v_CantErrors > @vMAX_ERRORS\n\
      BEGIN\n\
\n\
        SET @v_sqlerrm = 'Demasiados Errores (Máximo: ' + CAST(@vMAX_ERRORS as VARCHAR) + ')'\n\
        RAISERROR (51002,16,-1, @v_sqlerrm)		   \n\
\n\
      END\n\
      /*\n\
        Verifica que no se halla sobrepasado la cantidad maxima de errores indicada\n\
      */ \n\
      -- Gestion siguiente registro\n\
"
print(str8)

###############################################################################
output10 = output7 +"\n"
print(output10) 


###############################################################################

str9 = "\nEND\n\
\n\
\n\
			\n\
\n\
\n\
      EXECUTE AU_MAP_RT_PROC_UPD_STATS @vRUN_ID,\n\
                                       @v_CantReg,\n\
                                       0,\n\
                                       @v_CantIns,\n\
                                       @v_CantUpd,\n\
                                       0,\n\
                                       @v_CantErrors\n\
									   \n\
\n\
	\n\
    COMMIT\n\
    /*\n\
       actualiza los valores de cantidad de registros leidos,insertados,modificados y cantidad de errores en la\n\
       tabla au_jobs_procs          \n\
    \n\
    */  \n\
    EXECUTE AU_MAP_RT_MAP_END_OK @vRUN_ID\n\
    COMMIT\n\
    -- este proceso AU_MAP_RT_MAP_END_OK actualiza la tabla au_jobs_procs indicando que termino bien el proceso\n\
    CLOSE c_Input1\n\
    --cierra el cursor\n\
    DEALLOCATE c_Input1\n\
    --libera el cursor\n\
  END TRY\n\
  BEGIN CATCH\n\
\n\
    SET @v_sqlcode = ERROR_NUMBER()	\n\
\n\
    SET @v_sqlerrm = ERROR_MESSAGE()\n\
\n\
        /*\n\
          Guarda los valores de ERROR_NUMBER() y ERROR_MESSAGE()\n\
          ERROR_NUMBER(): Devuelve el número de error del error que ha provocado la ejecución del bloque CATCH de una construcción TRY…CATCH.\n\
\n\
          ERROR_MESSAGE(): Devuelve el texto del mensaje del error que ha provocado la ejecución del bloque CATCH de una construcción TRY…CATCH. \n\
          \n\
\n\
        */\n\
\n\
    IF XACT_STATE() = -1\n\
    BEGIN	\n\
      ROLLBACK\n\
    END   \n\
        /*\n\
        Función escalar que notifica el estado de la transacción de usuario de una solicitud que se está ejecutando                 actualmente.Cuando tiene el valor -1 la solicitud actual tiene una transacción de usuario activa, pero se ha         producido un error por el cual la transacción se clasificó como no confirmable. La solicitud no puede confirmar la         transacción o revertirla a un punto de retorno; sólo puede solicitar que la transacción se revierta completamente\n\
        */ \n\
\n\
    IF cursor_Status('global','c_Input1') >= 0\n\
    BEGIN\n\
      CLOSE c_Input1\n\
    END\n\
    /*\n\
    Cierra el cursor si todavia esta abierto\n\
    */   \n\
    IF cursor_Status('global','c_Input1') >= -2\n\
    BEGIN\n\
      DEALLOCATE c_Input1\n\
    END\n\
    /*\n\
    Libera el cursor si todavia no fue liberado \n\
    */ \n\
    IF (@v_sqlcode = 51002)\n\
    BEGIN\n\
      SET @v_sqlerrm = 'Demasiados Errores: ' + CAST(@v_sqlcode AS VARCHAR) + ': ' + @v_sqlerrm\n\
      SET @v_shortsqlerrm = 'TOO_MANY_ERRORS' \n\
    END\n\
    ELSE\n\
    BEGIN\n\
      SET @v_sqlerrm = 'Error Inesperado: ' + CAST(@v_sqlcode AS VARCHAR) + ': ' + @v_sqlerrm\n\
      SET @v_shortsqlerrm = 'UNEXPECTED_ERROR' 	  \n\
	\n\
   END\n\
\n\
    EXECUTE MAP_ERROR @vRUN_ID , @v_CantReg,0,\n\
                      @v_CantIns,@v_CantUpd,0,\n\
                      @v_CantErrors,@v_shortsqlerrm,@v_sqlerrm\n\
    /*\n\
       actualiza los valores de cantidad de registros leidos,insertados,modificados y cantidad de errores y el error por el cual el proceso cancelo \n\
    */  \n\
  END CATCH\n\
 \n\
END\n\
"
print(str9)

###############################################################################

query2 =  str5 + output5 +  output6 + str6 + output7 + str7 + output8 + output9 + str8 + output10 +str9
print(query2)

try:
        cursor2 = conn2.cursor()
        cursor2.execute(query2)
        cursor2.execute(" COMMIT ")
except pyodbc.Error as ex:
        print ("Error !!!!!" + ex.args[0])
f = open(TablaNueva, "w+")
f.write(query2)
f.close()

################################################################################
################################################################################
#Creacion de tablas y claves primarias y unicas

str10 = "CREATE TABLE " + SinonimoTablaNueva + "(\n\
	[Id"+TablaNueva[4:]+"]\t\t\t\t\t[int] IDENTITY(1,1) NOT NULL,\n"
    
retorno10 = ""
aux_UK = ""
aux_L = ["","","","","","","",""]
i = 0
for index, r in data2.iterrows():     
    if r["TYPE_NAME"] == "numeric" or r["TYPE_NAME"] == "decimal":
        if codigo in r["COLUMN_NAME"]:
            aux_UK += "\t[" + r["COLUMN_NAME"] + "] ASC,\n " 
            aux_L[i] += r["COLUMN_NAME"]
            aux_L[i+1] += r["TYPE_NAME"] + " (" + str(r["PRECISION"]) + ","  + str(r["SCALE"]) + ") "
            i+=2
        retorno10+=   "\t[" + r["COLUMN_NAME"] + "]\t\t\t\t\t[" + r["TYPE_NAME"] + "] (" + str(r["PRECISION"]) + ","  + str(r["SCALE"]) + ") "+ r["ISNULLABLE"] +"," +"\n"
    elif r["TYPE_NAME"] == "varchar" or r["TYPE_NAME"] == "nvarchar":
        if codigo in r["COLUMN_NAME"]:
            aux_UK +=  "\t[" + r["COLUMN_NAME"] + "] ASC,\n "
            aux_L[i] += r["COLUMN_NAME"]
            aux_L[i+1] += r["TYPE_NAME"] + " (" + str(r["LENGTH"])  + ") "
            i+=2
        retorno10+=  "\t[" + r["COLUMN_NAME"] + "]\t\t\t\t\t[" + r["TYPE_NAME"] + "] (" + str(r["LENGTH"])  + ") "+ r["ISNULLABLE"] +"," +"\n"      
    else:
        if codigo in r["COLUMN_NAME"]:
             aux_UK +=  "\t[" + r["COLUMN_NAME"] + "] ASC,\n "
             aux_L[i] += r["COLUMN_NAME"]
             aux_L[i+1] += r["TYPE_NAME"]
             i+=2
        retorno10 +=  "\t[" + r["COLUMN_NAME"] + "]\t\t\t\t\t[" + r["TYPE_NAME"] + "] "+ r["ISNULLABLE"] +",\n"

output10= retorno10 #elimina los ultimos dos caracteres

   
str11 = "\t[FecUltAct] \t\t\t\t\t[datetime] NOT NULL,\n\
\t[UsuUltAct] \t\t\t\t\t[varchar](50) NOT NULL,\n\
CONSTRAINT [PK_"+TablaNueva + "] PRIMARY KEY CLUSTERED\n\
(\n\
\t[Id"+TablaNueva[4:]+"] ASC\n\
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],\n\
 CONSTRAINT [UK_MOD_"+TablaNueva[4:]+"] UNIQUE NONCLUSTERED\n\
 (\n" + aux_UK[:-3]+ "\n)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = ON, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]\n\
 ) ON [PRIMARY]\n\
\n\
ALTER TABLE [dbo].["+TablaNueva + "] ADD  CONSTRAINT [DF_FecUltAct_"+TablaNueva + "]  DEFAULT (getdate()) FOR [FecUltAct]\n\
\n\
ALTER TABLE [dbo].["+TablaNueva + "] ADD  CONSTRAINT [DF_UsuUltAct_"+TablaNueva + "]  DEFAULT (suser_sname()) FOR [UsuUltAct]\n"

print(str10+output10+str11)

query3 = str10+output10+str11



conn3 = pyodbc.connect('Driver={SQL Server};'
                          'Server=eze-devsql\developer;'
                          'Database=ModeloDeNegocio;'
                          'Trusted_Connection=yes;')

cursor3 = conn3.cursor()

try:
        cursor3 = conn3.cursor()
        cursor3.execute(query3)
        cursor3.execute(" COMMIT ")
except pyodbc.Error as ex:
        print ("Error !!!!! , no se creo la tabla" + ex.args[0])
f = open(TablaNueva, "w+")
f.write(query3)
f.close()


##############################################################LOOKUP########



str12 = "CREATE FUNCTION [dbo].[MOD_" + TablaOrigen + "_LOOKUP] (\n\
  @p" + aux_L[0] + "  " + aux_L[1] + "\n\
)\n\
RETURNS int AS\n\
BEGIN\n\
  DECLARE @nSKEY INT\n\
\n\
  IF @p" +  aux_L[0] + " is null \n\
  BEGIN\n\
    SET @nSKEY = -2\n\
  END\n\
  ELSE\n\
  BEGIN\n\
\n\
    SELECT @nSKEY = Id" +  TablaOrigen + "\n\
    FROM   MOD_" +  TablaOrigen + "\n\
    WHERE  " +  aux_L[0] + " = @p" +  aux_L[0] + "\n\
\n\
    IF @nSKEY IS NULL\n\
    BEGIN\n\
        SET @nSKEY = -1\n\
    END\n\
\n\
  END\n\
\n\
  RETURN @nSKEY\n\
END"

#print(str12)

query4 = str12



conn4 = pyodbc.connect('Driver={SQL Server};'
                          'Server=eze-devsql\developer;'
                          'Database=ModeloDeNegocio;'
                          'Trusted_Connection=yes;')

cursor4 = conn4.cursor()

try:
        cursor4 = conn4.cursor()
        cursor4.execute(query4)
        cursor4.execute(" COMMIT ")
except pyodbc.Error as ex:
        print ("Error !!!!! , no se creo la tabla" + ex.args[0])
f = open(TablaNueva, "w+")
f.write(query4)
f.close()
