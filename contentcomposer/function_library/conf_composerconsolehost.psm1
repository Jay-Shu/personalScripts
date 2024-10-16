function buildComposerConsoleHostConfig {

    #param (
    #    
    #)

$filePath = "E:\Program Files\ContentComposer\Composer.ConsoleHost.exe.config";

param (
    [string[]]$userInput
)

if(!$userInput)
    {
        $userInput = $true;
    }

if($userInput = $true)
{
    $scheme = Read-Host "Provide the scheme for your URLs (i.e. http or https): ";
    $FQDN = Read-Host "Provide the FQDN for your Content Composer Server: ";
    $port8000 = Read-Host "Provide the STS Port:";
    $port8010 = Read-Host "Provide the Port for your Content Composer Server: " ;
    # $port8111 = "8111";
} else {
    $scheme = "https";
    $FQDN = "contentcomposer.com";
    $port8000 = "8000";
    $port8010 = "8010";
    # $port8011 = "8011";
    # $port8111 = "8111";
    # $mwsSystemOId = "mws";
}


if(!$odenViewSystemOId)
{
    $odenViewSystemOId = "odin"
}


# $enc = [System.Text.Encoding]::GetEncoding(28591) # iso-8859-1
$enc = [System.Text.Encoding]::GetEncoding("UTF-8") # this results in encoding="utf-8"

$xmlWriter = New-Object System.XMl.XmlTextWriter($filePath,$enc);
#$xmlWriter = New-Object System.XMl.XmlTextWriter($filePath,$NULL);
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
$xmlWriter.WriteAttributeString('name','xdata');
$xmlWriter.WriteAttributeString('type','ModusSuite.Xdata.SystemFramework.XdataConfiguration, ModusSuite.Xdata.SystemFramework');
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString('name','odinSettings');
$xmlWriter.WriteAttributeString('type','ModusSuite.Odin.SystemFramework.OdinConfigurationSection, ModusSuite.Odin.SystemFramework');
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString('name','Hyland.Logging');
$xmlWriter.WriteAttributeString('type','Hyland.Logging.Configuration.ClientConfigurationHandler,Hyland.Logging.Configuration');
$xmlWriter.WriteEndElement(); # End the section element

$xmlWriter.WriteStartElement('startup');
$xmlWriter.WriteAttributeString('useLegacyV2RuntimeActivationPolicy','true');
$xmlWriter.WriteStartElement('supportedRuntime');
$xmlWriter.WriteAttributeString('version','v4.0');
$xmlWriter.WriteAttributeString('sku','.NETFramework,Version=v4.8');
$xmlWriter.WriteEndElement(); # End the supportedRuntime element
$xmlWriter.WriteEndElement(); # End the startup element

$xmlWriter.WriteStartElement('Hyland.Logging');
$xmlWriter.WriteStartElement('Routes');
$xmlWriter.WriteStartElement('Route');
$xmlWriter.WriteAttributeString('name','CoCo_Standard');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','minimum-level');
$xmlWriter.WriteAttributeString('value','Error');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','File');
$xmlWriter.WriteAttributeString('value','%composerdir%\Composer_ConsoleHost_log.txt');
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
$xmlWriter.WriteAttributeString('key','exclude-profiles');
$xmlWriter.WriteAttributeString('value','monalisa,textsystem');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','AllowUnknownKeys');
$xmlWriter.WriteAttributeString('value','');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the Route element
$xmlWriter.WriteStartElement('Route');
$xmlWriter.WriteAttributeString('name','CoCo_Monalisa');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','minimum-level');
$xmlWriter.WriteAttributeString('value','Information');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','File');
$xmlWriter.WriteAttributeString('value','%composerdir%\Composer_ConsoleHost_log.txt');
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
$xmlWriter.WriteAttributeString('key','include-profiles');
$xmlWriter.WriteAttributeString('value','.NETFramework,Version=v4.8');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','AllowUnknownKeys');
$xmlWriter.WriteAttributeString('value','');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the Route element
$xmlWriter.WriteStartElement('Route');
$xmlWriter.WriteAttributeString('name','CoCo_Textsystem');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','minimum-level');
$xmlWriter.WriteAttributeString('value','Information');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','File');
$xmlWriter.WriteAttributeString('value','%composerdir%\Composer_ConsoleHost_log.txt');
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
$xmlWriter.WriteAttributeString('key','include-profiles');
$xmlWriter.WriteAttributeString('value','textsystem');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','AllowUnknownKeys');
$xmlWriter.WriteAttributeString('value','');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the Route element
$xmlWriter.WriteEndElement(); # End the Routes element
$xmlWriter.WriteEndElement(); # End the Hyland.Logging element

$xmlWriter.WriteStartElement('appSettings');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','rws');
$xmlWriter.WriteAttributeString('value','');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','ows');
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/ows/owsrepository");
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
$xmlWriter.WriteAttributeString('key','odinparameterfile');
$xmlWriter.WriteAttributeString('value','odinparameter.config');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','disableDebugNamedPipe');
$xmlWriter.WriteAttributeString('value','1');
$xmlWriter.WriteComment('listen to object change notifications so outdated objects are removed from internal runtime cache');
$xmlWriter.WriteEndElement(); # End the add element
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
    Modus Runtime
#>
$xmlWriter.WriteStartElement('modusruntime');
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
$xmlWriter.WriteEndElement(); # End the runtimeservices element

$xmlWriter.WriteStartElement('processes');
$xmlWriter.WriteComment('each process-element represents a process that will be started');
$xmlWriter.WriteComment('');
$xmlWriter.WriteComment('<process name="ModBatch_XmlFile" reference="ModBatch_XmlFile|29012008-13-prc-modb|2048|Process|None|modstd_megatron"/>');
$xmlWriter.WriteEndElement(); # End the processes element
$xmlWriter.WriteComment('all referenced processes in the specified alias tables will be started');
$xmlWriter.WriteStartElement('aliastables');
$xmlWriter.WriteComment('<aliastable name="batchProcesses" systemoid="mod5processes"/>');
$xmlWriter.WriteEndElement(); # End the aliastables element
$xmlWriter.WriteEndElement(); # End the modusruntime element

<#
    Xdata 
#>
$xmlWriter.WriteStartElement('xdata');
$xmlWriter.WriteAttributeString('configSource','xdata.config');
$xmlWriter.WriteEndElement(); # End the xdata element

<#
    odinSettings
#>

$xmlWriter.WriteStartElement('odinSettings');
$xmlWriter.WriteAttributeString('configSource','odin.config');
$xmlWriter.WriteEndElement(); # End the odinSettings element

<#
    Runtime
#>

$xmlWriter.WriteStartElement('runtime');
$xmlWriter.WriteStartElement('generatePublisherEvidence');
$xmlWriter.WriteAttributeString('enabled','false');
$xmlWriter.WriteEndElement(); # End the generatePublisherEvidence element
<#
    Assembly Binding
#>

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
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-4.0.3.0');
$xmlWriter.WriteAttributeString('newVersion','4.0.3.0');
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element
$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','System.Text.Encodings.Web');
$xmlWriter.WriteAttributeString('publicKeyToken','cc7b13ffcd2ddd51');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-6.0.0.0');
$xmlWriter.WriteAttributeString('newVersion','6.0.0.0');
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
$xmlWriter.WriteAttributeString('name','false');
$xmlWriter.WriteAttributeString('publicKeyToken','false');
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
    system.diagnostics
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
$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString('name','xdata');
$xmlWriter.WriteAttributeString('switchName','xdata_switch');
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
$xmlWriter.WriteAttributeString('name','textsystem');
$xmlWriter.WriteAttributeString('switchName','textsystem_switch');
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
$xmlWriter.WriteAttributeString('switchValue','Critical,Error,Error');
$xmlWriter.WriteAttributeString('propagateActivity','true');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','sdt');
$xmlWriter.WriteAttributeString('type','ModusSuite.Common.SystemFramework.XmlDailyTraceListener, ModusSuite.Common.SystemFramework');
$xmlWriter.WriteAttributeString('initializeData','RuntimeConsoleHost_wcf.svclog');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteEndElement(); # End the sources element

$xmlWriter.WriteStartElement('switches');
$xmlWriter.WriteComment('value="Error": log only error-messages');
$xmlWriter.WriteComment('value="Off": disable logging');
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
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','xdata_switch');
$xmlWriter.WriteAttributeString('value','Error');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','textsystem_switch');
$xmlWriter.WriteAttributeString('value','Error');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the switches element

$xmlWriter.WriteStartElement('sharedListeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','eventlog_listener');
$xmlWriter.WriteAttributeString('type','System.Diagnostics.EventLogTraceListener');
$xmlWriter.WriteAttributeString('initializeData','Anwendung');
$xmlWriter.WriteComment('The filter effects, that only error messages will traced in the Event-Log');
$xmlWriter.WriteStartElement('filter');
$xmlWriter.WriteAttributeString('type','System.Diagnostics.EventTypeFilter');
$xmlWriter.WriteAttributeString('initializeData','Error');
$xmlWriter.WriteEndElement(); # End the filter element
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the sharedListeners element

$xmlWriter.WriteStartElement('trace');
$xmlWriter.WriteAttributeString('autoflush','true');
$xmlWriter.WriteEndElement(); # End the trace element

$xmlWriter.WriteEndElement(); # End the system.diagnostics element


$xmlWriter.WriteStartElement('system.serviceModel');
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
    bindings
#>

$xmlWriter.WriteStartElement('bindings');
$xmlWriter.WriteStartElement('wsHttpBinding')
$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString('name','mws');
$xmlWriter.WriteAttributeString('receiveTimeout','00:05:00');
$xmlWriter.WriteAttributeString('sendTimeout','00:05:00');
$xmlWriter.WriteEndElement(); # End the binding element;
$xmlWriter.WriteComment("configuration for monalisa extension 'MLMwsClient'");
$xmlComment = @"
Settings for the communication with the repository (rws)
DON'T DELETE the binding element, because the element will
read out at the creation of the channel
"@;

$xmlWriter.WriteComment($xmlComment);
$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString('name','rws');
$xmlWriter.WriteAttributeString('sendTimeout','00:05:00');
$xmlWriter.WriteEndElement(); # End the binding element;
$xmlWriter.WriteEndElement(); # End the wsHttpBinding element
$xmlWriter.WriteStartElement('wsDualHttpBinding');
$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString('name','DebugBinding');
$xmlWriter.WriteAttributeString('maxBufferPoolSize','2147483600');
$xmlWriter.WriteAttributeString('maxReceivedMessageSize','2147483600');
$xmlWriter.WriteAttributeString('receiveTimeout','Infinite');
$xmlWriter.WriteAttributeString('sendTimeout','Infinite');
$xmlWriter.WriteStartElement('security');
$xmlWriter.WriteAttributeString('mode','None');
$xmlWriter.WriteEndElement(); # End the security element;
$xmlWriter.WriteStartElement('readerQuotas');
$xmlWriter.WriteAttributeString('maxStringContentLength','2147483647');
$xmlWriter.WriteAttributeString('maxArrayLength','2147483647');
$xmlWriter.WriteEndElement(); # End the readerQuotas element;
$xmlWriter.WriteEndElement(); # End the binding element;
$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString('name','RemoteControlBinding');
$xmlWriter.WriteAttributeString('maxBufferPoolSize','2147483600');
$xmlWriter.WriteAttributeString('maxReceivedMessageSize','2147483600');
$xmlWriter.WriteAttributeString('receiveTimeout','Infinite');
$xmlWriter.WriteAttributeString('sendTimeout','Infinite');
$xmlWriter.WriteStartElement('security');
$xmlWriter.WriteAttributeString('mode','None');
$xmlWriter.WriteEndElement(); # End the security element;
$xmlWriter.WriteEndElement(); # End the binding element;
$xmlWriter.WriteEndElement(); # End the wsDualHttpBinding element
$xmlWriter.WriteEndElement(); # End the bindings element

$xmlWriter.WriteEndElement(); # End the system.serviceModel element

$xmlWriter.WriteEndElement(); # End the configSections element
$xmlWriter.WriteEndElement(); # End the configuration element

$xmlWriter.WriteEndDocument();
$xmlWriter.Flush();

$xmlWriter.Close();
}

Export-ModuleMember -Function buildComposerConsoleHostConfig;