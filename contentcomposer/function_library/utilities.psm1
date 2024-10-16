# Importing the Script name function into this function set.
Import-Module E:\scripts\contentcomposer\2024\function_library\scriptname.psm1;

# Uncomment this line below if you are unsure the script is triggering.
# GetScriptName

<#
    Script Name: utilities.ps1
    Purpose:
        Server Utilities such as;
            Clearing Cache
            Creating a Process
            Deleting a Process
            Getting Info of a Process
            Getting a List of a Process
            Opening a Process
            Setting Data within a Process.
#>

function clearCache {
    param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)

    # Set our Headers for the Composer Repository
$headersClearCache = @{
    Authorization = $sessionId;
    Accept = "application/problem+json"
}

try {
    Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/server/cache" -Headers -$headersClearCache -SkipCertificateCheck;
    Write-Host "Successfully retrieved Printers.";
}
catch {
    Write-Host "Failed to clear Cache.";
    return;
}

return $true;
}

function processCreate {

    param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)


    $headersProcessCreate = @{
        Authorization = $sessionId;
        Accept = "application/problem+json"
    }
    
if(!$sessionId) {

    # Set our Headers for the Composer Repository
$headersProcessCreate = @{
    Authorization = $sessionId;
    Accept = "application/json,application/xml,application/problem+json";
    "Content-Type" = "application/json"
}

# Both values are accepted. Choose depending on the Body you are constructing.
# "Content-Type" = "application/json"
# "Content-Type" = "application/xml"

<#

bundleSystemOid: string
The Content Composer system object ID that contains the bundle.
example: dm1

bundleOid:string
The object ID of the Content Composer bundle that will be created with this communication. If this parameter value is passed, the parameter bundleName is not needed and will be ignored.

bundleName:string
The object name of the Content Composer bundle that will be created with this communication. Required if no bundleOid is passed.
example: Antragsannahme_webapi

type:string
An optional string used to describe this communication.
example: WebApiTest

title:string
An optional string used to describe this communication.
example: Postman Bundle

objectData:string
Optional XML data passed to the property ObjectData of the MwsProcess script context. The standard MWS script assigns this XML data to all Content Composer selections of the bundle.
example: options:
undefined An optional object that contains for example the command to be executed, values for manual variables, and systempool variables.
any of:{ }
{ }
processId:
string

Optional communication ID. This unique ID is used to identify the created communication instance. If not passed, Content Composer creates and returns a unique communication ID.


#>

# bundleSystemOid is REQUIRED

$bodyProcessCreate = @'
    {
        "bundleSystemOid":"dm1",
        "bundleOid":"",
        "bundleName":"",
        "type":"",
        "objectData":"<optionalxmldata><myvalue>"Value"</myvalue></optionalxmldata>",
        "options":{
            "onstart":"Print_Documents",
            "items":[
                "item1":"value",
                "item2":"value2"
            ]

        "pools":[
            {
                "name":"Name of the Pool Varialble",
                "type":"Type of Pool Variable",
                "text":"Value of Pool Variable"
            },
            {
                "name":"Name2 of the Pool Varialble",
                "type":"Type2 of Pool Variable",
                "text":"Value2 of Pool Variable"
            }

        ]
        },
        "processId":"Communication ID Goes Here"
    }
'@;

$bodyJsonVersion = &{$bodyProcessCreate | ConvertTo-Json};


try {
    Invoke-RestMethod -Method "Post" -Uri "$($CoCoUri)/mws/communications" -Body $bodyJsonVersion -Headers -$headersProcessCreate -SkipCertificateCheck;
    Wait-Event -Timeout 60;
    Write-Host "Successfully Created New Communication.";
    } catch {
        Write-Host "Failed to Create New Communication.";
        return;
        }


    } # Closing Bracket to line 60

return $true;
}

function processDelete {
    param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)



    # Set our Headers for the Composer Repository

$headersProcessDelete = @{
    Authorization = $sessionId;
    Accept = "application/problem+json"
}

$communicationId = Read-Host "Provide a valid Communication ID: ";

if (!$communicationId) {
    Write-Host "Cannot execute without a Communication ID.";
    Write-Host "Please refer to https://docs.hyland.com/COCO/en_US/Foundation/23/2/COCOAPI/Content/MWS%20REST%20API.html#api-DocumentGeneration-objGetStructure";
    
    # Original line
    # Exit
    return $false;
}

try {
Invoke-RestMethod -Method "Delete" -Uri "$($CoCoUri)/mws/communications/$($communicationId)" -Headers -$headersProcessDelete -SkipCertificateCheck;

if($_.Response.StatusCode.value__ -eq 200)
{
    Write-Host "Successfully Deleted Prcoess.";
}
return $_.Response.StatusCode.value__;

} catch {
    Write-Host "Failed to Delete Process With the Communication ID of: $($communicationId)";
    return;
}
    return $true;
}


function processGetInfo {
    param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)

# processGetInfo
# communications/{communicationId}/owner
<#
Gets communication details.

Gets details about a communication (former name: MWS process).
#>



    # Set our Headers for the Composer Repository

$headersProcessInfo = @{
    Authorization = $sessionId;
    Accept = "application/problem+json"
}

$communicationId = Read-Host "Provide a valid Communication ID: "

if (!$communicationId) {
    Write-Host "Cannot execute without a Communication ID.";
    Write-Host "Please refer to https://docs.hyland.com/COCO/en_US/Foundation/23/2/COCOAPI/Content/MWS%20REST%20API.html#api-DocumentGeneration-objGetStructure";
    Exit;
}

# Leave this here for quick reference and output during each run.
# 1 = PROCESSINFO
# 2 = POOLVARS
# 3 = MANVARS
# 4 = SELPARAMS

Write-Host "1 = PROCESSINFO";
Write-Host "2 = POOLVARS";
Write-Host "3 = MANVARS";
Write-Host "4 = SELPARAMS";

# Do-While for checking the input from the user.
# If the input is greater than or equal to 1 and less than or equal to 4 ask again.
# infoType is a Required Field

Do {
    $infoType = Read-Host "Please provide 1, 2, 3, or 4:";
    Write-Host "You provided the following $($infoType)";

    if ($infoType -lt 1 -and $infoType -gt 4)
    {
        Write-Host "You have chosen an invalid Information Type.";
        Write-Host "Your choices are: ";
        Write-Host "1 = PROCESSINFO";
        Write-Host "2 = POOLVARS";
        Write-Host "3 = MANVARS";
        Write-Host "4 = SELPARAMS";
    }

} while ($infoType -lt 1 -and $infoType -gt 4)

try {
    $getProcessInfo = Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/communications/$($communicationId)?infoType=$($infoType)" -Headers -$headersProcessInfo -SkipCertificateCheck;

    Write-Host "Successfully retrieved the Process Info.";
    $getProcessInfo;
} catch {
    Write-Host "Failed to Get Process Info With the Communication ID of: $($communicationId) to a new owner";
    return;
}
return $true;

}



function processForward {

# processForward
# communications/{communicationId}/owner
<#
Change the owner of a communication (Forward a communication).

Changes the owner of a communication and thus dispatches it to another user / user group.
#>
    # Set our Headers for the Composer Repository
    param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)

$headersProcessForward = @{
    Authorization = $sessionId;
    Accept = "application/problem+json"
}

$communicationId = Read-Host "Provide a valid Communication ID: ";

if (!$communicationId) {
    Write-Host "Cannot execute without a Communication ID.";
    Write-Host "Please refer to https://docs.hyland.com/COCO/en_US/Foundation/23/2/COCOAPI/Content/MWS%20REST%20API.html#api-DocumentGeneration-objGetStructure";
    return;
}

try {
    Invoke-RestMethod -Method "Put" -Uri "$($CoCoUri)/mws/communications/$($communicationId)/owner" -Headers -$headersProcessForward -SkipCertificateCheck;
    Write-Host $__.Response.StatusCode.value__;
    Write-Host "Successfully Forwarded the Prcoess.";

} catch {
    Write-Host "Failed to Forward Process With the Communication ID of: $($communicationId) to a new owner";
    return;
}
    return $true;
}

<#
    Finished:
        clearCache
        processCreate
        processDelete
        processForward
        processGetInfo
#>

function processGetList {
    param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)

    # Set our Headers for the Composer Repository

$headersProcessGetList = @{
    Authorization = $sessionId;
    Accept = "application/problem+json"
}

$communicationId = Read-Host "Provide a valid Communication ID: "

if (!$communicationId) {
    Write-Host "Cannot execute without a Communication ID."
    Write-Host "Please refer to https://docs.hyland.com/COCO/en_US/Foundation/23/2/COCOAPI/Content/MWS%20REST%20API.html#api-DocumentGeneration-processGetList"
    return;
}
<#
    Your Bearer Token, i.e. Session ID or IdP Access Token, must be established before-hand.
    Each of these are not Required.
#>
$startAt = Read-Host "Please provide the first element you are focusing on: "
$maxNumCom = Read-Host "Please Provide the maximum number of Communications to Return: "
$listUser = Read-Host "Provide a Specific User to list Communications for: "
$includeForwarded = Read-Host "Boolean, Include All forwarded communication: "
$includeNonForwarded = Read-Host "Boolean, Do not Include all forwarded communications: "
$includeState = Read-Host "String, Include the specific state (0 = Saved, 1 = Locked, 2 = Finished): "
$shortProcessDescription = Read-Host "Integer, Provide any number higher than 0 to use, otherwise, leave blank: "

try {
    Invoke-RestMethod -Method "Get" -Uri "$($CoCoUri)/mws/communications?startAt=$($startAt)&max=$($maxNumCom)&listUser=$($listUser)&includeForwarded=$($includeForwarded)&includeNotForwarded=$($includeNonForwarded)&includeState=$($includeState)&shortProcessDescription=$($shortProcessDescription)" -Headers -$headersProcessGetList -SkipCertificateCheck

} catch {
    Write-Host "Failed to Get Communications for the Current User"
    return;
}
    return $true;
}

function processOpen {
    param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)
$headersProcessOpen = @{
    Authorization = $sessionId;
    Accept = "application/json,application/problem+json";
    "Content-Type" = "application/json"
}

$communicationId = Read-Host "Provide a valid Communication ID: "

if (!$communicationId) {
    Write-Host "Cannot execute without a Communication ID."
    Write-Host "Please refer to https://docs.hyland.com/COCO/en_US/Foundation/23/2/COCOAPI/Content/MWS%20REST%20API.html#api-DocumentGeneration-processOpen"
    Exit
}

$processOpenState = Read-Host "Please supply one of the followning: Open, Close, Start: "

if(!$processOpenState){
    
    # This Logic will encompass a level higher in the future, this was just for a quick coding.

    Write-Host "Exiting Script."
    return;
}

$processOpenBody = @"
    {
        "State":"$($processOpenState)"
    }
"@

try {
    Invoke-RestMethod -Method "Put" -Uri "$($CoCoUri)/mws/communications/$($communicationId)/state" -Body $processOpenBody -Headers -$headersProcessOpen -SkipCertificateCheck
}
catch {
    Write-Host "Failed to Change the State With the Communication ID of: $($communicationId) to a new owner"
    return;
}
    Write-Host "Successfully Changed the state to $($processOpenState)."
    return $true;
}

function processSetData {
    param (
    [string[]]$sessionId,
    [string[]]$CoCoUri
)

$headersProcessSetData = @{
    Authorization = $sessionId;
    Accept = "application/json,application/problem+json";
    "Content-Type" = "application/json"
}

$communicationId = Read-Host "Provide a valid Communication ID: "

if (!$communicationId) {
    Write-Host "Cannot execute without a Communication ID."
    Write-Host "Please refer to https://docs.hyland.com/COCO/en_US/Foundation/23/2/COCOAPI/Content/MWS%20REST%20API.html#api-DocumentGeneration-processOpen"
    Exit
}

#$processOpenState = Read-Host "Please supply one of the followning: Open, Close, Start: "

#if(!$processOpenState){
    
    # This Logic will encompass a level higher in the future, this was just for a quick coding.

 #   Write-Host "Exiting Script."
  #  Exit
#}

$processSetDataBody = @"
    {
        <insert XData Here>
    }
"@

try {
    Invoke-RestMethod -Method "Put" -Uri "$($CoCoUri)/mws/communications/$($communicationId)/data/$($dataId)" -Body $processSetDataBody -Headers -$headersProcessSetData -SkipCertificateCheck
}
catch {
    Write-Host "Failed to Change the State With the Communication ID of: $($communicationId) to a new owner"
    return;
}
    Write-Host "Successfully Set the xData for Document Creation with: $($processSetDataBody)."
    return $true;
}

Export-ModuleMember -Function clearCache,processCreate,processDelete,processForward,processGetInfo,processGetList,processOpen,processSetData;