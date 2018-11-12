   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
    INCLUDE('potaskpanel.inc'),ONCE

   MAP
     MODULE('EXISTENCIAS_BC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('EXISTENCIAS001.CLW')
Main                   PROCEDURE   !Wizard Application for C:\Documents and Settings\Jorge Climis\Mis documentos\Clarion Projects\Existencias\DCT_existencias.dct
     END
     MODULE('EXISTENCIAS010.CLW')
GetDateServer          FUNCTION,STRING   !
     END
       BigFec(long),long
       BigCalendario
       BigRel(long,byte),long
       BigReloj
       MODULE('claevo.Dll')
       Exportar(*QUEUE,*QUEUE,*QUEUE,SHORT,STRING,*GROUP)
       ExportarVII(*QUEUE,*QUEUE,*QUEUE,SHORT,STRING,*GROUP,*QUEUE)
       END
       MODULE('claevo.Dll')
       EcRptExport(*QUEUE,*QUEUE,*QUEUE,SHORT,STRING,*GROUP)
       ExportarRptII(*QUEUE,*QUEUE,*QUEUE,SHORT,STRING,*GROUP,*QUEUE)
       PDP(*QUEUE,Long)
       END
   END

glo:conexion_gasoft  STRING(50)
glo:conSecurity      STRING(50)
glo:conexion         STRING(50)
glo:database         CSTRING(50)
glo:userbase         CSTRING(50)
glo:serverbase       CSTRING(50)
glo:password         CSTRING(50)
glo:QREPORT          QUEUE,PRE()
campo1                 &CSTRING
campo2                 &CSTRING
campo3                 &CSTRING
campo4                 &CSTRING
campo5                 &CSTRING
campo6                 &CSTRING
campo7                 CSTRING(51)
campo8                 &CSTRING
campo9                 &CSTRING
campo10                &CSTRING
                     END
GLO:id_programacion  LONG
GLO:existencia_medicion DECIMAL(15)
GLO:id_descarga      LONG,NAME('"id_descarga"')
GLO:id_procedencia   LONG
GLO:id_despacho      LONG
GLO:id_viaje         LONG,NAME('"id_viaje"')
GLO:id_solicitud     LONG,NAME('"id_solicitud"')
GLO:total_producto   LONG
GLO:fecha_Desde      DATE
GLO:fecha_hasta      DATE
GLO:filtro           CSTRING(500)
GLO:id_proveedor     LONG
GLO:ano              LONG
GLO:mes              LONG
glo:semana           LONG
GLO:glp_x_viaje      DECIMAL(18,2),NAME('"GLP_X_VIAJE"')
GLO:existencia       DECIMAL(11,2)
GLO:LowLimit         LONG
GLO:HighLimit        LONG
GLO:localidad_id     LONG
GLO:id_planta        LONG
GLO:id_tanque        LONG
GLO:capacidad        DECIMAL(18,4)
GLO:cant_tanques     LONG,NAME('"CANT_TANQUES"')
GLO:id_existencia    LONG,NAME('"ID_EXISTENCIA"')
SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

!region File Declaration
Proveedores          FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo."proveedores"'),PRE(pro),CREATE,BINDABLE,THREAD !Proveedores de GLP  
PK_proveedor             KEY(pro:id_proveedor),NOCASE,PRIMARY !Id Proveedor        
FK_PROVEEDOR_CONTABLE    KEY(pro:id_proveedor_contable,pro:id_proveedor),DUP,NOCASE !PROVEEDOR CONTABLE  
K_proveedor              KEY(pro:proveedor,pro:id_proveedor),DUP,NOCASE !Proveedor           
Record                   RECORD,PRE()
id_proveedor                LONG                           !Identificador interno del proveedor de producto
proveedor                   STRING(50)                     !                    
importe_DNL                 DECIMAL(12,2)                  !                    
direccion                   STRING(50)                     !                    
ciudad                      STRING(50)                     !                    
provincia                   STRING(50)                     !                    
telefono                    STRING(50)                     !                    
contacto                    STRING(50)                     !                    
id_proveedor_contable       LONG                           !                    
                         END
                     END                       

Transportistas       FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo."transportistas"'),PRE(tra),CREATE,BINDABLE,THREAD !Transportes de GLP  
PK_TRANSPORTISTA         KEY(tra:id_transportista),NOCASE,PRIMARY !Id Transportista    
K_TRANSPORTISTA          KEY(tra:transportista),DUP,NOCASE !Transportista       
Record                   RECORD,PRE()
id_transportista            LONG                           !                    
transportista               STRING(50)                     !                    
direccion                   STRING(50)                     !                    
ciudad                      STRING(50)                     !                    
provincia                   STRING(50)                     !                    
telefono                    STRING(50)                     !                    
                         END
                     END                       

Plantas              FILE,DRIVER('MSSQL'),OWNER(GLO:CONEXION),NAME('dbo."plantas"'),PRE(pla),CREATE,BINDABLE,THREAD !Plantas de GLP      
PK__plantas__7D439ABD    KEY(pla:ID_PLANTA),PRIMARY        !Id Planta           
PLA_PLA_FK_LOCALIDAD     KEY(pla:ID_LOCALIDAD),DUP         !Localidad           
K_LOCALIDAD_PLANTA       KEY(pla:ID_LOCALIDAD,pla:ID_PLANTA),DUP,NOCASE !Localidad           
Record                   RECORD,PRE()
ID_PLANTA                   LONG,NAME('"ID_PLANTA"')       !                    
NRO_PLANTA                  STRING(20),NAME('"NRO_PLANTA"') !                    
CAPACIDAD                   DECIMAL(18,4)                  !                    
ID_LOCALIDAD                LONG,NAME('"ID_LOCALIDAD"')    !                    
CANT_TANQUES                LONG,NAME('"CANT_TANQUES"')    !                    
EXISTENCIA_ACTUAL           DECIMAL(11,2),NAME('"EXISTENCIA_ACTUAL"') !                    
ULTIMA_DESCARGA             DECIMAL(11,2)                  !                    
autonomia                   LONG                           !                    
FECHA_AUDITORIA             STRING(8),NAME('"FECHA_AUDITORIA"') !                    
FECHA_AUDITORIA_GROUP       GROUP,OVER(FECHA_AUDITORIA)    !                    
FECHA_AUDITORIA_DATE          DATE                         !                    
FECHA_AUDITORIA_TIME          TIME                         !                    
                            END                            !                    
                         END
                     END                       

Existencias          FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo.existencias'),PRE(exi),BINDABLE,CREATE,THREAD !Existencias de GLP  
KEY__WA_Sys_ID_STOCK_32AB8735 KEY(exi:id_stock),DUP,NAME('_WA_Sys_ID_STOCK_32AB8735') !STOCK               
FK_EXISTENCIA_ANTERIOR   KEY(exi:id_existencia_anterior),DUP,NOCASE !                    
PK__EXISTENC__36B12243   KEY(exi:id_existencia),NOCASE,PRIMARY !Id                  
EXI_K_PLANTA_Y_ID_EXISTENCIA KEY(exi:id_existencia,exi:id_planta),DUP !Planta              
EXI_FK_PLANTA            KEY(exi:id_planta),DUP            !Planta              
FK_LOCALIDAD             KEY(exi:id_localidad),DUP,NOCASE  !LOCALIDAD           
K_LOCALIDAD_EXISTENCIAS  KEY(exi:id_existencia,exi:id_localidad),DUP,NOCASE !                    
K_LOCALIDAD_PLANTA_EXISTENCIA KEY(exi:id_localidad,exi:id_planta,exi:id_existencia),DUP !                    
EXI_EXI_FK_PLANTA        KEY(exi:id_planta),DUP            !                    
KEY__WA_Sys_id_localidad_32AB8735 KEY(exi:id_localidad),DUP,NAME('_WA_Sys_id_localidad_32AB8735') !                    
KEY__WA_Sys_EXISTENCIA_32AB8735 KEY(exi:existencia),DUP,NAME('_WA_Sys_EXISTENCIA_32AB8735') !                    
KEY__WA_Sys_EXISTENCIA_ANTERIOR_32AB8735 KEY(exi:existencia_anterior),DUP,NAME('_WA_Sys_EXISTENCIA_ANTERIOR_32AB8735') !                    
KEY__WA_Sys_PORC_EXISTENCIA_32AB8735 KEY(exi:porc_existencia),DUP,NAME('_WA_Sys_PORC_EXISTENCIA_32AB8735') !                    
KEY__WA_Sys_CONSUMO_32AB8735 KEY(exi:consumo),DUP,NAME('_WA_Sys_CONSUMO_32AB8735') !                    
KEY__WA_Sys_CAPACIDAD_PLANTA_32AB8735 KEY(exi:capacidad_planta),DUP,NAME('_WA_Sys_CAPACIDAD_PLANTA_32AB8735') !                    
KEY__WA_Sys_FECHA_LECTURA_32AB8735 KEY(exi:FECHA_LECTURA),DUP,NAME('_WA_Sys_FECHA_LECTURA_32AB8735') !                    
KEY__WA_Sys_AUTONOMIA_32AB8735 KEY(exi:AUTONOMIA),DUP,NAME('_WA_Sys_AUTONOMIA_32AB8735') !                    
KEY__WA_Sys_ultima_descarga_32AB8735 KEY(exi:ultima_descarga),DUP,NAME('_WA_Sys_ultima_descarga_32AB8735') !                    
K_FECHA_LOCALIDAD_PLANTA KEY(-exi:FECHA_LECTURA,exi:id_localidad,exi:id_planta),DUP !                    
Record                   RECORD,PRE()
id_existencia               LONG,NAME('"ID_EXISTENCIA"')   !                    
id_planta                   LONG,NAME('"ID_PLANTA"')       !                    
id_localidad                LONG,NAME('"id_localidad"')    !                    
existencia                  DECIMAL(15)                    !                    
existencia_anterior         DECIMAL(15),NAME('"EXISTENCIA_ANTERIOR"') !                    
porc_existencia             LONG,NAME('"PORC_EXISTENCIA"') !                    
consumo                     DECIMAL(15)                    !                    
capacidad_planta            DECIMAL(20),NAME('"CAPACIDAD_PLANTA"') !                    
FECHA_LECTURA               STRING(8),NAME('"FECHA_LECTURA"') !                    
FECHA_LECTURA_GROUP         GROUP,OVER(FECHA_LECTURA)      !                    
FECHA_LECTURA_DATE            DATE                         !                    
FECHA_LECTURA_TIME            TIME                         !                    
                            END                            !                    
AUTONOMIA                   LONG                           !                    
ultima_descarga             DECIMAL(20),NAME('"ultima_descarga"') !                    
id_stock                    LONG,NAME('"ID_STOCK"')        !                    
id_existencia_anterior      LONG                           !                    
id_descarga_ultima          LONG,NAME('"id_descarga_ultima"') !                    
utilizada                   BYTE                           !                    
                         END
                     END                       

Descargas            FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo.descargas'),PRE(des),CREATE,BINDABLE,THREAD !Decargas de GLP     
K_planta                 KEY(des:id_descarga,des:id_planta),DUP,NOCASE !Planta              
FK_LOCALIDAD             KEY(des:id_localidad),DUP,NOCASE  !LOCALIDAD           
K_LOCALIDAD_DESCARGA     KEY(des:id_descarga,des:id_localidad),DUP,NOCASE !                    
PK_descargas             KEY(des:id_descarga),PRIMARY      !Id Descarga         
KEY__WA_Sys_id_viaje_3D5E1FD2 KEY(des:id_viaje,des:id_descarga),DUP,NAME('_WA_Sys_id_viaje_3D5E1FD2'),NOCASE !Viajes              
FK_PLANTA                KEY(des:id_planta),DUP            !Plantas             
Record                   RECORD,PRE()
id_descarga                 LONG,NAME('"id_descarga"')     !                    
id_viaje                    LONG,NAME('"id_viaje"')        !                    
fecha_descarga              STRING(8),NAME('"fecha_descarga"') !                    
fecha_descarga_GROUP        GROUP,OVER(fecha_descarga)     !                    
fecha_descarga_DATE           DATE                         !                    
fecha_descarga_TIME           TIME                         !                    
                            END                            !                    
id_planta                   LONG,NAME('"ID_PLANTA"')       !                    
id_localidad                LONG                           !                    
cantidad                    DECIMAL(10,2)                  !                    
densidad                    DECIMAL(18,4)                  !                    
densidad_corregida          DECIMAL(18,2),NAME('"densidad_corregida"') !                    
t_c                         DECIMAL(18,2),NAME('"t_c"')    !                    
operador                    CSTRING(51)                    !                    
fecha_salida                STRING(8),NAME('"fecha_salida"') !                    
fecha_salida_GROUP          GROUP,OVER(fecha_salida)       !                    
fecha_salida_DATE             DATE                         !                    
fecha_salida_TIME             TIME                         !                    
                            END                            !                    
descargado                  BYTE                           !                    
                         END
                     END                       

Viajes               FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo.viajes'),PRE(via),BINDABLE,CREATE,THREAD !Viajes de GLP       
VIA_FK_PROGRAMACION      KEY(via:id_programacion),DUP      !PROGRAMACION        
VIA_FK_PROCEDENCIA       KEY(via:id_procedencia,via:id_viaje),DUP !PROCEDENCIA         
VIA_K_PROVEEDOR_ESTADO   KEY(via:id_proveedor,via:estado),DUP !                    
K_ano_mes                KEY(via:ano,via:mes),DUP,NOCASE   !                    
K_PROCEDENCIA            KEY(via:id_viaje,via:id_procedencia),DUP,NOCASE !                    
PK_viajes                KEY(via:id_viaje),NOCASE,PRIMARY  !Id Viaje            
K_ESTADO                 KEY(via:estado),DUP,NOCASE        !ESTADO              
FK_TRANSPORTISTA         KEY(via:id_transportista,via:id_viaje),DUP !Transportista       
FK_PROVEEDOR             KEY(via:id_proveedor,via:id_viaje),DUP !Proveedor           
K_REMITO                 KEY(via:nro_remito),DUP           !NRO REMITO          
K_PROVEEDOR_ID_VIAJE     KEY(via:id_proveedor,via:id_viaje),DUP,NOCASE !Proveedor           
K_ID_TRANSPORTISTA_VIAJE KEY(via:id_transportista,via:id_viaje),DUP,NOCASE !transportista       
FK_LOCALIDAD             KEY(via:id_localidad,via:id_viaje),DUP,NOCASE !LOCALIDAD           
FK_SOLICITUD             KEY(via:id_solicitud),DUP,NOCASE  !                    
FK_FACTURA               KEY(via:id_factura),DUP,NOCASE    !                    
Record                   RECORD,PRE()
id_viaje                    LONG,NAME('"id_viaje"')        !                    
id_procedencia              LONG,NAME('"ID_PROCEDENCIA"')  !                    
id_transportista            LONG,NAME('"ID_TRANSPORTISTA"') !                    
guia_transporte             STRING(51),NAME('"guia_transporte"') !                    
id_proveedor                LONG                           !Identificador interno del proveedor de producto
id_programacion             LONG,NAME('"ID_PROGRAMACION"') !                    
nro_remito                  STRING(51),NAME('"nro_remito"') !                    
peso                        DECIMAL(15)                    !                    
fecha_carga                 STRING(8),NAME('"fecha_carga"') !                    
fecha_carga_GROUP           GROUP,OVER(fecha_carga)        !                    
fecha_carga_DATE              DATE                         !                    
fecha_carga_TIME              TIME                         !                    
                            END                            !                    
chofer                      CSTRING(51)                    !                    
peso_descargado             DECIMAL(15)                    !                    
importe_producto            DECIMAL(9,2)                   !                    
cap_tk_camion               DECIMAL(19),NAME('"cap_tk_camion"') !                    
estado                      CSTRING(51)                    !                    
ano                         LONG                           !                    
mes                         LONG                           !                    
id_localidad                LONG,NAME('"ID_LOCALIDAD"')    !Localidad destino   
id_solicitud                LONG                           !                    
id_factura                  LONG                           !                    
despachado                  BYTE                           !                    
anulado                     BYTE                           !                    
                         END
                     END                       

Densidades_Corregidas FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo."densidades_corregidas"'),PRE(den),BINDABLE,CREATE,THREAD !Factores de corrección de densidad
PK_tabla_densidad_corregida KEY(den:id_factor),NOCASE,PRIMARY !Id                  
K_temp_Den               KEY(den:temperatura,den:densidad),NOCASE !Temp y Dens         
Record                   RECORD,PRE()
id_factor                   LONG,NAME('"id_factor"')       !                    
temperatura                 LONG                           !                    
densidad                    DECIMAL(7,2)                   !                    
factor_ajuste               DECIMAL(18,4),NAME('"factor_ajuste"') !                    
                         END
                     END                       

Niveles_Volumenes    FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo."niveles_volumenes"'),PRE(niv),BINDABLE,CREATE,THREAD !Volumenes calculados de tanques
PK_niveles_volumenes     KEY(niv:id_nivel),NOCASE,PRIMARY  !                    
UK_TANQUE_NIVEL          KEY(niv:idt_tanque,niv:nivel_regla),NOCASE !Tanque y Nivel      
FK_TANQUE                KEY(niv:id_nivel,niv:idt_tanque),DUP,NOCASE !Tipo de tanque      
K_NIVEL_REGLA            KEY(niv:nivel_regla),DUP,NOCASE   !                    
K_TANQUE                 KEY(niv:idt_tanque),DUP,NOCASE    !TIPO TANQUE         
Record                   RECORD,PRE()
id_nivel                    LONG,NAME('"id_nivel"')        !                    
idt_tanque                  LONG,NAME('"idt_tanque"')      !                    
nivel_regla                 DECIMAL(7,2),NAME('"nivel_regla"') !                    
volumen_calculado           DECIMAL(18,4),NAME('"volumen_calculado"') !                    
                         END
                     END                       

t_tanques            FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo."t_tanques"'),PRE(t_t),BINDABLE,CREATE,THREAD !Tipos de Tanques    
PK_t_tanques             KEY(t_t:idt_tanque),NOCASE,PRIMARY !Id Tanque           
K_MODELO                 KEY(t_t:idt_tanque,t_t:modelo),DUP,NOCASE !Modelo              
Record                   RECORD,PRE()
idt_tanque                  LONG,NAME('"idt_tanque"')      !                    
modelo                      CSTRING(51)                    !                    
volumen                     DECIMAL(18,2)                  !                    
capacidad                   DECIMAL(7,2)                   !                    
                         END
                     END                       

Tanques_plantas      FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo."tanques_plantas"'),PRE(tan),BINDABLE,CREATE,THREAD !Tanques en planta   
PK_tanques               KEY(tan:id_tanque),NOCASE,PRIMARY !Tanque              
FK_PLANTA                KEY(tan:id_planta,tan:id_tanque),DUP,NOCASE !Planta              
FK_TANQUE                KEY(tan:idt_tanques,tan:id_tanque),DUP,NOCASE !TIPO TANQUE         
k_planta                 KEY(tan:id_planta),DUP,NOCASE     !Planta              
K_TANQUE                 KEY(tan:idt_tanques),DUP,NOCASE   !Tipo de tanque      
Record                   RECORD,PRE()
id_tanque                   LONG,NAME('"id_tanque"')       !                    
id_planta                   LONG,NAME('"id_planta"')       !                    
nro_tanque                  LONG,NAME('"nro_tanque"')      !                    
cap_m3                      DECIMAL(18,2)                  !                    
idt_tanques                 LONG,NAME('"idt_tanques"')     !                    
                         END
                     END                       

Presiones_corregidas FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo."presiones_corregidas"'),PRE(pre),BINDABLE,CREATE,THREAD !Factores de corrección de presión
PK_factor_presion        KEY(pre:id_presion),NOCASE,PRIMARY !Id                  
K_presion_temp           KEY(pre:presion,pre:temperatura),DUP,NOCASE !Presion Temp        
k_presion                KEY(pre:presion),DUP,NOCASE       !                    
Record                   RECORD,PRE()
id_presion                  LONG                           !                    
presion                     DECIMAL(7,2)                   !                    
temperatura                 LONG                           !                    
factor_correccion           DECIMAL(7,6)                   !                    
                         END
                     END                       

Localidades_GLP      FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo."localidades_GLP"'),PRE(Loc),BINDABLE,CREATE,THREAD !                    
PK_localidad             KEY(Loc:id_localidad),NOCASE,PRIMARY !ID localidad        
K_localidad              KEY(Loc:Localidad,Loc:id_localidad),DUP,NOCASE !Localidad           
Record                   RECORD,PRE()
id_localidad                LONG                           !                    
Localidad                   STRING(20)                     !                    
                         END
                     END                       

Mediciones           FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo."mediciones"'),PRE(med),BINDABLE,CREATE,THREAD !Mediciones de Tanques
PK_mediciones            KEY(med:id_medicion),NOCASE,PRIMARY !                    
FK_EXISTENCIA            KEY(med:id_existencia),DUP,NOCASE !EXISTENCIA          
FK_PLANTA                KEY(med:id_planta),DUP,NOCASE     !PLANTA              
FK_DENSIDAD              KEY(med:id_factor_densidad),DUP,NOCASE !Factor densidad     
K_TANQUE                 KEY(med:id_medicion,med:id_tanque),DUP,NOCASE !Tanque              
K_MEDICIONES_EXISTENCIA  KEY(med:id_medicion,med:id_existencia),DUP,NOCASE !                    
FK_TANQUE                KEY(med:id_tanque),DUP,NOCASE     !                    
FK_LOCALIDAD             KEY(med:id_localidad,med:id_medicion),DUP,NOCASE !LOCALIDAD           
FK_NIVEL                 KEY(med:id_nivel,med:id_medicion),DUP,NOCASE !NIVEL               
Record                   RECORD,PRE()
id_medicion                 LONG,NAME('"id_medicion"')     !                    
id_tanque                   LONG                           !                    
id_localidad                LONG                           !                    
id_planta                   LONG,NAME('"ID_PLANTA"')       !                    
id_existencia               LONG                           !                    
fecha_lectura               STRING(8),NAME('"fecha_lectura"') !                    
fecha_lectura_GROUP         GROUP,OVER(fecha_lectura)      !                    
fecha_lectura_DATE            DATE                         !                    
fecha_lectura_TIME            TIME                         !                    
                            END                            !                    
id_nivel                    LONG,NAME('"id_nivel"')        !                    
nivel                       DECIMAL(18,2)                  !                    
temperatura                 LONG                           !                    
presion                     DECIMAL(7,3)                   !                    
densidad                    DECIMAL(18,4)                  !                    
id_factor_densidad          LONG                           !                    
volumen_liquido             DECIMAL(18,4)                  !                    
factor_liquido              DECIMAL(18,4)                  !                    
volumen_corr_liq            DECIMAL(18,4)                  !                    
Volumen_vapor               DECIMAL(12,6)                  !                    
factor_corr_vapor           DECIMAL(11,6)                  !                    
volumen_corr_vapor          DECIMAL(12,5)                  !                    
volumen_total               DECIMAL(12,6)                  !                    
volumen_total_corr          DECIMAL(12)                    !                    
                         END
                     END                       

aux_sql              FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo.aux_sql'),PRE(aux),BINDABLE,CREATE,THREAD !                    
Record                   RECORD,PRE()
campo1                      CSTRING(51)                    !                    
campo2                      CSTRING(51)                    !                    
campo3                      CSTRING(51)                    !                    
campo4                      CSTRING(51)                    !                    
campo5                      CSTRING(51)                    !                    
campo6                      CSTRING(51)                    !                    
campo7                      CSTRING(51)                    !                    
campo8                      CSTRING(51)                    !                    
campo9                      CSTRING(51)                    !                    
campo10                     CSTRING(10)                    !                    
                         END
                     END                       

programacion         FILE,DRIVER('MSSQL'),OWNER(GLO:conexion),NAME('dbo."programacion"'),PRE(prog),CREATE,BINDABLE,THREAD !                    
K_ANO_MES_SEMANA         KEY(prog:ano,prog:mes,prog:nro_semana),DUP,NOCASE !                    
PK_PROGRAMACION          KEY(prog:id_programacion),NOCASE,PRIMARY !Programación        
FK_PROVEEDOR             KEY(prog:id_proveedor),DUP,NOCASE !Id Proveedor        
K_ANO_MES_SEMAMA_PROVEEDOR KEY(prog:id_proveedor,prog:ano,prog:mes,prog:nro_semana),DUP,NOCASE !                    
K_proveedor              KEY(prog:id_programacion,prog:id_proveedor),DUP,NOCASE !Proveedor           
Record                   RECORD,PRE()
id_programacion             LONG                           !                    
id_proveedor                LONG                           !Identificador interno del proveedor de producto
ano                         LONG                           !                    
mes                         LONG                           !                    
nro_semana                  LONG                           !                    
cupo_GLP                    LONG                           !                    
cupo_GLP_programado         LONG                           !                    
cupo_GLP_utilizado          LONG                           !                    
cupo_GLP_restante           LONG                           !                    
                         END
                     END                       

Procedencias         FILE,DRIVER('MSSQL'),OWNER(GLO:CONEXION),NAME('dbo."procedencias"'),PRE(pro1),BINDABLE,CREATE,THREAD !                    
PK_PROCEDENCIA           KEY(pro1:id_procedencia),NOCASE,PRIMARY !Id Procedencia      
K_procedencia            KEY(pro1:id_procedencia,pro1:procedencia),DUP,NOCASE !                    
Record                   RECORD,PRE()
id_procedencia              LONG                           !                    
procedencia                 CSTRING(51)                    !                    
                         END
                     END                       

Mediciones_aux       FILE,DRIVER('MEMORY'),PRE(med1),BINDABLE,CREATE,THREAD !Mediciones de Tanques aux
PK_mediciones            KEY(med1:id_medicion),NOCASE,PRIMARY !                    
FK_EXISTENCIA            KEY(med1:id_existencia),DUP,NOCASE !EXISTENCIA          
FK_PLANTA                KEY(med1:ID_PLANTA),DUP,NOCASE    !PLANTA              
FK_DENSIDAD              KEY(med1:id_factor_densidad),DUP,NOCASE !Factor densidad     
K_TANQUE                 KEY(med1:id_medicion,med1:id_tanque),DUP,NOCASE !Tanque              
FK_TANQUE                KEY(med1:id_tanque),DUP,NOCASE    !                    
Record                   RECORD,PRE()
id_medicion                 LONG,NAME('"id_medicion"')     !                    
id_tanque                   LONG                           !                    
id_localidad                LONG                           !                    
ID_PLANTA                   LONG                           !                    
id_existencia               LONG                           !                    
fecha_lectura               STRING(8),NAME('"fecha_lectura"') !                    
fecha_lectura_GROUP         GROUP,OVER(fecha_lectura)      !                    
fecha_lectura_DATE            DATE                         !                    
fecha_lectura_TIME            TIME                         !                    
                            END                            !                    
nro_tanque                  LONG,NAME('"nro_tanque"')      !                    
id_nivel                    LONG,NAME('"id_nivel"')        !                    
cap_m3                      DECIMAL(18,2)                  !                    
nivel                       DECIMAL(18,2)                  !                    
temperatura                 LONG                           !                    
presion                     DECIMAL(7,3)                   !                    
densidad                    DECIMAL(18,4)                  !                    
id_factor_densidad          LONG                           !                    
volumen_liquido             DECIMAL(18,4)                  !                    
factor_liquido              DECIMAL(18,4)                  !                    
volumen_corr_liq            DECIMAL(18,4)                  !                    
Volumen_vapor               DECIMAL(12,6)                  !                    
factor_corr_vapor           DECIMAL(11,6)                  !                    
volumen_corr_vapor          DECIMAL(12,5)                  !                    
volumen_total               DECIMAL(12,6)                  !                    
volumen_total_corr          DECIMAL(12)                    !                    
                         END
                     END                       

parametros           FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo.parametros'),PRE(par),BINDABLE,CREATE,THREAD !                    
PK_parametros            KEY(par:ID_PARAMETRO),PRIMARY     !                    
Record                   RECORD,PRE()
ID_PARAMETRO                LONG,NAME('"ID_PARAMETRO"')    !                    
TEMP_DEFECTO                DECIMAL(18,2),NAME('"TEMP_DEFECTO"') !                    
DENS_DEFECTO                DECIMAL(18,4),NAME('"DENS_DEFECTO"') !                    
FACTOR_DEFECTO              DECIMAL(18,4),NAME('"FACTOR_DEFECTO"') !                    
GLP_X_VIAJE                 DECIMAL(18,2),NAME('"GLP_X_VIAJE"') !                    
COSTO_GLP                   DECIMAL(19,4),NAME('"COSTO_GLP"') !                    
IVA_GLP                     DECIMAL(18,2),NAME('"IVA_GLP"') !                    
                         END
                     END                       

PlantasStock         FILE,DRIVER('MSSQL'),OWNER(GLO:CONEXION),NAME('dbo.PlantasStock'),PRE(STK),BINDABLE,CREATE,THREAD !                    
FK_PLANTA                KEY(STK:id_planta),DUP,NOCASE     !                    
FK_LOCALIDAD             KEY(STK:id_localidad),DUP,NOCASE  !LOCALIDAD           
K_PLANTA_STOCK           KEY(STK:id_stock,STK:id_planta),DUP,NOCASE !                    
K_LOCALIDAD_STOCK        KEY(STK:id_stock,STK:id_localidad),DUP,NOCASE !                    
PK_PlantasStock          KEY(STK:id_stock),PRIMARY         !                    
Record                   RECORD,PRE()
id_stock                    LONG,NAME('"id_stock"')        !                    
id_localidad                LONG,NAME('"id_localidad"')    !                    
id_planta                   LONG,NAME('"id_planta"')       !                    
fecha                       STRING(8)                      !                    
fecha_GROUP                 GROUP,OVER(fecha)              !                    
fecha_DATE                    DATE                         !                    
fecha_TIME                    TIME                         !                    
                            END                            !                    
tipo                        CSTRING(51)                    !                    
producto                    LONG                           !                    
existencia                  LONG                           !                    
                         END
                     END                       

viajes_anticipos     FILE,DRIVER('MSSQL'),OWNER(GLO:CONEXION),NAME('dbo."viajes_anticipos"'),PRE(sol),BINDABLE,CREATE,THREAD !                    
PK_solicitudes_anticipos KEY(sol:id_solicitud),PRIMARY     !                    
Record                   RECORD,PRE()
id_solicitud                LONG,NAME('"id_solicitud"')    !                    
fecha_emision               STRING(8),NAME('"fecha_emision"') !                    
fecha_emision_GROUP         GROUP,OVER(fecha_emision)      !                    
fecha_emision_DATE            DATE                         !                    
fecha_emision_TIME            TIME                         !                    
                            END                            !                    
importe                     DECIMAL(19,2)                  !                    
producto                    LONG                           !                    
DIAS_DNL                    LONG,NAME('"DIAS_DNL"')        !                    
IMPORTE_DNL                 DECIMAL(19,2),NAME('"IMPORTE_DNL"') !                    
                         END
                     END                       

viajes_facturas      FILE,DRIVER('MSSQL'),OWNER(GLO:CONEXION),NAME('dbo."viajes_facturas"'),PRE(via2),BINDABLE,CREATE,THREAD !                    
PK_facturas_viajes       KEY(via2:id_factura,via2:id_viaje),PRIMARY !                    
Record                   RECORD,PRE()
id_factura                  LONG,NAME('"id_factura"')      !                    
id_viaje                    LONG,NAME('"id_viaje"')        !                    
nro_factura                 CSTRING(51),NAME('"nro_factura"') !                    
nro_remito                  STRING(51),NAME('"nro_remito"') !                    
                         END
                     END                       

contactos_proveedores FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo."contactos_proveedores"'),PRE(cont),CREATE,BINDABLE,THREAD !                    
PK_contacto              KEY(cont:id_contacto),PRIMARY     !contacto            
FK_PROVEEDOR             KEY(cont:id_proveedor),DUP,NOCASE !PROVEEDOR           
K_NOMBRE                 KEY(cont:nombre),DUP,NOCASE       !NOMBRE              
K_NOMBRE_CONTACTO        KEY(cont:nombre,cont:id_contacto),DUP,NOCASE !                    
Record                   RECORD,PRE()
id_contacto                 LONG                           !                    
id_proveedor                LONG                           !Identificador interno del proveedor de producto
nombre                      STRING(50)                     !                    
telefono                    STRING(50)                     !                    
mail                        STRING(50)                     !                    
                         END
                     END                       

contactos_Transportista FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo.transportista'),PRE(cont1),CREATE,BINDABLE,THREAD !                    
PK_contacto              KEY(cont1:id_contacto),PRIMARY    !contacto            
FK_TRANSPORTISTA         KEY(cont1:id_transportista),DUP,NOCASE !TRANSPORTISTA       
K_NOMBRE                 KEY(cont1:nombre),DUP,NOCASE      !NOMBRE              
K_NOMBRE_CONTACTO        KEY(cont1:nombre,cont1:id_contacto),DUP,NOCASE !                    
Record                   RECORD,PRE()
id_contacto                 LONG                           !                    
id_transportista            LONG                           !                    
nombre                      STRING(50)                     !                    
telefono                    STRING(50)                     !                    
mail                        STRING(50)                     !                    
                         END
                     END                       

SQL                  FILE,DRIVER('MSSQL'),OWNER(GLO:conexion),NAME('DBO.SQL'),PRE(SQL),BINDABLE,CREATE,THREAD !                    
Record                   RECORD,PRE()
campo1                      CSTRING(255)                   !                    
campo2                      CSTRING(255)                   !                    
campo3                      CSTRING(255)                   !                    
campo4                      CSTRING(255)                   !                    
campo5                      CSTRING(255)                   !                    
campo6                      CSTRING(255)                   !                    
campo7                      CSTRING(255)                   !                    
campo8                      CSTRING(255)                   !                    
campo9                      CSTRING(255)                   !                    
campo10                     CSTRING(255)                   !                    
                         END
                     END                       

conceptos_aduana     FILE,DRIVER('MSSQL'),OWNER(GLO:CONEXION),NAME('dbo."conceptos_aduana"'),PRE(Con),BINDABLE,CREATE,THREAD !                    
PK_CONCEPTO              KEY(Con:id_concepto),PRIMARY      !ID CONCEPTO         
K_CONCEPTO               KEY(Con:concepto),DUP,NOCASE      !CONCEPTO            
Record                   RECORD,PRE()
id_concepto                 LONG                           !                    
concepto                    STRING(100)                    !                    
importe                     DECIMAL(9,2)                   !                    
                         END
                     END                       

Despacho_aduana      FILE,DRIVER('MSSQL'),OWNER(GLO:CONEXION),NAME('dbo."despacho_aduana"'),PRE(des1),BINDABLE,CREATE,THREAD !                    
FK_PROCEDENCIA           KEY(des1:id_procedencia),DUP,NOCASE !PROCEDENCIA         
PK_DESPACHO              KEY(des1:id_despacho),PRIMARY     !ID DESPACHO         
FK_DESPACHANTE           KEY(des1:id_despachante),DUP,NOCASE !ID DESPACHANTE      
Record                   RECORD,PRE()
id_despacho                 LONG                           !                    
id_procedencia              LONG,NAME('"ID_PROCEDENCIA"')  !                    
peso_total                  DECIMAL(12,2)                  !                    
id_despachante              LONG                           !                    
importe                     DECIMAL(10,2)                  !                    
cant_viajes                 LONG                           !                    
total                       DECIMAL(7,2)                   !                    
                         END
                     END                       

Despachantes         FILE,DRIVER('MSSQL'),OWNER(GLO:CONEXION),NAME('dbo."despachantes"'),PRE(Des2),BINDABLE,CREATE,THREAD !                    
PK_DESPACHANTE           KEY(Des2:id_despachante),PRIMARY  !ID DESPACHANTE      
K_DESPACHANTE            KEY(Des2:despachante),DUP,NOCASE  !DESPACHANTE         
Record                   RECORD,PRE()
id_despachante              LONG                           !                    
despachante                 CSTRING(50)                    !                    
                         END
                     END                       

Despacho_viajes      FILE,DRIVER('MSSQL'),OWNER(GLO:CONEXION),NAME('dbo."despacho_viajes"'),PRE(Des3),BINDABLE,CREATE,THREAD !                    
PK_DESPACHO_VIAJES       KEY(Des3:id_despacho_viaje),PRIMARY !ID DESPACHO VIAJE   
FK_VIAJE                 KEY(Des3:id_viaje),NOCASE         !VIAJE               
FK_DESPACHO              KEY(Des3:id_despacho),DUP,NOCASE  !DESPACHO            
UQ_DESPACHO_VIAJE        KEY(Des3:id_despacho,Des3:id_viaje),NOCASE !ID DESPACHO ID VIAJE
UQ_DESPACHO_VIAJES_VIAJES KEY(Des3:id_viaje,Des3:id_despacho_viaje),NOCASE !DESPACHO VIAJES VIAJES
Record                   RECORD,PRE()
id_despacho_viaje           LONG                           !                    
id_despacho                 LONG                           !                    
id_viaje                    LONG,NAME('"id_viaje"')        !                    
peso                        DECIMAL(15)                    !                    
fecha_carga                 STRING(8),NAME('"fecha_carga"') !                    
fecha_carga_GROUP           GROUP,OVER(fecha_carga)        !                    
fecha_carga_DATE              DATE                         !                    
fecha_carga_TIME              TIME                         !                    
                            END                            !                    
                         END
                     END                       

Despacho_conceptos   FILE,DRIVER('MSSQL'),OWNER(GLO:CONEXION),NAME('dbo."despacho_conceptos"'),PRE(Des4),BINDABLE,CREATE,THREAD !                    
PK_DESPACHO_CONCEPTO     KEY(Des4:id_despacho_concepto),PRIMARY !ID DESPACHO CONCEPTO
UQ_DESPACHO_CONCEPTO     KEY(Des4:id_concepto,Des4:id_despacho_concepto),DUP,NOCASE !DESPACHO CONCEPTO   
UQ_DESPACHO_ADUANA       KEY(Des4:id_despacho,Des4:id_despacho_concepto),NOCASE !DESPACHO ADUANA     
FK_DESPACHO              KEY(Des4:id_despacho),DUP,NOCASE  !DESPACHO            
FK_CONCEPTO              KEY(Des4:id_concepto),DUP,NOCASE  !CONCEPTO            
Record                   RECORD,PRE()
id_despacho_concepto        LONG                           !                    
id_despacho                 LONG                           !                    
id_concepto                 LONG                           !                    
importe                     DECIMAL(12,2)                  !                    
observacion                 CSTRING(50)                    !                    
                         END
                     END                       

comprobantes         FILE,DRIVER('MSSQL'),OWNER(glo:conexion_gasoft),NAME('dbo."comprobantes_5"'),PRE(com),BINDABLE,CREATE,THREAD !                    
PK_COMPROBANTE           KEY(com:comprobante_id),OPT,PRIMARY !COMPROBANTE         
FK_PROVEEDOR             KEY(com:proveedor_id,com:comprobante_id),DUP,NOCASE !PROVEEDOR           
Record                   RECORD,PRE()
comprobante_id              LONG                           !                    
proveedor_id                LONG                           !                    
tipo_comprobante            CSTRING(21)                    !                    
letra_comprobante           CSTRING(2)                     !                    
numero_comprobante          CSTRING(21)                    !                    
importe                     DECIMAL(12,2)                  !                    
                         END
                     END                       

Proveedores_contable FILE,DRIVER('MSSQL'),OWNER(GLO:conexion_gasoft),NAME('dbo."proveedores_5"'),PRE(Pro3),BINDABLE,CREATE,THREAD !                    
PK_PROVEEDOR             KEY(Pro3:proveedor_id),OPT,PRIMARY !PROVEEDOR           
Record                   RECORD,PRE()
proveedor_id                LONG                           !                    
nombre                      CSTRING(81)                    !                    
                         END
                     END                       

Costos_GLP           FILE,DRIVER('MSSQL'),OWNER(GLO:conexion),NAME('dbo."costos_GLP"'),PRE(Cos),BINDABLE,CREATE,THREAD !                    
PK_COSTO                 KEY(Cos:id_costos),OPT,PRIMARY    !ID COSTO            
K_FECHA_VIGENCIA         KEY(Cos:fecha_vigencia),DUP,NOCASE !FECHA VIGENCIA      
Record                   RECORD,PRE()
id_costos                   LONG                           !                    
fecha_vigencia              STRING(8),NAME('"fecha_vigencia"') !                    
fecha_vigencia_GROUP        GROUP,OVER(fecha_vigencia)     !                    
fecha_vigencia_DATE           DATE                         !                    
fecha_vigencia_TIME           TIME                         !                    
                            END                            !                    
costo                       DECIMAL(7,2)                   !                    
                         END
                     END                       

Viajes_aux           FILE,DRIVER('MEMORY'),NAME('dbo."viajes_aux"'),PRE(via3),BINDABLE,CREATE,THREAD !Viajes de GLP       
VIA_FK_PROGRAMACION      KEY(via3:id_programacion),DUP     !PROGRAMACION        
VIA_FK_PROCEDENCIA       KEY(via3:id_procedencia,via3:id_viaje),DUP !PROCEDENCIA         
VIA_K_PROVEEDOR_ESTADO   KEY(via3:id_proveedor,via3:estado),DUP !                    
K_ano_mes                KEY(via3:ano,via3:mes),DUP,NOCASE !                    
K_PROCEDENCIA            KEY(via3:id_viaje,via3:id_procedencia),DUP,NOCASE !                    
PK_viajes                KEY(via3:id_viaje),NOCASE,PRIMARY !Id Viaje            
K_ESTADO                 KEY(via3:estado),DUP,NOCASE       !ESTADO              
FK_TRANSPORTISTA         KEY(via3:id_transportista,via3:id_viaje),DUP !Transportista       
FK_PROVEEDOR             KEY(via3:id_proveedor,via3:id_viaje),DUP !Proveedor           
K_REMITO                 KEY(via3:nro_remito),DUP          !NRO REMITO          
K_PROVEEDOR_ID_VIAJE     KEY(via3:id_proveedor,via3:id_viaje),DUP,NOCASE !Proveedor           
K_ID_TRANSPORTISTA_VIAJE KEY(via3:id_transportista,via3:id_viaje),DUP,NOCASE !transportista       
FK_LOCALIDAD             KEY(via3:id_localidad,via3:id_viaje),DUP,NOCASE !LOCALIDAD           
FK_SOLICITUD             KEY(via3:id_solicitud),DUP,NOCASE !                    
FK_FACTURA               KEY(via3:id_factura),DUP,NOCASE   !                    
Record                   RECORD,PRE()
id_viaje                    LONG,NAME('"id_viaje"')        !                    
id_procedencia              LONG,NAME('"ID_PROCEDENCIA"')  !                    
id_transportista            LONG,NAME('"ID_TRANSPORTISTA"') !                    
guia_transporte             STRING(51),NAME('"guia_transporte"') !                    
id_proveedor                LONG                           !Identificador interno del proveedor de producto
id_programacion             LONG,NAME('"ID_PROGRAMACION"') !                    
nro_remito                  STRING(51),NAME('"nro_remito"') !                    
peso                        DECIMAL(15)                    !                    
fecha_carga                 STRING(8),NAME('"fecha_carga"') !                    
fecha_carga_GROUP           GROUP,OVER(fecha_carga)        !                    
fecha_carga_DATE              DATE                         !                    
fecha_carga_TIME              TIME                         !                    
                            END                            !                    
chofer                      CSTRING(51)                    !                    
peso_descargado             DECIMAL(15)                    !                    
importe_producto            DECIMAL(9,2)                   !                    
cap_tk_camion               DECIMAL(19),NAME('"cap_tk_camion"') !                    
estado                      CSTRING(51)                    !                    
ano                         LONG                           !                    
mes                         LONG                           !                    
id_localidad                LONG,NAME('"ID_LOCALIDAD"')    !Localidad destino   
id_solicitud                LONG                           !                    
id_factura                  LONG                           !                    
despachado                  BYTE                           !                    
anulado                     BYTE                           !                    
                         END
                     END                       

ViajesAlias1         FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo.viajes'),PRE(via1),BINDABLE,CREATE,THREAD !                    
VIA_FK_PROGRAMACION      KEY(via1:id_programacion),DUP     !PROGRAMACION        
VIA_FK_PROCEDENCIA       KEY(via1:id_procedencia,via1:id_viaje),DUP !PROCEDENCIA         
VIA_K_PROVEEDOR_ESTADO   KEY(via1:id_proveedor,via1:estado),DUP !                    
K_ano_mes                KEY(via1:ano,via1:mes),DUP,NOCASE !                    
K_PROCEDENCIA            KEY(via1:id_viaje,via1:id_procedencia),DUP,NOCASE !                    
PK_viajes                KEY(via1:id_viaje),NOCASE,PRIMARY !Id Viaje            
K_ESTADO                 KEY(via1:estado),DUP,NOCASE       !ESTADO              
FK_TRANSPORTISTA         KEY(via1:id_transportista,via1:id_viaje),DUP !Transportista       
FK_PROVEEDOR             KEY(via1:id_proveedor,via1:id_viaje),DUP !Proveedor           
K_REMITO                 KEY(via1:nro_remito),DUP          !NRO REMITO          
K_PROVEEDOR_ID_VIAJE     KEY(via1:id_proveedor,via1:id_viaje),DUP,NOCASE !Proveedor           
K_ID_TRANSPORTISTA_VIAJE KEY(via1:id_transportista,via1:id_viaje),DUP,NOCASE !transportista       
FK_LOCALIDAD             KEY(via1:id_localidad,via1:id_viaje),DUP,NOCASE !LOCALIDAD           
FK_SOLICITUD             KEY(via1:id_solicitud),DUP,NOCASE !                    
FK_FACTURA               KEY(via1:id_factura),DUP,NOCASE   !                    
Record                   RECORD,PRE()
id_viaje                    LONG,NAME('"id_viaje"')        !                    
id_procedencia              LONG,NAME('"ID_PROCEDENCIA"')  !                    
id_transportista            LONG,NAME('"ID_TRANSPORTISTA"') !                    
guia_transporte             STRING(51),NAME('"guia_transporte"') !                    
id_proveedor                LONG                           !Identificador interno del proveedor de producto
id_programacion             LONG,NAME('"ID_PROGRAMACION"') !                    
nro_remito                  STRING(51),NAME('"nro_remito"') !                    
peso                        DECIMAL(15)                    !                    
fecha_carga                 STRING(8),NAME('"fecha_carga"') !                    
fecha_carga_GROUP           GROUP,OVER(fecha_carga)        !                    
fecha_carga_DATE              DATE                         !                    
fecha_carga_TIME              TIME                         !                    
                            END                            !                    
chofer                      CSTRING(51)                    !                    
peso_descargado             DECIMAL(15)                    !                    
importe_producto            DECIMAL(9,2)                   !                    
cap_tk_camion               DECIMAL(19),NAME('"cap_tk_camion"') !                    
estado                      CSTRING(51)                    !                    
ano                         LONG                           !                    
mes                         LONG                           !                    
id_localidad                LONG,NAME('"ID_LOCALIDAD"')    !Localidad destino   
id_solicitud                LONG                           !                    
id_factura                  LONG                           !                    
despachado                  BYTE                           !                    
anulado                     BYTE                           !                    
                         END
                     END                       

PlantasAlias         FILE,DRIVER('MSSQL'),OWNER(GLO:CONEXION),NAME('dbo."plantas"'),PRE(pla1),CREATE,BINDABLE,THREAD !                    
PK__plantas__7D439ABD    KEY(pla1:ID_PLANTA),PRIMARY       !Id Planta           
PLA_PLA_FK_LOCALIDAD     KEY(pla1:ID_LOCALIDAD),DUP        !Localidad           
K_LOCALIDAD_PLANTA       KEY(pla1:ID_LOCALIDAD,pla1:ID_PLANTA),DUP,NOCASE !Localidad           
Record                   RECORD,PRE()
ID_PLANTA                   LONG,NAME('"ID_PLANTA"')       !                    
NRO_PLANTA                  STRING(20),NAME('"NRO_PLANTA"') !                    
CAPACIDAD                   DECIMAL(18,4)                  !                    
ID_LOCALIDAD                LONG,NAME('"ID_LOCALIDAD"')    !                    
CANT_TANQUES                LONG,NAME('"CANT_TANQUES"')    !                    
EXISTENCIA_ACTUAL           DECIMAL(11,2),NAME('"EXISTENCIA_ACTUAL"') !                    
ULTIMA_DESCARGA             DECIMAL(11,2)                  !                    
autonomia                   LONG                           !                    
FECHA_AUDITORIA             STRING(8),NAME('"FECHA_AUDITORIA"') !                    
FECHA_AUDITORIA_GROUP       GROUP,OVER(FECHA_AUDITORIA)    !                    
FECHA_AUDITORIA_DATE          DATE                         !                    
FECHA_AUDITORIA_TIME          TIME                         !                    
                            END                            !                    
                         END
                     END                       

ExistenciasAlias1    FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo.existencias'),PRE(exi1),BINDABLE,CREATE,THREAD !                    
KEY__WA_Sys_ID_STOCK_32AB8735 KEY(exi1:id_stock),DUP,NAME('_WA_Sys_ID_STOCK_32AB8735') !STOCK               
FK_EXISTENCIA_ANTERIOR   KEY(exi1:id_existencia_anterior),DUP,NOCASE !                    
PK__EXISTENC__36B12243   KEY(exi1:id_existencia),NOCASE,PRIMARY !Id                  
EXI_K_PLANTA_Y_ID_EXISTENCIA KEY(exi1:id_existencia,exi1:id_planta),DUP !Planta              
EXI_FK_PLANTA            KEY(exi1:id_planta),DUP           !Planta              
FK_LOCALIDAD             KEY(exi1:id_localidad),DUP,NOCASE !LOCALIDAD           
K_LOCALIDAD_EXISTENCIAS  KEY(exi1:id_existencia,exi1:id_localidad),DUP,NOCASE !                    
K_LOCALIDAD_PLANTA_EXISTENCIA KEY(exi1:id_localidad,exi1:id_planta,exi1:id_existencia),DUP !                    
EXI_EXI_FK_PLANTA        KEY(exi1:id_planta),DUP           !                    
KEY__WA_Sys_id_localidad_32AB8735 KEY(exi1:id_localidad),DUP,NAME('_WA_Sys_id_localidad_32AB8735') !                    
KEY__WA_Sys_EXISTENCIA_32AB8735 KEY(exi1:existencia),DUP,NAME('_WA_Sys_EXISTENCIA_32AB8735') !                    
KEY__WA_Sys_EXISTENCIA_ANTERIOR_32AB8735 KEY(exi1:existencia_anterior),DUP,NAME('_WA_Sys_EXISTENCIA_ANTERIOR_32AB8735') !                    
KEY__WA_Sys_PORC_EXISTENCIA_32AB8735 KEY(exi1:porc_existencia),DUP,NAME('_WA_Sys_PORC_EXISTENCIA_32AB8735') !                    
KEY__WA_Sys_CONSUMO_32AB8735 KEY(exi1:consumo),DUP,NAME('_WA_Sys_CONSUMO_32AB8735') !                    
KEY__WA_Sys_CAPACIDAD_PLANTA_32AB8735 KEY(exi1:capacidad_planta),DUP,NAME('_WA_Sys_CAPACIDAD_PLANTA_32AB8735') !                    
KEY__WA_Sys_FECHA_LECTURA_32AB8735 KEY(exi1:FECHA_LECTURA),DUP,NAME('_WA_Sys_FECHA_LECTURA_32AB8735') !                    
KEY__WA_Sys_AUTONOMIA_32AB8735 KEY(exi1:AUTONOMIA),DUP,NAME('_WA_Sys_AUTONOMIA_32AB8735') !                    
KEY__WA_Sys_ultima_descarga_32AB8735 KEY(exi1:ultima_descarga),DUP,NAME('_WA_Sys_ultima_descarga_32AB8735') !                    
K_FECHA_LOCALIDAD_PLANTA KEY(-exi1:FECHA_LECTURA,exi1:id_localidad,exi1:id_planta),DUP !                    
Record                   RECORD,PRE()
id_existencia               LONG,NAME('"ID_EXISTENCIA"')   !                    
id_planta                   LONG,NAME('"ID_PLANTA"')       !                    
id_localidad                LONG,NAME('"id_localidad"')    !                    
existencia                  DECIMAL(15)                    !                    
existencia_anterior         DECIMAL(15),NAME('"EXISTENCIA_ANTERIOR"') !                    
porc_existencia             LONG,NAME('"PORC_EXISTENCIA"') !                    
consumo                     DECIMAL(15)                    !                    
capacidad_planta            DECIMAL(20),NAME('"CAPACIDAD_PLANTA"') !                    
FECHA_LECTURA               STRING(8),NAME('"FECHA_LECTURA"') !                    
FECHA_LECTURA_GROUP         GROUP,OVER(FECHA_LECTURA)      !                    
FECHA_LECTURA_DATE            DATE                         !                    
FECHA_LECTURA_TIME            TIME                         !                    
                            END                            !                    
AUTONOMIA                   LONG                           !                    
ultima_descarga             DECIMAL(20),NAME('"ultima_descarga"') !                    
id_stock                    LONG,NAME('"ID_STOCK"')        !                    
id_existencia_anterior      LONG                           !                    
id_descarga_ultima          LONG,NAME('"id_descarga_ultima"') !                    
utilizada                   BYTE                           !                    
                         END
                     END                       

Localidades_GLPAlias1 FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo."localidades_GLP"'),PRE(Loc1),BINDABLE,CREATE,THREAD !                    
PK_localidad             KEY(Loc1:id_localidad),NOCASE,PRIMARY !ID localidad        
K_localidad              KEY(Loc1:Localidad,Loc1:id_localidad),DUP,NOCASE !Localidad           
Record                   RECORD,PRE()
id_localidad                LONG                           !                    
Localidad                   STRING(20)                     !                    
                         END
                     END                       

conceptos_aduanaAlias FILE,DRIVER('MSSQL'),OWNER(GLO:CONEXION),NAME('dbo."conceptos_aduana"'),PRE(Con1),BINDABLE,CREATE,THREAD !                    
PK_CONCEPTO              KEY(Con1:id_concepto),PRIMARY     !ID CONCEPTO         
K_CONCEPTO               KEY(Con1:concepto),DUP,NOCASE     !CONCEPTO            
Record                   RECORD,PRE()
id_concepto                 LONG                           !                    
concepto                    STRING(100)                    !                    
importe                     DECIMAL(9,2)                   !                    
                         END
                     END                       

Despacho_viajesAlias1 FILE,DRIVER('MSSQL'),OWNER(GLO:CONEXION),NAME('dbo."despacho_viajes"'),PRE(Des31),BINDABLE,CREATE,THREAD !                    
PK_DESPACHO_VIAJES       KEY(Des31:id_despacho_viaje),PRIMARY !ID DESPACHO VIAJE   
FK_VIAJE                 KEY(Des31:id_viaje),NOCASE        !VIAJE               
FK_DESPACHO              KEY(Des31:id_despacho),DUP,NOCASE !DESPACHO            
UQ_DESPACHO_VIAJE        KEY(Des31:id_despacho,Des31:id_viaje),NOCASE !ID DESPACHO ID VIAJE
UQ_DESPACHO_VIAJES_VIAJES KEY(Des31:id_viaje,Des31:id_despacho_viaje),NOCASE !DESPACHO VIAJES VIAJES
Record                   RECORD,PRE()
id_despacho_viaje           LONG                           !                    
id_despacho                 LONG                           !                    
id_viaje                    LONG,NAME('"id_viaje"')        !                    
peso                        DECIMAL(15)                    !                    
fecha_carga                 STRING(8),NAME('"fecha_carga"') !                    
fecha_carga_GROUP           GROUP,OVER(fecha_carga)        !                    
fecha_carga_DATE              DATE                         !                    
fecha_carga_TIME              TIME                         !                    
                            END                            !                    
                         END
                     END                       

ProveedoresAlias     FILE,DRIVER('MSSQL'),OWNER(glo:conexion),NAME('dbo."proveedores"'),PRE(pro2),CREATE,BINDABLE,THREAD !                    
PK_proveedor             KEY(pro2:id_proveedor),NOCASE,PRIMARY !Id Proveedor        
FK_PROVEEDOR_CONTABLE    KEY(pro2:id_proveedor_contable,pro2:id_proveedor),DUP,NOCASE !PROVEEDOR CONTABLE  
K_proveedor              KEY(pro2:proveedor,pro2:id_proveedor),DUP,NOCASE !Proveedor           
Record                   RECORD,PRE()
id_proveedor                LONG                           !Identificador interno del proveedor de producto
proveedor                   STRING(50)                     !                    
importe_DNL                 DECIMAL(12,2)                  !                    
direccion                   STRING(50)                     !                    
ciudad                      STRING(50)                     !                    
provincia                   STRING(50)                     !                    
telefono                    STRING(50)                     !                    
contacto                    STRING(50)                     !                    
id_proveedor_contable       LONG                           !                    
                         END
                     END                       

!endregion

Access:Proveedores   &FileManager,THREAD                   ! FileManager for Proveedores
Relate:Proveedores   &RelationManager,THREAD               ! RelationManager for Proveedores
Access:Transportistas &FileManager,THREAD                  ! FileManager for Transportistas
Relate:Transportistas &RelationManager,THREAD              ! RelationManager for Transportistas
Access:Plantas       &FileManager,THREAD                   ! FileManager for Plantas
Relate:Plantas       &RelationManager,THREAD               ! RelationManager for Plantas
Access:Existencias   &FileManager,THREAD                   ! FileManager for Existencias
Relate:Existencias   &RelationManager,THREAD               ! RelationManager for Existencias
Access:Descargas     &FileManager,THREAD                   ! FileManager for Descargas
Relate:Descargas     &RelationManager,THREAD               ! RelationManager for Descargas
Access:Viajes        &FileManager,THREAD                   ! FileManager for Viajes
Relate:Viajes        &RelationManager,THREAD               ! RelationManager for Viajes
Access:Densidades_Corregidas &FileManager,THREAD           ! FileManager for Densidades_Corregidas
Relate:Densidades_Corregidas &RelationManager,THREAD       ! RelationManager for Densidades_Corregidas
Access:Niveles_Volumenes &FileManager,THREAD               ! FileManager for Niveles_Volumenes
Relate:Niveles_Volumenes &RelationManager,THREAD           ! RelationManager for Niveles_Volumenes
Access:t_tanques     &FileManager,THREAD                   ! FileManager for t_tanques
Relate:t_tanques     &RelationManager,THREAD               ! RelationManager for t_tanques
Access:Tanques_plantas &FileManager,THREAD                 ! FileManager for Tanques_plantas
Relate:Tanques_plantas &RelationManager,THREAD             ! RelationManager for Tanques_plantas
Access:Presiones_corregidas &FileManager,THREAD            ! FileManager for Presiones_corregidas
Relate:Presiones_corregidas &RelationManager,THREAD        ! RelationManager for Presiones_corregidas
Access:Localidades_GLP &FileManager,THREAD                 ! FileManager for Localidades_GLP
Relate:Localidades_GLP &RelationManager,THREAD             ! RelationManager for Localidades_GLP
Access:Mediciones    &FileManager,THREAD                   ! FileManager for Mediciones
Relate:Mediciones    &RelationManager,THREAD               ! RelationManager for Mediciones
Access:aux_sql       &FileManager,THREAD                   ! FileManager for aux_sql
Relate:aux_sql       &RelationManager,THREAD               ! RelationManager for aux_sql
Access:programacion  &FileManager,THREAD                   ! FileManager for programacion
Relate:programacion  &RelationManager,THREAD               ! RelationManager for programacion
Access:Procedencias  &FileManager,THREAD                   ! FileManager for Procedencias
Relate:Procedencias  &RelationManager,THREAD               ! RelationManager for Procedencias
Access:Mediciones_aux &FileManager,THREAD                  ! FileManager for Mediciones_aux
Relate:Mediciones_aux &RelationManager,THREAD              ! RelationManager for Mediciones_aux
Access:parametros    &FileManager,THREAD                   ! FileManager for parametros
Relate:parametros    &RelationManager,THREAD               ! RelationManager for parametros
Access:PlantasStock  &FileManager,THREAD                   ! FileManager for PlantasStock
Relate:PlantasStock  &RelationManager,THREAD               ! RelationManager for PlantasStock
Access:viajes_anticipos &FileManager,THREAD                ! FileManager for viajes_anticipos
Relate:viajes_anticipos &RelationManager,THREAD            ! RelationManager for viajes_anticipos
Access:viajes_facturas &FileManager,THREAD                 ! FileManager for viajes_facturas
Relate:viajes_facturas &RelationManager,THREAD             ! RelationManager for viajes_facturas
Access:contactos_proveedores &FileManager,THREAD           ! FileManager for contactos_proveedores
Relate:contactos_proveedores &RelationManager,THREAD       ! RelationManager for contactos_proveedores
Access:contactos_Transportista &FileManager,THREAD         ! FileManager for contactos_Transportista
Relate:contactos_Transportista &RelationManager,THREAD     ! RelationManager for contactos_Transportista
Access:SQL           &FileManager,THREAD                   ! FileManager for SQL
Relate:SQL           &RelationManager,THREAD               ! RelationManager for SQL
Access:conceptos_aduana &FileManager,THREAD                ! FileManager for conceptos_aduana
Relate:conceptos_aduana &RelationManager,THREAD            ! RelationManager for conceptos_aduana
Access:Despacho_aduana &FileManager,THREAD                 ! FileManager for Despacho_aduana
Relate:Despacho_aduana &RelationManager,THREAD             ! RelationManager for Despacho_aduana
Access:Despachantes  &FileManager,THREAD                   ! FileManager for Despachantes
Relate:Despachantes  &RelationManager,THREAD               ! RelationManager for Despachantes
Access:Despacho_viajes &FileManager,THREAD                 ! FileManager for Despacho_viajes
Relate:Despacho_viajes &RelationManager,THREAD             ! RelationManager for Despacho_viajes
Access:Despacho_conceptos &FileManager,THREAD              ! FileManager for Despacho_conceptos
Relate:Despacho_conceptos &RelationManager,THREAD          ! RelationManager for Despacho_conceptos
Access:comprobantes  &FileManager,THREAD                   ! FileManager for comprobantes
Relate:comprobantes  &RelationManager,THREAD               ! RelationManager for comprobantes
Access:Proveedores_contable &FileManager,THREAD            ! FileManager for Proveedores_contable
Relate:Proveedores_contable &RelationManager,THREAD        ! RelationManager for Proveedores_contable
Access:Costos_GLP    &FileManager,THREAD                   ! FileManager for Costos_GLP
Relate:Costos_GLP    &RelationManager,THREAD               ! RelationManager for Costos_GLP
Access:Viajes_aux    &FileManager,THREAD                   ! FileManager for Viajes_aux
Relate:Viajes_aux    &RelationManager,THREAD               ! RelationManager for Viajes_aux
Access:ViajesAlias1  &FileManager,THREAD                   ! FileManager for ViajesAlias1
Relate:ViajesAlias1  &RelationManager,THREAD               ! RelationManager for ViajesAlias1
Access:PlantasAlias  &FileManager,THREAD                   ! FileManager for PlantasAlias
Relate:PlantasAlias  &RelationManager,THREAD               ! RelationManager for PlantasAlias
Access:ExistenciasAlias1 &FileManager,THREAD               ! FileManager for ExistenciasAlias1
Relate:ExistenciasAlias1 &RelationManager,THREAD           ! RelationManager for ExistenciasAlias1
Access:Localidades_GLPAlias1 &FileManager,THREAD           ! FileManager for Localidades_GLPAlias1
Relate:Localidades_GLPAlias1 &RelationManager,THREAD       ! RelationManager for Localidades_GLPAlias1
Access:conceptos_aduanaAlias &FileManager,THREAD           ! FileManager for conceptos_aduanaAlias
Relate:conceptos_aduanaAlias &RelationManager,THREAD       ! RelationManager for conceptos_aduanaAlias
Access:Despacho_viajesAlias1 &FileManager,THREAD           ! FileManager for Despacho_viajesAlias1
Relate:Despacho_viajesAlias1 &RelationManager,THREAD       ! RelationManager for Despacho_viajesAlias1
Access:ProveedoresAlias &FileManager,THREAD                ! FileManager for ProveedoresAlias
Relate:ProveedoresAlias &RelationManager,THREAD            ! RelationManager for ProveedoresAlias

FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
GlobalErrorStatus    ErrorStatusClass,THREAD
GlobalErrors         ErrorClass                            ! Global error manager
INIMgr               INIClass                              ! Global non-volatile storage manager
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END


  CODE
  HELP('Existencias.chm')                                  ! Open the applications help file
  GlobalErrors.Init(GlobalErrorStatus)
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  INIMgr.Init('.\existencias.INI', NVD_INI)                ! Configure INIManager to use INI file
  DctInit
  SYSTEM{PROP:Icon} = '.\Distrigas.ico'
  !Seteo las variables de conexion a la Base de datos
  
  !-----Este codigo lo utilizo para generar el archivo de conexion
  !PUTINI('CONEXION','SERVERBASE','DSASRV01','.\conexion.ini')
  !PUTINI('CONEXION','DATABASE','bd_existencias','.\conexion.ini')
  !PUTINI('CONEXION','USERBASE','sa','.\conexion.ini')
  !PUTINI('CONEXION','PASSWORD','250117','.\conexion.ini')
  
  
  glo:Serverbase = GETINI('CONEXION','SERVERBASE',,'.\conexion.ini')
  glo:DataBase = GETINI('CONEXION','DATABASE',,'.\conexion.ini')
  GLO:userbase = GETINI('CONEXION','USERBASE',,'.\conexion.ini')
  GLO:PASSWORD = GETINI('CONEXION','PASSWORD',,'.\conexion.ini')
  
  
  
  GLO:CONEXION =CLIP(GLO:SERVERBASE)&','&CLIP(GLO:DATABASE)&','|
      &CLIP(GLO:USERBASE)&','&CLIP(GLO:PASSWORD)
      
      
  glo:conSecurity =CLIP(GLO:SERVERBASE)&','&CLIP('gasoft')&','|
      &CLIP(GLO:USERBASE)&','&CLIP(GLO:PASSWORD)
      
  glo:conexion_gasoft =CLIP(GLO:SERVERBASE)&','&CLIP('gasoft')&','|
      &CLIP(GLO:USERBASE)&','&CLIP(GLO:PASSWORD)
  Main
  INIMgr.Update
  INIMgr.Kill                                              ! Destroy INI manager
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher
    
!---------------------------------------------------------------------------
BigCalendario PROCEDURE
  CODE
  fec#=BigFec(TODAY())
!---------------------------------------------------------------------------
BigFec FUNCTION(big:fecha)


big:diadat  STRING(10),DIM(7)
big:mesdat  STRING(10),DIM(12)
big:fectot  SHORT(10)
big:fecdat  QUEUE,PRE(fec)
dd            SHORT
mm            SHORT
txt           STRING(40)
            END
big:mes     LONG
big:dia     LONG
big:ini     LONG
big:dias    LONG
Window WINDOW('...'),AT(,,176,110),FONT('Arial',8,-1,FONT:regular),CENTER,ALRT(UpKey),ALRT(DownKey),ALRT(HomeKey), |
         ALRT(EndKey),ALRT(LeftKey),ALRT(RightKey),SYSTEM,GRAY,DOUBLE,MASK,AUTO,MDI,COLOR(-1)
       STRING('D'),AT(4,0,24,12),USE(?String1),TRN,CENTER,FONT('Arial',10,,FONT:bold)
       STRING('L'),AT(28,0,24,12),USE(?String1:3),TRN,CENTER,FONT('Arial',10,,FONT:bold)
       STRING('M'),AT(52,0,24,12),USE(?String1:4),TRN,CENTER,FONT('Arial',10,,FONT:bold)
       STRING('M'),AT(76,0,24,12),USE(?String1:5),TRN,CENTER,FONT('Arial',10,,FONT:bold)
       STRING('J'),AT(100,0,24,12),USE(?String1:7),TRN,CENTER,FONT('Arial',10,,FONT:bold)
       STRING('V'),AT(124,0,24,12),USE(?String1:6),TRN,CENTER,FONT('Arial',10,,FONT:bold)
       STRING('S'),AT(148,0,24,12),USE(?String1:2),TRN,CENTER,FONT('Arial',10,,FONT:bold)
       BUTTON('11'),AT(4,12,24,12),USE(?11),TRN,SKIP,HIDE
       BUTTON('12'),AT(28,12,24,12),USE(?12),TRN,SKIP,HIDE
       BUTTON('13'),AT(52,12,24,12),USE(?13),TRN,SKIP,HIDE
       BUTTON('14'),AT(76,12,24,12),USE(?14),TRN,SKIP,HIDE
       BUTTON('15'),AT(100,12,24,12),USE(?15),TRN,SKIP,HIDE
       BUTTON('16'),AT(124,12,24,12),USE(?16),TRN,SKIP,HIDE
       BUTTON('17'),AT(148,12,24,12),USE(?17),TRN,SKIP,HIDE
       BUTTON('21'),AT(4,24,24,12),USE(?21),TRN,SKIP,HIDE
       BUTTON('22'),AT(28,24,24,12),USE(?22),TRN,SKIP,HIDE
       BUTTON('23'),AT(52,24,24,12),USE(?23),TRN,SKIP,HIDE
       BUTTON('24'),AT(76,24,24,12),USE(?24),TRN,SKIP,HIDE
       BUTTON('25'),AT(100,24,24,12),USE(?25),TRN,SKIP,HIDE
       BUTTON('26'),AT(124,24,24,12),USE(?26),TRN,SKIP,HIDE
       BUTTON('27'),AT(148,24,24,12),USE(?27),TRN,SKIP,HIDE
       BUTTON('31'),AT(4,36,24,12),USE(?31),TRN,SKIP,HIDE
       BUTTON('32'),AT(28,36,24,12),USE(?32),TRN,SKIP,HIDE
       BUTTON('33'),AT(52,36,24,12),USE(?33),TRN,SKIP,HIDE
       BUTTON('34'),AT(76,36,24,12),USE(?34),TRN,SKIP,HIDE
       BUTTON('35'),AT(100,36,24,12),USE(?35),TRN,SKIP,HIDE
       BUTTON('36'),AT(124,36,24,12),USE(?36),TRN,SKIP,HIDE
       BUTTON('37'),AT(148,36,24,12),USE(?37),TRN,SKIP,HIDE
       BUTTON('41'),AT(4,48,24,12),USE(?41),TRN,SKIP,HIDE
       BUTTON('42'),AT(28,48,24,12),USE(?42),TRN,SKIP,HIDE
       BUTTON('43'),AT(52,48,24,12),USE(?43),TRN,SKIP,HIDE
       BUTTON('44'),AT(76,48,24,12),USE(?44),TRN,SKIP,HIDE
       BUTTON('45'),AT(100,48,24,12),USE(?45),TRN,SKIP,HIDE
       BUTTON('46'),AT(124,48,24,12),USE(?46),TRN,SKIP,HIDE
       BUTTON('47'),AT(148,48,24,12),USE(?47),TRN,SKIP,HIDE
       BUTTON('51'),AT(4,60,24,12),USE(?51),TRN,SKIP,HIDE
       BUTTON('52'),AT(28,60,24,12),USE(?52),TRN,SKIP,HIDE
       BUTTON('53'),AT(52,60,24,12),USE(?53),TRN,SKIP,HIDE
       BUTTON('54'),AT(76,60,24,12),USE(?54),TRN,SKIP,HIDE
       BUTTON('55'),AT(100,60,24,12),USE(?55),TRN,SKIP,HIDE
       BUTTON('56'),AT(124,60,24,12),USE(?56),TRN,SKIP,HIDE
       BUTTON('57'),AT(148,60,24,12),USE(?57),TRN,SKIP,HIDE
       BUTTON('61'),AT(4,72,24,12),USE(?61),TRN,SKIP,HIDE
       BUTTON('62'),AT(28,72,24,12),USE(?62),TRN,SKIP,HIDE
       BUTTON('63'),AT(52,72,24,12),USE(?63),TRN,SKIP,HIDE
       BUTTON('64'),AT(76,72,24,12),USE(?64),TRN,SKIP,HIDE
       BUTTON('65'),AT(100,72,24,12),USE(?65),TRN,SKIP,HIDE
       BUTTON('66'),AT(124,72,24,12),USE(?66),TRN,SKIP,HIDE
       BUTTON('67'),AT(148,72,24,12),USE(?67),TRN,SKIP,HIDE
       BUTTON,AT(4,88,24,9),USE(?MesMen),TRN,TIP('Retrocede al mes anterior'),KEY(PgUpKey),ICON(ICON:VCRrewind)
       BUTTON,AT(44,88,12,9),USE(?Menos),TRN,TIP('Retrocede los dias indicados'),KEY(MinusKey),ICON(ICON:VCRback)
       SPIN(@n3),AT(56,88,28,9),USE(big:dias),RIGHT,TIP('Dias a retroceder o avanzar'),KEY(DecimalKey), |
           INS
       BUTTON,AT(84,88,12,9),USE(?Mas),TRN,TIP('Avanza los dias indicados'),KEY(PlusKey),ICON(ICON:VCRplay)
       BUTTON('|'),AT(108,88,24,9),USE(?DiaHoy),FONT('Wingdings',8,,FONT:regular),TRN,TIP('Pasa a la fecha actual'), |
           KEY(AstKey)
       BUTTON,AT(148,88,24,9),USE(?MesMas),TRN,TIP('Avanza al mes siguiente'),KEY(PgDnKey),ICON(ICON:VCRfastforward)
       STRING('...'),AT(4,100,168,8),USE(?Recordar),TRN,CENTER
       !STRING('Daniel Dana'),AT(46,101),USE(?String11),TRN,FONT('Times New Roman',9,,FONT:bold+FONT:italic,CHARSET:ANSI)      
      END
!---------------------------------------------------------------------------
  CODE
  OPEN(window)
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      DO IniciarProceso
    OF Event:CloseWindow
      BREAK
    OF Event:Accepted
      CASE FIELD()
      OF ?DiaHoy
        big:dia=today()
        DO MostrarMes
      OF ?MesMen
        big:mes=DATE(MONTH(big:dia-DAY(big:dia)-15),1,YEAR(big:dia-DAY(big:dia)-15))
        big:mes=DATE(MONTH(big:mes+45),1,YEAR(big:mes+45))-1
        IF DAY(big:dia)>DAY(big:mes) THEN
          big:dia=DATE(MONTH(big:mes),DAY(big:mes),YEAR(big:mes))
        ELSE
          big:dia=DATE(MONTH(big:mes),DAY(big:dia),YEAR(big:mes))
        END
        DO MostrarMes
      OF ?MesMas
        big:mes=DATE(MONTH(big:dia+45-DAY(big:dia)),1,YEAR(big:dia+45-DAY(big:dia)))
        big:mes=DATE(MONTH(big:mes+45),1,YEAR(big:mes+45))-1
        IF DAY(big:dia)>DAY(big:mes) THEN
          big:dia=DATE(MONTH(big:mes),DAY(big:mes),YEAR(big:mes))
        ELSE
          big:dia=DATE(MONTH(big:mes),DAY(big:dia),YEAR(big:mes))
        END
        DO MostrarMes
      OF ?Menos
        big:dia-=big:dias
        DO MostrarMes
      OF ?Mas
        big:dia+=big:dias
        DO MostrarMes
      ELSE
        IF ?<50 THEN
          DO EligeDia
        END
      END
    OF Event:AlertKey
      CASE KEYCODE()
      OF UpKey
        big:dia-=7
        DO MostrarMes
      OF DownKey
        big:dia+=7
        DO MostrarMes
      OF LeftKey
        big:dia-=1
        DO MostrarMes
      OF RightKey
        big:dia+=1
        DO MostrarMes
      OF HomeKey
        big:mes=DATE(MONTH(big:dia),1,YEAR(big:dia)-1)
        big:mes=DATE(MONTH(big:mes+45),1,YEAR(big:mes+45))-1
        IF DAY(big:dia)>DAY(big:mes) THEN
          big:dia=DATE(MONTH(big:mes),DAY(big:mes),YEAR(big:mes))
        ELSE
          big:dia=DATE(MONTH(big:mes),DAY(big:dia),YEAR(big:mes))
        END
        DO MostrarMes
      OF EndKey
        big:mes=DATE(MONTH(big:dia),1,YEAR(big:dia)+1)
        big:mes=DATE(MONTH(big:mes+45),1,YEAR(big:mes+45))-1
        IF DAY(big:dia)>DAY(big:mes) THEN
          big:dia=DATE(MONTH(big:mes),DAY(big:mes),YEAR(big:mes))
        ELSE
          big:dia=DATE(MONTH(big:mes),DAY(big:dia),YEAR(big:mes))
        END
        DO MostrarMes
      END
    END
  END
  CLOSE(window)
  FREE(big:fecdat)
  RETURN(big:Fecha)
!---------------------------------------------------------------------------
IniciarProceso ROUTINE
  big:diadat[1]='Domingo'
  big:diadat[2]='Lunes'
  big:diadat[3]='Martes'
  big:diadat[4]='Miercoles'
  big:diadat[5]='Jueves'
  big:diadat[6]='Viernes'
  big:diadat[7]='Sábado'
  big:mesdat[01]='Enero'
  big:mesdat[02]='Febrero'
  big:mesdat[03]='Marzo'
  big:mesdat[04]='Abril'
  big:mesdat[05]='Mayo'
  big:mesdat[06]='Junio'
  big:mesdat[07]='Julio'
  big:mesdat[08]='Agosto'
  big:mesdat[09]='Setiembre'
  big:mesdat[10]='Octubre'
  big:mesdat[11]='Noviembre'
  big:mesdat[12]='Diciembre'
  FREE(big:fecdat)
  IF big:fecha=0 THEN
    big:dia=TODAY()
  ELSE
    big:dia=DATE(MONTH(big:fecha),DAY(big:fecha),YEAR(big:fecha))
  END
  LOOP n#=1 TO 7
    n#{PROP:Text}=SUB(big:diadat[n#],1,3)
  END
  DO MostrarMes
  big:dias=0
  DISPLAY()
!---------------------------------------------------------------------------
EligeDia ROUTINE
  IF ?<50 THEN
    IF big:dia=?-8+big:ini THEN
      big:Fecha=?-8+big:ini
    ELSE
      big:dia=?-8+big:ini
      DO MostrarMes
      EXIT
    END
  ELSE
    big:Fecha=big:dia
  END
  POST(Event:CloseWindow)
!---------------------------------------------------------------------------
MostrarMes ROUTINE
  Window{PROP:text}=' ' & CLIP(UPPER(big:mesdat[MONTH(big:dia)])) & ' de ' & FORMAT(YEAR(big:dia),@n04)
  big:mes=DATE(MONTH(big:dia),1,YEAR(big:dia))
  f#=big:mes%7+1
  f#=big:mes-f#+1
  big:ini=f#
  LOOP s#=1 TO 6
    LOOP n#=1 TO 7
      i#=s#*7+n#
      IF MONTH(f#)=MONTH(big:mes) THEN
        IF f#=big:dia THEN
          i#{PROP:text}='[[' & FORMAT(DAY(f#),@n02) & ']]'
          d#=i#
        ELSE
          i#{PROP:text}=FORMAT(DAY(f#),@n02)
        END
        i#{PROP:ToolTip}=''
        i#{PROP:Font,4}=0
        IF n#=1 THEN
          i#{PROP:Font,4}=FONT:bold
        END
        LOOP j#=1 TO RECORDS(big:fecdat)
          GET(big:fecdat,j#)
          IF fec:dd=DAY(f#) AND fec:mm=MONTH(f#) THEN
            i#{PROP:ToolTip}=fec:txt
            i#{PROP:Font,4}=FONT:bold+FONT:underline
          END
        END
        UNHIDE(i#)
      ELSE
        HIDE(i#)
      END
      f#+=1
    END
  END
  DISPLAY()
  SELECT(d#)
  ?Recordar{PROP:Text}=d#{PROP:ToolTip}
!---------------------------------------------------------------------------
!---------------------------------------------------------------------------
BigReloj PROCEDURE
  CODE
  hor#=BigRel(CLOCK(),1)
!---------------------------------------------------------------------------
BigRel FUNCTION(hora,mover)


inisis LONG
inihor LONG

xc  LONG(50)    ! x del centro
yc  LONG(50)    ! y del centro
r   LONG(40)    ! radio

sh  STRING(8)   ! string de la hora
ini LONG        ! hora del sistema inicial
hr  LONG        ! horas
mr  LONG        ! minutos
sr  LONG        ! segundos

xh  LONG        ! aguja hora
yh  LONG        ! 
sxh LONG        ! signo
syh LONG        !
ah  LONG        ! angulo

xm  LONG        ! aguja minuto
ym  LONG        ! 
sxm LONG        ! signo
sym LONG        !
am  LONG        ! angulo

xs  LONG        ! aguja segundo
ys  LONG        !
sxs LONG        ! signo
sys LONG        !
as  LONG        ! angulo

deg2rad REAL(0.0174532925199)

window WINDOW('Hora'),AT(,,150,100),FONT('Arial',8,-1,FONT:regular),CENTER,IMM,TIMER(100),SYSTEM,GRAY,MASK, |
         AUTO,MDI,COLOR(-1)
       ELLIPSE,AT(10,10,80,80),USE(?reloj),HIDE,LINEWIDTH(1)
       ELLIPSE,AT(48,8,5,5),USE(?p0),COLOR(COLOR:Blue),FILL(COLOR:White),LINEWIDTH(1)
       ELLIPSE,AT(68,13,5,5),USE(?p1),COLOR(COLOR:Blue),FILL(COLOR:White),LINEWIDTH(1)
       ELLIPSE,AT(83,28,5,5),USE(?p2),COLOR(COLOR:Blue),FILL(COLOR:White),LINEWIDTH(1)
       ELLIPSE,AT(88,48,5,5),USE(?p3),COLOR(COLOR:Blue),FILL(COLOR:White),LINEWIDTH(1)
       ELLIPSE,AT(83,68,5,5),USE(?p4),COLOR(COLOR:Blue),FILL(COLOR:White),LINEWIDTH(1)
       ELLIPSE,AT(68,83,5,5),USE(?p5),COLOR(COLOR:Blue),FILL(COLOR:White),LINEWIDTH(1)
       ELLIPSE,AT(48,88,5,5),USE(?p6),COLOR(COLOR:Blue),FILL(COLOR:White),LINEWIDTH(1)
       ELLIPSE,AT(28,83,5,5),USE(?p7),COLOR(COLOR:Blue),FILL(COLOR:White),LINEWIDTH(1)
       ELLIPSE,AT(13,68,5,5),USE(?p8),COLOR(COLOR:Blue),FILL(COLOR:White),LINEWIDTH(1)
       ELLIPSE,AT(8,48,5,5),USE(?p9),COLOR(COLOR:Blue),FILL(COLOR:White),LINEWIDTH(1)
       ELLIPSE,AT(13,28,5,5),USE(?p10),COLOR(COLOR:Blue),FILL(COLOR:White),LINEWIDTH(1)
       ELLIPSE,AT(28,13,5,5),USE(?p11),COLOR(COLOR:Blue),FILL(COLOR:White),LINEWIDTH(1)
       LINE,AT(50,50,20,0),USE(?hor),HIDE,COLOR(COLOR:Black),LINEWIDTH(3)
       LINE,AT(50,50,0,-40),USE(?min),HIDE,COLOR(COLOR:Black),LINEWIDTH(1)
       LINE,AT(50,50,-40,0),USE(?seg),HIDE,COLOR(COLOR:Red),LINEWIDTH(1)
       STRING('Horas'),AT(100,6),USE(?String1),TRN
       SPIN(@n02),AT(100,18,40,10),USE(hr),IMM,HVSCROLL,RIGHT,INS,RANGE(-1,24),STEP(1)
       STRING('Minutos'),AT(100,30),USE(?String2),TRN
       SPIN(@n02),AT(100,42,40,10),USE(mr),IMM,HVSCROLL,RIGHT,INS,RANGE(-1,60),STEP(1)
       STRING('Segundos'),AT(100,54),USE(?String3),TRN
       SPIN(@n02),AT(100,66,40,10),USE(sr),IMM,HVSCROLL,RIGHT,INS,RANGE(-1,60),STEP(1)
       BUTTON('<191>'),AT(100,84,17,12),USE(?HoraActual),FONT('Wingdings',8,,FONT:regular),TIP('Pasa a la hora actual')
       BUTTON('a'),AT(123,84,17,12),USE(?Aceptar),FONT('Webdings',8,,FONT:regular),TIP('Graba la hora seleccionada'), |
           DEFAULT
     END
!---------------------------------------------------------------------------
  CODE
  OPEN(window)
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      IF NOT mover THEN
        TARGET{PROP:timer}=0
      ELSE
        TARGET{PROP:Timer}=100
      END
      sh=FORMAT(hora,@t04)
      hr=SUB(sh,1,2)
      mr=SUB(sh,4,2)
      sr=SUB(sh,7,2)
      inisis=CLOCK()
      inihor=hora
      DO MoverAgujas
    OF Event:CloseWindow
      BREAK
    OF Event:NewSelection
      IF sr>59 THEN sr=0;mr+=1.
      IF mr>59 THEN mr=0;hr+=1.
      IF hr>23 THEN hr=0.
      IF sr<0  THEN sr=59;mr-=1.
      IF mr<0  THEN mr=59;hr-=1.
      IF hr<0  THEN hr=23.
      inisis=CLOCK()
      inihor=hr*60*60*100+mr*60*100+sr*100+1
      DO MoverAgujas
    OF Event:Timer
      sh=FORMAT(CLOCK()-inisis+inihor,@t04)
      hr=SUB(sh,1,2)
      mr=SUB(sh,4,2)
      sr=SUB(sh,7,2)
      DO MoverAgujas
    OF Event:Accepted
      CASE FIELD()
      OF ?HoraActual
        sh=FORMAT(CLOCK(),@t04)
        hr=SUB(sh,1,2)
        mr=SUB(sh,4,2)
        sr=SUB(sh,7,2)
        inisis=CLOCK()
        inihor=hr*60*60*100+mr*60*100+sr*100+1
        DO MoverAgujas
      OF ?Aceptar
        hora=hr*60*60*100+mr*60*100+sr*100+1
        POST(Event:CloseWindow)
      END
    END
  END
  CLOSE(window)
  RETURN(hora)
!---------------------------------------------------------------------------
MoverAgujas ROUTINE
  HIDE(?hor)
  HIDE(?min)
  HIDE(?seg)
  DISPLAY()
  a12#=60*60*12
  a09#=60*60*9
  a06#=60*60*6
  a03#=60*60*3
  a00#=60*60*0
  IF hr>11 THEN
    ah=60*60*(hr-12)+60*mr+sr
  ELSE
    ah=60*60*hr+60*mr+sr
  END
  IF ah=0 THEN ah=a12#.
  IF ah>a00# AND ah<=a03# THEN ah=a03#-ah;sxh=+1;syh=-1.
  IF ah>a03# AND ah<=a06# THEN ah=ah-a03#;sxh=+1;syh=+1.
  IF ah>a06# AND ah<=a09# THEN ah=a09#-ah;sxh=-1;syh=+1.
  IF ah>a09# AND ah<=a12# THEN ah=ah-a09#;sxh=-1;syh=-1.
  ah=360*ah/a12#
  xh=r*cos(ah*deg2rad)*0.60
  yh=r*sin(ah*deg2rad)*0.60
  a60#=60*60
  a45#=60*45
  a30#=60*30
  a15#=60*15
  a00#=60*0
  am=60*mr+sr
  IF am=0 THEN am=a60#.
  IF am>a00# AND am<=a15# THEN am=a15#-am;sxm=+1;sym=-1.
  IF am>a15# AND am<=a30# THEN am=am-a15#;sxm=+1;sym=+1.
  IF am>a30# AND am<=a45# THEN am=a45#-am;sxm=-1;sym=+1.
  IF am>a45# AND am<=a60# THEN am=am-a45#;sxm=-1;sym=-1.
  am=360*am/a60#
  xm=r*cos(am*deg2rad)
  ym=r*sin(am*deg2rad)
  a60#=60
  a45#=45
  a30#=30
  a15#=15
  a00#=0
  as=sr
  IF as=0 THEN as=a60#.
  IF as>a00# AND as<=a15# THEN as=a15#-as;sxs=+1;sys=-1.
  IF as>a15# AND as<=a30# THEN as=as-a15#;sxs=+1;sys=+1.
  IF as>a30# AND as<=a45# THEN as=a45#-as;sxs=-1;sys=+1.
  IF as>a45# AND as<=a60# THEN as=as-a45#;sxs=-1;sys=-1.
  as=360*as/a60#
  xs=r*cos(as*deg2rad)
  ys=r*sin(as*deg2rad)
  ?hor{PROP:width} =xh*sxh
  ?hor{PROP:height}=yh*syh
  ?min{PROP:width} =xm*sxm
  ?min{PROP:height}=ym*sym
  ?seg{PROP:width} =xs*sxs
  ?seg{PROP:height}=ys*sys
  UNHIDE(?hor)
  UNHIDE(?min)
  UNHIDE(?seg)
  DISPLAY()
!---------------------------------------------------------------------------


Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

