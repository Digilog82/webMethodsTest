package JSocketAdapter.COMMON.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.util.Enumeration;
import java.util.Hashtable;
import custom.java.socket.manager.*;
// --- <<IS-END-IMPORTS>> ---

public final class MEMORY

{
	// ---( internal utility methods )---

	final static MEMORY _instance = new MEMORY();

	static MEMORY _newInstance() { return new MEMORY(); }

	static MEMORY _cast(Object o) { return (MEMORY)o; }

	// ---( server methods )---




	public static final void addOnlineConnectCount (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(addOnlineConnectCount)>> ---
		// @sigtype java 3.5
		// [i] field:0:required serverIP
		// [i] field:0:required portNumber
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	serverIP = IDataUtil.getString( pipelineCursor, "serverIP" );
		String	portNumber = IDataUtil.getString( pipelineCursor, "portNumber" );
		pipelineCursor.destroy();
		
		String name = "Connect_" + serverIP + "_" + portNumber;
		sManager.addOnlineConnectCount( name );
		// --- <<IS-END>> ---

                
	}



	public static final void addSessionCount (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(addSessionCount)>> ---
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		int	portNumber = IDataUtil.getInt( pipelineCursor, "portNumber", 0 );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.addSessionCount( portNumber );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void checkAccessExcept (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(checkAccessExcept)>> ---
		// @sigtype java 3.5
		// [i] field:0:required clientIP
		// [o] field:0:required exit
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	clientIP = IDataUtil.getString( pipelineCursor, "clientIP" );
		pipelineCursor.destroy();
		
		String exit = sManager.checkAccessExcept( clientIP );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exit", exit );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void closeOnlineServerSocket (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(closeOnlineServerSocket)>> ---
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		IDataCursor pipelineCursor = pipeline.getCursor();
		int	portNumber = IDataUtil.getInt( pipelineCursor, "portNumber", 0 );
		pipelineCursor.destroy();
		
		sManager.closeOnlineServerSocket( portNumber );
		// --- <<IS-END>> ---

                
	}



	public static final void createOnlineReceiveSequence (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createOnlineReceiveSequence)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required OnlineReceiveSequence
		// [o] field:0:required rcvSeq
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData OnlineReceiveSequence = IDataUtil.getIData( pipelineCursor, "OnlineReceiveSequence" );
		pipelineCursor.destroy();
		
		SynchronizedInvoker synchInvoker = null;
		String rcvSeq = "";
		
		try {
			synchInvoker = new SynchronizedInvoker();
			rcvSeq = synchInvoker.createOnlineReceiveSequence( name, OnlineReceiveSequence );
		} catch ( Exception e ) {
		}
		
		OnlineReceiveSequence = null;
		synchInvoker = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "rcvSeq", rcvSeq );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void existDataQueueKey (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(existDataQueueKey)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueKey
		// [o] field:0:required exist
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	queueKey = IDataUtil.getString( pipelineCursor, "queueKey" );
		pipelineCursor.destroy();
		
		String exist = sManager.existDataQueueKey( queueKey );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exist", exist );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void existOnlineQueuing (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(existOnlineQueuing)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] field:0:required synchronize {"true","false"}
		// [i] record:0:required OnlineQueuing
		// [o] field:0:required exist
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		String	synchronize = IDataUtil.getString( pipelineCursor, "synchronize" );
		IData OnlineQueuing = IDataUtil.getIData( pipelineCursor, "OnlineQueuing" );
		pipelineCursor.destroy();
		
		if ( synchronize == null ) {
			synchronize = "false";
		}
		
		SynchronizedInvoker synchInvoker = null;
		String exist = "false";
		
		try {
			if ( synchronize.equals( "true" ) ) {
				synchInvoker = new SynchronizedInvoker();
				exist = synchInvoker.existOnlineQueuing( name, OnlineQueuing );
			} else {
				exist = sManager.existOnlineQueuing( name );
			}
		} catch ( Exception e ) {
		}
		
		OnlineQueuing = null;
		synchInvoker = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exist", exist );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void existOnlineReceiveSequence (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(existOnlineReceiveSequence)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required exist
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String exist = sManager.existOnlineReceiveSequence( name );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exist", exist );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void existQueueManager (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(existQueueManager)>> ---
		// @sigtype java 3.5
		// [i] field:0:required qName
		// [o] field:0:required exist
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	qName = IDataUtil.getString( pipelineCursor, "qName" );
		pipelineCursor.destroy();
		
		String exist = "true";
		QueueManager qm = sManager.getQueueManager( qName );
		
		if ( qm == null ) {
			exist = "false";
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exist", exist );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void existSerialQueueManager (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(existSerialQueueManager)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		// [o] field:0:required exists
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		pipelineCursor.destroy();
		
		String exists = "true";
		
		QueueManager qm = sManager.getSerialQueueManager( queueName );
		
		if ( qm == null ) {
			exists = "false";
		}
		
		qm = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exists", exists );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void existSocketLogQueueManager (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(existSocketLogQueueManager)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		// [o] field:0:required exists
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		pipelineCursor.destroy();
		
		String exists = "true";
		
		QueueManager qm = sManager.getSocketLogQueueManager( queueName );
		
		if ( qm == null ) {
			exists = "false";
		}
		
		qm = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exists", exists );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getBusinessDocSchemaDef (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getBusinessDocSchemaDef)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		// [o] record:0:required schemaDef
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		IData schemaDef = null;
		
		try {
			schemaDef = sManager.getBusinessDocSchemaDef( name );
			
			if ( schemaDef == null ) {
				errorMsg = name + " \uC758 Schema \uC815\uC758\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "schemaDef", schemaDef );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getBusinessInterface (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getBusinessInterface)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		// [o] recref:0:required BusinessInterfaceInfo JSocketAdapter.DOC:InterfaceListInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		IData BusinessInterfaceInfo = null;
		String errorMsg = "";
		
		try {
			BusinessInterfaceInfo = sManager.getBusinessInterface( name );
			
			if ( BusinessInterfaceInfo == null ) {
				errorMsg = name + " \uAC00 Business Interface List \uC5D0 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "BusinessInterfaceInfo", BusinessInterfaceInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getBusinessName (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getBusinessName)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		// [o] recref:0:required BusinessNameInfo JSocketAdapter.DOC:BusinessNameInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		IData BusinessNameInfo = null;
		String errorMsg = "";
		
		try {
			//BusinessNameInfo = ( IData )BusinessNameList.get( name );
			BusinessNameInfo = sManager.getBusinessName( name );
			
			if ( BusinessNameInfo == null ) {
				errorMsg = name + " \uAC00 Business Name List \uC5D0 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "BusinessNameInfo", BusinessNameInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getCcsid (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getCcsid)>> ---
		// @sigtype java 3.5
		// [o] field:0:required ccsid
		String ccsid = sManager.getCcsid();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "ccsid", ccsid );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getConnectedSessionCount (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getConnectedSessionCount)>> ---
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [i] field:0:required threadPool
		// [o] field:0:required connectCount
		IDataCursor pipelineCursor = pipeline.getCursor();
		String portNumber = IDataUtil.getString( pipelineCursor, "portNumber" );
		String threadPool = IDataUtil.getString( pipelineCursor, "threadPool" );
		pipelineCursor.destroy();
		
		String connectCount = sManager.getConnectedSessionCount( Integer.parseInt( portNumber ), threadPool );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "connectCount", connectCount );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getCustomVariable (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getCustomVariable)>> ---
		// @sigtype java 3.5
		// [i] field:0:required variableName
		// [o] field:0:required errorMsg
		// [o] recref:0:required CustomVariableInfo JSocketAdapter.DOC:CustomVariableInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	variableName = IDataUtil.getString( pipelineCursor, "variableName" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		IData CustomVariableInfo = null;
		
		try {
			CustomVariableInfo = sManager.getCustomVariable( variableName );
			
			if ( CustomVariableInfo == null ) {
				errorMsg = variableName + " \uAC00 Custom Variable List \uC5D0 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "CustomVariableInfo", CustomVariableInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getDataQueueKey (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getDataQueueKey)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueKey
		// [o] field:0:required errorMsg
		// [o] recref:0:required DataQKeyInfo JSocketAdapter.DOC:DataQKeyInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	queueKey = IDataUtil.getString( pipelineCursor, "queueKey" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		IData DataQKeyInfo = null;
		
		try {
			DataQKeyInfo = sManager.getDataQueueKey( queueKey );
			
			if ( DataQKeyInfo == null ) {
				errorMsg = queueKey + " \uAC00 Data Queue Key List\uC5D0 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "DataQKeyInfo", DataQKeyInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getDocInterfaceID (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getDocInterfaceID)>> ---
		// @sigtype java 3.5
		// [i] field:0:required docName
		// [o] field:0:required errorMsg
		// [o] recref:0:required DocInterfaceIDInfo JSocketAdapter.DOC:DocInterfaceIDInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	docName = IDataUtil.getString( pipelineCursor, "docName" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		IData DocInterfaceIDInfo = null;
		
		try {
			DocInterfaceIDInfo = sManager.getDocInterfaceID( docName );
			
			if ( DocInterfaceIDInfo == null ) {
				errorMsg = "\uC804\uBB38 " + docName + "\uC774(\uAC00) Interface Doc List\uC5D0 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "DocInterfaceIDInfo", DocInterfaceIDInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getDocSchemaDef (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getDocSchemaDef)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		// [o] record:0:required schemaDef
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		IData schemaDef = null;
		
		try {
			schemaDef = sManager.getDocSchemaDef( name );
			
			if ( schemaDef == null ) {
				errorMsg = name + " \uC758 Schema \uC815\uC758\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "schemaDef", schemaDef );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getOnlineClientListener (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getOnlineClientListener)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		// [o] recref:0:required OnlineListenerInfo JSocketAdapter.DOC:OnlineListenerInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	sessionName = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		IData OnlineListenerInfo = null;
		String errorMsg = "";
		
		try {
			OnlineListenerInfo = sManager.getOnlineClientListener( sessionName );
			
			if ( OnlineListenerInfo == null ) {
				errorMsg = sessionName + " \uC5D0 \uB300\uD55C Online Client Listener \uC815\uBCF4\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "OnlineListenerInfo", OnlineListenerInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getOnlineConnectCount (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getOnlineConnectCount)>> ---
		// @sigtype java 3.5
		// [i] field:0:required serverIP
		// [i] field:0:required portNumber
		// [o] field:0:required connectCount
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	serverIP = IDataUtil.getString( pipelineCursor, "serverIP" );
		String	portNumber = IDataUtil.getString( pipelineCursor, "portNumber" );
		pipelineCursor.destroy();
		
		String name = "Connect_" + serverIP + "_" + portNumber;
		String connectCount = sManager.getOnlineConnectCount( name );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "connectCount", connectCount );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getOnlineHealthCheck (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getOnlineHealthCheck)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		// [o] recref:0:required OnlineHealthCheckInfo JSocketAdapter.DOC:OnlineHealthCheckInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		IData OnlineHealthCheckInfo = null;
		String errorMsg = "";
		
		try {
			OnlineHealthCheckInfo = sManager.getOnlineHealthCheck( name );
			
			if ( OnlineHealthCheckInfo == null ) {
				errorMsg = name + " \uC5D0 \uB300\uD55C Online Health Check Service \uC815\uBCF4\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "OnlineHealthCheckInfo", OnlineHealthCheckInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getOnlineReconnectingServer (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getOnlineReconnectingServer)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] field:0:required synchronize {"true","false"}
		// [i] record:0:required InReconnectingServer
		// [o] field:0:required exist
		// [o] field:0:required errorMsg
		// [o] recref:0:required OnlineReconnectingServer JSocketAdapter.DOC:OnlineReconnectingServer
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		String	synchronize = IDataUtil.getString( pipelineCursor, "synchronize" );
		IData InReconnectingServer = IDataUtil.getIData( pipelineCursor, "InReconnectingServer" );
		pipelineCursor.destroy();
		
		if ( synchronize == null ) {
			synchronize = "false";
		}
		
		SynchronizedInvoker synchInvoker = null;
		IData OnlineReconnectingServer = null;
		String exist = "";
		String errorMsg = "";
		
		try {
			// \uB3D9\uC2DC\uC5D0 \uC5EC\uB7EC Online Socket Reconnect \uD504\uB85C\uC138\uC2A4\uC5D0\uC11C \uD638\uCD9C \uC2DC synchronized \uB85C \uCC98\uB9AC
			// Reconnect \uD504\uB85C\uC138\uC2A4\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC744 \uACBD\uC6B0 \uBA54\uBAA8\uB9AC\uC5D0 \uBC14\uB85C Reconnect \uC815\uBCF4 \uC800\uC7A5
			if ( synchronize.equals( "true" ) ) {
				//exist = existOnlineReconnecting( name, InReconnectingServer );
				synchInvoker = new SynchronizedInvoker();
				exist = synchInvoker.existOnlineReconnectingServer( name, InReconnectingServer );
			} else {
				OnlineReconnectingServer = sManager.getOnlineReconnectingServer( name );
			
				if ( OnlineReconnectingServer == null ) {
					exist = "false";
					errorMsg = name + " \uC5D0 \uB300\uD55C Online Reconnecting Server \uC815\uBCF4\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
				} else {
					exist = "true";
				}
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		synchInvoker = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exist", exist );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "OnlineReconnectingServer", OnlineReconnectingServer );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getOnlineRequestHeader (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getOnlineRequestHeader)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] field:0:required remove {"No","Yes"}
		// [o] field:0:required errorMsg
		// [o] recref:0:required OnlineRequestHeader JSocketAdapter.DOC:OnlineRequestHeader
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		String	remove = IDataUtil.getString( pipelineCursor, "remove" );
		pipelineCursor.destroy();
		
		IData OnlineRequestHeader = null;
		String errorMsg = "";
		
		try {
			//OnlineRequestHeader = ( IData )OnlineRequestHeaderList.get( name );
			OnlineRequestHeader = sManager.getOnlineRequestHeader( name );
			
			if ( OnlineRequestHeader == null ) {
				errorMsg = name + " \uC5D0 \uB300\uD55C Online Request Header \uC815\uBCF4\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			} else {
				// OnlineRequestHeaderList Hashtable \uC5D0\uC11C \uC0AD\uC81C
				//OnlineRequestHeaderList.remove( name );
				if ( remove.equals( "Yes" ) ) {
					sManager.removeOnlineRequestHeader( name );
				}
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "OnlineRequestHeader", OnlineRequestHeader );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getOnlineResponseData (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getOnlineResponseData)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] field:0:required remove {"No","Yes"}
		// [o] field:0:required errorMsg
		// [o] recref:0:required OnlineResponseData JSocketAdapter.DOC:OnlineResponseData
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		String	remove = IDataUtil.getString( pipelineCursor, "remove" );
		pipelineCursor.destroy();
		
		IData OnlineResponseData = null;
		String errorMsg = "";
		
		try {
			OnlineResponseData = sManager.getOnlineResponseData( name );
			
			if ( OnlineResponseData == null ) {
				errorMsg = name + " \uC5D0 \uB300\uD55C Online Response Data \uC815\uBCF4\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			} else {
				// OnlineResponseDataList Hashtable \uC5D0\uC11C \uC0AD\uC81C
				if ( remove.equals( "Yes" ) ) {
					sManager.removeOnlineResponseData( name );
				}
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "OnlineResponseData", OnlineResponseData );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getOnlineRunningServer (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getOnlineRunningServer)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] field:0:required serverIP
		// [o] field:0:required errorMsg
		// [o] recref:0:required OnlineRunningServer JSocketAdapter.DOC:OnlineRunningServer
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		String	serverIP = IDataUtil.getString( pipelineCursor, "serverIP" );
		pipelineCursor.destroy();
		
		IData OnlineRunningServer = null;
		String errorMsg = "";
		
		try {
			name = name + "_" + serverIP;
			OnlineRunningServer = sManager.getOnlineRunningServer( name );
			
			if ( OnlineRunningServer == null ) {
				errorMsg = name + " \uC5D0 \uB300\uD55C Online Running Server \uC815\uBCF4\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "OnlineRunningServer", OnlineRunningServer );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getOnlineSendStatus (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getOnlineSendStatus)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] field:0:required remove {"No","Yes"}
		// [o] field:0:required errorMsg
		// [o] recref:0:required OnlineSendStatus JSocketAdapter.DOC:OnlineSendStatus
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		String	remove = IDataUtil.getString( pipelineCursor, "remove" );
		pipelineCursor.destroy();
		
		IData OnlineSendStatus = null;
		String errorMsg = "";
		
		try {
			OnlineSendStatus = sManager.getOnlineSendStatus( name );
			
			if ( OnlineSendStatus == null ) {
				errorMsg = name + " \uC5D0 \uB300\uD55C Online Send Status \uC815\uBCF4\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			} else {
				// OnlineSendStatusList Hashtable \uC5D0\uC11C \uC0AD\uC81C
				if ( remove.equals( "Yes" ) ) {
					sManager.removeOnlineSendStatus( name );
				}
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "OnlineSendStatus", OnlineSendStatus );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getOnlineServerListener (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getOnlineServerListener)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		// [o] recref:0:required OnlineListenerInfo JSocketAdapter.DOC:OnlineListenerInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	sessionName = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		IData OnlineListenerInfo = null;
		String errorMsg = "";
		
		try {
			OnlineListenerInfo = sManager.getOnlineServerListener( sessionName );
			
			if ( OnlineListenerInfo == null ) {
				errorMsg = sessionName + " \uC5D0 \uB300\uD55C Online Server Listener \uC815\uBCF4\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "OnlineListenerInfo", OnlineListenerInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getOutSocketList (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getOutSocketList)>> ---
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [o] field:0:required errorMsg
		// [o] field:0:required outSocketCount
		// [o] recref:1:required outSocketList JSocketAdapter.DOC:OutSocketInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		int	portNumber = IDataUtil.getInt( pipelineCursor, "portNumber", 0 );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		Hashtable hashTable = null;
		Enumeration hashList = null;
		IData[] outSocketList = null;
		IData socketInfo = null;
		int hashSize = 0;
		
		try {
			hashTable = sManager.getOutSocketList( portNumber );
			
			if ( hashTable != null ) {
				hashSize = hashTable.size();
		
				if ( hashSize > 0 ) {
					hashList = hashTable.elements();
					outSocketList = new IData[ hashSize ];
			
					for ( int i = 0; i < hashSize; i++ ) {
						socketInfo = ( IData )hashList.nextElement();
						outSocketList[ i ] = socketInfo;
					}
				}
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "outSocketCount", hashSize + "" );
		IDataUtil.put( pipelineCursor_1, "outSocketList", outSocketList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getQueueSendInfo (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getQueueSendInfo)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		// [o] recref:0:required QueueSendInfo JSocketAdapter.DOC:QueueSendInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		IData QueueSendInfo = null;
		String errorMsg = "";
		
		try {
			QueueSendInfo = sManager.getQueueSendInfo( name );
			
			if ( QueueSendInfo == null ) {
				errorMsg = name + " \uC5D0 \uB300\uD55C Queue Send Info \uC815\uBCF4\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "QueueSendInfo", QueueSendInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getQueueSize (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getQueueSize)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		// [o] field:0:required queueSize
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		pipelineCursor.destroy();
		
		QueueManager qm = sManager.getQueueManager( queueName );
		String queueSize = qm.getQueueSize();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "queueSize", queueSize );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getRealtimeRequestHeader (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getRealtimeRequestHeader)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] field:0:required remove {"No","Yes"}
		// [o] field:0:required errorMsg
		// [o] recref:0:required RealtimeRequestHeader JSocketAdapter.DOC:OnlineRequestHeader
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		String	remove = IDataUtil.getString( pipelineCursor, "remove" );
		pipelineCursor.destroy();
		
		IData RealtimeRequestHeader = null;
		String errorMsg = "";
		
		try {
			RealtimeRequestHeader = sManager.getRealtimeRequestHeader( name );
			
			if ( RealtimeRequestHeader == null ) {
				errorMsg = name + " \uC5D0 \uB300\uD55C Realtime Synch Request Header \uC815\uBCF4\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			} else {
				// RealtimeRequestHeaderList Hashtable \uC5D0\uC11C \uC0AD\uC81C
				if ( remove.equals( "Yes" ) ) {
					sManager.removeRealtimeRequestHeader( name );
				}
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "RealtimeRequestHeader", RealtimeRequestHeader );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getRestDocIDExtractInfo (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getRestDocIDExtractInfo)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		// [o] recref:0:required RestDocIDExtractInfo JSocketAdapter.DOC:RestDocIDExtractInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		IData RestDocIDExtractInfo = null;
		String errorMsg = "";
		
		try {
			RestDocIDExtractInfo = sManager.getDocIDExtractInfo( name );
			
			if ( RestDocIDExtractInfo == null ) {
				errorMsg = name + " \uAC00 Rest Doc ID Extract Info List \uC5D0 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "RestDocIDExtractInfo", RestDocIDExtractInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getSavedISMemory (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getSavedISMemory)>> ---
		// @sigtype java 3.5
		// [i] field:0:required savedObject
		// [o] record:1:required SavedList
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	savedObject = IDataUtil.getString( pipelineCursor, "savedObject" );
		IData SavedList[] = null;
		SocketServer ssThread = null;
		ThreadPoolSocketServer tpssThread = null;
		AsynchOnlineSocketServer aossThread = null;
		QueueManager qManager = null;
		Object ssObject = null;
		Hashtable hashTable = null;
		Enumeration hashList = null;
		Enumeration keyList = null;
		String[] keyNames = null;
		IDataCursor onlineCur = null;
		IDataCursor socketCur = null;
		String savedName = "";
		int hashSize = 0;
		
		if ( savedObject.equals( "customVariableList" ) ) {
			hashTable = sManager.getCustomVariableList();
		} else if ( savedObject.equals( "socketServerList" ) ) {
			hashTable = sManager.getSocketServerList();
		} else if ( savedObject.equals( "socketRunningServerList" ) ) {
			hashTable = sManager.getSocketRunningServerList();
		} else if ( savedObject.equals( "socketClientList" ) ) {
			hashTable = sManager.getSocketClientList();
		} else if ( savedObject.equals( "docInterfaceIDList" ) ) {
			hashTable = sManager.getDocInterfaceIDList();
		} else if ( savedObject.equals( "docSchemaDefList" ) ) {
			hashTable = sManager.getDocSchemaDefList();
		} else if ( savedObject.equals( "onlineSocketClientList" ) ) {
			hashTable = sManager.getOnlineSocketClientList();
		} else if ( savedObject.equals( "onlineRequestHeaderList" ) ) {
			hashTable = sManager.getOnlineRequestHeaderList();
		} else if ( savedObject.equals( "onlineResponseDataList" ) ) {
			hashTable = sManager.getOnlineResponseDataList();
		} else if ( savedObject.equals( "onlineSendStatusList" ) ) {
			hashTable = sManager.getOnlineSendStatusList();
		} else if ( savedObject.equals( "onlineRunningServerList" ) ) {
			hashTable = sManager.getOnlineRunningServerList();
		} else if ( savedObject.equals( "businessNameList" ) ) {
			hashTable = sManager.getBusinessNameList();
		} else if ( savedObject.equals( "businessInterfaceList" ) ) {
			hashTable = sManager.getBusinessInterfaceList();
		} else if ( savedObject.equals( "businessDocSchemaDefList" ) ) {
			hashTable = sManager.getBusinessDocSchemaDefList();
		} else if ( savedObject.equals( "onlineReconnectingServerList" ) ) {
			hashTable = sManager.getOnlineReconnectingServerList();
		} else if ( savedObject.equals( "onlineReceiveSequenceList" ) ) {
			hashTable = sManager.getOnlineReceiveSequenceList();
		} else if ( savedObject.equals( "onlineSocketQueueList" ) ) {
			hashTable = sManager.getOnlineSocketQueueList();
		} else if ( savedObject.equals( "onlineQueuingList" ) ) {
			hashTable = sManager.getOnlineQueuingList();
		} else if ( savedObject.equals( "onlineSequenceCreationList" ) ) {
			hashTable = sManager.getOnlineSequenceCreationList();
		} else if ( savedObject.equals( "onlineConnectCountList" ) ) {
			hashTable = sManager.getOnlineConnectCountList();
		} else if ( savedObject.equals( "dataQueueKeyList" ) ) {
			hashTable = sManager.getDataQueueKeyList();
		} else if ( savedObject.equals( "onlineServerListenerList" ) ) {
			hashTable = sManager.getOnlineServerListenerList();
		} else if ( savedObject.equals( "onlineClientListenerList" ) ) {
			hashTable = sManager.getOnlineClientListenerList();
		} else if ( savedObject.equals( "onlineHealthCheckList" ) ) {
			hashTable = sManager.getOnlineHealthCheckList();
		} else if ( savedObject.equals( "serialSocketQueueList" ) ) {
			hashTable = sManager.getSerialSocketQueueList();
		} else if ( savedObject.equals( "socketLogQueueList" ) ) {
			hashTable = sManager.getSocketLogQueueList();
		} else if ( savedObject.equals( "realtimeRequestHeaderList" ) ) {
			hashTable = sManager.getRealtimeRequestHeaderList();
		} else if ( savedObject.equals( "queueSendInfoList" ) ) {
			hashTable = sManager.getQueueSendInfoList();
		} else if ( savedObject.equals( "threadIDInfoList" ) ) {
			hashTable = sManager.getThreadIDInfoList();
		} else if ( savedObject.equals( "restApiProtocol" ) ) {
			hashTable = sManager.getDocIDExtractInfoList();
		}
		
		hashSize = hashTable.size();
		hashList = hashTable.elements();
		SavedList = new IData[ hashSize ];
		
		for ( int i = 0; i < hashSize; i++ ) {
			if ( savedObject.equals( "socketRunningServerList" ) ) {
				ssObject = hashList.nextElement();
				
				if ( ssObject instanceof SocketServer ) {
					ssThread = ( SocketServer )ssObject;
					SavedList[ i ] = IDataFactory.create();
					socketCur = SavedList[ i ].getCursor();
					socketCur.insertAfter( "portNumber", ssThread.getPortNumber() + "" );
					socketCur.insertAfter( "servicePath", ssThread.getServicePath() );
					socketCur.insertAfter( "ssocket", ssThread.getServerSocket() );
				} else if ( ssObject instanceof ThreadPoolSocketServer ) {
					tpssThread = ( ThreadPoolSocketServer )ssObject;
					SavedList[ i ] = IDataFactory.create();
					socketCur = SavedList[ i ].getCursor();
					socketCur.insertAfter( "portNumber", tpssThread.getPortNumber() + "" );
					socketCur.insertAfter( "servicePath", tpssThread.getServicePath() );
					socketCur.insertAfter( "ssocket", tpssThread.getServerSocket() );
				} else if ( ssObject instanceof AsynchOnlineSocketServer ) {
					aossThread = ( AsynchOnlineSocketServer )ssObject;
					SavedList[ i ] = IDataFactory.create();
					socketCur = SavedList[ i ].getCursor();
					socketCur.insertAfter( "portNumber", aossThread.getPortNumber() + "" );
					socketCur.insertAfter( "servicePath", aossThread.getServicePath() );
					socketCur.insertAfter( "ssocket", aossThread.getServerSocket() );
				}
			} else if ( savedObject.equals( "onlineSocketQueueList" ) ) {
				ssObject = hashList.nextElement();
				
				if ( ssObject instanceof QueueManager ) {
					qManager = ( QueueManager )ssObject;
					SavedList[ i ] = IDataFactory.create();
					socketCur = SavedList[ i ].getCursor();
					socketCur.insertAfter( "qName", qManager.getQueueName() );
					socketCur.insertAfter( "qCount", qManager.getQueueSize() );
				}
			} else if ( savedObject.equals( "serialSocketQueueList" ) ) {
				ssObject = hashList.nextElement();
				
				if ( ssObject instanceof QueueManager ) {
					qManager = ( QueueManager )ssObject;
					SavedList[ i ] = IDataFactory.create();
					socketCur = SavedList[ i ].getCursor();
					socketCur.insertAfter( "qName", qManager.getQueueName() );
					socketCur.insertAfter( "qCount", qManager.getQueueSize() );
				}
			} else if ( savedObject.equals( "socketLogQueueList" ) ) {
				ssObject = hashList.nextElement();
				
				if ( ssObject instanceof QueueManager ) {
					qManager = ( QueueManager )ssObject;
					SavedList[ i ] = IDataFactory.create();
					socketCur = SavedList[ i ].getCursor();
					socketCur.insertAfter( "qName", qManager.getQueueName() );
					socketCur.insertAfter( "qCount", qManager.getQueueSize() );
				}
			} else if ( savedObject.equals( "onlineConnectCountList" ) ) {
				if ( i == 0 ) {
					keyList = hashTable.keys();
					keyNames = new String[ hashSize ];
					
					for ( int j = 0; j < hashSize; j++ ) {
						keyNames[ j ] = ( String )keyList.nextElement();
					}
				}
				
				SavedList[ i ] = IDataFactory.create();
				socketCur = SavedList[ i ].getCursor();
				socketCur.insertAfter( "connectName", keyNames[ i ] );
				socketCur.insertAfter( "connectCount", ( String )hashList.nextElement() );
			}  else if ( savedObject.equals( "docSchemaDefList" ) ) {
				if ( i == 0 ) {
					keyList = hashTable.keys();
					keyNames = new String[ hashSize ];
					
					for ( int j = 0; j < hashSize; j++ ) {
						keyNames[ j ] = ( String )keyList.nextElement();
					}
				}
				
				SavedList[ i ] = IDataFactory.create();
				socketCur = SavedList[ i ].getCursor();
				socketCur.insertAfter( "docName", keyNames[ i ] );
			} else if ( savedObject.equals( "businessDocSchemaDefList" ) ) {
				if ( i == 0 ) {
					keyList = hashTable.keys();
					keyNames = new String[ hashSize ];
					
					for ( int j = 0; j < hashSize; j++ ) {
						keyNames[ j ] = ( String )keyList.nextElement();
					}
				}
				
				SavedList[ i ] = IDataFactory.create();
				socketCur = SavedList[ i ].getCursor();
				socketCur.insertAfter( "docName", keyNames[ i ] );
			} else {
				SavedList[ i ] = ( IData )hashList.nextElement();
			}
		}
		
		ssThread = null;
		tpssThread = null;
		qManager = null;
		ssObject = null;
		hashTable = null;
		hashList = null;
		keyList = null;
		keyNames = null;
		onlineCur = null;
		socketCur = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "SavedList", SavedList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getSessionCount (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getSessionCount)>> ---
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [o] field:0:required errorMsg
		// [o] field:0:required sessionCount
		IDataCursor pipelineCursor = pipeline.getCursor();
		int	portNumber = IDataUtil.getInt( pipelineCursor, "portNumber", 0 );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		int sessionCount = 0;
		
		try {
			sessionCount = sManager.getSessionCount( portNumber );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "sessionCount", sessionCount + "" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getSocketOperationSwitching (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getSocketOperationSwitching)>> ---
		// @sigtype java 3.5
		// [o] field:0:required socketSwitching
		String socketSwitching = sManager.getSocketOperationSwitching();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "socketSwitching", socketSwitching );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getThreadIDInfo (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getThreadIDInfo)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		// [o] recref:0:required ThreadIDInfo JSocketAdapter.DOC:ThreadIDInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		IData ThreadIDInfo = null;
		String errorMsg = "";
		
		try {
			ThreadIDInfo = sManager.getThreadIDInfo( name );
			
			if ( ThreadIDInfo == null ) {
				errorMsg = name + " \uC5D0 \uB300\uD55C Thread ID Info \uC815\uBCF4\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "ThreadIDInfo", ThreadIDInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putAsynchOnlineSocketServerThread (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putAsynchOnlineSocketServerThread)>> ---
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [i] object:0:required AsynchOnlineSocketServer
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		int portNumber = IDataUtil.getInt( pipelineCursor, "portNumber", 0 );
		AsynchOnlineSocketServer aoss = ( AsynchOnlineSocketServer )IDataUtil.get( pipelineCursor, "AsynchOnlineSocketServer" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putAsynchOnlineSocketServerThread( portNumber, aoss );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putBusinessDocSchemaDef (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putBusinessDocSchemaDef)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required schemaDef
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData schemaDef	= IDataUtil.getIData( pipelineCursor, "schemaDef" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putBusinessDocSchemaDef( name, schemaDef );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putBusinessInterface (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putBusinessInterface)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required BusinessInterfaceInfo
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData BusinessInterfaceInfo	= IDataUtil.getIData( pipelineCursor, "BusinessInterfaceInfo" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putBusinessInterface( name, BusinessInterfaceInfo );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putBusinessName (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putBusinessName)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required BusinessNameInfo
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData BusinessNameInfo	= IDataUtil.getIData( pipelineCursor, "BusinessNameInfo" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		// BusinessNameList Hashtable Creation.
		//createBusinessNameList();
		
		try {
			//BusinessNameList.put( name, BusinessNameInfo );
			sManager.putBusinessName( name, BusinessNameInfo );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putCustomVariable (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putCustomVariable)>> ---
		// @sigtype java 3.5
		// [i] field:0:required variableName
		// [i] record:0:required CustomVariableInfo
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	variableName = IDataUtil.getString( pipelineCursor, "variableName" );
		IData CustomVariableInfo	= IDataUtil.getIData( pipelineCursor, "CustomVariableInfo" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putCustomVariable( variableName, CustomVariableInfo );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putDataQueueKey (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putDataQueueKey)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueKey
		// [i] record:0:required DataQKeyInfo
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	queueKey = IDataUtil.getString( pipelineCursor, "queueKey" );
		IData DataQKeyInfo	= IDataUtil.getIData( pipelineCursor, "DataQKeyInfo" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putDataQueueKey( queueKey, DataQKeyInfo );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putDocInterfaceID (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putDocInterfaceID)>> ---
		// @sigtype java 3.5
		// [i] field:0:required docName
		// [i] record:0:required DocInterfaceIDInfo
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	docName = IDataUtil.getString( pipelineCursor, "docName" );
		IData DocInterfaceIDInfo	= IDataUtil.getIData( pipelineCursor, "DocInterfaceIDInfo" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putDocInterfaceID( docName, DocInterfaceIDInfo );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putDocSchemaDef (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putDocSchemaDef)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required schemaDef
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData schemaDef	= IDataUtil.getIData( pipelineCursor, "schemaDef" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putDocSchemaDef( name, schemaDef );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putOnlineClientListener (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putOnlineClientListener)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required OnlineListenerInfo
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	sessionName = IDataUtil.getString( pipelineCursor, "name" );
		IData OnlineListenerInfo	= IDataUtil.getIData( pipelineCursor, "OnlineListenerInfo" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putOnlineClientListener( sessionName, OnlineListenerInfo );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		OnlineListenerInfo = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putOnlineConnectCount (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putOnlineConnectCount)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] field:0:required conCount
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		String	conCount = IDataUtil.getString( pipelineCursor, "conCount" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putOnlineConnectCount( name, conCount );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
				
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putOnlineHealthCheck (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putOnlineHealthCheck)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required OnlineHealthCheckInfo
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData OnlineHealthCheckInfo	= IDataUtil.getIData( pipelineCursor, "OnlineHealthCheckInfo" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putOnlineHealthCheck( name, OnlineHealthCheckInfo );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		OnlineHealthCheckInfo = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putOnlineReceiveSequence (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putOnlineReceiveSequence)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [i] record:0:required OnlineReceiveSequence
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String NAME = IDataUtil.getString( pipelineCursor, "NAME" );
		IData OnlineReceiveSequence = IDataUtil.getIData( pipelineCursor, "OnlineReceiveSequence" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putOnlineReceiveSequence( NAME, OnlineReceiveSequence );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putOnlineReconnectingServer (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putOnlineReconnectingServer)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [i] record:0:required OnlineReconnectingServer
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String NAME = IDataUtil.getString( pipelineCursor, "NAME" );
		IData OnlineReconnectingServer = IDataUtil.getIData( pipelineCursor, "OnlineReconnectingServer" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putOnlineReconnectingServer( NAME, OnlineReconnectingServer );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putOnlineRequestHeader (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putOnlineRequestHeader)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required OnlineRequestHeader
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData OnlineRequestHeader	= IDataUtil.getIData( pipelineCursor, "OnlineRequestHeader" );
		pipelineCursor.destroy();
		
		IData OnlineRequestHeaderTemp = null;
		String errorMsg = "";
		
		// OnlineRequestHeaderList Hashtable \uC0DD\uC131
		//createOnlineRequestHeaderList();
		
		try {
			// \uAC19\uC740 name \uC758 Online Request Header \uC815\uBCF4\uAC00 \uC774\uBBF8 \uC800\uC7A5\uB418\uC5B4 \uC788\uB294\uC9C0 \uCCB4\uD06C
			//OnlineRequestHeaderTemp = ( IData )OnlineRequestHeaderList.get( name );
			OnlineRequestHeaderTemp = sManager.getOnlineRequestHeader( name );
			
			if ( OnlineRequestHeaderTemp == null ) {
				// OnlineRequestHeaderList Hashtable \uC5D0 Online Request Header \uC815\uBCF4 \uC800\uC7A5
				//OnlineRequestHeaderList.put( name, OnlineRequestHeader );
				sManager.putOnlineRequestHeader( name, OnlineRequestHeader );
			} else {
				errorMsg = name + " \uC5D0 \uB300\uD55C Online Request Header \uC815\uBCF4\uAC00 \uC774\uBBF8 \uC874\uC7AC\uD558\uACE0 \uC788\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		OnlineRequestHeader = null;
		OnlineRequestHeaderTemp = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
			
		// --- <<IS-END>> ---

                
	}



	public static final void putOnlineResponseData (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putOnlineResponseData)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required OnlineResponseData
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData OnlineResponseData	= IDataUtil.getIData( pipelineCursor, "OnlineResponseData" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putOnlineResponseData( name, OnlineResponseData );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		OnlineResponseData = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
			
		// --- <<IS-END>> ---

                
	}



	public static final void putOnlineRunningServer (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putOnlineRunningServer)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [i] field:0:required serverIP
		// [i] record:0:required OnlineRunningServer
		// [i] field:0:required synchOnlineRunning {"","true","false"}
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String NAME = IDataUtil.getString( pipelineCursor, "NAME" );
		String	serverIP = IDataUtil.getString( pipelineCursor, "serverIP" );
		String synchOnlineRunning = IDataUtil.getString( pipelineCursor, "synchOnlineRunning" );
		IData OnlineRunningServer = IDataUtil.getIData( pipelineCursor, "OnlineRunningServer" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		if ( synchOnlineRunning == null ) {
			synchOnlineRunning = "false";
		}
		
		try {
			NAME = NAME + "_" + serverIP;
			// \uBA54\uBAA8\uB9AC\uC5D0 \uC800\uC7A5
			sManager.putOnlineRunningServer( NAME, OnlineRunningServer );
			
			// XML \uD30C\uC77C\uC5D0 \uC800\uC7A5. startupOnlineRunning \uC11C\uBE44\uC2A4\uC5D0\uC11C \uD638\uCD9C\uD558\uB294 \uACBD\uC6B0\uC5D0\uB294 XML \uD30C\uC77C\uC5D0 \uC788\uB294 \uB370\uC774\uD130\uB97C \uC774\uC6A9\uD574\uC11C
			// \uBA54\uBAA8\uB9AC\uC5D0 \uC800\uC7A5\uD558\uB294 \uACBD\uC6B0\uC774\uBBC0\uB85C XML \uD30C\uC77C\uC5D0 \uC800\uC7A5\uD558\uB294 \uBD80\uBD84\uC740 Skip \uD55C\uB2E4.
			// 2019.04.10\uC5D0 \uC544\uB798 \uBD80\uBD84 \uC8FC\uC11D\uCC98\uB9AC
			// Online Running Server \uC815\uBCF4 \uB3D9\uAE30\uD654 \uCC98\uB9AC\uB294 \uB2E4\uB978 \uC6B4\uC601\uC11C\uBC84\uC5D0 \uC788\uB294 \uC815\uBCF4\uB97C \uC774\uC6A9\uD574\uC11C \uC218\uD589\uD558\uB294 \uAC83\uC73C\uB85C \uC218\uC815\uD568.
			/*
			if ( synchOnlineRunning.equals( "true" ) ) {
				
			} else {
				IData inIData = IDataFactory.create();
				IDataCursor inputCursor = inIData.getCursor();
				IDataUtil.put( inputCursor, "OnlineRunningServer", OnlineRunningServer );
				Service.doInvoke( "JSocketAdapter.COMMON.UTIL.FILE", "putOnlineRunningServer", inIData );
				inputCursor.destroy();
			}
			*/
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putOnlineSendStatus (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putOnlineSendStatus)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required OnlineSendStatus
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData OnlineSendStatus	= IDataUtil.getIData( pipelineCursor, "OnlineSendStatus" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putOnlineSendStatus( name, OnlineSendStatus );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		OnlineSendStatus = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
			
		// --- <<IS-END>> ---

                
	}



	public static final void putOnlineServerListener (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putOnlineServerListener)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required OnlineListenerInfo
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	sessionName = IDataUtil.getString( pipelineCursor, "name" );
		IData OnlineListenerInfo	= IDataUtil.getIData( pipelineCursor, "OnlineListenerInfo" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putOnlineServerListener( sessionName, OnlineListenerInfo );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		OnlineListenerInfo = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putQueueSendInfo (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putQueueSendInfo)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required QueueSendInfo
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData QueueSendInfo	= IDataUtil.getIData( pipelineCursor, "QueueSendInfo" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putQueueSendInfo( name, QueueSendInfo );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		QueueSendInfo = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
			
		// --- <<IS-END>> ---

                
	}



	public static final void putRealtimeRequestHeader (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putRealtimeRequestHeader)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required RealtimeRequestHeader
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData RealtimeRequestHeader	= IDataUtil.getIData( pipelineCursor, "RealtimeRequestHeader" );
		pipelineCursor.destroy();
		
		IData RealtimeRequestHeaderTemp = null;
		String errorMsg = "";
		
		try {
			// \uAC19\uC740 name \uC758 Realtime Synch Request Header \uC815\uBCF4\uAC00 \uC774\uBBF8 \uC800\uC7A5\uB418\uC5B4 \uC788\uB294\uC9C0 \uCCB4\uD06C
			RealtimeRequestHeaderTemp = sManager.getRealtimeRequestHeader( name );
			
			if ( RealtimeRequestHeaderTemp == null ) {
				// RealtimeRequestHeaderList Hashtable \uC5D0 Realtime Synch Request Header \uC815\uBCF4 \uC800\uC7A5
				sManager.putRealtimeRequestHeader( name, RealtimeRequestHeader );
			} else {
				errorMsg = name + " \uC5D0 \uB300\uD55C Realtime Synch Request Header \uC815\uBCF4\uAC00 \uC774\uBBF8 \uC874\uC7AC\uD558\uACE0 \uC788\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		RealtimeRequestHeader = null;
		RealtimeRequestHeaderTemp = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
			
		// --- <<IS-END>> ---

                
	}



	public static final void putRestDocIDExtractInfo (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putRestDocIDExtractInfo)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required RestDocIDExtractInfo
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData RestDocIDExtractInfo	= IDataUtil.getIData( pipelineCursor, "RestDocIDExtractInfo" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putDocIDExtractInfo( name, RestDocIDExtractInfo );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putThreadIDInfo (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putThreadIDInfo)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required ThreadIDInfo
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData ThreadIDInfo	= IDataUtil.getIData( pipelineCursor, "ThreadIDInfo" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.putThreadIDInfo( name, ThreadIDInfo );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		ThreadIDInfo = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void reduceConnectedSessionCount (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(reduceConnectedSessionCount)>> ---
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [i] field:0:required threadPool
		IDataCursor pipelineCursor = pipeline.getCursor();
		String portNumber = IDataUtil.getString( pipelineCursor, "portNumber" );
		String threadPool = IDataUtil.getString( pipelineCursor, "threadPool" );
		pipelineCursor.destroy();
		
		sManager.reduceConnectedSessionCount( Integer.parseInt( portNumber ), threadPool );
		// --- <<IS-END>> ---

                
	}



	public static final void reduceOnlineConnectCount (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(reduceOnlineConnectCount)>> ---
		// @sigtype java 3.5
		// [i] field:0:required serverIP
		// [i] field:0:required portNumber
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	serverIP = IDataUtil.getString( pipelineCursor, "serverIP" );
		String	portNumber = IDataUtil.getString( pipelineCursor, "portNumber" );
		pipelineCursor.destroy();
		
		String name = "Connect_" + serverIP + "_" + portNumber;
		String conCount = sManager.getOnlineConnectCount( name );
		
		if ( conCount.equals( "0" ) ) {
			// Reduce Skip
		} else {
			sManager.reduceOnlineConnectCount( name );
		}
		// --- <<IS-END>> ---

                
	}



	public static final void removeBusinessDocSchemaDef (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeBusinessDocSchemaDef)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.removeBusinessDocSchemaDef( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeBusinessInterface (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeBusinessInterface)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.removeBusinessInterface( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeBusinessName (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeBusinessName)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			//BusinessNameList.remove( name );
			sManager.removeBusinessName( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeCustomVariable (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeCustomVariable)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.removeCustomVariable( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeDataQueueKey (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeDataQueueKey)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.removeDataQueueKey( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeDocInterfaceID (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeDocInterfaceID)>> ---
		// @sigtype java 3.5
		// [i] field:0:required docName
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	docName = IDataUtil.getString( pipelineCursor, "docName" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.removeDocInterfaceID( docName );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeDocSchemaDef (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeDocSchemaDef)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.removeDocSchemaDef( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOnlineClientListener (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOnlineClientListener)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	sessionName = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			// OnlineClientListenerList Hashtable \uC5D0\uC11C \uC0AD\uC81C
			sManager.removeOnlineClientListener( sessionName );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOnlineConnectCount (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOnlineConnectCount)>> ---
		// @sigtype java 3.5
		// [i] field:0:required remoteServerIP
		// [i] field:0:required remotePortNumber
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	serverIP = IDataUtil.getString( pipelineCursor, "remoteServerIP" );
		String	portNumber = IDataUtil.getString( pipelineCursor, "remotePortNumber" );
		pipelineCursor.destroy();
		
		String name = "Connect_" + serverIP + "_" + portNumber;
		sManager.removeOnlineConnectCount( name );
		// --- <<IS-END>> ---

                
	}



	public static final void removeOnlineHealthCheck (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOnlineHealthCheck)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			// OnlineHealthCheckList Hashtable \uC5D0\uC11C \uC0AD\uC81C
			sManager.removeOnlineHealthCheck( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOnlineQueuing (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOnlineQueuing)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.removeOnlineQueuing( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOnlineReceiveSequence (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOnlineReceiveSequence)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.removeOnlineReceiveSequence( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOnlineReconnectingServer (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOnlineReconnectingServer)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.removeOnlineReconnectingServer( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOnlineRequestHeader (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOnlineRequestHeader)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			// OnlineRequestHeaderList Hashtable \uC5D0\uC11C \uC0AD\uC81C
			//OnlineRequestHeaderList.remove( name );
			sManager.removeOnlineRequestHeader( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOnlineResponseData (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOnlineResponseData)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			// OnlineResponseDataList Hashtable \uC5D0\uC11C \uC0AD\uC81C
			sManager.removeOnlineResponseData( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOnlineRunningServer (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOnlineRunningServer)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [i] field:0:required serverIP
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "NAME" );
		String	serverIP = IDataUtil.getString( pipelineCursor, "serverIP" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			name = name + "_" + serverIP;
			// \uBA54\uBAA8\uB9AC\uC5D0\uC11C \uC0AD\uC81C
			sManager.removeOnlineRunningServer( name );
			
			// XML \uD30C\uC77C\uC5D0\uC11C \uC0AD\uC81C
			// 2019.04.10\uC5D0 \uC544\uB798 \uBD80\uBD84 \uC8FC\uC11D\uCC98\uB9AC
			// Online Running Server \uC815\uBCF4 \uB3D9\uAE30\uD654 \uCC98\uB9AC\uB294 \uB2E4\uB978 \uC6B4\uC601\uC11C\uBC84\uC5D0 \uC788\uB294 \uC815\uBCF4\uB97C \uC774\uC6A9\uD574\uC11C \uC218\uD589\uD558\uB294 \uAC83\uC73C\uB85C \uC218\uC815\uD568.
			/*
			IData inIData = IDataFactory.create();
			IDataCursor inputCursor = inIData.getCursor();
			IDataUtil.put( inputCursor, "savedName", name );
			Service.doInvoke( "JSocketAdapter.COMMON.UTIL.FILE", "removeOnlineRunningServer", inIData );
			inputCursor.destroy();
			*/
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOnlineSendStatus (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOnlineSendStatus)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			// OnlineSendStatusList Hashtable \uC5D0\uC11C \uC0AD\uC81C
			sManager.removeOnlineSendStatus( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOnlineSequenceCreation (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOnlineSequenceCreation)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.removeOnlineSequenceCreation( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOnlineServerListener (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOnlineServerListener)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	sessionName = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			// OnlineServerListenerList Hashtable \uC5D0\uC11C \uC0AD\uC81C
			sManager.removeOnlineServerListener( sessionName );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOutSocket (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOutSocket)>> ---
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [i] field:0:required sessionName
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		int	portNumber = IDataUtil.getInt( pipelineCursor, "portNumber", 0 );
		String	name = IDataUtil.getString( pipelineCursor, "sessionName" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		int sessionCount = 0;
		
		try {
			sManager.removeOutSocket( portNumber, name );
			sessionCount = sManager.getSessionCount( portNumber );
			
			if ( sessionCount < 0 ) {
				sManager.setSessionCount( portNumber, 0 );
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOutSocket2 (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOutSocket2)>> ---
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [i] field:0:required sessionName
		// [i] field:0:required closingSide {"Server","Client"}
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		int	portNumber = IDataUtil.getInt( pipelineCursor, "portNumber", 0 );
		String	name = IDataUtil.getString( pipelineCursor, "sessionName" );
		String	closingSide = IDataUtil.getString( pipelineCursor, "closingSide" );
		pipelineCursor.destroy();
		
		if ( closingSide == null || closingSide.equals( "" ) ) {
			closingSide = "Unknown";
		}
		
		String errorMsg = "";
		int sessionCount = 0;
		
		try {
			sManager.removeOutSocket( portNumber, name, closingSide );
			sessionCount = sManager.getSessionCount( portNumber );
			
			if ( sessionCount < 0 ) {
				sManager.setSessionCount( portNumber, 0 );
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeQueueSendInfo (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeQueueSendInfo)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			// QueueSendInfoList Hashtable \uC5D0\uC11C \uC0AD\uC81C
			sManager.removeQueueSendInfo( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeRealtimeRequestHeader (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeRealtimeRequestHeader)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			// RealtimeRequestHeaderList Hashtable \uC5D0\uC11C \uC0AD\uC81C
			sManager.removeRealtimeRequestHeader( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeRestDocIDExtractInfo (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeRestDocIDExtractInfo)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.removeDocIDExtractInfo( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeThreadIDInfo (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeThreadIDInfo)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			// ThreadIDInfoList Hashtable \uC5D0\uC11C \uC0AD\uC81C
			sManager.removeThreadIDInfo( name );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void runningOnlineSocketClient (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(runningOnlineSocketClient)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required running
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		pipelineCursor.destroy();
		
		IData OnlineSocketClient = null;
		String running = "";
		
		try {
			OnlineSocketClient = sManager.getOnlineSocketClient( name );
			
			if ( OnlineSocketClient == null ) {
				running = "false";
			} else {
				running = "true";
			}
		} catch ( Exception e ) {
			running = "false";
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "running", running );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void setCcsid (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(setCcsid)>> ---
		// @sigtype java 3.5
		// [i] field:0:required ccsid
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	ccsid = IDataUtil.getString( pipelineCursor, "ccsid" );
		pipelineCursor.destroy();
		
		sManager.setCcsid( ccsid );
		// --- <<IS-END>> ---

                
	}



	public static final void setSessionCount (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(setSessionCount)>> ---
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [i] field:0:required sessionCount
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		int	portNumber = IDataUtil.getInt( pipelineCursor, "portNumber", 0 );
		int	sessionCount = IDataUtil.getInt( pipelineCursor, "sessionCount", 0 );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.setSessionCount( portNumber, sessionCount );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void setSocketOperationSwitching (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(setSocketOperationSwitching)>> ---
		// @sigtype java 3.5
		// [i] field:0:required socketSwitching {"true","false"}
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	socketSwitching = IDataUtil.getString( pipelineCursor, "socketSwitching" );
		pipelineCursor.destroy();
		
		sManager.setSocketOperationSwitching( socketSwitching );
		// --- <<IS-END>> ---

                
	}



	public static final void updateOutSocketUsing (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(updateOutSocketUsing)>> ---
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [i] field:0:required socketName
		// [i] field:0:required using {"true","false"}
		IDataCursor pipelineCursor = pipeline.getCursor();
		int	portNumber = IDataUtil.getInt( pipelineCursor, "portNumber", 0 );
		String	name = IDataUtil.getString( pipelineCursor, "socketName" );
		String using = IDataUtil.getString( pipelineCursor, "using" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			sManager.updateOutSocketUsing( portNumber, name, using );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void updateQueueSendInfo (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(updateQueueSendInfo)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [i] record:0:required QueueSendInfo
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData QueueSendInfo	= IDataUtil.getIData( pipelineCursor, "QueueSendInfo" );
		pipelineCursor.destroy();
		
		IData TempQueueSendInfo = null;
		String errorMsg = "";
		
		try {
			TempQueueSendInfo = sManager.getQueueSendInfo( name );
			
			if ( TempQueueSendInfo == null ) {
				errorMsg = name + " \uC5D0 \uB300\uD55C Queue Send Info \uC815\uBCF4\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			} else {
				sManager.putQueueSendInfo( name, QueueSendInfo );
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		QueueSendInfo = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
			
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	
	//private static Hashtable OnlineRequestHeaderList = null;
	//private static Hashtable BusinessNameList = null;
	private static SocketManager sManager = SocketManager.getInstance();
	
	/*
	private static void createOnlineRequestHeaderList() {
		if ( OnlineRequestHeaderList == null ) {
			OnlineRequestHeaderList = new Hashtable();
		}
	}
	*/
	
	/*
	private static void createBusinessNameList() {
		if ( BusinessNameList == null ) {
			BusinessNameList = new Hashtable();
		}
	}
	*/
	
	public static synchronized String existOnlineReconnecting( String name, IData inputData ) {
		IData OnlineReconnectingServer = null;
		String exist = "";
		
		try {
			OnlineReconnectingServer = sManager.getOnlineReconnectingServer( name );
			
			if ( OnlineReconnectingServer == null ) {
				exist = "false";
				sManager.putOnlineReconnectingServer( name, inputData );
			} else {
				exist = "true";				
			}
		} catch ( Exception e ) {
		
		}
		
		OnlineReconnectingServer = null;
		
		return exist;
	}
		
	// --- <<IS-END-SHARED>> ---
}

