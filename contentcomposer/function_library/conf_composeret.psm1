function buildComposerEncryptionToolConfig {
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

<#                    
$filePath = "E:\Program Files\ContentComposer\Composer.EncryptionTool.exe.config";

$enc = [System.Text.Encoding]::GetEncoding("UTF-8") # this results in encoding="utf-8"

$xmlWriter = New-Object System.XMl.XmlTextWriter($filePath,$enc);

$xmlWriter.Formatting = 'Indented'

$xmlWriter.Indentation = 1

$XmlWriter.IndentChar = "`t"
$xmlWriter.WriteStartDocument($false); # Setting to $false ensures that standalone=no
$xmlWriter.WriteStartElement('configuration');

$xmlWriter.WriteEndElement(); # End the configuration element

$xmlWriter.WriteEndDocument();
$xmlWriter.Flush();

$xmlWriter.Close();
#>


# Not needed


}

Export-ModuleMember -Function buildComposerEncryptionToolConfig;