

   MEMBER('existencias.clw')                               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('BRWEXT.INC'),ONCE

                     MAP
                       INCLUDE('EXISTENCIAS008.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('EXISTENCIAS002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS005.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS010.INC'),ONCE        !Req'd for module callout resolution
                     END



!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
totalesProductoLocalidad PROCEDURE 

CurrentTab           STRING(80)                            !
Q                    QUEUE,PRE()                           !
c1                   CSTRING(255)                          !
c2                   CSTRING(255)                          !
c3                   CSTRING(255)                          !
c4                   CSTRING(255)                          !
                     END                                   !
l:filtro             CSTRING(1000)                         !
l:fecha_desde        DATE                                  !
l:fecha_hasta        DATE                                  !
l:existencia_total   LONG                                  !
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('totalesProductoLocalidad'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(480,297,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       PROMPT('Fecha:'),AT(93,56),USE(?l:fecha_desde:Prompt)
                       ENTRY(@d6),AT(121,55,60,10),USE(l:fecha_desde)
                       PROMPT('Fecha hasta:'),AT(275,56),USE(?l:fecha_hasta:Prompt),DISABLE,HIDE
                       ENTRY(@d6),AT(325,56,60,10),USE(l:fecha_hasta),DISABLE,HIDE
                       BUTTON,AT(443,47,25,25),USE(?BUTTONFiltrar),ICON('seleccionar.ICO'),FLAT,TRN
                       STRING('Existencias totales por localidad'),AT(213,14,139),USE(?STRING1),FONT('Arial',10,, |
  FONT:bold+FONT:italic+FONT:underline),TRN
                       BUTTON,AT(185,47,25,25),USE(?BotonSeleccionFechaDesde),ICON('calen.ico'),FLAT,TRN
                       BUTTON,AT(390,48,25,25),USE(?BotonSeleccionFechaHasta),ICON('calen.ico'),DISABLE,FLAT,HIDE, |
  TRN
                       BOX,AT(37,43,468,34),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BOX,AT(37,81,468,213),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       LIST,AT(55,105,412,146),USE(?LIST1),FORMAT('100L(2)|M~campo 1~L(0)@s50@100L(2)|M~campo ' & |
  '2~L(0)@s50@100L(2)|M~campo 3~L(0)@s50@100L(2)|M~campo 4~L(0)@s50@'),FROM(glo:QREPORT)
                       BUTTON('E&xportar'),AT(227,265,52,15),USE(?EvoExportar),LEFT,ICON('export.ico'),CURSOR('mano.cur'), |
  FLAT
                     END

Loc::QHlist9 QUEUE,PRE(QHL9)
Id                         SHORT
Nombre                     STRING(100)
Longitud                   SHORT
Pict                       STRING(50)
Tot                 BYTE
                         END
QPar9 QUEUE,PRE(Q9)
FieldPar                 CSTRING(800)
                         END
QPar29 QUEUE,PRE(Qp29)
F2N                 CSTRING(300)
F2P                 CSTRING(100)
F2T                 BYTE
                         END
Loc::TituloListado9          STRING(100)
Loc::Titulo9          STRING(100)
SavPath9          STRING(2000)
Evo::Group9  GROUP,PRE()
Evo::Procedure9          STRING(100)
Evo::App9          STRING(100)
Evo::NroPage          LONG
   END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
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
filtrar             ROUTINE

    l:filtro = ' SELECT A.FECHA_LECTURA,b.localidad,sum(a.existencia) as existencia, SUM(A.consumo) as consumo '&|
               ' FROM EXISTENCIAS AS A INNER JOIN LOCALIDADES_GLP AS B ON A.ID_LOCALIDAD = B.ID_LOCALIDAD '&|
               ' WHERE FECHA_LECTURA ='''&format(L:fecha_Desde,@d6)&''' '&|
               ' GROUP BY A.FECHA_LECTURA ,A.ID_LOCALIDAD,b.id_localidad,b.LOCALIDAD '&|
               ' ORDER BY A.FECHA_LECTURA '
    
    
    sql{prop:sql}=l:filtro
    !message(l:filtro)
    if errorcode() then message(FILEERROR()).
    free(glo:QREPORT)
 
    
    loop until access:sql.next()
        MESSAGE('entra aca')
        campo1 = SQL:campo1
        campo2 = SQL:campo2
        campo3 = SQL:campo3
        campo4 = SQL:campo4
        add(glo:QREPORT)

    end
    DISPLAY()
    
    
    
    
 EXIT
    
PrintExQueue9 ROUTINE

 Evo::App9          = 'existencias'
 Evo::Procedure9          = GlobalErrors.GetProcedureName()& 9

 FREE(QPar9)
 Q9:FieldPar  = '1,2,3,4,'
 ADD(QPar9)  !!1
 Q9:FieldPar  = ';'
 ADD(QPar9)  !!2
 Q9:FieldPar  = 'Spanish'
 ADD(QPar9)  !!3
 Q9:FieldPar  = ''
 ADD(QPar9)  !!4
 Q9:FieldPar  = true
 ADD(QPar9)  !!5
 Q9:FieldPar  = ''
 ADD(QPar9)  !!6
 Q9:FieldPar  = true
 ADD(QPar9)  !!7
!!!! Exportaciones
 Q9:FieldPar  = 'HTML|'
  Q9:FieldPar  = CLIP( Q9:FieldPar)&'EXCEL|'
  Q9:FieldPar  = CLIP( Q9:FieldPar)&'WORD|'
 Q9:FieldPar  = CLIP( Q9:FieldPar)&'ASCII|'
  Q9:FieldPar  = CLIP( Q9:FieldPar)&'XML|'
  Q9:FieldPar  = CLIP( Q9:FieldPar)&'PRT|'
 ADD(QPar9)  !!8
 Q9:FieldPar  = 'All'
 ADD(QPar9)   !.9.
 Q9:FieldPar  = ' 0'
 ADD(QPar9)   !.10
 Q9:FieldPar  = 0
 ADD(QPar9)   !.11
 Q9:FieldPar  = '1'
 ADD(QPar9)   !.12

 Q9:FieldPar  = ''
 ADD(QPar9)   !.13

 Q9:FieldPar  = ''
 ADD(QPar9)   !.14

 Q9:FieldPar  = ''
 ADD(QPar9)   !.15

  Q9:FieldPar  = '16'
 ADD(QPar9)   !.16

  Q9:FieldPar  = 1
 ADD(QPar9)   !.17
  Q9:FieldPar  = 2
 ADD(QPar9)   !.18
  Q9:FieldPar  = '2'
 ADD(QPar9)   !.19
  Q9:FieldPar  = 12
 ADD(QPar9)   !.20

  Q9:FieldPar  = 0 !Exporta excel sin borrar
 ADD(QPar9)   !.21

  Q9:FieldPar  = Evo::NroPage !Nro Pag. Desde Report (BExp)
 ADD(QPar9)   !.22

  CLEAR(Q9:FieldPar)
 ADD(QPar9)   ! 23 Caracteres Encoding para xml

 Q9:FieldPar  = '0'
 ADD(QPar9)   ! 24 Use Open Office

  Q9:FieldPar  = '13021968'


 ADD(QPar9)

 FREE(QPar29)
      Qp29:F2N  = 'Fecha'
 Qp29:F2P  = '@s50'
 Qp29:F2T  = '0'
 ADD(QPar29)
      Qp29:F2N  = 'Localidad'
 Qp29:F2P  = '@s50'
 Qp29:F2T  = '0'
 ADD(QPar29)
      Qp29:F2N  = 'Existencia'
 Qp29:F2P  = '@s50'
 Qp29:F2T  = '0'
 ADD(QPar29)
      Qp29:F2N  = 'Consumo'
 Qp29:F2P  = '@s50'
 Qp29:F2T  = '0'
 ADD(QPar29)
 SysRec# = false
 FREE(Loc::QHlist9)
 LOOP
    SysRec# += 1
    IF ?LIST1{PROPLIST:Exists,SysRec#} = 1
        GET(QPar29,SysRec#)
        QHL9:Id      = SysRec#
        QHL9:Nombre  = Qp29:F2N
        QHL9:Longitud= ?LIST1{PropList:Width,SysRec#}  /2
        QHL9:Pict    = Qp29:F2P
        QHL9:Tot    = Qp29:F2T
        ADD(Loc::QHlist9)
     Else
       break
    END
 END
 Loc::Titulo9 ='Administrator the '

 SavPath9 = PATH()

  Exportar(Loc::QHlist9,glo:QREPORT,QPar9,0,Loc::Titulo9,Evo::Group9)
 SETPATH(SavPath9)
 !!!! Fin Routina Templates Clarion

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('totalesProductoLocalidad')
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
  Relate:SQL.Open                                          ! File SQL used by this procedure, so make sure it's RelationManager is open
  Relate:aux_sql.Open                                      ! File aux_sql used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('totalesProductoLocalidad',QuickWindow)     ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:SQL.Close
    Relate:aux_sql.Close
  END
  IF SELF.Opened
    INIMgr.Update('totalesProductoLocalidad',QuickWindow)  ! Save window data to non-volatile store
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
    OF ?BUTTONFiltrar
      
      
      do filtrar
      
      
      ThisWindow.Reset()
      
      
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BotonSeleccionFechaDesde
      ThisWindow.Update
      CHANGE(?l:fecha_desde,bigfec(CONTENTS(?l:fecha_desde)))
      !DO RefreshWindow
    OF ?BotonSeleccionFechaHasta
      ThisWindow.Update
      CHANGE(?l:fecha_hasta,bigfec(CONTENTS(?l:fecha_hasta)))
      !DO RefreshWindow
    OF ?EvoExportar
      ThisWindow.Update
       Do PrintExQueue9
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
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:OpenWindow
      L:fecha_Desde = GetDateServer()
      L:fecha_hasta = GetDateServer()
      
      do filtrar
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
!!! Report the Existencias File
!!! </summary>
ReportExistencias_2 PROCEDURE (STRING pFilter,STRING pOrder)

Progress:Thermometer BYTE                                  !
l:id_localidad       LONG,NAME('"id_localidad"')           !
l:ultima_descarga    DECIMAL(20),NAME('"ultima_descarga"') !
l:existencia_anterior DECIMAL(15),NAME('"EXISTENCIA_ANTERIOR"') !
l:existencia         DECIMAL(15)                           !
l:consumo            DECIMAL(15)                           !
l:capacidad_planta   DECIMAL(20),NAME('"CAPACIDAD_PLANTA"') !
l:porc_existencia    LONG,NAME('"PORC_EXISTENCIA"')        !
l:autonomia          LONG                                  !
Process:View         VIEW(Existencias)
                       PROJECT(exi:FECHA_LECTURA)
                       PROJECT(exi:FECHA_LECTURA_DATE)
                       PROJECT(exi:capacidad_planta)
                       PROJECT(exi:consumo)
                       PROJECT(exi:existencia)
                       PROJECT(exi:existencia_anterior)
                       PROJECT(exi:id_localidad)
                       PROJECT(exi:id_planta)
                       PROJECT(exi:porc_existencia)
                       PROJECT(exi:ultima_descarga)
                       JOIN(pla:PK__plantas__7D439ABD,exi:id_planta)
                       END
                       JOIN(Loc:PK_localidad,exi:id_localidad)
                         PROJECT(Loc:Localidad)
                       END
                     END
ProgressWindow       WINDOW,AT(,,157,90),FONT('Arial',8,COLOR:Black,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,TIMER(1),WALLPAPER('fondo.jpg')
                       PROGRESS,AT(18,30,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(3,18,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(2,18,141,10),USE(?Progress:PctText),CENTER
                       BUTTON,AT(61,47,25,25),USE(?Progress:Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar Reporte'), |
  TIP('Cancelar Reporte')
                     END

Report               REPORT('Existencias Report'),AT(1000,2521,7750,4854),PRE(RPT),PAPER(PAPER:A4),LANDSCAPE,FONT('Arial', |
  8,COLOR:Black,FONT:regular,CHARSET:DEFAULT),THOUS
                       HEADER,AT(1000,406,7750,2115),USE(?Header),FONT('Microsoft Sans Serif',8,COLOR:Black,FONT:bold, |
  CHARSET:DEFAULT)
                         STRING('Existencias de Producto'),AT(3948,792,2260,220),USE(?ReportTitle),FONT('Arial',12, |
  COLOR:Black,FONT:bold+FONT:italic+FONT:underline,CHARSET:DEFAULT),CENTER
                         BOX,AT(0,1854,7750,271),USE(?HeaderBox),COLOR(COLOR:Black),FILL(COLOR:Black),LINEWIDTH(1)
                         LINE,AT(771,1865,0,250),USE(?HeaderLine:1),COLOR(COLOR:Black)
                         LINE,AT(1552,1865,0,250),USE(?HeaderLine:2),COLOR(COLOR:Black)
                         LINE,AT(2323,1865,0,250),USE(?HeaderLine:3),COLOR(COLOR:Black)
                         LINE,AT(3104,1865,0,250),USE(?HeaderLine:4),COLOR(COLOR:Black)
                         LINE,AT(3875,1865,0,250),USE(?HeaderLine:5),COLOR(COLOR:Black)
                         LINE,AT(4646,1865,0,250),USE(?HeaderLine:6),COLOR(COLOR:Black)
                         LINE,AT(5427,1865,0,250),USE(?HeaderLine:7),COLOR(COLOR:Black)
                         LINE,AT(6198,1865,0,250),USE(?HeaderLine:8),COLOR(COLOR:Black)
                         LINE,AT(6979,1865,0,250),USE(?HeaderLine:9),COLOR(COLOR:Black)
                         STRING('Fecha Lectura'),AT(52,1896,675,170),USE(?HeaderTitle:1),FONT(,,COLOR:White),TRN
                         STRING('Localidad'),AT(1344,1896,675,170),USE(?HeaderTitle:3),FONT(,,COLOR:White),TRN
                         STRING('Anterior'),AT(2375,1896,675,170),USE(?HeaderTitle:4),FONT(,,COLOR:White),TRN
                         STRING('Descarga'),AT(3146,1896,675,170),USE(?HeaderTitle:5),FONT(,,COLOR:White),TRN
                         STRING('Actual'),AT(3927,1896,675,170),USE(?HeaderTitle:6),FONT(,,COLOR:White),TRN
                         STRING('Consumo'),AT(4698,1896,675,170),USE(?HeaderTitle:7),FONT(,,COLOR:White),TRN
                         STRING('porc existencia'),AT(5479,1896,675,170),USE(?HeaderTitle:8),FONT(,,COLOR:White),TRN
                         STRING('Cap. Planta'),AT(6250,1896,675,170),USE(?HeaderTitle:9),FONT(,,COLOR:White),TRN
                         STRING('Autonomía'),AT(7021,1896,675,170),USE(?HeaderTitle:10),FONT(,,COLOR:White),TRN
                         IMAGE('Logo DISTRIGAS Chico.bmp'),AT(-646,-10,1240,700),USE(?IMAGE1)
                         STRING('Av. Pte Kirchner 669 - 6° Piso'),AT(-646,781,1885,156),USE(?STRING1),FONT(,8,,FONT:bold)
                         STRING('Río Gallegos - Santa Cruz'),AT(-646,948,1885,156),USE(?STRING1:2),FONT(,8,,FONT:bold)
                         STRING('Tel. (02966) 420034/437928'),AT(-646,1125,1885,156),USE(?STRING1:3),FONT(,8,,FONT:bold)
                         STRING('Desde:'),AT(3750,1437,542,219),USE(?ReportTitle:2),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:DEFAULT),CENTER,TRN
                         STRING('Hasta:'),AT(5198,1437,469,219),USE(?ReportTitle:3),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:DEFAULT),CENTER,TRN
                         STRING(@d6),AT(4354,1437,781,219),USE(GLO:fecha_Desde),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:DEFAULT),CENTER,TRN
                         STRING(@d6),AT(5656,1437,792,219),USE(GLO:fecha_hasta),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:DEFAULT),CENTER,TRN
                       END
breakFecha             BREAK(exi:FECHA_LECTURA_DATE),USE(?BREAK1)
                         HEADER,AT(0,0,7750,1),USE(?GROUPHEADER1)
                           LINE,AT(-9,0,7750,0),USE(?DetailEndLine:2),COLOR(COLOR:Black)
                         END
breakLocalidad           BREAK(exi:id_localidad),USE(?BREAK2)
                           HEADER,AT(0,0,7750,0),USE(?GROUPHEADER3)
                           END
detail1                    DETAIL,AT(0,0,7750,0),USE(?DETAIL1)
                           END
                           FOOTER,AT(0,0,7750,250),USE(?GROUPFOOTER2)
                             LINE,AT(0,0,0,250),USE(?DetailLine:0),COLOR(COLOR:Black)
                             LINE,AT(771,0,0,250),USE(?DetailLine:1),COLOR(COLOR:Black)
                             LINE,AT(2323,0,0,250),USE(?DetailLine:3),COLOR(COLOR:Black)
                             LINE,AT(3104,0,0,250),USE(?DetailLine:4),COLOR(COLOR:Black)
                             LINE,AT(3875,0,0,250),USE(?DetailLine:5),COLOR(COLOR:Black)
                             LINE,AT(4646,0,0,250),USE(?DetailLine:6),COLOR(COLOR:Black)
                             LINE,AT(5427,0,0,250),USE(?DetailLine:7),COLOR(COLOR:Black)
                             LINE,AT(6198,0,0,250),USE(?DetailLine:8),COLOR(COLOR:Black)
                             LINE,AT(6979,0,0,250),USE(?DetailLine:9),COLOR(COLOR:Black)
                             STRING(@d6),AT(52,0,675,198),USE(exi:FECHA_LECTURA_DATE),CENTER,TRN
                             STRING(@s20),AT(979,42,1250,146),USE(Loc:Localidad),FONT(,,,,CHARSET:DEFAULT),CENTER,TRN
                             STRING(@n-20.0),AT(3917,42,708,146),USE(exi:existencia),DECIMAL(200),SUM,TRN
                             STRING(@n-20.0),AT(4656,42,750,146),USE(exi:consumo),DECIMAL(200),SUM,RESET(breakLocalidad), |
  TRN
                             STRING(@N-7.),AT(5479,42,675,146),USE(exi:porc_existencia),TRN
                             STRING(@n-20.0),AT(6260,42,675,146),USE(exi:capacidad_planta),DECIMAL(200),SUM,RESET(breakLocalidad), |
  TRN
                             LINE,AT(7750,0,0,250),USE(?DetailLine:2),COLOR(COLOR:Black)
                             STRING(@P<<<< díasP),AT(7042,42,,146),USE(l:autonomia),TRN
                             STRING(@n-20.0),AT(2375,42,708,146),USE(exi:existencia_anterior),DECIMAL(200),SUM,RESET(breakLocalidad), |
  TRN
                             STRING(@n-20.0),AT(3146,42,708,146),USE(exi:ultima_descarga),DECIMAL(200),SUM,RESET(breakLocalidad), |
  TRN
                           END
                         END
                         FOOTER,AT(0,0,7750,1),USE(?GROUPFOOTER1)
                           LINE,AT(0,0,7750,0),USE(?DetailEndLine),COLOR(COLOR:Black)
                         END
                       END
                       FOOTER,AT(1000,7958,7750,250),USE(?Footer)
                         STRING('Fecha:'),AT(115,52,344,135),USE(?ReportDatePrompt:2),FONT('Arial',8,,FONT:regular), |
  TRN
                         STRING('<<-- Date Stamp -->'),AT(490,52,927,135),USE(?ReportDateStamp:2),FONT('Arial',8,,FONT:regular), |
  TRN
                         STRING('Hora:'),AT(1625,52,271,135),USE(?ReportTimePrompt:2),FONT('Arial',8,,FONT:regular), |
  TRN
                         STRING('<<-- Time Stamp -->'),AT(1927,52,927,135),USE(?ReportTimeStamp:2),FONT('Arial',8,, |
  FONT:regular),TRN
                         STRING(@pPágina <<#p),AT(6950,52,700,135),USE(?PageCount:2),FONT('Arial',8,,FONT:regular), |
  PAGENO
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

ProgressMgr          StepStringClass                       ! Progress Manager
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
  GlobalErrors.SetProcedureName('ReportExistencias_2')
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
  INIMgr.Fetch('ReportExistencias_2',ProgressWindow)       ! Restore window settings from non-volatile store
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowAlpha+ScrollSort:AllowNumeric+ScrollSort:Descending,ScrollBy:RunTime)
  ThisReport.Init(Process:View, Relate:Existencias, ?Progress:PctText, Progress:Thermometer, ProgressMgr, exi:FECHA_LECTURA)
  ThisReport.AddSortOrder(exi:K_FECHA_LOCALIDAD_PLANTA)
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
  
  ThisReport.SetOrder('exi:FECHA_LECTURA_DATE,exi:id_localidad')
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
    INIMgr.Update('ReportExistencias_2',ProgressWindow)    ! Save window data to non-volatile store
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
  IF (exi:consumo <> 0)
    l:autonomia = exi:capacidad_planta / exi:consumo
  ELSE
    l:autonomia = exi:capacidad_planta / 0.01
  END
  !    l:ultima_descarga += exi:ultima_descarga
  !    l:existencia_anterior += exi:existencia_anterior
  !    l:existencia += exi:existencia
  !    l:consumo += exi:consumo
  !    l:capacidad_planta += exi:capacidad_planta
  !    l:porc_existencia = l:existencia *100 /l:capacidad_planta
  !    if l:consumo= 0
  !                l:consumo = 0.01
  !            END
  !    l:autonomia = l:existencia/l:consumo
  !
  !if l:id_localidad <> exi:id_localidad
  !    l:ultima_descarga = exi:ultima_descarga
  !    l:existencia_anterior = exi:existencia_anterior
  !    l:existencia = exi:existencia
  !    l:consumo = exi:consumo
  !    l:capacidad_planta = exi:capacidad_planta
  !    
  !    
  !END
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail1)
  RETURN ReturnValue


!!! <summary>
!!! Generated from procedure template - Window
!!! Viajes
!!! </summary>
BrowseViajesenProceso PROCEDURE 

CurrentTab           STRING(80)                            !
Buscador             CSTRING(51)                           !
L:id_proveedor       LONG                                  !Identificador interno del proveedor de producto
L:filtro             STRING(255)                           !
L:fecha_desde        DATE                                  !
L:fecha_hasta        DATE                                  !
L:cantidad_viajes    LONG                                  !
L:total_peso_estimado DECIMAL(15)                          !
BRW1::View:Browse    VIEW(Viajes)
                       PROJECT(via:id_viaje)
                       PROJECT(via:fecha_carga_DATE)
                       PROJECT(via:ano)
                       PROJECT(via:mes)
                       PROJECT(via:cap_tk_camion)
                       PROJECT(via:peso)
                       PROJECT(via:chofer)
                       PROJECT(via:nro_remito)
                       PROJECT(via:id_proveedor)
                       PROJECT(via:id_procedencia)
                       PROJECT(via:id_localidad)
                       JOIN(pro:PK_proveedor,via:id_proveedor)
                         PROJECT(pro:proveedor)
                         PROJECT(pro:id_proveedor)
                       END
                       JOIN(pro1:PK_PROCEDENCIA,via:id_procedencia)
                         PROJECT(pro1:procedencia)
                         PROJECT(pro1:id_procedencia)
                       END
                       JOIN(Loc:PK_localidad,via:id_localidad)
                         PROJECT(Loc:Localidad)
                         PROJECT(Loc:id_localidad)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
via:id_viaje           LIKE(via:id_viaje)             !List box control field - type derived from field
via:fecha_carga_DATE   LIKE(via:fecha_carga_DATE)     !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
pro1:procedencia       LIKE(pro1:procedencia)         !List box control field - type derived from field
Loc:Localidad          LIKE(Loc:Localidad)            !List box control field - type derived from field
via:ano                LIKE(via:ano)                  !List box control field - type derived from field
via:mes                LIKE(via:mes)                  !List box control field - type derived from field
via:cap_tk_camion      LIKE(via:cap_tk_camion)        !List box control field - type derived from field
via:peso               LIKE(via:peso)                 !List box control field - type derived from field
via:chofer             LIKE(via:chofer)               !List box control field - type derived from field
via:nro_remito         LIKE(via:nro_remito)           !List box control field - type derived from field
pro:id_proveedor       LIKE(pro:id_proveedor)         !Related join file key field - type derived from field
pro1:id_procedencia    LIKE(pro1:id_procedencia)      !Related join file key field - type derived from field
Loc:id_localidad       LIKE(Loc:id_localidad)         !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseViajes'),SYSTEM,WALLPAPER('fondo.jpg')
                       ENTRY(@P<<<<<P),AT(58,42,28,11),USE(L:id_proveedor)
                       BUTTON,AT(91,43,12,12),USE(?CallLookupProveedor),ICON('lupita.ico'),FLAT,TRN
                       ENTRY(@d6),AT(83,68,53,11),USE(L:fecha_desde)
                       BUTTON,AT(141,62,24,25),USE(?BotonSeleccionFechaDesde),ICON('calen.ico'),FLAT,TRN
                       ENTRY(@d6),AT(239,68,53,11),USE(L:fecha_hasta)
                       BUTTON,AT(299,62,24,25),USE(?BotonSeleccionFechaHasta),ICON('calen.ico'),FLAT,TRN
                       BUTTON,AT(464,62,25,25),USE(?Filtrar),ICON('seleccionar.ICO'),FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro')
                       ENTRY(@s50),AT(173,94,106),USE(Buscador)
                       BUTTON,AT(284,93,12,14),USE(?Browse:Top),ICON('VCRFIRST.GIF'),FLAT,TIP('Go to the First Page')
                       BUTTON,AT(299,93,12,14),USE(?Browse:PageUp),ICON('VCRPRIOR.GIF'),FLAT,TIP('Go to the Prior Page')
                       BUTTON,AT(312,93,12,14),USE(?Browse:Up),ICON('VCRUP.GIF'),FLAT,TIP('Go to the Prior Record')
                       BUTTON,AT(327,93,12,14),USE(?Browse:Down),ICON('VCRDOWN.GIF'),FLAT,TIP('Go to the Next Record')
                       BUTTON,AT(341,93,12,14),USE(?Browse:PageDown),ICON('VCRNEXT.GIF'),FLAT,TIP('Go to the Next Page')
                       BUTTON,AT(357,93,12,14),USE(?Browse:Bottom),ICON('VCRLAST.GIF'),FLAT,TIP('Go to the Last Page')
                       LIST,AT(15,117,498,143),USE(?Browse:1),HVSCROLL,FORMAT('36L|M~Nro viaje~D(0)@N-14_@54R(' & |
  '2)|M~Fecha carga~C(0)@d6@104L(2)|M~Proveedor~C(0)@s50@95L(2)|M~Procedencia~C(0)@s50@' & |
  '80L(2)|M~Destino~C(0)@s20@29L(2)|M~Año~C(1)@S4@18L(2)|M~Mes~C(1)@P<<<<P@44R(2)|M~Pes' & |
  'o estimado~C(0)@N-10_@44R(2)|M~Peso~D(12)@N-10_@91R(2)|M~Chofer~C(0)@s50@200L(2)|M~N' & |
  'ro remito~L(0)@P####-########P@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the Viajes file')
                       BUTTON,AT(194,290,25,25),USE(?View:2),ICON('Ver.ico'),FLAT,MSG('Vizualizar el registro'),TIP('Vizualizar' & |
  ' el registro')
                       BUTTON,AT(231,290,25,25),USE(?Insert:3),ICON('Insertar.ico'),DISABLE,FLAT,HIDE,MSG('Insertar u' & |
  'n registro'),TIP('Insertar un registro')
                       BUTTON,AT(270,290,25,25),USE(?Change:3),ICON('Editar.ico'),FLAT,MSG('Editar el registro'), |
  TIP('Editar el registro')
                       BUTTON,AT(307,290,25,25),USE(?Delete:3),ICON('Eliminar.ICO'),DISABLE,FLAT,HIDE,MSG('Eliminar e' & |
  'l registro'),TIP('Eliminar el registro')
                       BUTTON,AT(477,290,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       STRING('Viajes en proceso de descarga'),AT(202,13,130),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       BUTTON,AT(23,290,25,25),USE(?Seleccionar),ICON('seleccionar.ICO'),FLAT,TRN
                       BOX,AT(14,284,499,38),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       STRING('Buscador'),AT(135,97),USE(?STRING2),TRN
                       BOX,AT(14,29,499,84),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       STRING('Proveedor:'),AT(23,42,37,10),USE(?STRING2:2),TRN
                       STRING(@s50),AT(107,43,173,12),USE(pro2:proveedor),FONT(,,,FONT:regular),TRN
                       STRING('Fecha desde:'),AT(39,70,53,10),USE(?STRING2:3),TRN
                       STRING('Fecha hasta:'),AT(194,70,49,10),USE(?STRING2:4),TRN
                       STRING('Cantidad Viajes:'),AT(252,271),USE(?STRING3),TRN
                       STRING(@n-14),AT(307,271,51,10),USE(L:cantidad_viajes),TRN
                       STRING(@n-20.0),AT(433,271,72,10),USE(L:total_peso_estimado),TRN
                       STRING('Total estimado:'),AT(379,271,51,10),USE(?STRING3:2),TRN
                       BUTTON,AT(357,290,25,25),USE(?EvoExportar),LEFT,ICON('exportar.ico'),FLAT,MSG('Exportar Registros'), |
  TIP('Exportar Registros'),TRN
                     END

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
BRW1::Toolbar        BrowseToolbarClass
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
SetAlerts              PROCEDURE(),DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
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
filtrar             ROUTINE
    BRW1.SetFilter('')
    BRW1.ApplyFilter()
    L:filtro = 'via:estado = ''En proceso'''
    IF L:id_proveedor <> 0
        IF LEN(clip(L:filtro)) <> 0
               L:filtro = clip(L:filtro)&' AND '
        END
        L:filtro= clip(L:filtro)&' via:id_proveedor = '&L:id_proveedor
    END
    
    IF L:fecha_desde <> 0
        IF LEN(clip(L:filtro)) <> 0
               L:filtro = clip(L:filtro)&' AND '
        END
       L:filtro= clip(L:filtro)&' via:fecha_carga_DATE >= '&L:fecha_desde
    END
    
    IF L:fecha_hasta <> 0
        IF LEN(clip(L:filtro)) <> 0
               L:filtro = clip(L:filtro)&' AND '
        END
       L:filtro= clip(L:filtro)&' via:fecha_carga_DATE <= '&L:fecha_hasta
    END
    
    
    
    IF EVALUATE(L:filtro) <> ''
        BRW1.SetFilter(l:filtro)
        BRW1.ApplyFilter()
        BRW1.ResetFromFile()
        BRW1.ResetFromBuffer()
        ThisWindow.Reset(TRUE)
    END
    
    
 EXIT
    
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
  Q10:FieldPar  = '1,2,3,4,5,6,7,8,9,10,11,'
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
       Qp210:F2N  = 'Nro viaje'
  Qp210:F2P  = '@N-14_'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Fecha carga'
  Qp210:F2P  = '@d6'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Proveedor'
  Qp210:F2P  = '@s50'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Procedencia'
  Qp210:F2P  = '@s50'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Destino'
  Qp210:F2P  = '@s20'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Año'
  Qp210:F2P  = '@S4'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Mes'
  Qp210:F2P  = '@P<<P'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Peso estimado'
  Qp210:F2P  = '@N-10_'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Peso'
  Qp210:F2P  = '@N-10_'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Chofer'
  Qp210:F2P  = '@s50'
  Qp210:F2T  = '0'
  ADD(QPar210)
       Qp210:F2N  = 'Nro remito'
  Qp210:F2P  = '@P####-########P'
  Qp210:F2T  = '0'
  ADD(QPar210)
  SysRec# = false
  FREE(Loc::QHlist10)
  LOOP
     SysRec# += 1
     IF ?Browse:1{PROPLIST:Exists,SysRec#} = 1
         GET(QPar210,SysRec#)
         QHL10:Id      = SysRec#
         QHL10:Nombre  = Qp210:F2N
         QHL10:Longitud= ?Browse:1{PropList:Width,SysRec#}  /2
         QHL10:Pict    = Qp210:F2P
         QHL10:Tot    = Qp210:F2T
         ADD(Loc::QHlist10)
      Else
        break
     END
  END
  Loc::Titulo10 ='Administrator the Viajes'
 
 SavPath10 = PATH()
  Exportar(Loc::QHlist10,BRW1.Q,QPar10,0,Loc::Titulo10,Evo::Group10)
 IF Not EC::LoadI_10 Then  BRW1.FileLoaded=false.
 SETPATH(SavPath10)
 !!!! Fin Routina Templates Clarion

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('BrowseViajesenProceso')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?L:id_proveedor
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('via:id_viaje',via:id_viaje)                        ! Added by: BrowseBox(ABC)
  BIND('via:cap_tk_camion',via:cap_tk_camion)              ! Added by: BrowseBox(ABC)
  BIND('via:nro_remito',via:nro_remito)                    ! Added by: BrowseBox(ABC)
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
  BRW1::Sort0:Locator.Init(,via:id_viaje,1,BRW1)           ! Initialize the browse locator using  using key: via:PK_viajes , via:id_viaje
  BRW1.SetFilter('(via:estado = ''En proceso'')')          ! Apply filter expression to browse
  BRW1.AddField(via:id_viaje,BRW1.Q.via:id_viaje)          ! Field via:id_viaje is a hot field or requires assignment from browse
  BRW1.AddField(via:fecha_carga_DATE,BRW1.Q.via:fecha_carga_DATE) ! Field via:fecha_carga_DATE is a hot field or requires assignment from browse
  BRW1.AddField(pro:proveedor,BRW1.Q.pro:proveedor)        ! Field pro:proveedor is a hot field or requires assignment from browse
  BRW1.AddField(pro1:procedencia,BRW1.Q.pro1:procedencia)  ! Field pro1:procedencia is a hot field or requires assignment from browse
  BRW1.AddField(Loc:Localidad,BRW1.Q.Loc:Localidad)        ! Field Loc:Localidad is a hot field or requires assignment from browse
  BRW1.AddField(via:ano,BRW1.Q.via:ano)                    ! Field via:ano is a hot field or requires assignment from browse
  BRW1.AddField(via:mes,BRW1.Q.via:mes)                    ! Field via:mes is a hot field or requires assignment from browse
  BRW1.AddField(via:cap_tk_camion,BRW1.Q.via:cap_tk_camion) ! Field via:cap_tk_camion is a hot field or requires assignment from browse
  BRW1.AddField(via:peso,BRW1.Q.via:peso)                  ! Field via:peso is a hot field or requires assignment from browse
  BRW1.AddField(via:chofer,BRW1.Q.via:chofer)              ! Field via:chofer is a hot field or requires assignment from browse
  BRW1.AddField(via:nro_remito,BRW1.Q.via:nro_remito)      ! Field via:nro_remito is a hot field or requires assignment from browse
  BRW1.AddField(pro:id_proveedor,BRW1.Q.pro:id_proveedor)  ! Field pro:id_proveedor is a hot field or requires assignment from browse
  BRW1.AddField(pro1:id_procedencia,BRW1.Q.pro1:id_procedencia) ! Field pro1:id_procedencia is a hot field or requires assignment from browse
  BRW1.AddField(Loc:id_localidad,BRW1.Q.Loc:id_localidad)  ! Field Loc:id_localidad is a hot field or requires assignment from browse
  INIMgr.Fetch('BrowseViajesenProceso',QuickWindow)        ! Restore window settings from non-volatile store
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
    Relate:ProveedoresAlias.Close
    Relate:Viajes.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('BrowseViajesenProceso',QuickWindow)     ! Save window data to non-volatile store
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
      UpdateViajesenProceso
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
      ThisWindow.Reset(1)
    OF ?CallLookupProveedor
      ThisWindow.Update
      pro2:id_proveedor = L:id_proveedor
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        L:id_proveedor = pro2:id_proveedor
      END
      ThisWindow.Reset(1)
    OF ?BotonSeleccionFechaDesde
      ThisWindow.Update
      CHANGE(?L:fecha_desde,bigfec(CONTENTS(?L:fecha_desde)))
      !DO RefreshWindow
    OF ?BotonSeleccionFechaHasta
      ThisWindow.Update
      CHANGE(?L:fecha_hasta,bigfec(CONTENTS(?L:fecha_hasta)))
      !DO RefreshWindow
    OF ?Filtrar
      ThisWindow.Update
      DO filtrar
    OF ?EvoExportar
      ThisWindow.Update
       Do PrintExBrowse10
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


BRW1.ResetFromView PROCEDURE

L:cantidad_viajes:Cnt LONG                                 ! Count variable for browse totals
L:total_peso_estimado:Sum REAL                             ! Sum variable for browse totals
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
    L:cantidad_viajes:Cnt += 1
    L:total_peso_estimado:Sum += via:cap_tk_camion
  END
  SELF.View{PROP:IPRequestCount} = 0
  L:cantidad_viajes = L:cantidad_viajes:Cnt
  L:total_peso_estimado = L:total_peso_estimado:Sum
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
!!! Form Viajes
!!! </summary>
UpdateViajesenProceso PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::via:Record  LIKE(via:RECORD),THREAD
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('UpdateViajes'),WALLPAPER('fondo.jpg')
                       ENTRY(@P<<<<<<P),AT(175,52,40,10),USE(via:id_viaje),READONLY
                       ENTRY(@P<<<<<P),AT(176,93,24,10),USE(via:id_proveedor),RIGHT(1),OVR,MSG('Identificador ' & |
  'interno del proveedor de producto'),READONLY,REQ,TIP('Identificador interno del prov' & |
  'eedor de producto')
                       ENTRY(@d6),AT(175,214,48,10),USE(via:fecha_carga_DATE),READONLY,REQ
                       ENTRY(@N20_),AT(176,194,48,10),USE(via:cap_tk_camion),READONLY,REQ
                       BUTTON,AT(421,287,25,25),USE(?AceptarViajesTransito),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar lo' & |
  's datos y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON,AT(465,287,25,25),USE(?CancelarViajesTransito),FONT(,,,FONT:regular),ICON('Cancelar.ico'), |
  FLAT,MSG('Cancelar operación'),TIP('Cancelar operación')
                       PROMPT('Id viaje:'),AT(109,54),USE(?via:id_viaje:Prompt),TRN
                       PROMPT('Proveedor:'),AT(109,94),USE(?via:id_proveedor:Prompt),TRN
                       PROMPT('Fecha ultima carga:'),AT(109,215),USE(?avia:fecha_carga_DATE:Prompt),TRN
                       PROMPT('Cap. Camión'),AT(109,195),USE(?via:m3_tk_camion:Prompt),TRN
                       STRING('Enviar viaje a otra localidad'),AT(201,17),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       STRING(@s50),AT(220,93,160,12),USE(pro:proveedor),TRN
                       PROMPT('Kg<0DH,0AH>'),AT(231,194,15,10),USE(?via:peso:Prompt:4),TRN
                       PROMPT('Procedencia:'),AT(109,75),USE(?via:id_procedencia:Prompt)
                       ENTRY(@P<<<<P),AT(176,74,24,10),USE(via:id_procedencia),RIGHT(1),READONLY,REQ
                       STRING(@s50),AT(220,74,160,12),USE(pro1:procedencia),TRN
                       PROMPT('Chofer:'),AT(109,176),USE(?via:chofer:Prompt)
                       ENTRY(@s50),AT(175,175,120,10),USE(via:chofer),UPR
                       PROMPT('Nro remito:'),AT(109,139),USE(?via:nro_remito:Prompt)
                       ENTRY(@P####-########P),AT(175,137,60,10),USE(via:nro_remito)
                       PROMPT('Peso:'),AT(109,234),USE(?via:peso:Prompt)
                       ENTRY(@N20_),AT(175,232,53,10),USE(via:peso)
                       PROMPT('Kg<0DH,0AH>'),AT(233,233,13),USE(?via:peso:Prompt:2),TRN
                       STRING(@s50),AT(220,114,160,12),USE(tra:transportista),TRN
                       PROMPT('Transportista<0DH,0AH>'),AT(109,113,45,10),USE(?via:id_proveedor:Prompt:2),TRN
                       ENTRY(@P<<<P),AT(176,112,24,10),USE(via:id_transportista),RIGHT(1),OVR,MSG('Identificad' & |
  'or interno del proveedor de producto'),READONLY,REQ,TIP('Identificador interno del p' & |
  'roveedor de producto')
                       PROMPT('Destino:'),AT(109,270),USE(?via:chofer:Prompt:2)
                       ENTRY(@P<<P),AT(175,268,16,11),USE(via:id_localidad),READONLY,REQ,MSG('Localidad destino')
                       BUTTON,AT(195,268,12,12),USE(?CallLookupDestino),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@s20),AT(211,268,83,12),USE(Loc:Localidad),TRN
                       ENTRY(@n-20.0),AT(175,250,53,10),USE(via:peso_descargado)
                       PROMPT('Peso restante:'),AT(109,251),USE(?via:peso:Prompt:3)
                       PROMPT('Kg<0DH,0AH>'),AT(233,251,13),USE(?via:peso:Prompt:5),TRN
                       PROMPT('Guia transporte:'),AT(109,157),USE(?via:nro_remito:Prompt:2)
                       ENTRY(@s50),AT(175,155,120,10),USE(via:guia_transporte)
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
  QuickWindow{PROP:StatusText,0} = ActionMessage           ! Display status message in status bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateViajesenProceso')
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
  SELF.AddHistoryField(?via:chofer,13)
  SELF.AddHistoryField(?via:nro_remito,7)
  SELF.AddHistoryField(?via:peso,8)
  SELF.AddHistoryField(?via:id_transportista,3)
  SELF.AddHistoryField(?via:id_localidad,20)
  SELF.AddHistoryField(?via:peso_descargado,14)
  SELF.AddHistoryField(?via:guia_transporte,4)
  SELF.AddUpdateFile(Access:Viajes)
  SELF.AddItem(?CancelarViajesTransito,RequestCancelled)   ! Add the cancel control to the window manager
  IF SELF.Request<>ViewRecord
     Transaction.AddItem(Relate:Viajes,True)
     Transaction.AddItem(Relate:programacion,True)
  END
  Relate:Viajes.SetOpenRelated()
  Relate:Viajes.Open                                       ! File Viajes used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Viajes
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
    SELF.CancelAction = Cancel:Cancel                      ! No confirm cancel
    SELF.OkControl = ?AceptarViajesTransito
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  prog:id_programacion = via:id_programacion
  Access:programacion.fetch(prog:PK_PROGRAMACION)
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?via:id_viaje{PROP:ReadOnly} = True
    ?via:id_proveedor{PROP:ReadOnly} = True
    ?via:fecha_carga_DATE{PROP:ReadOnly} = True
    ?via:cap_tk_camion{PROP:ReadOnly} = True
    ?via:id_procedencia{PROP:ReadOnly} = True
    ?via:chofer{PROP:ReadOnly} = True
    ?via:nro_remito{PROP:ReadOnly} = True
    ?via:peso{PROP:ReadOnly} = True
    ?via:id_transportista{PROP:ReadOnly} = True
    ?via:id_localidad{PROP:ReadOnly} = True
    DISABLE(?CallLookupDestino)
    ?via:peso_descargado{PROP:ReadOnly} = True
    ?via:guia_transporte{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateViajesenProceso',QuickWindow)        ! Restore window settings from non-volatile store
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
    INIMgr.Update('UpdateViajesenProceso',QuickWindow)     ! Save window data to non-volatile store
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
  Loc:id_localidad = via:id_localidad                      ! Assign linking field value
  Access:Localidades_GLP.Fetch(Loc:PK_localidad)
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
      SelectTransportistas
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
    OF ?via:id_proveedor
      IF via:id_proveedor OR ?via:id_proveedor{PROP:Req}
        pro:id_proveedor = via:id_proveedor
        IF Access:Proveedores.TryFetch(pro:PK_proveedor)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            via:id_proveedor = pro:id_proveedor
          ELSE
            SELECT(?via:id_proveedor)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?AceptarViajesTransito
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
    OF ?via:id_transportista
      IF via:id_transportista OR ?via:id_transportista{PROP:Req}
        tra:id_transportista = via:id_transportista
        IF Access:Transportistas.TryFetch(tra:PK_TRANSPORTISTA)
          IF SELF.Run(3,SelectRecord) = RequestCompleted
            via:id_transportista = tra:id_transportista
          ELSE
            SELECT(?via:id_transportista)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?via:id_localidad
      IF via:id_localidad OR ?via:id_localidad{PROP:Req}
        Loc:id_localidad = via:id_localidad
        IF Access:Localidades_GLP.TryFetch(Loc:PK_localidad)
          IF SELF.Run(4,SelectRecord) = RequestCompleted
            via:id_localidad = Loc:id_localidad
          ELSE
            SELECT(?via:id_localidad)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupDestino
      ThisWindow.Update
      Loc:id_localidad = via:id_localidad
      IF SELF.Run(4,SelectRecord) = RequestCompleted
        via:id_localidad = Loc:id_localidad
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
  IF SELF.Request<>ViewRecord
     ReturnValue = Transaction.Start()
     IF ReturnValue<>Level:Benign THEN RETURN ReturnValue.
  END
  !Actualizacion de variables de estado en viajes y programacion
  if  self.Request = changeRecord
  !      via:estado = 'En transito'
  !      !via:ano = year(via:fecha_carga_DATE)
  !      !via:mes = month(via:fecha_carga_DATE)
  !      via:peso_restante = via:peso
  !      prog:cupo_GLP_utilizado -=via:cap_tk_camion +via:peso
  !      prog:cupo_GLP_restante = prog:cupo_GLP - prog:cupo_GLP_utilizado
  !      if Access:programacion.Update() <> Level:Benign
  !              message('Error en la actualización de la tabla programacion')
         
      !end
     
      
  END
  ReturnValue = PARENT.TakeCompleted()
  ! A ReturnValue other than Level:Benign will rollback the transaction
  IF SELF.Request<>ViewRecord
     Transaction.Finish(ReturnValue)
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
BrowseContactos PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(contactos_proveedores)
                       PROJECT(cont:id_contacto)
                       PROJECT(cont:id_proveedor)
                       PROJECT(cont:nombre)
                       PROJECT(cont:telefono)
                       PROJECT(cont:mail)
                       JOIN(pro:PK_proveedor,cont:id_proveedor)
                         PROJECT(pro:proveedor)
                         PROJECT(pro:id_proveedor)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
cont:id_contacto       LIKE(cont:id_contacto)         !List box control field - type derived from field
cont:id_proveedor      LIKE(cont:id_proveedor)        !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
cont:nombre            LIKE(cont:nombre)              !List box control field - type derived from field
cont:telefono          LIKE(cont:telefono)            !List box control field - type derived from field
cont:mail              LIKE(cont:mail)                !List box control field - type derived from field
pro:id_proveedor       LIKE(pro:id_proveedor)         !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),RESIZE,CENTER, |
  GRAY,IMM,MDI,HLP('BrowseContactos'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(73,76,385,152),USE(?Browse:1),HVSCROLL,FORMAT('48L(2)|M~Id contacto~@P<<<<<<<<P' & |
  '@0L(2)|M~ID Proveedor~@P<<<<<<<<<<P@135L(2)|M~Proveedor~L(0)@s50@80L(2)|M~nombre~@s5' & |
  '0@80L(2)|M~telefono~@s50@80L(2)|M~mail~@s50@'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he contactos file')
                       BUTTON,AT(175,287,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(204,287,25,25),USE(?View:3),ICON('Ver.ico'),FLAT,MSG('Visualiza el registro'),TIP('Visualiza ' & |
  'el registro')
                       BUTTON,AT(233,287,25,25),USE(?Insert:4),ICON('Insertar.ico'),FLAT,MSG('Inserta un Registro'), |
  TIP('Inserta un Registro')
                       BUTTON,AT(262,287,25,25),USE(?Change:4),ICON('Editar.ico'),DEFAULT,FLAT,MSG('Modifica e' & |
  'l registro'),TIP('Modifica el registro')
                       BUTTON,AT(291,287,25,25),USE(?Delete:4),ICON('Eliminar.ICO'),FLAT,MSG('Elimina un registro'), |
  TIP('Elimina un registro')
                       BUTTON,AT(425,287,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(453,287,25,25),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('Muestra ve' & |
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
  GlobalErrors.SetProcedureName('BrowseContactos')
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
  Relate:contactos_proveedores.Open                        ! File contactos_proveedores used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:contactos_proveedores,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,cont:PK_contacto)                     ! Add the sort order for cont:PK_contacto for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,cont:id_contacto,,BRW1)        ! Initialize the browse locator using  using key: cont:PK_contacto , cont:id_contacto
  BRW1.AddField(cont:id_contacto,BRW1.Q.cont:id_contacto)  ! Field cont:id_contacto is a hot field or requires assignment from browse
  BRW1.AddField(cont:id_proveedor,BRW1.Q.cont:id_proveedor) ! Field cont:id_proveedor is a hot field or requires assignment from browse
  BRW1.AddField(pro:proveedor,BRW1.Q.pro:proveedor)        ! Field pro:proveedor is a hot field or requires assignment from browse
  BRW1.AddField(cont:nombre,BRW1.Q.cont:nombre)            ! Field cont:nombre is a hot field or requires assignment from browse
  BRW1.AddField(cont:telefono,BRW1.Q.cont:telefono)        ! Field cont:telefono is a hot field or requires assignment from browse
  BRW1.AddField(cont:mail,BRW1.Q.cont:mail)                ! Field cont:mail is a hot field or requires assignment from browse
  BRW1.AddField(pro:id_proveedor,BRW1.Q.pro:id_proveedor)  ! Field pro:id_proveedor is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseContactos',QuickWindow)              ! Restore window settings from non-volatile store
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
    Relate:contactos_proveedores.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseContactos',QuickWindow)           ! Save window data to non-volatile store
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
    UpdateContactos
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
!!! Form contactos
!!! </summary>
UpdateContactos PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::cont:Record LIKE(cont:RECORD),THREAD
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('UpdateContactos'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(414,294,25,25),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Acepta los dato' & |
  's y cierra ventana'),TIP('Acepta los datos y cierra ventana')
                       BUTTON,AT(442,294,25,25),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancela operación'),TIP('Cancela operación')
                       BUTTON,AT(471,294,25,25),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Mostrar ventana de ayuda'), |
  STD(STD:Help),TIP('Mostrar ventana de ayuda')
                       ENTRY(@s50),AT(129,137,204,10),USE(cont:telefono,,?cont:telefono:2)
                       ENTRY(@P<<<<P),AT(129,91,40,10),USE(cont:id_contacto,,?cont:id_contacto:2),RIGHT(1)
                       ENTRY(@P<<<<<P),AT(129,105,40,10),USE(cont:id_proveedor,,?cont:id_proveedor:2),RIGHT(1),OVR, |
  MSG('Identificador interno del proveedor de producto'),TIP('Identificador interno del' & |
  ' proveedor de producto')
                       PROMPT('Proveedor:'),AT(73,105),USE(?cont:id_proveedor:Prompt:2),TRN
                       PROMPT('Nombre:'),AT(73,121),USE(?cont:nombre:Prompt:2),TRN
                       ENTRY(@s50),AT(129,121,204,10),USE(cont:nombre,,?cont:nombre:2)
                       PROMPT('Id contacto:'),AT(73,91),USE(?cont:id_contacto:Prompt:2),TRN
                       PROMPT('Teléfono:'),AT(73,137),USE(?cont:telefono:Prompt:2),TRN
                       PROMPT('E-mail:'),AT(73,152),USE(?cont:mail:Prompt:2),TRN
                       ENTRY(@s50),AT(129,152,204,10),USE(cont:mail,,?cont:mail:2)
                       BUTTON,AT(174,105,12,12),USE(?CallLookupProveedor),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@s50),AT(190,106,144,9),USE(pro:proveedor)
                       STRING('Ingreso de contactos'),AT(223,18),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI)
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
    ActionMessage = 'Adding a contactos Record'
  OF ChangeRecord
    ActionMessage = 'Changing a contactos Record'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateContactos')
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
  SELF.AddHistoryFile(cont:Record,History::cont:Record)
  SELF.AddHistoryField(?cont:telefono:2,4)
  SELF.AddHistoryField(?cont:id_contacto:2,1)
  SELF.AddHistoryField(?cont:id_proveedor:2,2)
  SELF.AddHistoryField(?cont:nombre:2,3)
  SELF.AddHistoryField(?cont:mail:2,5)
  SELF.AddUpdateFile(Access:contactos_proveedores)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:contactos_proveedores.Open                        ! File contactos_proveedores used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:contactos_proveedores
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
    ?cont:telefono:2{PROP:ReadOnly} = True
    ?cont:id_contacto:2{PROP:ReadOnly} = True
    ?cont:id_proveedor:2{PROP:ReadOnly} = True
    ?cont:nombre:2{PROP:ReadOnly} = True
    ?cont:mail:2{PROP:ReadOnly} = True
    DISABLE(?CallLookupProveedor)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateContactos',QuickWindow)              ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:contactos_proveedores.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateContactos',QuickWindow)           ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  pro:id_proveedor = cont:id_proveedor                     ! Assign linking field value
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
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    OF ?cont:id_proveedor:2
      IF cont:id_proveedor OR ?cont:id_proveedor:2{PROP:Req}
        pro:id_proveedor = cont:id_proveedor
        IF Access:Proveedores.TryFetch(pro:PK_proveedor)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            cont:id_proveedor = pro:id_proveedor
          ELSE
            SELECT(?cont:id_proveedor:2)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookupProveedor
      ThisWindow.Update
      pro:id_proveedor = cont:id_proveedor
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        cont:id_proveedor = pro:id_proveedor
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
!!! </summary>
ReportProveedores PROCEDURE 

Progress:Thermometer BYTE                                  !
Process:View         VIEW(Proveedores)
                       PROJECT(pro:ciudad)
                       PROJECT(pro:contacto)
                       PROJECT(pro:direccion)
                       PROJECT(pro:id_proveedor)
                       PROJECT(pro:proveedor)
                       PROJECT(pro:provincia)
                       PROJECT(pro:telefono)
                       JOIN(cont:FK_PROVEEDOR,pro:id_proveedor)
                         PROJECT(cont:mail)
                         PROJECT(cont:nombre)
                         PROJECT(cont:telefono)
                       END
                     END
ProgressWindow       WINDOW,AT(,,142,89),DOUBLE,CENTER,GRAY,TIMER(1),WALLPAPER('fondo.jpg')
                       PROGRESS,AT(15,32,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,20,141,10),USE(?Progress:UserString),FONT(,10,,FONT:bold+FONT:italic),CENTER, |
  TRN
                       STRING(''),AT(0,46,141,10),USE(?Progress:PctText),FONT(,10,,FONT:bold+FONT:italic),CENTER, |
  TRN
                       BUTTON('Cancel'),AT(58,59,25,25),USE(?Progress:Cancel),LEFT,ICON('Cancelar.ico'),FLAT,TRN
                     END

Report               REPORT,AT(1000,4000,6250,5625),PRE(RPT),PAPER(PAPER:A4),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(1000,1000,6250,3000),USE(?Header)
                         STRING(@s50),AT(917,1135),USE(pro:proveedor),FONT(,8,,FONT:bold)
                         STRING(@s50),AT(917,1396),USE(pro:direccion),FONT(,8,,FONT:bold)
                         STRING(@s50),AT(917,1656),USE(pro:ciudad),FONT(,8,,FONT:bold)
                         STRING(@s50),AT(917,1917),USE(pro:provincia),FONT(,8,,FONT:bold)
                         STRING(@s50),AT(917,2177),USE(pro:telefono),FONT(,8,,FONT:bold)
                         STRING(@s50),AT(917,2437),USE(pro:contacto),FONT(,8,,FONT:bold)
                         STRING('Proveedor:'),AT(198,1135,656),USE(?STRING1),FONT(,8,,FONT:bold),TRN
                         STRING('Dirección:'),AT(198,1396,656,198),USE(?STRING1:2),FONT(,8,,FONT:bold),TRN
                         STRING('Ciudad:'),AT(198,1656,656,198),USE(?STRING1:3),FONT(,8,,FONT:bold),TRN
                         STRING('Provincia:'),AT(198,1917,656,198),USE(?STRING1:4),FONT(,8,,FONT:bold),TRN
                         STRING('Teléfono:'),AT(198,2177,656,198),USE(?STRING1:5),FONT(,8,,FONT:bold),TRN
                         STRING('Contacto:'),AT(198,2437,656,198),USE(?STRING1:6),FONT(,8,,FONT:bold),TRN
                         STRING('Nombre'),AT(375,2750,1656,177),USE(?STRING1:7),FONT(,8,COLOR:Black,FONT:bold),CENTER, |
  TRN
                         STRING('Télefono'),AT(2333,2750,1656,177),USE(?STRING1:8),FONT(,8,COLOR:Black,FONT:bold),CENTER, |
  TRN
                         STRING('E-mail'),AT(4344,2750,1656,177),USE(?STRING1:9),FONT(,8,COLOR:Black,FONT:bold),CENTER, |
  TRN
                         BOX,AT(240,2687,5844,292),USE(?BOX1),COLOR(COLOR:Black),LINEWIDTH(1)
                         LINE,AT(2125,2698,0,271),USE(?LINE1:3),COLOR(COLOR:Black)
                         LINE,AT(4250,2698,0,271),USE(?LINE1:6),COLOR(COLOR:Black)
                       END
Detail                 DETAIL,AT(0,0,6250,281),USE(?Detail)
                         STRING(@s50),AT(375,31,1656),USE(cont:nombre)
                         STRING(@s50),AT(2333,31,1656),USE(cont:telefono)
                         STRING(@s50),AT(4344,31,1656,198),USE(cont:mail)
                         LINE,AT(250,281,5823,0),USE(?LINE2)
                         LINE,AT(4250,0,0,281),USE(?LINE1)
                         LINE,AT(2125,-9,0,281),USE(?LINE1:2)
                         LINE,AT(250,0,5823,0),USE(?LINE2:2)
                         LINE,AT(6073,-9,0,281),USE(?LINE1:4)
                         LINE,AT(250,-9,0,281),USE(?LINE1:5)
                       END
                       FOOTER,AT(1000,9688,6250,1000),USE(?Footer)
                       END
                       FORM,AT(1000,1000,6250,9688),USE(?Form)
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
  GlobalErrors.SetProcedureName('ReportProveedores')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:Proveedores.Open                                  ! File Proveedores used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('ReportProveedores',ProgressWindow)         ! Restore window settings from non-volatile store
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:Proveedores, ?Progress:PctText, Progress:Thermometer, ProgressMgr, pro:id_proveedor)
  ThisReport.AddSortOrder(pro:PK_proveedor)
  ThisReport.AddRange(pro:id_proveedor)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:Proveedores.SetQuickScan(1,Propagate:OneMany)
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
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
    INIMgr.Update('ReportProveedores',ProgressWindow)      ! Save window data to non-volatile store
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

!!! <summary>
!!! Procedure not yet defined
!!! </summary>
UpdateContactosTransportista PROCEDURE !Procedure not yet defined
  CODE
  GlobalErrors.ThrowMessage(Msg:ProcedureToDo,'UpdateContactosTransportista') ! This procedure acts as a place holder for a procedure yet to be defined
  SETKEYCODE(0)
  GlobalResponse = RequestCancelled                        ! Request cancelled is the implied action
!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
SelectLocalidades_GLPAlias PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Localidades_GLPAlias1)
                       PROJECT(Loc1:id_localidad)
                       PROJECT(Loc1:Localidad)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
Loc1:id_localidad      LIKE(Loc1:id_localidad)        !List box control field - type derived from field
Loc1:Localidad         LIKE(Loc1:Localidad)           !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,233,226),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('SelectLocalidades_GLPAlias'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(18,40,184,113),USE(?Browse:1),HVSCROLL,FORMAT('64R(2)|M~Id localidad~C(0)@n-14@' & |
  '80L(2)|M~Localidad~L(2)@s20@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the Localidade' & |
  's_GLPAlias1 file')
                       BUTTON,AT(11,180,25,25),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona el registro'), |
  TIP('Selecciona el registro')
                       BUTTON,AT(163,180,25,25),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(193,180,25,25),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('Muestra ve' & |
  'ntana de ayuda'),STD(STD:Help),TIP('Muestra ventana de ayuda')
                       STRING('Seleccione la localidad'),AT(70,14),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline)
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
  GlobalErrors.SetProcedureName('SelectLocalidades_GLPAlias')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  BIND('GLO:localidad_id',GLO:localidad_id)                ! Added by: BrowseBox(ABC)
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:Localidades_GLPAlias1.Open                        ! File Localidades_GLPAlias1 used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Localidades_GLPAlias1,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,Loc1:PK_localidad)                    ! Add the sort order for Loc1:PK_localidad for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,Loc1:id_localidad,1,BRW1)      ! Initialize the browse locator using  using key: Loc1:PK_localidad , Loc1:id_localidad
  BRW1.SetFilter('(Loc1:id_localidad <<>GLO:localidad_id)') ! Apply filter expression to browse
  BRW1.AddField(Loc1:id_localidad,BRW1.Q.Loc1:id_localidad) ! Field Loc1:id_localidad is a hot field or requires assignment from browse
  BRW1.AddField(Loc1:Localidad,BRW1.Q.Loc1:Localidad)      ! Field Loc1:Localidad is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectLocalidades_GLPAlias',QuickWindow)   ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Localidades_GLPAlias1.Close
  END
  IF SELF.Opened
    INIMgr.Update('SelectLocalidades_GLPAlias',QuickWindow) ! Save window data to non-volatile store
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

