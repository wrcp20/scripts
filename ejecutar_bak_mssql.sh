#!/bin/bash                                                                                                                                                   
/**
*AUTOR : wrcp20@gmail.com
*release : 1.0
*date : 22112020
*/
#echo 'RESPALDO NORMAL'                                                                                                                                       
#sqlcmd -H localhost -U usuario -P pass -Q "BACKUP DATABASE [df] TO DISK = N'd:\test.bak' WITH NOFORMAT, NOINIT, NAME = 'DEMOBAK', SKIP, 
NOREWIND, NOUNLOAD, STATS = 10"                                                                                                                               
echo 'RESPALDO COMPRIMIDO'                                                                                                                                    
#sqlcmd -H localhost -U usuario -P pass -Q "BACKUP DATABASE [df] TO DISK = N'd:\testbak2.bak' WITH NOFORMAT, NOINIT, NAME = 'DEMOBAK', SKIP, 
NOREWIND, NOUNLOAD,COMPRESSION, STATS = 10"                                                                                                                   
DIA=`date +"%d%m%Y_%H%M"`                                                                                                                                     
echo $DIA                                                                                                                                                     
#datos para el respaldo db                                                                                                                                    
usuario='usuario';                                                                                                                                                 
clave='clave';                                                                                                                                        
dborigen='[df]'                                                                                                                                  
dbdestino="DISK =N'df.bak'"                                                                                                                     
#fin datos respaldo db                                                                                                                                        
echo "INICIO DE BACKUP"                                                                                                                                       
sqlcmd -H localhost -U $usuario -P $clave -Q "BACKUP DATABASE $dborigen TO $dbdestino WITH NOFORMAT, NOINIT, NAME = 'RESPALDO DB ORDENESDEPAGO', SKIP, NOREWIN
D, NOUNLOAD,COMPRESSION, STATS = 10"                                                                                                                          
echo "FIN DESCARGA"                                                                                                                                           
echo "INICIO DESCARGA DE COPIA DESDE CONTENEDOR"                                                                                                              
docker cp id:/var/opt/mssql/data/df.bak /var/backups/mssql101/101.bak                                                                 
echo "REMPLAZO CON LA FECHA ACTUAL"                                                                                                                          
cp 101.bak $DIA                                                                                                                                               
rm -rf 101.bak
#borrar el respaldo generado en el servidor
docker exec id rm -rf  /var/opt/mssql/data/101.bak
