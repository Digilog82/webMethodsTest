package JSocketAdapter.COMMON.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import custom.java.com.log.DebugLogger;
import custom.java.socket.manager.*;
import java.util.Hashtable;
import java.util.Queue;
// --- <<IS-END-IMPORTS>> ---

public final class QUEUE

{
	// ---( internal utility methods )---

	final static QUEUE _instance = new QUEUE();

	static QUEUE _newInstance() { return new QUEUE(); }

	static QUEUE _cast(Object o) { return (QUEUE)o; }

	// ---( server methods )---




	public static final void clearQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(clearQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		// [i] field:0:required folderPath
		// [i] field:0:required serviceName
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		String folderPath = IDataUtil.getString( pipelineCursor, "folderPath" );
		String serviceName = IDataUtil.getString( pipelineCursor, "serviceName" );
		pipelineCursor.destroy();
		
		IData INPUT_DATA = null;
		IData outputData = null;
		
		try {
			// Queue \uC5D0 \uB370\uC774\uD130\uAC00 \uC874\uC7AC\uD558\uBA74 \uBA3C\uC800 \uB4E4\uC5B4\uC628 \uC21C\uC11C\uB300\uB85C \uC804\uC1A1\uCC98\uB9AC \uD55C\uB2E4.
			while( true ) {
				INPUT_DATA = sManager.pollQueue( queueName );
				
				if ( INPUT_DATA == null ) {
					Thread.sleep( 100 );
					break;
				} else {
					// \uC804\uBB38 \uCC98\uB9AC \uC2DC Serial \uD558\uAC8C \uCC98\uB9AC\uD558\uAE30 \uC704\uD574\uC11C doThreadInvoke\uB97C \uC0AC\uC6A9\uD558\uC9C0 \uC54A\uACE0 doInvoke\uB97C \uC0AC\uC6A9\uD55C\uB2E4.
					outputData = Service.doInvoke( folderPath, serviceName, INPUT_DATA );
				}
			}
		} catch ( Exception e ) {
			
		}
		// --- <<IS-END>> ---

                
	}



	public static final void clearSerialQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(clearSerialQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		// [i] field:0:required folderPath
		// [i] field:0:required serviceName
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		String folderPath = IDataUtil.getString( pipelineCursor, "folderPath" );
		String serviceName = IDataUtil.getString( pipelineCursor, "serviceName" );
		pipelineCursor.destroy();
		
		IData INPUT_DATA = null;
		IData outputData = null;
		
		try {
			// Queue \uC5D0 \uB370\uC774\uD130\uAC00 \uC874\uC7AC\uD558\uBA74 \uBA3C\uC800 \uB4E4\uC5B4\uC628 \uC21C\uC11C\uB300\uB85C \uCC98\uB9AC \uD55C\uB2E4.
			while( true ) {
				INPUT_DATA = sManager.pollSerialQueue( queueName );
				
				if ( INPUT_DATA == null ) {
					Thread.sleep( 100 );
					break;
				} else {
					// \uC804\uBB38 \uCC98\uB9AC \uC2DC Serial \uD558\uAC8C \uCC98\uB9AC\uD558\uAE30 \uC704\uD574\uC11C doThreadInvoke\uB97C \uC0AC\uC6A9\uD558\uC9C0 \uC54A\uACE0 doInvoke\uB97C \uC0AC\uC6A9\uD55C\uB2E4.
					outputData = Service.doInvoke( folderPath, serviceName, INPUT_DATA );
				}
			}
		} catch ( Exception e ) {
			
		}
		// --- <<IS-END>> ---

                
	}



	public static final void clearSocketLogQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(clearSocketLogQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		pipelineCursor.destroy();
		
		IData INPUT_DATA = null;
		IData outputData = null;
		IDataCursor cur = null;
		String writeService = "";
		String[] folderService = null;
		String folderPath = "";
		String serviceName = "";
		
		try {
			// Queue \uC5D0 \uB370\uC774\uD130\uAC00 \uC874\uC7AC\uD558\uBA74 \uBA3C\uC800 \uB4E4\uC5B4\uC628 \uC21C\uC11C\uB300\uB85C \uCC98\uB9AC \uD55C\uB2E4.
			while( true ) {
				INPUT_DATA = sManager.pollSocketLogQueue( queueName );
				
				if ( INPUT_DATA == null ) {
					break;
				} else {
					cur = INPUT_DATA.getCursor();
					writeService = IDataUtil.getString( cur, "writeService" );
					folderService = writeService.split( ":" );
					folderPath = folderService[ 0 ];
					serviceName = folderService[ 1 ];
					
					// \uAC19\uC740 \uD30C\uC77C\uC5D0 \uB3D9\uC2DC \uC811\uADFC\uD558\uB294 \uAC83\uC744 \uBC29\uC9C0\uD558\uAE30 \uC704\uD574\uC11C doThreadInvoke\uB97C \uC0AC\uC6A9\uD558\uC9C0 \uC54A\uACE0 doInvoke\uB97C \uC0AC\uC6A9\uD55C\uB2E4.
					outputData = Service.doInvoke( folderPath, serviceName, INPUT_DATA );
					
					cur.destroy();
					INPUT_DATA = null;
					outputData = null;
					folderService = null;
				}
			}
		} catch ( Exception e ) {
			
		}
		// --- <<IS-END>> ---

                
	}



	public static final void createQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		pipelineCursor.destroy();
		
		sManager.createQueue( queueName );
		// --- <<IS-END>> ---

                
	}



	public static final void createSerialQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createSerialQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		pipelineCursor.destroy();
		
		sManager.createSerialQueue( queueName );
		// --- <<IS-END>> ---

                
	}



	public static final void createSocketLogQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createSocketLogQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		pipelineCursor.destroy();
		
		sManager.createSocketLogQueue( queueName );
		// --- <<IS-END>> ---

                
	}



	public static final void offerQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(offerQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		// [i] record:0:required INPUT_DATA
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		IData INPUT_DATA	= IDataUtil.getIData( pipelineCursor, "INPUT_DATA" );
		pipelineCursor.destroy();
		
		sManager.offerQueue( queueName, INPUT_DATA );
		INPUT_DATA = null;
		// --- <<IS-END>> ---

                
	}



	public static final void offerSerialQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(offerSerialQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		// [i] record:0:required INPUT_DATA
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		IData INPUT_DATA	= IDataUtil.getIData( pipelineCursor, "INPUT_DATA" );
		pipelineCursor.destroy();
		
		sManager.offerSerialQueue( queueName, INPUT_DATA );
		INPUT_DATA = null;
		// --- <<IS-END>> ---

                
	}



	public static final void offerSocketLogQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(offerSocketLogQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		// [i] record:0:required INPUT_DATA
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		IData INPUT_DATA	= IDataUtil.getIData( pipelineCursor, "INPUT_DATA" );
		pipelineCursor.destroy();
		
		sManager.offerSocketLogQueue( queueName, INPUT_DATA );
		INPUT_DATA = null;
		// --- <<IS-END>> ---

                
	}



	public static final void pollSerialQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(pollSerialQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		// [o] field:0:required exist
		// [o] record:0:required INPUT_DATA
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		pipelineCursor.destroy();
		
		String exist = "true";
		IData INPUT_DATA = null;
		
		try {
			// Queue \uC5D0 \uB370\uC774\uD130\uAC00 \uC874\uC7AC\uD558\uBA74 \uBA3C\uC800 \uB4E4\uC5B4\uC628 \uC21C\uC11C\uB300\uB85C \uCC98\uB9AC \uD55C\uB2E4.
			INPUT_DATA = sManager.pollSerialQueue( queueName );
			
			if ( INPUT_DATA == null ) {
				exist = "false";
			}
		} catch ( Exception e ) {
			
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exist", exist );
		IDataUtil.put( pipelineCursor_1, "INPUT_DATA", INPUT_DATA );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void pollSocketLogQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(pollSocketLogQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		// [o] field:0:required exist
		// [o] record:0:required INPUT_DATA
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		pipelineCursor.destroy();
		
		String exist = "true";
		IData INPUT_DATA = null;
		
		try {
			// Queue \uC5D0 \uB370\uC774\uD130\uAC00 \uC874\uC7AC\uD558\uBA74 \uBA3C\uC800 \uB4E4\uC5B4\uC628 \uC21C\uC11C\uB300\uB85C \uCC98\uB9AC \uD55C\uB2E4.
			INPUT_DATA = sManager.pollSocketLogQueue( queueName );
			
			if ( INPUT_DATA == null ) {
				exist = "false";
			}
		} catch ( Exception e ) {
			
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exist", exist );
		IDataUtil.put( pipelineCursor_1, "INPUT_DATA", INPUT_DATA );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		pipelineCursor.destroy();
		
		sManager.removeQueue( queueName );
		// --- <<IS-END>> ---

                
	}



	public static final void removeSerialQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeSerialQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		pipelineCursor.destroy();
		
		sManager.removeSerialQueue( queueName );
		// --- <<IS-END>> ---

                
	}



	public static final void removeSocketLogQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeSocketLogQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		pipelineCursor.destroy();
		
		sManager.removeSocketLogQueue( queueName );
		// --- <<IS-END>> ---

                
	}



	public static final void sendDataFromSocketLogQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sendDataFromSocketLogQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		// [i] field:0:required customVariable
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		String customVariable = IDataUtil.getString( pipelineCursor, "customVariable" );		
		pipelineCursor.destroy();
		
		debugLogger.printLogAtIS( "### [" + queueName + " Socket Log Queue Sender] JSocketAdapter.COMMON.UTIL.QUEUE:sendDataFromSocketLogQueue Start ###" );
		
		IData INPUT_DATA = null;
		IData outputData = null;
		IDataCursor cur = null;
		String writeService = "";
		String[] folderService = null;
		String folderPath = "";
		String serviceName = "";
		
		IData CustomVariableInfo = null;
		IDataCursor outCursor = null;
		String customVariableValue = "";
		
		try {
			// Queue \uC5D0 \uB370\uC774\uD130\uAC00 \uC874\uC7AC\uD558\uBA74 \uBA3C\uC800 \uB4E4\uC5B4\uC628 \uC21C\uC11C\uB300\uB85C \uCC98\uB9AC \uD55C\uB2E4.
			while ( true ) {
				CustomVariableInfo = sManager.getCustomVariable( customVariable );
				outCursor = CustomVariableInfo.getCursor();
				customVariableValue = IDataUtil.getString( outCursor, "variableValue" );
				
				if ( customVariableValue.equals( "false" ) ) {
					// \uB85C\uADF8\uB97C \uC800\uC7A5\uD558\uC9C0 \uC54A\uB3C4\uB85D \uC124\uC815\uB418\uC5B4 \uC788\uB294 \uACBD\uC6B0 ==> \uB370\uBAAC \uC885\uB8CC
					outCursor.destroy();
					CustomVariableInfo = null;
					break;
				} else {
					// \uB85C\uADF8\uB97C \uC800\uC7A5\uD558\uB3C4\uB85D \uC124\uC815\uB418\uC5B4 \uC788\uB294 \uACBD\uC6B0 ==> Continue
					outCursor.destroy();
					CustomVariableInfo = null;
				}
				
				INPUT_DATA = sManager.pollSocketLogQueue( queueName );
				
				if ( INPUT_DATA == null ) {
					Thread.sleep( 10 );
				} else {
					cur = INPUT_DATA.getCursor();
					writeService = IDataUtil.getString( cur, "writeService" );
					folderService = writeService.split( ":" );
					folderPath = folderService[ 0 ];
					serviceName = folderService[ 1 ];
					
					// \uAC19\uC740 \uD30C\uC77C\uC5D0 \uB3D9\uC2DC \uC811\uADFC\uD558\uB294 \uAC83\uC744 \uBC29\uC9C0\uD558\uAE30 \uC704\uD574\uC11C doThreadInvoke\uB97C \uC0AC\uC6A9\uD558\uC9C0 \uC54A\uACE0 doInvoke\uB97C \uC0AC\uC6A9\uD55C\uB2E4.
					outputData = Service.doInvoke( folderPath, serviceName, INPUT_DATA );
					
					cur.destroy();
					INPUT_DATA = null;
					outputData = null;
					folderService = null;
				}
			}
		} catch ( Exception e ) {
			
		}
		
		debugLogger.printLogAtIS( "### [" + queueName + " Socket Log Queue Sender] JSocketAdapter.COMMON.UTIL.QUEUE:sendDataFromSocketLogQueue End ###" );
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static SocketManager sManager = SocketManager.getInstance();
	private static DebugLogger debugLogger = new DebugLogger();
	// --- <<IS-END-SHARED>> ---
}

