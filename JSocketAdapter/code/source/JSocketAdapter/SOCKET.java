package JSocketAdapter;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.OutputStream;
import java.io.InputStream;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.util.Vector;
import java.io.*;
import java.net.Socket;
import java.net.SocketException;
import javax.crypto.Cipher;
import custom.java.com.log.DebugLogger;
import custom.java.socket.manager.*;
// --- <<IS-END-IMPORTS>> ---

public final class SOCKET

{
	// ---( internal utility methods )---

	final static SOCKET _instance = new SOCKET();

	static SOCKET _newInstance() { return new SOCKET(); }

	static SOCKET _cast(Object o) { return (SOCKET)o; }

	// ---( server methods )---




	public static final void checkLocalServerPort (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(checkLocalServerPort)>> ---
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [i] field:0:required online
		// [o] field:0:required runningStatus
		// [o] field:0:required listening
		IDataCursor	pipelineCursor = pipeline.getCursor();
		String portNumber = IDataUtil.getString( pipelineCursor, "portNumber" );
		String online = IDataUtil.getString( pipelineCursor, "online" );
		pipelineCursor.destroy();
		
		if ( online == null ) {
			online = "";
		}
		
		String runningStatus = sManager.runningStatus( Integer.parseInt( portNumber ) ) + "";
		String listening = "";
		boolean isClosed;
		
		if ( online.equals( "Yes" ) ) {
			if ( runningStatus.equals( "true" ) ) {
				isClosed = sManager.getAsynchOnlineSocketServerThread( Integer.parseInt( portNumber ) ).getServerSocket().isClosed();
			
				if ( isClosed == true ) {
					listening = "No";
				} else {
					listening = "Yes";
				}
			} else {
				listening = "No";
			}
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "runningStatus", runningStatus );
		IDataUtil.put( pipelineCursor_1, "listening", listening );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void checkSocketStatus (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(checkSocketStatus)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] object:0:required socket
		// [o] field:0:required isClosed
		// [o] field:0:required isConnected
		IDataCursor	pipelineCursor = pipeline.getCursor();
		Socket socket = ( Socket )IDataUtil.get( pipelineCursor, "socket" );
		pipelineCursor.destroy();
		
		String isClosed	= "";
		String isConnected = "";
		
		try {
			isClosed = socket.isClosed( ) + "" ;
			isConnected	= socket.isConnected() + "";
		} catch( Exception e ){
			debugLogger.printLogAtIS( "### checkSocketStatus Error : " + e.toString(), "asynch" );
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "isClosed", isClosed );
		IDataUtil.put( pipelineCursor_1, "isConnected", isConnected );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void closeSocket (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(closeSocket)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] object:0:required socket
		// [i] object:0:required inputStream
		// [i] object:0:required outputStream
		// [o] field:0:required closed
		// [o] field:0:required errorMsg
		IDataCursor	pipelineCursor = pipeline.getCursor();
		InputStream	inputStream	= ( InputStream )IDataUtil.get( pipelineCursor, "inputStream" );
		OutputStream outputStream = ( OutputStream )IDataUtil.get( pipelineCursor, "outputStream" );
		Socket socket = ( Socket )IDataUtil.get( pipelineCursor, "socket" );
		pipelineCursor.destroy();
		
		String closed = "true";
		String errorMsg = "";
		
		try {
			if ( inputStream != null ) {
				inputStream.close();
			}
			
			if ( outputStream != null ) {
				outputStream.close();
			}
			
			if ( socket != null ) {
				socket.close();
			}
		} catch ( Exception e ){
			debugLogger.printLogAtIS( "### closeSocket Error : " + e.toString(), "asynch" );
			closed = "false";
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "closed", closed );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void createClientSocket (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createClientSocket)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required serverIP
		// [i] field:0:required serverPort
		// [i] field:0:required readTimeout
		// [i] field:0:required nagleAlg
		// [o] object:0:required socket
		// [o] object:0:required inputStream
		// [o] object:0:required outputStream
		// [o] field:0:required enabled
		// [o] field:0:required errorMsg
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String serverIP	= IDataUtil.getString( pipelineCursor, "serverIP" );
		int	serverPort = IDataUtil.getInt( pipelineCursor, "serverPort", 0 );
		int	readTimeout = IDataUtil.getInt( pipelineCursor, "readTimeout", 0 );
		String nagleAlg	= IDataUtil.getString( pipelineCursor, "nagleAlg" );
		pipelineCursor.destroy();
		
		Socket socket = null;
		InputStream	inputStream	= null;
		OutputStream outputStream = null;
		String enabled = "true";
		String errorMsg = "";
		
		if ( nagleAlg == null || nagleAlg.equals( "" ) ) {
			nagleAlg = "Yes";
		}
		
		try {
			socket = new Socket( serverIP, serverPort );
			socket.setSoTimeout( readTimeout );
			
			// Nagle \uC54C\uACE0\uB9AC\uC998\uC744 \uC0AC\uC6A9\uD558\uB294 \uAC83\uC774 \uAE30\uBCF8\uC774\uC9C0\uB9CC Server \uCABD\uC5D0\uC11C \uC804\uBB38 \uAE38\uC774\uC815\uBCF4\uB97C \uC774\uC6A9\uD574\uC11C Read \uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0\uC5D0\uB294
			// Client \uCABD\uC5D0\uC11C Nagle \uC54C\uACE0\uB9AC\uC998\uC744 \uC0AC\uC6A9\uD558\uC9C0 \uC54A\uB3C4\uB85D \uC124\uC815\uD574\uC11C \uC804\uBB38 \uD558\uB098 \uB2E8\uC704\uB85C Write \uD558\uB3C4\uB85D \uD55C\uB2E4.
			if ( nagleAlg.equals( "No" ) ) {
				socket.setTcpNoDelay( true );
			}
			
			// InputStream \uBA3C\uC800 \uC0DD\uC131, OutputStream \uB098\uC911\uC5D0 \uC0DD\uC131
			inputStream	= new BufferedInputStream( socket.getInputStream() );
			outputStream = new BufferedOutputStream( socket.getOutputStream() );
		} catch( Exception e ) {
			debugLogger.printLogAtIS( "### createClientSocket Error : " + e.toString(), "asynch" );
			enabled = "false";
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "socket", socket );
		IDataUtil.put( pipelineCursor_1, "inputStream", inputStream );
		IDataUtil.put( pipelineCursor_1, "outputStream", outputStream );
		IDataUtil.put( pipelineCursor_1, "enabled", enabled );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void downServerSocket (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(downServerSocket)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [i] field:0:required threadPool
		// [i] field:0:required online
		// [i] field:0:required servicePath
		// [o] field:0:required downed
		// [o] field:0:required errorMsg
		IDataCursor	pipelineCursor = pipeline.getCursor();
		String portNumber = IDataUtil.getString( pipelineCursor, "portNumber" );
		String threadPool = IDataUtil.getString( pipelineCursor, "threadPool" );
		String online = IDataUtil.getString( pipelineCursor, "online" );
		String servicePath = IDataUtil.getString( pipelineCursor, "servicePath" );
		int pnum = Integer.parseInt( portNumber );
		pipelineCursor.destroy();
		
		String downed = "true";
		String errorMsg = "";
		
		try {
			sManager.downServerSocket( pnum, threadPool, online, servicePath );
		} catch( Exception e ) {
			debugLogger.printLogAtIS( "### downSocketServer Error(Port : " + portNumber + ") : " + e.toString(), "asynch" );
			downed = "false";
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "downed", downed );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getCreatedPoolCount (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getCreatedPoolCount)>> ---
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [o] field:0:required createdPoolCount
		IDataCursor pipelineCursor = pipeline.getCursor();
		int	portNumber = IDataUtil.getInt( pipelineCursor, "portNumber", 0 );
		pipelineCursor.destroy();
		
		int createdPoolCount = sManager.getCreatedPoolCount( portNumber );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "createdPoolCount", createdPoolCount + "" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getInetAddress (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getInetAddress)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] object:0:required socket
		// [o] field:0:required ipAddress
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		Socket socket = ( Socket )IDataUtil.get( pipelineCursor, "socket" );
		pipelineCursor.destroy();
			
		String ipAddress = "";
		String errorMsg = "";
		
		try {
			ipAddress = socket.getInetAddress() + "";
			
			if ( ipAddress != null ) {
				ipAddress = ipAddress.replace( "/", "" );
			}
		} catch ( Exception e ) {
			debugLogger.printLogAtIS( "### getInetAddress Error : " + e.toString(), "asynch" );
			errorMsg = e.toString(); 
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "ipAddress", ipAddress );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getInputStreamDataLength (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getInputStreamDataLength)>> ---
		// @sigtype java 3.5
		// [i] object:0:required inputStream
		// [o] field:0:required streamDataLength
		IDataCursor pipelineCursor = pipeline.getCursor();
		BufferedInputStream	inputStream	= ( BufferedInputStream )IDataUtil.get( pipelineCursor, "inputStream" );
		pipelineCursor.destroy();
		
		int streamDataLength = 0;
		
		try {
			streamDataLength = inputStream.available();
		} catch ( Exception e ) {
			
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "streamDataLength", streamDataLength + "" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getLocalPort (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getLocalPort)>> ---
		// @sigtype java 3.5
		// [i] object:0:required socket
		// [o] field:0:required localPort
		IDataCursor	pipelineCursor = pipeline.getCursor();
		Socket socket = ( Socket )IDataUtil.get( pipelineCursor, "socket" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		String localPort = "";
		
		try {
			localPort = socket.getLocalPort() + "";
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "localPort", localPort );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getOnlineSocketClient (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getOnlineSocketClient)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [o] field:0:required errorMsg
		// [o] recref:0:required ClientSocketInfo JSocketAdapter.DOC:ClientSocketInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	NAME = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		IData ClientSocketInfo = null;
		String errorMsg = "";
		
		try {
			ClientSocketInfo = sManager.getOnlineSocketClient( NAME );
			
			if ( ClientSocketInfo == null ) {
				errorMsg = NAME + "\uC5D0 \uB300\uD55C Online Socket Connection\uC774 Offline \uC0C1\uD0DC\uC785\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "ClientSocketInfo", ClientSocketInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getSocketClient (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getSocketClient)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [o] field:0:required errorMsg
		// [o] recref:0:required ClientPortInfo JSocketAdapter.DOC:ClientPortInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	NAME = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		IData ClientPortInfo = null;
		String errorMsg = "";
		
		try {
			ClientPortInfo = sManager.getSocketClient( NAME );
			
			if ( ClientPortInfo == null ) {
				errorMsg = NAME + " \uC5D0 \uB300\uD55C Socket Client \uC815\uBCF4\uAC00 \uC5C6\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "ClientPortInfo", ClientPortInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getSocketServer (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getSocketServer)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [o] field:0:required errorMsg
		// [o] recref:0:required ServerPortInfo JSocketAdapter.DOC:ServerPortInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	NAME = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		IData ServerPortInfo = null;
		String errorMsg = "";
		
		try {
			ServerPortInfo = sManager.getSocketServer( NAME );
			
			if ( ServerPortInfo == null ) {
				errorMsg = NAME + " \uC5D0 \uB300\uD55C Socket Server \uC815\uBCF4\uAC00 \uC5C6\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "ServerPortInfo", ServerPortInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void noLingerCloseSocket (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(noLingerCloseSocket)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] object:0:required socket
		// [i] object:0:required inputStream
		// [i] object:0:required outputStream
		// [i] field:0:required linger
		// [o] field:0:required closed
		// [o] field:0:required errorMsg
		IDataCursor	pipelineCursor = pipeline.getCursor();
		InputStream	inputStream	= ( InputStream )IDataUtil.get( pipelineCursor, "inputStream" );
		OutputStream outputStream = ( OutputStream )IDataUtil.get( pipelineCursor, "outputStream" );
		Socket socket = ( Socket )IDataUtil.get( pipelineCursor, "socket" );
		String linger = IDataUtil.getString( pipelineCursor, "linger" );
		
		pipelineCursor.destroy();
		
		String closed = "true";
		String errorMsg = "";
		
		try {
			if ( linger != null && linger.equals( "false" ) && socket != null )
				socket.setSoLinger( false, 1 ); // \uB300\uAE30\uC2DC\uAC04 \uC5C6\uC774 Close \uD558\uB3C4\uB85D \uC14B\uD305
			if ( inputStream != null )
				inputStream.close();
			if ( outputStream != null )
				outputStream.close();
			if ( socket != null )
				socket.close();
		} catch ( Exception e ) {
			debugLogger.printLogAtIS( "### noLingerCloseSocket Error : " + e.toString(), "asynch" );
			closed = "false";
			errorMsg = e.toString(); 
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "closed", closed );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putOnlineSocketClient (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putOnlineSocketClient)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [i] recref:0:required ClientSocketInfo JSocketAdapter.DOC:ClientSocketInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	NAME = IDataUtil.getString( pipelineCursor, "NAME" );
		IData ClientSocketInfo	= IDataUtil.getIData( pipelineCursor, "ClientSocketInfo" );
		pipelineCursor.destroy();
		
		sManager.putOnlineSocketClient( NAME, ClientSocketInfo );
		// --- <<IS-END>> ---

                
	}



	public static final void putSocketClient (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putSocketClient)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [i] recref:0:required ClientPortInfo JSocketAdapter.DOC:ClientPortInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	NAME = IDataUtil.getString( pipelineCursor, "NAME" );
		IData ClientPortInfo	= IDataUtil.getIData( pipelineCursor, "ClientPortInfo" );
		pipelineCursor.destroy();
		
		sManager.putSocketClient( NAME, ClientPortInfo );
		// --- <<IS-END>> ---

                
	}



	public static final void putSocketServer (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putSocketServer)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		// [i] recref:0:required ServerPortInfo JSocketAdapter.DOC:ServerPortInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	NAME = IDataUtil.getString( pipelineCursor, "NAME" );
		IData ServerPortInfo	= IDataUtil.getIData( pipelineCursor, "ServerPortInfo" );
		pipelineCursor.destroy();
		
		sManager.putSocketServer( NAME, ServerPortInfo );
		// --- <<IS-END>> ---

                
	}



	public static final void readFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(readFile)>> ---
		// @sigtype java 3.5
		// [i] object:0:required inputStream
		// [i] object:0:required cipher
		// [i] field:0:optional readLen
		// [i] field:0:required applyRealLen {"false","true"}
		// [i] field:0:required online
		// [i] field:0:required fileName
		// [o] record:0:required body
		// [o] - object:0:required bytes
		// [o] field:0:required errorMsg
		// [o] field:0:required readLog
		// [o] field:0:required realReadLen
		IDataCursor pipelineCursor = pipeline.getCursor();
		BufferedInputStream	inputStream	= ( BufferedInputStream )IDataUtil.get( pipelineCursor, "inputStream" );
		Cipher cipher = ( Cipher )IDataUtil.get( pipelineCursor, "cipher" );
		int readLen = IDataUtil.getInt( pipelineCursor, "readLen", 0 ); // inputstream \uC5D0\uC11C read \uD558\uACE0\uC790 \uD558\uB294 byte \uC218
		String applyRealLen = IDataUtil.getString( pipelineCursor, "applyRealLen" );
		String online = IDataUtil.getString( pipelineCursor, "online" );
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		pipelineCursor.destroy();
		
		if ( applyRealLen == null ) {
			applyRealLen = "false";
		}
		
		if ( online == null ) {
			online = "NoS";
		}
		
		int totalReadLength = 0; // inputstream \uC5D0\uC11C \uC2E4\uC81C\uB85C read \uD55C \uB204\uC801 byte \uC218
		String errorMsg = "";
		String checkMsg = "";
		String readLog = "";
		String realReadLen = "0";
		StringBuffer strReadLogBuffer = new StringBuffer();
		
		File file = null;
		OutputStream os = null;
		ByteArrayOutputStream baos = null;
		byte[] buffer = new byte[ readLen ];
		byte[] newBuffer = null;
		byte[] encrypedData = null;
		
		// Online \uC1A1\uC2E0\uC758 \uACBD\uC6B0 write \uD558\uAE30\uC5D0 \uC55E\uC11C Server \uCABD\uC5D0\uC11C \uC784\uC758\uB85C Socket close \uD588\uB294\uC9C0\uB97C \uC54C\uC544\uBCF4\uAE30 \uC704\uD574\uC11C read \uB97C \uBA3C\uC800 \uD574\uBCF8\uB2E4.
		// Socket \uC774 \uC815\uC0C1\uC77C \uACBD\uC6B0\uC5D0\uB294 Read time out \uBC1C\uC0DD. Server \uCABD\uC5D0\uC11C Socket close \uD55C \uACBD\uC6B0\uC5D0\uB294 -1 \uB9AC\uD134
		if ( online.equals( "YesW" ) ) {
			checkMsg = " (Server side\uC5D0\uC11C Socket close \uD588\uB294\uC9C0 Check \uC2E4\uC2DC ::: \uC624\uB958 \uBB34\uC2DC)";
		}
		
		try {
			if ( readLen == 0 && applyRealLen.equals( "true" ) ) {
				// \uC2E4\uC81C \uC2A4\uD2B8\uB9BC\uC5D0 \uB4E4\uC5B4\uC640 \uC558\uB294 \uBC14\uC774\uD2B8 \uC218
				int realLen = 0;
				
				// \uC2E4\uC81C \uC2A4\uD2B8\uB9BC\uC5D0 \uB4E4\uC5B4\uC640 \uC558\uB294 \uBC14\uC774\uD2B8 \uC218\uBCF4\uB2E4 read \uD560\uB824\uACE0 \uD558\uB294 \uBC14\uC774\uD2B8 \uC218\uAC00 \uD074 \uACBD\uC6B0 blocking \uC0C1\uD0DC\uAC00 \uB418\uB294 \uAC83\uC744 \uBC29\uC9C0
				// Online \uC5C5\uBB34\uC758 \uACBD\uC6B0 \uC11C\uBC84\uC5D0\uC11C write \uD558\uB294 \uC18D\uB3C4\uB97C \uD074\uB77C\uC774\uC5B8\uD2B8\uAC00 \uB530\uB77C\uAC00\uC9C0 \uBABB\uD560 \uACBD\uC6B0 \uC774 \uBD80\uBD84\uC774 \uC801\uC6A9\uB418\uBA74 \uB370\uC774\uD130\uB97C
				// \uC6D0\uD558\uB294 \uD615\uD0DC\uB85C read \uD558\uC9C0 \uBABB\uD560 \uC218 \uC788\uB2E4. \uC774 \uBD80\uBD84\uC5D0 \uB300\uD55C \uC801\uC6A9\uC740 \uC2E0\uC911\uD558\uAC8C \uD574\uC57C \uD55C\uB2E4.
				// \uC2A4\uD2B8\uB9BC\uC5D0 \uB370\uC774\uD130\uAC00 \uC5C6\uB294 \uACBD\uC6B0 inputStream.available() ==> 0
				// \uB370\uC774\uD130\uAC00 \uB4E4\uC5B4\uC62C \uB54C\uAE4C\uC9C0 while \uC218\uD589 ==> \uB370\uC774\uD130\uAC00 \uB4E4\uC5B4\uC624\uBA74 while exit
				while ( ( realLen = inputStream.available() ) >= 0 ) {
					if ( realLen > 0 ) {
						buffer = null;
						buffer = new byte[ realLen ];
						break;
					}
				}
				
				realReadLen = realLen + "";
			}
			
			if ( buffer.length == 0 ) {
				// Read \uD560 \uAE38\uC774\uB97C \uC54C \uC218 \uC5C6\uC73C\uBBC0\uB85C InputStream \uC804\uCCB4\uB97C Read
				baos = new ByteArrayOutputStream();
				int len = 0;
				
				strReadLogBuffer.append( "InputStream \uC5D0\uC11C Read \uD574\uC57C\uD560 Length ::: \uBBF8\uC9C0\uC815" );
				
				// -1 \uC774 \uB9AC\uD134\uB418\uB294 \uACBD\uC6B0 ==> \uC1A1\uC2E0\uB2E8\uC5D0\uC11C OutputStream.shutdownOutput() \uD55C \uACBD\uC6B0 \uB610\uB294 OutputStream.close() \uD55C \uACBD\uC6B0
				while ( ( len = inputStream.read() ) != -1 ) {
					if ( len > 0 ) {
						totalReadLength += len;
						baos.write( len );
					}
				}
				
				if ( totalReadLength == 0 ) {
					strReadLogBuffer.append( "\n" );
					strReadLogBuffer.append( "InputStream \uC5D0\uC11C \uC2E4\uC81C\uB85C Read \uD55C Length \uD569\uACC4 ::: 0" );
				} else {
					if ( cipher == null ) { // \uC554\uD638\uD654\uB41C \uB370\uC774\uD130\uAC00 \uC544\uB2CC \uACBD\uC6B0
						buffer = null;
						buffer = baos.toByteArray();
					
						strReadLogBuffer.append( "\n" );
						strReadLogBuffer.append( "InputStream \uC5D0\uC11C \uC2E4\uC81C\uB85C Read \uD55C Length \uD569\uACC4 ::: " + buffer.length );
						realReadLen = buffer.length + "";
					} else { // \uC554\uD638\uD654\uB41C \uB370\uC774\uD130\uC778 \uACBD\uC6B0 ==> \uBCF5\uD638\uD654
						encrypedData = baos.toByteArray();
						
						// \uB370\uC774\uD130 \uBCF5\uD638\uD654
						buffer = null;
						buffer = cipher.doFinal( encrypedData );
						
						strReadLogBuffer.append( "\n" );
						strReadLogBuffer.append( "InputStream \uC5D0\uC11C \uC2E4\uC81C\uB85C Read \uD55C Length \uD569\uACC4 ::: " + encrypedData.length );
						realReadLen = encrypedData.length + "";
					}
					
					file = new File( fileName );
					
					if ( !file.exists() ) {
						file.createNewFile();
					}
				
					os = new FileOutputStream( file );
					os.write( buffer );
				}
				
				readLog = strReadLogBuffer.toString();
			} else {
				// \uC9C0\uC815\uD55C \uAE38\uC774 \uB9CC\uD07C\uB9CC Read
				int bufferLength = buffer.length;
				int len = 0;
				int readCount = 1;
				
				strReadLogBuffer.append( "InputStream \uC5D0\uC11C Read \uD574\uC57C\uD560 Length ::: " + bufferLength );
				
				/*
				 * read \uD558\uACE0\uC790 \uD558\uB294 byte \uC218\uAC00 \uBAA8\uB450 \uB4E4\uC5B4\uC62C \uB54C\uAE4C\uC9C0 \uAE30\uB2E4\uB9B0\uB2E4. \uC11C\uBC84\uC5D0\uC11C\uB294 write \uD560 \uC804\uCCB4 \uB370\uC774\uD130\uB97C \uD55C\uBC88\uC5D0 write \uD560 \uC218\uB3C4 \uC788\uACE0
				 * \uB098\uB204\uC5B4\uC11C \uC5EC\uB7EC\uBC88 write \uD560 \uC218\uB3C4 \uC788\uAE30 \uB54C\uBB38\uC5D0 \uC804\uCCB4 \uB370\uC774\uD130\uB97C read \uD560 \uB54C\uAE4C\uC9C0 \uAE30\uB2E4\uB824\uC57C \uD55C\uB2E4.
				 * Socket \uAE30\uBCF8 IO mode\uAC00 blocking \uC774\uAE30 \uB54C\uBB38\uC5D0 inputStream \uC5D0\uC11C read \uD558\uAC8C \uB418\uBA74 \uC2E4\uC81C\uB85C \uB370\uC774\uD130\uAC00 \uB4E4\uC5B4\uC62C \uB54C\uAE4C\uC9C0 read \uBA54\uC18C\uB4DC\uC5D0\uC11C \uAE30\uB2E4\uB9AC\uAC8C \uB41C\uB2E4.
				 * read \uD558\uACE0\uC790 \uD558\uB294 byte \uC218\uC640 \uC2E4\uC81C\uB85C inputStream \uC5D0 \uB4E4\uC5B4\uC640 \uC788\uB294 byte \uC218\uAC00 \uB9DE\uC9C0 \uC54A\uB2E4\uACE0 \uD574\uC11C inputStream.read \uD560 \uB54C
				 * thread block \uC0C1\uD0DC\uC5D0 \uBE60\uC9C0\uB294 \uAC83\uC740 \uC544\uB2C8\uB2E4. \uAC1C\uBC1C\uC790\uC758 \uAD6C\uD604 \uBC29\uC2DD\uC5D0 \uB530\uB77C\uC11C blocking \uC0C1\uD0DC\uC5D0 \uBE60\uC9C8 \uC218\uB3C4 \uC788\uACE0 \uC548 \uBE60\uC9C8 \uC218\uB3C4 \uC788\uB2E4.
				 * Synch \uBC29\uC2DD\uC77C \uACBD\uC6B0\uC5D0\uB294 read \uD558\uACE0\uC790 \uD558\uB294 byte \uC218\uBCF4\uB2E4 \uC2E4\uC81C\uB85C \uB4E4\uC5B4\uC628 byte \uC218\uAC00 \uC791\uB2E4 \uD558\uB354\uB77C\uB3C4 \uC0C1\uB300\uD3B8\uC5D0\uC11C\uB294 write \uD55C \uB2E4\uC74C\uC5D0
				 * \uBC14\uB85C socket close \uD558\uAE30 \uB54C\uBB38\uC5D0 Read timeout \uC774 \uB098\uAE30 \uC804\uC5D0 -1 \uC744 \uB9AC\uD134\uD574\uC11C while \uBB38\uC744 \uBE60\uC838 \uB098\uAC00\uAC8C \uB41C\uB2E4. \uC989, read blocking \uC774 \uC5C6\uAC8C \uB41C\uB2E4.
				 * -1 \uC774 \uB9AC\uD134\uB418\uB294 \uACBD\uC6B0 ==> \uC1A1\uC2E0\uB2E8\uC5D0\uC11C OutputStream.shutdownOutput() \uD55C \uACBD\uC6B0 \uB610\uB294 OutputStream.close() \uD55C \uACBD\uC6B0
				 */
				while ( ( len = inputStream.read( buffer, totalReadLength, bufferLength - totalReadLength ) ) != -1 ) {
					if ( len > 0 ) {
						totalReadLength += len;
						
						strReadLogBuffer.append( "\n" );
						strReadLogBuffer.append( "InputStream \uC5D0\uC11C \uC2E4\uC81C\uB85C Read \uD55C Length \uD569\uACC4" + readCount + " ::: " + totalReadLength );
						
						if ( totalReadLength == bufferLength ) {
							break;
						}
						
						readCount++;
					}
				}
				
				if ( totalReadLength == 0 ) {
					strReadLogBuffer.append( "\n" );
					strReadLogBuffer.append( "InputStream \uC5D0\uC11C \uC2E4\uC81C\uB85C Read \uD55C Length \uD569\uACC4 ::: 0" );
				}
				
				// Server \uCABD\uC5D0\uC11C \uC784\uC758\uB85C Socket Close \uD55C \uACBD\uC6B0\uC5D0\uB294 -1 \uC774 \uB9AC\uD134\uB41C\uB2E4.
				// Online Socket \uC758 \uACBD\uC6B0\uB294 \uC5D0\uB7EC\uCC98\uB9AC\uB97C \uD558\uACE0 Online \uC774 \uC544\uB2CC Synch \uBC29\uC2DD\uC778 \uACBD\uC6B0\uB294 \uC5D0\uB7EC\uCC98\uB9AC\uD558\uC9C0 \uC54A\uB294\uB2E4.
				if ( len == -1 ) {
					if ( online.equals( "YesR" ) || online.equals( "YesW" ) ) {
						errorMsg = "java.net.ESBException: Server socket closed";
					} else {
						strReadLogBuffer.append( "\n" );
						strReadLogBuffer.append( "Server socket closed \uAC00 \uBC1C\uC0DD\uD558\uC5EC InputStream Reading Exit" );
						
						// Online Socket \uC774\uC678\uC758 Synch \uBC29\uC2DD\uC73C\uB85C Read \uD558\uB294 \uACBD\uC6B0\uC5D0\uB3C4 totalReadLength\uAC00 0 \uC778 \uACBD\uC6B0\uC5D0\uB294 \uC5D0\uB7EC\uCC98\uB9AC\uD55C\uB2E4.
						if ( totalReadLength == 0 ) {
							errorMsg = "java.net.ESBException: Data length received from socket server is 0";
						}
					}
				}
				
				readLog = strReadLogBuffer.toString();
				
				// Read \uD574\uC57C\uD560 \uAE38\uC774\uBCF4\uB2E4 \uC801\uAC8C Read \uD588\uC744 \uACBD\uC6B0\uC5D0\uB294 \uC2E4\uC81C\uB85C Read \uD55C \uB9CC\uD07C\uB9CC \uB9AC\uD134\uD558\uB3C4\uB85D \uCC98\uB9AC\uD55C\uB2E4.
				// \uBB34\uC870\uAC74 strBuffer = new String( buffer ) \uD558\uAC8C \uB418\uBA74 \uBAA8\uC790\uB77C\uB294 \uBD80\uBD84\uC5D0 \uB300\uD574\uC11C\uB294
				// null \uB85C \uCC44\uC6CC\uC11C \uB9AC\uD134\uD558\uAC8C \uB41C\uB2E4. Text Editor \uC5D0\uC11C \uBCF4\uBA74 space \uCC98\uB7FC \uBCF4\uC774\uC9C0\uB9CC Hex code \uB97C \uBCF4\uBA74 null(00) \uC774\uB2E4.
				if ( totalReadLength == 0 ) {
					buffer = null;
				} else {
					if ( cipher == null ) { // \uC554\uD638\uD654\uB41C \uB370\uC774\uD130\uAC00 \uC544\uB2CC \uACBD\uC6B0
						if ( totalReadLength > 0 && totalReadLength < bufferLength ) {
							newBuffer = new byte[ totalReadLength ];
							System.arraycopy( buffer, 0, newBuffer, 0, totalReadLength );
					
							buffer = null;
							buffer = newBuffer;
							newBuffer = null;
						} else {
							// Read \uD574\uC57C\uD560 \uAE38\uC774\uC640 \uC2E4\uC81C\uB85C Read \uD55C \uAE38\uC774\uAC00 \uAC19\uC740 \uACBD\uC6B0 ==> Skip
						}
					} else { // \uC554\uD638\uD654\uB41C \uB370\uC774\uD130\uC778 \uACBD\uC6B0 ==> \uBCF5\uD638\uD654
						encrypedData = new byte[ totalReadLength ];
						System.arraycopy( buffer, 0, encrypedData, 0, totalReadLength );
						
						// \uB370\uC774\uD130 \uBCF5\uD638\uD654
						buffer = null;
						buffer = cipher.doFinal( encrypedData );
					}
					
					file = new File( fileName );
				
					if ( !file.exists() ) {
						file.createNewFile();
					}
				
					os = new FileOutputStream( file );
					os.write( buffer );
					
					realReadLen = totalReadLength + "";
				}
			}
		} catch ( SocketException se ) {
			debugLogger.printLogAtIS( "### readFile Error(SocketException)" + checkMsg + " : " + se.toString(), "asynch" );
			errorMsg = se.toString();
			readLog = strReadLogBuffer.toString();
			
			if ( totalReadLength == 0 ) {
				buffer = null;
			} else {
				newBuffer = new byte[ totalReadLength ];
				System.arraycopy( buffer, 0, newBuffer, 0, totalReadLength );
				buffer = null;
				buffer = newBuffer;
				newBuffer = null;
			}
		} catch ( Exception e ) {
			debugLogger.printLogAtIS( "### readFile Error(Exception)" + checkMsg + " : " + e.toString(), "asynch" );
			errorMsg = e.toString();
			readLog = strReadLogBuffer.toString();
			
			if ( totalReadLength == 0 ) {
				buffer = null;
			} else {
				newBuffer = new byte[ totalReadLength ];
				System.arraycopy( buffer, 0, newBuffer, 0, totalReadLength );
				buffer = null;
				buffer = newBuffer;
				newBuffer = null;
			}
		} finally {			
			try {
				if ( os != null ) {
					os.close();
				}
				
				if ( baos != null ) {
					baos.close();
				}
			} catch ( Exception fe ) {
				errorMsg = fe.toString();
			}
		}
		
		file = null;
		os = null;
		baos = null;
		cipher = null;
		
		IData body = IDataFactory.create();
		IDataCursor bcur = body.getCursor();
		IDataUtil.put( bcur, "bytes", buffer );
		bcur.destroy();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "body", body );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "readLog", readLog );
		IDataUtil.put( pipelineCursor_1, "realReadLen", realReadLen );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void readFromStream (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(readFromStream)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] object:0:required inputStream
		// [i] object:0:required cipher
		// [i] field:0:optional readLen
		// [i] field:0:required charset
		// [i] field:0:required applyRealLen {"false","true"}
		// [i] field:0:required online {"NoS","NoM","NoF","NoFF","YesW","YesR"}
		// [i] field:0:required debugLog {"","true","false"}
		// [i] field:0:required nullToSpace {"","No","Yes"}
		// [o] record:0:required body
		// [o] - object:0:required bytes
		// [o] - field:0:required string
		// [o] field:0:required errorMsg
		// [o] field:0:required readLog
		IDataCursor pipelineCursor = pipeline.getCursor();
		BufferedInputStream	inputStream	= ( BufferedInputStream )IDataUtil.get( pipelineCursor, "inputStream" );
		Cipher cipher = ( Cipher )IDataUtil.get( pipelineCursor, "cipher" );
		int readLen = IDataUtil.getInt( pipelineCursor, "readLen", 0 ); // inputstream \uC5D0\uC11C read \uD558\uACE0\uC790 \uD558\uB294 byte \uC218
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		String applyRealLen = IDataUtil.getString( pipelineCursor, "applyRealLen" );
		String online = IDataUtil.getString( pipelineCursor, "online" );
		String debugLog = IDataUtil.getString( pipelineCursor, "debugLog" );
		String nullToSpace = IDataUtil.getString( pipelineCursor, "nullToSpace" );
		pipelineCursor.destroy();
		
		if ( applyRealLen == null || applyRealLen.equals( "" ) ) {
			applyRealLen = "false";
		}
		
		if ( online == null || online.equals( "" ) ) {
			online = "NoS";
		}
		
		if ( debugLog == null || debugLog.equals( "" ) ) {
			debugLog = "true";
		}
		
		if ( nullToSpace == null || nullToSpace.equals( "" ) ) {
			nullToSpace = "No";
		}
		
		int totalReadLength = 0; // inputstream \uC5D0\uC11C \uC2E4\uC81C\uB85C read \uD55C \uB204\uC801 byte \uC218
		String strBuffer = "";
		String errorMsg = "";
		String checkMsg = "";
		String readLog = "";
		StringBuffer strReadLogBuffer = new StringBuffer();
		ByteArrayOutputStream baos = null;
		byte[] buffer = new byte[ readLen ];
		byte[] newBuffer = null;
		byte[] encrypedData = null;
		
		// Online \uC1A1\uC2E0\uC758 \uACBD\uC6B0 write \uD558\uAE30\uC5D0 \uC55E\uC11C Server \uB610\uB294 Client \uCABD\uC5D0\uC11C \uC784\uC758\uB85C Socket close \uD588\uB294\uC9C0\uB97C \uC54C\uC544\uBCF4\uAE30 \uC704\uD574\uC11C read\uB97C \uBA3C\uC800 \uD574\uBCF8\uB2E4.
		// Socket \uC774 \uC815\uC0C1\uC77C \uACBD\uC6B0\uC5D0\uB294 Read time out \uBC1C\uC0DD. Server \uB610\uB294 Client \uCABD\uC5D0\uC11C Socket close \uD55C \uACBD\uC6B0\uC5D0\uB294 -1 \uB9AC\uD134
		if ( online.equals( "YesW" ) ) {
			checkMsg = " (Remote side\uC5D0\uC11C Socket close \uD588\uB294\uC9C0 Check \uC2E4\uC2DC ::: \uC624\uB958 \uBB34\uC2DC)";
		}
		
		try {
			if ( readLen == 0 && applyRealLen.equals( "true" ) ) {
				// \uC2E4\uC81C \uC2A4\uD2B8\uB9BC\uC5D0 \uB4E4\uC5B4\uC640 \uC558\uB294 \uBC14\uC774\uD2B8 \uC218
				int realLen = 0;
				
				// \uC2E4\uC81C \uC2A4\uD2B8\uB9BC\uC5D0 \uB4E4\uC5B4\uC640 \uC558\uB294 \uBC14\uC774\uD2B8 \uC218\uBCF4\uB2E4 read \uD560\uB824\uACE0 \uD558\uB294 \uBC14\uC774\uD2B8 \uC218\uAC00 \uD074 \uACBD\uC6B0 blocking \uC0C1\uD0DC\uAC00 \uB418\uB294 \uAC83\uC744 \uBC29\uC9C0
				// Online \uC5C5\uBB34\uC758 \uACBD\uC6B0 \uC11C\uBC84\uC5D0\uC11C write \uD558\uB294 \uC18D\uB3C4\uB97C \uD074\uB77C\uC774\uC5B8\uD2B8\uAC00 \uB530\uB77C\uAC00\uC9C0 \uBABB\uD560 \uACBD\uC6B0 \uC774 \uBD80\uBD84\uC774 \uC801\uC6A9\uB418\uBA74 \uB370\uC774\uD130\uB97C
				// \uC6D0\uD558\uB294 \uD615\uD0DC\uB85C read \uD558\uC9C0 \uBABB\uD560 \uC218 \uC788\uB2E4. \uC774 \uBD80\uBD84\uC5D0 \uB300\uD55C \uC801\uC6A9\uC740 \uC2E0\uC911\uD558\uAC8C \uD574\uC57C \uD55C\uB2E4.
				// \uC2A4\uD2B8\uB9BC\uC5D0 \uB370\uC774\uD130\uAC00 \uC5C6\uB294 \uACBD\uC6B0 inputStream.available() ==> 0
				// \uB370\uC774\uD130\uAC00 \uB4E4\uC5B4\uC62C \uB54C\uAE4C\uC9C0 while \uC218\uD589 ==> \uB370\uC774\uD130\uAC00 \uB4E4\uC5B4\uC624\uBA74 while exit
				while ( ( realLen = inputStream.available() ) >= 0 ) {
					if ( realLen > 0 ) {
						buffer = null;
						buffer = new byte[ realLen ];
						break;
					} else {
						Thread.sleep( 10 );
					}
				}
			}
			
			if ( buffer.length == 0 ) {
				// Read \uD560 \uAE38\uC774\uB97C \uC54C \uC218 \uC5C6\uC73C\uBBC0\uB85C InputStream \uC804\uCCB4\uB97C Read
				baos = new ByteArrayOutputStream();
				int len = 0;
				
				strReadLogBuffer.append( "InputStream \uC5D0\uC11C Read \uD574\uC57C\uD560 Length ::: \uBBF8\uC9C0\uC815" );
				
				// -1 \uC774 \uB9AC\uD134\uB418\uB294 \uACBD\uC6B0 ==> \uC1A1\uC2E0\uB2E8\uC5D0\uC11C OutputStream.shutdownOutput() \uD55C \uACBD\uC6B0 \uB610\uB294 OutputStream.close() \uD55C \uACBD\uC6B0
				while ( ( len = inputStream.read() ) != -1 ) {
					if ( len > 0 ) {
						totalReadLength += len;
						baos.write( len );
					}
				}
				
				if ( totalReadLength == 0 ) {
					strReadLogBuffer.append( "\n" );
					strReadLogBuffer.append( "InputStream \uC5D0\uC11C \uC2E4\uC81C\uB85C Read \uD55C Length \uD569\uACC4 ::: 0" );
				} else {
					if ( cipher == null ) { // \uC554\uD638\uD654\uB41C \uB370\uC774\uD130\uAC00 \uC544\uB2CC \uACBD\uC6B0
						buffer = null;
						buffer = baos.toByteArray();
					
						strReadLogBuffer.append( "\n" );
						strReadLogBuffer.append( "InputStream \uC5D0\uC11C \uC2E4\uC81C\uB85C Read \uD55C Length \uD569\uACC4 ::: " + buffer.length );
					} else { // \uC554\uD638\uD654\uB41C \uB370\uC774\uD130\uC778 \uACBD\uC6B0 ==> \uBCF5\uD638\uD654
						encrypedData = baos.toByteArray();
						
						// \uB370\uC774\uD130 \uBCF5\uD638\uD654
						buffer = null;
						buffer = cipher.doFinal( encrypedData );
						
						strReadLogBuffer.append( "\n" );
						strReadLogBuffer.append( "InputStream \uC5D0\uC11C \uC2E4\uC81C\uB85C Read \uD55C Length \uD569\uACC4 ::: " + encrypedData.length );
					}
					
					// Null Value\uB97C Space\uB85C \uBCC0\uD658\uD574\uC57C \uD558\uB294 \uACBD\uC6B0
					if ( nullToSpace.equals( "Yes" ) ) {
						for ( int i = 0; i < buffer.length; i++ ) {
							if( buffer[ i ] == ( byte )0x00 || buffer[ i ] == ( byte )0xff ) {
								buffer[ i ] = ( byte )0x20;
							}
						}
					}
				
					if ( charset == null || charset.equals( "" ) ) {
						strBuffer = new String( buffer );
					} else { 
						strBuffer = new String( buffer, charset );
					}
				}
				
				readLog = strReadLogBuffer.toString();
			} else {
				// \uC9C0\uC815\uD55C \uAE38\uC774 \uB9CC\uD07C\uB9CC Read
				int bufferLength = buffer.length;
				int len = 0;
				int readCount = 1;
				
				strReadLogBuffer.append( "InputStream \uC5D0\uC11C Read \uD574\uC57C\uD560 Length ::: " + bufferLength );
				/*
				 * read \uD558\uACE0\uC790 \uD558\uB294 byte \uC218\uAC00 \uBAA8\uB450 \uB4E4\uC5B4\uC62C \uB54C\uAE4C\uC9C0 \uAE30\uB2E4\uB9B0\uB2E4. \uC11C\uBC84\uC5D0\uC11C\uB294 write \uD560 \uC804\uCCB4 \uB370\uC774\uD130\uB97C \uD55C\uBC88\uC5D0 write \uD560 \uC218\uB3C4 \uC788\uACE0
				 * \uB098\uB204\uC5B4\uC11C \uC5EC\uB7EC\uBC88 write \uD560 \uC218\uB3C4 \uC788\uAE30 \uB54C\uBB38\uC5D0 \uC804\uCCB4 \uB370\uC774\uD130\uB97C read \uD560 \uB54C\uAE4C\uC9C0 \uAE30\uB2E4\uB824\uC57C \uD55C\uB2E4.
				 * Socket \uAE30\uBCF8 IO mode\uAC00 blocking \uC774\uAE30 \uB54C\uBB38\uC5D0 inputStream \uC5D0\uC11C read \uD558\uAC8C \uB418\uBA74 \uC2E4\uC81C\uB85C \uB370\uC774\uD130\uAC00 \uB4E4\uC5B4\uC62C \uB54C\uAE4C\uC9C0 read \uBA54\uC18C\uB4DC\uC5D0\uC11C \uAE30\uB2E4\uB9AC\uAC8C \uB41C\uB2E4.
				 * read \uD558\uACE0\uC790 \uD558\uB294 byte \uC218\uC640 \uC2E4\uC81C\uB85C inputStream \uC5D0 \uB4E4\uC5B4\uC640 \uC788\uB294 byte \uC218\uAC00 \uB9DE\uC9C0 \uC54A\uB2E4\uACE0 \uD574\uC11C inputStream.read \uD560 \uB54C
				 * thread block \uC0C1\uD0DC\uC5D0 \uBE60\uC9C0\uB294 \uAC83\uC740 \uC544\uB2C8\uB2E4. \uAC1C\uBC1C\uC790\uC758 \uAD6C\uD604 \uBC29\uC2DD\uC5D0 \uB530\uB77C\uC11C blocking \uC0C1\uD0DC\uC5D0 \uBE60\uC9C8 \uC218\uB3C4 \uC788\uACE0 \uC548 \uBE60\uC9C8 \uC218\uB3C4 \uC788\uB2E4.
				 * Synch \uBC29\uC2DD\uC77C \uACBD\uC6B0\uC5D0\uB294 read \uD558\uACE0\uC790 \uD558\uB294 byte \uC218\uBCF4\uB2E4 \uC2E4\uC81C\uB85C \uB4E4\uC5B4\uC628 byte \uC218\uAC00 \uC791\uB2E4 \uD558\uB354\uB77C\uB3C4 \uC0C1\uB300\uD3B8\uC5D0\uC11C\uB294 write \uD55C \uB2E4\uC74C\uC5D0
				 * \uBC14\uB85C socket close \uD558\uAE30 \uB54C\uBB38\uC5D0 Read timeout \uC774 \uB098\uAE30 \uC804\uC5D0 -1 \uC744 \uB9AC\uD134\uD574\uC11C while \uBB38\uC744 \uBE60\uC838 \uB098\uAC00\uAC8C \uB41C\uB2E4. \uC989, read blocking \uC774 \uC5C6\uAC8C \uB41C\uB2E4.
				 * -1 \uC774 \uB9AC\uD134\uB418\uB294 \uACBD\uC6B0 ==> \uC1A1\uC2E0\uB2E8\uC5D0\uC11C OutputStream.shutdownOutput() \uD55C \uACBD\uC6B0 \uB610\uB294 OutputStream.close() \uD55C \uACBD\uC6B0
				 */
				while ( ( len = inputStream.read( buffer, totalReadLength, bufferLength - totalReadLength ) ) != -1 ) {
					if ( len > 0 ) {
						totalReadLength += len;
						
						strReadLogBuffer.append( "\n" );
						strReadLogBuffer.append( "InputStream \uC5D0\uC11C \uC2E4\uC81C\uB85C Read \uD55C Length \uD569\uACC4" + readCount + " ::: " + totalReadLength );
						
						if ( totalReadLength == bufferLength ) {
							break;
						}
						
						readCount++;
					}
				}
				
				if ( totalReadLength == 0 ) {
					strReadLogBuffer.append( "\n" );
					strReadLogBuffer.append( "InputStream \uC5D0\uC11C \uC2E4\uC81C\uB85C Read \uD55C Length \uD569\uACC4 ::: 0" );
				}
				
				// Server \uCABD\uC5D0\uC11C \uC784\uC758\uB85C Socket Close \uD55C \uACBD\uC6B0\uC5D0\uB294 -1 \uC774 \uB9AC\uD134\uB41C\uB2E4.
				// Online Socket \uC758 \uACBD\uC6B0\uB294 \uC5D0\uB7EC\uCC98\uB9AC\uB97C \uD558\uACE0 Online \uC774 \uC544\uB2CC Synch \uBC29\uC2DD\uC778 \uACBD\uC6B0\uB294 \uC5D0\uB7EC\uCC98\uB9AC\uD558\uC9C0 \uC54A\uB294\uB2E4.
				if ( len == -1 ) {
					if ( online.equals( "YesR" ) || online.equals( "YesW" ) ) {
						errorMsg = "java.net.ESBException: Socket closed from remote side.";
					} else {
						strReadLogBuffer.append( "\n" );
						strReadLogBuffer.append( "Remote side\uC5D0\uC11C socket closed\uAC00 \uBC1C\uC0DD\uD558\uC5EC InputStream Reading Exit" );
						
						// Online Socket \uC774\uC678\uC758 Synch \uBC29\uC2DD\uC73C\uB85C Read \uD558\uB294 \uACBD\uC6B0\uC5D0\uB3C4 totalReadLength\uAC00 0 \uC778 \uACBD\uC6B0\uC5D0\uB294 \uC5D0\uB7EC\uCC98\uB9AC\uD55C\uB2E4.
						if ( totalReadLength == 0 ) {
							errorMsg = "java.net.ESBException: Data length received from remote side is 0";
						} else {
							if ( totalReadLength < bufferLength ) {
								// \uC2E4\uC81C\uB85C Read \uD55C \uB370\uC774\uD130 \uAE38\uC774\uAC00 Read \uD574\uC57C \uD560 \uB370\uC774\uD130 \uAE38\uC774\uBCF4\uB2E4 \uC791\uC740 \uACBD\uC6B0
								errorMsg = "java.net.ESBException: Data length received from remote side is insufficient";
							}
						}
					}
				}
				
				readLog = strReadLogBuffer.toString();
				
				// Read \uD574\uC57C\uD560 \uAE38\uC774\uBCF4\uB2E4 \uC801\uAC8C Read \uD588\uC744 \uACBD\uC6B0\uC5D0\uB294 \uC2E4\uC81C\uB85C Read \uD55C \uB9CC\uD07C\uB9CC \uB9AC\uD134\uD558\uB3C4\uB85D \uCC98\uB9AC\uD55C\uB2E4.
				// \uBB34\uC870\uAC74 strBuffer = new String( buffer ) \uD558\uAC8C \uB418\uBA74 \uBAA8\uC790\uB77C\uB294 \uBD80\uBD84\uC5D0 \uB300\uD574\uC11C\uB294
				// null \uB85C \uCC44\uC6CC\uC11C \uB9AC\uD134\uD558\uAC8C \uB41C\uB2E4. Text Editor \uC5D0\uC11C \uBCF4\uBA74 space \uCC98\uB7FC \uBCF4\uC774\uC9C0\uB9CC Hex code \uB97C \uBCF4\uBA74 null(00) \uC774\uB2E4.
				if ( totalReadLength == 0 ) {
					buffer = null;
					strBuffer = "";
				} else {
					if ( cipher == null ) { // \uC554\uD638\uD654\uB41C \uB370\uC774\uD130\uAC00 \uC544\uB2CC \uACBD\uC6B0
						if ( totalReadLength > 0 && totalReadLength < bufferLength ) {
							newBuffer = new byte[ totalReadLength ];
							System.arraycopy( buffer, 0, newBuffer, 0, totalReadLength );
					
							buffer = null;
							buffer = newBuffer;
							newBuffer = null;
						} else {
							// Read \uD574\uC57C\uD560 \uAE38\uC774\uC640 \uC2E4\uC81C\uB85C Read \uD55C \uAE38\uC774\uAC00 \uAC19\uC740 \uACBD\uC6B0 ==> Skip
						}
					} else { // \uC554\uD638\uD654\uB41C \uB370\uC774\uD130\uC778 \uACBD\uC6B0 ==> \uBCF5\uD638\uD654
						encrypedData = new byte[ totalReadLength ];
						System.arraycopy( buffer, 0, encrypedData, 0, totalReadLength );
						
						// \uB370\uC774\uD130 \uBCF5\uD638\uD654
						buffer = null;
						buffer = cipher.doFinal( encrypedData );
					}
					
					// Null Value\uB97C Space\uB85C \uBCC0\uD658\uD574\uC57C \uD558\uB294 \uACBD\uC6B0
					if ( nullToSpace.equals( "Yes" ) ) {
						for ( int i = 0; i < buffer.length; i++ ) {
							if( buffer[ i ] == ( byte )0x00 || buffer[ i ] == ( byte )0xff ) {
								buffer[ i ] = ( byte )0x20;
							}
						}
					}
					
					if ( charset == null || charset.equals( "" ) ) {
						strBuffer = new String( buffer );
					} else { 
						strBuffer = new String( buffer, charset );						
					}
				}
			}
		} catch ( SocketException se ) {
			if ( debugLog.equals( "false" ) ) {
				// Server Log Skip
			} else {
				debugLogger.printLogAtIS( "### readFromStream Error(SocketException)" + checkMsg + " : " + se.toString(), "asynch" );
			}
			
			errorMsg = se.toString();
			readLog = strReadLogBuffer.toString();
			
			if ( totalReadLength == 0 ) {
				buffer = null;
				strBuffer = "";
			} else {
				newBuffer = new byte[ totalReadLength ];
				System.arraycopy( buffer, 0, newBuffer, 0, totalReadLength );
				
				// Null Value\uB97C Space\uB85C \uBCC0\uD658\uD574\uC57C \uD558\uB294 \uACBD\uC6B0
				if ( nullToSpace.equals( "Yes" ) ) {
					for ( int i = 0; i < newBuffer.length; i++ ) {
						if( newBuffer[ i ] == ( byte )0x00 || newBuffer[ i ] == ( byte )0xff ) {
							newBuffer[ i ] = ( byte )0x20;
						}
					}
				}
				
				if ( charset == null || charset.equals( "" ) ) {
					strBuffer = new String( newBuffer );
				} else {
					try {
						strBuffer = new String( newBuffer, charset );
					} catch ( Exception be ) {
						
					}
				}
				
				newBuffer = null;
			}
		} catch ( Exception e ) {
			if ( debugLog.equals( "false" ) ) {
				// Server Log Skip
			} else {
				debugLogger.printLogAtIS( "### readFromStream Error(Exception)" + checkMsg + " : " + e.toString(), "asynch" );
			}
			
			errorMsg = e.toString();
			readLog = strReadLogBuffer.toString();
			
			if ( totalReadLength == 0 ) {
				buffer = null;
				strBuffer = "";
			} else {
				newBuffer = new byte[ totalReadLength ];
				System.arraycopy( buffer, 0, newBuffer, 0, totalReadLength );
				
				// Null Value\uB97C Space\uB85C \uBCC0\uD658\uD574\uC57C \uD558\uB294 \uACBD\uC6B0
				if ( nullToSpace.equals( "Yes" ) ) {
					for ( int i = 0; i < newBuffer.length; i++ ) {
						if( newBuffer[ i ] == ( byte )0x00 || newBuffer[ i ] == ( byte )0xff ) {
							newBuffer[ i ] = ( byte )0x20;
						}
					}
				}
				
				if ( charset == null || charset.equals( "" ) ) {
					strBuffer = new String( newBuffer );
				} else {
					try {
						strBuffer = new String( newBuffer, charset );
					} catch ( Exception be ) {
						
					}
				}
				
				newBuffer = null;
			}
		} finally {
			try {
				if ( baos != null ) {
					baos.close();
				}
			} catch ( Exception fe ) {
				errorMsg = fe.toString();
			}
		}
		
		IData body = IDataFactory.create();
		IDataCursor bcur = body.getCursor();
		IDataUtil.put( bcur, "bytes", buffer );
		IDataUtil.put( bcur, "string", strBuffer );
		bcur.destroy();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "body", body );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "readLog", readLog );
		pipelineCursor_1.destroy();
		
		baos = null;
		cipher = null;
		strReadLogBuffer = null;
		buffer = null;
		encrypedData = null;
		strBuffer = null;
		body = null;
		// --- <<IS-END>> ---

                
	}



	public static final void readFromStreamUntilDelimiter (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(readFromStreamUntilDelimiter)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] object:0:required inputStream
		// [i] field:0:required docDelimiter
		// [i] field:0:required charset
		// [i] field:0:required online {"NoS","NoM","NoF","NoFF","YesW","YesR"}
		// [i] field:0:required debugLog {"","true","false"}
		// [i] field:0:required nullToSpace {"","No","Yes"}
		// [o] record:0:required body
		// [o] - object:0:required bytes
		// [o] - field:0:required string
		// [o] field:0:required errorMsg
		// [o] field:0:required readLog
		IDataCursor pipelineCursor = pipeline.getCursor();
		BufferedInputStream	inputStream	= ( BufferedInputStream )IDataUtil.get( pipelineCursor, "inputStream" );
		String docDelimiter = IDataUtil.getString( pipelineCursor, "docDelimiter" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		String online = IDataUtil.getString( pipelineCursor, "online" );
		String debugLog = IDataUtil.getString( pipelineCursor, "debugLog" );
		String nullToSpace = IDataUtil.getString( pipelineCursor, "nullToSpace" );
		pipelineCursor.destroy();
		
		if ( online == null || online.equals( "" ) ) {
			online = "NoS";
		}
		
		if ( debugLog == null || debugLog.equals( "" ) ) {
			debugLog = "true";
		}
		
		if ( nullToSpace == null || nullToSpace.equals( "" ) ) {
			nullToSpace = "No";
		}
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte dataByte = ( byte )0x00;
		byte deliByte = docDelimiter.getBytes()[ 0 ];
		int len = 0;
		byte[] buffer = null;
		String strBuffer = "";
		int totalReadLength = 0; // inputstream \uC5D0\uC11C \uC2E4\uC81C\uB85C read \uD55C \uB204\uC801 byte \uC218
		StringBuffer strReadLogBuffer = new StringBuffer();
		String readLog = "";
		String errorMsg = "";
		
		try {
			// inputStream.read() ==> InputStream\uC73C\uB85C\uBD80\uD130 1byte\uB97C Read, 4bytes int \uD0C0\uC785\uC73C\uB85C \uB9AC\uD134
			// \uADF8\uB7EC\uBBC0\uB85C Read \uD55C \uC804\uCCB4 Bytes Length \uAD6C\uD560 \uB54C len\uC744 \uACC4\uC18D \uD569\uC0B0\uD558\uBA74 \uC548\uB41C\uB2E4.
			while ( ( len = inputStream.read() ) != -1 ) {
				totalReadLength += 1;
				dataByte = ( byte )len;
				
				if ( dataByte == deliByte ) {
					// Read \uD55C \uB370\uC774\uD130\uAC00 delimiter\uC778 \uACBD\uC6B0 ==> \uC804\uBB38 \uB370\uC774\uD130\uC758 \uB05D\uC744 \uC758\uBBF8. delimiter \uB370\uC774\uD130\uB294 \uBC84\uB9AC\uACE0 Break \uD55C\uB2E4.
					totalReadLength -= 1;
					break;
				} else {
					// Null Value\uB97C Space\uB85C \uBCC0\uD658\uD574\uC57C \uD558\uB294 \uACBD\uC6B0
					if ( nullToSpace.equals( "Yes" ) ) {
						if ( dataByte == ( byte )0x00 || dataByte == ( byte )0xff ) {
							baos.write( ( byte )0x20 );
						} else {
							baos.write( dataByte );
						}
					} else {
						baos.write( dataByte );
					}
				}
			}
			
			strReadLogBuffer.append( "InputStream \uC5D0\uC11C \uC2E4\uC81C\uB85C Read \uD55C Length \uD569\uACC4 ::: " + totalReadLength );
			
			// Server \uCABD\uC5D0\uC11C \uC784\uC758\uB85C Socket Close \uD55C \uACBD\uC6B0\uC5D0\uB294 -1 \uC774 \uB9AC\uD134\uB41C\uB2E4.
			// Online Socket \uC758 \uACBD\uC6B0\uB294 \uC5D0\uB7EC\uCC98\uB9AC\uB97C \uD558\uACE0 Online \uC774 \uC544\uB2CC Synch \uBC29\uC2DD\uC778 \uACBD\uC6B0\uB294 \uC5D0\uB7EC\uCC98\uB9AC\uD558\uC9C0 \uC54A\uB294\uB2E4.
			if ( len == -1 ) {
				if ( online.equals( "YesR" ) || online.equals( "YesW" ) ) {
					errorMsg = "java.net.ESBException: Socket closed from remote side.";
				} else {
					strReadLogBuffer.append( "\n" );
					strReadLogBuffer.append( "Remote side\uC5D0\uC11C socket closed\uAC00 \uBC1C\uC0DD\uD558\uC5EC InputStream Reading Exit" );
					
					// Online Socket \uC774\uC678\uC758 Synch \uBC29\uC2DD\uC73C\uB85C Read \uD558\uB294 \uACBD\uC6B0\uC5D0\uB3C4 totalReadLength\uAC00 0 \uC778 \uACBD\uC6B0\uC5D0\uB294 \uC5D0\uB7EC\uCC98\uB9AC\uD55C\uB2E4.
					if ( totalReadLength == 0 ) {
						errorMsg = "java.net.ESBException: Data length received from remote side is 0";
					} else {
						// \uC2E4\uC81C\uB85C Read \uD55C \uB370\uC774\uD130 \uAE38\uC774\uAC00 Read \uD574\uC57C \uD560 \uB370\uC774\uD130 \uAE38\uC774\uBCF4\uB2E4 \uC791\uC740 \uACBD\uC6B0
						errorMsg = "java.net.ESBException: Data length received from remote side is insufficient";
					}
				}
			}
			
			readLog = strReadLogBuffer.toString();
			
			if ( totalReadLength == 0 ) {
				buffer = null;
				strBuffer = "";
			} else {			
				buffer = baos.toByteArray();
				
				if ( charset == null || charset.equals( "" ) ) {
					strBuffer = new String( buffer );
				} else {
					try {
						strBuffer = new String( buffer, charset );
					} catch ( Exception be ) {
						
					}
				}
			}
		} catch ( SocketException se ) {
			if ( debugLog.equals( "false" ) ) {
				// Server Log Skip
			} else {
				debugLogger.printLogAtIS( "### readFromStreamUntilDelimiter Error(SocketException)" + " : " + se.toString(), "asynch" );
			}
			
			errorMsg = se.toString();
			readLog = strReadLogBuffer.toString();
			
			if ( totalReadLength == 0 ) {
				buffer = null;
				strBuffer = "";
			} else {
				buffer = baos.toByteArray();
				
				if ( charset == null || charset.equals( "" ) ) {
					strBuffer = new String( buffer );
				} else {
					try {
						strBuffer = new String( buffer, charset );
					} catch ( Exception be ) {
						
					}
				}
			}
		} catch ( Exception e ) {
			if ( debugLog.equals( "false" ) ) {
				// Server Log Skip
			} else {
				debugLogger.printLogAtIS( "### readFromStreamUntilDelimiter Error(Exception)" + " : " + e.toString(), "asynch" );
			}
			
			errorMsg = e.toString();
			readLog = strReadLogBuffer.toString();
			
			if ( totalReadLength == 0 ) {
				buffer = null;
				strBuffer = "";
			} else {
				buffer = baos.toByteArray();
				
				if ( charset == null || charset.equals( "" ) ) {
					strBuffer = new String( buffer );
				} else {
					try {
						strBuffer = new String( buffer, charset );
					} catch ( Exception be ) {
						
					}
				}
			}
		} finally {
			try {
				if ( baos != null ) {
					baos.close();
				}
			} catch ( Exception fe ) {
				errorMsg = fe.toString();
			}
		}
		
		IData body = IDataFactory.create();
		IDataCursor bcur = body.getCursor();
		IDataUtil.put( bcur, "bytes", buffer );
		IDataUtil.put( bcur, "string", strBuffer );
		bcur.destroy();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "body", body );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "readLog", readLog );
		pipelineCursor_1.destroy();
		
		baos = null;
		strReadLogBuffer = null;
		buffer = null;
		strBuffer = null;
		body = null;
		// --- <<IS-END>> ---

                
	}



	public static final void readUntilEOL (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(readUntilEOL)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:optional eol
		// [i] object:0:required inputStream
		// [o] object:0:required inputStream
		// [o] field:0:required line
		// [o] field:0:required isEOF
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String eol = IDataUtil.getString( pipelineCursor, "eol" );
		BufferedInputStream	inputStream	= ( BufferedInputStream )IDataUtil.get( pipelineCursor, "inputStream" );
		pipelineCursor.destroy();
		
		if ( eol == null )
			eol = "\n";
		
		int b = 0;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		String line = "";
		String isEOF = "";
		String errorMsg = "";
		
		try {
			while ( ( b = inputStream.read() ) != -1 ) {
				baos.write( ( byte )b );
				
				if ( baos.toString().endsWith( eol ) )
					break;
			}
			
			if ( b == -1 ) {
				isEOF = "true";
			} else {
				isEOF = "false";
			}
			
			line = baos.toString();
		} catch ( Exception e ) {
			debugLogger.printLogAtIS( "### readUntilEOL Error : " + e.toString(), "asynch" );
			errorMsg = e.toString(); 
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "inputStream", inputStream );
		IDataUtil.put( pipelineCursor_1, "line", line );
		IDataUtil.put( pipelineCursor_1, "isEOF", isEOF );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeOnlineSocketClient (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeOnlineSocketClient)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		IDataCursor pipelineCursor = pipeline.getCursor();
		String NAME = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		sManager.removeOnlineSocketClient( NAME );
		// --- <<IS-END>> ---

                
	}



	public static final void removeSocketClient (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeSocketClient)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		IDataCursor pipelineCursor = pipeline.getCursor();
		String NAME = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		sManager.removeSocketClient( NAME );
		// --- <<IS-END>> ---

                
	}



	public static final void removeSocketServer (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeSocketServer)>> ---
		// @sigtype java 3.5
		// [i] field:0:required NAME
		IDataCursor pipelineCursor = pipeline.getCursor();
		String NAME = IDataUtil.getString( pipelineCursor, "NAME" );
		pipelineCursor.destroy();
		
		sManager.removeSocketServer( NAME );
		// --- <<IS-END>> ---

                
	}



	public static final void runServerSocket (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(runServerSocket)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required portNumber
		// [i] field:0:required servicePath
		// [i] field:0:required runAs
		// [i] field:0:optional readTimeout
		// [i] field:0:required threadPool
		// [i] field:0:required poolSize
		// [i] field:0:required online
		// [i] field:0:required portDuplexing
		// [i] field:0:required serialProcessing
		// [i] field:0:required allowedSessionCount
		// [i] field:0:required direction
		// [i] field:0:required outPortNumber
		// [i] field:0:required nagleAlg
		// [o] object:0:required serverSocketThread
		// [o] object:0:required threadPoolServerSocketThread
		// [o] object:0:required asynchOnlineServerSocketThread
		// [o] object:0:required synchronizeServerSocketThread
		// [o] field:0:required errorMsg
		IDataCursor	pipelineCursor = pipeline.getCursor();
		int portNumber = IDataUtil.getInt( pipelineCursor, "portNumber", 0 );
		String svcPath = IDataUtil.getString( pipelineCursor, "servicePath" );
		String runAs = IDataUtil.getString( pipelineCursor, "runAs" );
		int readTimeout	= IDataUtil.getInt( pipelineCursor, "readTimeout", 0 );
		String threadPool	= IDataUtil.getString( pipelineCursor, "threadPool" );
		int poolSize	= IDataUtil.getInt( pipelineCursor, "poolSize", 0 );
		String online	= IDataUtil.getString( pipelineCursor, "online" );
		String portDuplexing	= IDataUtil.getString( pipelineCursor, "portDuplexing" );
		String serialProcessing	= IDataUtil.getString( pipelineCursor, "serialProcessing" );
		String allowedSessionCount	= IDataUtil.getString( pipelineCursor, "allowedSessionCount" );
		String direction = IDataUtil.getString( pipelineCursor, "direction" );
		String outPortNumber = IDataUtil.getString( pipelineCursor, "outPortNumber" );
		String nagleAlg	= IDataUtil.getString( pipelineCursor, "nagleAlg" );
		pipelineCursor.destroy();
		
		if ( outPortNumber == null ) {
			outPortNumber = "";
		}
		
		if ( outPortNumber.equals( "" ) ) {
			outPortNumber = portNumber + "";
		}
		
		if ( svcPath == null ) {
			svcPath = "";
		}
		
		if ( nagleAlg == null || nagleAlg.equals("") ) {
			nagleAlg = "Yes";
		}
		
		SocketServer ssThread = null;
		ThreadPoolSocketServer tpssThread = null;
		AsynchOnlineSocketServer aossThread = null;
		SynchronizeSocketServer sssThread = null;
		String errorMsg = "";
		
		try {
			if ( threadPool.equals( "true" ) ) {
				tpssThread = sManager.runThreadPoolServerSocket( portNumber, svcPath, runAs, readTimeout, poolSize, nagleAlg );
				
				if ( tpssThread == null ) {
					errorMsg = "ServerSocket \uAC1D\uCCB4\uC0DD\uC131 \uC2E4\uD328";
				}
			} else {
				if ( online.equals( "No" ) ) {
					if ( svcPath.equals( "" ) ) {
						sssThread = sManager.runSynchronizeServerSocket( portNumber, readTimeout );
						
						if ( sssThread == null ) {
							errorMsg = "ServerSocket \uAC1D\uCCB4\uC0DD\uC131 \uC2E4\uD328";
						}
					} else {
						ssThread = sManager.runServerSocket( portNumber, svcPath, runAs, readTimeout, serialProcessing, nagleAlg );
						
						if ( ssThread == null ) {
							errorMsg = "ServerSocket \uAC1D\uCCB4\uC0DD\uC131 \uC2E4\uD328";
						}
					}
				} else {
					aossThread = sManager.runOnlineServerSocket( portNumber, svcPath, runAs, readTimeout, Integer.parseInt( allowedSessionCount ), direction, outPortNumber, portDuplexing, nagleAlg );
					
					if ( aossThread == null ) {
						errorMsg = "ServerSocket \uAC1D\uCCB4\uC0DD\uC131 \uC2E4\uD328";
					}
				}
			}
		} catch ( Exception e ) {
			debugLogger.printLogAtIS( "### runServerSocket Error : " + e.toString(), "asynch" );
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "serverSocketThread", ssThread );
		IDataUtil.put( pipelineCursor_1, "threadPoolServerSocketThread", tpssThread );
		IDataUtil.put( pipelineCursor_1, "asynchOnlineServerSocketThread", aossThread );
		IDataUtil.put( pipelineCursor_1, "synchronizeServerSocketThread", sssThread );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void setSoTimeout (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(setSoTimeout)>> ---
		// @sigtype java 3.5
		// [i] object:0:required socket
		// [i] field:0:required readTimeout
		// [o] field:0:required errorMsg
		IDataCursor	pipelineCursor = pipeline.getCursor();
		Socket socket = ( Socket )IDataUtil.get( pipelineCursor, "socket" );
		int	readTimeout = IDataUtil.getInt( pipelineCursor, "readTimeout", 0 );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			socket.setSoTimeout( readTimeout );
		} catch( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void writeFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeFile)>> ---
		// @sigtype java 3.5
		// [i] object:0:required socket
		// [i] object:0:required outputStream
		// [i] object:0:required cipher
		// [i] field:0:optional fileName
		// [i] field:0:optional shutdownOutput {"false","true"}
		// [o] object:0:required socket
		// [o] object:0:required outputStream
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		Socket socket = ( Socket )IDataUtil.get( pipelineCursor, "socket" );
		BufferedOutputStream outputStream = ( BufferedOutputStream )IDataUtil.get( pipelineCursor, "outputStream" );
		Cipher cipher = ( Cipher )IDataUtil.get( pipelineCursor, "cipher" );
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		String shutdownOutput = IDataUtil.getString( pipelineCursor, "shutdownOutput" );
		pipelineCursor.destroy();
		
		String errorMsg = "";		
		File file = null;
		FileInputStream fis = null;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] fileBytes = null;
		byte[] encrypedData = null;
		byte[] buffer = new byte[ 1024 * 8 ];
		int r = 0;
		
		if ( shutdownOutput == null ) {
			shutdownOutput = "false";
		}
		
		try {
			file = new File( fileName );
			fis = new FileInputStream( file );			
			
			while ( ( r = fis.read( buffer ) ) != -1 ) {
				if ( r > 0 ) {
					baos.write( buffer, 0, r );
				}
			}
			
			fileBytes = baos.toByteArray();
			
			if ( cipher == null ) { // \uC554\uD638\uD654 \uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0	
				outputStream.write( fileBytes );
			} else { // \uC554\uD638\uD654 \uD558\uB294 \uACBD\uC6B0
				encrypedData = cipher.doFinal( fileBytes );
				outputStream.write( encrypedData );
			}
			
			outputStream.flush();
			
			// \uB370\uC774\uD130 \uC1A1\uC2E0 \uC885\uB8CC
			if ( shutdownOutput.equals( "true" ) ) {
				socket.shutdownOutput();
			}
		} catch ( Exception e ) {
			debugLogger.printLogAtIS( "### writeFile Error : " + e.toString(), "asynch" );
			errorMsg = e.toString();
		} finally {
			try {
				if ( fis != null ) {
					fis.close();
				}
				
				if ( baos != null ) {
					baos.close();
				}
			} catch ( Exception fe ) {
				errorMsg = fe.toString();
			}
		}
		
		file = null;
		fis = null;
		cipher = null;
		baos = null;
		buffer = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void writeFlatFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeFlatFile)>> ---
		// @sigtype java 3.5
		// [i] object:0:required socket
		// [i] object:0:required outputStream
		// [i] object:0:required cipher
		// [i] field:0:optional fileName
		// [i] field:0:required fileEncoding
		// [i] field:0:optional shutdownOutput {"false","true"}
		// [o] object:0:required socket
		// [o] object:0:required outputStream
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		Socket socket = ( Socket )IDataUtil.get( pipelineCursor, "socket" );
		BufferedOutputStream outputStream = ( BufferedOutputStream )IDataUtil.get( pipelineCursor, "outputStream" );
		Cipher cipher = ( Cipher )IDataUtil.get( pipelineCursor, "cipher" );
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		String fileEncoding = IDataUtil.getString( pipelineCursor, "fileEncoding" );
		String shutdownOutput = IDataUtil.getString( pipelineCursor, "shutdownOutput" );
		pipelineCursor.destroy();
		
		String errorMsg = "";		
		BufferedReader fileReader = null;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] fileBytes = null;
		byte[] encrypedData = null;
		String fileContent = "";
		int lineIndex = 0;
		
		if ( shutdownOutput == null ) {
			shutdownOutput = "false";
		}
		
		try {
			fileReader = new BufferedReader( new InputStreamReader( new FileInputStream( fileName ), fileEncoding ) );
			
			while ( ( fileContent = fileReader.readLine() ) != null ) {
				if ( lineIndex == 0 ) {
					baos.write( fileContent.getBytes( fileEncoding ) );
				} else {
					if ( fileContent.equals( "\n" ) ) {
						baos.write( fileContent.getBytes( fileEncoding ) );
					} else {
						fileContent = "\n" + fileContent;
						baos.write( fileContent.getBytes( fileEncoding ) );
					}
				}
				
				lineIndex++;
			}
			
			fileBytes = baos.toByteArray();
			
			if ( cipher == null ) { // \uC554\uD638\uD654 \uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0	
				outputStream.write( fileBytes );
			} else { // \uC554\uD638\uD654 \uD558\uB294 \uACBD\uC6B0
				encrypedData = cipher.doFinal( fileBytes );
				outputStream.write( encrypedData );
			}
				
			outputStream.flush();				
			
			// \uB370\uC774\uD130 \uC1A1\uC2E0 \uC885\uB8CC
			if ( shutdownOutput.equals( "true" ) ) {
				socket.shutdownOutput();
			}
		} catch ( Exception e ) {
			debugLogger.printLogAtIS( "### writeFlatFile Error : " + e.toString(), "asynch" );
			errorMsg = e.toString();
		} finally {
			try {
				if ( fileReader != null ) {
					fileReader.close();
				}
				
				if ( baos != null ) {
					baos.close();
				}
			} catch ( Exception fe ) {
				errorMsg = fe.toString();
			}
		}
		
		fileReader = null;
		cipher = null;
		baos = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void writeToStream (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeToStream)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:optional stringToWrite
		// [i] object:0:optional bytesToWrite
		// [i] object:0:required socket
		// [i] object:0:required outputStream
		// [i] object:0:required cipher
		// [i] field:0:optional charset
		// [i] field:0:optional shutdownOutput {"false","true"}
		// [o] object:0:required socket
		// [o] object:0:required outputStream
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		Socket socket = ( Socket )IDataUtil.get( pipelineCursor, "socket" );
		BufferedOutputStream outputStream = ( BufferedOutputStream )IDataUtil.get( pipelineCursor, "outputStream" );
		Cipher cipher = ( Cipher )IDataUtil.get( pipelineCursor, "cipher" );
		byte[] btw = ( byte[] )IDataUtil.get( pipelineCursor, "bytesToWrite" );
		String shutdownOutput = IDataUtil.getString( pipelineCursor, "shutdownOutput" );
		String stw = IDataUtil.getString( pipelineCursor, "stringToWrite" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		byte[] encrypedData = null;
		
		if ( shutdownOutput == null ) {
			shutdownOutput = "false";
		}
		
		try {
			if ( btw == null ) {
				if ( charset == null ) {
					btw = stw.getBytes();
				} else {
					btw = stw.getBytes( charset );
				}
			}
			
			if ( cipher == null ) { // \uC554\uD638\uD654 \uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0			
				outputStream.write( btw );
			} else { // \uC554\uD638\uD654 \uD558\uB294 \uACBD\uC6B0
				encrypedData = cipher.doFinal( btw );
				outputStream.write( encrypedData );
			}
			
			outputStream.flush();
			
			// \uB370\uC774\uD130 \uC1A1\uC2E0 \uC885\uB8CC
			if ( shutdownOutput.equals( "true" ) ) {
				socket.shutdownOutput();
			}
		} catch ( Exception e ) {
			debugLogger.printLogAtIS( "### writeBuffer Error : " + e.toString(), "asynch" );
			errorMsg = e.toString();
		}
		
		cipher = null;
		btw = null;
		encrypedData = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	
	private static SocketManager sManager = SocketManager.getInstance();
	private static DebugLogger debugLogger = new DebugLogger();
	private static final String DEBUG_LEVEL = "4";
		
	// --- <<IS-END-SHARED>> ---
}

