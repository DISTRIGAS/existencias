  MEMBER('existencias.clw')

  INCLUDE('ABTblSyn.INC'),ONCE


CachedManager:Viajes_aux CLASS(FileSynchronizationClass),TYPE ! CachedManager for Viajes_aux
Init                   PROCEDURE(FILE pTargetFile,FILE pOriginalFile),DERIVED
PrimeRecord            PROCEDURE(),DERIVED
PrimeSaveRecord        PROCEDURE(),DERIVED
                     END


CachedManager:Viajes_aux.Init PROCEDURE(FILE pTargetFile,FILE pOriginalFile)

  CODE
  PARENT.Init(pTargetFile,pOriginalFile)
  SELF.OptimizeSave = True
  SELF.BackupOnSave = False


CachedManager:Viajes_aux.PrimeRecord PROCEDURE

  CODE
  PARENT.PrimeRecord
  CLEAR(Viajes_aux.Record)


CachedManager:Viajes_aux.PrimeSaveRecord PROCEDURE

  CODE
  PARENT.PrimeSaveRecord
  CLEAR(Viajes.Record)


MemDriverInit     PROCEDURE                                ! Initializes the MemDriver definition module
 CODE
    IF THREAD()=1
    END
    MemAccess:Viajes_aux &= NEW CachedManager:Viajes_aux
    MemAccess:Viajes_aux.Init(Viajes_aux,Viajes)
    MemAccess:Viajes_aux.SetOrderKey(via:FK_PROVEEDOR)
    MemAccess:Viajes_aux.SetRange(via:id_proveedor,GLO:lowLimit,GLO:highLimit)

MemDriverKill     PROCEDURE                                ! Kills the MemDriver definition module
 CODE
    IF THREAD()=1
    END
    IF NOT MemAccess:Viajes_aux &= NULL
       MemAccess:Viajes_aux.Kill()
       DISPOSE(MemAccess:Viajes_aux)
    END
