function buildComposerML {
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

$filePath = "E:\Program Files\ContentComposer\Composer.Core.exe.config";

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
$xmlWriter.WriteAttributeString('name','modusruntime');
$xmlWriter.WriteAttributeString('type','ModusSuite.Runtime.SystemFramework.RuntimeConfiguration, ModusSuite.Runtime.SystemFramework');
$xmlWriter.WriteEndElement(); # End the section element
$xmlWriter.WriteStartElement('section');
$xmlWriter.WriteAttributeString('name','mlsdatabase');
$xmlWriter.WriteAttributeString('type','ModusSuite.Common.SystemFramework.AliasConfigurationSection, ModusSuite.Common.SystemFramework');
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
$xmlWriter.WriteStartElement('Route');
$xmlWriter.WriteAttributeString('name','CoCo_Standard');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','minimum-level');
$xmlWriter.WriteAttributeString('value','Information');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','File');
$xmlWriter.WriteAttributeString('value','%userprofile%\ContentComposer\MonalisaEngine_log.txt');
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
$xmlWriter.WriteEndElement(); # End the Route element

$xmlWriter.WriteEndElement(); # End the Routes element
$xmlWriter.WriteEndElement(); # End the Hyland.Logging element

<#
    appSettings
#>

$xmlWriter.WriteStartElement('appSettings');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','sts');
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8000)/sts");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','login');
$xmlWriter.WriteAttributeString('value',"$($scheme)://$($FQDN):$($port8010)/mur/login");
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','ProtectedConfiguration');
$xmlWriter.WriteAttributeString('value','encryption_keys.config');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','AllowUnknownKeys');
$xmlWriter.WriteAttributeString('value','EnableHylandLogging');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the appSettings element

<#
    mlsdatabase
#>

$xmlWriter.WriteStartElement('mlsdatabase');
$xmlWriter.WriteStartElement('aliaslist');
$xmlWriter.WriteEndElement(); # End the aliaslist element
$xmlWriter.WriteEndElement(); # End the mlsdatabase element

<#
    modusruntime
#>

$xmlWriter.WriteStartElement('modusruntime');
$xmlWriter.WriteStartElement('runtimeservices');
$xmlWriter.WriteStartElement('service');
$xmlWriter.WriteAttributeString('name','repository');
$xmlWriter.WriteAttributeString('assembly','ModusSuite.Runtime.RepositoryService');
$xmlWriter.WriteAttributeString('type','ModusSuite.Runtime.RepositoryService');
$xmlWriter.WriteEndElement(); # End the service element
$xmlWriter.WriteEndElement(); # End the runtimeservices element
$xmlWriter.WriteEndElement(); # End the modusruntime element

<#
    runtime
#>

$xmlWriter.WriteStartElement('runtime');
$xmlWriter.WriteStartElement('generatePublisherEvidence');
$xmlWriter.WriteAttributeString('enabled','false');
$xmlWriter.WriteEndElement(); # End the generatePublisherEvidence element
$xmlWriter.WriteStartElement('assemblyBinding');
$xmlWriter.WriteAttributeString('xmlns','urn:schemas-microsoft-com:asm.v1');

<#
    Microsoft.Extensions.Logging.Abstractions
#>
$xmlWriter.WriteStartElement('dependentAssembly');
$xmlWriter.WriteStartElement('assemblyIdentity');
$xmlWriter.WriteAttributeString('name','Microsoft.Extensions.Logging.Abstractions');
$xmlWriter.WriteAttributeString('publicKeyToken','adb9793829ddae60');
$xmlWriter.WriteAttributeString('culture','neutral');
$xmlWriter.WriteEndElement(); # End the assemblyIdentity Element
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
$xmlWriter.WriteAttributeString('name','monalisa');
$xmlWriter.WriteAttributeString('switchValue','Information');
$xmlWriter.WriteStartElement('listeners');
$xmlWriter.WriteStartElement('remove');
$xmlWriter.WriteAttributeString('name','Default');
$xmlWriter.WriteEndElement(); # End the remove element
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','tracefile_listener');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the listeners element
$xmlWriter.WriteEndElement(); # End the source element
$xmlWriter.WriteEndElement(); # End the sources element

<#
    sharedListeners
#>

$xmlWriter.WriteStartElement('sharedListeners');
$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('name','tracefile_listener');
$xmlWriter.WriteAttributeString('type','ModusSuite.Common.SystemFramework.DailyTraceListener, ModusSuite.Common.SystemFramework');
$xmlWriter.WriteAttributeString('delimiter',';');
$xmlWriter.WriteAttributeString('initializeData','MonaLisaEngine_log.txt');
$xmlWriter.WriteAttributeString('traceOutputOptions','DateTime');
$xmlWriter.WriteEndElement(); # End the add element
$xmlWriter.WriteEndElement(); # End the sharedListeners element

<#
    trace
#>

$xmlWriter.WriteStartElement('trace');
$xmlWriter.WriteAttributeString('autoflush','true');
$xmlWriter.WriteAttributeString('indentsize','4');
$xmlWriter.WriteEndElement(); # End the trace element

$xmlWriter.WriteEndElement(); # End the system.diagnostics element

$xmlWriter.WriteEndElement(); # End the configuration element

$xmlWriter.WriteEndDocument();

$xmlWriter.Flush();

$xmlWriter.Close();
}

Export-ModuleMember -Function buildComposerML;