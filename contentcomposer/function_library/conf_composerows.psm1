function buildComposerOWSConfig {
    <#
                    .SYNOPSIS
                    This script

                    .DESCRIPTION
                    Long description

                    .EXAMPLE
                    An example

                    .NOTES
                    General notes
                    #>
param (
    [string[]]$userInput
)
                 
$filePath = "E:\Program Files\ContentComposer\Composer.OWS.exe.config";

$enc = [System.Text.Encoding]::GetEncoding("UTF-8") # this results in encoding="utf-8"

if($userInput = $true)
{
    $scheme = Read-Host "Provide the scheme for your URLs (i.e. http or https): ";
    $FQDN = Read-Host "Provide the FQDN for your Content Composer Server: ";
    $port8010 = Read-Host "Provide the Port for your Content Composer Server: " ;
    $port8000 = Read-Host "Provide the STS Port:";
   # $portMwsRepo = Read-Host "Provide the MWS Port: ";
   # $portSts = Read-Host "Provide the STS Port: ";
   # $portMwsBR = Read-Host "Provide the MWS Basic/Rest Port: ";
   # $mwsSystemOId = Read-Host "Provide the mwsSystemOId: ";
} else {
    $scheme = "https"; # We are defaulting to https 
    $FQDN = "contentcomposer.com";
    $port8000 = "8000";
    $port8010 = "8010";
    #$port8011 = "8011";
    #$port8111 = "8111";
    #$mwsSystemOId = "";
}



$xmlWriter = New-Object System.XMl.XmlTextWriter($filePath,$enc);

$xmlWriter.Formatting = 'Indented'

$xmlWriter.Indentation = 1

$XmlWriter.IndentChar = "`t"
$xmlWriter.WriteStartDocument($false); # Setting to $false ensures that standalone=no
$xmlWriter.WriteStartElement('configuration');
$xmlWriter.WriteStartElement('configSections');

$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString('name','modusruntime');
$xmlWriter.WriteAttributeString('type','ModusSuite.Runtime.SystemFramework.RuntimeConfiguration, ModusSuite.Runtime.SystemFramework');
$xmlWriter.WriteEndElement(); # End the section element


$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString('name','odinSettings');
$xmlWriter.WriteAttributeString('type','ModusSuite.Odin.SystemFramework.OdinConfigurationSection, ModusSuite.Odin.SystemFramework');
$xmlWriter.WriteEndElement(); # End the section element

$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString('name','remotecontrol');
$xmlWriter.WriteAttributeString('type','ModusSuite.Runtime.SystemFramework.RemoteControlConfiguration, ModusSuite.Runtime.SystemFramework');
$xmlWriter.WriteEndElement(); # End the section element

$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString('name','Hyland.Logging');
$xmlWriter.WriteAttributeString('type','Hyland.Logging.Configuration.ClientConfigurationHandler,Hyland.Logging.Configuration');
$xmlWriter.WriteEndElement(); # End the section element

$xmlWriter.WriteEndElement(); # End the configSections element

<#
    startup
#>

$xmlWriter.WriteStartElement('startup');
$xmlWriter.WriteAttributeString('useLegacyV2RuntimeActivationPolicy','true');
$xmlWriter.WriteStartElement('supportedRuntime');
$xmlWriter.WriteAttributeString('version','v4.0');
$xmlWriter.WriteAttributeString('sku','.NETFramework,Version=v4.8');
$xmlWriter.WriteEndElement(); # End the supportedRuntime element
$xmlWriter.WriteEndElement(); # End the startup element

<#
    Hyland.Logging
#>

$xmlWriter.WriteStartElement('Hyland.Logging');
$xmlWriter.WriteStartElement('Routes');

<#
    CoCo_Standard
#>

$xmlWriter.WriteStartElement('Route');
$xmlWriter.WriteAttributeString('name','CoCo_Standard');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','minimum-level');
$xmlWriter.WriteAttributeString('value','Error');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','File');
$xmlWriter.WriteAttributeString('value','%composerdir%\Composer_OWS_log.txt');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','FileRollInterval');
$xmlWriter.WriteAttributeString('value','Day');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','FileRollOnSize');
$xmlWriter.WriteAttributeString('value','true');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','FileByteLimit');
$xmlWriter.WriteAttributeString('value','1000000');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','FileCountLimit');
$xmlWriter.WriteAttributeString('value','31');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','OutputFormat');
$xmlWriter.WriteAttributeString('value','Minimal');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','AllowUnknownKeys');
$xmlWriter.WriteAttributeString('value','');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','exclude-profiles');
$xmlWriter.WriteAttributeString('value','runtime_process');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the Route element

<#
    CoCo_Runtime_Process
#>

$xmlWriter.WriteStartElement('Route');
$xmlWriter.WriteAttributeString('name','CoCo_Runtime_Process');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','minimum-level');
$xmlWriter.WriteAttributeString('value','Information');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','File');
$xmlWriter.WriteAttributeString('value','%composerdir%\Composer_OWS_log.txt');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','FileRollInterval');
$xmlWriter.WriteAttributeString('value','Day');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','FileRollOnSize');
$xmlWriter.WriteAttributeString('value','true');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','FileByteLimit');
$xmlWriter.WriteAttributeString('value','1000000');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','FileCountLimit');
$xmlWriter.WriteAttributeString('value','31');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','OutputFormat');
$xmlWriter.WriteAttributeString('value','Minimal');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','AllowUnknownKeys');
$xmlWriter.WriteAttributeString('value','');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','include-profiles');
$xmlWriter.WriteAttributeString('value','runtime_process');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the Route element

$xmlWriter.WriteEndElement(); # End the Routes element

<#
    AuditRoutes
#>

$xmlWriter.WriteStartElement('AuditRoutes');
$xmlWriter.WriteComment('add a Route element here to create an audit log');
$xmlWriter.WriteEndElement(); # End the AuditRoutes element

$xmlWriter.WriteEndElement(); # End the Hyland.Logging element

<#
    appSettings
#>

$xmlWriter.WriteStartElement('appSettings');

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','disableDebugNamedPipe');
$xmlWriter.WriteAttributeString('value','runtime_process');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','rws');
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/rws");
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','sts');
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8000)/sts");
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','login');
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/mur/login");
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','mur');
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/mur/data");
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','Authenticate');
$xmlWriter.WriteAttributeString('value','0');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteComment('listen to object change notifications so outdated objects are removed from internal runtime cache');

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','rwsMulticastIP');
$xmlWriter.WriteAttributeString('value','224.100.0.1');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','rwsMulticastPort');
$xmlWriter.WriteAttributeString('value','9050');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','rwsMulticastTTL');
$xmlWriter.WriteAttributeString('value','50');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','ProtectedConfiguration');
$xmlWriter.WriteAttributeString('value','encryption_keys.config');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','EnableHylandLogging');
$xmlWriter.WriteAttributeString('value','False');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteEndElement(); # End the appSettings element

<#
    modsruntime
#>

$xmlWriter.WriteStartElement('modusruntime');
$xmlWriter.WriteAttributeString('enablecache','true');
$xmlWriter.WriteStartElement('runtimeservices');

$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString('name','repository');
$xmlWriter.WriteAttributeString('assembly','ModusSuite.Runtime.RepositoryService');
$xmlWriter.WriteAttributeString('type','ModusSuite.Runtime.RepositoryService');
$xmlWriter.WriteEndElement(); # End the service element

$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString('name','threading');
$xmlWriter.WriteAttributeString('assembly','ModusSuite.Runtime.ThreadingService');
$xmlWriter.WriteAttributeString('type','ModusSuite.Runtime.ThreadingService');
$xmlWriter.WriteEndElement(); # End the service element

$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString('name','timer');
$xmlWriter.WriteAttributeString('assembly','ModusSuite.Runtime.TimerService');
$xmlWriter.WriteAttributeString('type','ModusSuite.Runtime.TimerService');
$xmlWriter.WriteEndElement(); # End the service element

$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString('name','remotecontrol');
$xmlWriter.WriteAttributeString('assembly','ModusSuite.Runtime.RemoteControlService');
$xmlWriter.WriteAttributeString('type','ModusSuite.Runtime.RemoteControlService');
$xmlWriter.WriteEndElement(); # End the service element

$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString('name','ows');
$xmlWriter.WriteAttributeString('assembly','ModusSuite.OWS.RuntimeService');
$xmlWriter.WriteAttributeString('type','False');
$xmlWriter.WriteEndElement(); # End the service element

$xmlWriter.WriteComment("<service name=`"owsbasic`" assembly=`"ModusSuite.OWS.RuntimeService`" type=`"ModusSuite.OWS.OWSRuntimeServiceBasic`"/>");
$xmlWriter.WriteEndElement(); # End the runtimeservices element
$xmlWriter.WriteEndElement(); # End the modusruntime element

<#
    odinSettings
#>

$xmlWriter.WriteStartElement('odinSettings');
$xmlWriter.WriteAttributeString('configSource','odin.config');
$xmlWriter.WriteEndElement(); # End the odinSettings element

<#
    remotecontrol
#>

$xmlWriter.WriteStartElement('remotecontrol');
$xmlWriter.WriteAttributeString('address','http://127.0.0.1:4722/RemoteControlService');
$xmlWriter.WriteEndElement(); # End the remotecontrol element

<#
    runtime
#>

$xmlWriter.WriteStartElement('runtime');
$xmlWriter.WriteStartElement('generatePublisherEvidence');
$xmlWriter.WriteAttributeString('enabled','false');
$xmlWriter.WriteEndElement(); # End the generatePublisherEvidence element

$xmlWriter.WriteStartElement('assemblyBinding');
$xmlWriter.WriteAttributeString('xmlns','urn:schemas-microsoft-com:asm.v1');

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','Microsoft.Extensions.Logging.Abstractions');
$xmlWriter.WriteAttributeString('publicKeyToken','adb9793829ddae60');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-2.2.0.0');
$xmlWriter.WriteAttributeString('newVersion','2.2.0.0');
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','Microsoft.Extensions.Options');
$xmlWriter.WriteAttributeString('publicKeyToken','adb9793829ddae60');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-2.2.0.0');
$xmlWriter.WriteAttributeString('newVersion','2.2.0.0');
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','System.Runtime.CompilerServices.Unsafe');
$xmlWriter.WriteAttributeString('publicKeyToken','b03f5f7f11d50a3a');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-6.0.0.0');
$xmlWriter.WriteAttributeString('newVersion','6.0.0.0');
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','System.Memory');
$xmlWriter.WriteAttributeString('publicKeyToken','cc7b13ffcd2ddd51');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-4.0.1.2');
$xmlWriter.WriteAttributeString('newVersion','4.0.1.2');
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','System.Buffers');
$xmlWriter.WriteAttributeString('publicKeyToken','cc7b13ffcd2ddd51');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-4.0.3.0"');
$xmlWriter.WriteAttributeString('newVersion','4.0.3.0"');
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','System.Text.Encodings.Web');
$xmlWriter.WriteAttributeString('publicKeyToken','cc7b13ffcd2ddd51');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-6.0.0.0"');
$xmlWriter.WriteAttributeString('newVersion','6.0.0.0"');
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','IdentityModel');
$xmlWriter.WriteAttributeString('publicKeyToken','e7877f4675df049f');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-4.6.0.0');
$xmlWriter.WriteAttributeString('newVersion','4.6.0.0');
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','Newtonsoft.Json');
$xmlWriter.WriteAttributeString('publicKeyToken','30ad4fe6b2a6aeed');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-13.0.0.0');
$xmlWriter.WriteAttributeString('newVersion','13.0.0.0');
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteEndElement(); # End the assemblyBinding element
$xmlWriter.WriteEndElement(); # End the runtime element

<#
    system.data
#>

$xmlWriter.WriteStartElement('system.data');
$xmlWriter.WriteStartElement('DbProviderFactories');
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString('invariant','Oracle.DataAccess.Client');
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','ODP.NET, Unmanaged Driver');
$xmlWriter.WriteAttributeString('invariant','Oracle.DataAccess.Client');
$xmlWriter.WriteAttributeString('description','Oracle Data Provider for .NET, Unmanaged Driver');
$xmlWriter.WriteAttributeString('type','Oracle.DataAccess.Client.OracleClientFactory, Oracle.DataAccess, Version=4.122.19.1, Culture=neutral, PublicKeyToken=89b483f429c47342');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the DbProviderFactories element
$xmlWriter.WriteEndElement(); # End the system.data element

<#
    system.diagntostics
#>

$xmlWriter.WriteStartElement('system.diagnostics');
$xmlWriter.WriteStartElement('sources');

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString('name','mws');
$xmlWriter.WriteAttributeString('switchName','mws_switch');
$xmlWriter.WriteAttributeString('switchType','System.Diagnostics.SourceSwitch');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString('name','Default');
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','tracefile_listener');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString('name','rws');
$xmlWriter.WriteAttributeString('switchName','rws_switch');
$xmlWriter.WriteAttributeString('switchType','System.Diagnostics.SourceSwitch');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString('name','Default');
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','tracefile_listener');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString('name','runtime_process');
$xmlWriter.WriteAttributeString('switchName','runtime_switch');
$xmlWriter.WriteAttributeString('switchType','System.Diagnostics.SourceSwitch');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString('name','Default');
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','tracefile_listener');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString('name','runtime_components');
$xmlWriter.WriteAttributeString('switchName','runtime_switch');
$xmlWriter.WriteAttributeString('switchType','System.Diagnostics.SourceSwitch');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString('name','Default');
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','tracefile_listener');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString('name','monalisa');
$xmlWriter.WriteAttributeString('switchName','monalisa_switch');
$xmlWriter.WriteAttributeString('switchType','System.Diagnostics.SourceSwitch');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString('name','Default');
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','tracefile_listener');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString('name','odin');
$xmlWriter.WriteAttributeString('switchName','odin_switch');
$xmlWriter.WriteAttributeString('switchType','System.Diagnostics.SourceSwitch');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString('name','Default');
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','tracefile_listener');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteComment('This source is used by WCF');

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString('name','System.ServiceModel');
$xmlWriter.WriteAttributeString('switchValue','Critical,Error');
$xmlWriter.WriteAttributeString('propagateActivity','true');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','sdt');
$xmlWriter.WriteAttributeString('type','ModusSuite.Common.SystemFramework.XmlDailyTraceListener, ModusSuite.Common.SystemFramework');
$xmlWriter.WriteAttributeString('initializeData','Composer_OWS.svclog');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteEndElement(); # End the sources element

<#
    switches
#>

$xmlWriter.WriteStartElement('switches');

$xmlWriter.WriteComment("value=`"Error`": log only error-messages");
$xmlWriter.WriteComment("value=`"Off`": disable logging");

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','rws_switch');
$xmlWriter.WriteAttributeString('value','Error');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','mws_switch');
$xmlWriter.WriteAttributeString('value','Error');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','runtime_switch');
$xmlWriter.WriteAttributeString('value','Error');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','monalisa_switch');
$xmlWriter.WriteAttributeString('value','Error');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','odin_switch');
$xmlWriter.WriteAttributeString('value','Error');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteEndElement(); # End the switches element

<#
    sharedListeners
#>

$xmlWriter.WriteStartElement('sharedListeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','eventlog_listener');
$xmlWriter.WriteAttributeString('value','System.Diagnostics.EventLogTraceListener');
$xmlWriter.WriteAttributeString('initializeData','Anwendung');
$xmlWriter.WriteComment('he filter effects, that only error messages will traced in the Event-Log');
$xmlWriter.WriteStartElement('filter');
$xmlWriter.WriteAttributeString('type','odin_switch');
$xmlWriter.WriteAttributeString('initializeData','Error');
$xmlWriter.WriteEndElement(); # End the filter element
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','tracefile_listener');
$xmlWriter.WriteAttributeString('type','ModusSuite.Common.SystemFramework.DailyTraceListener, ModusSuite.Common.SystemFramework');
$xmlWriter.WriteAttributeString('delimiter',';');
$xmlWriter.WriteAttributeString('initializeData','Composer_OWS_log.txt');
$xmlWriter.WriteAttributeString('traceOutputOptions','DateTime');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the sharedListeners element

<#
    trace
#>

$xmlWriter.WriteStartElement('trace');
$xmlWriter.WriteAttributeString('autoflush','true');
$xmlWriter.WriteEndElement(); # End the trace element

$xmlWriter.WriteEndElement(); # End the system.diagnostics element

<#
    system.serviceModel
#>

$xmlWriter.WriteStartElement('system.serviceModel');

<#
    diagnostics
#>

$xmlWriter.WriteStartElement('diagnostics');
$xmlWriter.WriteAttributeString('wmiProviderEnabled','false');
$xmlWriter.WriteStartElement('messageLogging');
$xmlWriter.WriteAttributeString('logMalformedMessages','false');
$xmlWriter.WriteAttributeString('logMessagesAtServiceLevel','false');
$xmlWriter.WriteAttributeString('logEntireMessage','false');
$xmlWriter.WriteAttributeString('logMessagesAtTransportLevel','false');
$xmlWriter.WriteEndElement(); # End the messageLogging element
$xmlWriter.WriteEndElement(); # End the diagnostics element

<#
    services
#>

$xmlWriter.WriteStartElement('services');

$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString('name','ModusSuite.OWS.OWSService');
$xmlWriter.WriteAttributeString('behaviorConfiguration','ModusSuiteServiceBehaviour');
$xmlWriter.WriteStartElement('host');
$xmlWriter.WriteStartElement('baseAddresses');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('baseAddress',"$($scheme)://$($FQDN):$($port8010)/ows");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the baseAddresses element
$xmlWriter.WriteEndElement(); # End the host element
$xmlWriter.WriteStartElement('endpoint');
$xmlWriter.WriteAttributeString('address','owsrepository');
$xmlWriter.WriteAttributeString('binding','wsHttpBinding');
$xmlWriter.WriteAttributeString('bindingConfiguration','TokenBinding');
$xmlWriter.WriteAttributeString('contract','IOWSService');
$xmlWriter.WriteEndElement(); # End the endpoint element
$xmlWriter.WriteEndElement(); # End the service element

$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString('name','ModusSuite.OWS.OWSServiceBasic');
$xmlWriter.WriteAttributeString('behaviorConfiguration','BasicBehaviour');
$xmlWriter.WriteStartElement('host');
$xmlWriter.WriteStartElement('baseAddresses');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('baseAddress',"$($scheme)://$($FQDN):$($port8010)/owsbasic");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the baseAddresses element
$xmlWriter.WriteEndElement(); # End the host element
$xmlWriter.WriteStartElement('endpoint');
$xmlWriter.WriteAttributeString('address','owsrepository');
$xmlWriter.WriteAttributeString('binding','basicHttpBinding');
$xmlWriter.WriteAttributeString('bindingConfiguration','BasicBinding');
$xmlWriter.WriteAttributeString('contract','IOWSService');
$xmlWriter.WriteEndElement(); # End the endpoint element
$xmlWriter.WriteEndElement(); # End the service element

$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString('name','false');
$xmlWriter.WriteAttributeString('behaviorConfiguration','false');
$xmlWriter.WriteStartElement('endpoint');
$xmlWriter.WriteAttributeString('address','http://127.0.0.1:4722/RemoteControlService');
$xmlWriter.WriteAttributeString('binding','wsDualHttpBinding');
$xmlWriter.WriteAttributeString('bindingConfiguration','RemoteControlBinding');
$xmlWriter.WriteAttributeString('contract','ModusSuite.Runtime.RemoteControlContract.IRuntimeControlService');
$xmlWriter.WriteEndElement(); # End the endpoint element
$xmlWriter.WriteEndElement(); # End the service element

$xmlWriter.WriteEndElement(); # End the services element

<#
    bindings
#>

$wsHttpBindingrws = @"
Settings for the communication with the repository (rws)
DON'T DELETE the binding element, because the element will read out
at the creation of the channel.
"@

$xmlWriter.WriteStartElement('bindings');

<#
    wsHttpBinding
#>

$xmlWriter.WriteStartElement('wsHttpBinding');
$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString('name','TokenBinding');
$xmlWriter.WriteAttributeString('maxBufferPoolSize','2147483600');
$xmlWriter.WriteAttributeString('maxReceivedMessageSize','2147483600');
$xmlWriter.WriteAttributeString('receiveTimeout','Infinite');
$xmlWriter.WriteStartElement('readerQuotas');
$xmlWriter.WriteAttributeString('maxStringContentLength','2147483647');
$xmlWriter.WriteAttributeString('maxArrayLength','2147483647');
$xmlWriter.WriteEndElement(); # End the readerQuotas element
$xmlWriter.WriteStartElement('security');
$xmlWriter.WriteAttributeString('mode','Message');
$xmlWriter.WriteStartElement('message');
$xmlWriter.WriteAttributeString('clientCredentialType','IssuedToken');
$xmlWriter.WriteEndElement(); # End the message element
$xmlWriter.WriteEndElement(); # End the security element
$xmlWriter.WriteEndElement(); # End the binding element

$xmlWriter.WriteComment($wsHttpBindingrws);

$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString('name','wsDualHttpBinding');
$xmlWriter.WriteAttributeString('sendTimeout','wsDualHttpBinding');
$xmlWriter.WriteEndElement(); # End the binding element

$xmlWriter.WriteEndElement(); # End the wsHttpBinding element


<#
    wsDualHttpBinding
#>

$xmlWriter.WriteStartElement('wsDualHttpBinding');
$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString('name','RemoteControlBinding');
$xmlWriter.WriteAttributeString('clientBaseAddress','http://127.0.0.1:8000/RemoteControlClient/');
$xmlWriter.WriteAttributeString('maxBufferPoolSize','2147483600');
$xmlWriter.WriteAttributeString('maxReceivedMessageSize','2147483600');
$xmlWriter.WriteAttributeString('receiveTimeout','Infinite');
$xmlWriter.WriteAttributeString('sendTimeout','Infinite');
$xmlWriter.WriteStartElement('security');
$xmlWriter.WriteAttributeString('mode','None');
$xmlWriter.WriteEndElement(); # End the security element
$xmlWriter.WriteEndElement(); # End the binding element

$xmlWriter.WriteEndElement(); # End the wsDualHttpBinding element

<#
    basicHttpBinding
#>

$xmlWriter.WriteStartElement('basicHttpBinding');
$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString('name','BasicBinding');
$xmlWriter.WriteAttributeString('maxBufferPoolSize','2147483600');
$xmlWriter.WriteAttributeString('maxReceivedMessageSize','2147483600');
$xmlWriter.WriteAttributeString('receiveTimeout','Infinite');
$xmlWriter.WriteStartElement('readerQuotas');
$xmlWriter.WriteAttributeString('maxStringContentLength','2147483647');
$xmlWriter.WriteAttributeString('maxArrayLength','2147483647');
$xmlWriter.WriteEndElement(); # End the readerQuotas element
$xmlWriter.WriteStartElement('security');
$xmlWriter.WriteAttributeString('mode','None');
$xmlWriter.WriteEndElement(); # End the security element
$xmlWriter.WriteEndElement(); # End the binding element

$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString('name','wsDualHttpBinding');
$xmlWriter.WriteAttributeString('sendTimeout','wsDualHttpBinding');
$xmlWriter.WriteEndElement(); # End the binding element

$xmlWriter.WriteEndElement(); # End the basicHttpBinding element

$xmlWriter.WriteEndElement(); # End the bindings element

<#
    behaviors
#>

$xmlWriter.WriteStartElement('behaviors');

$serviceCredsStsServer =@"
The serviceCredentials behavior allows one to define validation parameters for issued tokens.
This configuration adds the `"composer.server`" certificate to a list of known certificates. This
means that the service will accept tokens issued by `"STS`".
"@


$serviceCredsStsService =@"
The serviceCredentials behavior allows one to define a service certificate.
A service certificate is used by a client to authenticate the service and provide message protection.
This configuration references the `"composer.service`" certificate installed during setup of the sample.
"@

$xmlWriter.WriteStartElement('behavior');
$xmlWriter.WriteAttributeString('name','ModusSuiteServiceBehaviour');
$xmlWriter.WriteStartElement('serviceThrottling');
$xmlWriter.WriteAttributeString('maxConcurrentCalls','1000000');
$xmlWriter.WriteAttributeString('maxConcurrentInstances','1000000');
$xmlWriter.WriteAttributeString('maxConcurrentSessions','1000000');
$xmlWriter.WriteEndElement(); # End the serviceThrottling element
$xmlWriter.WriteStartElement('serviceDebug');
$xmlWriter.WriteAttributeString('includeExceptionDetailInFaults','true');
$xmlWriter.WriteEndElement(); # End the serviceDebug element
$xmlWriter.WriteStartElement('serviceMetadata');
$xmlWriter.WriteAttributeString('httpGetEnabled','true');
$xmlWriter.WriteEndElement(); # End the serviceMetadata element
$xmlWriter.WriteStartElement('serviceCredentials');
$xmlWriter.WriteComment($serviceCredsStsServer);
$xmlWriter.WriteStartElement('issuedTokenAuthentication');
$xmlWriter.WriteStartElement('knownCertificates');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('storeLocation','LocalMachine');
$xmlWriter.WriteAttributeString('storeName','TrustedPeople');
$xmlWriter.WriteAttributeString('x509FindType','FindBySubjectDistinguishedName');
$xmlWriter.WriteAttributeString('findValue','CN=composer.server');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the knownCertificates element
$xmlWriter.WriteEndElement(); # End the issuedTokenAuthentication element
$xmlWriter.WriteComment($serviceCredsStsService);
$xmlWriter.WriteStartElement('serviceCertificate');
$xmlWriter.WriteAttributeString('storeLocation','LocalMachine');
$xmlWriter.WriteAttributeString('storeName','My');
$xmlWriter.WriteAttributeString('x509FindType','FindBySubjectDistinguishedName');
$xmlWriter.WriteAttributeString('findValue','CN=composer.service');
$xmlWriter.WriteEndElement(); # End the serviceCertificate element
$xmlWriter.WriteEndElement(); # End the serviceCredentials element
$xmlWriter.WriteEndElement(); # End the behavior element

$xmlWriter.WriteStartElement('behavior');
$xmlWriter.WriteAttributeString('name','BasicBehaviour');
$xmlWriter.WriteStartElement('serviceThrottling');
$xmlWriter.WriteAttributeString('maxConcurrentCalls','1000000');
$xmlWriter.WriteAttributeString('maxConcurrentInstances','1000000');
$xmlWriter.WriteAttributeString('maxConcurrentSessions','1000000');
$xmlWriter.WriteEndElement(); # End the serviceThrottling element
$xmlWriter.WriteStartElement('serviceDebug');
$xmlWriter.WriteAttributeString('maxConcurrentCalls','true');
$xmlWriter.WriteEndElement(); # End the serviceDebug element
$xmlWriter.WriteStartElement('serviceMetadata');
$xmlWriter.WriteAttributeString('includeExceptionDetailInFaults','true');
$xmlWriter.WriteEndElement(); # End the serviceMetadata element
$xmlWriter.WriteEndElement(); # End the behavior element

$xmlWriter.WriteEndElement(); # End the behaviors element



$xmlWriter.WriteEndElement(); # End the system.serviceModel element

$xmlWriter.WriteEndElement(); # End the configuration element

$xmlWriter.WriteEndDocument();
$xmlWriter.Flush();

$xmlWriter.Close();

# $xmlWriter.WriteComment('');

}

Export-ModuleMember -Function buildComposerOWSConfig;