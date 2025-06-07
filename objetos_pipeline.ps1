Name                      MemberType    Definition
----                      ----------    ----------
Name                      AliasProperty Name = ServiceName
RequiredServices          AliasProperty RequiredServices = ServicesDependedOn
Disposed                  Event         System.EventHandler Disposed(System.Object, System.EventArgs)
Close                     Method        void Close()
Continue                  Method        void Continue()
Dispose                   Method        void Dispose(), void IDisposable.Dispose()
Equals                    Method        bool Equals(System.Object obj)
ExecuteCommand            Method        void ExecuteCommand(int command)
GetHashCode               Method        int GetHashCode()
GetLifetimeService        Method        System.Object GetLifetimeService()
GetType                   Method        type GetType()
InitializeLifetimeService Method        System.Object InitializeLifetimeService()
Pause                     Method        void Pause()
Refresh                   Method        void Refresh()
Start                     Method        void Start(), void Start(string[] args)
Stop                      Method        void Stop(), void Stop(bool stopDependentServices)
WaitForStatus             Method        void WaitForStatus(System.ServiceProcess.ServiceControllerStatus desiredStatus…
BinaryPathName            Property      System.String {get;set;}
CanPauseAndContinue       Property      bool CanPauseAndContinue {get;}
CanShutdown               Property      bool CanShutdown {get;}
CanStop                   Property      bool CanStop {get;}
Container                 Property      System.ComponentModel.IContainer Container {get;}
DelayedAutoStart          Property      System.Boolean {get;set;}
DependentServices         Property      System.ServiceProcess.ServiceController[] DependentServices {get;}
Description               Property      System.String {get;set;}
DisplayName               Property      string DisplayName {get;set;}
MachineName               Property      string MachineName {get;set;}
ServiceHandle             Property      System.Runtime.InteropServices.SafeHandle ServiceHandle {get;}
ServiceName               Property      string ServiceName {get;set;}
ServicesDependedOn        Property      System.ServiceProcess.ServiceController[] ServicesDependedOn {get;}
ServiceType               Property      System.ServiceProcess.ServiceType ServiceType {get;}
Site                      Property      System.ComponentModel.ISite Site {get;set;}
StartType                 Property      System.ServiceProcess.ServiceStartMode StartType {get;}
StartupType               Property      Microsoft.PowerShell.Commands.ServiceStartupType {get;set;}
Status                    Property      System.ServiceProcess.ServiceControllerStatus Status {get;}
UserName                  Property      System.String {get;set;}
ToString                  ScriptMethod  System.Object ToString();

PS C:\Windows\System32> Get-Service -Name "LSM" | Get-Member -MemberType Property

   TypeName: System.Service.ServiceController#StartupType

Name                MemberType Definition
----                ---------- ----------
BinaryPathName      Property   System.String {get;set;}
CanPauseAndContinue Property   bool CanPauseAndContinue {get;}
CanShutdown         Property   bool CanShutdown {get;}
CanStop             Property   bool CanStop {get;}
Container           Property   System.ComponentModel.IContainer Container {get;}
DelayedAutoStart    Property   System.Boolean {get;set;}
DependentServices   Property   System.ServiceProcess.ServiceController[] DependentServices {get;}
Description         Property   System.String {get;set;}
DisplayName         Property   string DisplayName {get;set;}
MachineName         Property   string MachineName {get;set;}
ServiceHandle       Property   System.Runtime.InteropServices.SafeHandle ServiceHandle {get;}
ServiceName         Property   string ServiceName {get;set;}
ServicesDependedOn  Property   System.ServiceProcess.ServiceController[] ServicesDependedOn {get;}
ServiceType         Property   System.ServiceProcess.ServiceType ServiceType {get;}
Site                Property   System.ComponentModel.ISite Site {get;set;}
StartType           Property   System.ServiceProcess.ServiceStartMode StartType {get;}
StartupType         Property   Microsoft.PowerShell.Commands.ServiceStartupType {get;set;}
Status              Property   System.ServiceProcess.ServiceControllerStatus Status {get;}
UserName            Property   System.String {get;set;}

PS C:\Users\Jose Manuel> Get-Item .\test.txt | Get-Member -MemberType Method

TypeName: System.ID.FileInfo

Name		MemberType    Definition
----            ----------    ----------
AppendText	Method        System.IO.StreamWriter AppendText()
CopyTo		Method        System.IO.FileInfo CopyTo(string destFileName),System.IO.FileInfo CopyTo(string destFileName, bool overwrite)
Create	        Method        System.IO.FileStream Create()	      
CreateObjRef	Method        System.Runtime.Remoting.ObjRef CreateObjRef(Type requestedType)
CreateText	Method        System.IO.StreamWriter CreateText()

PS C:\Users\Jose Manuel> Get-Item .\test.txt | Select-Object Name, Length

Name	Length
----	------
test.txt      0

PS C:\Users\Jose Manuel> Get-Service | Select-Object -Last 5
Get-Service: Service 'McpManagementService (McpManagementService)' cannot be queried due to the following error: PermissionDenied
Get-Service: Service 'SshdBroker (SshdBroker)' cannot be queried due to the following error: PermissionDenied

Status   Name               DisplayName
------   ----               -----------
Stopped  WwanSvc            Configuración automática de WWAN
Stopped  XblAuthManager     Administrador de autenticación de Xbo…
Stopped  XblGameSave        Juegos guardados en Xbox Live
Stopped  XboxGipSvc         Xbox Accessory Management Service
Stopped  XboxNetApiSvc      Servicio de red de Xbox Live

PS C:\Users\Jose Manuel> Get-Service | Select-Object -First 5

Status   Name               DisplayName
------   ----               -----------
Stopped  AarSvc_c86cb8      Agent Activation Runtime_c86cb8
Stopped  AJRouter           Servicio de enrutador de AllJoyn
Stopped  ALG                Servicio de puerta de enlace de nivel…
Running  AMD External Even… AMD External Events Utility
Stopped  AppIDSvc           Identidad de aplicación

PS C:\Users\Jose Manuel> (Get-Item .\test.txt).IsReadOnly
False

PS C:\Users\Jose Manuel> (Get-Item .\test.txt).IsReadOnly = 1

PS C:\Users\Jose Manuel> (Get-Item .\test.txt).IsReadOnly
True

PS C:\Users\Jose Manuel> Get-ChildItem *.txt

    Directory: C:\Users\Jose Manuel

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---       07/02/2025 03:13 p. m.              0 test.txt

PS C:\Users\Jose Manuel> (Get-Item .\test.txt).CopyTo("C:\Users\Jose Manuel\prueba.txt")

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---       07/02/2025 03:13 p. m.              0 prueba.txt

PS C:\Users\Jose Manuel> (Get-Item .\test.txt).Delete()
PS C:\Users\Jose Manuel> Get-ChildItem *.txt

    Directory: C:\Users\Jose Manuel

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---       07/02/2025 03:13 p. m.              0 prueba.txt

PS C:\Users\Jose Manuel> $miObjeto = New-Object PSObject
PS C:\Users\Jose Manuel> $miObjeto | Add-Member -MemberType NoteProperty -Name Nombre -Value "Miguel"
PS C:\Users\Jose Manuel> $miObjeto | Add-Member -MemberType NoteProperty -Name Edad -Value 23
PS C:\Users\Jose Manuel> $miObjeto | Add-Member -MemberType ScriptMethod -Name Saludar -Value { Write-Host "¡Hola Mundo!" }

PS C:\Users\Jose Manuel> $miObjeto = New-Object -TypeName PSObject -Property @{                                         >>   Nombre = "Miguel"
>>   Edad = 23
>> }
PS C:\Users\Jose Manuel> $miObjeto | Add-Member -MemberType ScriptMethod -Name Saludar -Value { Write-Host "¡Hola Mundo!" }
PS C:\Users\Jose Manuel> $miObjeto | Get-Member

   TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
Edad        NoteProperty int Edad=23
Nombre      NoteProperty string Nombre=Miguel
Saludar     ScriptMethod System.Object Saludar();

PS C:\Users\Jose Manuel> $miObjeto = [PSCustomObject] @{
>>   Nombre = "Miguel"
>>   Edad = 23
>> }
PS C:\Users\Jose Manuel> $miObjeto | Add-Member -MemberType ScriptMethod -Name Saludar -Value { Write-Host "¡Hola Mundo!" }
PS C:\Users\Jose Manuel> $miObjeto | Get-Member

   TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
Edad        NoteProperty int Edad=23
Nombre      NoteProperty string Nombre=Miguel
Saludar     ScriptMethod System.Object Saludar();

PS C:\Users\Jose Manuel> Get-Help -Full Get-Process

NAME
    Get-Process

SYNTAX
    Get-Process [[-Name] <string[]>] [-Module] [-FileVersionInfo] [<CommonParameters>]

    Get-Process [[-Name] <string[]>] -IncludeUserName [<CommonParameters>]

    Get-Process -Id <int[]> [-Module] [-FileVersionInfo] [<CommonParameters>]

    Get-Process -Id <int[]> -IncludeUserName [<CommonParameters>]

    Get-Process -InputObject <Process[]> [-Module] [-FileVersionInfo] [<CommonParameters>]

    Get-Process -InputObject <Process[]> -IncludeUserName [<CommonParameters>]


PARAMETERS
    -FileVersionInfo

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           Name, Id, InputObject
        Aliases                      FV, FVI
        Dynamic?                     false
        Accept wildcard characters?  false

    -Id <int[]>

        Required?                    true
        Position?                    Named
        Accept pipeline input?       true (ByPropertyName)
        Parameter set name           Id, IdWithUserName
        Aliases                      PID
        Dynamic?                     false
        Accept wildcard characters?  false

    -IncludeUserName

        Required?                    true
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           NameWithUserName, IdWithUserName, InputObjectWithUserName
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -InputObject <Process[]>

        Required?                    true
        Position?                    Named
        Accept pipeline input?       true (ByValue)
        Parameter set name           InputObject, InputObjectWithUserName
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -Module

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           Name, Id, InputObject
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -Name <string[]>

        Required?                    false
        Position?                    0
        Accept pipeline input?       true (ByPropertyName)
        Parameter set name           Name, NameWithUserName
        Aliases                      ProcessName
        Dynamic?                     false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).


INPUTS
    System.String[]
    System.Int32[]
    System.Diagnostics.Process[]


OUTPUTS
    System.Diagnostics.ProcessModule
    System.Diagnostics.FileVersionInfo
    System.Diagnostics.Process


ALIASES
    gps
    ps


REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Get-Process -Online" or
           go to https://go.microsoft.com/fwlink/?LinkID=2096814.

PS C:\Users\Jose Manuel> Get-Help -Full Stop-Process

NAME
    Stop-Process

SYNTAX
    Stop-Process [-Id] <int[]> [-PassThru] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]

    Stop-Process -Name <string[]> [-PassThru] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]

    Stop-Process [-InputObject] <Process[]> [-PassThru] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]


PARAMETERS
    -Confirm

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      cf
        Dynamic?                     false
        Accept wildcard characters?  false

    -Force

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -Id <int[]>

        Required?                    true
        Position?                    0
        Accept pipeline input?       true (ByPropertyName)
        Parameter set name           Id
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -InputObject <Process[]>

        Required?                    true
        Position?                    0
        Accept pipeline input?       true (ByValue)
        Parameter set name           InputObject
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -Name <string[]>

        Required?                    true
        Position?                    Named
        Accept pipeline input?       true (ByPropertyName)
        Parameter set name           Name
        Aliases                      ProcessName
        Dynamic?                     false
        Accept wildcard characters?  false

    -PassThru

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -WhatIf

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      wi
        Dynamic?                     false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).


INPUTS
    System.String[]
    System.Int32[]
    System.Diagnostics.Process[]


OUTPUTS
    System.Diagnostics.Process


ALIASES
    spps
    kill


REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Stop-Process -Online" or
           go to https://go.microsoft.com/fwlink/?LinkID=2097058.

PS C:\Users\Jose Manuel> Get-Process

 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
      5     0.99       4.56       0.06    8204   0 AggregatorHost
     20    11.03      24.55       0.28    7256   3 ApplicationFrameHost
     13     2.42      10.40      21.59   12100   3 atieclxx
      8     1.48       5.77       0.09    2308   0 atiesrxx
     25    39.50      63.14       2.12    1992   3 brave
     40   247.07     167.57      32.12    2780   3 brave
     28    76.93     124.60      11.61    3328   3 brave
     25    14.02      40.94       8.23    4412   3 brave
     23    29.86      71.76       2.50    5276   3 brave
     24    81.45      92.18      14.95    7220   3 brave
     42   149.36     194.74      54.42    8200   3 brave
     21    18.34      43.38       0.34   10040   3 brave
     19    12.75      27.95       0.16   10264   3 brave
     64   163.10     183.79      68.56   11828   3 brave
     17     7.91      20.41       0.33   12108   3 brave
     15     8.59      19.89       0.42   12572   3 brave
      9     2.11       7.00       0.12   15076   3 brave
     24    51.20     108.05       2.95   15152   3 brave
     21    16.07      44.15       1.22   15276   3 brave
     10     1.59       1.11       0.11    9928   0 BraveCrashHandler
      9     1.62       1.04       0.08    9936   0 BraveCrashHandler64
     28   101.42      96.64      12.34    2816   3 Code
     30    84.75     104.84       1.44    4100   3 Code
     12    10.74      31.59       0.05    4544   3 Code
     53   102.23     122.05       9.31    8652   3 Code
     18    13.79      45.92       0.45    9792   3 Code
     26    89.73     110.78       8.30   11312   3 Code
     37   253.59     268.68      33.17   12180   3 Code
     28   118.79     137.51       4.72   13676   3 Code
     25    69.01      87.72       1.11   15148   3 Code
      7     1.63       8.00       0.19    5212   3 CompPkgSrv
      9     6.38       6.48       2.36    5628   0 conhost
      8     1.30       6.35       0.14   11772   3 conhost
     14     9.71      20.57      15.03   11936   3 conhost
    105    60.10     134.25      12.11    8180   3 CopilotNative
     26     1.96       5.82       2.34     772   0 csrss
     27     9.97       6.30      43.56   13128   3 csrss
     17     4.75      21.00      19.34    3592   3 ctfmon
     11     2.40      10.19       0.14    3172   3 DAX3API
     11     3.30       9.07       0.70    4188   0 DAX3API
     11    10.91      30.77       0.06    6700   3 Discord
     44   103.00      91.11      14.56    9480   3 Discord
     79   250.02     244.14     317.89   11036   3 Discord
     18    14.79      49.44       3.45   11048   3 Discord
     30    72.50      71.72      10.31   11132   3 Discord
     16    12.12      74.64       0.34   12332   3 Discord
     16     4.36      13.16       0.83    2920   3 dllhost
     17     3.71      10.53       0.11    7464   0 dllhost
     47    82.86      61.39     307.14    6628   3 dwm
    128   156.89     175.48     148.64   13720   3 explorer
     14     4.93      18.68       0.39   11824   3 FileCoAuth
      9     1.55       6.51       0.11    4196   0 FMService64
      6     1.76       3.02       0.06    1088   0 fontdrvhost
      8     2.68       6.35       0.62    1800   3 fontdrvhost
     26   111.67     101.53       3.00    1100   3 GitHubDesktop
     55    85.96     102.92       5.66    2368   3 GitHubDesktop
     18    13.74      46.34       0.44    4204   3 GitHubDesktop
     40    71.00      92.61       4.94   15012   3 GitHubDesktop
     16     3.45      16.29       1.77    4888   0 hamachi-2
     24     3.34      13.84       1.81    9080   3 hamachi-2-ui
      0     0.06       0.01       0.00       0   0 Idle
     21    21.75      22.23       1.03    4456   0 LCD_Service
     10     2.00       7.48       0.25    4448   0 LMIGuardianSvc
     29    10.13      23.78      17.97     516   0 lsass
     25     6.78      18.32       0.69    4468   0 MateBookService
     56   110.66      49.71       7.84    5200   3 MBAMessageCenter
      0     0.99      77.21      63.39    2872   0 Memory Compression
     21    16.43      28.61      13.77    8684   0 MoUsoCoreWorker
     17    12.43      17.78       3.06    4508   0 MpDefenderCoreService
     17    19.17      22.78       0.23      88   3 msedge
     19    13.29      33.71       1.77    4384   3 msedge
     32   137.04     104.99     104.48    6512   3 msedge
     11     7.75      16.57       0.28    8232   3 msedge
     64    60.08     146.30     156.12   10016   3 msedge
     19    24.44      42.19       4.47   10600   3 msedge
     25   145.02      92.49      55.86   11316   3 msedge
     23    50.45      87.43      54.66   11368   3 msedge
     19    24.09       4.06       2.19   11820   3 msedge
     14     8.13      23.29       0.25   12436   3 msedge
      9     2.07       7.29       0.03   14248   3 msedge
     25   143.36     147.30      43.88   14584   3 msedge
     21    37.56      56.26       1.72    2112   3 msedgewebview2
     18    11.12      33.49       1.30    4936   3 msedgewebview2
     11     7.82      17.44       0.19    7496   3 msedgewebview2
     45    40.26     103.02       7.03    8132   3 msedgewebview2
     31   111.06      65.22       9.38    9860   3 msedgewebview2
     22    64.85     104.42      11.09   11040   3 msedgewebview2
      9     2.05       6.79       0.05   12528   3 msedgewebview2
    219   364.71     254.51     436.09    4728   0 MsMpEng
     12    33.02       5.83       0.12    4640   0 mysqld
    401   691.07      65.64      27.67    5520   0 mysqld
     14     7.79      12.96      10.80    9768   0 NisSrv
     13     2.85      14.98      15.92    7560   3 notepad
     27    40.22      36.37       3.70    4240   0 OfficeClickToRun
     63   113.50     108.71      15.27    8500   3 OneDrive
     14     2.80      11.82       0.14   14408   0 osdservice
     21    38.93      29.57       0.44   14656   3 OSD_Daemon
     67   272.79     245.79     132.84   13584   3 powershell_ise
    100    46.00     130.74      29.97    1744   3 pwsh
    128    59.53     164.34      75.78   12164   3 pwsh
     15     9.84      90.53       1.12     124   0 Registry
     12     2.92       8.64       0.39    4576   0 RtkAudUService64
     10     1.88       7.77       0.06    6996   3 RtkAudUService64
     12     2.31       9.48       0.11   15312   3 RtkAudUService64
      9     2.17       6.57       1.05    4564   0 RtkBtManServ
      9     1.57       8.25       0.08   11080   3 rundll32
     12     2.79      14.41       0.62    1364   3 RuntimeBroker
     18     6.38      26.67       3.14    3232   3 RuntimeBroker
     28    11.92      40.18       3.56    4772   3 RuntimeBroker
     21     6.59      21.98       1.41   12644   3 RuntimeBroker
     22     8.77      30.64       2.59   12736   3 RuntimeBroker
    172   224.06     106.16      49.00   10448   3 SearchApp
      9     1.65       7.56       0.03    6328   0 SearchFilterHost
     75    34.55      45.53      73.36    5696   0 SearchIndexer
     10     1.95       8.44       0.03    3136   3 SearchProtocolHost
     16     5.27      13.00       2.00   10368   0 SecurityHealthService
      9     1.75       8.63       0.05   14572   3 SecurityHealthSystray
     12     6.12       9.74      14.64     408   0 services
      4     0.65       2.82       0.03    4556   0 SessionService
     35    31.34      51.31       3.59    7908   3 ShellExperienceHost
     18     7.39      26.41       4.03   11072   3 sihost
      4     1.05       1.13       0.27     472   0 smss
     21     5.37      12.30       0.67    3764   0 spoolsv
     31    40.53      44.00       2.70    1008   0 sqlceip
     31    35.16      40.66       2.31   14076   0 sqlceip
     76   444.38     122.99     988.44    3216   0 sqlservr
     56   419.83     119.96     904.47   10508   0 sqlservr
     10     2.05       7.07       0.11    4616   0 sqlwriter
     34    40.05      60.80       1.89    1036   3 StartMenuExperienceHost
     93    56.52      58.87      34.95    3948   3 steam
     13     6.31       9.90       1.33   10676   0 steamservice
     42    45.64     140.18      68.89    8960   3 steamwebhelper
     25    65.95     102.26      78.91   10524   3 steamwebhelper
     29   299.39     297.34      26.14   10888   3 steamwebhelper
     36   239.24     132.70      31.00   12060   3 steamwebhelper
     13    10.54      16.36       0.39   12888   3 steamwebhelper
     20    10.94      25.61       1.94   13752   3 steamwebhelper
     12     7.83      10.89       0.08   14096   3 steamwebhelper
      8     1.52       6.67       0.03     884   0 svchost
      8     1.62       7.74       0.09    1000   0 svchost
     23    13.39      32.56      22.75    1068   0 svchost
     18    10.01      16.62      45.14    1248   0 svchost
     10     2.77       8.36       1.98    1308   0 svchost
     13     3.35      12.48       2.81    1360   0 svchost
     21     1.88       8.20       0.38    1432   0 svchost
     16     1.85      10.76       0.16    1440   0 svchost
     19     2.68      10.82       0.34    1452   0 svchost
     13     2.58       9.78       0.36    1568   0 svchost
      9     2.03      11.36       0.31    1576   0 svchost
     14    15.09      14.15       3.75    1680   0 svchost
     11     2.64       8.30       0.08    1752   0 svchost
     11     1.88       8.46       0.05    1772   0 svchost
     26     5.22       6.60       0.84    1872   0 svchost
     12     2.38      10.45       0.19    1912   0 svchost
     10     2.36       7.50       1.92    2032   0 svchost
     14     3.72      10.76       0.55    2088   0 svchost
      9     1.63       6.88       0.09    2268   0 svchost
     19     6.82      15.35       6.27    2288   0 svchost
     11     3.02      10.98       7.19    2324   0 svchost
     16     4.99      12.04       2.36    2352   0 svchost
     13     2.80      11.08       5.17    2432   0 svchost
      9     1.80       7.20       0.11    2464   0 svchost
     10     1.74       7.90       0.92    2496   0 svchost
      9     8.75      16.49      29.84    2508   0 svchost
      7     1.65       6.03       1.05    2644   0 svchost
     14     3.38      10.09       3.39    2664   0 svchost
     12     2.84      13.83      85.14    2716   0 svchost
      9     1.89       6.94       0.25    2732   0 svchost
      8     1.34       5.88       0.47    2740   0 svchost
     10     2.10       7.43       2.47    2820   0 svchost
     13     1.95       7.55       0.25    2928   0 svchost
      8     1.50       6.70       0.06    3012   0 svchost
      9     1.98       7.43       0.94    3020   0 svchost
     10     1.91       7.45       0.39    3028   0 svchost
     15     3.61       8.94      10.75    3204   0 svchost
     12     2.95      12.77       0.11    3212   0 svchost
     14     3.55      12.79       3.92    3352   0 svchost
     16     3.00       9.84       0.86    3472   0 svchost
     15     2.55      10.38       0.77    3480   0 svchost
     25     6.63      17.51       2.22    3620   0 svchost
     15     2.57      13.49       0.41    3672   0 svchost
     16     5.10      14.48       0.78    3824   0 svchost
     32    11.06      13.99       8.25    3848   0 svchost
     10     1.98       7.72       0.48    3932   0 svchost
      8     1.22       5.74       0.05    4160   0 svchost
     30    24.26      39.41      13.31    4176   0 svchost
     26     4.39      13.29       2.28    4220   0 svchost
     22    33.95      40.99      33.50    4272   0 svchost
     14     2.78       7.20       0.97    4296   0 svchost
     14     8.79      16.14       6.48    4320   0 svchost
     11     2.28       8.77       0.31    4600   0 svchost
     10     1.56       6.07       0.05    4608   0 svchost
      7     1.32       5.58       0.06    4676   0 svchost
     19     4.68      20.37       0.88    4716   0 svchost
     20     2.90       9.25       0.56    4856   0 svchost
     14     5.09      20.21      22.11    4876   0 svchost
      7     1.26       5.26       0.14    4900   0 svchost
     10     2.09       9.79       0.25    4976   0 svchost
     21     5.10      20.18       3.77    5116   0 svchost
      9     1.64       7.43       0.06    5272   0 svchost
     25     3.48      12.00       0.28    5352   0 svchost
     10     1.74       7.87       0.09    5556   0 svchost
      9     1.77       7.57       0.14    5868   0 svchost
      7     1.33       5.79       0.03    6620   0 svchost
      8     1.27       5.51       0.02    6652   0 svchost
     10     2.07       6.48       1.44    7088   0 svchost
     11     2.47       8.22       0.17    7104   0 svchost
     25     5.94      20.88       2.34    7280   0 svchost
     11     2.23       9.21       1.34    7420   0 svchost
     21    10.81      32.39      14.80    9568   3 svchost
     16     6.07      16.46       0.64   10284   0 svchost
     17     2.62       8.17       0.77   10620   0 svchost
      8     1.45       6.32       0.08   11240   0 svchost
     17     4.13      24.01       2.75   11388   3 svchost
     10     1.89       8.89       0.88   11588   0 svchost
     64    13.30      21.58       1.42   11612   0 svchost
     21     8.11      23.23       3.55   13068   0 svchost
     23     8.77      32.73       2.19   13636   3 svchost
     26     5.64      20.66       0.88   13792   3 svchost
     13     6.57      10.45       1.36   13828   0 svchost
     12     3.29      14.64      16.02   13896   0 svchost
      0     0.20       0.14     485.70       4   0 System
     49    37.12       1.43       1.31   13340   3 SystemSettings
     30     7.40      16.74       1.16    4068   3 taskhostw
     15     4.18      11.16       0.38   12204   3 taskhostw
     18     5.59      15.38       0.69   15292   3 taskhostw
     26    26.55      42.12       4.70    1520   3 TextInputHost
      8     1.50       7.37       0.03    9636   0 unsecapp
     10     2.27       9.67       0.17    3612   3 UserOOBEBroker
     11     1.65       6.81       0.17     892   0 wininit
     13     2.81      10.44       0.58    9224   3 winlogon
     16     5.80      11.80       1.03    5832   0 WmiPrvSE
      9     2.69       6.24       0.22    1120   0 WUDFHost

PS C:\Users\Jose Manuel> Get-Process -Name brave | Stop-Process
PS C:\Users\Jose Manuel> Get-Process

 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
      5     0.99       4.59       0.06    8204   0 AggregatorHost
     20    11.03      24.42       0.28    7256   3 ApplicationFrameHost
     13     2.42      10.40      22.39   12100   3 atieclxx
      8     1.48       5.77       0.09    2308   0 atiesrxx
     10     1.59       1.11       0.11    9928   0 BraveCrashHandler
      9     1.62       1.04       0.08    9936   0 BraveCrashHandler64
     28   101.45      71.48      12.44    2816   3 Code
     30    84.74      81.54       1.61    4100   3 Code
     12    10.74      28.28       0.05    4544   3 Code
     53   101.93      89.04       9.81    8652   3 Code
     18    13.78      42.39       0.53    9792   3 Code
     26    91.77      98.09       8.91   11312   3 Code
     37   248.73     164.82      34.19   12180   3 Code
     28   118.79      77.99       4.80   13676   3 Code
     25    69.01      72.80       1.27   15148   3 Code
      7     1.63       8.00       0.19    5212   3 CompPkgSrv
      9     6.38       6.48       2.44    5628   0 conhost
      8     1.30       5.68       0.14   11772   3 conhost
     14    10.13      20.85      20.97   11936   3 conhost
    105    60.16     124.86      12.12    8180   3 CopilotNative
     26     1.96       5.80       2.38     772   0 csrss
     24     9.97       5.99      46.31   13128   3 csrss
     17     4.75      20.68      19.50    3592   3 ctfmon
     11     2.46      10.79       0.16    3172   3 DAX3API
     11     3.30       9.07       0.80    4188   0 DAX3API
     11    10.91      30.77       0.06    6700   3 Discord
     44   103.00      88.17      15.11    9480   3 Discord
     79   251.21     242.82     350.75   11036   3 Discord
     18    14.79      48.48       3.58   11048   3 Discord
     30    72.53      69.75      10.39   11132   3 Discord
     16    12.12      74.63       0.36   12332   3 Discord
     16     4.36      11.78       0.83    2920   3 dllhost
     17     3.71      10.85       0.12    7464   0 dllhost
     47    82.25      59.89     322.59    6628   3 dwm
    127   156.15     159.96     149.78   13720   3 explorer
     14     4.95      18.70       0.41   11824   3 FileCoAuth
      9     1.55       6.51       0.11    4196   0 FMService64
      6     1.76       3.02       0.06    1088   0 fontdrvhost
      8     2.68       6.23       0.64    1800   3 fontdrvhost
     26   112.14      86.89       3.19    1100   3 GitHubDesktop
     55    84.41      93.99       6.64    2368   3 GitHubDesktop
     19    13.75      42.84       0.66    4204   3 GitHubDesktop
     40    71.07      78.92       5.42   15012   3 GitHubDesktop
     16     3.45      16.29       1.94    4888   0 hamachi-2
     24     3.34      13.84       1.97    9080   3 hamachi-2-ui
      0     0.06       0.01       0.00       0   0 Idle
     21    21.75      21.65       1.05    4456   0 LCD_Service
     10     2.00       7.48       0.27    4448   0 LMIGuardianSvc
     29    10.21      23.70      18.31     516   0 lsass
     25     6.84      18.48       0.70    4468   0 MateBookService
     56   110.62      49.61       8.23    5200   3 MBAMessageCenter
      0     1.22     249.49      70.27    2872   0 Memory Compression
     21    16.28      27.18      14.42    8684   0 MoUsoCoreWorker
     17    12.53      17.96       3.09    4508   0 MpDefenderCoreService
     17    19.17      23.28       0.25      88   3 msedge
     19    13.29      33.30       1.81    4384   3 msedge
     32   120.04     104.43     107.55    6512   3 msedge
     11     7.75      16.66       0.28    8232   3 msedge
     63    60.07     145.73     162.86   10016   3 msedge
     19    24.44      42.22       4.75   10600   3 msedge
     25   145.02      94.64      55.88   11316   3 msedge
     24    51.02      87.59      56.11   11368   3 msedge
     19    24.09       4.58       2.22   11820   3 msedge
     14     8.16      23.33       0.25   12436   3 msedge
      9     2.07       7.29       0.03   14248   3 msedge
     26   147.03     134.64      47.28   14584   3 msedge
     21    37.56      54.39       1.72    2112   3 msedgewebview2
     18    11.12      33.13       1.30    4936   3 msedgewebview2
     11     7.82      16.95       0.19    7496   3 msedgewebview2
     46    40.37     100.30       7.08    8132   3 msedgewebview2
     31   111.06      57.82       9.38    9860   3 msedgewebview2
     22    64.85      79.74      11.09   11040   3 msedgewebview2
      9     2.05       6.76       0.05   12528   3 msedgewebview2
    219   364.88     202.20     444.20    4728   0 MsMpEng
     12    33.02       5.83       0.12    4640   0 mysqld
    401   691.07      65.64      30.17    5520   0 mysqld
     13     6.90      12.41      11.17    9768   0 NisSrv
     13     2.91      15.03      16.02    7560   3 notepad
     27    40.34      36.72       3.88    4240   0 OfficeClickToRun
     64   113.61     108.74      15.39    8500   3 OneDrive
     14     2.80      11.82       0.14   14408   0 osdservice
     21    38.89      28.39       0.44   14656   3 OSD_Daemon
     67   272.79     113.50     133.36   13584   3 powershell_ise
    100    44.56     129.88      30.59    1744   3 pwsh
    128    59.97     119.04      76.12   12164   3 pwsh
     15     9.83      90.36       1.12     124   0 Registry
     12     2.92       8.64       0.39    4576   0 RtkAudUService64
     10     1.88       7.77       0.06    6996   3 RtkAudUService64
     12     2.31       9.48       0.11   15312   3 RtkAudUService64
      9     2.17       6.58       1.05    4564   0 RtkBtManServ
      9     1.57       8.25       0.08   11080   3 rundll32
     12     2.86      13.90       0.62    1364   3 RuntimeBroker
     18     6.40      26.61       3.16    3232   3 RuntimeBroker
     28    11.86      39.71       3.56    4772   3 RuntimeBroker
     21     6.59      21.98       1.42   12644   3 RuntimeBroker
     22     8.77      29.02       2.61   12736   3 RuntimeBroker
    174   220.88     106.74      49.64   10448   3 SearchApp
     74    34.28      41.65      73.44    5696   0 SearchIndexer
     16     5.27      13.00       2.00   10368   0 SecurityHealthService
      9     1.75       8.63       0.05   14572   3 SecurityHealthSystray
     11     6.03       9.68      14.83     408   0 services
      4     0.65       2.82       0.03    4556   0 SessionService
     35    31.34      51.29       3.59    7908   3 ShellExperienceHost
     18     7.44      26.11       4.03   11072   3 sihost
      4     1.05       1.13       0.27     472   0 smss
     21     5.37      12.30       0.67    3764   0 spoolsv
     31    41.22      44.85       2.84    1008   0 sqlceip
     31    35.77      41.48       2.42   14076   0 sqlceip
     76   468.17     141.19   1,067.34    3216   0 sqlservr
     55   422.49     123.46     970.81   10508   0 sqlservr
     10     2.05       7.07       0.11    4616   0 sqlwriter
     34    40.09      58.05       1.89    1036   3 StartMenuExperienceHost
     94    56.73      61.52      38.59    3948   3 steam
     13     6.31       9.90       1.55   10676   0 steamservice
     41    45.61     140.06      75.03    8960   3 steamwebhelper
     24    66.27      88.04      79.69   10524   3 steamwebhelper
     29   299.35     297.82      26.23   10888   3 steamwebhelper
     37   233.41     134.98      31.36   12060   3 steamwebhelper
     13    10.54      16.35       0.42   12888   3 steamwebhelper
     19    10.91      25.25       2.00   13752   3 steamwebhelper
     12     7.83      10.89       0.08   14096   3 steamwebhelper
      8     1.52       6.67       0.03     884   0 svchost
     23    13.30      32.49      23.47    1068   0 svchost
     18     9.97      16.21      45.45    1248   0 svchost
     10     2.71       8.30       2.02    1308   0 svchost
     13     3.35      12.48       2.81    1360   0 svchost
     21     1.89       8.25       0.38    1432   0 svchost
     16     1.85      10.76       0.16    1440   0 svchost
     19     2.68      10.85       0.38    1452   0 svchost
     13     2.61       9.93       0.36    1568   0 svchost
      9     2.13      11.40       0.31    1576   0 svchost
     14    15.07      13.80       3.80    1680   0 svchost
     11     2.64       8.29       0.08    1752   0 svchost
     11     1.88       8.47       0.05    1772   0 svchost
     28     5.71       8.56       0.94    1872   0 svchost
     12     2.38      10.44       0.20    1912   0 svchost
     10     2.38       7.31       1.92    2032   0 svchost
     14     3.80      10.81       0.55    2088   0 svchost
      9     1.63       6.88       0.09    2268   0 svchost
     18     6.54      15.22       6.55    2288   0 svchost
     10     2.97      10.94       7.28    2324   0 svchost
     16     5.10      10.10       2.36    2352   0 svchost
     12     2.58      11.04       5.23    2432   0 svchost
      9     1.80       7.20       0.11    2464   0 svchost
     10     1.74       7.89       0.92    2496   0 svchost
      9     8.71      16.35      29.88    2508   0 svchost
      7     1.65       5.96       1.08    2644   0 svchost
     14     3.53      10.00       3.44    2664   0 svchost
     12     2.95      13.84      98.20    2716   0 svchost
      9     1.89       6.94       0.25    2732   0 svchost
      8     1.39       5.89       0.55    2740   0 svchost
     10     2.14       7.51       2.48    2820   0 svchost
     13     1.95       7.55       0.25    2928   0 svchost
      8     1.50       6.70       0.06    3012   0 svchost
      9     1.98       7.44       0.94    3020   0 svchost
     10     1.91       7.43       0.39    3028   0 svchost
     15     3.65       8.70      10.92    3204   0 svchost
     14     3.74      12.98       3.94    3352   0 svchost
     15     2.92       9.78       0.86    3472   0 svchost
     15     2.58      10.42       0.77    3480   0 svchost
     25     6.63      17.50       2.23    3620   0 svchost
     15     2.57      13.50       0.41    3672   0 svchost
     16     5.10      14.48       0.78    3824   0 svchost
     32    11.18      13.48       8.31    3848   0 svchost
     11     2.11       7.80       0.48    3932   0 svchost
      8     1.22       5.74       0.05    4160   0 svchost
     29    23.86      38.82      13.42    4176   0 svchost
     26     4.20      12.68       2.30    4220   0 svchost
     22    36.44      31.55      34.11    4272   0 svchost
     14     2.88       7.75       1.02    4296   0 svchost
     14     8.78      16.22       6.61    4320   0 svchost
     12     2.33       8.77       0.31    4600   0 svchost
     10     1.56       6.07       0.05    4608   0 svchost
      7     1.32       5.58       0.06    4676   0 svchost
     19     4.57      20.12       0.89    4716   0 svchost
     20     3.01       9.77       0.56    4856   0 svchost
     13     4.93      16.33      22.31    4876   0 svchost
      7     1.26       5.26       0.14    4900   0 svchost
     10     2.23       9.86       0.25    4976   0 svchost
     20     4.68      19.96       3.78    5116   0 svchost
     25     3.53      11.83       0.30    5352   0 svchost
     10     1.74       7.88       0.09    5556   0 svchost
      9     1.78       7.59       0.14    5868   0 svchost
      7     1.33       5.79       0.03    6620   0 svchost
      8     1.27       5.51       0.02    6652   0 svchost
     64    13.35      21.00       1.48    7064   0 svchost
     10     2.07       6.48       1.44    7088   0 svchost
     11     2.47       8.23       0.17    7104   0 svchost
     26     6.09      21.00       2.42    7280   0 svchost
     11     2.23       9.21       1.34    7420   0 svchost
      9     1.75       7.47       0.05    7692   0 svchost
     20    10.66      32.10      15.08    9568   3 svchost
     16     6.07      16.49       0.64   10284   0 svchost
     17     2.64       8.15       0.77   10620   0 svchost
      8     1.55       6.34       0.08   11240   0 svchost
     15     3.76      22.17       3.08   11388   3 svchost
     10     1.89       8.89       0.88   11588   0 svchost
     12     2.86      12.65       0.09   12548   0 svchost
      8     1.64       7.75       0.09   12784   0 svchost
     21     8.01      23.27       3.55   13068   0 svchost
     23     8.65      32.66       2.19   13636   3 svchost
     26     5.64      20.65       0.88   13792   3 svchost
     13     6.72      10.15       1.53   13828   0 svchost
     12     3.27      14.78      16.02   13896   0 svchost
      0     0.20       0.14     496.28       4   0 System
     49    37.12       1.43       1.31   13340   3 SystemSettings
     30     7.40      16.65       1.23    4068   3 taskhostw
     15     4.18      11.14       0.38   12204   3 taskhostw
     18     5.59      15.41       0.70   15292   3 taskhostw
     26    26.53      41.75       4.75    1520   3 TextInputHost
      7     1.47       7.35       0.03    9636   0 unsecapp
     10     2.33       9.73       0.17    3612   3 UserOOBEBroker
     11     1.65       6.81       0.17     892   0 wininit
     13     2.81      10.51       0.58    9224   3 winlogon
     16     5.80      11.79       1.11    5832   0 WmiPrvSE
      9     2.69       6.38       0.22    1120   0 WUDFHost

PS C:\Users\Jose Manuel> Get-Help -Full Get-ChildItem

NAME
    Get-ChildItem

SYNTAX
    Get-ChildItem [[-Path] <string[]>] [[-Filter] <string>] [-Include <string[]>] [-Exclude <string[]>] [-Recurse]
    [-Depth <uint>] [-Force] [-Name] [-Attributes {None | ReadOnly | Hidden | System | Directory | Archive | Device |
    Normal | Temporary | SparseFile | ReparsePoint | Compressed | Offline | NotContentIndexed | Encrypted |
    IntegrityStream | NoScrubData}] [-FollowSymlink] [-Directory] [-File] [-Hidden] [-ReadOnly] [-System]
    [<CommonParameters>]

    Get-ChildItem [[-Filter] <string>] -LiteralPath <string[]> [-Include <string[]>] [-Exclude <string[]>] [-Recurse]
    [-Depth <uint>] [-Force] [-Name] [-Attributes {None | ReadOnly | Hidden | System | Directory | Archive | Device |
    Normal | Temporary | SparseFile | ReparsePoint | Compressed | Offline | NotContentIndexed | Encrypted |
    IntegrityStream | NoScrubData}] [-FollowSymlink] [-Directory] [-File] [-Hidden] [-ReadOnly] [-System]
    [<CommonParameters>]


PARAMETERS
    -Attributes <FlagsExpression[FileAttributes]>

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     true
        Accept wildcard characters?  false

    -Depth <uint>

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -Directory

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      ad
        Dynamic?                     true
        Accept wildcard characters?  false

    -Exclude <string[]>

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -File

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      af
        Dynamic?                     true
        Accept wildcard characters?  false

    -Filter <string>

        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -FollowSymlink

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     true
        Accept wildcard characters?  false

    -Force

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -Hidden

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      ah, h
        Dynamic?                     true
        Accept wildcard characters?  false

    -Include <string[]>

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -LiteralPath <string[]>

        Required?                    true
        Position?                    Named
        Accept pipeline input?       true (ByPropertyName)
        Parameter set name           LiteralItems
        Aliases                      PSPath, LP
        Dynamic?                     false
        Accept wildcard characters?  false

    -Name

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -Path <string[]>

        Required?                    false
        Position?                    0
        Accept pipeline input?       true (ByValue, ByPropertyName)
        Parameter set name           Items
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -ReadOnly

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      ar
        Dynamic?                     true
        Accept wildcard characters?  false

    -Recurse

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      s, r
        Dynamic?                     false
        Accept wildcard characters?  false

    -System

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      as
        Dynamic?                     true
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).


INPUTS
    System.String[]


OUTPUTS
    System.IO.FileInfo
    System.IO.DirectoryInfo


ALIASES
    gci
    ls
    dir


REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Get-ChildItem -Online" or
           go to https://go.microsoft.com/fwlink/?LinkID=2096492.

PS C:\Users\Jose Manuel> Get-Help -Full Stop-Service

NAME
    Stop-Service

SYNTAX
    Stop-Service [-InputObject] <ServiceController[]> [-Force] [-NoWait] [-PassThru] [-Include <string[]>] [-Exclude
    <string[]>] [-WhatIf] [-Confirm] [<CommonParameters>]

    Stop-Service [-Name] <string[]> [-Force] [-NoWait] [-PassThru] [-Include <string[]>] [-Exclude <string[]>]
    [-WhatIf] [-Confirm] [<CommonParameters>]

    Stop-Service -DisplayName <string[]> [-Force] [-NoWait] [-PassThru] [-Include <string[]>] [-Exclude <string[]>]
    [-WhatIf] [-Confirm] [<CommonParameters>]


PARAMETERS
    -Confirm

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      cf
        Dynamic?                     false
        Accept wildcard characters?  false

    -DisplayName <string[]>

        Required?                    true
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           DisplayName
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -Exclude <string[]>

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -Force

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -Include <string[]>

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -InputObject <ServiceController[]>

        Required?                    true
        Position?                    0
        Accept pipeline input?       true (ByValue)
        Parameter set name           InputObject
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -Name <string[]>

        Required?                    true
        Position?                    0
        Accept pipeline input?       true (ByValue, ByPropertyName)
        Parameter set name           Default
        Aliases                      ServiceName
        Dynamic?                     false
        Accept wildcard characters?  false

    -NoWait

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -PassThru

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        Accept wildcard characters?  false

    -WhatIf

        Required?                    false
        Position?                    Named
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      wi
        Dynamic?                     false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).


INPUTS
    System.String[]
    System.ServiceProcess.ServiceController[]


OUTPUTS
    System.ServiceProcess.ServiceController


ALIASES
    spsv


REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Stop-Service -Online" or
           go to https://go.microsoft.com/fwlink/?LinkID=2097052.

PS C:\Users\Jose Manuel> Get-Service

Status   Name               DisplayName
------   ----               -----------
Stopped  AarSvc_c86cb8      Agent Activation Runtime_c86cb8
Stopped  AJRouter           Servicio de enrutador de AllJoyn
Running  ALG                Servicio de puerta de enlace de nivel…
Running  AMD External Even… AMD External Events Utility
Stopped  AppIDSvc           Identidad de aplicación
Running  Appinfo            Información de la aplicación
Stopped  AppReadiness       Preparación de aplicaciones
Running  AppXSvc            AppX Deployment Service (AppXSVC)
Stopped  aspnet_state       ASP.NET State Service
Running  AudioEndpointBuil… Compilador de extremo de audio de Win…
Running  Audiosrv           Audio de Windows
Stopped  autotimesvc        Hora de la red de telefonía móvil
Stopped  AxInstSV           Instalador de ActiveX (AxInstSV)
Running  AzureAttestService AzureAttestService
Stopped  BcastDVRUserServi… Servicio de usuario de difusión y Gam…
Stopped  BDESVC             Servicio Cifrado de unidad BitLocker
Running  BFE                Motor de filtrado de base
Stopped  BITS               Servicio de transferencia inteligente…
Stopped  BluetoothUserServ… Servicio de soporte técnico al usuari…
Stopped  brave              Brave Update Servicio (brave)
Stopped  BraveElevationSer… Brave Elevation Service (BraveElevati…
Stopped  bravem             Brave Update Servicio (bravem)
Running  BrokerInfrastruct… Servicio de infraestructura de tareas…
Running  BTAGService        Servicio de puerta de enlace de audio…
Running  BthAvctpSvc        Servicio AVCTP
Running  bthserv            Servicio de compatibilidad con Blueto…
Running  camsvc             Servicio Administrador de funcionalid…
Stopped  CaptureService_c8… CaptureService_c86cb8
Running  cbdhsvc_c86cb8     Servicio de usuario de Portapapeles_c…
Running  CDPSvc             Servicio de plataforma de dispositivo…
Running  CDPUserSvc_c86cb8  Servicio de usuario de plataforma de …
Stopped  CertPropSvc        Propagación de certificados
Running  ClickToRunSvc      Microsoft Office Click-to-Run Service
Stopped  ClipSVC            Servicio de licencia de cliente (Clip…
Stopped  COMSysApp          Aplicación del sistema COM+
Stopped  ConsentUxUserSvc_… ConsentUX_c86cb8
Running  CoreMessagingRegi… CoreMessaging
Stopped  CredentialEnrollm… CredentialEnrollmentManagerUserSvc_c8…
Running  CryptSvc           Servicios de cifrado
Running  DcomLaunch         Iniciador de procesos de servidor DCOM
Stopped  dcsvc              Declared Configuration(DC) service
Stopped  debugregsvc        debugregsvc
Stopped  defragsvc          Optimizar unidades
Stopped  DeveloperToolsSer… Developer Tools Service
Stopped  DeviceAssociation… DeviceAssociationBroker_c86cb8
Running  DeviceAssociation… Servicio de asociación de dispositivos
Stopped  DeviceInstall      Servicio de instalación de dispositiv…
Stopped  DevicePickerUserS… DevicePicker_c86cb8
Stopped  DevicesFlowUserSv… DevicesFlow_c86cb8
Running  DevQueryBroker     Agente de detección en segundo plano …
Running  Dhcp               Cliente DHCP
Stopped  diagnosticshub.st… Servicio Recopilador estándar del con…
Stopped  diagsvc            Diagnostic Execution Service
Running  DiagTrack          Experiencia del usuario y telemetría …
Running  DispBrokerDesktop… Mostrar el servicio de directivas
Running  DisplayEnhancemen… Servicio de mejora de visualización
Stopped  DmEnrollmentSvc    Servicio de inscripción de administra…
Stopped  dmwappushservice   Servicio de enrutamiento de mensajes …
Running  Dnscache           Cliente DNS
Running  DolbyDAXAPI        Dolby DAX API Service
Stopped  DoSvc              Optimización de distribución
Stopped  dot3svc            Configuración automática de redes cab…
Running  DPS                Servicio de directivas de diagnóstico
Stopped  DsmSvc             Administrador de configuración de dis…
Stopped  DsSvc              Servicio de uso compartido de datos
Running  DusmSvc            Uso de datos
Stopped  Eaphost            Protocolo de autenticación extensible
Stopped  edgeupdate         Microsoft Edge Update Service (edgeup…
Stopped  edgeupdatem        Microsoft Edge Update Service (edgeup…
Stopped  EFS                Sistema de cifrado de archivos (EFS)
Stopped  embeddedmode       Modo incrustado
Stopped  EntAppSvc          Servicio de administración de aplicac…
Running  EventLog           Registro de eventos de Windows
Running  EventSystem        Sistema de eventos COM+
Stopped  Fax                Fax
Stopped  fdPHost            Host de proveedor de detección de fun…
Stopped  FDResPub           Publicación de recurso de detección d…
Stopped  fhsvc              File History Service
Stopped  FileSyncHelper     FileSyncHelper
Running  FMAPOService       Fortemedia APO Control Service
Running  FontCache          Servicio de caché de fuentes de Windo…
Stopped  FrameServer        Servicio FrameServer de la Cámara de …
Stopped  GameInputSvc       GameInput Service
Running  gpsvc              Cliente de directiva de grupo
Stopped  GraphicsPerfSvc    GraphicsPerfSvc
Running  Hamachi2Svc        Hamachi Tunneling Engine
Running  hidserv            Servicio de dispositivo de interfaz h…
Running  Huawei_OSDServer   Huawei OSD Service
Stopped  HvHost             Servicio de host HV
Stopped  icssvc             Servicio de punto de conexión de Wind…
Running  IKEEXT             Módulos de creación de claves de IPse…
Running  InstallService     Servicio de instalación de Microsoft …
Running  iphlpsvc           Aplicación auxiliar IP
Stopped  IpxlatCfgSvc       Servicio de configuración de traslaci…
Running  KeyIso             Aislamiento de claves CNG
Stopped  KtmRm              KTMRM para DTC (Coordinador de transa…
Running  LanmanServer       Servidor
Running  LanmanWorkstation  Estación de trabajo
Running  LCD_Service        Huawei LCD_Service
Running  lfsvc              Servicio de geolocalización
Running  LicenseManager     Servicio de administrador de licencia…
Stopped  lltdsvc            Asignador de detección de topologías …
Running  lmhosts            Aplicación auxiliar de NetBIOS sobre …
Running  LMIGuardianSvc     LMIGuardianSvc
Running  LSM                Administrador de sesión local
Stopped  LxpSvc             Servicio de experiencia de idioma
Stopped  MapsBroker         Administrador de mapas descargado
Running  MBAMainService     Huawei PCManager Windows Service

PS C:\Users\Jose Manuel> Get-Service ALG | Stop-Service
PS C:\Users\Jose Manuel> Get-Service

Status   Name               DisplayName
------   ----               -----------
Stopped  AarSvc_c86cb8      Agent Activation Runtime_c86cb8
Stopped  AJRouter           Servicio de enrutador de AllJoyn
Stopped  ALG                Servicio de puerta de enlace de nivel…
Running  AMD External Even… AMD External Events Utility
Stopped  AppIDSvc           Identidad de aplicación
Running  Appinfo            Información de la aplicación
Stopped  AppReadiness       Preparación de aplicaciones
Stopped  AppXSvc            AppX Deployment Service (AppXSVC)
Stopped  aspnet_state       ASP.NET State Service
Running  AudioEndpointBuil… Compilador de extremo de audio de Win…
Running  Audiosrv           Audio de Windows
Stopped  autotimesvc        Hora de la red de telefonía móvil
Stopped  AxInstSV           Instalador de ActiveX (AxInstSV)
Running  AzureAttestService AzureAttestService
Stopped  BcastDVRUserServi… Servicio de usuario de difusión y Gam…
Stopped  BDESVC             Servicio Cifrado de unidad BitLocker
Running  BFE                Motor de filtrado de base
Stopped  BITS               Servicio de transferencia inteligente…
Stopped  BluetoothUserServ… Servicio de soporte técnico al usuari…
Stopped  brave              Brave Update Servicio (brave)
Stopped  BraveElevationSer… Brave Elevation Service (BraveElevati…
Stopped  bravem             Brave Update Servicio (bravem)
Running  BrokerInfrastruct… Servicio de infraestructura de tareas…
Running  BTAGService        Servicio de puerta de enlace de audio…
Running  BthAvctpSvc        Servicio AVCTP
Running  bthserv            Servicio de compatibilidad con Blueto…
Running  camsvc             Servicio Administrador de funcionalid…
Stopped  CaptureService_c8… CaptureService_c86cb8
Running  cbdhsvc_c86cb8     Servicio de usuario de Portapapeles_c…
Running  CDPSvc             Servicio de plataforma de dispositivo…
Running  CDPUserSvc_c86cb8  Servicio de usuario de plataforma de …
Stopped  CertPropSvc        Propagación de certificados
Running  ClickToRunSvc      Microsoft Office Click-to-Run Service
Stopped  ClipSVC            Servicio de licencia de cliente (Clip…
Stopped  COMSysApp          Aplicación del sistema COM+
Stopped  ConsentUxUserSvc_… ConsentUX_c86cb8
Running  CoreMessagingRegi… CoreMessaging
Stopped  CredentialEnrollm… CredentialEnrollmentManagerUserSvc_c8…
Running  CryptSvc           Servicios de cifrado
Running  DcomLaunch         Iniciador de procesos de servidor DCOM
Stopped  dcsvc              Declared Configuration(DC) service
Stopped  debugregsvc        debugregsvc
Stopped  defragsvc          Optimizar unidades
Stopped  DeveloperToolsSer… Developer Tools Service
Stopped  DeviceAssociation… DeviceAssociationBroker_c86cb8
Running  DeviceAssociation… Servicio de asociación de dispositivos
Stopped  DeviceInstall      Servicio de instalación de dispositiv…
Stopped  DevicePickerUserS… DevicePicker_c86cb8
Stopped  DevicesFlowUserSv… DevicesFlow_c86cb8
Running  DevQueryBroker     Agente de detección en segundo plano …
Running  Dhcp               Cliente DHCP
Stopped  diagnosticshub.st… Servicio Recopilador estándar del con…
Stopped  diagsvc            Diagnostic Execution Service
Running  DiagTrack          Experiencia del usuario y telemetría …
Running  DispBrokerDesktop… Mostrar el servicio de directivas
Running  DisplayEnhancemen… Servicio de mejora de visualización
Stopped  DmEnrollmentSvc    Servicio de inscripción de administra…
Stopped  dmwappushservice   Servicio de enrutamiento de mensajes …
Running  Dnscache           Cliente DNS
Running  DolbyDAXAPI        Dolby DAX API Service
Stopped  DoSvc              Optimización de distribución
Stopped  dot3svc            Configuración automática de redes cab…
Running  DPS                Servicio de directivas de diagnóstico
Stopped  DsmSvc             Administrador de configuración de dis…
Stopped  DsSvc              Servicio de uso compartido de datos
Running  DusmSvc            Uso de datos
Stopped  Eaphost            Protocolo de autenticación extensible
Stopped  edgeupdate         Microsoft Edge Update Service (edgeup…
Stopped  edgeupdatem        Microsoft Edge Update Service (edgeup…
Stopped  EFS                Sistema de cifrado de archivos (EFS)
Stopped  embeddedmode       Modo incrustado
Stopped  EntAppSvc          Servicio de administración de aplicac…
Running  EventLog           Registro de eventos de Windows
Running  EventSystem        Sistema de eventos COM+
Stopped  Fax                Fax
Stopped  fdPHost            Host de proveedor de detección de fun…
Stopped  FDResPub           Publicación de recurso de detección d…
Stopped  fhsvc              File History Service
Stopped  FileSyncHelper     FileSyncHelper
Running  FMAPOService       Fortemedia APO Control Service
Running  FontCache          Servicio de caché de fuentes de Windo…
Stopped  FrameServer        Servicio FrameServer de la Cámara de …
Stopped  GameInputSvc       GameInput Service
Running  gpsvc              Cliente de directiva de grupo
Stopped  GraphicsPerfSvc    GraphicsPerfSvc
Running  Hamachi2Svc        Hamachi Tunneling Engine
Running  hidserv            Servicio de dispositivo de interfaz h…
Running  Huawei_OSDServer   Huawei OSD Service
Stopped  HvHost             Servicio de host HV
Stopped  icssvc             Servicio de punto de conexión de Wind…
Running  IKEEXT             Módulos de creación de claves de IPse…
Running  InstallService     Servicio de instalación de Microsoft …
Running  iphlpsvc           Aplicación auxiliar IP
Stopped  IpxlatCfgSvc       Servicio de configuración de traslaci…
Running  KeyIso             Aislamiento de claves CNG
Stopped  KtmRm              KTMRM para DTC (Coordinador de transa…
Running  LanmanServer       Servidor
Running  LanmanWorkstation  Estación de trabajo
Running  LCD_Service        Huawei LCD_Service
Running  lfsvc              Servicio de geolocalización
Running  LicenseManager     Servicio de administrador de licencia…
Stopped  lltdsvc            Asignador de detección de topologías …
Running  lmhosts            Aplicación auxiliar de NetBIOS sobre …
Running  LMIGuardianSvc     LMIGuardianSvc
Running  LSM                Administrador de sesión local
Stopped  LxpSvc             Servicio de experiencia de idioma
Stopped  MapsBroker         Administrador de mapas descargado
Running  MBAMainService     Huawei PCManager Windows Service

PS C:\Users\Jose Manuel> Get-Service
Status   Name               DisplayName
------   ----               -----------
Stopped  AarSvc_c86cb8      Agent Activation Runtime_c86cb8

PS C:\Users\Jose Manuel> "AarSvc_c86cb8" | Stop-Service

PS C:\Users\Jose Manuel> Get-Service
PS C:\Users\Jose Manuel> Get-Service

PS C:\Users\Jose Manuel> $miObjeto = [PSCustomObject] @{
>> Name = "Spooler"
>> }
PS C:\Users\Jose Manuel> $miObjeto | Stop-Service

PS C:\Users\Jose Manuel> Get-Service
PS C:\Users\Jose Manuel> Get-Service