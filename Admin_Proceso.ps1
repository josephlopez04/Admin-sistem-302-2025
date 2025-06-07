PS C:\Users\Jose Manuel> Get-Service

Status   Name               DisplayName
------   ----               -----------
Stopped  AarSvc_2f1cd67     Agent Activation Runtime_2f1cd67
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
Stopped  CaptureService_2f… CaptureService_2f1cd67
Running  cbdhsvc_2f1cd67    Servicio de usuario de Portapapeles_2…
Running  CDPSvc             Servicio de plataforma de dispositivo…
Running  CDPUserSvc_2f1cd67 Servicio de usuario de plataforma de …
Stopped  CertPropSvc        Propagación de certificados
Running  ClickToRunSvc      Microsoft Office Click-to-Run Service
Stopped  ClipSVC            Servicio de licencia de cliente (Clip…
Stopped  COMSysApp          Aplicación del sistema COM+
Stopped  ConsentUxUserSvc_… ConsentUX_2f1cd67
Running  CoreMessagingRegi… CoreMessaging
Stopped  CredentialEnrollm… CredentialEnrollmentManagerUserSvc_2f…
Running  CryptSvc           Servicios de cifrado
Running  DcomLaunch         Iniciador de procesos de servidor DCOM
Stopped  dcsvc              Declared Configuration(DC) service
Stopped  debugregsvc        debugregsvc
Stopped  defragsvc          Optimizar unidades
Stopped  DeveloperToolsSer… Developer Tools Service
Stopped  DeviceAssociation… DeviceAssociationBroker_2f1cd67
Running  DeviceAssociation… Servicio de asociación de dispositivos
Stopped  DeviceInstall      Servicio de instalación de dispositiv…
Stopped  DevicePickerUserS… DevicePicker_2f1cd67
Stopped  DevicesFlowUserSv… DevicesFlow_2f1cd67
Running  DevQueryBroker     Agente de detección en segundo plano …
Running  Dhcp               Cliente DHCP
Stopped  diagnosticshub.st… Servicio Recopilador estándar del con…
Stopped  diagsvc            Diagnostic Execution Service

PS C:\Users\Jose Manuel> Get-Service -Name Spooler

Status   Name               DisplayName
------   ----               -----------
Running  Spooler            Cola de impresión

PS C:\Users\Jose Manuel> Get-Service -DisplayName Hora*

Status   Name               DisplayName
------   ----               -----------
Stopped  autotimesvc        Hora de la red de telefonía móvil
Stopped  W32Time            Hora de Windows

PS C:\Users\Jose Manuel> Get-Service | Where-Object {$_.Status -eq "Running"}

Status   Name               DisplayName
------   ----               -----------
Running  AMD External Even… AMD External Events Utility
Running  Appinfo            Información de la aplicación
Running  AudioEndpointBuil… Compilador de extremo de audio de Win…
Running  Audiosrv           Audio de Windows
Running  AzureAttestService AzureAttestService
Running  BFE                Motor de filtrado de base
Running  BrokerInfrastruct… Servicio de infraestructura de tareas…
Running  BTAGService        Servicio de puerta de enlace de audio…
Running  BthAvctpSvc        Servicio AVCTP
Running  bthserv            Servicio de compatibilidad con Blueto…
Running  camsvc             Servicio Administrador de funcionalid…
Running  cbdhsvc_2f1cd67    Servicio de usuario de Portapapeles_2…
Running  CDPSvc             Servicio de plataforma de dispositivo…
Running  CDPUserSvc_2f1cd67 Servicio de usuario de plataforma de …
Running  ClickToRunSvc      Microsoft Office Click-to-Run Service
Running  CoreMessagingRegi… CoreMessaging
Running  CryptSvc           Servicios de cifrado
Running  DcomLaunch         Iniciador de procesos de servidor DCOM
Running  DeviceAssociation… Servicio de asociación de dispositivos
Running  DevQueryBroker     Agente de detección en segundo plano …
Running  Dhcp               Cliente DHCP
Running  DiagTrack          Experiencia del usuario y telemetría …
Running  DispBrokerDesktop… Mostrar el servicio de directivas
Running  DisplayEnhancemen… Servicio de mejora de visualización
Running  Dnscache           Cliente DNS
Running  DolbyDAXAPI        Dolby DAX API Service
Running  DPS                Servicio de directivas de diagnóstico
Running  DsSvc              Servicio de uso compartido de datos
Running  DusmSvc            Uso de datos
Running  EventLog           Registro de eventos de Windows
Running  EventSystem        Sistema de eventos COM+
Running  FMAPOService       Fortemedia APO Control Service
Running  FontCache          Servicio de caché de fuentes de Windo…
Running  gpsvc              Cliente de directiva de grupo
Running  Hamachi2Svc        Hamachi Tunneling Engine
Running  hidserv            Servicio de dispositivo de interfaz h…
Running  Huawei_OSDServer   Huawei OSD Service
Running  IKEEXT             Módulos de creación de claves de IPse…
Running  InstallService     Servicio de instalación de Microsoft …
Running  iphlpsvc           Aplicación auxiliar IP
Running  KeyIso             Aislamiento de claves CNG
Running  LanmanServer       Servidor
Running  LanmanWorkstation  Estación de trabajo
Running  LCD_Service        Huawei LCD_Service
Running  lfsvc              Servicio de geolocalización
Running  LicenseManager     Servicio de administrador de licencia…
Running  lmhosts            Aplicación auxiliar de NetBIOS sobre …
Running  LMIGuardianSvc     LMIGuardianSvc
Running  LSM                Administrador de sesión local
Running  MBAMainService     Huawei PCManager Windows Service

PS C:\Users\Jose Manuel> Get-Service |
>> Where-Object {$_.StartType -eq "Automatic"} |
>> Select-Object Name, StartType

Name                        StartType
----                        ---------
AMD External Events Utility Automatic
AudioEndpointBuilder        Automatic
Audiosrv                    Automatic
AzureAttestService          Automatic
BFE                         Automatic
brave                       Automatic
BrokerInfrastructure        Automatic
CDPSvc                      Automatic
CDPUserSvc_2f1cd67          Automatic
ClickToRunSvc               Automatic
CoreMessagingRegistrar      Automatic
CryptSvc                    Automatic
DcomLaunch                  Automatic
debugregsvc                 Automatic
Dhcp                        Automatic
DiagTrack                   Automatic
DispBrokerDesktopSvc        Automatic
Dnscache                    Automatic
DolbyDAXAPI                 Automatic
DoSvc                       Automatic
DPS                         Automatic
DusmSvc                     Automatic
edgeupdate                  Automatic
EventLog                    Automatic
EventSystem                 Automatic
FMAPOService                Automatic
FontCache                   Automatic
gpsvc                       Automatic
Hamachi2Svc                 Automatic
Huawei_OSDServer            Automatic
IKEEXT                      Automatic
iphlpsvc                    Automatic
LanmanServer                Automatic
LanmanWorkstation           Automatic
LCD_Service                 Automatic
LMIGuardianSvc              Automatic
LSM                         Automatic
MapsBroker                  Automatic
MBAMainService              Automatic

PS C:\Users\Jose Manuel> Get-Service -DependentServices Spooler

Status   Name               DisplayName
------   ----               -----------
Stopped  Fax

PS C:\Users\Jose Manuel> Get-Service -RequiredServices Fax

Status   Name               DisplayName
------   ----               -----------
Stopped  TapiSrv            Telefonía
Running  RpcSs              Llamada a procedimiento remoto (RPC)
Running  Spooler            Cola de impresión

PS C:\Users\Jose Manuel> Stop-Service -Name Spooler -Confirm -PassThru

Confirm
Are you sure you want to perform this action?
Performing the operation "Stop-Service" on target "Cola de impresión (Spooler)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y

Status   Name               DisplayName
------   ----               -----------
Stopped  Spooler            Cola de impresión

PS C:\Users\Jose Manuel> Start-Service -Name Spooler -Confirm -PassThru

Confirm
Are you sure you want to perform this action?
Performing the operation "Start-Service" on target "Cola de impresión (Spooler)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y

Status   Name               DisplayName
------   ----               -----------
Running  Spooler            Cola de impresión

PS C:\Users\Jose Manuel> Suspend-Service -Name stisvc -Confirm -PassThru

Confirm
Are you sure you want to perform this action?
Performing the operation "Suspend-Service" on target "Adquisición de imágenes de Windows (WIA) (stisvc)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y

Status   Name               DisplayName
------   ----               -----------
Running  stisvc             Adquisicion de imagenes de Windows

PS C:\Users\Jose Manuel> Get-Service | Where-Object CanPauseAndContinue -eq True

Status   Name               DisplayName
------   ----               -----------
Running  LanmanWorkstation  Estación de trabajo
Get-Service: Service 'McpManagementService (McpManagementService)' cannot be queried due to the following error: PermissionDenied
Running  MSSQL$SQLEXPRESS   SQL Server (SQLEXPRESS)
Running  MSSQLSERVER        SQL Server (MSSQLSERVER)
Running  MySQL90            MySQL90
Running  seclogon           Inicio de sesión secundario
Get-Service: Service 'SshdBroker (SshdBroker)' cannot be queried due to the following error: PermissionDenied
Running  Winmgmt            Instrumental de administración de Win…

PS C:\Users\Jose Manuel> Suspend-Service -Name Spooler
Suspend-Service: Service 'Cola de impresión (Spooler)' cannot be suspended because the service does not support being suspended or resumed.
Suspend-Service: Service 'Cola de impresión (Spooler)' cannot be suspended due to the following error: Cannot pause 'Spooler' service on computer '.'.

PS C:\Users\Jose Manuel> Restart-Service -Name WSearch -Confirm -PassThru

Confirm
Are you sure you want to perform this action?
Performing the operation "Restart-Service" on target "Windows Search (WSearch)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y

Status   Name               DisplayName
------   ----               -----------
Running  WSearch            Windows Search

PS C:\Users\Jose Manuel> Set-Service -Name dcsvc -DisplayName "Servicio de virtualizacion de credenciales de seguridad distribuidas"

PS C:\Users\Jose Manuel> Set-Service -Name BITS -StartupType Automatic -Confirm -PassThru | Select-Object Name, StartType

Confirm
Are you sure you want to perform this action?
Performing the operation "Set-Service" on target "Servicio de transferencia inteligente en segundo plano (BITS) (BITS)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y

Name StartType
---- ---------
BITS Automatic

PS C:\Users\Jose Manuel> Set-Service -Name BITS -Description "Transfiere archivos en segundo plano mediante el uso de ancho de banda de red inactivo"

PS C:\Users\Jose Manuel> Get-CimInstance Win32_Service -Filter 'Name = "BITS"' | Format-List Name, Description

Name        : BITS
Description : Transfiere archivos en segundo plano mediante el uso de ancho de banda de red inactivo

PS C:\Users\Jose Manuel> Set-Service -Name Spooler -Status Running -Confirm -PassThru

Confirm
Are you sure you want to perform this action?
Performing the operation "Set-Service" on target "Cola de impresión (Spooler)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y

Status   Name               DisplayName
------   ----               -----------
Running  Spooler            Cola de impresión
PS C:\Users\Jose Manuel> Set-Service -Name stisvc -Status Paused -Confirm -PassThru

Confirm
Are you sure you want to perform this action?
Performing the operation "Set-Service" on target "Adquisición de imágenes de Windows (WIA) (stisvc)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y
Set-Service: Service 'Adquisición de imágenes de Windows (WIA) (stisvc)' cannot be suspended because it is not currently running.
Set-Service: Service 'Adquisición de imágenes de Windows (WIA) (stisvc)' cannot be suspended due to the following error: Cannot pause 'stisvc' service on computer '.'.

Status   Name               DisplayName
------   ----               -----------
Stopped  stisvc             Adquisición de imágenes de Windows (W…

Confirm
Are you sure you want to perform this action?
Performing the operation "Set-Service" on target "Servicio de transferencia inteligente en segundo plano (BITS) (BITS)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y

Status   Name               DisplayName
------   ----               -----------
Stopped  BITS               Servicio de transferencia inteligente…

