

   MEMBER('existencias.clw')                               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('EXISTENCIAS010.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('EXISTENCIAS002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS011.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Procedure not yet defined
!!! </summary>
updateMediciones PROCEDURE !Procedure not yet defined
  CODE
  GlobalErrors.ThrowMessage(Msg:ProcedureToDo,'updateMediciones') ! This procedure acts as a place holder for a procedure yet to be defined
  SETKEYCODE(0)
  GlobalResponse = RequestCancelled                        ! Request cancelled is the implied action
!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
AcercaDe PROCEDURE 

Window               WINDOW,AT(,,263,143),FONT('Microsoft Sans Serif',8,,FONT:regular),DOUBLE,GRAY,MDI,SYSTEM,WALLPAPER('fondo.jpg')
                       STRING('Sistema de Existencias de GLP'),AT(23,25,207,12),USE(?STRING1),TRN
                       STRING('Versión:'),AT(23,116,207,12),USE(?STRING1:2),TRN
                       STRING('Desarrollado por:'),AT(23,41,207,12),USE(?STRING1:3),TRN
                       STRING('Gerencia de Sistemas Distrigas S.A.'),AT(23,57,207,12),USE(?STRING1:4),TRN
                       IMAGE('Logo DISTRIGAS Chico.bmp'),AT(23,70,64,42),USE(?IMAGE1)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
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
  GlobalErrors.SetProcedureName('AcercaDe')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?STRING1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AcercaDe',Window)                          ! Restore window settings from non-volatile store
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('AcercaDe',Window)                       ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
SelectProveedoresAlias PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(ProveedoresAlias)
                       PROJECT(pro2:id_proveedor)
                       PROJECT(pro2:proveedor)
                       PROJECT(pro2:importe_DNL)
                       PROJECT(pro2:direccion)
                       PROJECT(pro2:ciudad)
                       PROJECT(pro2:provincia)
                       PROJECT(pro2:telefono)
                       PROJECT(pro2:contacto)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
pro2:id_proveedor      LIKE(pro2:id_proveedor)        !List box control field - type derived from field
pro2:proveedor         LIKE(pro2:proveedor)           !List box control field - type derived from field
pro2:importe_DNL       LIKE(pro2:importe_DNL)         !List box control field - type derived from field
pro2:direccion         LIKE(pro2:direccion)           !List box control field - type derived from field
pro2:ciudad            LIKE(pro2:ciudad)              !List box control field - type derived from field
pro2:provincia         LIKE(pro2:provincia)           !List box control field - type derived from field
pro2:telefono          LIKE(pro2:telefono)            !List box control field - type derived from field
pro2:contacto          LIKE(pro2:contacto)            !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,386,192),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),RESIZE,CENTER, |
  GRAY,IMM,MDI,HLP('SelectProveedoresAlias'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(18,33,354,113),USE(?Browse:1),HVSCROLL,FORMAT('52L(2)|M~ID Proveedor~@P<<<<<<<<' & |
  '<<P@80L(2)|M~Proveedor~@s50@80D(24)|M~Importe DNL~C(0)@N~$ ~-17_.2@80L(2)|M~direccio' & |
  'n~@s50@80L(2)|M~Ciudad~@s50@80L(2)|M~Provincia~@s50@80L(2)|M~Teléfono~@s50@80L(2)|M~' & |
  'Contacto~@s50@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the ProveedoresAlias file')
                       BUTTON,AT(17,151,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(335,151,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       STRING('Seleccione un proveedor'),AT(128,17,119),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
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
  GlobalErrors.SetProcedureName('SelectProveedoresAlias')
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
  Relate:ProveedoresAlias.Open                             ! File ProveedoresAlias used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:ProveedoresAlias,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,pro2:PK_proveedor)                    ! Add the sort order for pro2:PK_proveedor for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,pro2:id_proveedor,1,BRW1)      ! Initialize the browse locator using  using key: pro2:PK_proveedor , pro2:id_proveedor
  BRW1.AddField(pro2:id_proveedor,BRW1.Q.pro2:id_proveedor) ! Field pro2:id_proveedor is a hot field or requires assignment from browse
  BRW1.AddField(pro2:proveedor,BRW1.Q.pro2:proveedor)      ! Field pro2:proveedor is a hot field or requires assignment from browse
  BRW1.AddField(pro2:importe_DNL,BRW1.Q.pro2:importe_DNL)  ! Field pro2:importe_DNL is a hot field or requires assignment from browse
  BRW1.AddField(pro2:direccion,BRW1.Q.pro2:direccion)      ! Field pro2:direccion is a hot field or requires assignment from browse
  BRW1.AddField(pro2:ciudad,BRW1.Q.pro2:ciudad)            ! Field pro2:ciudad is a hot field or requires assignment from browse
  BRW1.AddField(pro2:provincia,BRW1.Q.pro2:provincia)      ! Field pro2:provincia is a hot field or requires assignment from browse
  BRW1.AddField(pro2:telefono,BRW1.Q.pro2:telefono)        ! Field pro2:telefono is a hot field or requires assignment from browse
  BRW1.AddField(pro2:contacto,BRW1.Q.pro2:contacto)        ! Field pro2:contacto is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectProveedoresAlias',QuickWindow)       ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ProveedoresAlias.Close
  END
  IF SELF.Opened
    INIMgr.Update('SelectProveedoresAlias',QuickWindow)    ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select:2
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
AnularViajeProgramado PROCEDURE  (LONG pid_viaje)          ! Declare Procedure
Progress:Thermometer BYTE                                  !

  CODE
    via:id_viaje = pid_viaje
    IF Access:Viajes.Fetch(via:PK_viajes) = Level:Benign
        IF via:estado <> 'Programado'
            MESSAGE('El viaje no tiene estado Programado')
           
            RETURN 
        END
        
        IF via:anulado = 1
            MESSAGE('El viaje esta anulado')
            RETURN
            
        END
        
        
            
        IF MESSAGE('¿Desea anula el viaje programado?','Atención',ICON:Question,BUTTON:Yes+BUTTON:No,BUTTON:No) = BUTTON:YES

                via:anulado = 1
                IF Access:Viajes.Update() <> Level:Benign
                    MESSAGE( 'Error en la actualizacion de la tabla viajes','Atención',ICON:Exclamation)
                   



            prog:id_programacion = via:id_programacion
            IF access:programacion.Fetch(prog:PK_PROGRAMACION) = Level:Benign
                prog:cupo_GLP_programado -=via:cap_tk_camion
                prog:cupo_GLP_restante = prog:cupo_GLP -(prog:cupo_GLP_programado+prog:cupo_GLP_utilizado)
                
                IF Access:programacion.Update() <> Level:Benign
                    MESSAGE( 'Error en la actualizacion de la tabla programación','Atención',ICON:Exclamation)
                    
                    RETURN 
                END
                
            END
        END
    ELSE
        MESSAGE('No se pudo encontrar el viaje.Contactese con el Administrador','Atención',ICON:Exclamation)
       
        RETURN 
    END
    END

!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
BrowseViajesRelacionadosCupos PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Viajes)
                       PROJECT(via:id_viaje)
                       PROJECT(via:id_programacion)
                       PROJECT(via:nro_remito)
                       PROJECT(via:peso)
                       PROJECT(via:cap_tk_camion)
                       PROJECT(via:fecha_carga_DATE)
                       PROJECT(via:id_procedencia)
                       PROJECT(via:id_transportista)
                       PROJECT(via:id_proveedor)
                       JOIN(pro1:PK_PROCEDENCIA,via:id_procedencia)
                         PROJECT(pro1:procedencia)
                         PROJECT(pro1:id_procedencia)
                       END
                       JOIN(tra:PK_TRANSPORTISTA,via:id_transportista)
                         PROJECT(tra:transportista)
                         PROJECT(tra:id_transportista)
                       END
                       JOIN(pro:PK_proveedor,via:id_proveedor)
                         PROJECT(pro:proveedor)
                         PROJECT(pro:id_proveedor)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
via:id_viaje           LIKE(via:id_viaje)             !List box control field - type derived from field
pro1:procedencia       LIKE(pro1:procedencia)         !List box control field - type derived from field
tra:transportista      LIKE(tra:transportista)        !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
via:id_programacion    LIKE(via:id_programacion)      !List box control field - type derived from field
via:nro_remito         LIKE(via:nro_remito)           !List box control field - type derived from field
via:peso               LIKE(via:peso)                 !List box control field - type derived from field
via:cap_tk_camion      LIKE(via:cap_tk_camion)        !List box control field - type derived from field
via:fecha_carga_DATE   LIKE(via:fecha_carga_DATE)     !List box control field - type derived from field
pro1:id_procedencia    LIKE(pro1:id_procedencia)      !Related join file key field - type derived from field
tra:id_transportista   LIKE(tra:id_transportista)     !Related join file key field - type derived from field
pro:id_proveedor       LIKE(pro:id_proveedor)         !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,524,254),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),RESIZE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseViajesRelacionadosCupos'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(10,43,499,146),USE(?Browse:1),HVSCROLL,FORMAT('80R(2)|M~Id viaje~C(0)@N_20_@141' & |
  'R(2)|M~Procedencia~C(0)@s50@128L(2)|M~Transportista~L(0)@s50@200L(2)|M~Proveedor~L(0' & |
  ')@s50@32L(2)|M~Id Cupo~@P<<<<<<<<<<<<P@60L(2)|M~nro remito~@P####-########P@80R(2)|M' & |
  '~Peso~C(0)@n-20.0@44R(2)|M~Cap. Tanque~C(0)@N-_10.@80R(2)|M~Fecha carga~C(0)@d6@'),FROM(Queue:Browse:1), |
  IMM,MSG('Browsing the Viajes file')
                       BUTTON,AT(449,203,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(478,203,25,25),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Muestra vent' & |
  'ana de ayuda'),STD(STD:Help),TIP('Muestra ventana de ayuda')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
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
  GlobalErrors.SetProcedureName('BrowseViajesRelacionadosCupos')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('via:id_programacion',via:id_programacion)          ! Added by: BrowseBox(ABC)
  BIND('glo:id_programacion',glo:id_programacion)          ! Added by: BrowseBox(ABC)
  BIND('via:id_viaje',via:id_viaje)                        ! Added by: BrowseBox(ABC)
  BIND('via:nro_remito',via:nro_remito)                    ! Added by: BrowseBox(ABC)
  BIND('via:cap_tk_camion',via:cap_tk_camion)              ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Viajes.SetOpenRelated()
  Relate:Viajes.Open                                       ! File Viajes used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Viajes,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,via:VIA_FK_PROGRAMACION)              ! Add the sort order for via:VIA_FK_PROGRAMACION for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,via:id_programacion,,BRW1)     ! Initialize the browse locator using  using key: via:VIA_FK_PROGRAMACION , via:id_programacion
  BRW1.SetFilter('(via:id_programacion = glo:id_programacion)') ! Apply filter expression to browse
  BRW1.AddField(via:id_viaje,BRW1.Q.via:id_viaje)          ! Field via:id_viaje is a hot field or requires assignment from browse
  BRW1.AddField(pro1:procedencia,BRW1.Q.pro1:procedencia)  ! Field pro1:procedencia is a hot field or requires assignment from browse
  BRW1.AddField(tra:transportista,BRW1.Q.tra:transportista) ! Field tra:transportista is a hot field or requires assignment from browse
  BRW1.AddField(pro:proveedor,BRW1.Q.pro:proveedor)        ! Field pro:proveedor is a hot field or requires assignment from browse
  BRW1.AddField(via:id_programacion,BRW1.Q.via:id_programacion) ! Field via:id_programacion is a hot field or requires assignment from browse
  BRW1.AddField(via:nro_remito,BRW1.Q.via:nro_remito)      ! Field via:nro_remito is a hot field or requires assignment from browse
  BRW1.AddField(via:peso,BRW1.Q.via:peso)                  ! Field via:peso is a hot field or requires assignment from browse
  BRW1.AddField(via:cap_tk_camion,BRW1.Q.via:cap_tk_camion) ! Field via:cap_tk_camion is a hot field or requires assignment from browse
  BRW1.AddField(via:fecha_carga_DATE,BRW1.Q.via:fecha_carga_DATE) ! Field via:fecha_carga_DATE is a hot field or requires assignment from browse
  BRW1.AddField(pro1:id_procedencia,BRW1.Q.pro1:id_procedencia) ! Field pro1:id_procedencia is a hot field or requires assignment from browse
  BRW1.AddField(tra:id_transportista,BRW1.Q.tra:id_transportista) ! Field tra:id_transportista is a hot field or requires assignment from browse
  BRW1.AddField(pro:id_proveedor,BRW1.Q.pro:id_proveedor)  ! Field pro:id_proveedor is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseViajesRelacionadosCupos',QuickWindow) ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Viajes.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseViajesRelacionadosCupos',QuickWindow) ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
GetDateServer        PROCEDURE                             ! Declare Procedure

  CODE
   !Obtener fecha del servidor
    sql{PROP:SQL} = 'SELECT CONVERT(VARCHAR(10), GETDATE(), 103)'
    NEXT(sql)
   
    RETURN DEFORMAT(SQL:campo1,@D6)
!!! <summary>
!!! Generated from procedure template - Window
!!! Window
!!! </summary>
TransferirProducto PROCEDURE 

L:id_planta_origen   LONG,NAME('"ID_PLANTA"')              !
L:strSQL             CSTRING(256)                          !
L:error              BYTE                                  !
L:id_planta_destino  LONG,NAME('"ID_PLANTA"')              !
L:id_localidad       LONG                                  !
L:cantidad           DECIMAL(15)                           !
L:fecha_transferencia DATE                                 !
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('TransferenciadeProducto'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(418,290,37,31),USE(?Ok),LEFT,ICON('Aceptar.ICO'),FLAT,MSG('Acceptar operación'), |
  TIP('Acceptar operación'),TRN
                       BUTTON,AT(467,290,37,31),USE(?Cancel),LEFT,ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación'),TRN
                       PROMPT('Localidad:'),AT(49,73),USE(?L:id_localidad:Prompt),TRN
                       ENTRY(@n-14),AT(103,73,21,10),USE(GLO:localidad_id),RIGHT(1),REQ
                       BUTTON,AT(129,73,12,12),USE(?CallLookupLocalidad),ICON('lupita.ico'),FLAT,TRN
                       STRING(@s20),AT(145,76,86,10),USE(Loc:Localidad),TRN
                       PROMPT('Planta Origen:'),AT(49,101),USE(?L:id_planta_origen:Prompt),TRN
                       ENTRY(@P<<P),AT(103,102,21,10),USE(L:id_planta_origen),OVR,REQ
                       PROMPT('Planta Destino:'),AT(49,130),USE(?L:id_planta_destino:Prompt),TRN
                       ENTRY(@P<<P),AT(103,129,21,10),USE(L:id_planta_destino),OVR,REQ
                       BUTTON,AT(129,101,12,12),USE(?CallLookupPlantaOrigen),ICON('lupita.ico'),FLAT,TRN
                       BUTTON,AT(129,129,12,12),USE(?CallLookupPlantaDestino),ICON('lupita.ico'),FLAT,TRN
                       STRING(@P<<P),AT(185,104,17,9),USE(pla:NRO_PLANTA),TRN
                       STRING(@P<<P),AT(186,130,17,9),USE(pla1:NRO_PLANTA,,?pla1:NRO_PLANTA:2),TRN
                       PROMPT('Cantidad:'),AT(49,157),USE(?L:cantidad:Prompt),TRN
                       ENTRY(@n-20.0),AT(103,156,60,10),USE(L:cantidad),DECIMAL(12)
                       PROMPT('Fecha:'),AT(49,177),USE(?L:fecha_transferencia:Prompt),TRN
                       ENTRY(@d6),AT(103,177,60,10),USE(L:fecha_transferencia)
                       STRING('Transferencia de Producto entre Plantas'),AT(168,16,176),USE(?STRING1),FONT('Arial', |
  10,,FONT:bold+FONT:italic+FONT:underline,CHARSET:ANSI),TRN
                       BUTTON('...'),AT(168,169,25,24),USE(?BotonSeleccionFecha),ICON('calen.ico'),FLAT,TRN
                       PROMPT('Nro Planta:'),AT(145,103),USE(?L:id_planta_origen:Prompt:2),TRN
                       PROMPT('Nro Planta:'),AT(145,129),USE(?L:id_planta_origen:Prompt:3),TRN
                       PROMPT('Existencia Actual:'),AT(294,102),USE(?L:id_planta_origen:Prompt:4),TRN
                       PROMPT('Existencia Actual:'),AT(294,127),USE(?L:id_planta_origen:Prompt:5),TRN
                       STRING(@N20_),AT(355,127,83,9),USE(pla1:EXISTENCIA_ACTUAL),TRN
                       STRING(@N20_),AT(355,102,100,13),USE(pla:EXISTENCIA_ACTUAL),TRN
                       STRING(@N20_),AT(246,102,44,10),USE(pla:CAPACIDAD),RIGHT(20),TRN
                       STRING(@N20_),AT(247,127,43,10),USE(pla1:CAPACIDAD),RIGHT(20),TRN
                       PROMPT('Capacidad:'),AT(206,128),USE(?L:id_planta_origen:Prompt:6),TRN
                       PROMPT('Capacidad:'),AT(206,103),USE(?L:id_planta_origen:Prompt:7),TRN
                       BUTTON,AT(369,290,37,31),USE(?Help),LEFT,KEY(MouseRight2),ICON('WAHELP.ico'),FLAT,HLP('Transferen' & |
  'ciadeProducto'),MSG('See this window help'),STD(STD:Help),TIP('See this window help'),TRN
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
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
TransferirProductoOrigen  ROUTINE
    CLEAR(exi:Record)
    error#=0   
    L:strSQL = 'SELECT  TOP 1 ID_EXISTENCIA FROM EXISTENCIAS WHERE ID_PLANTA='&L:id_planta_origen&' ORDER BY FECHA_LECTURA DESC'
    SQL{PROP:SQL}= clip(L:strSQL)
    
    !MESSAGE(L:strSQL)
    NEXT(SQL)
  
    
    ! Actualizo la planta de Origen
    
  
    
    exi1:id_existencia = SQL:campo1
    IF Access:ExistenciasAlias1.Fetch(exi1:PK__EXISTENC__36B12243) = Level:Benign  
        ! MESSAGE('existencia actual:'&exi1:existencia&' - existencia planta:'&pla:EXISTENCIA_ACTUAL)
           
        IF exi1:existencia <> pla:EXISTENCIA_ACTUAL
            MESSAGE('Existe una inconsistencia en la existencia actual de la planta con la ultima existencia','Atención',ICON:Exclamation)
            error# = 1
        ELSE
            
          exi:id_localidad = GLO:localidad_id
          exi:id_planta = pla:ID_PLANTA  
          exi:capacidad_planta = pla:CAPACIDAD   
          exi:consumo =  L:cantidad  
          exi:FECHA_LECTURA_DATE = L:fecha_transferencia
         
     
          exi:existencia_anterior =exi1:existencia
          exi:id_existencia_anterior =exi1:id_existencia
          exi:existencia =exi1:existencia-L:cantidad
          exi:porc_existencia = exi:existencia *100/exi:capacidad_planta         
          exi:autonomia =exi:existencia/ exi:consumo
       
    
          IF ACCESS:Existencias.Insert() <> Level:Benign
              MESSAGE('Error en la insercion de existencia de origen')
              error# = 1
          ELSE
              !MESSAGE('Se inserto la existencia nro:'&exi:id_existencia)
          END
        END
        

    ELSE
        message(' No se pudo encontrar la existencia anterior de la planta de origen')
        ERROR# = 1
    END  
    
    ! Actualizo Existencia actual en la planta de origen         
    IF error# = 0      
        pla:ID_PLANTA = L:id_planta_origen
        IF Access:Plantas.Fetch(pla:PK__plantas__7D439ABD) = Level:Benign
            pla:EXISTENCIA_ACTUAL = pla:EXISTENCIA_ACTUAL - L:cantidad
            pla:ULTIMA_DESCARGA = 0
            
            IF Access:Plantas.Update() <> Level:Benign
                MESSAGE('Error en la actualizacion en la tabla Plantas: '&fileerror())
                error# = 1
            ELSE
                !MESSAGE('Se actualizó existencia en la planta nro:'&pla:ID_PLANTA)
            END
        ELSE
            MESSAGE('No se encontro la planta de origen')
            error# = 1
        END
     END
   ! Actualizo Stock de Planta
     IF error# = 0
        STK:id_localidad = exi:id_localidad
        STK:id_planta = exi:id_planta
        STK:fecha_DATE = exi:FECHA_LECTURA_DATE
        STK:fecha_TIME = exi:FECHA_LECTURA_TIME    
        STK:tipo='Transferencia'
        STK:producto = exi:consumo *(-1)
        STK:existencia = exi:existencia
        
        IF     access:PlantasStock.insert() <> Level:Benign
            message('Error en la inserción en la tabla PlantasStock')
            error# =1
        ELSE
            exi:id_stock = STK:id_stock
            IF Access:Existencias.update() <> Level:Benign
                MESSAGE('Error en la actualizacion de existencia')
            ELSE
               ! MESSAGE('Se actualizo la existencia nro:'&exi:id_existencia)
            END
            
        END
     END
  L:error = error#
  EXIT
    
        

    
TransferirProductoDestino   ROUTINE
!    Actualizo planta Destino
    IF error# = 0
         SQL{PROP:SQL}='SELECT  TOP 1 ID_EXISTENCIA FROM EXISTENCIAS WHERE ID_PLANTA='&L:id_planta_destino&' ORDER BY FECHA_LECTURA DESC'
         
         NEXT(SQL)
         !message('Existencia anterior:'&SQL:campo1)
         
         CLEAR(exi:Record)
         exi1:id_existencia = SQL:campo1
        
        IF Access:ExistenciasAlias1.Fetch(exi1:PK__EXISTENC__36B12243) = Level:Benign
            IF exi1:existencia <> pla1:EXISTENCIA_ACTUAL
                MESSAGE('Existe una inconsistencia en la existencia actual de la planta con la ultima existencia','Atención',ICON:Exclamation)
                error# = 1
            ELSE
                exi:id_planta = pla1:ID_PLANTA
                exi:capacidad_planta = pla1:CAPACIDAD  
                exi:id_localidad = GLO:localidad_id    
                exi:existencia_anterior =exi1:existencia
                exi:id_existencia_anterior =exi1:id_existencia
                exi:existencia =exi1:existencia+L:cantidad
                exi:ultima_descarga = L:cantidad
                exi:porc_existencia = exi:existencia *100/exi:capacidad_planta
                exi:consumo = 0     
                exi:autonomia =exi:existencia/ 0.0001
                exi:FECHA_LECTURA_DATE = L:fecha_transferencia               
                exi:id_descarga_ultima = 0
               
                IF ACCESS:Existencias.Insert() <> Level:Benign
                    MESSAGE('Error en la insercion de existencia de destino')
                    error# = 1
                ELSE
                    !MESSAGE('Se inserto la existencia destino nro: '&exi:id_existencia)
                END
            END
        END
        
    END
    ! Actualizo la planta destino
    
    IF error# = 0      
        pla:ID_PLANTA = L:id_planta_destino
        IF Access:Plantas.Fetch(pla:PK__plantas__7D439ABD) = Level:Benign
            pla:EXISTENCIA_ACTUAL = exi:existencia
            pla:ULTIMA_DESCARGA = L:cantidad
            
            
            IF Access:Plantas.Update() <> Level:Benign
                MESSAGE('Error en la actualizacion en la tabla Plantas: '&fileerror())
                error# = 1
            ELSE
                !MESSAGE('Se actualizó existencia en la planta nro:'&pla:ID_PLANTA)
            END
        ELSE
            MESSAGE('No se encontro la planta de origen')
            error# = 1
        END
     END
    
    
    
    ! Actualizo stock
    IF error# = 0
            STK:id_localidad = exi:id_localidad
            STK:id_planta = exi:id_planta
            STK:fecha_DATE = exi:FECHA_LECTURA_DATE
            STK:tipo='Transferencia'
            STK:producto = L:cantidad
            STK:existencia = exi:existencia
            IF     access:PlantasStock.insert() <> Level:Benign
                message('Error en la transaccion en la tabla PlantasStock')
                error# = 1
            ELSE
                !MESSAGE('Se actualizo el stock nro:'&STK:id_stock)
                exi:id_stock = stk:id_stock
                
                IF ACCESS:existencias.Update() <> Level:Benign
                    MESSAGE('Error en la insercion de existencia de origen')
                    error# =1
                ELSE
                   ! MESSAGE('Se Actualizo la existencia nro:'&exi:id_existencia)
                END 
            END
        
    ELSE
            MESSAGE('No se encontro la existencia de la planta destino')
    END
    
    
    
    
   L:error = error#  
  EXIT
    

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('TransferirProducto')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Ok
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Ok,RequestCancelled)                    ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Ok,RequestCompleted)                    ! Add the close control to the window manger
  END
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Descargas.SetOpenRelated()
  Relate:Descargas.Open                                    ! File Descargas used by this procedure, so make sure it's RelationManager is open
  Relate:ExistenciasAlias1.Open                            ! File ExistenciasAlias1 used by this procedure, so make sure it's RelationManager is open
  Relate:PlantasAlias.Open                                 ! File PlantasAlias used by this procedure, so make sure it's RelationManager is open
  Relate:PlantasStock.Open                                 ! File PlantasStock used by this procedure, so make sure it's RelationManager is open
  Relate:SQL.Open                                          ! File SQL used by this procedure, so make sure it's RelationManager is open
  Access:Existencias.UseFile                               ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:Plantas.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:Localidades_GLP.UseFile                           ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
   L:fecha_transferencia = GetDateServer()
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('TransferirProducto',QuickWindow)           ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Descargas.Close
    Relate:ExistenciasAlias1.Close
    Relate:PlantasAlias.Close
    Relate:PlantasStock.Close
    Relate:SQL.Close
  END
  IF SELF.Opened
    INIMgr.Update('TransferirProducto',QuickWindow)        ! Save window data to non-volatile store
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
      SelectPlantas
      SelectPlantasAlias
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
    CASE ACCEPTED()
    OF ?Ok
      !Validar Datos
      IF glo:LOCALIDAD_ID = 0
          MESSAGE('debe ingresar una Localidad','Atención',ICON:Exclamation)
          Select(?GLO:localidad_id)
          CYCLE
        
      END
      
      IF L:id_planta_origen = 0 
          MESSAGE('Desde ingresar la la planta de origen','Atención',ICON:Exclamation)
          Select(?L:id_planta_origen)
          CYCLE
      END
      
      IF L:id_planta_destino = 0 
          MESSAGE('Desde ingresar la la planta de destino','Atención',ICON:Exclamation)
          Select(?L:id_planta_origen)
          CYCLE
      END
      
      IF L:id_planta_origen = L:id_planta_destino
          MESSAGE('La planta de origen debe ser distinta a la planta de destino','Atención',ICON:Exclamation)
          Select(?L:id_planta_origen)
          CYCLE    
      END
      
      IF pla1:ID_LOCALIDAD <>pla:ID_LOCALIDAD
          MESSAGE('Las plantas tienen que ser de la misma localidad','Atención',ICON:Exclamation)
          Select(?L:id_planta_origen)
          CYCLE
      END
      
      
      IF L:cantidad <= 0
          MESSAGE('Debe ingresar una cantidad mayor que 0','Atención',ICON:Exclamation)
          Select(?L:cantidad)
          CYCLE
      END
      
      IF pla:EXISTENCIA_ACTUAL <=0
          MESSAGE('La planta no tiene producto disponible','Atención',ICON:Exclamation)
          Select(?L:id_planta_origen)
          CYCLE
      END 
      
      IF pla1:CAPACIDAD <= pla1:EXISTENCIA_ACTUAL
          MESSAGE( 'La planta de destino esta en su capacidad maxima.No se puede ingresar mas producto','Atención',ICON:Exclamation)
          Select(?L:cantidad)
          CYCLE
      END
      
      
      !IF pla:EXISTENCIA_ACTUAL < pla:CAPACIDAD - L:cantidad  
      !    MESSAGE( 'No se puede transferir producto mayor a la existencia actual de la planta origen','Atención',ICON:Exclamation)
      !    Select(?L:cantidad)
      !    CYCLE
      !END
      
      
      !Verificar la existencia de la planta de destino
      
      IF pla1:EXISTENCIA_ACTUAL+L:cantidad > pla1:CAPACIDAD
           MESSAGE('No se puede transferir producto mayor a la capacidad disponible de la planta de destino','Atención',ICON:Exclamation)
          Select(?L:cantidad)
          CYCLE
      END
      
      IF MESSAGE('¿Desea Tranferir producto?','Atención',ICON:Question,BUTTON:YES+BUTTON:NO,BUTTON:YES) = BUTTON:YES
          LOGOUT(1,Existencias,PlantasStock,Plantas)
           DO TransferirProductoOrigen
              IF L:error = 0
                  DO TransferirProductoDestino
                  IF L:error= 0
                      MESSAGE('Se realizo la transferencia de producto','Atención',ICON:Exclamation)
                  ELSE
                      MESSAGE('No se pudo realizar la transferencia','Atención',ICON:Exclamation)
                      ROLLBACK()
                  END
              ELSE
                  ROLLBACK()
              END
          COMMIT
          
      END
    OF ?L:id_planta_origen
          DISPLAY()
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
    OF ?L:id_planta_origen
      IF L:id_planta_origen OR ?L:id_planta_origen{PROP:Req}
        pla:ID_PLANTA = L:id_planta_origen
        IF Access:Plantas.TryFetch(pla:PK__plantas__7D439ABD)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            L:id_planta_origen = pla:ID_PLANTA
            GLO:id_planta = pla:ID_PLANTA
          ELSE
            CLEAR(GLO:id_planta)
            SELECT(?L:id_planta_origen)
            CYCLE
          END
        ELSE
          GLO:id_planta = pla:ID_PLANTA
        END
      END
      ThisWindow.Reset(1)
    OF ?L:id_planta_destino
      IF L:id_planta_destino OR ?L:id_planta_destino{PROP:Req}
        pla1:ID_PLANTA = L:id_planta_destino
        IF Access:PlantasAlias.TryFetch(pla1:PK__plantas__7D439ABD)
          IF SELF.Run(3,SelectRecord) = RequestCompleted
            L:id_planta_destino = pla1:ID_PLANTA
          ELSE
            SELECT(?L:id_planta_destino)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupPlantaOrigen
      ThisWindow.Update
      pla:ID_PLANTA = L:id_planta_origen
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        L:id_planta_origen = pla:ID_PLANTA
        GLO:id_planta = pla:ID_PLANTA
      END
      ThisWindow.Reset(1)
    OF ?CallLookupPlantaDestino
      ThisWindow.Update
      pla1:ID_PLANTA = L:id_planta_destino
      IF SELF.Run(3,SelectRecord) = RequestCompleted
        L:id_planta_destino = pla1:ID_PLANTA
      END
      ThisWindow.Reset(1)
    OF ?BotonSeleccionFecha
      ThisWindow.Update
      CHANGE(?L:fecha_transferencia,bigfec(CONTENTS(?L:fecha_transferencia)))
      !DO RefreshWindow
    END
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
  CASE FIELD()
  OF ?L:id_planta_origen
        IF GlobalResponse = RequestCompleted
              !ThisWindow.Reset(TRUE)
              DISPLAY()
          END
  END
  ReturnValue = PARENT.TakeFieldEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
SelectPlantasAlias PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(PlantasAlias)
                       PROJECT(pla1:ID_PLANTA)
                       PROJECT(pla1:NRO_PLANTA)
                       PROJECT(pla1:CAPACIDAD)
                       PROJECT(pla1:EXISTENCIA_ACTUAL)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
pla1:ID_PLANTA         LIKE(pla1:ID_PLANTA)           !List box control field - type derived from field
pla1:NRO_PLANTA        LIKE(pla1:NRO_PLANTA)          !List box control field - type derived from field
pla1:CAPACIDAD         LIKE(pla1:CAPACIDAD)           !List box control field - type derived from field
pla1:EXISTENCIA_ACTUAL LIKE(pla1:EXISTENCIA_ACTUAL)   !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,260,260),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('SelectPlantasAlias'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(43,61,178,113),USE(?Browse:1),HVSCROLL,FORMAT('40L(2)|M~Id Planta~@P<<<<P@44L(2' & |
  ')|M~Nro planta~@P<<<<P@40D(22)|M~Capacidad~C(0)@N20_@44D(22)|M~Existencia~C(0)@N-10.`2@'), |
  FROM(Queue:Browse:1),IMM,MSG('Browsing the PlantasAlias file')
                       BUTTON,AT(32,211,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(196,211,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       STRING('Seleccione planta de destino'),AT(71,19),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       BOX,AT(22,39,211,162),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BOX,AT(22,206,211,36),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
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
  GlobalErrors.SetProcedureName('SelectPlantasAlias')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('pla1:ID_LOCALIDAD',pla1:ID_LOCALIDAD)              ! Added by: BrowseBox(ABC)
  BIND('glo:localidad_id',glo:localidad_id)                ! Added by: BrowseBox(ABC)
  BIND('pla1:ID_PLANTA',pla1:ID_PLANTA)                    ! Added by: BrowseBox(ABC)
  BIND('GLO:id_planta',GLO:id_planta)                      ! Added by: BrowseBox(ABC)
  BIND('pla1:NRO_PLANTA',pla1:NRO_PLANTA)                  ! Added by: BrowseBox(ABC)
  BIND('pla1:EXISTENCIA_ACTUAL',pla1:EXISTENCIA_ACTUAL)    ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:PlantasAlias.Open                                 ! File PlantasAlias used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:PlantasAlias,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,pla1:PK__plantas__7D439ABD)           ! Add the sort order for pla1:PK__plantas__7D439ABD for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,pla1:ID_PLANTA,,BRW1)          ! Initialize the browse locator using  using key: pla1:PK__plantas__7D439ABD , pla1:ID_PLANTA
  BRW1.SetFilter('((pla1:ID_LOCALIDAD =glo:localidad_id) AND (pla1:ID_PLANTA <<> GLO:id_planta))') ! Apply filter expression to browse
  BRW1.AddField(pla1:ID_PLANTA,BRW1.Q.pla1:ID_PLANTA)      ! Field pla1:ID_PLANTA is a hot field or requires assignment from browse
  BRW1.AddField(pla1:NRO_PLANTA,BRW1.Q.pla1:NRO_PLANTA)    ! Field pla1:NRO_PLANTA is a hot field or requires assignment from browse
  BRW1.AddField(pla1:CAPACIDAD,BRW1.Q.pla1:CAPACIDAD)      ! Field pla1:CAPACIDAD is a hot field or requires assignment from browse
  BRW1.AddField(pla1:EXISTENCIA_ACTUAL,BRW1.Q.pla1:EXISTENCIA_ACTUAL) ! Field pla1:EXISTENCIA_ACTUAL is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectPlantasAlias',QuickWindow)           ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:PlantasAlias.Close
  END
  IF SELF.Opened
    INIMgr.Update('SelectPlantasAlias',QuickWindow)        ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select:2
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! Costos_GLP
!!! </summary>
BrowsecostosGLP PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Costos_GLP)
                       PROJECT(Cos:id_costos)
                       PROJECT(Cos:fecha_vigencia_DATE)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
Cos:id_costos          LIKE(Cos:id_costos)            !List box control field - type derived from field
Cos:fecha_vigencia_DATE LIKE(Cos:fecha_vigencia_DATE) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,340,209),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowsecostosGLP'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(8,30,324,113),USE(?Browse:1),HVSCROLL,FORMAT('64R(2)|M~id costos~C(0)@n-14@80R(' & |
  '2)|M~fecha vigencia DATE~C(0)@d17@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the Cost' & |
  'os_GLP file')
                       BUTTON,AT(96,148,25,25),USE(?View:2),ICON('Ver.ico'),FLAT,MSG('Visualiza el registro'),TIP('Visualiza ' & |
  'el registro')
                       BUTTON,AT(125,148,25,25),USE(?Insert:3),ICON('Insertar.ico'),FLAT,MSG('Inserta un Registro'), |
  TIP('Inserta un Registro')
                       BUTTON,AT(154,148,25,25),USE(?Change:3),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Modifica e' & |
  'l registro'),TIP('Modifica el registro')
                       BUTTON,AT(183,148,25,25),USE(?Delete:3),ICON('Eliminar.ICO'),FLAT,MSG('Elimina un registro'), |
  TIP('Elimina un registro')
                       BUTTON,AT(282,180,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(311,180,25,25),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Muestra vent' & |
  'ana de ayuda'),STD(STD:Help),TIP('Muestra ventana de ayuda')
                       STRING('Costos GLP'),AT(151,10),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline)
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
SetAlerts              PROCEDURE(),DERIVED
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
  GlobalErrors.SetProcedureName('BrowsecostosGLP')
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
  Relate:Costos_GLP.Open                                   ! File Costos_GLP used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Costos_GLP,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,Cos:PK_COSTO)                         ! Add the sort order for Cos:PK_COSTO for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,Cos:id_costos,,BRW1)           ! Initialize the browse locator using  using key: Cos:PK_COSTO , Cos:id_costos
  BRW1.AddField(Cos:id_costos,BRW1.Q.Cos:id_costos)        ! Field Cos:id_costos is a hot field or requires assignment from browse
  BRW1.AddField(Cos:fecha_vigencia_DATE,BRW1.Q.Cos:fecha_vigencia_DATE) ! Field Cos:fecha_vigencia_DATE is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowsecostosGLP',QuickWindow)              ! Restore window settings from non-volatile store
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
    Relate:Costos_GLP.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowsecostosGLP',QuickWindow)           ! Save window data to non-volatile store
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
    updateCostosGLP
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


BRW1.SetAlerts PROCEDURE

  CODE
  SELF.EditViaPopup = False
  PARENT.SetAlerts


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

