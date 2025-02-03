/*

    Execution Method:
        This script is designed to be run as a... action.
        Missing original comment block.
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
        // check script execution (Workflow, Intool, EM)
        var wfItem = INWfItem.get(currentWFItem.id);
        
        //get the Perceptive Content Document Using the Workflow Item to find the DOCUMENT_ID which is equivalent to OBJECT_ID
        var doc = new INDocument(wfItem.objectId);

        //get the INDocument bBject Info of the Content Document (index keys field 1-5, drawer, document type, etc.)
        if (!doc.getInfo()){
            if(!routeItem(wfItem,ERROR_QUEUE,"Failed to retrieve document info.")){
                debug.log("ERROR","Failed to route Workflow Item [%s] to queue [%s].\n",wfItem.id,COMPLETE_QUEUE);
                return false;
            }
        }

        var props = doc.getCustomProperties()
        
        // We need to grab all the document information


        d = printDate()
        // We need to establish our HTTP API Call for Perceptive Enterprise Search
        var client = new HttpClient("https://pes_server:port/api");
        var request = new HttpRequest("POST","https://pes_server:port/api");
        var headers = [
            "user"="username",
            "password"="password",
            "Content-Type"="application/octet-stream",
            "Accept"="application/xml",
            "ocr"="true", // This must be set for the Document to be OCR'd upon submission.
            "collection"="Perceptive Content 7.x",
            "index"="Default",
            "action"="add",
            "filename"=doc.workingName,
            "last-modified"=d,
            "drawer"=doc.drawer,
            "field1"=doc.field1,
            "field2"=doc.field2,
            "field3"=doc.field3,
            "field4"=doc.field4,
            "field5"=doc.field5,
            "doctype"=doc.type, // may be doc.type or doc.docType
            "document-notes"=doc.keywords
            // There are more headers here, they are just not present.
            ];
            if (props)
        {
            for (var i=0; i<props.length; i++)
            {
                var docProps = [
                    props[i].name=props[i].value
                ]
                headers.push(docProps);
            }
        };
        
        request.addHeaders(headers);

            /*
            
            We need to process each page and send them over as an application/octet-stream.

            */

        request.setBodyAsFile(bodyObject,"application/octet-stream");
        var response = client.sendRequest(request);

        var responseHeaders = response.getHeaders();
        var statusCode = response.getStatusCode();

            if(statusCode != 200)
            {

            } else {

            };

        debug.logAlways("INFO","The following status code was received: %s \n",statusCode);
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
    
    // .LINK - Powershell Notation.
    // https://stackoverflow.com/questions/5914020/javascript-date-to-string

    return temp.getFullYear() +
      pad(1 + temp.getMonth()) +
      pad(temp.getDate()) + "T" +
      pad(temp.getHours()) +
      pad(temp.getMinutes()) +
      pad(temp.getSeconds()) + "Z";
  }