<#

#>

Import-Module E:\scripts\contentcomposer\2024\function_library\scriptname.psm1;


function healthCheck {

param(
    [string[]]$CoCoUri
)

# https://stackoverflow.com/questions/29613572/error-handling-for-invoke-restmethod-powershell

try {
    Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/health";
    Write-Host "200 Response Code was Recieved!";
} catch {
    # Dig into the exception to get the Response details.
    # Note that value__ is not a typo.
    Write-Host "Status Code:" $_.Exception.Response.StatusCode.value__;
    Write-Host "Status Description:" $_.Exception.Response.StatusDescription;
    return;
    # We do not want to continue making any attempts when the health check did not return a 200 response code.
}

return $true;

}
function loginSession {

    param(
    [string[]]$CoCoUri
)


$inputUsername = Read-Host -Prompt "Enter your MWS Username";
$inputPassword = Read-Host -Prompt "Enter your MWS Password";

<#
    Basic Authentication is Used producing a Bearer Authorization Token
    Contains the base64 encoded value of one of the following:
    * 'username:password' - Use this for an interactive login from an end user client.
    * 'username:passwordCode:silent' - Use this for a login from a backend service.
    * 'username:passwordCode:silent:aliasUsername' - Use this for a login from a
        backend service if you want to assign the new communication to a different
        user account.
    More information about the placeholders:
    * 'username'- Replace with the username.
    * 'password' - Replace with the password in plain text.
    * 'passwordCode' - Replace with the encrypted password. Use Encoder.exe to
        encrypt the password.
    * 'silent' - This is a static text, do not replace it.
    * 'aliasUsername' - Replace with a different username. To use this feature, you
        must configure your MWS service. See the 'Content Composer Advanced Design
        and Setup Guide' for more information. 

#>

$combinedCreds = "Basic $($inputUsername):$($inputPassword)";
$headersLogin = @{
    Authorization="$($combinedCreds)";
    Accept="application/json,application/xml"
}

<#
    It is important to first establish a sesssion, otherwise, we will not
    be able to attempt any other calls.
    
    Future Development of this Script will be geared towards function based items to allow for access outside of this file.
    In order to meet the aforementioned requirement
#>

    try {
    $resultSet = Invoke-RestMethod -Method 'Post' -Uri "https://$($CoCoUri)/mws/sessions" -Headers $headersLogin -SkipCertificateCheck;
    
    $sessionId = $resultSet.sessionId;

    if(!$sessionId) {
        Write-Host "You have successfully logged into MWS API." "Session ID: $($sessionId)";
        }

    } # Line 69 Closing Bracket

    catch { # Catch Opening Bracket
        Write-Host "Failed to run";
        return;
    } # Catch Closing Bracket

return $sessionId;

}

function removeSesion {
param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)



    # We need to set our logout headers to associate the Delete with the Correct Session.
    $headersLogout = @{
        Authorization=$sessionId;
        Accept="application/problem+json"
    }
    try {
        Invoke-RestMethod -Method "Delete" -Uri "$($CoCoUri)/mws/sessions" -Headers $headersLogout -SkipCertificateCheck;
    } catch {
        Write-Host "No Session ID to cleanup.";
        return;
    }
    
Write-Host "Your session has been removed.";
return $true;
}


# Display the Script we are Executing each time.
# GetScriptName

Export-ModuleMember -Function healthCheck,loginSession,removeSession;