  MEMBER('existencias.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
existencias_BC1:DctInit    PROCEDURE
existencias_BC1:DctKill    PROCEDURE
existencias_BC1:FilesInit  PROCEDURE
  END

Hide:Access:viajes_facturas CLASS(FileManager),TYPE        ! FileManager for viajes_facturas
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:viajes_facturas CLASS(RelationManager),TYPE    ! RelationManager for viajes_facturas
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:contactos_proveedores CLASS(FileManager),TYPE  ! FileManager for contactos_proveedores
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:contactos_proveedores CLASS(RelationManager),TYPE ! RelationManager for contactos_proveedores
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:contactos_Transportista CLASS(FileManager),TYPE ! FileManager for contactos_Transportista
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:contactos_Transportista CLASS(RelationManager),TYPE ! RelationManager for contactos_Transportista
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:SQL      CLASS(FileManager),TYPE               ! FileManager for SQL
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:SQL      CLASS(RelationManager),TYPE           ! RelationManager for SQL
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:conceptos_aduana CLASS(FileManager),TYPE       ! FileManager for conceptos_aduana
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:conceptos_aduana CLASS(RelationManager),TYPE   ! RelationManager for conceptos_aduana
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Despacho_aduana CLASS(FileManager),TYPE        ! FileManager for Despacho_aduana
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Despacho_aduana CLASS(RelationManager),TYPE    ! RelationManager for Despacho_aduana
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Despachantes CLASS(FileManager),TYPE           ! FileManager for Despachantes
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Despachantes CLASS(RelationManager),TYPE       ! RelationManager for Despachantes
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Despacho_viajes CLASS(FileManager),TYPE        ! FileManager for Despacho_viajes
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Despacho_viajes CLASS(RelationManager),TYPE    ! RelationManager for Despacho_viajes
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Despacho_conceptos CLASS(FileManager),TYPE     ! FileManager for Despacho_conceptos
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Despacho_conceptos CLASS(RelationManager),TYPE ! RelationManager for Despacho_conceptos
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:comprobantes CLASS(FileManager),TYPE           ! FileManager for comprobantes
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:comprobantes CLASS(RelationManager),TYPE       ! RelationManager for comprobantes
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Proveedores_contable CLASS(FileManager),TYPE   ! FileManager for Proveedores_contable
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Proveedores_contable CLASS(RelationManager),TYPE ! RelationManager for Proveedores_contable
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Costos_GLP CLASS(FileManager),TYPE             ! FileManager for Costos_GLP
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Costos_GLP CLASS(RelationManager),TYPE         ! RelationManager for Costos_GLP
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Viajes_aux CLASS(FileManager),TYPE             ! FileManager for Viajes_aux
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Viajes_aux CLASS(RelationManager),TYPE         ! RelationManager for Viajes_aux
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:ViajesAlias1 CLASS(FileManager),TYPE           ! FileManager for ViajesAlias1
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:ViajesAlias1 CLASS(RelationManager),TYPE       ! RelationManager for ViajesAlias1
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:PlantasAlias CLASS(FileManager),TYPE           ! FileManager for PlantasAlias
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:PlantasAlias CLASS(RelationManager),TYPE       ! RelationManager for PlantasAlias
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:ExistenciasAlias1 CLASS(FileManager),TYPE      ! FileManager for ExistenciasAlias1
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:ExistenciasAlias1 CLASS(RelationManager),TYPE  ! RelationManager for ExistenciasAlias1
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Localidades_GLPAlias1 CLASS(FileManager),TYPE  ! FileManager for Localidades_GLPAlias1
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Localidades_GLPAlias1 CLASS(RelationManager),TYPE ! RelationManager for Localidades_GLPAlias1
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:conceptos_aduanaAlias CLASS(FileManager),TYPE  ! FileManager for conceptos_aduanaAlias
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:conceptos_aduanaAlias CLASS(RelationManager),TYPE ! RelationManager for conceptos_aduanaAlias
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Despacho_viajesAlias1 CLASS(FileManager),TYPE  ! FileManager for Despacho_viajesAlias1
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Despacho_viajesAlias1 CLASS(RelationManager),TYPE ! RelationManager for Despacho_viajesAlias1
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:ProveedoresAlias CLASS(FileManager),TYPE       ! FileManager for ProveedoresAlias
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:ProveedoresAlias CLASS(RelationManager),TYPE   ! RelationManager for ProveedoresAlias
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


_Hide:Access:viajes_facturas &Hide:Access:viajes_facturas,AUTO,THREAD
_Hide:Relate:viajes_facturas &Hide:Relate:viajes_facturas,AUTO,THREAD
_Hide:Access:contactos_proveedores &Hide:Access:contactos_proveedores,AUTO,THREAD
_Hide:Relate:contactos_proveedores &Hide:Relate:contactos_proveedores,AUTO,THREAD
_Hide:Access:contactos_Transportista &Hide:Access:contactos_Transportista,AUTO,THREAD
_Hide:Relate:contactos_Transportista &Hide:Relate:contactos_Transportista,AUTO,THREAD
_Hide:Access:SQL     &Hide:Access:SQL,AUTO,THREAD
_Hide:Relate:SQL     &Hide:Relate:SQL,AUTO,THREAD
_Hide:Access:conceptos_aduana &Hide:Access:conceptos_aduana,AUTO,THREAD
_Hide:Relate:conceptos_aduana &Hide:Relate:conceptos_aduana,AUTO,THREAD
_Hide:Access:Despacho_aduana &Hide:Access:Despacho_aduana,AUTO,THREAD
_Hide:Relate:Despacho_aduana &Hide:Relate:Despacho_aduana,AUTO,THREAD
_Hide:Access:Despachantes &Hide:Access:Despachantes,AUTO,THREAD
_Hide:Relate:Despachantes &Hide:Relate:Despachantes,AUTO,THREAD
_Hide:Access:Despacho_viajes &Hide:Access:Despacho_viajes,AUTO,THREAD
_Hide:Relate:Despacho_viajes &Hide:Relate:Despacho_viajes,AUTO,THREAD
_Hide:Access:Despacho_conceptos &Hide:Access:Despacho_conceptos,AUTO,THREAD
_Hide:Relate:Despacho_conceptos &Hide:Relate:Despacho_conceptos,AUTO,THREAD
_Hide:Access:comprobantes &Hide:Access:comprobantes,AUTO,THREAD
_Hide:Relate:comprobantes &Hide:Relate:comprobantes,AUTO,THREAD
_Hide:Access:Proveedores_contable &Hide:Access:Proveedores_contable,AUTO,THREAD
_Hide:Relate:Proveedores_contable &Hide:Relate:Proveedores_contable,AUTO,THREAD
_Hide:Access:Costos_GLP &Hide:Access:Costos_GLP,AUTO,THREAD
_Hide:Relate:Costos_GLP &Hide:Relate:Costos_GLP,AUTO,THREAD
_Hide:Access:Viajes_aux &Hide:Access:Viajes_aux,AUTO,THREAD
_Hide:Relate:Viajes_aux &Hide:Relate:Viajes_aux,AUTO,THREAD
_Hide:Access:ViajesAlias1 &Hide:Access:ViajesAlias1,AUTO,THREAD
_Hide:Relate:ViajesAlias1 &Hide:Relate:ViajesAlias1,AUTO,THREAD
_Hide:Access:PlantasAlias &Hide:Access:PlantasAlias,AUTO,THREAD
_Hide:Relate:PlantasAlias &Hide:Relate:PlantasAlias,AUTO,THREAD
_Hide:Access:ExistenciasAlias1 &Hide:Access:ExistenciasAlias1,AUTO,THREAD
_Hide:Relate:ExistenciasAlias1 &Hide:Relate:ExistenciasAlias1,AUTO,THREAD
_Hide:Access:Localidades_GLPAlias1 &Hide:Access:Localidades_GLPAlias1,AUTO,THREAD
_Hide:Relate:Localidades_GLPAlias1 &Hide:Relate:Localidades_GLPAlias1,AUTO,THREAD
_Hide:Access:conceptos_aduanaAlias &Hide:Access:conceptos_aduanaAlias,AUTO,THREAD
_Hide:Relate:conceptos_aduanaAlias &Hide:Relate:conceptos_aduanaAlias,AUTO,THREAD
_Hide:Access:Despacho_viajesAlias1 &Hide:Access:Despacho_viajesAlias1,AUTO,THREAD
_Hide:Relate:Despacho_viajesAlias1 &Hide:Relate:Despacho_viajesAlias1,AUTO,THREAD
_Hide:Access:ProveedoresAlias &Hide:Access:ProveedoresAlias,AUTO,THREAD
_Hide:Relate:ProveedoresAlias &Hide:Relate:ProveedoresAlias,AUTO,THREAD


existencias_BC1:DctInit PROCEDURE
  CODE
  _Hide:Access:viajes_facturas &= NEW(Hide:Access:viajes_facturas)
  _Hide:Relate:viajes_facturas &= NEW(Hide:Relate:viajes_facturas)
  _Hide:Access:contactos_proveedores &= NEW(Hide:Access:contactos_proveedores)
  _Hide:Relate:contactos_proveedores &= NEW(Hide:Relate:contactos_proveedores)
  _Hide:Access:contactos_Transportista &= NEW(Hide:Access:contactos_Transportista)
  _Hide:Relate:contactos_Transportista &= NEW(Hide:Relate:contactos_Transportista)
  _Hide:Access:SQL &= NEW(Hide:Access:SQL)
  _Hide:Relate:SQL &= NEW(Hide:Relate:SQL)
  _Hide:Access:conceptos_aduana &= NEW(Hide:Access:conceptos_aduana)
  _Hide:Relate:conceptos_aduana &= NEW(Hide:Relate:conceptos_aduana)
  _Hide:Access:Despacho_aduana &= NEW(Hide:Access:Despacho_aduana)
  _Hide:Relate:Despacho_aduana &= NEW(Hide:Relate:Despacho_aduana)
  _Hide:Access:Despachantes &= NEW(Hide:Access:Despachantes)
  _Hide:Relate:Despachantes &= NEW(Hide:Relate:Despachantes)
  _Hide:Access:Despacho_viajes &= NEW(Hide:Access:Despacho_viajes)
  _Hide:Relate:Despacho_viajes &= NEW(Hide:Relate:Despacho_viajes)
  _Hide:Access:Despacho_conceptos &= NEW(Hide:Access:Despacho_conceptos)
  _Hide:Relate:Despacho_conceptos &= NEW(Hide:Relate:Despacho_conceptos)
  _Hide:Access:comprobantes &= NEW(Hide:Access:comprobantes)
  _Hide:Relate:comprobantes &= NEW(Hide:Relate:comprobantes)
  _Hide:Access:Proveedores_contable &= NEW(Hide:Access:Proveedores_contable)
  _Hide:Relate:Proveedores_contable &= NEW(Hide:Relate:Proveedores_contable)
  _Hide:Access:Costos_GLP &= NEW(Hide:Access:Costos_GLP)
  _Hide:Relate:Costos_GLP &= NEW(Hide:Relate:Costos_GLP)
  _Hide:Access:Viajes_aux &= NEW(Hide:Access:Viajes_aux)
  _Hide:Relate:Viajes_aux &= NEW(Hide:Relate:Viajes_aux)
  _Hide:Access:ViajesAlias1 &= NEW(Hide:Access:ViajesAlias1)
  _Hide:Relate:ViajesAlias1 &= NEW(Hide:Relate:ViajesAlias1)
  _Hide:Access:PlantasAlias &= NEW(Hide:Access:PlantasAlias)
  _Hide:Relate:PlantasAlias &= NEW(Hide:Relate:PlantasAlias)
  _Hide:Access:ExistenciasAlias1 &= NEW(Hide:Access:ExistenciasAlias1)
  _Hide:Relate:ExistenciasAlias1 &= NEW(Hide:Relate:ExistenciasAlias1)
  _Hide:Access:Localidades_GLPAlias1 &= NEW(Hide:Access:Localidades_GLPAlias1)
  _Hide:Relate:Localidades_GLPAlias1 &= NEW(Hide:Relate:Localidades_GLPAlias1)
  _Hide:Access:conceptos_aduanaAlias &= NEW(Hide:Access:conceptos_aduanaAlias)
  _Hide:Relate:conceptos_aduanaAlias &= NEW(Hide:Relate:conceptos_aduanaAlias)
  _Hide:Access:Despacho_viajesAlias1 &= NEW(Hide:Access:Despacho_viajesAlias1)
  _Hide:Relate:Despacho_viajesAlias1 &= NEW(Hide:Relate:Despacho_viajesAlias1)
  _Hide:Access:ProveedoresAlias &= NEW(Hide:Access:ProveedoresAlias)
  _Hide:Relate:ProveedoresAlias &= NEW(Hide:Relate:ProveedoresAlias)
  Relate:viajes_facturas &= _Hide:Relate:viajes_facturas
  Relate:contactos_proveedores &= _Hide:Relate:contactos_proveedores
  Relate:contactos_Transportista &= _Hide:Relate:contactos_Transportista
  Relate:SQL &= _Hide:Relate:SQL
  Relate:conceptos_aduana &= _Hide:Relate:conceptos_aduana
  Relate:Despacho_aduana &= _Hide:Relate:Despacho_aduana
  Relate:Despachantes &= _Hide:Relate:Despachantes
  Relate:Despacho_viajes &= _Hide:Relate:Despacho_viajes
  Relate:Despacho_conceptos &= _Hide:Relate:Despacho_conceptos
  Relate:comprobantes &= _Hide:Relate:comprobantes
  Relate:Proveedores_contable &= _Hide:Relate:Proveedores_contable
  Relate:Costos_GLP &= _Hide:Relate:Costos_GLP
  Relate:Viajes_aux &= _Hide:Relate:Viajes_aux
  Relate:ViajesAlias1 &= _Hide:Relate:ViajesAlias1
  Relate:PlantasAlias &= _Hide:Relate:PlantasAlias
  Relate:ExistenciasAlias1 &= _Hide:Relate:ExistenciasAlias1
  Relate:Localidades_GLPAlias1 &= _Hide:Relate:Localidades_GLPAlias1
  Relate:conceptos_aduanaAlias &= _Hide:Relate:conceptos_aduanaAlias
  Relate:Despacho_viajesAlias1 &= _Hide:Relate:Despacho_viajesAlias1
  Relate:ProveedoresAlias &= _Hide:Relate:ProveedoresAlias


existencias_BC1:FilesInit PROCEDURE
  CODE
  _Hide:Relate:viajes_facturas.Init
  _Hide:Relate:contactos_proveedores.Init
  _Hide:Relate:contactos_Transportista.Init
  _Hide:Relate:SQL.Init
  _Hide:Relate:conceptos_aduana.Init
  _Hide:Relate:Despacho_aduana.Init
  _Hide:Relate:Despachantes.Init
  _Hide:Relate:Despacho_viajes.Init
  _Hide:Relate:Despacho_conceptos.Init
  _Hide:Relate:comprobantes.Init
  _Hide:Relate:Proveedores_contable.Init
  _Hide:Relate:Costos_GLP.Init
  _Hide:Relate:Viajes_aux.Init
  _Hide:Relate:ViajesAlias1.Init
  _Hide:Relate:PlantasAlias.Init
  _Hide:Relate:ExistenciasAlias1.Init
  _Hide:Relate:Localidades_GLPAlias1.Init
  _Hide:Relate:conceptos_aduanaAlias.Init
  _Hide:Relate:Despacho_viajesAlias1.Init
  _Hide:Relate:ProveedoresAlias.Init


existencias_BC1:DctKill PROCEDURE
  CODE
  _Hide:Relate:viajes_facturas.Kill
  DISPOSE(_Hide:Relate:viajes_facturas)
  _Hide:Relate:contactos_proveedores.Kill
  DISPOSE(_Hide:Relate:contactos_proveedores)
  _Hide:Relate:contactos_Transportista.Kill
  DISPOSE(_Hide:Relate:contactos_Transportista)
  _Hide:Relate:SQL.Kill
  DISPOSE(_Hide:Relate:SQL)
  _Hide:Relate:conceptos_aduana.Kill
  DISPOSE(_Hide:Relate:conceptos_aduana)
  _Hide:Relate:Despacho_aduana.Kill
  DISPOSE(_Hide:Relate:Despacho_aduana)
  _Hide:Relate:Despachantes.Kill
  DISPOSE(_Hide:Relate:Despachantes)
  _Hide:Relate:Despacho_viajes.Kill
  DISPOSE(_Hide:Relate:Despacho_viajes)
  _Hide:Relate:Despacho_conceptos.Kill
  DISPOSE(_Hide:Relate:Despacho_conceptos)
  _Hide:Relate:comprobantes.Kill
  DISPOSE(_Hide:Relate:comprobantes)
  _Hide:Relate:Proveedores_contable.Kill
  DISPOSE(_Hide:Relate:Proveedores_contable)
  _Hide:Relate:Costos_GLP.Kill
  DISPOSE(_Hide:Relate:Costos_GLP)
  _Hide:Relate:Viajes_aux.Kill
  DISPOSE(_Hide:Relate:Viajes_aux)
  _Hide:Relate:ViajesAlias1.Kill
  DISPOSE(_Hide:Relate:ViajesAlias1)
  _Hide:Relate:PlantasAlias.Kill
  DISPOSE(_Hide:Relate:PlantasAlias)
  _Hide:Relate:ExistenciasAlias1.Kill
  DISPOSE(_Hide:Relate:ExistenciasAlias1)
  _Hide:Relate:Localidades_GLPAlias1.Kill
  DISPOSE(_Hide:Relate:Localidades_GLPAlias1)
  _Hide:Relate:conceptos_aduanaAlias.Kill
  DISPOSE(_Hide:Relate:conceptos_aduanaAlias)
  _Hide:Relate:Despacho_viajesAlias1.Kill
  DISPOSE(_Hide:Relate:Despacho_viajesAlias1)
  _Hide:Relate:ProveedoresAlias.Kill
  DISPOSE(_Hide:Relate:ProveedoresAlias)


Hide:Relate:viajes_facturas.Init PROCEDURE
  CODE
  _Hide:Access:viajes_facturas.Init
  SELF.Init(Access:viajes_facturas,1)


Hide:Access:viajes_facturas.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= via2:Record
  SELF.FileNameValue = 'viajes_facturas'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= viajes_facturas
  PARENT.Init
  Access:viajes_facturas &= SELF


Hide:Access:viajes_facturas.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:viajes_facturas &= NULL                           ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:viajes_facturas.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(viajes_facturas,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(via2:PK_facturas_viajes,'via2:PK_facturas_viajes',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:viajes_facturas.Kill PROCEDURE

  CODE
  _Hide:Access:viajes_facturas.Kill                        ! Kill the file manager
  PARENT.Kill
  Relate:viajes_facturas &= NULL                           ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:viajes_facturas)                    ! destroy the file manager


Hide:Relate:contactos_proveedores.Init PROCEDURE
  CODE
  _Hide:Access:contactos_proveedores.Init
  SELF.Init(Access:contactos_proveedores,1)


Hide:Access:contactos_proveedores.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= cont:Record
  SELF.FileNameValue = 'contactos_proveedores'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= contactos_proveedores
  PARENT.Init
  Access:contactos_proveedores &= SELF


Hide:Access:contactos_proveedores.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:contactos_proveedores &= NULL                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:contactos_proveedores.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(contactos_proveedores,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(cont:PK_contacto,'contacto',1)
    SELF.AddKey(cont:FK_PROVEEDOR,'PROVEEDOR',0)
    SELF.AddKey(cont:K_NOMBRE,'NOMBRE',0)
    SELF.AddKey(cont:K_NOMBRE_CONTACTO,'cont:K_NOMBRE_CONTACTO',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:contactos_proveedores.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Proveedores)


Hide:Relate:contactos_proveedores.Kill PROCEDURE

  CODE
  _Hide:Access:contactos_proveedores.Kill                  ! Kill the file manager
  PARENT.Kill
  Relate:contactos_proveedores &= NULL                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:contactos_proveedores)              ! destroy the file manager


Hide:Relate:contactos_Transportista.Init PROCEDURE
  CODE
  _Hide:Access:contactos_Transportista.Init
  SELF.Init(Access:contactos_Transportista,1)


Hide:Access:contactos_Transportista.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= cont1:Record
  SELF.FileNameValue = 'contactos_Transportista'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= contactos_Transportista
  PARENT.Init
  Access:contactos_Transportista &= SELF


Hide:Access:contactos_Transportista.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:contactos_Transportista &= NULL                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:contactos_Transportista.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(contactos_Transportista,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(cont1:PK_contacto,'contacto',1)
    SELF.AddKey(cont1:FK_TRANSPORTISTA,'TRANSPORTISTA',0)
    SELF.AddKey(cont1:K_NOMBRE,'NOMBRE',0)
    SELF.AddKey(cont1:K_NOMBRE_CONTACTO,'cont1:K_NOMBRE_CONTACTO',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:contactos_Transportista.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Transportistas)


Hide:Relate:contactos_Transportista.Kill PROCEDURE

  CODE
  _Hide:Access:contactos_Transportista.Kill                ! Kill the file manager
  PARENT.Kill
  Relate:contactos_Transportista &= NULL                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:contactos_Transportista)            ! destroy the file manager


Hide:Relate:SQL.Init PROCEDURE
  CODE
  _Hide:Access:SQL.Init
  SELF.Init(Access:SQL,1)


Hide:Access:SQL.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= SQL:Record
  SELF.FileNameValue = 'SQL'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= SQL
  PARENT.Init
  Access:SQL &= SELF


Hide:Access:SQL.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:SQL &= NULL                                       ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:SQL.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(SQL,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:SQL.Kill PROCEDURE

  CODE
  _Hide:Access:SQL.Kill                                    ! Kill the file manager
  PARENT.Kill
  Relate:SQL &= NULL                                       ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:SQL)                                ! destroy the file manager


Hide:Relate:conceptos_aduana.Init PROCEDURE
  CODE
  _Hide:Access:conceptos_aduana.Init
  SELF.Init(Access:conceptos_aduana,1)


Hide:Access:conceptos_aduana.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Con:Record
  SELF.FileNameValue = 'conceptos_aduana'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= conceptos_aduana
  PARENT.Init
  Access:conceptos_aduana &= SELF


Hide:Access:conceptos_aduana.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:conceptos_aduana &= NULL                          ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:conceptos_aduana.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(conceptos_aduana,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Con:PK_CONCEPTO,'ID CONCEPTO',1)
    SELF.AddKey(Con:K_CONCEPTO,'CONCEPTO',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:conceptos_aduana.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Despacho_conceptos,RI:None,RI:None,Des4:FK_CONCEPTO)
  SELF.AddRelationLink(Con:id_concepto,Des4:id_concepto)


Hide:Relate:conceptos_aduana.Kill PROCEDURE

  CODE
  _Hide:Access:conceptos_aduana.Kill                       ! Kill the file manager
  PARENT.Kill
  Relate:conceptos_aduana &= NULL                          ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:conceptos_aduana)                   ! destroy the file manager


Hide:Relate:Despacho_aduana.Init PROCEDURE
  CODE
  _Hide:Access:Despacho_aduana.Init
  SELF.Init(Access:Despacho_aduana,1)


Hide:Access:Despacho_aduana.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= des1:Record
  SELF.FileNameValue = 'Despacho_aduana'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Despacho_aduana
  PARENT.Init
  Access:Despacho_aduana &= SELF


Hide:Access:Despacho_aduana.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Despacho_aduana &= NULL                           ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Despacho_aduana.PrimeFields PROCEDURE

  CODE
  des1:peso_total = 0                                      ! Assign initial field value
  des1:importe = 0                                         ! Assign initial field value
  des1:cant_viajes = 0                                     ! Assign initial field value
  des1:total = 0                                           ! Assign initial field value
  PARENT.PrimeFields


Hide:Access:Despacho_aduana.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Despacho_aduana,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(des1:FK_PROCEDENCIA,'PROCEDENCIA',0)
    SELF.AddKey(des1:PK_DESPACHO,'ID DESPACHO',1)
    SELF.AddKey(des1:FK_DESPACHANTE,'ID DESPACHANTE',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Despacho_aduana.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Despachantes)

  SELF.AddRelation(Relate:Despacho_viajes,RI:None,RI:None,Des3:FK_DESPACHO)
  SELF.AddRelationLink(des1:id_despacho,Des3:id_despacho)

  SELF.AddRelation(Relate:Despacho_conceptos,RI:None,RI:None,Des4:FK_DESPACHO)
  SELF.AddRelationLink(des1:id_despacho,Des4:id_despacho)

  SELF.AddRelation(Relate:Procedencias)


Hide:Relate:Despacho_aduana.Kill PROCEDURE

  CODE
  _Hide:Access:Despacho_aduana.Kill                        ! Kill the file manager
  PARENT.Kill
  Relate:Despacho_aduana &= NULL                           ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Despacho_aduana)                    ! destroy the file manager


Hide:Relate:Despachantes.Init PROCEDURE
  CODE
  _Hide:Access:Despachantes.Init
  SELF.Init(Access:Despachantes,1)


Hide:Access:Despachantes.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Des2:Record
  SELF.FileNameValue = 'Despachantes'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Despachantes
  PARENT.Init
  Access:Despachantes &= SELF


Hide:Access:Despachantes.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Despachantes &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Despachantes.PrimeFields PROCEDURE

  CODE
  Des2:id_despachante = 0                                  ! Assign initial field value
  PARENT.PrimeFields


Hide:Access:Despachantes.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Despachantes,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Des2:PK_DESPACHANTE,'ID DESPACHANTE',1)
    SELF.AddKey(Des2:K_DESPACHANTE,'DESPACHANTE',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Despachantes.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Despacho_aduana,RI:None,RI:None,des1:FK_DESPACHANTE)
  SELF.AddRelationLink(Des2:id_despachante,des1:id_despachante)


Hide:Relate:Despachantes.Kill PROCEDURE

  CODE
  _Hide:Access:Despachantes.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:Despachantes &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Despachantes)                       ! destroy the file manager


Hide:Relate:Despacho_viajes.Init PROCEDURE
  CODE
  _Hide:Access:Despacho_viajes.Init
  SELF.Init(Access:Despacho_viajes,1)


Hide:Access:Despacho_viajes.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Des3:Record
  SELF.FileNameValue = 'Despacho_viajes'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Despacho_viajes
  PARENT.Init
  Access:Despacho_viajes &= SELF


Hide:Access:Despacho_viajes.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Despacho_viajes &= NULL                           ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Despacho_viajes.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Despacho_viajes,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Des3:PK_DESPACHO_VIAJES,'ID DESPACHO VIAJE',0)
    SELF.AddKey(Des3:FK_VIAJE,'VIAJE',0)
    SELF.AddKey(Des3:FK_DESPACHO,'DESPACHO',0)
    SELF.AddKey(Des3:UQ_DESPACHO_VIAJE,'ID DESPACHO ID VIAJE',0)
    SELF.AddKey(Des3:UQ_DESPACHO_VIAJES_VIAJES,'DESPACHO VIAJES VIAJES',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Despacho_viajes.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Viajes)

  SELF.AddRelation(Relate:Despacho_aduana)


Hide:Relate:Despacho_viajes.Kill PROCEDURE

  CODE
  _Hide:Access:Despacho_viajes.Kill                        ! Kill the file manager
  PARENT.Kill
  Relate:Despacho_viajes &= NULL                           ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Despacho_viajes)                    ! destroy the file manager


Hide:Relate:Despacho_conceptos.Init PROCEDURE
  CODE
  _Hide:Access:Despacho_conceptos.Init
  SELF.Init(Access:Despacho_conceptos,1)


Hide:Access:Despacho_conceptos.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Des4:Record
  SELF.FileNameValue = 'Despacho_conceptos'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Despacho_conceptos
  PARENT.Init
  Access:Despacho_conceptos &= SELF


Hide:Access:Despacho_conceptos.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Despacho_conceptos &= NULL                        ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Despacho_conceptos.PrimeFields PROCEDURE

  CODE
  Des4:id_despacho_concepto = 0                            ! Assign initial field value
  PARENT.PrimeFields


Hide:Access:Despacho_conceptos.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Despacho_conceptos,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Des4:PK_DESPACHO_CONCEPTO,'ID DESPACHO CONCEPTO',1)
    SELF.AddKey(Des4:UQ_DESPACHO_CONCEPTO,'DESPACHO CONCEPTO',0)
    SELF.AddKey(Des4:UQ_DESPACHO_ADUANA,'DESPACHO ADUANA',0)
    SELF.AddKey(Des4:FK_DESPACHO,'DESPACHO',0)
    SELF.AddKey(Des4:FK_CONCEPTO,'CONCEPTO',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Despacho_conceptos.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Despacho_aduana)

  SELF.AddRelation(Relate:conceptos_aduana)

  SELF.AddRelation(Relate:conceptos_aduanaAlias)


Hide:Relate:Despacho_conceptos.Kill PROCEDURE

  CODE
  _Hide:Access:Despacho_conceptos.Kill                     ! Kill the file manager
  PARENT.Kill
  Relate:Despacho_conceptos &= NULL                        ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Despacho_conceptos)                 ! destroy the file manager


Hide:Relate:comprobantes.Init PROCEDURE
  CODE
  _Hide:Access:comprobantes.Init
  SELF.Init(Access:comprobantes,1)


Hide:Access:comprobantes.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= com:Record
  SELF.FileNameValue = 'comprobantes'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= comprobantes
  PARENT.Init
  Access:comprobantes &= SELF


Hide:Access:comprobantes.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:comprobantes &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:comprobantes.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(comprobantes,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(com:PK_COMPROBANTE,'COMPROBANTE',1)
    SELF.AddKey(com:FK_PROVEEDOR,'PROVEEDOR',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:comprobantes.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Proveedores_contable)


Hide:Relate:comprobantes.Kill PROCEDURE

  CODE
  _Hide:Access:comprobantes.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:comprobantes &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:comprobantes)                       ! destroy the file manager


Hide:Relate:Proveedores_contable.Init PROCEDURE
  CODE
  _Hide:Access:Proveedores_contable.Init
  SELF.Init(Access:Proveedores_contable,1)


Hide:Access:Proveedores_contable.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Pro3:Record
  SELF.FileNameValue = 'Proveedores_contable'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Proveedores_contable
  PARENT.Init
  Access:Proveedores_contable &= SELF


Hide:Access:Proveedores_contable.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Proveedores_contable &= NULL                      ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Proveedores_contable.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Proveedores_contable,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Pro3:PK_PROVEEDOR,'PROVEEDOR',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Proveedores_contable.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Proveedores,RI:None,RI:None,pro:FK_PROVEEDOR_CONTABLE)
  SELF.AddRelationLink(Pro3:proveedor_id,pro:id_proveedor_contable)

  SELF.AddRelation(Relate:comprobantes,RI:None,RI:None,com:FK_PROVEEDOR)
  SELF.AddRelationLink(Pro3:proveedor_id,com:proveedor_id)


Hide:Relate:Proveedores_contable.Kill PROCEDURE

  CODE
  _Hide:Access:Proveedores_contable.Kill                   ! Kill the file manager
  PARENT.Kill
  Relate:Proveedores_contable &= NULL                      ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Proveedores_contable)               ! destroy the file manager


Hide:Relate:Costos_GLP.Init PROCEDURE
  CODE
  _Hide:Access:Costos_GLP.Init
  SELF.Init(Access:Costos_GLP,1)


Hide:Access:Costos_GLP.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Cos:Record
  SELF.FileNameValue = 'Costos_GLP'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Costos_GLP
  PARENT.Init
  Access:Costos_GLP &= SELF


Hide:Access:Costos_GLP.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Costos_GLP &= NULL                                ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Costos_GLP.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Costos_GLP,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Cos:PK_COSTO,'ID COSTO',1)
    SELF.AddKey(Cos:K_FECHA_VIGENCIA,'FECHA VIGENCIA',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Costos_GLP.Kill PROCEDURE

  CODE
  _Hide:Access:Costos_GLP.Kill                             ! Kill the file manager
  PARENT.Kill
  Relate:Costos_GLP &= NULL                                ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Costos_GLP)                         ! destroy the file manager


Hide:Relate:Viajes_aux.Init PROCEDURE
  CODE
  _Hide:Access:Viajes_aux.Init
  SELF.Init(Access:Viajes_aux,1)


Hide:Access:Viajes_aux.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= via3:Record
  SELF.FileNameValue = 'Viajes_aux'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Viajes_aux
  PARENT.Init
  Access:Viajes_aux &= SELF


Hide:Access:Viajes_aux.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Viajes_aux &= NULL                                ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Viajes_aux.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Viajes_aux,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(via3:VIA_FK_PROGRAMACION,'PROGRAMACION',0)
    SELF.AddKey(via3:VIA_FK_PROCEDENCIA,'PROCEDENCIA',0)
    SELF.AddKey(via3:VIA_K_PROVEEDOR_ESTADO,'via3:VIA_K_PROVEEDOR_ESTADO',0)
    SELF.AddKey(via3:K_ano_mes,'via3:K_ano_mes',0)
    SELF.AddKey(via3:K_PROCEDENCIA,'via3:K_PROCEDENCIA',0)
    SELF.AddKey(via3:PK_viajes,'Id Viaje',0)
    SELF.AddKey(via3:K_ESTADO,'ESTADO',0)
    SELF.AddKey(via3:FK_TRANSPORTISTA,'Transportista',0)
    SELF.AddKey(via3:FK_PROVEEDOR,'Proveedor',0)
    SELF.AddKey(via3:K_REMITO,'NRO REMITO',0)
    SELF.AddKey(via3:K_PROVEEDOR_ID_VIAJE,'Proveedor',0)
    SELF.AddKey(via3:K_ID_TRANSPORTISTA_VIAJE,'transportista',0)
    SELF.AddKey(via3:FK_LOCALIDAD,'LOCALIDAD',0)
    SELF.AddKey(via3:FK_SOLICITUD,'via3:FK_SOLICITUD',0)
    SELF.AddKey(via3:FK_FACTURA,'via3:FK_FACTURA',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Viajes_aux.Kill PROCEDURE

  CODE
  _Hide:Access:Viajes_aux.Kill                             ! Kill the file manager
  PARENT.Kill
  Relate:Viajes_aux &= NULL                                ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Viajes_aux)                         ! destroy the file manager


Hide:Relate:ViajesAlias1.Init PROCEDURE
  CODE
  _Hide:Access:ViajesAlias1.Init
  SELF.Init(Access:ViajesAlias1,1)
  SELF.SetAlias(Relate:Viajes)


Hide:Access:ViajesAlias1.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= via1:Record
  SELF.AliasedFile &= Access:Viajes                        !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'ViajesAlias1'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ViajesAlias1
  PARENT.Init
  Access:ViajesAlias1 &= SELF


Hide:Access:ViajesAlias1.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ViajesAlias1 &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ViajesAlias1.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ViajesAlias1,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(via1:VIA_FK_PROGRAMACION,'PROGRAMACION',0)
    SELF.AddKey(via1:VIA_FK_PROCEDENCIA,'PROCEDENCIA',0)
    SELF.AddKey(via1:VIA_K_PROVEEDOR_ESTADO,'via1:VIA_K_PROVEEDOR_ESTADO',0)
    SELF.AddKey(via1:K_ano_mes,'via1:K_ano_mes',0)
    SELF.AddKey(via1:K_PROCEDENCIA,'via1:K_PROCEDENCIA',0)
    SELF.AddKey(via1:PK_viajes,'Id Viaje',1)
    SELF.AddKey(via1:K_ESTADO,'ESTADO',0)
    SELF.AddKey(via1:FK_TRANSPORTISTA,'Transportista',0)
    SELF.AddKey(via1:FK_PROVEEDOR,'Proveedor',0)
    SELF.AddKey(via1:K_REMITO,'NRO REMITO',0)
    SELF.AddKey(via1:K_PROVEEDOR_ID_VIAJE,'Proveedor',0)
    SELF.AddKey(via1:K_ID_TRANSPORTISTA_VIAJE,'transportista',0)
    SELF.AddKey(via1:FK_LOCALIDAD,'LOCALIDAD',0)
    SELF.AddKey(via1:FK_SOLICITUD,'via1:FK_SOLICITUD',0)
    SELF.AddKey(via1:FK_FACTURA,'via1:FK_FACTURA',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:ViajesAlias1.Kill PROCEDURE

  CODE
  _Hide:Access:ViajesAlias1.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:ViajesAlias1 &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ViajesAlias1)                       ! destroy the file manager


Hide:Relate:PlantasAlias.Init PROCEDURE
  CODE
  _Hide:Access:PlantasAlias.Init
  SELF.Init(Access:PlantasAlias,1)
  SELF.SetAlias(Relate:Plantas)


Hide:Access:PlantasAlias.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= pla1:Record
  SELF.AliasedFile &= Access:Plantas                       !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'PlantasAlias'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= PlantasAlias
  PARENT.Init
  Access:PlantasAlias &= SELF


Hide:Access:PlantasAlias.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:PlantasAlias &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:PlantasAlias.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(PlantasAlias,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(pla1:PK__plantas__7D439ABD,'Id Planta',1)
    SELF.AddKey(pla1:PLA_PLA_FK_LOCALIDAD,'Localidad',0)
    SELF.AddKey(pla1:K_LOCALIDAD_PLANTA,'Localidad',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:PlantasAlias.Kill PROCEDURE

  CODE
  _Hide:Access:PlantasAlias.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:PlantasAlias &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:PlantasAlias)                       ! destroy the file manager


Hide:Relate:ExistenciasAlias1.Init PROCEDURE
  CODE
  _Hide:Access:ExistenciasAlias1.Init
  SELF.Init(Access:ExistenciasAlias1,1)
  SELF.SetAlias(Relate:Existencias)


Hide:Access:ExistenciasAlias1.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= exi1:Record
  SELF.AliasedFile &= Access:Existencias                   !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'ExistenciasAlias1'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ExistenciasAlias1
  PARENT.Init
  Access:ExistenciasAlias1 &= SELF


Hide:Access:ExistenciasAlias1.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ExistenciasAlias1 &= NULL                         ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ExistenciasAlias1.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ExistenciasAlias1,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(exi1:KEY__WA_Sys_ID_STOCK_32AB8735,'STOCK',0)
    SELF.AddKey(exi1:FK_EXISTENCIA_ANTERIOR,'exi1:FK_EXISTENCIA_ANTERIOR',0)
    SELF.AddKey(exi1:PK__EXISTENC__36B12243,'Id',1)
    SELF.AddKey(exi1:EXI_K_PLANTA_Y_ID_EXISTENCIA,'Planta',0)
    SELF.AddKey(exi1:EXI_FK_PLANTA,'Planta',0)
    SELF.AddKey(exi1:FK_LOCALIDAD,'LOCALIDAD',0)
    SELF.AddKey(exi1:K_LOCALIDAD_EXISTENCIAS,'exi1:K_LOCALIDAD_EXISTENCIAS',0)
    SELF.AddKey(exi1:K_LOCALIDAD_PLANTA_EXISTENCIA,'exi1:K_LOCALIDAD_PLANTA_EXISTENCIA',0)
    SELF.AddKey(exi1:EXI_EXI_FK_PLANTA,'exi1:EXI_EXI_FK_PLANTA',0)
    SELF.AddKey(exi1:KEY__WA_Sys_id_localidad_32AB8735,'exi1:KEY__WA_Sys_id_localidad_32AB8735',0)
    SELF.AddKey(exi1:KEY__WA_Sys_EXISTENCIA_32AB8735,'exi1:KEY__WA_Sys_EXISTENCIA_32AB8735',0)
    SELF.AddKey(exi1:KEY__WA_Sys_EXISTENCIA_ANTERIOR_32AB8735,'exi1:KEY__WA_Sys_EXISTENCIA_ANTERIOR_32AB8735',0)
    SELF.AddKey(exi1:KEY__WA_Sys_PORC_EXISTENCIA_32AB8735,'exi1:KEY__WA_Sys_PORC_EXISTENCIA_32AB8735',0)
    SELF.AddKey(exi1:KEY__WA_Sys_CONSUMO_32AB8735,'exi1:KEY__WA_Sys_CONSUMO_32AB8735',0)
    SELF.AddKey(exi1:KEY__WA_Sys_CAPACIDAD_PLANTA_32AB8735,'exi1:KEY__WA_Sys_CAPACIDAD_PLANTA_32AB8735',0)
    SELF.AddKey(exi1:KEY__WA_Sys_FECHA_LECTURA_32AB8735,'exi1:KEY__WA_Sys_FECHA_LECTURA_32AB8735',0)
    SELF.AddKey(exi1:KEY__WA_Sys_AUTONOMIA_32AB8735,'exi1:KEY__WA_Sys_AUTONOMIA_32AB8735',0)
    SELF.AddKey(exi1:KEY__WA_Sys_ultima_descarga_32AB8735,'exi1:KEY__WA_Sys_ultima_descarga_32AB8735',0)
    SELF.AddKey(exi1:K_FECHA_LOCALIDAD_PLANTA,'exi1:K_FECHA_LOCALIDAD_PLANTA',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:ExistenciasAlias1.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Localidades_GLP)

  SELF.AddRelation(Relate:Plantas)

  SELF.AddRelation(Relate:Existencias,RI:None,RI:None,exi:FK_EXISTENCIA_ANTERIOR)
  SELF.AddRelationLink(exi1:id_existencia,exi:id_existencia_anterior)


Hide:Relate:ExistenciasAlias1.Kill PROCEDURE

  CODE
  _Hide:Access:ExistenciasAlias1.Kill                      ! Kill the file manager
  PARENT.Kill
  Relate:ExistenciasAlias1 &= NULL                         ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ExistenciasAlias1)                  ! destroy the file manager


Hide:Relate:Localidades_GLPAlias1.Init PROCEDURE
  CODE
  _Hide:Access:Localidades_GLPAlias1.Init
  SELF.Init(Access:Localidades_GLPAlias1,1)
  SELF.SetAlias(Relate:Localidades_GLP)


Hide:Access:Localidades_GLPAlias1.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Loc1:Record
  SELF.AliasedFile &= Access:Localidades_GLP               !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'Localidades_GLPAlias1'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Localidades_GLPAlias1
  PARENT.Init
  Access:Localidades_GLPAlias1 &= SELF


Hide:Access:Localidades_GLPAlias1.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Localidades_GLPAlias1 &= NULL                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Localidades_GLPAlias1.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Localidades_GLPAlias1,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Loc1:PK_localidad,'ID localidad',0)
    SELF.AddKey(Loc1:K_localidad,'Localidad',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Localidades_GLPAlias1.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Viajes,RI:None,RI:None,via:FK_LOCALIDAD)
  SELF.AddRelationLink(Loc1:id_localidad,via:id_localidad)


Hide:Relate:Localidades_GLPAlias1.Kill PROCEDURE

  CODE
  _Hide:Access:Localidades_GLPAlias1.Kill                  ! Kill the file manager
  PARENT.Kill
  Relate:Localidades_GLPAlias1 &= NULL                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Localidades_GLPAlias1)              ! destroy the file manager


Hide:Relate:conceptos_aduanaAlias.Init PROCEDURE
  CODE
  _Hide:Access:conceptos_aduanaAlias.Init
  SELF.Init(Access:conceptos_aduanaAlias,1)
  SELF.SetAlias(Relate:conceptos_aduana)


Hide:Access:conceptos_aduanaAlias.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Con1:Record
  SELF.AliasedFile &= Access:conceptos_aduana              !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'conceptos_aduanaAlias'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= conceptos_aduanaAlias
  PARENT.Init
  Access:conceptos_aduanaAlias &= SELF


Hide:Access:conceptos_aduanaAlias.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:conceptos_aduanaAlias &= NULL                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:conceptos_aduanaAlias.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(conceptos_aduanaAlias,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Con1:PK_CONCEPTO,'ID CONCEPTO',1)
    SELF.AddKey(Con1:K_CONCEPTO,'CONCEPTO',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:conceptos_aduanaAlias.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Despacho_conceptos,RI:None,RI:None,Des4:FK_CONCEPTO)
  SELF.AddRelationLink(Con1:id_concepto,Des4:id_concepto)


Hide:Relate:conceptos_aduanaAlias.Kill PROCEDURE

  CODE
  _Hide:Access:conceptos_aduanaAlias.Kill                  ! Kill the file manager
  PARENT.Kill
  Relate:conceptos_aduanaAlias &= NULL                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:conceptos_aduanaAlias)              ! destroy the file manager


Hide:Relate:Despacho_viajesAlias1.Init PROCEDURE
  CODE
  _Hide:Access:Despacho_viajesAlias1.Init
  SELF.Init(Access:Despacho_viajesAlias1,1)
  SELF.SetAlias(Relate:Despacho_viajes)


Hide:Access:Despacho_viajesAlias1.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Des31:Record
  SELF.AliasedFile &= Access:Despacho_viajes               !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'Despacho_viajesAlias1'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Despacho_viajesAlias1
  PARENT.Init
  Access:Despacho_viajesAlias1 &= SELF


Hide:Access:Despacho_viajesAlias1.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Despacho_viajesAlias1 &= NULL                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Despacho_viajesAlias1.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Despacho_viajesAlias1,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Des31:PK_DESPACHO_VIAJES,'ID DESPACHO VIAJE',0)
    SELF.AddKey(Des31:FK_VIAJE,'VIAJE',0)
    SELF.AddKey(Des31:FK_DESPACHO,'DESPACHO',0)
    SELF.AddKey(Des31:UQ_DESPACHO_VIAJE,'ID DESPACHO ID VIAJE',0)
    SELF.AddKey(Des31:UQ_DESPACHO_VIAJES_VIAJES,'DESPACHO VIAJES VIAJES',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Despacho_viajesAlias1.Kill PROCEDURE

  CODE
  _Hide:Access:Despacho_viajesAlias1.Kill                  ! Kill the file manager
  PARENT.Kill
  Relate:Despacho_viajesAlias1 &= NULL                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Despacho_viajesAlias1)              ! destroy the file manager


Hide:Relate:ProveedoresAlias.Init PROCEDURE
  CODE
  _Hide:Access:ProveedoresAlias.Init
  SELF.Init(Access:ProveedoresAlias,1)
  SELF.SetAlias(Relate:Proveedores)


Hide:Access:ProveedoresAlias.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= pro2:Record
  SELF.AliasedFile &= Access:Proveedores                   !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'ProveedoresAlias'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ProveedoresAlias
  PARENT.Init
  Access:ProveedoresAlias &= SELF


Hide:Access:ProveedoresAlias.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ProveedoresAlias &= NULL                          ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ProveedoresAlias.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ProveedoresAlias,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(pro2:PK_proveedor,'Id Proveedor',1)
    SELF.AddKey(pro2:FK_PROVEEDOR_CONTABLE,'PROVEEDOR CONTABLE',0)
    SELF.AddKey(pro2:K_proveedor,'Proveedor',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:ProveedoresAlias.Kill PROCEDURE

  CODE
  _Hide:Access:ProveedoresAlias.Kill                       ! Kill the file manager
  PARENT.Kill
  Relate:ProveedoresAlias &= NULL                          ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ProveedoresAlias)                   ! destroy the file manager

