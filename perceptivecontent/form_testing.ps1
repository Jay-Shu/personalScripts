Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'ODBC Connection Setup'
$form.Size = New-Object System.Drawing.Size(600, 400)
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

$odbcdsnlabel = New-Object System.Windows.Forms.Label
$odbcdsnlabel.Location = New-Object System.Drawing.Point(10, 20)
$odbcdsnlabel.Size = New-Object System.Drawing.Size(280, 20)
$odbcdsnlabel.Text = 'Provide the ODBC DSN:'
$form.Controls.Add($odbcdsnlabel)

$odbcdsntext = New-Object System.Windows.Forms.TextBox
$odbcdsntext.Location = New-Object System.Drawing.Point(10, 40)
$odbcdsntext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcdsntext)

$odbcserverlabel = New-Object System.Windows.Forms.Label
$odbcserverlabel.Location = New-Object System.Drawing.Point(10, 60)
$odbcserverlabel.Size = New-Object System.Drawing.Size(280, 20)
$odbcserverlabel.Text = 'Provide the ODBC Server:'
$form.Controls.Add($odbcserverlabel)

$odbcservertext = New-Object System.Windows.Forms.TextBox
$odbcservertext.Location = New-Object System.Drawing.Point(10, 80)
$odbcservertext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcservertext)

$odbcdrivernamelabel = New-Object System.Windows.Forms.Label
$odbcdrivernamelabel.Location = New-Object System.Drawing.Point(10, 100)
$odbcdrivernamelabel.Size = New-Object System.Drawing.Size(280, 30)
$odbcdrivernamelabel.Text = 'Please Provide a Driver Name (e.g. ODBC Driver 17 for SQL Server):'
$form.Controls.Add($odbcdrivernamelabel)

$odbcdrivernametext = New-Object System.Windows.Forms.TextBox
$odbcdrivernametext.Location = New-Object System.Drawing.Point(10, 130)
$odbcdrivernametext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcdrivernametext)

$odbcsqlauthorwindowsauthlabel = New-Object System.Windows.Forms.Label
$odbcsqlauthorwindowsauthlabel.Location = New-Object System.Drawing.Point(10, 150)
$odbcsqlauthorwindowsauthlabel.Size = New-Object System.Drawing.Size(280, 30)
$odbcsqlauthorwindowsauthlabel.Text = 'Please provide Yes for SQL Auth or No for Windows Auth:'
$form.Controls.Add($odbcsqlauthorwindowsauthlabel)

$odbcsqlauthorwindowsauthtext = New-Object System.Windows.Forms.TextBox
$odbcsqlauthorwindowsauthtext.Location = New-Object System.Drawing.Point(10, 180)
$odbcsqlauthorwindowsauthtext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcsqlauthorwindowsauthtext)

$odbcdatabaselabel = New-Object System.Windows.Forms.Label
$odbcdatabaselabel.Location = New-Object System.Drawing.Point(10, 200)
$odbcdatabaselabel.Size = New-Object System.Drawing.Size(280, 20)
$odbcdatabaselabel.Text = 'Please Provide the Name of the Database:'
$form.Controls.Add($odbcdatabaselabel)

$odbcdatabasetext = New-Object System.Windows.Forms.TextBox
$odbcdatabasetext.Location = New-Object System.Drawing.Point(10, 220)
$odbcdatabasetext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcdatabasetext)

$odbcportlabel = New-Object System.Windows.Forms.Label
$odbcportlabel.Location = New-Object System.Drawing.Point(10, 200)
$odbcportlabel.Size = New-Object System.Drawing.Size(280, 20)
$odbcportlabel.Text = 'Please Provide a Port (e.g. 1433):'
$form.Controls.Add($odbcportlabel)

$odbcporttext = New-Object System.Windows.Forms.TextBox
$odbcporttext.Location = New-Object System.Drawing.Point(10, 220)
$odbcporttext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcporttext)

$odbcuseftmonlylabel = New-Object System.Windows.Forms.Label
$odbcuseftmonlylabel.Location = New-Object System.Drawing.Point(10, 240)
$odbcuseftmonlylabel.Size = New-Object System.Drawing.Size(280, 20)
$odbcuseftmonlylabel.Text = 'Provide a Yes or No for File Transfer Manager:'
$form.Controls.Add($odbcuseftmonlylabel)

$odbcuseftmonlytext = New-Object System.Windows.Forms.TextBox
$odbcuseftmonlytext.Location = New-Object System.Drawing.Point(10, 260)
$odbcuseftmonlytext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcuseftmonlytext)


$form.Topmost = $true

$form.Add_Shown(
    {
        $odbcdsntext.Select(),
        $odbcservertext.Select(),
        $odbcdrivernametext.Select(),
        $odbcsqlauthorwindowsauthtext.Select(),
        $odbcdatabasetext.Select(),
        $odbcporttext.Select(),
        $odbcuseftmonlytext.Select()
    }
)
#$form.Add_Shown({$odbcdsntext.Activate()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $x = $odbcdsntext.Text
    $y = $odbcservertext.Text
    $x
    $y
}