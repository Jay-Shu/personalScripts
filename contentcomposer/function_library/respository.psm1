# Importing the Script name function into this function set.
Import-Module E:\scripts\contentcomposer\2024\function_library\scriptname.psm1;

# Uncomment this line below if you are unsure the script is triggering.
# GetScriptName

function getRepoSystemList {
    param(
    [string[]]$sessionId,
    [string[]]$CoCoUri
    )

    $headersGetRepoSystemList = @{
        Authorization = $sessionId;
        Accept = "application/json,application/xml,application/problem+json"
    }
    
    try {
        Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/sessions/systems" -Headers -$headersGetRepoSystemList -SkipCertificateCheck;
    }
    catch {
        Write-Host "Failed to retrieve the Composer Repository. Either does not exist or you do not have access to it.";
        return;
    }
    Write-Host "Successfully retrieved the Composer Repository."
    return $true;

}

function getSystemByName {
    param(
    [string[]]$sessionId,
    [string[]]$CoCoUri
    )
    $headersGetSystemByName = @{
        Authorization = $sessionId;
        Accept = "application/json,application/xml,application/problem+json"
    }
    
    $composerSystemName = Read-Host "Type in the Name of your desired Composer System Name";
    try {
        Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/systems/$($composerSystemName)" -Headers -$headersGetSystemByName -SkipCertificateCheck;
    }
    catch {
        Write-Host "Failed to retrieve the Composer Repository by Name. That Name either does not exist or you do not have access to it.";
        return;
    }
    Write-Host "Successfully retrieved $($composerSystemName)";
    return $true;
}

function getGetFolderContent {
    param(
    [string[]]$sessionId,
    [string[]]$CoCoUri
    )
    $headersrRepGetFolderContent = @{
        Authorization = $sessionId;
        Accept = "application/json,application/xml,application/problem+json"
    }
    
    if(!$composerSystemName) {
        $composerSystemName = Read-Host "Type in the Name of your desired Composer System Name";
    }

    $folderName = Read-Host "Type in the Name of the Folder you wish to retrieve: ";
    
    $filterInput = "Choose None or One of the following; P (Bundle), D (Document), B (Text Block), or A (Folder): ";
    
    # Initial Test if loop below does not work.
    # $folderFilter = Read-Host "Choose None or One of the following; P (Bundle), D (Document), B (Text Block), or A (Folder): "
    
    # Clear-Host
    # $ErrorActionPreference = 'Stop'
    
    # https://stackoverflow.com/questions/68056955/user-input-validation-in-powershell
    
    $scriptBlock = {
        try
        {
            # REMEMBER THE DATATYPE MATTERS!!!
            $folderFilter = [string](Read-Host $filterInput);
            
            if ($folderFilter -eq "P") {
                Write-Host "Your Input was $($folderFilter)";
                
                
               #& $scriptBlock
            }
            elseif ($folderFilter -eq "D")
                { 
                    Write-Host "Your Input was $($folderFilter)";
                #    & $scriptBlock
                    
                }
            elseif ($folderFilter -eq "B")
                { 
                    Write-Host "Your Input was $($folderFilter)";
                 #   & $scriptBlock
                    
                }
            elseif ($folderFilter -eq "A")
                { 
                    Write-Host "Your Input was $($folderFilter)";
                  #  & $scriptBlock
                    
                }
                elseif ($folderFilter -eq "Null")
                    { 
                        Write-Host "Your Input must be a valid option: P, D, B, A or Null.";
                   #     & $scriptBlock
                        
                    }
                else {
            } Write-Host "$($folderFilter) was set to an invalid value.";
            Break;
            #$filterInput
        }
        catch
        {
            Write-Host "Your Input must be: P, B, D, A or Null.";
           # & $scriptBlock
           return;
        }
    }

    if(!$folderFilter) {
        # We do not want to be stuck in a loop
        $folderFilter=&{$scriptBlock};
    }

try {

    Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/systems/$($composerSystemName)/folders/$($folderName)?filter=$($folderFilter)" -Headers -$headersrRepGetFolderContent -SkipCertificateCheck;
    Wait-Event -Timeout 60;
}
catch {
    return;
}
return $true;
}

function repGetFolderTree {
    param(
    [string[]]$sessionId,
    [string[]]$CoCoUri
    )

try {
    $headersRepGetFolderTree = @{
        Authorization = $sessionId;
        Accept = "application/json,application/xml,application/problem+json"
    }
    
    if(!$composerSystemName) 
        {
            $composerSystemName = Read-Host "Type in the Name of your desired Composer System Name" ;
        }
    
        $startFolder = Read-Host "Provide a Folder from which the hierarchy is delivered. If empty, the RootFolder of the system is used: ";
    # 
        Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/sessions/systems/$($composerSystemName)/folder-tree?startFolder=$($startFolder)" -Headers -$headersRepGetFolderTree -SkipCertificateCheck;
}
catch {
    Write-Host "Failed to retrieve the Composer Repository Folder Tree." ;
}

Write-Host "Successfully retrieved the Composer Repository Folder Tree.";
return $true;
}

function repGetForms {
    param(
    [string[]]$sessionId,
    [string[]]$CoCoUri
    )

        # Set our Headers for the Composer Repository
    
    $headersRepGetForms = @{
        Authorization = $sessionId;
        Accept = "application/json,application/xml,application/problem+json"
    }
    
    if(!$composerSystemName) 
        {
            $composerSystemName = Read-Host "Type in the Name of your desired Composer System Name" 
        }
    
        $usedByPrinterId = Read-Host "Provide a the printer ID you wish to use. Otherwise, leave blank"
    
        # This is only used if a Printer ID is not supplied
        if(!$usedByPrinterId) 
            {
                $usedByPrinterName = Read-Host "Provide a the printer Name you wish to use. Otherwise, leave blank."
            }
    
            if($null -eq $usedByPrinterName -and $null -ne $usedByPrinterId) 
            {
                $printerType = Read-Host "Provide a the printer Name you wish to use. Otherwise, leave blank."
            }
        
    # 
    try {
        Invoke-RestMethod -Method "Get" -Uri "https://$($contentcomposeriis):$($port)/mws/sessions/systems/$($composerSystemName)/forms?usedByPrinterId=$($usedByPrinterId)&usedByPrinterName=$($usedByPrinterName)&printerType=$($printerType)" -Headers -$headersRepGetForms -SkipCertificateCheck;
    }
    catch {
        Write-Host "Failed to retrieve forms ";
        return;
    }
    Write-Host "Successfully retrieved forms.";
    return $true;
}

function repGetPrinters {
    param(
    [string[]]$sessionId,
    [string[]]$CoCoUri
    )
    $headersRepGetPrinters = @{
        Authorization = $sessionId;
        Accept = "application/json,application/xml,application/problem+json"
    }
    
    if(!$composerSystemName) 
        {
            $composerSystemName = Read-Host "Type in the Name of your desired Composer System Name";
        }
    
        $containingFormId = Read-Host "Provide the object ID of the Form:";
    
        # This is only used if a Printer ID is not supplied
        if($null -eq $containingFormId) 
            {
                $containingFormName = Read-Host "Provide the form name:";
            }
try {
    Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/systems/$($composerSystemName)/printers?containingFormId=$($containingFormId)&containingFormName=$($containingFormName)" -Headers -$headersRepGetPrinters -SkipCertificateCheck
} catch {
    Write-Host "Failed to retrieve Printers.";
    return;
}
    Write-Host "Successfully retrieved Printers.";
    return $true;
}

function repGetSystemContent {
    param(
    [string[]]$sessionId,
    [string[]]$CoCoUri
    )

    $headersRepGetSystemContent = @{
        Authorization = $sessionId;
        Accept = "application/json,application/xml,application/problem+json"
    }
    
    if(!$composerSystemName) 
        {
            $composerSystemName = Read-Host "Type in the Name of your desired Composer System Name: ";
        }
    $systemContentFilter = Read-Host "Please enter in; A, B, D, P, or Press Enter: ";

    try {
        Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/systems/$($composerSystemName)/folders?filter=$($systemContentFilter)" -Headers -$headersRepGetSystemContent -SkipCertificateCheck;
    }
    catch {
        Write-Host "Failed to retrieve SystemContent.";
        return;
    }
    Write-Host "Successfully retrieved Printers.";
    return $true;
}

function repGetValueHelpDefinition {
    param(
    [string[]]$sessionId,
    [string[]]$CoCoUri
    )
    $headersRepGetValueHelpDefinition = @{
        Authorization = $sessionId;
        Accept = "application/json,application/xml,application/problem+json"
    }
    
    if(!$composerSystemName) 
        {
            $composerSystemName = Read-Host "Type in the Name of your desired Composer System Name: ";
        }
    
    $valueHelpId = Read-Host "Please enter provide the OID of a Value Help Object: ";    
    try {
        Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/systems/$($composerSystemName)/value-help-definitions/$($valueHelpId)" -Headers -$headersRepGetValueHelpDefinition -SkipCertificateCheck;
    }
    catch {
        Write-Host "Unable to retrieve Value Help Definition";
        return;
    }
    Write-Host "Successfully retrieved Value Help Definition";
    return $true;
}

Export-ModuleMember -Function getRepoSystemList,getSystemByName,getGetFolderContent,repGetFolderTree,repGetForms,repGetPrinters,repGetSystemContent,repGetValueHelpDefinition