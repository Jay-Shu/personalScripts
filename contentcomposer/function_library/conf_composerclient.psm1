<#
    This script contains the actual configurations.
    We are making this function.
#>

function buildComposerClientExeConfig {

    #param (
    #    
    #)
    param (
    [string[]]$userInput
)
    $filePath = "E:\Program Files\ContentComposer\Composer.Client.exe.config";

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
        $odenViewSystemOId = Read-Host "Provide the Oden View System OID: ";
       # $portMwsRepo = Read-Host "Provide the MWS Port: ";
       # $portSts = Read-Host "Provide the STS Port: ";
       # $portMwsBR = Read-Host "Provide the MWS Basic/Rest Port: ";
       # $mwsSystemOId = Read-Host "Provide the mwsSystemOId: ";
    } else {
        $scheme = "https"; # We are defaulting to https 
        $FQDN = "contentcomposer.com";
        $port8000 = "8000";
        $port8010 = "8010";
        $port8011 = "8011";
        # $port8111 = "8111";
        $odenViewSystemOId = "odin";
        # $mwsSystemOId = "";
    }
    

    if(!$odenViewSystemOId)
    {
        $odenViewSystemOId = "odin"
    }

<#

$enc = [System.Text.Encoding]::GetEncoding(28591) # iso-8859-1

# UTF-8 worked when tried, so therefore the result is
# encoding="utf-8" within the declaration.

 #>
$enc = [System.Text.Encoding]::GetEncoding("UTF-8") 

$xmlWriter = New-Object System.XMl.XmlTextWriter($filePath,$enc);
# $xmlWriter = New-Object System.XMl.XmlTextWriter($filePath,$NULL);
$xmlWriter.Formatting = 'Indented'

# $settings = New-Object System.XML.XmlWriterSettings
# $settings.Encoding.UTF8

$xmlWriter.Indentation = 1

$XmlWriter.IndentChar = "`t"
$xmlWriter.WriteStartDocument($false); # Setting to $false ensures that standalone=no
$xmlWriter.WriteStartElement('configuration');
$xmlWriter.WriteStartElement('configSections');
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString('name','CompositeUI');
$xmlWriter.WriteAttributeString('type','Microsoft.Practices.CompositeUI.Configuration.SettingsSection, Microsoft.Practices.CompositeUI');
$xmlWriter.WriteAttributeString('allowExeDefinition','MachineToLocalUser');
$xmlWriter.WriteEndElement(); # End the Section element
$xmlWriter.WriteStartElement('sectionGroup');
$xmlWriter.WriteAttributeString('name','userSettings');
$xmlWriter.WriteAttributeString('type','System.Configuration.UserSettingsGroup, System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089');
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString('name','ModusSuite.Studio.Properties.Settings');
$xmlWriter.WriteAttributeString('type','System.Configuration.ClientSettingsSection, System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089');
$xmlWriter.WriteAttributeString('allowExeDefinition','MachineToLocalUser');
$xmlWriter.WriteAttributeString('requirePermission','false');
$xmlWriter.WriteEndElement(); # End the Section element
$xmlWriter.WriteEndElement(); # End the Section group element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString('name','PropertyEditor');
$xmlWriter.WriteAttributeString('type','ModusSuite.Common.PropertyEditors.PropertyEditorConfiguration, ModusSuite.Common.PropertyEditors');
$xmlWriter.WriteEndElement(); # End the Section element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString('name','Hyland.Logging');
$xmlWriter.WriteAttributeString('type','Hyland.Logging.Configuration.ClientConfigurationHandler,Hyland.Logging.Configuration');
$xmlWriter.WriteEndElement(); # End the Section element
$xmlWriter.WriteEndElement(); # End the Config Sections Element
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
$xmlWriter.WriteAttributeString('value','%composerdir%\Composer.Client_Log.txt');
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
$xmlWriter.WriteAttributeString('value','monalisa,textsystem,odin,modusstudio,xdata,mwsclient');
$xmlWriter.WriteEndElement(); # End the Add Element
$xmlWriter.WriteEndElement(); # End the route element
$xmlWriter.WriteStartElement('Route');
$xmlWriter.WriteAttributeString('name','CoCo_OutputWindow');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','minimum-level');
$xmlWriter.WriteAttributeString('value','Information');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','File');
$xmlWriter.WriteAttributeString('value','%composerdir%\Composer.Client_Log.txt');
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
$xmlWriter.WriteAttributeString('value','Json');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','AllowUnknownKeys');
$xmlWriter.WriteAttributeString('value','');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','include-profiles');
$xmlWriter.WriteAttributeString('value','monalisa,textsystem,odin,modusstudio,xdata,mwsclient');
$xmlWriter.WriteEndElement(); # End the Add Element
$xmlWriter.WriteEndElement(); # End the Route Element

$xmlWriter.WriteEndElement(); # End the Routes Element

$xmlWriter.WriteEndElement(); # End the Hyland.Logging Element

$xmlWriter.WriteStartElement('appSettings');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key',"sts");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8000)/sts");
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key',"login");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/mur/login");
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key',"mur");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/mur/data");
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key',"license");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/mur/license");
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key',"mwsrws");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/mws/mwsrepository");
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key',"mws");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8011)/mws/mwsprocess");
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key',"dpws");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/dataprovider");
$xmlWriter.WriteEndElement(); # end the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key',"ows");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/ows/owsrepository");
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key',"odinviewsystemoid");
$xmlWriter.WriteAttributeString('value',"$($odenViewSystemOId)");
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','odinviewdbalias');
$xmlWriter.WriteAttributeString('value','odin');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','useInternalDocumentViewer');
$xmlWriter.WriteAttributeString('value','False');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','WordUpdateTOC');
$xmlWriter.WriteAttributeString('value','true');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','showProcessOptions');
$xmlWriter.WriteAttributeString('value','true');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','EnableHylandLogging');
$xmlWriter.WriteAttributeString('value','False');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteEndElement(); # End the appSettings Element

$xmlWriter.WriteStartElement('CompositeUI');
$xmlWriter.WriteStartElement('services');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('serviceType','Microsoft.Practices.CompositeUI.Services.IAuthenticationService, Microsoft.Practices.CompositeUI');
$xmlWriter.WriteAttributeString('instanceType','ModusSuite.Common.CAB.AuthenticationService, ModusSuite.Common.CAB.ClientAuthenticationService');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteEndElement(); # End the services Element
$xmlWriter.WriteEndElement(); # End the CompositeUI Element

$xmlWriter.WriteStartElement('PropertyEditor');
$xmlWriter.WriteAttributeString('configSource','ModusSuite.Common.PropertyEditors.dll.config');
$xmlWriter.WriteEndElement(); # End the PropertyEditor Element

$xmlWriter.WriteStartElement('runtime');
$xmlWriter.WriteStartElement('generatePublisherEvidence');
$xmlWriter.WriteAttributeString('enabled','false');
$xmlWriter.WriteEndElement(); # End the generatePublisherEvidence Element

$xmlWriter.WriteStartElement('assemblyBinding');
$xmlWriter.WriteAttributeString('xmlns','urn:schemas-microsoft-com:asm.v1');

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','Microsoft.Extensions.Logging.Abstractions');
$xmlWriter.WriteAttributeString('publicKeyToken','adb9793829ddae60');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity Element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-2.2.0.0');
$xmlWriter.WriteAttributeString('newVersion','2.2.0.0');
$xmlWriter.WriteEndElement(); # End the bindingRedirect Element
$xmlWriter.WriteEndElement(); # End the dependentAssembly Element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','Microsoft.Extensions.Options');
$xmlWriter.WriteAttributeString('publicKeyToken','adb9793829ddae60');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity Element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-2.2.0.0');
$xmlWriter.WriteAttributeString('newVersion','2.2.0.0');
$xmlWriter.WriteEndElement(); # End the bindingRedirect Element
$xmlWriter.WriteEndElement(); # End the dependentAssembly Element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','System.Runtime.CompilerServices.Unsafe');
$xmlWriter.WriteAttributeString('publicKeyToken','b03f5f7f11d50a3a');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity Element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-6.0.0.0');
$xmlWriter.WriteAttributeString('newVersion','6.0.0.0');
$xmlWriter.WriteEndElement(); # End the bindingRedirect Element
$xmlWriter.WriteEndElement(); # End the dependentAssembly Element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','System.Memory');
$xmlWriter.WriteAttributeString('publicKeyToken','cc7b13ffcd2ddd51');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity Element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-4.0.1.2');
$xmlWriter.WriteAttributeString('newVersion','4.0.1.2');
$xmlWriter.WriteEndElement(); # End the bindingRedirect Element
$xmlWriter.WriteEndElement(); # End the dependentAssembly Element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','System.Buffers');
$xmlWriter.WriteAttributeString('publicKeyToken','cc7b13ffcd2ddd51');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity Element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-4.0.3.0');
$xmlWriter.WriteAttributeString('newVersion','4.0.3.0');
$xmlWriter.WriteEndElement(); # End the bindingRedirect Element
$xmlWriter.WriteEndElement(); # End the dependentAssembly Element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','System.Text.Encodings.Web');
$xmlWriter.WriteAttributeString('publicKeyToken','cc7b13ffcd2ddd51');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity Element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-6.0.0.0');
$xmlWriter.WriteAttributeString('newVersion','6.0.0.0');
$xmlWriter.WriteEndElement(); # End the bindingRedirect Element
$xmlWriter.WriteEndElement(); # End the dependentAssembly Element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','IdentityModel');
$xmlWriter.WriteAttributeString('publicKeyToken','e7877f4675df049f');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity Element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-4.6.0.0');
$xmlWriter.WriteAttributeString('newVersion','4.6.0.0');
$xmlWriter.WriteEndElement(); # End the bindingRedirect Element
$xmlWriter.WriteEndElement(); # End the dependentAssembly Element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','Newtonsoft.Json');
$xmlWriter.WriteAttributeString('publicKeyToken','30ad4fe6b2a6aeed');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity Element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString('oldVersion','0.0.0.0-13.0.0.0');
$xmlWriter.WriteAttributeString('newVersion','13.0.0.0');
$xmlWriter.WriteEndElement(); # End the bindingRedirect Element
$xmlWriter.WriteEndElement(); # End the dependentAssembly Element

$xmlWriter.WriteEndElement(); # End the assemblyBinding Element
$xmlWriter.WriteEndElement(); # End the runtime Element
<#
    system.diagnostics
#>
$xmlWriter.WriteStartElement('system.diagnostics');

<#
    sources
#>
$xmlWriter.WriteStartElement('sources');
$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString('name','mws');
$xmlWriter.WriteAttributeString('switchName','mws_switch');
$xmlWriter.WriteAttributeString('switchType','System.Diagnostics.SourceSwitch');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString('name','Default');
$xmlWriter.WriteComment('<add name="tracefile_listener"/>')
$xmlWriter.WriteEndElement(); # End the remove Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','outputmanager_listener');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteEndElement(); # End the listeners Element
$xmlWriter.WriteEndElement(); # End the source Element
$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString('name','odin');
$xmlWriter.WriteAttributeString('switchName','odin_switch');
$xmlWriter.WriteAttributeString('switchType','System.Diagnostics.SourceSwitch');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString('name','Default');
$xmlWriter.WriteComment('<add name="tracefile_listener"/>')
$xmlWriter.WriteEndElement(); # End the remove Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','outputmanager_listener');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteEndElement(); # End the listeners Element
$xmlWriter.WriteEndElement(); # End the source Element
$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString('name','modusstudio');
$xmlWriter.WriteAttributeString('switchName','studio_switch');
$xmlWriter.WriteAttributeString('switchType','System.Diagnostics.SourceSwitch');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString('name','Default');
$xmlWriter.WriteComment('<add name="tracefile_listener"/>')
$xmlWriter.WriteEndElement(); # End the remove Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','outputmanager_listener');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteEndElement(); # End the listeners Element
$xmlWriter.WriteEndElement(); # End the source Element
$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString('name','mwsclient');
$xmlWriter.WriteAttributeString('switchName','mwsclient_switch');
$xmlWriter.WriteAttributeString('switchType','System.Diagnostics.SourceSwitch');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString('name','Default');
$xmlWriter.WriteComment('<add name="tracefile_listener"/>')
$xmlWriter.WriteEndElement(); # End the remove Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','outputmanager_listener');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteEndElement(); # End the listeners Element
$xmlWriter.WriteEndElement(); # End the source Element
$xmlWriter.WriteComment('<add name="tracefile_listener"/>')
$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString('name','Microsoft.Practices.CompositeUI.EventBroker.EventTopic');
$xmlWriter.WriteAttributeString('switchName','cab_switch');
$xmlWriter.WriteAttributeString('switchType','System.Diagnostics.SourceSwitch');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString('name','Default');
$xmlWriter.WriteComment('This source is used by the EventTopic class of CAB to log raised exceptions on Fire for example.')
$xmlWriter.WriteEndElement(); # End the remove Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','tracefile_listener');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteEndElement(); # End the listeners Element
$xmlWriter.WriteEndElement(); # End the source Element
$xmlWriter.WriteEndElement(); # End the sources Element

<#
    Switches
#>
$xmlWriter.WriteStartElement('switches');
$xmlWriter.WriteComment('<add name="test_switch" value="1"/>')
$xmlWriter.WriteComment('You can set the level at which tracing is to occur')
$xmlWriter.WriteComment('You can turn tracing off')
$xmlWriter.WriteComment('<add name="test_switch" value="Off"/>')
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','mws_switch');
$xmlWriter.WriteAttributeString('value','Information');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','odin_switch');
$xmlWriter.WriteAttributeString('value','Information');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','studio_switch');
$xmlWriter.WriteAttributeString('value','Information');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','mwsclient_switch');
$xmlWriter.WriteAttributeString('value','Information');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','cab_switch');
$xmlWriter.WriteAttributeString('value','Off');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteComment('You have to set here "Information" to trace EventTopic exceptions')
$xmlWriter.WriteEndElement(); # End the switches Element

<#
    sharedListeners
#>

$xmlWriter.WriteStartElement('sharedListeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','outputmanager_listener');
$xmlWriter.WriteAttributeString('type','ModusSuite.Studio.OutputManager.Types.OutputWindowTraceListener, ModusSuite.Studio.OutputManager, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','tracefile_listener');
$xmlWriter.WriteAttributeString('type','ModusSuite.Common.SystemFramework.DailyTraceListener, ModusSuite.Common.SystemFramework');
$xmlWriter.WriteAttributeString('delimiter',';');
$xmlWriter.WriteAttributeString('initializeData','Composer.Client_Log.txt');
$xmlWriter.WriteAttributeString('traceOutputOptions','DateTime');
$xmlWriter.WriteEndElement(); # End the add Element
$xmlWriter.WriteEndElement(); # End the sharedListeners Element

<#
    trace
#>

$xmlWriter.WriteStartElement('trace');
$xmlWriter.WriteAttributeString('autoflush','true');
$xmlWriter.WriteEndElement(); # End the trace Element

$xmlWriter.WriteEndElement(); # End the system.diagnostics Element

<#
    userSettings
#>
$xmlWriter.WriteStartElement('userSettings');
$xmlWriter.WriteStartElement('ModusSuite.Studio.Properties.Settings');
$xmlWriter.WriteStartElement('setting');
$xmlWriter.WriteAttributeString('name','Layout');
$xmlWriter.WriteAttributeString('serializeAs','String');
$xmlWriter.WriteStartElement('value');
$xmlWriter.WriteEndElement(); # End the value Element
$xmlWriter.WriteEndElement(); # End the setting Element
$xmlWriter.WriteEndElement(); # End the ModusSuite.Studio.Properties.Settings Element
$xmlWriter.WriteEndElement(); # End the userSettings Element

<#
    system.serviceModel
#>
$xmlWriter.WriteStartElement('system.serviceModel');
$xmlWriter.WriteComment('For debugging purposes set the includeExceptionDetailInFaults attribute to true')
$xmlWriter.WriteStartElement('bindings');
$xmlWriter.WriteStartElement('wsHttpBinding');
$xmlWriter.WriteComment('time client will wait for a response from mws services')
$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString('name','mws');
$xmlWriter.WriteAttributeString('sendTimeout','00:05:00');
$xmlWriter.WriteEndElement(); # End the binding Element
$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString('name','mwsrws');
$xmlWriter.WriteAttributeString('sendTimeout','00:05:00');
$xmlWriter.WriteEndElement(); # End the binding Element

$xmlWriter.WriteEndElement(); # End the wsHttpBinding Element
$xmlWriter.WriteComment('Binding for the Debugger')
$xmlWriter.WriteStartElement('wsDualHttpBinding');
$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString('name','DebugClientBinding');
$xmlWriter.WriteAttributeString('clientBaseAddress','http://localhost:4711/DebugClient/');
$xmlWriter.WriteAttributeString('sendTimeout','Infinite');
$xmlWriter.WriteAttributeString('receiveTimeout','Infinite');
$xmlWriter.WriteAttributeString('maxBufferPoolSize','2147483600');
$xmlWriter.WriteAttributeString('maxReceivedMessageSize','2147483600');
$xmlWriter.WriteStartElement('readerQuotas');
$xmlWriter.WriteAttributeString('maxStringContentLength','1003741824');
$xmlWriter.WriteAttributeString('maxArrayLength','2147483647');
$xmlWriter.WriteEndElement(); # End the readerQuotas Element
$xmlWriter.WriteStartElement('security');
$xmlWriter.WriteAttributeString('mode','None');
$xmlWriter.WriteEndElement(); # End the security Element
$xmlWriter.WriteEndElement(); # End the binding Element
$xmlWriter.WriteEndElement(); # End the wsDualHttpBinding Element
$xmlWriter.WriteEndElement(); # End the bindings Element

$xmlWriter.WriteStartElement('client');
$xmlWriter.WriteStartElement('endpoint');
$xmlWriter.WriteAttributeString('name','ModusSuite.Runtime.DebugService');
$xmlWriter.WriteAttributeString('address','http://127.0.0.1:8012/RemoteDebugger');
$xmlWriter.WriteAttributeString('binding','wsDualHttpBinding');
$xmlWriter.WriteAttributeString('bindingConfiguration','DebugClientBinding');
$xmlWriter.WriteAttributeString('contract','ModusSuite.Runtime.Types.IDebugService');
$xmlWriter.WriteEndElement(); # End the endpoint Element
$xmlWriter.WriteEndElement(); # End the client Element

$xmlWriter.WriteEndElement(); # End the system.serviceModel Element


$xmlWriter.WriteEndElement(); # End the configuration Element
$xmlWriter.WriteEndDocument();

$xmlWriter.Flush();

$xmlWriter.Close();

}


Export-ModuleMember -Function buildComposerClientExeConfig;