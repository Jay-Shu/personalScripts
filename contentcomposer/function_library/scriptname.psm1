function GetScriptName

{

    try {
        $myInvocation.ScriptName;
        $scriptName = (GetScriptName | Split-Path -Leaf);
    Write-Host "Executing script $($scriptName)";
    } catch {
        Write-Host "";
        return;
    }
return $scriptName;
}

function Get-CurrentLineNumber {
    [int]$MyInvocation.ScriptLineNumber
    }
    
    <#
    try { Bad-Command }
    catch {
    write-host “Script Failed at line No: $(Get-CurrentLineNumber)”
    exit
   
    }
#>

Export-ModuleMember -Function GetScriptName,Get-CurrentLineNumber