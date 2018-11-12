

   MEMBER('existencias.clw')                               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('BRWEXT.INC'),ONCE

                     MAP
                       INCLUDE('EXISTENCIAS006.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('EXISTENCIAS001.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS005.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS007.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS008.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS010.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS011.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Browse the programacion file
!!! </summary>
SelectProgramacion PROCEDURE 

CurrentTab           STRING(80)                            !
BRW7::View:Browse    VIEW(programacion)
                       PROJECT(prog:nro_semana)
                       PROJECT(prog:cupo_GLP)
                       PROJECT(prog:cupo_GLP_utilizado)
                       PROJECT(prog:cupo_GLP_restante)
                       PROJECT(prog:id_programacion)
                       PROJECT(prog:id_proveedor)
                       JOIN(pro:PK_proveedor,prog:id_proveedor)
                         PROJECT(pro:proveedor)
                         PROJECT(pro:id_proveedor)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
prog:nro_semana        LIKE(prog:nro_semana)          !List box control field - type derived from field
prog:cupo_GLP          LIKE(prog:cupo_GLP)            !List box control field - type derived from field
prog:cupo_GLP_utilizado LIKE(prog:cupo_GLP_utilizado) !List box control field - type derived from field
prog:cupo_GLP_restante LIKE(prog:cupo_GLP_restante)   !List box control field - type derived from field
prog:id_programacion   LIKE(prog:id_programacion)     !Primary key field - type derived from field
pro:id_proveedor       LIKE(pro:id_proveedor)         !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,427,296),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('SelectProgramacion'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(368,237,33,33),USE(?Close),LEFT,ICON('Cancelar.ico'),FLAT,MSG('Close Window'),TIP('Close Window'), |
  TRN
                       STRING('Seleccione una programación'),AT(146,17),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       LIST,AT(38,105,363,113),USE(?List),FORMAT('88L(2)|M~Proveedor~C(0)@s50@40L(2)|M~nro sem' & |
  'ana~C(1)@P<<P@80L(2)|M~Cupo~L(1)@N20@80L(2)|M~Cupo GLP utilizado~L(1)@N20@80L(2)|M~C' & |
  'upo GLP restante~L(1)@N20@'),FROM(Queue:Browse),IMM
                       STRING('Proveedor:'),AT(49,43),USE(?STRING2),TRN
                       STRING(@s50),AT(88,43,109,10),USE(pro:proveedor),TRN
                       STRING('Año:'),AT(49,63,20,9),USE(?STRING2:2),TRN
                       STRING(@P<<<<P),AT(73,63,20,9),USE(prog:ano),TRN
                       STRING(@P<<P),AT(73,82,20,9),USE(prog:mes),TRN
                       STRING('Mes:'),AT(49,82,20,9),USE(?STRING2:3),TRN
                       BUTTON,AT(37,237,33,33),USE(?Select),ICON('seleccionar.ICO'),FLAT,TRN
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW7                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
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
  GlobalErrors.SetProcedureName('SelectProgramacion')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Close
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('glo:id_proveedor',glo:id_proveedor)                ! Added by: BrowseBox(ABC)
  BIND('glo:ano',glo:ano)                                  ! Added by: BrowseBox(ABC)
  BIND('glo:mes',glo:mes)                                  ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:programacion.Open                                 ! File programacion used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW7.Init(?List,Queue:Browse.ViewPosition,BRW7::View:Browse,Queue:Browse,Relate:programacion,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW7.Q &= Queue:Browse
  BRW7.RetainRow = 0
  BRW7.AddSortOrder(,prog:PK_PROGRAMACION)                 ! Add the sort order for prog:PK_PROGRAMACION for sort order 1
  BRW7.AddLocator(BRW7::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW7::Sort0:Locator.Init(,prog:id_programacion,1,BRW7)   ! Initialize the browse locator using  using key: prog:PK_PROGRAMACION , prog:id_programacion
  BRW7.SetFilter('((prog:id_proveedor= glo:id_proveedor) and (prog:ano=glo:ano) and (prog:mes=glo:mes))') ! Apply filter expression to browse
  BRW7.AddField(pro:proveedor,BRW7.Q.pro:proveedor)        ! Field pro:proveedor is a hot field or requires assignment from browse
  BRW7.AddField(prog:nro_semana,BRW7.Q.prog:nro_semana)    ! Field prog:nro_semana is a hot field or requires assignment from browse
  BRW7.AddField(prog:cupo_GLP,BRW7.Q.prog:cupo_GLP)        ! Field prog:cupo_GLP is a hot field or requires assignment from browse
  BRW7.AddField(prog:cupo_GLP_utilizado,BRW7.Q.prog:cupo_GLP_utilizado) ! Field prog:cupo_GLP_utilizado is a hot field or requires assignment from browse
  BRW7.AddField(prog:cupo_GLP_restante,BRW7.Q.prog:cupo_GLP_restante) ! Field prog:cupo_GLP_restante is a hot field or requires assignment from browse
  BRW7.AddField(prog:id_programacion,BRW7.Q.prog:id_programacion) ! Field prog:id_programacion is a hot field or requires assignment from browse
  BRW7.AddField(pro:id_proveedor,BRW7.Q.pro:id_proveedor)  ! Field pro:id_proveedor is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectProgramacion',QuickWindow)           ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW7.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:programacion.Close
  END
  IF SELF.Opened
    INIMgr.Update('SelectProgramacion',QuickWindow)        ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


BRW7.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window


!!! <summary>
!!! Generated from procedure template - Window
!!! Browse the Existencias file
!!! </summary>
BrowseExistencias PROCEDURE 

CurrentTab           STRING(80)                            !
l:nro_planta         STRING(20),NAME('"NRO_PLANTA"')       !
l:buscador           CSTRING(100)                          !
l:fecha_existencia   DATE                                  !
l:id_planta          LONG                                  !
l:fecha_desde        DATE                                  !
l:fecha_hasta        DATE                                  !
l:existencia_total   LONG                                  !
L:consumo_total      DECIMAL(15)                           !
l:localidad_id       LONG                                  !
l:localidad          STRING(20)                            !
l:filtro             CSTRING(500)                          !
BRW1::View:Browse    VIEW(Existencias)
                       PROJECT(exi:id_existencia)
                       PROJECT(exi:FECHA_LECTURA_DATE)
                       PROJECT(exi:id_localidad)
                       PROJECT(exi:capacidad_planta)
                       PROJECT(exi:id_planta)
                       PROJECT(exi:existencia_anterior)
                       PROJECT(exi:existencia)
                       PROJECT(exi:porc_existencia)
                       PROJECT(exi:consumo)
                       PROJECT(exi:AUTONOMIA)
                       JOIN(pla:PK__plantas__7D439ABD,exi:id_planta)
                         PROJECT(pla:NRO_PLANTA)
                         PROJECT(pla:ID_PLANTA)
                         PROJECT(pla:ID_LOCALIDAD)
                         JOIN(Loc:PK_localidad,pla:ID_LOCALIDAD)
                           PROJECT(Loc:Localidad)
                           PROJECT(Loc:id_localidad)
                         END
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
exi:id_existencia      LIKE(exi:id_existencia)        !List box control field - type derived from field
exi:FECHA_LECTURA_DATE LIKE(exi:FECHA_LECTURA_DATE)   !List box control field - type derived from field
exi:id_localidad       LIKE(exi:id_localidad)         !List box control field - type derived from field
pla:NRO_PLANTA         LIKE(pla:NRO_PLANTA)           !List box control field - type derived from field
Loc:Localidad          LIKE(Loc:Localidad)            !List box control field - type derived from field
exi:capacidad_planta   LIKE(exi:capacidad_planta)     !List box control field - type derived from field
exi:id_planta          LIKE(exi:id_planta)            !List box control field - type derived from field
exi:existencia_anterior LIKE(exi:existencia_anterior) !List box control field - type derived from field
exi:existencia         LIKE(exi:existencia)           !List box control field - type derived from field
exi:porc_existencia    LIKE(exi:porc_existencia)      !List box control field - type derived from field
exi:consumo            LIKE(exi:consumo)              !List box control field - type derived from field
exi:AUTONOMIA          LIKE(exi:AUTONOMIA)            !List box control field - type derived from field
pla:ID_PLANTA          LIKE(pla:ID_PLANTA)            !Related join file key field - type derived from field
Loc:id_localidad       LIKE(Loc:id_localidad)         !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('Browse Existencias Totales'),SYSTEM,WALLPAPER('fondo.jpg')
                       ENTRY(@P<<<<P),AT(134,12,21),USE(GLO:localidad_id),HIDE
                       BUTTON,AT(168,37,14,14),USE(?CallLookupLocalidad),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@P<<P),AT(271,39,14,12),USE(l:nro_planta),TRN
                       BUTTON,AT(288,37,12,12),USE(?CallLookupPlanta),ICON('Lupita.ico'),FLAT,TRN
                       BUTTON,AT(441,47,,25),USE(?BUTTONfiltrar),ICON('seleccionar.ICO'),FLAT,TRN
                       BUTTON,AT(470,47,25,25),USE(?BUTTONfiltrar:2),ICON('sin_filtro.ico'),FLAT,TRN
                       ENTRY(@d6),AT(91,63,60,10),USE(GLO:fecha_Desde)
                       BUTTON,AT(153,54,25,25),USE(?BotonSeleccionFechaDesde),ICON('calen.ico'),FLAT,TRN
                       ENTRY(@d6),AT(228,62,60,10),USE(GLO:fecha_hasta)
                       BUTTON,AT(293,54,25,25),USE(?BotonSeleccionFechaHasta),ICON('calen.ico'),FLAT,TRN
                       ENTRY(@s99),AT(188,95),USE(l:buscador)
                       BUTTON,AT(337,94,16,14),USE(?Browse:Top),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page'), |
  TRN
                       BUTTON,AT(354,94,16,14),USE(?Browse:PageUp),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the Prior Page'), |
  TRN
                       BUTTON,AT(371,94,16,14),USE(?Browse:Up),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record'), |
  TRN
                       BUTTON,AT(387,94,16,14),USE(?Browse:Down),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record'), |
  TRN
                       BUTTON,AT(404,94,16,14),USE(?Browse:PageDown),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page'), |
  TRN
                       BUTTON,AT(421,94,16,14),USE(?Browse:Bottom),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page'), |
  TRN
                       LIST,AT(29,116,475,158),USE(?Browse:1),HVSCROLL,FORMAT('31R(2)|M~Nro~C(1)@N-14_@48R(2)|' & |
  'M~Fecha Lectura~C(0)@d6@0L(2)|M~Localidad~L(1)@N-14_@[34L(2)|M~Nro planta~L(0)@P<<<<' & |
  'P@80L(2)|M~Localidad~C(0)@s20@40D|M~Capacidad~C(0)@N-20_~KG~@](162)|~Planta~0L(2)|M~' & |
  'Id Planta~@P<<<<P@[72D(10)|M~Anterior~C(0)@N-20_~KG~@48D(10)|M~Actual~C(0)@N-20_~KG~' & |
  '@58D(10)|M~% ~C(0)@N-7_~ %~@]|~Existencias~48D(10)|M~Consumo~C(0)@N-20_~KG~@40L(2)|M' & |
  '~Autonomía~@N20_@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the Existencias file')
                       BUTTON,AT(163,300,25,23),USE(?View:2),LEFT,ICON('Ver.ico'),FLAT,MSG('Vizualizar la existencia'), |
  TIP('Vizualizar la existencia'),TRN
                       BUTTON,AT(197,300,25,23),USE(?Insert:3),LEFT,ICON('Insertar.ico'),FLAT,MSG('Ingresar un' & |
  'a existencia'),TIP('Ingresar una existencia'),TRN
                       BUTTON,AT(231,300,25,23),USE(?Change:3),LEFT,ICON('Editar.ico'),FLAT,MSG('Change the Record'), |
  TIP('Change the Record'),TRN
                       BUTTON,AT(265,300,25,23),USE(?Delete:3),LEFT,ICON('Eliminar.ICO'),FLAT,MSG('Eliminar la' & |
  ' existencia'),TIP('Eliminar la existencia'),TRN
                       BUTTON,AT(461,300,25,23),USE(?Close),LEFT,ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'), |
  TIP('Cerrar ventana')
                       PROMPT('Existencias en Planta'),AT(219,14),USE(?GLO:localidad_id:Prompt:2),FONT('Arial',10, |
  ,FONT:bold+FONT:italic+FONT:underline,CHARSET:ANSI),TRN
                       BOX,AT(28,297,476,30),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BOX,AT(28,29,476,58),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       STRING(@s20),AT(81,39,83,12),USE(l:localidad),TRN
                       STRING('Localidad:'),AT(41,39,36,10),USE(?STRING1:2),TRN
                       PROMPT('Fecha Desde'),AT(41,63),USE(?l:fecha_desde:Prompt),TRN
                       PROMPT('Fecha Hasta'),AT(183,63),USE(?l:fecha_hasta:Prompt),TRN
                       PROMPT('Planta Nro'),AT(233,39),USE(?l:id_planta:Prompt:2),TRN
                       BUTTON,AT(301,300,26,24),USE(?BtnimprimirExistencias),ICON('Imprimir.ico'),FLAT,MSG('Imprimir e' & |
  'xistencias por localidad'),TIP('Imprimir existencias por localidad'),TRN
                       BOX,AT(28,88,476,26),USE(?BOX1:3),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       PROMPT('Buscar:'),AT(160,97),USE(?l:fecha_desde:Prompt:2),TRN
                       ENTRY(@P<<<<P),AT(345,15,24),USE(GLO:id_planta),HIDE
                       BUTTON,AT(339,300,26,24),USE(?BtnimprimirExistencias:2),ICON('Imprimir.ico'),FLAT,MSG('Imprimir E' & |
  'xistencias'),TIP('Imprimir Existencias'),TRN
                       PROMPT('Total consumo:'),AT(388,283),USE(?l:id_planta:Prompt),TRN
                       STRING(@n-20.0),AT(441,282,63,12),USE(L:consumo_total),TRN
                       PROMPT('Existencia Total:'),AT(251,284),USE(?l:id_planta:Prompt:3),TRN
                       STRING(@n-14),AT(320,283,63,12),USE(l:existencia_total),TRN
                       BUTTON,AT(382,300,26,24),USE(?EvoExportar),LEFT,ICON('exportar.ico'),FLAT,TRN
                       BUTTON('Button1'),AT(81,300,,18),USE(?BUTTON1)
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
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
SetAlerts              PROCEDURE(),DERIVED
SetQueueRecord         PROCEDURE(),DERIVED
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
filtrar             ROUTINE
    IF GLO:localidad_id <> 0 and GLO:id_planta <> 0
    
        l:filtro = '' 
        
        if glo:localidad_id <> 0
            l:filtro ='exi:id_localidad ='&glo:localidad_id
            
        END
        if glo:id_planta <> 0 
            if len(l:filtro) <> 0
                l:filtro = clip(l:filtro) &' and '
         END
            
            l:filtro =clip(l:filtro)& ' exi:id_planta = '&glo:id_planta
        END
        
        
        if glo:fecha_desde <> 0
           if len(l:filtro) <> 0
                l:filtro = clip(l:filtro) &' and '
            END
            l:filtro = clip(l:filtro) &' exi:fecha_lectura_date >='&glo:fecha_desde
        END
        
        if glo:fecha_hasta <> 0
            if len(l:filtro) <> 0
                l:filtro = clip(l:filtro) &' and '
            END
            l:filtro = clip(l:filtro) &' exi:fecha_lectura_date <= '&glo:fecha_hasta
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
    ELSE
        MESSAGE('Debe seleccionar una localidad o una planta','Atención',ICON:Exclamation)
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
       Qp211:F2N  = 'Nro'
  Qp211:F2P  = '@N-14_'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Fecha Lectura'
  Qp211:F2P  = '@d6'
  Qp211:F2T  = '0'
  ADD(QPar211)
  Qp211:F2N  = 'ECNOEXPORT'
  Qp211:F2P  = '@N-14_'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Nro planta'
  Qp211:F2P  = '@P<<P'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Localidad'
  Qp211:F2P  = '@s20'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Capacidad'
  Qp211:F2P  = '@N-20_~KG~'
  Qp211:F2T  = '0'
  ADD(QPar211)
  Qp211:F2N  = 'ECNOEXPORT'
  Qp211:F2P  = '@P<<P'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Anterior'
  Qp211:F2P  = '@N-20_~KG~'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Actual'
  Qp211:F2P  = '@N-20_~KG~'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = '% '
  Qp211:F2P  = '@N-7_~ %~'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Consumo'
  Qp211:F2P  = '@N-20_~KG~'
  Qp211:F2T  = '0'
  ADD(QPar211)
       Qp211:F2N  = 'Autonomía'
  Qp211:F2P  = '@N20_'
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
  Loc::Titulo11 ='Administrator the Existencias'
 
 SavPath11 = PATH()
  Exportar(Loc::QHlist11,BRW1.Q,QPar11,0,Loc::Titulo11,Evo::Group11)
 IF Not EC::LoadI_11 Then  BRW1.FileLoaded=false.
 SETPATH(SavPath11)
 !!!! Fin Routina Templates Clarion

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseExistencias')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?GLO:localidad_id
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('GLO:localidad_id',GLO:localidad_id)                ! Added by: BrowseBox(ABC)
  BIND('exi:id_existencia',exi:id_existencia)              ! Added by: BrowseBox(ABC)
  BIND('exi:id_localidad',exi:id_localidad)                ! Added by: BrowseBox(ABC)
  BIND('pla:NRO_PLANTA',pla:NRO_PLANTA)                    ! Added by: BrowseBox(ABC)
  BIND('exi:capacidad_planta',exi:capacidad_planta)        ! Added by: BrowseBox(ABC)
  BIND('exi:id_planta',exi:id_planta)                      ! Added by: BrowseBox(ABC)
  BIND('exi:existencia_anterior',exi:existencia_anterior)  ! Added by: BrowseBox(ABC)
  BIND('exi:porc_existencia',exi:porc_existencia)          ! Added by: BrowseBox(ABC)
  BIND('pla:ID_PLANTA',pla:ID_PLANTA)                      ! Added by: BrowseBox(ABC)
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
  Relate:Existencias.SetOpenRelated()
  Relate:Existencias.Open                                  ! File Existencias used by this procedure, so make sure it's RelationManager is open
  Access:Localidades_GLP.UseFile                           ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Existencias,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,exi:PK__EXISTENC__36B12243)           ! Add the sort order for exi:PK__EXISTENC__36B12243 for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(?l:buscador,exi:id_existencia,1,BRW1) ! Initialize the browse locator using ?l:buscador using key: exi:PK__EXISTENC__36B12243 , exi:id_existencia
  BRW1.AddField(exi:id_existencia,BRW1.Q.exi:id_existencia) ! Field exi:id_existencia is a hot field or requires assignment from browse
  BRW1.AddField(exi:FECHA_LECTURA_DATE,BRW1.Q.exi:FECHA_LECTURA_DATE) ! Field exi:FECHA_LECTURA_DATE is a hot field or requires assignment from browse
  BRW1.AddField(exi:id_localidad,BRW1.Q.exi:id_localidad)  ! Field exi:id_localidad is a hot field or requires assignment from browse
  BRW1.AddField(pla:NRO_PLANTA,BRW1.Q.pla:NRO_PLANTA)      ! Field pla:NRO_PLANTA is a hot field or requires assignment from browse
  BRW1.AddField(Loc:Localidad,BRW1.Q.Loc:Localidad)        ! Field Loc:Localidad is a hot field or requires assignment from browse
  BRW1.AddField(exi:capacidad_planta,BRW1.Q.exi:capacidad_planta) ! Field exi:capacidad_planta is a hot field or requires assignment from browse
  BRW1.AddField(exi:id_planta,BRW1.Q.exi:id_planta)        ! Field exi:id_planta is a hot field or requires assignment from browse
  BRW1.AddField(exi:existencia_anterior,BRW1.Q.exi:existencia_anterior) ! Field exi:existencia_anterior is a hot field or requires assignment from browse
  BRW1.AddField(exi:existencia,BRW1.Q.exi:existencia)      ! Field exi:existencia is a hot field or requires assignment from browse
  BRW1.AddField(exi:porc_existencia,BRW1.Q.exi:porc_existencia) ! Field exi:porc_existencia is a hot field or requires assignment from browse
  BRW1.AddField(exi:consumo,BRW1.Q.exi:consumo)            ! Field exi:consumo is a hot field or requires assignment from browse
  BRW1.AddField(exi:AUTONOMIA,BRW1.Q.exi:AUTONOMIA)        ! Field exi:AUTONOMIA is a hot field or requires assignment from browse
  BRW1.AddField(pla:ID_PLANTA,BRW1.Q.pla:ID_PLANTA)        ! Field pla:ID_PLANTA is a hot field or requires assignment from browse
  BRW1.AddField(Loc:id_localidad,BRW1.Q.Loc:id_localidad)  ! Field Loc:id_localidad is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseExistencias',QuickWindow)            ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 5
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,exi:PK__EXISTENC__36B12243)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Existencias.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('BrowseExistencias',QuickWindow)         ! Save window data to non-volatile store
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
      SelectLocalidades_GLP
      SelectPlantas
      UpdateExistencias
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
    OF ?BtnimprimirExistencias
      brw1.SetOrder('exi:id_planta')
      brw1.ApplyOrder()
      ThisWindow.Reset(1)
      
      
          
      
      
      
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
    OF ?CallLookupLocalidad
      ThisWindow.Update
      
      !        IF GLO:id_planta = 0
      !            pla:ID_LOCALIDAD = GLO:localidad_id
      !            set(pla:PLA_PLA_FK_LOCALIDAD,pla:PLA_PLA_FK_LOCALIDAD)
      !            IF RECORDS(pla:PLA_PLA_FK_LOCALIDAD) > 1 !
      !
      !                IF SELF.Run(2,SelectRecord) = RequestCompleted ! Ejecuto el selectPlantas (Ver proc Window.Run)
      !                    GLO:id_planta = pla:ID_PLANTA
      !                    l:nro_planta = pla:NRO_PLANTA
      !                END
      !            ELSE
      !                GLO:id_planta = pla:ID_PLANTA
      !                l:nro_planta = pla:NRO_PLANTA
      !                
      !            END
      !            
      !            DISPLAY(?GLO:id_planta)
      !            DISPLAY(?l:NRO_PLANTA)
      !            
      !        ELSE
      !           
      !        END
      !        DO filtrar
      !        ThisWindow.Reset(1)
      !    END
      !    
      !   
      
      Loc:id_localidad = GLO:localidad_id
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        GLO:localidad_id = Loc:id_localidad
        l:localidad = Loc:Localidad
      END
      ThisWindow.Reset(1)
    OF ?CallLookupPlanta
      ThisWindow.Update
      pla:ID_PLANTA = GLO:id_planta
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        GLO:id_planta = pla:ID_PLANTA
        l:nro_planta = pla:NRO_PLANTA
      END
      ThisWindow.Reset(1)
    OF ?BUTTONfiltrar
      ThisWindow.Update
      do filtrar
    OF ?BUTTONfiltrar:2
      ThisWindow.Update
      !Reset el filtro y filtra por glo:localidad id
      BRW1.SetFilter('')
      brw1.ApplyFilter()
      ThisWindow.Reset(true)
      
      
      
      
    OF ?BotonSeleccionFechaDesde
      ThisWindow.Update
      CHANGE(?GLO:fecha_Desde,bigfec(CONTENTS(?GLO:fecha_Desde)))
      !DO RefreshWindow
    OF ?BotonSeleccionFechaHasta
      ThisWindow.Update
      CHANGE(?GLO:fecha_hasta,bigfec(CONTENTS(?GLO:fecha_hasta)))
      !DO RefreshWindow
    OF ?BtnimprimirExistencias
      ThisWindow.Update
      START(ReportExistencias, 50000, BRW1.VIEW{PROP:FILTER},BRW1.VIEW{PROP:ORDER})
      ThisWindow.Reset
    OF ?GLO:id_planta
      IF GLO:id_planta OR ?GLO:id_planta{PROP:Req}
        pla:ID_PLANTA = GLO:id_planta
        IF Access:Plantas.TryFetch(pla:PK__plantas__7D439ABD)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            GLO:id_planta = pla:ID_PLANTA
            l:nro_planta = pla:NRO_PLANTA
          ELSE
            CLEAR(l:nro_planta)
            SELECT(?GLO:id_planta)
            CYCLE
          END
        ELSE
          l:nro_planta = pla:NRO_PLANTA
        END
      END
      ThisWindow.Reset(1)
    OF ?BtnimprimirExistencias:2
      ThisWindow.Update
      START(ReportExistencias_2, 50000, BRW1.VIEW{PROP:FILTER},BRW1.VIEW{PROP:ORDER})
      ThisWindow.Reset
    OF ?EvoExportar
      ThisWindow.Update
       Do PrintExBrowse11
    OF ?BUTTON1
      ThisWindow.Update
      START(GraficoExistencia, 25000)
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
        if glo:id_planta <> 0
            do filtrar
        END
        
        
    END
  OF ?CallLookupLocalidad
    IF GlobalResponse = RequestCompleted
        IF GLO:localidad_id <> 0  
            pla:ID_LOCALIDAD = GLO:localidad_id
           
            if Access:Plantas.Fetch(pla:PLA_PLA_FK_LOCALIDAD) = Level:Benign
                !message('La localidad posee 1 planta')
                GLO:id_planta = pla:ID_PLANTA
                l:nro_planta = pla:NRO_PLANTA
                DISPLAY(?GLO:id_planta)
                DISPLAY(?l:NRO_PLANTA)
                DO filtrar
            END
       
           
        END
      
    END
  OF ?CallLookupPlanta
    !if GlobalResponse = RequestCompleted
    !    if GLO:id_planta <> 0
    !        do filtrar
    !       
    !    END
    !    
    !END
    !
    !    
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
    OF ?GLO:id_planta
      pla:ID_PLANTA = GLO:id_planta
      IF Access:Plantas.TryFetch(pla:PK__plantas__7D439ABD)
        IF SELF.Run(2,SelectRecord) = RequestCompleted
          GLO:id_planta = pla:ID_PLANTA
          l:nro_planta = pla:NRO_PLANTA
      ELSE
          CLEAR(l:nro_planta)
        END
      END
      ThisWindow.Reset
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
      !Open Window
      GLO:fecha_Desde=date(month(today()),1,year(today()))
      GLO:fecha_hasta=TODAY()
      DISPLAY()
    END
  ReturnValue = PARENT.TakeWindowEvent()
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


BRW1.ResetFromView PROCEDURE

L:consumo_total:Sum  REAL                                  ! Sum variable for browse totals
l:existencia_total:Sum REAL                                ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:Existencias.SetQuickScan(1)
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
    L:consumo_total:Sum += exi:consumo
    l:existencia_total:Sum += exi:existencia
  END
  SELF.View{PROP:IPRequestCount} = 0
  L:consumo_total = L:consumo_total:Sum
  l:existencia_total = l:existencia_total:Sum
  PARENT.ResetFromView
  !MESSAGE(exi:consumo:Sum)
  Relate:Existencias.SetQuickScan(0)
  SETCURSOR()


BRW1.SetAlerts PROCEDURE

  CODE
  SELF.EditViaPopup = False
  PARENT.SetAlerts


BRW1.SetQueueRecord PROCEDURE

  CODE
  PARENT.SetQueueRecord
  !exi:consumo:Sum += exi:consumo
  


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
!!! Form Existencias
!!! </summary>
UpdateExistencias PROCEDURE 

l:tipo_existencia    STRING(20)                            !
l:ultima_descarga_id LONG                                  !
l:id_existencia      LONG                                  !
CurrentTab           STRING(80)                            !
l:localidad          STRING(50)                            !
l:existencia_anterior_id LONG                              !
L:prod_disponible    DECIMAL(15)                           !
ActionMessage        CSTRING(40)                           !
History::exi:Record  LIKE(exi:RECORD),THREAD
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,,CHARSET:DEFAULT),DOUBLE,CENTER,GRAY,IMM, |
  MDI,HLP('UpdateExistenciasTotales'),SYSTEM,WALLPAPER('fondo.jpg')
                       ENTRY(@N-14_),AT(357,76,16,10),USE(exi:id_localidad),HIDE,REQ
                       BUTTON,AT(135,76,12,12),USE(?CallLookupLocalidad),ICON('Lupita.ico'),FLAT,MSG('Eliga la l' & |
  'ocalidad a la que pertenece la existencia'),TRN
                       ENTRY(@P<<P),AT(399,76,16,10),USE(exi:id_planta),OVR,HIDE,REQ
                       BUTTON,AT(135,94,12,12),USE(?CallLookupPlanta),ICON('Lupita.ico'),FLAT,TRN
                       ENTRY(@d6),AT(189,147,48,10),USE(exi:FECHA_LECTURA_DATE),MSG('Fecha de la lectura de la' & |
  ' existencia'),REQ,TIP('Fecha de la lectura de la existencia')
                       BUTTON,AT(241,140,25,25),USE(?BotonSeleccionFecha),ICON('calen.ico'),FLAT,TRN
                       ENTRY(@N-20_),AT(189,188,48,10),USE(exi:existencia_anterior),MSG('Lectura de la existen' & |
  'cia anterior'),READONLY,TIP('Lectura de la existencia anterior')
                       PROMPT('KG'),AT(241,190),USE(?exi:id_planta:Prompt:4),TRN
                       ENTRY(@N-20_),AT(189,207,48,10),USE(exi:ultima_descarga),MSG('Descarga realizada en la ' & |
  'ultima lectura'),READONLY,TIP('Descarga realizada en la ultima lectura')
                       PROMPT('KG'),AT(241,209),USE(?exi:id_planta:Prompt:5),TRN
                       ENTRY(@n-20.0),AT(189,225,48,10),USE(exi:existencia),MSG('Lectura de la existencia actual'), |
  REQ,TIP('Lectura de la existencia actual')
                       STRING(@N-20_~ KG~),AT(189,246,63,10),USE(exi:consumo,,?exi:consumo:2),DECIMAL(36),TRN
                       BUTTON,AT(323,248,25,25),USE(?BtnCalcularConsumo),ICON('Calcular.ico'),DISABLE,FLAT,HIDE,TRN
                       BUTTON,AT(447,291,25,25),USE(?OK),LEFT,ICON('Aceptar.ICO'),FLAT,MSG('Aceptar los datos ' & |
  'y cerrar ventana'),TIP('Aceptar los datos y cerrar ventana')
                       BUTTON,AT(477,291,25,25),USE(?Cancel),LEFT,ICON('Cancelar.ico'),DEFAULT,FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       PROMPT('Planta:'),AT(98,95),USE(?exi:id_planta:Prompt),TRN
                       PROMPT('Existencia:'),AT(125,226),USE(?exi:existencia:Prompt),TRN
                       PROMPT('Existencia %:'),AT(125,264),USE(?exi:porc_existencia:Prompt),TRN
                       PROMPT('Consumo:'),AT(125,246),USE(?exi:consumo:Prompt),TRN
                       PROMPT('Cap. Planta:'),AT(183,96),USE(?exi:capacidad_planta:Prompt),TRN
                       PROMPT('Fecha Lectura:'),AT(125,147),USE(?aexi:FECHA_LECTURA_DATE:Prompt),TRN
                       PROMPT('Autonomia'),AT(125,283),USE(?exi:AUTONOMIA:Prompt),TRN
                       STRING(@s50),AT(151,78,138,10),USE(l:localidad),TRN
                       STRING(@P<<P),AT(165,96,14,10),USE(pla:NRO_PLANTA),TRN
                       PROMPT('Nro:'),AT(150,96),USE(?exi:id_planta:Prompt:2),TRN
                       STRING('Ingreso de existencias en Planta'),AT(198,15),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       STRING(@N-20_~ KG~),AT(231,96),USE(pla:CAPACIDAD),LEFT,TRN
                       STRING(@N-7.~%~),AT(189,264),USE(exi:porc_existencia,,?exi:porc_existencia:2),FONT(,,,FONT:regular), |
  DECIMAL(5),TRN
                       STRING(@N20),AT(189,283,49,10),USE(exi:AUTONOMIA,,?exi:AUTONOMIA:2),FONT(,,,FONT:regular), |
  DECIMAL(22),TRN
                       PROMPT('Localidad:'),AT(98,76),USE(?exi:id_planta:Prompt:3),TRN
                       BOX,AT(89,46,357,73),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BOX,AT(89,134,357,174),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       PROMPT('Planta:'),AT(94,34),USE(?exi:id_existencia:Prompt:2),TRN
                       PROMPT('Existencia:'),AT(91,123),USE(?exi:id_existencia:Prompt:3),TRN
                       STRING(@N-20_),AT(189,169,49,10),USE(exi:capacidad_planta),DECIMAL(37),TRN
                       PROMPT('Cap. Planta:'),AT(125,169),USE(?exi:capacidad_planta:Prompt:2),TRN
                       PROMPT('Existencia anterior:'),AT(125,189),USE(?aexi:FECHA_LECTURA_DATE:Prompt:2),TRN
                       PROMPT('Ultima descarga:'),AT(125,207),USE(?aexi:FECHA_LECTURA_DATE:Prompt:3),TRN
                       PROMPT('KG'),AT(241,226),USE(?exi:id_planta:Prompt:6),TRN
                       ENTRY(@n-14),AT(323,187,18,10),USE(exi:id_existencia_anterior),RIGHT(1),HIDE
                       BUTTON,AT(253,186,12,12),USE(?CallLookupExistenciaAnterior),ICON('Lupita.ico'),FLAT,TRN
                       ENTRY(@n-14),AT(323,207,18,10),USE(exi:id_descarga_ultima),RIGHT(1),HIDE
                       PROMPT('Nro existencia:'),AT(98,56),USE(?exi:id_existencia:Prompt),TRN
                       BUTTON,AT(469,153,12,12),USE(?BtnUpdateUltimaDescarga),ICON('Lupita.ico'),DISABLE,FLAT,HIDE, |
  TRN
                       BUTTON,AT(257,207,12,12),USE(?CallLookupDescarga),ICON('Lupita.ico'),FLAT,TRN
                       PROMPT('Días'),AT(241,283),USE(?exi:AUTONOMIA:Prompt:3),TRN
                       STRING(@N20_),AT(151,56,88),USE(exi:id_existencia,,?exi:id_existencia:2),TRN
                       BUTTON,AT(322,221,25,25),USE(?BtnCalcularExistencia),ICON('Calcular.ico'),FLAT,MSG('Calcula la' & |
  ' existencia en los tanques'),TIP('Calcula la existencia en los tanques'),TRN
                       STRING(@n-20_),AT(349,97),USE(L:prod_disponible),FONT(,,,FONT:regular),RIGHT,TRN
                       PROMPT('Disp.:'),AT(320,96),USE(?exi:capacidad_planta:Prompt:3),TRN
                       PROMPT('KG'),AT(241,169),USE(?exi:id_planta:Prompt:7),TRN
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
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
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
borrarMediciones    ROUTINE
    SET(Mediciones_aux)
    LOOP UNTIL Access:Mediciones_aux.Next()
        Access:Mediciones_aux.DeleteRecord(0)
    END
    
    
    EXIT
    
buscar_existencia   ROUTINE
    IF exi:id_localidad=0 or exi:id_planta=0
        IF exi:id_localidad= 0 THEN  message('Ingrese los datos de la localidad ').
        IF exi:id_planta = 0 THEN message('Ingrese los datos de la planta').
    ELSE
    
     
        SQL{PROP:SQL}='SELECT  TOP 1 ID_EXISTENCIA FROM DBO.EXISTENCIAS WHERE ID_PLANTA='&exi:id_planta&' ORDER BY FECHA_LECTURA DESC'
     
        NEXT(SQL)
        !message(SQL:campo1)
        exi1:id_existencia = SQL:campo1
        
        IF Access:ExistenciasAlias1.Fetch(exi1:PK__EXISTENC__36B12243) = Level:Benign
            exi:existencia_anterior =exi1:existencia
            exi:id_existencia_anterior =exi1:id_existencia
            DISPLAY(?exi:existencia_anterior)
            DISPLAY(?exi:FECHA_LECTURA_DATE)
        ELSE
            message(' No se pudo encontrar la existencia anterior')
        END
    END
    
    
  EXIT
    
calcular_consumo    ROUTINE
    exi:consumo =  exi:existencia_anterior + exi:ultima_descarga - exi:existencia
 
    
    if exi:capacidad_planta <> 0
        exi:porc_existencia = exi:existencia *100/exi:capacidad_planta
    ELSE
        exi:porc_existencia= exi:existencia *100/0.0001
    END
    
    if exi:consumo<>0
        exi:AUTONOMIA = exi:existencia/ exi:consumo
    ELSE
        exi:autonomia =exi:existencia/ 0.0001
    END
    
        
        
    
    EXIT

    
asignar_mediciones  ROUTINE
    CLEAR(med:RECORD)
    med:id_existencia = exi:id_existencia
    SET(Mediciones)
    SET(med:FK_EXISTENCIA,med:FK_EXISTENCIA)
    LOOP UNTIL ACCESS:MEDICIONES.Next() OR  med:id_existencia <> exi:id_existencia
        Access:Mediciones.DeleteRecord(0)
    END
    
    
    CLEAR(med1:RECORD)
    SET(Mediciones_aux)
    med1:id_existencia = exi:id_existencia
    SET(med1:K_TANQUE,med1:K_TANQUE)
    LOOP UNTIL ACCESS:Mediciones_aux.NEXT() AND med1:id_existencia <> exi:id_existencia
        med:id_tanque = med1:id_tanque
        med:ID_PLANTA = exi:ID_PLANTA
        med:id_localidad = exi:id_localidad
        med:id_existencia = exi:id_existencia
        med:fecha_lectura_DATE = exi:FECHA_LECTURA_DATE
        med:fecha_lectura_TIME = exi:FECHA_LECTURA_TIME
        med:nivel = med1:nivel
        med:id_nivel = med1:id_nivel
        med:temperatura = med1:temperatura
        med:presion = med1:presion
        med:densidad = med1:densidad
        med:id_factor_densidad = med1:id_factor_densidad
        med:volumen_liquido = med1:volumen_liquido
        med:factor_liquido = med1:factor_liquido
        med:volumen_corr_liq = med1:volumen_corr_liq
        med:Volumen_vapor = med1:Volumen_vapor
        med:factor_corr_vapor = med1:factor_corr_vapor
        med:volumen_corr_vapor = med1:volumen_corr_vapor
        med:volumen_total = med1:volumen_total
        med:volumen_total_corr = med1:volumen_total_corr
        IF ACCESS:Mediciones.Insert() <> Level:Benign
            MESSAGE( ' No se puede agregar la medicion','atención')
            BREAK
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
  SELF.Request = InsertRecord
  GlobalErrors.SetProcedureName('UpdateExistencias')
  IF GlobalRequest = 0 
      GlobalRequest = InsertRecord
      DesdeMenu# = TRUE
  END
  
  
  
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?exi:id_localidad
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(exi:Record,History::exi:Record)
  SELF.AddHistoryField(?exi:id_localidad,3)
  SELF.AddHistoryField(?exi:id_planta,2)
  SELF.AddHistoryField(?exi:FECHA_LECTURA_DATE,11)
  SELF.AddHistoryField(?exi:existencia_anterior,5)
  SELF.AddHistoryField(?exi:ultima_descarga,14)
  SELF.AddHistoryField(?exi:existencia,4)
  SELF.AddHistoryField(?exi:consumo:2,7)
  SELF.AddHistoryField(?exi:porc_existencia:2,6)
  SELF.AddHistoryField(?exi:AUTONOMIA:2,13)
  SELF.AddHistoryField(?exi:capacidad_planta,8)
  SELF.AddHistoryField(?exi:id_existencia_anterior,16)
  SELF.AddHistoryField(?exi:id_descarga_ultima,17)
  SELF.AddHistoryField(?exi:id_existencia:2,1)
  SELF.AddUpdateFile(Access:Existencias)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Descargas.SetOpenRelated()
  Relate:Descargas.Open                                    ! File Descargas used by this procedure, so make sure it's RelationManager is open
  Relate:ExistenciasAlias1.Open                            ! File ExistenciasAlias1 used by this procedure, so make sure it's RelationManager is open
  Relate:PlantasAlias.Open                                 ! File PlantasAlias used by this procedure, so make sure it's RelationManager is open
  Relate:PlantasStock.Open                                 ! File PlantasStock used by this procedure, so make sure it's RelationManager is open
  Relate:SQL.Open                                          ! File SQL used by this procedure, so make sure it's RelationManager is open
  Access:Mediciones_aux.UseFile                            ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Existencias
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
  IF DesdeMenu# = TRUE
      Access:Existencias.PrimeAutoInc()
  END
  
     
  IF self.Request = InsertRecord
      IF GLO:localidad_id <> 0
          exi:id_localidad = GLO:localidad_id
          Loc:id_localidad = GLO:localidad_id
          if Access:Localidades_GLP.fetch(Loc:PK_localidad) = Level:Benign
              l:localidad = Loc:Localidad
              display(?l:localidad)
          END
          
          
          IF GLO:id_planta <> 0 
              exi:id_planta = GLO:id_planta
              pla:ID_PLANTA = exi:id_planta
              if Access:Plantas.fetch(pla:PK__plantas__7D439ABD) = Level:Benign
                  exi:capacidad_planta = pla:CAPACIDAD
                  DISPLAY(?exi:id_planta)
              END
              
          ELSE
              
              pla:ID_LOCALIDAD = GLO:localidad_id
              set(pla:PLA_PLA_FK_LOCALIDAD,pla:PLA_PLA_FK_LOCALIDAD) 
             
              cont#= 0
              LOOP until Access:Plantas.next() or pla:ID_LOCALIDAD <> GLO:localidad_id
                
                
                  cont#+=1
              end
              
              
              
              
              if cont# = 1
                 
                  exi:id_planta = pla:ID_PLANTA
                  exi:capacidad_planta = pla:CAPACIDAD
                  DISPLAY(?exi:id_planta)
                  DISPLAY(?exi:capacidad_planta)
                  
              end
          
          
          END
       DO borrarMediciones    
          
       DO buscar_existencia   
      END
    ThisWindow.Reset(true)
  END
  
  
  
  if self.Request = ChangeRecord
      !l:existencia_anterior = exi:existencia
      STK:id_stock = exi:id_stock
      if Access:PlantasStock.fetch(STK:PK_PlantasStock) = Level:Benign
          
      END
      
      GLO:localidad_id = exi:id_localidad
      GLO:id_planta = exi:id_planta
      
          
      
  END
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?exi:id_localidad{PROP:ReadOnly} = True
    DISABLE(?CallLookupLocalidad)
    ?exi:id_planta{PROP:ReadOnly} = True
    DISABLE(?CallLookupPlanta)
    ?exi:FECHA_LECTURA_DATE{PROP:ReadOnly} = True
    DISABLE(?BotonSeleccionFecha)
    ?exi:existencia_anterior{PROP:ReadOnly} = True
    ?exi:ultima_descarga{PROP:ReadOnly} = True
    ?exi:existencia{PROP:ReadOnly} = True
    DISABLE(?BtnCalcularConsumo)
    ?exi:id_existencia_anterior{PROP:ReadOnly} = True
    DISABLE(?CallLookupExistenciaAnterior)
    ?exi:id_descarga_ultima{PROP:ReadOnly} = True
    DISABLE(?BtnUpdateUltimaDescarga)
    DISABLE(?CallLookupDescarga)
    DISABLE(?BtnCalcularExistencia)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateExistencias',QuickWindow)            ! Restore window settings from non-volatile store
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
    INIMgr.Update('UpdateExistencias',QuickWindow)         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  pla:ID_PLANTA = exi:id_planta                            ! Assign linking field value
  Access:Plantas.Fetch(pla:PK__plantas__7D439ABD)
  Loc:id_localidad = pla:ID_LOCALIDAD                      ! Assign linking field value
  Access:Localidades_GLP.Fetch(Loc:PK_localidad)
  des:id_descarga = exi:id_existencia_anterior             ! Assign linking field value
  Access:Descargas.Fetch(des:PK_descargas)
  med:id_existencia = exi:id_existencia                    ! Assign linking field value
  Access:Mediciones.Fetch(med:FK_EXISTENCIA)
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
      SelectPlantas
      SelectExistencias
      BrowseDescargas
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
    OF ?BtnUpdateUltimaDescarga
      GLO:localidad_id = exi:id_localidad
      GLO:id_planta = exi:id_planta
      GLO:id_descarga = 0
    OF ?BtnCalcularExistencia
      IF exi:id_planta = 0 
          MESSAGE('Ingrese el nro de planta')
          Select(?exi:id_planta)
          CYCLE
      END
      
      IF exi:FECHA_LECTURA_DATE = 0
          MESSAGE('Ingrese la fecha de lectura')
          Select(?exi:FECHA_LECTURA_DATE)
          CYCLE
          
      END
      
      
      
      
      GLO:existencia_medicion = exi:id_existencia
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?exi:id_localidad
      IF exi:id_localidad OR ?exi:id_localidad{PROP:Req}
        Loc:id_localidad = exi:id_localidad
        IF Access:Localidades_GLP.TryFetch(Loc:PK_localidad)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            exi:id_localidad = Loc:id_localidad
            GLO:localidad_id = Loc:id_localidad
            l:localidad = Loc:Localidad
          ELSE
            CLEAR(GLO:localidad_id)
            CLEAR(l:localidad)
            SELECT(?exi:id_localidad)
            CYCLE
          END
        ELSE
          GLO:localidad_id = Loc:id_localidad
          l:localidad = Loc:Localidad
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupLocalidad
      ThisWindow.Update
      IF GlobalResponse = RequestCompleted
          pla:ID_LOCALIDAD = exi:id_localidad
          Access:Plantas.fetch(pla:PLA_PLA_FK_LOCALIDAD)
          ThisWindow.Reset(true)
              
      END
      Loc:id_localidad = exi:id_localidad
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        exi:id_localidad = Loc:id_localidad
        GLO:localidad_id = Loc:id_localidad
        l:localidad = Loc:Localidad
      END
      ThisWindow.Reset(1)
    OF ?exi:id_planta
      IF exi:id_planta OR ?exi:id_planta{PROP:Req}
        pla:ID_PLANTA = exi:id_planta
        IF Access:Plantas.TryFetch(pla:PK__plantas__7D439ABD)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            exi:id_planta = pla:ID_PLANTA
            exi:capacidad_planta = pla:CAPACIDAD
            GLO:id_planta = pla:ID_PLANTA
          ELSE
            CLEAR(exi:capacidad_planta)
            CLEAR(GLO:id_planta)
            SELECT(?exi:id_planta)
            CYCLE
          END
        ELSE
          exi:capacidad_planta = pla:CAPACIDAD
          GLO:id_planta = pla:ID_PLANTA
        END
      END
      ThisWindow.Reset(1)
      !  IF exi:id_planta OR ?exi:id_planta{PROP:Req}
      !      if GlobalResponse =RequestCompleted
      !          if self.Request = InsertRecord
      !              exi:ultima_descarga = pla:ULTIMA_DESCARGA
      !          END
      !          
      !      ELSE
      !          clear(exi:ultima_descarga)
      !          select(?exi:ultima_descarga)
      !          cycle
      !          
      !      END
      !      
      !  END
        ThisWindow.Reset(1)  
        
    OF ?CallLookupPlanta
      ThisWindow.Update
      pla:ID_PLANTA = exi:id_planta
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        exi:id_planta = pla:ID_PLANTA
        exi:capacidad_planta = pla:CAPACIDAD
        GLO:id_planta = pla:ID_PLANTA
      END
      ThisWindow.Reset(1)
         
       if GlobalResponse =RequestCompleted
                     if self.Request = InsertRecord
                          DO buscar_existencia
                          
                      END
                          
           
       L:prod_disponible = pla:CAPACIDAD - pla:EXISTENCIA_ACTUAL                     
       END
       ThisWindow.Reset(1)               
    OF ?BotonSeleccionFecha
      ThisWindow.Update
      CHANGE(?exi:FECHA_LECTURA_DATE,bigfec(CONTENTS(?exi:FECHA_LECTURA_DATE)))
      !DO RefreshWindow
      do buscar_existencia
      thiswindow.Reset(true)
    OF ?BtnCalcularConsumo
      ThisWindow.Update
      GlobalRequest = InsertRecord
      updateMediciones()
      ThisWindow.Reset
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    OF ?exi:id_existencia_anterior
      IF exi:id_existencia_anterior OR ?exi:id_existencia_anterior{PROP:Req}
        exi1:id_existencia = exi:id_existencia_anterior
        IF Access:ExistenciasAlias1.TryFetch(exi1:PK__EXISTENC__36B12243)
          IF SELF.Run(3,SelectRecord) = RequestCompleted
            exi:id_existencia_anterior = exi1:id_existencia
            exi:existencia_anterior = exi1:existencia
          ELSE
            CLEAR(exi:existencia_anterior)
            SELECT(?exi:id_existencia_anterior)
            CYCLE
          END
        ELSE
          exi:existencia_anterior = exi1:existencia
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupExistenciaAnterior
      ThisWindow.Update
      exi1:id_existencia = exi:id_existencia_anterior
      IF SELF.Run(3,SelectRecord) = RequestCompleted
        exi:id_existencia_anterior = exi1:id_existencia
        exi:existencia_anterior = exi1:existencia
      END
      ThisWindow.Reset(1)
    OF ?exi:id_descarga_ultima
      IF exi:id_descarga_ultima OR ?exi:id_descarga_ultima{PROP:Req}
        des:id_descarga = exi:id_descarga_ultima
        IF Access:Descargas.TryFetch(des:PK_descargas)
          IF SELF.Run(4,SelectRecord) = RequestCompleted
            exi:id_descarga_ultima = des:id_descarga
            exi:ultima_descarga = des:cantidad
          ELSE
            CLEAR(exi:ultima_descarga)
            SELECT(?exi:id_descarga_ultima)
            CYCLE
          END
        ELSE
          exi:ultima_descarga = des:cantidad
        END
      END
      ThisWindow.Reset(1)
    OF ?BtnUpdateUltimaDescarga
      ThisWindow.Update
      GlobalRequest = InsertRecord
      UpdateDescargas()
      ThisWindow.Reset
      if GlobalRequest = RequestCompleted
        if GLO:id_descarga <> 0
          des:id_descarga = GLO:id_descarga
          if Access:Descargas.fetch(des:PK_descargas) = Level:Benign
                exi:ultima_descarga = des:cantidad
                exi:id_descarga_ultima = des:id_descarga
                display(?exi:ultima_descarga)
                
            END
            
          
        END
      ThisWindow.Reset(true)
      END
        
    OF ?CallLookupDescarga
      ThisWindow.Update
      des:id_descarga = exi:id_descarga_ultima
      IF SELF.Run(4,SelectRecord) = RequestCompleted
        exi:id_descarga_ultima = des:id_descarga
        exi:ultima_descarga = des:cantidad
      END
      ThisWindow.Reset(1)
    OF ?BtnCalcularExistencia
      ThisWindow.Update
      GlobalRequest = InsertRecord
      updateMedicionesExistencias(exi:id_existencia,exi:id_planta,exi:FECHA_LECTURA_DATE)
      ThisWindow.Reset
      if GLO:existencia_medicion<>0
      exi:existencia = GLO:existencia_medicion
          
      END 
          
      
      DO calcular_consumo
      DISPLAY(?exi:existencia)
      ThisWindow.reset(true)
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
  !Validar Datos
  SQL{PROP:SQL}='SELECT  TOP 1 ID_EXISTENCIA FROM DBO.EXISTENCIAS WHERE ID_PLANTA='&exi:id_planta&' ORDER BY FECHA_LECTURA DESC'
  NEXT(SQL)
  IF RECORDS(SQL) <> 0
      MESSAGE('Debe ingresar la existencia anterior')
      SELECT(?exi:existencia_anterior)
      CYCLE
  END
  
  
  
  IF (exi:existencia > exi:existencia_anterior) AND (exi:ultima_descarga = 0) 
      MESSAGE('La existencia actual el mayor a la anterior.Verifique que se haya ingresado una descarga','Error de validación',ICON:Exclamation)
      SELECT(?exi:ultima_descarga)
      CYCLE
  END
  
  
  IF exi:FECHA_LECTURA_DATE < exi1:FECHA_LECTURA_DATE
      MESSAGE('La fecha de lectura no puede ser menor a la fecha de la existencia anterior','Error de validadción',ICON:Exclamation)
      SELECT(?exi:FECHA_LECTURA_DATE)
      CYCLE
  END
  
  
  !IF pla:CAPACIDAD-pla:EXISTENCIA < exi:existencia
  !    MESSAGE('La existencia es mayor a la capacidad disponible de la planta','Atención',ICON:Exclamation)
  !    SELECT(?exi:existencia)
  !    CYCLE
  !END
  
      
  ReturnValue = PARENT.TakeCompleted()
  IF ReturnValue = Level:Benign
      IF self.Request = InsertRecord
          pla:EXISTENCIA_ACTUAL = exi:existencia
  
          IF Access:Plantas.Update() <> Level:Benign
              MESSAGE('Error en la actualizacion en la tabla Plantas')
          END
          
          STK:id_localidad = exi:id_localidad
          STK:id_planta = exi:id_planta
          STK:fecha_DATE = exi:FECHA_LECTURA_DATE
          STK:tipo='Consumo'
          STK:producto = exi:consumo *(-1)
          STK:existencia = exi:existencia
          
          IF  access:PlantasStock.insert() <> Level:Benign
              message('Error en la transaccion en la tabla PlantasStock')
          END
          
              
          exi:id_stock = STK:id_stock
          if Access:Existencias.Update() <> Level:Benign
              message('error en la actualizacion de la tabla existencia')
          END
          
          DO asignar_mediciones
          
          
          
      MESSAGE('Se ingreso la existencia correctamente','Mensaje',ICON:Save,BUTTON:OK,BUTTON:OK)     
      END
      
      
     IF self.Request = ChangeRecord
          STK:id_stock = exi:id_stock
          IF access:plantasStock.fetch(STK:PK_PlantasStock) = Level:Benign
  
              pla:EXISTENCIA_ACTUAL = exi:existencia
  
              IF Access:Plantas.update() <> Level:Benign
               MESSAGE('Error en la actualización de la tabla Plantas')
              END
              
              
              STK:id_localidad = exi:id_localidad
              STK:id_planta = exi:id_planta
              STK:fecha_DATE = exi:FECHA_LECTURA_DATE
              STK:tipo='Consumo'
              STK:producto = exi:consumo *(-1)
              STK:existencia = exi:existencia
              
              if Access:PlantasStock.Update() <> Level:benign
                  message('Error en la actualizacion de la tabla PlantasStock')
              END
          ELSE
              pla:EXISTENCIA_ACTUAL = exi:existencia
              
              IF Access:Plantas.update() <> Level:Benign
               MESSAGE('Error en la actualización de la tabla Plantas')
              END
              
              STK:id_localidad = exi:id_localidad
              STK:id_planta = exi:id_planta
              STK:fecha_DATE = exi:FECHA_LECTURA_DATE
              STK:tipo='Consumo'
              STK:producto = exi:consumo *(-1)
              STK:existencia = exi:existencia
              
              IF Access:PlantasStock.Insert() <> Level:benign
                  message('Error en la actualizacion de la tabla PlantasStock')
              END 
              
          END
      MESSAGE('Se modificó la existencia correctamente','Mensaje',ICON:Save,BUTTON:OK,BUTTON:OK)
      END 
      
      
     
      
      
      
      
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
  OF ?exi:existencia
    do calcular_consumo
    ThisWindow.Reset()
  OF ?BtnCalcularConsumo
    do calcular_consumo
    ThisWindow.Reset(true)
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
!!! Browse the Viajes file
!!! 25/10/2015: Se modificó el filtro del browse en la tabla viajes:
!!!  id_solicitud= 0 para que aparescan solamente los viajes que no estan asignados en ninguna solicitud
!!! </summary>
BrowseGeneracionSolicitudAnticipo PROCEDURE 

l:importe_dnl        DECIMAL(12,2)                         !
l:filtro             STRING(500)                           !
l:cantidad_viajes    LONG                                  !
l:total_producto     DECIMAL(18),NAME('"cap_tk_camion"')   !
L:Fecha_desde        DATE                                  !
l:fecha_hasta        DATE                                  !
l:id_proveedor       LONG(0)                               !
l:importe_producto   DECIMAL(12,2)                         !
l:total_importe      DECIMAL(12,2)                         !
CurrentTab           STRING(80)                            !
BRW11::View:Browse   VIEW(Viajes)
                       PROJECT(via:id_viaje)
                       PROJECT(via:id_proveedor)
                       PROJECT(via:fecha_carga_DATE)
                       PROJECT(via:cap_tk_camion)
                       PROJECT(via:importe_producto)
                       PROJECT(via:id_procedencia)
                       JOIN(pro:PK_proveedor,via:id_proveedor)
                         PROJECT(pro:proveedor)
                         PROJECT(pro:importe_DNL)
                         PROJECT(pro:id_proveedor)
                       END
                       JOIN(pro1:PK_PROCEDENCIA,via:id_procedencia)
                         PROJECT(pro1:procedencia)
                         PROJECT(pro1:id_procedencia)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
via:id_viaje           LIKE(via:id_viaje)             !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
via:id_proveedor       LIKE(via:id_proveedor)         !List box control field - type derived from field
pro1:procedencia       LIKE(pro1:procedencia)         !List box control field - type derived from field
pro:importe_DNL        LIKE(pro:importe_DNL)          !List box control field - type derived from field
via:fecha_carga_DATE   LIKE(via:fecha_carga_DATE)     !List box control field - type derived from field
via:cap_tk_camion      LIKE(via:cap_tk_camion)        !List box control field - type derived from field
l:importe_producto     LIKE(l:importe_producto)       !List box control field - type derived from local data
via:importe_producto   LIKE(via:importe_producto)     !List box control field - type derived from field
pro:id_proveedor       LIKE(pro:id_proveedor)         !Related join file key field - type derived from field
pro1:id_procedencia    LIKE(pro1:id_procedencia)      !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseSolicitudAnticipo'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(497,290,25,23),USE(?Close),LEFT,ICON('Cancelar.ico'),FLAT,MSG('Close Window'),TIP('Close Window')
                       LIST,AT(8,68,515,132),USE(?List),FORMAT('40L(2)|M~Id viaje~C(0)@P<<<<<<<<<<<<P@128L(2)|' & |
  'M~Proveedor~C(0)@s50@0L(2)|M~ID Proveedor~L(1)@P<<<<<<P@162L(2)|M~Procedencia~C(0)@s' & |
  '50@0L(2)|M~Importe DNL~C(0)@N-25.2@40L(2)|M~Fecha carga~L(0)@d6@44L(2)|M~Cap. Tanque' & |
  '~L(0)@N-_10.@59D(11)|M~Importe GLP~D(12)@N$-17_.2@56D(11)|M~importe producto~D(12)@n-13.2@'), |
  FROM(Queue:Browse),IMM
                       STRING(@N-20_~ Kg~),AT(455,230,55,12),USE(l:total_producto),TRN
                       STRING(@N~$ ~-17_.2),AT(443,251,67,10),USE(l:total_importe,,?l:total_importe:2),TRN
                       PROMPT('Proveedor:'),AT(21,42),USE(?l:id_proveedor:Prompt),TRN
                       ENTRY(@N-14_),AT(60,42,19,10),USE(l:id_proveedor)
                       BUTTON,AT(83,41,12,12),USE(?CallLookupProveedor),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@N-14_),AT(461,209,48,12),USE(l:cantidad_viajes,,?l:cantidad_viajes:2),TRN
                       BUTTON,AT(185,290),USE(?BtnImprimirSolicitud),ICON('Imprimir.ico'),FLAT,TRN
                       BUTTON,AT(467,36),USE(?btnfiltrar),FONT(,,,FONT:regular),ICON('seleccionar.ICO'),FLAT,TRN
                       STRING(@s50),AT(117,41,107,12),USE(pro:proveedor),TRN
                       PROMPT('Cantidad Viajes:'),AT(395,210),USE(?l:id_proveedor:Prompt:2),TRN
                       PROMPT('Total de Producto:'),AT(395,228,39,17),USE(?l:id_proveedor:Prompt:3),TRN
                       PROMPT('Importe de Producto:'),AT(395,249,45,21),USE(?l:id_proveedor:Prompt:4),TRN
                       PROMPT('Generación de solicitud de Anticipo'),AT(189,10),USE(?l:id_proveedor:Prompt:5),FONT('Arial', |
  10,,FONT:bold+FONT:italic+FONT:underline,CHARSET:ANSI),TRN
                       PROMPT('Desde:'),AT(227,41),USE(?L:Fecha_desde:Prompt)
                       ENTRY(@D6),AT(254,41,50,10),USE(L:Fecha_desde)
                       PROMPT('Hasta:'),AT(349,41),USE(?l:fecha_hasta:Prompt)
                       ENTRY(@d6),AT(375,41,49,10),USE(l:fecha_hasta)
                       BUTTON,AT(309,36,22,18),USE(?BotonSeleccionFechaDesde),ICON('calen.ico'),FLAT,TRN
                       BUTTON,AT(427,36,22,18),USE(?BotonSeleccionFechaHasta),ICON('calen.ico'),FLAT,TRN
                       BOX,AT(6,28,518,37),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BOX,AT(389,204,135,74),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BOX,AT(7,282,517,38),USE(?BOX1:3),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW11                CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
ResetFromView          PROCEDURE(),DERIVED
SetQueueRecord         PROCEDURE(),DERIVED
                     END

BRW11::Sort0:Locator StepLocatorClass                      ! Default Locator
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
crear_solicitud   ROUTINE
    sol:fecha_emision_DATE = today()
    sol:importe = l:total_importe
    sol:producto = l:total_producto
    IF Access:viajes_anticipos.insert() = Level:Benign
        LOOP q# = 1 TO records(BRW11.q) BY 1;get(brw11.q,q#)
            via1:id_viaje = BRW11.q.via:id_viaje
            
            IF access:ViajesAlias1.fetch(via1:PK_viajes) = Level:Benign
                IF via1:id_solicitud <> 0
                    MESSAGE('El viaje Nro'&via1:id_viaje&' se encuentra en la solicitud Nro '&via1:id_solicitud,'Atención',ICON:Exclamation)
                ELSE
                    via1:cap_tk_camion = BRW11.Q.via:cap_tk_camion *1000
                    via1:id_solicitud = sol:id_solicitud
                    via1:importe_producto = BRW11.Q.l:importe_producto
                    via1:peso = via1:cap_tk_camion
                    IF access:ViajesAlias1.update() <> Level:benign
                        message(' No se pudo actualizar en la tabla viajes')
                    END
                END
                
            ELSE
                message('No se pudo encontrar el viaje:'&BRW11.q.via:id_viaje&'.Contactese  con el administrador','Atención', ICON:Exclamation)
                
            END
            
            
            
        END
    ELSE
        message('No se pudo generar el anticipo.Contactese con el Administrador','Atención',ICON:Exclamation)
    END
 
  EXIT
    
    
    
filtrar             ROUTINE
    l:filtro = ' (via:estado = ''programado'' ) AND (via:anulado <> 1)'
    if l:id_proveedor <> 0
   
        l:filtro = clip(l:filtro)& ' and (via:id_proveedor = '& l:id_proveedor&')'
        !brw11.applyfilter()
       
    END
    if l:fecha_desde <> 0
        l:filtro = clip(l:filtro)&' and (via:fecha_carga_DATE >='&l:fecha_desde&')'
    end
    if l:fecha_hasta <> 0
        l:filtro = clip(l:filtro)&' and (via:fecha_carga_DATE<='&l:fecha_hasta&')'
    end
    
    brw11.setfilter(l:filtro)
    brw11.applyfilter()
 exit
    
    
    

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseGeneracionSolicitudAnticipo')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Close
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('via:id_viaje',via:id_viaje)                        ! Added by: BrowseBox(ABC)
  BIND('via:cap_tk_camion',via:cap_tk_camion)              ! Added by: BrowseBox(ABC)
  BIND('l:importe_producto',l:importe_producto)            ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Proveedores.SetOpenRelated()
  Relate:Proveedores.Open                                  ! File Proveedores used by this procedure, so make sure it's RelationManager is open
  Relate:ViajesAlias1.Open                                 ! File ViajesAlias1 used by this procedure, so make sure it's RelationManager is open
  Relate:aux_sql.Open                                      ! File aux_sql used by this procedure, so make sure it's RelationManager is open
  Relate:parametros.Open                                   ! File parametros used by this procedure, so make sure it's RelationManager is open
  Relate:viajes_anticipos.Open                             ! File viajes_anticipos used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
    par:ID_PARAMETRO = 1
    Access:parametros.fetch(par:PK_parametros)
  BRW11.Init(?List,Queue:Browse.ViewPosition,BRW11::View:Browse,Queue:Browse,Relate:Viajes,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW11.Q &= Queue:Browse
  BRW11.RetainRow = 0
  BRW11.AddSortOrder(,via:PK_viajes)                       ! Add the sort order for via:PK_viajes for sort order 1
  BRW11.AddLocator(BRW11::Sort0:Locator)                   ! Browse has a locator for sort order 1
  BRW11::Sort0:Locator.Init(,via:id_viaje,1,BRW11)         ! Initialize the browse locator using  using key: via:PK_viajes , via:id_viaje
  BRW11.SetFilter('(via:estado =''Programado'' AND via:id_solicitud = 0 AND via:anulado <<>1)') ! Apply filter expression to browse
  BRW11.AddField(via:id_viaje,BRW11.Q.via:id_viaje)        ! Field via:id_viaje is a hot field or requires assignment from browse
  BRW11.AddField(pro:proveedor,BRW11.Q.pro:proveedor)      ! Field pro:proveedor is a hot field or requires assignment from browse
  BRW11.AddField(via:id_proveedor,BRW11.Q.via:id_proveedor) ! Field via:id_proveedor is a hot field or requires assignment from browse
  BRW11.AddField(pro1:procedencia,BRW11.Q.pro1:procedencia) ! Field pro1:procedencia is a hot field or requires assignment from browse
  BRW11.AddField(pro:importe_DNL,BRW11.Q.pro:importe_DNL)  ! Field pro:importe_DNL is a hot field or requires assignment from browse
  BRW11.AddField(via:fecha_carga_DATE,BRW11.Q.via:fecha_carga_DATE) ! Field via:fecha_carga_DATE is a hot field or requires assignment from browse
  BRW11.AddField(via:cap_tk_camion,BRW11.Q.via:cap_tk_camion) ! Field via:cap_tk_camion is a hot field or requires assignment from browse
  BRW11.AddField(l:importe_producto,BRW11.Q.l:importe_producto) ! Field l:importe_producto is a hot field or requires assignment from browse
  BRW11.AddField(via:importe_producto,BRW11.Q.via:importe_producto) ! Field via:importe_producto is a hot field or requires assignment from browse
  BRW11.AddField(pro:id_proveedor,BRW11.Q.pro:id_proveedor) ! Field pro:id_proveedor is a hot field or requires assignment from browse
  BRW11.AddField(pro1:id_procedencia,BRW11.Q.pro1:id_procedencia) ! Field pro1:id_procedencia is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseGeneracionSolicitudAnticipo',QuickWindow) ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW11.AddToolbarTarget(Toolbar)                          ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Proveedores.Close
    Relate:ViajesAlias1.Close
    Relate:aux_sql.Close
    Relate:parametros.Close
    Relate:viajes_anticipos.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseGeneracionSolicitudAnticipo',QuickWindow) ! Save window data to non-volatile store
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
    CASE ACCEPTED()
    OF ?BtnImprimirSolicitud
      GLO:fecha_Desde = L:Fecha_desde
      GLO:fecha_hasta = l:fecha_hasta
      
      do crear_solicitud
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?l:id_proveedor
      IF l:id_proveedor OR ?l:id_proveedor{PROP:Req}
        pro:id_proveedor = l:id_proveedor
        IF Access:Proveedores.TryFetch(pro:PK_proveedor)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            l:id_proveedor = pro:id_proveedor
          ELSE
            SELECT(?l:id_proveedor)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupProveedor
      ThisWindow.Update
      pro:id_proveedor = l:id_proveedor
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        l:id_proveedor = pro:id_proveedor
      END
      ThisWindow.Reset(1)
    OF ?BtnImprimirSolicitud
      ThisWindow.Update
      START(ReportSolicitudAnticipo, 50000, BRW11.VIEW{PROP:FILTER},BRW11.VIEW{PROP:ORDER})
      ThisWindow.Reset
    OF ?btnfiltrar
      ThisWindow.Update
      if L:Fecha_desde > l:fecha_hasta
          message('El rango de fecha no es correcto','Atención',ICON:Exclamation,BUTTON:CANCEL)
          Select(?L:Fecha_desde)
          CYCLE
      END
       
      do filtrar
      
      
      setcursor(CURSOR:Wait)
      BRW11.ResetFromFile()
      BRW11.ResetFromBuffer()
      ThisWindow.Reset(true)
      SETCURSOR
                  
        
      
    OF ?BotonSeleccionFechaDesde
      ThisWindow.Update
      CHANGE(?L:Fecha_desde,bigfec(CONTENTS(?L:Fecha_desde)))
      !DO RefreshWindow
    OF ?BotonSeleccionFechaHasta
      ThisWindow.Update
      CHANGE(?l:fecha_hasta,bigfec(CONTENTS(?l:fecha_hasta)))
      !DO RefreshWindow
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW11.ResetFromView PROCEDURE

l:total_producto:Sum REAL                                  ! Sum variable for browse totals
l:total_importe:Sum  REAL                                  ! Sum variable for browse totals
l:cantidad_viajes:Cnt LONG                                 ! Count variable for browse totals
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
    l:total_producto:Sum += via:cap_tk_camion
    l:total_importe:Sum += l:importe_producto + l:importe_dnl
    l:cantidad_viajes:Cnt += 1
  END
  SELF.View{PROP:IPRequestCount} = 0
  l:total_producto = l:total_producto:Sum
  l:total_importe = l:total_importe:Sum
  l:cantidad_viajes = l:cantidad_viajes:Cnt
  PARENT.ResetFromView
  Relate:Viajes.SetQuickScan(0)
  SETCURSOR()


BRW11.SetQueueRecord PROCEDURE

  CODE
  L:importe_producto = (via:cap_tk_camion * 0.001 * par:COSTO_GLP) * (1 + par:IVA_GLP / 100)
  PARENT.SetQueueRecord
  
  


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
ReportSolicitudAnticipo PROCEDURE (STRING pFiltro,STRING pOrden)

Progress:Thermometer BYTE                                  !
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
l:subtotal_importe   DECIMAL(12,2)                         !
l:importe_producto   DECIMAL(12,2)                         !
l:cap_tanque         DECIMAL(19),NAME('"cap_tk_camion"')   !
Process:View         VIEW(Viajes)
                       PROJECT(via:cap_tk_camion)
                       PROJECT(via:fecha_carga_DATE)
                       PROJECT(via:id_proveedor)
                       PROJECT(via:id_viaje)
                       PROJECT(via:id_procedencia)
                       JOIN(pro1:PK_PROCEDENCIA,via:id_procedencia)
                         PROJECT(pro1:procedencia)
                       END
                       JOIN(pro:PK_proveedor,via:id_proveedor)
                         PROJECT(pro:importe_DNL)
                         PROJECT(pro:proveedor)
                       END
                     END
ProgressWindow       WINDOW,AT(,,142,69),DOUBLE,CENTER,GRAY,TIMER(1),WALLPAPER('fondo.jpg')
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER,TRN
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER,TRN
                       BUTTON,AT(56,43,28,21),USE(?Progress:Cancel),ICON('Cancelar.ico'),FLAT,TRN
                     END

Report               REPORT,AT(1000,3200,6250,7688),PRE(RPT),PAPER(PAPER:A4),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(1000,1000,6250,2073),USE(?Header)
                         STRING('SOLICITUD DE ANTICIPO'),AT(2135,354,1875),USE(?STRING1),FONT(,10,,FONT:bold)
                         STRING('CARGAS DE GAS PROPANO'),AT(2135,729,1875,198),USE(?STRING1:2),FONT(,9,,FONT:regular)
                         STRING('Gerencia Comercial'),AT(4656,354,1260,198),USE(?STRING1:3),FONT(,9,,FONT:regular)
                         IMAGE('Logo DISTRIGAS Chico.bmp'),AT(0,198,1240,700),USE(?IMAGE1)
                         LINE,AT(10,1948,5583,0),USE(?LINE1)
                         STRING('Av. Pte Kirchner 669 - 6° Piso'),AT(0,969,1885,156),USE(?STRING1:14),FONT(,8,,FONT:bold)
                         STRING('Río Gallegos - Santa Cruz'),AT(0,1135,1885,156),USE(?STRING1:8),FONT(,8,,FONT:bold)
                         STRING('Tel. (02966) 420034/437928'),AT(0,1333,1885,156),USE(?STRING1:7),FONT(,8,,FONT:bold)
                         STRING(@d17),AT(5021,1292,729),USE(sol:fecha_emision_DATE)
                         STRING('Fecha Emisión:'),AT(4021,1292,937,198),USE(?STRING1:15),FONT(,9,,FONT:regular)
                       END
breakProveedor         BREAK(via:id_proveedor),USE(?BREAK1)
                         HEADER,AT(0,0,6250,1417),USE(?GROUPHEADER1)
                           STRING(@s100),AT(115,479,5812),USE(l:TituloFecha),HIDE,TRN
                           STRING('Fecha'),AT(115,1146,375,198),USE(?STRING1:4),FONT(,9,,FONT:regular),TRN
                           STRING(@s50),AT(2271,52,2010),USE(pro:proveedor),TRN
                           STRING('Cantidad'),AT(771,1146,521,198),USE(?STRING1:5),FONT(,9,,FONT:regular),TRN
                           STRING('ANTICIPO DE GLP A CUENTA DE:'),AT(104,62,2104,198),USE(?STRING1:9),FONT(,9,,FONT:regular), |
  TRN
                           LINE,AT(10,1365,6187,0),USE(?LINE2)
                           STRING('Importe'),AT(1833,1146,510,198),USE(?STRING1:6),FONT(,9,,FONT:regular),TRN
                           STRING('Pto de Entrega'),AT(4708,1146,896,198),USE(?STRING1:13),FONT(,9,,FONT:regular),TRN
                           STRING('Total'),AT(3312,1146,427,198),USE(?STRING1:10),FONT(,9,,FONT:regular),TRN
                         END
detail1                  DETAIL,AT(0,0,6250,281),USE(?DETAIL1)
                           STRING(@d6),AT(62,31),USE(via:fecha_carga_DATE),FONT(,8,,,CHARSET:DEFAULT)
                           STRING(@s50),AT(4292,31,1729),USE(pro1:procedencia),FONT(,8,,,CHARSET:DEFAULT)
                           STRING(@N$-17.`2),AT(1625,31,1229),USE(l:importe_producto),FONT(,8,,,CHARSET:DEFAULT),TRN
                           STRING(@N$-17.`2),AT(3094,31,1292),USE(l:total_importe),FONT(,8,,,CHARSET:DEFAULT),TRN
                           STRING(@N8.2~Tn~),AT(771,21,792),USE(l:cap_tanque),FONT(,8,,,CHARSET:DEFAULT),CENTER,TRN
                         END
                         FOOTER,AT(0,0,6250,2000),USE(?GROUPFOOTER1),PAGEAFTER(1)
                           STRING('Total de Prod:'),AT(52,354,812,198),USE(?STRING1:11),FONT(,9,,FONT:regular)
                           STRING(@P<<<P),AT(927,94,250),USE(l:cant_viajes),CENTER,CNT,RESET(breakProveedor)
                           STRING('Cant Viajes:'),AT(52,94,708,198),USE(?STRING1:17),FONT(,9,,FONT:regular)
                           STRING(@N12.2~Tn~),AT(927,354,958),USE(l:total_producto,,?l:total_producto:2),LEFT(1)
                           STRING(@N$-17.`2),AT(927,615),USE(l:subtotal_importe),LEFT(12)
                           STRING('Importe Total:'),AT(52,615,812,198),USE(?STRING1:18),FONT(,9,,FONT:regular)
                           LINE,AT(10,21,6187,0),USE(?LINE1:2)
                           STRING('Solicito la provisión de '),AT(62,1042,1396),USE(?STRING2)
                           STRING(@P<<<P),AT(1521,1042,250,198),USE(l:cant_viajes,,?l:cant_viajes:2),CENTER,CNT,RESET(breakProveedor)
                           STRING('viajes equivalentes a'),AT(1833,1042,1344,198),USE(?STRING2:2)
                           STRING(@N-14_),AT(3177,1042,1219,198),USE(l:total_producto),LEFT(1)
                           STRING('TN ; por un importe de '),AT(4458,1042,1781,198),USE(?STRING2:3)
                           STRING(@N$-17.`2),AT(250,1479,1573,198),USE(l:subtotal_importe,,?l:subtotal_importe:2),FONT(, |
  12,,FONT:bold),LEFT(12)
                           BOX,AT(62,1365,1917,406),USE(?BOX1),COLOR(COLOR:Black),LINEWIDTH(1),ROUND
                           STRING('*'),AT(2000,1365),USE(?STRING4),FONT(,10,,FONT:bold)
                         END
                       END
                       FOOTER,AT(1010,10948,6250,542),USE(?Footer)
                         STRING('* La presente solicitud NO incluye conciliación de saldo con el proveedor'),AT(31, |
  156,6094,250),USE(?STRING3)
                       END
                       FORM,AT(1000,1000),USE(?FORM1)
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
  GlobalErrors.SetProcedureName('ReportSolicitudAnticipo')
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
  Relate:viajes_anticipos.Open                             ! File viajes_anticipos used by this procedure, so make sure it's RelationManager is open
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
  
  ! Seteo para imprimir por duplicado
  PRINTER{PROPPRINT:copies} = 2
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('ReportSolicitudAnticipo',ProgressWindow)   ! Restore window settings from non-volatile store
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
  ThisReport.SetOrder(pOrden)
  
  
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Viajes.Close
    Relate:parametros.Close
    Relate:viajes_anticipos.Close
  END
  IF SELF.Opened
    INIMgr.Update('ReportSolicitudAnticipo',ProgressWindow) ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  PRINTER{PROPPRINT:copies}=1
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  l:importe_producto = (via:cap_tk_camion * 0.001 * par:COSTO_GLP) * (1 + par:IVA_GLP / 100)
  IF ((via:fecha_carga_DATE % 7 = 0) OR (via:fecha_carga_DATE % 7 = 6))
    l:importe_dnl = pro:importe_DNL
  ELSE
    l:importe_dnl = 0
  END
  l:total_importe = l:importe_producto
  IF (l:campoBreak = via:id_proveedor)
    l:subtotal_importe = l:total_importe + l:subtotal_importe
  ELSE
    l:subtotal_importe = l:total_importe
  END
  IF (l:campoBreak = via:id_proveedor)
    l:cant_viajes = 1 + l:cant_viajes
  ELSE
    l:cant_viajes = 1
  END
  IF (l:campoBreak = via:id_proveedor)
    l:total_producto = (via:cap_tk_camion / 1000) + l:total_producto
  ELSE
    l:total_producto = (via:cap_tk_camion) / 1000
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
  l:campoBreak = via:id_proveedor
  l:cap_tanque = via:cap_tk_camion /1000
  l:TituloFecha =' PROVICIÓN DESDE '&FORMAT(l:fecha_desde,@D6)&' HASTA '&FORMAT(l:fecha_hasta,@D6)
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail1)
  RETURN ReturnValue

