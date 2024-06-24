package JSocketAdapter.COMMON.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.app.b2b.server.*;
import com.wm.lang.ns.*;
import com.wm.util.Config;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.IOException;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.*;
import custom.java.com.log.DebugLogger;
// --- <<IS-END-IMPORTS>> ---

public final class MISC

{
	// ---( internal utility methods )---

	final static MISC _instance = new MISC();

	static MISC _newInstance() { return new MISC(); }

	static MISC _cast(Object o) { return (MISC)o; }

	// ---( server methods )---




	public static final void execCommand (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(execCommand)>> ---
		// @sigtype java 3.5
		// [i] field:0:required program
		// [i] field:0:required option
		// [i] field:0:required command
		// [i] field:0:required encoding
		// [o] field:0:required status
		// [o] field:0:required errorMsg
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String program = IDataUtil.getString( pipelineCursor, "program" );
		String option = IDataUtil.getString( pipelineCursor, "option" );
		String command = IDataUtil.getString( pipelineCursor, "command" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();
		
		// UNIX \uC5D0\uC11C\uB294 /bin/sh \uB85C \uC124\uC815\uD558\uACE0 \uB9AC\uB205\uC2A4\uC5D0\uC11C\uB294 /bin/bash \uB85C \uC124\uC815\uD55C\uB2E4.
		// \uB9AC\uB205\uC2A4\uC5D0\uC11C /bin/sh \uB85C \uC124\uC815\uD558\uBA74 \uD30C\uC77C\uB9CC \uC0AD\uC81C\uD558\uB3C4\uB85D \uBA85\uB839\uC5B4\uB97C \uC2E4\uD589\uD560 \uB54C \uD30C\uC77C \uC0AC\uC774\uC988\uAC00 0 \uC778 \uD30C\uC77C\uB9CC \uC0AD\uC81C\uB418\uACE0
		// 0 \uBCF4\uB2E4 \uD070 \uD30C\uC77C\uC740 \uC0AD\uC81C\uB418\uC9C0 \uC54A\uB294\uB2E4.
		String[] commandArray = { program, option, command };
		Process proc = null;
		BufferedReader stdInput = null;
		BufferedReader stdError = null;
		String tmpString = "";
		String status = "success";
		String errorMsg = "";
		String[] outputStringList = null;
		String outputString = "";
		
		if ( encoding == null || encoding.contentEquals( "" ) ) {
			encoding = "EUC-KR";
		}
		
		try {
			proc = Runtime.getRuntime().exec( commandArray );
			stdInput = new BufferedReader( new InputStreamReader( proc.getInputStream(), encoding ) );
			stdError = new BufferedReader( new InputStreamReader( proc.getErrorStream(), encoding ) );
			
			// Read the output from the command
			while ( ( tmpString = stdInput.readLine() ) != null ) {
				debugLogger.printLogAtIS( "Execute Shell Command ==> " + tmpString );
			}
			
			// Read any errors from the attempted command
			while ( ( tmpString = stdError.readLine() ) != null ) {
				status = "fail";
				errorMsg = tmpString;
				debugLogger.printLogAtIS( "Failed Execute Shell Command ==> " + tmpString );
			}
			
			proc.destroy();
			
			if ( stdInput != null ) {
				stdInput.close();
			}
			
			if ( stdError != null ) {
				stdError.close();
			}
		} catch ( IOException e ) {
			status = "fail : Catch Exception";
			errorMsg = e.getMessage();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "status", status );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void garbageCollector (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(garbageCollector)>> ---
		// @sigtype java 3.5
		System.gc();
		// --- <<IS-END>> ---

                
	}



	public static final void generateUUID (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(generateUUID)>> ---
		// @sigtype java 3.5
		// [o] field:0:required UUID
		UUID uuid = UUID.randomUUID();
		String genUUID = uuid.toString().replaceAll( "-", "" );
		
		uuid = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "UUID", genUUID );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getISProperty (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getISProperty)>> ---
		// @sigtype java 3.5
		// [i] field:0:required propFileName
		// [i] field:1:required propKeys
		// [o] field:0:required errorMsg
		// [o] field:1:required propValues
		IDataCursor pipelineCursor = pipeline.getCursor();
		String propFileName = IDataUtil.getString( pipelineCursor, "propFileName" );
		String[] propKeys = IDataUtil.getStringArray( pipelineCursor, "propKeys" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		InputStream is = null;
		Properties properties = new Properties();
		String[] propValues = new String[ propKeys.length ];
		
		try {
			is = new FileInputStream( propFileName );
			properties.load( is );
			
			for ( int i = 0; i < propKeys.length; i++ ) {
				propValues[ i ] = properties.getProperty( propKeys[ i ] );
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		} finally {
			try {
				if ( is != null ) {
					is.close();
				}
			} catch ( Exception fe ) {
			}
		}
		
		is = null;
		properties = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "propValues", propValues );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getParentServiceName (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getParentServiceName)>> ---
		// @sigtype java 3.5
		// [o] field:0:required folderName
		// [o] field:0:required serviceName
		// [o] field:0:required fullName
		String fullName = Service.getParentServiceName();
		String[] folderService = fullName.split( "\\:" );
		String folderName = folderService[ 0 ];
		String serviceName = folderService[ 1 ];
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "folderName", folderName );
		IDataUtil.put( pipelineCursor_1, "serviceName", serviceName );
		IDataUtil.put( pipelineCursor_1, "fullName", fullName );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getPropertyValue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getPropertyValue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required propName
		// [i] field:0:required propFullFileName
		// [o] field:0:required propValue
		IDataCursor pipelineCursor = pipeline.getCursor();		
		String propName = IDataUtil.getString( pipelineCursor, "propName" );
		String propFullFileName = IDataUtil.getString( pipelineCursor, "propFullFileName" );
		pipelineCursor.destroy();
		
		Properties prop = new Properties();
		FileInputStream fis = null;
		String propValue = "";
		
		try {
			fis = new FileInputStream( propFullFileName );
			prop.load( fis );
			propValue = prop.getProperty( propName );
		} catch ( Exception e ) {
			throw new ServiceException( propName + " Property Get Error ==> " + e );
		} finally {
			if ( fis != null ) {
				try {
					fis.close();
				} catch ( Exception fe ) {
					
				}
			}
		}
		
		prop = null;
		fis = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "propValue", propValue );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getServerInformation (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getServerInformation)>> ---
		// @sigtype java 3.5
		// [o] field:0:required serverName
		// [o] field:0:required serverIP
		// [o] field:0:required primaryPort
		// [o] field:0:required currentPort
		// [o] field:0:required protocol
		IDataCursor idcPipeline = pipeline.getCursor();
		
		String strServerName = ServerAPI.getServerName();
		String strCurrentPort = ServerAPI.getCurrentPort() + "";
		String strServerIP = "";
		String strProtocol = "";
		
		IData listenerInfo = null;
		String strPrimaryPort = "";
		IData results = null;
		IDataCursor idcListenerInfo = null;
		
		try {
			strServerIP = ( InetAddress.getLocalHost() ).getHostAddress();
			
			// IS Start \uC2DC Startup \uC11C\uBE44\uC2A4\uAC00 \uBA3C\uC800 \uC2E4\uD589\uB418\uACE0 Port Enable \uCC98\uB9AC\uAC00 \uB098\uC911\uC5D0 \uC2E4\uD589\uB418\uAE30 \uB54C\uBB38\uC5D0 Startup \uC11C\uBE44\uC2A4\uC5D0\uC11C \uC544\uB798 \uC11C\uBE44\uC2A4\uB97C Invoke \uD558\uBA74 results\uAC00 null \uC774\uB2E4.
			results = Service.doInvoke( "wm.server.net.listeners", "getPrimaryListener", pipeline );
			IDataUtil.merge( results, pipeline );
			 
			if ( idcPipeline.first( "primary" ) ) {
				listenerInfo = IDataUtil.getIData( idcPipeline, "primary" );
				idcPipeline.delete();
				
				idcListenerInfo = listenerInfo.getCursor();
				
				if ( idcListenerInfo.first( "port" ) ) {
					strPrimaryPort = IDataUtil.getString( idcListenerInfo, "port" );
				}
				
				if ( idcListenerInfo.first( "protocol" ) ) {
					strProtocol = IDataUtil.getString( idcListenerInfo, "protocol" );
					strProtocol = strProtocol.toLowerCase();
				}
				
				idcListenerInfo.destroy();
			}
		} catch ( Exception e ) {
			strPrimaryPort = "";
		}
		
		idcPipeline.destroy();
		
		listenerInfo = null;
		results = null;
		idcListenerInfo = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "serverName", strServerName );
		IDataUtil.put( pipelineCursor_1, "serverIP", strServerIP );
		IDataUtil.put( pipelineCursor_1, "primaryPort", strPrimaryPort );
		IDataUtil.put( pipelineCursor_1, "currentPort", strCurrentPort );
		IDataUtil.put( pipelineCursor_1, "protocol", strProtocol );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getServiceName (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getServiceName)>> ---
		// @sigtype java 3.5
		// [o] field:0:required folderName
		// [o] field:0:required serviceName
		// [o] field:0:required fullName
		// [o] field:0:required successFlag
		// [o] field:0:required errorMessage
		// [o] field:0:required serviceStartTime
		/** Service is designed to return the current service name.
		  * Output: folderPath - the folder path to the service
		  *			serviceName - the service name
		  *			fullName - the folder path + ":" + service
		  *			successFlag - true or false
		  *			errorMessage - error detail. This is set to "None" if no error occurs.
		  *
		  * NOTE 1: Because this service relies on a method invocation that retrieves the NSService
		  * 	object relating to the calling service, it will *NOT* work as desired if run independently.
		  * 	Instead, it will return information on the current service (this one) and set the
		  *		"successFlag" and "errorMessage" values to indicate an error.
		  * NOTE 2: This service uses non-public APIs within the webMethods Integration Server. These may 
		  * 	change in future releases of the product *without* notice. These method invocations are
		  *		marked as such.
		  *
		  * @author Ryan Johnston, Professional Services, webMethods, Inc.
		  * @version 1.0
		  */
		
		//Instantiate a cursor for access to the pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		
		//Working & Output Variables - Create all output & working variables
		NSService callingService = null;
		StringTokenizer strTok = null;
		String folderPath = new String();
		String serviceName = new String();
		String fullName = new String();
		String successFlag = "true";
		String errorMessage = "None";
		
		// Service Start Time
		SimpleDateFormat sdf = new SimpleDateFormat( "yyyyMMddHHmmssSSS" );
		Date startDate = new Date();
		String serviceStartTime = sdf.format( startDate );
		
		//Input Variables
		//None
		
		//Service Body
		//This publicly documented method gets the NSService object associated with the calling service.
		callingService = Service.getCallingService();
		
		/** If the callingService is not available (meaning that the service was run directly, set the 
		  * "callingService" to hold the values for the current service (this one). Additionally, set the
		  * "successFlag" and "errorMessage" fields to indicate a problem.
		  */
		if (callingService == null)
		{
			callingService = InvokeState.getCurrentService();
			successFlag = "false";
			errorMessage = "No calling service found... Returning information for this service instead.";
		}
		
		/** Non-public API. However, this call is relatively safe, as "toString" is a standard method that
		  * is normally overriden from the root java.lang.Object.
		  */
		fullName = callingService.toString();
		
		/** Use StringTokenizer, from the java.util package, to extract the folderPath and serviceName 
		  * values.
		  */
		try
		{
			strTok = new StringTokenizer(fullName, ":");
			folderPath = strTok.nextToken();
			serviceName = strTok.nextToken();
		}
		catch(java.lang.Exception ex)
		{
			System.out.println("CRITICAL ERROR: Check the toString() method within NSService to ensure that it is returning Folder:ServiceName as desired.");
			successFlag = "false";
			errorMessage = "CRITICAL ERROR: Check the toString() method within NSService to ensure that it is returning Folder:ServiceName as desired.";
		
		}
		
		callingService = null;
		strTok = null;
		sdf = null;
		startDate = null;
		
		//Populate service output
		if (pipelineCursor.first("folderName"))
			pipelineCursor.delete();
		pipelineCursor.insertAfter("folderName", folderPath);
		
		if (pipelineCursor.first("serviceName"))
			pipelineCursor.delete();
		pipelineCursor.insertAfter("serviceName", serviceName);
		
		if (pipelineCursor.first("fullName"))
			pipelineCursor.delete();
		pipelineCursor.insertAfter("fullName", fullName);
		
		if (pipelineCursor.first("successFlag"))
			pipelineCursor.delete();
		pipelineCursor.insertAfter("successFlag", successFlag);
		
		if (pipelineCursor.first("errorMessage"))
			pipelineCursor.delete();
		pipelineCursor.insertAfter("errorMessage", errorMessage);
		
		if (pipelineCursor.first("serviceStartTime"))
			pipelineCursor.delete();
		pipelineCursor.insertAfter("serviceStartTime", serviceStartTime);
		// --- <<IS-END>> ---

                
	}



	public static final void getSystemAttribute (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getSystemAttribute)>> ---
		// @sigtype java 3.5
		// [i] field:0:required attrName
		// [o] field:0:required attrValue
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String attrName = IDataUtil.getString( pipelineCursor, "attrName" );
		pipelineCursor.destroy();
		
		IData results = null;
		IDataCursor resultsCursor = null;
		IData sysattr = null;
		IDataCursor sysattrCursor = null;
		String curKey = "";
		String curValue = "";
		String attrValue = "";
		
		try {
			results = Service.doInvoke( "wm.server.query.adminui", "getSystemAttributes", pipeline );
			
			if ( results != null ) {
				resultsCursor = results.getCursor();
				sysattr = IDataUtil.getIData( resultsCursor, "sysattr" );
			
				if ( sysattr != null ) {
					sysattrCursor = sysattr.getCursor();
				
					while ( sysattrCursor.next() ) {
						curKey = sysattrCursor.getKey();
						curValue = ( String )sysattrCursor.getValue();
					
						if ( attrName.equals( curKey ) ) {
							attrValue = curValue;
							break;
						}
					}
				}
			}
		} catch ( Exception e ) {
			throw new ServiceException( "Could not invoke wm.server.query.adminui:getSystemAttributes: " + e );
		}
		
		results = null;
		resultsCursor = null;
		sysattr = null;
		sysattrCursor = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "attrValue", attrValue );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void returnCommandExec (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(returnCommandExec)>> ---
		// @sigtype java 3.5
		// [i] field:0:required program
		// [i] field:0:required option
		// [i] field:0:required command
		// [i] field:0:required encoding
		// [o] field:0:required status
		// [o] field:0:required errorMsg
		// [o] field:1:required outputStringList
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String program = IDataUtil.getString( pipelineCursor, "program" );
		String option = IDataUtil.getString( pipelineCursor, "option" );
		String command = IDataUtil.getString( pipelineCursor, "command" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();
		
		// UNIX \uC5D0\uC11C\uB294 /bin/sh \uB85C \uC124\uC815\uD558\uACE0 \uB9AC\uB205\uC2A4\uC5D0\uC11C\uB294 /bin/bash \uB85C \uC124\uC815\uD55C\uB2E4.
		// \uB9AC\uB205\uC2A4\uC5D0\uC11C /bin/sh \uB85C \uC124\uC815\uD558\uBA74 \uD30C\uC77C\uB9CC \uC0AD\uC81C\uD558\uB3C4\uB85D \uBA85\uB839\uC5B4\uB97C \uC2E4\uD589\uD560 \uB54C \uD30C\uC77C \uC0AC\uC774\uC988\uAC00 0 \uC778 \uD30C\uC77C\uB9CC \uC0AD\uC81C\uB418\uACE0
		// 0 \uBCF4\uB2E4 \uD070 \uD30C\uC77C\uC740 \uC0AD\uC81C\uB418\uC9C0 \uC54A\uB294\uB2E4.
		String[] commandArray = { program, option, command };
		Process proc = null;
		BufferedReader stdInput = null;
		BufferedReader stdError = null;
		String tmpString = "";
		String status = "success";
		String errorMsg = "";
		String[] outputStringList = null;
		String outputString = "";
		
		if ( encoding == null || encoding.contentEquals( "" ) ) {
			encoding = "EUC-KR";
		}
		
		try {
			proc = Runtime.getRuntime().exec( commandArray );
			stdInput = new BufferedReader( new InputStreamReader( proc.getInputStream(), encoding ) );
			stdError = new BufferedReader( new InputStreamReader( proc.getErrorStream(), encoding ) );
			
			// Read the output from the command
			while ( ( tmpString = stdInput.readLine() ) != null ) {
				debugLogger.printLogAtIS( "Execute Shell Command ==> " + tmpString );
				
				if ( outputString.equals( "" ) ) {
					outputString = tmpString;
				} else {
					outputString = outputString + "|||" + tmpString;
				}
			}
			
			if ( !outputString.equals( "" ) ) {
				outputStringList = outputString.split( "\\|\\|\\|" );
			}
			
			// Read any errors from the attempted command
			while ( ( tmpString = stdError.readLine() ) != null ) {
				status = "fail";
				errorMsg = tmpString;
				debugLogger.printLogAtIS( "Failed Execute Shell Command ==> " + tmpString );
			}
			
			proc.destroy();
			
			if ( stdInput != null ) {
				stdInput.close();
			}
			
			if ( stdError != null ) {
				stdError.close();
			}
		} catch ( IOException e ) {
			status = "fail : Catch Exception";
			errorMsg = e.getMessage();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "status", status );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "outputStringList", outputStringList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void setCustomContextID (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(setCustomContextID)>> ---
		// @sigtype java 3.5
		// [i] field:0:required ccID
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String ccID = IDataUtil.getString( pipelineCursor, "ccID" );
		pipelineCursor.destroy();
		
		InvokeState.getCurrentState().setCustomAuditContextID( ccID );
		// --- <<IS-END>> ---

                
	}



	public static final void setISProperty (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(setISProperty)>> ---
		// @sigtype java 3.5
		// [i] record:1:required props
		// [i] - field:0:required propKey
		// [i] - field:0:required propValue
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData[] props = IDataUtil.getIDataArray( pipelineCursor, "props" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		IDataCursor propCur = null;
		IData prop = null;
		String propKey = "";
		String propValue = "";
		
		try {
			for ( int i = 0; i < props.length; i++ ) {
				prop = props[ i ];
				propCur = prop.getCursor();
				propKey = IDataUtil.getString( propCur, "propKey" );
				propValue = IDataUtil.getString( propCur, "propValue" );
				Config.setProperty( propKey, propValue );
				
				prop = null;
				propCur.destroy();
			}
			
			Server.saveConfiguration();
			// \uC704 \uC2A4\uD15D\uC744 \uC218\uD589\uD558\uBA74 server.cnf \uD30C\uC77C\uC5D0 \uBC14\uB85C \uBC18\uC601\uB418\uACE0 \uC218\uD589\uD558\uC9C0 \uC54A\uC73C\uBA74 IS\uB97C Restart \uD560 \uB54C server.cnf \uD30C\uC77C\uC5D0 \uBC18\uC601\uB41C\uB2E4.
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static DebugLogger debugLogger = new DebugLogger();
	// --- <<IS-END-SHARED>> ---
}

