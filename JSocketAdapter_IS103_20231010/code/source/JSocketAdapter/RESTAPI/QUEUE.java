package JSocketAdapter.RESTAPI;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import custom.java.com.log.DebugLogger;
import custom.java.socket.manager.*;
// --- <<IS-END-IMPORTS>> ---

public final class QUEUE

{
	// ---( internal utility methods )---

	final static QUEUE _instance = new QUEUE();

	static QUEUE _newInstance() { return new QUEUE(); }

	static QUEUE _cast(Object o) { return (QUEUE)o; }

	// ---( server methods )---




	public static final void sendDataFromSerialQueue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sendDataFromSerialQueue)>> ---
		// @sigtype java 3.5
		// [i] field:0:required queueName
		// [i] field:0:required disServiceFolder
		// [i] field:0:required disServiceName
		IDataCursor pipelineCursor = pipeline.getCursor();
		String queueName = IDataUtil.getString( pipelineCursor, "queueName" );
		String disServiceFolder = IDataUtil.getString( pipelineCursor, "disServiceFolder" );		
		String disServiceName = IDataUtil.getString( pipelineCursor, "disServiceName" );
		pipelineCursor.destroy();
		
		debugLogger.printLogAtIS( "### [" + queueName + " Serial Queue Sender] JSocketAdapter.RESTAPI.QUEUE:sendDataFromSerialQueue Start ###" );
		
		QueueManager qm = null;
		IData INPUT_DATA = null;
		IData outputData = null;				
		
		try {
			while ( true ) {
				// Queue\uAC00 \uC874\uC7AC\uD558\uB294\uC9C0 \uD655\uC778
				qm = sManager.getSerialQueueManager( queueName );
			
				if ( qm == null ) {
					// Queue\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0 ==> Basic Info > REST API Protocol \uBA54\uB274\uC5D0\uC11C Protocol \uC815\uBCF4\uB97C \uC0AD\uC81C\uD55C \uACBD\uC6B0 ==> \uB370\uBAAC \uC885\uB8CC
					break;
				}
			
				// Queue \uC5D0 \uB370\uC774\uD130\uAC00 \uC874\uC7AC\uD558\uBA74 \uBA3C\uC800 \uB4E4\uC5B4\uC628 \uC21C\uC11C\uB300\uB85C \uCC98\uB9AC \uD55C\uB2E4.
				INPUT_DATA = sManager.pollSerialQueue( queueName );
			
				if ( INPUT_DATA == null ) {
					Thread.sleep( 10 );
				} else {
					// \uC804\uBB38 \uCC98\uB9AC \uC2DC Serial \uD558\uAC8C \uCC98\uB9AC\uD558\uAE30 \uC704\uD574\uC11C doThreadInvoke\uB97C \uC0AC\uC6A9\uD558\uC9C0 \uC54A\uACE0 doInvoke\uB97C \uC0AC\uC6A9\uD55C\uB2E4.
					outputData = Service.doInvoke( disServiceFolder, disServiceName, INPUT_DATA );
				}
				
				INPUT_DATA = null;
				outputData = null;
			}
		} catch ( Exception e ) {
			
		}
		
		qm = null;
		INPUT_DATA = null;
		outputData = null;
		
		debugLogger.printLogAtIS( "### [" + queueName + " Serial Queue Sender] JSocketAdapter.RESTAPI.QUEUE:sendDataFromSerialQueue End ###" );
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static DebugLogger debugLogger = new DebugLogger();
	private static SocketManager sManager = SocketManager.getInstance();
	// --- <<IS-END-SHARED>> ---
}

