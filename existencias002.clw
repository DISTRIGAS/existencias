

   MEMBER('existencias.clw')                               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('EXISTENCIAS002.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('EXISTENCIAS003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS004.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS008.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS011.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Tanques_plantas
!!! </summary>
BrowseTanques_plantas PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Tanques_plantas)
                       PROJECT(tan:id_tanque)
                       PROJECT(tan:id_planta)
                       PROJECT(tan:nro_tanque)
                       PROJECT(tan:cap_m3)
                       PROJECT(tan:idt_tanques)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
tan:id_tanque          LIKE(tan:id_tanque)            !List box control field - type derived from field
tan:id_planta          LIKE(tan:id_planta)            !List box control field - type derived from field
tan:nro_tanque         LIKE(tan:nro_tanque)           !List box control field - type derived from field
tan:cap_m3             LIKE(tan:cap_m3)               !List box control field - type derived from field
tan:idt_tanques        LIKE(tan:idt_tanques)          !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Tanques_plantas'),AT(,,236,218),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,TILED,CENTER,GRAY,IMM,MDI,HLP('BrowseTanques_plantas'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(8,30,220,104),USE(?Browse:1),HVSCROLL,FORMAT('64R(2)|M~id tanque~C(0)@n-14@28L(' & |
  '2)|M~Planta~L(2)@P<<<<<<P@44L(2)|M~nro tanque~L(2)@P<<<<P@40D(12)|M~Capacidad~C(0)@N' & |
  '-6.2@52L(2)|M~Tipo tanque:~L(2)@P<<<<P@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the' & |
  ' Tanques_plantas file')
                       BUTTON('&Ver'),AT(80,138,34,34),USE(?View:2),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'), |
  TIP('Vizualizar el registro')
                       BUTTON('&Insertar'),AT(118,138,34,34),USE(?Insert:3),ICON('Insertar.ico'),FLAT,MSG('Insertar u' & |
  'n registro'),TIP('Insertar un registro')
                       BUTTON('E&ditar'),AT(156,138,34,34),USE(?Change:3),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro')
                       BUTTON('&Eliminar'),AT(194,138,34,34),USE(?Delete:3),ICON('Eliminar.ICO'),FLAT,MSG('Eliminar e' & |
  'l registro'),TIP('Eliminar el registro')
                       SHEET,AT(4,4,228,172),USE(?CurrentTab)
                         TAB('&1) Tanque'),USE(?Tab:2)
                         END
                         TAB('&2) Planta'),USE(?Tab:3)
                           BUTTON('Plantas'),AT(8,138,88,34),USE(?SelectPlantas),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona' & |
  'r campo padre'),TIP('Seleccionar campo padre')
                         END
                         TAB('&3) TIPO TANQUE'),USE(?Tab:4)
                           BUTTON('t_tanques'),AT(8,138,88,34),USE(?Selectt_tanques),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona' & |
  'r campo padre'),TIP('Seleccionar campo padre')
                         END
                         TAB('&4) Planta'),USE(?Tab:5)
                         END
                         TAB('&5) Tipo de tanque'),USE(?Tab:6)
                         END
                       END
                       BUTTON('&Cerrar'),AT(160,180,34,34),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'), |
  TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(198,180,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'), |
  STD(STD:Help),TIP('Ver ventana de ayuda')
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
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::Sort3:Locator  StepLocatorClass                      ! Conditional Locator - CHOICE(?CurrentTab) = 4
BRW1::Sort4:Locator  StepLocatorClass                      ! Conditional Locator - CHOICE(?CurrentTab) = 5
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
  GlobalErrors.SetProcedureName('BrowseTanques_plantas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('tan:id_tanque',tan:id_tanque)                      ! Added by: BrowseBox(ABC)
  BIND('tan:id_planta',tan:id_planta)                      ! Added by: BrowseBox(ABC)
  BIND('tan:nro_tanque',tan:nro_tanque)                    ! Added by: BrowseBox(ABC)
  BIND('tan:idt_tanques',tan:idt_tanques)                  ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Plantas.SetOpenRelated()
  Relate:Plantas.Open                                      ! File Plantas used by this procedure, so make sure it's RelationManager is open
  Relate:t_tanques.SetOpenRelated()
  Relate:t_tanques.Open                                    ! File t_tanques used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Tanques_plantas,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,tan:FK_PLANTA)                        ! Add the sort order for tan:FK_PLANTA for sort order 1
  BRW1.AddRange(tan:id_planta,Relate:Tanques_plantas,Relate:Plantas) ! Add file relationship range limit for sort order 1
  BRW1.AddSortOrder(,tan:FK_TANQUE)                        ! Add the sort order for tan:FK_TANQUE for sort order 2
  BRW1.AddRange(tan:idt_tanques,Relate:Tanques_plantas,Relate:t_tanques) ! Add file relationship range limit for sort order 2
  BRW1.AddSortOrder(,tan:k_planta)                         ! Add the sort order for tan:k_planta for sort order 3
  BRW1.AddLocator(BRW1::Sort3:Locator)                     ! Browse has a locator for sort order 3
  BRW1::Sort3:Locator.Init(,tan:id_planta,1,BRW1)          ! Initialize the browse locator using  using key: tan:k_planta , tan:id_planta
  BRW1.AddSortOrder(,tan:K_TANQUE)                         ! Add the sort order for tan:K_TANQUE for sort order 4
  BRW1.AddLocator(BRW1::Sort4:Locator)                     ! Browse has a locator for sort order 4
  BRW1::Sort4:Locator.Init(,tan:idt_tanques,1,BRW1)        ! Initialize the browse locator using  using key: tan:K_TANQUE , tan:idt_tanques
  BRW1.AddSortOrder(,tan:PK_tanques)                       ! Add the sort order for tan:PK_tanques for sort order 5
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 5
  BRW1::Sort0:Locator.Init(,tan:id_tanque,1,BRW1)          ! Initialize the browse locator using  using key: tan:PK_tanques , tan:id_tanque
  BRW1.AddField(tan:id_tanque,BRW1.Q.tan:id_tanque)        ! Field tan:id_tanque is a hot field or requires assignment from browse
  BRW1.AddField(tan:id_planta,BRW1.Q.tan:id_planta)        ! Field tan:id_planta is a hot field or requires assignment from browse
  BRW1.AddField(tan:nro_tanque,BRW1.Q.tan:nro_tanque)      ! Field tan:nro_tanque is a hot field or requires assignment from browse
  BRW1.AddField(tan:cap_m3,BRW1.Q.tan:cap_m3)              ! Field tan:cap_m3 is a hot field or requires assignment from browse
  BRW1.AddField(tan:idt_tanques,BRW1.Q.tan:idt_tanques)    ! Field tan:idt_tanques is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseTanques_plantas',QuickWindow)        ! Restore window settings from non-volatile store
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
    Relate:Plantas.Close
    Relate:t_tanques.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseTanques_plantas',QuickWindow)     ! Save window data to non-volatile store
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
    UpdateTanques_plantas(0)
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
    OF ?SelectPlantas
      ThisWindow.Update
      GlobalRequest = SelectRecord
      SelectPlantas()
      ThisWindow.Reset
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


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?CurrentTab) = 2
    RETURN SELF.SetSort(1,Force)
  ELSIF CHOICE(?CurrentTab) = 3
    RETURN SELF.SetSort(2,Force)
  ELSIF CHOICE(?CurrentTab) = 4
    RETURN SELF.SetSort(3,Force)
  ELSIF CHOICE(?CurrentTab) = 5
    RETURN SELF.SetSort(4,Force)
  ELSE
    RETURN SELF.SetSort(5,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window


!!! <summary>
!!! Generated from procedure template - Window
!!! Mediciones
!!! </summary>
BrowseMediciones PROCEDURE 

CurrentTab           STRING(80)                            !
L:strFilter          CSTRING(256)                          !
L:buscador           STRING(100)                           !
BRW8::View:Browse    VIEW(Mediciones)
                       PROJECT(med:id_localidad)
                       PROJECT(med:id_planta)
                       PROJECT(med:fecha_lectura_DATE)
                       PROJECT(med:id_medicion)
                       PROJECT(med:nivel)
                       PROJECT(med:temperatura)
                       PROJECT(med:presion)
                       PROJECT(med:densidad)
                       PROJECT(med:factor_liquido)
                       PROJECT(med:volumen_liquido)
                       PROJECT(med:factor_corr_vapor)
                       PROJECT(med:Volumen_vapor)
                       PROJECT(med:volumen_corr_vapor)
                       PROJECT(med:volumen_total)
                       PROJECT(med:volumen_total_corr)
                       PROJECT(med:id_factor_densidad)
                       JOIN(den:PK_tabla_densidad_corregida,med:id_factor_densidad)
                         PROJECT(den:id_factor)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
med:id_localidad       LIKE(med:id_localidad)         !List box control field - type derived from field
med:id_planta          LIKE(med:id_planta)            !List box control field - type derived from field
med:fecha_lectura_DATE LIKE(med:fecha_lectura_DATE)   !List box control field - type derived from field
med:id_medicion        LIKE(med:id_medicion)          !List box control field - type derived from field
med:nivel              LIKE(med:nivel)                !List box control field - type derived from field
med:temperatura        LIKE(med:temperatura)          !List box control field - type derived from field
med:presion            LIKE(med:presion)              !List box control field - type derived from field
med:densidad           LIKE(med:densidad)             !List box control field - type derived from field
med:factor_liquido     LIKE(med:factor_liquido)       !List box control field - type derived from field
med:volumen_liquido    LIKE(med:volumen_liquido)      !List box control field - type derived from field
med:factor_corr_vapor  LIKE(med:factor_corr_vapor)    !List box control field - type derived from field
med:Volumen_vapor      LIKE(med:Volumen_vapor)        !List box control field - type derived from field
med:volumen_corr_vapor LIKE(med:volumen_corr_vapor)   !List box control field - type derived from field
med:volumen_total      LIKE(med:volumen_total)        !List box control field - type derived from field
med:volumen_total_corr LIKE(med:volumen_total_corr)   !List box control field - type derived from field
den:id_factor          LIKE(den:id_factor)            !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,TILED, |
  CENTER,GRAY,IMM,MDI,HLP('BrowseMediciones'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON('&Cerrar'),AT(430,304,34,34),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'), |
  TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(468,304,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'), |
  STD(STD:Help),TIP('Ver ventana de ayuda')
                       LIST,AT(26,79,475,208),USE(?List:2),FORMAT('0L(2)|M~Id localidad~L(1)@n-14@18L(2)|M~Id ' & |
  'Planta~L(0)@P<<<<P@40L(2)|M~Fecha lectura~L(0)@d6@40L(2)|M~Id medición~L(0)@P<<<<<<<<' & |
  '<<<<P@20L(2)|M~Nivel~L(0)@N-4.`1@60L(2)|M~Temp.~L(1)@n-14@44L(2)|M~Pres.~L(0)@n-10.3' & |
  '@28L(2)|M~Dens.~L(0)@N-6.`3@36L(2)|M~FACorr~L(0)@N-8.`4@36L(2)|M~Vol Liq.~L(0)@N-8.`' & |
  '4@44L(2)|M~FAPr~D(12)@N-10.`6@64L(2)|M~Vol. Vap~D(12)@n-15.6@52L(2)|M~Vol. Corr Vap.' & |
  '~D(12)@N-12.`6@64L(2)|M~Volumen~D(12)@N-15_`6@68L(2)|M~Total Corr~D(12)@n-16.0@'),FROM(Queue:Browse:1), |
  IMM
                       STRING('Mediciones de planta'),AT(219,18),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       PROMPT('Localidad:'),AT(31,47),USE(?GLO:localidad_id:Prompt),TRN
                       ENTRY(@n-14),AT(69,47,21,10),USE(GLO:localidad_id),RIGHT(1)
                       PROMPT('Planta:'),AT(31,62),USE(?GLO:id_planta:Prompt),TRN
                       ENTRY(@P<<<<<P),AT(69,62,21,10),USE(GLO:id_planta),RIGHT(1)
                       PROMPT('Desde:'),AT(215,48),USE(?GLO:fecha_Desde:Prompt),TRN
                       ENTRY(@d6),AT(240,47,60,10),USE(GLO:fecha_Desde)
                       PROMPT('Hasta:'),AT(337,47),USE(?GLO:fecha_hasta:Prompt),TRN
                       ENTRY(@d6),AT(363,47,60,10),USE(GLO:fecha_hasta)
                       BUTTON,AT(303,39,28,24),USE(?BotonSeleccionFecha),ICON('calen.ico'),FLAT,TRN
                       BUTTON,AT(425,39,28,24),USE(?BotonSeleccionFecha:2),ICON('CALEN.ICO'),FLAT,TRN
                       BUTTON,AT(95,46,12,12),USE(?CallLookup),ICON('Lupita.ico'),FLAT,TRN
                       BUTTON,AT(95,60,12,12),USE(?CallLookupPlanta),ICON('lupita.ico'),FLAT,TRN
                       STRING(@s20),AT(118,50),USE(Loc:Localidad),TRN
                       STRING(@P<<P),AT(118,65),USE(pla:NRO_PLANTA),TRN
                       BUTTON,AT(469,39,33,31),USE(?BtnFilter),ICON('seleccionar.ICO'),FLAT,TRN
                       BUTTON,AT(226,307,33,31),USE(?BtnFilter:2),ICON('Imprimir.ico'),FLAT,TRN
                       BUTTON('E&xportar'),AT(134,318,52,15),USE(?EvoExportar),LEFT,ICON('export.ico'),FLAT
                     END

Loc::QHlist10 QUEUE,PRE(QHL10)
Id                         SHORT
Nombre                     STRING(100)
Longitud                   SHORT
Pict                       STRING(50)
Tot                 BYTE
                         END
QPar10 QUEUE,PRE(Q10)
FieldPar                 CSTRING(800)
                         END
QPar210 QUEUE,PRE(Qp210)
F2N                 CSTRING(300)
F2P                 CSTRING(100)
F2T                 BYTE
                         END
Loc::TituloListado10          STRING(100)
Loc::Titulo10          STRING(100)
SavPath10          STRING(2000)
Evo::Group10  GROUP,PRE()
Evo::Procedure10          STRING(100)
Evo::App10          STRING(100)
Evo::NroPage          LONG
   END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
                     END

BRW8::Sort0:Locator  StepLocatorClass                      ! Default Locator
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

Ec::LoadI_10  SHORT
Gol_woI_10 WINDOW,AT(,,236,43),FONT('MS Sans Serif',8,,),CENTER,GRAY
       IMAGE('clock.ico'),AT(8,11),USE(?ImgoutI_10),CENTERED
       GROUP,AT(38,11,164,20),USE(?G::I_10),BOXED,BEVEL(-1)
         STRING('Preparando datos para Exportacion'),AT(63,11),USE(?StrOutI_10),TRN
         STRING('Aguarde un instante por Favor...'),AT(67,20),USE(?StrOut2I_10),TRN
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
PrintExBrowse10 ROUTINE

 OPEN(Gol_woI_10)
 DISPLAY()
 SETTARGET(QuickWindow)
 SETCURSOR(CURSOR:WAIT)
 EC::LoadI_10 = BRW1.FileLoaded
 IF Not  EC::LoadI_10
     BRW1.FileLoaded=True
     CLEAR(BRW1.LastItems,1)
     BRW1.ResetFromFile()
 END
 CLOSE(Gol_woI_10)
 SETCURSOR()
  Evo::App10          = 'existencias'
  Evo::Procedure10          = GlobalErrors.GetProcedureName()& 10
 
  FREE(QPar10)
  Q10:FieldPar  = '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,'
  ADD(QPar10)  !!1
  Q10:FieldPar  = ';'
  ADD(QPar10)  !!2
  Q10:FieldPar  = 'Spanish'
  ADD(QPar10)  !!3
  Q10:FieldPar  = ''
  ADD(QPar10)  !!4
  Q10:FieldPar  = true
  ADD(QPar10)  !!5
  Q10:FieldPar  = ''
  ADD(QPar10)  !!6
  Q10:FieldPar  = true
  ADD(QPar10)  !!7
 !!!! Exportaciones
  Q10:FieldPar  = 'HTML|'
   Q10:FieldPar  = CLIP( Q10:FieldPar)&'EXCEL|'
   Q10:FieldPar  = CLIP( Q10:FieldPar)&'WORD|'
  Q10:FieldPar  = CLIP( Q10:FieldPar)&'ASCII|'
   Q10:FieldPar  = CLIP( Q10:FieldPar)&'XML|'
   Q10:FieldPar  = CLIP( Q10:FieldPar)&'PRT|'
  ADD(QPar10)  !!8
  Q10:FieldPar  = 'All'
  ADD(QPar10)   !.9.
  Q10:FieldPar  = ' 0'
  ADD(QPar10)   !.10
  Q10:FieldPar  = 0
  ADD(QPar10)   !.11
  Q10:FieldPar  = '1'
  ADD(QPar10)   !.12
 
  Q10:FieldPar  = ''
  ADD(QPar10)   !.13
 
  Q10:FieldPar  = ''
  ADD(QPar10)   !.14
 
  Q10:FieldPar  = ''
  ADD(QPar10)   !.15
 
   Q10:FieldPar  = '16'
  ADD(QPar10)   !.16
 
   Q10:FieldPar  = 1
  ADD(QPar10)   !.17
   Q10:FieldPar  = 2
  ADD(QPar10)   !.18
   Q10:FieldPar  = '2'
  ADD(QPar10)   !.19
   Q10:FieldPar  = 12
  ADD(QPar10)   !.20
 
   Q10:FieldPar  = 0 !Exporta excel sin borrar
  ADD(QPar10)   !.21
 
   Q10:FieldPar  = Evo::NroPage !Nro Pag. Desde Report (BExp)
  ADD(QPar10)   !.22
 
   CLEAR(Q10:FieldPar)
  ADD(QPar10)   ! 23 Caracteres Encoding para xml
 
  Q10:FieldPar  = '0'
  ADD(QPar10)   ! 24 Use Open Office
 
   Q10:FieldPar  = '13021968'
 
 
  ADD(QPar10)
 
  FREE(QPar210)
  Qp210:F2N  = 'ECNOEXPORT'
  Qp210:F2P  = '@n-14'
  Qp210:F2T  = '0'
  ADD(QPar210)
  Qp210:F2N  = 'ECNOEXPORT'
  Qp210:F2P  = '@P<<P'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Fecha lectura'
  Qp210:F2P  = '@d6'
  Qp210:F2T  = '0'
  ADD(QPar210)
  Qp210:F2N  = 'ECNOEXPORT'
  Qp210:F2P  = '@P<<<<<<P'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Nivel'
  Qp210:F2P  = '@N-4.`1'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Temp.'
  Qp210:F2P  = '@n-14'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Pres.'
  Qp210:F2P  = '@n-10.3'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Dens.'
  Qp210:F2P  = '@N-6.`3'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'FACorr'
  Qp210:F2P  = '@N-8.`4'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Vol Liq.'
  Qp210:F2P  = '@N-8.`4'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'FAPr'
  Qp210:F2P  = '@N-10.`6'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Vol. Vap'
  Qp210:F2P  = '@n-15.6'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Vol. Corr Vap.'
  Qp210:F2P  = '@N-12.`6'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Volumen'
  Qp210:F2P  = '@N-15_`6'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Total Corr'
  Qp210:F2P  = '@n-16.0'
  Qp210:F2T  = '0'
  ADD(QPar210)
  SysRec# = false
  FREE(Loc::QHlist10)
  LOOP
     SysRec# += 1
     IF ?List:2{PROPLIST:Exists,SysRec#} = 1
         GET(QPar210,SysRec#)
         QHL10:Id      = SysRec#
         QHL10:Nombre  = Qp210:F2N
         QHL10:Longitud= ?List:2{PropList:Width,SysRec#}  /2
         QHL10:Pict    = Qp210:F2P
         QHL10:Tot    = Qp210:F2T
         ADD(Loc::QHlist10)
      Else
        break
     END
  END
  Loc::Titulo10 ='Mediciones'
 
 SavPath10 = PATH()
  Exportar(Loc::QHlist10,BRW1.Q,QPar10,0,Loc::Titulo10,Evo::Group10)
 IF Not EC::LoadI_10 Then  BRW1.FileLoaded=false.
 SETPATH(SavPath10)
 !!!! Fin Routina Templates Clarion

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseMediciones')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Close
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('GLO:localidad_id',GLO:localidad_id)                ! Added by: BrowseBox(ABC)
  BIND('med:id_planta',med:id_planta)                      ! Added by: BrowseBox(ABC)
  BIND('GLO:id_planta',GLO:id_planta)                      ! Added by: BrowseBox(ABC)
  BIND('GLO:fecha_desde',GLO:fecha_desde)                  ! Added by: BrowseBox(ABC)
  BIND('GLO:fecha_hasta',GLO:fecha_hasta)                  ! Added by: BrowseBox(ABC)
  BIND('med:id_medicion',med:id_medicion)                  ! Added by: BrowseBox(ABC)
  BIND('den:id_factor',den:id_factor)                      ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Existencias.SetOpenRelated()
  Relate:Existencias.Open                                  ! File Existencias used by this procedure, so make sure it's RelationManager is open
  Access:Plantas.UseFile                                   ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:Tanques_plantas.UseFile                           ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:Localidades_GLP.UseFile                           ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW1.Init(?List:2,Queue:Browse:1.ViewPosition,BRW8::View:Browse,Queue:Browse:1,Relate:Mediciones,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,med:PK_mediciones)                    ! Add the sort order for med:PK_mediciones for sort order 1
  BRW1.AddLocator(BRW8::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW8::Sort0:Locator.Init(,med:id_medicion,1,BRW1)        ! Initialize the browse locator using  using key: med:PK_mediciones , med:id_medicion
  BRW1.SetFilter('(med:id_localidad = GLO:localidad_id AND med:id_planta = GLO:id_planta and med:fecha_lectura_DATE >= GLO:fecha_desde)') ! Apply filter expression to browse
  BRW1.AddField(med:id_localidad,BRW1.Q.med:id_localidad)  ! Field med:id_localidad is a hot field or requires assignment from browse
  BRW1.AddField(med:id_planta,BRW1.Q.med:id_planta)        ! Field med:id_planta is a hot field or requires assignment from browse
  BRW1.AddField(med:fecha_lectura_DATE,BRW1.Q.med:fecha_lectura_DATE) ! Field med:fecha_lectura_DATE is a hot field or requires assignment from browse
  BRW1.AddField(med:id_medicion,BRW1.Q.med:id_medicion)    ! Field med:id_medicion is a hot field or requires assignment from browse
  BRW1.AddField(med:nivel,BRW1.Q.med:nivel)                ! Field med:nivel is a hot field or requires assignment from browse
  BRW1.AddField(med:temperatura,BRW1.Q.med:temperatura)    ! Field med:temperatura is a hot field or requires assignment from browse
  BRW1.AddField(med:presion,BRW1.Q.med:presion)            ! Field med:presion is a hot field or requires assignment from browse
  BRW1.AddField(med:densidad,BRW1.Q.med:densidad)          ! Field med:densidad is a hot field or requires assignment from browse
  BRW1.AddField(med:factor_liquido,BRW1.Q.med:factor_liquido) ! Field med:factor_liquido is a hot field or requires assignment from browse
  BRW1.AddField(med:volumen_liquido,BRW1.Q.med:volumen_liquido) ! Field med:volumen_liquido is a hot field or requires assignment from browse
  BRW1.AddField(med:factor_corr_vapor,BRW1.Q.med:factor_corr_vapor) ! Field med:factor_corr_vapor is a hot field or requires assignment from browse
  BRW1.AddField(med:Volumen_vapor,BRW1.Q.med:Volumen_vapor) ! Field med:Volumen_vapor is a hot field or requires assignment from browse
  BRW1.AddField(med:volumen_corr_vapor,BRW1.Q.med:volumen_corr_vapor) ! Field med:volumen_corr_vapor is a hot field or requires assignment from browse
  BRW1.AddField(med:volumen_total,BRW1.Q.med:volumen_total) ! Field med:volumen_total is a hot field or requires assignment from browse
  BRW1.AddField(med:volumen_total_corr,BRW1.Q.med:volumen_total_corr) ! Field med:volumen_total_corr is a hot field or requires assignment from browse
  BRW1.AddField(den:id_factor,BRW1.Q.den:id_factor)        ! Field den:id_factor is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseMediciones',QuickWindow)             ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.ToolbarItem.HelpButton = ?Help
  SELF.SetAlerts()
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
    INIMgr.Update('BrowseMediciones',QuickWindow)          ! Save window data to non-volatile store
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
      IF GLO:id_planta<>0
          ThisWindow.Reset(TRUE)
      END
      IF GLO:id_planta OR ?GLO:id_planta{PROP:Req}
        pla:ID_PLANTA = GLO:id_planta
        IF Access:Plantas.TryFetch(pla:PK__plantas__7D439ABD)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            GLO:id_planta = pla:ID_PLANTA
          ELSE
            SELECT(?GLO:id_planta)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?BotonSeleccionFecha
      ThisWindow.Update
      CHANGE(?GLO:fecha_Desde,bigfec(CONTENTS(?GLO:fecha_Desde)))
      !DO RefreshWindow
    OF ?BotonSeleccionFecha:2
      ThisWindow.Update
      CHANGE(?GLO:fecha_hasta,bigfec(CONTENTS(?GLO:fecha_hasta)))
      !DO RefreshWindow
    OF ?CallLookup
      ThisWindow.Update
      Loc:id_localidad = GLO:localidad_id
      IF SELF.Run(1,SelectRecord) = RequestCompleted       ! Call lookup procedure and verify RequestCompleted
        GLO:localidad_id = Loc:id_localidad
      END
      ThisWindow.Reset(1)
    OF ?CallLookupPlanta
      ThisWindow.Update
      pla:ID_PLANTA = GLO:id_planta
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        GLO:id_planta = pla:ID_PLANTA
      END
      ThisWindow.Reset(1)
    OF ?BtnFilter
      ThisWindow.Update
      L:strFilter = ''
      
      !!IF GLO:localidad_id <>0
      !    L:strFilter= 'med:id_localidad = '&GLO:localidad_id
      !    MESSAGE(L:strFilter)
      !!!END
      
      IF GLO:id_planta <> 0
          L:strFilter = ' med:id_planta ='&GLO:id_planta
          MESSAGE(L:strfilter)
      ELSE
          MESSAGE('Debe elegir una planta','Atención',ICON:Exclamation)
          SELECT(?GLO:id_planta)
          CYCLE
      END
      
      IF GLO:fecha_Desde <>0
          L:strFilter = L:strFilter&' AND med:fecha_lectura_DATE >= '&GLO:fecha_desde 
          MESSAGE(L:strFilter)
      END
      
      IF GLO:fecha_hasta <> 0
          L:strFilter = L:strFilter&' AND med:fecha_lectura_DATE<= '&GLO:fecha_hasta 
          MESSAGE(L:strFilter)
      END
      
      
      
      
      IF EVALUATE(L:strFilter)
          BRW1.SetFilter(clip(L:strFilter))
          BRW1.ApplyFilter()
          ThisWindow.Reset(TRUE)
      END
    OF ?BtnFilter:2
      ThisWindow.Update
      START(ReportMediciones, 25000, BRW1.VIEW{PROP:FILTER},BRW1.VIEW{PROP:ORDER})
      ThisWindow.Reset
    OF ?EvoExportar
      ThisWindow.Update
       Do PrintExBrowse10
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


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! Presiones_corregidas
!!! </summary>
BrowsePresiones_corregidas PROCEDURE 

CurrentTab           STRING(80)                            !
l:presion            DECIMAL(7,2)                          !
BRW1::View:Browse    VIEW(Presiones_corregidas)
                       PROJECT(pre:id_presion)
                       PROJECT(pre:presion)
                       PROJECT(pre:temperatura)
                       PROJECT(pre:factor_correccion)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
pre:id_presion         LIKE(pre:id_presion)           !List box control field - type derived from field
pre:presion            LIKE(pre:presion)              !List box control field - type derived from field
l:presion              LIKE(l:presion)                !List box control field - type derived from local data
pre:temperatura        LIKE(pre:temperatura)          !List box control field - type derived from field
pre:factor_correccion  LIKE(pre:factor_correccion)    !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,455,370),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowsePresiones_corregidas'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(70,90,307,183),USE(?Browse:1),HVSCROLL,FORMAT('64R(2)|M~id presion~C(0)@n-14@48' & |
  'D(21)|M~Presion~C(0)@n-10.3@63R(2)|M~Presión Corr~D(10)@n-10.2@64R(2)|M~Temperatura~' & |
  'C(0)@n-14@72D(32)|M~Factor corrección~C(0)@n-9.6@'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he Presiones_corregidas file')
                       BUTTON('&Ver'),AT(125,312,34,34),USE(?View:2),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'), |
  TIP('Vizualizar el registro')
                       BUTTON('&Insertar'),AT(163,312,34,34),USE(?Insert:3),ICON('Insertar.ico'),FLAT,MSG('Insertar u' & |
  'n registro'),TIP('Insertar un registro')
                       BUTTON('E&ditar'),AT(201,312,34,34),USE(?Change:3),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro')
                       BUTTON('&Eliminar'),AT(239,312,34,34),USE(?Delete:3),ICON('Eliminar.ICO'),FLAT,MSG('Eliminar e' & |
  'l registro'),TIP('Eliminar el registro')
                       BUTTON('&Cerrar'),AT(365,312,34,34),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'), |
  TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(403,312,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'), |
  STD(STD:Help),TIP('Ver ventana de ayuda')
                       STRING('Presiones Corregidas'),AT(171,18),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI)
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
SetQueueRecord         PROCEDURE(),DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?Browse:1
EditInPlace::pre:presion EditEntryClass                    ! Edit-in-place class for field pre:presion
EditInPlace::pre:temperatura EditEntryClass                ! Edit-in-place class for field pre:temperatura
EditInPlace::pre:factor_correccion EditEntryClass          ! Edit-in-place class for field pre:factor_correccion
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
  GlobalErrors.SetProcedureName('BrowsePresiones_corregidas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('l:presion',l:presion)                              ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Presiones_corregidas.Open                         ! File Presiones_corregidas used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Presiones_corregidas,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,pre:PK_factor_presion)                ! Add the sort order for pre:PK_factor_presion for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,pre:id_presion,1,BRW1)         ! Initialize the browse locator using  using key: pre:PK_factor_presion , pre:id_presion
  BRW1.AddField(pre:id_presion,BRW1.Q.pre:id_presion)      ! Field pre:id_presion is a hot field or requires assignment from browse
  BRW1.AddField(pre:presion,BRW1.Q.pre:presion)            ! Field pre:presion is a hot field or requires assignment from browse
  BRW1.AddField(l:presion,BRW1.Q.l:presion)                ! Field l:presion is a hot field or requires assignment from browse
  BRW1.AddField(pre:temperatura,BRW1.Q.pre:temperatura)    ! Field pre:temperatura is a hot field or requires assignment from browse
  BRW1.AddField(pre:factor_correccion,BRW1.Q.pre:factor_correccion) ! Field pre:factor_correccion is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowsePresiones_corregidas',QuickWindow)   ! Restore window settings from non-volatile store
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
    INIMgr.Update('BrowsePresiones_corregidas',QuickWindow) ! Save window data to non-volatile store
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
    UpdatePresiones_corregidas
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(,1) ! pre:id_presion Disable
  SELF.AddEditControl(EditInPlace::pre:presion,2)
  SELF.AddEditControl(,3) ! l:presion Disable
  SELF.AddEditControl(EditInPlace::pre:temperatura,4)
  SELF.AddEditControl(EditInPlace::pre:factor_correccion,5)
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
  l:presion = pre:presion / 10
  PARENT.SetQueueRecord
  
  SELF.Q.l:presion = l:presion                             !Assign formula result to display queue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! Localidades_GLP
!!! </summary>
BrowseLocalidades_GLP PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Localidades_GLP)
                       PROJECT(Loc:id_localidad)
                       PROJECT(Loc:Localidad)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
Loc:id_localidad       LIKE(Loc:id_localidad)         !List box control field - type derived from field
Loc:Localidad          LIKE(Loc:Localidad)            !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Localidades_GLP'),AT(,,164,218),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,TILED,CENTER,GRAY,IMM,MDI,HLP('BrowseLocalidades_GLP'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(8,30,148,104),USE(?Browse:1),HVSCROLL,FORMAT('64R(2)|M~Id localidad~C(0)@n-14@8' & |
  '0L(2)|M~Localidad~L(2)@s20@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the Localidades_GLP file')
                       BUTTON('&Ver'),AT(8,138,34,34),USE(?View:2),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'), |
  TIP('Vizualizar el registro')
                       BUTTON('&Insertar'),AT(46,138,34,34),USE(?Insert:3),ICON('Insertar.ico'),FLAT,MSG('Insertar u' & |
  'n registro'),TIP('Insertar un registro')
                       BUTTON('E&ditar'),AT(84,138,34,34),USE(?Change:3),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro')
                       BUTTON('&Eliminar'),AT(122,138,34,34),USE(?Delete:3),ICON('Eliminar.ICO'),FLAT,MSG('Eliminar e' & |
  'l registro'),TIP('Eliminar el registro')
                       SHEET,AT(4,4,156,172),USE(?CurrentTab)
                         TAB('&1) ID localidad'),USE(?Tab:2)
                         END
                         TAB('&2) Localidad'),USE(?Tab:3)
                         END
                       END
                       BUTTON('&Cerrar'),AT(88,180,34,34),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'), |
  TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(126,180,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'), |
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
  GlobalErrors.SetProcedureName('BrowseLocalidades_GLP')
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
  Relate:Localidades_GLP.Open                              ! File Localidades_GLP used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Localidades_GLP,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,Loc:K_localidad)                      ! Add the sort order for Loc:K_localidad for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(,Loc:Localidad,1,BRW1)          ! Initialize the browse locator using  using key: Loc:K_localidad , Loc:Localidad
  BRW1.AddSortOrder(,Loc:PK_localidad)                     ! Add the sort order for Loc:PK_localidad for sort order 2
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort0:Locator.Init(,Loc:id_localidad,1,BRW1)       ! Initialize the browse locator using  using key: Loc:PK_localidad , Loc:id_localidad
  BRW1.AddField(Loc:id_localidad,BRW1.Q.Loc:id_localidad)  ! Field Loc:id_localidad is a hot field or requires assignment from browse
  BRW1.AddField(Loc:Localidad,BRW1.Q.Loc:Localidad)        ! Field Loc:Localidad is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseLocalidades_GLP',QuickWindow)        ! Restore window settings from non-volatile store
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
    Relate:Localidades_GLP.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseLocalidades_GLP',QuickWindow)     ! Save window data to non-volatile store
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
    UpdateLocalidades_GLP
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

!!! <summary>
!!! Generated from procedure template - Window
!!! Form Proveedores
!!! </summary>
UpdateProveedores PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
BRW7::View:Browse    VIEW(contactos_proveedores)
                       PROJECT(cont:id_contacto)
                       PROJECT(cont:nombre)
                       PROJECT(cont:telefono)
                       PROJECT(cont:mail)
                       PROJECT(cont:id_proveedor)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
cont:id_contacto       LIKE(cont:id_contacto)         !List box control field - type derived from field
cont:nombre            LIKE(cont:nombre)              !List box control field - type derived from field
cont:telefono          LIKE(cont:telefono)            !List box control field - type derived from field
cont:mail              LIKE(cont:mail)                !List box control field - type derived from field
cont:id_proveedor      LIKE(cont:id_proveedor)        !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::pro:Record  LIKE(pro:RECORD),THREAD
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('UpdateProveedores'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(427,293,25,25),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar los dat' & |
  'os y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON,AT(465,293,25,25),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       ENTRY(@n-25.4),AT(103,76,60,10),USE(pro:importe_DNL),DECIMAL(12)
                       ENTRY(@P<<<<<P),AT(103,50,40,10),USE(pro:id_proveedor),RIGHT(1),OVR,MSG('Identificador ' & |
  'interno del proveedor de producto'),TIP('Identificador interno del proveedor de producto')
                       ENTRY(@s50),AT(103,63,161,10),USE(pro:proveedor),OVR,UPR,REQ
                       PROMPT('Proveedor:'),AT(47,63),USE(?pro:proveedor:Prompt),TRN
                       PROMPT('Importe DNL:'),AT(47,79),USE(?pro:importe_DNL:Prompt)
                       PROMPT('ID Proveedor:'),AT(47,50),USE(?pro:id_proveedor:Prompt),TRN
                       STRING('Ingreso de Proveedores de GLP'),AT(195,18,137),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       PROMPT('Dirección:'),AT(47,90),USE(?pro:direccion:Prompt)
                       ENTRY(@s50),AT(103,90,161,10),USE(pro:direccion)
                       PROMPT('Ciudad:'),AT(47,103),USE(?pro:ciudad:Prompt)
                       ENTRY(@s50),AT(103,103,161,10),USE(pro:ciudad)
                       PROMPT('Telefono:'),AT(47,117),USE(?pro:telefono:Prompt)
                       ENTRY(@s50),AT(103,117,161,10),USE(pro:telefono)
                       PROMPT('contacto:'),AT(47,131),USE(?pro:contacto:Prompt)
                       ENTRY(@s50),AT(103,130,161,10),USE(pro:contacto)
                       LIST,AT(47,174,386,100),USE(?List),RIGHT(1),FORMAT('0L(2)|M~Id contacto~L(1)@P<<<<<<<<P' & |
  '@111L(2)|M~nombre~L(0)@s50@118L(2)|M~telefono~L(0)@s50@200L(2)|M~mail~L(0)@s50@'),FROM(Queue:Browse), |
  IMM
                       BUTTON,AT(165,294,25,25),USE(?Insert),ICON('Insertar.ico'),FLAT,TRN
                       BUTTON,AT(208,294,25,25),USE(?Change),ICON('Editar.ico'),FLAT,TRN
                       BUTTON,AT(249,294,25,25),USE(?Delete),ICON('Eliminar.ICO'),FLAT,TRN
                       PROMPT('Proveedor:'),AT(45,145),USE(?pro:id_proveedor_contable:Prompt)
                       ENTRY(@n-14),AT(103,145,49,10),USE(pro:id_proveedor_contable),RIGHT(1)
                       BUTTON('...'),AT(157,143,12,12),USE(?CallLookup)
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

BRW7                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW7::Sort0:Locator  StepLocatorClass                      ! Default Locator
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
  GlobalErrors.SetProcedureName('UpdateProveedores')
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
  SELF.AddHistoryFile(pro:Record,History::pro:Record)
  SELF.AddHistoryField(?pro:importe_DNL,3)
  SELF.AddHistoryField(?pro:id_proveedor,1)
  SELF.AddHistoryField(?pro:proveedor,2)
  SELF.AddHistoryField(?pro:direccion,4)
  SELF.AddHistoryField(?pro:ciudad,5)
  SELF.AddHistoryField(?pro:telefono,7)
  SELF.AddHistoryField(?pro:contacto,8)
  SELF.AddHistoryField(?pro:id_proveedor_contable,9)
  SELF.AddUpdateFile(Access:Proveedores)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Proveedores.Open                                  ! File Proveedores used by this procedure, so make sure it's RelationManager is open
  Relate:contactos_proveedores.Open                        ! File contactos_proveedores used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Proveedores
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
  BRW7.Init(?List,Queue:Browse.ViewPosition,BRW7::View:Browse,Queue:Browse,Relate:contactos_proveedores,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?pro:importe_DNL{PROP:ReadOnly} = True
    ?pro:id_proveedor{PROP:ReadOnly} = True
    ?pro:proveedor{PROP:ReadOnly} = True
    ?pro:direccion{PROP:ReadOnly} = True
    ?pro:ciudad{PROP:ReadOnly} = True
    ?pro:telefono{PROP:ReadOnly} = True
    ?pro:contacto{PROP:ReadOnly} = True
    DISABLE(?Insert)
    DISABLE(?Change)
    DISABLE(?Delete)
    ?pro:id_proveedor_contable{PROP:ReadOnly} = True
    DISABLE(?CallLookup)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW7.Q &= Queue:Browse
  BRW7.RetainRow = 0
  BRW7.AddSortOrder(,cont:FK_PROVEEDOR)                    ! Add the sort order for cont:FK_PROVEEDOR for sort order 1
  BRW7.AddRange(cont:id_proveedor,Relate:contactos_proveedores,Relate:Proveedores) ! Add file relationship range limit for sort order 1
  BRW7.AddLocator(BRW7::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW7::Sort0:Locator.Init(,cont:id_proveedor,1,BRW7)      ! Initialize the browse locator using  using key: cont:FK_PROVEEDOR , cont:id_proveedor
  BRW7.AddField(cont:id_contacto,BRW7.Q.cont:id_contacto)  ! Field cont:id_contacto is a hot field or requires assignment from browse
  BRW7.AddField(cont:nombre,BRW7.Q.cont:nombre)            ! Field cont:nombre is a hot field or requires assignment from browse
  BRW7.AddField(cont:telefono,BRW7.Q.cont:telefono)        ! Field cont:telefono is a hot field or requires assignment from browse
  BRW7.AddField(cont:mail,BRW7.Q.cont:mail)                ! Field cont:mail is a hot field or requires assignment from browse
  BRW7.AddField(cont:id_proveedor,BRW7.Q.cont:id_proveedor) ! Field cont:id_proveedor is a hot field or requires assignment from browse
  INIMgr.Fetch('UpdateProveedores',QuickWindow)            ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW7.AskProcedure = 2
  BRW7.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Proveedores.Close
    Relate:contactos_proveedores.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateProveedores',QuickWindow)         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  Pro3:proveedor_id = pro:id_proveedor_contable            ! Assign linking field value
  Access:Proveedores_contable.Fetch(Pro3:PK_PROVEEDOR)
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
      SelectProveedorContable
      UpdateContactos
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
    OF ?pro:id_proveedor_contable
      IF pro:id_proveedor_contable OR ?pro:id_proveedor_contable{PROP:Req}
        Pro3:proveedor_id = pro:id_proveedor_contable
        IF Access:Proveedores_contable.TryFetch(Pro3:PK_PROVEEDOR)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            pro:id_proveedor_contable = Pro3:proveedor_id
          ELSE
            SELECT(?pro:id_proveedor_contable)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookup
      ThisWindow.Update
      Pro3:proveedor_id = pro:id_proveedor_contable
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        pro:id_proveedor_contable = Pro3:proveedor_id
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


BRW7.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

!!! <summary>
!!! Generated from procedure template - Window
!!! Form Transportistas
!!! </summary>
UpdateTransportistas PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
BRW7::View:Browse    VIEW(contactos_Transportista)
                       PROJECT(cont1:id_contacto)
                       PROJECT(cont1:id_transportista)
                       PROJECT(cont1:nombre)
                       PROJECT(cont1:telefono)
                       PROJECT(cont1:mail)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
cont1:id_contacto      LIKE(cont1:id_contacto)        !List box control field - type derived from field
cont1:id_transportista LIKE(cont1:id_transportista)   !List box control field - type derived from field
cont1:nombre           LIKE(cont1:nombre)             !List box control field - type derived from field
cont1:telefono         LIKE(cont1:telefono)           !List box control field - type derived from field
cont1:mail             LIKE(cont1:mail)               !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::tra:Record  LIKE(tra:RECORD),THREAD
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('UpdateTransportistas'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(395,292,25,25),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar los dat' & |
  'os y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON,AT(433,292,25,25),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       BUTTON,AT(471,292,25,25),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver Ventana de ayuda'),STD(STD:Help), |
  TIP('Ver Ventana de ayuda')
                       ENTRY(@P<<<P),AT(126,41,40,10),USE(tra:id_transportista),RIGHT(1),OVR,REQ
                       PROMPT('ID Transportista:'),AT(54,41),USE(?tra:id_transportista:Prompt),TRN
                       ENTRY(@s50),AT(126,54,204,10),USE(tra:transportista),UPR,REQ
                       PROMPT('Transportista:'),AT(54,54),USE(?tra:transportista:Prompt),TRN
                       PROMPT('Dirección:'),AT(54,70),USE(?tra:direccion:Prompt)
                       ENTRY(@s50),AT(126,70,204,10),USE(tra:direccion),REQ
                       PROMPT('Ciudad:'),AT(54,84),USE(?tra:ciudad:Prompt)
                       ENTRY(@s50),AT(126,83,204,10),USE(tra:ciudad),REQ
                       PROMPT('Provincia:'),AT(54,99),USE(?tra:provincia:Prompt)
                       ENTRY(@s50),AT(126,98,204,10),USE(tra:provincia),REQ
                       PROMPT('Teléfono:'),AT(54,112),USE(?tra:telefono:Prompt)
                       ENTRY(@s50),AT(126,113,204,10),USE(tra:telefono),REQ
                       LIST,AT(55,140,409,100),USE(?List),FONT(,10),RIGHT(1),FORMAT('0L(2)|M~Id contacto~L(1)@' & |
  'P<<<<<<<<P@0L(2)|M~ID Transportista~L(1)@P<<<<<<P@93L(2)|M~nombre~L(0)@s50@96L(2)|M~' & |
  'telefono~L(0)@s50@200L(2)|M~mail~L(0)@s50@'),FROM(Queue:Browse),IMM
                       BUTTON,AT(140,244,25,25),USE(?Insert),ICON('Insertar.ico'),FLAT,TRN
                       BUTTON,AT(193,244,25,25),USE(?Change),ICON('Editar.ico'),FLAT,TRN
                       BUTTON,AT(247,244,25,25),USE(?Delete),ICON('Eliminar.ICO'),FLAT,TRN
                       STRING('Ingreso de Transportista'),AT(225,22),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline)
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
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

BRW7                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
PrimeRecord            PROCEDURE(BYTE SuppressClear = 0),BYTE,PROC,DERIVED
                     END

BRW7::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?List
EditInPlace::cont1:id_contacto CLASS(EditEntryClass)       ! Edit-in-place class for field cont1:id_contacto
Init                   PROCEDURE(UNSIGNED FieldNumber,UNSIGNED ListBox,*? UseVar),DERIVED
                     END

EditInPlace::cont1:id_transportista CLASS(EditEntryClass)  ! Edit-in-place class for field cont1:id_transportista
Init                   PROCEDURE(UNSIGNED FieldNumber,UNSIGNED ListBox,*? UseVar),DERIVED
                     END

EditInPlace::cont1:nombre EditEntryClass                   ! Edit-in-place class for field cont1:nombre
EditInPlace::cont1:telefono EditEntryClass                 ! Edit-in-place class for field cont1:telefono
EditInPlace::cont1:mail EditEntryClass                     ! Edit-in-place class for field cont1:mail
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
  GlobalErrors.SetProcedureName('UpdateTransportistas')
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
  SELF.AddHistoryFile(tra:Record,History::tra:Record)
  SELF.AddHistoryField(?tra:id_transportista,1)
  SELF.AddHistoryField(?tra:transportista,2)
  SELF.AddHistoryField(?tra:direccion,3)
  SELF.AddHistoryField(?tra:ciudad,4)
  SELF.AddHistoryField(?tra:provincia,5)
  SELF.AddHistoryField(?tra:telefono,6)
  SELF.AddUpdateFile(Access:Transportistas)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Transportistas.Open                               ! File Transportistas used by this procedure, so make sure it's RelationManager is open
  Relate:contactos_Transportista.Open                      ! File contactos_Transportista used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Transportistas
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
  BRW7.Init(?List,Queue:Browse.ViewPosition,BRW7::View:Browse,Queue:Browse,Relate:contactos_Transportista,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?tra:id_transportista{PROP:ReadOnly} = True
    ?tra:transportista{PROP:ReadOnly} = True
    ?tra:direccion{PROP:ReadOnly} = True
    ?tra:ciudad{PROP:ReadOnly} = True
    ?tra:provincia{PROP:ReadOnly} = True
    ?tra:telefono{PROP:ReadOnly} = True
    DISABLE(?Insert)
    DISABLE(?Change)
    DISABLE(?Delete)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW7.Q &= Queue:Browse
  BRW7.RetainRow = 0
  BRW7.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW7.AddField(cont1:id_contacto,BRW7.Q.cont1:id_contacto) ! Field cont1:id_contacto is a hot field or requires assignment from browse
  BRW7.AddField(cont1:id_transportista,BRW7.Q.cont1:id_transportista) ! Field cont1:id_transportista is a hot field or requires assignment from browse
  BRW7.AddField(cont1:nombre,BRW7.Q.cont1:nombre)          ! Field cont1:nombre is a hot field or requires assignment from browse
  BRW7.AddField(cont1:telefono,BRW7.Q.cont1:telefono)      ! Field cont1:telefono is a hot field or requires assignment from browse
  BRW7.AddField(cont1:mail,BRW7.Q.cont1:mail)              ! Field cont1:mail is a hot field or requires assignment from browse
  INIMgr.Fetch('UpdateTransportistas',QuickWindow)         ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW7.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW7.ToolbarItem.HelpButton = ?Help
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Transportistas.Close
    Relate:contactos_Transportista.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateTransportistas',QuickWindow)      ! Save window data to non-volatile store
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
    UpdateContactosTransportista
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


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window


BRW7.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW7::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::cont1:id_contacto,1)
  SELF.AddEditControl(EditInPlace::cont1:id_transportista,2)
  SELF.AddEditControl(EditInPlace::cont1:nombre,3)
  SELF.AddEditControl(EditInPlace::cont1:telefono,4)
  SELF.AddEditControl(EditInPlace::cont1:mail,5)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW7.PrimeRecord PROCEDURE(BYTE SuppressClear = 0)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.PrimeRecord(SuppressClear)
  cont1:id_transportista = tra:id_transportista
  RETURN ReturnValue


EditInPlace::cont1:id_contacto.Init PROCEDURE(UNSIGNED FieldNumber,UNSIGNED ListBox,*? UseVar)

  CODE
  PARENT.Init(FieldNumber,ListBox,UseVar)
  SELF.SetReadOnly(True)


EditInPlace::cont1:id_transportista.Init PROCEDURE(UNSIGNED FieldNumber,UNSIGNED ListBox,*? UseVar)

  CODE
  PARENT.Init(FieldNumber,ListBox,UseVar)
  SELF.SetReadOnly(True)

!!! <summary>
!!! Generated from procedure template - Window
!!! Seleccionar un registro de Localidades_GLP
!!! </summary>
SelectLocalidades_GLP PROCEDURE 

CurrentTab           STRING(80)                            !
BRW9::View:Browse    VIEW(Localidades_GLP)
                       PROJECT(Loc:id_localidad)
                       PROJECT(Loc:Localidad)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
Loc:id_localidad       LIKE(Loc:id_localidad)         !List box control field - type derived from field
Loc:Localidad          LIKE(Loc:Localidad)            !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,260,260),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('SelectLocalidades_GLP'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(206,206,25,28),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       STRING('Seleccione una Localidad'),AT(79,20),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       LIST,AT(50,67,150,100),USE(?List),RIGHT(1),FORMAT('60L(2)|M~Id localidad~L(1)@n-14@80L(' & |
  '2)|M~Localidad~L(0)@s20@'),FROM(Queue:Browse),IMM
                       BUTTON,AT(25,206,,28),USE(?Select),ICON('seleccionar.ICO'),FLAT,TRN
                       BOX,AT(11,202,231,36),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BOX,AT(11,44,231,154),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW9                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW9::Sort0:Locator  StepLocatorClass                      ! Default Locator
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
  GlobalErrors.SetProcedureName('SelectLocalidades_GLP')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Close
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
  BRW9.Init(?List,Queue:Browse.ViewPosition,BRW9::View:Browse,Queue:Browse,Relate:Localidades_GLP,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW9.Q &= Queue:Browse
  BRW9.RetainRow = 0
  BRW9.AddSortOrder(,Loc:PK_localidad)                     ! Add the sort order for Loc:PK_localidad for sort order 1
  BRW9.AddLocator(BRW9::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW9::Sort0:Locator.Init(,Loc:id_localidad,1,BRW9)       ! Initialize the browse locator using  using key: Loc:PK_localidad , Loc:id_localidad
  BRW9.AddField(Loc:id_localidad,BRW9.Q.Loc:id_localidad)  ! Field Loc:id_localidad is a hot field or requires assignment from browse
  BRW9.AddField(Loc:Localidad,BRW9.Q.Loc:Localidad)        ! Field Loc:Localidad is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectLocalidades_GLP',QuickWindow)        ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW9.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
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
    INIMgr.Update('SelectLocalidades_GLP',QuickWindow)     ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


BRW9.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! Form Plantas
!!! </summary>
UpdatePlantas PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
L:CAPACIDAD          DECIMAL(18,4)                         !
L:CANT_TANQUES       LONG,NAME('"CANT_TANQUES"')           !
BRW8::View:Browse    VIEW(Tanques_plantas)
                       PROJECT(tan:nro_tanque)
                       PROJECT(tan:id_tanque)
                       PROJECT(tan:id_planta)
                       PROJECT(tan:idt_tanques)
                       JOIN(t_t:PK_t_tanques,tan:idt_tanques)
                         PROJECT(t_t:modelo)
                         PROJECT(t_t:capacidad)
                         PROJECT(t_t:idt_tanque)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
tan:nro_tanque         LIKE(tan:nro_tanque)           !List box control field - type derived from field
t_t:modelo             LIKE(t_t:modelo)               !List box control field - type derived from field
t_t:capacidad          LIKE(t_t:capacidad)            !List box control field - type derived from field
tan:id_tanque          LIKE(tan:id_tanque)            !Primary key field - type derived from field
tan:id_planta          LIKE(tan:id_planta)            !Browse key field - type derived from field
t_t:idt_tanque         LIKE(t_t:idt_tanque)           !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::pla:Record  LIKE(pla:RECORD),THREAD
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('UpdatePlantas'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(435,284,34,34),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar los dat' & |
  'os y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON,AT(473,284,34,34),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       ENTRY(@P<<P),AT(87,49,40,10),USE(pla:ID_PLANTA),OVR
                       PROMPT('Id Planta:'),AT(25,50),USE(?pla:ID_PLANTA:Prompt),TRN
                       ENTRY(@P<<P),AT(87,66,40,10),USE(pla:NRO_PLANTA),OVR
                       PROMPT('Nro planta:'),AT(25,67),USE(?pla:NRO_PLANTA:Prompt),TRN
                       PROMPT('Capacidad:'),AT(25,84),USE(?pla:CAPACIDAD:Prompt),TRN
                       ENTRY(@N-20_),AT(87,84,59,10),USE(pla:CAPACIDAD)
                       ENTRY(@n-14),AT(87,101,21,10),USE(pla:ID_LOCALIDAD)
                       PROMPT('Localidad:'),AT(25,102),USE(?pla:ID_LOCALIDAD:Prompt),TRN
                       PROMPT('Tanques:'),AT(25,119),USE(?pla:CANT_TANQUES:Prompt),TRN
                       ENTRY(@P<<P),AT(87,118,21,10),USE(pla:CANT_TANQUES),RIGHT(1),REQ
                       BUTTON,AT(113,99,12,12),USE(?CallLookupLocalidad),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@s20),AT(129,102,93,10),USE(Loc:Localidad),TRN
                       STRING('Carga de Plantas de GLP'),AT(213,15),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       LIST,AT(102,164,183,100),USE(?List),FORMAT('40L(2)|M~Nro tanque~C(0)@P<<<<P@80L(2)|M~Mo' & |
  'delo~C(0)@s20@44L(2)|M~Capacidad~C(0)@N-10_@'),FROM(Queue:Browse),IMM
                       BUTTON,AT(125,268,34,34),USE(?Insert),ICON('insertar.ico'),FLAT,TRN
                       BUTTON,AT(169,268,34,34),USE(?Change),ICON('editar.ico'),FLAT,TRN
                       BUTTON,AT(213,268,34,34),USE(?Delete),ICON('eliminar.ico'),FLAT,TRN
                       PROMPT('Fecha auditoría:<0DH,0AH>'),AT(25,140,57),USE(?pla:FECHA_AUDITORIA_DATE:Prompt),TRN
                       ENTRY(@d6),AT(87,140,48,10),USE(pla:FECHA_AUDITORIA_DATE)
                       PROMPT('Kg'),AT(151,84),USE(?pla:CAPACIDAD:Prompt:2),TRN
                       PROMPT('Capacidad:'),AT(331,171),USE(?L:CAPACIDAD:Prompt),TRN
                       ENTRY(@N-8.`4),AT(381,170,60,10),USE(GLO:capacidad)
                       PROMPT('Tanques:'),AT(331,191),USE(?L:CANT_TANQUES:Prompt),TRN
                       ENTRY(@n20_),AT(381,190,60,10),USE(GLO:cant_tanques),RIGHT(1)
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

BRW8                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
                     END

BRW8::Sort0:Locator  StepLocatorClass                      ! Default Locator
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
  GlobalErrors.SetProcedureName('UpdatePlantas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('tan:nro_tanque',tan:nro_tanque)                    ! Added by: BrowseBox(ABC)
  BIND('tan:id_tanque',tan:id_tanque)                      ! Added by: BrowseBox(ABC)
  BIND('tan:id_planta',tan:id_planta)                      ! Added by: BrowseBox(ABC)
  BIND('t_t:idt_tanque',t_t:idt_tanque)                    ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(pla:Record,History::pla:Record)
  SELF.AddHistoryField(?pla:ID_PLANTA,1)
  SELF.AddHistoryField(?pla:NRO_PLANTA,2)
  SELF.AddHistoryField(?pla:CAPACIDAD,3)
  SELF.AddHistoryField(?pla:ID_LOCALIDAD,4)
  SELF.AddHistoryField(?pla:CANT_TANQUES,5)
  SELF.AddHistoryField(?pla:FECHA_AUDITORIA_DATE,11)
  SELF.AddUpdateFile(Access:Plantas)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Existencias.SetOpenRelated()
  Relate:Existencias.Open                                  ! File Existencias used by this procedure, so make sure it's RelationManager is open
  Relate:SQL.Open                                          ! File SQL used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Plantas
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel                      ! No confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  BRW8.Init(?List,Queue:Browse.ViewPosition,BRW8::View:Browse,Queue:Browse,Relate:Tanques_plantas,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?pla:ID_PLANTA{PROP:ReadOnly} = True
    ?pla:NRO_PLANTA{PROP:ReadOnly} = True
    ?pla:CAPACIDAD{PROP:ReadOnly} = True
    ?pla:ID_LOCALIDAD{PROP:ReadOnly} = True
    ?pla:CANT_TANQUES{PROP:ReadOnly} = True
    DISABLE(?CallLookupLocalidad)
    DISABLE(?Insert)
    DISABLE(?Change)
    DISABLE(?Delete)
    ?pla:FECHA_AUDITORIA_DATE{PROP:ReadOnly} = True
    ?GLO:capacidad{PROP:ReadOnly} = True
    ?GLO:cant_tanques{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW8.Q &= Queue:Browse
  BRW8.RetainRow = 0
  BRW8.AddSortOrder(,tan:FK_PLANTA)                        ! Add the sort order for tan:FK_PLANTA for sort order 1
  BRW8.AddRange(tan:id_planta,pla:ID_PLANTA)               ! Add single value range limit for sort order 1
  BRW8.AddLocator(BRW8::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW8::Sort0:Locator.Init(,tan:id_tanque,1,BRW8)          ! Initialize the browse locator using  using key: tan:FK_PLANTA , tan:id_tanque
  BRW8.AddField(tan:nro_tanque,BRW8.Q.tan:nro_tanque)      ! Field tan:nro_tanque is a hot field or requires assignment from browse
  BRW8.AddField(t_t:modelo,BRW8.Q.t_t:modelo)              ! Field t_t:modelo is a hot field or requires assignment from browse
  BRW8.AddField(t_t:capacidad,BRW8.Q.t_t:capacidad)        ! Field t_t:capacidad is a hot field or requires assignment from browse
  BRW8.AddField(tan:id_tanque,BRW8.Q.tan:id_tanque)        ! Field tan:id_tanque is a hot field or requires assignment from browse
  BRW8.AddField(tan:id_planta,BRW8.Q.tan:id_planta)        ! Field tan:id_planta is a hot field or requires assignment from browse
  BRW8.AddField(t_t:idt_tanque,BRW8.Q.t_t:idt_tanque)      ! Field t_t:idt_tanque is a hot field or requires assignment from browse
  INIMgr.Fetch('UpdatePlantas',QuickWindow)                ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW8.AskProcedure = 2
  BRW8.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Existencias.Close
    Relate:SQL.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdatePlantas',QuickWindow)             ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
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
      UpdateTanques_plantas(pla:ID_PLANTA)
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
    OF ?pla:ID_LOCALIDAD
      IF pla:ID_LOCALIDAD OR ?pla:ID_LOCALIDAD{PROP:Req}
        Loc:id_localidad = pla:ID_LOCALIDAD
        IF Access:Localidades_GLP.TryFetch(Loc:PK_localidad)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            pla:ID_LOCALIDAD = Loc:id_localidad
          ELSE
            SELECT(?pla:ID_LOCALIDAD)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookupLocalidad
      ThisWindow.Update
      Loc:id_localidad = pla:ID_LOCALIDAD
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        pla:ID_LOCALIDAD = Loc:id_localidad
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
  ReturnValue = PARENT.TakeCompleted()
  !Generar primera existencia
  IF ReturnValue = Level:Benign
      IF self.Request = InsertRecord
          exi:id_planta = pla:ID_PLANTA
          exi:id_localidad = pla:ID_LOCALIDAD
          exi:existencia = 0
          exi:existencia_anterior = 0
          exi:porc_existencia = 0
          exi:consumo = 0
          exi:capacidad_planta = pla:CAPACIDAD        
          SQL{prop:sql}='SELECT  CONVERT(VARCHAR(10), GETDATE(), 103)'
          NEXT(SQL)
          exi:FECHA_LECTURA_DATE = DEFORMAT(SQL:campo1,@D6)
        
          exi:AUTONOMIA = 0
          exi:ultima_descarga = 0
          exi:id_stock = 0
          exi:id_existencia_anterior = 0
          exi:id_descarga_ultima = 0
          exi:utilizada = 0
          IF Access:Existencias.Insert() <> Level:Benign
              MESSAGE('No se pudo insertar en la tabla Existencias','Atención',ICON:Exclamation)
          ELSE
              MESSAGE('Se cargo la existencia')
          END
          
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


BRW8.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW8.ResetFromView PROCEDURE

tan:cap_m3:Sum       REAL                                  ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:Tanques_plantas.SetQuickScan(1)
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
    tan:cap_m3:Sum += GLO:capacidad
  END
  SELF.View{PROP:IPRequestCount} = 0
  tan:cap_m3 = tan:cap_m3:Sum
  PARENT.ResetFromView
  Relate:Tanques_plantas.SetQuickScan(0)
  SETCURSOR()

!!! <summary>
!!! Generated from procedure template - Window
!!! Seleccionar un registro de Plantas
!!! </summary>
SelectPlantas PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Plantas)
                       PROJECT(pla:ID_PLANTA)
                       PROJECT(pla:ID_LOCALIDAD)
                       PROJECT(pla:NRO_PLANTA)
                       PROJECT(pla:CAPACIDAD)
                       PROJECT(pla:EXISTENCIA_ACTUAL)
                       JOIN(Loc:PK_localidad,pla:ID_LOCALIDAD)
                         PROJECT(Loc:id_localidad)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
pla:ID_PLANTA          LIKE(pla:ID_PLANTA)            !List box control field - type derived from field
pla:ID_LOCALIDAD       LIKE(pla:ID_LOCALIDAD)         !List box control field - type derived from field
pla:NRO_PLANTA         LIKE(pla:NRO_PLANTA)           !List box control field - type derived from field
pla:CAPACIDAD          LIKE(pla:CAPACIDAD)            !List box control field - type derived from field
pla:EXISTENCIA_ACTUAL  LIKE(pla:EXISTENCIA_ACTUAL)    !List box control field - type derived from field
Loc:id_localidad       LIKE(Loc:id_localidad)         !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,260,260),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('SelectPlantas'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(40,65,179,115),USE(?Browse:1),HVSCROLL,FORMAT('40L(2)|M~Id Planta~@P<<<<P@0L(2)' & |
  '|M~Localidad~L(0)@n-14@38L(2)|M~Nro planta~@P<<<<P@40C|M~Capacidad~@N-10_@20L(2)|M~E' & |
  'xistencia~C(0)@N-10.`2@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the Plantas file')
                       BUTTON,AT(24,210,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Seleccionar el registro'), |
  TIP('Seleccionar el registro')
                       BUTTON,AT(211,210,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       STRING('Seleccionar Planta GLP'),AT(82,15),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       STRING('Localidad:'),AT(59,44),USE(?STRING2),FONT(,,,FONT:regular),TRN
                       STRING(@s20),AT(103,44,97,10),USE(Loc:Localidad),FONT(,,,FONT:regular),TRN
                       BOX,AT(10,204,240,36),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BOX,AT(10,35,240,165),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
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
  GlobalErrors.SetProcedureName('SelectPlantas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('pla:ID_LOCALIDAD',pla:ID_LOCALIDAD)                ! Added by: BrowseBox(ABC)
  BIND('GLO:localidad_id',GLO:localidad_id)                ! Added by: BrowseBox(ABC)
  BIND('pla:ID_PLANTA',pla:ID_PLANTA)                      ! Added by: BrowseBox(ABC)
  BIND('pla:NRO_PLANTA',pla:NRO_PLANTA)                    ! Added by: BrowseBox(ABC)
  BIND('pla:EXISTENCIA_ACTUAL',pla:EXISTENCIA_ACTUAL)      ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Plantas.SetOpenRelated()
  Relate:Plantas.Open                                      ! File Plantas used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Plantas,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,pla:PK__plantas__7D439ABD)            ! Add the sort order for pla:PK__plantas__7D439ABD for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,pla:ID_PLANTA,,BRW1)           ! Initialize the browse locator using  using key: pla:PK__plantas__7D439ABD , pla:ID_PLANTA
  BRW1.SetFilter('(pla:ID_LOCALIDAD=GLO:localidad_id)')    ! Apply filter expression to browse
  BRW1.AddField(pla:ID_PLANTA,BRW1.Q.pla:ID_PLANTA)        ! Field pla:ID_PLANTA is a hot field or requires assignment from browse
  BRW1.AddField(pla:ID_LOCALIDAD,BRW1.Q.pla:ID_LOCALIDAD)  ! Field pla:ID_LOCALIDAD is a hot field or requires assignment from browse
  BRW1.AddField(pla:NRO_PLANTA,BRW1.Q.pla:NRO_PLANTA)      ! Field pla:NRO_PLANTA is a hot field or requires assignment from browse
  BRW1.AddField(pla:CAPACIDAD,BRW1.Q.pla:CAPACIDAD)        ! Field pla:CAPACIDAD is a hot field or requires assignment from browse
  BRW1.AddField(pla:EXISTENCIA_ACTUAL,BRW1.Q.pla:EXISTENCIA_ACTUAL) ! Field pla:EXISTENCIA_ACTUAL is a hot field or requires assignment from browse
  BRW1.AddField(Loc:id_localidad,BRW1.Q.Loc:id_localidad)  ! Field Loc:id_localidad is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectPlantas',QuickWindow)                ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Plantas.Close
  END
  IF SELF.Opened
    INIMgr.Update('SelectPlantas',QuickWindow)             ! Save window data to non-volatile store
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

