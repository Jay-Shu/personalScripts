<#
                    .SYNOPSIS
                    For performing and testing of API calls in succession. Integration Server is RESTful.

                    .DESCRIPTION
                    This script is intended for working with Integration Server in various capacities. We need to establish a session
                        first before taking additional steps. Then immediately disconnect the session following

                    .EXAMPLE
                    This example demonstrates pseudo-code of the calls. Effectively; Establish Connection, Retrieve views,
                        Retrieve results from a specific view, Disconnect Connection.
                        
                        Establish a Connection
                        Grab the objects
                        Grab a specific Object
                        Disconnect the Connection

                    Individual examples:
                        Invoke-WebRequest -Uri "https://apachetomcat:port/integrationserver/v1/connection" -Method "GET" -Headers {"X-IntegrationServer-Username"="deptmanager";"X-IntegrationServer-Password"="deptmanagerpassword";"Accept"="application/xml"} -SkipCertificateCheck
                        Invoke-WebRequest -Uri "https://apachetomcat:port/integrationserver/v1/view" -Method "GET" -Headers {""X-IntegrationServer-Session-Hash"="GUID";"Accept"="application/xml"} -SkipCertificateCheck
                        Invoke-WebRequest -Uri "https://apachetomcat:port/integrationserver/v1/view/{id}" -Method "GET" -Headers {""X-IntegrationServer-Session-Hash"="GUID";"Accept"="application/xml"} -SkipCertificateCheck
                        Invoke-WebRequest -Uri "https://apachetomcat:port/integrationserver/v1/connection" -Headers {"X-IntegrationServer-Session-Hash"="GUID";"Accept"="application/xml"} -Method "DELETE" -SkipCertificateCheck

                    .NOTES
                    This script isn't meant to be over the top. However, can demonstrate the expected behavior of working with Integration Server. For a Developer
                        this is crucial for a successful and stable integration. Additionally, 

                    .INPUTS
                    globalVars: Hashtable for storing our globally accessible variables.
                    baseUri: Base URL where Integration Server is installed at. Include the end slash.
                    documents: Password of the username performing the promoting and demoting. This must be a current Perceptive Manager.
                    views: View URI Fragment.
                    drawers: Drawer URI Fragment.
                    workflowItems: Workflow URI Fragment.
                    serverStatus: Server Status URI Fragment. This will return the Status of the Inserver.
                        INSERVER_UP is what we expect to be returned.
                    serverInfo: Server Info URI Fragment. This will not return the Status of the Inserver and will not indicate
                        whether it is in a functioning state or not.
                    xIntegrationServerUsername: X-IntegrationServer-Username, this must be a header.
                    xIntegrationServerPassword: X-IntegrationServer-Password, this must be a header.
                    connection: Connection URI Fragment.
                    v1: Version 1 API Calls. If you do not specify a version in the URI, it will default to V1.
                        The lax method is to not include v1 in any uri that you intend for only Version 1
                        usage. Recommended best practice is to always include the version.
                    v2: Version 2 API Calls.
                    v3: Version 3 API Calls.
                    v4: Version 4 API Calls.
                    v5: Version 5 API Calls.
                    v6: Version 6 API Calls.
                    v7: Version 7 API Calls.
                    v8: Version 8 API Calls.
                    v9: Version 9 API Calls.
                    v10: Version 10 API Calls.
                    v11: Version 11 API Calls.
                    interactive: Staged for future development.
                    headers: These are the headers we will be using X-IntegrationServer-UserName, X-IntegrationServer-Password, X-IntegrationServer-Session-Hash,
                        Accept, Content-Type, X-IntegrationServer-Resource-Name (filename of the page).
                    request: Our initial connection for establishing a session. This needs to result in an X-IntegrationServer-Session-Sash.

                Citations:
                    Invoke-WebRequest, https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.4
                    What is Integration Server?, https://docs.hyland.com/Developer/IS/en_US/7.11/index.html
                    Request Headers, https://docs.hyland.com/Developer/IS/en_US/7.11/requestheaders.html
                    Licensing, https://docs.hyland.com/Developer/IS/en_US/7.11/licensing.html
                    /v1/status, https://docs.hyland.com/Developer/IS/en_US/7.11/operations.html#call_ServiceStatus_V1_GET-status
                    about_Comparison_Operators, https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.4
                    /v1/drawer, https://docs.hyland.com/Developer/IS/en_US/7.11/operations.html#call_Drawer_V1_GET-drawer
                    /v1/drawer/{id}, https://docs.hyland.com/Developer/IS/en_US/7.11/operations.html#call_Drawer_V1_GET-drawer-id
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
        $v4 = "v4"; #Establishing versioning for calls version 4
        $v5 = "v5"; #Establishing versioning for calls version 5. Remainder of API calls live within 1 - 5 versions.
        $v6 = "v6"; #Establishing versioning for calls version 6
        $v7 = "v7"; #Establishing versioning for calls version 7
        $v8 = "v8"; #Establishing versioning for calls version 8
        $v9 = "v9"; #Establishing versioning for calls version 9
        $v10 = "v10"; #Establishing versioning for calls version 10
        $v11 = "v11"; #Establishing versioning for calls version 11. Document API Calls go up to version 11.
        $interactive = $false;
    }

    $headers = @{
        "Accept" = "application/xml";
        "X-IntegrationServer-Username" = "$($globalVars.$xIntegrationServerUsername)";
        "X-IntegrationServer-Password" = "$($globalVars.$xIntegrationServerPassword)";
    }

    $fullConnectionUri = "$($globalVars.baseUri)/$($globalVars.v1)/$($globalVars.connection)" # No end slash
    $request = Invoke-WebRequest -Uri $fullConnectionUri -Method "GET" -Headers @headers -SkipCertificateCheck
    $response = $request.GetResponse()
    $xIntegrationServerSessionHash = $request.Headers["X-IntegrationServer-Session-Hash"]

    if(!$xIntegrationServerSessionHash){
        Write-Host "Failed to establish a connection and receive an X-IntegrationServer-Session-Hash"
        break
    }


    <#
        After we establish a session we need to perform some work.
        To make sure we can hit what we expect let's step through.
        Instead of hard-coding values, we will primarily be using
        paramaterization.
    #>

    <#
        Considerations:
            Perceptive Enterprise Search; This is to perform a similar behavior to Perceptive Content 
                Full Text Search Agent (ImageNow Full Text Search Agent).
            Interactive Document Retrieval; A while loop can accomplish this. Versioning allowance
                from 1 to 11.
    #>

    $actionsList = @"
Your available actions are:
documents
views
drawers
workflowItems
serverStatus
"@


    Write-Host $actionsList
    $action = Read-Host "Please provide an action:"
    while($action -ne "end"){
    if($action -eq "documents"){
        Write-Host "We are going to perform a document retrieval"
        $documentHeaders = @{
            "Accept" = "application/xml";
            "X-IntegrationServer-Session-Hash" = $xIntegrationServerSessionHash;

        }

        $documentId = Read-Host "Provide a valid Document ID (must begin with 1(5.x), 2 (6.x) or 321Z(7.x) ):"

        $documentUri = "$($globalVars.baseUri)/$($globalVars.v1)/$($globalVars.documents)/$($documentId)"
        $docReq = Invoke-WebRequest -Uri $documentUri -Method "GET" -Headers @documentHeaders -SkipCertificateCheck

        $docResponse = $docReq.GetResponse()
        $docStatusCode = $docReq.StatusCode

        if($docStatusCode -ne 200){
            
            Write-Host "Invalid Document ID, Invalid Session Hash, Or User does not have permissions to the Document."
        
        } else 
        {
            # Validation of our header is necessary. That has to come after the Status code is checked.
            $docISSH = $request.Headers["X-IntegrationServer-Session-Hash"]
            if($docISSH -ne $xIntegrationServerSessionHash) {
                Write-Host "Something has changed and your X-IntegrationServer-Session-Hash is no longer valid or has updated."
                break
            } else {
                Write-Host "Successfully validated the X-IntegrationServer-Session-Hash Header against the Response."
            }
        }

    } elseif($action -eq "views"){
        Write-Host "We are going to perform a view retrieval and run"
        Write-Host "Our expected output will be an xml. Effectively, the Response Body."
        
        $viewHeaders = @{
            "Accept" = "application/xml";
            "X-IntegrationServer-Session-Hash" = $xIntegrationServerSessionHash;
        }

        $viewUri = "$($globalVars.baseUri)/$($globalVars.v1)/$($globalVars.views)"
        $getViews = Invoke-WebRequest -Uri $viewUri -Method "GET" -Headers @viewHeaders -SkipCertificateCheck
        $viewsResponse = $getViews.GetResponse()
        $viewsStatusCode = $getViews.StatusCode

        if($viewsStatusCode -ne 200){
            Write-Host "We are expecting an HTTP Status code of 200."
            break
        } else 
        {
            # Validation of our header is necessary. That has to come after the Status code is checked.
            $viewISSH = $request.Headers["X-IntegrationServer-Session-Hash"]
            if($viewISSH -ne $xIntegrationServerSessionHash) {
                Write-Host "Something has changed and your X-IntegrationServer-Session-Hash is no longer valid or has updated."
                break
            } else {
                Write-Host "Successfully validated the X-IntegrationServer-Session-Hash Header against the Response."
                [xml]$xml = $getViews.Content
                $viewsReturned = $xml.views.view

                $viewIds = @()
                foreach ($view in $viewsReturned){
                    $viewIdVal = $view.id
                    $viewIds += $viewIdVal
                }
                Write-Host "Choose one of the following View Ids to Copy and use."
                Write-Host $viewIds
                
                $viewSpecificHeaders = @{
                    "Accept" = "application/xml";
                    "X-IntegrationServer-Session-Hash" = $xIntegrationServerSessionHash;
                }
        

                $viewIdSpecific = Read-Host "Provide the View Id:"
                $viewSpecificUri = "$($globalVars.baseUri)/$($globalVars.v1)/$($globalVars.views)/$($viewIdSpecific)"
                $runView = Invoke-WebRequest -Uri $viewSpecificUri -Method "GET" -Headers @viewSpecificHeaders -SkipCertificateCheck
                
                $viewSpecificResponse = $runView.GetResponse()
                $viewSpecificStatusCode = $runView.StatusCode

                if($viewSpecificStatusCode -ne 200) {
                    Write-Host "We are expecting to return an HTTP Status code of 200."
                } else {
                    [xml]$specificXml = $runView.Content
                    
                    Write-Host "An XML will be returned of the view being ran."
                    Write-Host "Our View Returned the Following Content."
                    Write-Host $specificXml
                }
            }
        }

    } elseif($action -eq "drawers"){
        Write-Host "We are going to perform a view retrieval and run"
        Write-Host "Our expected output will be an xml. Effectively, the Response Body."
        
        $drawerHeaders = @{
            "Accept" = "application/xml";
            "X-IntegrationServer-Session-Hash" = $xIntegrationServerSessionHash;
        }

        $drawerUri = "$($globalVars.baseUri)/$($globalVars.v1)/$($globalVars.drawers)"
        $getDrawers = Invoke-WebRequest -Uri $drawerUri -Method "GET" -Headers @drawerHeaders -SkipCertificateCheck
        $drawersResponse = $getDrawers.GetResponse()
        $drawersStatusCode = $getDrawers.StatusCode

        if($drawersStatusCode -ne 200){
            Write-Host "We are expecting an HTTP Status code of 200."
            break
        } else 
        {
            # Validation of our header is necessary. That has to come after the Status code is checked.
            $drawerISSH = $request.Headers["X-IntegrationServer-Session-Hash"]
            if($drawerISSH -ne $xIntegrationServerSessionHash) {
                Write-Host "Something has changed and your X-IntegrationServer-Session-Hash is no longer valid or has updated."
                break
            } else {
                Write-Host "Successfully validated the X-IntegrationServer-Session-Hash Header against the Response."
                [xml]$xml = $getDrawers.Content
                $drawersReturned = $xml.drawers.drawer

                $drawerIds = @()
                foreach ($drawer in $drawersReturned){
                    $drawerIdVal = $drawer.name
                    $drawerIds += $drawerIdVal
                }
                Write-Host "Choose one of the following View Ids to Copy and use."
                Write-Host $drawerIds
                
                $drawerSpecificHeaders = @{
                    "Accept" = "application/xml";
                    "X-IntegrationServer-Session-Hash" = $xIntegrationServerSessionHash;
                }
        

                $drawerIdSpecific = Read-Host "Provide the View Id:"
                $drawerSpecificUri = "$($globalVars.baseUri)/$($globalVars.v1)/$($globalVars.drawers)/$($drawerIdSpecific)"
                $getDrawer = Invoke-WebRequest -Uri $drawerSpecificUri -Method "GET" -Headers @drawerSpecificHeaders -SkipCertificateCheck
                
                $drawerSpecificResponse = $getDrawer.GetResponse()
                $drawerSpecificStatusCode = $getDrawer.StatusCode

                if($drawerSpecificStatusCode -ne 200) {
                    Write-Host "We are expecting to return an HTTP Status code of 200."
                } else {
                    [xml]$specificXml = $getDrawer.Content
                    
                    Write-Host "An XML will be returned of the view being ran."
                    Write-Host "Our View Returned the Following Content."
                    Write-Host $specificXml
                }
            }
        }

    } elseif($action -eq "workflowItems"){
    
    } elseif($action -eq "serverStatus") {
    
    }

} # end of While Loop for $action

$disconnectHeaders = @{
    "Accept"="application/xml";
    "X-IntegrationServer-Session-Hash"= $xIntegrationServerSessionHash;
}

Invoke-WebRequest -Uri "$($baseUri)/$($globalVars.v1)/$($globalVars.connection)" -Headers $disconnectHeaders -Method "DELETE" -SkipCertificateCheck