<#
                    .SYNOPSIS
                    Promote and Demote Perceptive Users within Perceptive Content.

                    .DESCRIPTION
                    This script is intended to make the process of promoting and demoting of Perceptive Users to/from Managers.

                    .EXAMPLE
                    intool --cmd promote-perceptive-manager --username myusername --login-name currentperceptivemanager --login-password currentperceptivemanagerpassword
                    intool --cmd demote-perceptive-manager --username myusername --login-name currentperceptivemanager --login-password currentperceptivemanagerpassword

                    .NOTES
                    This script is inclusive to Promote and Demote. Not intended for other uses.

                    .INPUTS
                    username: Username that will be performing the promoting and demoting. This must be a current Perceptive Manager.
                    password: Password of the username performing the promoting and demoting. This must be a current Perceptive Manager.
                    inserverBin64: Inserver Installation Directory. This is where your executables live.
                    inserverBin64Old: Inserver Installation Directory for solutions from older versions. Prior to Version 7, it was [drive]:\inserver6
                    #>
    #param (
    #
    #)

$globalVars = @{
    username = "perceptivemanger";
    password = "password";
    inserverBin64 = "E:\inserver\bin64";
    inserverBin64Old = "E:\inserver6\bin64";
}


$useGlobalVars = $true


if ($useGlobalVars -eq $true){
    $promoteOrDemote = Read-Host "Provide 1 for Promote, Provide 2 for Demote:"

    while($promoteOrDemote -eq 1 -or $promoteOrDemote -eq 2){
    
    $inputUserName = Read-Host "Please Enter the Username of the Perceptive Manager you wish to Promote or Demote"

    Set-Location -Path $globalVars.inserverBin64
    
    if($promoteOrDemote -eq 1){
        &{intool --cmd promote-perceptive-manager --username "${inputUsername}" --login-name $globalVars.username --login-password $globalVars.password}
        $promoteOrDemote = Read-Host "Provide 1 for Promote, Provide 2 for Demote:"
    } elseif ($promoteOrDemote -eq 2) {
        &{intool --cmd demote-perceptive-manager --username "${inputUsername}" --login-name $globalVars.username --login-password $globalVars.password}
        $promoteOrDemote = Read-Host "Provide 1 for Promote, Provide 2 for Demote:"
    } else {
        Write-Host "Exiting script."
        break
    }
}

} elseif ($useGlobalVars -eq $false){
    
    $promoteOrDemote = Read-Host "Provide 1 for Promote, Provide 2 for Demote:"
    $userName2 = Read-Host "Please Enter the Username of the Perceptive Manager:"
    $userPassword2 = Read-Host "Please Enter the Username of the Perceptive Manager:" -MaskInput -AsSecureString

    while($promoteOrDemote -eq 1 -or $promoteOrDemote -eq 2){
    
    
    $inputPromoteDemote = Read-Host "Please enter the username of who you want to Prmote/Demote:"

    Set-Location -Path $globalVars.inserverBin64
    
    if($promoteOrDemote -eq 1){
        &{intool --cmd promote-perceptive-manager --username "${inputPromoteDemote}" --login-name $userName2 --login-password $userPassword2}
        Write-Host "Provide another value to exit script other than 1 or 2"
        $promoteOrDemote = Read-Host "Provide 1 for Promote, Provide 2 for Demote:"
    } elseif ($promoteOrDemote -eq 2) {
        &{intool --cmd demote-perceptive-manager --username "${inputPromoteDemote}" --login-name $userName2 --login-password $userPassword2}
        Write-Host "Provide another value to exit script other than 1 or 2"
        $promoteOrDemote = Read-Host "Provide 1 for Promote, Provide 2 for Demote:"
    } else {
        Write-Host "Exiting script."
        break
    }
}

} else {
    Write-Host "Invalid Entry. Exiting Script."
    break
}