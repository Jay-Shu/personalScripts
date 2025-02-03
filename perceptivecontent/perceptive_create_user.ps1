<#
                    .SYNOPSIS
                        This script is intended for creating new users via Integration Server. This is so we do not have to login
                    to the management console.

                    .DESCRIPTION
                        We have to establish a connection

                    .EXAMPLE
                        Get-RDUserSession -ConnectionBroker

                    .NOTES
                        We will need to include a number of functions to accomplish this task. Additionally, sessions cannot be ended
                    which are still active (not disconnected or suspended).

                    .INPUTS
                    username: Username that will be performing the promoting and demoting. This must be a current Perceptive Manager.
                    password: Password of the username performing the promoting and demoting. This must be a current Perceptive Manager.
                    inserverBin64: Inserver Installation Directory. This is where your executables live.
                    inserverBin64Old: Inserver Installation Directory for solutions from older versions. Prior to Version 7, it was [drive]:\inserver6

                    .LINK
                    https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.4
                    about_Operators

                    Changelog:
                        2025-01-20: Added in template for Integration Server Calls.
                        2025-01-20: Added form for easier user interactions.
#>


$globalVars = @{
    baseUri = "https://apachetomcat:port/integrationserver/"; # This value must be the Base URI and not an actual API Call.
    documents = "document";
    views = "view";
    drawers = "drawer";
    workflowItems = "workflowItem";
    serviceStatus = "status";
    serverInfo = "serverInfo";
    xIntegrationServerUsername = "departmentmanager";
    xIntegrationServerPassword = "departmentmanagerpassword";
    connection = "connection";
    workflowQueues = "workflowQueue"; # Since the Queue is provided along with the Process.
    interactive = $false;
}


# We need to validate that the Integration is Up and Perceptive Content is Up.
$serverStatusHeaders = @{
    "Accept" = "application/xml";
}

$serverStatusRequest = Invoke-WebRequest -Uri "$($globalVars.baseUri)/v1/status" -Headers @serverStatusHeaders -Method "GET" -SkipCertificateCheck
$serverStatusResponse = $serverStatusRequest.GetResponse()

[xml]$xml = $serverStatusRequest.Content
$serverStatusReturned = $xml.serviceStatus.perceptiveContentStatus

IF($serverStatusRequest.StatusCode -ne 200){
    Write-Host "Failed with HTTP Status Code: $($serverStatusRequest.StatusCode)"
} ELSEIF ($serverStatusReturned -eq "INSERVER_UP" && $serverStatusRequest.StatusCode -eq 200){
    Write-Host "Server is up proceeding on"
} ELSEIF ($serverStatusReturned -eq "INSERVER_DOWN_DB_ERROR" && $serverStatusRequest.StatusCode -eq 200){
    Write-Host "Server encountered issues at the Database Layer. Reach out to your Perceptive Content Administrator to resolve this issue."
} ELSEIF ($serverStatusReturned -eq "INSERVER_DOWN_UNREACHABLE" && $serverStatusRequest.StatusCode -eq 200){
    Write-Host "Server encountered issues at the Perceptive Content Server Layer. Reach out to your Perceptive Content Administrator to resolve this issue."
}


IF($serverStatusRequest.StatusCode -eq 200){

$headers = @{
    "Accept" = "application/xml";
    "X-IntegrationServer-Username" = "$($globalVars.$xIntegrationServerUsername)";
    "X-IntegrationServer-Password" = "$($globalVars.$xIntegrationServerPassword)";
}

$request = Invoke-WebRequest -Uri $fullConnectionUri -Method "GET" -Headers @headers -SkipCertificateCheck
$response = $request.GetResponse()
$xIntegrationServerSessionHash = $request.Headers["X-IntegrationServer-Session-Hash"]

if($NULL -eq $xIntegrationServerSessionHash){
    Write-Host "Failed to establish a connection and receive an X-IntegrationServer-Session-Hash"
    break
    } ELSE {

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'New User Creation'
$form.Size = New-Object System.Drawing.Size(800, 400)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(400, 330)
$okButton.Size = New-Object System.Drawing.Size(75, 23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(480, 330)
$cancelButton.Size = New-Object System.Drawing.Size(75, 23)
$cancelButton.Text = 'CANCEL'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$userfullnamelabel = New-Object System.Windows.Forms.Label
$userfullnamelabel.Location = New-Object System.Drawing.Point(10, 20)
$userfullnamelabel.Size = New-Object System.Drawing.Size(280, 20)
$userfullnamelabel.Text = "Provide the Perceptive User Name:"
$form.Controls.Add($userfullnamelabel)

$userfullnametext = New-Object System.Windows.Forms.TextBox
$userfullnametext.Location = New-Object System.Drawing.Point(10, 40)
$userfullnametext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($userfullnametext)

$useractivelabel = New-Object System.Windows.Forms.Label
$useractivelabel.Location = New-Object System.Drawing.Point(10, 60)
$useractivelabel.Size = New-Object System.Drawing.Size(280, 20)
$useractivelabel.Text = 'Will this account be active (true or false):'
$form.Controls.Add($useractivelabel)

$useractivetext = New-Object System.Windows.Forms.TextBox
$useractivetext.Location = New-Object System.Drawing.Point(10, 80)
$useractivetext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($useractivetext)

$firstnamelabel = New-Object System.Windows.Forms.Label
$firstnamelabel.Location = New-Object System.Drawing.Point(10, 100)
$firstnamelabel.Size = New-Object System.Drawing.Size(280, 30)
$firstnamelabel.Text = 'First Name:'
$form.Controls.Add($firstnamelabel)

$firstnametext = New-Object System.Windows.Forms.TextBox
$firstnametext.Location = New-Object System.Drawing.Point(10, 130)
$firstnametext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($firstnametext)

$lastnamelabel = New-Object System.Windows.Forms.Label
$lastnamelabel.Location = New-Object System.Drawing.Point(10, 150)
$lastnamelabel.Size = New-Object System.Drawing.Size(280, 30)
$lastnamelabel.Text = 'Last Name:'
$form.Controls.Add($lastnamelabel)

$lastnametext = New-Object System.Windows.Forms.TextBox
$lastnametext.Location = New-Object System.Drawing.Point(10, 180)
$lastnametext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($lastnametext)

$prefixlabel = New-Object System.Windows.Forms.Label
$prefixlabel.Location = New-Object System.Drawing.Point(10, 200)
$prefixlabel.Size = New-Object System.Drawing.Size(280, 20)
$prefixlabel.Text = 'Prefix:'
$form.Controls.Add($prefixlabel)

$prefixtext = New-Object System.Windows.Forms.TextBox
$prefixtext.Location = New-Object System.Drawing.Point(10, 220)
$prefixtext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($prefixtext)

$suffixlabel = New-Object System.Windows.Forms.Label
$suffixlabel.Location = New-Object System.Drawing.Point(10, 200)
$suffixlabel.Size = New-Object System.Drawing.Size(280, 20)
$suffixlabel.Text = 'Suffix:'
$form.Controls.Add($suffixlabel)

$suffixtext = New-Object System.Windows.Forms.TextBox
$suffixtext.Location = New-Object System.Drawing.Point(10, 220)
$suffixtext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($suffixtext)

$titlelabel = New-Object System.Windows.Forms.Label
$titlelabel.Location = New-Object System.Drawing.Point(10, 240)
$titlelabel.Size = New-Object System.Drawing.Size(280, 20)
$titlelabel.Text = 'Title:'
$form.Controls.Add($titlelabel)

$titletext = New-Object System.Windows.Forms.TextBox
$titletext.Location = New-Object System.Drawing.Point(10, 260)
$titletext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($titletext)

$phonelabel = New-Object System.Windows.Forms.Label
$phonelabel.Location = New-Object System.Drawing.Point(10, 240)
$phonelabel.Size = New-Object System.Drawing.Size(280, 20)
$phonelabel.Text = 'Phone:'
$form.Controls.Add($phonelabel)

$phonetext = New-Object System.Windows.Forms.TextBox
$phonetext.Location = New-Object System.Drawing.Point(10, 260)
$phonetext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($phonetext)

$mobilelabel = New-Object System.Windows.Forms.Label
$mobilelabel.Location = New-Object System.Drawing.Point(10, 240)
$mobilelabel.Size = New-Object System.Drawing.Size(280, 20)
$mobilelabel.Text = 'Mobile:'
$form.Controls.Add($mobilelabel)

$mobiletext = New-Object System.Windows.Forms.TextBox
$mobiletext.Location = New-Object System.Drawing.Point(10, 260)
$mobiletext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($mobiletext)

$pagerlabel = New-Object System.Windows.Forms.Label
$pagerlabel.Location = New-Object System.Drawing.Point(10, 240)
$pagerlabel.Size = New-Object System.Drawing.Size(280, 20)
$pagerlabel.Text = 'Pager:'
$form.Controls.Add($pagerlabel)

$pagertext = New-Object System.Windows.Forms.TextBox
$pagertext.Location = New-Object System.Drawing.Point(10, 260)
$pagertext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($pagertext)

$faxlabel = New-Object System.Windows.Forms.Label
$faxlabel.Location = New-Object System.Drawing.Point(10, 240)
$faxlabel.Size = New-Object System.Drawing.Size(280, 20)
$faxlabel.Text = 'Fax:'
$form.Controls.Add($faxlabel)

$faxtext = New-Object System.Windows.Forms.TextBox
$faxtext.Location = New-Object System.Drawing.Point(10, 260)
$faxtext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($faxtext)

$emaillabel = New-Object System.Windows.Forms.Label
$emaillabel.Location = New-Object System.Drawing.Point(10, 240)
$emaillabel.Size = New-Object System.Drawing.Size(280, 20)
$emaillabel.Text = 'Email:'
$form.Controls.Add($emaillabel)

$emailtext = New-Object System.Windows.Forms.TextBox
$emailtext.Location = New-Object System.Drawing.Point(10, 260)
$emailtext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($emailtext)


$form.Topmost = $true

$form.Add_Shown(
    {
        $userfullnametext.Select(),
        $useractivetext.Select(),
        $firstnametext.Select(),
        $lastnametext.Select(),
        $prefixtext.Select(),
        $suffixtext.Select(),
        $titletext.Select(),
        $phonetext.Select()
    }
)

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $x = $odbcdsntext.Text
    $y = $odbcservertext.Text
    $x
    $y
}
    }

}