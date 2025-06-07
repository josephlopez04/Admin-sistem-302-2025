PS C:\Users\Jose Manuel> cat .\for1.ps1
for (($i = 0), ($j = 0); $i -lt 5; $i++)
{
    "`$i:$i"
    "`$j:$j"
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\for1.ps1' because it does not exist.
$i:0
$j:0
$i:1
$j:0
$i:2
$j:0
$i:3
$j:0
$i:4
$j:0

PS C:\Users\Jose Manuel> cat .\for2.ps1
for ($($i = 0;$j = 0); $i -lt 5; $($i++;$j++))
{
    "`$i:$i"
    "`$j:$j"
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\for2.ps1' because it does not exist.
$i:0
$j:0
$i:1
$j:1
$i:2
$j:2
$i:3
$j:3
$i:4
$j:4

PS C:\Users\Jose Manuel> cat .\foreach1.ps1
>> $ssoo = "freebsd", "openbsd", "solaris", "fedora", "ubuntu", "netbsd"
>> foreach ($so in $ssoo)
>> {
>>   Write-Host $so
>> }
Get-Content: Cannot find path 'C:\Users\Jose Manuel\foreach1.ps1' because it does not exist.
freebsd
openbsd
solaris
fedora
ubuntu
netbsd

cat .\foreach2.ps1
foreach ($archivo in Get-ChildItem)
 {
   if ($archivo.Length -ge 10KB)
   {
     Write-Host $archivo -> [($archivo.Length)]
   }
 }

 PS C:\Users\Jose Manuel> cat .\while.ps1
$num = 0

while ($num -ne 3)
{
  $num++
  Write-Host $num
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\while.ps1' because it does not exist.
1
2
3

PS C:\Users\Jose Manuel> cat .\while2.ps1
$num = 0

while ($num -ne 5)
{
   if ($num -eq 1) { $num = $num + 3 ; Continue }
   $num++
   Write-Host $num
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\while2.ps1' because it does not exist.
1
5

PS C:\Users\Jose Manuel> cat .\do-while.ps1
$valor = 5
$multiplicacion = 1
do
{
   $multiplicacion = $multiplicacion * $valor
   $valor--
}
while ($valor -gt 0)

Write-Host $multiplicacion
Get-Content: Cannot find path 'C:\Users\Jose Manuel\do-while.ps1' because it does not exist.
120

PS C:\Users\Jose Manuel> cat .\do-until.ps1
$valor = 5
$multiplicacion = 1
do
{
  $multiplicacion = $multiplicacion * $valor
  $valor--
}
until ($valor -eq 0)

Write-Host $multiplicacion
Get-Content: Cannot find path 'C:\Users\Jose Manuel\do-until.ps1' because it does not exist.
120

PS C:\Users\Jose Manuel> cat .\break.ps1
$num = 10
for($i = 2; $i -lt 10; $i++)
{
   $num = $num+$i
   if ($i -eq 5) { Break }
}
Write-Host $num
Write-Host $i
Get-Content: Cannot find path 'C:\Users\Jose Manuel\break.ps1' because it does not exist.
24
5

PS C:\Users\Jose Manuel> cat .break2.ps1
$cadena = "Hola, buenas tardes"
$cadena2= "Hola, buenas noches"

switch -Wildcard ($cadena, $cadena2)
{
  "Hola, buenas*" {"[$_] coincide con [Hola, buenas*]"}
  "Hola, bue*" {"[$_] coincide con [Hola, bue*]"}
  "Hola," {"[$_] coincide con [Hola,]"; Break }
  "Hola, buenas tardes" {"[$_] coincide con [Hola, buenas tardes]"}
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\.Ibreak2.ps1' because it does not exist.
[Hola, buenas tardes] coincide con [Hola, buenas*]
[Hola, buenas tardes] coincide con [Hola, bue*]
[Hola, buenas tardes] coincide con [Hola, buenas tardes]
[Hola, buenas noches] coincide con [Hola, buenas*]
[Hola, buenas noches] coincide con [Hola, bue*]

PS C:\Users\Jose Manuel> cat .\continue1.ps1
$num = 10

for($i = 2; $i -lt 10; $i++)
{
  if ($i -eq 5) { Continue }
  $num = $num+$i
}

Write-Host $num
Write-Host $i
Get-Content: Cannot find path 'C:\Users\Jose Manuel\continue1.ps1' because it does not exist.
49
10

PS C:\Users\Jose Manuel> cat .continue2.ps1
$cadena = "Hola, buenas tardes"
$cadena2= "Hola, buenas noches"

switch -Wildcard ($cadena, $cadena2)
{
   "Hola, buenas*" {"[$_] coincide con [Hola, buenas*]"}
   "Hola, bue*" {"[$_] coincide con [Hola, bue*]"; Continue}
   "Hola," {"[$_] coincide con [Hola,]"}
   "Hola, buenas tardes" {"[$_] coincide con [Hola, buenas tardes]"}
}
Get-Content: Cannot find path 'C:\Users\Jose Manuel\.continue2.ps1' because it does not exist.
[Hola, buenas tardes] coincide con [Hola, buenas*]
[Hola, buenas tardes] coincide con [Hola, bue*]
[Hola, buenas noches] coincide con [Hola, buenas*]
[Hola, buenas noches] coincide con [Hola, bue*]