<# 
    .SYNOPSIS 
    Perform Building of EDI Files.
    
    .DESCRIPTION 
    This is intended to be a proof of concept
    
    .EXAMPLE 
    Search-Registry -Path HKLM:\SYSTEM\CurrentControlSet\Services\* -SearchRegex "svchost" -ValueData 
    
    .EXAMPLE 
    Search-Registry -Path HKLM:\SOFTWARE\Microsoft -Recurse -ValueNameRegex "ValueName1|ValueName2" -ValueDataRegex "ValueData" -KeyNameRegex "KeyNameToFind1|KeyNameToFind2" 
    
    #>
    $filePath = "E:\temp\edi_test_file.txt";
    
    $enc = [System.Text.Encoding]::GetEncoding("UTF-8") 

    $xmlWriter = New-Object System.XMl.XmlTextWriter($filePath,$enc);
    # $xmlWriter = New-Object System.XMl.XmlTextWriter($filePath,$NULL);
    $xmlWriter.Formatting = 'Indented'

    # $settings = New-Object System.XML.XmlWriterSettings
    # $settings.Encoding.UTF8

    $xmlWriter.Indentation = 1

    $XmlWriter.IndentChar = "`t"
    $xmlWriter.WriteStartDocument($false); # Setting to $false ensures that standalone=no
    $xmlWriter.WriteStartElement('XCS');
    $xmlWriter.WriteStartElement('Interchange');
    $xmlWriter.WriteAttributeString('AckRequested','0');
    $xmlWriter.WriteAttributeString('AuthorizationInfo','       ');
    $xmlWriter.WriteAttributeString('AuthorizationQual','00');
    $xmlWriter.WriteAttributeString('ControlNumber','000077143');
    $xmlWriter.WriteAttributeString('Date','090914');
    $xmlWriter.WriteAttributeString('ElementDelim','*');
    $xmlWriter.WriteAttributeString('SecurityInfo','        ');
    $xmlWriter.WriteEndElement(); # End the Interchange Element

    $xmlWriter.WriteStartElement('SenderId');
    $xmlWriter.WriteAttributeString('Qualifier','01');
    $xmlWriter.WriteValue('EXAMPLE850      ')
    $xmlWriter.WriteEndElement(); # End the SenderId Element

    $xmlWriter.WriteStartElement('ReceiverId');
    $xmlWriter.WriteAttributeString('Qualifier','ZZ');
    $xmlWriter.WriteValue('035239425      ')
    $xmlWriter.WriteEndElement(); # End the ReceiverId Element

    $xmlWriter.WriteStartElement('Group');
    $xmlWriter.WriteAttributeString('ApplReceiver','035239425');
    $xmlWriter.WriteAttributeString('ApplSender','EXAMPLE850');
    $xmlWriter.WriteAttributeString('ControlNumber','850077005');
    $xmlWriter.WriteAttributeString('Date','20090914');
    $xmlWriter.WriteAttributeString('GroupType','PO');
    $xmlWriter.WriteAttributeString('StandardCOde','X');
    $xmlWriter.WriteAttributeString('StandardVersion','004010VICS');
    $xmlWriter.WriteEndElement(); # End the Group Element

    $xmlWriter.WriteStartElement('Transaction');
    $xmlWriter.WriteAttributeString('ControlNumber','850305757');
    $xmlWriter.WriteAttributeString('DocType','850');
    $xmlWriter.WriteAttributeString('SegIdx','1');
    $xmlWriter.WriteStartElement('ST');
    $xmlWriter.WriteAttributeString('SegIdx','1');
    $xmlWriter.WriteStartElement('ST01');
    $xmlWriter.WriteValue('850');
    $xmlWriter.WriteEndElement(); # End the ST01 Element
    $xmlWriter.WriteStartElement('ST02');
    $xmlWriter.WriteValue('850305757');
    $xmlWriter.WriteEndElement(); # End the ST02 Element
    $xmlWriter.WriteStartElement('ST03');
    $xmlWriter.WriteEndElement(); # End the ST02 Element
    $xmlWriter.WriteEndElement(); # End the ST Element

    $xmlWriter.WriteStartElement('BEG');
    $xmlWriter.WriteAttributeString('SegIdx','2');
    $xmlWriter.WriteStartElement('BEG01');
    $xmlWriter.WriteValue('00');
    $xmlWriter.WriteEndElement(); # End the BEG01 Element
    $xmlWriter.WriteStartElement('BEG02');
    $xmlWriter.WriteValue('SA');
    $xmlWriter.WriteEndElement(); # End the BEG02 Element
    $xmlWriter.WriteStartElement('BEG03');
    $xmlWriter.WriteValue('123456');
    $xmlWriter.WriteEndElement(); # End the BEG03 Element
    $xmlWriter.WriteStartElement('BEG05');
    $xmlWriter.WriteValue('20090813');
    $xmlWriter.WriteEndElement(); # End the BEG05 Element
    $xmlWriter.WriteEndElement(); # End the BEG Element

    $xmlWriter.WriteStartElement('PER');
    $xmlWriter.WriteAttributeString('SegIdx','3');
    $xmlWriter.WriteStartElement('PER01');
    $xmlWriter.WriteString('AE');
    $xmlWriter.WriteEndElement(); # End the PER01 Element
    $xmlWriter.WriteStartElement('PER09');
    $xmlWriter.WriteString('20');
    $xmlWriter.WriteEndElement(); # End the PER09 Element
    $xmlWriter.WriteEndElement(); # End the PER Element

    $xmlWriter.WriteStartElement('FOB');
    $xmlWriter.WriteAttributeString('SegIdx','4');
    $xmlWriter.WriteStartElement('FOB01');
    $xmlWriter.WriteValue('CC');
    $xmlWriter.WriteEndElement(); # End the FOB01 Element
    $xmlWriter.WriteStartElement('FOB02');
    $xmlWriter.WriteValue('AC');
    $xmlWriter.WriteEndElement(); # End the FOB01 Element
    $xmlWriter.WriteStartElement('FOB03');
    $xmlWriter.WriteValue('CHICAGO');
    $xmlWriter.WriteEndElement(); # End the FOB01 Element
    $xmlWriter.WriteEndElement(); # End the FOB Element

    $xmlWriter.WriteEndElement(); # End the Transaction Element
    $xmlWriter.WriteEndElement(); # End the XCS Element
    
    $xmlWriter.WriteEndDocument();

    $xmlWriter.Flush();

    $xmlWriter.Close();