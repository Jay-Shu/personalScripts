function GetScriptName

{

$myInvocation.ScriptName

}

$scriptName = (GetScriptName | Split-Path -Leaf)

Write-Host "Executing script $($scriptName)"

Export-ModuleMember -Function GetScriptName