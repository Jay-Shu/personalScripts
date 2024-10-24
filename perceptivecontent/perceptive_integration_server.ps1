<#
                    .SYNOPSIS
                    For performing and testing of calls in succession.

                    .DESCRIPTION
                    This script is intended to make the process of promoting and demoting of Perceptive Users to/from Managers.

                    .EXAMPLE
                    intool --cmd promote-perceptive-manager --username myusername --login-name currentperceptivemanager --login-password currentperceptivemanagerpassword
                    intool --cmd demote-perceptive-manager --username myusername --login-name currentperceptivemanager --login-password currentperceptivemanagerpassword

                    .NOTES
                    This script is inclusive to Promote and Demote. Not intended for other uses.

                    .INPUTS
                    baseUri: Base URL where Integration Server is installed at. Include the end slash.
                    password: Password of the username performing the promoting and demoting. This must be a current Perceptive Manager.
                    inserverBin64: 
                    #>
    #param (
    #
    #)


    $globalVars = @{
        $baseUri = "https://apachetomcat:port/integrationserver/"; # This value must be the Base URI and not an actual API Call.
        $documents = "document"
        $views = "view"
        $drawers = "drawer"
        $workflowItems = "workflowItem"
        $serverStatus = "status"
        $serverInfo = "serverInfo"
        $xIntegrationServerUsername = "departmentmanager"
        $xIntegrationServerPassword = "departmentmanagerpassword"
        $connection = "connection"
        $v1 = "v1"; #Establishing versioning for calls version 1
        $v2 = "v2"; #Establishing versioning for calls version 2
        $v3 = "v3"; #Establishing versioning for calls version 3
        $v4 = "v3"; #Establishing versioning for calls version 4
        $v5 = "v3"; #Establishing versioning for calls version 5. Remainder of API calls live within 1 - 5 versions.
        $v6 = "v3"; #Establishing versioning for calls version 6
        $v7 = "v3"; #Establishing versioning for calls version 7
        $v8 = "v3"; #Establishing versioning for calls version 8
        $v9 = "v3"; #Establishing versioning for calls version 9
        $v10 = "v3"; #Establishing versioning for calls version 10
        $v11 = "v3"; #Establishing versioning for calls version 11. Document API Calls go up to version 11.
        $interactive = $false;
    }



    $fullConnectionUri = "$($globalVars.baseUri)" + "$($globalVars.v1)" + "$($globalVars.connection)"
    $request = Invoke-WebRequest -Uri $fullConnectionUri -Method "GET" -Headers 
    $response = $request.GetResponse()
    $xIntegrationServerSessionHash = $request.Headers["X-IntegrationServer-Session-Hash"]

    if(!$xIntegrationServerSessionHash){
        Write-Host "Failed to establish a connection and receive an X-IntegrationServer-Session-Hash"
    }
