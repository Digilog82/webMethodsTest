package JSocketAdapter.COMMON.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;
import java.net.UnknownHostException;
// --- <<IS-END-IMPORTS>> ---

public final class NETWORK

{
	// ---( internal utility methods )---

	final static NETWORK _instance = new NETWORK();

	static NETWORK _newInstance() { return new NETWORK(); }

	static NETWORK _cast(Object o) { return (NETWORK)o; }

	// ---( server methods )---




	public static final void checkTargetConnection (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(checkTargetConnection)>> ---
		// @sigtype java 3.5
		// [i] field:0:required IP
		// [i] field:0:required PORT
		// [i] field:0:required connectTimeout
		// [o] field:0:required connect
		// [o] field:0:required firewallOpen
		// [o] field:0:required errorMsg
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String IP = IDataUtil.getString( pipelineCursor, "IP" );
		int PORT = IDataUtil.getInt( pipelineCursor, "PORT", 0 );
		int connectTimeout = IDataUtil.getInt( pipelineCursor, "connectTimeout", 0 );
		
		String connect = "";
		String firewallOpen = "";
		String errorMsg = "";
		String tempMsg = "";
		SocketAddress target = null;
		Socket socket = null;
		
		try {		
			if ( PORT == 0 ) {
				throw new ServiceException( "Port \uBC88\uD638\uB97C \uC785\uB825\uD574\uC57C \uD569\uB2C8\uB2E4." );
			}
			
			if ( connectTimeout == 0 ) {
				connectTimeout = 5;
			}
		
			target = new InetSocketAddress( IP, PORT );
			socket = new Socket();
			socket.connect( target, connectTimeout * 1000 ); // connectTimeout \uCD08 \uC548\uC5D0 \uC5F0\uACB0\uC774 \uC548 \uB418\uBA74 Time Out \uBC1C\uC0DD.
			connect = "true";
			firewallOpen = "true";
		} catch ( Exception e ) {
			errorMsg = e.toString();
			tempMsg = errorMsg.toLowerCase();
			
			if ( tempMsg.indexOf( "connect timed out" ) > 0 ) {
				connect = "false";
				firewallOpen = "false";
			} else if ( tempMsg.indexOf( "connection refused" ) > 0 ) {
				connect = "false";
				firewallOpen = "true";
			} else {
				connect = "false";
				firewallOpen = "unknown";
			}
		} finally {
			try {
				if ( socket != null ) {
					socket.close();
				}
			} catch ( Exception fe ) {
				errorMsg = fe.toString();
			}
		}
		
		target = null;
		socket = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "connect", connect );
		IDataUtil.put( pipelineCursor_1, "firewallOpen", firewallOpen );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}
}

