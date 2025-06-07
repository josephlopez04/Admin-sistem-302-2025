PS C:\Users\Jose Manuel> cat .\condicionales.ps1
$condicion = $true
if ( $condicion )
{
   Write-Output "La condicion era verdadera"
}
else
{
   Write-Output "La condiciones era falsa"
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\condicionales.ps1' because it does not exist.
La condicion era verdadera

PS C:\Users\Jose Manuel> cat .\condicionales2.ps1
$numero = 2
if ($numero -ge 3)
{
     Write-Output "El número [$numero] es mayor o igual que 3"
}
elseif ($numero -lt 2)
{  # Corregido el operador de comparación
     Write-Output "El número [$numero] es menor que 2"
}
else
{
    Write-Output "El número [$numero] es igual a 2"
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\condicionales2.ps1' because it does not exist.
El número [2] es igual a 2

PS C:\WINDOWS\system32> $PSVersionTable

Name                           Value                                                                         
----                           -----                                                                         
PSVersion                      5.1.19041.5369                                                                
PSEdition                      Desktop                                                                       
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}                                                       
BuildVersion                   10.0.19041.5369                                                               
CLRVersion                     4.0.30319.42000                                                               
WSManStackVersion              3.0                                                                           
PSRemotingProtocolVersion      2.3                                                                           
SerializationVersion           1.1.0.1  

PS C:\Users\Jose Manuel> $mensaje = (Test-Path $path) ? "Path existe" : "Path no encontrado"
Test-Path: Value cannot be null. (Parameter 'The provided Path argument was null or an empty collection.')
PS C:\Users\Jose Manuel> $mensaje
Path no encontrado

PS C:\WINDOWS\system32>         tmp> cat .\condicionales.ps1
tmp> : El término 'tmp>' no se reconoce como nombre de un cmdlet, función, archivo de script o programa 
ejecutable. Compruebe si escribió correctamente el nombre o, si incluyó una ruta de acceso, compruebe que 
dicha ruta es correcta e inténtelo de nuevo.
En línea: 1 Carácter: 9
+         tmp> cat .\condicionales.ps1
+         ~~~~
    + CategoryInfo          : ObjectNotFound: (tmp>:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException

PS C:\Users\Jose Manuel> $mensaje = (Test-Path $path) ? "Path existe" : "Path no encontrado"
Test-Path: Value cannot be null. (Parameter 'The provided Path argument was null or an empty collection.')
PS C:\Users\Jose Manuel> $mensaje
Path no encontrado



PS C:\Users\Jose Manuel> cat .\switch1.ps1
switch (3)
{
   1{"[$_] es uno."}
   2{"[$_] es dos."}
   3{"[$_] es tres."}
   4{"[$_] es cuatro."}
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\switch1.ps1' because it does not exist.
[3] es tres.

PS C:\Users\Jose Manuel> cat .\switch2.ps1
switch (3)
{
   1{"[$_] es uno."}
   2{"[$_] es dos."}
   3{"[$_] es tres."}
   4{"[$_] es cuatro."}
   3{"[$_] es tres de nuevo."}
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\switch2.ps1' because it does not exist.
[3] es tres.
[3] es tres de nuevo.

PS C:\Users\Jose Manuel> cat .\switch3.ps1
switch (3)
{
   1{"[$_] es uno."}
   2{"[$_] es dos."}
   3{"[$_] es tres."; Break}
   4{"[$_] es cuatro."}
   3{"[$_] es tres de nuevo."}
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\switch3.ps1' because it does not exist.
[3] es tres.

PS C:\Users\Jose Manuel> cat .\switch4.ps1
switch (1, 5)
{
   1{"[$_] es uno."}
   2{"[$_] es dos."}
   3{"[$_] es tres."}
   4{"[$_] es cuatro."}
   5{"[$_] es cinco."}
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\switch4.ps1' because it does not exist.
[1] es uno.
[5] es cinco.

PS C:\Users\Jose Manuel> cat .\switch5.ps1
switch ("seis")
{
   1{"[$_] es uno."; Break}
   2{"[$_] es dos."; Break}
   3{"[$_] es tres."; Break}
   4{"[$_] es cuatro."; Break}
   5{"[$_] es cinco."; Break}
   Default {
           "No hay coincidencias con [$_]"
           }
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\switch5.ps1' because it does not exist.
No hay coincidencias con [seis]

PS C:\Users\Jose Manuel> cat .\switch6.ps1
switch -Wildcard  ("seis")
{
   1{"[$_] es uno."; Break}
   2{"[$_] es dos."; Break}
   3{"[$_] es tres."; Break}
   4{"[$_] es cuatro."; Break}
   5{"[$_] es cinco."; Break}
   "se*" {"[$_] coincide con [se*]"}
   Default {
           "No hay coincidencias con [$_]"
           }
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\switch6.ps1' because it does not exist.
[seis] coincide con [se*]

PS C:\Users\Jose Manuel> cat .\switch7.ps1
$email = 'antonio.yanez@udc.es'
$email2 = 'antonio.yanez@usc.gal'
$url = 'https://www.dc.fi.udc.es/~afyanez/Docencia/2023'
switch -Regex ($url, $email, $email2)
{
    '^\w+\.\w+@(udc|usc|edu)\.es|gal$' { "[$_] es una direccion de correo electronico academia" }
    '^ftp\://.*$' { "[$_] es una direccion ftp" }
    '^(http[s]?)\://.*$' { "[$_] es una direccion web, que utiliza [$($matches[1])]" }'
Get-Content: Cannot find path 'C:\Users\Jose Manuel\switch7.ps1' because it does not exist.
[https://www.dc.fi.udc.es/~afyanez/Docencia/2023] es una direccion web, que utiliza [https]
[antonio.yanez@udc.es] es una direccion de correo electronico academia
[antonio.yanez@usc.gal] es una direccion de correo electronico academia