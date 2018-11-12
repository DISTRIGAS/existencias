

   MEMBER('existencias.clw')                               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('BRWEXT.INC'),ONCE

                     MAP
                       INCLUDE('EXISTENCIAS005.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('EXISTENCIAS003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS010.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Form Procedencias
!!! </summary>
UpdateProcedencias PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::pro1:Record LIKE(pro1:RECORD),THREAD
QuickWindow          WINDOW('Form Procedencias'),AT(,,284,90),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,TILED,CENTER,GRAY,IMM,MDI,HLP('UpdateProcedencias'),SYSTEM,WALLPAPER('fondo.jpg')
                       SHEET,AT(4,4,276,44),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('Id Procedencia:'),AT(8,20),USE(?pro1:id_procedencia:Prompt),TRN
                           ENTRY(@P<<<P),AT(72,20,40,10),USE(pro1:id_procedencia),RIGHT(1)
                           PROMPT('Procedencia:'),AT(8,34),USE(?pro1:procedencia:Prompt),TRN
                           ENTRY(@s50),AT(72,34,204,10),USE(pro1:procedencia)
                         END
                       END
                       BUTTON('&Aceptar'),AT(170,52,34,34),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar lo' & |
  's datos y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON('&Cancelar'),AT(208,52,34,34),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       BUTTON('A&yuda'),AT(246,52,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver Ventana de ayuda'), |
  STD(STD:Help),TIP('Ver Ventana de ayuda')
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
  GlobalErrors.SetProcedureName('UpdateProcedencias')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?pro1:id_procedencia:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(pro1:Record,History::pro1:Record)
  SELF.AddHistoryField(?pro1:id_procedencia,1)
  SELF.AddHistoryField(?pro1:procedencia,2)
  SELF.AddUpdateFile(Access:Procedencias)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Procedencias.Open                                 ! File Procedencias used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Procedencias
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
    ?pro1:id_procedencia{PROP:ReadOnly} = True
    ?pro1:procedencia{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateProcedencias',QuickWindow)           ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Procedencias.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateProcedencias',QuickWindow)        ! Save window data to non-volatile store
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
!!! programacion
!!! </summary>
BrowseProgramacion PROCEDURE 

CurrentTab           STRING(80)                            !
buscador             CSTRING(51)                           !
L:ano                LONG                                  !
L:mes                LONG                                  !
L:filtro             STRING(255)                           !
L:id_proveedor       LONG                                  !Identificador interno del proveedor de producto
BRW1::View:Browse    VIEW(programacion)
                       PROJECT(prog:id_programacion)
                       PROJECT(prog:ano)
                       PROJECT(prog:mes)
                       PROJECT(prog:nro_semana)
                       PROJECT(prog:cupo_GLP)
                       PROJECT(prog:cupo_GLP_programado)
                       PROJECT(prog:cupo_GLP_utilizado)
                       PROJECT(prog:cupo_GLP_restante)
                       PROJECT(prog:id_proveedor)
                       JOIN(pro:PK_proveedor,prog:id_proveedor)
                         PROJECT(pro:proveedor)
                         PROJECT(pro:id_proveedor)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
prog:id_programacion   LIKE(prog:id_programacion)     !List box control field - type derived from field
prog:ano               LIKE(prog:ano)                 !List box control field - type derived from field
prog:mes               LIKE(prog:mes)                 !List box control field - type derived from field
prog:nro_semana        LIKE(prog:nro_semana)          !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
prog:cupo_GLP          LIKE(prog:cupo_GLP)            !List box control field - type derived from field
prog:cupo_GLP_programado LIKE(prog:cupo_GLP_programado) !List box control field - type derived from field
prog:cupo_GLP_utilizado LIKE(prog:cupo_GLP_utilizado) !List box control field - type derived from field
prog:cupo_GLP_restante LIKE(prog:cupo_GLP_restante)   !List box control field - type derived from field
pro:id_proveedor       LIKE(pro:id_proveedor)         !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseProgramacion'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(15,98,489,165),USE(?Browse:1),HVSCROLL,FORMAT('28L(2)|M~Id Cupo~L(1)@P<<<<<<<<<<' & |
  '<<P@24L(2)|M~Año~@P<<<<<<<<P@16L(2)|M~Mes~@P<<<<P@29L(2)|M~Semana~@P<<P@85L(2)|M~Pro' & |
  'veedor~C(0)@s50@54R(2)|M~Cupo. Asignado~C(0)@N-12_@80R(2)|M~Programado~C(1)@N20@80R(' & |
  '2)|M~Utilizado~C(1)@N20@80R(2)|M~Restante~C(1)@N20@'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he programacion file')
                       BUTTON,AT(175,292,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Seleccionar e' & |
  'l registro'),TIP('Seleccionar el registro')
                       BUTTON,AT(213,292,25,25),USE(?View:3),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'),TIP('Vizualizar' & |
  ' el registro')
                       BUTTON,AT(251,292,25,25),USE(?Insert:4),ICON('Insertar.ico'),FLAT,MSG('Insertar un registro'), |
  TIP('Insertar un registro')
                       BUTTON,AT(289,292,25,25),USE(?Change:4),ICON('Editar.ico'),FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro')
                       BUTTON,AT(327,292,25,25),USE(?Delete:4),ICON('Eliminar.ICO'),FLAT,MSG('Eliminar el registro'), |
  TIP('Eliminar el registro')
                       BUTTON,AT(465,292,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       STRING('Cupos de Producto'),AT(210,14),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       ENTRY(@s50),AT(113,74,175),USE(buscador)
                       STRING('Buscar'),AT(89,77),USE(?STRING2),TRN
                       BOX,AT(14,30,491,64),USE(?BOX1:3),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       STRING('Año:'),AT(33,43,17,12),USE(?STRING2:2),TRN
                       ENTRY(@n-14),AT(55,42,25),USE(L:ano)
                       ENTRY(@n-14),AT(113,42,19),USE(L:mes)
                       STRING('Mes:'),AT(91,43,17,12),USE(?STRING2:3),TRN
                       BUTTON,AT(457,50,25,25),USE(?BtnFiltrar),ICON('seleccionar.ICO'),FLAT,TRN
                       BOX,AT(14,285,491,38),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BUTTON,AT(289,74,16,14),USE(?Browse:Top),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page'), |
  TRN
                       BUTTON,AT(306,74,16,14),USE(?Browse:PageUp),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the Prior Page'), |
  TRN
                       BUTTON,AT(325,74,16,14),USE(?Browse:Up),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record'), |
  TRN
                       BUTTON,AT(342,74,16,14),USE(?Browse:Down),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record'), |
  TRN
                       BUTTON,AT(361,74,16,14),USE(?Browse:PageDown),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page'), |
  TRN
                       BUTTON,AT(378,74,16,14),USE(?Browse:Bottom),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page'), |
  TRN
                       STRING('Proveedor:'),AT(153,43,39,12),USE(?STRING2:4),TRN
                       ENTRY(@P<<<<<P),AT(190,41,19),USE(L:id_proveedor)
                       BUTTON,AT(213,41,14,14),USE(?CallLookupProveedor),ICON('lupita.ico'),FLAT,TRN
                       STRING(@s50),AT(231,43,207,11),USE(pro2:proveedor),TRN
                       BUTTON,AT(25,292,25,25),USE(?Select),ICON('ver.ico'),FLAT,MSG('Ver viajes relacionados'),TIP('Ver viajes' & |
  ' relacionados')
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
filtrar             ROUTINE
    Brw1.SetFilter('')
    Brw1.applyFilter()
    L:filtro=''
    IF  L:ano <> 0
        IF LEN(clip(L:filtro)) <> 0
            L:filtro = clip(L:filtro)&' AND '
        END
        L:filtro = clip(L:filtro)& ' prog:ano = '&L:ano
        
    END
    
    IF L:mes <> 0
        IF LEN(clip(L:filtro)) <> 0
            L:filtro = clip(L:filtro)&' AND '
        END
        L:filtro = clip(L:filtro)& ' prog:mes = '&L:mes
    END
    
     IF L:id_proveedor <> 0
        IF LEN(clip(L:filtro)) <> 0
            L:filtro = clip(L:filtro)&' AND '
        END
        L:filtro = clip(L:filtro)& ' prog:id_proveedor = '&L:id_proveedor
    END
    
    MESSAGE(clip(L:filtro))
    IF EVALUATE(L:filtro) <> ''
        BRW1.SetFilter(l:filtro)
        BRW1.ApplyFilter()
        BRW1.ResetFromFile()
        BRW1.ResetFromBuffer()
        ThisWindow.Reset(TRUE)
    END
        
    
 EXIT
    

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseProgramacion')
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
  Relate:ProveedoresAlias.Open                             ! File ProveedoresAlias used by this procedure, so make sure it's RelationManager is open
  Relate:parametros.Open                                   ! File parametros used by this procedure, so make sure it's RelationManager is open
  Relate:programacion.Open                                 ! File programacion used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  par:ID_PARAMETRO = 1
  Access:parametros.fetch(par:PK_parametros)
  GLO:glp_x_viaje = par:GLP_X_VIAJE
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:programacion,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,prog:PK_PROGRAMACION)                 ! Add the sort order for prog:PK_PROGRAMACION for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?buscador,prog:id_programacion,1,BRW1) ! Initialize the browse locator using ?buscador using key: prog:PK_PROGRAMACION , prog:id_programacion
  BRW1.AddField(prog:id_programacion,BRW1.Q.prog:id_programacion) ! Field prog:id_programacion is a hot field or requires assignment from browse
  BRW1.AddField(prog:ano,BRW1.Q.prog:ano)                  ! Field prog:ano is a hot field or requires assignment from browse
  BRW1.AddField(prog:mes,BRW1.Q.prog:mes)                  ! Field prog:mes is a hot field or requires assignment from browse
  BRW1.AddField(prog:nro_semana,BRW1.Q.prog:nro_semana)    ! Field prog:nro_semana is a hot field or requires assignment from browse
  BRW1.AddField(pro:proveedor,BRW1.Q.pro:proveedor)        ! Field pro:proveedor is a hot field or requires assignment from browse
  BRW1.AddField(prog:cupo_GLP,BRW1.Q.prog:cupo_GLP)        ! Field prog:cupo_GLP is a hot field or requires assignment from browse
  BRW1.AddField(prog:cupo_GLP_programado,BRW1.Q.prog:cupo_GLP_programado) ! Field prog:cupo_GLP_programado is a hot field or requires assignment from browse
  BRW1.AddField(prog:cupo_GLP_utilizado,BRW1.Q.prog:cupo_GLP_utilizado) ! Field prog:cupo_GLP_utilizado is a hot field or requires assignment from browse
  BRW1.AddField(prog:cupo_GLP_restante,BRW1.Q.prog:cupo_GLP_restante) ! Field prog:cupo_GLP_restante is a hot field or requires assignment from browse
  BRW1.AddField(pro:id_proveedor,BRW1.Q.pro:id_proveedor)  ! Field pro:id_proveedor is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseProgramacion',QuickWindow)           ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 2
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,prog:PK_PROGRAMACION)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ProveedoresAlias.Close
    Relate:parametros.Close
    Relate:programacion.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('BrowseProgramacion',QuickWindow)        ! Save window data to non-volatile store
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
      SelectProveedoresAlias
      UpdateProgramacion
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
    OF ?Select
      GLO:id_programacion = prog:id_programacion
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BtnFiltrar
      ThisWindow.Update
      do filtrar
    OF ?L:id_proveedor
      IF L:id_proveedor OR ?L:id_proveedor{PROP:Req}
        pro2:id_proveedor = L:id_proveedor
        IF Access:ProveedoresAlias.TryFetch(pro2:PK_proveedor)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            L:id_proveedor = pro2:id_proveedor
          ELSE
            SELECT(?L:id_proveedor)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookupProveedor
      ThisWindow.Update
      pro2:id_proveedor = L:id_proveedor
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        L:id_proveedor = pro2:id_proveedor
      END
      ThisWindow.Reset(1)
    OF ?Select
      ThisWindow.Update
      BrowseViajesRelacionadosCupos()
      ThisWindow.Reset
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
!!! Form programacion
!!! </summary>
UpdateProgramacion PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::prog:Record LIKE(prog:RECORD),THREAD
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('UpdateProgramacion'),SYSTEM,WALLPAPER('fondo.jpg')
                       ENTRY(@P<<<<<<P),AT(119,43,40,10),USE(prog:id_programacion),RIGHT(1),READONLY
                       ENTRY(@P<<<<<P),AT(119,67,40,10),USE(prog:id_proveedor),RIGHT(1),OVR,MSG('Identificador' & |
  ' interno del proveedor de producto'),REQ,TIP('Identificador interno del proveedor de producto')
                       BUTTON,AT(173,65,12,12),USE(?CallLookupProveedor),ICON('Lupita.ico'),FLAT,TRN
                       ENTRY(@P<<<<P),AT(119,91,40,10),USE(prog:ano),RIGHT(1),REQ
                       ENTRY(@P<<P),AT(119,115,40,10),USE(prog:mes),RIGHT(1),REQ
                       ENTRY(@P<P),AT(119,139,40,10),USE(prog:nro_semana),RIGHT(1)
                       ENTRY(@N-20_),AT(119,161,60),USE(prog:cupo_GLP),REQ
                       BUTTON,AT(435,290,25,25),USE(?AceptarProgramacion),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar lo' & |
  's datos y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON,AT(472,290,25,25),USE(?CancelarProgramacion),ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       PROMPT('Proveedor:'),AT(56,68),USE(?prog:id_proveedor:Prompt:2),TRN
                       PROMPT('Año:'),AT(56,92),USE(?prog:ano:Prompt:2),TRN
                       PROMPT('Mes:'),AT(56,116),USE(?prog:mes:Prompt:2),TRN
                       PROMPT('Id Cupo:'),AT(56,44),USE(?prog:id_programacion:Prompt:2),TRN
                       PROMPT('Producto Asignado'),AT(56,164),USE(?prog:tn_disp:Prompt:2),TRN
                       PROMPT('Nro semana:'),AT(56,140),USE(?prog:nro_semana:Prompt:2),TRN
                       STRING(@s50),AT(191,68,153,10),USE(pro:proveedor),TRN
                       STRING('Carga de Cupo de Producto'),AT(195,17),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       ENTRY(@N-20_),AT(119,209,60),USE(prog:cupo_GLP_utilizado)
                       ENTRY(@N-20_),AT(119,233,60),USE(prog:cupo_GLP_restante)
                       PROMPT('Cupo restante:'),AT(56,236),USE(?prog:tn_disp:Prompt),TRN
                       PROMPT('Cupo utilizados:'),AT(56,212),USE(?prog:tn_disp:Prompt:3),TRN
                       PROMPT('Cupo Programado:'),AT(56,188),USE(?prog:cupo_GLP_programado:Prompt),TRN
                       ENTRY(@N20_),AT(119,187,60,10),USE(prog:cupo_GLP_programado)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeCompleted          PROCEDURE(),BYTE,PROC,DERIVED
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
  GlobalErrors.SetProcedureName('UpdateProgramacion')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?prog:id_programacion
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(prog:Record,History::prog:Record)
  SELF.AddHistoryField(?prog:id_programacion,1)
  SELF.AddHistoryField(?prog:id_proveedor,2)
  SELF.AddHistoryField(?prog:ano,3)
  SELF.AddHistoryField(?prog:mes,4)
  SELF.AddHistoryField(?prog:nro_semana,5)
  SELF.AddHistoryField(?prog:cupo_GLP,6)
  SELF.AddHistoryField(?prog:cupo_GLP_utilizado,8)
  SELF.AddHistoryField(?prog:cupo_GLP_restante,9)
  SELF.AddHistoryField(?prog:cupo_GLP_programado,7)
  SELF.AddUpdateFile(Access:programacion)
  SELF.AddItem(?CancelarProgramacion,RequestCancelled)     ! Add the cancel control to the window manager
  Relate:aux_sql.Open                                      ! File aux_sql used by this procedure, so make sure it's RelationManager is open
  Relate:parametros.Open                                   ! File parametros used by this procedure, so make sure it's RelationManager is open
  Relate:programacion.Open                                 ! File programacion used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:programacion
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.DeleteAction = Delete:Auto                        ! Automatic deletions
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel                      ! No confirm cancel
    SELF.OkControl = ?AceptarProgramacion
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(QuickWindow)                                   ! Open window
  if self.Request = InsertRecord
      DISABLE(?prog:cupo_GLP_restante)
      DISABLE(?prog:cupo_GLP_utilizado)
      DISABLE(?prog:cupo_GLP_programado)
  
  end  
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?prog:id_programacion{PROP:ReadOnly} = True
    ?prog:id_proveedor{PROP:ReadOnly} = True
    DISABLE(?CallLookupProveedor)
    ?prog:ano{PROP:ReadOnly} = True
    ?prog:mes{PROP:ReadOnly} = True
    ?prog:nro_semana{PROP:ReadOnly} = True
    ?prog:cupo_GLP{PROP:ReadOnly} = True
    ?prog:cupo_GLP_utilizado{PROP:ReadOnly} = True
    ?prog:cupo_GLP_restante{PROP:ReadOnly} = True
    ?prog:cupo_GLP_programado{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateProgramacion',QuickWindow)           ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:aux_sql.Close
    Relate:parametros.Close
    Relate:programacion.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateProgramacion',QuickWindow)        ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  pro:id_proveedor = prog:id_proveedor                     ! Assign linking field value
  Access:Proveedores.Fetch(pro:PK_proveedor)
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
    SelectProveedores
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
    OF ?prog:id_proveedor
      IF prog:id_proveedor OR ?prog:id_proveedor{PROP:Req}
        pro:id_proveedor = prog:id_proveedor
        IF Access:Proveedores.TryFetch(pro:PK_proveedor)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            prog:id_proveedor = pro:id_proveedor
          ELSE
            SELECT(?prog:id_proveedor)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupProveedor
      ThisWindow.Update
      pro:id_proveedor = prog:id_proveedor
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        prog:id_proveedor = pro:id_proveedor
      END
      ThisWindow.Reset(1)
    OF ?AceptarProgramacion
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
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
  IF self.Request = InsertRecord
      
      prog:cupo_GLP_restante = prog:cupo_GLP
      prog:cupo_GLP_utilizado = 0
      prog:cupo_GLP_programado = 0
  END
  
  
  ReturnValue = PARENT.TakeCompleted()
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
!!! Seleccionar un registro de Viajes
!!! </summary>
SelectViajesEnTransito PROCEDURE 

CurrentTab           STRING(80)                            !
buscador             CSTRING(51)                           !
BRW1::View:Browse    VIEW(Viajes)
                       PROJECT(via:id_viaje)
                       PROJECT(via:id_localidad)
                       PROJECT(via:fecha_carga_DATE)
                       PROJECT(via:estado)
                       PROJECT(via:nro_remito)
                       PROJECT(via:peso)
                       PROJECT(via:chofer)
                       PROJECT(via:id_proveedor)
                       PROJECT(via:id_procedencia)
                       PROJECT(via:id_transportista)
                       JOIN(pro:PK_proveedor,via:id_proveedor)
                         PROJECT(pro:proveedor)
                         PROJECT(pro:id_proveedor)
                       END
                       JOIN(pro1:PK_PROCEDENCIA,via:id_procedencia)
                         PROJECT(pro1:procedencia)
                         PROJECT(pro1:id_procedencia)
                       END
                       JOIN(tra:PK_TRANSPORTISTA,via:id_transportista)
                         PROJECT(tra:transportista)
                         PROJECT(tra:id_transportista)
                       END
                       JOIN(Loc:PK_localidad,via:id_localidad)
                         PROJECT(Loc:Localidad)
                         PROJECT(Loc:id_localidad)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
via:id_viaje           LIKE(via:id_viaje)             !List box control field - type derived from field
via:id_localidad       LIKE(via:id_localidad)         !List box control field - type derived from field
via:fecha_carga_DATE   LIKE(via:fecha_carga_DATE)     !List box control field - type derived from field
via:estado             LIKE(via:estado)               !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
pro1:procedencia       LIKE(pro1:procedencia)         !List box control field - type derived from field
Loc:Localidad          LIKE(Loc:Localidad)            !List box control field - type derived from field
tra:transportista      LIKE(tra:transportista)        !List box control field - type derived from field
via:nro_remito         LIKE(via:nro_remito)           !List box control field - type derived from field
via:peso               LIKE(via:peso)                 !List box control field - type derived from field
via:chofer             LIKE(via:chofer)               !List box control field - type derived from field
buscador               LIKE(buscador)                 !Browse hot field - type derived from local data
pro:id_proveedor       LIKE(pro:id_proveedor)         !Related join file key field - type derived from field
pro1:id_procedencia    LIKE(pro1:id_procedencia)      !Related join file key field - type derived from field
tra:id_transportista   LIKE(tra:id_transportista)     !Related join file key field - type derived from field
Loc:id_localidad       LIKE(Loc:id_localidad)         !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(0,0,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE, |
  GRAY,IMM,MDI,HLP('SelectViajes'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(10,82,507,194),USE(?Browse:1),HVSCROLL,FORMAT('36D(2)|M~Nro Viaje~R(0)@N20_@0L(' & |
  '2)|M~Id localidad~L(1)@n-14@49R(2)|M~Fecha carga~C(0)@d6@63L(2)|M~Estado~C(0)@s50@80' & |
  'L(2)|M~Proveedor~C(0)@s50@82L(2)|M~Procedencia~C(0)@s50@70L(2)|M~Destino~C(0)@s20@10' & |
  '0L(2)|M~Transportista~C(0)@s50@64L(2)|M~Nro remito~@P####-########P@42D(22)|M~Peso~C' & |
  '(0)@N-20_~ KG~@80L(2)|M~Chofer~@s50@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the Viajes file')
                       BUTTON,AT(223,287,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Seleccionar e' & |
  'l registro'),TIP('Seleccionar el registro')
                       BUTTON,AT(483,287,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       STRING('Seleccione un viaje'),AT(222,15),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       BOX,AT(9,280,509,41),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BOX,AT(9,37,509,41),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BUTTON,AT(267,50,16,14),USE(?Browse:Top),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page'), |
  TRN
                       BUTTON,AT(283,50,16,14),USE(?Browse:PageUp),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the Prior Page'), |
  TRN
                       BUTTON,AT(299,50,16,14),USE(?Browse:Up),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record'), |
  TRN
                       BUTTON,AT(315,50,16,14),USE(?Browse:Down),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record'), |
  TRN
                       BUTTON,AT(331,50,16,14),USE(?Browse:PageDown),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page'), |
  TRN
                       BUTTON,AT(347,50,16,14),USE(?Browse:Bottom),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page'), |
  TRN
                       ENTRY(@s50),AT(117,51),USE(buscador)
                       STRING('Buscador'),AT(83,52,31),USE(?STRING2),TRN
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
  GlobalErrors.SetProcedureName('SelectViajesEnTransito')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('via:id_viaje',via:id_viaje)                        ! Added by: BrowseBox(ABC)
  BIND('via:id_localidad',via:id_localidad)                ! Added by: BrowseBox(ABC)
  BIND('via:nro_remito',via:nro_remito)                    ! Added by: BrowseBox(ABC)
  BIND('buscador',buscador)                                ! Added by: BrowseBox(ABC)
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
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Viajes,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,via:PK_viajes)                        ! Add the sort order for via:PK_viajes for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?buscador,via:id_viaje,1,BRW1)  ! Initialize the browse locator using ?buscador using key: via:PK_viajes , via:id_viaje
  BRW1.SetFilter('((via:estado = ''Programado'' or via:estado=''En Proceso''  ) AND ( NULL(via:anulado) OR via:anulado <<> 1))') ! Apply filter expression to browse
  BRW1.AddField(via:id_viaje,BRW1.Q.via:id_viaje)          ! Field via:id_viaje is a hot field or requires assignment from browse
  BRW1.AddField(via:id_localidad,BRW1.Q.via:id_localidad)  ! Field via:id_localidad is a hot field or requires assignment from browse
  BRW1.AddField(via:fecha_carga_DATE,BRW1.Q.via:fecha_carga_DATE) ! Field via:fecha_carga_DATE is a hot field or requires assignment from browse
  BRW1.AddField(via:estado,BRW1.Q.via:estado)              ! Field via:estado is a hot field or requires assignment from browse
  BRW1.AddField(pro:proveedor,BRW1.Q.pro:proveedor)        ! Field pro:proveedor is a hot field or requires assignment from browse
  BRW1.AddField(pro1:procedencia,BRW1.Q.pro1:procedencia)  ! Field pro1:procedencia is a hot field or requires assignment from browse
  BRW1.AddField(Loc:Localidad,BRW1.Q.Loc:Localidad)        ! Field Loc:Localidad is a hot field or requires assignment from browse
  BRW1.AddField(tra:transportista,BRW1.Q.tra:transportista) ! Field tra:transportista is a hot field or requires assignment from browse
  BRW1.AddField(via:nro_remito,BRW1.Q.via:nro_remito)      ! Field via:nro_remito is a hot field or requires assignment from browse
  BRW1.AddField(via:peso,BRW1.Q.via:peso)                  ! Field via:peso is a hot field or requires assignment from browse
  BRW1.AddField(via:chofer,BRW1.Q.via:chofer)              ! Field via:chofer is a hot field or requires assignment from browse
  BRW1.AddField(buscador,BRW1.Q.buscador)                  ! Field buscador is a hot field or requires assignment from browse
  BRW1.AddField(pro:id_proveedor,BRW1.Q.pro:id_proveedor)  ! Field pro:id_proveedor is a hot field or requires assignment from browse
  BRW1.AddField(pro1:id_procedencia,BRW1.Q.pro1:id_procedencia) ! Field pro1:id_procedencia is a hot field or requires assignment from browse
  BRW1.AddField(tra:id_transportista,BRW1.Q.tra:id_transportista) ! Field tra:id_transportista is a hot field or requires assignment from browse
  BRW1.AddField(Loc:id_localidad,BRW1.Q.Loc:id_localidad)  ! Field Loc:id_localidad is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectViajesEnTransito',QuickWindow)       ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  BRW1.SetOrder('-via:fecha_carga_DATE')
  BRW1.ApplyOrder()
  ThisWindow.Reset(TRUE)
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,via:PK_viajes)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Viajes.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('SelectViajesEnTransito',QuickWindow)    ! Save window data to non-volatile store
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
!!! Procedencias
!!! </summary>
SelectProcedencias PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Procedencias)
                       PROJECT(pro1:id_procedencia)
                       PROJECT(pro1:procedencia)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
pro1:id_procedencia    LIKE(pro1:id_procedencia)      !List box control field - type derived from field
pro1:procedencia       LIKE(pro1:procedencia)         !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,302,254),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseProcedencias'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(44,59,186,104),USE(?Browse:1),HVSCROLL,FORMAT('60L(2)|M~Id Procedencia~L(2)@P<<' & |
  '<<<<P@80L(2)|M~Procedencia~L(2)@s50@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the Pr' & |
  'ocedencias file')
                       BUTTON,AT(17,199,34,34),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Seleccionar el registro'), |
  TIP('Seleccionar el registro')
                       BUTTON,AT(215,199,34,34),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON,AT(253,199,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'),STD(STD:Help), |
  TIP('Ver ventana de ayuda')
                       STRING('Seleccione una procedencia'),AT(82,12),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI)
                     END

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
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
  GlobalErrors.SetProcedureName('SelectProcedencias')
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
  Relate:Procedencias.Open                                 ! File Procedencias used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Procedencias,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,pro1:PK_PROCEDENCIA)                  ! Add the sort order for pro1:PK_PROCEDENCIA for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,pro1:id_procedencia,1,BRW1)    ! Initialize the browse locator using  using key: pro1:PK_PROCEDENCIA , pro1:id_procedencia
  BRW1.AddField(pro1:id_procedencia,BRW1.Q.pro1:id_procedencia) ! Field pro1:id_procedencia is a hot field or requires assignment from browse
  BRW1.AddField(pro1:procedencia,BRW1.Q.pro1:procedencia)  ! Field pro1:procedencia is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectProcedencias',QuickWindow)           ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,pro1:PK_PROCEDENCIA)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Procedencias.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('SelectProcedencias',QuickWindow)        ! Save window data to non-volatile store
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
!!! parametros
!!! </summary>
BrowseParametros PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(parametros)
                       PROJECT(par:ID_PARAMETRO)
                       PROJECT(par:TEMP_DEFECTO)
                       PROJECT(par:DENS_DEFECTO)
                       PROJECT(par:FACTOR_DEFECTO)
                       PROJECT(par:GLP_X_VIAJE)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
par:ID_PARAMETRO       LIKE(par:ID_PARAMETRO)         !List box control field - type derived from field
par:TEMP_DEFECTO       LIKE(par:TEMP_DEFECTO)         !List box control field - type derived from field
par:DENS_DEFECTO       LIKE(par:DENS_DEFECTO)         !List box control field - type derived from field
par:FACTOR_DEFECTO     LIKE(par:FACTOR_DEFECTO)       !List box control field - type derived from field
par:GLP_X_VIAJE        LIKE(par:GLP_X_VIAJE)          !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('parametros'),AT(,,358,218),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('BrowseParametros'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(8,30,342,104),USE(?Browse:1),HVSCROLL,FORMAT('64R(2)|M~ID PARAMETRO~C(0)@n-14@8' & |
  '0D(22)|M~TEMP DEFECTO~C(0)@n-25.2@80D(32)|M~DENS DEFECTO~C(0)@n-24.4@80D(28)|M~FACTO' & |
  'R DEFECTO~C(0)@n-24.4@80D(24)|M~GLP X VIAJE~C(0)@n-25.2@'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he parametros file')
                       BUTTON('&Seleccionar'),AT(164,138,34,34),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona' & |
  'r el registro'),TIP('Seleccionar el registro')
                       BUTTON('&Ver'),AT(202,138,34,34),USE(?View:3),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'), |
  TIP('Vizualizar el registro')
                       BUTTON('&Insertar'),AT(240,138,34,34),USE(?Insert:4),ICON('Insertar.ico'),FLAT,MSG('Insertar u' & |
  'n registro'),TIP('Insertar un registro')
                       BUTTON('E&ditar'),AT(278,138,34,34),USE(?Change:4),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro')
                       BUTTON('&Eliminar'),AT(316,138,34,34),USE(?Delete:4),ICON('Eliminar.ICO'),FLAT,MSG('Eliminar e' & |
  'l registro'),TIP('Eliminar el registro')
                       SHEET,AT(4,4,350,172),USE(?CurrentTab)
                         TAB('&1) PK_parametros'),USE(?Tab:2)
                         END
                       END
                       BUTTON('&Cerrar'),AT(282,180,34,34),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'), |
  TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(320,180,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'), |
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
  GlobalErrors.SetProcedureName('BrowseParametros')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('par:ID_PARAMETRO',par:ID_PARAMETRO)                ! Added by: BrowseBox(ABC)
  BIND('par:TEMP_DEFECTO',par:TEMP_DEFECTO)                ! Added by: BrowseBox(ABC)
  BIND('par:DENS_DEFECTO',par:DENS_DEFECTO)                ! Added by: BrowseBox(ABC)
  BIND('par:FACTOR_DEFECTO',par:FACTOR_DEFECTO)            ! Added by: BrowseBox(ABC)
  BIND('par:GLP_X_VIAJE',par:GLP_X_VIAJE)                  ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:parametros.Open                                   ! File parametros used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:parametros,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,par:PK_parametros)                    ! Add the sort order for par:PK_parametros for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,par:ID_PARAMETRO,,BRW1)        ! Initialize the browse locator using  using key: par:PK_parametros , par:ID_PARAMETRO
  BRW1.AddField(par:ID_PARAMETRO,BRW1.Q.par:ID_PARAMETRO)  ! Field par:ID_PARAMETRO is a hot field or requires assignment from browse
  BRW1.AddField(par:TEMP_DEFECTO,BRW1.Q.par:TEMP_DEFECTO)  ! Field par:TEMP_DEFECTO is a hot field or requires assignment from browse
  BRW1.AddField(par:DENS_DEFECTO,BRW1.Q.par:DENS_DEFECTO)  ! Field par:DENS_DEFECTO is a hot field or requires assignment from browse
  BRW1.AddField(par:FACTOR_DEFECTO,BRW1.Q.par:FACTOR_DEFECTO) ! Field par:FACTOR_DEFECTO is a hot field or requires assignment from browse
  BRW1.AddField(par:GLP_X_VIAJE,BRW1.Q.par:GLP_X_VIAJE)    ! Field par:GLP_X_VIAJE is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseParametros',QuickWindow)             ! Restore window settings from non-volatile store
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
    Relate:parametros.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseParametros',QuickWindow)          ! Save window data to non-volatile store
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
    UpdateParametros
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
!!! Form parametros
!!! </summary>
UpdateParametros PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::par:Record  LIKE(par:RECORD),THREAD
QuickWindow          WINDOW,AT(,,296,235),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('UpdateParametros'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON('&Aceptar'),AT(151,178,34,34),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar lo' & |
  's datos y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON('&Cancelar'),AT(189,178,34,34),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       BUTTON('A&yuda'),AT(227,178,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver Ventana de ayuda'), |
  STD(STD:Help),TIP('Ver Ventana de ayuda')
                       ENTRY(@n-24.4),AT(102,103,104,10),USE(par:FACTOR_DEFECTO)
                       ENTRY(@n-14),AT(74,42,64,10),USE(par:ID_PARAMETRO),DISABLE,HIDE
                       ENTRY(@n-25.2),AT(102,74,104,10),USE(par:TEMP_DEFECTO)
                       PROMPT('TEMP DEFECTO:'),AT(31,74),USE(?par:TEMP_DEFECTO:Prompt),TRN
                       PROMPT('DENS DEFECTO:'),AT(31,89),USE(?par:DENS_DEFECTO:Prompt),TRN
                       ENTRY(@n-24.4),AT(102,89,104,10),USE(par:DENS_DEFECTO)
                       PROMPT('ID PARAMETRO:'),AT(10,42),USE(?par:ID_PARAMETRO:Prompt),DISABLE,HIDE,TRN
                       PROMPT('FACTOR DEFECTO:'),AT(31,103),USE(?par:FACTOR_DEFECTO:Prompt),TRN
                       PROMPT('GLP X VIAJE:'),AT(31,118),USE(?par:GLP_X_VIAJE:Prompt),TRN
                       ENTRY(@n-25.2),AT(102,118,104,10),USE(par:GLP_X_VIAJE)
                       STRING('Parámetros'),AT(125,10),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       PROMPT('COSTO GLP X KG'),AT(31,134),USE(?par:COSTO_GLP:Prompt),TRN
                       ENTRY(@N-25.4),AT(102,133,104,10),USE(par:COSTO_GLP)
                       PROMPT('IVA GLP:'),AT(31,148),USE(?par:IVA_GLP:Prompt),TRN
                       ENTRY(@N-25.`2),AT(102,148,60,10),USE(par:IVA_GLP)
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
    GlobalErrors.Throw(Msg:InsertIllegal)
    RETURN
  OF ChangeRecord
    ActionMessage = 'Record Will Be Changed'
  OF DeleteRecord
    GlobalErrors.Throw(Msg:DeleteIllegal)
    RETURN
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateParametros')
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
  SELF.AddHistoryFile(par:Record,History::par:Record)
  SELF.AddHistoryField(?par:FACTOR_DEFECTO,4)
  SELF.AddHistoryField(?par:ID_PARAMETRO,1)
  SELF.AddHistoryField(?par:TEMP_DEFECTO,2)
  SELF.AddHistoryField(?par:DENS_DEFECTO,3)
  SELF.AddHistoryField(?par:GLP_X_VIAJE,5)
  SELF.AddHistoryField(?par:COSTO_GLP,6)
  SELF.AddHistoryField(?par:IVA_GLP,7)
  SELF.AddUpdateFile(Access:parametros)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:parametros.Open                                   ! File parametros used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:parametros
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.InsertAction = Insert:None                        ! Inserts not allowed
    SELF.DeleteAction = Delete:None                        ! Deletes not allowed
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel+Cancel:Query         ! Confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?par:FACTOR_DEFECTO{PROP:ReadOnly} = True
    ?par:ID_PARAMETRO{PROP:ReadOnly} = True
    ?par:TEMP_DEFECTO{PROP:ReadOnly} = True
    ?par:DENS_DEFECTO{PROP:ReadOnly} = True
    ?par:GLP_X_VIAJE{PROP:ReadOnly} = True
    ?par:COSTO_GLP{PROP:ReadOnly} = True
    ?par:IVA_GLP{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateParametros',QuickWindow)             ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:parametros.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateParametros',QuickWindow)          ! Save window data to non-volatile store
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
!!! Form Mediciones
!!! </summary>
updateMedicionesExistencias PROCEDURE (LONG pid_existencia,LONG pid_planta,LONG pfecha_lectura)

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
L:id_existencia      LONG                                  !
L:id_planta          STRING(20)                            !
l:id_factor_ajuste   LONG,NAME('"id_factor"')              !
l:id_presion         LONG                                  !
l:factor_presion     DECIMAL(7,6)                          !
l:factor_ajuste      DECIMAL(18,4),NAME('"factor_ajuste"') !
L:localidad          STRING(20)                            !
L:nro_planta         STRING(20)                            !
L:fecha_lectura      DATE                                  !
Qdensidades          QUEUE,PRE()                           !
densidad             DECIMAL(7,3)                          !
                     END                                   !
Qtemperaturas        QUEUE,PRE()                           !
temperatura          LONG                                  !
                     END                                   !
Qnivel               QUEUE,PRE()                           !
nivel_regla          DECIMAL(7,2),NAME('"nivel_regla"')    !
volumen_calculado    DECIMAL(18,4),NAME('"volumen_calculado"') !
                     END                                   !
Qpresiones           QUEUE,PRE()                           !
presion              DECIMAL(7,2)                          !
                     END                                   !
BRW7::View:Browse    VIEW(Mediciones_aux)
                       PROJECT(med1:id_tanque)
                       PROJECT(med1:ID_PLANTA)
                       PROJECT(med1:id_factor_densidad)
                       PROJECT(med1:nro_tanque)
                       PROJECT(med1:cap_m3)
                       PROJECT(med1:nivel)
                       PROJECT(med1:volumen_liquido)
                       PROJECT(med1:temperatura)
                       PROJECT(med1:densidad)
                       PROJECT(med1:factor_liquido)
                       PROJECT(med1:volumen_corr_liq)
                       PROJECT(med1:Volumen_vapor)
                       PROJECT(med1:presion)
                       PROJECT(med1:factor_corr_vapor)
                       PROJECT(med1:volumen_corr_vapor)
                       PROJECT(med1:volumen_total)
                       PROJECT(med1:volumen_total_corr)
                       PROJECT(med1:id_medicion)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
med1:id_tanque         LIKE(med1:id_tanque)           !List box control field - type derived from field
med1:ID_PLANTA         LIKE(med1:ID_PLANTA)           !List box control field - type derived from field
med1:id_factor_densidad LIKE(med1:id_factor_densidad) !List box control field - type derived from field
med1:nro_tanque        LIKE(med1:nro_tanque)          !List box control field - type derived from field
med1:cap_m3            LIKE(med1:cap_m3)              !List box control field - type derived from field
med1:nivel             LIKE(med1:nivel)               !List box control field - type derived from field
med1:volumen_liquido   LIKE(med1:volumen_liquido)     !List box control field - type derived from field
med1:temperatura       LIKE(med1:temperatura)         !List box control field - type derived from field
med1:densidad          LIKE(med1:densidad)            !List box control field - type derived from field
med1:factor_liquido    LIKE(med1:factor_liquido)      !List box control field - type derived from field
med1:volumen_corr_liq  LIKE(med1:volumen_corr_liq)    !List box control field - type derived from field
med1:Volumen_vapor     LIKE(med1:Volumen_vapor)       !List box control field - type derived from field
med1:presion           LIKE(med1:presion)             !List box control field - type derived from field
med1:factor_corr_vapor LIKE(med1:factor_corr_vapor)   !List box control field - type derived from field
med1:volumen_corr_vapor LIKE(med1:volumen_corr_vapor) !List box control field - type derived from field
med1:volumen_total     LIKE(med1:volumen_total)       !List box control field - type derived from field
med1:volumen_total_corr LIKE(med1:volumen_total_corr) !List box control field - type derived from field
med1:id_medicion       LIKE(med1:id_medicion)         !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::med:Record  LIKE(med:RECORD),THREAD
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('updateMediciones'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(418,289,34,34),USE(?OK),LEFT,ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Accept dat' & |
  'a and close the window'),TIP('Accept data and close the window')
                       BUTTON,AT(471,289,34,34),USE(?Cancel),LEFT,ICON('Cancelar.ico'),FLAT,MSG('Cancel operation'), |
  TIP('Cancel operation')
                       LIST,AT(7,86,516,176),USE(?List),FONT(,10),HVSCROLL,FORMAT('0L(2)|M~id tanque~L(0)@n-14' & |
  '@E(,0080FF80H,,)0L(2)|M~Planta~L(1)@n-14@E(,00C0FFC0H,,)0L(2)|M~Factor densidad~L(0)' & |
  '@P<<<<<<P@18L(2)|M~Nro~L(0)@P<<<<P@E(,00C0FFC0H,,)28L(2)|M~Cap~L(0)@N-6.2@E(,00C0FFC' & |
  '0H,,)[23L(2)|M~Nivel~L(0)@N-5.2@E(,00C0FFFFH,,)36L(2)|M~Vol.~L(0)@N-8.`4@E(,00C0FFFF' & |
  'H,,)]|~Nivel~[23D(2)|M~C°~D(1)@n-14@E(,0080C0FFH,,)29L(2)|M~Dens.~L(0)@N-6.`3@E(,008' & |
  '0C0FFH,,)36L(2)|M~Factor Ajuste~L(0)@N-8.`4@E(,0080C0FFH,,)36L(2)|M~Vol corr.~L(0)@N' & |
  '-8.`4@E(,0080C0FFH,,)]|~Liquido~[50L(2)|M~Vol.~L(1)@N-12.`6@E(,00FFC0C0H,,)44L(2)|M~' & |
  'Presión~D(0)@n-10.3@E(,00FFC0C0H,,)47L(2)|M~F corr~D(12)@N-10.`6@E(,00FFC0C0H,,)52L(' & |
  '2)|M~V Corr~D(10)@N-12.`6@E(,00FFC0C0H,,)](176)|~Vapor~46L(2)|M~Vol total~D(1)@N-15_' & |
  '`6@E(,00C0E0FFH,,)68L(2)|M~Vol Total Corr~D(1)@n-16.0@E(,00C0E0FFH,,)'),FROM(Queue:Browse), |
  IMM
                       PROMPT('Planta:'),AT(13,67),USE(?med:ID_PLANTA:Prompt),FONT('Arial',,,FONT:bold),TRN
                       PROMPT('Localidad:'),AT(13,50),USE(?GLO:localidad_id:Prompt),FONT('Arial',,,FONT:bold),TRN
                       BUTTON,AT(454,51,31,27),USE(?BtnCargarTanques),ICON('sqbe_wzs.ico'),FLAT,HIDE,TRN
                       BUTTON('&Insert'),AT(169,289,42,12),USE(?Insert),DISABLE,HIDE
                       BUTTON,AT(217,289,34,34),USE(?Change),ICON('Editar.ico'),FLAT,TRN
                       BUTTON('&Delete'),AT(256,289,42,12),USE(?Delete),DISABLE,HIDE
                       PROMPT('Existencia:'),AT(411,267),USE(?GLO:existencia_medicion:Prompt),FONT('Arial',8,,FONT:bold, |
  CHARSET:ANSI),TRN
                       ENTRY(@n-20.0),AT(455,267,60,10),USE(GLO:existencia_medicion),FONT(,8),DECIMAL,COLOR(00F5F5F5h), |
  READONLY
                       STRING('Mediciones de Tanques'),AT(224,17),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       STRING(@s20),AT(54,50,98),USE(L:localidad),FONT('Arial',,,FONT:bold),TRN
                       STRING(@s20),AT(46,67,98),USE(L:nro_planta),FONT('Arial',,,FONT:bold),TRN
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeCompleted          PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
SetQueueRecord         PROCEDURE(),DERIVED
                     END

BRW1::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?List
EditInPlace::med1:nivel CLASS(EditEntryClass)              ! Edit-in-place class for field med1:nivel
TakeEvent              PROCEDURE(UNSIGNED Event),BYTE,DERIVED
                     END

EditInPlace::med1:temperatura CLASS(EditSpinClass)         ! Edit-in-place class for field med1:temperatura
Init                   PROCEDURE(UNSIGNED FieldNumber,UNSIGNED ListBox,*? UseVar),DERIVED
                     END

EditInPlace::med1:densidad CLASS(EditDropListClass)        ! Edit-in-place class for field med1:densidad
CreateControl          PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(UNSIGNED Event),BYTE,DERIVED
                     END

EditInPlace::med1:presion CLASS(EditDropListClass)         ! Edit-in-place class for field med1:presion
CreateControl          PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(UNSIGNED Event),BYTE,DERIVED
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
BuscarFactorliquido  ROUTINE
!    den:temperatura = med1:temperatura
!    den:densidad = med1:densidad
!    IF access:Densidades_Corregidas.Fetch(den:K_temp_Den) <> Level:Benign
!  
!        MESSAGE('No se encontró factor de correccion','Atención',icon:exclamation)
!    ELSE
!        message('temperatura:'&med1:temperatura&' densidad: '&med1:densidad&' factor '&den:factor_ajuste)
!    END
!    
!   
   
    aux_sql{prop:sql} = 'SELECT ID_FACTOR,FACTOR_AJUSTE FROM DENSIDADES_CORREGIDAS WHERE TEMPERATURA = '&BRW1.Q.med1:temperatura&' AND DENSIDAD = '&BRW1.Q.med1:densidad
    NEXT(aux_sql)
    l:id_factor_ajuste = aux:campo1
    l:factor_ajuste = aux:campo2
    EXIT
    
buscarFactorVapor   ROUTINE
    !message('SELECT ID_PRESION,FACTOR_CORRECCION FROM PRESIONES_CORREGIDAS WHERE TEMPERATURA ='&BRW1.Q.med1:temperatura&' AND PRESION ='&BRW1.Q.med1:presion)
    aux_sql{PROP:SQL}='SELECT ID_PRESION,FACTOR_CORRECCION FROM PRESIONES_CORREGIDAS WHERE TEMPERATURA ='&BRW1.Q.med1:temperatura&' AND PRESION ='&BRW1.Q.med1:presion*10
    NEXT(aux_sql)
    l:id_presion = aux:campo1
    l:factor_presion = aux:campo2
   
    
    EXIT
    
CargarQniveles      ROUTINE

    IF tan:id_tanque <>0
        
        niv:idt_tanque = tan:idt_tanques
        set(niv:FK_TANQUE,niv:FK_TANQUE)
        LOOP UNTIL access:Niveles_Volumenes.next() or niv:idt_tanque <> tan:idt_tanques      
            nivel_regla = niv:nivel_regla
            volumen_calculado = niv:volumen_calculado
            ADD(Qnivel)
           
        END
        
    END
    
  EXIT
        
cargarQTemperaturas ROUTINE
    LOOP i# = -15 to 15
        temperatura = i#
        add(Qtemperaturas)
    END
    
    EXIT
    
cargarQpresiones    ROUTINE
    loop i#= 79 to 10 by -1
        presion = i#/10
        add(Qpresiones)
    END
    
    EXIT
    
cargarQDensidades   ROUTINE
    
    loop i# = 0 to 6
        densidad = 0.508 +(i#*0.001)
        add(Qdensidades)
    END
    
        
    EXIT
    
cargarTanques       ROUTINE
 
 cargar# =1
 IF glo:ID_PLANTA <> 0
        IF RECORDS(Mediciones_aux) >0
            IF MESSAGE('¿Desea eliminar las mediciones anteriores?','Atención',ICON:Question,BUTTON:Yes+BUTTON:No) =  BUTTON:Yes 
                SET(Mediciones_aux)
                LOOP UNTIL ACCESS:Mediciones_aux.NEXT()
                    Access:Mediciones_aux.DeleteRecord(0)                
                END
            ELSE
                 cargar#=0
                
            END
        END    
        IF cargar# =1
            set(Mediciones_aux)
            CLEAR(med1:Record)
            CLEAR(tan:record)
            set(Tanques_plantas)
            tan:id_planta = L:id_planta
            SET(tan:K_PLANTA,tan:K_PLANTA)
            access:Tanques_plantas.next()
            tan:id_planta = L:id_planta
            SET(tan:K_PLANTA,tan:K_PLANTA)
           
            LOOP UNTIL access:Tanques_plantas.next() or tan:id_planta <> L:id_planta
             
              med1:id_tanque = tan:id_tanque
              med1:ID_PLANTA = tan:id_planta
              med1:id_localidad = pla:ID_LOCALIDAD
              med1:nro_tanque = tan:nro_tanque
              med1:cap_m3 = tan:cap_m3
              med1:densidad = 0.508 
              med:id_existencia = L:id_existencia
              Access:Mediciones_aux.Insert()

            END
        END
  END
    
    SETCURSOR(CURSOR:Wait)
    BRW1.Resetfromfile()
    BRW1.ResetFromBuffer()
    ThisWindow.reset(true)
    setcursor()
    
 EXIT
    
cargarTanques1       ROUTINE
    set(Mediciones_aux)
    loop until Access:Mediciones_aux.next()
        delete(Mediciones_aux)
    END
   IF ThisWindow.Request = ChangeRecord 
    IF L:id_existencia <> 0
            med:id_existencia = L:id_existencia
            SET(med:FK_EXISTENCIA,med:FK_EXISTENCIA) 
            LOOP UNTIL ACCESS:Mediciones.Next() OR med:id_existencia <> L:id_existencia
                med1:id_medicion = med:id_medicion
                med1:id_existencia = med:id_tanque       
                med1:fecha_lectura_DATE = med:fecha_lectura_DATE
                med1:fecha_lectura_TIME = med:fecha_lectura_TIME
                med1:id_tanque =med:id_tanque
                tan:id_tanque = med:id_tanque
                ACCESS:Tanques_plantas.Fetch(tan:PK_tanques)
                med1:nro_tanque =tan:nro_tanque
                med1:cap_m3 =tan:cap_m3
                med1:nivel =med:nivel
                med1:temperatura =med:temperatura
                med1:presion =med:presion
                med1:densidad =med:densidad
                med1:id_factor_densidad =med:id_factor_densidad
                med1:volumen_liquido =med:volumen_liquido
                med1:factor_liquido =med:factor_liquido
                med1:volumen_corr_liq =med:volumen_corr_liq
                med1:Volumen_vapor =med:Volumen_vapor
                med1:factor_corr_vapor =med:factor_corr_vapor
                med1:volumen_corr_vapor =med:volumen_corr_vapor
                med1:volumen_total =med:volumen_total
                med1:volumen_total_corr =med:volumen_total_corr
                Access:Mediciones_aux.Insert()   
            END   
      END
    END
    
    
    
  EXIT
    

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
  L:id_existencia = pid_existencia
  L:id_planta = pid_planta
  L:fecha_lectura = pfecha_lectura
  GlobalErrors.SetProcedureName('updateMedicionesExistencias')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('med1:nro_tanque',med1:nro_tanque)                  ! Added by: BrowseBox(ABC)
  BIND('med1:id_medicion',med1:id_medicion)                ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(med:Record,History::med:Record)
  SELF.AddUpdateFile(Access:Mediciones)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Densidades_Corregidas.SetOpenRelated()
  Relate:Densidades_Corregidas.Open                        ! File Densidades_Corregidas used by this procedure, so make sure it's RelationManager is open
  Relate:Niveles_Volumenes.SetOpenRelated()
  Relate:Niveles_Volumenes.Open                            ! File Niveles_Volumenes used by this procedure, so make sure it's RelationManager is open
  Relate:aux_sql.Open                                      ! File aux_sql used by this procedure, so make sure it's RelationManager is open
  Access:Localidades_GLP.UseFile                           ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Mediciones
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.DeleteAction = Delete:Auto                        ! Automatic deletions
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel                      ! No confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW7::View:Browse,Queue:Browse,Relate:Mediciones_aux,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    DISABLE(?BtnCargarTanques)
    DISABLE(?Insert)
    DISABLE(?Change)
    DISABLE(?Delete)
    ?GLO:existencia_medicion{PROP:ReadOnly} = True
  END
  BRW1.Q &= Queue:Browse
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AddField(med1:id_tanque,BRW1.Q.med1:id_tanque)      ! Field med1:id_tanque is a hot field or requires assignment from browse
  BRW1.AddField(med1:ID_PLANTA,BRW1.Q.med1:ID_PLANTA)      ! Field med1:ID_PLANTA is a hot field or requires assignment from browse
  BRW1.AddField(med1:id_factor_densidad,BRW1.Q.med1:id_factor_densidad) ! Field med1:id_factor_densidad is a hot field or requires assignment from browse
  BRW1.AddField(med1:nro_tanque,BRW1.Q.med1:nro_tanque)    ! Field med1:nro_tanque is a hot field or requires assignment from browse
  BRW1.AddField(med1:cap_m3,BRW1.Q.med1:cap_m3)            ! Field med1:cap_m3 is a hot field or requires assignment from browse
  BRW1.AddField(med1:nivel,BRW1.Q.med1:nivel)              ! Field med1:nivel is a hot field or requires assignment from browse
  BRW1.AddField(med1:volumen_liquido,BRW1.Q.med1:volumen_liquido) ! Field med1:volumen_liquido is a hot field or requires assignment from browse
  BRW1.AddField(med1:temperatura,BRW1.Q.med1:temperatura)  ! Field med1:temperatura is a hot field or requires assignment from browse
  BRW1.AddField(med1:densidad,BRW1.Q.med1:densidad)        ! Field med1:densidad is a hot field or requires assignment from browse
  BRW1.AddField(med1:factor_liquido,BRW1.Q.med1:factor_liquido) ! Field med1:factor_liquido is a hot field or requires assignment from browse
  BRW1.AddField(med1:volumen_corr_liq,BRW1.Q.med1:volumen_corr_liq) ! Field med1:volumen_corr_liq is a hot field or requires assignment from browse
  BRW1.AddField(med1:Volumen_vapor,BRW1.Q.med1:Volumen_vapor) ! Field med1:Volumen_vapor is a hot field or requires assignment from browse
  BRW1.AddField(med1:presion,BRW1.Q.med1:presion)          ! Field med1:presion is a hot field or requires assignment from browse
  BRW1.AddField(med1:factor_corr_vapor,BRW1.Q.med1:factor_corr_vapor) ! Field med1:factor_corr_vapor is a hot field or requires assignment from browse
  BRW1.AddField(med1:volumen_corr_vapor,BRW1.Q.med1:volumen_corr_vapor) ! Field med1:volumen_corr_vapor is a hot field or requires assignment from browse
  BRW1.AddField(med1:volumen_total,BRW1.Q.med1:volumen_total) ! Field med1:volumen_total is a hot field or requires assignment from browse
  BRW1.AddField(med1:volumen_total_corr,BRW1.Q.med1:volumen_total_corr) ! Field med1:volumen_total_corr is a hot field or requires assignment from browse
  BRW1.AddField(med1:id_medicion,BRW1.Q.med1:id_medicion)  ! Field med1:id_medicion is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('updateMedicionesExistencias',QuickWindow)  ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Densidades_Corregidas.Close
    Relate:Niveles_Volumenes.Close
    Relate:aux_sql.Close
  END
  IF SELF.Opened
    INIMgr.Update('updateMedicionesExistencias',QuickWindow) ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  pla:ID_PLANTA = med:id_planta                            ! Assign linking field value
  Access:Plantas.Fetch(pla:PK__plantas__7D439ABD)
  Loc:id_localidad = pla:ID_LOCALIDAD                      ! Assign linking field value
  Access:Localidades_GLP.Fetch(Loc:PK_localidad)
  PARENT.Reset(Force)


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
    OF ?BtnCargarTanques
      ThisWindow.Update
      IF RECORDS(Mediciones_aux) = 0
          DO cargarTanques
          DO cargarQdensidades
       !   do cargarQtemperaturas
          do cargarQpresiones
          SETCURSOR(CURSOR:Wait)
          brw1.Resetfromfile()
          brw1.ResetFromBuffer()
          ThisWindow.reset(true)
          setcursor()
      END
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
  ReturnValue = PARENT.TakeCompleted()
  IF ReturnValue = Level:Benign
  !    CLEAR(med:RECORD)
  !    med:id_existencia = L:id_existencia
  !    SET(med:FK_EXISTENCIA,med:FK_EXISTENCIA)
  !    LOOP UNTIL ACCESS:MEDICIONES.Next() OR  med:id_existencia <> L:id_existencia
  !        Access:Mediciones.DeleteRecord(0)
  !    END
  !    
  !    
  !    CLEAR(med1:RECORD)
  !    SET(Mediciones_aux)
  !    LOOP UNTIL ACCESS:Mediciones_aux.NEXT()
  !        med:id_tanque = med1:id_tanque
  !        med:ID_PLANTA = L:ID_PLANTA
  !        pla:ID_PLANTA = L:id_planta
  !        Access:Plantas.Fetch(pla:PK__plantas__7D439ABD)
  !        med:id_localidad = pla:ID_LOCALIDAD
  !        med:id_existencia = L:id_existencia
  !        med:fecha_lectura_DATE = L:fecha_lectura
  !        med:fecha_lectura_TIME = clock()
  !        med:nivel = med1:nivel
  !        med:id_nivel = med1:id_nivel
  !        med:temperatura = med1:temperatura
  !        med:presion = med1:presion
  !        med:densidad = med1:densidad
  !        med:id_factor_densidad = med1:id_factor_densidad
  !        med:volumen_liquido = med1:volumen_liquido
  !        med:factor_liquido = med1:factor_liquido
  !        med:volumen_corr_liq = med1:volumen_corr_liq
  !        med:Volumen_vapor = med1:Volumen_vapor
  !        med:factor_corr_vapor = med1:factor_corr_vapor
  !        med:volumen_corr_vapor = med1:volumen_corr_vapor
  !        med:volumen_total = med1:volumen_total
  !        med:volumen_total_corr = med1:volumen_total_corr
  !        
  !        IF ACCESS:Mediciones.Insert() <> Level:Benign
  !            MESSAGE( ' No se puede agregar la medicion','atención')
  !            BREAK
  !        END
          
              
  !   END
      SETCURSOR(CURSOR:Wait)
      brw1.Resetfromfile()
      brw1.ResetFromBuffer()
      ThisWindow.reset(true)
      setcursor()
          
  
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE EVENT()
    OF EVENT:OpenWindow
      !IF GLO:id_planta <> 0
                
          pla:ID_PLANTA = L:id_planta
          access:Plantas.Fetch(pla:PK__plantas__7D439ABD)
          L:nro_planta= pla:NRO_PLANTA
          DISPLAY(?L:nro_planta)
          
          Loc:id_localidad = pla:ID_LOCALIDAD
          access:Localidades_GLP.Fetch(Loc:PK_localidad)
        
          L:localidad = Loc:Localidad
          DISPLAY(?L:localidad)
      !
      
          
      
          SETCURSOR(CURSOR:Wait)
      
          DO cargarQniveles
          DO cargarQdensidades
          DO cargarQtemperaturas
          DO cargarQpresiones
          DO cargarTanques   
          
          brw1.Resetfromfile()
          brw1.ResetFromBuffer()
          ThisWindow.reset(true)
          setcursor()
      !    
      !    POST(EVENT:accepted,?Change)
      !ELSE
      !   
      !    RETURN Level:Fatal
      !END
    END
  ReturnValue = PARENT.TakeWindowEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(,1) ! med1:id_tanque Disable
  SELF.AddEditControl(,2) ! med1:ID_PLANTA Disable
  SELF.AddEditControl(,3) ! med1:id_factor_densidad Disable
  SELF.AddEditControl(,4) ! med1:nro_tanque Disable
  SELF.AddEditControl(,5) ! med1:cap_m3 Disable
  SELF.AddEditControl(EditInPlace::med1:nivel,6)
  SELF.AddEditControl(,7) ! med1:volumen_liquido Disable
  SELF.AddEditControl(EditInPlace::med1:temperatura,8)
  SELF.AddEditControl(EditInPlace::med1:densidad,9)
  SELF.AddEditControl(,10) ! med1:factor_liquido Disable
  SELF.AddEditControl(,11) ! med1:volumen_corr_liq Disable
  SELF.AddEditControl(,12) ! med1:Volumen_vapor Disable
  SELF.AddEditControl(EditInPlace::med1:presion,13)
  SELF.AddEditControl(,14) ! med1:factor_corr_vapor Disable
  SELF.AddEditControl(,15) ! med1:volumen_corr_vapor Disable
  SELF.AddEditControl(,16) ! med1:volumen_total Disable
  SELF.AddEditControl(,17) ! med1:volumen_total_corr Disable
  SELF.TabAction = EIPAction:Always
  SELF.EnterAction = EIPAction:Always
  SELF.DeleteAction = EIPAction:Never
  SELF.FocusLossAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Always+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW1.ResetFromView PROCEDURE

GLO:existencia_medicion:Sum REAL                           ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:Mediciones_aux.SetQuickScan(1)
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
    GLO:existencia_medicion:Sum += med1:volumen_total_corr
  END
  SELF.View{PROP:IPRequestCount} = 0
  GLO:existencia_medicion = GLO:existencia_medicion:Sum
  PARENT.ResetFromView
  Relate:Mediciones_aux.SetQuickScan(0)
  SETCURSOR()


BRW1.SetQueueRecord PROCEDURE

  CODE
  DO cargarQniveles
  PARENT.SetQueueRecord
  


EditInPlace::med1:nivel.TakeEvent PROCEDURE(UNSIGNED Event)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.TakeEvent(Event)
  CASE ReturnValue
  OF EditAction:None orof EditAction:Cancel
  ELSE
      update(Self.Feq)
      tan:id_tanque = BRW1.Q.med1:id_tanque
     ! MESSAGE('Nro tanque:'&BRW1.Q.med1:id_tanque)
      access:Tanques_plantas.Fetch(tan:PK_tanques)
      niv:idt_tanque = tan:idt_tanques
      niv:nivel_regla = BRW1.Q.med1:nivel
      IF  access:Niveles_Volumenes.Fetch(niv:K_NIVEL_REGLA) = Level:Benign
          BRW1.Q.med1:volumen_liquido = niv:volumen_calculado
          med1:id_nivel = niv:id_nivel
      ELSE
          MESSAGE('No se pudo encontrar el volumen de liquido')
      END
      
  !    SET(niv:K_TANQUE,niv:K_TANQUE)
  ! !   MESSAGE(tan:idt_tanques)
  !    LOOP UNTIL access:Niveles_Volumenes.Next() OR niv:idt_tanque <> tan:idt_tanques
  !  !      MESSAGE(BRW1.Q.med1:nivel&' = '&FORMAT(niv:nivel_regla,@N-5.2))
  !        IF BRW1.Q.med1:nivel = FORMAT(niv:nivel_regla,@N-5.2)    
  !            BRW1.Q.med1:volumen_liquido = niv:volumen_calculado
  !    !        MESSAGE(' nivelregla:'&niv:nivel_regla&' .se encontro el vol de liquido:'&niv:volumen_calculado)
  !            BREAK
  !        END
  !        
  !    END
  !    
  !    
  !    
      
  END
  RETURN ReturnValue


EditInPlace::med1:temperatura.Init PROCEDURE(UNSIGNED FieldNumber,UNSIGNED ListBox,*? UseVar)

  CODE
  PARENT.Init(FieldNumber,ListBox,UseVar)
  SELF.FEQ{PROP:RangeLow} = -15
  SELF.FEQ{PROP:RangeHigh} = 15


EditInPlace::med1:densidad.CreateControl PROCEDURE

  CODE
  PARENT.CreateControl
  SELF.FEQ{PROP:From} = Qdensidades
  SELF.FEQ{PROP:Drop} = 10
  SELF.FEQ{PROP:DropWidth} = 0


EditInPlace::med1:densidad.TakeEvent PROCEDURE(UNSIGNED Event)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.TakeEvent(Event)
  !Calcular volumen Liquido
  CASE ReturnValue
  OF EditAction:None orof EditAction:Cancel
  ELSE
      update(Self.Feq)
      DO BuscarFactorliquido
      BRW1.Q.med1:factor_liquido = l:factor_ajuste
      BRW1.Q.med1:id_factor_densidad = l:id_factor_ajuste
      BRW1.Q.med1:volumen_corr_liq =  BRW1.Q.med1:factor_liquido *  BRW1.Q.med1:volumen_liquido
      BRW1.Q.med1:Volumen_vapor = BRW1.Q.med1:cap_m3 - brw1.Q.med1:volumen_liquido
     ! MESSAGE(format(BRW1.Q.med1:cap_m3,@N-12.6)&'-'&format(brw1.Q.med1:volumen_liquido,@N-12.6))
     ! MESSAGE(format(BRW1.Q.med1:Volumen_vapor,@N-12.6))
  END
  RETURN ReturnValue


EditInPlace::med1:presion.CreateControl PROCEDURE

  CODE
  PARENT.CreateControl
  SELF.FEQ{PROP:From} = Qpresiones
  SELF.FEQ{PROP:Drop} = 10
  SELF.FEQ{PROP:DropWidth} = 0


EditInPlace::med1:presion.TakeEvent PROCEDURE(UNSIGNED Event)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.TakeEvent(Event)
  !Calcular Volumen Vapor
  CASE ReturnValue
  OF EditAction:None orof EditAction:Cancel
  ELSE
      update(Self.Feq)
      DO buscarFactorVapor
     
      BRW1.Q.med1:factor_corr_vapor = l:factor_presion
      BRW1.Q.med1:volumen_corr_vapor = BRW1.Q.med1:factor_corr_vapor * BRW1.Q.med1:Volumen_vapor
      
  END
  !Calcular Volumen Total
  CASE ReturnValue
  OF EditAction:None orof EditAction:Cancel
  ELSE
      update(Self.Feq)  
      BRW1.Q.med1:factor_corr_vapor = l:factor_presion
      BRW1.Q.med1:volumen_total = BRW1.Q.med1:volumen_corr_vapor + brw1.Q.med1:volumen_corr_liq
      BRW1.Q.med1:volumen_total_corr =  BRW1.Q.med1:volumen_total * BRW1.Q.med1:densidad * 1000
      
  END
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

