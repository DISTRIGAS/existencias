

   MEMBER('existencias.clw')                               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('BRWEXT.INC'),ONCE

                     MAP
                       INCLUDE('EXISTENCIAS009.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('EXISTENCIAS005.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
BrowseConceptosAduana PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(conceptos_aduana)
                       PROJECT(Con:id_concepto)
                       PROJECT(Con:concepto)
                       PROJECT(Con:importe)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
Con:id_concepto        LIKE(Con:id_concepto)          !List box control field - type derived from field
Con:concepto           LIKE(Con:concepto)             !List box control field - type derived from field
Con:importe            LIKE(Con:importe)              !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,515,350),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),RESIZE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseConceptosAnticipos'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(87,60,342,113),USE(?Browse:1),HVSCROLL,FORMAT('57R(2)|M~Id Concepto~C(0)@N-14_@' & |
  '222L(2)|M~Concepto~C(2)@s100@56L(2)|M~Importe~C(12)@N-13_.2~ $~@'),FROM(Queue:Browse:1), |
  IMM,MSG('Browsing the conceptos_anticipos file')
                       BUTTON,AT(135,210,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(190,210,25,25),USE(?View:3),ICON('Ver.ico'),FLAT,MSG('Visualiza el registro'),TIP('Visualiza ' & |
  'el registro')
                       BUTTON,AT(245,210,25,25),USE(?Insert:4),ICON('Insertar.ico'),FLAT,MSG('Inserta un Registro'), |
  TIP('Inserta un Registro')
                       BUTTON,AT(299,210,25,25),USE(?Change:4),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Modifica e' & |
  'l registro'),TIP('Modifica el registro')
                       BUTTON,AT(354,210,25,25),USE(?Delete:4),ICON('Eliminar.ICO'),FLAT,MSG('Elimina un registro'), |
  TIP('Elimina un registro')
                       BUTTON,AT(434,292,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(462,292,25,25),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('Muestra ve' & |
  'ntana de ayuda'),STD(STD:Help),TIP('Muestra ventana de ayuda')
                       STRING('Conceptos de Aduana'),AT(212,18),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline), |
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
  GlobalErrors.SetProcedureName('BrowseConceptosAduana')
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
  Relate:conceptos_aduana.Open                             ! File conceptos_aduana used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:conceptos_aduana,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,Con:PK_CONCEPTO)                      ! Add the sort order for Con:PK_CONCEPTO for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,Con:id_concepto,,BRW1)         ! Initialize the browse locator using  using key: Con:PK_CONCEPTO , Con:id_concepto
  BRW1.AddField(Con:id_concepto,BRW1.Q.Con:id_concepto)    ! Field Con:id_concepto is a hot field or requires assignment from browse
  BRW1.AddField(Con:concepto,BRW1.Q.Con:concepto)          ! Field Con:concepto is a hot field or requires assignment from browse
  BRW1.AddField(Con:importe,BRW1.Q.Con:importe)            ! Field Con:importe is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseConceptosAduana',QuickWindow)        ! Restore window settings from non-volatile store
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
    Relate:conceptos_aduana.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseConceptosAduana',QuickWindow)     ! Save window data to non-volatile store
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
    UpdateConceptosAduana
    ReturnValue = GlobalResponse
  END
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
!!! Form conceptos_anticipos
!!! </summary>
UpdateConceptosAduana PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::Con:Record  LIKE(Con:RECORD),THREAD
QuickWindow          WINDOW,AT(,,428,295),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('UpdateConeptosAnticipos'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(319,218,25,25),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Acepta los dato' & |
  's y cierra ventana'),TIP('Acepta los datos y cierra ventana')
                       BUTTON,AT(348,218,25,25),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancela operación'),TIP('Cancela operación')
                       BUTTON,AT(377,218,25,25),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Mostrar ventana de ayuda'), |
  STD(STD:Help),TIP('Mostrar ventana de ayuda')
                       ENTRY(@N-14_),AT(96,79,60,10),USE(Con:id_concepto),RIGHT(1),READONLY
                       PROMPT('Id Concepto:'),AT(43,79),USE(?Con:id_concepto:Prompt),TRN
                       PROMPT('Concepto:'),AT(43,102),USE(?Con:concepto:Prompt),TRN
                       ENTRY(@s100),AT(96,102,289,10),USE(Con:concepto),UPR
                       PROMPT('Importe:'),AT(45,127),USE(?Con:importe:Prompt)
                       ENTRY(@N-13_.2~ $~),AT(96,127,60,10),USE(Con:importe),DECIMAL(12)
                       STRING('Ingreso de Conceptos de Aduana'),AT(145,17),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline), |
  TRN
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
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateConceptosAduana')
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
  SELF.AddHistoryFile(Con:Record,History::Con:Record)
  SELF.AddHistoryField(?Con:id_concepto,1)
  SELF.AddHistoryField(?Con:concepto,2)
  SELF.AddHistoryField(?Con:importe,3)
  SELF.AddUpdateFile(Access:conceptos_aduana)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:conceptos_aduana.Open                             ! File conceptos_aduana used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:conceptos_aduana
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
    ?Con:id_concepto{PROP:ReadOnly} = True
    ?Con:concepto{PROP:ReadOnly} = True
    ?Con:importe{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateConceptosAduana',QuickWindow)        ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:conceptos_aduana.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateConceptosAduana',QuickWindow)     ! Save window data to non-volatile store
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
BrowseDespachoAduanero PROCEDURE 

CurrentTab           STRING(80)                            !
l:buscador           CSTRING(50)                           !
BRW1::View:Browse    VIEW(Despacho_aduana)
                       PROJECT(des1:id_despacho)
                       PROJECT(des1:peso_total)
                       PROJECT(des1:id_despachante)
                       PROJECT(des1:importe)
                       PROJECT(des1:cant_viajes)
                       JOIN(Des2:PK_DESPACHANTE,des1:id_despachante)
                         PROJECT(Des2:despachante)
                         PROJECT(Des2:id_despachante)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
des1:id_despacho       LIKE(des1:id_despacho)         !List box control field - type derived from field
des1:peso_total        LIKE(des1:peso_total)          !List box control field - type derived from field
des1:id_despachante    LIKE(des1:id_despachante)      !List box control field - type derived from field
Des2:despachante       LIKE(Des2:despachante)         !List box control field - type derived from field
des1:importe           LIKE(des1:importe)             !List box control field - type derived from field
des1:cant_viajes       LIKE(des1:cant_viajes)         !List box control field - type derived from field
Des2:id_despachante    LIKE(Des2:id_despachante)      !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseDespachoAduanero'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(33,82,465,163),USE(?Browse:1),HVSCROLL,FORMAT('64R(2)|M~Id Despacho~C(0)@n-14@7' & |
  '6D(24)|M~Peso total~C(0)@n-17.2@0R(2)|M~Id despachante~C(0)@N-14_@144R(2)|M~Despacha' & |
  'nte~C(0)@s49@64D(24)|M~Importe~C(0)@n-14.2@64R(2)|M~Cant viajes~C(0)@n-14@'),FROM(Queue:Browse:1), |
  IMM,MSG('Browsing the Despacho_aduana file')
                       BUTTON,AT(59,256,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(132,256,25,25),USE(?View:3),ICON('Ver.ico'),FLAT,MSG('Visualiza el registro'),TIP('Visualiza ' & |
  'el registro')
                       BUTTON,AT(205,256,25,25),USE(?Insert:4),ICON('Insertar.ico'),FLAT,MSG('Inserta un Registro'), |
  TIP('Inserta un Registro')
                       BUTTON,AT(277,256,25,25),USE(?Change:4),ICON('Editar.ico'),FLAT,MSG('Modifica el registro'), |
  TIP('Modifica el registro')
                       BUTTON,AT(350,256,25,25),USE(?Delete:4),ICON('Eliminar.ICO'),FLAT,MSG('Elimina un registro'), |
  TIP('Elimina un registro')
                       BUTTON,AT(473,296,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       STRING('Despacho Aduanero'),AT(221,12),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline), |
  TRN
                       BUTTON,AT(423,256,25,25),USE(?Print),ICON('Imprimir.ico'),FLAT,TRN
                       ENTRY(@s49),AT(151,52,177),USE(l:buscador)
                       BUTTON,AT(335,50,16,14),USE(?Browse:Top),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page')
                       BUTTON,AT(351,50,16,14),USE(?Browse:PageUp),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the Prior Page')
                       BUTTON,AT(367,50,16,14),USE(?Browse:Up),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record')
                       BUTTON,AT(383,50,16,14),USE(?Browse:Down),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record')
                       BUTTON,AT(399,50,16,14),USE(?Browse:PageDown),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page')
                       BUTTON,AT(415,50,16,14),USE(?Browse:Bottom),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page')
                       STRING('Buscador'),AT(108,52,41,12),USE(?STRING1:2),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline), |
  TRN
                       BOX,AT(33,39,467,40),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BOX,AT(32,248,467,40),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
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
  GlobalErrors.SetProcedureName('BrowseDespachoAduanero')
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
  BRW1::Toolbar.InitVCR(?Browse:Top, ?Browse:Bottom, ?Browse:PageUp, ?Browse:PageDown, ?Browse:Up, ?Browse:Down, 0)
  BRW1::Toolbar.InitMisc(0, 0)
  SELF.AddItem(BRW1::Toolbar.WindowComponent)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Despachantes.Open                                 ! File Despachantes used by this procedure, so make sure it's RelationManager is open
  Relate:Despacho_aduana.Open                              ! File Despacho_aduana used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Despacho_aduana,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,des1:PK_DESPACHO)                     ! Add the sort order for des1:PK_DESPACHO for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?l:buscador,des1:id_despacho,,BRW1) ! Initialize the browse locator using ?l:buscador using key: des1:PK_DESPACHO , des1:id_despacho
  BRW1.AddField(des1:id_despacho,BRW1.Q.des1:id_despacho)  ! Field des1:id_despacho is a hot field or requires assignment from browse
  BRW1.AddField(des1:peso_total,BRW1.Q.des1:peso_total)    ! Field des1:peso_total is a hot field or requires assignment from browse
  BRW1.AddField(des1:id_despachante,BRW1.Q.des1:id_despachante) ! Field des1:id_despachante is a hot field or requires assignment from browse
  BRW1.AddField(Des2:despachante,BRW1.Q.Des2:despachante)  ! Field Des2:despachante is a hot field or requires assignment from browse
  BRW1.AddField(des1:importe,BRW1.Q.des1:importe)          ! Field des1:importe is a hot field or requires assignment from browse
  BRW1.AddField(des1:cant_viajes,BRW1.Q.des1:cant_viajes)  ! Field des1:cant_viajes is a hot field or requires assignment from browse
  BRW1.AddField(Des2:id_despachante,BRW1.Q.Des2:id_despachante) ! Field Des2:id_despachante is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseDespachoAduanero',QuickWindow)       ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1
  BRW1.PrintProcedure = 2
  BRW1.PrintControl = ?Print
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,des1:PK_DESPACHO)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Despachantes.Close
    Relate:Despacho_aduana.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('BrowseDespachoAduanero',QuickWindow)    ! Save window data to non-volatile store
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
      UpdateDespachoAduanero
      ReportDespachoAduanero
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
    OF ?Print
      GLO:id_despacho=des1:id_despacho
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
!!! Select a Despachantes Record
!!! </summary>
SelectDespachantes PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Despachantes)
                       PROJECT(Des2:id_despachante)
                       PROJECT(Des2:despachante)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
Des2:id_despachante    LIKE(Des2:id_despachante)      !List box control field - type derived from field
Des2:despachante       LIKE(Des2:despachante)         !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,298,252),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('SelectDespachantes'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(28,55,225,113),USE(?Browse:1),HVSCROLL,FORMAT('64R(2)|M~Id despachante~C(0)@n-1' & |
  '4@80L(2)|M~Despachante~L(2)@s49@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the Despac' & |
  'hantes file')
                       BUTTON,AT(21,199,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(228,199,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       STRING('Seleecione el Despachante'),AT(81,17),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
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
  GlobalErrors.SetProcedureName('SelectDespachantes')
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
  Relate:Despachantes.Open                                 ! File Despachantes used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Despachantes,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,Des2:PK_DESPACHANTE)                  ! Add the sort order for Des2:PK_DESPACHANTE for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,Des2:id_despachante,,BRW1)     ! Initialize the browse locator using  using key: Des2:PK_DESPACHANTE , Des2:id_despachante
  BRW1.AddField(Des2:id_despachante,BRW1.Q.Des2:id_despachante) ! Field Des2:id_despachante is a hot field or requires assignment from browse
  BRW1.AddField(Des2:despachante,BRW1.Q.Des2:despachante)  ! Field Des2:despachante is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectDespachantes',QuickWindow)           ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Despachantes.Close
  END
  IF SELF.Opened
    INIMgr.Update('SelectDespachantes',QuickWindow)        ! Save window data to non-volatile store
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
!!! Form Despacho_aduana
!!! </summary>
UpdateDespachoAduanero PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
l:id_viaje           LONG,NAME('"id_viaje"')               !
BRW8::View:Browse    VIEW(Despacho_viajes)
                       PROJECT(Des3:id_viaje)
                       PROJECT(Des3:peso)
                       PROJECT(Des3:fecha_carga_DATE)
                       PROJECT(Des3:id_despacho_viaje)
                       PROJECT(Des3:id_despacho)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
Des3:id_viaje          LIKE(Des3:id_viaje)            !List box control field - type derived from field
Des3:peso              LIKE(Des3:peso)                !List box control field - type derived from field
Des3:fecha_carga_DATE  LIKE(Des3:fecha_carga_DATE)    !List box control field - type derived from field
Des3:id_despacho_viaje LIKE(Des3:id_despacho_viaje)   !Primary key field - type derived from field
Des3:id_despacho       LIKE(Des3:id_despacho)         !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW11::View:Browse   VIEW(Despacho_conceptos)
                       PROJECT(Des4:importe)
                       PROJECT(Des4:observacion)
                       PROJECT(Des4:id_despacho_concepto)
                       PROJECT(Des4:id_despacho)
                       PROJECT(Des4:id_concepto)
                       JOIN(Con1:PK_CONCEPTO,Des4:id_concepto)
                         PROJECT(Con1:concepto)
                         PROJECT(Con1:id_concepto)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
Con1:concepto          LIKE(Con1:concepto)            !List box control field - type derived from field
Des4:importe           LIKE(Des4:importe)             !List box control field - type derived from field
Des4:observacion       LIKE(Des4:observacion)         !List box control field - type derived from field
Des4:id_despacho_concepto LIKE(Des4:id_despacho_concepto) !Primary key field - type derived from field
Des4:id_despacho       LIKE(Des4:id_despacho)         !Browse key field - type derived from field
Con1:id_concepto       LIKE(Con1:id_concepto)         !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::des1:Record LIKE(des1:RECORD),THREAD
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('UpdateDespachoAduanero'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(428,293,25,25),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Acepta los dato' & |
  's y cierra ventana'),TIP('Acepta los datos y cierra ventana'),TRN
                       BUTTON,AT(461,293,25,25),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancela operación'),TIP('Cancela operación'), |
  TRN
                       STRING('Ingreso de despacho aduanero'),AT(193,10),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       ENTRY(@n-14),AT(86,41,64,10),USE(des1:id_despacho),LEFT,READONLY
                       ENTRY(@N-14_),AT(86,79,23,10),USE(des1:id_despachante),LEFT,REQ
                       PROMPT('Despachante<0DH,0AH>'),AT(30,80,52,10),USE(?des1:id_despachante:Prompt),TRN
                       STRING(@s49),AT(134,80,142,10),USE(Des2:despachante),TRN
                       PROMPT('Peso total:'),AT(30,61),USE(?des1:peso_total:Prompt),TRN
                       ENTRY(@N-17~ KG~),AT(86,60,64,10),USE(des1:peso_total),DECIMAL(12),REQ
                       PROMPT('Nro Despacho:'),AT(30,42),USE(?des1:id_despacho:Prompt),TRN
                       BUTTON,AT(114,78,12,12),USE(?CallLookupDespachante),ICON('Lupita.ico'),FLAT,TRN
                       ENTRY(@N~$ ~-14.2),AT(445,267,64,10),USE(des1:importe,,?des1:importe:3),DECIMAL(12),REQ
                       PROMPT('Total:'),AT(422,268),USE(?des1:importe:Prompt:3),TRN
                       ENTRY(@n-14),AT(86,137,64,10),USE(des1:cant_viajes,,?des1:cant_viajes:3),LEFT,REQ
                       PROMPT('Cant viajes:'),AT(30,137),USE(?des1:cant_viajes:Prompt:3),TRN
                       LIST,AT(295,58,215,87),USE(?List),LEFT(1),HVSCROLL,FORMAT('86L|M~Nro Viaje~C(0)@N_20_@7' & |
  '2C|M~Peso~@n-20.0@40C|M~Fecha carga~@d6@'),FROM(Queue:Browse),IMM
                       PROMPT('Viaje:'),AT(299,34,23,10),USE(?GLO:id_viaje:Prompt)
                       ENTRY(@P<<<<<P),AT(319,34,23,10),USE(l:id_viaje),LEFT
                       BUTTON,AT(346,34,12,12),USE(?CallLookupViaje),ICON('Lupita.ico'),FLAT,TRN
                       BUTTON,AT(374,26,25,25),USE(?BtnAgregarViaje),ICON('Insertar.ico'),FLAT,TRN
                       BUTTON,AT(422,26,,25),USE(?BtnEliminar),ICON('Eliminar.ICO'),FLAT,TRN
                       LIST,AT(31,156,478,100),USE(?List:2),LEFT(1),HVSCROLL,FORMAT('200L(2)|M~Concepto~C(0)@s' & |
  '100@76L(2)|M~Importe~D(12)@N~ $~-17_.2@196L(2)|M~Observación~C(0)@s49@'),FROM(Queue:Browse:1), |
  IMM
                       BUTTON,AT(11,302,25,25),USE(?Insert:2),ICON('Insertar.ico'),DISABLE,FLAT,HIDE,TRN
                       BUTTON,AT(54,302,25,25),USE(?Change:2),ICON('Editar.ico'),DISABLE,FLAT,HIDE,TRN
                       BUTTON,AT(95,302,25,25),USE(?Delete:2),ICON('Eliminar.ICO'),DISABLE,FLAT,HIDE,TRN
                       BUTTON,AT(230,273,25,25),USE(?Insert),ICON('Insertar.ico'),FLAT,TRN
                       PROMPT('Importe:'),AT(30,118),USE(?des1:importe:Prompt),TRN
                       ENTRY(@n-14.2),AT(86,118,64,10),USE(des1:total),DECIMAL(12),REQ
                       BUTTON,AT(275,273,25,25),USE(?Delete),ICON('Eliminar.ICO'),FLAT,TRN
                       PROMPT('Procedencia:'),AT(30,99),USE(?pro1:procedencia:Prompt)
                       ENTRY(@N-14_),AT(86,98,23,10),USE(des1:id_procedencia)
                       BUTTON,AT(114,97,12,12),USE(?CallLookupProcedencia),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@s50),AT(134,99,142,10),USE(pro1:procedencia,,?pro1:procedencia:2),TRN
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeCompleted          PROCEDURE(),BYTE,PROC,DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

BRW8                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
ResetFromView          PROCEDURE(),DERIVED
                     END

BRW8::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW11                CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
SetAlerts              PROCEDURE(),DERIVED
                     END

BRW11::Sort0:Locator StepLocatorClass                      ! Default Locator
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
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateDespachoAduanero')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('Des3:id_viaje',Des3:id_viaje)                      ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(des1:Record,History::des1:Record)
  SELF.AddHistoryField(?des1:id_despacho,1)
  SELF.AddHistoryField(?des1:id_despachante,4)
  SELF.AddHistoryField(?des1:peso_total,3)
  SELF.AddHistoryField(?des1:importe:3,5)
  SELF.AddHistoryField(?des1:cant_viajes:3,6)
  SELF.AddHistoryField(?des1:total,7)
  SELF.AddHistoryField(?des1:id_procedencia,2)
  SELF.AddUpdateFile(Access:Despacho_aduana)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  GLO:id_despacho = des1:id_despacho
  Relate:Despacho_aduana.Open                              ! File Despacho_aduana used by this procedure, so make sure it's RelationManager is open
  Relate:Despacho_conceptos.Open                           ! File Despacho_conceptos used by this procedure, so make sure it's RelationManager is open
  Relate:Despacho_viajes.Open                              ! File Despacho_viajes used by this procedure, so make sure it's RelationManager is open
  Relate:SQL.Open                                          ! File SQL used by this procedure, so make sure it's RelationManager is open
  Relate:Viajes.SetOpenRelated()
  Relate:Viajes.Open                                       ! File Viajes used by this procedure, so make sure it's RelationManager is open
  Relate:conceptos_aduana.Open                             ! File conceptos_aduana used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Despacho_aduana
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
  BRW8.Init(?List,Queue:Browse.ViewPosition,BRW8::View:Browse,Queue:Browse,Relate:Despacho_viajes,SELF) ! Initialize the browse manager
  BRW11.Init(?List:2,Queue:Browse:1.ViewPosition,BRW11::View:Browse,Queue:Browse:1,Relate:Despacho_conceptos,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?des1:id_despacho{PROP:ReadOnly} = True
    ?des1:id_despachante{PROP:ReadOnly} = True
    ?des1:peso_total{PROP:ReadOnly} = True
    DISABLE(?CallLookupDespachante)
    ?des1:importe:3{PROP:ReadOnly} = True
    ?des1:cant_viajes:3{PROP:ReadOnly} = True
    ?l:id_viaje{PROP:ReadOnly} = True
    DISABLE(?CallLookupViaje)
    DISABLE(?BtnAgregarViaje)
    DISABLE(?BtnEliminar)
    DISABLE(?Insert:2)
    DISABLE(?Change:2)
    DISABLE(?Delete:2)
    DISABLE(?Insert)
    ?des1:total{PROP:ReadOnly} = True
    DISABLE(?Delete)
    ?des1:id_procedencia{PROP:ReadOnly} = True
    DISABLE(?CallLookupProcedencia)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW8.Q &= Queue:Browse
  BRW8.RetainRow = 0
  BRW8.AddSortOrder(,Des3:UQ_DESPACHO_VIAJE)               ! Add the sort order for Des3:UQ_DESPACHO_VIAJE for sort order 1
  BRW8.AddRange(Des3:id_despacho,des1:id_despacho)         ! Add single value range limit for sort order 1
  BRW8.AddLocator(BRW8::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW8::Sort0:Locator.Init(,Des3:id_viaje,1,BRW8)          ! Initialize the browse locator using  using key: Des3:UQ_DESPACHO_VIAJE , Des3:id_viaje
  BRW8.AddField(Des3:id_viaje,BRW8.Q.Des3:id_viaje)        ! Field Des3:id_viaje is a hot field or requires assignment from browse
  BRW8.AddField(Des3:peso,BRW8.Q.Des3:peso)                ! Field Des3:peso is a hot field or requires assignment from browse
  BRW8.AddField(Des3:fecha_carga_DATE,BRW8.Q.Des3:fecha_carga_DATE) ! Field Des3:fecha_carga_DATE is a hot field or requires assignment from browse
  BRW8.AddField(Des3:id_despacho_viaje,BRW8.Q.Des3:id_despacho_viaje) ! Field Des3:id_despacho_viaje is a hot field or requires assignment from browse
  BRW8.AddField(Des3:id_despacho,BRW8.Q.Des3:id_despacho)  ! Field Des3:id_despacho is a hot field or requires assignment from browse
  BRW11.Q &= Queue:Browse:1
  BRW11.RetainRow = 0
  BRW11.AddSortOrder(,Des4:UQ_DESPACHO_ADUANA)             ! Add the sort order for Des4:UQ_DESPACHO_ADUANA for sort order 1
  BRW11.AddRange(Des4:id_despacho,des1:id_despacho)        ! Add single value range limit for sort order 1
  BRW11.AddLocator(BRW11::Sort0:Locator)                   ! Browse has a locator for sort order 1
  BRW11::Sort0:Locator.Init(,Des4:id_despacho_concepto,1,BRW11) ! Initialize the browse locator using  using key: Des4:UQ_DESPACHO_ADUANA , Des4:id_despacho_concepto
  BRW11.AddField(Con1:concepto,BRW11.Q.Con1:concepto)      ! Field Con1:concepto is a hot field or requires assignment from browse
  BRW11.AddField(Des4:importe,BRW11.Q.Des4:importe)        ! Field Des4:importe is a hot field or requires assignment from browse
  BRW11.AddField(Des4:observacion,BRW11.Q.Des4:observacion) ! Field Des4:observacion is a hot field or requires assignment from browse
  BRW11.AddField(Des4:id_despacho_concepto,BRW11.Q.Des4:id_despacho_concepto) ! Field Des4:id_despacho_concepto is a hot field or requires assignment from browse
  BRW11.AddField(Des4:id_despacho,BRW11.Q.Des4:id_despacho) ! Field Des4:id_despacho is a hot field or requires assignment from browse
  BRW11.AddField(Con1:id_concepto,BRW11.Q.Con1:id_concepto) ! Field Con1:id_concepto is a hot field or requires assignment from browse
  INIMgr.Fetch('UpdateDespachoAduanero',QuickWindow)       ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW11.AskProcedure = 4
  BRW8.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW11.AddToolbarTarget(Toolbar)                          ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  if self.Response = RequestCancelled
      if self.request = InsertRecord
          
          Des3:id_despacho = des1:id_despacho
          set(Des3:FK_DESPACHO,Des3:FK_DESPACHO)
          loop until Access:Despacho_viajes.next() or Des3:id_despacho <> des1:id_despacho
              via:id_viaje = Des3:id_viaje
              Access:Viajes.Fetch(via:PK_viajes)
              via:despachado = 0
              Access:Viajes.Update()
              delete(Despacho_viajes)
          END
  
  
          Des4:id_despacho =des1:id_despacho
          set(Des4:FK_DESPACHO,Des4:FK_DESPACHO)
          loop until Access:Despacho_conceptos.next() or Des4:id_despacho <>des1:id_despacho
              Delete(Despacho_conceptos)
          END
      END
      
  END
  
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Despacho_aduana.Close
    Relate:Despacho_conceptos.Close
    Relate:Despacho_viajes.Close
    Relate:SQL.Close
    Relate:Viajes.Close
    Relate:conceptos_aduana.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateDespachoAduanero',QuickWindow)    ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.PrimeFields PROCEDURE

  CODE
  des1:id_procedencia = 4
  des1:id_despachante = 1
  PARENT.PrimeFields


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  Des2:id_despachante = des1:id_despachante                ! Assign linking field value
  Access:Despachantes.Fetch(Des2:PK_DESPACHANTE)
  pro1:id_procedencia = des1:id_procedencia                ! Assign linking field value
  Access:Procedencias.Fetch(pro1:PK_PROCEDENCIA)
  des1:total = des1:cant_viajes * des1:importe
  PARENT.Reset(Force)


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
    EXECUTE Number
      SelectDespachantes
      SelectViajesDespacho
      SelectProcedencias
      UpdateDespachoConceptos
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
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    OF ?des1:id_despachante
      IF des1:id_despachante OR ?des1:id_despachante{PROP:Req}
        Des2:id_despachante = des1:id_despachante
        IF Access:Despachantes.TryFetch(Des2:PK_DESPACHANTE)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            des1:id_despachante = Des2:id_despachante
          ELSE
            SELECT(?des1:id_despachante)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupDespachante
      ThisWindow.Update
      Des2:id_despachante = des1:id_despachante
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        des1:id_despachante = Des2:id_despachante
      END
      ThisWindow.Reset(1)
    OF ?l:id_viaje
      IF l:id_viaje OR ?l:id_viaje{PROP:Req}
        via:id_viaje = l:id_viaje
        IF Access:Viajes.TryFetch(via:PK_viajes)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            l:id_viaje = via:id_viaje
          ELSE
            SELECT(?l:id_viaje)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupViaje
      ThisWindow.Update
      via:id_viaje = l:id_viaje
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        l:id_viaje = via:id_viaje
      END
      ThisWindow.Reset(1)
    OF ?BtnAgregarViaje
      ThisWindow.Update
      if l:id_viaje <> 0
          via:id_viaje = l:id_viaje
          Access:Viajes.fetch(via:PK_viajes)
      
          Des3:id_despacho = des1:id_despacho
          Des3:id_viaje = l:id_viaje
          Des3:peso = via:peso
          Des3:fecha_carga_DATE = via:fecha_carga_DATE
      
      
          Access:Despacho_viajes.Insert()
      
          SETCURSOR(CURSOR:Wait)
          BRW8.ResetFromFile()
          brw8.ResetFromBuffer()
          ThisWindow.Reset(true)
          SETCURSOR
      END
      
      
      
      
    OF ?BtnEliminar
      ThisWindow.Update
      via:id_viaje = Des3:id_viaje
      Access:Viajes.Fetch(via:PK_viajes)
      via:despachado = 0
      access:viajes.Update()
      delete(Despacho_viajes)
      
      clear(Despacho_viajes)
      
      
      SETCURSOR(CURSOR:Wait)
      BRW8.ResetFromFile()
      brw8.ResetFromBuffer()
      ThisWindow.Reset(true)
      SETCURSOR
    OF ?Insert
      ThisWindow.Update
      set(conceptos_aduana)
      loop until Access:conceptos_aduana.next()
          Des4:id_despacho=des1:id_despacho
          Des4:id_concepto=Con:id_concepto
          Des4:importe=Con:importe
          Des4:observacion=''
          Access:Despacho_conceptos.Insert()
      END
      SETCURSOR(CURSOR:Wait)
      BRW11.ResetfromFile()
      brw11.ResetFromBuffer()
      ThisWindow.Reset(true)
      SETCURSOR
      
      
      
    OF ?Delete
      ThisWindow.Update
      
      Des4:id_despacho = des1:id_despacho
      set(Des4:FK_DESPACHO,Des4:FK_DESPACHO)
      loop until Access:Despacho_conceptos.next() or Des4:id_despacho <> des1:id_despacho
          delete(Despacho_conceptos)
      END
      
      SETCURSOR(CURSOR:Wait)
      BRW11.ResetfromFile()
      brw11.ResetFromBuffer()
      ThisWindow.Reset(true)
      SETCURSOR
    OF ?des1:id_procedencia
      IF des1:id_procedencia OR ?des1:id_procedencia{PROP:Req}
        pro1:id_procedencia = des1:id_procedencia
        IF Access:Procedencias.TryFetch(pro1:PK_PROCEDENCIA)
          IF SELF.Run(3,SelectRecord) = RequestCompleted
            des1:id_procedencia = pro1:id_procedencia
          ELSE
            SELECT(?des1:id_procedencia)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupProcedencia
      ThisWindow.Update
      pro1:id_procedencia = des1:id_procedencia
      IF SELF.Run(3,SelectRecord) = RequestCompleted
        des1:id_procedencia = pro1:id_procedencia
      END
      ThisWindow.Reset(1)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeCompleted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  if self.Request = InsertRecord or self.Request = ChangeRecord
      Des3:id_despacho = des1:id_despacho
      set(Des3:FK_VIAJE,Des3:FK_VIAJE)
      loop until Access:Despacho_viajes.next() or Des3:id_despacho <> des1:id_despacho
          via:id_viaje = Des3:id_viaje
          Access:Viajes.fetch(via:PK_viajes)
          via:despachado = 1
          Access:Viajes.Update()
      END
      
  END
  ReturnValue = PARENT.TakeCompleted()
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
  OF ?CallLookupViaje
    
    
    if globalResponse = RequestCompleted
        via:id_viaje = l:id_viaje
        Access:Viajes.fetch(via:PK_viajes)
        
        Des3:id_despacho = des1:id_despacho
        Des3:id_viaje = l:id_viaje
        Des3:peso = via:peso
        Des3:fecha_carga_DATE = via:fecha_carga_DATE
        sql{PROP:SQL} = 'Select max(id_despacho_viaje)+1 from '&clip(glo:database)&'.dbo.Despacho_viajes'
        next(sql)
        Des3:id_despacho_viaje = SQL:campo1
        
        Access:Despacho_viajes.Insert()
        l:id_viaje = 0
        display(?l:id_viaje)
    
    
        ThisWindow.Reset(true)
    END
    glo:id_procedencia = des1:id_procedencia
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window


BRW8.ResetFromView PROCEDURE

des1:cant_viajes:Cnt LONG                                  ! Count variable for browse totals
des1:peso_total:Sum  REAL                                  ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:Despacho_viajes.SetQuickScan(1)
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
    des1:cant_viajes:Cnt += 1
    des1:peso_total:Sum += Des3:peso
  END
  SELF.View{PROP:IPRequestCount} = 0
  des1:cant_viajes = des1:cant_viajes:Cnt
  des1:peso_total = des1:peso_total:Sum
  PARENT.ResetFromView
  Relate:Despacho_viajes.SetQuickScan(0)
  SETCURSOR()


BRW11.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END


BRW11.ResetFromView PROCEDURE

des1:importe:Sum     REAL                                  ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:Despacho_conceptos.SetQuickScan(1)
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
    des1:importe:Sum += Des4:importe
  END
  SELF.View{PROP:IPRequestCount} = 0
  des1:importe = des1:importe:Sum
  PARENT.ResetFromView
  Relate:Despacho_conceptos.SetQuickScan(0)
  SETCURSOR()


BRW11.SetAlerts PROCEDURE

  CODE
  SELF.EditViaPopup = False
  PARENT.SetAlerts

!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
BrowseDespachantes PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Despachantes)
                       PROJECT(Des2:id_despachante)
                       PROJECT(Des2:despachante)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
Des2:id_despachante    LIKE(Des2:id_despachante)      !List box control field - type derived from field
Des2:despachante       LIKE(Des2:despachante)         !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,158,209),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),RESIZE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseDespachantes'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(8,30,142,113),USE(?Browse:1),HVSCROLL,FORMAT('64R(2)|M~Id despachante~C(0)@n-14' & |
  '@80L(2)|M~Despachante~L(2)@s49@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the Despach' & |
  'antes file')
                       BUTTON,AT(9,147,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(38,147,25,25),USE(?View:3),ICON('Ver.ico'),FLAT,MSG('Visualiza el registro'),TIP('Visualiza ' & |
  'el registro')
                       BUTTON,AT(67,147,25,25),USE(?Insert:4),ICON('Insertar.ico'),FLAT,MSG('Inserta un Registro'), |
  TIP('Inserta un Registro')
                       BUTTON,AT(96,147,25,25),USE(?Change:4),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Modifica el registro'), |
  TIP('Modifica el registro')
                       BUTTON,AT(125,147,25,25),USE(?Delete:4),ICON('Eliminar.ICO'),FLAT,MSG('Elimina un registro'), |
  TIP('Elimina un registro')
                       SHEET,AT(4,4,150,172),USE(?CurrentTab)
                         TAB('&1) ID DESPACHANTE'),USE(?Tab:2)
                         END
                       END
                       BUTTON,AT(100,180,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(129,180,25,25),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('Muestra ve' & |
  'ntana de ayuda'),STD(STD:Help),TIP('Muestra ventana de ayuda')
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
  GlobalErrors.SetProcedureName('BrowseDespachantes')
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
  Relate:Despachantes.Open                                 ! File Despachantes used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Despachantes,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,Des2:PK_DESPACHANTE)                  ! Add the sort order for Des2:PK_DESPACHANTE for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,Des2:id_despachante,,BRW1)     ! Initialize the browse locator using  using key: Des2:PK_DESPACHANTE , Des2:id_despachante
  BRW1.AddField(Des2:id_despachante,BRW1.Q.Des2:id_despachante) ! Field Des2:id_despachante is a hot field or requires assignment from browse
  BRW1.AddField(Des2:despachante,BRW1.Q.Des2:despachante)  ! Field Des2:despachante is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseDespachantes',QuickWindow)           ! Restore window settings from non-volatile store
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
    Relate:Despachantes.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseDespachantes',QuickWindow)        ! Save window data to non-volatile store
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
    UpdateDespachantes
    ReturnValue = GlobalResponse
  END
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
!!! Form Despachantes
!!! </summary>
UpdateDespachantes PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::Des2:Record LIKE(Des2:RECORD),THREAD
QuickWindow          WINDOW('Form Despachantes'),AT(,,280,81),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('UpdateDespachantes'),SYSTEM,WALLPAPER('fondo.jpg')
                       SHEET,AT(4,4,272,44),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('Id despachante:'),AT(8,20),USE(?Des2:id_despachante:Prompt),TRN
                           ENTRY(@n-14),AT(72,20,64,10),USE(Des2:id_despachante),LEFT,REQ
                           PROMPT('Despachante:'),AT(8,34),USE(?Des2:despachante:Prompt),TRN
                           ENTRY(@s49),AT(72,34,200,10),USE(Des2:despachante),UPR,REQ
                         END
                       END
                       BUTTON,AT(193,52,25,25),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Acepta los datos' & |
  ' y cierra ventana'),TIP('Acepta los datos y cierra ventana')
                       BUTTON,AT(222,52,25,25),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancela operación'),TIP('Cancela operación')
                       BUTTON,AT(251,52,25,25),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Mostrar ventana de ayuda'), |
  STD(STD:Help),TIP('Mostrar ventana de ayuda')
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
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateDespachantes')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Des2:id_despachante:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(Des2:Record,History::Des2:Record)
  SELF.AddHistoryField(?Des2:id_despachante,1)
  SELF.AddHistoryField(?Des2:despachante,2)
  SELF.AddUpdateFile(Access:Despachantes)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Despachantes.Open                                 ! File Despachantes used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Despachantes
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
    ?Des2:id_despachante{PROP:ReadOnly} = True
    ?Des2:despachante{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateDespachantes',QuickWindow)           ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Despachantes.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateDespachantes',QuickWindow)        ! Save window data to non-volatile store
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
SelectViajesDespacho PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Viajes)
                       PROJECT(via:id_viaje)
                       PROJECT(via:guia_transporte)
                       PROJECT(via:nro_remito)
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
tra:transportista      LIKE(tra:transportista)        !List box control field - type derived from field
pro1:procedencia       LIKE(pro1:procedencia)         !List box control field - type derived from field
via:guia_transporte    LIKE(via:guia_transporte)      !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
via:nro_remito         LIKE(via:nro_remito)           !List box control field - type derived from field
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
                       LIST,AT(31,74,459,164),USE(?Browse:1),HVSCROLL,FORMAT('62R(2)|M~Id viaje~C(0)@N_20_@112' & |
  'L(2)|M~Transportista~L(0)@s50@124L(2)|M~Procedencia~L(0)@s50@80L(2)|M~Guia Transport' & |
  'e~C(2)@s50@124L(2)|M~Proveedor~C(0)@s50@80L(2)|M~Nro Remito~C(2)@s50@80R(2)|M~Peso~C' & |
  '(0)@n-20.0@80R(2)|M~Fecha carga~C(0)@d6@'),FROM(Queue:Browse:1),IMM,MSG('Browsing th' & |
  'e Viajes file')
                       BUTTON,AT(29,257,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(435,287,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(465,287,25,25),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('Muestra ve' & |
  'ntana de ayuda'),STD(STD:Help),TIP('Muestra ventana de ayuda')
                       STRING('Seleccione Viajes pendientes de despacho'),AT(176,16),USE(?STRING1),FONT('Arial',10, |
  ,FONT:bold+FONT:italic+FONT:underline,CHARSET:ANSI),TRN
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
  GlobalErrors.SetProcedureName('SelectViajesDespacho')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('via:id_procedencia',via:id_procedencia)            ! Added by: BrowseBox(ABC)
  BIND('via:id_viaje',via:id_viaje)                        ! Added by: BrowseBox(ABC)
  BIND('via:guia_transporte',via:guia_transporte)          ! Added by: BrowseBox(ABC)
  BIND('via:nro_remito',via:nro_remito)                    ! Added by: BrowseBox(ABC)
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
  BRW1.AddSortOrder(,via:K_PROCEDENCIA)                    ! Add the sort order for via:K_PROCEDENCIA for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,via:id_viaje,1,BRW1)           ! Initialize the browse locator using  using key: via:K_PROCEDENCIA , via:id_viaje
  BRW1.SetFilter('((via:id_procedencia = 4)  and (via:despachado <<> 1))') ! Apply filter expression to browse
  BRW1.AddField(via:id_viaje,BRW1.Q.via:id_viaje)          ! Field via:id_viaje is a hot field or requires assignment from browse
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
  INIMgr.Fetch('SelectViajesDespacho',QuickWindow)         ! Restore window settings from non-volatile store
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
    INIMgr.Update('SelectViajesDespacho',QuickWindow)      ! Save window data to non-volatile store
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
!!! Form Despacho_conceptos
!!! </summary>
UpdateDespachoConceptos PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::Des4:Record LIKE(Des4:RECORD),THREAD
QuickWindow          WINDOW,AT(,,427,296),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('UpdateDespachoConceptos'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(303,222,25,25),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Acepta los dato' & |
  's y cierra ventana'),TIP('Acepta los datos y cierra ventana')
                       BUTTON,AT(349,222,25,25),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancela operación'),TIP('Cancela operación')
                       ENTRY(@N~ $~-17_.2),AT(111,145,77,10),USE(Des4:importe),DECIMAL(12)
                       ENTRY(@n-14),AT(111,65,64,10),USE(Des4:id_despacho_concepto),RIGHT(1),HIDE,REQ
                       ENTRY(@n-14),AT(111,79,64,10),USE(Des4:id_despacho),LEFT,HIDE
                       PROMPT('Id Despacho:'),AT(23,79),USE(?Des4:id_despacho:Prompt),HIDE,TRN
                       PROMPT('Concepto:'),AT(73,102),USE(?Des4:id_concepto:Prompt),TRN
                       ENTRY(@N-14_),AT(111,102,24,10),USE(Des4:id_concepto),RIGHT(1)
                       PROMPT('Id despacho concepto:'),AT(23,65),USE(?Des4:id_despacho_concepto:Prompt),HIDE,TRN
                       PROMPT('Importe:'),AT(23,145),USE(?Des4:importe:Prompt),TRN
                       PROMPT('Observación:'),AT(29,188),USE(?Des4:observacion:Prompt),TRN
                       ENTRY(@s49),AT(108,188,203,10),USE(Des4:observacion),UPR
                       BUTTON,AT(140,101,12,12),USE(?CallLookup),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@s100),AT(156,102,216,14),USE(Con:concepto,,?Con:concepto:2)
                       STRING('Ingresos de Conceptos '),AT(165,9),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
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
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateDespachoConceptos')
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
  SELF.AddHistoryFile(Des4:Record,History::Des4:Record)
  SELF.AddHistoryField(?Des4:importe,4)
  SELF.AddHistoryField(?Des4:id_despacho_concepto,1)
  SELF.AddHistoryField(?Des4:id_despacho,2)
  SELF.AddHistoryField(?Des4:id_concepto,3)
  SELF.AddHistoryField(?Des4:observacion,5)
  SELF.AddUpdateFile(Access:Despacho_conceptos)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Despacho_conceptos.Open                           ! File Despacho_conceptos used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Despacho_conceptos
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
  Des4:id_despacho = GLO:id_despacho
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?Des4:importe{PROP:ReadOnly} = True
    ?Des4:id_despacho_concepto{PROP:ReadOnly} = True
    ?Des4:id_despacho{PROP:ReadOnly} = True
    ?Des4:id_concepto{PROP:ReadOnly} = True
    ?Des4:observacion{PROP:ReadOnly} = True
    DISABLE(?CallLookup)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateDespachoConceptos',QuickWindow)      ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Despacho_conceptos.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateDespachoConceptos',QuickWindow)   ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  Con:id_concepto = Des4:id_concepto                       ! Assign linking field value
  Access:conceptos_aduana.Fetch(Con:PK_CONCEPTO)
  PARENT.Reset(Force)


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
    BrowseConceptosAduana
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
    OF ?Des4:id_concepto
      IF Des4:id_concepto OR ?Des4:id_concepto{PROP:Req}
        Con:id_concepto = Des4:id_concepto
        IF Access:conceptos_aduana.TryFetch(Con:PK_CONCEPTO)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            Des4:id_concepto = Con:id_concepto
            Des4:importe = Con:importe
          ELSE
            CLEAR(Des4:importe)
            SELECT(?Des4:id_concepto)
            CYCLE
          END
        ELSE
          Des4:importe = Con:importe
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookup
      ThisWindow.Update
      Con:id_concepto = Des4:id_concepto
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        Des4:id_concepto = Con:id_concepto
        Des4:importe = Con:importe
      END
      ThisWindow.Reset(1)
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
!!! Generated from procedure template - Report
!!! Report the Despacho_aduana File
!!! </summary>
ReportDespachoAduanero PROCEDURE 

Progress:Thermometer BYTE                                  !
l:fecha_desde        DATE                                  !
l:fecha_hasta        DATE                                  !
Process:View         VIEW(Despacho_aduana)
                       PROJECT(des1:cant_viajes)
                       PROJECT(des1:id_despacho)
                       PROJECT(des1:importe)
                       PROJECT(des1:peso_total)
                       PROJECT(des1:total)
                       PROJECT(des1:id_despachante)
                       JOIN(Des2:PK_DESPACHANTE,des1:id_despachante)
                         PROJECT(Des2:despachante)
                       END
                     END
ProgressWindow       WINDOW,AT(,,179,86),FONT('Arial',8,COLOR:Black,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,TIMER(1),WALLPAPER('fondo.jpg')
                       PROGRESS,AT(27,25,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(19,11,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(19,40,141,10),USE(?Progress:PctText),CENTER
                       BUTTON,AT(81,54,25,25),USE(?Progress:Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar Reporte'), |
  TIP('Cancelar Reporte')
                     END

Report               REPORT('Despacho_aduana Report'),AT(250,1729,7750,9458),PRE(RPT),PAPER(PAPER:A4),FONT('Arial', |
  8,COLOR:Black,FONT:regular,CHARSET:DEFAULT),THOUS
                       HEADER,AT(250,250,7750,1479),USE(?Header),FONT('Microsoft Sans Serif',8,COLOR:Black,FONT:bold, |
  CHARSET:DEFAULT)
                         STRING('SOLICITUD DE ANTICIPO'),AT(1781,823,3896,220),USE(?ReportTitle),FONT('Arial',10,COLOR:Black, |
  FONT:bold,CHARSET:DEFAULT),CENTER
                         LINE,AT(479,1396,6844,0),USE(?DetailEndLine:4),COLOR(COLOR:Black)
                         STRING('CARGA DE  GAS PROPANO - Despacho Aduanero'),AT(1865,1104,3896,219),USE(?ReportTitle:2), |
  FONT('Arial',10,COLOR:Black,FONT:regular,CHARSET:DEFAULT),CENTER
                         STRING('Gerencia Comercial'),AT(5781,479,1552,219),USE(?ReportTitle:3),FONT('Arial',10,COLOR:Black, |
  FONT:regular+FONT:italic,CHARSET:DEFAULT),CENTER
                         IMAGE('Logo DISTRIGAS Chico.bmp'),AT(437,302,1281,833),USE(?IMAGE1)
                       END
DetailViaje            DETAIL,AT(0,0,8271,1600),USE(?Detail)
                         LINE,AT(1594,1365,0,250),USE(?DetailLine:0),COLOR(COLOR:Black)
                         STRING(@n-17.2),AT(3750,615,1208,219),USE(des1:peso_total),FONT(,,COLOR:Black),LEFT,TRN
                         STRING(@n-14),AT(1854,615,521,219),USE(des1:cant_viajes),FONT(,,COLOR:Black),LEFT,TRN
                         STRING('PREVISIÓN DE VIAJES DESDE'),AT(469,31,1615,229),USE(?HeaderTitle),TRN
                         LINE,AT(1594,1615,4625,0),USE(?DetailEndLine:6),COLOR(COLOR:Black)
                         STRING('Solicito la provisión de '),AT(469,615,1458,219),USE(?ReportTitle:4),FONT('Arial', |
  10,COLOR:Black,FONT:regular,CHARSET:DEFAULT),TRN
                         STRING('viajes equivalentes a '),AT(2437,615,1354,219),USE(?ReportTitle:5),FONT('Arial',10, |
  COLOR:Black,FONT:regular,CHARSET:DEFAULT),CENTER,TRN
                         STRING('KG'),AT(4677,615,312,219),USE(?ReportTitle:6),FONT('Arial',10,COLOR:Black,FONT:regular, |
  CHARSET:DEFAULT),CENTER,TRN
                         STRING('FECHA'),AT(2156,1427,500,187),USE(?HeaderTitle:6),FONT(,,,FONT:bold),TRN
                         STRING('NRO VIAJE'),AT(3604,1427,771,187),USE(?HeaderTitle:7),FONT(,,,FONT:bold),TRN
                         STRING('PESO'),AT(5365,1427,354,187),USE(?HeaderTitle:8),FONT(,,,FONT:bold),TRN
                         LINE,AT(3135,1365,0,250),USE(?DetailLine:0:2),COLOR(COLOR:Black)
                         LINE,AT(4687,1365,0,250),USE(?DetailLine:0:3),COLOR(COLOR:Black)
                         LINE,AT(6229,1365,0,250),USE(?DetailLine:0:4),COLOR(COLOR:Black)
                         LINE,AT(1594,1365,4635,0),USE(?DetailEndLine:7),COLOR(COLOR:Black)
                         STRING(@d6),AT(2073,31),USE(l:fecha_desde),TRN
                         STRING('HASTA'),AT(2729,31,479,229),USE(?HeaderTitle:11),TRN
                         STRING(@d6),AT(3229,31),USE(l:fecha_hasta),TRN
                       END
detailViajesItem       DETAIL,AT(0,0,7750,250),USE(?DETAIL7)
                         LINE,AT(1594,0,0,250),USE(?DetailLine:9),COLOR(COLOR:Black)
                         LINE,AT(3135,0,0,250),USE(?DetailLine:8),COLOR(COLOR:Black)
                         LINE,AT(4687,0,0,250),USE(?DetailLine:7),COLOR(COLOR:Black)
                         LINE,AT(6229,0,0,250),USE(?DetailLine:6),COLOR(COLOR:Black)
                         STRING(@n-14),AT(3750,42,865,177),USE(Des3:id_viaje,,?Des3:id_viaje:2),TRN
                         STRING(@N-17.2~ KG~),AT(5125,31,1031,177),USE(Des3:peso,,?Des3:peso:2),TRN
                         STRING(@d6),AT(2083,42,667,177),USE(Des3:fecha_carga_DATE,,?Des3:fecha_carga_DATE:2),TRN
                         LINE,AT(1604,0,4625,0),USE(?DetailEndLine:3),COLOR(COLOR:Black)
                         LINE,AT(1594,250,4625,0),USE(?DetailEndLine),COLOR(COLOR:Black)
                       END
detailTotalViaje       DETAIL,AT(0,0,7750,615),USE(?DETAIL6)
                         STRING(@N-17.2~ KG~),AT(5125,31,1031,219),USE(des1:peso_total,,?des1:peso_total:2),FONT(,, |
  COLOR:Black,FONT:bold),TRN
                         STRING(@n-14),AT(3750,31,865,219),USE(des1:cant_viajes,,?des1:cant_viajes:2),FONT(,,COLOR:Black, |
  FONT:bold),TRN
                         STRING('TOTAL'),AT(2167,31,500,187),USE(?HeaderTitle:2),FONT(,,,FONT:bold),TRN
                         LINE,AT(1604,0,4625,0),USE(?DetailEndLine:10),COLOR(COLOR:Black)
                         LINE,AT(1594,0,0,250),USE(?DetailLine:0:5),COLOR(COLOR:Black)
                         LINE,AT(3135,0,0,250),USE(?DetailLine:0:6),COLOR(COLOR:Black)
                         LINE,AT(4687,0,0,250),USE(?DetailLine:0:7),COLOR(COLOR:Black)
                         LINE,AT(6229,0,0,250),USE(?DetailLine:0:8),COLOR(COLOR:Black)
                         LINE,AT(1594,250,4630,0),USE(?DetailEndLine:11),COLOR(COLOR:Black)
                       END
detailConcepto         DETAIL,AT(0,0,7750,1550),USE(?DETAIL5)
                         STRING(@s49),AT(2062,604,1990,219),USE(Des2:despachante,,?Des2:despachante:3),FONT(,,COLOR:Black, |
  FONT:bold),CENTER
                         STRING('CONCEPTO'),AT(3000,1344,719,187),USE(?HeaderTitle:14),FONT(,,,FONT:bold),CENTER,TRN
                         STRING('De acuerdo a la planificación para la logística de compra de gas propano, se so' & |
  'licita se genere el pago'),AT(552,323,6562,219),USE(?ReportTitle:12),FONT('Arial',10,COLOR:Black, |
  FONT:regular,CHARSET:DEFAULT)
                         STRING('por anticipo a cuenta de '),AT(562,583,1521,219),USE(?ReportTitle:11),FONT('Arial', |
  10,COLOR:Black,FONT:regular,CHARSET:DEFAULT)
                         BOX,AT(427,208,6906,708),USE(?BOX1:2),COLOR(COLOR:Black),LINEWIDTH(2)
                         STRING('de acuerdo al siguiente detalle:'),AT(4094,583,2083,219),USE(?ReportTitle:10),FONT('Arial', |
  10,COLOR:Black,FONT:regular,CHARSET:DEFAULT)
                         STRING('IMPORTE'),AT(6052,1354,719,187),USE(?HeaderTitle:3),FONT(,,,FONT:bold),CENTER,TRN
                         LINE,AT(427,1302,6885,0),USE(?DetailEndLine:13),COLOR(COLOR:Black)
                         LINE,AT(427,1302,0,250),USE(?DetailLine:15),COLOR(COLOR:Black)
                         LINE,AT(5604,1312,0,250),USE(?DetailLine:14),COLOR(COLOR:Black)
                         LINE,AT(7312,1302,0,250),USE(?DetailLine:5),COLOR(COLOR:Black)
                         LINE,AT(427,1562,6885,0),USE(?DetailEndLine:12),COLOR(COLOR:Black)
                       END
detailConceptoItem     DETAIL,AT(0,0,7750,250),USE(?DETAIL3)
                         STRING(@N~ $~-17_.2),AT(5677,31,1573,177),USE(Des4:importe,,?Des4:importe:3)
                         LINE,AT(437,250,6885,0),USE(?DetailEndLine:17),COLOR(COLOR:Black)
                         LINE,AT(427,0,6885,0),USE(?DetailEndLine:16),COLOR(COLOR:Black)
                         LINE,AT(5604,0,0,250),USE(?DetailLine:20),COLOR(COLOR:Black)
                         STRING(@s100),AT(594,42,4937,177),USE(Con:concepto,,?Con:concepto:3)
                         LINE,AT(7312,0,0,250),USE(?DetailLine:19),COLOR(COLOR:Black)
                         LINE,AT(427,0,0,250),USE(?DetailLine:18),COLOR(COLOR:Black)
                       END
detailConceptoTotal    DETAIL,AT(0,0,7750,250),USE(?DETAIL4)
                         LINE,AT(427,0,6885,0),USE(?DetailEndLine:18),COLOR(COLOR:Black)
                         LINE,AT(5604,0,0,250),USE(?DetailLine:21),COLOR(COLOR:Black)
                         LINE,AT(427,250,6885,0),USE(?DetailEndLine:19),COLOR(COLOR:Black)
                         LINE,AT(427,0,0,250),USE(?DetailLine:22),COLOR(COLOR:Black)
                         LINE,AT(7312,0,0,250),USE(?DetailLine:23),COLOR(COLOR:Black)
                         STRING('TOTAL'),AT(4990,31,500,187),USE(?HeaderTitle:15),FONT(,,,FONT:bold),TRN
                         STRING(@N~$ ~-14.2),AT(5677,21),USE(des1:importe),TRN
                       END
detailImporteAnticipo  DETAIL,AT(0,0,7750,1000),USE(?DETAIL2)
                         STRING('IMPORTE ANTICIPO:'),AT(531,437,1698,187),USE(?HeaderTitle:16),FONT(,12,,FONT:bold), |
  TRN
                         STRING(@N~$ ~-14.2),AT(2292,437,1760),USE(des1:total,,?des1:total:3),FONT(,12,,FONT:bold)
                         BOX,AT(417,302,6906,437),USE(?BOX1),COLOR(COLOR:Black),LINEWIDTH(2)
                       END
detail1                DETAIL,AT(0,0,7750,667),USE(?DETAIL1)
                       END
                       FOOTER,AT(250,11188,7750,250),USE(?Footer)
                         STRING('Fecha:'),AT(115,52,344,135),USE(?ReportDatePrompt:2),FONT('Arial',8,,FONT:regular), |
  TRN
                         STRING('<<-- Date Stamp -->'),AT(490,52,927,135),USE(?ReportDateStamp:2),FONT('Arial',8,,FONT:regular), |
  TRN
                         STRING('Hora:'),AT(1281,52,271,135),USE(?ReportTimePrompt:2),FONT('Arial',8,,FONT:regular), |
  TRN
                         STRING('<<-- Time Stamp -->'),AT(1583,52,927,135),USE(?ReportTimeStamp:2),FONT('Arial',8,, |
  FONT:regular),TRN
                         STRING(@pPágina <<#p),AT(6950,52,700,135),USE(?PageCount:2),FONT('Arial',8,,FONT:regular), |
  PAGENO
                       END
                       FORM,AT(250,250,7750,11188),USE(?Form),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT)
                         IMAGE,AT(-52,31,7750,11188),USE(?FormImage),TILED
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
  GlobalErrors.SetProcedureName('ReportDespachoAduanero')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:Despacho_aduana.Open                              ! File Despacho_aduana used by this procedure, so make sure it's RelationManager is open
  Relate:Despacho_conceptos.Open                           ! File Despacho_conceptos used by this procedure, so make sure it's RelationManager is open
  Relate:Despacho_viajes.Open                              ! File Despacho_viajes used by this procedure, so make sure it's RelationManager is open
  Relate:Despacho_viajesAlias1.Open                        ! File Despacho_viajesAlias1 used by this procedure, so make sure it's RelationManager is open
  Relate:Viajes.SetOpenRelated()
  Relate:Viajes.Open                                       ! File Viajes used by this procedure, so make sure it's RelationManager is open
  Relate:conceptos_aduana.Open                             ! File conceptos_aduana used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('ReportDespachoAduanero',ProgressWindow)    ! Restore window settings from non-volatile store
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:Despacho_aduana, ?Progress:PctText, Progress:Thermometer, ProgressMgr, des1:id_despacho)
  ThisReport.AddSortOrder(des1:PK_DESPACHO)
  ThisReport.AddRange(des1:id_despacho)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:Despacho_aduana.SetQuickScan(1,Propagate:OneMany)
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  Previewer.Maximize = True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Despacho_aduana.Close
    Relate:Despacho_conceptos.Close
    Relate:Despacho_viajes.Close
    Relate:Despacho_viajesAlias1.Close
    Relate:Viajes.Close
    Relate:conceptos_aduana.Close
  END
  IF SELF.Opened
    INIMgr.Update('ReportDespachoAduanero',ProgressWindow) ! Save window data to non-volatile store
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
  
  clear(Des31:RECORD)
  Des31:id_despacho = des1:id_despacho
  set(Des31:FK_DESPACHO,Des31:FK_DESPACHO)
  l:fecha_desde = 0
  l:fecha_hasta = 0
  
  loop until Access:Despacho_viajesAlias1.next() or Des31:id_despacho <> des1:id_despacho
      if l:fecha_desde = 0
          l:fecha_desde = Des31:fecha_carga_DATE
      END
      
      if l:fecha_hasta = 0
          l:fecha_hasta = Des31:fecha_carga_DATE
      END
      
       if l:fecha_desde > Des31:fecha_carga_DATE
          l:fecha_desde = Des31:fecha_carga_DATE
          END
      
      if l:fecha_hasta < Des31:fecha_carga_DATE
          l:fecha_hasta = Des31:fecha_carga_DATE
      END
      
  END
  
  print(RPT:DetailViaje)
  
  
  
  
  clear(Des3:RECORD)
  Des3:id_despacho = des1:id_despacho
  set(Des3:FK_DESPACHO,Des3:FK_DESPACHO)
  loop until Access:Despacho_viajes.next() or Des3:id_despacho <> des1:id_despacho
      via:id_viaje= Des3:id_viaje
      Access:Viajes.fetch(via:PK_viajes)
      print(RPT:DetailViajesItem)
  END
  print(RPT:detailTotalViaje)
  print(RPT:detailConcepto)
  
  CLEAR(Des4:record)
  Des4:id_despacho = des1:id_despacho
  SET(Des4:FK_DESPACHO,Des4:FK_DESPACHO)
  LOOP UNTIL Access:Despacho_conceptos.next() or Des4:id_despacho <> des1:id_despacho
      Con:id_concepto = Des4:id_concepto
      Access:conceptos_aduana.fetch(Con:PK_CONCEPTO)
      print(RPT:detailConceptoItem)
  END
  
  print(RPT:detailConceptoTotal)
  print(RPT:detailimporteAnticipo)
  
  RETURN ReturnValue
  PRINT(RPT:DetailViaje)
  PRINT(RPT:detailViajesItem)
  PRINT(RPT:detailTotalViaje)
  PRINT(RPT:detailConcepto)
  PRINT(RPT:detailConceptoItem)
  PRINT(RPT:detailConceptoTotal)
  PRINT(RPT:detailImporteAnticipo)
  PRINT(RPT:detail1)
  RETURN ReturnValue

