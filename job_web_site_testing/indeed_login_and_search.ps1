    <#
                    .SYNOPSIS
                    Launch Chromedriver.
                    Navigate to indeed.com

                    .DESCRIPTION
                    Long description

                    .EXAMPLE
                    An example

                    .NOTES
                    General notes
                    #>
    #param (
    #
    #)

<# 
IF (Test-Path -Path E:\chromedriver-win64) {
    &{chromedriver.exe "https://www.indeed.com/account/login"}
} ELSE {
    $env:Path = $env:Path + ";<yourchromedriverpath>;"
    &{chromedriver.exe "https://www.indeed.com/account/login"}
}

 #>

 $response = Invoke-WebRequest -Uri "https://secure.indeed.com/auth?hl=en_US&co=US&continue=https%3A%2F%2Fwww.indeed.com%2F%3Ffrom%3Dgnav-util-homepage&tmpl=desktop&from=gnav-util-homepage&jsContinue=https%3A%2F%2Fonboarding.indeed.com%2Fonboarding%3Fhl%3Den_US%26co%3DUS%26from%3Dgnav-homepage&empContinue=https%3A%2F%2Faccount.indeed.com%2Fmyaccess" -Method "GET"
 $form = $response.Forms[0]
 $form.Fields["ifl-InputFormField-ihl-useId-passport-webapp-1"] = "jcbshuster@yahoo.com"
 $result = Invoke-WebRequest -Uri $form.Action -Method "POST" -Body $form.Fields

 $userinput = Read-Host "Please Provide the 6-digit code: "

 $logintoindeed = Invoke-WebRequest -Uri "https://secure.indeed.com/auth?hl=en_US&co=US&continue=https%3A%2F%2Fwww.indeed.com%2F%3Ffrom%3Dgnav-util-homepage&tmpl=desktop&from=gnav-util-homepage&jsContinue=https%3A%2F%2Fonboarding.indeed.com%2Fonboarding%3Fhl%3Den_US%26co%3DUS%26from%3Dgnav-homepage&empContinue=https%3A%2F%2Faccount.indeed.com%2Fmyaccess" -Method "GET"

 $loginform = $logintoindeed.Forms[0]
 $loginform.Fields["passcode-input"] = $userinput
 $loginresult = Invoke-WebRequest -Uri $loginform.Action -Method $loginform.Method -Body $loginform.Fields

 $jobsearch = Read-Host "Please provide a Job Title or keyword to search for: "

 $performjobsearch = Invoke-WebRequest -Uri "https://www.indeed.com" -Method "GET"
 $performjobsearchform = $performjobsearch.Forms[0]
 $performjobsearchform.Fields["text-input-what"] = $jobsearch

 $performjobsearchresult = Invoke-WebRequest -Uri $performjobsearchform.Action -Method $performjobsearchform.Method -Body $performjobsearchform.Fields