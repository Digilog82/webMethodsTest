var Pass1 = "";
var changePass = false;
var changePassEdit = false;
var CMGRPROP = { minimumPoolSize : "1", maximumPoolSize :"10", poolIncrementSize : "1", blockingTimeout : "1000", expireTimeout : "1000", startupRetryCount : "0", startupBackoffSecs : "10", heartBeatInterval : "0"};

// LG TRAX 1-I49V9
// Add array var for multiple passwords
var pwdLabels = new Array(" "," "," "," "," "," "," "," "," "," "," "," "," "," ");

var adapterConnPropValidator = function(theForm){return "";};															 
function xl(text)
{
    var out = "";
    var t = "";
    for(var i = 0;i < text.length;i++){
	t = text.substring(i, i+1);
	if(t == "<"){
	    out += "&lt;";
	}
	else if(t == ">"){
	    out += "&gt;";
	}
	else{
	    out += t;
	}
    }	
    document.write(out);
}


function isNumber(num)
{
    num = num.toString();
    if (num.length == 0) {
        return false;
    }

    for (var i = 0; i < num.length; i++) {
        var x = num.substring(i, i + 1);
        // LG TRAX 1-NWQZN - Fix to allow negative numbers
        // to be validated....Before all neg numbers errored
        if (i == 0 && x == "-") {
            if(num.length == 1) {
                return false;
            }
        }
        else if (x < "0" || x > "9") {
            return false;
        }
    }

    return true;
}

function validateForm(theForm)
{
    var returnValue = 0;
    var errors = "Error:";

    if (theForm.elements['resourceFolderName'] != null && theForm.elements['resourceFolderName'].value.length == 0) {
        returnValue = -1;
        errors += "Folder Name required for connection resource.\n";
    }

    if (theForm.elements['resourceName'] != null && theForm.elements['resourceName'].value.length == 0) {
        returnValue = -1;
        errors += "Connection Name required for connection resource.\n";
    }

	var errMsg = adapterConnPropValidator(theForm);
	if(errMsg.length > 0)
	{
		returnValue = -1;
		errors += errMsg;
	}											
    var str = "";
    //str += "validating form " + theForm + "\n";

    for (i = 0; i < theForm.elements.length; ++i) {
        // password confirmation fields start with "PWD"
        if (theForm.elements[i].name.substring(0, 3) == "PWD") {
            var sname = theForm.elements[i].name.substring(3);
            var dotpos = sname.indexOf('.', 1);

            str += "dotpos = " + dotpos + "\n";
            str += "theForm.elements[" + sname + "].value = " + theForm.elements[sname].value + "\n";
            str += "theForm.elements[" + i + "].value = " + theForm.elements[i].value + "\n";

            if (theForm.elements[i].value.length == 0 && theForm.elements[sname].value.length > 0) {
                returnValue = -1;
                errors += "Password for " + sname.substring(dotpos + 1) + " must be retyped for confirmation.\n";
            }
            else if (theForm.elements[sname].value != theForm.elements[i].value) {
                returnValue = -1;
                errors += "The passwords entered for " + sname.substring(dotpos + 1) + " do not match.\n";
            }
        }
    }

    // LG TRAX MHXUU
    // Validate the values for retryLimit and retryBackoffTimeout 
    // Check that they are >= 0
     if(theForm.elements["retryLimit"] != null){
	if(!isNumber(theForm.elements["retryLimit"].value)){
	    returnValue = -1;
            errors += "Retry Limit must be a number >=0\n";
        }
	else if(parseInt(theForm.elements["retryLimit"].value) < 0) {
	    returnValue = -1;
            errors += "Retry Limit value must be >=0\n";
        }
    }
    if(theForm.elements["retryBackoffTimeout"] != null){
	if(!isNumber(theForm.elements["retryBackoffTimeout"].value)){
	    returnValue = -1;
            errors += "Retry Backoff Timeout must be a number >=0\n";
        }
	else if(parseInt(theForm.elements["retryBackoffTimeout"].value) < 0) {
	    returnValue = -1;
            errors += "Retry Backoff Timeout value must be >=0\n";
        }
    }

    // SAA TRAX NA9QH
    // Validate the values for startupRetryCount and startupBackoffSecs 
    // Check that they are >= 0
//     if(theForm.elements[".CMGRPROP.startupRetryCount"] != null){
//	if(!isNumber(theForm.elements[".CMGRPROP.startupRetryCount"].value)){
//	    returnValue = -1;
//            errors += "Startup Retry Count must be a number >=0\n";
//        }
//	else if(parseInt(theForm.elements[".CMGRPROP.startupRetryCount"].value) < 0) {
//	    returnValue = -1;
//            errors += "Startup Retry Count value must be >=0\n";
//        }
//    }
//    if(theForm.elements[".CMGRPROP.startupBackoffSecs"] != null){
//	if(!isNumber(theForm.elements[".CMGRPROP.startupBackoffSecs"].value)){
//	    returnValue = -1;
//            errors += "Startup Backoff Timeout must be a number >=0\n";
//        }
//	else if(parseInt(theForm.elements[".CMGRPROP.startupBackoffSecs"].value) < 0) {
//	    returnValue = -1;
//            errors += "Startup Backoff Timeout value must be >=0\n";
//        }
//    }
// End NA9QH
       
    // LG Debug Stuff
    //alert(str + "\n" + errors);
    //for (m = 0; m < theForm.elements.length; ++m) {
    //    str += "Form Elem = " + theForm.elements[m].name + " Value = " + theForm.elements[m].value + "\n";
    //}
    //alert(str);

    //  LG TRAX 1-MHXP3 
    //  Added check of the existence of ".poolable" element (Part of Connection Form)
    //  this validateForm is used with Listener Forms which have no connection pools
    if(theForm.elements[".CMGRPROP.poolable"] != null && theForm.elements[".CMGRPROP.poolable"].value == "true") {

        if (!isNumber(theForm.elements[".CMGRPROP.minimumPoolSize"].value)) {
            returnValue = -1;
            errors += "Minimum Pool Size must be a number >=0 when\n";
            errors += "Connection Pooling is enabled.\n";
        }
        else if (theForm.elements[".CMGRPROP.minimumPoolSize"].value < 0) {
            returnValue = -1;
            errors += "Minimum Pool Size must be a number >=0 when\n";
            errors += "Connection Pooling is enabled.\n";
        }

        if (!isNumber(theForm.elements[".CMGRPROP.maximumPoolSize"].value)) {
            returnValue = -1;
            errors += "Maximum Pool Size must be a number >=1 when\n";
            errors += "Connection Pooling is enabled.\n";
        }
        else if (parseInt(theForm.elements[".CMGRPROP.maximumPoolSize"].value) <= 0) {
            returnValue = -1;
            errors += "Maximum Pool Size must be a number >=1 when\n";
            errors += "Connection Pooling is enabled.\n";
        }
        else if (parseInt(theForm.elements[".CMGRPROP.minimumPoolSize"].value) > parseInt(theForm.elements[".CMGRPROP.maximumPoolSize"].value)) {
            returnValue = -1;
            errors += "Minimum Pool Size cannot be greater than \n";
            errors += "Maximum Pool Size.\n";
        }

        if (!isNumber(theForm.elements[".CMGRPROP.poolIncrementSize"].value)) {
            returnValue = -1;
            errors += "Pool Increment Size must be a number >=1 when\n";
            errors += "Connection Pooling is enabled.\n";
        }
        else {
            var maxPool = parseInt(theForm.elements[".CMGRPROP.maximumPoolSize"].value);
            var poolInc = parseInt(theForm.elements[".CMGRPROP.poolIncrementSize"].value);

            if (poolInc <= 0) {
                returnValue = -1;
                errors += "Pool Increment Size must be a number >=1 when\n";
                errors += "Connection Pooling is enabled.\n";
            }
            else if (maxPool > 0 && poolInc > maxPool) {
                returnValue = -1;
                errors += "Pool Increment Size must be a number <= Maximum Pool Size when\n";
                errors += "Connection Pooling is enabled.\n";
            }

        }

        if (!isNumber(theForm.elements[".CMGRPROP.blockingTimeout"].value)) {
            returnValue = -1;
            errors += "Please enter a valid blocking timeout (in msec) or -1 for no timeout.\n";
        }
        else if (parseInt(theForm.elements[".CMGRPROP.blockingTimeout"].value) < -1) {
            returnValue = -1;
            errors += "Please enter a valid blocking timeout (in msec) or -1 for no timeout.\n";
        }

        if (!isNumber(theForm.elements[".CMGRPROP.expireTimeout"].value)) {
            returnValue = -1;
            errors += "Please enter a valid expire timeout (in msec) or -1 for no timeout.\n";
        }
        else if (parseInt(theForm.elements[".CMGRPROP.expireTimeout"].value) < -1) {
            returnValue = -1;
            errors += "Please enter a valid expire timeout (in msec) or -1 for no timeout.\n";
        }
        
	if(!isNumber(theForm.elements[".CMGRPROP.startupRetryCount"].value)){
	    returnValue = -1;
            errors += "Startup Retry Count must be a number >=0\n";
        }
	else if(parseInt(theForm.elements[".CMGRPROP.startupRetryCount"].value) < 0) {
	    returnValue = -1;
            errors += "Startup Retry Count value must be >=0\n";
        }
        
	if(!isNumber(theForm.elements[".CMGRPROP.startupBackoffSecs"].value)){
	    returnValue = -1;
            errors += "Startup Backoff Timeout must be a number >=0\n";
        }
	else if(parseInt(theForm.elements[".CMGRPROP.startupBackoffSecs"].value) < 0) {
	    returnValue = -1;
            errors += "Startup Backoff Timeout value must be >=0\n";
        }
    
	if(!(theForm.elements[".CMGRPROP.heartBeatInterval"] === undefined)){	
		if(!isNumber(theForm.elements[".CMGRPROP.heartBeatInterval"].value)) {
        returnValue = -1;
            errors += "Heart Beat Interval must be a number >=0\n";
      
        }
		else if (theForm.elements[".CMGRPROP.heartBeatInterval"].value < 0) {
        returnValue = -1;
            errors += "Heart Beat Interval must be a number >=0\n";
    
        }
	}	
    }

    if (returnValue == -1) {
        alert(errors);
        return false;
    }
    else {
        return true;
    }
}

//  LG TRAX 1-I49V9 
//  Change this function to record the name of the CHANGED password element
//  in an array instead of a single flag to support multiple password fields
//  in forms for Connections and Listeners 
function passwordChanged(theForm, pwdElem) {
    //alert(pwdElem);
    for(i = 0;i < pwdLabels.length;i++){
	if(pwdLabels[i] == pwdElem){
		break;
	}
	else if(pwdLabels[i] == " "){
		pwdLabels[i] = pwdElem;
		break;
	}
    }
    if(i == pwdLabels.length){
	alert("Error: Too many password fields.");
        return false;
    }
    theForm.elements['passwordChange'].value = pwdLabels;
    // Old code when this was just a flag field
    //theForm.elements['passwordChange'].value = "true";
    return true;
}

function setField(field, val)
{
    if (val) {
        field.disabled = false;
    }
    else {
	//  LG TRAX 1-KLCNP 9-15-03
	// Change the value of the disabled display field
	// in the Connection Manager Properties from n/a to blank
        field.value = "";
        field.disabled = true;
        field.setAttribute("color", "red");
    }
}

function setEnabledFields(theForm, val)
{
    setField(theForm.elements[".CMGRPROP.minimumPoolSize"],   val);
    setField(theForm.elements[".CMGRPROP.maximumPoolSize"],   val);
    setField(theForm.elements[".CMGRPROP.poolIncrementSize"], val);
    setField(theForm.elements[".CMGRPROP.blockingTimeout"],   val);
    setField(theForm.elements[".CMGRPROP.expireTimeout"],     val);
    setField(theForm.elements[".CMGRPROP.startupRetryCount"],   val);
    setField(theForm.elements[".CMGRPROP.startupBackoffSecs"],     val);
	if(!(theForm.elements[".CMGRPROP.heartBeatInterval"] === undefined)){
		setField(theForm.elements[".CMGRPROP.heartBeatInterval"],     val);
	}	
		
}

function handlePoolableChange(theForm)
{
    var poolableobj = theForm.elements[".CMGRPROP.poolable"];
    var poolable = poolableobj.options[poolableobj.selectedIndex].value;

    if (poolable == "true") {
        theForm.elements[".CMGRPROP.minimumPoolSize"  ].value = CMGRPROP.minimumPoolSize;
        theForm.elements[".CMGRPROP.maximumPoolSize"  ].value = CMGRPROP.maximumPoolSize;
        theForm.elements[".CMGRPROP.poolIncrementSize"].value = CMGRPROP.poolIncrementSize;
        theForm.elements[".CMGRPROP.blockingTimeout"  ].value = CMGRPROP.blockingTimeout;
        theForm.elements[".CMGRPROP.expireTimeout"    ].value = CMGRPROP.expireTimeout;
        theForm.elements[".CMGRPROP.startupRetryCount"  ].value = CMGRPROP.startupRetryCount;
        theForm.elements[".CMGRPROP.startupBackoffSecs"    ].value = CMGRPROP.startupBackoffSecs;
		if(!(theForm.elements[".CMGRPROP.heartBeatInterval"] === undefined)){
		 theForm.elements[".CMGRPROP.heartBeatInterval"].value = CMGRPROP.heartBeatInterval;
	   }
        setEnabledFields(theForm, true);
    }
    else if (poolable == "false") {
        CMGRPROP.minimumPoolSize   = theForm.elements[".CMGRPROP.minimumPoolSize"  ].value;
        CMGRPROP.maximumPoolSize   = theForm.elements[".CMGRPROP.maximumPoolSize"  ].value;
        CMGRPROP.poolIncrementSize = theForm.elements[".CMGRPROP.poolIncrementSize"].value;
        CMGRPROP.blockingTimeout   = theForm.elements[".CMGRPROP.blockingTimeout"  ].value;
        CMGRPROP.expireTimeout     = theForm.elements[".CMGRPROP.expireTimeout"    ].value;
        CMGRPROP.startupRetryCount   = theForm.elements[".CMGRPROP.startupRetryCount"  ].value;
        CMGRPROP.startupBackoffSecs     = theForm.elements[".CMGRPROP.startupBackoffSecs"    ].value;
		if(!(theForm.elements[".CMGRPROP.heartBeatInterval"] === undefined)){
			CMGRPROP.heartBeatInterval     = theForm.elements[".CMGRPROP.heartBeatInterval"    ].value;
		}
        setEnabledFields(theForm, false);
    }
}

function testConnection(dspPage)
{					
	var htmlform = document.forms["form"];				
	validateForm(htmlform);				
	htmlform.setAttribute("action", dspPage);
	document.forms["form"]["test"].value = "true";
	return true;
}		
function testCompleted()
{
	document.forms["form"]["test"].value = "completed";
}

