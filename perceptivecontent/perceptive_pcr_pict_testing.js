/*

    Execution Method:
        This script is designed to be run as a... action.
*/

#if defined(imagenowDir6)
    #include "$IMAGENOWDIR6$/script/STL/packages/Logging/iScriptDebug.js";
    #include "$IMAGENOWDIR6$/script/STL/packages/System/generateUniqueID.js";
#else
    #include "../script/STL/packages/Logging/iScriptDebug.js";
    #include "../script/STL/packages/System/generateUniqueID.js";
#endif

// Uncomment to allow DB Access #link <SEDBC>

var DRY_RUN = true; // true - run script in dry run mode. This will give you a simulated output of your iScript.
var LOG_TO_FILE = true; //false - log to stdout, if ran by intool, true - log to inserver#/log/ directory.
var DEBUG_LEVEL = 5; // 0 - Off/Criticals, 5 - verbose
var SPLIT_LOG_BY_THREAD = true; //set to true in high volume scripts when multiple worker threads are used (workflow, external messaging agent, integration server)
var MAX_LOG_FILE_SIZE = 1; // Maximum size of log file (in MB) before a new one will be created.

var ERROR_QUEUE = "PES Error Queue"; //Workflow queue where error documents will be routed.
var COMPLETE_QUEUE = "PES Indexed Document"; //Workflow Queue where completed documents will be routed.

// We will need to look at the Document's CPs and then add them in a loop.
var EXECUTION_METHODS = ['Workflow','INTOOL']
    debug;

function main ()
{
    try {
        debug = new iScriptDebug("USE SCRIPT FILE NAME",LOG_TO_FILE,DEBUG_LEVEL,undefined,{splitLogByThreadID:SPLIT_LOG_BY_THREAD,maxLog});
        debug.showINowInfo("INFO");
        debug.logAlways("INFO","Script Version: $Id$\n");
        debug.logAlways("INFO","Script Name: %s.\n",_argv[0]);

        d = printDate()
        // We need to establish our HTTP API Call for Perceptive Enterprise Search
        var client = new HttpClient("https://pcr_server:port")
        var request = new HttpRequest("POST","/rs/wsdl?");
        var headers = [
            "Content-Type"="application/xml",
            "Accept"="application/xml"
            // There are more headers here, they are just not present.
            ];
        /*
            For Testing purposes this will be static. In the future we can grab and modify example transcripts.
            Our Transformation should be handled by the channel and not need additional modifications.
        */
        body = "<?xml version="+'"'+1.0+'"'+" encoding="+'"'+"UTF-8"+'"'+"?>"
+"<bwout:transcript xmlns:bwout="+'"'+"http://www.hyland.com/transcript/xml/bwout"+'"'+" xmlns="+'"'+"http://www.hyland.com/transcript/xml/common"+'"'+" xmlns:xsi="+'"'+"http://www.w3.org/2001/XMLSchema-instance"+'"'+" xsi:noNamespaceSchemaLocation="+'"'+"bwtrans.xsd"+'">'
+"<fileInfo xmlns="+'""'+">321Z45T_00119EQLT00000F.tif</fileInfo>"
+"<type xmlns="+'""'+" classname="+'"'+"College"+'"'+">University</type>"
+"<issueDate xmlns="+'""'+">2020-03-30</issueDate>"
+"<InvalidReasonCode xmlns="+'""'+">0</InvalidReasonCode>"
+"<InvalidReason xmlns="+'""'+">NONE</InvalidReason>"
+"<URN xmlns="+'""'+" xsi:nil="+'"'+"true"+'"'+" />"
+"<studentRecord xmlns="+'""'+">"
+"<streetAddress>123 Easy St</streetAddress>"
+"<applicantId>0000007</applicantId>"
+"<applicantSiteID>1</applicantSiteID>"
+"<city>Ocklawaha</city>"
+"<userField1 xsi:nil="+'"'+"true"+'"'+" />"
+"<userField2 xsi:nil="+"true"+'"'+" />"
+"<userField3 xsi:nil="+"true"+'"'+" />"
+"<userField4 xsi:nil="+"true"+'"'+" />"
+"<userField5 xsi:nil="+"true"+'"'+" />"
+"<dob>1989-09-16</dob>"
+"<firstName>Zeppelin</firstName>"
+"<lastName>Led</lastName>"
+"<middleName>Out</middleName>"
+"<phoneNumber>333-333-3333</phoneNumber>"
+"<ssn>333333333</ssn>"
+"<state>FL</state>"
+"<zip>33333</zip>"
+"</studentRecord>"
+"<customfields xmlns="+'""'+">"
+"<field1 xsi:nil="+'"'+"true"+'"'+" />"
+"<field10 xsi:nil="+'"'+"true"+'"'+" />"
+"<field2 xsi:nil="+'"'+"true"+'"'+" />"
+"<field3 xsi:nil="+'"'+"true"+'"'+" />"
+"<field4 xsi:nil="+'"'+"true"+'"'+" />"
+"<field5 xsi:nil="+'"'+"true"+'"'+" />"
+"<field6 xsi:nil="+'"'+"true"+'"'+" />"
+"<field7 xsi:nil="+'"'+"true"+'"'+" />"
+"<field8 xsi:nil="+'"'+"true"+'"'+" />"
+"<field9 xsi:nil="+'"'+"true"+'"'+" />"
+"</customfields>"
+"<universitySummary xmlns="+'""'+">"
+"<univcumulativeGPA>N/A</univcumulativeGPA>"
+"<degree>"
+"<awardDate>2019-08-08</awardDate>"
+"<major xsi:nil="+'"'+"true"+'"'+" />"
+"<program>ASSOCIATE IN ARTS</program>"
+"</degree>"
+"</universitySummary>"
+"<universityInstitutionalRecord xmlns="+'""'+">"
+"<act xsi:nil="+'"'+"true"+'"'+" />"
+"<address xsi:nil="+'"'+"true"+'"'+" />"
+"<ceeb xsi:nil="+'"'+"true"+'"'+" />"
+"<city>Miami</city>"
+"<fice>001111</fice>"
+"<institutionId>001111</institutionId>"
+"<issuingSchoolName>Eastern FL SC/Main</issuingSchoolName>"
+"<opeid xsi:nil="+'"'+"true"+'"'+" />"
+"<phoneNumber xsi:nil="+'"'+"true"+" />"
+"<institutionSiteID>1</institutionSiteID>"
+"<state>FL</state>"
+"<zip xsi:nil="+'"'+"true"+'"'+" />"
+"</universityInstitutionalRecord>"
+"<universityCourseRecords xmlns="+'""'+">"
+"<term>FALL 2016</term>"
+"<year xsi:nil="+'"'+"true"+'"'+" />"
+"<dateCompleted xsi:nil="+'"'+"true"+'"'+" />"
+"<course>"
+"<subject>SPN 1120</subject>"
+"<number>SPN 1120</number>"
+"<title>Spanish 1</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>C</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>4.00</creditsAttempted>"
+"<pointsEarned>8.00</pointsEarned>"
+"</course>"
+"<course>"
+"<subject>ENC 1101</subject>"
+"<number>ENC 1101</number>"
+"<title>Composition 1</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>C</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>3.00</creditsAttempted>"
+"<pointsEarned>6.00</pointsEarned>"
+"</course>"
+"<course>"
+"<subject>MAT 0057</subject>"
+"<number>MAT 0057</number>"
+"<title>Modularized Dev</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>S</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>3.00</creditsAttempted>"
+"<pointsEarned>0.00</pointsEarned>"
+"</course>"
+"<course>"
+"<subject>SPC 2608</subject>"
+"<number>SPC 2608</number>"
+"<title>Fundamentals of Worgs</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>B</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>3.00</creditsAttempted>"
+"<pointsEarned>9.00</pointsEarned>"
+"</course>"
+"</universityCourseRecords>"
+"<universityCourseRecords xmlns="+'""'+">"
+"<term>SPRING 2017</term>"
+"<year xsi:nil="+'"'+"true"+'"'+" />"
+"<dateCompleted xsi:nil="+'"'+"true"+'"'+" />"
+"<course>"
+"<subject>SPN 1121</subject>"
+"<number>SPN 1121</number>"
+"<title>Spanish 2</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>C</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>4.00</creditsAttempted>"
+"<pointsEarned>8.00</pointsEarned>"
+"</course>"
+"<course>"
+"<subject>MAT 0057</subject>"
+"<number>MAT 0057</number>"
+"<title>Modularized Dev</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>B</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>3.00</creditsAttempted>"
+"<pointsEarned>9.00</pointsEarned>"
+"</course>"
+"<course>"
+"<subject>BSC 1010C</subject>"
+"<number>BSC 1010C</number>"
+"<title>General Biology 1</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>C</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>4.00</creditsAttempted>"
+"<pointsEarned>8.00</pointsEarned>"
+"</course>"
+"</universityCourseRecords>"
+"<universityCourseRecords xmlns="+'""'+">"
+"<term>FALL 2017</term>"
+"<year xsi:nil="+'"'+"true"+'"'+" />"
+"<dateCompleted xsi:nil="+'"'+"true"+'"'+" />"
+"<course>"
+"<subject>PSY 2012</subject>"
+"<number>PSY 2012</number>"
+"<title>General Psychology 1</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>B</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>3.00</creditsAttempted>"
+"<pointsEarned>9.00</pointsEarned>"
+"</course>"
+"<course>"
+"<subject>MAT 1033</subject>"
+"<number>MAT 1033</number>"
+"<title>Intermediate Algebra</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>W</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>0.00</creditsAttempted>"
+"<pointsEarned>0.00</pointsEarned>"
+"</course>"
+"<course>"
+"<subject>BSC 2093 C</subject>"
+"<number>BSC 2093 C</number>"
+"<title>Human Anatomy</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>F</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>0.00</creditsAttempted>"
+"<pointsEarned>0.00</pointsEarned>"
+"</course>"
+"</universityCourseRecords>"
+"<universityCourseRecords xmlns="+'""'+">"
+"<term>SPRING 2018</term>"
+"<year xsi:nil="+'"'+"true"+'"'+" />"
+"<dateCompleted xsi:nil="+'"'+"true"+'"'+" />"
+"<course>"
+"<subject>BSC 2093 C</subject>"
+"<number>BSC 2093 C</number>"
+"<title>Human Anatomy</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>C</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>4.00</creditsAttempted>"
+"<pointsEarned>8.00</pointsEarned>"
+"</course>"
+"<course>"
+"<subject>BSC 2094 C</subject>"
+"<number>BSC 2094 C</number>"
+"<title>Human Anatomy and</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>W</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>0.00</creditsAttempted>"
+"<pointsEarned>0.00</pointsEarned>"
+"</course>"
+"<course>"
+"<subject>SYG 2000</subject>"
+"<number>SYG 2000</number>"
+"<title>Introduction to</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>C</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>3.00</creditsAttempted>"
+"<pointsEarned>6.00</pointsEarned>"
+"</course>"
+"</universityCourseRecords>"
+"<universityCourseRecords xmlns="+'""'+">"
+"<term>SUMMER 2018</term>"
+"<year xsi:nil="+'"'+"true"+'"'+" />"
+"<dateCompleted xsi:nil="+'"'+"true"+'"'+" />"
+"<course>"
+"<subject>HUN 1201</subject>"
+"<number>HUN 1201</number>"
+"<title>Essentials of Nutrition</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>B</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>3.00</creditsAttempted>"
+"<pointsEarned>9.00</pointsEarned>"
+"</course>"
+"<course>"
+"<subject>MAT 1033</subject>"
+"<number>MAT 1033</number>"
+"<title>Intermediate Algebra</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>C</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>3.00</creditsAttempted>"
+"<pointsEarned>6.00</pointsEarned>"
+"</course>"
+"</universityCourseRecords>"
+"<universityCourseRecords xmlns="+'""'+">"
+"<term>FALL 2018</term>"
+"<year xsi:nil="+'"'+"true"+'"'+" />"
+"<dateCompleted xsi:nil="+'"'+"true"+'"'+" />"
+"<course>"
+"<subject>BSC 2094</subject>"
+"<number>BSC 2094</number>"
+"<title>Human Anatomy and Physi</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>B</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>4.00</creditsAttempted>"
+"<pointsEarned>12.00</pointsEarned>"
+"</course>"
+"<course>"
+"<subject>CHM 1025</subject>"
+"<number>CHM 1025</number>"
+"<title>College Chemistry</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>B</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>3.00</creditsAttempted>"
+"<pointsEarned>9.00</pointsEarned>"
+"</course>"
+"<course>"
+"<subject>CHM 1025</subject>"
+"<number>CHM 1025</number>"
+"<title>College Chemistry Labor</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+"<scoreLetter>A</scoreLetter>"
+"<scorePoint xsi:nil="+'"'+"true"+'"'+" />"
+"<creditsAttempted>1.00</creditsAttempted>"
+"<pointsEarned>4.00</pointsEarned>"
+"</course>"
+"<course>"
+"<subject>ENC 1102</subject>"
+"<number>ENC 1102</number>"
+"<title>Composition 2</title>"
+"<repeat xsi:nil="+'"'+"true"+'"'+" />"
+<scoreLetter>A</scoreLetter>
+<scorePoint xsi:nil="true" />
+<creditsAttempted>3.00</creditsAttempted>
+<pointsEarned>12.00</pointsEarned>
+</course>
+</universityCourseRecords>
+<universityCourseRecords xmlns="">
+<term>SPRING 2019</term>
+<year xsi:nil="true" />
+<dateCompleted xsi:nil="true" />
+<course>
+<subject>REL 2300</subject>
+<number>REL 2300</number>
+<title>World Religions</title>
+<repeat xsi:nil="true" />
+<scoreLetter>B</scoreLetter>
+<scorePoint xsi:nil="true" />
+<creditsAttempted>3.00</creditsAttempted>
+<pointsEarned>9.00</pointsEarned>
+</course>
+<course>
+<subject>MAC 1105</subject>
+<number>MAC 1105</number>
+<title>College Algebra</title>
+<repeat xsi:nil="true" />
+<scoreLetter>B</scoreLetter>
+<scorePoint xsi:nil="true" />
+<creditsAttempted>3.00</creditsAttempted>
+<pointsEarned>9.00</pointsEarned>
+</course>
+<course>
+<subject>HUM 1020</subject>
+<number>HUM 1020</number>
+<title>Introduction to the Hum</title>
+<repeat xsi:nil="true" />
+<scoreLetter>A</scoreLetter>
+<scorePoint xsi:nil="true" />
+<creditsAttempted>3.00</creditsAttempted>
+<pointsEarned>12.00</pointsEarned>
+</course>
+</universityCourseRecords>
+<universityCourseRecords xmlns="">
+<term>SUMMER 2019</term>
+<year xsi:nil="true" />
+<dateCompleted xsi:nil="true" />
+<course>
+<subject>ISS 2200</subject>
+<number>ISS 2200</number>
+<title>Intro to International</title>
+<repeat xsi:nil="true" />
+<scoreLetter>A</scoreLetter>
+<scorePoint xsi:nil="true" />
+<creditsAttempted>3.00</creditsAttempted>
+<pointsEarned>12.00</pointsEarned>
+</course>
+<course>
+<subject>MAC 1140</subject>
+<number>MAC 1140</number>
+<title>Precalculus Algebra</title>
+<repeat xsi:nil="true" />
+<scoreLetter>C</scoreLetter>
+<scorePoint xsi:nil="true" />
+<creditsAttempted>3.00</creditsAttempted>
+<pointsEarned>6.00</pointsEarned>
+</course>
+</universityCourseRecords>
+<universityCourseRecords xmlns="">
+<term>FALL 2019</term>
+<year xsi:nil="true" />
+<dateCompleted xsi:nil="true" />
+<course>
+<subject>MCB 2010</subject>
+<number>MCB 2010</number>
+<title>Microbiology for Hlth S</title>
+<repeat xsi:nil="true" />
+<scoreLetter>A</scoreLetter>
+<scorePoint xsi:nil="true" />
+<creditsAttempted>4.00</creditsAttempted>
+<pointsEarned>16.00</pointsEarned>
+</course>
+<course>
+<subject>HSC 1000</subject>
+<number>HSC 1000</number>
+<title>Introduction to Healthc</title>
+<repeat xsi:nil="true" />
+<scoreLetter>A</scoreLetter>
+<scorePoint xsi:nil="true" />
+<creditsAttempted>3.00</creditsAttempted>
+<pointsEarned>12.00</pointsEarned>
+</course>
+</universityCourseRecords>
+<universityCourseRecords xmlns="">
+<term>SPRING 2020</term>
+<year xsi:nil="true" />
+<dateCompleted xsi:nil="true" />
+<course>
+<subject>HSA 3502</subject>
+<number>HSA 3502</number>
+<title>Healthcare Risk Managem</title>
+<repeat xsi:nil="true" />
+<scoreLetter>W</scoreLetter>
+<scorePoint xsi:nil="true" />
+<creditsAttempted>0.00</creditsAttempted>
+<pointsEarned>0.00</pointsEarned>
+</course>
+<course>
+<subject>ENC 3241</subject>
+<number>ENC 3241</number>
+<title>Technical Writing for P</title>
+<repeat xsi:nil="true" />
+<scoreLetter>W</scoreLetter>
+<scorePoint xsi:nil="true" />
+<creditsAttempted>0.00</creditsAttempted>
+<pointsEarned>0.00</pointsEarned>
+</course>
+</universityCourseRecords>
+</bwout:transcript>
        //headers.push(props);
        
        request.addHeaders(headers);

            /*
            
            We need to process each page and send them over as an application/octet-stream.

            */

        request.setBodyAsFile(bodyObject,"application/octet-stream");

        // We need to supply all the relevant metadata; Drawer, Field 1, Field 2, Field 3, Field 4, Field 5, Doc Type, 
    } catch {
        // In the event an error arises.

    } finally {
        /*
        Do this here
        */

    }

}

function printDate() {
    const temp = new Date();
    const pad = (i) => (i < 10) ? "0" + i : "" + i;
    
    // .LINK
    // https://stackoverflow.com/questions/5914020/javascript-date-to-string

    return temp.getFullYear() +
      pad(1 + temp.getMonth()) +
      pad(temp.getDate()) + "T" +
      pad(temp.getHours()) +
      pad(temp.getMinutes()) +
      pad(temp.getSeconds()) + "Z";
  }