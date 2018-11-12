

   MEMBER('existencias.clw')                               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('BRWEXT.INC'),ONCE
   INCLUDE('svgraph.inc'),ONCE

                     MAP
                       INCLUDE('EXISTENCIAS011.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('EXISTENCIAS002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS007.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
ConciliacionRemitos PROCEDURE 

L:comprobante_id     LONG                                  !
L:id_viaje           LONG,NAME('"id_viaje"')               !
L:factura            STRING(30)                            !
L:id_proveedor       LONG                                  !Identificador interno del proveedor de producto
L:total_remitos      DECIMAL(9,2)                          !
L:total_conciliado   DECIMAL(9,2)                          !
L:nro_remito         STRING(51),NAME('"nro_remito"')       !
QFacturasViajes      QUEUE,PRE(QF)                         !
id_viaje             LONG,NAME('"id_viaje"')               !
comprobante_id       LONG                                  !
numero_comprobante   CSTRING(21)                           !
letra_comprobante    CSTRING(2)                            !
nro_remito           STRING(51),NAME('"nro_remito"')       !
importe_producto     DECIMAL(9,2)                          !
fecha_carga          DATE                                  !
peso                 DECIMAL(15)                           !
                     END                                   !
QRemitos             QUEUE,PRE(QR)                         !
id_viaje             LONG,NAME('"id_viaje"')               !
peso                 DECIMAL(15)                           !
fecha_carga          DATE                                  !
nro_remito           STRING(51),NAME('"nro_remito"')       !
importe_producto     DECIMAL(9,2)                          !
                     END                                   !
BRW5::View:Browse    VIEW(Viajes_aux)
                       PROJECT(via3:id_viaje)
                       PROJECT(via3:id_proveedor)
                       PROJECT(via3:nro_remito)
                       PROJECT(via3:fecha_carga_DATE)
                       PROJECT(via3:peso)
                       PROJECT(via3:importe_producto)
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?List:3
via3:id_viaje          LIKE(via3:id_viaje)            !List box control field - type derived from field
via3:id_proveedor      LIKE(via3:id_proveedor)        !List box control field - type derived from field
via3:nro_remito        LIKE(via3:nro_remito)          !List box control field - type derived from field
via3:fecha_carga_DATE  LIKE(via3:fecha_carga_DATE)    !List box control field - type derived from field
via3:peso              LIKE(via3:peso)                !List box control field - type derived from field
via3:importe_producto  LIKE(via3:importe_producto)    !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
Window               WINDOW,AT(,,523,349),FONT('Microsoft Sans Serif',8,,FONT:regular),DOUBLE,GRAY,MDI,SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON(' '),AT(412,295,27,23),USE(?OkButton),LEFT,ICON('aceptar.ico'),DEFAULT,FLAT,STD(STD:Close), |
  TRN
                       BUTTON(' '),AT(453,295,29,23),USE(?CancelButton),LEFT,ICON('cancelar.ico'),FLAT,STD(STD:Close), |
  TRN
                       BUTTON,AT(151,66,12,12),USE(?CallLookup),ICON('Lupita.ico'),FLAT,TRN
                       ENTRY(@n-14),AT(96,66,51),USE(L:comprobante_id)
                       PROMPT('Proveedor:'),AT(59,47),USE(?L:id_proveedor:Prompt),TRN
                       ENTRY(@P<<<<<P),AT(96,47,29,10),USE(L:id_proveedor),RIGHT(1),OVR,MSG('Identificador int' & |
  'erno del proveedor de producto'),TIP('Identificador interno del proveedor de producto')
                       BUTTON,AT(151,44,12,12),USE(?CallLookup:2),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@s50),AT(167,47,147),USE(pro:proveedor),TRN
                       PROMPT('ID Proveedor:'),AT(371,28),USE(?glo:id_proveedor:Prompt)
                       ENTRY(@P<<<<<P),AT(422,27,60,10),USE(GLO:id_proveedor),RIGHT(1),OVR,MSG('Identificador ' & |
  'interno del proveedor de producto'),TIP('Identificador interno del proveedor de producto')
                       PROMPT('Factura:'),AT(59,70),USE(?L:id_proveedor:Prompt:2),TRN
                       BUTTON,AT(371,106,29,23),USE(?BtnBuscarRemitos),ICON('seleccionar.ICO'),FLAT,TRN
                       STRING(@s30),AT(167,66,147),USE(L:factura),TRN
                       STRING(@n-17.2),AT(390,66,68,10),USE(com:importe),TRN
                       PROMPT('Importe:'),AT(360,66),USE(?L:id_proveedor:Prompt:3),TRN
                       STRING(@n-13.2),AT(167,262,59,11),USE(L:total_remitos),TRN
                       STRING(@n-13.2),AT(440,250,53,11),USE(L:total_conciliado),TRN
                       PROMPT('Buscar:'),AT(41,28),USE(?L:id_proveedor:Prompt:4),TRN
                       ENTRY(@P####-########P),AT(69,27,64,10),USE(L:nro_remito)
                       BUTTON,AT(137,23,17,14),USE(?BtnBuscarRemito),FONT(,,,FONT:regular),ICON('lupita.ico'),FLAT, |
  TRN
                       STRING('Conciliación de Producto'),AT(209,10),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline), |
  TRN
                       LIST,AT(57,147,191,100),USE(?List:3),FORMAT('32D(2)|M~Id viaje~L(0)@N_20_@40L(2)|M~ID P' & |
  'roveedor~L(1)@P<<<<<<<<<<P@40L(2)|M~nro remito~L(0)@P####-########P@40L(2)|M~Fecha c' & |
  'arga~L(0)@d6@84L(2)|M~Peso~D(12)@n-20.0@56L(2)|M~importe producto~D(12)@n-13.2@'),FROM(Queue:Browse:2), |
  IMM
                       BUTTON,AT(59,129,16,14),USE(?Browse:Top),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page')
                       BUTTON,AT(77,129,16,14),USE(?Browse:PageUp),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the Prior Page')
                       BUTTON,AT(96,129,16,14),USE(?Browse:Up),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record')
                       BUTTON,AT(115,129,16,14),USE(?Browse:Down),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record')
                       BUTTON,AT(133,129,16,14),USE(?Browse:PageDown),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page')
                       BUTTON,AT(152,129,16,14),USE(?Browse:Bottom),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page')
                       PROMPT('Id viaje:'),AT(60,92),USE(?L:id_viaje:Prompt)
                       ENTRY(@N_20_),AT(96,93,37,10),USE(L:id_viaje)
                       BUTTON('...'),AT(137,92,12,12),USE(?CallLookup:3)
                       STRING(@P####-########P),AT(167,92,147),USE(L:nro_remito,,?L:nro_remito:3),TRN
                       BUTTON('Button1'),AT(243,88),USE(?BUTTON1)
                     END

BRW5::Toolbar        BrowseToolbarClass
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW5                 CLASS(BrowseClass)                    ! Browse using ?List:3
Q                      &Queue:Browse:2                !Reference to browse queue
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
  GlobalErrors.SetProcedureName('ConciliacionRemitos')
  GLO:LowLimit = 0
  GLO:HighLimit = 0
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OkButton
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('via3:id_viaje',via3:id_viaje)                      ! Added by: BrowseBox(ABC)
  BIND('via3:nro_remito',via3:nro_remito)                  ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  BRW5::Toolbar.Init(SELF,BRW5)
  BRW5::Toolbar.InitBrowse(0, 0, 0, 0)
  BRW5::Toolbar.InitVCR(?Browse:Top, ?Browse:Bottom, ?Browse:PageUp, ?Browse:PageDown, ?Browse:Up, ?Browse:Down, 0)
  BRW5::Toolbar.InitMisc(0, 0)
  SELF.AddItem(BRW5::Toolbar.WindowComponent)
  Relate:Proveedores.SetOpenRelated()
  Relate:Proveedores.Open                                  ! File Proveedores used by this procedure, so make sure it's RelationManager is open
  Relate:Viajes_aux.Open                                   ! File Viajes_aux used by this procedure, so make sure it's RelationManager is open
  Relate:comprobantes.Open                                 ! File comprobantes used by this procedure, so make sure it's RelationManager is open
  Relate:viajes_anticipos.Open                             ! File viajes_anticipos used by this procedure, so make sure it's RelationManager is open
  Relate:viajes_facturas.Open                              ! File viajes_facturas used by this procedure, so make sure it's RelationManager is open
  Access:Viajes.UseFile                                    ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW5.Init(?List:3,Queue:Browse:2.ViewPosition,BRW5::View:Browse,Queue:Browse:2,Relate:Viajes_aux,SELF) ! Initialize the browse manager
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  BRW5.Q &= Queue:Browse:2
  BRW5.RetainRow = 0
  BRW5.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW5.AddField(via3:id_viaje,BRW5.Q.via3:id_viaje)        ! Field via3:id_viaje is a hot field or requires assignment from browse
  BRW5.AddField(via3:id_proveedor,BRW5.Q.via3:id_proveedor) ! Field via3:id_proveedor is a hot field or requires assignment from browse
  BRW5.AddField(via3:nro_remito,BRW5.Q.via3:nro_remito)    ! Field via3:nro_remito is a hot field or requires assignment from browse
  BRW5.AddField(via3:fecha_carga_DATE,BRW5.Q.via3:fecha_carga_DATE) ! Field via3:fecha_carga_DATE is a hot field or requires assignment from browse
  BRW5.AddField(via3:peso,BRW5.Q.via3:peso)                ! Field via3:peso is a hot field or requires assignment from browse
  BRW5.AddField(via3:importe_producto,BRW5.Q.via3:importe_producto) ! Field via3:importe_producto is a hot field or requires assignment from browse
  INIMgr.Fetch('ConciliacionRemitos',Window)               ! Restore window settings from non-volatile store
  BRW5.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Proveedores.Close
    Relate:Viajes_aux.Close
    Relate:comprobantes.Close
    Relate:viajes_anticipos.Close
    Relate:viajes_facturas.Close
  END
  IF SELF.Opened
    INIMgr.Update('ConciliacionRemitos',Window)            ! Save window data to non-volatile store
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
      selectFacturas
      SelectProveedores
      SelectViajesDescargados
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
    OF ?CallLookup
      ThisWindow.Update
      com:comprobante_id = L:comprobante_id
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        L:comprobante_id = com:comprobante_id
        L:factura = com:letra_comprobante&'-'&format(com:numero_comprobante,@P#####-########P)
      END
      ThisWindow.Reset(1)
    OF ?L:comprobante_id
      IF L:comprobante_id OR ?L:comprobante_id{PROP:Req}
        com:comprobante_id = L:comprobante_id
        IF Access:comprobantes.TryFetch(com:PK_COMPROBANTE)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            L:comprobante_id = com:comprobante_id
            L:factura = com:letra_comprobante&'-'&format(com:numero_comprobante,@P#####-########P)
          ELSE
            CLEAR(L:factura)
            SELECT(?L:comprobante_id)
            CYCLE
          END
        ELSE
          L:factura = com:letra_comprobante&'-'&format(com:numero_comprobante,@P#####-########P)
        END
      END
      ThisWindow.Reset(1)
    OF ?L:id_proveedor
      IF L:id_proveedor OR ?L:id_proveedor{PROP:Req}
        pro:id_proveedor = L:id_proveedor
        IF Access:Proveedores.TryFetch(pro:PK_proveedor)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            L:id_proveedor = pro:id_proveedor
            GLO:id_proveedor = pro:id_proveedor_contable
          ELSE
            CLEAR(GLO:id_proveedor)
            SELECT(?L:id_proveedor)
            CYCLE
          END
        ELSE
          GLO:id_proveedor = pro:id_proveedor_contable
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookup:2
      ThisWindow.Update
      pro:id_proveedor = L:id_proveedor
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        L:id_proveedor = pro:id_proveedor
        GLO:id_proveedor = pro:id_proveedor_contable
      END
      ThisWindow.Reset(1)
    OF ?BtnBuscarRemitos
      ThisWindow.Update
      !FREE(QRemitos)
      !IF L:id_proveedor <> 0
      !    L:total_remitos = 0
      !    
      !    
      !    SET(Viajes_aux)
      !    LOOP until access:Viajes_aux.next()
      !        access:Viajes_aux.DeleteRecord(0)
      !    END
      !    
      !    via:id_proveedor = L:id_proveedor
      !    SET(via:FK_PROVEEDOR,via:FK_PROVEEDOR)
      !    
      !    LOOP UNTIL access:viajes.Next() OR via:id_proveedor <> L:id_proveedor
      !        IF via:estado ='Descargado'
      !!            QR:id_viaje = via:id_viaje
      !!            QR:nro_remito = via:nro_remito
      !!
      !!            QR:importe_producto = via:importe_producto
      !!            QR:fecha_carga = via:fecha_carga_DATE
      !!            L:total_remitos += via:importe_producto
      !!            ADD(QRemitos)
      !            
      !            via3:record :=: via:record
      !            access:Viajes_aux.Insert()
      !            
      !        END       
      !        
      !        brw5.ResetFromFile()
      !        brw5.ResetFromBuffer()
      !        ThisWindow.Reset(true)
      !        
      !    END      
      !END
      !
      !DISPLAY()
      GLO:LowLimit = L:id_proveedor
      GLO:HighLimit = L:id_proveedor
      
    OF ?BtnBuscarRemito
      ThisWindow.Update
      IF  L:nro_remito<> 0
          GET(QRemitos,L:nro_remito)
      END
      DISPLAY()
    OF ?L:id_viaje
      IF L:id_viaje OR ?L:id_viaje{PROP:Req}
        via:id_viaje = L:id_viaje
        IF Access:Viajes.TryFetch(via:PK_viajes)
          IF SELF.Run(3,SelectRecord) = RequestCompleted
            L:id_viaje = via:id_viaje
          ELSE
            SELECT(?L:id_viaje)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookup:3
      ThisWindow.Update
      via:id_viaje = L:id_viaje
      IF SELF.Run(3,SelectRecord) = RequestCompleted
        L:id_viaje = via:id_viaje
      END
      ThisWindow.Reset(1)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Window
!!! comprobantes
!!! </summary>
selectFacturas PROCEDURE 

CurrentTab           STRING(80)                            !
L:buscar             CSTRING(50)                           !
BRW1::View:Browse    VIEW(comprobantes)
                       PROJECT(com:comprobante_id)
                       PROJECT(com:tipo_comprobante)
                       PROJECT(com:letra_comprobante)
                       PROJECT(com:numero_comprobante)
                       PROJECT(com:importe)
                       PROJECT(com:proveedor_id)
                       JOIN(Pro3:PK_PROVEEDOR,com:proveedor_id)
                         PROJECT(Pro3:proveedor_id)
                         JOIN(pro:FK_PROVEEDOR_CONTABLE,Pro3:proveedor_id)
                         END
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
com:comprobante_id     LIKE(com:comprobante_id)       !List box control field - type derived from field
com:tipo_comprobante   LIKE(com:tipo_comprobante)     !List box control field - type derived from field
com:letra_comprobante  LIKE(com:letra_comprobante)    !List box control field - type derived from field
com:numero_comprobante LIKE(com:numero_comprobante)   !List box control field - type derived from field
com:importe            LIKE(com:importe)              !List box control field - type derived from field
Pro3:proveedor_id      LIKE(Pro3:proveedor_id)        !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,415,271),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('selectFacturas'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(20,81,375,141),USE(?Browse:1),HVSCROLL,FORMAT('0R(2)|M~comprobante i~C(0)@n-14@' & |
  '80L(2)|M~Tipo~@s20@23L(2)|M~Letra~@s1@76L(2)|M~Numero~@P#####-########P@72L(2)|M~Imp' & |
  'orte~D(12)@n-17.2@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the comprobantes file')
                       BUTTON,AT(19,226,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(341,226,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(370,226,25,25),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Muestra vent' & |
  'ana de ayuda'),STD(STD:Help),TIP('Muestra ventana de ayuda')
                       STRING('Proveedor:'),AT(28,36,39,10),USE(?STRING1),TRN
                       STRING(@s80),AT(65,36,195,10),USE(Pro3:nombre),TRN
                       ENTRY(@s49),AT(55,58,199,12),USE(L:buscar)
                       STRING('Buscar:'),AT(28,61,39,10),USE(?STRING1:2),TRN
                       BUTTON,AT(282,57,16,14),USE(?Browse:Top),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page')
                       BUTTON,AT(301,57,16,14),USE(?Browse:PageUp),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the Prior Page')
                       BUTTON,AT(319,57,16,14),USE(?Browse:Up),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record')
                       BUTTON,AT(338,57,16,14),USE(?Browse:Down),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record')
                       BUTTON,AT(357,57,16,14),USE(?Browse:PageDown),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page')
                       BUTTON,AT(375,57,16,14),USE(?Browse:Bottom),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page')
                       STRING('Seleccionar Factura'),AT(159,10,95),USE(?STRING2),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline), |
  TRN
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

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator
BRW1::Sort0:StepClass StepLongClass                        ! Default Step Manager
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
  GlobalErrors.SetProcedureName('selectFacturas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('glo:id_proveedor',glo:id_proveedor)                ! Added by: BrowseBox(ABC)
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
  Relate:comprobantes.Open                                 ! File comprobantes used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  Pro3:proveedor_id = glo:id_proveedor
  access:Proveedores_contable.Fetch(Pro3:PK_PROVEEDOR)
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:comprobantes,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha+ScrollSort:CaseSensitive) ! Moveable thumb based upon com:comprobante_id for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,com:PK_COMPROBANTE) ! Add the sort order for com:PK_COMPROBANTE for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?L:buscar,com:comprobante_id,,BRW1) ! Initialize the browse locator using ?L:buscar using key: com:PK_COMPROBANTE , com:comprobante_id
  BRW1.SetFilter('(com:proveedor_id = glo:id_proveedor AND com:tipo_comprobante=''Factura'')') ! Apply filter expression to browse
  BRW1.AddField(com:comprobante_id,BRW1.Q.com:comprobante_id) ! Field com:comprobante_id is a hot field or requires assignment from browse
  BRW1.AddField(com:tipo_comprobante,BRW1.Q.com:tipo_comprobante) ! Field com:tipo_comprobante is a hot field or requires assignment from browse
  BRW1.AddField(com:letra_comprobante,BRW1.Q.com:letra_comprobante) ! Field com:letra_comprobante is a hot field or requires assignment from browse
  BRW1.AddField(com:numero_comprobante,BRW1.Q.com:numero_comprobante) ! Field com:numero_comprobante is a hot field or requires assignment from browse
  BRW1.AddField(com:importe,BRW1.Q.com:importe)            ! Field com:importe is a hot field or requires assignment from browse
  BRW1.AddField(Pro3:proveedor_id,BRW1.Q.Pro3:proveedor_id) ! Field Pro3:proveedor_id is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('selectFacturas',QuickWindow)               ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,com:PK_COMPROBANTE)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:comprobantes.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('selectFacturas',QuickWindow)            ! Save window data to non-volatile store
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
!!! <summary>
!!! Generated from procedure template - Window
!!! Proveedores_contable
!!! </summary>
SelectProveedorContable PROCEDURE 

L:buscar             STRING(50)                            !
CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Proveedores_contable)
                       PROJECT(Pro3:proveedor_id)
                       PROJECT(Pro3:nombre)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
Pro3:proveedor_id      LIKE(Pro3:proveedor_id)        !List box control field - type derived from field
Pro3:nombre            LIKE(Pro3:nombre)              !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,337,233),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('SelectProveedorContable'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(14,66,306,113),USE(?Browse:1),HVSCROLL,FORMAT('64R(2)|M~proveedor id~C(0)@n-14@' & |
  '80L(2)|M~nombre~L(2)@s80@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the Proveedores_c' & |
  'ontable file')
                       BUTTON,AT(15,191,25,25),USE(?Select:2),ICON('seleccionar.ico'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(267,191,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(295,191,25,25),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Muestra vent' & |
  'ana de ayuda'),STD(STD:Help),TIP('Muestra ventana de ayuda')
                       STRING('Buscar:'),AT(19,50),USE(?STRING1),FONT(,,,FONT:bold),TRN
                       ENTRY(@s50),AT(49,47),USE(L:buscar)
                       BUTTON,AT(193,47,16,14),USE(?Browse:Top:2),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page')
                       BUTTON,AT(211,47,16,14),USE(?Browse:PageUp:2),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the ' & |
  'Prior Page')
                       BUTTON,AT(230,47,16,14),USE(?Browse:Up:2),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record')
                       BUTTON,AT(249,47,16,14),USE(?Browse:Down:2),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record')
                       BUTTON,AT(267,47,16,14),USE(?Browse:PageDown:2),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page')
                       BUTTON,AT(286,47,16,14),USE(?Browse:Bottom:2),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page')
                       STRING('Seleccionar Proveedor'),AT(110,12,99,11),USE(?STRING2),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline), |
  TRN
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

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator
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
  GlobalErrors.SetProcedureName('SelectProveedorContable')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  BRW1::Toolbar.Init(SELF,BRW1)
  BRW1::Toolbar.InitBrowse(0, 0, 0, 0)
  BRW1::Toolbar.InitVCR(?Browse:Top:2, ?Browse:Bottom:2, ?Browse:PageUp:2, ?Browse:PageDown:2, ?Browse:Up:2, ?Browse:Down:2, 0)
  BRW1::Toolbar.InitMisc(0, 0)
  SELF.AddItem(BRW1::Toolbar.WindowComponent)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Proveedores_contable.Open                         ! File Proveedores_contable used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Proveedores_contable,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,Pro3:PK_PROVEEDOR)                    ! Add the sort order for Pro3:PK_PROVEEDOR for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?L:buscar,Pro3:proveedor_id,,BRW1) ! Initialize the browse locator using ?L:buscar using key: Pro3:PK_PROVEEDOR , Pro3:proveedor_id
  BRW1.AddField(Pro3:proveedor_id,BRW1.Q.Pro3:proveedor_id) ! Field Pro3:proveedor_id is a hot field or requires assignment from browse
  BRW1.AddField(Pro3:nombre,BRW1.Q.Pro3:nombre)            ! Field Pro3:nombre is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectProveedorContable',QuickWindow)      ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,Pro3:PK_PROVEEDOR)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Proveedores_contable.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('SelectProveedorContable',QuickWindow)   ! Save window data to non-volatile store
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
!!! <summary>
!!! Generated from procedure template - Window
!!! Formulario Costos_GLP
!!! </summary>
updateCostosGLP PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::Cos:Record  LIKE(Cos:RECORD),THREAD
QuickWindow          WINDOW,AT(,,224,153),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('updateCostosGLP'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(130,114,25,25),USE(?OK),ICON('aceptar.ICO'),DEFAULT,FLAT,MSG('Acepta los dato' & |
  's y cierra ventana'),TIP('Acepta los datos y cierra ventana')
                       BUTTON,AT(159,114,25,25),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancela operación'),TIP('Cancela operación')
                       BUTTON,AT(187,114,25,25),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Mostrar ventana de ayuda'), |
  STD(STD:Help),TIP('Mostrar ventana de ayuda')
                       ENTRY(@d6),AT(107,56,50,10),USE(Cos:fecha_vigencia_DATE),FLAT
                       ENTRY(@n-10.2),AT(107,70,48,10),USE(Cos:costo),DECIMAL(12)
                       PROMPT('costo:'),AT(25,76),USE(?Cos:costo:Prompt),TRN
                       ENTRY(@n-14),AT(107,41,50,10),USE(Cos:id_costos),RIGHT(1),READONLY
                       PROMPT('id costos:'),AT(23,41),USE(?Cos:id_costos:Prompt),TRN
                       PROMPT('fecha vigencia:'),AT(23,56),USE(?aCos:fecha_vigencia_DATE:Prompt),TRN
                       STRING('Ingreso de costos de GLP'),AT(58,11),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline)
                       BUTTON,AT(163,51,21,18),USE(?BotonSeleccionFecha),ICON('calen.ico')
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
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
    ActionMessage = 'Record Will Be Added'
  OF ChangeRecord
    ActionMessage = 'Record Will Be Changed'
  END
  QuickWindow{PROP:StatusText,2} = ActionMessage           ! Display status message in status bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('updateCostosGLP')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(Cos:Record,History::Cos:Record)
  SELF.AddHistoryField(?Cos:fecha_vigencia_DATE,4)
  SELF.AddHistoryField(?Cos:costo,6)
  SELF.AddHistoryField(?Cos:id_costos,1)
  SELF.AddUpdateFile(Access:Costos_GLP)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Costos_GLP.Open                                   ! File Costos_GLP used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Costos_GLP
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
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?Cos:fecha_vigencia_DATE{PROP:ReadOnly} = True
    ?Cos:costo{PROP:ReadOnly} = True
    ?Cos:id_costos{PROP:ReadOnly} = True
    DISABLE(?BotonSeleccionFecha)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('updateCostosGLP',QuickWindow)              ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
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
    INIMgr.Update('updateCostosGLP',QuickWindow)           ! Save window data to non-volatile store
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
    OF ?BotonSeleccionFecha
      ThisWindow.Update
      CHANGE(?Cos:fecha_vigencia_DATE,bigfec(CONTENTS(?Cos:fecha_vigencia_DATE)))
      !DO RefreshWindow
    END
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
SelectViajesDescargados PROCEDURE 

CurrentTab           STRING(80)                            !
L:buscador           STRING(50)                            !
BRW1::View:Browse    VIEW(Viajes)
                       PROJECT(via:id_viaje)
                       PROJECT(via:nro_remito)
                       PROJECT(via:guia_transporte)
                       PROJECT(via:peso)
                       PROJECT(via:fecha_carga_DATE)
                       PROJECT(via:id_procedencia)
                       PROJECT(via:id_transportista)
                       PROJECT(via:id_proveedor)
                       JOIN(tra:PK_TRANSPORTISTA,via:id_transportista)
                         PROJECT(tra:transportista)
                         PROJECT(tra:id_transportista)
                       END
                       JOIN(pro:PK_proveedor,via:id_proveedor)
                         PROJECT(pro:proveedor)
                         PROJECT(pro:id_proveedor)
                       END
                       JOIN(pro1:PK_PROCEDENCIA,via:id_procedencia)
                         PROJECT(pro1:procedencia)
                         PROJECT(pro1:id_procedencia)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
via:id_viaje           LIKE(via:id_viaje)             !List box control field - type derived from field
via:nro_remito         LIKE(via:nro_remito)           !List box control field - type derived from field
tra:transportista      LIKE(tra:transportista)        !List box control field - type derived from field
pro1:procedencia       LIKE(pro1:procedencia)         !List box control field - type derived from field
via:guia_transporte    LIKE(via:guia_transporte)      !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
via:nro_remito         LIKE(via:nro_remito)           !List box control field - type derived from field - type derived from field
via:peso               LIKE(via:peso)                 !List box control field - type derived from field
via:fecha_carga_DATE   LIKE(via:fecha_carga_DATE)     !List box control field - type derived from field
via:id_procedencia     LIKE(via:id_procedencia)       !Browse key field - type derived from field
tra:id_transportista   LIKE(tra:id_transportista)     !Related join file key field - type derived from field
pro:id_proveedor       LIKE(pro:id_proveedor)         !Related join file key field - type derived from field
pro1:id_procedencia    LIKE(pro1:id_procedencia)      !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('SelectViajesDespacho'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(31,74,459,164),USE(?Browse:1),HVSCROLL,FORMAT('62R(2)|M~Id viaje~C(0)@N_20_@67R' & |
  '(2)|M~Nro Remito~C(0)@P####-########P@112L(2)|M~Transportista~L(0)@s50@124L(2)|M~Pro' & |
  'cedencia~L(0)@s50@80L(2)|M~Guia Transporte~C(2)@s50@124L(2)|M~Proveedor~C(0)@s50@80L' & |
  '(2)|M~Nro Remito~C(2)@s50@80R(2)|M~Peso~C(0)@n-20.0@80R(2)|M~Fecha carga~C(0)@d6@'),FROM(Queue:Browse:1), |
  IMM,MSG('Browsing the Viajes file')
                       BUTTON,AT(29,257,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(435,287,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(465,287,25,25),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('Muestra ve' & |
  'ntana de ayuda'),STD(STD:Help),TIP('Muestra ventana de ayuda')
                       STRING('Seleccione Viajes descargados'),AT(176,16),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       PROMPT('Buscar:'),AT(51,55),USE(?L:buscador:Prompt)
                       ENTRY(@s50),AT(81,56,191,10),USE(L:buscador)
                       BUTTON,AT(283,51,16,14),USE(?Browse:Top:2),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page')
                       BUTTON,AT(301,51,16,14),USE(?Browse:PageUp:2),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the ' & |
  'Prior Page')
                       BUTTON,AT(320,51,16,14),USE(?Browse:Up:2),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record')
                       BUTTON,AT(339,51,16,14),USE(?Browse:Down:2),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record')
                       BUTTON,AT(357,51,16,14),USE(?Browse:PageDown:2),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page')
                       BUTTON,AT(376,51,16,14),USE(?Browse:Bottom:2),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page')
                     END

BRW1::Toolbar        BrowseToolbarClass
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator
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
  GlobalErrors.SetProcedureName('SelectViajesDescargados')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('via:id_viaje',via:id_viaje)                        ! Added by: BrowseBox(ABC)
  BIND('via:nro_remito',via:nro_remito)                    ! Added by: BrowseBox(ABC)
  BIND('via:guia_transporte',via:guia_transporte)          ! Added by: BrowseBox(ABC)
  BIND('via:id_procedencia',via:id_procedencia)            ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  BRW1::Toolbar.Init(SELF,BRW1)
  BRW1::Toolbar.InitBrowse(0, 0, 0, 0)
  BRW1::Toolbar.InitVCR(?Browse:Top:2, ?Browse:Bottom:2, ?Browse:PageUp:2, ?Browse:PageDown:2, ?Browse:Up:2, ?Browse:Down:2, 0)
  BRW1::Toolbar.InitMisc(0, 0)
  SELF.AddItem(BRW1::Toolbar.WindowComponent)
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
  BRW1.AddSortOrder(,via:K_PROCEDENCIA)                    ! Add the sort order for via:K_PROCEDENCIA for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?L:buscador,via:id_viaje,1,BRW1) ! Initialize the browse locator using ?L:buscador using key: via:K_PROCEDENCIA , via:id_viaje
  BRW1.SetFilter('(via:estado=''Descargado'' AND via:anulado<<>1)') ! Apply filter expression to browse
  BRW1.AddField(via:id_viaje,BRW1.Q.via:id_viaje)          ! Field via:id_viaje is a hot field or requires assignment from browse
  BRW1.AddField(via:nro_remito,BRW1.Q.via:nro_remito)      ! Field via:nro_remito is a hot field or requires assignment from browse
  BRW1.AddField(tra:transportista,BRW1.Q.tra:transportista) ! Field tra:transportista is a hot field or requires assignment from browse
  BRW1.AddField(pro1:procedencia,BRW1.Q.pro1:procedencia)  ! Field pro1:procedencia is a hot field or requires assignment from browse
  BRW1.AddField(via:guia_transporte,BRW1.Q.via:guia_transporte) ! Field via:guia_transporte is a hot field or requires assignment from browse
  BRW1.AddField(pro:proveedor,BRW1.Q.pro:proveedor)        ! Field pro:proveedor is a hot field or requires assignment from browse
  BRW1.AddField(via:nro_remito,BRW1.Q.via:nro_remito)      ! Field via:nro_remito is a hot field or requires assignment from browse
  BRW1.AddField(via:peso,BRW1.Q.via:peso)                  ! Field via:peso is a hot field or requires assignment from browse
  BRW1.AddField(via:fecha_carga_DATE,BRW1.Q.via:fecha_carga_DATE) ! Field via:fecha_carga_DATE is a hot field or requires assignment from browse
  BRW1.AddField(via:id_procedencia,BRW1.Q.via:id_procedencia) ! Field via:id_procedencia is a hot field or requires assignment from browse
  BRW1.AddField(tra:id_transportista,BRW1.Q.tra:id_transportista) ! Field tra:id_transportista is a hot field or requires assignment from browse
  BRW1.AddField(pro:id_proveedor,BRW1.Q.pro:id_proveedor)  ! Field pro:id_proveedor is a hot field or requires assignment from browse
  BRW1.AddField(pro1:id_procedencia,BRW1.Q.pro1:id_procedencia) ! Field pro1:id_procedencia is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectViajesDescargados',QuickWindow)      ! Restore window settings from non-volatile store
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
    INIMgr.Update('SelectViajesDescargados',QuickWindow)   ! Save window data to non-volatile store
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
!!! Generated from procedure template - Form
!!! </summary>
GraficoExistencia PROCEDURE 

GRP6::View:Graph     VIEW(Existencias)
                     END
Window               WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular),RESIZE,GRAY,MDI,SYSTEM,WALLPAPER('fondo.jpg')
                       PROMPT('GLO : id planta:'),AT(21,65),USE(?GLO:id_planta:Prompt)
                       ENTRY(@P<<<<<P),AT(75,66,60,10),USE(GLO:id_planta),RIGHT(1)
                       BUTTON('...'),AT(140,65,12,12),USE(?CallLookup)
                       BUTTON('...'),AT(140,49,12,12),USE(?CallLookup:2)
                       PROMPT('Localidad:'),AT(26,51),USE(?GLO:localidad_id:Prompt)
                       ENTRY(@n-14),AT(75,50,60,10),USE(GLO:localidad_id),RIGHT(1)
                       GROUP,AT(56,100,377,210),USE(?Graph),BEVEL(-1,1),BOXED
                       END
                       BUTTON('Button1'),AT(236,25),USE(?BUTTON1)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
GRP6                 CLASS(GraphClass)
BeginRefresh           PROCEDURE(),bool,DERIVED
SetDefault             PROCEDURE(),DERIVED
Graph:RecordIndex      LONG
Graph:SPointNumber     LONG
Series1_Process        PROCEDURE()                         ! New method added to this class instance
Series1_TakeNextValue  PROCEDURE(),BYTE                    ! New method added to this class instance
Series1_FilterRecord   PROCEDURE(),BYTE                    ! New method added to this class instance
                     END

GRP6:VM1             ViewManager

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
  GlobalErrors.SetProcedureName('GraficoExistencia')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?GLO:id_planta:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('GLO:fecha_desde',GLO:fecha_desde)                  ! Added by: Graph(SVGraph)
  BIND('GLO:FECHA_HASTA',GLO:FECHA_HASTA)                  ! Added by: Graph(SVGraph)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:Existencias.SetOpenRelated()
  Relate:Existencias.Open                                  ! File Existencias used by this procedure, so make sure it's RelationManager is open
  Access:Localidades_GLP.UseFile                           ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:Plantas.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Open(Window)                                        ! Open window
  ! Initializing ViewManager of object GRP6
  GRP6:VM1.Init(GRP6::View:Graph,Relate:Existencias)
  GRP6:VM1.AddSortOrder(exi:EXI_FK_PLANTA)
  GRP6:VM1.AddRange(exi:id_planta,GLO:id_planta)
  GRP6:VM1.SetFilter('exi:FECHA_LECTURA_DATE>=GLO:fecha_desde AND exi:FECHA_LECTURA_DATE <<= GLO:FECHA_HASTA')
  Do DefineListboxStyle
  INIMgr.Fetch('GraficoExistencia',Window)                 ! Restore window settings from non-volatile store
  GRP6.Init(Window,?Graph,2,2,2,2)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GRP6.Kill()
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Existencias.Close
  END
  IF SELF.Opened
    INIMgr.Update('GraficoExistencia',Window)              ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF Window{Prop:AcceptAll} THEN RETURN.
  PARENT.Reset(Force)
  GRP6.Refresh(true)


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      SelectPlantas
      SelectLocalidadGlobal
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
    OF ?GLO:id_planta
      IF GLO:id_planta OR ?GLO:id_planta{PROP:Req}
        pla:ID_PLANTA = GLO:id_planta
        IF Access:Plantas.TryFetch(pla:PK__plantas__7D439ABD)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            GLO:id_planta = pla:ID_PLANTA
          ELSE
            SELECT(?GLO:id_planta)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookup
      ThisWindow.Update
      pla:ID_PLANTA = GLO:id_planta
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        GLO:id_planta = pla:ID_PLANTA
      END
      ThisWindow.Reset(1)
    OF ?CallLookup:2
      ThisWindow.Update
      Loc:id_localidad = GLO:localidad_id
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        GLO:localidad_id = Loc:id_localidad
      END
      ThisWindow.Reset(1)
    OF ?GLO:localidad_id
      IF GLO:localidad_id OR ?GLO:localidad_id{PROP:Req}
        Loc:id_localidad = GLO:localidad_id
        IF Access:Localidades_GLP.TryFetch(Loc:PK_localidad)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            GLO:localidad_id = Loc:id_localidad
          ELSE
            SELECT(?GLO:localidad_id)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
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
  GRP6.TakeEvent()
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


GRP6.BeginRefresh PROCEDURE

ReturnValue          bool,AUTO

  CODE
  ! Graph Data
  SELF.Series1_Process()
  SORT(SELF.qCluster, +SELF.qCluster.eName)
  ReturnValue = PARENT.BeginRefresh()
  RETURN ReturnValue


GRP6.SetDefault PROCEDURE

  CODE
  PARENT.SetDefault
  SELF.GraphType(GraphType:ColumnChart, false)
  SELF.eGraphSubType = GraphSubType:Simple
  SELF.eGraphFigure = FigureType:Bar
  SELF.oTitle.SetFont(,16)
  SELF.eWallpaper = Wallpaper:Tiled
  SELF.e3D = True
  SELF.eAxisListAutoSwap = True
  SELF.oLegend.ePosition = LegendPosition:Bottom
  SELF.oLegend.eBox = False
  SELF.eAxisListStyle = AxisListStyle:Standard
  SELF.eAxisListGrid = True
  SELF.eAxisListScaleMinMax = False
  SELF.eAxisListScale = Scale:Linear
  SELF.eAxisXname = True
  SELF.eAxisXGrid = True
  SELF.eAxisYname = True
  SELF.eAxisYGrid = True
  SELF.eNodeType = NodeType:Circle
  SELF.eNodeMinMax = False
  SELF.eNodeLabel = False
  SELF.eNodeValue = False
  SELF.eNodeBgr = False
  SELF.eBestPositionNodeText = True
  SELF.eSaveFileNameAlwaysExt = true
  SELF.gPrint.ePreview = True
  SELF.gPrint.eOrientation = equ:Auto
  SELF.gPrint.eBox = False
  SELF.gPrint.eL = 20
  SELF.gPrint.eT = 10
  SELF.gPrint.eR = 10
  SELF.gPrint.eB = 20
  SELF.gPrint.eAlignment = Alignment:Left + Alignment:Top
  SELF.gPrint.eProportional = True
  SELF.gPrint.eStretch =  0
  SELF.ePopUp = true
  CLEAR(SELF.ePopUpItems)
  SELF.ePopUpItems += GraphPop:Title
  SELF.ePopUpItems += GraphPop:Wallpaper
  CLEAR(SELF.ePopUpSubWallpaper)
  SELF.ePopUpSubWallpaper += GraphPop:Wallpaper:None
  SELF.ePopUpSubWallpaper += GraphPop:Wallpaper:Stretched
  SELF.ePopUpSubWallpaper += GraphPop:Wallpaper:Tiled
  SELF.ePopUpSubWallpaper += GraphPop:Wallpaper:Centered
  SELF.ePopUpItems += GraphPop:3D
  SELF.ePopUpItems += GraphPop:Zoom
  SELF.ePopUpItems += GraphPop:GraphType
  CLEAR(SELF.ePopUpSubGraphType)
  SELF.ePopUpSubGraphType += GraphPop:ScatterGraph
  SELF.ePopUpSubGraphType += GraphPop:Line
  SELF.ePopUpSubGraphType += GraphPop:AreaGraph
  SELF.ePopUpSubGraphType += GraphPop:FloatingArea
  SELF.ePopUpSubGraphType += GraphPop:ColumnChart
  SELF.ePopUpSubGraphType += GraphPop:ColumnWithAccumulation
  SELF.ePopUpSubGraphType += GraphPop:FloatingColumn
  SELF.ePopUpSubGraphType += GraphPop:BarChart
  SELF.ePopUpSubGraphType += GraphPop:BarWithAccumulation
  SELF.ePopUpSubGraphType += GraphPop:FloatingBar
  SELF.ePopUpSubGraphType += GraphPop:PieChart
  SELF.ePopUpItems += GraphPop:Figure
  SELF.ePopUpItems += GraphPop:Legend
  CLEAR(SELF.ePopUpSubLegend)
  SELF.ePopUpSubLegend += GraphPop:Legend:None
  SELF.ePopUpSubLegend += GraphPop:Legend:Left
  SELF.ePopUpSubLegend += GraphPop:Legend:Right
  SELF.ePopUpSubLegend += GraphPop:Legend:Top
  SELF.ePopUpSubLegend += GraphPop:Legend:Bottom
  SELF.ePopUpItems += GraphPop:LegendBox
  SELF.ePopUpItems += GraphPop:AxisList
  CLEAR(SELF.ePopUpSubAxisList)
  SELF.ePopUpSubAxisList += GraphPop:AxisList:None
  SELF.ePopUpSubAxisList += GraphPop:AxisList:Standard
  SELF.ePopUpSubAxisList += GraphPop:AxisList:Long
  SELF.ePopUpItems += GraphPop:Grid
  SELF.ePopUpItems += GraphPop:GridX
  SELF.ePopUpItems += GraphPop:GridY
  SELF.ePopUpItems += GraphPop:AxisListName
  SELF.ePopUpItems += GraphPop:AxisListScale
  SELF.ePopUpItems += GraphPop:AxisListScaleMinMax
  SELF.ePopUpItems += GraphPop:Node
  CLEAR(SELF.ePopUpSubNode)
  SELF.ePopUpSubNode += GraphPop:Node:Square
  SELF.ePopUpSubNode += GraphPop:Node:Triangle
  SELF.ePopUpSubNode += GraphPop:Node:Circle
  SELF.ePopUpSubNode += GraphPop:Node:None
  SELF.ePopUpItems += GraphPop:NodeMinMax
  SELF.ePopUpItems += GraphPop:NodeLabel
  SELF.ePopUpItems += GraphPop:NodeValue
  SELF.ePopUpItems += GraphPop:NodeBgr
  SELF.ePopUpItems += GraphPop:Print
  SELF.ePopUpItems += GraphPop:PrintBestFit
  SELF.ePopUpItems += GraphPop:Save
  SELF.ePopUpItems += GraphPop:SaveAs
  SELF.ePopUpItems += GraphPop:DrillDown
  SELF.ePopUpItems += GraphPop:ReturnFromDrillDown
  SELF.ePopUpItems += GraphPop:ToolTip
  SELF.eToolTip = True
  SELF.eBestPositionToolTip = True
  SELF.gToolTipProp.eTrn = False
  CLEAR(SELF.gShowMouse)
  CLEAR(SELF.gShowMouseX)
  CLEAR(SELF.gShowMouseY)
  CLEAR(SELF.gShowDiagramName)
  CLEAR(SELF.gShowDiagramNameV)
  CLEAR(SELF.gShowNodeName)
  CLEAR(SELF.gShowNodeNameV)
  CLEAR(SELF.gShowNodeValue)
  CLEAR(SELF.gShowNodeValueX)
  CLEAR(SELF.gShowNodeValueY)
  SELF.gShowMouse.eOnT = true
  SELF.gShowDiagramName.eOnT = true
  SELF.gShowNodeName.eOnT = true
  SELF.gShowNodeValue.eOnT = true

GRP6.Series1_Process PROCEDURE()

locSaveViewPosition1 any

  CODE
    GRP6:VM1.Reset()
    GRP6:VM1.ApplyRange()
    SELF.Graph:RecordIndex = 1
    LOOP
      IF SELF.Series1_TakeNextValue()<>Level:Benign then break END
      IF SELF.Series1_FilterRecord()<>Level:Benign then cycle END
    END


GRP6.Series1_TakeNextValue PROCEDURE()

ReturnValue          byte

  CODE
    ReturnValue = Level:Benign
    ReturnValue = GRP6:VM1.Next()
    SELF.Graph:RecordIndex += 1
    RETURN ReturnValue


GRP6.Series1_FilterRecord PROCEDURE()

ReturnValue          byte

  CODE
    ReturnValue = Level:Benign
    RETURN ReturnValue


!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
ReportMediciones PROCEDURE (STRING pfilter,STRING pOrder)

Progress:Thermometer BYTE                                  !
Process:View         VIEW(Mediciones)
                       PROJECT(med:Volumen_vapor)
                       PROJECT(med:densidad)
                       PROJECT(med:factor_corr_vapor)
                       PROJECT(med:factor_liquido)
                       PROJECT(med:id_planta)
                       PROJECT(med:nivel)
                       PROJECT(med:presion)
                       PROJECT(med:temperatura)
                       PROJECT(med:volumen_corr_liq)
                       PROJECT(med:volumen_corr_vapor)
                       PROJECT(med:volumen_liquido)
                       PROJECT(med:volumen_total)
                       PROJECT(med:volumen_total_corr)
                     END
ProgressWindow       WINDOW,AT(,,142,73),DOUBLE,CENTER,GRAY,TIMER(1),WALLPAPER('fondo.jpg')
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER,TRN
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER,TRN
                       BUTTON,AT(58,43,22,18),USE(?Progress:Cancel),ICON('Cancelar.ico'),FLAT,TRN
                     END

Report               REPORT,AT(354,1427,9510,5208),PRE(RPT),PAPER(PAPER:A4),LANDSCAPE,FONT('Arial',10,,FONT:regular, |
  CHARSET:ANSI),THOUS
                       HEADER,AT(354,365,9510,1000),USE(?Header)
                       END
Detail                 DETAIL,AT(0,0,9500,312),USE(?Detail)
                         STRING(@N-4.`1),AT(31,-10),USE(med:nivel),TRN
                         STRING(@n-14),AT(219,21),USE(med:temperatura),RIGHT(1),TRN
                         STRING(@n-10.3),AT(1448,21),USE(med:presion),TRN
                         STRING(@N-6.`3),AT(2312,21),USE(med:densidad),TRN
                         STRING(@N-8.`4),AT(2969,21),USE(med:volumen_liquido),TRN
                         STRING(@N-8.`4),AT(3708,21),USE(med:factor_liquido),TRN
                         STRING(@N-8.`4),AT(4448,21),USE(med:volumen_corr_liq),TRN
                         STRING(@n-15.6),AT(5042,21,656),USE(med:Volumen_vapor),DECIMAL(12),TRN
                         STRING(@N-10.`6),AT(5760,21,677),USE(med:factor_corr_vapor),DECIMAL(12),TRN
                         STRING(@N-12.`6),AT(6500,21,885),USE(med:volumen_corr_vapor),DECIMAL(12),TRN
                         STRING(@N-15_`6),AT(7448,21,1146),USE(med:volumen_total),DECIMAL(12),TRN
                         STRING(@n-16.0),AT(8583,-10,1031),USE(med:volumen_total_corr),DECIMAL(12),TRN
                       END
                       FOOTER,AT(354,6698,9510,552),USE(?Footer)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
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
  GlobalErrors.SetProcedureName('ReportMediciones')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:Mediciones.Open                                   ! File Mediciones used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('ReportMediciones',ProgressWindow)          ! Restore window settings from non-volatile store
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:Mediciones, ?Progress:PctText, Progress:Thermometer, ProgressMgr, med:id_planta)
  ThisReport.AddSortOrder(med:FK_PLANTA)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:Mediciones.SetQuickScan(1,Propagate:OneMany)
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  SELF.SetAlerts()
  thisreport.SetFilter(pfilter)
  ThisReport.SetOrder(pOrder)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Mediciones.Close
  END
  IF SELF.Opened
    INIMgr.Update('ReportMediciones',ProgressWindow)       ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

