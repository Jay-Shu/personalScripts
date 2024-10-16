# https://www.itprotoday.com/powershell/how-add-exit-mechanisms-powershell-scripts

Add-Type -AssemblyName System.Windows.Forms

# Create the form
$form = New-Object Windows.Forms.Form
$form.Text = “Content Composer by Hyland Software”
$form.Size = New-Object Drawing.Size(500, 500)
$form.FormBorderStyle = [Windows.Forms.FormBorderStyle]::FixedDialog
$form.StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
$Form.KeyPreview = $True
$Form.Add_KeyDown({if ($_.KeyCode -eq “Escape”)
     {$Form.Close()}})

# Create the label to display “Hello World”
$label = New-Object Windows.Forms.Label
$label.Text = “Content Composer”
$label.Font = New-Object Drawing.Font(“Arial”, 14, [Drawing.FontStyle]::Bold)
$label.AutoSize = $true
$label.Location = New-Object Drawing.Point(100, 40)
$label.ForeColor = [System.Drawing.Color]::Black

$Button1 = New-Object System.Windows.Forms.Button
$Button1.Location = New-Object System.Drawing.Size (200,250)
$Button1.Size = New-Object System.Drawing.Size(80,30)
$Button1.Font=New-Object System.Drawing.Font(“Lucida Console”,14,[System.Drawing.FontStyle]::Regular)
$Button1.BackColor = “LightGray”
$Button1.Text = “Exit”
<#
$Button1.Add_Click({
            $Form.Close()
            })
#>
$Button2 = New-Object System.Windows.Forms.Button
$Button2.Location = New-Object System.Drawing.Size(100,250)
$Button2.Size = New-Object System.Drawing.Size(80,30)
$Button2.Font=New-Object System.Drawing.Font(“Lucida Console”,14,[System.Drawing.FontStyle]::Regular)
$Button2.BackColor = “LightGray”
$Button2.Text = “Do The Needful”

# Add the label to the form
$form.Controls.Add($label)
$Form.Controls.Add($Button1)

# Display the form
$form.ShowDialog()