

   MEMBER('existencias.clw')                               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('BRWEXT.INC'),ONCE

                     MAP
                       INCLUDE('EXISTENCIAS007.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('EXISTENCIAS002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS006.INC'),ONCE        !Req'd for module callout resolution
                     END



!!! <summary>
!!! Generated from procedure template - Window
!!! Browse the Viajes file
!!! </summary>
BrowseBalanceProducto PROCEDURE 

L:buscador           CSTRING(100)                          !
L:IncluirProgramados BYTE                                  !
l:id_localidad       LONG                                  !
l:localidad          STRING(50)                            !
CurrentTab           STRING(80)                            !
l:cant_producto      LONG                                  !
l:cant_viajes        LONG                                  !
l:strFilter          STRING(200)                           !
l:fecha_hasta        DATE                                  !
l:fecha_desde        DATE                                  !
BRW1::View:Browse    VIEW(Viajes)
                       PROJECT(via:id_viaje)
                       PROJECT(via:fecha_carga_DATE)
                       PROJECT(via:nro_remito)
                       PROJECT(via:guia_transporte)
                       PROJECT(via:peso)
                       PROJECT(via:id_procedencia)
                       PROJECT(via:id_proveedor)
                       PROJECT(via:id_localidad)
                       PROJECT(via:id_transportista)
                       JOIN(pro1:PK_PROCEDENCIA,via:id_procedencia)
                         PROJECT(pro1:procedencia)
                         PROJECT(pro1:id_procedencia)
                       END
                       JOIN(pro:PK_proveedor,via:id_proveedor)
                         PROJECT(pro:proveedor)
                         PROJECT(pro:id_proveedor)
                       END
                       JOIN(Loc1:PK_localidad,via:id_localidad)
                         PROJECT(Loc1:Localidad)
                         PROJECT(Loc1:id_localidad)
                       END
                       JOIN(des:KEY__WA_Sys_id_viaje_3D5E1FD2,via:id_viaje)
                         PROJECT(des:fecha_descarga_DATE)
                         PROJECT(des:cantidad)
                         PROJECT(des:id_planta)
                         JOIN(pla:PK__plantas__7D439ABD,des:id_planta)
                           PROJECT(pla:NRO_PLANTA)
                           PROJECT(pla:ID_PLANTA)
                         END
                       END
                       JOIN(tra:PK_TRANSPORTISTA,via:id_transportista)
                         PROJECT(tra:transportista)
                         PROJECT(tra:id_transportista)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
via:id_viaje           LIKE(via:id_viaje)             !List box control field - type derived from field
via:fecha_carga_DATE   LIKE(via:fecha_carga_DATE)     !List box control field - type derived from field
pro1:procedencia       LIKE(pro1:procedencia)         !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
via:nro_remito         LIKE(via:nro_remito)           !List box control field - type derived from field
des:fecha_descarga_DATE LIKE(des:fecha_descarga_DATE) !List box control field - type derived from field
Loc1:Localidad         LIKE(Loc1:Localidad)           !List box control field - type derived from field
pla:NRO_PLANTA         LIKE(pla:NRO_PLANTA)           !List box control field - type derived from field
tra:transportista      LIKE(tra:transportista)        !List box control field - type derived from field
via:guia_transporte    LIKE(via:guia_transporte)      !List box control field - type derived from field
des:cantidad           LIKE(des:cantidad)             !List box control field - type derived from field
via:peso               LIKE(via:peso)                 !List box control field - type derived from field
pro1:id_procedencia    LIKE(pro1:id_procedencia)      !Related join file key field - type derived from field
pro:id_proveedor       LIKE(pro:id_proveedor)         !Related join file key field - type derived from field
Loc1:id_localidad      LIKE(Loc1:id_localidad)        !Related join file key field - type derived from field
pla:ID_PLANTA          LIKE(pla:ID_PLANTA)            !Related join file key field - type derived from field
tra:id_transportista   LIKE(tra:id_transportista)     !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseViajesEnTransito'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(24,102,489,164),USE(?Browse:1),HVSCROLL,FORMAT('51R(2)|M~Nro Viaje~C(0)@N20_@51' & |
  'R(2)|M~Fecha carga~C(0)@d6@105L(2)|M~Procedencia~C(0)@s50@83L(2)|M~Proveedor~C(0)@s5' & |
  '0@80L(2)|M~Nro remito~@s50@55R(2)|M~Fecha Descarga~C(0)@d6@80L(2)|M~Destino~C(0)@s20' & |
  '@40R(2)|M~Nro Pta~C(0)@P<<<<P@200L(2)|M~Transportista~L(0)@s50@90L(2)|M~Guia Transpo' & |
  'rte~L(0)@s50@60D(22)|M~Desc. p/ planta~C(0)@N-14.@48D(22)|M~Peso~C(0)@N-10.`2@'),FROM(Queue:Browse:1), |
  IMM,MSG('Browsing the Viajes file')
                       BUTTON,AT(456,292,25,25),USE(?Close),LEFT,ICON('Cancelar.ico'),FLAT,MSG('Close Window'),TIP('Close Window'), |
  TRN
                       STRING('Balance de Producto'),AT(230,15),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       BUTTON,AT(385,292,25,25),USE(?BtnImprimir),ICON('Imprimir.ico'),FLAT,TRN
                       ENTRY(@d6),AT(275,36,47,13),USE(l:fecha_desde)
                       STRING('Desde:'),AT(247,36,25,12),USE(?STRING2),TRN
                       ENTRY(@d6),AT(275,57),USE(l:fecha_hasta)
                       STRING('Hasta:'),AT(247,58,24,12),USE(?STRING2:2),TRN
                       BUTTON,AT(475,41,25,25),USE(?BUTTON1),ICON('seleccionar.ICO'),FLAT,TRN
                       BUTTON,AT(326,31,20,20),USE(?BotonSeleccionFechaDesde),ICON('calen.ico'),FLAT,TRN
                       BUTTON,AT(327,52,20,20),USE(?BotonSeleccionFechaHasta),ICON('calen.ico'),FLAT,TRN
                       STRING('Total producto:'),AT(399,270,54,14),USE(?STRING2:3),TRN
                       STRING(@N-14~ kg~),AT(456,270,54,14),USE(l:cant_producto),TRN
                       STRING(@n-14),AT(331,270,54,14),USE(l:cant_viajes),TRN
                       STRING('Cant viajes:'),AT(274,270,42,14),USE(?STRING2:4),TRN
                       BOX,AT(22,30,491,69),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BOX,AT(23,286,491,39),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       PROMPT('Destino'),AT(42,39),USE(?l:id_localidad:Prompt),TRN
                       ENTRY(@P<<<P),AT(72,38,18,13),USE(l:id_localidad),RIGHT(1)
                       BUTTON,AT(95,39,12,12),USE(?CallLookupLocalidad),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@s20),AT(111,41,83,10),USE(Loc:Localidad),TRN
                       BUTTON,AT(203,293,25,25),USE(?Insert),ICON('Insertar.ico'),FLAT,TRN
                       BUTTON,AT(245,293,25,25),USE(?Change),ICON('Editar.ico'),FLAT,TRN
                       BUTTON,AT(287,293,25,25),USE(?Delete),ICON('Eliminar.ICO'),FLAT,TRN
                       BUTTON,AT(55,292,25,25),USE(?View),ICON('Ver.ico'),FLAT,TRN
                       BUTTON,AT(310,81,16,14),USE(?Browse:Top),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page')
                       BUTTON,AT(326,81,16,14),USE(?Browse:PageUp),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the Prior Page')
                       BUTTON,AT(342,81,16,14),USE(?Browse:Up),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record')
                       BUTTON,AT(358,81,16,14),USE(?Browse:Locate),ICON('FIND.GIF'),DISABLE,FLAT,TIP('Locate record')
                       BUTTON,AT(374,81,16,14),USE(?Browse:Down),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record')
                       BUTTON,AT(390,81,16,14),USE(?Browse:PageDown),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page')
                       BUTTON,AT(406,81,16,14),USE(?Browse:Bottom),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page')
                       ENTRY(@s99),AT(164,82,142),USE(L:buscador)
                       STRING('Buscar:'),AT(135,82,25,12),USE(?STRING2:5),TRN
                       CHECK,AT(111,60),USE(L:IncluirProgramados)
                       STRING('Incluir Programados'),AT(42,60,67,12),USE(?STRING2:6),TRN
                       BUTTON,AT(333,293,25,25),USE(?EvoExportar),LEFT,ICON('exportar.ico'),FLAT
                     END

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
BRW1::Toolbar        BrowseToolbarClass
Loc::QHlist11 QUEUE,PRE(QHL11)
Id                         SHORT
Nombre                     STRING(100)
Longitud                   SHORT
Pict                       STRING(50)
Tot                 BYTE
                         END
QPar11 QUEUE,PRE(Q11)
FieldPar                 CSTRING(800)
                         END
QPar211 QUEUE,PRE(Qp211)
F2N                 CSTRING(300)
F2P                 CSTRING(100)
F2T                 BYTE
                         END
Loc::TituloListado11          STRING(100)
Loc::Titulo11          STRING(100)
SavPath11          STRING(2000)
Evo::Group11  GROUP,PRE()
Evo::Procedure11          STRING(100)
Evo::App11          STRING(100)
Evo::NroPage          LONG
   END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
SetAlerts              PROCEDURE(),DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

Ec::LoadI_11  SHORT
Gol_woI_11 WINDOW,AT(,,236,43),FONT('MS Sans Serif',8,,),CENTER,GRAY
       IMAGE('clock.ico'),AT(8,11),USE(?ImgoutI_11),CENTERED
       GROUP,AT(38,11,164,20),USE(?G::I_11),BOXED,BEVEL(-1)
         STRING('Preparando datos para Exportacion'),AT(63,11),USE(?StrOutI_11),TRN
         STRING('Aguarde un instante por Favor...'),AT(67,20),USE(?StrOut2I_11),TRN
       END
     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
calcular_periodo    ROUTINE
    ! Calcular el ultimo dia del mes segun fecha_desde
    l:fecha_hasta =date(month(l:fecha_Desde),DAY(DATE(month(l:fecha_Desde) + 1,0,year(l:fecha_desde))),year(l:fecha_desde))   
    EXIT
    
filtrar             ROUTINE
    l:strFilter = 'via:peso <> 0'
    
    if L:IncluirProgramados = 0
        l:strFilter = clip(l:strFilter)& ' and via:estado <>''Programado'''
    END
    
   
    if l:id_localidad <> 0
        l:strFilter = clip(l:strFilter)&' and via:id_localidad = '&l:id_localidad
    else
         l:strFilter = clip(l:strFilter)&' and via:id_localidad = 0'
    END
    
    if l:fecha_desde <> 0
    l:strFilter = clip(l:strFilter)&' and via:fecha_carga_DATE >='&l:fecha_desde
    END

    if l:fecha_hasta <> 0
    l:strFilter = clip(l:strFilter)&' and via:fecha_carga_DATE <='&l:fecha_hasta
    END
   
    
    
    if evaluate(l:strFilter)
        BRW1.SetFilter(l:strFilter)
        BRW1.ApplyFilter()
        ThisWindow.reset(1)
    END
   EXIT
    
PrintExBrowse11 ROUTINE

 OPEN(Gol_woI_11)
 DISPLAY()
 SETTARGET(QuickWindow)
 SETCURSOR(CURSOR:WAIT)
 EC::LoadI_11 = BRW1.FileLoaded
 IF Not  EC::LoadI_11
     BRW1.FileLoaded=True
     CLEAR(BRW1.LastItems,1)
     BRW1.ResetFromFile()
 END
 CLOSE(Gol_woI_11)
 SETCURSOR()
  Evo::App11          = 'existencias'
  Evo::Procedure11          = GlobalErrors.GetProcedureName()& 11
 
  FREE(QPar11)
  Q11:FieldPar  = '1,2,3,4,5,6,7,8,9,10,11,12,'
  ADD(QPar11)  !!1
  Q11:FieldPar  = ';'
  ADD(QPar11)  !!2
  Q11:FieldPar  = 'Spanish'
  ADD(QPar11)  !!3
  Q11:FieldPar  = ''
  ADD(QPar11)  !!4
  Q11:FieldPar  = true
  ADD(QPar11)  !!5
  Q11:FieldPar  = ''
  ADD(QPar11)  !!6
  Q11:FieldPar  = true
  ADD(QPar11)  !!7
 !!!! Exportaciones
  Q11:FieldPar  = 'HTML|'
   Q11:FieldPar  = CLIP( Q11:FieldPar)&'EXCEL|'
   Q11:FieldPar  = CLIP( Q11:FieldPar)&'WORD|'
  Q11:FieldPar  = CLIP( Q11:FieldPar)&'ASCII|'
   Q11:FieldPar  = CLIP( Q11:FieldPar)&'XML|'
   Q11:FieldPar  = CLIP( Q11:FieldPar)&'PRT|'
  ADD(QPar11)  !!8
  Q11:FieldPar  = 'All'
  ADD(QPar11)   !.9.
  Q11:FieldPar  = ' 0'
  ADD(QPar11)   !.10
  Q11:FieldPar  = 0
  ADD(QPar11)   !.11
  Q11:FieldPar  = '1'
  ADD(QPar11)   !.12
 
  Q11:FieldPar  = ''
  ADD(QPar11)   !.13
 
  Q11:FieldPar  = ''
  ADD(QPar11)   !.14
 
  Q11:FieldPar  = ''
  ADD(QPar11)   !.15
 
   Q11:FieldPar  = '16'
  ADD(QPar11)   !.16
 
   Q11:FieldPar  = 1
  ADD(QPar11)   !.17
   Q11:FieldPar  = 2
  ADD(QPar11)   !.18
   Q11:FieldPar  = '2'
  ADD(QPar11)   !.19
   Q11:FieldPar  = 12
  ADD(QPar11)   !.20
 
   Q11:FieldPar  = 0 !Exporta excel sin borrar
  ADD(QPar11)   !.21
 
   Q11:FieldPar  = Evo::NroPage !Nro Pag. Desde Report (BExp)
  ADD(QPar11)   !.22
 
   CLEAR(Q11:FieldPar)
  ADD(QPar11)   ! 23 Caracteres Encoding para xml
 
  Q11:FieldPar  = '0'
  ADD(QPar11)   ! 24 Use Open Office
 
   Q11:FieldPar  = '13021968'
 
 
  ADD(QPar11)
 
  FREE(QPar211)
       Qp211:F2N  = 'Nro Viaje'
  Qp211:F2P  = '@N20_'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Fecha carga'
  Qp211:F2P  = '@d6'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Procedencia'
  Qp211:F2P  = '@s50'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Proveedor'
  Qp211:F2P  = '@s50'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Nro remito'
  Qp211:F2P  = '@s50'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Fecha Descarga'
  Qp211:F2P  = '@d6'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Destino'
  Qp211:F2P  = '@s20'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Nro Pta'
  Qp211:F2P  = '@P<<P'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Transportista'
  Qp211:F2P  = '@s50'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Guia Transporte'
  Qp211:F2P  = '@s50'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Desc. p/ planta'
  Qp211:F2P  = '@N-14.'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Peso'
  Qp211:F2P  = '@N-10.`2'
  Qp211:F2T  = '0'
  ADD(QPar211)
  SysRec# = false
  FREE(Loc::QHlist11)
  LOOP
     SysRec# += 1
     IF ?Browse:1{PROPLIST:Exists,SysRec#} = 1
         GET(QPar211,SysRec#)
         QHL11:Id      = SysRec#
         QHL11:Nombre  = Qp211:F2N
         QHL11:Longitud= ?Browse:1{PropList:Width,SysRec#}  /2
         QHL11:Pict    = Qp211:F2P
         QHL11:Tot    = Qp211:F2T
         ADD(Loc::QHlist11)
      Else
        break
     END
  END
  Loc::Titulo11 ='Balance de Producto'
 
 SavPath11 = PATH()
  Exportar(Loc::QHlist11,BRW1.Q,QPar11,0,Loc::Titulo11,Evo::Group11)
 IF Not EC::LoadI_11 Then  BRW1.FileLoaded=false.
 SETPATH(SavPath11)
 !!!! Fin Routina Templates Clarion

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseBalanceProducto')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('via:id_viaje',via:id_viaje)                        ! Added by: BrowseBox(ABC)
  BIND('via:nro_remito',via:nro_remito)                    ! Added by: BrowseBox(ABC)
  BIND('pla:NRO_PLANTA',pla:NRO_PLANTA)                    ! Added by: BrowseBox(ABC)
  BIND('via:guia_transporte',via:guia_transporte)          ! Added by: BrowseBox(ABC)
  BIND('pla:ID_PLANTA',pla:ID_PLANTA)                      ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  BRW1::Toolbar.Init(SELF,BRW1)
  BRW1::Toolbar.InitBrowse(0, 0, 0, 0)
  BRW1::Toolbar.InitVCR(?Browse:Top, ?Browse:Bottom, ?Browse:PageUp, ?Browse:PageDown, ?Browse:Up, ?Browse:Down, ?Browse:Locate)
  BRW1::Toolbar.InitMisc(0, 0)
  SELF.AddItem(BRW1::Toolbar.WindowComponent)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Localidades_GLP.Open                              ! File Localidades_GLP used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Viajes,SELF) ! Initialize the browse manager
  l:fecha_Desde = date(month(today()),1,year(today()))
  !l:fecha_hasta =DATE(month(l:fecha_Desde)+1,0,year(l:fecha_desde)) 
  l:fecha_hasta = today()
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,via:PK_viajes)                        ! Add the sort order for via:PK_viajes for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?L:buscador,via:id_viaje,1,BRW1) ! Initialize the browse locator using ?L:buscador using key: via:PK_viajes , via:id_viaje
  BRW1.SetFilter('(via:peso <<> 0 and via:estado =''Descargado'')') ! Apply filter expression to browse
  BRW1.AddField(via:id_viaje,BRW1.Q.via:id_viaje)          ! Field via:id_viaje is a hot field or requires assignment from browse
  BRW1.AddField(via:fecha_carga_DATE,BRW1.Q.via:fecha_carga_DATE) ! Field via:fecha_carga_DATE is a hot field or requires assignment from browse
  BRW1.AddField(pro1:procedencia,BRW1.Q.pro1:procedencia)  ! Field pro1:procedencia is a hot field or requires assignment from browse
  BRW1.AddField(pro:proveedor,BRW1.Q.pro:proveedor)        ! Field pro:proveedor is a hot field or requires assignment from browse
  BRW1.AddField(via:nro_remito,BRW1.Q.via:nro_remito)      ! Field via:nro_remito is a hot field or requires assignment from browse
  BRW1.AddField(des:fecha_descarga_DATE,BRW1.Q.des:fecha_descarga_DATE) ! Field des:fecha_descarga_DATE is a hot field or requires assignment from browse
  BRW1.AddField(Loc1:Localidad,BRW1.Q.Loc1:Localidad)      ! Field Loc1:Localidad is a hot field or requires assignment from browse
  BRW1.AddField(pla:NRO_PLANTA,BRW1.Q.pla:NRO_PLANTA)      ! Field pla:NRO_PLANTA is a hot field or requires assignment from browse
  BRW1.AddField(tra:transportista,BRW1.Q.tra:transportista) ! Field tra:transportista is a hot field or requires assignment from browse
  BRW1.AddField(via:guia_transporte,BRW1.Q.via:guia_transporte) ! Field via:guia_transporte is a hot field or requires assignment from browse
  BRW1.AddField(des:cantidad,BRW1.Q.des:cantidad)          ! Field des:cantidad is a hot field or requires assignment from browse
  BRW1.AddField(via:peso,BRW1.Q.via:peso)                  ! Field via:peso is a hot field or requires assignment from browse
  BRW1.AddField(pro1:id_procedencia,BRW1.Q.pro1:id_procedencia) ! Field pro1:id_procedencia is a hot field or requires assignment from browse
  BRW1.AddField(pro:id_proveedor,BRW1.Q.pro:id_proveedor)  ! Field pro:id_proveedor is a hot field or requires assignment from browse
  BRW1.AddField(Loc1:id_localidad,BRW1.Q.Loc1:id_localidad) ! Field Loc1:id_localidad is a hot field or requires assignment from browse
  BRW1.AddField(pla:ID_PLANTA,BRW1.Q.pla:ID_PLANTA)        ! Field pla:ID_PLANTA is a hot field or requires assignment from browse
  BRW1.AddField(tra:id_transportista,BRW1.Q.tra:id_transportista) ! Field tra:id_transportista is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseBalanceProducto',QuickWindow)        ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 2
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,via:PK_viajes)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Localidades_GLP.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('BrowseBalanceProducto',QuickWindow)     ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      SelectLocalidades_GLP
      UpdateViajes
    END
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.SetAlerts PROCEDURE

  CODE
  PARENT.SetAlerts
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.SetAlerts()


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?BtnImprimir
      BRW1.SetOrder('via:id_proveedor')
      brw1.ApplyOrder()
      thiswindow.Reset(1)
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BtnImprimir
      ThisWindow.Update
      START(ReportBalanceProducto, 50000, BRW1.VIEW{PROP:FILTER},BRW1.VIEW{PROP:ORDER})
      ThisWindow.Reset
    OF ?BUTTON1
      ThisWindow.Update
      do filtrar
      
    OF ?BotonSeleccionFechaDesde
      ThisWindow.Update
      CHANGE(?l:fecha_desde,bigfec(CONTENTS(?l:fecha_desde)))
      !DO RefreshWindow
    OF ?BotonSeleccionFechaHasta
      ThisWindow.Update
      CHANGE(?l:fecha_hasta,bigfec(CONTENTS(?l:fecha_hasta)))
      !DO RefreshWindow
    OF ?l:id_localidad
      IF l:id_localidad OR ?l:id_localidad{PROP:Req}
        Loc:id_localidad = l:id_localidad
        IF Access:Localidades_GLP.TryFetch(Loc:PK_localidad)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            l:id_localidad = Loc:id_localidad
            l:localidad = Loc:Localidad
          ELSE
            CLEAR(l:localidad)
            SELECT(?l:id_localidad)
            CYCLE
          END
        ELSE
          l:localidad = Loc:Localidad
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupLocalidad
      ThisWindow.Update
      Loc:id_localidad = l:id_localidad
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        l:id_localidad = Loc:id_localidad
        l:localidad = Loc:Localidad
      END
      ThisWindow.Reset(1)
    OF ?EvoExportar
      ThisWindow.Update
       Do PrintExBrowse11
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  !Take Sort Headers Events
  IF BRW1::SortHeader.TakeEvents()
     RETURN Level:Notify
  END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeFieldEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all field specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeFieldEvent()
  CASE FIELD()
  OF ?l:fecha_desde
    do calcular_periodo
  OF ?BotonSeleccionFechaDesde
    do calcular_periodo
    DISPLAY
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END
  SELF.ViewControl = ?View                                 ! Setup the control used to initiate view only mode


BRW1.ResetFromView PROCEDURE

l:cant_viajes:Cnt    LONG                                  ! Count variable for browse totals
l:cant_producto:Sum  REAL                                  ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:Viajes.SetQuickScan(1)
  SELF.Reset
  IF SELF.UseMRP
     IF SELF.View{PROP:IPRequestCount} = 0
          SELF.View{PROP:IPRequestCount} = 60
     END
  END
  LOOP
    IF SELF.UseMRP
       IF SELF.View{PROP:IPRequestCount} = 0
            SELF.View{PROP:IPRequestCount} = 60
       END
    END
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      SETCURSOR()
      RETURN
    END
    SELF.SetQueueRecord
    l:cant_viajes:Cnt += 1
    l:cant_producto:Sum += via:peso
  END
  SELF.View{PROP:IPRequestCount} = 0
  l:cant_viajes = l:cant_viajes:Cnt
  l:cant_producto = l:cant_producto:Sum
  PARENT.ResetFromView
  Relate:Viajes.SetQuickScan(0)
  SETCURSOR()


BRW1.SetSort PROCEDURE(BYTE NewOrder,BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.SetSort(NewOrder,Force)
  IF BRW1::LastSortOrder<>NewOrder THEN
     BRW1::SortHeader.ClearSort()
  END
  BRW1::LastSortOrder=NewOrder
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

BRW1::SortHeader.QueueResorted       PROCEDURE(STRING pString)
  CODE
    IF pString = ''
       BRW1.RestoreSort()
       BRW1.ResetSort(True)
    ELSE
       BRW1.ReplaceSort(pString,BRW1::Sort0:Locator)
       BRW1.SetLocatorFromSort()
    END
!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
ReportBalanceProducto PROCEDURE (STRING pFiltro,STRING pOrden)

Progress:Thermometer BYTE                                  !
l:id_viaje           STRING(20)                            !
l:prod_tonel         LONG                                  !
l:titulopie          STRING(500)                           !
l:TituloFecha        STRING(100)                           !
l:campoBreak         LONG                                  !
l:cant_viajes        LONG                                  !
l:fecha_desde        DATE                                  !
l:total_producto     LONG                                  !
l:fecha_hasta        DATE                                  !
l:importe_dnl        DECIMAL(12,2)                         !
l:total_importe      DECIMAL(12,2)                         !
l:fecha_descarga     DATE                                  !
l:subtotal_importe   DECIMAL(12,2)                         !
l:importe_producto   DECIMAL(12,2)                         !
Process:View         VIEW(Viajes)
                       PROJECT(via:fecha_carga_DATE)
                       PROJECT(via:guia_transporte)
                       PROJECT(via:id_proveedor)
                       PROJECT(via:id_viaje)
                       PROJECT(via:nro_remito)
                       PROJECT(via:peso)
                       PROJECT(via:id_procedencia)
                       PROJECT(via:id_localidad)
                       PROJECT(via:id_transportista)
                       JOIN(pro1:PK_PROCEDENCIA,via:id_procedencia)
                         PROJECT(pro1:procedencia)
                       END
                       JOIN(pro:PK_proveedor,via:id_proveedor)
                         PROJECT(pro:proveedor)
                       END
                       JOIN(Loc:PK_localidad,via:id_localidad)
                         PROJECT(Loc:Localidad)
                       END
                       JOIN(tra:PK_TRANSPORTISTA,via:id_transportista)
                         PROJECT(tra:transportista)
                       END
                       JOIN(des:KEY__WA_Sys_id_viaje_3D5E1FD2,via:id_viaje)
                         PROJECT(des:cantidad)
                         PROJECT(des:fecha_descarga_DATE)
                         PROJECT(des:id_planta)
                         JOIN(pla:PK__plantas__7D439ABD,des:id_planta)
                           PROJECT(pla:NRO_PLANTA)
                         END
                       END
                     END
ProgressWindow       WINDOW,AT(,,142,69),DOUBLE,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON,AT(56,43,28,21),USE(?Progress:Cancel),ICON('Cancelar.ico'),FLAT,TRN
                     END

Report               REPORT,AT(177,1895,11448,5844),PRE(RPT),PAPER(PAPER:A4),LANDSCAPE,FONT('Arial',10,,FONT:regular, |
  CHARSET:ANSI),THOUS
                       HEADER,AT(177,198,11375,1719),USE(?Header)
                         STRING('BALANCE DE PRODUCTO'),AT(4885,198,1781),USE(?STRING1),FONT(,10,,FONT:bold)
                         STRING('Fecha Car.'),AT(42,1448,594,198),USE(?STRING1:4),FONT(,9,COLOR:Black,FONT:regular)
                         STRING('Producto Car'),AT(4156,1448,781,198),USE(?STRING1:5),FONT(,9,COLOR:Black,FONT:regular)
                         STRING('PLANTAS DE GAS PROPANO'),AT(4885,406,1875,198),USE(?STRING1:2),FONT(,9,,FONT:bold)
                         STRING('Procedencia'),AT(1021,1448,771,198),USE(?STRING1:6),FONT(,9,COLOR:Black,FONT:regular)
                         STRING('Gerencia Comercial'),AT(9927,198,1396,198),USE(?STRING1:3),FONT(,9,,FONT:bold)
                         STRING('N° Remito'),AT(3302,1448,687,198),USE(?STRING1:7),FONT(,9,COLOR:Black,FONT:regular)
                         IMAGE('Logo DISTRIGAS Chico.bmp'),AT(21,156,1010,573),USE(?IMAGE1)
                         STRING('Proveedor'),AT(2219,1448,656,198),USE(?STRING1:8),FONT(,9,COLOR:Black,FONT:regular), |
  TRN
                         STRING('Av. Pte Kirchner 669 - 6° Piso'),AT(21,812,1885,156),USE(?STRING1:12),FONT(,8,,FONT:bold)
                         STRING('Destino'),AT(5969,1458,479,177),USE(?STRING1:9),FONT(,9,COLOR:Black,FONT:regular), |
  TRN
                         STRING('Río Gallegos - Santa Cruz'),AT(21,979,1885,156),USE(?STRING1:11),FONT(,8,,FONT:bold)
                         STRING('Tel. (02966) 420034/437928'),AT(21,1146,1885,156),USE(?STRING1:10),FONT(,8,,FONT:bold)
                         STRING('Fecha Desc'),AT(5031,1448,750,198),USE(?STRING1:13),FONT(,9,COLOR:Black,FONT:regular)
                         STRING('Transportista'),AT(7271,1448,833,198),USE(?STRING1:14),FONT(,9,COLOR:Black,FONT:regular)
                         STRING('Guia Transp.'),AT(8208,1448,854,198),USE(?STRING1:15),FONT(,9,COLOR:Black,FONT:regular)
                         STRING('Desc. p/planta'),AT(9229,1458,865,187),USE(?STRING1:16),FONT(,9,COLOR:Black,FONT:regular), |
  TRN
                         BOX,AT(21,1385,11167,312),USE(?BOX1),COLOR(COLOR:Black),LINEWIDTH(2)
                         STRING('Total Desc.'),AT(10312,1448,687,187),USE(?STRING1:17),FONT(,9,COLOR:Black,FONT:regular), |
  TRN
                         LINE,AT(10083,1385,0,312),USE(?LINE2),COLOR(COLOR:Black)
                         LINE,AT(9135,1385,0,312),USE(?LINE2:2),COLOR(COLOR:Black)
                         LINE,AT(8135,1385,0,312),USE(?LINE2:3),COLOR(COLOR:Black)
                         LINE,AT(7208,1385,0,312),USE(?LINE2:4),COLOR(COLOR:Black)
                         LINE,AT(5781,1385,0,312),USE(?LINE2:5),COLOR(COLOR:Black)
                         LINE,AT(4969,1385,0,312),USE(?LINE2:6),COLOR(COLOR:Black)
                         LINE,AT(4083,1385,0,312),USE(?LINE2:7),COLOR(COLOR:Black)
                         LINE,AT(3135,1385,0,312),USE(?LINE2:8),COLOR(COLOR:Black)
                         LINE,AT(2104,1385,0,312),USE(?LINE2:9),COLOR(COLOR:Black)
                         LINE,AT(729,1385,0,312),USE(?LINE2:10),COLOR(COLOR:Black)
                         LINE,AT(6677,1396,0,312),USE(?LINE2:23),COLOR(COLOR:Black)
                         STRING('Pta nro'),AT(6708,1448,479,177),USE(?STRING1:18),FONT(,9,COLOR:Black,FONT:regular), |
  TRN
                       END
detail2                DETAIL,AT(0,0,11385,260),USE(?DETAIL2)
                         STRING(@s50),AT(2198,31,875,177),USE(pro:proveedor,,?pro:proveedor:4),FONT(,8,,,CHARSET:DEFAULT)
                         STRING(@d6),AT(31,31,635,177),USE(via:fecha_carga_DATE,,?via:fecha_carga_DATE:2),FONT(,8,, |
  ,CHARSET:DEFAULT)
                         STRING(@N-10.),AT(4292,31,,177),USE(via:peso,,?via:peso:2),FONT(,8,,,CHARSET:DEFAULT)
                         STRING(@s50),AT(792,31,1156,177),USE(pro1:procedencia),FONT(,8,,,CHARSET:DEFAULT)
                         STRING(@s50),AT(3167,31,844,177),USE(via:nro_remito),FONT(,8,,,CHARSET:DEFAULT)
                         STRING(@s20),AT(5792,31,885,177),USE(Loc:Localidad),FONT(,8,,,CHARSET:DEFAULT)
                         STRING(@d6),AT(5125,31,635,177),USE(des:fecha_descarga_DATE),FONT(,8,,,CHARSET:DEFAULT)
                         STRING(@s50),AT(7250,31,854,240),USE(tra:transportista),FONT(,8,,,CHARSET:DEFAULT)
                         STRING(@s50),AT(8187,31,885,177),USE(via:guia_transporte),FONT(,8,,,CHARSET:DEFAULT)
                         STRING(@N-14.),AT(9187,31,917,177),USE(des:cantidad),FONT(,8,,,CHARSET:DEFAULT)
                         LINE,AT(21,260,11167,0),USE(?LINE1)
                         LINE,AT(729,0,0,260),USE(?LINE2:11)
                         LINE,AT(2104,0,0,260),USE(?LINE2:12)
                         LINE,AT(3135,0,0,260),USE(?LINE2:13)
                         LINE,AT(4083,0,0,260),USE(?LINE2:14)
                         LINE,AT(4969,0,0,260),USE(?LINE2:15)
                         LINE,AT(5781,0,0,260),USE(?LINE2:16)
                         LINE,AT(7208,0,0,260),USE(?LINE2:17)
                         LINE,AT(8135,0,0,260),USE(?LINE2:18)
                         LINE,AT(9135,0,0,260),USE(?LINE2:19)
                         LINE,AT(10083,0,0,260),USE(?LINE2:20)
                         LINE,AT(11177,0,0,260),USE(?LINE2:21)
                         LINE,AT(21,0,0,260),USE(?LINE2:22)
                         LINE,AT(6677,-9,0,260),USE(?LINE2:24)
                         STRING(@P<<P),AT(6802,10),USE(pla:NRO_PLANTA,,?pla:NRO_PLANTA:2)
                         STRING(@N-14.),AT(10281,10,698),USE(l:total_producto,,?l:total_producto:3),FONT(,8)
                       END
                       FOOTER,AT(177,7802,9542,344),USE(?Footer)
                         STRING('Fecha impresión:'),AT(73,62),USE(?ReportDatePrompt),FONT(,8),TRN
                         STRING('<<-- Date Stamp -->'),AT(1187,62),USE(?ReportDateStamp),FONT(,8),TRN
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepLongClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('ReportBalanceProducto')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:Viajes.SetOpenRelated()
  Relate:Viajes.Open                                       ! File Viajes used by this procedure, so make sure it's RelationManager is open
  Relate:parametros.Open                                   ! File parametros used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  !Buscar los parametros de sistema 
  par:ID_PARAMETRO = 1
  Access:parametros.fetch(par:PK_parametros)
  
  
  !l:fecha_desde = GLO:fecha_Desde
  !l:fecha_hasta = GLO:fecha_hasta
  !IF l:fecha_hasta AND l:fecha_desde
  !    l:TituloFecha ='PREVISIÓN DE DESDE '&format(l:fecha_desde,@d6)&' A '&format(l:fecha_hasta,@d6)
  !ELSE
  !    l:TituloFecha=''
  !END
  
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('ReportBalanceProducto',ProgressWindow)     ! Restore window settings from non-volatile store
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:Viajes, ?Progress:PctText, Progress:Thermometer, ProgressMgr, via:id_viaje)
  ThisReport.AddSortOrder(via:PK_viajes)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:Viajes.SetQuickScan(1,Propagate:OneMany)
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  SELF.SetAlerts()
  !Filtrar por los parametros enviados
  ThisReport.setFilter(pFiltro)
  
  
      
  ThisReport.SetOrder('via:fecha_carga_DATE,'&clip(porden))
  
  l:id_viaje = via:id_viaje
  
  
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Viajes.Close
    Relate:parametros.Close
  END
  IF SELF.Opened
    INIMgr.Update('ReportBalanceProducto',ProgressWindow)  ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp{PROP:Text} = FORMAT(TODAY(),@D17)
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  l:total_producto = 0
  
  if l:id_viaje <>via:id_viaje
      
      l:total_producto = via:peso_descargado
  
  END
  
  l:id_viaje = via:id_viaje
  IF (l:campoBreak = via:id_proveedor)
    l:cant_viajes = 1 + l:cant_viajes
  ELSE
    l:cant_viajes = 1
  END
  IF (l:campoBreak = via:id_proveedor)
    l:total_producto = via:peso + l:total_producto
  ELSE
    l:total_producto = via:peso
  END
  IF (l:fecha_desde = 0)
    l:fecha_desde = via:fecha_carga_DATE
  ELSE
    IF (via:fecha_carga_DATE < l:fecha_desde)
      l:fecha_desde = via:fecha_carga_DATE
    ELSE
      l:fecha_desde = l:fecha_desde
    END
  END
  IF (l:fecha_hasta = 0)
    l:fecha_hasta = via:fecha_carga_DATE
  ELSE
    IF (l:campoBreak = via:id_proveedor)
      IF (via:fecha_carga_DATE > l:fecha_hasta)
        l:fecha_hasta = via:fecha_carga_DATE
      ELSE
        l:fecha_hasta = l:fecha_hasta
      END
    ELSE
      l:fecha_hasta = via:fecha_carga_DATE
    END
  END
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail2)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
BrowseAnticiposGenerados PROCEDURE 

CurrentTab           STRING(80)                            !
L:buscador           STRING(255)                           !
BRW1::View:Browse    VIEW(viajes_anticipos)
                       PROJECT(sol:id_solicitud)
                       PROJECT(sol:fecha_emision_DATE)
                       PROJECT(sol:importe)
                       PROJECT(sol:producto)
                       PROJECT(sol:IMPORTE_DNL)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
sol:id_solicitud       LIKE(sol:id_solicitud)         !List box control field - type derived from field
sol:fecha_emision_DATE LIKE(sol:fecha_emision_DATE)   !List box control field - type derived from field
sol:importe            LIKE(sol:importe)              !List box control field - type derived from field
sol:producto           LIKE(sol:producto)             !List box control field - type derived from field
sol:IMPORTE_DNL        LIKE(sol:IMPORTE_DNL)          !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW6::View:Browse    VIEW(Viajes)
                       PROJECT(via:id_solicitud)
                       PROJECT(via:id_viaje)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
via:id_solicitud       LIKE(via:id_solicitud)         !List box control field - type derived from field
via:id_viaje           LIKE(via:id_viaje)             !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseAnticiposGenerados'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(71,62,393,113),USE(?Browse:1),HVSCROLL,FORMAT('64R(2)|M~Id Solicitud~C(0)@n-14@' & |
  '60R(2)|M~Fecha emisión~C(0)@d17@80D(32)|M~Importe~C(0)@n-25.2@64R(2)|M~Producto~C(0)' & |
  '@n-14@108R(2)|M~Importe DNL~C(0)@n-26.2@'),FROM(Queue:Browse:1),IMM,MSG('Browsing th' & |
  'e viajes_anticipos file')
                       BUTTON,AT(162,284,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(209,284,25,25),USE(?View:3),ICON('Ver.ico'),FLAT,MSG('Visualiza el registro'),TIP('Visualiza ' & |
  'el registro')
                       BUTTON,AT(255,284,25,25),USE(?Insert:4),ICON('Insertar.ico'),FLAT,MSG('Inserta un Registro'), |
  TIP('Inserta un Registro')
                       BUTTON,AT(296,284,25,25),USE(?Change:4),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Modifica e' & |
  'l registro'),TIP('Modifica el registro')
                       BUTTON,AT(347,284,25,25),USE(?Delete:4),ICON('Eliminar.ICO'),FLAT,MSG('Elimina un registro'), |
  TIP('Elimina un registro')
                       BUTTON,AT(457,284,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       STRING('Anticipos Generados'),AT(217,18,92,12),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       BUTTON,AT(395,284,25,25),USE(?Delete),ICON('Imprimir.ico'),FLAT,MSG('Elimina un registro'), |
  TIP('Elimina un registro')
                       LIST,AT(71,180,150,100),USE(?List),RIGHT(1),FORMAT('60L(2)|M~id solicitud~L(1)@n-14@80L' & |
  '(2)|M~Id viaje~L(0)@N_20_@'),FROM(Queue:Browse),IMM
                       ENTRY(@s255),AT(174,45,147),USE(L:buscador)
                       STRING('Buscar'),AT(135,44),USE(?STRING2),FONT(,,,FONT:bold),TRN
                       BUTTON,AT(352,44,16,14),USE(?Browse:Top),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page')
                       BUTTON,AT(371,44,16,14),USE(?Browse:PageUp),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the Prior Page')
                       BUTTON,AT(389,44,16,14),USE(?Browse:Up),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record')
                       BUTTON,AT(408,44,16,14),USE(?Browse:Down),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record')
                       BUTTON,AT(427,44,16,14),USE(?Browse:PageDown),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page')
                       BUTTON,AT(445,44,16,14),USE(?Browse:Bottom),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page')
                     END

BRW1::Toolbar        BrowseToolbarClass
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetAlerts              PROCEDURE(),DERIVED
                     END

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator
BRW11                CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
                     END

BRW6::Sort0:Locator  StepLocatorClass                      ! Default Locator
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseAnticiposGenerados')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('sol:id_solicitud',sol:id_solicitud)                ! Added by: BrowseBox(ABC)
  BIND('sol:IMPORTE_DNL',sol:IMPORTE_DNL)                  ! Added by: BrowseBox(ABC)
  BIND('via:id_viaje',via:id_viaje)                        ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  BRW1::Toolbar.Init(SELF,BRW1)
  BRW1::Toolbar.InitBrowse(0, 0, 0, 0)
  BRW1::Toolbar.InitVCR(?Browse:Top, ?Browse:Bottom, ?Browse:PageUp, ?Browse:PageDown, ?Browse:Up, ?Browse:Down, 0)
  BRW1::Toolbar.InitMisc(0, 0)
  SELF.AddItem(BRW1::Toolbar.WindowComponent)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Viajes.SetOpenRelated()
  Relate:Viajes.Open                                       ! File Viajes used by this procedure, so make sure it's RelationManager is open
  Relate:viajes_anticipos.Open                             ! File viajes_anticipos used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:viajes_anticipos,SELF) ! Initialize the browse manager
  BRW11.Init(?List,Queue:Browse.ViewPosition,BRW6::View:Browse,Queue:Browse,Relate:Viajes,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,sol:PK_solicitudes_anticipos)         ! Add the sort order for sol:PK_solicitudes_anticipos for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?L:buscador,sol:id_solicitud,,BRW1) ! Initialize the browse locator using ?L:buscador using key: sol:PK_solicitudes_anticipos , sol:id_solicitud
  BRW1.AddField(sol:id_solicitud,BRW1.Q.sol:id_solicitud)  ! Field sol:id_solicitud is a hot field or requires assignment from browse
  BRW1.AddField(sol:fecha_emision_DATE,BRW1.Q.sol:fecha_emision_DATE) ! Field sol:fecha_emision_DATE is a hot field or requires assignment from browse
  BRW1.AddField(sol:importe,BRW1.Q.sol:importe)            ! Field sol:importe is a hot field or requires assignment from browse
  BRW1.AddField(sol:producto,BRW1.Q.sol:producto)          ! Field sol:producto is a hot field or requires assignment from browse
  BRW1.AddField(sol:IMPORTE_DNL,BRW1.Q.sol:IMPORTE_DNL)    ! Field sol:IMPORTE_DNL is a hot field or requires assignment from browse
  BRW11.Q &= Queue:Browse
  BRW11.RetainRow = 0
  BRW11.AddSortOrder(,via:FK_SOLICITUD)                    ! Add the sort order for via:FK_SOLICITUD for sort order 1
  BRW11.AddRange(via:id_solicitud,sol:id_solicitud)        ! Add single value range limit for sort order 1
  BRW11.AddLocator(BRW6::Sort0:Locator)                    ! Browse has a locator for sort order 1
  BRW6::Sort0:Locator.Init(,via:id_solicitud,1,BRW11)      ! Initialize the browse locator using  using key: via:FK_SOLICITUD , via:id_solicitud
  BRW11.AddField(via:id_solicitud,BRW11.Q.via:id_solicitud) ! Field via:id_solicitud is a hot field or requires assignment from browse
  BRW11.AddField(via:id_viaje,BRW11.Q.via:id_viaje)        ! Field via:id_viaje is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseAnticiposGenerados',QuickWindow)     ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1
  BRW11.AddToolbarTarget(Toolbar)                          ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Viajes.Close
    Relate:viajes_anticipos.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseAnticiposGenerados',QuickWindow)  ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    UpdateViajesAnticipos
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Delete
      ThisWindow.Update
      START(ReportSolicitudAnticipo, 25000, BRW11.VIEW{PROP:FILTER},BRW11.VIEW{PROP:ORDER})
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select:2
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:4
    SELF.ChangeControl=?Change:4
    SELF.DeleteControl=?Delete:4
  END
  SELF.ViewControl = ?View:3                               ! Setup the control used to initiate view only mode


BRW1.SetAlerts PROCEDURE

  CODE
  SELF.EditViaPopup = False
  PARENT.SetAlerts


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
SelectLocalidadGlobal PROCEDURE 

Window               WINDOW,AT(,,213,77),FONT('Microsoft Sans Serif',8,,FONT:regular),DOUBLE,GRAY,MDI,WALLPAPER('fondo.jpg')
                       PROMPT('Localidad:'),AT(16,26),USE(?GLO:localidad_id:Prompt)
                       ENTRY(@n-14),AT(54,25,23,10),USE(GLO:localidad_id),RIGHT(1)
                       STRING(@s20),AT(98,26),USE(Loc:Localidad),FONT(,,,FONT:regular)
                       BUTTON('...'),AT(81,23,12,12),USE(?CallLookup)
                       BUTTON('Close'),AT(162,50),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SelectLocalidadGlobal')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?GLO:localidad_id:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Localidades_GLP.Open                              ! File Localidades_GLP used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('SelectLocalidadGlobal',Window)             ! Restore window settings from non-volatile store
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Localidades_GLP.Close
  END
  IF SELF.Opened
    INIMgr.Update('SelectLocalidadGlobal',Window)          ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      SelectLocalidades_GLP
      SelectLocalidades_GLP
    END
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?GLO:localidad_id
      if GlobalResponse = RequestCompleted
          return Level:Fatal
      END
      IF GLO:localidad_id OR ?GLO:localidad_id{PROP:Req}
        Loc:id_localidad = GLO:localidad_id
        IF Access:Localidades_GLP.TryFetch(Loc:PK_localidad)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            GLO:localidad_id = Loc:id_localidad
          ELSE
            SELECT(?GLO:localidad_id)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookup
      ThisWindow.Update
      Loc:id_localidad = GLO:localidad_id
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        GLO:localidad_id = Loc:id_localidad
      END
      ThisWindow.Reset(1)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?GLO:localidad_id
      Loc:id_localidad = GLO:localidad_id
      IF Access:Localidades_GLP.TryFetch(Loc:PK_localidad)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          GLO:localidad_id = Loc:id_localidad
        END
      END
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Report
!!! Report the Existencias File
!!! </summary>
ReportExistencias PROCEDURE (STRING pfilter,STRING pOrder)

Progress:Thermometer BYTE                                  !
Process:View         VIEW(Existencias)
                       PROJECT(exi:AUTONOMIA)
                       PROJECT(exi:FECHA_LECTURA_DATE)
                       PROJECT(exi:capacidad_planta)
                       PROJECT(exi:consumo)
                       PROJECT(exi:existencia)
                       PROJECT(exi:existencia_anterior)
                       PROJECT(exi:id_existencia)
                       PROJECT(exi:porc_existencia)
                       PROJECT(exi:ultima_descarga)
                       PROJECT(exi:id_planta)
                       PROJECT(exi:id_localidad)
                       JOIN(pla:PK__plantas__7D439ABD,exi:id_planta)
                         PROJECT(pla:NRO_PLANTA)
                       END
                       JOIN(Loc:PK_localidad,exi:id_localidad)
                         PROJECT(Loc:Localidad)
                       END
                     END
ProgressWindow       WINDOW,AT(,,142,80),FONT('Microsoft Sans Serif',8,COLOR:Black,FONT:regular,CHARSET:DEFAULT), |
  DOUBLE,CENTER,GRAY,TIMER(1),WALLPAPER('fondo.jpg')
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON,AT(58,32,25,25),USE(?Progress:Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar Reporte'), |
  TIP('Cancelar Reporte')
                     END

Report               REPORT('Existencias Report'),AT(250,2760,8000,5375),PRE(RPT),PAPER(PAPER:LETTER),LANDSCAPE, |
  FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),THOUS
                       HEADER,AT(250,250,8000,2458),USE(?Header),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT)
                         STRING('Existencias de Producto'),AT(3031,646,2219,220),USE(?ReportTitle),FONT('Arial',12, |
  ,FONT:bold+FONT:italic+FONT:underline,CHARSET:DEFAULT),CENTER
                         IMAGE('Logo DISTRIGAS Chico.bmp'),AT(115,146,1812,990),USE(?IMAGE1)
                         STRING('Av. Pte Kirchner 669 - 6° Piso'),AT(115,1187,1885,156),USE(?STRING1),FONT(,8,,FONT:bold)
                         STRING('Río Gallegos - Santa Cruz'),AT(115,1354,1885,156),USE(?STRING1:2),FONT(,8,,FONT:bold)
                         STRING('Tel. (02966) 420034/437928'),AT(115,1531,1885,156),USE(?STRING1:3),FONT(,8,,FONT:bold)
                         STRING('Desde:'),AT(2729,1948,542,219),USE(?ReportTitle:2),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:DEFAULT),CENTER,TRN
                         STRING('Hasta:'),AT(4177,1948,469,219),USE(?ReportTitle:3),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:DEFAULT),CENTER,TRN
                         STRING(@d6),AT(3333,1948,781,219),USE(GLO:fecha_Desde),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:DEFAULT),CENTER,TRN
                         STRING(@d6),AT(4635,1948,792,219),USE(GLO:fecha_hasta),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:DEFAULT),CENTER,TRN
                       END
breakLocalidad         BREAK(exi:id_localidad),USE(?BREAK1)
                         HEADER,AT(0,0,8000,0),USE(?GROUPHEADER1)
                         END
                         FOOTER,AT(0,0,8000,0),USE(?GROUPFOOTER1)
                         END
                       END
breakPlanta            BREAK(exi:id_planta),USE(?BREAK2)
                         HEADER,AT(0,0),USE(?GROUPHEADER3)
                           BOX,AT(0,729,8000,250),USE(?HeaderBox),COLOR(COLOR:Black),FILL(COLOR:Black),LINEWIDTH(1)
                           LINE,AT(979,729,0,250),USE(?HeaderLine:1),COLOR(COLOR:Black)
                           LINE,AT(1979,729,0,250),USE(?HeaderLine:2),COLOR(COLOR:Black)
                           LINE,AT(2979,729,0,250),USE(?HeaderLine:3),COLOR(COLOR:Black)
                           LINE,AT(3979,729,0,250),USE(?HeaderLine:4),COLOR(COLOR:Black)
                           LINE,AT(4979,729,0,250),USE(?HeaderLine:5),COLOR(COLOR:Black)
                           LINE,AT(5979,729,0,250),USE(?HeaderLine:6),COLOR(COLOR:Black)
                           LINE,AT(6979,729,0,250),USE(?HeaderLine:7),COLOR(COLOR:Black)
                           STRING('Fecha Lectura'),AT(31,781,900,170),USE(?HeaderTitle:1),FONT(,,COLOR:White,FONT:bold), |
  CENTER,COLOR(COLOR:Black),TRN
                           STRING('Existencia'),AT(2052,781,900,170),USE(?HeaderTitle:2),FONT(,,COLOR:White,FONT:bold), |
  CENTER,COLOR(COLOR:Black),TRN
                           STRING('Existencia ant.'),AT(1010,781,958,177),USE(?HeaderTitle:3),FONT(,,COLOR:White,FONT:bold), |
  CENTER,COLOR(COLOR:Black),TRN
                           STRING('porc existencia'),AT(4031,781,900,170),USE(?HeaderTitle:4),FONT(,,COLOR:White,FONT:bold), |
  CENTER,COLOR(COLOR:Black),TRN
                           STRING('Consumo'),AT(3031,781,900,170),USE(?HeaderTitle:5),FONT(,,COLOR:White,FONT:bold),CENTER, |
  COLOR(COLOR:Black),TRN
                           STRING('Ultima descarga'),AT(5031,781,900,170),USE(?HeaderTitle:6),FONT(,,COLOR:White,FONT:bold), |
  CENTER,COLOR(COLOR:Black),TRN
                           STRING('Cap. Planta'),AT(6031,781,900,170),USE(?HeaderTitle:7),FONT(,,COLOR:White,FONT:bold), |
  CENTER,COLOR(COLOR:Black),TRN
                           STRING('Autonomía'),AT(7031,781,900,170),USE(?HeaderTitle:8),FONT(,,COLOR:White,FONT:bold), |
  CENTER,COLOR(COLOR:Black),TRN
                           STRING(@s20),AT(833,146),USE(Loc:Localidad),FONT('Arial',10,,FONT:bold+FONT:italic,CHARSET:ANSI)
                           STRING(@P<<P),AT(3135,146),USE(pla:NRO_PLANTA),FONT('Arial',10,,FONT:bold+FONT:italic,CHARSET:ANSI)
                           STRING('Localidad:'),AT(94,146,719,167),USE(?HeaderTitle:9),FONT('Arial',10,,FONT:bold+FONT:italic, |
  CHARSET:ANSI),TRN
                           STRING('Planta Nro:'),AT(2406,146,771,198),USE(?HeaderTitle:10),FONT('Arial',10,,FONT:bold+FONT:italic, |
  CHARSET:ANSI),TRN
                         END
detail2                  DETAIL,AT(0,0,8000,292),USE(?DETAIL2)
                           LINE,AT(-9,-20,0,250),USE(?DetailLine:0),COLOR(COLOR:Black)
                           LINE,AT(979,0,0,250),USE(?DetailLine:1),COLOR(COLOR:Black)
                           LINE,AT(1979,0,0,250),USE(?DetailLine:2),COLOR(COLOR:Black)
                           LINE,AT(2979,0,0,250),USE(?DetailLine:3),COLOR(COLOR:Black)
                           LINE,AT(3979,0,0,250),USE(?DetailLine:4),COLOR(COLOR:Black)
                           LINE,AT(4979,0,0,250),USE(?DetailLine:5),COLOR(COLOR:Black)
                           LINE,AT(5979,0,0,250),USE(?DetailLine:6),COLOR(COLOR:Black)
                           LINE,AT(6979,0,0,250),USE(?DetailLine:7),COLOR(COLOR:Black)
                           STRING(@d6),AT(31,31,900,170),USE(exi:FECHA_LECTURA_DATE),CENTER
                           STRING(@N-20~ KG~),AT(2052,52,900,170),USE(exi:existencia),LEFT
                           STRING(@N-20~KG~),AT(1052,52,900,170),USE(exi:existencia_anterior),LEFT
                           STRING(@N-7.~ %~),AT(4031,52,900,170),USE(exi:porc_existencia),LEFT
                           STRING(@N-20~ KG~),AT(3031,52,900,170),USE(exi:consumo),LEFT
                           STRING(@N-20~ KG~),AT(5031,31,900,170),USE(exi:ultima_descarga),LEFT
                           STRING(@N-20~ KG~),AT(6031,31,900,170),USE(exi:capacidad_planta),LEFT
                           STRING(@P<<<# DíasP),AT(7031,31,900,170),USE(exi:AUTONOMIA),CENTER(4)
                           LINE,AT(-9,260,8000,0),USE(?DetailEndLine),COLOR(COLOR:Black)
                           LINE,AT(7979,0,0,250),USE(?DetailLine:8),COLOR(COLOR:Black)
                         END
                         FOOTER,AT(0,0,8000,208),USE(?GROUPFOOTER2),PAGEAFTER(1)
                         END
                       END
                       FOOTER,AT(250,8200,8667,250),USE(?Footer)
                         STRING('Fecha Impresión:'),AT(115,52,979,187),USE(?ReportDatePrompt:2),FONT('Arial',8,,FONT:regular), |
  TRN
                         STRING('<<-- Date Stamp -->'),AT(1062,62,927,135),USE(?ReportDateStamp:2),FONT('Arial',8,, |
  FONT:regular),TRN
                         STRING('Hora:'),AT(2031,62,271,135),USE(?ReportTimePrompt:2),FONT('Arial',8,,FONT:regular), |
  TRN
                         STRING('<<-- Time Stamp -->'),AT(2333,62,927,135),USE(?ReportTimeStamp:2),FONT('Arial',8,, |
  FONT:regular),TRN
                         STRING(@pPágina <<#p),AT(8042,62,700,135),USE(?PageCount:2),FONT('Arial',8,,FONT:regular), |
  PAGENO
                       END
                       FORM,AT(250,250,8000,10500),USE(?Form),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT)
                         IMAGE,AT(0,0,8000,10500),USE(?FormImage),TILED
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepLongClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('ReportExistencias')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:Existencias.SetOpenRelated()
  Relate:Existencias.Open                                  ! File Existencias used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('ReportExistencias',ProgressWindow)         ! Restore window settings from non-volatile store
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:Existencias, ?Progress:PctText, Progress:Thermometer, ProgressMgr, exi:id_existencia)
  ThisReport.AddSortOrder(exi:PK__EXISTENC__36B12243)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:Existencias.SetQuickScan(1,Propagate:OneMany)
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  Previewer.Maximize = True
  SELF.SetAlerts()
  thisreport.SetFilter(pfilter)
  !porder=clip(pOrder)&',exi:FECHA_LECTURA_DATE'
  !message(porder)
  !ThisReport.SetOrder('exi:id_planta','exi:FECHA_LECTURA_DATE')
  
  
  ThisReport.SetOrder('exi:id_planta,exi:FECHA_LECTURA_DATE,exi:id_localidad')
  
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Existencias.Close
  END
  IF SELF.Opened
    INIMgr.Update('ReportExistencias',ProgressWindow)      ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp:2{PROP:Text} = FORMAT(TODAY(),@D17)
  END
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportTimeStamp:2{PROP:Text} = FORMAT(CLOCK(),@T7)
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail2)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Window
!!! Form viajes_anticipos
!!! </summary>
UpdateViajesAnticipos PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
BRW2::View:Browse    VIEW(Viajes)
                       PROJECT(via:id_viaje)
                       PROJECT(via:id_procedencia)
                       PROJECT(via:id_transportista)
                       PROJECT(via:guia_transporte)
                       PROJECT(via:id_proveedor)
                       PROJECT(via:id_programacion)
                       PROJECT(via:nro_remito)
                       PROJECT(via:peso)
                       PROJECT(via:fecha_carga_DATE)
                       PROJECT(via:id_solicitud)
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?Browse:2
via:id_viaje           LIKE(via:id_viaje)             !List box control field - type derived from field
via:id_procedencia     LIKE(via:id_procedencia)       !List box control field - type derived from field
via:id_transportista   LIKE(via:id_transportista)     !List box control field - type derived from field
via:guia_transporte    LIKE(via:guia_transporte)      !List box control field - type derived from field
via:id_proveedor       LIKE(via:id_proveedor)         !List box control field - type derived from field
via:id_programacion    LIKE(via:id_programacion)      !List box control field - type derived from field
via:nro_remito         LIKE(via:nro_remito)           !List box control field - type derived from field
via:peso               LIKE(via:peso)                 !List box control field - type derived from field
via:fecha_carga_DATE   LIKE(via:fecha_carga_DATE)     !List box control field - type derived from field
via:id_solicitud       LIKE(via:id_solicitud)         !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::sol:Record  LIKE(sol:RECORD),THREAD
QuickWindow          WINDOW('Form viajes_anticipos'),AT(,,204,149),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('UpdateViajesAnticipos'),SYSTEM,WALLPAPER('fondo.jpg')
                       SHEET,AT(4,4,196,112),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('id solicitud:'),AT(8,20),USE(?sol:id_solicitud:Prompt),TRN
                           ENTRY(@n-14),AT(88,20,64,10),USE(sol:id_solicitud)
                           PROMPT('fecha emision DATE:'),AT(8,34),USE(?sol:fecha_emision_DATE:Prompt),TRN
                           ENTRY(@d17),AT(88,34,104,10),USE(sol:fecha_emision_DATE)
                           PROMPT('fecha emision TIME:'),AT(8,48),USE(?sol:fecha_emision_TIME:Prompt),TRN
                           ENTRY(@t7),AT(88,48,104,10),USE(sol:fecha_emision_TIME)
                           PROMPT('importe:'),AT(8,62),USE(?sol:importe:Prompt),TRN
                           ENTRY(@n-25.2),AT(88,62,108,10),USE(sol:importe)
                           PROMPT('producto:'),AT(8,76),USE(?sol:producto:Prompt),TRN
                           ENTRY(@n-14),AT(88,76,64,10),USE(sol:producto),RIGHT(1)
                         END
                         TAB('&2) Viajes'),USE(?Tab:2)
                           LIST,AT(8,20,188,63),USE(?Browse:2),HVSCROLL,FORMAT('36L(2)|M~Id viaje~L(2)@P<<<<<<<<<<' & |
  '<<P@64R(2)|M~id procedencia~C(0)@n-14@68L(2)|M~ID Transportista~L(2)@P<<<<<<P@80L(2)' & |
  '|M~guia transporte~L(2)@s50@52L(2)|M~ID Proveedor~L(2)@P<<<<<<<<<<P@32L(2)|M~Id Cupo' & |
  '~L(2)@P<<<<<<<<<<<<P@80L(2)|M~nro remito~L(2)@s50@48D(22)|M~Peso~C(0)@N-10.`2@80R(2)' & |
  '|M~Fecha carga~C(0)@d6@'),FROM(Queue:Browse:2),IMM,MSG('Browsing the Viajes file')
                           BUTTON,AT(113,87,25,25),USE(?Insert:3),ICON('Insertar.ico'),FLAT,MSG('Inserta un Registro'), |
  TIP('Inserta un Registro')
                           BUTTON,AT(142,87,25,25),USE(?Change:3),ICON('Editar.ico'),FLAT,MSG('Modifica el registro'), |
  TIP('Modifica el registro')
                           BUTTON,AT(171,87,25,25),USE(?Delete:3),ICON('Eliminar.ICO'),FLAT,MSG('Elimina un registro'), |
  TIP('Elimina un registro')
                         END
                       END
                       BUTTON,AT(117,120,25,25),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Acepta los dato' & |
  's y cierra ventana'),TIP('Acepta los datos y cierra ventana')
                       BUTTON,AT(146,120,25,25),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancela operación'),TIP('Cancela operación')
                       BUTTON,AT(175,120,25,25),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Mostrar ventana de ayuda'), |
  STD(STD:Help),TIP('Mostrar ventana de ayuda')
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW2                 CLASS(BrowseClass)                    ! Browse using ?Browse:2
Q                      &Queue:Browse:2                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Adding a viajes_anticipos Record'
  OF ChangeRecord
    ActionMessage = 'Changing a viajes_anticipos Record'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateViajesAnticipos')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?sol:id_solicitud:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('via:id_viaje',via:id_viaje)                        ! Added by: BrowseBox(ABC)
  BIND('via:id_procedencia',via:id_procedencia)            ! Added by: BrowseBox(ABC)
  BIND('via:id_transportista',via:id_transportista)        ! Added by: BrowseBox(ABC)
  BIND('via:guia_transporte',via:guia_transporte)          ! Added by: BrowseBox(ABC)
  BIND('via:id_programacion',via:id_programacion)          ! Added by: BrowseBox(ABC)
  BIND('via:nro_remito',via:nro_remito)                    ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(sol:Record,History::sol:Record)
  SELF.AddHistoryField(?sol:id_solicitud,1)
  SELF.AddHistoryField(?sol:fecha_emision_DATE,4)
  SELF.AddHistoryField(?sol:fecha_emision_TIME,5)
  SELF.AddHistoryField(?sol:importe,6)
  SELF.AddHistoryField(?sol:producto,7)
  SELF.AddUpdateFile(Access:viajes_anticipos)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Viajes.SetOpenRelated()
  Relate:Viajes.Open                                       ! File Viajes used by this procedure, so make sure it's RelationManager is open
  Relate:viajes_anticipos.Open                             ! File viajes_anticipos used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:viajes_anticipos
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel+Cancel:Query         ! Confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  BRW2.Init(?Browse:2,Queue:Browse:2.ViewPosition,BRW2::View:Browse,Queue:Browse:2,Relate:Viajes,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?sol:id_solicitud{PROP:ReadOnly} = True
    ?sol:fecha_emision_DATE{PROP:ReadOnly} = True
    ?sol:fecha_emision_TIME{PROP:ReadOnly} = True
    ?sol:importe{PROP:ReadOnly} = True
    ?sol:producto{PROP:ReadOnly} = True
    DISABLE(?Insert:3)
    DISABLE(?Change:3)
    DISABLE(?Delete:3)
  END
  BRW2.Q &= Queue:Browse:2
  BRW2.RetainRow = 0
  BRW2.AddSortOrder(,via:FK_SOLICITUD)                     ! Add the sort order for via:FK_SOLICITUD for sort order 1
  BRW2.AddRange(via:id_solicitud,Relate:Viajes,Relate:viajes_anticipos) ! Add file relationship range limit for sort order 1
  BRW2.AddField(via:id_viaje,BRW2.Q.via:id_viaje)          ! Field via:id_viaje is a hot field or requires assignment from browse
  BRW2.AddField(via:id_procedencia,BRW2.Q.via:id_procedencia) ! Field via:id_procedencia is a hot field or requires assignment from browse
  BRW2.AddField(via:id_transportista,BRW2.Q.via:id_transportista) ! Field via:id_transportista is a hot field or requires assignment from browse
  BRW2.AddField(via:guia_transporte,BRW2.Q.via:guia_transporte) ! Field via:guia_transporte is a hot field or requires assignment from browse
  BRW2.AddField(via:id_proveedor,BRW2.Q.via:id_proveedor)  ! Field via:id_proveedor is a hot field or requires assignment from browse
  BRW2.AddField(via:id_programacion,BRW2.Q.via:id_programacion) ! Field via:id_programacion is a hot field or requires assignment from browse
  BRW2.AddField(via:nro_remito,BRW2.Q.via:nro_remito)      ! Field via:nro_remito is a hot field or requires assignment from browse
  BRW2.AddField(via:peso,BRW2.Q.via:peso)                  ! Field via:peso is a hot field or requires assignment from browse
  BRW2.AddField(via:fecha_carga_DATE,BRW2.Q.via:fecha_carga_DATE) ! Field via:fecha_carga_DATE is a hot field or requires assignment from browse
  BRW2.AddField(via:id_solicitud,BRW2.Q.via:id_solicitud)  ! Field via:id_solicitud is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateViajesAnticipos',QuickWindow)        ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW2.AskProcedure = 1
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Viajes.Close
    Relate:viajes_anticipos.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateViajesAnticipos',QuickWindow)     ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    UpdateViajes
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW2.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
SelectExistencias PROCEDURE 

CurrentTab           STRING(80)                            !
l:buscador           CSTRING(100)                          !
BRW1::View:Browse    VIEW(ExistenciasAlias1)
                       PROJECT(exi1:FECHA_LECTURA_DATE)
                       PROJECT(exi1:id_existencia)
                       PROJECT(exi1:id_planta)
                       PROJECT(exi1:id_localidad)
                       PROJECT(exi1:existencia)
                       PROJECT(exi1:existencia_anterior)
                       PROJECT(exi1:porc_existencia)
                       PROJECT(exi1:consumo)
                       PROJECT(exi1:utilizada)
                       PROJECT(exi1:capacidad_planta)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
exi1:FECHA_LECTURA_DATE LIKE(exi1:FECHA_LECTURA_DATE) !List box control field - type derived from field
exi1:id_existencia     LIKE(exi1:id_existencia)       !List box control field - type derived from field
exi1:id_planta         LIKE(exi1:id_planta)           !List box control field - type derived from field
exi1:id_localidad      LIKE(exi1:id_localidad)        !List box control field - type derived from field
exi1:existencia        LIKE(exi1:existencia)          !List box control field - type derived from field
exi1:existencia_anterior LIKE(exi1:existencia_anterior) !List box control field - type derived from field
exi1:porc_existencia   LIKE(exi1:porc_existencia)     !List box control field - type derived from field
exi1:consumo           LIKE(exi1:consumo)             !List box control field - type derived from field
exi1:utilizada         LIKE(exi1:utilizada)           !List box control field - type derived from field
exi1:capacidad_planta  LIKE(exi1:capacidad_planta)    !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,427,298),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('SelectExistencias'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(15,71,393,159),USE(?Browse:1),HVSCROLL,FORMAT('80R(2)|M~Fecha Lectura~C(0)@d6@0' & |
  'L(2)|M~Id existencia~@P<<<<<<<<<<P@0L(2)|M~Id Planta~@P<<<<P@0R(2)|M~Localidad~C(0)@' & |
  'N-14_@48D(10)|M~Existencia~C(0)@N20_~ kg~@68D(12)|M~existencia anterior~C(0)@N20_~ k' & |
  'g~@46D(12)|M~porc existencia~C(0)@N-7_~%~@48D(10)|M~Existencia~C(0)@N20_~ kg~@0D(22)' & |
  '|M~utilizada~C(0)@n3@40D(22)|M~Cap. Planta~C(0)@N20_~ kg~@'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he ExistenciasAlias1 file')
                       BUTTON,AT(35,242,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(355,242,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       STRING('Selecciones una existencia'),AT(158,16),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       BUTTON,AT(255,44,16,14),USE(?Browse:Top),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page')
                       BUTTON,AT(271,44,16,14),USE(?Browse:PageUp),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the Prior Page')
                       BUTTON,AT(288,44,16,14),USE(?Browse:Up),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record')
                       BUTTON,AT(305,44,16,14),USE(?Browse:Down),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record')
                       BUTTON,AT(321,44,16,14),USE(?Browse:PageDown),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page')
                       BUTTON,AT(338,44,16,14),USE(?Browse:Bottom),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page')
                       BOX,AT(11,235,400,39),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       PROMPT('Buscador:'),AT(90,47),USE(?l:buscador:Prompt)
                       ENTRY(@s99),AT(128,47,123,10),USE(l:buscador)
                       BOX,AT(11,36,400,31),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       PROMPT('Existencia:'),AT(133,250),USE(?l:buscador:Prompt:2),FONT(,,,FONT:regular)
                       STRING(@N-20_),AT(177,250,75,10),USE(exi1:existencia),FONT(,,,FONT:regular)
                     END

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
BRW1::Toolbar        BrowseToolbarClass
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
SetAlerts              PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('SelectExistencias')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('exi1:id_localidad',exi1:id_localidad)              ! Added by: BrowseToolbarControl(ABC)
  BIND('glo:localidad_id',glo:localidad_id)                ! Added by: BrowseBox(ABC)
  BIND('exi1:id_planta',exi1:id_planta)                    ! Added by: BrowseToolbarControl(ABC)
  BIND('GLO:id_planta',GLO:id_planta)                      ! Added by: BrowseBox(ABC)
  BIND('exi1:id_existencia',exi1:id_existencia)            ! Added by: BrowseBox(ABC)
  BIND('exi1:existencia_anterior',exi1:existencia_anterior) ! Added by: BrowseBox(ABC)
  BIND('exi1:porc_existencia',exi1:porc_existencia)        ! Added by: BrowseBox(ABC)
  BIND('exi1:capacidad_planta',exi1:capacidad_planta)      ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  BRW1::Toolbar.Init(SELF,BRW1)
  BRW1::Toolbar.InitBrowse(0, 0, 0, 0)
  BRW1::Toolbar.InitVCR(?Browse:Top, ?Browse:Bottom, ?Browse:PageUp, ?Browse:PageDown, ?Browse:Up, ?Browse:Down, 0)
  BRW1::Toolbar.InitMisc(0, 0)
  SELF.AddItem(BRW1::Toolbar.WindowComponent)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:ExistenciasAlias1.Open                            ! File ExistenciasAlias1 used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:ExistenciasAlias1,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,exi1:PK__EXISTENC__36B12243)          ! Add the sort order for exi1:PK__EXISTENC__36B12243 for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,exi1:id_existencia,1,BRW1)     ! Initialize the browse locator using  using key: exi1:PK__EXISTENC__36B12243 , exi1:id_existencia
  BRW1.SetFilter('((exi1:id_localidad = glo:localidad_id) and (exi1:id_planta =GLO:id_planta) and (exi1:utilizada = 0))') ! Apply filter expression to browse
  BRW1.AddField(exi1:FECHA_LECTURA_DATE,BRW1.Q.exi1:FECHA_LECTURA_DATE) ! Field exi1:FECHA_LECTURA_DATE is a hot field or requires assignment from browse
  BRW1.AddField(exi1:id_existencia,BRW1.Q.exi1:id_existencia) ! Field exi1:id_existencia is a hot field or requires assignment from browse
  BRW1.AddField(exi1:id_planta,BRW1.Q.exi1:id_planta)      ! Field exi1:id_planta is a hot field or requires assignment from browse
  BRW1.AddField(exi1:id_localidad,BRW1.Q.exi1:id_localidad) ! Field exi1:id_localidad is a hot field or requires assignment from browse
  BRW1.AddField(exi1:existencia,BRW1.Q.exi1:existencia)    ! Field exi1:existencia is a hot field or requires assignment from browse
  BRW1.AddField(exi1:existencia_anterior,BRW1.Q.exi1:existencia_anterior) ! Field exi1:existencia_anterior is a hot field or requires assignment from browse
  BRW1.AddField(exi1:porc_existencia,BRW1.Q.exi1:porc_existencia) ! Field exi1:porc_existencia is a hot field or requires assignment from browse
  BRW1.AddField(exi1:consumo,BRW1.Q.exi1:consumo)          ! Field exi1:consumo is a hot field or requires assignment from browse
  BRW1.AddField(exi1:utilizada,BRW1.Q.exi1:utilizada)      ! Field exi1:utilizada is a hot field or requires assignment from browse
  BRW1.AddField(exi1:capacidad_planta,BRW1.Q.exi1:capacidad_planta) ! Field exi1:capacidad_planta is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectExistencias',QuickWindow)            ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,exi1:PK__EXISTENC__36B12243)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ExistenciasAlias1.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('SelectExistencias',QuickWindow)         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.SetAlerts PROCEDURE

  CODE
  PARENT.SetAlerts
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.SetAlerts()


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  !Take Sort Headers Events
  IF BRW1::SortHeader.TakeEvents()
     RETURN Level:Notify
  END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select:2
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)


BRW1.SetSort PROCEDURE(BYTE NewOrder,BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.SetSort(NewOrder,Force)
  IF BRW1::LastSortOrder<>NewOrder THEN
     BRW1::SortHeader.ClearSort()
  END
  BRW1::LastSortOrder=NewOrder
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

BRW1::SortHeader.QueueResorted       PROCEDURE(STRING pString)
  CODE
    IF pString = ''
       BRW1.RestoreSort()
       BRW1.ResetSort(True)
    ELSE
       BRW1.ReplaceSort(pString,BRW1::Sort0:Locator)
       BRW1.SetLocatorFromSort()
    END
