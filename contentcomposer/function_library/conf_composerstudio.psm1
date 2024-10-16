function buildComposerStudioConfig {
    <#
                    .SYNOPSIS
                    Short description

                    .DESCRIPTION
                    Long description

                    .EXAMPLE
                    An example

                    .NOTES
                    General notes
                    #>
    #param (
    #    
    #)

$filePath = "E:\Program Files\ContentComposer\Composer.Studio.exe.config";

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

<#
    configSections
#>

$xmlWriter.WriteStartElement('configSections');
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString("name","CompositeUI");
$xmlWriter.WriteAttributeString("type","Microsoft.Practices.CompositeUI.Configuration.SettingsSection, Microsoft.Practices.CompositeUI");
$xmlWriter.WriteAttributeString("allowExeDefinition","MachineToLocalUser");
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString("name","modusruntime");
$xmlWriter.WriteAttributeString("type","ModusSuite.Runtime.SystemFramework.RuntimeConfiguration, ModusSuite.Runtime.SystemFramework");
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString("name","mws");
$xmlWriter.WriteAttributeString("type","ModusSuite.MWS.SystemFramework.Configuration, ModusSuite.MWS.SystemFramework");
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString("name","xdata");
$xmlWriter.WriteAttributeString("type","ModusSuite.Xdata.SystemFramework.XdataConfiguration, ModusSuite.Xdata.SystemFramework");
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString("name","remotecontrol");
$xmlWriter.WriteAttributeString("type","ModusSuite.Runtime.RemoteControlSystemFramework.RemoteControlConfiguration, ModusSuite.Runtime.RemoteControlSystemFramework");
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString("name","inputmaskpresets");
$xmlWriter.WriteAttributeString("type","ModusSuite.Studio.ModusEditor.Types.PresetConfigurationSection, ModusSuite.Studio.ModusEditor");
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteStartElement('sectionGroup');
$xmlWriter.WriteAttributeString("name","userSettings");
$xmlWriter.WriteAttributeString("type","System.Configuration.UserSettingsGroup, System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089");
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString("name","ModusSuite.Studio.Properties.Settings");
$xmlWriter.WriteAttributeString("type","System.Configuration.ClientSettingsSection, System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089");
$xmlWriter.WriteAttributeString("allowExeDefinition","MachineToLocalUser");
$xmlWriter.WriteAttributeString("requirePermission","false");
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString("name","ModusSuite.Studio.Navigator.Properties.Settings");
$xmlWriter.WriteAttributeString("type","System.Configuration.ClientSettingsSection, System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089");
$xmlWriter.WriteAttributeString("allowExeDefinition","MachineToLocalUser");
$xmlWriter.WriteAttributeString("requirePermission","false");
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteEndElement(); # End the sectionGroup element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString("name","dbalias");
$xmlWriter.WriteAttributeString("type","ModusSuite.Common.ConnectionStringEditor.SqlTemplateConfigurationSection, ModusSuite.Common.ConnectionStringEditor");
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString("name","PropertyEditor");
$xmlWriter.WriteAttributeString("type","ModusSuite.Common.PropertyEditors.PropertyEditorConfiguration, ModusSuite.Common.PropertyEditors");
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString("name","odinSettings");
$xmlWriter.WriteAttributeString("type","ModusSuite.Odin.SystemFramework.OdinConfigurationSection, ModusSuite.Odin.SystemFramework");
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString("name","Hyland.Logging");
$xmlWriter.WriteAttributeString("type","Hyland.Logging.Configuration.ClientConfigurationHandler,Hyland.Logging.Configuration");
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteEndElement(); # End the configSections element

<#
    startup
#>

$xmlWriter.WriteStartElement('startup');
$xmlWriter.WriteAttributeString("name","useLegacyV2RuntimeActivationPolicy");
$xmlWriter.WriteAttributeString("type","true");
$xmlWriter.WriteStartElement('supportedRuntime');
$xmlWriter.WriteAttributeString("version","odinSettings");
$xmlWriter.WriteAttributeString("sku","ModusSuite.Odin.SystemFramework.OdinConfigurationSection, ModusSuite.Odin.SystemFramework");
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
$xmlWriter.WriteAttributeString("name","CoCo_Standard");
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","minimum-level");
$xmlWriter.WriteAttributeString("value","Error");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","File");
$xmlWriter.WriteAttributeString("value","%composerdir%\Composer.Studio_Log.txt");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","FileRollInterval");
$xmlWriter.WriteAttributeString("value","Day");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","FileRollOnSize");
$xmlWriter.WriteAttributeString("value","true");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","FileByteLimit");
$xmlWriter.WriteAttributeString("value","1000000");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","FileCountLimit");
$xmlWriter.WriteAttributeString("value","31");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","OutputFormat");
$xmlWriter.WriteAttributeString("value","Minimal");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","AllowUnknownKeys");
$xmlWriter.WriteAttributeString("value","");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","exclude-profiles");
$xmlWriter.WriteAttributeString("value","monalisa,textsystem,odin,modusstudio,xdata");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the Route element

<#
    CoCo_OutputWindow
#>

$xmlWriter.WriteStartElement('Route');
$xmlWriter.WriteAttributeString("name","CoCo_OutputWindow");
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","minimum-level");
$xmlWriter.WriteAttributeString("value","Information");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","File");
$xmlWriter.WriteAttributeString("value","%composerdir%\Composer.Studio_Log.txt");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","FileRollInterval");
$xmlWriter.WriteAttributeString("value","Day");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","FileRollOnSize");
$xmlWriter.WriteAttributeString("value","true");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","FileByteLimit");
$xmlWriter.WriteAttributeString("value","1000000");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","FileCountLimit");
$xmlWriter.WriteAttributeString("value","31");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","OutputFormat");
$xmlWriter.WriteAttributeString("value","Minimal");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","AllowUnknownKeys");
$xmlWriter.WriteAttributeString("value","");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","include-profiles");
$xmlWriter.WriteAttributeString("value","monalisa,textsystem,odin,modusstudio,xdata");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the Route element

$xmlWriter.WriteEndElement(); # End the Routes element
$xmlWriter.WriteEndElement(); # End the Hyland.Logging element


<#
    appSettings
#>

$xmlWriter.WriteStartElement('appSettings');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","wordtemplate");
$xmlWriter.WriteAttributeString("value","%Composerdir%Normal.dotm");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","reportwordtemplate");
$xmlWriter.WriteAttributeString("value","%Composerdir%Report.docx");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","sts");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8000)/sts");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","login");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/mur/login");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","license");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/mur/license");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","rws");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/rws");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","mwsrws");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/mws/mwsrepository");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","dpws");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/dataprovider");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","odinparameterfile");
$xmlWriter.WriteAttributeString("value","odinparameter.config");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","ows");
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/ows/owsrepository");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","useInternalDocumentViewer");
$xmlWriter.WriteAttributeString("value","False");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","WordForcePrintView");
$xmlWriter.WriteAttributeString("value","True");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","manVarResultXmlElementType");
$xmlWriter.WriteAttributeString("value","manvar2");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","ProtectedConfiguration");
$xmlWriter.WriteAttributeString("value","encryption_keys.config");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("key","EnableHylandLogging");
$xmlWriter.WriteAttributeString("value","False");
$xmlWriter.WriteEndElement(); # End the add element

$rwsMultiCast = @"
<add key=`"rwsMulticastIP`" value=`"224.100.0.1`" /> 
<add key=`"rwsMulticastPort`" value=`"9050`" /> 
<add key=`"rwsMulticastTTL`" value=`"50`" /> 
"@

$xmlWriter.WriteComment($rwsMultiCast);
$xmlWriter.WriteEndElement(); # End the appSettings element

<#
    modsruntime
#>

$xmlWriter.WriteStartElement('modsruntime');
$xmlWriter.WriteStartElement('runtimeservices');
$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString("name","repository");
$xmlWriter.WriteAttributeString("assembly","ModusSuite.Runtime.RepositoryService");
$xmlWriter.WriteAttributeString("type","ModusSuite.Runtime.RepositoryService");
$xmlWriter.WriteEndElement(); # End the service
$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString("name","threading");
$xmlWriter.WriteAttributeString("assembly","ModusSuite.Runtime.ThreadingService");
$xmlWriter.WriteAttributeString("type","ModusSuite.Runtime.ThreadingService");
$xmlWriter.WriteEndElement(); # End the service
$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString("name","timer");
$xmlWriter.WriteAttributeString("assembly","ModusSuite.Runtime.TimerService");
$xmlWriter.WriteAttributeString("type","ModusSuite.Runtime.TimerService");
$xmlWriter.WriteEndElement(); # End the service
$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString("name","debugger");
$xmlWriter.WriteAttributeString("assembly","ModusSuite.Runtime.DebugService");
$xmlWriter.WriteAttributeString("type","ModusSuite.Runtime.DebugService");
$xmlWriter.WriteEndElement(); # End the service
$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString("name","mws");
$xmlWriter.WriteAttributeString("assembly","ModusSuite.Runtime.MWSRuntimeService");
$xmlWriter.WriteAttributeString("type","ModusSuite.Runtime.MWSRuntimeService");
$xmlWriter.WriteEndElement(); # End the service
$xmlWriter.WriteEndElement(); # End the runtimeservices
$xmlWriter.WriteEndElement(); # End the modsruntime

<#
    CompositeUI
#>

$xmlWriter.WriteStartElement('CompositeUI');
$xmlWriter.WriteStartElement('services');
$xmlWriter.WriteEndElement(); # End the services element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("serviceType","Microsoft.Practices.CompositeUI.Services.IAuthenticationService, Microsoft.Practices.CompositeUI");
$xmlWriter.WriteAttributeString("instanceType","ModusSuite.Common.CAB.AuthenticationService, ModusSuite.Common.CAB.ClientAuthenticationService");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the CompositeUI element


<#
    odinSettings
#>

$xmlWriter.WriteStartElement('odinSettings');
$xmlWriter.WriteAttributeString("configSource","odin.config");
$xmlWriter.WriteEndElement(); # End the odinSettings element

<#
    mws
#>

$xmlWriter.WriteStartElement('mws');
$xmlWriter.WriteAttributeString("systemoid","mws");
$xmlWriter.WriteAttributeString("dbalias","mws");
$xmlWriter.WriteAttributeString("process","mws_standard");
$xmlWriter.WriteAttributeString("client_runtime_mode","true");
$xmlWriter.WriteEndElement(); # End the mws element

<#
    remotecontrol
#>

$xmlWriter.WriteStartElement('remotecontrol');
$xmlWriter.WriteAttributeString("configSource","remotecontrol.config");
$xmlWriter.WriteEndElement(); # End the remotecontrol element

<#
    xdata
#>

$xmlWriter.WriteStartElement('xdata');
$xmlWriter.WriteAttributeString("configSource","xdata.config");
$xmlWriter.WriteEndElement(); # End the xdata element

<#
    dbalias
#>

$xmlWriter.WriteStartElement('dbalias');
$xmlWriter.WriteAttributeString("configSource","dbalias.config");
$xmlWriter.WriteEndElement(); # End the dbalias element

<#
    inputmaskpresets
#>

$xmlWriter.WriteStartElement('inputmaskpresets');
$xmlWriter.WriteAttributeString("configSource","inputmasks.config");
$xmlWriter.WriteEndElement(); # End the inputmaskpresets element

<#
    PropertyEditor
#>

$xmlWriter.WriteStartElement('PropertyEditor');
$xmlWriter.WriteAttributeString("configSource","ModusSuite.Common.PropertyEditors.dll.config");
$xmlWriter.WriteEndElement(); # End the PropertyEditor element

<#
    runtime
#>

$xmlWriter.WriteStartElement('runtime');
$xmlWriter.WriteStartElement('generatePublisherEvidence');
$xmlWriter.WriteAttributeString("enabled","false");
$xmlWriter.WriteEndElement(); # End the generatePublisherEvidence element
$xmlWriter.WriteStartElement('assemblyBinding');
$xmlWriter.WriteAttributeString("xmlns","urn:schemas-microsoft-com:asm.v1");

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString("name","Newtonsoft.Json");
$xmlWriter.WriteAttributeString("publicKeyToken","30ad4fe6b2a6aeed");
$xmlWriter.WriteAttributeString("culture","neutral");
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString("oldVersion","0.0.0.0-13.0.0.0");
$xmlWriter.WriteAttributeString("newVersion","13.0.0.0");
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString("name","System.IdentityModel.Tokens.Jwt");
$xmlWriter.WriteAttributeString("publicKeyToken","31bf3856ad364e35");
$xmlWriter.WriteAttributeString("culture","neutral");
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString("oldVersion","0.0.0.0-6.5.1.0");
$xmlWriter.WriteAttributeString("newVersion","6.5.1.0");
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString("name","Microsoft.IdentityModel.Tokens");
$xmlWriter.WriteAttributeString("publicKeyToken","31bf3856ad364e35");
$xmlWriter.WriteAttributeString("culture","neutral");
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString("oldVersion","0.0.0.0-6.5.1.0");
$xmlWriter.WriteAttributeString("newVersion","6.5.1.0");
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString("name","Microsoft.Extensions.Logging");
$xmlWriter.WriteAttributeString("publicKeyToken","adb9793829ddae60");
$xmlWriter.WriteAttributeString("culture","neutral");
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString("oldVersion","0.0.0.0-2.2.0.0");
$xmlWriter.WriteAttributeString("newVersion","false");
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString("name","Microsoft.Extensions.Logging.Abstractions");
$xmlWriter.WriteAttributeString("publicKeyToken","adb9793829ddae60");
$xmlWriter.WriteAttributeString("culture","neutral");
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString("oldVersion","0.0.0.0-2.2.0.0");
$xmlWriter.WriteAttributeString("newVersion","2.1.1.0");
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString("name","Microsoft.Extensions.Options");
$xmlWriter.WriteAttributeString("publicKeyToken","adb9793829ddae60");
$xmlWriter.WriteAttributeString("culture","neutral");
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString("oldVersion","0.0.0.0-2.2.0.0");
$xmlWriter.WriteAttributeString("newVersion","2.2.0.0");
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString("name","System.Runtime.CompilerServices.Unsafe");
$xmlWriter.WriteAttributeString("publicKeyToken","b03f5f7f11d50a3a");
$xmlWriter.WriteAttributeString("culture","neutral");
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString("oldVersion","0.0.0.0-6.0.0.0");
$xmlWriter.WriteAttributeString("newVersion","6.0.0.0");
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString("name","System.Memory");
$xmlWriter.WriteAttributeString("publicKeyToken","cc7b13ffcd2ddd51");
$xmlWriter.WriteAttributeString("culture","neutral");
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString("oldVersion","0.0.0.0-4.0.1.2");
$xmlWriter.WriteAttributeString("newVersion","4.0.1.2");
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString("name","System.Buffers");
$xmlWriter.WriteAttributeString("publicKeyToken","cc7b13ffcd2ddd51");
$xmlWriter.WriteAttributeString("culture","neutral");
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString("oldVersion","0.0.0.0-4.0.3.0");
$xmlWriter.WriteAttributeString("newVersion","4.0.3.0");
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString("name","System.Text.Encodings.Web");
$xmlWriter.WriteAttributeString("publicKeyToken","cc7b13ffcd2ddd51");
$xmlWriter.WriteAttributeString("culture","neutral");
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString("oldVersion","0.0.0.0-6.0.0.0");
$xmlWriter.WriteAttributeString("newVersion","6.0.0.0");
$xmlWriter.WriteEndElement(); # End the bindingRedirect element
$xmlWriter.WriteEndElement(); # End the dependentAssembly element

$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString("name","IdentityModel");
$xmlWriter.WriteAttributeString("publicKeyToken","e7877f4675df049f");
$xmlWriter.WriteAttributeString("culture","neutral");
$xmlWriter.WriteEndElement(); # End the assemblyIdentity element
$xmlWriter.WriteStartElement('bindingRedirect');
$xmlWriter.WriteAttributeString("oldVersion","0.0.0.0-4.6.0.0");
$xmlWriter.WriteAttributeString("newVersion","4.6.0.0");
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
$xmlWriter.WriteAttributeString("invariant","Oracle.DataAccess.Client");
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","ODP.NET, Unmanaged Driver");
$xmlWriter.WriteAttributeString("invariant","Oracle.DataAccess.Client");
$xmlWriter.WriteAttributeString("description","Oracle Data Provider for .NET, Unmanaged Driver");
$xmlWriter.WriteAttributeString("type","Oracle.DataAccess.Client.OracleClientFactory, Oracle.DataAccess, Version=4.122.19.1, Culture=neutral, PublicKeyToken=89b483f429c47342");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the DbProviderFactories element

$xmlWriter.WriteEndElement(); # End the system.data element

<#
    system.diagnostics
#>

$xmlWriter.WriteStartElement('system.diagnostics');
$xmlWriter.WriteStartElement('sources');

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString("name","mws");
$xmlWriter.WriteAttributeString("switchName","runtime_switch");
$xmlWriter.WriteAttributeString("switchType","System.Diagnostics.SourceSwitch");
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString("name","Default");
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString("name","xdata");
$xmlWriter.WriteAttributeString("switchName","xdata_switch");
$xmlWriter.WriteAttributeString("switchType","System.Diagnostics.SourceSwitch");
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString("name","Default");
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString("name","modusstudio");
$xmlWriter.WriteAttributeString("switchName","studio_switch");
$xmlWriter.WriteAttributeString("switchType","System.Diagnostics.SourceSwitch");
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","outputmanager_listener");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString("name","Default");
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString("name","monalisa");
$xmlWriter.WriteAttributeString("switchName","monalisa_switch");
$xmlWriter.WriteAttributeString("switchType","System.Diagnostics.SourceSwitch");
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","outputmanager_listener");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString("name","Default");
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteComment('This source is used by the Runtime processes');

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString("name","runtime_process");
$xmlWriter.WriteAttributeString("switchName","runtime_switch");
$xmlWriter.WriteAttributeString("switchType","System.Diagnostics.SourceSwitch");
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString("name","Default");
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString("name","runtime_components");
$xmlWriter.WriteAttributeString("switchName","runtime_switch");
$xmlWriter.WriteAttributeString("switchType","System.Diagnostics.SourceSwitch");
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString("name","Default");
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString("name","odin");
$xmlWriter.WriteAttributeString("switchName","odin_switch");
$xmlWriter.WriteAttributeString("switchType","System.Diagnostics.SourceSwitch");
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString("name","Default");
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString("name","textsystem");
$xmlWriter.WriteAttributeString("switchName","textsystem_switch");
$xmlWriter.WriteAttributeString("switchType","System.Diagnostics.SourceSwitch");
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","outputmanager_listener");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString("name","Default");
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString("name","mur");
$xmlWriter.WriteAttributeString("switchName","mur_switch");
$xmlWriter.WriteAttributeString("switchType","System.Diagnostics.SourceSwitch");
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","outputmanager_listener");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString("name","Default");
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteComment('This source is used by the EventTopic class of CAB to log raised exceptions on Fire for example.');


$xmlWriter.WriteStartElement('source');
$xmlWriter.WriteAttributeString("name","Microsoft.Practices.CompositeUI.EventBroker.EventTopic");
$xmlWriter.WriteAttributeString("switchName","cab_switch");
$xmlWriter.WriteAttributeString("switchType","System.Diagnostics.SourceSwitch");
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString("name","Default");
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element

$xmlWriter.WriteEndElement(); # End the sources element

<#
    switches
#>

$xmlWriter.WriteStartElement('switches');
$xmlWriter.WriteComment("<add name=`"test_switch`" value=`"1`" />");
$xmlWriter.WriteComment('You can set the level at which tracing is to occur');
$xmlWriter.WriteComment('You can turn tracing off');
$xmlWriter.WriteComment("add name=`"test_switch`" value=`"Off`"");

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","runtime_switch");
$xmlWriter.WriteAttributeString("value","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","odin_switch");
$xmlWriter.WriteAttributeString("value","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","xdata_switch");
$xmlWriter.WriteAttributeString("value","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","studio_switch");
$xmlWriter.WriteAttributeString("value","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","monalisa_switch");
$xmlWriter.WriteAttributeString("value","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","mur_switch");
$xmlWriter.WriteAttributeString("value","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","cab_switch");
$xmlWriter.WriteAttributeString("value","tracefile_listener");
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteComment("You have to set here `"Information`" to trace EventTopic exceptions");

$xmlWriter.WriteEndElement(); # End the switches element

<#
    sharedListeners
#>

$xmlWriter.WriteStartElement('sharedListeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","outputmanager_listener");
$xmlWriter.WriteAttributeString("type","ModusSuite.Studio.OutputManager.Types.OutputWindowTraceListener, ModusSuite.Studio.OutputManager, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString("name","tracefile_listener");
$xmlWriter.WriteAttributeString("type","ModusSuite.Common.SystemFramework.DailyTraceListener, ModusSuite.Common.SystemFramework");
$xmlWriter.WriteAttributeString("delimiter",";");
$xmlWriter.WriteAttributeString("initializeData","Composer.Studio_Log.txt");
$xmlWriter.WriteAttributeString("traceOutputOptions","DateTime");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the sharedListeners element

<#
    trace
#>

$xmlWriter.WriteStartElement('trace');
$xmlWriter.WriteAttributeString("autoflush","true");
$xmlWriter.WriteEndElement(); # End the trace element

$xmlWriter.WriteEndElement(); # End the system.diagnostics element

<#
    userSettings
#>

$xmlWriter.WriteStartElement('userSettings');

$xmlWriter.WriteStartElement('ModusSuite.Studio.Properties.Settings');
$xmlWriter.WriteStartElement('setting');
$xmlWriter.WriteAttributeString("name","Layout");
$xmlWriter.WriteAttributeString("serializeAs","String");
$xmlWriter.WriteStartElement('value');
$xmlWriter.WriteEndElement(); # End the value element
$xmlWriter.WriteEndElement(); # End the setting element
$xmlWriter.WriteEndElement(); # End the ModusSuite.Studio.Properties.Settings element
$xmlWriter.WriteStartElement('ModusSuite.Studio.Navigator.Properties.Settings');
$xmlWriter.WriteStartElement('setting');
$xmlWriter.WriteAttributeString("name","NavigatorMaxRowsPerPage");
$xmlWriter.WriteAttributeString("serializeAs","String");
$xmlWriter.WriteStartElement('value');
$xmlWriter.WriteElementString('-1');
$xmlWriter.WriteEndElement(); # End the value element
$xmlWriter.WriteEndElement(); # End the setting element
$xmlWriter.WriteEndElement(); # End the ModusSuite.Studio.Navigator.Properties.Settings element

$xmlWriter.WriteEndElement(); # End the userSettings element

<#
    system.serviceModel
#>

$xmlWriter.WriteStartElement('system.serviceModel');
$xmlWriter.WriteStartElement('client');

$xmlWriter.WriteStartElement('endpoint');
$xmlWriter.WriteAttributeString("name","RemoteControlServiceXWS");
$xmlWriter.WriteAttributeString("address","http://localhost:4723/RemoteControlService");
$xmlWriter.WriteAttributeString("binding","wsDualHttpBinding");
$xmlWriter.WriteAttributeString("bindingConfiguration","Binding1");
$xmlWriter.WriteAttributeString("contract","ModusSuite.Runtime.RemoteControlContract.IRuntimeControlService");
$xmlWriter.WriteEndElement(); # End the endpoint element


$xmlWriter.WriteStartElement('endpoint');
$xmlWriter.WriteAttributeString("name","RemoteControlServiceOWS");
$xmlWriter.WriteAttributeString("address","http://localhost:4722/RemoteControlService");
$xmlWriter.WriteAttributeString("binding","wsDualHttpBinding");
$xmlWriter.WriteAttributeString("bindingConfiguration","Binding1");
$xmlWriter.WriteAttributeString("contract","ModusSuite.Runtime.RemoteControlContract.IRuntimeControlService");
$xmlWriter.WriteEndElement(); # End the endpoint element


$xmlWriter.WriteStartElement('endpoint');
$xmlWriter.WriteAttributeString("name","RemoteControlServiceMWS");
$xmlWriter.WriteAttributeString("address","http://localhost:4721/RemoteControlService");
$xmlWriter.WriteAttributeString("binding","wsDualHttpBinding");
$xmlWriter.WriteAttributeString("bindingConfiguration","Binding1");
$xmlWriter.WriteAttributeString("contract","ModusSuite.Runtime.RemoteControlContract.IRuntimeControlService");
$xmlWriter.WriteEndElement(); # End the endpoint element


$xmlWriter.WriteStartElement('endpoint');
$xmlWriter.WriteAttributeString("name","RemoteControlServiceCore");
$xmlWriter.WriteAttributeString("address","http://localhost:4720/RemoteControlService");
$xmlWriter.WriteAttributeString("binding","wsDualHttpBinding");
$xmlWriter.WriteAttributeString("bindingConfiguration","Binding1");
$xmlWriter.WriteAttributeString("contract","ModusSuite.Runtime.RemoteControlContract.IRuntimeControlService");
$xmlWriter.WriteEndElement(); # End the endpoint element

$xmlWriter.WriteEndElement(); # End the client element

<#
    bindings
#>

$xmlWriter.WriteStartElement('bindings');

<#
    wsDualHttpBinding
#>

$xmlWriter.WriteStartElement('wsDualHttpBinding');
$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString("name","Binding1");
$xmlWriter.WriteAttributeString("clientBaseAddress","http://localhost:8000/RemoteControlClient/");
$xmlWriter.WriteAttributeString("maxBufferPoolSize","2147483600");
$xmlWriter.WriteAttributeString("maxReceivedMessageSize","2147483600");
$xmlWriter.WriteAttributeString("receiveTimeout","Infinite");
$xmlWriter.WriteAttributeString("sendTimeout","Infinite");
$xmlWriter.WriteStartElement('readerQuotas');
$xmlWriter.WriteAttributeString("maxStringContentLength","2147483647");
$xmlWriter.WriteAttributeString("maxArrayLength","2147483647");
$xmlWriter.WriteEndElement(); # End the readerQuotas element
$xmlWriter.WriteStartElement('security');
$xmlWriter.WriteAttributeString("mode","None");
$xmlWriter.WriteEndElement(); # End the security element
$xmlWriter.WriteEndElement(); # End the binding element
$xmlWriter.WriteEndElement(); # End the wsDualHttpBinding element


<#
    wsHttpBinding
#>

$xmlWriter.WriteStartElement('wsHttpBinding');
$xmlWriter.WriteComment("Settings for the communication with the repository (rws)
DON'T DELETE the binding element, because the element will read out
at the creation of the channel");
$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString("name","rws");
$xmlWriter.WriteAttributeString("sendTimeout","00:05:00");
$xmlWriter.WriteEndElement(); # End the binding element
$xmlWriter.WriteStartElement('binding');
$xmlWriter.WriteAttributeString("name","mws");
$xmlWriter.WriteAttributeString("receiveTimeout","00:05:00");
$xmlWriter.WriteAttributeString("sendTimeout","00:05:00");
$xmlWriter.WriteEndElement(); # End the binding element
$xmlWriter.WriteComment("For debugging purposes set the includeExceptionDetailInFaults attribute to true");
$xmlWriter.WriteEndElement(); # End the wsHttpBinding element

$xmlWriter.WriteEndElement(); # End the bindings element

<#
    behaviors
#>

$xmlWriter.WriteStartElement('behaviors');
$xmlWriter.WriteStartElement('serviceBehaviors');
$xmlWriter.WriteStartElement('behavior');
$xmlWriter.WriteAttributeString("name","DebugServiceBehavior");
$xmlWriter.WriteStartElement('serviceThrottling');
$xmlWriter.WriteAttributeString("maxConcurrentCalls","1000000");
$xmlWriter.WriteAttributeString("maxConcurrentInstances","1000000");
$xmlWriter.WriteAttributeString("maxConcurrentSessions","1000000");
$xmlWriter.WriteEndElement(); # End the serviceThrottling element
$xmlWriter.WriteStartElement('serviceMetadata');
$xmlWriter.WriteAttributeString("httpGetEnabled","True");
$xmlWriter.WriteEndElement(); # End the serviceMetadata element
$xmlWriter.WriteStartElement('serviceDebug');
$xmlWriter.WriteAttributeString("includeExceptionDetailInFaults","False");
$xmlWriter.WriteEndElement(); # End the serviceDebug element
$xmlWriter.WriteEndElement(); # End the behavior element
$xmlWriter.WriteEndElement(); # End the serviceBehaviors element
$xmlWriter.WriteEndElement(); # End the behaviors element

$xmlWriter.WriteEndElement(); # End the system.serviceModel element
$xmlWriter.WriteComment("Enable this block if Webservice Discovery fails - contact your system administrator for proxy information
<system.net>
  <defaultProxy enabled=`"true`">
    <proxy proxyaddress=`"http://myproxy.com:8080`"  bypassonlocal=`"true`" />
  </defaultProxy>
</system.net>");
$xmlWriter.WriteEndElement(); # End the configuration element

$xmlWriter.WriteEndDocument();
$xmlWriter.Flush();

$xmlWriter.Close();
}

Export-ModuleMember -Function buildComposerStudioConfig;