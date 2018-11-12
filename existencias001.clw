

   MEMBER('existencias.clw')                               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('BRWEXT.INC'),ONCE
   INCLUDE('winext.inc'),ONCE

                     MAP
                       INCLUDE('EXISTENCIAS001.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('EXISTENCIAS002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS004.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS005.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS006.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS007.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS008.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS009.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS010.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS011.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Frame
!!! Wizard Application for C:\Documents and Settings\Jorge Climis\Mis documentos\Clarion Projects\Existencias\DCT_existencias.dct
!!! </summary>
Main PROCEDURE 

SQLOpenWindow        WINDOW('Inicializando la Base de Datos'),AT(,,208,26),FONT('Microsoft Sans Serif',8,,FONT:regular),CENTER,GRAY,DOUBLE
                       STRING('Este proceso puede tardar varios minutos.'),AT(27,12)
                       IMAGE(Icon:Connect),AT(4,4,23,17)
                       STRING('Por favor espere mientras el sistema se conecta con la BD'),AT(27,3)
                        END





MenuWindow  WINDOW,AT(,,397,285),GRAY,WALLPAPER('fondo.jpg')
         
         
        END
AppFrame             APPLICATION('Sistema de logística de Gas Licuado'),AT(,,453,350),FONT('Microsoft Sans Serif', |
  8,COLOR:Black,FONT:bold,CHARSET:DEFAULT),DOUBLE,CENTER,ICON('Distrigas.ico'),WALLPAPER('planta.JPG'),IMM
                       MENUBAR,USE(?Menubar)
                         MENU('&Archivo'),USE(?FileMenu)
                           ITEM('&Configuración de Impresión'),USE(?PrintSetup),MSG('Configuración de impresión'),STD(STD:PrintSetup)
                           ITEM,USE(?SEPARATOR1),SEPARATOR
                           ITEM('&Salir'),USE(?Exit),MSG('Salir de la aplicación'),STD(STD:Close)
                         END
                         MENU('&Editar'),USE(?EditMenu)
                           ITEM('Co$rtar'),USE(?Cut),MSG('Corta la selección al portapapeles'),STD(STD:Cut)
                           ITEM('&Copiar'),USE(?Copy),MSG('Copia la selección al portapapeles'),STD(STD:Copy)
                           ITEM('&Pegar'),USE(?Paste),MSG('Pega del portapapeles'),STD(STD:Paste)
                         END
                         MENU('&Conversiones'),USE(?TablaConversiones)
                           ITEM('Tabla de volumenes'),USE(?TablaVolumenes)
                           ITEM('Factor de correccion de liquido'),USE(?TablaLiquido)
                           ITEM('Factor de corrección de presiones'),USE(?TablaPresion)
                           ITEM('&Parámetros'),USE(?TablaParametros)
                           ITEM('Costos GLP'),USE(?costoGLP)
                         END
                         MENU('&Gestión de Viajes'),USE(?ViajesMenu)
                           ITEM('Browse Cupos de Producto'),USE(?BrowseProgramacion),MSG('Browse Programación')
                           ITEM('Browse Programación de viajes'),USE(?BrowseProgramacionViajes)
                           ITEM('Browse Conceptos de Anticipos'),USE(?BrowseConceptosAnticipos)
                           ITEM('Browse Despachantes'),USE(?BrowseDespachantes)
                           ITEM('Solicitud de Anticipos'),USE(?SolicitudAnticipo)
                           ITEM('Browse Anticipos generados'),USE(?BrowseAnticiposGenerados)
                           ITEM('Browse Balance de producto'),USE(?BrowseBalanceProducto)
                           ITEM('Browse Totales de existencias'),USE(?TotalesExistencias)
                           ITEM('Despacho Aduanero'),USE(?DespachoAduanero)
                           ITEM('Conciliación de Remitos'),USE(?ConciliacionRemitos)
                         END
                         MENU('&Listados'),USE(?Listados)
                           ITEM('Browse Existencias de GLP'),USE(?BrowseExistenciasTotales)
                           ITEM('Browse viajes en proceso '),USE(?BrowseViajesProceso)
                           ITEM('Browse Viajes de GLP'),USE(?BrowseViajes),MSG('Browse Viajes de GLP')
                           ITEM('Browse Decargas de GLP'),USE(?BrowseDescargas),MSG('Browse Decargas de GLP')
                         END
                         MENU('&Operativos'),USE(?DatosOperativos)
                           ITEM('Ingreso de Existencias'),USE(?IngresoExistencias)
                           ITEM('Transferencia de producto'),USE(?TransferenciaProducto)
                           ITEM('Mediciones de tanques'),USE(?Mediciones)
                         END
                         MENU('&Browse'),USE(?BrowseMenu)
                           ITEM('Seleccionar localidad'),USE(?SelectLocalidadGlobal)
                           ITEM('Browse Proveedores de GLP'),USE(?BrowseProveedores),MSG('Browse Proveedores de GLP')
                           ITEM('Browse Transportes de GLP'),USE(?BrowseTransportistas),MSG('Browse Transportes de GLP')
                           ITEM('Browse Plantas de GLP'),USE(?BrowsePlantas),MSG('Browse Plantas de GLP')
                           ITEM('Browse Tanques de Planta'),USE(?BrowseTanquesPlantas)
                           ITEM('Browse Factores de corrección de densidad'),USE(?BrowseDensidades_Corregidas),MSG('Browse Fac' & |
  'tores de corrección de densidad')
                           ITEM('Browse Volumenes calculados de tanques'),USE(?BrowseNiveles_Volumenes),MSG('Browse Vol' & |
  'umenes calculados de tanques')
                           ITEM('Browse Tipos de Tanques'),USE(?Browset_tanques),MSG('Browse Tipos de Tanques')
                           ITEM('Browse Mediciones de Tanques'),USE(?BrowseMediciones),MSG('Browse Mediciones de Tanques')
                           ITEM('Browse Factores de corrección de presión'),USE(?BrowsePresiones_corregidas),MSG('Browse Fac' & |
  'tores de corrección de presión')
                           ITEM('Browse the Localidades_GLP file'),USE(?BrowseLocalidades_GLP),MSG('Browse Localidades_GLP')
                           ITEM('Browse Procedencias'),USE(?BrowseProcedencias)
                           ITEM('Browse Contactos'),USE(?BrowseContactos)
                         END
                         MENU('&Ventana'),USE(?WindowMenu),STD(STD:WindowList)
                           ITEM('&Mosaico'),USE(?Tile),MSG('Organizar múltiples ventanas abiertas'),STD(STD:TileWindow)
                           ITEM('&Cascada'),USE(?Cascade),MSG('Organizar múltiples ventanas abiertas'),STD(STD:CascadeWindow)
                           ITEM('&Organizar iconos'),USE(?Arrange),MSG('Organiza los iconos de las ventanas minimizadas'), |
  STD(STD:ArrangeIcons)
                         END
                         MENU('A&yuda'),USE(?HelpMenu)
                           ITEM('&Contenidos'),USE(?Helpindex),MSG('Ver el contenido del archivo de ayuda'),STD(STD:HelpIndex)
                           ITEM('&Buscar ayuda sobre...'),USE(?HelpSearch),MSG('Buscar ayuda sobre un tema'),STD(STD:HelpSearch)
                           ITEM('&Como usar el ayuda'),USE(?HelpOnHelp),MSG('Proporciona instrucciones generales s' & |
  'obre el uso de la ayuda'),STD(STD:HelpOnHelp)
                           ITEM('&Acerca de'),USE(?AcercaDe)
                         END
                       END
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
FrameExtension       CLASS(WindowExtenderClass)
TrayIconMouseLeft2     PROCEDURE(),DERIVED
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
Menu::Menubar ROUTINE                                      ! Code for menu items on ?Menubar
Menu::FileMenu ROUTINE                                     ! Code for menu items on ?FileMenu
Menu::EditMenu ROUTINE                                     ! Code for menu items on ?EditMenu
Menu::TablaConversiones ROUTINE                            ! Code for menu items on ?TablaConversiones
  CASE ACCEPTED()
  OF ?TablaVolumenes
    START(BrowseNiveles_Volumenes, 50000)
  OF ?TablaLiquido
    START(BrowseDensidades_Corregidas, 50000)
  OF ?TablaPresion
    START(BrowsePresiones_corregidas, 50000)
  OF ?TablaParametros
    START(BrowseParametros, 50000)
  OF ?costoGLP
    START(BrowsecostosGLP, 25000)
  END
Menu::ViajesMenu ROUTINE                                   ! Code for menu items on ?ViajesMenu
  CASE ACCEPTED()
  OF ?BrowseProgramacion
    START(BrowseProgramacion, 50000)
  OF ?BrowseProgramacionViajes
    START(BrowseProgramarViajes, 50000)
  OF ?BrowseConceptosAnticipos
    START(BrowseConceptosAduana, 50000)
  OF ?BrowseDespachantes
    START(BrowseDespachantes, 50000)
  OF ?SolicitudAnticipo
    START(BrowseGeneracionSolicitudAnticipo, 50000)
  OF ?BrowseAnticiposGenerados
    START(BrowseAnticiposGenerados, 50000)
  OF ?BrowseBalanceProducto
    START(BrowseBalanceProducto, 50000)
  OF ?TotalesExistencias
    START(totalesProductoLocalidad, 50000)
  OF ?DespachoAduanero
    START(BrowseDespachoAduanero, 50000)
  OF ?ConciliacionRemitos
    START(ConciliacionRemitos, 50000)
  END
Menu::Listados ROUTINE                                     ! Code for menu items on ?Listados
  CASE ACCEPTED()
  OF ?BrowseExistenciasTotales
    START(BrowseExistencias, 50000)
  OF ?BrowseViajesProceso
    START(BrowseViajesenProceso, 50000)
  OF ?BrowseViajes
    START(BrowseViajes, 050000)
  OF ?BrowseDescargas
    START(BrowseDescargas, 050000)
  END
Menu::DatosOperativos ROUTINE                              ! Code for menu items on ?DatosOperativos
  CASE ACCEPTED()
  OF ?IngresoExistencias
    START(UpdateExistencias, 25000)
  OF ?TransferenciaProducto
    START(TransferirProducto, 25000)
  OF ?Mediciones
    START(BrowseMediciones, 25000)
  END
Menu::BrowseMenu ROUTINE                                   ! Code for menu items on ?BrowseMenu
  CASE ACCEPTED()
  OF ?SelectLocalidadGlobal
    START(SelectLocalidadGlobal, 50000)
  OF ?BrowseProveedores
    START(BrowseProveedores, 050000)
  OF ?BrowseTransportistas
    START(BrowseTransportistas, 050000)
  OF ?BrowsePlantas
    START(BrowsePlantas, 050000)
  OF ?BrowseTanquesPlantas
    START(BrowseTanques_plantas, 50000)
  OF ?BrowseDensidades_Corregidas
    START(BrowseDensidades_Corregidas, 050000)
  OF ?BrowseNiveles_Volumenes
    START(BrowseNiveles_Volumenes, 050000)
  OF ?Browset_tanques
    START(Browset_tanques, 050000)
  OF ?BrowseMediciones
    START(BrowseMediciones, 050000)
  OF ?BrowsePresiones_corregidas
    START(BrowsePresiones_corregidas, 050000)
  OF ?BrowseLocalidades_GLP
    START(BrowseLocalidades_GLP, 050000)
  OF ?BrowseProcedencias
    START(BrowseProcedencias, 50000)
  OF ?BrowseContactos
    START(BrowseContactos, 50000)
  END
Menu::WindowMenu ROUTINE                                   ! Code for menu items on ?WindowMenu
Menu::HelpMenu ROUTINE                                     ! Code for menu items on ?HelpMenu
  CASE ACCEPTED()
  OF ?AcercaDe
    START(AcercaDe, 50000)
  END

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  
  SETCURSOR(Cursor:Wait)
  OPEN(SQLOpenWindow)
  ACCEPT
      IF EVENT() = Event:OpenWindow
  
  Relate:Proveedores.Open                                  ! File Proveedores used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
      POST(EVENT:CloseWindow)
    END
  END
  CLOSE(SQLOpenWindow)
  
  
  
  SETCURSOR()
  
  
  
      
  SELF.Open(AppFrame)                                      ! Open window
  Do DefineListboxStyle
  FrameExtension.Init(AppFrame,1,1,0{PROP:Icon},'')
  INIMgr.Fetch('Main',AppFrame)                            ! Restore window settings from non-volatile store
  SELF.SetAlerts()
      AppFrame{PROP:TabBarVisible}  = False
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Proveedores.Close
  END
  IF SELF.Opened
    INIMgr.Update('Main',AppFrame)                         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
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
    CASE ACCEPTED()
    ELSE
      DO Menu::Menubar                                     ! Process menu items on ?Menubar menu
      DO Menu::FileMenu                                    ! Process menu items on ?FileMenu menu
      DO Menu::EditMenu                                    ! Process menu items on ?EditMenu menu
      DO Menu::TablaConversiones                           ! Process menu items on ?TablaConversiones menu
      DO Menu::ViajesMenu                                  ! Process menu items on ?ViajesMenu menu
      DO Menu::Listados                                    ! Process menu items on ?Listados menu
      DO Menu::DatosOperativos                             ! Process menu items on ?DatosOperativos menu
      DO Menu::BrowseMenu                                  ! Process menu items on ?BrowseMenu menu
      DO Menu::WindowMenu                                  ! Process menu items on ?WindowMenu menu
      DO Menu::HelpMenu                                    ! Process menu items on ?HelpMenu menu
    END
  ReturnValue = PARENT.TakeAccepted()
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
    IF EVENT()
       FrameExtension.TakeEvent()
    END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


FrameExtension.TrayIconMouseLeft2 PROCEDURE


  CODE
  PARENT.TrayIconMouseLeft2
  POST(EVENT:Maximize)

!!! <summary>
!!! Generated from procedure template - Window
!!! Proveedores
!!! </summary>
BrowseProveedores PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Proveedores)
                       PROJECT(pro:id_proveedor)
                       PROJECT(pro:proveedor)
                       PROJECT(pro:importe_DNL)
                       PROJECT(pro:direccion)
                       PROJECT(pro:provincia)
                       PROJECT(pro:ciudad)
                       PROJECT(pro:telefono)
                       PROJECT(pro:contacto)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
pro:id_proveedor       LIKE(pro:id_proveedor)         !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
pro:importe_DNL        LIKE(pro:importe_DNL)          !List box control field - type derived from field
pro:direccion          LIKE(pro:direccion)            !List box control field - type derived from field
pro:provincia          LIKE(pro:provincia)            !List box control field - type derived from field
pro:ciudad             LIKE(pro:ciudad)               !List box control field - type derived from field
pro:telefono           LIKE(pro:telefono)             !List box control field - type derived from field
pro:contacto           LIKE(pro:contacto)             !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseProveedores'),SYSTEM,WALLPAPER('fondo.jpg')
                       STRING('Proveedores'),AT(238,18),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline), |
  TRN
                       BUTTON,AT(441,290,33,27),USE(?Cancel),ICON('cancelar.ico'),FLAT,TRN
                       LIST,AT(19,53,470,182),USE(?List),RIGHT(1),FORMAT('40L(2)|M~ID Proveedor~L(1)@P<<<<<<<<' & |
  '<<P@200L(2)|M~Proveedor~L(0)@s50@76L(2)|M~Importe DNL~L(0)@N~$ ~-17_.2@200L(2)|M~dir' & |
  'eccion~L(0)@s50@200L(2)|M~provincia~L(0)@s50@200L(2)|M~ciudad~L(0)@s50@200L(2)|M~tel' & |
  'efono~L(0)@s50@200L(2)|M~contacto~L(0)@s50@'),FROM(Queue:Browse),IMM,MSG('Identifica' & |
  'dor interno del proveedor de producto'),TIP('Identificador interno del proveedor de producto')
                       BUTTON,AT(197,257,33,27),USE(?Insert),ICON('insertar.ico'),FLAT,TRN
                       BUTTON,AT(238,257,33,27),USE(?Change),ICON('editar.ico'),FLAT,TRN
                       BUTTON,AT(281,257,33,27),USE(?Delete),ICON('eliminar.ico'),FLAT,TRN
                       BUTTON,AT(80,257,33,27),USE(?View),ICON('ver.ico'),FLAT,TRN
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
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
  GlobalErrors.SetProcedureName('BrowseProveedores')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?STRING1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Proveedores.Open                                  ! File Proveedores used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:Proveedores,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW1.Q &= Queue:Browse
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AddField(pro:id_proveedor,BRW1.Q.pro:id_proveedor)  ! Field pro:id_proveedor is a hot field or requires assignment from browse
  BRW1.AddField(pro:proveedor,BRW1.Q.pro:proveedor)        ! Field pro:proveedor is a hot field or requires assignment from browse
  BRW1.AddField(pro:importe_DNL,BRW1.Q.pro:importe_DNL)    ! Field pro:importe_DNL is a hot field or requires assignment from browse
  BRW1.AddField(pro:direccion,BRW1.Q.pro:direccion)        ! Field pro:direccion is a hot field or requires assignment from browse
  BRW1.AddField(pro:provincia,BRW1.Q.pro:provincia)        ! Field pro:provincia is a hot field or requires assignment from browse
  BRW1.AddField(pro:ciudad,BRW1.Q.pro:ciudad)              ! Field pro:ciudad is a hot field or requires assignment from browse
  BRW1.AddField(pro:telefono,BRW1.Q.pro:telefono)          ! Field pro:telefono is a hot field or requires assignment from browse
  BRW1.AddField(pro:contacto,BRW1.Q.pro:contacto)          ! Field pro:contacto is a hot field or requires assignment from browse
  INIMgr.Fetch('BrowseProveedores',QuickWindow)            ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Proveedores.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseProveedores',QuickWindow)         ! Save window data to non-volatile store
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
    UpdateProveedores
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END
  SELF.ViewControl = ?View                                 ! Setup the control used to initiate view only mode

!!! <summary>
!!! Generated from procedure template - Window
!!! Transportistas
!!! </summary>
BrowseTransportistas PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Transportistas)
                       PROJECT(tra:id_transportista)
                       PROJECT(tra:transportista)
                       PROJECT(tra:direccion)
                       PROJECT(tra:ciudad)
                       PROJECT(tra:provincia)
                       PROJECT(tra:telefono)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
tra:id_transportista   LIKE(tra:id_transportista)     !List box control field - type derived from field
tra:transportista      LIKE(tra:transportista)        !List box control field - type derived from field
tra:direccion          LIKE(tra:direccion)            !List box control field - type derived from field
tra:ciudad             LIKE(tra:ciudad)               !List box control field - type derived from field
tra:provincia          LIKE(tra:provincia)            !List box control field - type derived from field
tra:telefono           LIKE(tra:telefono)             !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseTransportistas'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(42,71,443,144),USE(?Browse:1),HVSCROLL,FORMAT('16L(2)|M~ID~@P<<<<P@80L(2)|M~Tra' & |
  'nsportista~@s50@84L(2)|M~Dirección~L(0)@s50@95L(2)|M~Ciudad~L(0)@s50@102L(2)|M~Provi' & |
  'ncia~L(0)@s50@200L(2)|M~Teléfono~L(0)@s50@'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he Transportistas file')
                       BUTTON,AT(194,298,25,25),USE(?View:2),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'),TIP('Vizualizar' & |
  ' el registro')
                       BUTTON,AT(231,298,25,25),USE(?Insert:3),ICON('Insertar.ico'),FLAT,MSG('Insertar un registro'), |
  TIP('Insertar un registro')
                       BUTTON,AT(270,298,25,25),USE(?Change:3),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro')
                       BUTTON,AT(307,298,25,25),USE(?Delete:3),ICON('Eliminar.ICO'),FLAT,MSG('Eliminar el registro'), |
  TIP('Eliminar el registro')
                       BUTTON,AT(447,298,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON,AT(484,298,25,25),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'),STD(STD:Help), |
  TIP('Ver ventana de ayuda')
                       STRING('Transportistas'),AT(218,20),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline), |
  TRN
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
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
  GlobalErrors.SetProcedureName('BrowseTransportistas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
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
  Relate:Transportistas.Open                               ! File Transportistas used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Transportistas,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,tra:PK_TRANSPORTISTA)                 ! Add the sort order for tra:PK_TRANSPORTISTA for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,tra:id_transportista,1,BRW1)   ! Initialize the browse locator using  using key: tra:PK_TRANSPORTISTA , tra:id_transportista
  BRW1.AddField(tra:id_transportista,BRW1.Q.tra:id_transportista) ! Field tra:id_transportista is a hot field or requires assignment from browse
  BRW1.AddField(tra:transportista,BRW1.Q.tra:transportista) ! Field tra:transportista is a hot field or requires assignment from browse
  BRW1.AddField(tra:direccion,BRW1.Q.tra:direccion)        ! Field tra:direccion is a hot field or requires assignment from browse
  BRW1.AddField(tra:ciudad,BRW1.Q.tra:ciudad)              ! Field tra:ciudad is a hot field or requires assignment from browse
  BRW1.AddField(tra:provincia,BRW1.Q.tra:provincia)        ! Field tra:provincia is a hot field or requires assignment from browse
  BRW1.AddField(tra:telefono,BRW1.Q.tra:telefono)          ! Field tra:telefono is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseTransportistas',QuickWindow)         ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Transportistas.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseTransportistas',QuickWindow)      ! Save window data to non-volatile store
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
    UpdateTransportistas
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END
  SELF.ViewControl = ?View:2                               ! Setup the control used to initiate view only mode


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! Plantas
!!! </summary>
BrowsePlantas PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Plantas)
                       PROJECT(pla:ID_PLANTA)
                       PROJECT(pla:NRO_PLANTA)
                       PROJECT(pla:CAPACIDAD)
                       PROJECT(pla:CANT_TANQUES)
                       PROJECT(pla:FECHA_AUDITORIA_DATE)
                       PROJECT(pla:ID_LOCALIDAD)
                       JOIN(Loc:PK_localidad,pla:ID_LOCALIDAD)
                         PROJECT(Loc:Localidad)
                         PROJECT(Loc:id_localidad)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
pla:ID_PLANTA          LIKE(pla:ID_PLANTA)            !List box control field - type derived from field
Loc:Localidad          LIKE(Loc:Localidad)            !List box control field - type derived from field
pla:NRO_PLANTA         LIKE(pla:NRO_PLANTA)           !List box control field - type derived from field
pla:CAPACIDAD          LIKE(pla:CAPACIDAD)            !List box control field - type derived from field
pla:CANT_TANQUES       LIKE(pla:CANT_TANQUES)         !List box control field - type derived from field
pla:FECHA_AUDITORIA_DATE LIKE(pla:FECHA_AUDITORIA_DATE) !List box control field - type derived from field
Loc:id_localidad       LIKE(Loc:id_localidad)         !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW7::View:Browse    VIEW(Tanques_plantas)
                       PROJECT(tan:nro_tanque)
                       PROJECT(tan:cap_m3)
                       PROJECT(tan:id_tanque)
                       PROJECT(tan:id_planta)
                       PROJECT(tan:idt_tanques)
                       JOIN(t_t:PK_t_tanques,tan:idt_tanques)
                         PROJECT(t_t:modelo)
                         PROJECT(t_t:idt_tanque)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
tan:nro_tanque         LIKE(tan:nro_tanque)           !List box control field - type derived from field
tan:cap_m3             LIKE(tan:cap_m3)               !List box control field - type derived from field
t_t:modelo             LIKE(t_t:modelo)               !List box control field - type derived from field
tan:id_tanque          LIKE(tan:id_tanque)            !Primary key field - type derived from field
tan:id_planta          LIKE(tan:id_planta)            !Browse key field - type derived from field
t_t:idt_tanque         LIKE(t_t:idt_tanque)           !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowsePlantas'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(121,43,285,104),USE(?Browse:1),HVSCROLL,FORMAT('0L(2)|M~Id Planta~@P<<P@80C(2)|' & |
  'M~Localidad~C(0)@s20@44C(2)|M~Nro planta~L(2)@P<<<<P@59C|M~Cap. Kg~@N20_@36C(2)|M~Ta' & |
  'nques~C(0)@P<<<<P@53C(2)|M~Fecha auditoría~L(0)@d6@'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he Plantas file')
                       BUTTON,AT(177,294,31,30),USE(?View:2),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'),TIP('Vizualizar' & |
  ' el registro'),TRN
                       BUTTON,AT(217,294,31,30),USE(?Insert:3),ICON('Insertar.ico'),FLAT,MSG('Insertar un registro'), |
  TIP('Insertar un registro'),TRN
                       BUTTON,AT(253,294,31,30),USE(?Change:3),ICON('Editar.ico'),FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro'),TRN
                       BUTTON,AT(293,294,31,30),USE(?Delete:3),ICON('Eliminar.ICO'),FLAT,MSG('Eliminar el registro'), |
  TIP('Eliminar el registro'),TRN
                       BUTTON,AT(462,294,31,30),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana'), |
  TRN
                       STRING('Plantas de GLP'),AT(232,17,69),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       LIST,AT(137,159,253,126),USE(?List),VSCROLL,FORMAT('45D(2)|M~nro tanque~C(0)@N20_@42D(2' & |
  ')|M~Capacidad~C(0)@N20_@80L(2)|M~Modelo~C(0)@s20@'),FROM(Queue:Browse),IMM
                       BOX,AT(17,291,493,34),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                     END

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
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
BRW7                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
                     END

BRW7::Sort0:Locator  StepLocatorClass                      ! Default Locator
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
  GlobalErrors.SetProcedureName('BrowsePlantas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('pla:ID_PLANTA',pla:ID_PLANTA)                      ! Added by: BrowseBox(ABC)
  BIND('pla:NRO_PLANTA',pla:NRO_PLANTA)                    ! Added by: BrowseBox(ABC)
  BIND('pla:CANT_TANQUES',pla:CANT_TANQUES)                ! Added by: BrowseBox(ABC)
  BIND('tan:nro_tanque',tan:nro_tanque)                    ! Added by: BrowseBox(ABC)
  BIND('tan:id_tanque',tan:id_tanque)                      ! Added by: BrowseBox(ABC)
  BIND('tan:id_planta',tan:id_planta)                      ! Added by: BrowseBox(ABC)
  BIND('t_t:idt_tanque',t_t:idt_tanque)                    ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Localidades_GLP.SetOpenRelated()
  Relate:Localidades_GLP.Open                              ! File Localidades_GLP used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Plantas,SELF) ! Initialize the browse manager
  BRW7.Init(?List,Queue:Browse.ViewPosition,BRW7::View:Browse,Queue:Browse,Relate:Tanques_plantas,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,pla:PK__plantas__7D439ABD)            ! Add the sort order for pla:PK__plantas__7D439ABD for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,pla:ID_PLANTA,,BRW1)           ! Initialize the browse locator using  using key: pla:PK__plantas__7D439ABD , pla:ID_PLANTA
  BRW1.AddField(pla:ID_PLANTA,BRW1.Q.pla:ID_PLANTA)        ! Field pla:ID_PLANTA is a hot field or requires assignment from browse
  BRW1.AddField(Loc:Localidad,BRW1.Q.Loc:Localidad)        ! Field Loc:Localidad is a hot field or requires assignment from browse
  BRW1.AddField(pla:NRO_PLANTA,BRW1.Q.pla:NRO_PLANTA)      ! Field pla:NRO_PLANTA is a hot field or requires assignment from browse
  BRW1.AddField(pla:CAPACIDAD,BRW1.Q.pla:CAPACIDAD)        ! Field pla:CAPACIDAD is a hot field or requires assignment from browse
  BRW1.AddField(pla:CANT_TANQUES,BRW1.Q.pla:CANT_TANQUES)  ! Field pla:CANT_TANQUES is a hot field or requires assignment from browse
  BRW1.AddField(pla:FECHA_AUDITORIA_DATE,BRW1.Q.pla:FECHA_AUDITORIA_DATE) ! Field pla:FECHA_AUDITORIA_DATE is a hot field or requires assignment from browse
  BRW1.AddField(Loc:id_localidad,BRW1.Q.Loc:id_localidad)  ! Field Loc:id_localidad is a hot field or requires assignment from browse
  BRW7.Q &= Queue:Browse
  BRW7.RetainRow = 0
  BRW7.AddSortOrder(,tan:FK_PLANTA)                        ! Add the sort order for tan:FK_PLANTA for sort order 1
  BRW7.AddRange(tan:id_planta,pla:ID_PLANTA)               ! Add single value range limit for sort order 1
  BRW7.AddLocator(BRW7::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW7::Sort0:Locator.Init(,tan:id_tanque,1,BRW7)          ! Initialize the browse locator using  using key: tan:FK_PLANTA , tan:id_tanque
  BRW7.AddField(tan:nro_tanque,BRW7.Q.tan:nro_tanque)      ! Field tan:nro_tanque is a hot field or requires assignment from browse
  BRW7.AddField(tan:cap_m3,BRW7.Q.tan:cap_m3)              ! Field tan:cap_m3 is a hot field or requires assignment from browse
  BRW7.AddField(t_t:modelo,BRW7.Q.t_t:modelo)              ! Field t_t:modelo is a hot field or requires assignment from browse
  BRW7.AddField(tan:id_tanque,BRW7.Q.tan:id_tanque)        ! Field tan:id_tanque is a hot field or requires assignment from browse
  BRW7.AddField(tan:id_planta,BRW7.Q.tan:id_planta)        ! Field tan:id_planta is a hot field or requires assignment from browse
  BRW7.AddField(t_t:idt_tanque,BRW7.Q.t_t:idt_tanque)      ! Field t_t:idt_tanque is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowsePlantas',QuickWindow)                ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1
  BRW7.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,pla:PK__plantas__7D439ABD)
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
    INIMgr.Update('BrowsePlantas',QuickWindow)             ! Save window data to non-volatile store
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
    UpdatePlantas
    ReturnValue = GlobalResponse
  END
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
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END
  SELF.ViewControl = ?View:2                               ! Setup the control used to initiate view only mode


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
!!! Generated from procedure template - Window
!!! </summary>
BrowseDescargas PROCEDURE 

CurrentTab           STRING(80)                            !
l:filtro             CSTRING(250)                          !
l:fecha_desde        DATE                                  !
l:fecha_hasta        DATE                                  !
l:localidad          STRING(20)                            !
l:buscador           CSTRING(100)                          !
L:id_proveedor       LONG                                  !Identificador interno del proveedor de producto
BRW1::View:Browse    VIEW(Descargas)
                       PROJECT(des:id_descarga)
                       PROJECT(des:id_localidad)
                       PROJECT(des:id_viaje)
                       PROJECT(des:fecha_descarga_DATE)
                       PROJECT(des:id_planta)
                       PROJECT(des:cantidad)
                       JOIN(pla:PK__plantas__7D439ABD,des:id_planta)
                         PROJECT(pla:NRO_PLANTA)
                         PROJECT(pla:ID_PLANTA)
                       END
                       JOIN(Loc:PK_localidad,des:id_localidad)
                         PROJECT(Loc:Localidad)
                         PROJECT(Loc:id_localidad)
                       END
                       JOIN(via:PK_viajes,des:id_viaje)
                         PROJECT(via:id_proveedor)
                         PROJECT(via:nro_remito)
                         PROJECT(via:guia_transporte)
                         PROJECT(via:id_viaje)
                         JOIN(pro:PK_proveedor,via:id_proveedor)
                           PROJECT(pro:proveedor)
                           PROJECT(pro:id_proveedor)
                         END
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
des:id_descarga        LIKE(des:id_descarga)          !List box control field - type derived from field
via:id_proveedor       LIKE(via:id_proveedor)         !List box control field - type derived from field
des:id_localidad       LIKE(des:id_localidad)         !List box control field - type derived from field
des:id_viaje           LIKE(des:id_viaje)             !List box control field - type derived from field
Loc:Localidad          LIKE(Loc:Localidad)            !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
pla:NRO_PLANTA         LIKE(pla:NRO_PLANTA)           !List box control field - type derived from field
des:fecha_descarga_DATE LIKE(des:fecha_descarga_DATE) !List box control field - type derived from field
via:nro_remito         LIKE(via:nro_remito)           !List box control field - type derived from field
via:guia_transporte    LIKE(via:guia_transporte)      !List box control field - type derived from field
des:id_planta          LIKE(des:id_planta)            !List box control field - type derived from field
des:cantidad           LIKE(des:cantidad)             !List box control field - type derived from field
pla:ID_PLANTA          LIKE(pla:ID_PLANTA)            !Related join file key field - type derived from field
Loc:id_localidad       LIKE(Loc:id_localidad)         !Related join file key field - type derived from field
via:id_viaje           LIKE(via:id_viaje)             !Related join file key field - type derived from field
pro:id_proveedor       LIKE(pro:id_proveedor)         !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseDescargas'),SYSTEM,WALLPAPER('fondo.jpg')
                       ENTRY(@P<<<P),AT(164,42,18,10),USE(GLO:localidad_id),RIGHT(1),HIDE
                       BUTTON,AT(147,41,12,12),USE(?CallLookup),ICON('Lupita.ico'),FLAT,TRN
                       ENTRY(@d6),AT(225,41,49,10),USE(l:fecha_desde)
                       BUTTON,AT(279,35,25,25),USE(?BotonSeleccionFechaDesde),ICON('calen.ico'),FLAT,TRN
                       BUTTON,AT(445,44,25,25),USE(?BtnFiltrar),FONT(,,,FONT:regular),ICON('seleccionar.ICO'),FLAT, |
  MSG('Filtra los registros'),TIP('Filtra los registros'),TRN
                       LIST,AT(17,114,493,163),USE(?Browse:1),HVSCROLL,FORMAT('28D(2)|M~Id descarga~L(2)@N20_@' & |
  '0D(2)|M~ID Proveedor~L(1)@P<<<<<<<<<<P@0R(2)|M~id localidad~C(0)@n-14@32D(2)|M~Viaje' & |
  '~L(2)@N20_@80R(2)|M~Localidad~C(0)@s20@50R(2)|M~Proveedor~C(0)@s50@40R(2)|M~Nro plan' & |
  'ta~C(0)@P<<<<P@57R(2)|M~Fecha descarga~C(0)@d6@57R(2)|M~Nro Remito~C(0)@s50@50R(2)|M' & |
  '~Guia Transporte~C(0)@s50@0L(2)|M~Planta~@P<<<<P@64R(2)|M~Cantidad~C(0)@N-14.@'),FROM(Queue:Browse:1), |
  IMM,MSG('Registros de Descargas de GLP'),TIP('Registros de Descargas de GLP')
                       BUTTON,AT(34,290,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona la descarga'), |
  TIP('Selecciona la descarga'),TRN
                       BUTTON,AT(183,290,25,25),USE(?View:3),ICON('Ver.ico'),FLAT,MSG('Visualiza el registro'),TIP('Visualiza ' & |
  'el registro'),TRN
                       BUTTON,AT(231,290,25,25),USE(?Insert:4),ICON('Insertar.ico'),FLAT,MSG('Inserta una descarga'), |
  TIP('Inserta una descarga'),TRN
                       BUTTON,AT(275,290,25,25),USE(?Change:4),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Modifica l' & |
  'a descarga'),TIP('Modifica la descarga'),TRN
                       BUTTON,AT(318,290,25,25),USE(?Delete:4),ICON('Eliminar.ICO'),DISABLE,FLAT,HIDE,MSG('Elimina la descarga'), |
  TIP('Elimina la descarga'),TRN
                       BUTTON,AT(473,290,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana'), |
  TRN
                       BOX,AT(16,281,495,42),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       STRING('Descargas en planta'),AT(230,15,85,15),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       BOX,AT(16,32,495,46),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       PROMPT('Localidad:'),AT(25,44),USE(?GLO:localidad_id:Prompt),TRN
                       STRING(@s20),AT(61,44,82,10),USE(Loc:Localidad),FONT(,,,FONT:regular),TRN
                       PROMPT('Desde:'),AT(198,42),USE(?l:fecha:Prompt),TRN
                       BUTTON,AT(355,88,16,14),USE(?Browse:Top),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page')
                       BUTTON,AT(371,88,16,14),USE(?Browse:PageUp),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the Prior Page')
                       BUTTON,AT(387,88,16,14),USE(?Browse:Up),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record')
                       BUTTON,AT(403,88,16,14),USE(?Browse:Down),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record')
                       BUTTON,AT(419,88,16,14),USE(?Browse:PageDown),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page')
                       BUTTON,AT(435,88,16,14),USE(?Browse:Bottom),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page')
                       ENTRY(@s99),AT(153,89,197),USE(l:buscador)
                       PROMPT('Buscar:'),AT(123,93,,9),USE(?GLO:localidad_id:Prompt:2),TRN
                       BOX,AT(16,82,495,28),USE(?BOX1:3),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       PROMPT('Planta Nro:'),AT(25,61),USE(?GLO:localidad_id:Prompt:3),TRN
                       ENTRY(@P<<<<<P),AT(94,62,18,10),USE(GLO:id_planta),RIGHT(1),HIDE
                       BUTTON,AT(77,60,12,12),USE(?CallLookupPlanta),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@P<<P),AT(61,60,13,12),USE(pla:NRO_PLANTA),TRN
                       PROMPT('Hasta:'),AT(309,42),USE(?l:fecha:Prompt:2),TRN
                       ENTRY(@d6),AT(337,41,49,10),USE(l:fecha_hasta)
                       BUTTON('...'),AT(391,35,25,25),USE(?BotonSeleccionFechaHasta),ICON('calen.ico'),FLAT,TRN
                       BUTTON,AT(362,290,25,25),USE(?EvoExportarDescargas),LEFT,ICON('exportar.ico'),FLAT
                       PROMPT('Proveedor:'),AT(181,61),USE(?L:id_proveedor:Prompt),TRN
                       ENTRY(@P<<<<<P),AT(221,60,25,10),USE(L:id_proveedor),RIGHT(1),OVR,MSG('Identificador in' & |
  'terno del proveedor de producto'),TIP('Identificador interno del proveedor de producto')
                       BUTTON,AT(251,58,12,12),USE(?CallLookup:2),ICON('lupita.ico'),FLAT,TRN
                       STRING(@s50),AT(267,60,135,10),USE(pro:proveedor),FONT(,,,FONT:regular),TRN
                     END

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
BRW1::Toolbar        BrowseToolbarClass
Loc::QHlist13 QUEUE,PRE(QHL13)
Id                         SHORT
Nombre                     STRING(100)
Longitud                   SHORT
Pict                       STRING(50)
Tot                 BYTE
                         END
QPar13 QUEUE,PRE(Q13)
FieldPar                 CSTRING(800)
                         END
QPar213 QUEUE,PRE(Qp213)
F2N                 CSTRING(300)
F2P                 CSTRING(100)
F2T                 BYTE
                         END
Loc::TituloListado13          STRING(100)
Loc::Titulo13          STRING(100)
SavPath13          STRING(2000)
Evo::Group13  GROUP,PRE()
Evo::Procedure13          STRING(100)
Evo::App13          STRING(100)
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
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetAlerts              PROCEDURE(),DERIVED
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

Ec::LoadI_13  SHORT
Gol_woI_13 WINDOW,AT(,,236,43),FONT('MS Sans Serif',8,,),CENTER,GRAY
       IMAGE('clock.ico'),AT(8,11),USE(?ImgoutI_13),CENTERED
       GROUP,AT(38,11,164,20),USE(?G::I_13),BOXED,BEVEL(-1)
         STRING('Preparando datos para Exportacion'),AT(63,11),USE(?StrOutI_13),TRN
         STRING('Aguarde un instante por Favor...'),AT(67,20),USE(?StrOut2I_13),TRN
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
filtrar             ROUTINE
    l:filtro = 'des:descargado <> 1' 
    
    IF glo:localidad_id <> 0
        IF len(l:filtro) <> 0
            l:filtro = clip(l:filtro) &' and '
        END
        l:filtro ='des:id_localidad='&glo:localidad_id
       ! message(l:filtro)
    END
    
    IF GLO:id_planta <> 0
         IF len(l:filtro) <> 0
            l:filtro = clip(l:filtro) &' and '
         END
      l:filtro =clip(l:filtro)& ' des:ID_PLANTA='&GLO:id_planta  
    END
    
    IF l:fecha_desde <> 0 
        IF len(l:filtro) <> 0
            l:filtro = clip(l:filtro) &' and '
        END
        !MESSAGE(l:fecha_desde)
        !l:filtro =clip(l:filtro)& ' des:FECHA_descarga_DATE = '''&format(l:fecha_desde,@d6)&''''
        l:filtro =clip(l:filtro)& ' des:FECHA_descarga_DATE >= '&l:fecha_desde
       
        
    END
    
    IF l:fecha_hasta <> 0 
        IF len(l:filtro) <> 0
            l:filtro = clip(l:filtro) &' and '
        END
        
        
        l:filtro =clip(l:filtro)& ' des:FECHA_descarga_DATE <= '&l:fecha_hasta

    END
    IF L:id_proveedor <> 0
         IF len(l:filtro) <> 0
            l:filtro = clip(l:filtro) &' and '
         END
      l:filtro =clip(l:filtro)& ' via:id_proveedor ='&L:id_proveedor
    END
    
    
   ! message(l:filtro)
    IF EVALUATE(l:filtro)<>''
   
        BRW1.SetFilter(l:filtro)
        BRW1.ApplyFilter()
        brw1.ResetFromFile()
        brw1.ResetFromBuffer()
        ThisWindow.Reset(TRUE)
    ELSE
        message('error en el filtrado')
    END
    
 EXIT
PrintExBrowse13 ROUTINE

 OPEN(Gol_woI_13)
 DISPLAY()
 SETTARGET(QuickWindow)
 SETCURSOR(CURSOR:WAIT)
 EC::LoadI_13 = BRW1.FileLoaded
 IF Not  EC::LoadI_13
     BRW1.FileLoaded=True
     CLEAR(BRW1.LastItems,1)
     BRW1.ResetFromFile()
 END
 CLOSE(Gol_woI_13)
 SETCURSOR()
  Evo::App13          = 'existencias'
  Evo::Procedure13          = GlobalErrors.GetProcedureName()& 13
 
  FREE(QPar13)
  Q13:FieldPar  = '1,2,3,4,5,6,7,8,9,10,11,12,'
  ADD(QPar13)  !!1
  Q13:FieldPar  = ';'
  ADD(QPar13)  !!2
  Q13:FieldPar  = 'Spanish'
  ADD(QPar13)  !!3
  Q13:FieldPar  = ''
  ADD(QPar13)  !!4
  Q13:FieldPar  = true
  ADD(QPar13)  !!5
  Q13:FieldPar  = ''
  ADD(QPar13)  !!6
  Q13:FieldPar  = true
  ADD(QPar13)  !!7
 !!!! Exportaciones
  Q13:FieldPar  = 'HTML|'
   Q13:FieldPar  = CLIP( Q13:FieldPar)&'EXCEL|'
   Q13:FieldPar  = CLIP( Q13:FieldPar)&'WORD|'
  Q13:FieldPar  = CLIP( Q13:FieldPar)&'ASCII|'
   Q13:FieldPar  = CLIP( Q13:FieldPar)&'XML|'
   Q13:FieldPar  = CLIP( Q13:FieldPar)&'PRT|'
  ADD(QPar13)  !!8
  Q13:FieldPar  = 'All'
  ADD(QPar13)   !.9.
  Q13:FieldPar  = ' 0'
  ADD(QPar13)   !.10
  Q13:FieldPar  = 0
  ADD(QPar13)   !.11
  Q13:FieldPar  = '1'
  ADD(QPar13)   !.12
 
  Q13:FieldPar  = ''
  ADD(QPar13)   !.13
 
  Q13:FieldPar  = ''
  ADD(QPar13)   !.14
 
  Q13:FieldPar  = ''
  ADD(QPar13)   !.15
 
   Q13:FieldPar  = '16'
  ADD(QPar13)   !.16
 
   Q13:FieldPar  = 1
  ADD(QPar13)   !.17
   Q13:FieldPar  = 2
  ADD(QPar13)   !.18
   Q13:FieldPar  = '2'
  ADD(QPar13)   !.19
   Q13:FieldPar  = 12
  ADD(QPar13)   !.20
 
   Q13:FieldPar  = 0 !Exporta excel sin borrar
  ADD(QPar13)   !.21
 
   Q13:FieldPar  = Evo::NroPage !Nro Pag. Desde Report (BExp)
  ADD(QPar13)   !.22
 
   CLEAR(Q13:FieldPar)
  ADD(QPar13)   ! 23 Caracteres Encoding para xml
 
  Q13:FieldPar  = '0'
  ADD(QPar13)   ! 24 Use Open Office
 
   Q13:FieldPar  = '13021968'
 
 
  ADD(QPar13)
 
  FREE(QPar213)
       Qp213:F2N  = 'Id descarga'
  Qp213:F2P  = '@N20_'
  Qp213:F2T  = '0'
  ADD(QPar213)
  Qp213:F2N  = 'ECNOEXPORT'
  Qp213:F2P  = '@P<<<<<P'
  Qp213:F2T  = '0'
  ADD(QPar213)
  Qp213:F2N  = 'ECNOEXPORT'
  Qp213:F2P  = '@n-14'
  Qp213:F2T  = '0'
  ADD(QPar213)
       Qp213:F2N  = 'Viaje'
  Qp213:F2P  = '@N20_'
  Qp213:F2T  = '0'
  ADD(QPar213)
       Qp213:F2N  = 'Localidad'
  Qp213:F2P  = '@s20'
  Qp213:F2T  = '0'
  ADD(QPar213)
       Qp213:F2N  = 'Proveedor'
  Qp213:F2P  = '@s50'
  Qp213:F2T  = '0'
  ADD(QPar213)
       Qp213:F2N  = 'Nro planta'
  Qp213:F2P  = '@P<<P'
  Qp213:F2T  = '0'
  ADD(QPar213)
       Qp213:F2N  = 'Fecha descarga'
  Qp213:F2P  = '@d6'
  Qp213:F2T  = '0'
  ADD(QPar213)
       Qp213:F2N  = 'Nro Remito'
  Qp213:F2P  = '@s50'
  Qp213:F2T  = '0'
  ADD(QPar213)
       Qp213:F2N  = 'Guia Transporte'
  Qp213:F2P  = '@s50'
  Qp213:F2T  = '0'
  ADD(QPar213)
  Qp213:F2N  = 'ECNOEXPORT'
  Qp213:F2P  = '@P<<P'
  Qp213:F2T  = '0'
  ADD(QPar213)
       Qp213:F2N  = 'Cantidad'
  Qp213:F2P  = '@N-14.'
  Qp213:F2T  = '0'
  ADD(QPar213)
  SysRec# = false
  FREE(Loc::QHlist13)
  LOOP
     SysRec# += 1
     IF ?Browse:1{PROPLIST:Exists,SysRec#} = 1
         GET(QPar213,SysRec#)
         QHL13:Id      = SysRec#
         QHL13:Nombre  = Qp213:F2N
         QHL13:Longitud= ?Browse:1{PropList:Width,SysRec#}  /2
         QHL13:Pict    = Qp213:F2P
         QHL13:Tot    = Qp213:F2T
         ADD(Loc::QHlist13)
      Else
        break
     END
  END
  Loc::Titulo13 ='Descargas'
 
 SavPath13 = PATH()
  Exportar(Loc::QHlist13,BRW1.Q,QPar13,0,Loc::Titulo13,Evo::Group13)
 IF Not EC::LoadI_13 Then  BRW1.FileLoaded=false.
 SETPATH(SavPath13)
 !!!! Fin Routina Templates Clarion

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseDescargas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?GLO:localidad_id
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('des:id_descarga',des:id_descarga)                  ! Added by: BrowseBox(ABC)
  BIND('des:id_viaje',des:id_viaje)                        ! Added by: BrowseBox(ABC)
  BIND('pla:NRO_PLANTA',pla:NRO_PLANTA)                    ! Added by: BrowseBox(ABC)
  BIND('via:nro_remito',via:nro_remito)                    ! Added by: BrowseBox(ABC)
  BIND('via:guia_transporte',via:guia_transporte)          ! Added by: BrowseBox(ABC)
  BIND('des:id_planta',des:id_planta)                      ! Added by: BrowseBox(ABC)
  BIND('pla:ID_PLANTA',pla:ID_PLANTA)                      ! Added by: BrowseBox(ABC)
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
  Relate:Descargas.SetOpenRelated()
  Relate:Descargas.Open                                    ! File Descargas used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Descargas,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,des:PK_descargas)                     ! Add the sort order for des:PK_descargas for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?l:buscador,des:id_descarga,,BRW1) ! Initialize the browse locator using ?l:buscador using key: des:PK_descargas , des:id_descarga
  BRW1.AddField(des:id_descarga,BRW1.Q.des:id_descarga)    ! Field des:id_descarga is a hot field or requires assignment from browse
  BRW1.AddField(via:id_proveedor,BRW1.Q.via:id_proveedor)  ! Field via:id_proveedor is a hot field or requires assignment from browse
  BRW1.AddField(des:id_localidad,BRW1.Q.des:id_localidad)  ! Field des:id_localidad is a hot field or requires assignment from browse
  BRW1.AddField(des:id_viaje,BRW1.Q.des:id_viaje)          ! Field des:id_viaje is a hot field or requires assignment from browse
  BRW1.AddField(Loc:Localidad,BRW1.Q.Loc:Localidad)        ! Field Loc:Localidad is a hot field or requires assignment from browse
  BRW1.AddField(pro:proveedor,BRW1.Q.pro:proveedor)        ! Field pro:proveedor is a hot field or requires assignment from browse
  BRW1.AddField(pla:NRO_PLANTA,BRW1.Q.pla:NRO_PLANTA)      ! Field pla:NRO_PLANTA is a hot field or requires assignment from browse
  BRW1.AddField(des:fecha_descarga_DATE,BRW1.Q.des:fecha_descarga_DATE) ! Field des:fecha_descarga_DATE is a hot field or requires assignment from browse
  BRW1.AddField(via:nro_remito,BRW1.Q.via:nro_remito)      ! Field via:nro_remito is a hot field or requires assignment from browse
  BRW1.AddField(via:guia_transporte,BRW1.Q.via:guia_transporte) ! Field via:guia_transporte is a hot field or requires assignment from browse
  BRW1.AddField(des:id_planta,BRW1.Q.des:id_planta)        ! Field des:id_planta is a hot field or requires assignment from browse
  BRW1.AddField(des:cantidad,BRW1.Q.des:cantidad)          ! Field des:cantidad is a hot field or requires assignment from browse
  BRW1.AddField(pla:ID_PLANTA,BRW1.Q.pla:ID_PLANTA)        ! Field pla:ID_PLANTA is a hot field or requires assignment from browse
  BRW1.AddField(Loc:id_localidad,BRW1.Q.Loc:id_localidad)  ! Field Loc:id_localidad is a hot field or requires assignment from browse
  BRW1.AddField(via:id_viaje,BRW1.Q.via:id_viaje)          ! Field via:id_viaje is a hot field or requires assignment from browse
  BRW1.AddField(pro:id_proveedor,BRW1.Q.pro:id_proveedor)  ! Field pro:id_proveedor is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseDescargas',QuickWindow)              ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 5
  SELF.SetAlerts()
  if glo:localidad_id <> 0
      Loc:id_localidad = GLO:localidad_id
      Access:Localidades_GLP.fetch(Loc:PK_localidad)
      
  END
  
  if GLO:id_planta<> 0
      pla:ID_PLANTA = GLO:id_planta
      Access:Plantas.Fetch(pla:PK__plantas__7D439ABD)
  END
  
  
  if GLO:localidad_id <> 0 or GLO:id_planta <> 0
      do filtrar
      
  END
  
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,des:PK_descargas)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Descargas.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('BrowseDescargas',QuickWindow)           ! Save window data to non-volatile store
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
      SelectPlantas
      SelectProveedores
      UpdateDescargas
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?GLO:localidad_id
      IF GLO:localidad_id OR ?GLO:localidad_id{PROP:Req}
        Loc:id_localidad = GLO:localidad_id
        IF Access:Localidades_GLP.TryFetch(Loc:PK_localidad)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            GLO:localidad_id = Loc:id_localidad
            l:localidad = Loc:Localidad
          ELSE
            CLEAR(l:localidad)
            SELECT(?GLO:localidad_id)
            CYCLE
          END
        ELSE
          l:localidad = Loc:Localidad
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookup
      ThisWindow.Update
      Loc:id_localidad = GLO:localidad_id
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        GLO:localidad_id = Loc:id_localidad
        l:localidad = Loc:Localidad
      END
      ThisWindow.Reset(1)
    OF ?BotonSeleccionFechaDesde
      ThisWindow.Update
      CHANGE(?l:fecha_desde,bigfec(CONTENTS(?l:fecha_desde)))
      !DO RefreshWindow
    OF ?BtnFiltrar
      ThisWindow.Update
      do filtrar
    OF ?GLO:id_planta
      IF GLO:id_planta OR ?GLO:id_planta{PROP:Req}
        pla:ID_PLANTA = GLO:id_planta
        IF Access:Plantas.TryFetch(pla:PK__plantas__7D439ABD)
          IF SELF.Run(3,SelectRecord) = RequestCompleted
            GLO:id_planta = pla:ID_PLANTA
          ELSE
            SELECT(?GLO:id_planta)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupPlanta
      ThisWindow.Update
      pla:ID_PLANTA = GLO:id_planta
      IF SELF.Run(3,SelectRecord) = RequestCompleted
        GLO:id_planta = pla:ID_PLANTA
      END
      ThisWindow.Reset(1)
    OF ?BotonSeleccionFechaHasta
      ThisWindow.Update
      CHANGE(?l:fecha_hasta,bigfec(CONTENTS(?l:fecha_hasta)))
      !DO RefreshWindow
    OF ?EvoExportarDescargas
      ThisWindow.Update
       Do PrintExBrowse13
    OF ?L:id_proveedor
      IF L:id_proveedor OR ?L:id_proveedor{PROP:Req}
        pro:id_proveedor = L:id_proveedor
        IF Access:Proveedores.TryFetch(pro:PK_proveedor)
          IF SELF.Run(4,SelectRecord) = RequestCompleted
            L:id_proveedor = pro:id_proveedor
          ELSE
            SELECT(?L:id_proveedor)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookup:2
      ThisWindow.Update
      pro:id_proveedor = L:id_proveedor
      IF SELF.Run(4,SelectRecord) = RequestCompleted
        L:id_proveedor = pro:id_proveedor
      END
      ThisWindow.Reset(1)
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
  OF ?GLO:localidad_id
    if GlobalResponse = RequestCompleted
        do filtrar
    END
  OF ?CallLookup
    if GlobalResponse = RequestCompleted
        do filtrar
    END
  OF ?l:fecha_desde
    !IF l:fecha_desde <> 0
    !    do filtrar
    !END
    !
    !
  OF ?BotonSeleccionFechaDesde
    !if GlobalResponse = RequestCompleted
    !        if l:fecha_desde<> 0
    !        do filtrar
    !    end
    !
    !   
    !END
  OF ?l:fecha_hasta
    ! IF l:fecha_hasta <> 0
    !        do filtrar
    !    END
  OF ?BotonSeleccionFechaHasta
    !if GlobalResponse = RequestCompleted
    !        if l:fecha_hasta<> 0
    !        do filtrar
    !    end
    !
    !   
    !END
  OF ?L:id_proveedor
    if GlobalResponse = RequestCompleted
        do filtrar
    END
  OF ?CallLookup:2
    if GlobalResponse = RequestCompleted
        do filtrar
    END
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
          l:localidad = Loc:Localidad
      ELSE
          CLEAR(l:localidad)
        END
      END
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
!!! Generated from procedure template - Window
!!! Viajes
!!! </summary>
BrowseViajes PROCEDURE 

CurrentTab           STRING(80)                            !
l:filtro             CSTRING(500)                          !
Buscador             CSTRING(51)                           !
BRW1::View:Browse    VIEW(Viajes)
                       PROJECT(via:id_viaje)
                       PROJECT(via:anulado)
                       PROJECT(via:fecha_carga_DATE)
                       PROJECT(via:peso)
                       PROJECT(via:importe_producto)
                       PROJECT(via:estado)
                       PROJECT(via:guia_transporte)
                       PROJECT(via:nro_remito)
                       PROJECT(via:chofer)
                       PROJECT(via:id_programacion)
                       PROJECT(via:id_transportista)
                       PROJECT(via:id_proveedor)
                       PROJECT(via:id_localidad)
                       PROJECT(via:id_procedencia)
                       JOIN(tra:PK_TRANSPORTISTA,via:id_transportista)
                         PROJECT(tra:transportista)
                         PROJECT(tra:id_transportista)
                       END
                       JOIN(pro:PK_proveedor,via:id_proveedor)
                         PROJECT(pro:proveedor)
                         PROJECT(pro:id_proveedor)
                       END
                       JOIN(Loc:PK_localidad,via:id_localidad)
                         PROJECT(Loc:Localidad)
                         PROJECT(Loc:id_localidad)
                       END
                       JOIN(pro1:PK_PROCEDENCIA,via:id_procedencia)
                         PROJECT(pro1:procedencia)
                         PROJECT(pro1:id_procedencia)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
via:id_viaje           LIKE(via:id_viaje)             !List box control field - type derived from field
via:anulado            LIKE(via:anulado)              !List box control field - type derived from field
via:fecha_carga_DATE   LIKE(via:fecha_carga_DATE)     !List box control field - type derived from field
pro1:procedencia       LIKE(pro1:procedencia)         !List box control field - type derived from field
Loc:Localidad          LIKE(Loc:Localidad)            !List box control field - type derived from field
via:peso               LIKE(via:peso)                 !List box control field - type derived from field
via:importe_producto   LIKE(via:importe_producto)     !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
via:estado             LIKE(via:estado)               !List box control field - type derived from field
tra:transportista      LIKE(tra:transportista)        !List box control field - type derived from field
via:guia_transporte    LIKE(via:guia_transporte)      !List box control field - type derived from field
via:nro_remito         LIKE(via:nro_remito)           !List box control field - type derived from field
via:chofer             LIKE(via:chofer)               !List box control field - type derived from field
via:id_programacion    LIKE(via:id_programacion)      !List box control field - type derived from field
tra:id_transportista   LIKE(tra:id_transportista)     !Related join file key field - type derived from field
pro:id_proveedor       LIKE(pro:id_proveedor)         !Related join file key field - type derived from field
Loc:id_localidad       LIKE(Loc:id_localidad)         !Related join file key field - type derived from field
pro1:id_procedencia    LIKE(pro1:id_procedencia)      !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,526,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseViajes'),SYSTEM,WALLPAPER('fondo.jpg')
                       ENTRY(@P<<<P),AT(66,38,15,10),USE(GLO:localidad_id)
                       BUTTON,AT(86,37,12,12),USE(?CallLookupLocalidad),ICON('Lupita.ico'),FLAT,TRN
                       BUTTON,AT(130,53,22,18),USE(?BotonSeleccionFechaDesde),ICON('calen.ico'),FLAT,TRN
                       BUTTON,AT(266,53,22,18),USE(?BotonSeleccionFechaHasta),ICON('calen.ico'),FLAT,TRN
                       BUTTON,AT(461,41,25,25),USE(?BtnFiltrar),ICON('seleccionar.ICO'),FLAT,TRN
                       ENTRY(@s50),AT(159,87,152),USE(Buscador)
                       BUTTON,AT(324,87,12,14),USE(?Browse:Top),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page')
                       BUTTON,AT(339,87,12,14),USE(?Browse:PageUp),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the Prior Page')
                       BUTTON,AT(353,87,12,14),USE(?Browse:Up),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record')
                       BUTTON,AT(368,87,12,14),USE(?Browse:Down),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record')
                       BUTTON,AT(383,87,12,14),USE(?Browse:PageDown),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page')
                       BUTTON,AT(397,87,12,14),USE(?Browse:Bottom),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page')
                       LIST,AT(14,108,498,181),USE(?Browse:1),HVSCROLL,FORMAT('36D(2)|M~Nro viaje~C(2)@N20_@31' & |
  'D(2)|M~anulado~C(0)@n3@51R(2)|M~Fecha carga~C(0)@d6@134L(2)|M~Procedencia~C(0)@s50@8' & |
  '0L(2)|M~Destino~C(0)@s20@48D(22)|M~Peso~C(0)@N-10.`2@61D(22)|M~Importe Producto~D(0)' & |
  '@N$-13.2@150L(2)|M~Proveedor~C(0)@s50@71L(2)|M~Estado~C(2)@s50@103L(2)|M~Transportis' & |
  'ta~C(0)@s50@80L(2)|M~guia transporte~C(2)@s50@80L(2)|M~nro remito~C(2)@s50@80L(2)|M~' & |
  'Chofer~C(2)@s50@40L(2)|M~Id Cupo~C(1)@P<<<<<<<<<<<<P@'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he Viajes file')
                       BUTTON,AT(22,295,35,25),USE(?Seleccionar),ICON('seleccionar.ICO'),FLAT,TRN
                       BUTTON,AT(173,295,35,25),USE(?View:2),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'),TIP('Vizualizar' & |
  ' el registro')
                       BUTTON,AT(211,295,35,25),USE(?Insert:3),ICON('Insertar.ico'),FLAT,MSG('Insertar un registro'), |
  TIP('Insertar un registro')
                       BUTTON,AT(249,295,35,25),USE(?Change:3),ICON('Editar.ico'),FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro')
                       BUTTON,AT(287,295,35,25),USE(?Delete:3),ICON('Eliminar.ICO'),FLAT,MSG('Eliminar el registro'), |
  TIP('Eliminar el registro')
                       BUTTON,AT(429,295,35,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON,AT(467,295,35,25),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'),STD(STD:Help), |
  TIP('Ver ventana de ayuda')
                       STRING('Viajes de GLP'),AT(229,13,70),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       BOX,AT(13,291,499,34),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       STRING('Buscador'),AT(124,89),USE(?STRING2),TRN
                       BOX,AT(13,81,499,25),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BOX,AT(13,29,499,49),USE(?BOX1:3),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       PROMPT('Localidad'),AT(31,38),USE(?GLO:localidad_id:Prompt),TRN
                       STRING(@s20),AT(102,38,85,11),USE(Loc:Localidad),TRN
                       PROMPT('Desde:'),AT(38,61),USE(?GLO:fecha_Desde:Prompt),TRN
                       ENTRY(@d6),AT(66,61,60,10),USE(GLO:fecha_Desde)
                       PROMPT('Hasta:'),AT(177,61),USE(?GLO:fecha_hasta:Prompt),TRN
                       ENTRY(@d6),AT(201,61,60,10),USE(GLO:fecha_hasta)
                     END

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
BRW1::Toolbar        BrowseToolbarClass
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
SetAlerts              PROCEDURE(),DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  FilterLocatorClass                    ! Default Locator

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
filtrar             ROUTINE
    l:filtro = '' 
    
    if glo:localidad_id <> 0
        l:filtro ='via:id_localidad ='&glo:localidad_id
        
    END
    
    
    if glo:fecha_desde <> 0
       if len(l:filtro) <> 0
            l:filtro = clip(l:filtro) &' and '
        END
        l:filtro = clip(l:filtro) &' via:fecha_carga_DATE >='&glo:fecha_desde
    END
    
    if glo:fecha_hasta <> 0
        if len(l:filtro) <> 0
            l:filtro = clip(l:filtro) &' and '
        END
        l:filtro = clip(l:filtro) &' via:fecha_carga_DATE <= '&glo:fecha_hasta
    END
    
    
    !message(l:filtro)
    if EVALUATE(l:filtro)<>''
    
        BRW1.SetFilter(l:filtro)
        BRW1.ApplyFilter()
        brw1.ResetFromFile()
        brw1.ResetFromBuffer()
        ThisWindow.Reset(TRUE)
    ELSE
        message('Error en el filtrado:'&l:filtro,'Atención',ICON:Exclamation)
    END
    
 EXIT
    

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseViajes')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?GLO:localidad_id
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('via:id_viaje',via:id_viaje)                        ! Added by: BrowseBox(ABC)
  BIND('via:guia_transporte',via:guia_transporte)          ! Added by: BrowseBox(ABC)
  BIND('via:nro_remito',via:nro_remito)                    ! Added by: BrowseBox(ABC)
  BIND('via:id_programacion',via:id_programacion)          ! Added by: BrowseBox(ABC)
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
  Relate:Proveedores.SetOpenRelated()
  Relate:Proveedores.Open                                  ! File Proveedores used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Viajes,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  GLO:localidad_id = 0
  GLO:fecha_Desde = date(month(today()),1,year(today()))
  GLO:fecha_hasta = today()
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,via:PK_viajes)                        ! Add the sort order for via:PK_viajes for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?Buscador,via:id_viaje,1,BRW1)  ! Initialize the browse locator using ?Buscador using key: via:PK_viajes , via:id_viaje
  BRW1.AddField(via:id_viaje,BRW1.Q.via:id_viaje)          ! Field via:id_viaje is a hot field or requires assignment from browse
  BRW1.AddField(via:anulado,BRW1.Q.via:anulado)            ! Field via:anulado is a hot field or requires assignment from browse
  BRW1.AddField(via:fecha_carga_DATE,BRW1.Q.via:fecha_carga_DATE) ! Field via:fecha_carga_DATE is a hot field or requires assignment from browse
  BRW1.AddField(pro1:procedencia,BRW1.Q.pro1:procedencia)  ! Field pro1:procedencia is a hot field or requires assignment from browse
  BRW1.AddField(Loc:Localidad,BRW1.Q.Loc:Localidad)        ! Field Loc:Localidad is a hot field or requires assignment from browse
  BRW1.AddField(via:peso,BRW1.Q.via:peso)                  ! Field via:peso is a hot field or requires assignment from browse
  BRW1.AddField(via:importe_producto,BRW1.Q.via:importe_producto) ! Field via:importe_producto is a hot field or requires assignment from browse
  BRW1.AddField(pro:proveedor,BRW1.Q.pro:proveedor)        ! Field pro:proveedor is a hot field or requires assignment from browse
  BRW1.AddField(via:estado,BRW1.Q.via:estado)              ! Field via:estado is a hot field or requires assignment from browse
  BRW1.AddField(tra:transportista,BRW1.Q.tra:transportista) ! Field tra:transportista is a hot field or requires assignment from browse
  BRW1.AddField(via:guia_transporte,BRW1.Q.via:guia_transporte) ! Field via:guia_transporte is a hot field or requires assignment from browse
  BRW1.AddField(via:nro_remito,BRW1.Q.via:nro_remito)      ! Field via:nro_remito is a hot field or requires assignment from browse
  BRW1.AddField(via:chofer,BRW1.Q.via:chofer)              ! Field via:chofer is a hot field or requires assignment from browse
  BRW1.AddField(via:id_programacion,BRW1.Q.via:id_programacion) ! Field via:id_programacion is a hot field or requires assignment from browse
  BRW1.AddField(tra:id_transportista,BRW1.Q.tra:id_transportista) ! Field tra:id_transportista is a hot field or requires assignment from browse
  BRW1.AddField(pro:id_proveedor,BRW1.Q.pro:id_proveedor)  ! Field pro:id_proveedor is a hot field or requires assignment from browse
  BRW1.AddField(Loc:id_localidad,BRW1.Q.Loc:id_localidad)  ! Field Loc:id_localidad is a hot field or requires assignment from browse
  BRW1.AddField(pro1:id_procedencia,BRW1.Q.pro1:id_procedencia) ! Field pro1:id_procedencia is a hot field or requires assignment from browse
  INIMgr.Fetch('BrowseViajes',QuickWindow)                 ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 3
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
    Relate:Proveedores.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('BrowseViajes',QuickWindow)              ! Save window data to non-volatile store
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?GLO:localidad_id
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
    OF ?CallLookupLocalidad
      ThisWindow.Update
      Loc:id_localidad = GLO:localidad_id
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        GLO:localidad_id = Loc:id_localidad
      END
      ThisWindow.Reset(1)
    OF ?BotonSeleccionFechaDesde
      ThisWindow.Update
      CHANGE(?GLO:fecha_Desde,bigfec(CONTENTS(?GLO:fecha_Desde)))
      !DO RefreshWindow
    OF ?BotonSeleccionFechaHasta
      ThisWindow.Update
      CHANGE(?GLO:fecha_hasta,bigfec(CONTENTS(?GLO:fecha_hasta)))
      !DO RefreshWindow
    OF ?BtnFiltrar
      ThisWindow.Update
      do filtrar
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


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Seleccionar
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END
  SELF.ViewControl = ?View:2                               ! Setup the control used to initiate view only mode


BRW1.SetSort PROCEDURE(BYTE NewOrder,BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.SetSort(NewOrder,Force)
  IF BRW1::LastSortOrder<>NewOrder THEN
     BRW1::SortHeader.ClearSort()
  END
  BRW1::LastSortOrder=NewOrder
  RETURN ReturnValue

BRW1::SortHeader.QueueResorted       PROCEDURE(STRING pString)
  CODE
    IF pString = ''
       BRW1::Sort0:Locator.UseFreeElementOnly = True
       BRW1.RestoreSort()
       BRW1.ResetSort(True)
    ELSE
       BRW1.ReplaceSort(pString,BRW1::Sort0:Locator)
       BRW1.SetLocatorFromSort()
       BRW1.ResetFromBuffer()
    END
!!! <summary>
!!! Generated from procedure template - Window
!!! Densidades_Corregidas
!!! </summary>
BrowseDensidades_Corregidas PROCEDURE 

CurrentTab           STRING(80)                            !
l:densidad           DECIMAL(7,3)                          !
L:strFiltro          STRING(100)                           !
l:temperarura        LONG                                  !
l:buscador           CSTRING(50)                           !
BRW1::View:Browse    VIEW(Densidades_Corregidas)
                       PROJECT(den:id_factor)
                       PROJECT(den:temperatura)
                       PROJECT(den:densidad)
                       PROJECT(den:factor_ajuste)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
den:id_factor          LIKE(den:id_factor)            !List box control field - type derived from field
den:temperatura        LIKE(den:temperatura)          !List box control field - type derived from field
den:densidad           LIKE(den:densidad)             !List box control field - type derived from field
l:densidad             LIKE(l:densidad)               !List box control field - type derived from local data
den:factor_ajuste      LIKE(den:factor_ajuste)        !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseDensidades_Corregidas'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(122,96,296,178),USE(?Browse:1),HVSCROLL,FORMAT('40L(2)|M~Id factor~@P<<<<<<<<P@' & |
  '64R(2)|M~Temperatura~C(0)@n-14@80D(40)|M~Densidad~C(0)@N-24_`4@55L(2)|M~Densidad Cor' & |
  'r~D(5)@n-9.4@56D(22)|M~Factor Ajuste~C(0)@N-8.`4@'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he Densidades_Corregidas file')
                       BUTTON('&Ver'),AT(176,292,34,34),USE(?View:2),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'), |
  TIP('Vizualizar el registro')
                       BUTTON('&Insertar'),AT(215,292,34,34),USE(?Insert:3),ICON('Insertar.ico'),DISABLE,FLAT,HIDE, |
  MSG('Insertar un registro'),TIP('Insertar un registro')
                       BUTTON('E&ditar'),AT(252,292,34,34),USE(?Change:3),ICON('Editar.ico'),DEFAULT,DISABLE,FLAT, |
  HIDE,MSG('Editar el registro'),TIP('Editar el registro')
                       BUTTON('&Eliminar'),AT(291,292,34,34),USE(?Delete:3),ICON('Eliminar.ICO'),DISABLE,FLAT,HIDE, |
  MSG('Eliminar el registro'),TIP('Eliminar el registro')
                       BUTTON('&Cerrar'),AT(407,292,34,34),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'), |
  TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(445,292,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'), |
  STD(STD:Help),TIP('Ver ventana de ayuda')
                       STRING('Desidades corregidas'),AT(229,19),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI)
                       ENTRY(@s49),AT(159,79,197),USE(l:buscador)
                       PROMPT('Densidad:'),AT(99,50),USE(?l:densidad:Prompt)
                       ENTRY(@n-10.3),AT(149,50,60,10),USE(l:densidad),DECIMAL(12)
                       PROMPT('Temperatura:'),AT(223,50),USE(?l:temperarura:Prompt)
                       ENTRY(@n-14),AT(274,50,60,10),USE(l:temperarura)
                       BUTTON,AT(415,33,34,34),USE(?BtnBuscar),ICON('Ver.ico'),FLAT,TRN
                     END

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
SetAlerts              PROCEDURE(),DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetQueueRecord         PROCEDURE(),DERIVED
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator
BRW1::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?Browse:1
EditInPlace::den:temperatura EditEntryClass                ! Edit-in-place class for field den:temperatura
EditInPlace::den:densidad EditEntryClass                   ! Edit-in-place class for field den:densidad
EditInPlace::den:factor_ajuste EditEntryClass              ! Edit-in-place class for field den:factor_ajuste
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
filtrar             ROUTINE
    L:strFiltro=''
    IF l:temperarura 
       
        L:strFiltro = 'den:temperatura = '&l:temperarura
    END
    
    IF den:densidad
        if clip(L:strFiltro) <> ''
        L:strFiltro = clip(L:strFiltro)&' AND '
        END
         L:strFiltro = clip(L:strFiltro)&'den:densidad = '&l:densidad
    END
    BRW1.SetFilter(CLIP(L:strFiltro))
    brw1.ApplyFilter()
    ThisWindow.Reset(true)
    EXIT
    

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseDensidades_Corregidas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('den:id_factor',den:id_factor)                      ! Added by: BrowseBox(ABC)
  BIND('l:densidad',l:densidad)                            ! Added by: BrowseBox(ABC)
  BIND('den:factor_ajuste',den:factor_ajuste)              ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Densidades_Corregidas.Open                        ! File Densidades_Corregidas used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Densidades_Corregidas,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,den:PK_tabla_densidad_corregida)      ! Add the sort order for den:PK_tabla_densidad_corregida for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?l:buscador,den:id_factor,1,BRW1) ! Initialize the browse locator using ?l:buscador using key: den:PK_tabla_densidad_corregida , den:id_factor
  BRW1.AddField(den:id_factor,BRW1.Q.den:id_factor)        ! Field den:id_factor is a hot field or requires assignment from browse
  BRW1.AddField(den:temperatura,BRW1.Q.den:temperatura)    ! Field den:temperatura is a hot field or requires assignment from browse
  BRW1.AddField(den:densidad,BRW1.Q.den:densidad)          ! Field den:densidad is a hot field or requires assignment from browse
  BRW1.AddField(l:densidad,BRW1.Q.l:densidad)              ! Field l:densidad is a hot field or requires assignment from browse
  BRW1.AddField(den:factor_ajuste,BRW1.Q.den:factor_ajuste) ! Field den:factor_ajuste is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseDensidades_Corregidas',QuickWindow)  ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,den:PK_tabla_densidad_corregida)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Densidades_Corregidas.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('BrowseDensidades_Corregidas',QuickWindow) ! Save window data to non-volatile store
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
    UpdateDensidades_Corregidas
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BtnBuscar
      ThisWindow.Update
      do filtrar
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


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(,1) ! den:id_factor Disable
  SELF.AddEditControl(EditInPlace::den:temperatura,2)
  SELF.AddEditControl(EditInPlace::den:densidad,3)
  SELF.AddEditControl(,4) ! l:densidad Disable
  SELF.AddEditControl(EditInPlace::den:factor_ajuste,5)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END
  SELF.ViewControl = ?View:2                               ! Setup the control used to initiate view only mode


BRW1.SetQueueRecord PROCEDURE

  CODE
  l:densidad = den:densidad / 1000
  PARENT.SetQueueRecord
  
  SELF.Q.l:densidad = l:densidad                           !Assign formula result to display queue


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
!!! Generated from procedure template - Window
!!! Niveles_Volumenes
!!! </summary>
BrowseNiveles_Volumenes PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Niveles_Volumenes)
                       PROJECT(niv:id_nivel)
                       PROJECT(niv:nivel_regla)
                       PROJECT(niv:volumen_calculado)
                       PROJECT(niv:idt_tanque)
                       JOIN(t_t:PK_t_tanques,niv:idt_tanque)
                         PROJECT(t_t:modelo)
                         PROJECT(t_t:idt_tanque)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
niv:id_nivel           LIKE(niv:id_nivel)             !List box control field - type derived from field
t_t:modelo             LIKE(t_t:modelo)               !List box control field - type derived from field
niv:nivel_regla        LIKE(niv:nivel_regla)          !List box control field - type derived from field
niv:volumen_calculado  LIKE(niv:volumen_calculado)    !List box control field - type derived from field
t_t:idt_tanque         LIKE(t_t:idt_tanque)           !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,427,296),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseNiveles_Volumenes'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(65,73,255,104),USE(?Browse:1),HVSCROLL,FORMAT('64R(2)|M~Id Nivel~C(0)@n-14@80R(' & |
  '2)|M~Modelo~C(0)@s20@48D(7)|M~Nivel regla~C(0)@N-9.`3@40D(22)|M~Volumen~C(0)@N-8.`4@'), |
  FROM(Queue:Browse:1),IMM,MSG('Browsing the Niveles_Volumenes file')
                       BUTTON('&Ver'),AT(114,221,34,34),USE(?View:2),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'), |
  TIP('Vizualizar el registro')
                       BUTTON('&Insertar'),AT(152,221,34,34),USE(?Insert:3),ICON('Insertar.ico'),FLAT,MSG('Insertar u' & |
  'n registro'),TIP('Insertar un registro')
                       BUTTON('E&ditar'),AT(190,221,34,34),USE(?Change:3),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro')
                       BUTTON('&Eliminar'),AT(228,221,34,34),USE(?Delete:3),ICON('Eliminar.ICO'),FLAT,MSG('Eliminar e' & |
  'l registro'),TIP('Eliminar el registro')
                       BUTTON('&Cerrar'),AT(327,221,34,34),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'), |
  TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(365,221,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'), |
  STD(STD:Help),TIP('Ver ventana de ayuda')
                       BUTTON('t_tanques'),AT(15,221,47,34),USE(?Selectt_tanques),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona' & |
  'r campo padre'),TIP('Seleccionar campo padre')
                       STRING('Tabla de conversion de nivel a volumenes<0DH,0AH>'),AT(107,17),USE(?STRING1),FONT('Arial', |
  10,,FONT:bold+FONT:italic+FONT:underline,CHARSET:ANSI)
                     END

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
  GlobalErrors.SetProcedureName('BrowseNiveles_Volumenes')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('niv:id_nivel',niv:id_nivel)                        ! Added by: BrowseBox(ABC)
  BIND('niv:nivel_regla',niv:nivel_regla)                  ! Added by: BrowseBox(ABC)
  BIND('niv:volumen_calculado',niv:volumen_calculado)      ! Added by: BrowseBox(ABC)
  BIND('t_t:idt_tanque',t_t:idt_tanque)                    ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Niveles_Volumenes.SetOpenRelated()
  Relate:Niveles_Volumenes.Open                            ! File Niveles_Volumenes used by this procedure, so make sure it's RelationManager is open
  Access:t_tanques.UseFile                                 ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Niveles_Volumenes,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,niv:PK_niveles_volumenes)             ! Add the sort order for niv:PK_niveles_volumenes for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,niv:id_nivel,1,BRW1)           ! Initialize the browse locator using  using key: niv:PK_niveles_volumenes , niv:id_nivel
  BRW1.AddField(niv:id_nivel,BRW1.Q.niv:id_nivel)          ! Field niv:id_nivel is a hot field or requires assignment from browse
  BRW1.AddField(t_t:modelo,BRW1.Q.t_t:modelo)              ! Field t_t:modelo is a hot field or requires assignment from browse
  BRW1.AddField(niv:nivel_regla,BRW1.Q.niv:nivel_regla)    ! Field niv:nivel_regla is a hot field or requires assignment from browse
  BRW1.AddField(niv:volumen_calculado,BRW1.Q.niv:volumen_calculado) ! Field niv:volumen_calculado is a hot field or requires assignment from browse
  BRW1.AddField(t_t:idt_tanque,BRW1.Q.t_t:idt_tanque)      ! Field t_t:idt_tanque is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseNiveles_Volumenes',QuickWindow)      ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Niveles_Volumenes.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseNiveles_Volumenes',QuickWindow)   ! Save window data to non-volatile store
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
    UpdateNiveles_Volumenes
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
    OF ?Selectt_tanques
      ThisWindow.Update
      GlobalRequest = SelectRecord
      Selectt_tanques()
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END
  SELF.ViewControl = ?View:2                               ! Setup the control used to initiate view only mode


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! t_tanques
!!! </summary>
Browset_tanques PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(t_tanques)
                       PROJECT(t_t:idt_tanque)
                       PROJECT(t_t:modelo)
                       PROJECT(t_t:volumen)
                       PROJECT(t_t:capacidad)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
t_t:idt_tanque         LIKE(t_t:idt_tanque)           !List box control field - type derived from field
t_t:modelo             LIKE(t_t:modelo)               !List box control field - type derived from field
t_t:volumen            LIKE(t_t:volumen)              !List box control field - type derived from field
t_t:capacidad          LIKE(t_t:capacidad)            !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Tipos de Tanques'),AT(,,277,218),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  DOUBLE,TILED,CENTER,GRAY,IMM,MDI,HLP('Browset_tanques'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(8,30,255,104),USE(?Browse:1),HVSCROLL,FORMAT('44L(2)|M~idt tanque~@N20_@80L(2)|' & |
  'M~Modelo~@s20@32D(12)|M~Volumen~C(0)@N-7.2@44D(12)|M~Capacidad~L(12)@N-10_@'),FROM(Queue:Browse:1), |
  IMM,MSG('Browsing the t_tanques file')
                       BUTTON('&Ver'),AT(8,138,34,34),USE(?View:2),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'), |
  TIP('Vizualizar el registro')
                       BUTTON('&Insertar'),AT(46,138,34,34),USE(?Insert:3),ICON('Insertar.ico'),FLAT,MSG('Insertar u' & |
  'n registro'),TIP('Insertar un registro')
                       BUTTON('E&ditar'),AT(84,138,34,34),USE(?Change:3),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro')
                       BUTTON('&Eliminar'),AT(122,138,34,34),USE(?Delete:3),ICON('Eliminar.ICO'),FLAT,MSG('Eliminar e' & |
  'l registro'),TIP('Eliminar el registro')
                       SHEET,AT(4,4,271,172),USE(?CurrentTab)
                         TAB('&1) Id Tanque'),USE(?Tab:2)
                         END
                         TAB('&2) Modelo'),USE(?Tab:3)
                         END
                       END
                       BUTTON('&Cerrar'),AT(201,178,34,34),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'), |
  TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(239,178,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'), |
  STD(STD:Help),TIP('Ver ventana de ayuda')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::Sort1:Locator  StepLocatorClass                      ! Conditional Locator - CHOICE(?CurrentTab) = 2
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
  GlobalErrors.SetProcedureName('Browset_tanques')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('t_t:idt_tanque',t_t:idt_tanque)                    ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:t_tanques.SetOpenRelated()
  Relate:t_tanques.Open                                    ! File t_tanques used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:t_tanques,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,t_t:K_MODELO)                         ! Add the sort order for t_t:K_MODELO for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(,t_t:idt_tanque,1,BRW1)         ! Initialize the browse locator using  using key: t_t:K_MODELO , t_t:idt_tanque
  BRW1.AddSortOrder(,t_t:PK_t_tanques)                     ! Add the sort order for t_t:PK_t_tanques for sort order 2
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort0:Locator.Init(,t_t:idt_tanque,1,BRW1)         ! Initialize the browse locator using  using key: t_t:PK_t_tanques , t_t:idt_tanque
  BRW1.AddField(t_t:idt_tanque,BRW1.Q.t_t:idt_tanque)      ! Field t_t:idt_tanque is a hot field or requires assignment from browse
  BRW1.AddField(t_t:modelo,BRW1.Q.t_t:modelo)              ! Field t_t:modelo is a hot field or requires assignment from browse
  BRW1.AddField(t_t:volumen,BRW1.Q.t_t:volumen)            ! Field t_t:volumen is a hot field or requires assignment from browse
  BRW1.AddField(t_t:capacidad,BRW1.Q.t_t:capacidad)        ! Field t_t:capacidad is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('Browset_tanques',QuickWindow)              ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:t_tanques.Close
  END
  IF SELF.Opened
    INIMgr.Update('Browset_tanques',QuickWindow)           ! Save window data to non-volatile store
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
    Updatet_tanques
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END
  SELF.ViewControl = ?View:2                               ! Setup the control used to initiate view only mode


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?CurrentTab) = 2
    RETURN SELF.SetSort(1,Force)
  ELSE
    RETURN SELF.SetSort(2,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

