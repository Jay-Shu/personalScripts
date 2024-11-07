<#
                    .SYNOPSIS
                    For testing with SambaSecurity APIs.

                    .DESCRIPTION
                    Demonstrational Script for SambaSecurity APIs.

                    .EXAMPLE
                    &{intool --cmd db-struct --table-name IN_DOC}

                    .NOTES
                    Decision between either creating a form or sticking with the While Loop needs to be made in the near future.

                    .INPUTS
                    inserverBin64: Bin64 directory for your Perceptive Content Installation.
                    inserverBin64Old: Bin64 directory for your Upgraded Perceptive Content Installation.
                    schema: Database Schema used is inuser or inemuser
                    in_doc: Documents Table
                    in_sc_users: Users Table
                    in_wf_queue: Workflow Queues Table
                    in_wf_process: Worklow Processes Table
                    in_wf_item: Workflow Item Table
                    in_wf_item_hist: Workflow History Table
                    in_wf_item_queue_hist: Workflow Item Queue History Table.
                    in_wf_item_hist_arch: Workflow Item History Archive Table.
                    in_wf_item_queue_hist_arch: Workflow Item QUeue History Archive Table.
                    examples: Run examples $true, don't run examples $false
                    choiceMenu: Decision List.
                    chosenItem: chosenMenu item decided by the user
                    inputTable: The Table being used for db-struct.

                    .LINK
                    
                    #>
    #param (
    #
    #)

    $baseUri = "https://api-demo.sambasafety.io/oauth2/v1/token"

    $username = Read-Host "Provide a Username: "
    $password = Read-Host "Provide a Password: "

    $encodedAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($username):$($password)"))
    $tokenHeaders = @{
    "Content-Type"="application/x-www-form-urlencoded";
    "Authorization"="Basic $($encodedAuth)";
    "Accept"="application/xml";
    }