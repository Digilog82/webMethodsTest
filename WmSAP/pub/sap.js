var CPROP = { programId : "", gatewayHost :"", gatewayService : "", repositoryServer : ""};

function setField(field, val)
{
    if (val) {
        field.disabled = false;
    }
    else {
        field.disabled = true;
        field.setAttribute("color", "red");
    }
}

// Local, called by setExternalRFCServerFields( theForm, val)
function setFieldEmptyIfDisabled(field, val)
{
    if (val) {
        field.disabled = false;
    }
    else {
		field.value = "";
        field.disabled = true;
        field.setAttribute("color", "red");
    }
}

// Enabling/disabling of the RFC Connection attributes depending on the current state attributes
function init()
{
    handleLoadBalancingChange( document.forms[0]);
    handleConnectionTypeChange( document.forms[0]);
    handleSNCChange( document.forms[0]);
    handlePoolableChange( document.forms[0]);
}

// Enabling/disabling of the RFC Listener attributes depending on the current state attributes
function init1()
{
    handleSNCChange1( document.forms[0]);
	handleHighAvailabilityChange( document.forms[0]);
}

// Initial enabling of the RFC Connection attributes
// IMPORTANT: This avoids null values which would lead to ART runtime errors
function enableAll( theForm)
{
    setField(theForm.elements[".CPROP.logonGroup"]          , true);
    setField(theForm.elements[".CPROP.messageServerHost"]   , true);
    setField(theForm.elements[".CPROP.messageServerService"], true);
    setField(theForm.elements[".CPROP.systemId"]            , true);
    setField(theForm.elements[".CPROP.appServerHost"]       , true);
    setField(theForm.elements[".CPROP.systemNumber"]        , true);
    setField(theForm.elements[".CPROP.programId"]           , true);
    setField(theForm.elements[".CPROP.gatewayHost"]         , true);
    setField(theForm.elements[".CPROP.gatewayService"]      , true);
    setField(theForm.elements[".CPROP.repositoryServer"]    , true);
    setField(theForm.elements[".CPROP.sncQualityOfService"] , true);
    setField(theForm.elements[".CPROP.sncMyName"]           , true);
    setField(theForm.elements[".CPROP.sncPartnerName"]      , true);
    setField(theForm.elements[".CPROP.sncAuthentication"]	, true);

    setField(theForm.elements[".CMGRPROP.poolable"]	        , true);
}

// Initial enabling of the RFC Listener attributes
// IMPORTANT: This avoid nulls values which would lead to ART runtime errors
function enableAll1( theForm)
{
	setField(theForm.elements[".CPROP.gatewayHost"]			, true);
	setField(theForm.elements[".CPROP.gatewayService"]		, true);
	setField(theForm.elements[".CPROP.messageServerHost"]	, true);
	setField(theForm.elements[".CPROP.messageServerService"], true);
	setField(theForm.elements[".CPROP.systemId"]			, true);
	setField(theForm.elements[".CPROP.sncQualityOfService"] , true);
	setField(theForm.elements[".CPROP.sncMyName"]			, true);
	setField(theForm.elements[".CPROP.authService"]			, true);
}


function setLoadBalancingFields(theForm, val)
{
    setField(theForm.elements[".CPROP.logonGroup"]          , val);
    setField(theForm.elements[".CPROP.messageServerHost"]   , val);
	setField(theForm.elements[".CPROP.messageServerService"], val);
    setField(theForm.elements[".CPROP.systemId"]            , val);
    setField(theForm.elements[".CPROP.appServerHost"]       , !val);
    setField(theForm.elements[".CPROP.systemNumber"]        , !val);
}

function handleLoadBalancingChange(theForm)
{
    var optionobj = theForm.elements[".CPROP.loadBalancing"];
    var option = optionobj.options[optionobj.selectedIndex].value;

    if (option == "On") {
        setLoadBalancingFields(theForm, true);
    }
    else if (option == "Off") {
        setLoadBalancingFields(theForm, false);
    }
}

// Local, called by handleConnectionTypeChange( theForm)
function setExternalRFCServerFields( theForm, val)
{
    setFieldEmptyIfDisabled(theForm.elements[".CPROP.programId"]           , val);
    setFieldEmptyIfDisabled(theForm.elements[".CPROP.gatewayHost"]         , val);
    setFieldEmptyIfDisabled(theForm.elements[".CPROP.gatewayService"]      , val);
    setFieldEmptyIfDisabled(theForm.elements[".CPROP.repositoryServer"]    , val);
}

// Called by RFC connection dsps
// The name is misleading: this is about External RFC Server properties
function handleConnectionTypeChange( theForm)
{
    var optionobj = theForm.elements[".CPROP.connectionType"];
    var option = optionobj.options[optionobj.selectedIndex].value;

    if (option == "Yes") {
		theForm.elements[".CPROP.programId"  ].value = CPROP.programId;
        theForm.elements[".CPROP.gatewayHost"  ].value = CPROP.gatewayHost;
        theForm.elements[".CPROP.gatewayService"].value = CPROP.gatewayService;
        theForm.elements[".CPROP.repositoryServer"  ].value = CPROP.repositoryServer;
		
        setExternalRFCServerFields( theForm, true);
    }
    else if (option == "No") {
		CPROP.programId = theForm.elements[".CPROP.programId"  ].value;
		CPROP.gatewayHost = theForm.elements[".CPROP.gatewayHost"  ].value;
		CPROP.gatewayService = theForm.elements[".CPROP.gatewayService"  ].value;
		CPROP.repositoryServer = theForm.elements[".CPROP.repositoryServer"  ].value;
		
        setExternalRFCServerFields( theForm, false);
    }
}


function enablePoolFields( theForm, val)
{
    setField( theForm.elements[".CMGRPROP.minimumPoolSize"],   val);
    setField( theForm.elements[".CMGRPROP.maximumPoolSize"],   val);
    setField( theForm.elements[".CMGRPROP.poolIncrementSize"], val);
    setField( theForm.elements[".CMGRPROP.blockingTimeout"],   val);
    setField( theForm.elements[".CMGRPROP.expireTimeout"],     val);

    if (val == true)
    {
         if (theForm.elements[".CMGRPROP.minimumPoolSize"].value == "")
             theForm.elements[".CMGRPROP.minimumPoolSize"].value = "1";
         if (theForm.elements[".CMGRPROP.maximumPoolSize"].value == "")
             theForm.elements[".CMGRPROP.maximumPoolSize"].value = "10";
         if (theForm.elements[".CMGRPROP.poolIncrementSize"].value == "")
             theForm.elements[".CMGRPROP.poolIncrementSize"].value = "1";
         if (theForm.elements[".CMGRPROP.blockingTimeout"].value == "")
             theForm.elements[".CMGRPROP.blockingTimeout"].value = "1000";
         if (theForm.elements[".CMGRPROP.expireTimeout"].value == "")
             theForm.elements[".CMGRPROP.expireTimeout"].value = "1000";
    }

    if (theForm.elements[".CMGRPROP.startupRetryCount"].value == "")
        theForm.elements[".CMGRPROP.startupRetryCount"].value = "0";
    if (theForm.elements[".CMGRPROP.startupBackoffSecs"].value == "")
        theForm.elements[".CMGRPROP.startupBackoffSecs"].value = "10";
}


function handlePoolableChange( theForm)
{
    var poolableobj = theForm.elements[".CMGRPROP.poolable"];
    var poolable = poolableobj.options[poolableobj.selectedIndex].value;

    if (poolable == "true")
    {
        enablePoolFields( theForm, true);
    }
    else if (poolable == "false")
    {
        enablePoolFields( theForm, false);
    }
}


function setPoolFields( theForm, val)
{
    setField( theForm.elements[".CMGRPROP.poolable"], val);

    if (val == false)
    {
        theForm.elements[".CMGRPROP.poolable"].value = "false";
        handlePoolableChange( theForm);
    }
}


function setSNCFields( theForm, val)
{
    setField(theForm.elements[".CPROP.sncQualityOfService"] , val);
    setField(theForm.elements[".CPROP.sncAuthentication"]	, val);
    setField(theForm.elements[".CPROP.sncMyName"]           , val);
    setField(theForm.elements[".CPROP.sncPartnerName"]      , val);
}


function handleSNCChange( theForm)
{
    var optionobj = theForm.elements[".CPROP.sncMode"];
    var option = optionobj.options[optionobj.selectedIndex].value;

    if (option == "Yes")
    {
        setSNCFields( theForm, true);
    }
    else if (option == "No")
    {
        setSNCFields( theForm, false);
    }
}

// Local, called by handleSNCChange1( theForm) for SNC-related RFC CListener properties
function setSNCFields1( theForm, val)
{
    setField(theForm.elements[".CPROP.sncQualityOfService"] , val);
//  setField(theForm.elements[".CPROP.sncAuthentication"]	, val);	// Not used by RFC CListeners
    setField(theForm.elements[".CPROP.sncMyName"]           , val);
    setField(theForm.elements[".CPROP.authService"]         , val);
}

// Called by RFC Listener dsps and init1() to handle SNC-related RFC CListener properties 
function handleSNCChange1( theForm)
{
    var optionobj = theForm.elements[".CPROP.sncMode"];
    var option = optionobj.options[optionobj.selectedIndex].value;

    if (option == "Yes") {
        setSNCFields1( theForm, true);
    }
    else if (option == "No") {
        setSNCFields1( theForm, false);
    }
}

// Local, called by handleHighAvailabilityChange( theForm) for HA-related RFC CConnection properties
function setHighAvailabilityFields( theForm, val)
{
    setField( theForm.elements[".CPROP.messageServerHost"]    , val);
    setField( theForm.elements[".CPROP.messageServerService"] , val);
    setField( theForm.elements[".CPROP.systemId"]             , val);
    setField( theForm.elements[".CPROP.gatewayHost"]          , !val);
    setField( theForm.elements[".CPROP.gatewayService"]       , !val);
}

function handleHighAvailabilityChange( theForm)
{
    var optionobj = theForm.elements[".CPROP.haMode"];
    var option = optionobj.options[optionobj.selectedIndex].value;

    if (option == "Yes") {
        setHighAvailabilityFields( theForm, true);
    }
    else if (option == "No") {
        setHighAvailabilityFields( theForm, false);
    }
}

function testSAPConnection(dspPage)
{					
	var htmlform = document.forms["form"];				
	var isFormValid = validateSAPConnectionForm(htmlform);
	if(!isFormValid){
		return false;
	}		
	htmlform.setAttribute("action", dspPage);
	document.forms["form"]["test"].value = "true";
	document.forms["form"][".CPROP.testConnection"].value = "On";
	var connectionAliasElements = document.forms["form"][".CPROP.alias"];
	if(connectionAliasElements.value != null && connectionAliasElements.value.length > 0){
		document.forms["form"]["resourceName"].value = "connNode_" + connectionAliasElements.value;
	}
	return true;
}

function testSAPCompleted()
{
	document.forms["form"]["test"].value = "completed";
}

function validateSAPConnectionForm(theForm)
{
	if (theForm.elements[".CPROP.testConnection"] != null && theForm.elements["test"].value == "completed") {
        theForm.elements[".CPROP.testConnection"].value = "Off";
    }
	
    var returnValue = 0;
    var errors = "Error: ";

    if (theForm.elements['resourceFolderName'] != null && theForm.elements['resourceFolderName'].value.length == 0) {
        returnValue = -1;
        errors += "Folder Name required for connection resource.\n";
    }

    if (theForm.elements['.CPROP.alias'] != null && theForm.elements['.CPROP.alias'].value.length == 0) {
        returnValue = -1;
        errors += "Connection Alias required for connection resource.\n";
    }
	
	if (theForm.elements['.CPROP.user'] != null && theForm.elements['.CPROP.user'].value.length == 0) {
        returnValue = -1;
        errors += "User Name required for connection resource.\n";
    }
	
	if (theForm.elements['.CPROP.password'] != null && theForm.elements['.CPROP.password'].value.length == 0) {
        returnValue = -1;
        errors += "Password required for connection resource.\n";
    }
	
	if (theForm.elements['.CPROP.client'] != null && theForm.elements['.CPROP.client'].value.length == 0) {
        returnValue = -1;
        errors += "Client required for connection resource.\n";
    }
	
	if (theForm.elements['.CPROP.client'] != null && theForm.elements['.CPROP.client'].value.length > 3) {
        returnValue = -1;
        errors += "Client cannot be of more than 3 digits.\n";
    }
													
    var str = "";

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
		else if (theForm.elements[".CMGRPROP.minimumPoolSize"].value > 2147483647) {
            returnValue = -1;
            errors += "Please enter a valid value for Minimum Pool Size.\n";
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
		else if (theForm.elements[".CMGRPROP.maximumPoolSize"].value > 2147483647) {
            returnValue = -1;
            errors += "Please enter a valid value for Maximum Pool Size.\n";
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
			else if (theForm.elements[".CMGRPROP.poolIncrementSize"].value > 2147483647) {
				returnValue = -1;
				errors += "Please enter a valid value for Pool Increment Size.\n";
			}
            else if (maxPool > 0 && poolInc > maxPool) {
                returnValue = -1;
                errors += "Pool Increment Size must be a number <= Maximum Pool Size when\n";
                errors += "Connection Pooling is enabled.\n";
            }

        }

        if (!isNumber(theForm.elements[".CMGRPROP.blockingTimeout"].value)) {
            returnValue = -1;
            errors += "Please enter a valid block timeout (in msec)\n";
        }
        else if (parseInt(theForm.elements[".CMGRPROP.blockingTimeout"].value) < 0) {
            returnValue = -1;
            errors += "Block Timeout value must be >=0.\n";
        }
		else if (theForm.elements[".CMGRPROP.blockingTimeout"].value > 2147483647) {
			returnValue = -1;
			errors += "Please enter a valid value for Block Timeout.\n";
		}

        if (!isNumber(theForm.elements[".CMGRPROP.expireTimeout"].value)) {
            returnValue = -1;
            errors += "Please enter a valid expire timeout (in msec) or -1 for no timeout.\n";
        }
        else if (parseInt(theForm.elements[".CMGRPROP.expireTimeout"].value) < -1) {
            returnValue = -1;
            errors += "Please enter a valid expire timeout (in msec) or -1 for no timeout.\n";
        }
		else if (theForm.elements[".CMGRPROP.expireTimeout"].value > 2147483647) {
			returnValue = -1;
			errors += "Please enter a valid value for expire timeout.\n";
		}
        
	if(!isNumber(theForm.elements[".CMGRPROP.startupRetryCount"].value)){
	    returnValue = -1;
            errors += "Startup Retry Count must be a number >=0\n";
        }
	else if(parseInt(theForm.elements[".CMGRPROP.startupRetryCount"].value) < 0) {
	    returnValue = -1;
            errors += "Startup Retry Count value must be >=0\n";
        }
	else if (theForm.elements[".CMGRPROP.startupRetryCount"].value > 2147483647) {
			returnValue = -1;
			errors += "Please enter a valid value for Startup Retry Count.\n";
		}
        
	if(!isNumber(theForm.elements[".CMGRPROP.startupBackoffSecs"].value)){
	    returnValue = -1;
            errors += "Startup Backoff Timeout must be a number >=0\n";
        }
	else if(parseInt(theForm.elements[".CMGRPROP.startupBackoffSecs"].value) < 0) {
	    returnValue = -1;
            errors += "Startup Backoff Timeout value must be >=0\n";
        }
	else if (theForm.elements[".CMGRPROP.startupBackoffSecs"].value > 2147483647) {
			returnValue = -1;
			errors += "Please enter a valid value for Startup Backoff Timeout.\n";
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

function updateURLSAP(elemId, linkContent)
{
	var elem = document.getElementById(elemId);
	if(elem == undefined || elem == null)
	{
		return;
	}
	
	elemId=elemId.replace(/\-/g,"_").replace(/\(/g,"_").replace(/\)/g,"_");
	elem.setAttribute("id", elemId);
	updateURL(elemId, linkContent);
}