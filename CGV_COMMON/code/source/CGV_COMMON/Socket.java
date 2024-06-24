package CGV_COMMON;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;
// --- <<IS-END-IMPORTS>> ---

public final class Socket

{
	// ---( internal utility methods )---

	final static Socket _instance = new Socket();

	static Socket _newInstance() { return new Socket(); }

	static Socket _cast(Object o) { return (Socket)o; }

	// ---( server methods )---




	public static final void jSocket (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(jSocket)>> ---
		// @sigtype java 3.5
		String ipAddr="127.0.0.1";
		int port=2222;
		
		System.out.println("\uC5F0\uACB0 \uC694\uCCAD\uC911 ...");
		
		try {
		Socket sock = new Socket(ipAddr, port);
		} catch (UnknownHostException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}
		
		System.out.println("\uC5F0\uACB0 \uC131\uACF5");
		// --- <<IS-END>> ---

                
	}
}

