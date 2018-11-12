

   MEMBER('existencias.clw')                               ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('BRWEXT.INC'),ONCE

                     MAP
                       INCLUDE('EXISTENCIAS003.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('EXISTENCIAS002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS005.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS006.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('EXISTENCIAS008.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Form Descargas
!!! Se utiliza para registrar las descargas de camiones en la planta.
!!! Ademas actualiza los estados de los viaje
!!! Tablas relacionadas : Descargas - Viajes
!!! </summary>
UpdateDescargas PROCEDURE 

CurrentTab           STRING(80)                            !
l:transportista      STRING(50)                            !
l:id_transportista   LONG,NAME('"ID_TRANSPORTISTA"')       !
l:id_localidad_viaje LONG,NAME('"ID_LOCALIDAD"')           !Localidad destino
l:peso_descargado    DECIMAL(7,2)                          !
l:guia_transporte    STRING(51),NAME('"guia_transporte"')  !
l:nro_remito         STRING(51),NAME('"nro_remito"')       !
l:peso               DECIMAL(7,2)                          !
l:existencia_actual  LONG                                  !
l:localidad          STRING(20)                            !
l:chofer             CSTRING(51)                           !
ActionMessage        CSTRING(40)                           !
l:descarga_anterior  BYTE                                  !Se utiliza cuando se modifica una descarga para restarselo al producto descargado
l:id_localidad_transferencia LONG                          !
l:StrSQL             STRING(500)                           !
History::des:Record  LIKE(des:RECORD),THREAD
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  ICON('Calcular.ico'),GRAY,IMM,MDI,HLP('UpdateDescargas'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON,AT(449,289,30,30),USE(?OK),LEFT,ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Accept dat' & |
  'a and close the window'),TIP('Accept data and close the window'),TRN
                       BUTTON,AT(137,44,12,12),USE(?CallLookupLocalidad),ICON('Lupita.ico'),FLAT,TRN
                       ENTRY(@P<<<<<<P),AT(79,79,32,10),USE(des:id_viaje),REQ
                       BUTTON,AT(127,77,12,12),USE(?CallLookupViaje),ICON('Lupita.ico'),FLAT,TRN
                       ENTRY(@P####-########P),AT(79,121,64,10),USE(l:guia_transporte),FONT(,,,FONT:regular),REQ
                       ENTRY(@N-10.`2),AT(177,121,60,10),USE(l:peso),REQ
                       PROMPT('KG'),AT(241,121),USE(?pla:EXISTENCIA_ACTUAL:Prompt),TRN
                       ENTRY(@P####-########P),AT(79,137,64,10),USE(l:nro_remito),FONT(,,,FONT:regular),REQ
                       ENTRY(@s50),AT(79,152,160,10),USE(via:chofer),UPR
                       ENTRY(@d6),AT(99,187,55,10),USE(des:fecha_descarga_DATE),REQ
                       BUTTON,AT(159,180,24,25),USE(?BotonSeleccionFechaDescarga),ICON('calen.ico'),FLAT,TRN
                       ENTRY(@t1),AT(247,187,25,10),USE(des:fecha_descarga_TIME)
                       ENTRY(@N-20_),AT(99,207,64,10),USE(des:cantidad),REQ
                       ENTRY(@N-7_.3),AT(99,223,40,10),USE(des:densidad)
                       ENTRY(@N-9_.3),AT(99,241,44,10),USE(des:densidad_corregida)
                       ENTRY(@N-4_.1),AT(99,258,40,10),USE(des:t_c)
                       ENTRY(@S30),AT(99,276,124,10),USE(des:operador),UPR
                       ENTRY(@d6),AT(99,297,55,10),USE(des:fecha_salida_DATE),REQ
                       BUTTON,AT(159,289,25,25),USE(?BotonSeleccionFechaSalida),ICON('calen.ico'),FLAT,TRN
                       ENTRY(@t1),AT(235,297,25,10),USE(des:fecha_salida_TIME)
                       BUTTON,AT(483,289,30,30),USE(?Cancel),LEFT,ICON('Cancelar.ico'),FLAT,MSG('Cancel operation'), |
  TIP('Cancel operation'),TRN
                       ENTRY(@N-14_),AT(126,14,23,10),USE(des:id_localidad),HIDE,READONLY,REQ
                       ENTRY(@P<<P),AT(301,46,13,10),USE(des:id_planta),OVR,HIDE,REQ
                       BUTTON,AT(250,44,12,12),USE(?CallLookupPlanta),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@s20),AT(53,44,81,11),USE(Loc:Localidad),TRN
                       ENTRY(@P<<<<<P),AT(77,14,40,10),USE(des:id_descarga),HIDE
                       PROMPT('Viaje:'),AT(18,79),USE(?des:id_viaje:Prompt),TRN
                       PROMPT('Fecha descarga:'),AT(18,187),USE(?Ades:fecha_descarga_DATE:Prompt),TRN
                       PROMPT('Id descarga:'),AT(32,14),USE(?des:id_descarga:Prompt),HIDE
                       PROMPT('Hora descarga:'),AT(193,187),USE(?ades:fecha_descarga_TIME:Prompt),TRN
                       PROMPT('Nro Planta:'),AT(197,45),USE(?des:id_planta:Prompt),TRN
                       PROMPT('Cantidad de Producto:'),AT(18,207),USE(?des:cantidad:Prompt),TRN
                       PROMPT('Densidad remito:'),AT(18,223),USE(?des:densidad:Prompt),TRN
                       PROMPT('Densidad medida:'),AT(18,241),USE(?des:densidad_corregida:Prompt),TRN
                       PROMPT('Temp:'),AT(18,258),USE(?des:t_c:Prompt),TRN
                       PROMPT('Operador:'),AT(18,276),USE(?des:operador:Prompt),TRN
                       PROMPT('Fecha salida:'),AT(18,297),USE(?Ades:fecha_salida_DATE:Prompt),TRN
                       PROMPT('Hora salida:'),AT(193,297),USE(?ades:fecha_salida_TIME:Prompt),TRN
                       PROMPT('Chofer:'),AT(18,153),USE(?via:chofer:Prompt),TRN
                       STRING('Descarga de Camiones'),AT(217,14),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       STRING('Transportista:'),AT(18,93),USE(?STRING2),TRN
                       STRING(@s50),AT(115,93,203,9),USE(l:transportista),TRN
                       PROMPT('Guia Transporte:'),AT(18,122),USE(?via:guia_transporte:Prompt),TRN
                       STRING('Proveedor:'),AT(18,106,35,11),USE(?STRING2:2),TRN
                       STRING(@s50),AT(79,107,203,9),USE(pro:proveedor),TRN
                       STRING(@s50),AT(193,80,203,9),USE(pro1:procedencia),TRN
                       STRING('Procedencia:'),AT(147,80,43,10),USE(?STRING2:3),TRN
                       PROMPT('Nro Remito:'),AT(18,137),USE(?via:nro_remito:Prompt),TRN
                       STRING(@n-20.0),AT(321,121,51,11),USE(via:peso_descargado),TRN
                       STRING('Prod. Descargado:'),AT(257,121,61,11),USE(?STRING2:4),TRN
                       STRING(@P<<P),AT(234,45,12,13),USE(pla:NRO_PLANTA),TRN
                       PROMPT('Localidad:'),AT(18,45),USE(?des:id_localidad:Prompt),TRN
                       PROMPT('Peso:'),AT(152,121),USE(?via:peso:Prompt),TRN
                       PROMPT('KG'),AT(167,209),USE(?pla:EXISTENCIA_ACTUAL:Prompt:5),TRN
                       BOX,AT(13,73,426,97),USE(?BOX1),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       STRING('Fecha viaje:'),AT(338,93,43,9),USE(?STRING2:5),TRN
                       STRING(@d6),AT(385,93,47,10),USE(via:fecha_carga_DATE),TRN
                       BOX,AT(13,36,426,31),USE(?BOX1:2),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       BOX,AT(13,178,425,141),USE(?BOX1:3),COLOR(COLOR:Blue),LINEWIDTH(1),ROUND
                       PROMPT('Transferir viaje a :'),AT(224,138),USE(?Ades:fecha_salida_DATE:Prompt:2),TRN
                       ENTRY(@P<<<<P),AT(284,137,25,10),USE(l:id_localidad_transferencia),RIGHT(1),MSG('Localidad destino'), |
  TIP('Localidad destino')
                       BUTTON,AT(313,135,12,12),USE(?CallLookupLocalidadViaje),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@s20),AT(329,138,87,9),USE(Loc1:Localidad),TRN
                       ENTRY(@P<<<P),AT(78,92,16),USE(l:id_transportista)
                       BUTTON,AT(99,92,12,12),USE(?CallLookupTrasnportista),ICON('Lupita.ico'),FLAT,TRN
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
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
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
AsignarVariablesViaje      ROUTINE

   

        IF clip(via:guia_transporte) <> ''
            l:guia_transporte = via:guia_transporte
        END
        
        IF clip(via:nro_remito) <> ''
            l:nro_remito =via:nro_remito
        END
        IF via:peso <> 0
            l:peso = via:peso
        END
        
        IF clip(via:chofer) <> ''
            l:chofer =via:chofer
        END
        
        if via:id_localidad <> 0
            l:id_localidad_viaje = via:id_localidad
        END
        
        if via:peso_descargado <> 0
            l:peso_descargado = via:peso_descargado
        END
    
        IF via:id_transportista <> 0 
          l:id_transportista = via:id_transportista
          
          tra:id_transportista = via:id_transportista
        
          IF Access:Transportistas.fetch(tra:PK_TRANSPORTISTA) = Level:Benign
            
              l:transportista = tra:transportista
              DISPLAY(?l:transportista)
          END
        END
    
    
      l:id_localidad_viaje = des:id_localidad 

    
    
    EXIT
    
    
actualizarVariablesViaje    ROUTINE
    
        via:id_localidad = des:id_localidad  
        via:peso_descargado = l:peso_descargado - l:descarga_anterior + des:cantidad
        via:id_transportista = l:id_transportista
        via:guia_transporte = l:guia_transporte
        via:nro_remito = l:nro_remito
        via:peso = l:peso
        via:chofer = l:chofer
        via:id_localidad =l:id_localidad_viaje
             
        IF l:id_localidad_transferencia > 0
              via:id_localidad = l:id_localidad_transferencia
        END
        
        IF via:peso_descargado = via:peso
                via:estado = 'Descargado'
                
           ELSIF via:peso_descargado <= via:peso
            via:estado = 'En proceso'
        END
    EXIT
    
actualizarVariablesProgramacion     ROUTINE
    prog:id_programacion = via:id_programacion
    IF Access:programacion.Fetch(prog:PK_PROGRAMACION) = Level:Benign
        prog:cupo_GLP_programado -=via:cap_tk_camion
        prog:cupo_GLP_utilizado += via:peso
        prog:cupo_GLP_restante = prog:cupo_GLP -(prog:cupo_GLP_programado+prog:cupo_GLP_utilizado)
        IF ACCESS:programacion.Update() <> Level:Benign
            MESSAGE('Error en la actualizacion de programacion','Atencion')
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
  GlobalErrors.SetProcedureName('UpdateDescargas')
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
  SELF.AddHistoryFile(des:Record,History::des:Record)
  SELF.AddHistoryField(?des:id_viaje,2)
  SELF.AddHistoryField(?des:fecha_descarga_DATE,5)
  SELF.AddHistoryField(?des:fecha_descarga_TIME,6)
  SELF.AddHistoryField(?des:cantidad,9)
  SELF.AddHistoryField(?des:densidad,10)
  SELF.AddHistoryField(?des:densidad_corregida,11)
  SELF.AddHistoryField(?des:t_c,12)
  SELF.AddHistoryField(?des:operador,13)
  SELF.AddHistoryField(?des:fecha_salida_DATE,16)
  SELF.AddHistoryField(?des:fecha_salida_TIME,17)
  SELF.AddHistoryField(?des:id_localidad,8)
  SELF.AddHistoryField(?des:id_planta,7)
  SELF.AddHistoryField(?des:id_descarga,1)
  SELF.AddUpdateFile(Access:Descargas)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Descargas.SetOpenRelated()
  Relate:Descargas.Open                                    ! File Descargas used by this procedure, so make sure it's RelationManager is open
  Relate:Localidades_GLPAlias1.Open                        ! File Localidades_GLPAlias1 used by this procedure, so make sure it's RelationManager is open
  Relate:PlantasStock.Open                                 ! File PlantasStock used by this procedure, so make sure it's RelationManager is open
  Relate:ViajesAlias1.Open                                 ! File ViajesAlias1 used by this procedure, so make sure it's RelationManager is open
  Relate:aux_sql.Open                                      ! File aux_sql used by this procedure, so make sure it's RelationManager is open
  Access:programacion.UseFile                              ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Descargas
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
  !Asignar variables cuando es una inserción
  IF Self.request = InsertRecord
     IF GLO:localidad_id <> 0
          des:id_localidad = GLO:localidad_id
          Loc:id_localidad = GLO:localidad_id
          
          if Access:Localidades_GLP.fetch(Loc:PK_localidad) <> Level:Benign
              message('No se pudo encontrar la localidad')
          ELSE
              des:id_localidad = Loc:id_localidad
              display(?des:id_localidad)
              display(?Loc:Localidad)
             
          END
          
          l:id_localidad_transferencia = des:id_localidad
          Loc1:id_localidad= l:id_localidad_transferencia
          Access:Localidades_GLPAlias1.Fetch(Loc1:PK_localidad)
      ELSE
          MESSAGE('Ingrese la localidad','Atención',ICON:Exclamation)
          select(?des:id_localidad)
          
      END
  
  
      IF GLO:id_planta <> 0
          des:id_planta = GLO:id_planta
          pla:ID_PLANTA = GLO:id_planta
          if Access:Plantas.Fetch(pla:PK__plantas__7D439ABD) <> Level:Benign
              message('No se pudo encontrar la planta')
          ELSE
              des:id_planta = pla:id_planta
              DISPLAY(?des:id_planta)
              
              
          END
      ELSE
          MESSAGE('Ingrese la planta','Atención',ICON:Exclamation)
          select(?des:id_planta)
          
      END
    
      l:descarga_anterior = 0
     
      ThisWindow.Reset(1)
      display()
  end
  !Asignar variables cuando es una modificación
  
  
  if self.Request = ChangeRecord
    
      l:descarga_anterior = des:cantidad
      
      DO asignarVariablesViaje
      
      
  
  END
  
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    DISABLE(?CallLookupLocalidad)
    ?des:id_viaje{PROP:ReadOnly} = True
    DISABLE(?CallLookupViaje)
    ?l:guia_transporte{PROP:ReadOnly} = True
    ?l:peso{PROP:ReadOnly} = True
    ?l:nro_remito{PROP:ReadOnly} = True
    ?via:chofer{PROP:ReadOnly} = True
    ?des:fecha_descarga_DATE{PROP:ReadOnly} = True
    DISABLE(?BotonSeleccionFechaDescarga)
    ?des:fecha_descarga_TIME{PROP:ReadOnly} = True
    ?des:cantidad{PROP:ReadOnly} = True
    ?des:densidad{PROP:ReadOnly} = True
    ?des:densidad_corregida{PROP:ReadOnly} = True
    ?des:t_c{PROP:ReadOnly} = True
    ?des:operador{PROP:ReadOnly} = True
    ?des:fecha_salida_DATE{PROP:ReadOnly} = True
    DISABLE(?BotonSeleccionFechaSalida)
    ?des:fecha_salida_TIME{PROP:ReadOnly} = True
    ?des:id_localidad{PROP:ReadOnly} = True
    ?des:id_planta{PROP:ReadOnly} = True
    DISABLE(?CallLookupPlanta)
    ?des:id_descarga{PROP:ReadOnly} = True
    ?l:id_localidad_transferencia{PROP:ReadOnly} = True
    DISABLE(?CallLookupLocalidadViaje)
    ?l:id_transportista{PROP:ReadOnly} = True
    DISABLE(?CallLookupTrasnportista)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateDescargas',QuickWindow)              ! Restore window settings from non-volatile store
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
    Relate:Localidades_GLPAlias1.Close
    Relate:PlantasStock.Close
    Relate:ViajesAlias1.Close
    Relate:aux_sql.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateDescargas',QuickWindow)           ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  via:id_viaje = des:id_viaje                              ! Assign linking field value
  Access:Viajes.Fetch(via:PK_viajes)
  tra:id_transportista = via:id_transportista              ! Assign linking field value
  Access:Transportistas.Fetch(tra:PK_TRANSPORTISTA)
  pro:id_proveedor = via:id_proveedor                      ! Assign linking field value
  Access:Proveedores.Fetch(pro:PK_proveedor)
  pro1:id_procedencia = via:id_procedencia                 ! Assign linking field value
  Access:Procedencias.Fetch(pro1:PK_PROCEDENCIA)
  Loc:id_localidad = des:id_localidad                      ! Assign linking field value
  Access:Localidades_GLP.Fetch(Loc:PK_localidad)
  pla:ID_PLANTA = des:id_planta                            ! Assign linking field value
  Access:Plantas.Fetch(pla:PK__plantas__7D439ABD)
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
      SelectViajesEnTransito
      SelectLocalidades_GLP
      SelectPlantas
      SelectLocalidades_GLPAlias
      SelectTransportistas
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
    OF ?CallLookupLocalidad
      ThisWindow.Update
      Loc:id_localidad = des:id_localidad
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        des:id_localidad = Loc:id_localidad
        l:id_localidad_transferencia = des:id_localidad
        GLO:localidad_id = Loc:id_localidad
      END
      ThisWindow.Reset(1)
    OF ?des:id_viaje
      IF des:id_viaje OR ?des:id_viaje{PROP:Req}
        via:id_viaje = des:id_viaje
        IF Access:Viajes.TryFetch(via:PK_viajes)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            des:id_viaje = via:id_viaje
          ELSE
            SELECT(?des:id_viaje)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(0)
    OF ?CallLookupViaje
      ThisWindow.Update
      via:id_viaje = des:id_viaje
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        des:id_viaje = via:id_viaje
      END
      ThisWindow.Reset(1)
      !Asigna variables locales cuando se elige un viaje
      IF GlobalResponse = RequestCompleted
          IF via:peso = 0
             ENABLE(?l:peso)
              !enable(?via:peso)
          ELSE
              DISABLE(?l:peso)
              !DISABLE(?via:peso)
              
          END
          
          DO AsignarVariablesViaje
          ThisWindow.Reset(TRUE)
      END
    OF ?BotonSeleccionFechaDescarga
      ThisWindow.Update
      if GlobalResponse = RequestCompleted
          if self.Request = InsertRecord
              des:fecha_salida_DATE = des:fecha_descarga_DATE
          END
          
      END
      CHANGE(?des:fecha_descarga_DATE,bigfec(CONTENTS(?des:fecha_descarga_DATE)))
      !DO RefreshWindow
    OF ?BotonSeleccionFechaSalida
      ThisWindow.Update
      CHANGE(?des:fecha_salida_DATE,bigfec(CONTENTS(?des:fecha_salida_DATE)))
      !DO RefreshWindow
    OF ?des:id_localidad
      IF des:id_localidad OR ?des:id_localidad{PROP:Req}
        Loc:id_localidad = des:id_localidad
        IF Access:Localidades_GLP.TryFetch(Loc:PK_localidad)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            des:id_localidad = Loc:id_localidad
            l:id_localidad_transferencia = des:id_localidad
            GLO:localidad_id = Loc:id_localidad
          ELSE
            CLEAR(l:id_localidad_transferencia)
            CLEAR(GLO:localidad_id)
            SELECT(?des:id_localidad)
            CYCLE
          END
        ELSE
          l:id_localidad_transferencia = des:id_localidad
          GLO:localidad_id = Loc:id_localidad
        END
      END
      ThisWindow.Reset(1)
    OF ?des:id_planta
      IF des:id_planta OR ?des:id_planta{PROP:Req}
        pla:ID_PLANTA = des:id_planta
        IF Access:Plantas.TryFetch(pla:PK__plantas__7D439ABD)
          IF SELF.Run(4,SelectRecord) = RequestCompleted
            des:id_planta = pla:ID_PLANTA
          ELSE
            SELECT(?des:id_planta)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(0)
    OF ?CallLookupPlanta
      ThisWindow.Update
      pla:ID_PLANTA = des:id_planta
      IF SELF.Run(4,SelectRecord) = RequestCompleted
        des:id_planta = pla:ID_PLANTA
      END
      ThisWindow.Reset(1)
    OF ?l:id_localidad_transferencia
      IF l:id_localidad_transferencia OR ?l:id_localidad_transferencia{PROP:Req}
        Loc1:id_localidad = l:id_localidad_transferencia
        IF Access:Localidades_GLPAlias1.TryFetch(Loc1:PK_localidad)
          IF SELF.Run(5,SelectRecord) = RequestCompleted
            l:id_localidad_transferencia = Loc1:id_localidad
          ELSE
            SELECT(?l:id_localidad_transferencia)
            CYCLE
          END
        END
      END
      ThisWindow.Reset()
    OF ?CallLookupLocalidadViaje
      ThisWindow.Update
      Loc1:id_localidad = l:id_localidad_transferencia
      IF SELF.Run(5,SelectRecord) = RequestCompleted
        l:id_localidad_transferencia = Loc1:id_localidad
      END
      ThisWindow.Reset(1)
    OF ?l:id_transportista
      IF l:id_transportista OR ?l:id_transportista{PROP:Req}
        tra:id_transportista = l:id_transportista
        IF Access:Transportistas.TryFetch(tra:PK_TRANSPORTISTA)
          IF SELF.Run(6,SelectRecord) = RequestCompleted
            l:id_transportista = tra:id_transportista
            l:transportista = tra:transportista
          ELSE
            CLEAR(l:transportista)
            SELECT(?l:id_transportista)
            CYCLE
          END
        ELSE
          l:transportista = tra:transportista
        END
      END
      ThisWindow.Reset(0)
    OF ?CallLookupTrasnportista
      ThisWindow.Update
      tra:id_transportista = l:id_transportista
      IF SELF.Run(6,SelectRecord) = RequestCompleted
        l:id_transportista = tra:id_transportista
        l:transportista = tra:transportista
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
  ! Valida los datos
  
  IF Self.Request = InsertRecord OR Self.Request = ChangeRecord
      
    
      IF des:cantidad > l:peso-l:peso_descargado - l:descarga_anterior
         message('La cantidad de producto no puede ser mayor a la disponible','Atención',ICON:Exclamation)
          select(?des:cantidad)
         
          CYCLE
          
      END
  
      IF l:id_localidad_viaje = 0
          message('El viaje no posee localidad de destino.','Atención',ICON:Exclamation)
          select(?des:id_viaje)
          
          CYCLE
      END
      
  END
  
  ReturnValue = PARENT.TakeCompleted()
  !Actualizar Viajes  y programacion
  IF ReturnValue = Level:Benign
      IF self.Request = InsertRecord OR self.Request = ChangeRecord
          DO actualizarVariablesViaje
          
             IF  Access:Viajes.update() <> Level:Benign
                  MESSAGE('No se pudo actualizar la tabla viajes','Error en actualización:'&FILEERROR(),ICON:Exclamation)
              END
          
          DO actualizarVariablesProgramacion
          IF Access:programacion.Update() <> Level:Benign
              MESSAGE('No se pudo actualizar la tabla programacion','Error en actualización:'&FILEERROR(),ICON:Exclamation)
          END
          
      END
  END
  IF ReturnValue = Level:Benign
      GLO:id_descarga =des:id_descarga
  
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
    OF ?des:id_localidad
      Loc:id_localidad = des:id_localidad
      IF Access:Localidades_GLP.TryFetch(Loc:PK_localidad)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          des:id_localidad = Loc:id_localidad
          l:id_localidad_transferencia = des:id_localidad
          GLO:localidad_id = Loc:id_localidad
      ELSE
          CLEAR(l:id_localidad_transferencia)
          CLEAR(GLO:localidad_id)
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
!!! Seleccionar un registro de Transportistas
!!! </summary>
SelectTransportistas PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Transportistas)
                       PROJECT(tra:id_transportista)
                       PROJECT(tra:transportista)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
tra:id_transportista   LIKE(tra:id_transportista)     !List box control field - type derived from field
tra:transportista      LIKE(tra:transportista)        !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,235,236),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('SelectTransportistas'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(39,52,142,104),USE(?Browse:1),HVSCROLL,FORMAT('18L(2)|M~ID~C(2)@P<<<<<<P@80L(2)' & |
  '|M~Transportista~C(2)@s50@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the Transportistas file')
                       BUTTON,AT(5,188,34,34),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Seleccionar el registro'), |
  TIP('Seleccionar el registro')
                       BUTTON,AT(148,188,34,34),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       BUTTON,AT(186,188,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'),STD(STD:Help), |
  TIP('Ver ventana de ayuda')
                       STRING('Seleccione un transportista'),AT(61,14),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
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
  GlobalErrors.SetProcedureName('SelectTransportistas')
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
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectTransportistas',QuickWindow)         ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,tra:PK_TRANSPORTISTA)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Transportistas.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('SelectTransportistas',QuickWindow)      ! Save window data to non-volatile store
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
!!! Seleccionar un registro de Proveedores
!!! </summary>
SelectProveedores PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(Proveedores)
                       PROJECT(pro:id_proveedor)
                       PROJECT(pro:proveedor)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
pro:id_proveedor       LIKE(pro:id_proveedor)         !List box control field - type derived from field
pro:proveedor          LIKE(pro:proveedor)            !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,185,218),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('SelectProveedores'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(15,46,142,104),USE(?Browse:1),HVSCROLL,FORMAT('49L(2)|M~ID Proveedor~@P<<P@80L(' & |
  '2)|M~Proveedor~C(2)@s50@'),FROM(Queue:Browse:1),IMM,MSG('Selecciona un proveedor')
                       BUTTON,AT(26,167,34,30),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Seleccionar el registro'), |
  TIP('Seleccionar el registro')
                       BUTTON,AT(106,167,34,30),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'),TIP('Cerrar ventana')
                       STRING('Seleccione el proveedor'),AT(39,14),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
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
  GlobalErrors.SetProcedureName('SelectProveedores')
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
  Relate:Proveedores.Open                                  ! File Proveedores used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:Proveedores,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1.RetainRow = 0
  BRW1.AddSortOrder(,pro:PK_proveedor)                     ! Add the sort order for pro:PK_proveedor for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,pro:id_proveedor,1,BRW1)       ! Initialize the browse locator using  using key: pro:PK_proveedor , pro:id_proveedor
  BRW1.AddField(pro:id_proveedor,BRW1.Q.pro:id_proveedor)  ! Field pro:id_proveedor is a hot field or requires assignment from browse
  BRW1.AddField(pro:proveedor,BRW1.Q.pro:proveedor)        ! Field pro:proveedor is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('SelectProveedores',QuickWindow)            ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,pro:PK_proveedor)
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
    INIMgr.Update('SelectProveedores',QuickWindow)         ! Save window data to non-volatile store
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
!!! Form Viajes
!!! </summary>
UpdateViajes PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::via:Record  LIKE(via:RECORD),THREAD
QuickWindow          WINDOW,AT(,,527,349),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('UpdateViajes'),SYSTEM,WALLPAPER('fondo.jpg')
                       ENTRY(@P<<<<<<P),AT(104,46,40,10),USE(via:id_viaje),READONLY
                       ENTRY(@P<<<P),AT(104,80,17,10),USE(via:id_transportista),RIGHT(1),OVR
                       BUTTON,AT(125,78,12,12),USE(?CallLookupTransportista),ICON('Lupita.ico'),FLAT,TRN
                       ENTRY(@P####-########P),AT(104,97,63,10),USE(via:guia_transporte)
                       ENTRY(@P<<<<<P),AT(104,114,24,10),USE(via:id_proveedor),RIGHT(1),OVR,MSG('Identificador' & |
  ' interno del proveedor de producto'),TIP('Identificador interno del proveedor de producto')
                       BUTTON,AT(133,113,12,12),USE(?CallLookupProveedor),ICON('Lupita.ico'),FLAT,TRN
                       ENTRY(@P####-########P),AT(104,132,63,10),USE(via:nro_remito)
                       ENTRY(@N-20_),AT(104,149,48,10),USE(via:peso)
                       ENTRY(@d6),AT(104,166,48,10),USE(via:fecha_carga_DATE)
                       BUTTON,AT(157,159,22,20),USE(?BotonSeleccionFecha),ICON('calen.ico'),FLAT,TRN
                       ENTRY(@s50),AT(104,183,204,10),USE(via:chofer),UPR
                       ENTRY(@N-20_),AT(104,201,48,10),USE(via:peso_descargado)
                       ENTRY(@N-20_),AT(104,218,48,10),USE(via:cap_tk_camion)
                       BUTTON,AT(411,287,34,34),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar los dat' & |
  'os y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON,AT(448,287,34,34),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       PROMPT('Nro Viaje:'),AT(32,46),USE(?via:id_viaje:Prompt),TRN
                       PROMPT('Procedencia:'),AT(32,63),USE(?via:procedencia:Prompt),TRN
                       PROMPT('Transportista:'),AT(32,81),USE(?via:id_transportista:Prompt),TRN
                       PROMPT('Guia Transporte:'),AT(32,98),USE(?via:guia_transporte:Prompt),TRN
                       PROMPT('Proveedor:'),AT(32,115),USE(?via:id_proveedor:Prompt),TRN
                       PROMPT('Nro Remito:'),AT(32,132),USE(?via:nro_remito:Prompt),TRN
                       PROMPT('Peso:'),AT(32,150),USE(?via:peso:Prompt),TRN
                       PROMPT('Fecha carga:'),AT(32,167),USE(?avia:fecha_carga_DATE:Prompt),TRN
                       PROMPT('Chofer:'),AT(32,184),USE(?via:chofer:Prompt),TRN
                       PROMPT('Peso descargado:'),AT(32,201),USE(?via:peso_restante:Prompt),TRN
                       PROMPT('Cap Camión:'),AT(32,218),USE(?via:m3_tk_camion:Prompt),TRN
                       STRING('Ingreso de Viajes'),AT(228,18),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
  CHARSET:ANSI),TRN
                       STRING(@s50),AT(139,79,169,12),USE(tra:transportista),TRN
                       STRING(@s50),AT(149,113,160,12),USE(pro:proveedor),TRN
                       PROMPT('Kg'),AT(157,150),USE(?via:peso:Prompt:2),TRN
                       PROMPT('Kg'),AT(157,202),USE(?via:peso:Prompt:3),TRN
                       PROMPT('m3'),AT(157,218),USE(?via:peso:Prompt:4),TRN
                       PROMPT('Localidad:'),AT(32,236),USE(?via:id_localidad:Prompt),TRN
                       ENTRY(@P<<P),AT(104,236,17,10),USE(via:id_localidad),RIGHT(1),MSG('Localidad destino'),TIP('Localidad destino')
                       BUTTON,AT(126,234,12,12),USE(?CallLookup),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@s50),AT(139,234,160,12),USE(Loc:Localidad),TRN
                       OPTION,AT(103,252,183,23),USE(via:estado),BOXED
                         RADIO('Programado'),AT(109,260),USE(?VIA:ESTADO:RADIO1)
                         RADIO('En transito'),AT(290,260),USE(?VIA:ESTADO:RADIO2:2),HIDE
                         RADIO('En proceso'),AT(163,260),USE(?VIA:ESTADO:RADIO2)
                         RADIO('Descargado'),AT(228,260),USE(?VIA:ESTADO:RADIO4)
                       END
                       PROMPT('Estado:'),AT(32,265),USE(?via:id_localidad:Prompt:2),TRN
                       ENTRY(@P<<<P),AT(103,62,18,10),USE(via:id_procedencia),RIGHT(1)
                       BUTTON,AT(126,60,12,12),USE(?CallLookup:2),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@s50),AT(142,60,169,12),USE(pro1:procedencia),TRN
                       ENTRY(@P<<<<<<P),AT(103,287,18,10),USE(via:id_programacion),RIGHT(1)
                       PROMPT('Programación:'),AT(32,287),USE(?via:id_localidad:Prompt:3),TRN
                       BUTTON,AT(125,286,12,12),USE(?CallLookupProgramacion),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@P<<<<P),AT(157,287,28,12),USE(prog:ano),TRN
                       STRING(@P<<P),AT(208,286,17,12),USE(prog:mes),TRN
                       STRING(@P<P),AT(250,286,17,12),USE(prog:nro_semana),TRN
                       PROMPT('Año:'),AT(142,286),USE(?via:id_localidad:Prompt:4)
                       PROMPT('Mes:'),AT(189,286),USE(?via:id_localidad:Prompt:5)
                       PROMPT('Semana:'),AT(218,287),USE(?via:id_localidad:Prompt:6)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
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
  GlobalErrors.SetProcedureName('UpdateViajes')
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
  SELF.AddHistoryField(?via:id_transportista,3)
  SELF.AddHistoryField(?via:guia_transporte,4)
  SELF.AddHistoryField(?via:id_proveedor,5)
  SELF.AddHistoryField(?via:nro_remito,7)
  SELF.AddHistoryField(?via:peso,8)
  SELF.AddHistoryField(?via:fecha_carga_DATE,11)
  SELF.AddHistoryField(?via:chofer,13)
  SELF.AddHistoryField(?via:peso_descargado,14)
  SELF.AddHistoryField(?via:cap_tk_camion,16)
  SELF.AddHistoryField(?via:id_localidad,20)
  SELF.AddHistoryField(?via:estado,17)
  SELF.AddHistoryField(?via:id_procedencia,2)
  SELF.AddHistoryField(?via:id_programacion,6)
  SELF.AddUpdateFile(Access:Viajes)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
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
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel                      ! No confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(QuickWindow)                                   ! Open window
  IF Self.Request = InsertRecord
      
      via:peso_descargado{PROP:Enabled}= FALSE
  END
  
  IF Self.Request = ChangeRecord
      via:peso{PROP:ReadOnly} = TRUE
      via:peso_descargado{PROP:Enabled}= TRUE
      
      
  END
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?via:id_viaje{PROP:ReadOnly} = True
    ?via:id_transportista{PROP:ReadOnly} = True
    DISABLE(?CallLookupTransportista)
    ?via:guia_transporte{PROP:ReadOnly} = True
    ?via:id_proveedor{PROP:ReadOnly} = True
    DISABLE(?CallLookupProveedor)
    ?via:nro_remito{PROP:ReadOnly} = True
    ?via:peso{PROP:ReadOnly} = True
    ?via:fecha_carga_DATE{PROP:ReadOnly} = True
    DISABLE(?BotonSeleccionFecha)
    ?via:chofer{PROP:ReadOnly} = True
    ?via:peso_descargado{PROP:ReadOnly} = True
    ?via:cap_tk_camion{PROP:ReadOnly} = True
    ?via:id_localidad{PROP:ReadOnly} = True
    DISABLE(?CallLookup)
    ?via:id_procedencia{PROP:ReadOnly} = True
    DISABLE(?CallLookup:2)
    ?via:id_programacion{PROP:ReadOnly} = True
    DISABLE(?CallLookupProgramacion)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateViajes',QuickWindow)                 ! Restore window settings from non-volatile store
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
    INIMgr.Update('UpdateViajes',QuickWindow)              ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  pro:id_proveedor = via:id_proveedor                      ! Assign linking field value
  Access:Proveedores.Fetch(pro:PK_proveedor)
  tra:id_transportista = via:id_transportista              ! Assign linking field value
  Access:Transportistas.Fetch(tra:PK_TRANSPORTISTA)
  Loc:id_localidad = via:id_localidad                      ! Assign linking field value
  Access:Localidades_GLP.Fetch(Loc:PK_localidad)
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
      SelectTransportistas
      SelectProveedores
      SelectLocalidades_GLP
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
      glo:id_proveedor = via:id_proveedor
      glo:ano = year(via:fecha_carga_DATE)
      glo:mes = month(via:fecha_carga_DATE)
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?via:id_transportista
      IF via:id_transportista OR ?via:id_transportista{PROP:Req}
        tra:id_transportista = via:id_transportista
        IF Access:Transportistas.TryFetch(tra:PK_TRANSPORTISTA)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            via:id_transportista = tra:id_transportista
          ELSE
            SELECT(?via:id_transportista)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupTransportista
      ThisWindow.Update
      tra:id_transportista = via:id_transportista
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        via:id_transportista = tra:id_transportista
      END
      ThisWindow.Reset(1)
    OF ?via:id_proveedor
      IF via:id_proveedor OR ?via:id_proveedor{PROP:Req}
        pro:id_proveedor = via:id_proveedor
        IF Access:Proveedores.TryFetch(pro:PK_proveedor)
          IF SELF.Run(2,SelectRecord) = RequestCompleted
            via:id_proveedor = pro:id_proveedor
          ELSE
            SELECT(?via:id_proveedor)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupProveedor
      ThisWindow.Update
      pro:id_proveedor = via:id_proveedor
      IF SELF.Run(2,SelectRecord) = RequestCompleted
        via:id_proveedor = pro:id_proveedor
      END
      ThisWindow.Reset(1)
    OF ?BotonSeleccionFecha
      ThisWindow.Update
      CHANGE(?via:fecha_carga_DATE,bigfec(CONTENTS(?via:fecha_carga_DATE)))
      !DO RefreshWindow
    OF ?OK
      ThisWindow.Update
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    OF ?via:id_localidad
      IF via:id_localidad OR ?via:id_localidad{PROP:Req}
        Loc:id_localidad = via:id_localidad
        IF Access:Localidades_GLP.TryFetch(Loc:PK_localidad)
          IF SELF.Run(3,SelectRecord) = RequestCompleted
            via:id_localidad = Loc:id_localidad
          ELSE
            SELECT(?via:id_localidad)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookup
      ThisWindow.Update
      Loc:id_localidad = via:id_localidad
      IF SELF.Run(3,SelectRecord) = RequestCompleted
        via:id_localidad = Loc:id_localidad
      END
      ThisWindow.Reset(1)
    OF ?via:id_procedencia
      IF via:id_procedencia OR ?via:id_procedencia{PROP:Req}
        pro1:id_procedencia = via:id_procedencia
        IF Access:Procedencias.TryFetch(pro1:PK_PROCEDENCIA)
          IF SELF.Run(4,SelectRecord) = RequestCompleted
            via:id_procedencia = pro1:id_procedencia
          ELSE
            SELECT(?via:id_procedencia)
            CYCLE
          END
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookup:2
      ThisWindow.Update
      pro1:id_procedencia = via:id_procedencia
      IF SELF.Run(4,SelectRecord) = RequestCompleted
        via:id_procedencia = pro1:id_procedencia
      END
      ThisWindow.Reset(1)
    OF ?via:id_programacion
      IF via:id_programacion OR ?via:id_programacion{PROP:Req}
        prog:id_programacion = via:id_programacion
        IF Access:programacion.TryFetch(prog:PK_PROGRAMACION)
          IF SELF.Run(5,SelectRecord) = RequestCompleted
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
      IF SELF.Run(5,SelectRecord) = RequestCompleted
        via:id_programacion = prog:id_programacion
      END
      ThisWindow.Reset(1)
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
  OF ?via:peso
    if self.Request = InsertRecord
        via:peso_descargado = via:peso
        display(?via:peso_descargado)
        
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
!!! Form Densidades_Corregidas
!!! </summary>
UpdateDensidades_Corregidas PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::den:Record  LIKE(den:RECORD),THREAD
QuickWindow          WINDOW('Form Densidades_Corregidas'),AT(,,180,118),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,TILED,CENTER,GRAY,IMM,MDI,HLP('UpdateDensidades_Corregidas'),SYSTEM, |
  WALLPAPER('fondo.jpg')
                       SHEET,AT(4,4,172,72),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('Id factor:'),AT(8,20),USE(?den:id_factor:Prompt),TRN
                           ENTRY(@P<<<<P),AT(68,20,40,10),USE(den:id_factor)
                           PROMPT('Temperatura:'),AT(8,34),USE(?den:temperatura:Prompt),TRN
                           ENTRY(@n-14),AT(68,34,64,10),USE(den:temperatura)
                           PROMPT('Densidad:'),AT(8,48),USE(?den:densidad:Prompt),TRN
                           ENTRY(@N-24_`4),AT(68,48,104,10),USE(den:densidad)
                           PROMPT('Factor Ajuste:'),AT(8,62),USE(?den:factor_ajuste:Prompt),TRN
                           ENTRY(@N-8.`4),AT(68,62,40,10),USE(den:factor_ajuste)
                         END
                       END
                       BUTTON('&Aceptar'),AT(66,80,34,34),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar lo' & |
  's datos y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON('&Cancelar'),AT(104,80,34,34),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       BUTTON('A&yuda'),AT(142,80,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver Ventana de ayuda'), |
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
  GlobalErrors.SetProcedureName('UpdateDensidades_Corregidas')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?den:id_factor:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(den:Record,History::den:Record)
  SELF.AddHistoryField(?den:id_factor,1)
  SELF.AddHistoryField(?den:temperatura,2)
  SELF.AddHistoryField(?den:densidad,3)
  SELF.AddHistoryField(?den:factor_ajuste,4)
  SELF.AddUpdateFile(Access:Densidades_Corregidas)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Densidades_Corregidas.Open                        ! File Densidades_Corregidas used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Densidades_Corregidas
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
    ?den:id_factor{PROP:ReadOnly} = True
    ?den:temperatura{PROP:ReadOnly} = True
    ?den:densidad{PROP:ReadOnly} = True
    ?den:factor_ajuste{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateDensidades_Corregidas',QuickWindow)  ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Densidades_Corregidas.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateDensidades_Corregidas',QuickWindow) ! Save window data to non-volatile store
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
!!! Seleccionar un registro de t_tanques
!!! </summary>
Selectt_tanques PROCEDURE 

CurrentTab           STRING(80)                            !
BRW1::View:Browse    VIEW(t_tanques)
                       PROJECT(t_t:idt_tanque)
                       PROJECT(t_t:modelo)
                       PROJECT(t_t:volumen)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
t_t:idt_tanque         LIKE(t_t:idt_tanque)           !List box control field - type derived from field
t_t:modelo             LIKE(t_t:modelo)               !List box control field - type derived from field
t_t:volumen            LIKE(t_t:volumen)              !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW,AT(,,337,270),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('Selectt_tanques'),SYSTEM,WALLPAPER('fondo.jpg')
                       LIST,AT(59,60,216,104),USE(?Browse:1),HVSCROLL,FORMAT('44L(2)|M~idt tanque~@P<<<<<<<<P@' & |
  '80L(2)|M~Modelo~@s20@32D(12)|M~Volumen~C(0)@N-_15_`2@'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he t_tanques file')
                       BUTTON('&Seleccionar'),AT(12,206,34,34),USE(?Select:2),ICON('seleccionar.ICO'),FLAT,MSG('Selecciona' & |
  'r el registro'),TIP('Seleccionar el registro')
                       BUTTON('&Cerrar'),AT(241,206,34,34),USE(?Close),ICON('Cancelar.ico'),FLAT,MSG('Cerrar ventana'), |
  TIP('Cerrar ventana')
                       BUTTON('&Ayuda'),AT(279,206,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver ventana de ayuda'), |
  STD(STD:Help),TIP('Ver ventana de ayuda')
                       STRING('Seleccione Modelo del tanque'),AT(105,17),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
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
  GlobalErrors.SetProcedureName('Selectt_tanques')
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
  BRW1.AddSortOrder(,t_t:PK_t_tanques)                     ! Add the sort order for t_t:PK_t_tanques for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,t_t:idt_tanque,1,BRW1)         ! Initialize the browse locator using  using key: t_t:PK_t_tanques , t_t:idt_tanque
  BRW1.AddField(t_t:idt_tanque,BRW1.Q.t_t:idt_tanque)      ! Field t_t:idt_tanque is a hot field or requires assignment from browse
  BRW1.AddField(t_t:modelo,BRW1.Q.t_t:modelo)              ! Field t_t:modelo is a hot field or requires assignment from browse
  BRW1.AddField(t_t:volumen,BRW1.Q.t_t:volumen)            ! Field t_t:volumen is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('Selectt_tanques',QuickWindow)              ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse:1,?Browse:1,'','',BRW1::View:Browse,t_t:PK_t_tanques)
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:t_tanques.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('Selectt_tanques',QuickWindow)           ! Save window data to non-volatile store
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
!!! Form Niveles_Volumenes
!!! </summary>
UpdateNiveles_Volumenes PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::niv:Record  LIKE(niv:RECORD),THREAD
QuickWindow          WINDOW('Form Niveles_Volumenes'),AT(,,158,118),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,TILED,CENTER,GRAY,IMM,MDI,HLP('UpdateNiveles_Volumenes'),SYSTEM, |
  WALLPAPER('fondo.jpg')
                       SHEET,AT(4,4,150,72),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('Id Nivel:'),AT(8,20),USE(?niv:id_nivel:Prompt),TRN
                           ENTRY(@n-14),AT(61,20,64,10),USE(niv:id_nivel)
                           PROMPT('Tipo tanque:'),AT(8,34),USE(?niv:idt_tanque:Prompt),TRN
                           ENTRY(@P<<P),AT(61,34,40,10),USE(niv:idt_tanque),REQ
                           PROMPT('Nivel regla:'),AT(8,48),USE(?niv:nivel_regla:Prompt),TRN
                           ENTRY(@N-4.`1),AT(61,48,40,10),USE(niv:nivel_regla)
                           PROMPT('Volumen:'),AT(8,62),USE(?niv:volumen_calculado:Prompt),TRN
                           ENTRY(@N-8.`4),AT(61,62,40,10),USE(niv:volumen_calculado)
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
  GlobalErrors.SetProcedureName('UpdateNiveles_Volumenes')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?niv:id_nivel:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(niv:Record,History::niv:Record)
  SELF.AddHistoryField(?niv:id_nivel,1)
  SELF.AddHistoryField(?niv:idt_tanque,2)
  SELF.AddHistoryField(?niv:nivel_regla,3)
  SELF.AddHistoryField(?niv:volumen_calculado,4)
  SELF.AddUpdateFile(Access:Niveles_Volumenes)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Niveles_Volumenes.SetOpenRelated()
  Relate:Niveles_Volumenes.Open                            ! File Niveles_Volumenes used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Niveles_Volumenes
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
    ?niv:id_nivel{PROP:ReadOnly} = True
    ?niv:idt_tanque{PROP:ReadOnly} = True
    ?niv:nivel_regla{PROP:ReadOnly} = True
    ?niv:volumen_calculado{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateNiveles_Volumenes',QuickWindow)      ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
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
    INIMgr.Update('UpdateNiveles_Volumenes',QuickWindow)   ! Save window data to non-volatile store
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
!!! Form t_tanques
!!! </summary>
Updatet_tanques PROCEDURE 

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::t_t:Record  LIKE(t_t:RECORD),THREAD
QuickWindow          WINDOW('Form t_tanques'),AT(,,164,135),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,TILED,CENTER,GRAY,IMM,MDI,HLP('Updatet_tanques'),SYSTEM,WALLPAPER('fondo.jpg')
                       SHEET,AT(4,4,156,92),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('Id tipo tanque:'),AT(8,20),USE(?t_t:idt_tanque:Prompt),TRN
                           ENTRY(@P<<<<P),AT(72,20,40,10),USE(t_t:idt_tanque)
                           PROMPT('Modelo:'),AT(8,34),USE(?t_t:modelo:Prompt),TRN
                           ENTRY(@s20),AT(72,34,84,10),USE(t_t:modelo)
                           PROMPT('Volumen:'),AT(8,48),USE(?t_t:volumen:Prompt),TRN
                           ENTRY(@N-5.2),AT(72,48,40,10),USE(t_t:volumen)
                           PROMPT('Capacidad:'),AT(8,63),USE(?t_t:capacidad:Prompt),TRN
                           ENTRY(@N-10_),AT(72,63,60,10),USE(t_t:capacidad),DECIMAL(12)
                         END
                       END
                       BUTTON('&Aceptar'),AT(48,100,34,34),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar lo' & |
  's datos y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON('&Cancelar'),AT(86,100,34,34),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       BUTTON('A&yuda'),AT(124,100,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver Ventana de ayuda'), |
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
  GlobalErrors.SetProcedureName('Updatet_tanques')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?t_t:idt_tanque:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(t_t:Record,History::t_t:Record)
  SELF.AddHistoryField(?t_t:idt_tanque,1)
  SELF.AddHistoryField(?t_t:modelo,2)
  SELF.AddHistoryField(?t_t:volumen,3)
  SELF.AddHistoryField(?t_t:capacidad,4)
  SELF.AddUpdateFile(Access:t_tanques)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:t_tanques.SetOpenRelated()
  Relate:t_tanques.Open                                    ! File t_tanques used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:t_tanques
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
    ?t_t:idt_tanque{PROP:ReadOnly} = True
    ?t_t:modelo{PROP:ReadOnly} = True
    ?t_t:volumen{PROP:ReadOnly} = True
    ?t_t:capacidad{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('Updatet_tanques',QuickWindow)              ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
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
    INIMgr.Update('Updatet_tanques',QuickWindow)           ! Save window data to non-volatile store
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
!!! Form Tanques_plantas
!!! </summary>
UpdateTanques_plantas PROCEDURE (long pid_planta)

CurrentTab           STRING(80)                            !
ActionMessage        CSTRING(40)                           !
History::tan:Record  LIKE(tan:RECORD),THREAD
QuickWindow          WINDOW,AT(,,341,246),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),DOUBLE,CENTER, |
  GRAY,IMM,MDI,HLP('UpdateTanques_plantas'),SYSTEM,WALLPAPER('fondo.jpg')
                       BUTTON('&Aceptar'),AT(212,183,34,34),USE(?OK),ICON('Aceptar.ICO'),DEFAULT,FLAT,MSG('Aceptar lo' & |
  's datos y cerrar la ventana'),TIP('Aceptar los datos y cerrar la ventana')
                       BUTTON('&Cancelar'),AT(251,183,34,34),USE(?Cancel),ICON('Cancelar.ico'),FLAT,MSG('Cancelar operación'), |
  TIP('Cancelar operación')
                       BUTTON('A&yuda'),AT(288,183,34,34),USE(?Help),ICON('WAHELP.ICO'),FLAT,MSG('Ver Ventana de ayuda'), |
  STD(STD:Help),TIP('Ver Ventana de ayuda')
                       ENTRY(@P<<P),AT(83,94,40,10),USE(tan:nro_tanque),REQ
                       PROMPT('id tanque:'),AT(30,58),USE(?tan:id_tanque:Prompt),TRN
                       PROMPT('Planta:'),AT(30,78),USE(?tan:id_planta:Prompt),TRN
                       ENTRY(@P<<<P),AT(83,78,40,10),USE(tan:id_planta),REQ
                       ENTRY(@n-14),AT(83,58,64,10),USE(tan:id_tanque)
                       PROMPT('Nro tanque:'),AT(30,94),USE(?tan:nro_tanque:Prompt),TRN
                       PROMPT('Capacidad:'),AT(30,135),USE(?tan:cap_m3:Prompt),TRN
                       ENTRY(@N-12.2),AT(83,135,46,10),USE(tan:cap_m3),REQ
                       ENTRY(@P<<P),AT(83,113,40,10),USE(tan:idt_tanques),REQ
                       PROMPT('Tipo tanque:'),AT(30,114),USE(?tan:idt_tanques:Prompt),TRN
                       BUTTON,AT(127,113,12,12),USE(?CallLookupt_tanques),ICON('Lupita.ico'),FLAT,TRN
                       STRING(@s20),AT(143,114,83,9),USE(t_t:modelo),TRN
                       STRING('Carga de Tanques de GLP en Planta '),AT(95,14),USE(?STRING1),FONT('Arial',10,,FONT:bold+FONT:italic+FONT:underline, |
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
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('UpdateTanques_plantas')
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
  SELF.AddHistoryFile(tan:Record,History::tan:Record)
  SELF.AddHistoryField(?tan:nro_tanque,3)
  SELF.AddHistoryField(?tan:id_planta,2)
  SELF.AddHistoryField(?tan:id_tanque,1)
  SELF.AddHistoryField(?tan:cap_m3,4)
  SELF.AddHistoryField(?tan:idt_tanques,5)
  SELF.AddUpdateFile(Access:Tanques_plantas)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Tanques_plantas.Open                              ! File Tanques_plantas used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Tanques_plantas
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
  SELF.Open(QuickWindow)                                   ! Open window
  if self.Request = InsertRecord or self.Request = ChangeRecord
      tan:id_planta = pid_planta
      
  END
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?tan:nro_tanque{PROP:ReadOnly} = True
    ?tan:id_planta{PROP:ReadOnly} = True
    ?tan:id_tanque{PROP:ReadOnly} = True
    ?tan:cap_m3{PROP:ReadOnly} = True
    ?tan:idt_tanques{PROP:ReadOnly} = True
    DISABLE(?CallLookupt_tanques)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateTanques_plantas',QuickWindow)        ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Tanques_plantas.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateTanques_plantas',QuickWindow)     ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF QuickWindow{Prop:AcceptAll} THEN RETURN.
  t_t:idt_tanque = tan:idt_tanques                         ! Assign linking field value
  Access:t_tanques.Fetch(t_t:PK_t_tanques)
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
    Selectt_tanques
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
    OF ?tan:idt_tanques
      IF tan:idt_tanques OR ?tan:idt_tanques{PROP:Req}
        t_t:idt_tanque = tan:idt_tanques
        IF Access:t_tanques.TryFetch(t_t:PK_t_tanques)
          IF SELF.Run(1,SelectRecord) = RequestCompleted
            tan:idt_tanques = t_t:idt_tanque
            tan:cap_m3 = t_t:volumen
          ELSE
            CLEAR(tan:cap_m3)
            SELECT(?tan:idt_tanques)
            CYCLE
          END
        ELSE
          tan:cap_m3 = t_t:volumen
        END
      END
      ThisWindow.Reset(1)
    OF ?CallLookupt_tanques
      ThisWindow.Update
      t_t:idt_tanque = tan:idt_tanques
      IF SELF.Run(1,SelectRecord) = RequestCompleted
        tan:idt_tanques = t_t:idt_tanque
        tan:cap_m3 = t_t:volumen
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

