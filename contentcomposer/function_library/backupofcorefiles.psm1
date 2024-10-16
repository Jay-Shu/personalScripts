# This is the crude version
# Author: Jacob Shuster
# Date: 2024-03-13
# Latest Update Date: N/A
# 
<#
    Description: 
        This script is intended for performing a simple backup of the Core Installation Files that are "*.config".

    Future Development:
        1. Add in Prompts
        2. Error Catches
        3. Dynamic File Naming for backups, to prevent overwriting.
        4. Incorporate as part of a library

    Modifications:
        2024-03-13: Initial Creation
        2024-03-13: Removed excessive spacing from the Copy + Paste


#>

$docopy = 1

IF($docopy -eq 1){
    Copy-Item -Path Composer.Client.exe.config -Destination E:/backup/Composer.Client.exe.config
    Copy-Item -Path Composer.ConfigurationEditor.exe.config -Destination E:/backup/Composer.ConfigurationEditor.exe.config
    Copy-Item -Path Composer.ConsoleHost.exe.config -Destination E:/backup/Composer.ConsoleHost.exe.config
    Copy-Item -Path Composer.Core.exe.config -Destination E:/backup/Composer.Core.exe.config
    Copy-Item -Path Composer.Database.Setup.exe.config -Destination E:/backup/Composer.Database.Setup.exe.config
    Copy-Item -Path Composer.EncryptionTool.exe.config -Destination E:/backup/Composer.EncryptionTool.exe.config               
    Copy-Item -Path Composer.InstallTool.exe.config -Destination E:/backup/Composer.InstallTool.exe.config
    Copy-Item -Path Composer.MWS.exe.config -Destination E:/backup/Composer.MWS.exe.config
    Copy-Item -Path Composer.OWS.exe.config -Destination E:/backup/Composer.OWS.exe.config
    Copy-Item -Path Composer.SetupAssistant.exe.config -Destination E:/backup/Composer.SetupAssistant.exe.config
    Copy-Item -Path Composer.Studio.exe.config -Destination E:/backup/Composer.Studio.exe.config
    Copy-Item -Path Composer.SupportTool.exe.config -Destination E:/backup/Composer.SupportTool.exe.config
    Copy-Item -Path Composer.Tool.exe.config -Destination E:/backup/Composer.Tool.exe.config
    Copy-Item -Path Composer.WCF.Console.exe.config -Destination E:/backup/Composer.WCF.Console.exe.config
    Copy-Item -Path Composer.WindowsServiceHost.exe.config -Destination E:/backup/Composer.WindowsServiceHost.exe.config
    Copy-Item -Path Composer.XWS.exe.config -Destination E:/backup/Composer.XWS.exe.config
    Copy-Item -Path dbalias.config -Destination E:/backup/dbalias.config
    Copy-Item -Path DocXCompiler.exe.config -Destination E:/backup/DocXCompiler.exe.config
    Copy-Item -Path Encoder.exe.config -Destination E:/backup/Encoder.exe.config
    Copy-Item -Path ExeUpdater.exe.config -Destination E:/backup/ExeUpdater.exe.config
    Copy-Item -Path IdpUserCrypt.exe.config -Destination E:/backup/IdpUserCrypt.exe.config
    Copy-Item -Path inputmasks.config -Destination E:/backup/inputmasks.config
    Copy-Item -Path InstallUtil.exe.config -Destination E:/backup/InstallUtil.exe.config
    Copy-Item -Path ModusSuite.Common.ManualVariablesEditor.dll.config -Destination E:/backup/ModusSuite.Common.ManualVariablesEditor.dll.config
    Copy-Item -Path ModusSuite.Common.PropertyEditors.dll.config -Destination E:/backup/ModusSuite.Common.PropertyEditors.dll.config
    Copy-Item -Path ModusSuite.Common.XPathEvaluator.exe.config -Destination E:/backup/ModusSuite.Common.XPathEvaluator.exe.config      
    Copy-Item -Path ModusSuite.Odin.OdinViews.dll.config -Destination E:/backup/ModusSuite.Odin.OdinViews.dll.config
    Copy-Item -Path MonalisaEngine.exe.config -Destination E:/backup/MonalisaEngine.exe.config
    Copy-Item -Path odin.config -Destination E:/backup/odin.config
    Copy-Item -Path OdinDocx2Xps.exe.config -Destination E:/backup/OdinDocx2Xps.exe.config
    Copy-Item -Path odinparameter.config -Destination E:/backup/odinparameter.config
    Copy-Item -Path OdinStreamToDmo.exe.config -Destination E:/backup/OdinStreamToDmo.exe.config
    Copy-Item -Path RemoteControl.config -Destination E:/backup/RemoteControl.config
    Copy-Item -Path repository.config -Destination E:/backup/repository.config
    Copy-Item -Path selparams.config -Destination E:/backup/selparams.config                                 
    Copy-Item -Path systemlayout.config -Destination E:/backup/systemlayout.config
    Copy-Item -Path TransferConsole.exe.config -Destination E:/backup/TransferConsole.exe.config
    Copy-Item -Path UserRepository.config -Destination E:/backup/UserRepository.config
    Copy-Item -Path UserRepository_Idp.config -Destination E:/backup/UserRepository_Idp.config
    Copy-Item -Path UserRepository_Ldap.config -Destination E:/backup/UserRepository_Ldap.config
    Copy-Item -Path vdatabase.config -Destination E:/backup/vdatabase.config
    Copy-Item -Path xdata.config -Destination E:/backup/xdata.config
    Copy-Item -Path XmlPatcher.exe.config -Destination E:/backup/XmlPatcher.exe.config
    } else {
        Write-Host "$docopy is not set to 1, if you wish to copy these files set $docopy to 1 and not ""1"" "
}



