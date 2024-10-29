<#
                    .SYNOPSIS
                    For Utilizing the DB Specific Intool Commands.

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
        inserverBin64 = "E:\inserver\bin64";
        inserverBin64Old = "E:\inserver6\bin64";
        schema = "inuser."
        in_doc = "IN_DOC";
        in_sc_users = "IN_SC_USRS";
        in_wf_queue = "IN_WF_QUEUE";
        in_wf_process = "IN_WF_PRCOESS";
        in_wf_item = "IN_WF_ITEM";
        in_wf_item_hist = "IN_WF_ITEM_HIST";
        in_wf_item_queue_hist = "IN_WF_ITEM_QUEUE_HIST";
        in_wf_item_hist_arch = "IN_WF_ITEM_HIST_ARCH";
        in_wf_item_queue_hist_arch = "IN_WF_ITEM_QUEUE_HIST_ARCH";
        examples = $true;
    }


IF (Test-Path -Path $globalVars.inserverBin64)
{
    Set-Location -Path $globalVars.inserverBin64

} ELSEIF (Test-Path -Path $globalVars.inserverBin64Old)
{
    Set-Location -Path $globalVars.inserverBin64Old
}

$choiceMenu = @"
Please select from the following list:
db-struct
db-rec-num
db-list-tables
db-show-execution-plan
db-schema-validation

If you do not wish to make a choice, just press enter.
"@

$chosenItem = Read-Host $choiceMenu

WHILE ($NULL -ne $chosenItem){
IF($chosenItem -eq "db-struct"){
    IF($examples -eq $true){
        IF (Test-Path -Path $globalVars.inserverBin64)
{
    # Bin64
    
    &{intool --cmd db-struct --table-name $globalVars.in_doc}
    &{intool --cmd db-struct --table-name $globalVars.in_sc_users}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_queue}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_process}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_item}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_item_hist}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_item_queue_hist}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_item_hist_arch}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_item_queue_hist_arch}

} # IF Closing for Bin64
    ELSEIF (Test-Path -Path $globalVars.inserverBin64Old)
{
    # Bin
    &{intool --cmd db-struct --table-name $globalVars.in_doc}
    &{intool --cmd db-struct --table-name $globalVars.in_sc_users}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_queue}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_process}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_item}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_item_hist}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_item_queue_hist}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_item_hist_arch}
    &{intool --cmd db-struct --table-name $globalVars.in_wf_item_queue_hist_arch}
} # ELSEIF Closing for Bin

    } ELSE {
        # Note, that these queries are executed by the inuser. The inuser account is a Database Level Account.
        # Not an actual user within Perceptive Content.
        $inputTable = Read-Host "Please provide a table name(e.g. IN_DOC, IN_DOC_KW, IN_WF_QUEUE):"
        &{intool --cmd db-struct --table-name $inputTable}

        
    }

    $chosenItem = $NULL
    $choiceMenu = @"
Please select from the following list:
db-struct
db-rec-num
db-list-tables
db-show-execution-plan
db-schema-validation

If you do not wish to make a choice, just press enter.
"@
    $chosenItem = Read-Host $choiceMenu
}

ELSEIF($chosenItem -eq "db-rec-num"){
    IF($examples -eq $true){
        IF (Test-Path -Path $globalVars.inserverBin64)
{
    # Bin64
    
    &{intool --cmd db-rec-num --table-name $globalVars.in_doc}
    &{intool --cmd db-rec-num --table-name $globalVars.in_sc_users}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_queue}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_process}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_item}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_item_hist}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_item_queue_hist}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_item_hist_arch}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_item_queue_hist_arch}

} # IF Closing for Bin64
    ELSEIF (Test-Path -Path $globalVars.inserverBin64Old)
{
    # Bin
    &{intool --cmd db-rec-num --table-name $globalVars.in_doc}
    &{intool --cmd db-rec-num --table-name $globalVars.in_sc_users}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_queue}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_process}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_item}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_item_hist}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_item_queue_hist}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_item_hist_arch}
    &{intool --cmd db-rec-num --table-name $globalVars.in_wf_item_queue_hist_arch}
} # ELSEIF Closing for Bin

    } ELSE {
        # Note, that these queries are executed by the inuser. The inuser account is a Database Level Account.
        # Not an actual user within Perceptive Content.
        $inputTable = Read-Host "Please provide a table name(e.g. IN_DOC, IN_DOC_KW, IN_WF_QUEUE):"
        &{intool --cmd db-rec-num --table-name $inputTable}

        
    }

    $chosenItem = $NULL
    $choiceMenu = @"
Please select from the following list:
db-struct
db-rec-num
db-list-tables
db-show-execution-plan
db-schema-validation

If you do not wish to make a choice, just press enter.
"@
    $chosenItem = Read-Host $choiceMenu
}

ELSEIF($chosenItem -eq "db-list-tables")

{
    # This has no arguments.
    Write-Host "Executing intool --cmd db-list-tables."
    &{intool --cmd db-list-tables}
    $chosenItem = $NULL
    $choiceMenu = @"
Please select from the following list:
db-struct
db-rec-num
db-list-tables
db-show-execution-plan
db-schema-validation

If you do not wish to make a choice, just press enter.
"@
    $chosenItem = Read-Host $choiceMenu

}

ELSEIF ($choiceMenu -eq "db-show-execution-plan")

{
        Write-Host "Exeucting intool --cmd db-show-execution-plan"
        $chosenItem = $NULL
        $queryChoice = @"
Provide additional arguments:
query
queryFile
queryLogFile

the outputFile paramater will be added each time
"@


IF($queryChoice -eq "query"){

IF (Test-Path -Path $globalVars.inserverBin64)
        {
            $inputQuery = Read-Host "Please provide a query to be used. Include the schema."
            # inputQuery = "SELECT * FROM inuser.IN_SC_USRS"
            $randomNum = Get-Random
            &{intool --cmd db-show-execution-plan --query $inputQuery --outputFile "$($globalVars.inserverBin64)/$($randomNum)-query-log.txt"}

        } # IF Closing for Bin64
    ELSEIF (Test-Path -Path $globalVars.inserverBin64Old)
        {
            $inputQuery = Read-Host "Please provide a query to be used. Include the schema."
            $randomNum = Get-Random
            &{intool --cmd db-show-execution-plan --query $inputQuery --outputFile "$($globalVars.inserverBin64Old)/$($randomNum)-query-log.txt"}
        } # ELSEIF Closing for Bin
    } 
    ELSEIF ($queryChoice -eq "queryFile")
        {
            $fileLocation = Read-Host "Please provide a file location (E:/folder/myfile.sql):"
            IF($NULL -ne $fileLocation)
            {
                IF(Test-Path -Path $globalVars.inserverBin64){
                $randomNum = Get-Random
                &{intool --cmd db-show-execution-plan --queryFile $fileLocation --outputFile "$($globalVars.inserverBin64)/$($randomNum)-query-log.txt"}
                ELSE{
                    $randomNum = Get-Random
                    &{intool --cmd db-show-execution-plan --queryFile $fileLocation --outputFile "$($globalVars.inserverBin64Old)/$($randomNum)-query-log.txt"}
                }
            
            
            }
            } else {
                Write-Host "Invalid Location, File Does Not Exist, Location Does Not Exist, or File/Location is Inaccessible."
                break
            }
        }
    ELSEIF($queryChoice -eq "queryLogFile")
    {
            $fileLocation = Read-Host "Please provide a file location (E:/folder/myfile.sql):"
            IF($NULL -ne $fileLocation)
            {
                IF(Test-Path -Path $globalVars.inserverBin64){
                $randomNum = Get-Random
                &{intool --cmd db-show-execution-plan --queryLogFile $fileLocation --outputFile "$($globalVars.inserverBin64)/$($randomNum)-query-log.txt"}
                ELSE{
                    $randomNum = Get-Random
                    &{intool --cmd db-show-execution-plan --queryLogFile $fileLocation --outputFile "$($globalVars.inserverBin64Old)/$($randomNum)-query-log.txt"}
                }
            
            
            }
            } else {
                Write-Host "Invalid Location, File Does Not Exist, Location Does Not Exist, or File/Location is Inaccessible."
                break
            }
    }
    $chosenItem = $NULL
    $choiceMenu = @"
Please select from the following list:
db-struct
db-rec-num
db-list-tables
db-show-execution-plan
db-schema-validation

If you do not wish to make a choice, just press enter.
"@
    $chosenItem = Read-Host $choiceMenu
} # db-show-execution-plan closing.
ELSEIF($chosenItem -eq "db-schema-validation")
{
    Write-Host "This takes no inputs. But, Will show whether your current database schema is valid or needs to be updated."
    IF (Test-Path -Path $globalVars.inserverBin64)
        {
            &{intool --cmd db-schema-validation}

        } # IF Closing for Bin64
    ELSEIF (Test-Path -Path $globalVars.inserverBin64Old)
        {
            &{intool --cmd db-schema-validation}
        } # ELSEIF Closing for Bin
            $chosenItem = $NULL
        $choiceMenu = @"
Please select from the following list:
db-struct
db-rec-num
db-list-tables
db-show-execution-plan
db-schema-validation
        
If you do not wish to make a choice, just press enter.
"@
            $chosenItem = Read-Host $choiceMenu
} # db-schema-validation closing.

} # While Loop

function decisionList{
    $chosenItem = $NULL
    $choiceMenu = @"
Please select from the following list:
db-struct
db-rec-num
db-list-tables
db-show-execution-plan
db-schema-validation

If you do not wish to make a choice, just press enter.
"@
    $chosenItem = Read-Host $choiceMenu
}