<#

#>
# Importing the Script name function into this function set.
Import-Module E:\scripts\contentcomposer\2024\function_library\scriptname.psm1;

# Uncomment this line below if you are unsure the script is triggering.
# GetScriptName

function docGetFileMime {
    param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)


    # Set our Headers for the Composer Repository

$headersDocGetFileMime = @{
    Authorization = $sessionId;
    Accept = "application/octet-stream,application/problem+json"
}

        $communicationId = Read-Host "Type in the Communication ID (required): ";
        $docId = Read-Host "Please enter a Valid Document ID related to $($communicationId) (required): ";
    
    if(!$communicationId -and !$docId) {
        Write-Host "Communication ID and Document ID are required values for this URL.";
        # Terminating here because we cannot proceed without both the Communication and Doc IDs.
        return;
        }

try {
    Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/communications/$($communicationId)/docs/$($docId)" -Headers -$headersDocGetFileMime -SkipCertificateCheck
}
catch {
    Write-Host "Failed to retrieve Document with the Following: $($docId) With the Communication ID of: $($communicationId)"
    return;
}
Write-Host "Successfully retrieved the generated Document."
return $true;
}

function docSetFileMime {
    param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)

try {
    
}
catch {
    
    return;
}

return $true;
}
function objGetStructure {
    param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)

try {
    
}
catch {
    
    return;
}

return $true;
}

function objSetOutputparams {
    param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)

try {
    
}
catch {
    
    return;
}

return $true;
}

function objToggle {
    param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)

try {
    
}
catch {
    
    return;
}

return $true;
}

Export-ModuleMember -Function docGetFileMime.docSetFileMime,objGetStructure,objSetOutputparams,objToggle;