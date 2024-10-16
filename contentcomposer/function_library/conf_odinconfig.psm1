function buildComposerOdinConfig {
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
    # Standard Distribution when needed, included as part of the template
    # $scheme = Read-Host "Provide the scheme for your URLs (i.e. http or https): ";
    # $FQDN = Read-Host "Provide the FQDN for your Content Composer Server: ";
    # $port8000 = Read-Host "Provide the STS Port:";
    # $port8010 = Read-Host "Provide the Port for your Content Composer Server: " ;
    # $port8111 = "8111";
} else {
    # Standard Distribution when needed, included as part of the template
    # $scheme = "https";
    # $FQDN = "contentcomposer.com";
    # $port8010 = "8010";
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
$xmlWriter.WriteStartElement('odinSettings');

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','tempdir');
$xmlWriter.WriteAttributeString('value','="%userprofile%\documents');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','destinationdir');
$xmlWriter.WriteAttributeString('value','');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','printServerPaths');
$xmlWriter.WriteAttributeString('value','');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','compartTraceDir');
$xmlWriter.WriteAttributeString('value','%Composerdir%compartTrace');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','PDFtoXPSConverter');
$xmlWriter.WriteAttributeString('value','Compart');
$xmlWriter.WriteEndElement(); # End the add element

$optionTiffConverter = @"
option `"TiffConverter`"
Specifies the algorithm that the Rendition component uses to convert a TIFF file to XPS file format.
Possible values for `"TiffConverter`":
`"Default`": use the simple, old TIFF converter. This is the default value if this attribute is not present in the odin.config file.
`"FitToPage`": use the new TIFF converter introduced with Content Composer EP4.
"@

$xmlWriter.WriteComment($optionTiffConverter);

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','TiffConverter');
$xmlWriter.WriteAttributeString('value','Default');
$xmlWriter.WriteEndElement(); # End the add element

$optionTiffConverterOutputPageSize = @"
option `"TiffConverterOutputPageSize. Possible values: `"A4`" or `"Letter`". See CoCo manual for more information
<add key=`"TiffConverterOutputPageSize`" value=`"Letter`"/>
"@

$xmlWriter.WriteComment($optionTiffConverterOutputPageSize);

$xmlWriter.WriteStartElement('add');
$xmlWriter.WriteAttributeString('key','TiffConverterOutputPageSize');
$xmlWriter.WriteAttributeString('value','A4');
$xmlWriter.WriteEndElement(); # End the add element

$xmlWriter.WriteEndElement(); # End the odinSettings element

$xmlWriter.WriteEndDocument();

$xmlWriter.Flush();

$xmlWriter.Close();

}



# $xmlWriter.WriteComment();

Export-ModuleMember -Function buildComposerOdinConfig;