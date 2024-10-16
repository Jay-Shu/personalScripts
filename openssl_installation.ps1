<#
    Name of Script: openssl_installation.ps1
    Author: Jacob Shuster
    Role: Consultant - 1099
    Umbrella Company: N/A
    Creation Date: 2024-03-20
    Script Cost: 6 hours
    Rate: 100.00 (Based on 2019*)

    Changelog:
        2024-03-21: Inclusion of Changelog.
        2024-03-21: Adding in If-Else blocks to enable testing.
        2024-03-22: If-Else blocks consolidiation.
        2024-03-22: Updated Write-Host lines within test block, Included escape characters, and update
            of the variables used to reflect their proper syntax within "".
            $($variableName)
            $($hashTable.variableName)
        2024-03-22: Completed If-Else blocks consolidation.
        2024-03-22: Added function for retrieving the Script Name. Will be used for future scripts as a
            library. To reduce the amount of additional coding lines per script.
        2024-03-22: Added in Warnings for various sections regarding the enabling and disabling of
            certain variables.
        2024-03-22: Added in additional Notes for OpenSSL Testing for s_client and s_server.
		2024-07-14: Added in retrieval of OS Version. Refer to Citations.
		2024-07-14: Added in Legacy options for Windows Server 2012 and older versions. This is an issue with OpenSSL 3.x
			and not OpenSSL 1.x. Specifically "-keypbe PBE-SHA1-3DES -certpbe PBE-SHA1-3DES"
		2024-07-14: Added in logic for running with or without legacy options in OpenSSL.
        2024-08-07: Removed previous default comments.

    TO DO:
        N/A - No current modification requests pending.

    DISCLAIMER:
        After receipt, this Script is "as-is". Additional modifications past the base are at 100.00 per hour.
        This script is intended to setup your initial certificate chain. It is only expected to be ran 1 time.
        Additional runs past the first will yield unexpected results.
    
    Non-Billable Items:
        Notes that do not affect the integrity of the Script.
        Re-Formatting of the proper semantics. This was to ensure consistency within the script, and
            ensure lines will execute as expected. i.e. $variable => $($varible) and $variable => $($hashtable.variable).
        
    Accessing the below variables $globalVars.variablename

    WARNING: Do not have trailing spaces in front or behind of any "<string>" for the "-subj" argument
        this will cause it to fail.

    Variables:
        checkHomeDrive; This variable is checking the HOMEDRIVE of the User. If the HOMEDRIVE is a
            Network drive, then it will be updated to a local location. A similar action applies to
            RabbitMQ as well (You cannot install RabbitMQ with an account that has a Network
            HOMEDRIVE location).
        globalVars; This hashtable is all of your Global Variables that will be referenced below.
            You need to update these to their appropriate values for script to intake for processing.
            The way to access these variables is $globalVars.variableName
            and $($globalVars.variableName).
        certificateAuth; This variable is your Root Certificate Authority base folder name.
        interCertificateAUth; This variable is your Intermediate Certificate Authority base folder name.
        test; Set to $true to execute tests, Set to $false to skip tests.
        serialNum; By default this 1000, if you intend to follow any documentation that surrounds 
            OpenSSL provided internally this will be the value used.
        indexVal; By default this needs to be null, therefore set to $NULL
        compName2; This variable is to retrieve the Hostname
        computerName2; This variable is to retrieve the Computer Name
        home; We are setting this higher, in the event that Hash Tables do not allow for if-else blocks.
        localMachineCountry; This variable is to retrieve the Country Code for the Local Machine.
        defaultOrganizationalUnit; This variable is set to Consulting - 1099 by default. Update this to
            it's appropriate Unit (i.e. Technical Support, Development, Sales, Pre-Sales, etc.)
        defaultOrganization; This variable is set to McGee ECM Solutions, LLC, by default. Update this to
            it's appropriate Organization (i.e. Mickey Mouse Fun House, ACME Inc., Wabbit Season, LLC.)
            Example:
                Using configuration from E:\ca\openssl_ca.cfg
                Enter pass phrase for E:/ca/private/ca.key.pem:
                Check that the request matches the signature
                Signature ok
                The organizationName field is different between
                CA certificate (McGee ECM Solutions, LLC.) and the request (McGee ECM Solutions)
        defaultEmail; This variable is the email associated with the Organization requesting the Certificate(s).
            Optional within the openssl_ca.cfg [v3_ca] and openssl_int.cfg [v3_intermediate] files.
        defaultState; This variable is for the State or Province. Default is set to Kansas.
        defaultLocale; This variable is for the City or Locale.
        importCertificateChain; This variable is for turning the import of the certificate chain following creation.
            Set to $true to have this completed. Set to $false to skip.
        createThePFX; This variable is for turning the creation of the PFX on $true, or off $false.
        openssl3Compat; This variable is for the Compatibility that applies to OpenSSL 3.x . Whereas,
            In versions 1.x this was not necessary.
        leafOrganizationalUnit; This variables is for the Organizational Unit of the Leaf Certificate.
        leafOrganization; This variable is for the Organization of the Leaf Certificate.
        leafEmail; This variable is for the Email of the Leaf Certificate. Update it to the correct value.
        leafState; This variable is for the State of the Leaf Certificate. Update it to the correct value.
        leafLocale; This variable is for the Locale of the Leaf Certificate. Update it to the correct value.
        leafCN; THis variable is for the Common Name in the Subject Attribute of your Certificate.
            If you have Subject Alternative Name Attribute then this is looked at second by any
            transmitting Servers.
            This matters heavily for: Perceptive DataTransfer, Perceptive Connect Runtime, Perceptive TransForm,
            and Load Balancers (add a layer of complexity with Trust Stores and traffic handling).
        useSubjectAltName; This variable is for enabling the Subject Alternative Name Attribute.
            Default is $false, set to $true to include this Attribute.
        leafSubjectAltName; This variable is for the Subject Alternative Name Attribute values.
            Your notation is in subjectAltName=DNS.1:localhost,DNS.2:mcfoo,IP.1:127.0.0.1,IP.2:10.0.0.1
            Where IP is each IP that is registered to this Certificate and Each DNS is each DNS
            Entry thatis registered to the certificate.
        leafCertName; This variable is for setting the name of the Leaf Certificate. If you want this to
            match your FQDN, then set this to $leafCN
        init_ca_file; This variable is preparing your openssl_ca.cfg file for usage. Do not modify unless
            you know what you are doing.
        init_int_file; This variable is preparing your openssl_int.cfg file for usage. Do not modify unless
            you know what you are doing.
        scriptName; This variable is full path of the Script. First execution is just
		signature; This variable is necessary for powershell to determine the Major and Minor versions of the
			Operating System.
		os: This variable is for storing the Operating System.
		majorVersion: This variable is for storing the Major Version retrieved by Powershell.
		minorVersion: This variable is for storing the Minor Version retrieved by Powershell. Not Needed, at this time.
		build: This variable is the build associated with the release.
		buildNumber: This variable is the revision number associated with the release.
		
		
		
	Citations:
		1. Use Powershell to Find Operating System Version, https://devblogs.microsoft.com/scripting/use-powershell-to-find-operating-system-version/
		2. Operating System Version, https://learn.microsoft.com/en-us/windows/win32/sysinfo/operating-system-version
#>

<#
    Functions => Being migrated to .\function_library
#>

# https://hostingultraso.com/help/windows/find-your-script%E2%80%99s-name-powershell

function GetScriptName
{

$myInvocation.ScriptName
 # Import-Module <path> myfunctions.ps1 for functional scripts in the future.

}


$scriptName = (GetScriptName | Split-Path -Leaf)
Write-Host "Executing script $($scriptName)"

# Adding in a Version Check
Function Get-OSVersion

{

 $signature = @"

 [DllImport("kernel32.dll")]

 public static extern uint GetVersion();

"@
Add-Type -MemberDefinition $signature -Name "Win32OSVersion" -Namespace Win32Functions -PassThru
}

$os = [System.BitConverter]::GetBytes((Get-OSVersion)::GetVersion())
$majorVersion = $os[0]
$minorVersion = $os[1]
$build = [byte]$os[2],[byte]$os[3]
$buildNumber = [System.BitConverter]::ToInt16($build,0)

# We need to know if our Operating system requires legacy algorithms

# Uncomment for testing.
# "Version is {0}.{1} build {2}" -F $majorVersion,$minorVersion,$buildNumber



$checkHomeDrive = $env:HOMEDRIVE

if($checkHomeDrive -ccontains "\\"){

    $env:HOMEDRIVE = "E:"
}

$globalVars = @{
    certificateAuth = "ca";
    interCertificateAUth = "intermediate";
    test = $true; # Default is $true to avoid accidental runs.
    download = $false; # Default is $false, assuming it was downloaded prior to the introduction of this script.
    serialNum = "1000";
    indexVal = $NULL; # This MUST be null during initialization. DO NOT CHANGE THIS VALUE.
    compName2 = ([System.Net.Dns]::GetHostByName($env:computerName).HostName);
    computerName2 = ([System.Net.Dns]::GetHostByName($env:computerName));
    home = $env:HOMEDRIVE;
    localMachineCountry = (Get-ItemProperty -Path 'HKCU:\Control Panel\International\Geo' | Select-Object -ExpandProperty Name);
    defaultOrganizationalUnit = "Consulting - 1099";
    defaultOrganization = "NameGoesHere"; # THESE MUST MATCH FOR THE ROOT TO SIGN THE INTERMEDAITE CERTIFICATE.
    defaultEmail = "first.last@company.com";
    defaultState = "Kansas";
    defaultLocale = "Kansas City";
    importCertificateChain = $true;
    createThePFX = $true;
    openssl3Compat = $true;
    leafOrganizationalUnit = $globalVars.defaultOrganizationalUnit;
    leafOrganization = $globalVars.defaultOrganization ; # This does not have to match prior Root and Intermediate Subject attributes.
    leafEmail = $globalVars.defaultEmail;
    leafState = $globalVars.defaultState;
    leafLocale = $globalVars.defaultLocale;
    leafCN = "<FQDN>"; # This does not have to match prior Root and Intermediate Subject attributes. However, CNs that match will be denied. Also, CN will be ignored when Subject Alternative Name is in use. For Load-Balancing this must be true, also with certain products that require the address either inbound or outbound to match that value. Perceptive DataTransfer and Perceptive Connect Runtime are both affected by this.
    useSubjectAltName = $true;
    # Note that URI is left out from the subjectAltName, this is due to an issue of not properly creating the URI attribute.
    # Also, you can use a single certificate for your entire stack as long as you include all of their IP and DNS values.
    leafSubjectAltName = "<Enter in all valid entries (i.e. subjectAltName=DNS.1:localhost,DNS.2:mcfoo,IP.1:127.0.0.1,IP.2:10.0.0.1)>";
    leafCertName = "<desiredname>" # This does not have to match prior Root and Intermediate Subject attributes.

}
<#
    It is necessary to have this filled out PRIOR to any If-else blocks.
    This is because it is necessary for the creation of the openssl_ca.cfg
    and the openssl_int.cfg
#>
$init_ca_file = @"
#
# OpenSSL example configuration file.
# See doc/man5/config.pod for more info.
#
# This is mostly being used for generation of certificate requests,
# but may be used for auto loading of providers

# Note that you can include other files from the main configuration
# file using the .include directive.
#.include filename

# This definition stops the following lines choking if HOME isn't
# defined.
HOME			= .

# Use this in order to automatically load providers.
openssl_conf = openssl_init

# Comment out the next line to ignore configuration errors
config_diagnostics = 1

# Extra OBJECT IDENTIFIER info:
# oid_file       = `$ENV::HOME/.oid
oid_section = new_oids

# To use this configuration file with the `"-extfile`" option of the
# `"openssl x509`" utility, name here the section containing the
# X.509v3 extensions to use:
# extensions		=
# (Alternatively, use a configuration file that has only
# X.509v3 extensions in its main [= default] section.)

[ new_oids ]
# We can add new OIDs in here for use by 'ca', 'req' and 'ts'.
# Add a simple OID like this:
# testoid1=1.2.3.4
# Or use config file substitution like this:
# testoid2=`${testoid1}.5.6

# Policies used by the TSA examples.
tsa_policy1 = 1.2.3.4.1
tsa_policy2 = 1.2.3.4.5.6
tsa_policy3 = 1.2.3.4.5.7

# For FIPS
# Optionally include a file that is generated by the OpenSSL fipsinstall
# application. This file contains configuration data required by the OpenSSL
# fips provider. It contains a named section e.g. [fips_sect] which is
# referenced from the [provider_sect] below.
# Refer to the OpenSSL security policy for more information.
# .include fipsmodule.cnf

[openssl_init]
providers = provider_sect

# List of providers to load
[provider_sect]
default = default_sect
legacy = legacy_sect

# The fips section name should match the section name inside the
# included fipsmodule.cnf.
# fips = fips_sect

# If no providers are activated explicitly, the default one is activated implicitly.
# See man 7 OSSL_PROVIDER-default for more details.
#
# If you add a section explicitly activating any other provider(s), you most
# probably need to explicitly activate the default provider, otherwise it
# becomes unavailable in openssl.  As a consequence applications depending on
# OpenSSL may not work correctly which could lead to significant system
# problems including inability to remotely access the system.

[default_sect]
# activate = 1

[legacy_sect]
activate = 1

[ ca ]
default_ca = CA_default

[ CA_default ]

dir		= $($globalVars.home)/ca		# Where everything is kept
certs		= `$dir/certs		# Where the issued certs are kept
crl_dir		= `$dir/crl		# Where the issued crl are kept
database	= `$dir/index.txt	# database index file.
#unique_subject	= no			# Set to 'no' to allow creation of
					# several certs with same subject.
new_certs_dir	= `$dir/newcerts		# default place for new certs.

private_key	= `$dir/private/ca.key.pem # The private key
certificate	= `$dir/certs/ca.cert.pem 	# The CA certificate
serial		= `$dir/serial 		# The current serial number
crl		= `$dir/crl.pem 		# The current CRL
crlnumber	= `$dir/crlnumber	# the current crl number

x509_extensions	= usr_cert		# The extensions to add to the cert

# Comment out the following two lines for the `"traditional`"
# (and highly broken) format.
name_opt 	= ca_default		# Subject Name options
cert_opt 	= ca_default		# Certificate field options

# Extension copying option: use with caution.
# copy_extensions = copy

# Extensions to add to a CRL. Note: Netscape communicator chokes on V2 CRLs
# so this is commented out by default to leave a V1 CRL.
# crlnumber must also be commented out to leave a V1 CRL.
# crl_extensions	= crl_ext

default_days	= 365			# how long to certify for
default_crl_days= 3650			# how long before next CRL
default_md	= default		# use public key default MD
preserve	= no			# keep passed DN ordering

# A few difference way of specifying how similar the request should look
# For type CA, the listed attributes must be the same, and the optional
# and supplied fields are just that :-)
policy		= policy_strict

[ policy_strict ]
# The root CA should only sign intermediate certificates that match.
# See the POLICY FORMAT section of man ca.
countryName             = match
stateOrProvinceName     = match
organizationName        = match
organizationalUnitName  = optional
commonName              = supplied
emailAddress            = optional

[ policy_loose ]
# Allow the intermediate CA to sign a more diverse range of certificates.
# See the POLICY FORMAT section of the ca man page.
countryName             = optional
stateOrProvinceName     = optional
localityName            = optional
organizationName        = optional
organizationalUnitName  = optional
commonName              = supplied
emailAddress            = optional

[ req ]
# Options for the req tool (man req).
default_bits        = 2048
distinguished_name  = req_distinguished_name
string_mask         = utf8only

# SHA-1 is deprecated, so use SHA-2 instead.
default_md          = sha256

# Extension to add when the -x509 option is used.
x509_extensions     = v3_ca

[ req_distinguished_name ]
# See <https://en.wikipedia.org/wiki/Certificate_signing_request>.
countryName                     = Country Name (2 letter code)
stateOrProvinceName             = State or Province Name
localityName                    = Locality Name
0.organizationName              = Organization Name
organizationalUnitName          = Organizational Unit Name
commonName                      = Common Name
emailAddress                    = Email Address

# Optionally, specify some defaults.
countryName_default             = US
stateOrProvinceName_default     = Kansas
localityName_default            = Eudora
0.organizationName_default      = McGee ECM Solutions, LLC.
#organizationalUnitName_default =
#emailAddress_default           =

[ v3_ca ]
# Extensions for a typical CA (man x509v3_config).
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:true
keyUsage = critical, digitalSignature, cRLSign, keyCertSign

[ v3_intermediate_ca ]
# Extensions for a typical intermediate CA (man x509v3_config).
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:true, pathlen:0
keyUsage = critical, digitalSignature, cRLSign, keyCertSign
"@

$init_int_file = @"

HOME			= .

# Use this in order to automatically load providers.
openssl_conf = openssl_init

# Comment out the next line to ignore configuration errors
config_diagnostics = 1

# Extra OBJECT IDENTIFIER info:
# oid_file       = `$ENV::HOME/.oid
oid_section = new_oids

# To use this configuration file with the `"-extfile`" option of the
# `"openssl x509`" utility, name here the section containing the
# X.509v3 extensions to use:
# extensions		=
# (Alternatively, use a configuration file that has only
# X.509v3 extensions in its main [= default] section.)

[ new_oids ]
# We can add new OIDs in here for use by 'ca', 'req' and 'ts'.
# Add a simple OID like this:
# testoid1=1.2.3.4
# Or use config file substitution like this:
# testoid2=`${testoid1}.5.6

# Policies used by the TSA examples.
tsa_policy1 = 1.2.3.4.1
tsa_policy2 = 1.2.3.4.5.6
tsa_policy3 = 1.2.3.4.5.7

# For FIPS
# Optionally include a file that is generated by the OpenSSL fipsinstall
# application. This file contains configuration data required by the OpenSSL
# fips provider. It contains a named section e.g. [fips_sect] which is
# referenced from the [provider_sect] below.
# Refer to the OpenSSL security policy for more information.
# .include fipsmodule.cnf

[openssl_init]
providers = provider_sect

# List of providers to load
[provider_sect]
default = default_sect
legacy = legacy_sect

# The fips section name should match the section name inside the
# included fipsmodule.cnf.
# fips = fips_sect

# If no providers are activated explicitly, the default one is activated implicitly.
# See man 7 OSSL_PROVIDER-default for more details.
#
# If you add a section explicitly activating any other provider(s), you most
# probably need to explicitly activate the default provider, otherwise it
# becomes unavailable in openssl.  As a consequence applications depending on
# OpenSSL may not work correctly which could lead to significant system
# problems including inability to remotely access the system.

[default_sect]
# activate = 1

[legacy_sect]
activate = 1

[ ca ]
default_ca = CA_default

[ CA_default ]

dir		= $($globalVars.home)/ca/intermediate		# Where everything is kept
certs		= `$dir/certs		# Where the issued certs are kept
crl_dir		= `$dir/crl		# Where the issued crl are kept
database	= `$dir/index.txt	# database index file.
#unique_subject	= no			# Set to 'no' to allow creation of
					# several certs with same subject.
new_certs_dir	= `$dir/newcerts		# default place for new certs.

private_key	= `$dir/private/intermediate.key.pem # The private key
certificate	= `$dir/certs/intermediate.cert.pem 	# The CA certificate
serial		= `$dir/serial 		# The current serial number
crl		= `$dir/crl.pem 		# The current CRL
crlnumber	= `$dir/crlnumber	# the current crl number

x509_extensions	= usr_cert		# The extensions to add to the cert

# Comment out the following two lines for the `"traditional`"
# (and highly broken) format.
name_opt 	= ca_default		# Subject Name options
cert_opt 	= ca_default		# Certificate field options

# Extension copying option: use with caution.
# copy_extensions = copy

# Extensions to add to a CRL. Note: Netscape communicator chokes on V2 CRLs
# so this is commented out by default to leave a V1 CRL.
# crlnumber must also be commented out to leave a V1 CRL.
# crl_extensions	= crl_ext

default_days	= 365			# how long to certify for
default_crl_days= 3650			# how long before next CRL
default_md	= default		# use public key default MD
preserve	= no			# keep passed DN ordering

# A few difference way of specifying how similar the request should look
# For type CA, the listed attributes must be the same, and the optional
# and supplied fields are just that :-)
policy		= policy_loose

[ policy_strict ]
# The root CA should only sign intermediate certificates that match.
# See the POLICY FORMAT section of man ca.
countryName             = match
stateOrProvinceName     = match
organizationName        = match
organizationalUnitName  = optional
commonName              = supplied
emailAddress            = optional

[ policy_loose ]
# Allow the intermediate CA to sign a more diverse range of certificates.
# See the POLICY FORMAT section of the ca man page.
countryName             = optional
stateOrProvinceName     = optional
localityName            = optional
organizationName        = optional
organizationalUnitName  = optional
commonName              = supplied
emailAddress            = optional

[ req ]
# Options for the req tool (man req).
default_bits        = 2048
distinguished_name  = req_distinguished_name
string_mask         = utf8only

# SHA-1 is deprecated, so use SHA-2 instead.
default_md          = sha256

# Extension to add when the -x509 option is used.
x509_extensions     = v3_ca

[ req_distinguished_name ]
# See <https://en.wikipedia.org/wiki/Certificate_signing_request>.
countryName                     = Country Name (2 letter code)
stateOrProvinceName             = State or Province Name
localityName                    = Locality Name
0.organizationName              = Organization Name
organizationalUnitName          = Organizational Unit Name
commonName                      = Common Name
emailAddress                    = Email Address

# Optionally, specify some defaults.
countryName_default             = US
stateOrProvinceName_default     = Kansas
localityName_default            = Kansas City
0.organizationName_default      = McGee ECM Solutions, LLC.
organizationalUnitName_default = Global Professional Services
emailAddress_default           = first.last@mcgeeecmsolutions.com

[ v3_ca ]
# Extensions for a typical CA (man x509v3_config).
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:true
keyUsage = critical, digitalSignature, cRLSign, keyCertSign

[ v3_intermediate_ca ]
# Extensions for a typical intermediate CA (man x509v3_config).
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:true, pathlen:0
keyUsage = critical, digitalSignature, cRLSign, keyCertSign

[ usr_cert ]
# Extensions for client certificates (man x509v3_config).
basicConstraints = CA:FALSE
nsCertType = client, email
nsComment = `"OpenSSL Generated Client Certificate`"
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
keyUsage = critical, nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth, emailProtection

[ server_cert ]
# Extensions for server certificates (man x509v3_config).
basicConstraints = CA:FALSE
nsCertType = server
nsComment = `"OpenSSL Generated Server Certificate`"
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer:always
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth

[ blanket_cert ]
# Extensions for server certificates (man x509v3_config).
basicConstraints = CA:FALSE
#nsCertType = server
nsComment = `"OpenSSL Generated Blanket Certificate`"
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer:always
#keyUsage = critical, digitalSignature, keyEncipherment
#extendedKeyUsage = serverAuth

[ crl_ext ]
# Extension for CRLs (man x509v3_config).
authorityKeyIdentifier=keyid:always

[ ocsp ]
# Extension for OCSP signing certificates (man ocsp).
basicConstraints = CA:FALSE
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
keyUsage = critical, digitalSignature
extendedKeyUsage = critical, OCSPSigning
"@
<#
    Exclusions:
        Variables in relation to Root Certificate and Intermediate Certificate naming conventions. These will remain static.
#>

Set-Location -Path $env:HOMEDRIVE

New-Item -ItemType Directory -Path opensslInstallation -Force

if($globalVars.test) {
    $compName = (Get-CimInstance -ClassName Win32_ComputerSystem).Name

# This can be used to grab the username
# $usersName = ((Get-WMIObject -class Win32_ComputerSystem).username -split "\\")[1]


# Works
Write-Host "$($compName)"

# Works
# Write-Host $usersName

# Does not Work
Write-Host "$($globalVars.computerName2)"

# Works
Write-Host "$($globalVars.compName)"
    Write-Host "Your expected output:"
    Write-Host "Invoke-WebRequest -Uri `"https://slproweb.com/download/Win64OpenSSL-3_2_1.msi`" -Outfile `"E:\opensslInstallation\Win64OpenSSL-3_2_1.msi`""
    Write-Host "msiexec.exe `"E:\opensslInstallation\Win64OpenSSL-3_2_1.msi`" /QN /L* `"C:\msilog.txt`" ALLUSERS = 1"
    Write-Host "Your expected output will be:"
    Write-Host "New-Item -ItemType Directory -Path $($globalVars.home)\ca,$($globalVars.home)\ca\newcerts,$($globalVars.home)\ca\private,$($globalVars.home)\ca\crl,$($globalVars.home)\ca\certs -Force"
    Write-Host "New-Item -ItemType File -Path $($globalVars.home)\ca\index.txt"
    Write-Host "New-Item -ItemType File -Path $($globalVars.home)\ca\serial -Value `"1000`" "

    Write-Host "Your expected output:"
    Write-Host "New-Item -ItemType Directory -Path $($globalVars.home)\ca\intermediate,$($globalVars.home)\ca\intermediate\newcerts,$($globalVars.home)\ca\intermediate\private,$($globalVars.home)\ca\intermediate\crl,$($globalVars.home)\ca\intermediate\certs,$($globalVars.home)\ca\intermediate\csr -Force"
    Write-Host "New-Item -ItemType File -Path $($globalVars.home)\ca\intermediate\index.txt"
    Write-Host "New-Item -ItemType File -Path $($globalVars.home)\ca\intermediate\serial -Value `"1000`""
    Write-Host "New-Item -ItemType File -Path $($globalVars.home)\ca\intermediate\crlnumber -Value `"1000`""
    Write-Host "Add-Content -Path $($globalVars.home)\ca\openssl_ca.cfg -Value $init_ca_file -Force"
    Write-Host "Add-Content -Path $($globalVars.home)\ca\intermediate\openssl_int.cfg -Value $init_int_file -Force"
    Write-Host "&{openssl genrsa -batch -aes256 -out $($globalVars.home)\ca\private\ca.key.pem -passin pass:contentcompser 4096}"
    Write-Host "&{openssl req -batch -config $($globalVars.home)\ca\openssl_ca.cfg -key $($globalVars.home)\ca\private\ca.key.pem -new -x509 -days 7300 -sha256 -subj `"/C=$($globalVars.localMachineCountry)/ST=$($globalVars.defaultState)/L=$($globalVars.defaultLocale)/O=$($globalVars.defaultOrganization)/OU=$($globalVars.defaultOrganizationalUnit)/CN=$($globalVars.compName2)`" -extensions v3_ca -passin pass:contentcomposer -out $($globalVars.home)\ca\certs\ca.cert.pem}"
    Write-Host "Get-Content $globalVars.home\ca\certs\ca.cert.pem, $globalVars.home\ca\intermediate\certs\intermediate.cert.pem | Set-Content -Path `"$($globalVars.home)\ca\intermediate\certs\rootintermediatechain.cert.pem)`""

# We are expecting this to execute successfully. If it does not then you need to check the prior commands.
    Write-Host "&{openssl x509 -noout -text -in $($globalVars.home)\ca\certs\ca.cert.pem}"


    Write-Host "&{openssl genrsa -batch -aes256 -passin pass:contentcomposer -out $($globalVars.home)\ca\intermediate\private\intermediate.key.pem 4096}"
    Write-Host "&{openssl req -batch -config .\openssl_int.cfg -new -sha256 -subj `"/C=$($globalVars.localMachineCountry)/ST=$($globalVars.defaultState)/L=$($globalVars.defaultLocale)/O=$($globalVars.defaultOrganization)/OU=$($globalVars.defaultOrganizationalUnit)/CN=$($globalVars.compName2)`" -key $($globalVars.home)\ca\intermediate\private\intermediate.key.pem -out $($globalVars.home)\ca\intermediate\csr\intermediate.csr.pem -passin pass:contentcomposer}"
    Write-Host "&{openssl ca -batch -config $($globalVars.home)\ca\intermediate\openssl_int.cfg -extensions blanket_cert -days 3650 -notext -in $($globalVars.home)\ca\intermediate\csr\intermediate.csr.pem -passin pass:contentcomposer -out $($globalVars.home)\ca\intermediate\certs\intermediate.cert.pem}"
    Write-Host "&{openssl genrsa -out $($globalVars.home)\ca\intermediate\private\obiwanjacobi.key.pem 2048}"


if($globalVars.useSubjectAltName -ne $true ) {
    Write-Host "Running without Subject Alternative Name."
    Write-Host "If you intended to run with Subject Alternative Names"
    Write-Host "update the useSubjectAltName to `$true."
    Write-Host "&{openssl req -batch -config $($globalVars.home)\ca\intermediate\openssl_int.cfg -key $($globalVars.home)\ca\intermediate\private\$($globalVars.leafCertName).key.pem -new -sha256 -subj `"/C=$($globalVars.localMachineCountry)/ST=$($globalVars.leafState)/L=$($globalVars.leafLocale)/O=$($globalVars.leafOrganization)/OU=$($globalVars.leafOrganizationalUnit)/CN=$($globalVars.leafCN)`" -out $($globalVars.home)\ca\intermediate\csr\$($globalVars.leafCertName).csr.pem -passin pass:contentcomposer}"
} else {
    Write-Host "Provided the Following subjectAltName:"
    Write-Host $($globalVars.leafSubjectAltName)
    Write-Host "&{openssl req -batch -config $globalVars.home\ca\intermediate\openssl_int.cfg -key $($globalVars.home)\ca\intermediate\private\$($globalVars.leafCertName).key.pem -new -sha256 -subj `"/C=$($globalVars.localMachineCountry)/ST=$($globalVars.leafState)/L=$($globalVars.leafLocale)/O=$($globalVars.leafOrganization)/OU=$($globalVars.leafOrganizationalUnit)/CN=$($globalVars.leafCN)`" -addext $($globalVars.leafSubjectAltName) -out $($globalVars.home)\ca\intermediate\csr\$($globalVars.leafCertName).csr.pem -passin pass:contentcomposer}"
}

    Write-Host "&{openssl ca -batch -config $($globalVars.home)\ca\intermediate\openssl_int.cfg -extensions blanket_cert -days 3650 -notext -in $($globalVars.home)\ca\intermediate\csr\$($globalVars.leafCertName).csr.pem -passin pass:contentcomposer -out $($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).cert.pem}
&{openssl x509 -noout -text -in $($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).cert.pem}"

    Write-Host "&{openssl pkcs12 -export -inkey $($globalVars.home)\ca\intermediate\private\$($globalVars.leafCertName).key.pem -in $($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).cert.pem -certfile $($globalVars.home)\ca\intermediate\certs\ca-chain.cert.pem -name `"$($globalVars.leafCertName)`" -out $($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).pfx -passout pass:contentcomposer}"
    Write-Host "`$leafPfx = (Get-Item -Path $($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).pfx)"

    Write-Host "`$commmand = &{java -version}"
    Write-Host "`$commmand"

    if(!$command){
        Write-Host "keytool -importkeystore -srckeystore $($leafPfx) -storepass contentcomposer -destkeystore $($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).jks -deststoretype jks -deststorepass contentcomposer -destalias `"$($globalVars.leafCertName)`""
    } else {
        Write-Host "`$env:Path += `";`$env:JAVA_HOME\bin`""
        Write-Host "keytool -importkeystore -srckeystore $leafPfx -storepass contentcomposer -destkeystore $globalVars.home\ca\intermediate\certs\$($globalVars.leafCertName).jks -deststoretype jks -deststorepass contentcomposer -destalias `"$($globalVars.leafCertName)`""
    }
    
    if($globalVars.importCertificateChain = $true){

        # Importing the Certification Chain in order: Root CA Certificate, Intermediate CA Certificate, Leaf Certificate
        Write-Host "Import-Certificate -FilePath `"$($globalVars.home)\ca\certs\ca.cert.pem`" -CertStoreLocation `"Cert:\LocalMachine\Root`""
        Write-Host "Import-Certificate -FilePath `"$($globalVars.home)\ca\intermediate\certs\intermediate.cert.pem`" -CertStoreLocation `"Cert:\LocalMachine\CA`""
        Write-Host "Import-Certificate -FilePath `"$($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).cert.pem`" -CertStoreLocation `"Cert:\LocalMachine\Root`""
        
        # Microsoft Trust Store checking.
        # Root Certification Authorities.
        Write-Host "Set-Location -Path `"Cert:\LocalMachine\Root"`"
        Write-Host "&{Get-ChildItem -Path . -Recurse}"
        
        # Intermedation Certification Authorities.
        Write-Host "Set-Location -Path `"Cert:\LocalMachine\CA`""
        Write-Host "&{Get-ChildItem -Path . -Recurse}"
        }
    
        Write-Host "Some of the commands would fail or return null values."
        Write-Host "This is due files expected are not created."
        Write-Host "Therefore, shall be treated as a `"simulation`" with expected loss."
        Write-Host "Test completed."

    # Else for line 542
} else {
    if ($globalVars.download) {
        Invoke-WebRequest -Uri "https://slproweb.com/download/Win64OpenSSL-3_2_1.msi" -Outfile "E:\opensslInstallation\Win64OpenSSL-3_2_1.msi"
        msiexec.exe "E:\opensslInstallation\Win64OpenSSL-3_2_1.msi" /QN /L* "C:\msilog.txt" ALLUSERS = 1
    }
    <#
    For this section we need to create the directories
    for the Root Certificate Authority, in this case,
    referred to as the "CA"

    Condensed this down to 1 line from 4**
    #>

    New-Item -ItemType Directory -Path $($globalVars.home)\ca,$($globalVars.home)\ca\newcerts,$($globalVars.home)\ca\private,$($globalVars.home)\ca\crl,$($globalVars.home)\ca\certs -Force
    New-Item -ItemType File -Path $($globalVars.home)\ca\index.txt
    New-Item -ItemType File -Path $($globalVars.home)\ca\serial -Value "1000"

    <#
    For this section we need to create the directories
    for the Intermediate Certificate Authority, in this case,
    referred to as the "Intermediate CA".

    The Intermediate CA is responsible for signing any and
    ALL CSRs for future Leaf Certificates generated.

    Condensed this down to 1 line from 4**
    #>

    New-Item -ItemType Directory -Path "$($globalVars.home)\ca\intermediate,$($globalVars.home)\ca\intermediate\newcerts,$($globalVars.home)\ca\intermediate\private,$($globalVars.home)\ca\intermediate\crl,$($globalVars.home)\ca\intermediate\certs,$($globalVars.home)\ca\intermediate\csr" -Force
    New-Item -ItemType File -Path "$($globalVars.home)\ca\intermediate\index.txt" -Force
    New-Item -ItemType File -Path "$($globalVars.home)\ca\intermediate\serial" -Value "1000" -Force
    New-Item -ItemType File -Path "$($globalVars.home)\ca\intermediate\crlnumber" -Value "1000" -Force
    Add-Content -Path "$($globalVars.home)\ca\openssl_ca.cfg" -Value $init_ca_file -Force
    Add-Content -Path "$($globalVars.home)\ca\intermediate\openssl_int.cfg" -Value $init_int_file -Force

    Write-Host "No Installation necessary."
    <#
    For this section we are running the necessary commands to build
        the Root Certificate. In order to have a close to authentic
        chain, we need to have it be 3 tiered.
    Root Certificate Authority
        Intermediate Certificate Authority
            Leaf Certificate (What you get back whenever you send off
                a CSR and recieve a certificate).
#>

# &{} notation is a matter of preference. The commmands will execute without being wrapped in &{}.
&{openssl genrsa -batch -aes256 -out "$($globalVars.home)\ca\private\ca.key.pem" -passin pass:contentcompser 4096}
&{openssl req -batch -config "$($globalVars.home)\ca\openssl_ca.cfg" -key "$($globalVars.home)\ca\private\ca.key.pem" -new -x509 -days 7300 -sha256 -subj "/C=$($globalVars.localMachineCountry)/ST=$($globalVars.defaultState)/L=$($globalVars.defaultLocale)/O=$($globalVars.defaultOrganization)/OU=$($globalVars.defaultOrganizationalUnit)/CN=$($globalVars.compName2)" -extensions v3_ca -passin pass:contentcomposer -out "$($globalVars.home)\ca\certs\ca.cert.pem"}

# We need to concatenate the Root Certificate and Intermediate Certificate.
# For any future use this is important and makes it easy to form the chain.
# prior to keystore construction (pfx, p7b, etc.)
Get-Content "$($globalVars.home)\ca\certs\ca.cert.pem", "$($globalVars.home)\ca\intermediate\certs\intermediate.cert.pem" | Set-Content -Path "$($globalVars.home)\ca\intermediate\certs\ca-chain.cert.pem"

# We are expecting this to execute successfully. If it does not then you need to check the prior commands.
&{openssl x509 -noout -text -in "$globalVars.home\ca\certs\ca.cert.pem"}


&{openssl genrsa -batch -aes256 -passin pass:contentcomposer -out "$($globalVars.home)\ca\intermediate\private\intermediate.key.pem" 4096}
&{openssl req -batch -config "$($globalVars.home)\openssl_int.cfg" -new -sha256 -subj "/C=$($globalVars.localMachineCountry)/ST=$($globalVars.defaultState)/L=$($globalVars.defaultLocale)/O=$($globalVars.defaultOrganization)/OU=$($globalVars.defaultOrganizationalUnit)/CN=$($globalVars.compName2)" -key "$($globalVars.home)\ca\intermediate\private\intermediate.key.pem" -out "$($globalVars.home)\ca\intermediate\csr\intermediate.csr.pem" -passin pass:contentcomposer}
&{openssl ca -batch -config "$($globalVars.home)\ca\intermediate\openssl_int.cfg" -extensions blanket_cert -days 3650 -notext -in "$($globalVars.home)\ca\intermediate\csr\intermediate.csr.pem" -passin pass:contentcomposer -out "$($globalVars.home)\ca\intermediate\certs\intermediate.cert.pem"}


<#
    For this section we need to generate the leaf certificate.
    Remove any arguments that prompt for a password. For the
    Certificate a password is not necessary. The password
    comes into play with the Trust Store and/or Key Store.
#>

&{openssl genrsa -out "$($globalVars.home)\ca\intermediate\private\obiwanjacobi.key.pem" 2048}

<#
    C = Country, ST = State or Province, O = Organization, OU = Organizational Unit, CN = Common Name
    Your common name is the uri that your Software will use and is expected by reciprocating applications.
    "/C=US,/ST=Kansas,/L=Kansas City,/O=McGee ECM Solutions,/OU=1099 Consulting,/CN=$($globalVars.compName2)"
#>
if($globalVars.useSubjectAltName -ne $true ) {
    Write-Host "Running without Subject Alternative Name."
    Write-Host "If you intended to run with Subject Alternative Names"
    Write-Host "update the useSubjectAltName to `$true."
    &{openssl req -batch -config "$($globalVars.home)\ca\intermediate\openssl_int.cfg" -key "$($globalVars.home)\ca\intermediate\private\$($globalVars.leafCertName).key.pem" -new -sha256 -subj "/C=$($globalVars.localMachineCountry)/ST=$($globalVars.leafState)/L=$($globalVars.leafLocale)/O=$($globalVars.leafOrganization)/OU=$($globalVars.leafOrganizationalUnit)/CN=$($globalVars.leafCN)" -out "$($globalVars.home)\ca\intermediate\csr\$($globalVars.leafCertName).csr.pem" -passin pass:contentcomposer}
		} else {
    Write-Host "Provided the Following subjectAltName:"
    Write-Host $($globalVars.leafSubjectAltName)
    &{openssl req -batch -config "$($globalVars.home)\ca\intermediate\openssl_int.cfg" -key "$($globalVars.home)\ca\intermediate\private\$($globalVars.leafCertName).key.pem" -new -sha256 -subj "/C=$($globalVars.localMachineCountry)/ST=$($globalVars.leafState)/L=$($globalVars.leafLocale)/O=$($globalVars.leafOrganization)/OU=$($globalVars.leafOrganizationalUnit)/CN=$($globalVars.leafCN)" -addext "$($globalVars.leafSubjectAltName)"-out "$($globalVars.home)\ca\intermediate\csr\$($globalVars.leafCertName).csr.pem" -passin pass:contentcomposer}
		}
    &{openssl ca -batch -config "$($globalVars.home)\ca\intermediate\openssl_int.cfg" -extensions blanket_cert -days 3650 -notext -in "$($globalVars.home)\ca\intermediate\csr\$($globalVars.leafCertName).csr.pem" -passin pass:contentcomposer -out "$($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).cert.pem"}
    &{openssl x509 -noout -text -in "$($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).cert.pem"}
	
	# It is necessary for servers that are Windows 2012 to have Compatibility otherwise, the certificate is inert.
	# This will need to be added for compatibility
	# -keypbe PBE-SHA1-3DES -certpbe PBE-SHA1-3DES
	<#
	Table of Contents for Versions.
		Windows 11: Major Version 10
		Windows Server 2022: Major Version 10
		Windows Server 2019: Major Version 10
		Windows Server 2016: Major Version 10
		Windows Server 2012: Major Version 6
		Windows Server 2008: Major Version 6
		Windows Server 2003: Major Version 5
		Windows Server 2000: Major Version 5
	#>
	
	if($majorVersion -lt 10 ) {
		&{openssl pkcs12 -export -inkey "$($globalVars.home)\ca\intermediate\private\$($globalVars.leafCertName).key.pem" -in "$($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).cert.pem" -keypbe PBE-SHA1-3DES -certpbe PBE-SHA1-3DES -certfile "$($globalVars.home)\ca\intermediate\certs\ca-chain.cert.pem" -name "$($globalVars.leafCertName)" -out "$($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).pfx" -passout pass:contentcomposer}
	} else {
		&{openssl pkcs12 -export -inkey "$($globalVars.home)\ca\intermediate\private\$($globalVars.leafCertName).key.pem" -in "$($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).cert.pem" -certfile "$($globalVars.home)\ca\intermediate\certs\ca-chain.cert.pem" -name "$($globalVars.leafCertName)" -out "$($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).pfx" -passout pass:contentcomposer}
	}
	
    $leafPfx = (Get-Item -Path $globalVars.home\ca\intermediate\certs\$($globalVars.leafCertName).pfx)

    # We need to make sure that keytool is available.
    $commmand = &{java -version}
    $commmand

    #if(!$command){
    if($command){
        keytool -importkeystore -srckeystore "$($leafPfx)" -storepass contentcomposer -destkeystore "$($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).jks" -deststoretype jks -deststorepass contentcomposer -destalias "$($globalVars.leafCertName)"
    } else {
        $env:Path += ";$($env:JAVA_HOME)\bin"
        keytool -importkeystore -srckeystore $leafPfx -storepass contentcomposer -destkeystore "$($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).jks" -deststoretype jks -deststorepass contentcomposer -destalias "$($globalVars.leafCertName)"
    }

    if($globalVars.importCertificateChain){

        # Importing the Certification Chain in order: Root CA Certificate, Intermediate CA Certificate, Leaf Certificate
        Import-Certificate -FilePath "$($globalVars.home)\ca\certs\ca.cert.pem" -CertStoreLocation "Cert:\LocalMachine\Root"
        Import-Certificate -FilePath "$($globalVars.home)\ca\intermediate\certs\intermediate.cert.pem" -CertStoreLocation "Cert:\LocalMachine\CA"
        Import-Certificate -FilePath "$($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).cert.pem" -CertStoreLocation "Cert:\LocalMachine\Root"
        
        # Microsoft Trust Store checking.
        # Root Certification Authorities.
        Set-Location -Path "Cert:\LocalMachine\Root"
        &{Get-ChildItem -Path . -Recurse}
        
        # Intermedation Certification Authorities.
        Set-Location -Path "Cert:\LocalMachine\CA"
        &{Get-ChildItem -Path . -Recurse}
        }
# Closing Bracket for line 566, including the else clause.

Write-Host "OpenSSL has the ability to test certificates"
Write-Host " therefore, it is possible with s_client"
Write-Host " and s_server commands. Each can only run"
Write-Host " within their own window. Because the terminal"
Write-Host " cursor will not advance for s_server."

Write-Host "For additional testing use the following commands:"

Write-Host "openssl verify -CAFile `"$($globalVars.home)\ca\intermediate\certs\ca-chain.cert.pem`" `"$($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).cert.pem`" "
<#
        OpenSSL Documentation:
            https://www.openssl.org/docs/man3.2/man1/openssl-s_server.html
            https://www.openssl.org/docs/man3.2/man1/openssl-s_client.html
#>
Write-Host "In a separate command window or powershell window; openssl s_server -port 8400 -verify 0 -chainCApath `"$($globalVars.home)\certificates\CAs`" -status_verbose"
Write-Host "In a separate command window or powershell window; openssl s_server -port 8400 -verify 0 -CAfile `"$($globalVars.home)\certificates\CAs\truststore.pem`" -status_verbose "
Write-Host "In a separate command window or powershell window; openssl s_client -connect localhost:8400 -CAfile `"$($globalVars.home)\certificates\CAs\truststore.pem`" -cert `"$($globalVars.home)\ca\intermediate\certs\$($globalVars.leafCertName).cert.pem`"-status_verbose"
}

<#
    Recommendations are in line with Google's Recommendations as of 2024-03-22

    OpenSSL Ciphers TLSv1.2 (un-filtered for recommendations):
        TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:DHE-RSA-AES256-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES256-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES128-SHA:DHE-RSA-AES128-SHA:RSA-PSK-AES256-GCM-SHA384:DHE-PSK-AES256-GCM-SHA384:RSA-PSK-CHACHA20-POLY1305:DHE-PSK-CHACHA20-POLY1305:ECDHE-PSK-CHACHA20-POLY1305:AES256-GCM-SHA384:PSK-AES256-GCM-SHA384:PSK-CHACHA20-POLY1305:RSA-PSK-AES128-GCM-SHA256:DHE-PSK-AES128-GCM-SHA256:AES128-GCM-SHA256:PSK-AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:ECDHE-PSK-AES256-CBC-SHA384:ECDHE-PSK-AES256-CBC-SHA:SRP-RSA-AES-256-CBC-SHA:SRP-AES-256-CBC-SHA:RSA-PSK-AES256-CBC-SHA384:DHE-PSK-AES256-CBC-SHA384:RSA-PSK-AES256-CBC-SHA:DHE-PSK-AES256-CBC-SHA:AES256-SHA:PSK-AES256-CBC-SHA384:PSK-AES256-CBC-SHA:ECDHE-PSK-AES128-CBC-SHA256:ECDHE-PSK-AES128-CBC-SHA:SRP-RSA-AES-128-CBC-SHA:SRP-AES-128-CBC-SHA:RSA-PSK-AES128-CBC-SHA256:DHE-PSK-AES128-CBC-SHA256:RSA-PSK-AES128-CBC-SHA:DHE-PSK-AES128-CBC-SHA:AES128-SHA:PSK-AES128-CBC-SHA256:PSK-AES128-CBC-SHA

    OpenSSL Ciphers TLSv1.2 (filtered for recommendations):
        TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256:TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256:TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256:TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256:TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384:TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384:TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA:TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA:TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA:TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA:TLS_RSA_WITH_AES_128_GCM_SHA256:TLS_RSA_WITH_AES_256_GCM_SHA384:TLS_RSA_WITH_AES_128_CBC_SHA:TLS_RSA_WITH_AES_256_CBC_SHA:TLS_RSA_WITH_3DES_EDE_CBC_SHA

    Openssl Ciphers TLSv1.3 (un-filtered for recommendations):
        TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:DHE-RSA-AES256-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES256-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES128-SHA:DHE-RSA-AES128-SHA:RSA-PSK-AES256-GCM-SHA384:DHE-PSK-AES256-GCM-SHA384:RSA-PSK-CHACHA20-POLY1305:DHE-PSK-CHACHA20-POLY1305:ECDHE-PSK-CHACHA20-POLY1305:AES256-GCM-SHA384:PSK-AES256-GCM-SHA384:PSK-CHACHA20-POLY1305:RSA-PSK-AES128-GCM-SHA256:DHE-PSK-AES128-GCM-SHA256:AES128-GCM-SHA256:PSK-AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:ECDHE-PSK-AES256-CBC-SHA384:ECDHE-PSK-AES256-CBC-SHA:SRP-RSA-AES-256-CBC-SHA:SRP-AES-256-CBC-SHA:RSA-PSK-AES256-CBC-SHA384:DHE-PSK-AES256-CBC-SHA384:RSA-PSK-AES256-CBC-SHA:DHE-PSK-AES256-CBC-SHA:AES256-SHA:PSK-AES256-CBC-SHA384:PSK-AES256-CBC-SHA:ECDHE-PSK-AES128-CBC-SHA256:ECDHE-PSK-AES128-CBC-SHA:SRP-RSA-AES-128-CBC-SHA:SRP-AES-128-CBC-SHA:RSA-PSK-AES128-CBC-SHA256:DHE-PSK-AES128-CBC-SHA256:RSA-PSK-AES128-CBC-SHA:DHE-PSK-AES128-CBC-SHA:AES128-SHA:PSK-AES128-CBC-SHA256:PSK-AES128-CBC-SHA
    
    OpenSSL Ciphers TLSv1.3 (filtered for recommendations):
        TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256:TLS_AES_128_CCM_8_SHA256:TLS_AES_128_CCM_SHA256
        
        # The last two Ciphers do not appear in the list above. Therfore, the latter has them removed.
        # OpenSSL 3.2 limitations
        TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256

    Author Notes:
        The OpenSSL Ciphers are necessary for SSLHostConfig configurations within Apache Tomcat Foundation server.xml. In order to skip having to translate with OpenSSL the Apache Tomcat Ciphers into OpenSSL Ciphers. By 2024 most software is at minimum TLSv1.2 and if it is not then an exception needs to be made with the expectation that it will be
        remedied in a future build.
        The Cipher exception does not apply to BI. Unless there is a way to directly control the Ciphers without breaking it in the process. Proceed with Caution when making
            changes to a BI environment post-TLS securing.
#>