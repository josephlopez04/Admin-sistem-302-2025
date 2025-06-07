PS C:\WINDOWS\system32> [int]$Variable=100

PS C:\WINDOWS\system32> [int]$Variable="holo"
No se puede convertir el valor "holo" al tipo "System.Int32". Error: "La cadena de entrada no tiene el 
formato correcto."
En línea: 1 Carácter: 1
+ [int]$Variable="holo"
+ ~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : MetadataError: (:) [], ArgumentTransformationMetadataException
    + FullyQualifiedErrorId : RuntimeException
 
PS C:\WINDOWS\system32> $Variable.GetType()

IsPublic IsSerial Name                                     BaseType                                          
-------- -------- ----                                     --------                                          
True     True     Int32                                    System.ValueType 