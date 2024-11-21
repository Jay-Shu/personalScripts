<#
                    .SYNOPSIS
                    For testing with SambaSecurity APIs.

                    .DESCRIPTION
                    Demonstrational Script for SambaSecurity APIs.

                    .EXAMPLE
                    &{intool --cmd db-struct --table-name IN_DOC}

                    .NOTES
                    Headers are Independent of the payload/body/content of the API Call. Therefore, I elected to stick with Authorization="Bearer $($accessToken)"
                      as the ideal choice. This keeps the waters from being muddied. If you are doing this via curl then follow documentation.

                    .INPUTS
                    Too many to list. Search by Section for your inputs.

                    .LINK
                    https://www.postman.com/sambaengineering/developer-sambasafety-com/request/3zm54uj/obtain-a-token
                    SambaSafety API Documentation\Authentication\Obtain a Token

                    .LINK
                    https://www.postman.com/sambaengineering/developer-sambasafety-com/request/upf4a10/place-an-order?tab=overview
                    License History Discovery | Place An Order

                    .LINK
                    https://stackoverflow.com/questions/40902970/why-do-we-prefer-authorization-header-to-send-bearer-token-to-server-over-other
                    Why do we prefer authorization header to send bearer token to server over other techniques like URL encoding.
                    #>
#param (
#
#)
# $baseUri = "https://developer.sambasafety.io"
#$accessTokenParamsToEncode = "grant_type=client_credentials"
#$scopeParamToEncode = "scope=API"
#$accessTokenUrlEncoded = [uri]::EscapeDataString($accessTokenParamsToEncode)
#$scopeTokenUrlEncoded = [uri]::EscapeDataString($scopeParamToEncode)
$accessTokenUri = "https://api-demo.sambasafety.io/oauth2/v1/token?grant_type=client_credentials&scope=API"
$myapikey = Read-Host "Provide an API Key: "
$username = Read-Host "Provide a Username: "
$password = Read-Host "Provide a Password: "

$timeZoneOffset = (Get-TimeZone).GetUtcOffset((Get-Date))

# This may be turned into a function
$todaysDate = Get-Date -Format "yyyy-mm-ddThh:mm:ss$($timeZoneOffset)"

$encodedAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($username):$($password)"))
$tokenHeaders = @{
  "Content-Type"  = "application/x-www-form-urlencoded";
  "Authorization" = "Basic $($encodedAuth)";
  "Accept"        = "application/json"; # JSON is the default and Documentation doesn't indicate any other return format.
  "x-api-key"     = $myapikey;
}

$obtainToken = Invoke-WebRequest -Uri "$($accessTokenUri)$($accessTokenUrlEncoded)&$($scopeTokenUrlEncoded)" -Headers @tokenHeaders -SslProtocol Tls13 -SkipCertificateCheck
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

$baseUri = "https://api-demo.sambasafety.io"
$actionList = @"
LNS
LD
LHD
LV
AD
AH
AI
AMVR
IMVR
TMVR
LMG
LMP
LML
LME
MER
"@
    
$action = "start"
WHILE ($NULL -ne $action) {
  Write-Host @actionList
  $action = Read-Host "Please Provide an Action:"

  IF ($action -eq "LNS") {
    $licenseNumberSearch = "/orders/v1/licensenumbersearch"

    $licenseNumberSearchUri = $baseUri + $licenseNumberSearch

    $firstName = Read-Host "Please Supply a First Name: "
    $middleName = Read-Host "Please Supply a Middle Name: "
    $lastName = Read-Host "Please Supply a Last Name: "
    $birthDate = Read-Host "Please Provide a Birthdate (yyyy-MM-dd): "
    $birthDateAdjustment = [datetime]::ParseExact($birthDate, "yyyy-MM-dd", $NULL)
    $formattedBirthDate = $birthDateAdjustment.ToString("yyyy-MM-dd")
    $city = Read-Host "Please Provide a City: "
    $stateAbbreviation.ToUpper() = Read-Host "Please Provide the State Abbreviation: "
    $streetAddress = Read-Host "Please Provide a Street Address: "
    $zipCode = Read-Host "Please Provide a Zip Code: "
    $billCode.ToUpper() = Read-Host "Please Provide a Billing Code: "
    $billReference.ToUpper() = Read-Host "Please Provide a Billing Reference: "
    
    $lnsBody = [PSCustomObject]@{
      "firstName"     = "$($firstName)"
      "middleName"    = "$($middleName)"
      "lastName"      = "$($lastName)"
      "birthDate"     = "$($formattedBirthDate)"
      "address"       = @{
        "city"    = "$($city)"
        "state"   = "$($stateAbbreviation)"
        "street"  = "$($streetAddress)";
        "zipCode" = "$($zipCode)";
      }
      "billCode"      = "$($billCode)"
      "billReference" = "$($billReference)"
    }
    # We need to serialize first before sending over the wire.
    $lnsBodyString = $lnsBody | ConvertTo-Json
    

    $lnsHeaders = @{
      "x-api-key"     = $myapikey;
      "Accept"        = "application/json";
      "Content-Type"  = "application/json";
      "Authorization" = "Bearer $($accessToken)"
    }

    $lnsRequest = Invoke-WebRequest -Uri $licenseNumberSearchUri -Method "POST" -Body @lnsBodyString -Headers @lnsHeaders -SslProtocol Tls13 -SkipCertificateCheck
    $lnsResponse = $lnsRequest.GetResponse()

    IF ($lnsRequest.StatusCode -ne 200) {
      Write-Host "The HTTP Status Code of $($lnsRequest.StatusCode)"
    }
    ELSE {
      Write-Host "A Successful HTTP Status of 200 was returned"
      Write-Host "Below is your return"
      Write-Host $lnsRequest.Content
    }
  }
  ELSEIF ($action -eq "LD") {
    $choiceToTake = "start"
    WHILE ($NULL -ne $choiceToTake) {
      $choiceToTake = Read-Host "Please provide an action: "
      IF ($choiceToTake -eq "LO") {
        Write-Host "The Selection is License Discovery > List All Orders"
            
        $startOrderDate = Read-Host "Please provide a Start Order Date: "
        $startOrderDateAdjustment = [datetime]::ParseExact($startOrderDate, "yyyy-MM-dd", $NULL)
        $formattedStartOrderDate = $startOrderDateAdjustment.ToString("yyyy-MM-dd")
            
        $endOrderDate = Read-Host "Please provide an End Order Date: "
        $endOrderDateAdjustment = [datetime]::ParseExact($endOrderDate, "yyyy-MM-dd", $NULL)
        $formattedEndOrderDate = $endOrderDateAdjustment.ToString("yyyy-MM-dd")

        $licenseReportsUri = "/orders/v1/licensereports/verifydriver?page=1&size=50&startOrderDate=$($formattedStartOrderDate)&endOrderDate=$($formattedEndOrderDate)"
        $licenseDiscoveryHeaders = @{
          "x-api-key"     = $myapikey;
          "Authorization" = "Bearer $($accessToken)";
          "Accept"        = "application/json";
        }

        $listAllOrdersUri = $baseUri + $licenseReportsUri
        $runListAllOrdersRequest = Invoke-WebRequest -Uri $listAllOrdersUri -Method "GET" -Headers @licenseDiscoveryHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $runListAllOrdersResponse = $runListAllOrdersRequest.GetResponse()

        Write-Host "The Following Orders Have Been Returned: "
        Write-Host $runListAllOrdersRequest.Content

        <#
                Example Response and where we see our first encounter of billCode and billReference being provided.
                An Enumerations List will be needed in the long-run.

                {
  "meta": {
    "totalPages": 1,
    "totalRecords": 1
  },
  "data": [
    {
      "errorMessage": null,
      "orderId": "d5083b3d-b7a1-4aa2-b6a0-55e89457ee57",
      "status": "FULFILLED",
      "request": {
        "firstName": "John",
        "lastName": "Lima",
        "middleName": "",
        "customAttributes": null,
        "billCode": "Example",
        "billReference": "License Discovery",
        "address": {
          "street": "190 Hoeger Rest",
          "city": "Lindgrenborough",
          "zipCode": "80001",
          "state": "CA"
        },
        "birthDate": "1999-01-01",
        "licenseState": "CA",
        "county": null,
        "agency": null
      },
      "createdDateTime": "2023-07-27T18:43:02.511585Z"
    }
  ],
  "links": {
    "self": "https://api.sambasafety.io/orders/v1/licensereports/verifydriver?startOrderDate=2023-01-01&endOrderDate=2023-09-15&page=1&size=50",
    "first": "https://api.sambasafety.io/orders/v1/licensereports/verifydriver?startOrderDate=2023-01-01&endOrderDate=2023-09-15&page=1&size=50",
    "next": "https://api.sambasafety.io/orders/v1/licensereports/verifydriver?startOrderDate=2023-01-01&endOrderDate=2023-09-15&page=2&size=50",
    "last": "https://api.sambasafety.io/orders/v1/licensereports/verifydriver?startOrderDate=2023-01-01&endOrderDate=2023-09-15&page=2&size=50"
  }
}
            #>

      }
      ELSEIF ($choiceToTake -eq "PO") {
        $placeOrderUri = "/orders/v1/licensereports/verifydriver"
        $placeOrderUriFull = $baseUri + $placeOrderUri

        $purpose.ToUpper() = Read-Host "Please Provide a Purpose (e.g. LICENSE):"
        $licenseNumber = Read-Host "Please Provide a Valid License Number: "
        $licenseState.ToUpper() = Read-Host "Please Provide the State Abbreviation: "
        $firstName = Read-Host "Please Provide a First Name: "
        $lastName = Read-Host "Please Provide a Last Name: "

        $birthDate = Read-Host "Please provide an End Order Date: "
        $birthDateAdjustment = [datetime]::ParseExact($birthDate, "yyyy-MM-dd", $NULL)
        $formattedEndbirthDate = $birthDateAdjustment.ToString("yyyy-MM-dd")
        # Gender and Eye Color must be UPPERED $variable.ToUpper()

        $street = Read-Host "Please Provide a Street Address: "
        $city = Read-Host "Please Provide a City: "
        $state.ToUpper() = Read-Host "Please Provide the State Abbreviation: "
        $zipCode = Read-Host "Please Provide a Valid Zip Code: "

        $middleName = Read-Host "Please Provide a Middle Name: "
        $suffix = Read-Host "Please Provide a Suffix: "
        $billCode = Read-Host "Please Provide a Billing Code (e.g. Example): "
        $billReference = Read-Host "Please Provide a Billing Reference (e.g. License Discovery): "

        <#
          Custom Fields
          Update the Read-Host to the proper name to ask for. If there is more than 1 key-value pair then a 
          while...loop will be our best option. Followed by the addition of the values to the JSON.
          e.g. WHILE($NULL -ne $controlVariable){} 

          If we want to specifically approach this from a JSON perspective then we will need to build it manually.
        #>
        $placeOrderBody = [PSCustomObject]@{
          "purpose"         = "$($purpose)"
          "licenseNumber"   = "$($licenseNumber)"
          "licenseState"    = "$($licenseState)"
          "firstName"       = "$($firstName)"
          "lastName"        = "$($lastName)"
          "birthDate"       = "$($formattedEndbirthDate)"
          "address"         = @{
            "street"  = "$($street)"
            "city"    = "$($city)"
            "state"   = "$($state)"
            "zipCode" = "$($zipCode)"
          }
          "middleName"      = "$($middleName)"
          "suffix"          = "$($suffix)"
          "billCode"        = "$($billCode)"
          "billReference"   = "$($billReference)"
          "customFields"    = "[$($customFields)]"
          "licenseCategory" = "$($licenseCategory)"
          "issueDate"       = "$($issueDate)"
          "expiryDate"      = "$($expiryDate)"
          "eyeColor"        = "$($eyeColor)"
          "gender"          = "$($gender)"
          "height"          = $($height)
          "weight"          = $($weight)
        }


        $placeOrderBodyString = $placeOrderBody | ConvertTo-Json

        # Since there can be an indeterminate amount of 
        $additionalEntries = "start"
        WHILE ($additionalEntries -ne "No") {
          $customFieldName = Read-Host "Please Provide the Key-Value Pair's Name: "
          $customFieldValue = Read-Host "Please Provide the value to the Key-Value Pair: "


          # This will need to be tested.
          $customFields = [PSCustomObject]@{
            "name"  = "$($customFieldName)"
            "value" = "$($customFieldValue)"
          }

          $customFieldsJson = $customFields | ConvertTo-Json

          $placeOrderBodyString.customFields.Add($customFieldsJson)

          $additionalEntries = Read-Host "Additional Entries? "

        }
        # Serialization before-hand. We should always serialize
        

        $placeOrderHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)";
          "Content-Type"  = "application/json";
        }

        $placeOrderRequest = Invoke-WebRequest -Uri $placeOrderUriFull -Body $placeOrderBodyString -Method "POST" -SkipCertificateCheck -Headers @placeOrderHeaders
        $placeOrderResponse = $placeOrderRequest.GetResponse()

        IF ($placeOrderRequest.Status -ne 201) {
          Write-Host "Failed to place orders"
        }
        ELSE {
          Write-Host "Successfully placed the Order."
        }
      }
      ELSEIF ($choiceToTake -eq "COS") {
        
        Write-Host "Your Order Id will be a GUID, meaning it is 36 Characters in total (4 being hyphens)"
        $orderId = Read-Host "Please Provide an Order Id (e.g. a8dcbb7a-f936-45fd-9bf9-abb21bc873e6): "
        $checkOrderStatusUri = "/orders/v1/licensereports/verifydriver/$($orderId)"

        $checkOrderStatusFullUri = $baseUri + $checkOrderStatusUri

        $checkOrderStatusHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)";
        }

        $checkOrderStatusRequest = Invoke-WebRequest -Uri $checkOrderStatusFullUri -Method "GET" -Headers @checkOrderStatusHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $checkOrderStatusResponse = $checkOrderStatusRequest.GetResponse()

        IF ($checkOrderStatusRequest.StatusCode -ne 200) {
          Write-Host "Unable to retrieve results. An HTTP Status code of 200 was not received."
          Write-Host "Status code of: $($checkOrderStatusRequest.StatusCode)"
        }
        ELSE {
          Write-Host "The following response was received: "
          Write-Host $checkOrderStatusRequest.Content
        }

      }
      ELSEIF ($choiceToTake -eq "GR") {
        $getReportsHeaders = @{
          # "Content-Type"="application/json"; This is for Sending Across the wire NOT coming back. Accept is what we need to use.
          "Authorization" = "Bearer $($accessToken)";
          "Accept"        = "application/json";
          "x-api-key"     = $myapikey;
        }

        $reportId = Read-Host "Please Provide a Valid Report Id: "
        $getReportsUri = "/reports/v1/licensereports/verifydriver/$($reportId)"
        $getReportsUriFull = $baseUri + $getReportsUri

        $getReportsRequest = Invoke-WebRequest -Uri $getReportsUriFull -Method "GET" -Headers @getReportsHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $getReportsResponse = $getReportsRequest.GetResponse()

        IF ($getReportsRequest.StatusCode -ne 200) {
          Write-Host "Unable to retrieve results. An HTTP Status code of 200 was not received."
          Write-Host "Status code of: $($getReportsRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully retrieved results."
          Write-Host $getReportsRequest.Content
        }
      }
    }

  } # End of $action LD
  ELSEIF ($action -eq "LHD") {
    $action = "start"
    WHILE ($NULL -ne $action) {
      $action = Read-Host "What action would you like to take?"
      IF ($action -eq "PO") {
        $placeOrderUri = "/organization/v1/licenses/history"
        $placeOrderUriFull = $baseUri + $placeOrderUri
      
        $placeOrderHeaders = @{
          "x-api-key"     = $myapikey;
          "Content-Type"  = "application/json";
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }

        $licenseState = Read-Host "Please Provide the License State Abbreviation: "
        $licenseNumber = Read-Host "Please Provide the License Number: "
        $birthDate = Read-Host "Please provide an End Order Date: "
        $birthDateAdjustment = [datetime]::ParseExact($birthDate, "yyyy-MM-dd", $NULL)
        $formattedEndbirthDate = $birthDateAdjustment.ToString("yyyy-MM-dd")

        $firstName = Read-Host "Please Provide the First Name: "
        $lastName = Read-Host "Please Provide the Last Name: "
        $middleName = Read-Host "Please Provide the Middle Name: "
        $gender = Read-Host "Please Provide the a Gender (M, F, X): "
        $ssn = Read-Host "Please Provide the Social Security Number: "
        $stateAccessCode = Read-Host "Please Provide the State Access Code (CA, PA, UT): "
        $billCode = Read-Host "Please Provide the Bill Code: "
        $billReference.ToUpper() = Read-Host "Please Provide the Bill Reference: "
        $productId = Read-Host "Please Provide the Product Id: "
        $subType = Read-Host "Please Provide the Sub-Type: "
        $hostValue = Read-Host "Please Provide the Host: "
        $purpose = Read-Host "Please Provide the Purpose: "
        $yearsRequired = Read-Host "Please Provide the Number of Years Required: "

        $placeOrderBody = [PSCustomObject]@{
          "licenseState"    = "$($licenseState)"
          "licenseNumber"   = "$($licenseNumber)"
          "birthDate"       = "$($formattedEndbirthDate)"
          "firstName"       = "$($firstName)"
          "lastName"        = "$($lastName)"
          "middleName"      = "$($middleName)"
          "gender"          = "$($gender)"
          "ssn"             = "$($ssn)"
          "stateAccessCode" = "$($stateAccessCode)"
          "billCode"        = "$($billCode)"
          "billReference"   = "$($billReference)"
          "productId"       = "$($productId)"
          "subType"         = "$($subType)"
          "host"            = "$($hostValue)"
          "purpose"         = "$($purpose)"
          "customFields"    = "[]"
          "reportFormats"   = "[
          `"application/vnd.sambasafety.platform.mvr+pdf`",
          `"application/vnd.sambasafety.platform.mvr+html`"
      ]"
          "yearsRequired"   = "$($yearsRequired)"
        }
      
        $placeOrderBodyString = $placeOrderBody | ConvertTo-Json

        $additionalEntries = "start"
        WHILE ($additionalEntries -ne "No") {
          $customFieldName = Read-Host "Please Provide the Key-Value Pair's Name: "
          $customFieldValue = Read-Host "Please Provide the value to the Key-Value Pair: "


          # This will need to be tested.
          $customFields = [PSCustomObject]@{
            "name"  = "$($customFieldName)"
            "value" = "$($customFieldValue)"
          }

          $customFieldsJson = $customFields | ConvertTo-Json

          $placeOrderBodyString.customFields.Add($customFields)

          $additionalEntries = Read-Host "Additional Entries? "

        }
        
        $placeOrderRequest = Invoke-WebRequest -Uri $placeOrderUriFull -Headers @placeOrderHeaders -Method "POST" -Body $placeOrderBodyString -SslProtocol Tls13 -SkipCertificateCheck

      }
      ELSEIF ($action -eq "COS") {

        $orderId = Read-Host "Please Provide an Order Id: "
        $checkOrderStatusUri = "/reports/v1/licensehistory/$($orderId)"
        $checkOrderStatusFullUri = $baseUri + $checkOrderStatusUri

        $checkOrderStatusHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)";
        }

        $checkOrderStatusRequest = Invoke-WebRequest -Uri $checkOrderStatusFullUri -Method "GET" -Headers @checkOrderStatusHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $checkOrderStatusResponse = $checkOrderStatusRequest.GetResponse()

        IF ($checkOrderStatusRequest.StatusCode -ne 200) {
          Write-Host "Unable to retrieve results."
        }
        ELSE {
          Write-Host "Successfully retrieved results"
          Write-Host "Order Status:`r`n$($checkOrderStatusRequest.Content)"
        }

      } # Check Order Status
    } # End of $action Loop
  } # End of $action LHD
  ELSEIF ($action -eq "LV") {
    $choice = "start"
    WHILE ($NULL -ne $choice) {

      IF ($choice -eq "LAO") {
        $prompted = $FALSE
        IF ($prompted -eq $FALSE) {
          $pageSize = "1"
          $size = "50"
        }
        ELSEIF ($prompted -eq $TRUE) {
          $pageSize = Read-Host "Pleave provide the number of transactions you wish to review:"
          $size = Read-Host "Please Provide the number of Transactions to review on a page."
        }

        $startOrderDate = Read-Host "Please provide a Start Order Date: "
        $startOrderDateAdjustment = [datetime]::ParseExact($startOrderDate, "yyyy-MM-dd", $NULL)
        $formattedStartOrderDate = $startOrderDateAdjustment.ToString("yyyy-MM-dd")
            
        $endOrderDate = Read-Host "Please provide an End Order Date: "
        $endOrderDateAdjustment = [datetime]::ParseExact($endOrderDate, "yyyy-MM-dd", $NULL)
        $formattedEndOrderDate = $endOrderDateAdjustment.ToString("yyyy-MM-dd")

        $listAllOrdersLV = "/orders/v1/licensereports/verifylicense?page=$($pageSize)&size=$($size)&startOrderDate=$($formattedStartOrderDate)&endOrderDate=$($formattedEndOrderDate)"
        $listAllOrdersLVFullUri = $baseUri + $listAllOrdersLV

        $listAllOrdersLVHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)";
        }


        $listAllOrdersLVRequest = Invoke-WebRequest -Uri $listAllOrdersLVFullUri -Method "GET" -Headers @listAllOrdersLVHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $listAllOrdersLVResponse = $listAllOrdersLVRequest.GetResponse()

        IF ($listAllOrdersLVRequest.StatusCode -ne 200 -And $listAllOrdersLVRequest.StatusCode -ne 400) {
          Write-Host "Unable to retrieve results"
        }
        ELSEIF ($listAllOrdersLVRequest.StatusCode -eq 200) {
          Write-Host "Successfully retrieved results."
          Write-Host $listAllOrdersLVRequest.Content
        }
        ELSE {
          Write-Host "The Following HTTP Status Code was received: $($listAllOrdersLVRequest.StatusCode)"
        }
      } # End of choice IF Loop
      ELSEIF ($choice -eq "PO") {
        $placeOrderUri = "/orders/v1/licensereports/verifylicense"
        $placeOrderUriFull = $baseUri + $placeOrderUri

        $birthDate = Read-Host "Please provide an End Order Date: "
        $birthDateAdjustment = [datetime]::ParseExact($birthDate, "yyyy-MM-dd", $NULL)
        $formattedBirthDate = $birthDateAdjustment.ToString("yyyy-MM-dd")
        # Gender and Eye Color must be UPPERED $variable.ToUpper()
        $firstName = Read-Host "Please Supply a First Name: "
        $middleName = Read-Host "Please Supply a Middle Name: "
        $lastName = Read-Host "Please Supply a Last Name: "
        $licenseNumber = Read-Host "Please Provide a License Number: "
        $licenseState.ToUpper() = Read-Host "Please provide the State Abbreviation: "
        $suffix = Read-Host "Please Provide a Suffix: "
        $billCode = Read-Host "Please Provide a Billing Code (e.g. Example): "
        $billReference.ToUpper() = Read-Host "Please Provide a Billing Reference (e.g. License Discovery): "
        $purpose.ToUpper() = Read-Host "Please Provide a Purpose: "
        $options.ToUpper() = Read-Host "Please Provide an Option: "
      
        $issueDate = Read-Host "Please provide an End Order Date: "
        $issueDateAdjustment = [datetime]::ParseExact($issueDate, "yyyy-MM-dd", $NULL)
        $formattedIssueDate = $issueDateAdjustment.ToString("yyyy-MM-dd")

        $expiryDate = Read-Host "Please provide an End Order Date: "
        $expiryDateAdjustment = [datetime]::ParseExact($expiryDate, "yyyy-MM-dd", $NULL)
        $formattedExpiryDate = $expiryDateAdjustment.ToString("yyyy-MM-dd")

        $eyeColor.ToUpper() = Read-Host "Please Provide an Eye Color: "

        $street = Read-Host "Please Provide a Street Address: "
        $city = Read-Host "Please Provide a City: "
        $state.ToUpper() = Read-Host "Please Provide the State Abbreviation: "
        $zipCode = Read-Host "Please Provide a Valid Zip Code: "

        $height = Read-Host "Please Provide a Height in Whole Numbers only: "
        $weight = Read-Host "Please Provide a Weight in Whole Numbers ony: "
        $vaultAge = Read-Host "Please Provide a Vault Age in Whole Numbers only: "
      
        $placeOrderBody = [PSCustomObject]@{
          "birthDate"       = "$($formattedBirthDate)";
          "firstName"       = "$($firstName)";
          "lastName"        = "$($lastName)";
          "licenseNumber"   = "$($licenseNumber)";
          "licenseState"    = "$($licenseState)";
          "middleName"      = "$($middleName)";
          "suffix"          = "$($suffix)";
          "billCode"        = "$($billCode)";
          "billReference"   = "$($billReference)";
          "purpose"         = "$($purpose)";
          "options"         = "[`"$($options)`"]";
          "customFields"    = "[]";
          "licenseCategory" = "$($licenseCategory)";
          "issueDate"       = "$($formattedIssueDate)";
          "expiryDate"      = "$($formattedExpiryDate)";
          "eyeColor"        = "$($eyeColor)";
          "gender"          = "$($gender)";
          "address"         = @{
            "street"  = "$($streetAddress)";
            "city"    = "$($city)";
            "state"   = "$($stateAbbreviation)";
            "zipCode" = "$($zipCode)";
          }
          "height"          = $height;
          "weight"          = $weight;
          "vaultAge"        = $vaultAge;
        }

        $placeOrderBodyString = $placeOrderBody | ConvertTo-Json

        $additionalEntries = "start"
        WHILE ($additionalEntries -ne "No") {
          $customFieldName = Read-Host "Please Provide the Key-Value Pair's Name: "
          $customFieldValue = Read-Host "Please Provide the value to the Key-Value Pair: "
  
  
          # This will need to be tested.
          $customFields = [PSCustomObject]@{
            "name"  = "$($customFieldName)"
            "value" = "$($customFieldValue)"
          }

          $customFieldsJson = $customFields | ConvertTo-Json
        
          $placeOrderBodyString.customFields.Add($customFields)
  
          $additionalEntries = Read-Host "Additional Entries? "
        }
        

        $placeOrderHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Content-Type"  = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }

        $placeOrderRequest = Invoke-WebRequest -Uri $placeOrderUriFull -Method "POST" -Headers @placeOrderHeaders -Body $placeOrderBodyString -SslProtocol Tls13 -SkipCertificateCheck
        $placeOrderResponse = $placeOrderRequest.GetResponse()

        IF ($placeOrderRequest.StatusCode -ne 201) {
          Write-Host "Failed to create a new record"
        }
        ELSE {
          Write-Host "Successfully created the record."
          Write-Host $placeOrderRequest.Content
        }

      }
      ELSEIF ($choice -eq "COS") {
        Write-Host "Your Order Id will be a GUID, meaning it is 36 Characters in total (4 being hyphens)"
        $orderId = Read-Host "Please Provide an Order Id (e.g. a8dcbb7a-f936-45fd-9bf9-abb21bc873e6): "
        $checkOrderStatusUri = "/orders/v1/licensereports/verifylicense$($orderId)"

        $checkOrderStatusFullUri = $baseUri + $checkOrderStatusUri

        $checkOrderStatusHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)";
        }

        $checkOrderStatusRequest = Invoke-WebRequest -Uri $checkOrderStatusFullUri -Method "GET" -Headers @checkOrderStatusHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $checkOrderStatusResponse = $checkOrderStatusRequest.GetResponse()

        IF ($checkOrderStatusRequest.StatusCode -ne 200) {
          Write-Host "Unable to retrieve results. An HTTP Status code of 200 was not received."
          Write-Host "Status code of: $($checkOrderStatusRequest.StatusCode)"
        }
        ELSE {
          Write-Host "The following response was received: "
          Write-Host $checkOrderStatusRequest.Content
        }
      }
      ELSEIF ($choice -eq "GR") {
        Write-Host "A Valid Reports Id will be GUID (32 Alphanumeric Characters with 4 hyphens): "
        $reportsId = Read-Host "Please Provide a Valid Reports Id:"
        $getReportsUri = "/reports/v1/licensereports/verifylicense/$($reportsId)"
        $getReportsUriFull = $baseUri + $getReportsUri

        $getReportsHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }
      
        $getReportsRequest = Invoke-WebRequest -Uri $getReportsUriFull -Method "GET" -Headers @getReportsHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $getReportsResponse = $getReportsRequest.GetResponse()
      
        IF ($getReportsRequest.StatusCode -ne 200) {
          Write-Host "Unable to retrieve results for GUID: $($reportId)"
        }
        ELSEIF ($getReportsRequest -eq 200) {
          Write-Host "Successfully retrieved results for GUID: $($reportsId)"
          Write-Host $getReportsRequest.Content
        }

      } # End of $choice GR
    } # End of $choice loop
  } # End of $action LV
  ELSEIF ($action = "AD") {
    <#
    This section is for Activity Details:
    List all Orders = LO
    Place an Order for a Quote = POQ
    Place an Order = PO
    Check Order Status = COS
    Get a Report = GR
  #>
    $choice = "start"
    WHILE ($NULL -ne $choice) {
      IF ($choice -eq "LO") {
        $prompted = $FALSE
        IF ($prompted -eq $FALSE) {
          $pageSize = "1"
          $size = "50"
        } 
        ELSEIF ($prompted -eq $TRUE) {
          $pageSize = Read-Host "Pleave provide the number of transactions you wish to review:"
          $size = Read-Host "Please Provide the number of Transactions to review on a page."
        }

        $startOrderDate = Read-Host "Please provide a Start Order Date: "
        $startOrderDateAdjustment = [datetime]::ParseExact($startOrderDate, "yyyy-MM-dd", $NULL)
        $formattedStartOrderDate = $startOrderDateAdjustment.ToString("yyyy-MM-dd")
            
        $endOrderDate = Read-Host "Please provide an End Order Date: "
        $endOrderDateAdjustment = [datetime]::ParseExact($endOrderDate, "yyyy-MM-dd", $NULL)
        $formattedEndOrderDate = $endOrderDateAdjustment.ToString("yyyy-MM-dd")
        $loUri = "/orders/v1/activityreports/detail?page$($pageSize)&size=$($size)&startOrderDate=$($startOrderDateAdjustment)&endOrderDate=$($endOrderDateAdjustment)"

        $loUriFull = $baseUri + $loUri

        $loHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }

        $loRequest = Invoke-WebRequest -Uri $loUriFull -Method "GET" -Headers @loHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $loResponse = $loRequest.GetResponse()

        IF ($loRequest.StatusCode -ne 200) {
          Write-Host "Failed to retreive results."
        }
        ELSE {
          Write-Host "Successfully retrieved results."
          Write-Host $loRequest.Content
        }

      }
      ELSEIF ($choice -eq "POQ") {
        $poqUri = "/orders/v1/activityreports/detailquote"
        $poqUriFull = $baseUri + $poqUri

        $poqHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Content-Type"  = "application/json"; # This is NOT required for GET Requests.
          "Authorization" = "Bearer $($accessToken)";
        }

        $birthDate = Read-Host "Please provide an End Order Date: "
        $birthDateAdjustment = [datetime]::ParseExact($birthDate, "yyyy-MM-dd", $NULL)
        $formattedbirthDate = $birthDateAdjustment.ToString("yyyy-MM-dd")
        # Gender and Eye Color must be UPPERED $variable.ToUpper()
        $firstName = Read-Host "Please Supply a First Name: "
        $middleName = Read-Host "Please Supply a Middle Name: "
        $lastName = Read-Host "Please Supply a Last Name: "
        $licenseNumber = Read-Host "Please Provide a License Number: "
        $licenseState.ToUpper() = Read-Host "Please provide the State Abbreviation: "
        $suffix = Read-Host "Please Provide a Suffix: "
        $billCode = Read-Host "Please Provide a Billing Code (e.g. Example): "
        $billReference.ToUpper() = Read-Host "Please Provide a Billing Reference (e.g. License Discovery): "
        $purpose.ToUpper() = Read-Host "Please Provide a Purpose: "
        $options.ToUpper() = Read-Host "Please Provide an Option: "
      
        $issueDate = Read-Host "Please provide an End Order Date: "
        $issueDateAdjustment = [datetime]::ParseExact($issueDate, "yyyy-MM-dd", $NULL)
        $formattedIssueDate = $issueDateAdjustment.ToString("yyyy-MM-dd")

        $expiryDate = Read-Host "Please provide an End Order Date: "
        $expiryDateAdjustment = [datetime]::ParseExact($expiryDate, "yyyy-MM-dd", $NULL)
        $formattedExpiryDate = $expiryDateAdjustment.ToString("yyyy-MM-dd")
        $licenseCategory.ToUpper() = Read-Host "Please Provide a License Category"
        $eyeColor.ToUpper() = Read-Host "Please Provide an Eye Color: "

        $street = Read-Host "Please Provide a Street Address: "
        $city = Read-Host "Please Provide a City: "
        $state.ToUpper() = Read-Host "Please Provide the State Abbreviation: "
        $zipCode = Read-Host "Please Provide a Valid Zip Code: "

        $height = Read-Host "Please Provide a Height in Whole Numbers only: "
        $weight = Read-Host "Please Provide a Weight in Whole Numbers ony: "
        $activityDuration = Read-Host "Please Provide a Vault Age in Whole Numbers only: "

        $poqBody = [PSCustomObject]@{
          "birthDate"        = "$($formattedBirthDate)"
          "firstName"        = "$($firstName)"
          "lastName"         = "$($lastName)"
          "licenseNumber"    = "$($licenseNumber)"
          "licenseState"     = "$($licenseState)"
          "middleName"       = "$($middleName)"
          "suffix"           = "$($suffix)"
          "billCode"         = "$($billCode)"
          "billReference"    = "$($billReference)"
          "purpose"          = "$($purpose)"
          "options"          = "[`"$($options)`"]"
          "customFields"     = "[]"
          "licenseCategory"  = "$($licenseCategory)"
          "issueDate"        = "$($formattedIssueDate)"
          "expiryDate"       = "$($formattedExpiryDate)"
          "eyeColor"         = "$($eyeColor)"
          "gender"           = "$($gender)"
          "address"          = @{
            "street"  = "$($street)"
            "city"    = "$($city)"
            "state"   = "$($state)"
            "zipCode" = "$($zipCode)"
          }
          "height"           = $height
          "weight"           = $weight
          "activityDuration" = $activityDuration
        }

        $poqBodyString = $poqBody | ConvertTo-Json # We need to run it against ConvertTo-Json prior to send off.

        $additionalEntries = "start"
        WHILE ($additionalEntries -ne "No") {
          $customFieldName = Read-Host "Please Provide the Key-Value Pair's Name: "
          $customFieldValue = Read-Host "Please Provide the value to the Key-Value Pair: "
  
  
          # This will need to be tested.
          $customFields = [PSCustomObject]@{
            "name"  = "$($customFieldName)"
            "value" = "$($customFieldValue)"
          }

          $customFieldsJson = $customFields | ConvertTo-Json
  
          $poqBodyString.customFields.Add($customFields)
  
          $additionalEntries = Read-Host "Additional Entries? "
        } # End Additional Entries Loop
        

        $poqRequest = Invoke-WebRequest -Uri $poqUriFull -Method "POST" -Headers @poqHeaders -Body $poqBodyString -SslProtocol Tls13 -SkipCertificateCheck
        $poqResponse = $poqRequest.GetResponse()

        IF ($poqRequest.StatusCode -ne 201) {
          Write-Host "Failed to create new record."
        }
        ELSEIF ($poqRequest.StatusCode -eq 201) {
          Write-Host "Successfully Created new Record."
          Write-Host $poqResponse.Content
        }


      }
      ELSEIF ($choice -eq "PO") {
        $poUri = "/orders/v1/activityreports/detail"
        $poUriFull = $baseUri + $poUri


        $birthDate = Read-Host "Please provide an End Order Date: "
        $birthDateAdjustment = [datetime]::ParseExact($birthDate, "yyyy-MM-dd", $NULL)
        $formattedBirthDate = $birthDateAdjustment.ToString("yyyy-MM-dd")
        # Gender and Eye Color must be UPPERED $variable.ToUpper()
        $firstName = Read-Host "Please Supply a First Name: "
        $middleName = Read-Host "Please Supply a Middle Name: "
        $lastName = Read-Host "Please Supply a Last Name: "
        $licenseNumber = Read-Host "Please Provide a License Number: "
        $licenseState.ToUpper() = Read-Host "Please provide the State Abbreviation: "
        $suffix = Read-Host "Please Provide a Suffix: "
        $billCode = Read-Host "Please Provide a Billing Code (e.g. Example): "
        $billReference.ToUpper() = Read-Host "Please Provide a Billing Reference (e.g. License Discovery): "
        $purpose.ToUpper() = Read-Host "Please Provide a Purpose: "
        $options.ToUpper() = Read-Host "Please Provide an Option: "
      
        $issueDate = Read-Host "Please provide an End Order Date: "
        $issueDateAdjustment = [datetime]::ParseExact($issueDate, "yyyy-MM-dd", $NULL)
        $formattedIssueDate = $issueDateAdjustment.ToString("yyyy-MM-dd")

        $expiryDate = Read-Host "Please provide an End Order Date: "
        $expiryDateAdjustment = [datetime]::ParseExact($expiryDate, "yyyy-MM-dd", $NULL)
        $formattedExpiryDate = $expiryDateAdjustment.ToString("yyyy-MM-dd")

        $eyeColor.ToUpper() = Read-Host "Please Provide an Eye Color: "

        $street = Read-Host "Please Provide a Street Address: "
        $city = Read-Host "Please Provide a City: "
        $state.ToUpper() = Read-Host "Please Provide the State Abbreviation: "
        $zipCode = Read-Host "Please Provide a Valid Zip Code: "

        $height = Read-Host "Please Provide a Height in Whole Numbers only: "
        $weight = Read-Host "Please Provide a Weight in Whole Numbers ony: "
        $vaultAge = Read-Host "Please Provide a Vault Age in Whole Numbers only: "
      
        $placeOrderBody = [PSCustomObject]@{
          "birthDate"       = "$($formattedBirthDate)";
          "firstName"       = "$($firstName)";
          "lastName"        = "$($lastName)";
          "licenseNumber"   = "$($licenseNumber)";
          "licenseState"    = "$($licenseState)";
          "middleName"      = "$($middleName)";
          "suffix"          = "$($suffix)";
          "billCode"        = "$($billCode)";
          "billReference"   = "$($billReference)";
          "purpose"         = "$($purpose)";
          "options"         = "[`"$($options)`"]";
          "customFields"    = "[]";
          "licenseCategory" = "$($licenseCategory)";
          "issueDate"       = "$($formattedIssueDate)";
          "expiryDate"      = "$($formattedExpiryDate)";
          "eyeColor"        = "$($eyeColor)";
          "gender"          = "$($gender)";
          "address"         = @{
            "street"  = "$($streetAddress)";
            "city"    = "$($city)";
            "state"   = "$($stateAbbreviation)";
            "zipCode" = "$($zipCode)";
          }
          "height"          = $height;
          "weight"          = $weight;
          "vaultAge"        = $vaultAge;
        }

        $placeOrderBodyString = $placeOrderBody | ConvertTo-Json

        $additionalEntries = "start"
        WHILE ($additionalEntries -ne "No") {
          $customFieldName = Read-Host "Please Provide the Key-Value Pair's Name: "
          $customFieldValue = Read-Host "Please Provide the value to the Key-Value Pair: "
  
  
          # This will need to be tested.
          $customFields = @{
            "name"  = "$($customFieldName)"
            "value" = "$($customFieldValue)"
          }
                  
          $customFieldsJson = $customFields | ConvertTo-Json
  
          $placeOrderBodyString.customFields.Add($customFieldsJson)
  
          $additionalEntries = Read-Host "Additional Entries? "
        }
        

        $poHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Content-Type"  = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }

        $placeOrderRequest = Invoke-WebRequest -Uri $poUriFull -Method "POST" -Headers @placeOrderHeaders -Body $placeOrderBodyString -SslProtocol Tls13 -SkipCertificateCheck
        $placeOrderResponse = $placeOrderRequest.GetResponse()

        IF ($placeOrderRequest.StatusCode -ne 201) {
          Write-Host "Failed to create a new record"
        }
        ELSE {
          Write-Host "Successfully created the record."
          Write-Host $placeOrderRequest.Content
        }

    
      }
      ELSEIF ($choice -eq "COS") {
        $orderId = Read-Host "Please provide a Valid Order Id GUID: "
        $cosUri = "/orders/v1/activityreports/detail/$($orderId)"
        $cosUriFull = $baseUri + $cosUri

        # DO NOT INCLUDE CONTENT-TYPE IT WILL BE IGNORED BY THE SERVER IN A GET REQUEST
        $cosHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)";
        }
    
        $cosRequest = Invoke-WebRequest -Uri $cosUriFull -Method "GET" -Headers @cosHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $cosResponse = $cosRequest.GetResponse()

        IF ($cosRequest.StatusCode -ne 200) {
          Write-Host "Unable to retrieve Results."
        }
        ELSEIF ($cosRequest.StatusCode -eq 200) {
          Write-Host "Successfully retrieved Results."
          Write-Host $cosRequest.Content
        }

      } # End of $choice COS
      ELSEIF ($choice -eq "GR") {
        $reportId = Write-Host "Please Provide a Valid Report Id GUID: "
        $getReportUri = "/reports/av1/activityreports/detail/$($reportId)"
        $getReportUriFull = $baseUri + $getReportUri

        $getReportHeaders = @{
          "x-api-key"     = $myapikey;
          "Authorization" = "Bearer $($accessToken)";
          "Accept"        = "application/vnd.sambasafety.json;version=2.0.4" 
        }
      
        $getReportRequest = Invoke-WebRequest -Uri $getReportUriFull -Method "GET" -Headers @getReportHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $getReportResponse = $getReportRequest.GetResponse()

        IF ($getReportRequest.StatusCode -ne 200) {
          Write-Host "Failed to retrieve results for Report GUID: $($reportId)"
        }
        ELSE {
          Write-Host "Successfully retrieved results for Report GUID: $($reportId)`r`n$($getReport.Content)"
        }
    
      } # End of $choice GR
      $choice = $NULL
      $choice = Read-Host "Please Provide a Choice Or Press Enter: "
    } # End of $choice While Loop for AD

  } # End of $action AD
  ELSEIF ($action -eq "AH") {
    $choice = "start"
    WHILE ($NULL -ne $choice) {
      $choice = Read-Host "Please Provide a Choice: "
      IF ($choice -eq "PO") {
    
        $searchStartDate = Read-Host "Please provide an End Order Date: "
        $searchStartDateAdjustment = [datetime]::ParseExact($searchStartDate, "yyyy-MM-dd", $NULL)
        $formattedSearchStartDate = $searchStartDateAdjustment.ToString("yyyy-MM-dd")

        $licenseState.ToUpper() = Read-Host "Please Provide a State Abbreviation: "
        $licenseNumber = Read-Host "Please Provide a Valid License Number: "

        $birthDate = Read-Host "Please provide an End Order Date: "
        $birthDateAdjustment = [datetime]::ParseExact($birthDate, "yyyy-MM-dd", $NULL)
        $formattedBirthDate = $birthDateAdjustment.ToString("yyyy-MM-dd")

        $lastName = Read-Host "Please Provide a Last Name: "
        $middleName = Read-Host "Please Provide a Middle Name: "
        $firstName = Read-Host "Please Provide a First Name: "
      
        $city = Read-Host "Please Provide a City: "
        $street = Read-Host "Please Provide a Street Address: "
        $stateAbbreviation.ToUpper() = Read-Host "Please Provide a State Abbreviation: "
        $zipCode = Read-Host "Please Provide a Zip Code: "
        $billCode = Read-Host "Please Provide a Bill Code: "
        $billReference = Read-Host "Please Provide a Billing Reference: "

        $placeOrderBody = [PSCustomObject]@{
          "searchStartDate" = "$($formattedSearchStartDate)"
          "licenseState"    = "$($licenseState)"
          "licenseNumber"   = "$($licenseNumber)"
          "birthDate"       = "$($formattedBirthDate)"
          "lastName"        = "$($lastName)"
          "middleName"      = "$($middleName)"
          "firstName"       = "$($firstName)"
          "address"         = @{
            "street"  = "$($street)"
            "city"    = "$($city)"
            "state"   = "$($stateAbbreviation)"
            "zipCode" = $zipCode # This time it is an integer and not a string.
          }
          "billCode"        = "$($billCode)"
          "billReference"   = "$($billReference)" # Are these supposed to be Uppered, proper casing, camelCasing, or otherwise? This is unclear.
        }

        $placeOrderBodyString = $placeOrderBody | ConvertTo-Json

        $placeOrderUri = "/orders/v1/activityreports/history"
        $placeOrderUriFull = $baseUri + $placeOrderUri
        $placeOrderHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Content-Type"  = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }

        $placeOrderRequest = Invoke-WebRequest -Uri $placeOrderUriFull -Method "POST" -Body $placeOrderBodyString -Headers @getReportHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $placeOrderResponse = $placeOrderRequest.GetResponse()

        IF ($placeOrderRequest.StatusCode -ne 201) {
          Write-Host "Failed to create record."
        }
        ELSE {
          Write-Host "Successfully created new record: $($placeOrderRequest.Content)"
        }
      }
      ELSEIF ($choice -eq "COS") {
        $orderId = Read-Host "Please Provide a Valid Order GUID: "
        $checkOrderStatusUri = "/orders/v1/activityreports/history/$($orderId)"
        $checkOrderStatusUriFull = $baseUri + $checkOrderStatusUri

        $checkOrderStatusHeaders = @{
          "Accept"        = "application/json";
          "x-api-key"     = $myapikey;
          "Authorization" = "Bearer $($accessToken)"
        }

        $checkOrderStatusRequest = Invoke-WebRequest -Uri $checkOrderStatusUriFull -Method "GET" -Headers @checkOrderStatusHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $checkOrderStatusResponse = $checkOrderStatusRequest.GetResponse()

        IF ($checkOrderStatusRequest.StatusCode -ne 200) {
          Write-Host "Failed to retrieve results for Order GUID: $($orderId)."
          Write-Host "Received the following HTTP Status Code: $($checkOrderStatusRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully retrieved Order Id: $($orderId)`r`n$($checkOrderStatusRequest.Content)"
        }
      }
      ELSEIF ($choice -eq "GR") {
        $reportId = Read-Host "Please Provide a Valid Report GUID: "
        $getReportUri = "/reports/v1/activityreports/history/$($reportId)"

        $getReportHeaders = @{
          "Accept"        = "application/vnd.sambasafety.activityhistory+json;version=2.0.0";
          "x-api-key"     = $myapikey;
          "Authorization" = "Bearer $($accessToken)"
        }

        $getReportUriFull = $baseUri + $getReportUri
        $getReportRequest = Invoke-WebRequest -Uri $getReportUriFull -Method "GET" -Headers @getReportHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $getReportResponse = $getReportRequest.GetResponse()

        IF ($getReportRequest.StatusCode -ne 200) {
          Write-Host "Failed to retrieve results for Report GUID: $($reportId)"
        }
        ELSE {
          Write-Host "Successfully retrieved results for Report GUID: $($reportId)`r`n$($getReportRequest.Content)"
        }
      } # End $choice GR

      $choice = $NULL
      $choice = Read-Host "Please Provide a Choice Or Press Enter: "
    }
  } # End of $action AH
  ELSEIF ($action -eq "AI") {
    $choice = "start"
    WHILE ($NULL -ne $choice) {
      $choice = Read-Host "Please provide a choice: "
      IF ($choice -eq "LAO") {
        # List all Orders

        $prompted = $FALSE
        IF ($prompted -eq $FALSE) {
          $pageSize = "1"
          $size = "50"
        } 
        ELSEIF ($prompted -eq $TRUE) {
          $pageSize = Read-Host "Pleave provide the number of transactions you wish to review:"
          $size = Read-Host "Please Provide the number of Transactions to review on a page."
        }

        $startOrderDate = Read-Host "Please provide a Start Order Date: "
        $startOrderDateAdjustment = [datetime]::ParseExact($startOrderDate, "yyyy-MM-dd", $NULL)
        $formattedStartOrderDate = $startOrderDateAdjustment.ToString("yyyy-MM-dd")
            
        $endOrderDate = Read-Host "Please provide an End Order Date: "
        $endOrderDateAdjustment = [datetime]::ParseExact($endOrderDate, "yyyy-MM-dd", $NULL)
        $formattedEndOrderDate = $endOrderDateAdjustment.ToString("yyyy-MM-dd")

        $listAllOrdersAI = "/orders/v1/activityreports/indicator?page=$($pageSize)&size=$($size)&startOrderDate=$($startOrderDateAdjustment)&endOrderDate=$($endOrderDateAdjustment)"

        $listAllOrdersAIFullUri = $baseUri + $listAllOrdersAI
        $listAllOrdersAIHeaders = @{
          "x-api-key"     = $myapikey;
          "Authorization" = "Bearer $($accessToken)";
          "Accept"        = "application/json"
        }

        $listAllOrdersAIRequest = Invoke-WebRequest -Uri $listAllOrdersAIFullUri -Method "GET" -Headers @listAllOrdersAIHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $listAllOrdersAIResponse = $listAllOrdersAIRequest.GetResponse()
        
        IF ($listAllOrdersAIRequest.StatusCode -ne 200) {
          Write-Host "Failed to retrieve Results"
        }
        ELSE {
          Write-Host "Successfully retrieved results."
          Write-Host $listAllOrdersAIRequest.Content
        }

      } # End $choide LAO
      ELSEIF ($choice -eq "POQ") {
        $placeOrderQuoteHeaders = @{
          "x-api-key"     = $myapikey;
          "Authorization" = "Bearer $($accessToken)";
          "Accept"        = "application/json";
          "Content-Type"  = "application/json";
        }

        $birthDate = Read-Host "Please provide a Birth Date: "
        $birthDateAdjustment = [datetime]::ParseExact($birthDate, "yyyy-MM-dd", $NULL)
        $formattedBirthDate = $birthDateAdjustment.ToString("yyyy-MM-dd")
        
        $firstName = Read-Host "Please Provide a First Name: "
        $lastName = Read-Host "Please Provide a Last Name: "
        $licenseNumber = Read-Host "Please Provide a License Number: "
        $purpose.ToUpper() = Read-Host "Please Provide a Purpose: "
        $licenseState.ToUpper() = Read-Host "Please Provide the Licensed State Abbreviation: "
        $middleName = Read-Host "Please Provide a Last Nane: "
        $suffix = Read-Host "Please Provide a Suffix: "
        $billCode.ToUpper() = Read-Host "Please Provide a Bill Code: "
        $billReference.ToUpper() = Read-Host "Please Provide a Billing Reference: "
        $options.ToUpper() = Read-Host "Please provide an option: " # This one can be a While...Loop on a Project by Project Basis, not always necessary.
        $licenseCategory.ToUpper() = Read-Host "Please provide a License Category: "

        $issueDate = Read-Host "Please provide an Issue Date: "
        $issueDateAdjustment = [datetime]::ParseExact($issueDate, "yyyy-MM-dd", $NULL)
        $formattedIssueDate = $issueDateAdjustment.ToString("yyyy-MM-dd")

        $expiryDate = Read-Host "Please provide an Expiry Date: "
        $expiryDateAdjustment = [datetime]::ParseExact($expiryDate, "yyyy-MM-dd", $NULL)
        $formattedExpiryDate = $expiryDateAdjustment.ToString("yyyy-MM-dd")

        $eyeColor.ToUpper() = Read-Host "Please Provide an Eye Color: "
        $gender.ToUpper() = Read-Host "Please Provide a Gender (M, F, X): "
        $street = Read-Host "Please provide a Street Address: "
        $city = Read-Host "Please Provide a City: "
        $stateAbbreviation.ToUpper() = Read-Host "Please Provide the State Abbreviation: "
        $zipCode = Read-Host "Please Provide a Zip Code: "
        
        $height = Read-Host "Please Provide a Height in Whole Numbers Only: "
        $weight = Read-Host "Please Provide a Weight in Whole Numbers Only: "
        $activityDuration = Read-Host "Please Provide an Activity Duration in Whole Numbers Only: "

        $poqBody = [PSCustomObject]@{
          "birthDate"        = "$($formattedBirthDate)"
          "firstName"        = "$($firstName)"
          "lastName"         = "$($lastName)"
          "licenseNumber"    = "$($licenseNumber)"
          "purpose"          = "$($purpose)" # ToUpper()
          "licenseState"     = "$($licenseState)" # ToUpper()
          "middleName"       = "$($middleName)"
          "suffix"           = "$($suffix)"
          "billCode"         = "$($billCode)"
          "billReference"    = "$($billReference)"
          "options"          = "[`"$($options)`"]" # This will be determined later, since it does not function the same structurally. [] as opposed to [{}]. It is Array-Like.
          "customFields"     = "[]" # We will add these later by asking the user how many to add.
          "licenseCategory"  = "$($licenseCategory)"
          "issueDate"        = "$($formattedIssueDate)"
          "expiryDate"       = "$($formattedExpiryDate)"
          "eyeColor"         = "$($eyeColor)"
          "gender"           = "$($gender)"
          "address"          = @{
            "street"  = "$($street)"
            "city"    = "$($city)"
            "state"   = "$($stateAbbreviation)"
            "zipCode" = "$($zipCode)"
          }
          "height"           = $height
          "weight"           = $weight
          "activityDuration" = $activityDuration
        }


        $poqBodyString = $poqBody | ConvertTo-Json

        $additionalEntries = "start"
        WHILE ($additionalEntries -ne "No") {
          $customFieldName = Read-Host "Please Provide the Key-Value Pair's Name: "
          $customFieldValue = Read-Host "Please Provide the value to the Key-Value Pair: "
  
  
          # This will need to be tested.
          $customFields = @{
            "name"  = "$($customFieldName)"
            "value" = "$($customFieldValue)"
          }
                  
          $customFieldsJson = $customFields | ConvertTo-Json
          
          $poqBodyString.customFields.Add($customFieldsJson)
  
          $additionalEntries = Read-Host "Additional Entries? "
        }

        
        $poqUri = "/orders/v1/activityreports/indicatorquote"
        $poqUriFull = $baseUri + $poqUri
        $poqRequest = Invoke-WebRequest -Uri $poqUriFull -Method "POST" -Headers @placeOrderQuoteHeaders -Body @poqBodyString -SslProtocol Tls13 -SkipCertificateCheck

        $poqResponse = $poqRequest.GetResponse()
        IF ($poqRequest.StatusCode -ne 201) {
          Write-Host "Failed to create a new record."
          Write-Host "The following HTTP Status Code was received: $($poqRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Created a new Record."
          Write-Host $poqRequest.Content
        }

      }
      ELSEIF ($choice -eq "PO") {
        $placeAnOrderIndicatorHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Content-Type"  = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }

        $placeAnOrderIndicatorUri = "/orders/v1/activityreports/indicator"
        $placeAnOrderIndicatorFullUri = $baseUri + $placeAnOrderIndicatorUri

        $birthDate = Read-Host "Please provide a Birth Date: "
        $birthDateAdjustment = [datetime]::ParseExact($birthDate, "yyyy-MM-dd", $NULL)
        $formattedBirthDate = $birthDateAdjustment.ToString("yyyy-MM-dd")
        
        $firstName = Read-Host "Please Provide a First Name: "
        $lastName = Read-Host "Please Provide a Last Name: "
        $licenseNumber = Read-Host "Please Provide a License Number: "
        $licenseState.ToUpper() = Read-Host "Please Provide the Licensed State Abbreviation: "
        $middleName = Read-Host "Please Provide a Middle Name: "
        $billCode.ToUpper() = Read-Host "Please Provide a Billing Code: "
        $billReference.ToUpper() = Read-Host "Please Provide a Billing Reference: "
        $purpose.ToUpper() = Read-Host "Please Provide a Purpose: "
        $options.ToUpper() = Read-Host "Please Provide an Option: "
        $licenseCategory.ToUpper() = Read-Host "Please Provide a License Category: "

        $issueDate = Read-Host "Please provide an Issue Date: "
        $issueDateAdjustment = [datetime]::ParseExact($issueDate, "yyyy-MM-dd", $NULL)
        $formattedIssueDate = $issueDateAdjustment.ToString("yyyy-MM-dd")

        $expiryDate = Read-Host "Please provide an Expiry Date: "
        $expiryDateAdjustment = [datetime]::ParseExact($expiryDate, "yyyy-MM-dd", $NULL)
        $formattedExpiryDate = $expiryDateAdjustment.ToString("yyyy-MM-dd")

        $eyeColor.ToUpper() = Read-Host "Please Provide an Eye Color: "
        $gender.ToUpper() = Read-Host "Please Provide a Gender (M, F, X): "
        $street = Read-Host "Please provide a Street Address: "
        $city = Read-Host "Please Provide a City: "
        $state.ToUpper() = Read-Host "Please Provide the State Abbreviation: "
        $zipCode = Read-Host "Please Provide a Zip Code: "
        
        $height = Read-Host "Please Provide a Height in Whole Numbers Only: "
        $weight = Read-Host "Please Provide a Weight in Whole Numbers Only: "
        $vaultAge = Read-Host "Please Provide the VaultAge in Whole Numbers Only: " # 0 = No Vault Allowed, 1-1095 days.

        $placeAnOrderIndicatorBody = [PSCustomObject]@{    
          "birthDate"       = "$($formattedBirthDate)"
          "firstName"       = "$($firstName)"
          "lastName"        = "$($lastName)"
          "licenseNumber"   = "$($licenseNumber)"
          "licenseState"    = "$($licenseState)"
          "middleName"      = "$($middleName)"
          "suffix"          = "$($suffix)"
          "billCode"        = "$($billCode)"
          "billReference"   = "$($billReference)"
          "purpose"         = "$($purpose)"
          "options"         = "[`"$($options)`"]"
          "customFields"    = "[]"
          "licenseCategory" = "$($licenseCategory)"
          "issueDate"       = "$($formattedIssueDate)"
          "expiryDate"      = "$($formattedExpiryDate)"
          "eyeColor"        = "$($eyeColor)"
          "gender"          = "$($gender)"
          "address"         = @{
            "street"  = "$($street)"
            "city"    = "$($city)"
            "state"   = "$($state)"
            "zipCode" = "$($zipCode)"
          }
          "height"          = $height
          "weight"          = $weight
          "vaultAge"        = $vaultAge
        }

        $placeAnOrderIndicatorBodyString = $placeAnOrderIndicatorBody | ConvertTo-Json

        $additionalEntries = "start"
        WHILE ($additionalEntries -ne "No") {
          $customFieldName = Read-Host "Please Provide the Key-Value Pair's Name: "
          $customFieldValue = Read-Host "Please Provide the value to the Key-Value Pair: "
  
  
          # This will need to be tested.
          $customFields = [PSCustomObject]@{
            "name"  = "$($customFieldName)"
            "value" = "$($customFieldValue)"
          }

          

          $customFieldsJson = $customFields | ConvertTo-Json
  
          $placeAnOrderIndicatorBodyString.customFields.Add($customFieldsJson)
  
          $additionalEntries = Read-Host "Additional Entries? "
        }
        

        $placeAnOrderIndicatorRequest = Invoke-WebRequest -Uri $placeAnOrderIndicatorFullUri -Method "POST" -Body $placeAnOrderIndicatorBodyString -Headers @placeAnOrderIndicatorHeaders -SslProtocol Tls13 -SkipCertificateCheck

        $placeAnOrderIndicatorResponse = $placeAnOrderIndicatorRequest.GetResponse()
        
        IF ($placeAnOrderIndicatorRequest.StatusCode -ne 201) {
          Write-Host "Failed to Place an Order."
          Write-Host "Received HTTP Status Code: $($placeAnOrderIndicatorRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Placed an Order."
          Write-Host $placeAnOrderIndicatorRequest.Content
        }

      }
      ELSEIF ($choice -eq "COS") {
        $orderId = Read-Host "Please Provide a Valid Order GUID: "
        $checkOrderStatusIndicatorUri = "/orders/v1/activityreports/indicator/$($orderId)"

        $checkOrderStatusIndicatorFullUri = $baseUri + $checkOrderStatusIndicatorUri
        $checkOrderStatusIndicatorHeaders = @{
          "x-api-key"     = $myapikey;
          "Authorization" = "Bearer $($accessToken)";
          "Accept"        = "application/json";
        }

        $checkOrderStatusIndicatorRequest = Invoke-WebRequest -Uri $checkOrderStatusIndicatorFullUri -Headers @checkOrderStatusIndicatorHeaders  -SslProtocol Tls13 -SkipCertificateCheck
        $checkOrderStatusIndicatorResponse = $checkOrderStatusIndicatorRequest.GetResponse()

        IF ($checkOrderStatusIndicatorRequest.StatusCode -ne 200) {
          Write-Host "Failed to retrieve results."
          Write-Host "The Following HTTP Status Code: $($checkOrderStatusIndicatorRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Retrieveed Results.`r`n$($checkOrderStatusIndicatorRequest.Content)"
        }

      }
      ELSEIF ($choice -eq "GR") {
        $reportId = Read-Host "Please Provide a Valid Order GUID: "
        $getReportIndicatorUri = "/reports/v1/activityreports/indicator/$($reportId)"

        $getReportIndicatorFullUri = $baseUri + $getReportIndicatorUri
        $getReportIndicatorHeaders = @{
          "x-api-key"     = $myapikey;
          "Authorization" = "Bearer $($accessToken)";
          "Accept"        = "application/json";
        }

        $getReportIndicatorRequest = Invoke-WebRequest -Uri $getReportIndicatorFullUri -Headers @getReportIndicatorHeaders  -SslProtocol Tls13 -SkipCertificateCheck
        $getReportIndicatorResponse = $getReportIndicatorRequest.GetResponse()

        IF ($getReportIndicatorRequest.StatusCode -ne 200) {
          Write-Host "Failed to retrieve results."
          Write-Host "The Following HTTP Status Code: $($getReportIndicatorRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Retrieveed Results.`r`n$($getReportIndicatorRequest.Content)"
        }
      }


      $choice = $NULL
      $choice = Read-Host "Please Provide a Choice Or Press Enter: "
    } # End of While Loop $choice
  } # End of $action AI
  ELSEIF ($action -eq "AMVR") {
    $choice = "start"
    WHILE ($NULL -ne $choice) {
      $choice = Read-Host "Please Provide a Choice Or Press Enter: "
      IF ($choice -eq "LAO") {
        $prompted = $FALSE
        IF ($prompted -eq $FALSE) {
          $pageSize = "1"
          $size = "50"
        }
        ELSEIF ($prompted -eq $TRUE) {
          $pageSize = Read-Host "Pleave provide the number of transactions you wish to review:"
          $size = Read-Host "Please Provide the number of Transactions to review on a page."
        }

        $startOrderDate = Read-Host "Please provide a Start Order Date: "
        $startOrderDateAdjustment = [datetime]::ParseExact($startOrderDate, "yyyy-MM-dd", $NULL)
        $formattedStartOrderDate = $startOrderDateAdjustment.ToString("yyyy-MM-dd")
            
        $endOrderDate = Read-Host "Please provide an End Order Date: "
        $endOrderDateAdjustment = [datetime]::ParseExact($endOrderDate, "yyyy-MM-dd", $NULL)
        $formattedEndOrderDate = $endOrderDateAdjustment.ToString("yyyy-MM-dd")

        $listAllOrdersMVR = "/orders/v1/mvrreports/activity?page=$($pageSize)&size=$($size)&startOrderDate=$($formattedStartOrderDate)&endOrderDate=$($formattedEndOrderDate)"
        
        $listAllOrdersMVRFullUri = $baseUri + $listAllOrdersMVR

        $listAllOrdersMVRHeaders = @{
          "x-api-key"                 = $myapikey;
          "Accept"                    = "application/json";
          "Authorization"             = "Bearer $($accessToken)";
          "Strict-Transport-Security" = "max-age=60;preload"; # Testing with enforced security at the Header Level. TLSv1.3 is enabled as that is the Highest Version of TLS they can use. Not all applications are caught up with TLSv1.3 many are still TLSv1.1 and TLSv1.2 .
          "Content-Security-Policy"   = "frame-ancestors 'SAMEORIGIN'"; # Out in the wild we need to be as granular as we can while allowing for full functionality.
          "X-Frame-Options"           = "SAMEORIGIN"
        }
      
        $listAllOrdersMVRRequest = Invoke-WebRequest -Uri $listAllOrdersMVRFullUri -Headers @listAllOrdersMVRHeaders -Method "GET" -SslProtocol Tls13 -SkipCertificateCheck
        $listAllOrdersMVRResponse = $listAllOrdersMVRRequest.GetResponse()

        IF ($listAllOrdersMVRRequest.StatusCode -ne 200) {
          Write-Host "Unable to retrieve results."
          Write-Host "Returned the following HTTP Status Code: $($listAllOrdersMVRRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully retrieved results.`r`n$($listAllOrdersM.Content)"
        }

      } # End of List All Orders
      ELSEIF ($choice -eq "POQ") {

        $placeOrderQuoteHeaders = @{
          "x-api-key"     = $myapikey;
          "Authorization" = "Bearer $($accessToken)";
          "Accept"        = "application/json";
          "Content-Type"  = "application/json";
        }

        $birthDate = Read-Host "Please provide a Birth Date: "
        $birthDateAdjustment = [datetime]::ParseExact($birthDate, "yyyy-MM-dd", $NULL)
        $formattedBirthDate = $birthDateAdjustment.ToString("yyyy-MM-dd")
        
        $firstName = Read-Host "Please Provide a First Name: "
        $lastName = Read-Host "Please Provide a Last Name: "
        $licenseNumber = Read-Host "Please Provide a License Number: "
        $purpose.ToUpper() = Read-Host "Please Provide a Purpose: "
        $licenseState.ToUpper() = Read-Host "Please Provide the Licensed State Abbreviation: "
        $middleName = Read-Host "Please Provide a Last Nane: "
        $suffix = Read-Host "Please Provide a Suffix: "
        $billCode.ToUpper() = Read-Host "Please Provide a Bill Code: "
        $billReference.ToUpper() = Read-Host "Please Provide a Billing Reference: "
        $options.ToUpper() = Read-Host "Please provide an option: " # This one can be a While...Loop on a Project by Project Basis, not always necessary.
        $licenseCategory.ToUpper() = Read-Host "Please provide a License Category: "

        $issueDate = Read-Host "Please provide an Issue Date: "
        $issueDateAdjustment = [datetime]::ParseExact($issueDate, "yyyy-MM-dd", $NULL)
        $formattedIssueDate = $issueDateAdjustment.ToString("yyyy-MM-dd")

        $expiryDate = Read-Host "Please provide an Expiry Date: "
        $expiryDateAdjustment = [datetime]::ParseExact($expiryDate, "yyyy-MM-dd", $NULL)
        $formattedExpiryDate = $expiryDateAdjustment.ToString("yyyy-MM-dd")

        $eyeColor.ToUpper() = Read-Host "Please Provide an Eye Color: "
        $gender.ToUpper() = Read-Host "Please Provide a Gender (M, F, X): "
        $street = Read-Host "Please provide a Street Address: "
        $city = Read-Host "Please Provide a City: "
        $stateAbbreviation.ToUpper() = Read-Host "Please Provide the State Abbreviation: "
        $zipCode = Read-Host "Please Provide a Zip Code: "
        
        $height = Read-Host "Please Provide a Height in Whole Numbers Only: "
        $weight = Read-Host "Please Provide a Weight in Whole Numbers Only: "
        $activityDuration = Read-Host "Please Provide an Activity Duration in Whole Numbers Only: "

        $poqBody = [PSCustomObject]@{
          "birthDate"        = "$($formattedBirthDate)"
          "firstName"        = "$($firstName)"
          "lastName"         = "$($lastName)"
          "licenseNumber"    = "$($licenseNumber)"
          "purpose"          = "$($purpose)" # ToUpper()
          "licenseState"     = "$($licenseState)" # ToUpper()
          "middleName"       = "$($middleName)"
          "suffix"           = "$($suffix)"
          "billCode"         = "$($billCode)"
          "billReference"    = "$($billReference)"
          "options"          = "[`"$($options)`"]" # This will be determined later, since it does not function the same structurally. [] as opposed to [{}]. It is Array-Like.
          "customFields"     = "[]" # We will add these later by asking the user how many to add.
          "licenseCategory"  = "$($licenseCategory)"
          "issueDate"        = "$($formattedIssueDate)"
          "expiryDate"       = "$($formattedExpiryDate)"
          "eyeColor"         = "$($eyeColor)"
          "gender"           = "$($gender)"
          "address"          = @{
            "street"  = "$($street)"
            "city"    = "$($city)"
            "state"   = "$($stateAbbreviation)"
            "zipCode" = "$($zipCode)"
          }
          "height"           = $height
          "weight"           = $weight
          "activityDuration" = $activityDuration
        }
        $poqBodyString = $poqBody | ConvertTo-Json

        $additionalEntries = "start"
        WHILE ($additionalEntries -ne "No") {
          $customFieldName = Read-Host "Please Provide the Key-Value Pair's Name: "
          $customFieldValue = Read-Host "Please Provide the value to the Key-Value Pair: "
  
  
          # This will need to be tested.
          $customFields = @{
            "name"  = "$($customFieldName)"
            "value" = "$($customFieldValue)"
          }
                  
          $customFieldsJson = $customFields | ConvertTo-Json
          
          $poqBodyString.customFields.Add($customFieldsJson)
  
          $additionalEntries = Read-Host "Additional Entries? "
        }

        
        $poqUri = "/orders/v1/mvrreports/activityquote"
        $poqUriFull = $baseUri + $poqUri
        $poqRequest = Invoke-WebRequest -Uri $poqUriFull -Method "POST" -Headers @placeOrderQuoteHeaders -Body @poqBodyString -SslProtocol Tls13 -SkipCertificateCheck

        $poqResponse = $poqRequest.GetResponse()

        IF ($poqRequest.StatusCode -ne 201) {
          Write-Host "Failed to create new record."
          Write-Host "The following HTTP Status Code was received: $($poqRequest.StatusCode)"
        }
        ELSEIF ($poqRequest.StatusCode -eq 201) {
          Write-Host "Successfully created new record.`r`n$($poqRequest.Content)"
        }


      } # End of Place an Order for a Quote
      ELSEIF ($choice -eq "PO") {

        $birthDate = Read-Host "Please provide a Birth Date: "
        $birthDateAdjustment = [datetime]::ParseExact($birthDate, "yyyy-MM-dd", $NULL)
        $formattedBirthDate = $birthDateAdjustment.ToString("yyyy-MM-dd")
        
        $firstName = Read-Host "Please Provide a First Name: "
        $lastName = Read-Host "Please Provide a Last Name: "
        $licenseNumber = Read-Host "Please Provide a License Number: "
        $licenseState.ToUpper() = Read-Host "Please Provide the Licensed State Abbreviation: "
        $middleName = Read-Host "Please Provide a Middle Name: "
        $suffix = Read-Host "Please Provide a Suffix: "
        $billCode.ToUpper() = Read-Host "Please Provide a Billing Code: "
        $billReference.ToUpper() = Read-Host "Please Provide a Billing Reference: "
        $purpose.ToUpper() = Read-Host "Please Provide a Purpose: "
        $options.ToUpper() = Read-Host "Please Provide an Option: "
        $licenseCategory.ToUpper() = Read-Host "Please Provide a License Category: "

        $issueDate = Read-Host "Please provide an Issue Date: "
        $issueDateAdjustment = [datetime]::ParseExact($issueDate, "yyyy-MM-dd", $NULL)
        $formattedIssueDate = $issueDateAdjustment.ToString("yyyy-MM-dd")

        $expiryDate = Read-Host "Please provide an Expiry Date: "
        $expiryDateAdjustment = [datetime]::ParseExact($expiryDate, "yyyy-MM-dd", $NULL)
        $formattedExpiryDate = $expiryDateAdjustment.ToString("yyyy-MM-dd")

        $eyeColor.ToUpper() = Read-Host "Please Provide an Eye Color: "
        $gender.ToUpper() = Read-Host "Please Provide a Gender (M, F, X): "
        $street = Read-Host "Please provide a Street Address: "
        $city = Read-Host "Please Provide a City: "
        $state.ToUpper() = Read-Host "Please Provide the State Abbreviation: "
        $zipCode = Read-Host "Please Provide a Zip Code: "
        
        $height = Read-Host "Please Provide a Height in Whole Numbers Only: "
        $weight = Read-Host "Please Provide a Weight in Whole Numbers Only: "
        $vaultAge = Read-Host "Please Provide the VaultAge in Whole Numbers Only: " # 0 = No Vault Allowed, 1-1095 days.

        $placeAnOrderMVRBody = [PSCustomObject] @{
          "birthDate"       = "$($formattedBirthDate)"
          "firstName"       = "$($firstName)"
          "lastName"        = "$($lastName)"
          "licenseNumber"   = "$($licenseNumber)"
          "purpose"         = "$($purpose)"
          "licenseState"    = "$($licenseState)"
          "middleName"      = "$($middleName)"
          "suffix"          = "$($suffix)"
          "billCode"        = "$($billCode)"
          "billReference"   = "$($billReference)"
          "options"         = "[`"$($options)`"]"
          "customFields"    = "[]"
          "licenseCategory" = "$($licenseCategory)"
          "issueDate"       = "$($formattedIssueDate)"
          "expiryDate"      = "$($formattedExpiryDate)"
          "eyeColor"        = "$($eyeColor)"
          "gender"          = "$($gender)"
          "address"         = @{
            "street"  = "$($street)"
            "city"    = "$($city)"
            "state"   = "$($state)"
            "zipCode" = "$($zipCode)"
          }
          "height"          = $height
          "weight"          = $weight
          "vaultAge"        = $vaultAge
        }

        $placeAnOrderMVRBodyString = $placeAnOrderMVRBody | ConvertTo-Json
        $additionalEntries = "start"
        
        WHILE ($additionalEntries -ne "No") {
          $customFieldName = Read-Host "Please Provide the Key-Value Pair's Name: "
          $customFieldValue = Read-Host "Please Provide the value to the Key-Value Pair: "
  
  
          # This will need to be tested.
          $customFields = @{
            "name"  = "$($customFieldName)"
            "value" = "$($customFieldValue)"
          }
                  
          $customFieldsJson = $customFields | ConvertTo-Json
          
          $placeAnOrderMVRBodyString.customFields.Add($customFieldsJson)
  
          $additionalEntries = Read-Host "Additional Entries? "
        }

        $placeAnOrderMVRHeaders = @{
          "x-api-key"    = $myapikey;
          "Accept"       = "application/json";
          "Content-Type" = "application/json";
        }

        $placeAnOrderMVRUri = "/orders/v1/mvrreports/activity"
        $placeAnOrderMVRFullUri = $baseUri + $placeAnOrderMVRUri
        $placeAnOrderMVRRequest = Invoke-WebRequest -Uri $placeAnOrderMVRFullUri -Method "POST" -Headers @placeAnOrderMVRHeaders -Body @placeAnOrderMVRBodyString -SslProtocol Tls13 -SkipCertificateCheck

        $placeAnOrderMVRResponse = $placeAnOrderMVRRequest.GetResponse()
        
        IF ($placeAnOrderMVRRequest.StatusCode -ne 201) {
          Write-Host "Unable to create a new record."
          Write-Host "The following HTTP Status Code was received: $($placeAnOrderMVRRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Created a New Record.`r`n$($placeAnOrderMVRRequest.Content)"
        }


      } # End of Place an Order
      ELSEIF ($choice -eq "COS") {
      
        $orderId = Read-Host "Please Provide a Valid Order GUID: "
        $checkOrderStatusMVRUri = "/orders/v1/mvrreports/activity/$($orderId)"
        $checkOrderStatusMVRFullUri = $baseUri + $checkOrderStatusMVRUri

        $checkOrderStatusMVRHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }

        $checkOrderStatusMVRRequest = Invoke-WebRequest -Uri $checkOrderStatusMVRFullUri -Method "GET" -Headers @checkOrderStatusMVRHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $checkOrderStatusMVRResponse = $checkOrderStatusMVRRequest.GetResponse()

        IF ($checkOrderStatusMVRRequest.StatusCode -ne 200) {
          Write-Host "Failed to retrieve Results,"
          Write-Host "The Following HTTP Status Code was received: $($checkOrderStatusMVRRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully retrieved results.`r`n$($checkOrderStatusMVRRequest.Content)"
        }

      } # End of Check Order Status
      ELSEIF ($choice -eq "GR") {
        $reportId = Read-Host "Please Provide a Valid Report GUID: "
        $getReportMVRUri = "/reports/v1/mvrreports/activity/$($reportId)"

        $getReportMVRHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/vnd.sambasafety.json;version=3.0.0";
          "Authorization" = "Bearer $($accessToken)"
        }

        $getReportMVRFullUri = $baseUri + $getReportMVRUri

        $getReportMVRRequest = Invoke-WebRequest -Uri $getReportMVRFullUri -Method "GET" -Headers @getReportMVRHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $getReportMVRResponse = $getReportMVRRequest.GetResponse()

        IF ($getReportMVRRequest.StatusCode -ne 200) {
          Write-Host "Unable to Retrieve Results."
          Write-Host "The Following HTTP Status Code was Received: $($getReportMVRRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Retrieved Results.`r`n$($getReportMVRRequest.Content)"
        }
      
      } # End of Get a Report
      $choice = $NULL
      $choice = Read-Host "Please Provide a Choice Or Press Enter: "
    } # End of $choice While loop

    
  } # End of AMVR
  ELSEIF ($action -eq "IMVR") {
    $choice = "start"
    WHILE ($NULL -ne $choice) {
      $choice = Read-Host "Please provide a choice: "

      IF ($choice -eq "LAO") {

        <#
          Prompted Section.
        #>

        $prompted = $FALSE
        IF ($prompted -eq $FALSE) {
          $pageSize = "1"
          $size = "50"
        }
        ELSEIF ($prompted -eq $TRUE) {
          $pageSize = Read-Host "Pleave provide the number of transactions you wish to review:"
          $size = Read-Host "Please Provide the number of Transactions to review on a page."
        }

        $startOrderDate = Read-Host "Please provide a Start Order Date: "
        $startOrderDateAdjustment = [datetime]::ParseExact($startOrderDate, "yyyy-MM-dd", $NULL)
        $formattedStartOrderDate = $startOrderDateAdjustment.ToString("yyyy-MM-dd")
            
        $endOrderDate = Read-Host "Please provide an End Order Date: "
        $endOrderDateAdjustment = [datetime]::ParseExact($endOrderDate, "yyyy-MM-dd", $NULL)
        $formattedEndOrderDate = $endOrderDateAdjustment.ToString("yyyy-MM-dd")

        $listAllOrdersIntelligentMVRUri = "/orders/v1/mvrreports/intelligent?page=$($pageSize)&size=$($size)&startOrderDate=$($formattedStartOrderDate)&endOrderDate=$($formattedEndOrderDate)"
        
        $listAllOrdersIntelligentMVRUri = $baseUri + $listAllOrdersIntelligentMVRUri

        $listAllOrdersIntelligentMVRHeaders = @{
          "x-api-key"                 = $myapikey;
          "Accept"                    = "application/json";
          "Authorization"             = "Bearer $($accessToken)";
          "Strict-Transport-Security" = "max-age=60;preload"; # Testing with enforced security at the Header Level. TLSv1.3 is enabled as that is the Highest Version of TLS they can use. Not all applications are caught up with TLSv1.3 many are still TLSv1.1 and TLSv1.2 .
          "Content-Security-Policy"   = "frame-ancestors 'SAMEORIGIN'"; # Out in the wild we need to be as granular as we can while allowing for full functionality.
          "X-Frame-Options"           = "SAMEORIGIN"
        }
      
        $listAllOrdersIntelligentMVRRequest = Invoke-WebRequest -Uri $listAllOrdersIntelligentMVRUri -Headers @listAllOrdersIntelligentMVRHeaders -Method "GET" -SslProtocol Tls13 -SkipCertificateCheck
        $listAllOrdersIntelligentMVResponse = $listAllOrdersIntelligentMVRRequest.GetResponse()

        IF ($listAllOrdersIntelligentMVRRequest.StatusCode -ne 200) {
          Write-Host "Unable to retrieve results."
          Write-Host "Returned the following HTTP Status Code: $($listAllOrdersIntelligentMVRRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully retrieved results.`r`n$($listAllOrdersIntelligentMVRRequest.Content)"
        }

      }
      ELSEIF ($choice -eq "PO") {
        

        $birthDate = Read-Host "Please provide a Birth Date: "
        $birthDateAdjustment = [datetime]::ParseExact($birthDate, "yyyy-MM-dd", $NULL)
        $formattedBirthDate = $birthDateAdjustment.ToString("yyyy-MM-dd")
        
        $firstName = Read-Host "Please Provide a First Name: "
        $lastName = Read-Host "Please Provide a Last Name: "
        $licenseNumber = Read-Host "Please Provide a License Number: "
        $licenseState.ToUpper() = Read-Host "Please Provide the Licensed State Abbreviation: "
        $middleName = Read-Host "Please Provide a Middle Name: "
        $suffix = Read-Host "Please Provide a Suffix: "
        $billCode.ToUpper() = Read-Host "Please Provide a Billing Code: "
        $billReference.ToUpper() = Read-Host "Please Provide a Billing Reference: "
        $purpose.ToUpper() = Read-Host "Please Provide a Purpose: "
        $options.ToUpper() = Read-Host "Please Provide an Option: "
        $licenseCategory.ToUpper() = Read-Host "Please Provide a License Category: "

        $issueDate = Read-Host "Please provide an Issue Date: "
        $issueDateAdjustment = [datetime]::ParseExact($issueDate, "yyyy-MM-dd", $NULL)
        $formattedIssueDate = $issueDateAdjustment.ToString("yyyy-MM-dd")

        $expiryDate = Read-Host "Please provide an Expiry Date: "
        $expiryDateAdjustment = [datetime]::ParseExact($expiryDate, "yyyy-MM-dd", $NULL)
        $formattedExpiryDate = $expiryDateAdjustment.ToString("yyyy-MM-dd")

        $eyeColor.ToUpper() = Read-Host "Please Provide an Eye Color: "
        $gender.ToUpper() = Read-Host "Please Provide a Gender (M, F, X): "
        $street = Read-Host "Please provide a Street Address: "
        $city = Read-Host "Please Provide a City: "
        $state.ToUpper() = Read-Host "Please Provide the State Abbreviation: "
        $zipCode = Read-Host "Please Provide a Zip Code: "
        
        $height = Read-Host "Please Provide a Height in Whole Numbers Only: "
        $weight = Read-Host "Please Provide a Weight in Whole Numbers Only: "
        $vaultAge = Read-Host "Please Provide the VaultAge in Whole Numbers Only: " # 0 = No Vault Allowed, 1-1095 days.

        $placeAnOrderIntelligentMVRBody = [PSCustomObject] @{
          "birthDate"       = "$($formattedBirthDate)"
          "firstName"       = "$($firstName)"
          "lastName"        = "$($lastName)"
          "licenseNumber"   = "$($licenseNumber)"
          "purpose"         = "$($purpose)"
          "licenseState"    = "$($licenseState)"
          "middleName"      = "$($middleName)"
          "suffix"          = "$($suffix)"
          "billCode"        = "$($billCode)"
          "billReference"   = "$($billReference)"
          "options"         = "[`"$($options)`"]"
          "customFields"    = "[]"
          "licenseCategory" = "$($licenseCategory)"
          "issueDate"       = "$($formattedIssueDate)"
          "expiryDate"      = "$($formattedExpiryDate)"
          "eyeColor"        = "$($eyeColor)"
          "gender"          = "$($gender)"
          "address"         = @{
            "street"  = "$($street)"
            "city"    = "$($city)"
            "state"   = "$($state)"
            "zipCode" = "$($zipCode)"
          }
          "height"          = $height
          "weight"          = $weight
          "vaultAge"        = $vaultAge
        }

        $placeAnOrderIntelligentMVRBodyString = $placeAnOrderIntelligentMVRBody | ConvertTo-Json
        $additionalEntries = "start"
        
        WHILE ($additionalEntries -ne "No") {
          $customFieldName = Read-Host "Please Provide the Key-Value Pair's Name: "
          $customFieldValue = Read-Host "Please Provide the value to the Key-Value Pair: "
  
  
          # This will need to be tested.
          $customFields = @{
            "name"  = "$($customFieldName)"
            "value" = "$($customFieldValue)"
          }
                  
          $customFieldsJson = $customFields | ConvertTo-Json
          
          $placeAnOrderIntelligentMVRBodyString.customFields.Add($customFieldsJson)
  
          $additionalEntries = Read-Host "Additional Entries? "
        }

        $placeAnOrderIntelligentMVRHeaders = @{
          "x-api-key"    = $myapikey;
          "Accept"       = "application/json";
          "Content-Type" = "application/json";
        }

        $placeAnOrderIntelligentMVRUri = "/orders/v1/mvrreports/intelligent"
        $placeAnOrderIntelligentMVRUriFull = $baseUri + $placeAnOrderIntelligentMVRUri
        $placeAnOrderIntelligentMVRRequest = Invoke-WebRequest -Uri $placeAnOrderIntelligentMVRUriFull -Method "POST" -Headers @placeAnOrderIntelligentMVRHeaders -Body @placeAnOrderIntelligentMVRBodyString -SslProtocol Tls13 -SkipCertificateCheck

        $placeAnOrderIntelligentMVRResponse = $placeAnOrderIntelligentMVRRequest.GetResponse()
        
        IF ($placeAnOrderIntelligentMVRRequest.StatusCode -ne 201) {
          Write-Host "Unable to create a new record."
          Write-Host "The following HTTP Status Code was received: $($placeAnOrderIntelligentMVRRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Created a New Record.`r`n$($placeAnOrderIntelligentMVRRequest.Content)"
        }

      }
      ELSEIF ($choice -eq "COS") {
        # Check Order Status
        $checkOrderStatusIntelligentMVRHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)";
        }

        $orderId = Read-Host "Please Prove a Valid Order GUID: "
        $checkOrderStatusIntelligentMVRUri = "/orders/v1/mvrreports/intelligent/$($orderId)"

        # This could be condensed to $baseUri += $checkOrderStatusIntelligentMVRUri
        $checkOrderStatusIntelligentMVRFullUri = $baseUri + $checkOrderStatusIntelligentMVRUri


        $checkOrderStatusIntellligentMVRRequest = Invoke-WebRequest -Uri $checkOrderStatusIntelligentMVRFullUri -Method "GET" -Headers @checkOrderStatusIntelligentMVRHeaders -SslProtocol Tls13 -SkipCertificateCheck
      
        IF ($checkOrderStatusIntellligentMVRRequest.StatusCode -ne 200) {
          Write-Host "Failed to Retrieve Results."
          Write-Host "The Following HTTP Status Code was Returned: $($checkOrderStatusIntellligentMVRRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Retrieved Results.`r`n$($checkOrderStatusIntellligentMVRRequest.Content)"
        }

      }
      ELSEIF ($choice -eq "GR") {
        $reportId = Read-Host "Please Provide a Valid Report GUID: "
        $getAReportIntelligentMVRUri = "/reports/v1/mvrreports/intelligent/$($reportId)"

        $getAReportIntelligentMVRHeaders = @{
          "x-api-key"     = $myapikey;
          "Authorization" = "Bearer $($accessToken)";
          "Accept"        = "application/vnd.sambasafety.json;version=3.0.0";
        }

        $getAReportIntelligentMVRFullUri = $baseUri + $getAReportIntelligentMVRUri

        $getAReportIntelligentMVRRequest = Invoke-WebRequest -Uri $getAReportIntelligentMVRFullUri -Headers @getAReportIntelligentMVRHeaders -Method "GET" -SslProtocol Tls13 -SkipCertificateCheck
        $getAReportIntelligentMVRResponse = $getAReportIntelligentMVRRequest.GeetResponse()

        IF ($getAReportIntelligentMVRRequest.StatusCode -ne 200) {
          Write-Host "Failed to retrieve results."
          Write-Host "The Following HTTP Status Code was Received: $($getAReportIntelligentMVRRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Retrieved Results.`r`n$($getAReportIntelligentMVRRequest.Content)"
        }
      }
      $choice = $NULL
      $choice = Read-Host "Please Provide a Choice Or Press Enter: "
    } # End of While Loop $choice
  } # End of IMVR
  ELSEIF ($action -eq "TMVR") {
    $choice = "start"
    WHILE ($NULL -ne $choice) {
      IF ($choice -eq "LAO") {
        
        $prompted = $FALSE
        IF ($prompted -eq $TRUE) {
          $pageSize = Read-Host "Please Provide a Page Size in Whole Numbers Only: "
          $size = Read-Host "Please Provide a Size in Whole Numbers Only: "
          $listAllOrdersIntelligentTMVRUri = "/transactional/v1/mvrorders?page=$($pageSize)&size=$($size)"
        }
        ELSE {
          $listAllOrdersIntelligentTMVRUri = "/transactional/v1/mvrorders"
        }


        $listAllOrdersIntelligentTMVRFullUri = $baseUri + $listAllOrdersIntelligentTMVRUri
        $listAllOrdersIntelligentTMVRHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }

        $listAllOrdersIntelligentTMVRRequest = Invoke-WebRequest -Uri $listAllOrdersIntelligentTMVRFullUri -Headers @listAllOrdersIntelligentTMVRHeaders
        $listAllOrdersIntelligentTMVRResposne = $listAllOrdersIntelligentTMVRRequest.GetResponse()

        IF ($listAllOrdersIntelligentTMVRRequest.StatusCode -ne 200) {
          Write-Host "Failed to retrieve results."
          Write-Host "The Following HTTP Status Code was Received: $($listAllOrdersIntelligentTMVRRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Retrieved Results.`r`n$($listAllOrdersIntelligentTMVRRequest.Content)"
        }

      }
      ELSEIF ($choice -eq "PO") {
        $birthDate = Read-Host "Please provide a Birth Date: "
        $birthDateAdjustment = [datetime]::ParseExact($birthDate, "yyyy-MM-dd", $NULL)
        $formattedBirthDate = $birthDateAdjustment.ToString("yyyy-MM-dd")

        $licenseState.ToUpper() = Read-Host "Please Provide the Licensed State Abbreviation: "  
        $licenseNumber = Read-Host "Please Provide a License Number: "
        $firstName = Read-Host "Please Provide a First Name: "
        $lastName = Read-Host "Please Provide a Last Name: "
        $middleName = Read-Host "Please Provide a Middle Name: "
        $gender.ToUpper() = Read-Host "Please Provide a Gender (M, F, X): "
        $ssn = Read-Host "Please Provide a Valid SSN: "
        $stateAccessCode.ToUpper() = Read-Host "Please Provide a State Access Code (CA, PA, and UT require this): "
        $originatingId = Read-Host "Please Provide a Valid Originating GUID: "
        $billCode.ToUpper() = Read-Host "Please Provide a Billing Code: "
        $billReference.ToUpper() = Read-Host "Please Provide a Billing Reference: "
        $productId.ToUpper() = Read-Host "Please Provide a Valid Product GUID: "
        $subType.ToUpper() = Read-Host "Please Provide a Valid Sub Type (3Y, 5Y, 7Y, EM, DB, or CR): "
        $hostValue.ToUpper() = Read-Host "Please Provide a Host Status (ONLINE or OVERNIGHT): "
        $purpose.ToUpper() = Read-Host "Please Provide a Valid Purpose: "
          
        $placeAnOrderTMVRBody = [PSCustomObject] @{
          "licenseState"    = "$($licenseState)"
          "licenseNumber"   = "$($licenseNumber)"
          "birthDate"       = "$($formattedBirthDate)"
          "firstName"       = "$($firstName)"
          "lastName"        = "$($lastName)"
          "middleName"      = "$($middleName)"
          "gender"          = "$($gender)"
          "ssn"             = "$($ssn)"
          "stateAccessCode" = "$($stateAccessCode)"
          "originationId"   = "$($originatingId)"
          "billCode"        = "$($billCode)"
          "billReference"   = "$($billReference)"
          "productId"       = "$($productId)"
          "subType"         = "$($subType)"
          "host"            = "$($hostValue)"
          "purpose"         = "$($purpose)"
          "customFields"    = "[]"
          "reportFormats"   = "[]" # Documentation States this is no longer utilized and will be ignored. The only way to force extra headers is server-side. Typically easier with an Apache Tomcay
        }
  
        $placeAnOrderTMVRBodyString = $placeAnOrderTMVRBody | ConvertTo-Json
  
        $placeAnOrderTMVRHeaders = @{
          "x-api-key"    = $myapikey;
          "Accept"       = "application/json";
          "Content-Type" = "application/json";
        }
  
        $placeAnOrderTMVRUri = "/transactional/v1/mvrorders"
        $placeAnOrderTMVRFullUri = $baseUri + $placeAnOrderTMVRUri
        $placeAnOrderTMVRRequest = Invoke-WebRequest -Uri $placeAnOrderTMVRFullUri -Method "POST" -Headers @placeAnOrderTMVRHeaders -Body @placeAnOrderTMVRBodyString -SslProtocol Tls13 -SkipCertificateCheck
  
        $placeAnOrderTMVRResponse = $placeAnOrderTMVRRequest.GetResponse()
          
        IF ($placeAnOrderTMVRRequest.StatusCode -ne 201) {
          Write-Host "Unable to create a new record."
          Write-Host "The following HTTP Status Code was received: $($placeAnOrderTMVRRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Created a New Record.`r`n$($placeAnOrderTMVRRequest.Content)"
        }

      }
      ELSEIF ($choice -eq "COS") {
        $orderId = Read-Host "Please Provide a Valid Order GUID: "
        $checkOrderStatusTMVRUri = "/transactional/v1/mvrorders/$($orderId)"
        $checkOrderStatusTMVRFullUri = $baseUri + $checkOrderStatusTMVRUri
  
        $checkOrderStatusTMVRHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }
  
        $checkOrderStatusTMVRRequest = Invoke-WebRequest -Uri $checkOrderStatusTMVRFullUri -Method "GET" -Headers @checkOrderStatusTMVRHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $checkOrderStatusTMVRResponse = $checkOrderStatusTMVRRequest.GetResponse()
  
        IF ($checkOrderStatusTMVRRequest.StatusCode -ne 200) {
          Write-Host "Failed to retrieve Results,"
          Write-Host "The Following HTTP Status Code was received: $($checkOrderStatusTMVRRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully retrieved results.`r`n$($checkOrderStatusTMVRRequest.Content)"
        }
      }
      ELSEIF ($choice -eq "GR") {
        $reportId = Read-Host "Please Provide a Valid Report GUID: "
        $getReportTMVRUri = "/reports/v1/motorvehiclereports/$($reportId)"
  
        $getReportTMVRHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/vnd.sambasafety.json;version=3.0.0";
          "Authorization" = "Bearer $($accessToken)"
        }
  
        $getReportTMVRFullUri = $baseUri + $getReportTMVRUri
  
        $getReportTMVRRequest = Invoke-WebRequest -Uri $getReportTMVRFullUri -Method "GET" -Headers @getReportTMVRHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $getReportTMVRResponse = $getReportTMVRRequest.GetResponse()
  
        IF ($getReportTMVRRequest.StatusCode -ne 200) {
          Write-Host "Unable to Retrieve Results."
          Write-Host "The Following HTTP Status Code was Received: $($getReportTMVRRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Retrieved Results.`r`n$($getReportTMVRRequest.Content)"
        }
      }

      $choice = $NULL
      $choice = Read-Host "Please Provide a Choice Or Press Enter: "
    } # End of $choice While Loop for TMVR
  } # End of TMVR
  ELSEIF ($action -eq "LMG") {
    $choice = "start"
    WHILE ($NULL -ne $choice) {
      $choice = Read-Host "Please Provide a Choice"
      IF ($choice -eq "LAG") {
        
        $prompt = $FALSE
        IF ($prompt -eq $TRUE) {
          $pageSize = Read-Host "Please Provide a Size in Whole Numbers Only: "
          $size = Read-Host "Please Provide a Size in Whole Numbers Only: "
          $listAllGroupsUri = "/organization/v1/groups?page=$($pageSize)&size=$($size)"
        }
        ELSE {
          $listAllGroupsUri = "/organization/v1/groups"
        }
        
        $listAllGroupsFullUri = $baseUri + $listAllGroupsUri
        $listAllGroupsHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }

        $listAllGroupsRequest = Invoke-WebRequest -Uri $listAllGroupsFullUri -Method "GET" -Headers @listAllGroupsHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $listAllGroupsResponse = $listAllGroupsRequest.GetResponse()

        IF ($listAllGroupsRequest.StatusCode -eq 200) {
          Write-Host "Failed to Retrieve results."
          Write-Host "The Following HTTP Status Code was Received: $($listAllGroupsRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Retrieved Results.`r`n$($listAllGroupsRequest.Content)"
        }

      }
      ELSEIF ($choice -eq "CAG") {
        $createAGroupUri = "/organization/v1/groups"
        $createAGroupFullUri = $baseUri + $createAGroupUri

        $createAGroupHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)";
          "Content-Type"  = "application/json";
        }

        $groupName = Read-Host "Please Provide a Group Name: "
        $description = Read-Host "Please Provide a Description: "

        $ask = Read-Host "Establish A Heirarchy? (Y or N): "
        IF ($ask -eq "Y") {
          $parentGroupId = Read-Host "Please Provide a Parent Group GUID: "
        }

        $createAGroupBody = [PSCustomObject]@{
          "groupName"     = "$($groupName)"
          "description"   = "$($description)"
          "parentGroupId" = "$($parentGroupId)"
        }

        $createAGroupBodyString = $createAGroupBody | ConvertTo-Json

        $createAGroupRequest = Invoke-WebRequest -Uri $createAGroupFullUri -Headers @createAGroupHeaders -Method "POST" -Body $createAGroupBodyString -SslProtocol Tls13 -SkipCertificateCheck
        $createAGroupResponse = $createAGroupRequest.GetResponse()

        IF ($createAGroupRequest.StatusCode -eq 201) {
          Write-Host "Failed to Create a New Record."
          Write-Host "The Following HTTP Status Code was received: $($createAGroupRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Create a New Record.`r`n$($createAGroupRequest.Content)"
        }


      }
      ELSEIF ($choice -eq "RAG") {
        $groupId = Read-Host "Please Provide a Valid Group GUID: "
        $readAGroupUri = "/organization/v1/groups/$($groupId)"
        
        $readAGroupHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }

        $readAGroupFullUri = $baseUri + $readAGroupUri

        $readAGroupRequest = Invoke-WebRequest -Uri $readAGroupFullUri -Method "GET" -Headers @readAGroupHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $readAGroupResponse = $readAGroupRequest.GetResponse()

        IF ($readAGroupRequest.StatusCode -eq 200) {
          Write-Host "Failed to retrieve results."
          Write-Host "The Following HTTP Status Code was Received: $($readAGroupRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully Retrieved Results.`r`n$($readAGroupRequest.Content)"
        }

      }
      ELSEIF ($choice -eq "UAG") {
        $groupId = Read-Host "Please Provide a Valid Group GUID: "
        $groupName = Read-Host "Please Provide a Group Name: "
        $description = Read-Host "Please Provide a Description: "

        $ask = Read-Host "Enabling Hierarchy (Y or N)?"
        IF ($ask -eq "Y") {
          $parentGroupId = Read-Host "Please Provide a Parent Group GUID: "
        }

        $updateAGroupUri = "/organization/v1/groups/$($groupId)"

        $updateAGroupHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Content-Type"  = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }

        $updateAGroupBody = [PsCustomObject]@{
          "groupName"     = "$($groupName)"
          "description"   = "$($description)"
          "parentGroupId" = "$($parentGroupId)"
        }

        $updateAGroupBodyString = $updateAGroupBody | ConvertTo-Json

        $updateAGroupFullUri = $baseUri + $updateAGroupUri

        $updateAGroupRequest = Invoke-WebRequest -Uri $updateAGroupFullUri -Method "PUT" -Body $updateAGroupBodyString -Headers @updateAGroupHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $updateAGroupResponse = $updateAGroupRequest.GetResponse()

        IF ($updateAGroupRequest.StatusCode -ne 204) {
          Write-Host "Failed to Update a Group."
          Write-Host "The Following Group GUID ($($groupId))."
          Write-Host "The Following HTTP Status Code: $($updateAGroupRequest.StatuCode)"
        }
        ELSE {
          Write-Host "Successfully Updated the Group with GUID ($($groupId))"
        }
      }
      ELSEIF ($choice -eq "DAG") {
        $groupId = Read-Host "Please Provide a Valid Group GUID: "
        $deleteAGroupUri = "/organization/av1/groups/$($groupId)"

        $deleteAGroupHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)";
        }

        $deleteAGroupFullUri = $baseUri + $deleteAGroupUri

        $deleteAGroupRequest = Invoke-WebRequest -Uri $deleteAGroupFullUri -Method "DELETE" -Headers @deleteAGroupHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $deleteAGroupResponse = $deleteAGroupRequest.GetResponse()

        IF ($deleteAGroupRequest.StatusCode -ne 204) {
          Write-Host "Failed to Delete Record."
          Write-Host "The Following HTTP Status Code was received: $($deleteAGroupRequest.StatusCode)"
        }
      }
      ELSEIF ($choice -eq "MAPTG") {
        $groupId = Read-Host "Please Provide a Valid Group GUID: "
        $personId = Read-Host "Please Provide a Valid Person GUID: "
        $moveAPersonToAGroupUri = "/organization/v1/groups/$($groupId)/people/$($personId)"
        $moveAPersonToAGroupFullUri = $baseUri = $moveAPersonToAGroupUri

        $moveAPersonToAGroupHeaders = @{
          "x-api-key"     = $myapikey;
          "Accept"        = "application/json";
          "Authorization" = "Bearer $($accessToken)"
        }

        $moveAPersonToAGroupRequest = Invoke-WebRequest -Uri $moveAPersonToAGroupFullUri -Method "PUT" -Headers @moveAPersonToAGroupHeaders -SslProtocol Tls13 -SkipCertificateCheck
        $moveAPersonToAGroupResponse = $moveAPersonToAGroupRequest.GetResponse()

        IF ($moveAPersonToAGroupRequest.StatusCode -ne 204) {
          Write-Host "Failed to Move Person: $($personId) to Group: $($groupId)."
          Write-Host "The Following HTTP Status Code was received: $($moveAPersonToAGroupRequest.StatusCode)"
        }
        ELSE {
          Write-Host "Successfully moved Person $($personId) to Group $($groupId)."
        }
      }
      $choice = $NULL
      $choice = Read-Host "Please Provide a Choice Or Press Enter: "
    } # End of While Loop $choice

  } # End of LMG
  ELSEIF ($action -eq "LMP") {
    $choice = "start"
    WHILE ($NULL -ne $choice) {
      $choice = Read-Host "Please Provide a Choice"
      IF ($choice -eq "AD") {
        $secondaryAsk = Read-Host "Please Provide a Decision on People Activity Data."
        IF ($secondaryAsk -eq "AAD") {
          $personId = Read-Host "Please Provide a Valid Person GUID: "
          $addActivityDataUri = "/organization/v1/people/$($personId)/activity"

          $addActivityHeaders = @{
            "x-api-key"     = $myapikey;
            "Accept"        = "application/json";
            "Content-Type"  = "application/json";
            "Authorization" = "Bearer $($accessToken)"
          }

          $addActivityDataFullUri = $baseUri + $addActivityDataUri

          $activityId = Read-Host "Please Provide a Valid Activity ID: "
          $activityType = Read-Host "Please Provide a Valid Activity Type: "

          $activityDate = Read-Host "Please provide an Activity Date: "
          $activityDateAdjustment = [datetime]::ParseExact($activityDate, "yyyy-MM-dd", $NULL)
          $formattedActivityDate = $activityDateAdjustment.ToString("yyyy-MM-dd")

          $description = Read-Host "Please Provide a Description: "
          $subType = Read-Host "Please Provide a Valid Sub-Type"

          $classification = Read-Host "Please Provide a Classification"
          $cost = Read-Host "Please Provide a Cost: "
          $locale = Read-Host "Please Provide the State Abbreviation: "
          $details = Read-Host "Please Provide Details: "
          $vehicleUID = Read-Host "Please Provide the Vehicle ID: "
          $score = Read-Host "Please Provide a Score in Whole Numbers Only: "
          $archiveStatus = Read-Host "Please provide an Archive Status (true or false): "

          $addActivityDataBody = [PSCustomObject]@{
            "activityId"     = "$($activityId)"
            "activityType"   = "$($activityType)"
            "activityDate"   = "$($formattedActivityDate)"
            "description"    = "$($description)"
            "subType"        = "$($subType)"
            "classification" = "$($classification)"
            "cost"           = "$($cost)"
            "location"       = "$($locale)"
            "details"        = "$($details)"
            "vehicleId"      = "$($vehicleUID)"
            "score"          = $score
            "archiveStatus"  = $archiveStatus
          }
        }
        ELSEIF ($secondaryAsk -eq "SAD") {
            
        }
        ELSEIF ($secondaryAsk -eq "GAD") {
            
        }
        ELSEIF ($secondaryAsk -eq "UAD") {
            
        }
        ELSEIF ($secondaryAsk -eq "ADTA") {
            
        }

      }
      ELSEIF ($choice -eq "CF") {
        $tertiaryAsk = Read-Host "Please Provide a Decision: "
        IF ($tertiaryAsk -eq "RCFP") {
          
        }
        ELSEIF ($tertiaryAsk -eq "SCFP") {
          
        } # End of Set Custom Fields for a Person

      }
      ELSEIF ($choice -eq "SP") {
        
      }



      $choice = $NULL
      $choice = Read-Host "Please Provide a Choice"
    }
  } # End of LMP
  $action = $NULL # We must null the value prior to asking again. Otherwise, we will be stuck looping.
  $action = Read-Host "Please Provide an Action or Press Enter: "
} # End While Loop

# To remove this file from the git rep but keep locally.
# git rm --cached -r ./sambasecurityapis

$revokeTokenUri = "/oauth2/v1/revoke?"
$revokeTokenFullUri = $baseUri + $revokeTokenUri

$revokeTokenHeaders = @{
  "x-api-key" = $myapikey;
  "Accept"    = "application/json";
}

$revokeTokenUrlEncoding = "token=$($accessToken)"
$revokeTokenUrlEncoded = [uri]::EscapeDataString($revokeTokenUrlEncoding)

$revokeTokenFullUriAndEcoding = $revokeTokenFullUri + $revokeTokenUrlEncoded