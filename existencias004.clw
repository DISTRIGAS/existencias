

   MEMBER('existencias.clw')                               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('BRWEXT.INC'),ONCE

                     MAP
                       INCLUDE('EXISTENCIAS004.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('EXISTENCIAS003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS005.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS006.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS010.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Form Presiones_corregidas
!!! </summary>
UpdatePresiones_corregidas PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::pre:Record  LIKE(pre:RECORD),THREAD
QuickWindow          WINDOW('Form Presiones_corregidas'),AT(,,158,118),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,TILED,CENTER,GRAY,IMM,MDI,HLP('UpdatePresiones_corregidas'),SYSTEM, |
  WALLPAPER('fondo.jpg')
                       SHEET,AT(4,4,150,72),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('id presion:'),AT(8,20),USE(?pre:id_presion:Prompt),TRN
                           ENTRY(@n-14),AT(84,20,64,10),USE(pre:id_presion),RIGHT(1),REQ
                           PROMPT('Presion:'),AT(8,34),USE(?pre:presion:Prompt),TRN
                           ENTRY(@n-10.3),AT(84,34,48,10),USE(pre:presion),DECIMAL(12)
                           PROMPT('Temperatura:'),AT(8,48),USE(?pre:temperatura:Prompt),TRN
                           ENTRY(@n-14),AT(84,48,64,10),USE(pre:temperatura)
                           PROMPT('Factor corrección:'),AT(8,62),USE(?pre:factor_correccion:Prompt),TRN
                           ENTRY(@n-9.6),AT(84,62,44,10),USE(pre:factor_correccion),DECIMAL(12)
                         END
                       END
                       BUTTON('&Aceptar'),AT(44,80,34,34),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar lo' & |
  's datos y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON('&Cancelar'),AT(82,80,34,34),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       BUTTON('A&yuda'),AT(120,80,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver Ventana de ayuda'), |
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
  GlobalErrors.SetProcedureName('UpdatePresiones_corregidas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?pre:id_presion:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(pre:Record,History::pre:Record)
  SELF.AddHistoryField(?pre:id_presion,1)
  SELF.AddHistoryField(?pre:presion,2)
  SELF.AddHistoryField(?pre:temperatura,3)
  SELF.AddHistoryField(?pre:factor_correccion,4)
  SELF.AddUpdateFile(Access:Presiones_corregidas)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Presiones_corregidas.Open                         ! File Presiones_corregidas used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Presiones_corregidas
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
    ?pre:id_presion{PROP:ReadOnly} = True
    ?pre:presion{PROP:ReadOnly} = True
    ?pre:temperatura{PROP:ReadOnly} = True
    ?pre:factor_correccion{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdatePresiones_corregidas',QuickWindow)   ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Presiones_corregidas.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdatePresiones_corregidas',QuickWindow) ! Save window data to non-volatile store
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
!!! Form Localidades_GLP
!!! </summary>
UpdateLocalidades_GLP PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::Loc:Record  LIKE(Loc:RECORD),THREAD
QuickWindow          WINDOW('Form Localidades_GLP'),AT(,,158,90),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,TILED,CENTER,GRAY,IMM,MDI,HLP('UpdateLocalidades_GLP'),SYSTEM,WALLPAPER('fondo.jpg')
                       SHEET,AT(4,4,150,44),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('Id localidad:'),AT(8,20),USE(?Loc:id_localidad:Prompt),TRN
                           ENTRY(@n-14),AT(64,20,64,10),USE(Loc:id_localidad),RIGHT(1),REQ
                           PROMPT('Localidad:'),AT(8,34),USE(?Loc:Localidad:Prompt),TRN
                           ENTRY(@s20),AT(64,34,84,10),USE(Loc:Localidad),UPR,REQ
                         END
                       END
                       BUTTON('&Aceptar'),AT(44,52,34,34),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar lo' & |
  's datos y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON('&Cancelar'),AT(82,52,34,34),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       BUTTON('A&yuda'),AT(120,52,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver Ventana de ayuda'), |
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
  GlobalErrors.SetProcedureName('UpdateLocalidades_GLP')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Loc:id_localidad:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(Loc:Record,History::Loc:Record)
  SELF.AddHistoryField(?Loc:id_localidad,1)
  SELF.AddHistoryField(?Loc:Localidad,2)
  SELF.AddUpdateFile(Access:Localidades_GLP)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Localidades_GLP.Open                              ! File Localidades_GLP used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Localidades_GLP
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
    ?Loc:id_localidad{PROP:ReadOnly} = True
    ?Loc:Localidad{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateLocalidades_GLP',QuickWindow)        ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
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
    INIMgr.Update('UpdateLocalidades_GLP',QuickWindow)     ! Save window data to non-volatile store
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
!!! Form Viajes
!!! </summary>
UpdateProgramarViajes PROCEDURE 

CurrentTab           STRING(80)                            !
l:semana             LONG                                  !
L:Peso_anterior      DECIMAL(7,2)                          !
L:ID_PROGRAMACION    LONG                                  !
ActionMessage        CSTRING(40)                           !
History::via:Record  LIKE(via:RECORD),THREAD
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('UpdateViajes'),SYSTEM,WALLPAPER('fondo.jpg')
                       ENTRY(@P<<<<<<P),AT(106,49,40,12),USE(via:id_viaje),DISABLE,HIDE
                       ENTRY(@P<<<<<P),AT(106,109,21,12),USE(via:id_proveedor),RIGHT(1),OVR,MSG('Identificador' & |
  ' interno del proveedor de producto'),REQ,TIP('Identificador interno del proveedor de producto')
                       BUTTON,AT(139,111,11,11),USE(?CallLookupProveedor),ICON('Lupita.ico'),FLAT,TRN
                       ENTRY(@d6),AT(106,140,48,12),USE(via:fecha_carga_DATE),REQ
                       BUTTON,AT(161,137,22,20),USE(?BotonSeleccionFecha),ICON('calen.ico'),FLAT,TRN
                       ENTRY(@N20_),AT(106,232,48,12),USE(via:cap_tk_camion),REQ
                       BUTTON,AT(422,283,25,25),USE(?AceptarViajeProgramado),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar lo' & |
  's datos y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON,AT(459,283,25,25),USE(?CancelarViajeProgramado),ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       PROMPT('Nro Viaje:'),AT(52,51),USE(?via:id_viaje:Prompt),DISABLE,HIDE,TRN
                       PROMPT('Proveedor:'),AT(52,112),USE(?via:id_proveedor:Prompt),TRN
                       PROMPT('Fecha carga:'),AT(52,143),USE(?avia:fecha_carga_DATE:Prompt),TRN
                       PROMPT('Peso estimado:'),AT(52,234),USE(?via:m3_tk_camion:Prompt),TRN
                       STRING('Ingreso de viajes programado'),AT(205,10),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       STRING(@s50),AT(153,110,160,12),USE(pro:proveedor),TRN
                       PROMPT('Kg<0DH,0AH>'),AT(159,233,13,12),USE(?via:peso:Prompt:4),TRN
                       PROMPT('Procedencia:'),AT(52,83),USE(?via:id_procedencia:Prompt),TRN
                       ENTRY(@P<<<<P),AT(106,80,21,12),USE(via:id_procedencia),RIGHT(1),REQ
                       BUTTON,AT(138,82,11,11),USE(?CallLookupProcedencia),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@s50),AT(153,81,160,12),USE(pro1:procedencia),TRN
                       ENTRY(@P<<<<<<P),AT(106,172,27,12),USE(via:id_programacion),REQ
                       BUTTON,AT(145,172,12,12),USE(?CallLookupProgramacion),ICON('Lupita.ico'),FLAT,TRN
                       PROMPT('Cupo Asignado:'),AT(171,175),USE(?prog:cupo_GLP:Prompt),TRN
                       PROMPT('Cupo GLP utilizado:'),AT(171,199),USE(?prog:cupo_GLP_utilizado:Prompt),TRN
                       PROMPT('Cupo GLP restante:'),AT(171,213),USE(?prog:cupo_GLP_restante:Prompt),TRN
                       PROMPT('Programación:'),AT(52,174),USE(?via:m3_tk_camion:Prompt:2),TRN
                       STRING(@N20_),AT(250,175,60),USE(prog:cupo_GLP,,?prog:cupo_GLP:2),TRN
                       STRING(@N20_),AT(250,199,60),USE(prog:cupo_GLP_utilizado,,?prog:cupo_GLP_utilizado:2),FONT(, |
  ,,FONT:regular),TRN
                       STRING(@N20),AT(250,213,60),USE(prog:cupo_GLP_restante),FONT(,,,FONT:regular),TRN
                       PROMPT('Semana:'),AT(187,143),USE(?prog:cupo_GLP:Prompt:2),TRN
                       STRING(@P<<<P),AT(221,143,18,14),USE(l:semana,,?l:semana:2),TRN
                       STRING(@N20_),AT(250,186,60),USE(prog:cupo_GLP_programado),FONT(,,,FONT:regular),TRN
                       PROMPT('Cupo GLP programado:'),AT(171,186),USE(?prog:cupo_GLP_restante:Prompt:2),TRN
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
PrimeUpdate            PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeCompleted          PROCEDURE(),BYTE,PROC,DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Transaction          TransactionManager                    ! Transaction Manager
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
!Valida peso estimado
valildar_peso_camion        ROUTINE
    
if via:cap_tk_camion > prog:cupo_GLP_restante
    message('El peso estimado no puede ser mayor que el cupo restante')
    select(?via:cap_tk_camion)

end

    EXIT
    
calcular_semana     ROUTINE
    GLO:fecha_Desde = DATE(MONTH(via:fecha_carga_DATE),1,YEAR(via:fecha_carga_DATE))  

    l:semana = 1
    loop dia# = GLO:fecha_Desde to via:fecha_carga_DATE by 1
        if dia# %7 = 0
            l:semana += 1
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
  GlobalErrors.SetProcedureName('UpdateProgramarViajes')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?via:id_viaje
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(via:Record,History::via:Record)
  SELF.AddHistoryField(?via:id_viaje,1)
  SELF.AddHistoryField(?via:id_proveedor,5)
  SELF.AddHistoryField(?via:fecha_carga_DATE,11)
  SELF.AddHistoryField(?via:cap_tk_camion,16)
  SELF.AddHistoryField(?via:id_procedencia,2)
  SELF.AddHistoryField(?via:id_programacion,6)
  SELF.AddUpdateFile(Access:Viajes)
  SELF.AddItem(?CancelarViajeProgramado,RequestCancelled)  ! Add the cancel control to the window manager
  IF SELF.Request<>ViewRecord
     Transaction.AddItem(Relate:Viajes,True)
     Transaction.AddItem(Relate:programacion,True)
  END
  Relate:Viajes.SetOpenRelated()
  Relate:Viajes.Open                                       ! File Viajes used by this procedure, so make sure it's RelationManager is open
  Access:programacion.UseFile                              ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Viajes
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
    SELF.OkControl = ?AceptarViajeProgramado
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  if self.Request = ChangeRecord
      L:Peso_anterior = via:cap_tk_camion
  END
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?via:id_viaje{PROP:ReadOnly} = True
    ?via:id_proveedor{PROP:ReadOnly} = True
    DISABLE(?CallLookupProveedor)
    ?via:fecha_carga_DATE{PROP:ReadOnly} = True
    DISABLE(?BotonSeleccionFecha)
    ?via:cap_tk_camion{PROP:ReadOnly} = True
    ?via:id_procedencia{PROP:ReadOnly} = True
    DISABLE(?CallLookupProcedencia)
    ?via:id_programacion{PROP:ReadOnly} = True
    DISABLE(?CallLookupProgramacion)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateProgramarViajes',QuickWindow)        ! Restore window settings from non-volatile store
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
    INIMgr.Update('UpdateProgramarViajes',QuickWindow)     ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.PrimeUpdate PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  IF SELF.Request<>ViewRecord
     ReturnValue = Transaction.Start()
     IF ReturnValue<>Level:Benign THEN
        SELF.Response = RequestCancelled
        RETURN ReturnValue
     END
  END
  ReturnValue = PARENT.PrimeUpdate()
  ! A SELF.Response other than RequestCompleted will rollback the transaction
  IF SELF.Request<>ViewRecord
     Transaction.Finish(CHOOSE(SELF.Response = RequestCompleted,Level:Benign,Level:Fatal))
  END
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  pro:id_proveedor = via:id_proveedor                      ! Assign linking field value
  Access:Proveedores.Fetch(pro:PK_proveedor)
  tra:id_transportista = via:id_transportista              ! Assign linking field value
  Access:Transportistas.Fetch(tra:PK_TRANSPORTISTA)
  pro1:id_procedencia = via:id_procedencia                 ! Assign linking field value
  Access:Procedencias.Fetch(pro1:PK_PROCEDENCIA)
  prog:id_programacion = via:id_programacion               ! Assign linking field value
  Access:programacion.Fetch(prog:PK_PROGRAMACION)
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
      SelectProveedores
      SelectProcedencias
      SelectProgramacion
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
    OF ?CallLookupProgramacion
      glo:ano = year(via:fecha_carga_DATE)
      GLO:mes = MONTH(via:fecha_carga_DATE)
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?via:id_proveedor
      IF via:id_proveedor OR ?via:id_proveedor{PROP:Req}
        pro:id_proveedor = via:id_proveedor
        IF Access:Proveedores.TryFetch(pro:PK_proveedor)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            via:id_proveedor = pro:id_proveedor
            GLO:id_proveedor = pro:id_proveedor
          ELSE
            CLEAR(GLO:id_proveedor)
            SELECT(?via:id_proveedor)
            CYCLE
          END
        ELSE
          GLO:id_proveedor = pro:id_proveedor
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupProveedor
      ThisWindow.Update
      pro:id_proveedor = via:id_proveedor
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        via:id_proveedor = pro:id_proveedor
        GLO:id_proveedor = pro:id_proveedor
      END
      ThisWindow.Reset(1)
    OF ?via:fecha_carga_DATE
      do calcular_semana
      
      prog:ano = year(via:fecha_carga_DATE)
      prog:mes = MONTH(via:fecha_carga_DATE)
      prog:nro_semana = l:semana
      prog:id_proveedor = via:id_proveedor
      
      IF access:programacion.Fetch(prog:K_ANO_MES_SEMAMA_PROVEEDOR) <> Level:Benign
          MESSAGE('No se pudo encontrar la programación: año -'&prog:ano&' mes - '&prog:mes&' semana- '&l:semana)
      ELSE
          
          via:id_programacion = prog:id_programacion
          via:ano = prog:ano
          via:mes = prog:mes
      END
      
      
      
      display(l:semana)
      ThisWindow.Reset(TRUE)
    OF ?BotonSeleccionFecha
      ThisWindow.Update
      do calcular_semana
      
      prog:ano = year(via:fecha_carga_DATE)
      prog:mes = MONTH(via:fecha_carga_DATE)
      prog:nro_semana = l:semana
      prog:id_proveedor = via:id_proveedor
      
      !if access:programacion.Fetch(prog:K_ANO_MES_SEMAMA_PROVEEDOR) <> Level:Benign
      !    MESSAGE('No se pudo encontrar la programación: año -'&prog:ano&' mes - '&prog:mes&' semana- '&l:semana)
      !ELSE
      !    
      !    via:id_programacion = prog:id_programacion
      !    via:ano = prog:ano
      !    via:mes = prog:mes
      !END
      
      
      
      display(l:semana)
      ThisWindow.Reset(TRUE)
      CHANGE(?via:fecha_carga_DATE,bigfec(CONTENTS(?via:fecha_carga_DATE)))
      !DO RefreshWindow
    OF ?AceptarViajeProgramado
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    OF ?via:id_procedencia
      IF via:id_procedencia OR ?via:id_procedencia{PROP:Req}
        pro1:id_procedencia = via:id_procedencia
        IF Access:Procedencias.TryFetch(pro1:PK_PROCEDENCIA)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            via:id_procedencia = pro1:id_procedencia
          ELSE
            SELECT(?via:id_procedencia)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupProcedencia
      ThisWindow.Update
      pro1:id_procedencia = via:id_procedencia
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        via:id_procedencia = pro1:id_procedencia
      END
      ThisWindow.Reset(1)
    OF ?via:id_programacion
      IF via:id_programacion OR ?via:id_programacion{PROP:Req}
        prog:id_programacion = via:id_programacion
        IF Access:programacion.TryFetch(prog:PK_PROGRAMACION)
          IF SELF.Run(3,SelectRecord) = RequestCompleted
            via:id_programacion = prog:id_programacion
          ELSE
            SELECT(?via:id_programacion)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupProgramacion
      ThisWindow.Update
      prog:id_programacion = via:id_programacion
      IF SELF.Run(3,SelectRecord) = RequestCompleted
        via:id_programacion = prog:id_programacion
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
  !Valida los datos
  IF via:cap_tk_camion = 0
      MESSAGE('Ingrese el peso estimado')
      Select(?via:cap_tk_camion)
      CYCLE
      
  END
  IF SELF.Request<>ViewRecord
     ReturnValue = Transaction.Start()
     IF ReturnValue<>Level:Benign THEN RETURN ReturnValue.
  END
  ! Asigna datos al viaje
  IF self.Request = InsertRecord or self.Request = changeRecord
      via:estado = 'Programado'
      via:ano = year(via:fecha_carga_DATE)
      via:mes = month(via:fecha_carga_DATE)
      
  END
  
  IF self.Request = InsertRecord
      via:peso = 0
      via:peso_descargado = 0
  END
  
  ReturnValue = PARENT.TakeCompleted()
  !Actualiza la tabla programacion
   IF ReturnValue = Level:Benign
       prog:id_programacion = via:id_programacion
       IF Access:programacion.fetch(prog:PK_PROGRAMACION) = Level:Benign
              IF SELF.Request = InsertRecord 
                  prog:cupo_GLP_programado += via:cap_tk_camion
              END
              IF self.Request = ChangeRecord
                  prog:cupo_GLP_programado += via:cap_tk_camion-L:Peso_anterior
              END
  
              prog:cupo_GLP_restante = prog:cupo_GLP -(prog:cupo_GLP_utilizado+prog:cupo_GLP_programado)
              if Access:programacion.Update() <> Level:Benign
                  MESSAGE('error en la actualización de la programación:'& Fileerror())
                  Transaction.TransactionRollBack()
               end
        ELSE
            message('No se pudo encontrar la programacion')
            
        END
  END
  
  
  ! A ReturnValue other than Level:Benign will rollback the transaction
  IF SELF.Request<>ViewRecord
     Transaction.Finish(ReturnValue)
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
  ReturnValue = PARENT.TakeFieldEvent()
  CASE FIELD()
  OF ?BotonSeleccionFecha
    
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
!!! Viajes
!!! </summary>
BrowseProgramarViajes PROCEDURE 

CurrentTab           STRING(80)                            !
Buscador             CSTRING(51)                           !
BRW1::View:Browse    VIEW(Viajes)
                       PROJECT(via:id_viaje)
                       PROJECT(via:ano)
                       PROJECT(via:mes)
                       PROJECT(via:fecha_carga_DATE)
                       PROJECT(via:cap_tk_camion)
                       PROJECT(via:id_transportista)
                       PROJECT(via:id_proveedor)
                       PROJECT(via:id_procedencia)
                       JOIN(tra:PK_TRANSPORTISTA,via:id_transportista)
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
via:ano                LIKE(via:ano)                  !List box control field - type derived from field
via:mes                LIKE(via:mes)                  !List box control field - type derived from field
pro1:procedencia       LIKE(pro1:procedencia)         !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
via:fecha_carga_DATE   LIKE(via:fecha_carga_DATE)     !List box control field - type derived from field
via:cap_tk_camion      LIKE(via:cap_tk_camion)        !List box control field - type derived from field
tra:id_transportista   LIKE(tra:id_transportista)     !Related join file key field - type derived from field
pro:id_proveedor       LIKE(pro:id_proveedor)         !Related join file key field - type derived from field
pro1:id_procedencia    LIKE(pro1:id_procedencia)      !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseViajes'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(16,75,501,194),USE(?Browse:1),HVSCROLL,FORMAT('40L(2)|M~Id viaje~C(0)@P<<<<<<<<' & |
  '<<<<P@40L(2)|M~Año~C(1)@S4@40L(2)|M~Mes~C(1)@P<<<<P@130L(2)|M~Procedencia~C(0)@s50@1' & |
  '30L(2)|M~Proveedor~C(0)@s50@66R(2)|M~Fecha carga~C(0)@d6@44R(2)|M~Peso estimado~L(0)@N-_10.@'), |
  FROM(Queue:Browse:1),IMM,MSG('Browsing the Viajes file')
                       BUTTON,AT(173,279,25,25),USE(?View:2),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'),TIP('Vizualizar' & |
  ' el registro')
                       BUTTON,AT(211,279,25,25),USE(?Insert:3),ICON('Insertar.ico'),FLAT,MSG('Insertar un registro'), |
  TIP('Insertar un registro')
                       BUTTON,AT(249,279,25,25),USE(?Change:3),ICON('Editar.ico'),FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro')
                       BUTTON,AT(476,2,25,25),USE(?Delete:3),ICON('Eliminar.ICO'),DISABLE,FLAT,HIDE,MSG('Eliminar e' & |
  'l registro'),TIP('Eliminar el registro')
                       BUTTON,AT(461,279,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       STRING('Viajes programados de GLP'),AT(202,12,123),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       BUTTON,AT(44,279,25,25),USE(?Seleccionar),ICON('seleccionar.ICO'),FLAT,TRN
                       BOX,AT(15,273,503,38),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       ENTRY(@s50),AT(131,46,152),USE(Buscador)
                       STRING('Buscador'),AT(95,46),USE(?STRING2),TRN
                       BUTTON,AT(296,46,12,14),USE(?Browse:Top),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page')
                       BUTTON,AT(311,46,12,14),USE(?Browse:PageUp),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the Prior Page')
                       BUTTON,AT(325,46,12,14),USE(?Browse:Up),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record')
                       BUTTON,AT(340,46,12,14),USE(?Browse:Down),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record')
                       BUTTON,AT(355,46,12,14),USE(?Browse:PageDown),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page')
                       BUTTON,AT(371,46,12,14),USE(?Browse:Bottom),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page')
                       BOX,AT(15,32,503,38),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BUTTON,AT(289,279,25,25),USE(?Delete),ICON('Eliminar.ICO'),FLAT,MSG('Eliminar el registro'), |
  TIP('Eliminar el registro')
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
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator

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
  GlobalErrors.SetProcedureName('BrowseProgramarViajes')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('via:id_viaje',via:id_viaje)                        ! Added by: BrowseBox(ABC)
  BIND('via:cap_tk_camion',via:cap_tk_camion)              ! Added by: BrowseBox(ABC)
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
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,via:PK_viajes)                        ! Add the sort order for via:PK_viajes for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?Buscador,via:id_viaje,1,BRW1)  ! Initialize the browse locator using ?Buscador using key: via:PK_viajes , via:id_viaje
  BRW1.SetFilter('(via:estado = ''Programado'' AND via:anulado <<> 1)') ! Apply filter expression to browse
  BRW1.AddField(via:id_viaje,BRW1.Q.via:id_viaje)          ! Field via:id_viaje is a hot field or requires assignment from browse
  BRW1.AddField(via:ano,BRW1.Q.via:ano)                    ! Field via:ano is a hot field or requires assignment from browse
  BRW1.AddField(via:mes,BRW1.Q.via:mes)                    ! Field via:mes is a hot field or requires assignment from browse
  BRW1.AddField(pro1:procedencia,BRW1.Q.pro1:procedencia)  ! Field pro1:procedencia is a hot field or requires assignment from browse
  BRW1.AddField(pro:proveedor,BRW1.Q.pro:proveedor)        ! Field pro:proveedor is a hot field or requires assignment from browse
  BRW1.AddField(via:fecha_carga_DATE,BRW1.Q.via:fecha_carga_DATE) ! Field via:fecha_carga_DATE is a hot field or requires assignment from browse
  BRW1.AddField(via:cap_tk_camion,BRW1.Q.via:cap_tk_camion) ! Field via:cap_tk_camion is a hot field or requires assignment from browse
  BRW1.AddField(tra:id_transportista,BRW1.Q.tra:id_transportista) ! Field tra:id_transportista is a hot field or requires assignment from browse
  BRW1.AddField(pro:id_proveedor,BRW1.Q.pro:id_proveedor)  ! Field pro:id_proveedor is a hot field or requires assignment from browse
  BRW1.AddField(pro1:id_procedencia,BRW1.Q.pro1:id_procedencia) ! Field pro1:id_procedencia is a hot field or requires assignment from browse
  INIMgr.Fetch('BrowseProgramarViajes',QuickWindow)        ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1
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
    INIMgr.Update('BrowseProgramarViajes',QuickWindow)     ! Save window data to non-volatile store
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
    UpdateProgramarViajes
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
    OF ?Delete
      ThisWindow.Update
      AnularViajeProgramado(via:id_viaje)
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
BrowseProcedencias PROCEDURE 

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
                       LIST,AT(50,53,186,104),USE(?Browse:1),HVSCROLL,FORMAT('60L(2)|M~Id Procedencia~L(2)@P<<' & |
  '<<<<P@80L(2)|M~Procedencia~L(2)@s50@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the Pr' & |
  'ocedencias file')
                       BUTTON('&Seleccionar'),AT(17,199,34,34),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona' & |
  'r el registro'),TIP('Seleccionar el registro')
                       BUTTON('&Ver'),AT(55,199,34,34),USE(?View:3),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'), |
  TIP('Vizualizar el registro')
                       BUTTON('&Insertar'),AT(93,199,34,34),USE(?Insert:4),ICON('Insertar.ico'),FLAT,MSG('Insertar u' & |
  'n registro'),TIP('Insertar un registro')
                       BUTTON('E&ditar'),AT(131,199,34,34),USE(?Change:4),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro')
                       BUTTON('&Eliminar'),AT(169,199,34,34),USE(?Delete:4),ICON('Eliminar.ICO'),FLAT,MSG('Eliminar e' & |
  'l registro'),TIP('Eliminar el registro')
                       BUTTON('&Cerrar'),AT(215,199,34,34),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'), |
  TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(253,199,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'), |
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
  GlobalErrors.SetProcedureName('BrowseProcedencias')
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
  INIMgr.Fetch('BrowseProcedencias',QuickWindow)           ! Restore window settings from non-volatile store
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
    Relate:Procedencias.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseProcedencias',QuickWindow)        ! Save window data to non-volatile store
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
    UpdateProcedencias
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

