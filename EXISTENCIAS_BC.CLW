  MEMBER('existencias.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('existencias_BC0.CLW')
existencias_BC0:DctInit             PROCEDURE
existencias_BC0:DctKill             PROCEDURE
existencias_BC0:FilesInit           PROCEDURE
    END
    MODULE('existencias_BC1.CLW')
existencias_BC1:DctInit             PROCEDURE
existencias_BC1:DctKill             PROCEDURE
existencias_BC1:FilesInit           PROCEDURE
    END
    MODULE('existencias_BC2.CLW')
existencias_BC2:DctInit             PROCEDURE
existencias_BC2:DctKill             PROCEDURE
existencias_BC2:FilesInit           PROCEDURE
    END
  END

DctInit PROCEDURE
  CODE
  existencias_BC0:DctInit
  existencias_BC1:DctInit
  existencias_BC2:DctInit
  existencias_BC0:FilesInit
  existencias_BC1:FilesInit
  existencias_BC2:FilesInit


DctKill PROCEDURE
  CODE
  existencias_BC0:DctKill
  existencias_BC1:DctKill
  existencias_BC2:DctKill

