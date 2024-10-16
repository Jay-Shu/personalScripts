function userInfo {
    param(
    [string[]]$CoCoUri,
    [string[]]$sessionId
)

    if(!$sessionId) {

        # Set our Headers for User Info
    $headersUserInfo = @{
        Authorization = $sessionId;
        Accept = "application/json,application/xml,application/problem+json"
    }
    try {
        $getUserInfo = Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/sessions/user-info" -Headers -$headersUserInfo -SkipCertificateCheck
        Write-Host "Successfully retrieved the User Info.";
        $getUserInfo;
    }
    catch {
        Write-Host "Failed to retrieve the User's Info";
    }
}
    
} # Closing to line 1

function getUsersOfRole {
    param(
    [string[]]$CoCoUri,
    [string[]]$sessionId
)

if(!$sessionId) {

    # Set our Headers for the Composer Repository

$headersGetUsersOfRole = @{
    Authorization = $sessionId;
    Accept = "application/json,application/xml,application/problem+json"
}


$roleName = Read-Host "Please supply a Role Name: "
try {
    $getGetUsersOfRole = Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri))/mws/users?roleName=$($roleName)" -Headers -$headersGetUsersOfRole -SkipCertificateCheck
    Write-Host "Successfully retrieved Value Help Definition."
    $getGetUsersOfRole
} catch {
    Write-Host "Failed to retrieve Users from the Chosen Role:$($roleName)";
    Write-Host "Status Code:" $_.Exception.Response.StatusCode.value__;
    Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription;
    Exit
        }
    }
} # Closing for line 31

function getRoles {
    param(
    [string[]]$CoCoUri,
    [string[]]$sessionId
)

if(!$sessionId) {

    # Set our Headers for the Composer Repository

$headersGetRoles = @{
    Authorization = $sessionId;
    Accept = "application/json,application/xml,application/problem+json"
}

try {
    $getGetRoles = Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/roles" -Headers -$headersGetRoles -SkipCertificateCheck
    Write-Host "Successfully retrieved Printers."
    $getGetRoles
}
catch {
    Write-Host "Failed to retrieve the roles: $($getGetRoles)"
}
                } # Closing for line 62
                    } # Closing for line 56

Export-ModuleMember -Function getUsersOfRole,userInfo,getRoles