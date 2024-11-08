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
                    

                    .LINK
                    https://www.postman.com/sambaengineering/developer-sambasafety-com/request/3zm54uj/obtain-a-token
                    SambaSafety API Documentation\Authentication\Obtain a Token
                    #>
    #param (
    #
    #)
    # $baseUri = "https://developer.sambasafety.io"
    $baseUri = "https://api-demo.sambasafety.io/oauth2/v1/token?grant_type=client_credentials&scope=API"

    $username = Read-Host "Provide a Username: "
    $password = Read-Host "Provide a Password: "

    $timeZoneOffset = (Get-TimeZone).GetUtcOffset((Get-Date))

    # This may be turned into a function
    $todaysDate = Get-Date -Format "yyyy-mm-ddThh:mm:ss$($timeZoneOffset)"

    $encodedAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($username):$($password)"))
    $tokenHeaders = @{
    "Content-Type"="application/x-www-form-urlencoded";
    "Authorization"="Basic $($encodedAuth)";
    "Accept"="application/json"; # JSON is the default and Documentation doesn't indicate any other return format.
    "X-Api-Key"="MyApiKey"
    }

    $obtainToken = Invoke-WebRequest -Uri "$($baseUri)" -Headers @tokenHeaders
    $obtainTokenResponse = $obtainToken.GetResponse()
    $returnBody = $obtainToken.Content
    $accessToken = $returnBody.access_token
    Write-Host "Current Bearer Authorization Token: $($accessToken)"


    <#
        Subsequent API Calls will be using $accessToken for their Bearer Token
        $tokenHeaders = @{
    "Content-Type"="application/x-www-form-urlencoded";
    "Authorization"="$($accessToken)";
    "Accept"="application/json"; # JSON is the default and Documentation doesn't indicate any other return format.
    "X-Api-Key"="MyApiKey"
    }

    #>
