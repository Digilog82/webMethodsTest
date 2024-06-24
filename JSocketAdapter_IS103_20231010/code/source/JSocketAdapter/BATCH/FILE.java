package JSocketAdapter.BATCH;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.*;
// --- <<IS-END-IMPORTS>> ---

public final class FILE

{
	// ---( internal utility methods )---

	final static FILE _instance = new FILE();

	static FILE _newInstance() { return new FILE(); }

	static FILE _cast(Object o) { return (FILE)o; }

	// ---( server methods )---




	public static final void closeFileReader (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(closeFileReader)>> ---
		// @sigtype java 3.5
		// [i] object:0:required fileReader
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		BufferedReader fileReader = ( BufferedReader )IDataUtil.get( pipelineCursor, "fileReader" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			fileReader.close();
		} catch ( Exception e ) {
			errorMsg = e.toString(); 
		}
		
		fileReader = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void closeFileWriter (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(closeFileWriter)>> ---
		// @sigtype java 3.5
		// [i] object:0:required fileWriter
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		BufferedWriter fileWriter = ( BufferedWriter )IDataUtil.get( pipelineCursor, "fileWriter" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			fileWriter.close();
		} catch ( Exception e ) {
			errorMsg = e.toString(); 
		}
		
		fileWriter = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void openFileReader (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(openFileReader)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [i] field:0:required fileEncoding
		// [o] field:0:required errorMsg
		// [o] object:0:required fileReader
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		String fileEncoding = IDataUtil.getString( pipelineCursor, "fileEncoding" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		BufferedReader fileReader = null;
		
		try {
			// InputStreamReader \uB97C \uC774\uC6A9\uD574\uC11C charset \uC744 \uBA85\uC2DC\uD574\uC57C \uD55C\uAE00 \uAE68\uC9D0 \uD604\uC0C1\uC774 \uC5C6\uB2E4.
			fileReader = new BufferedReader( new InputStreamReader( new FileInputStream( fileName ), fileEncoding ) );
		} catch ( Exception e ) {
			errorMsg = e.toString(); 
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "fileReader", fileReader );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void openFileWriter (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(openFileWriter)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [i] field:0:required append {"true","false"}
		// [i] field:0:required fileEncoding
		// [o] field:0:required errorMsg
		// [o] object:0:required fileWriter
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		//String append = IDataUtil.getString( pipelineCursor, "append" );
		boolean append = IDataUtil.getBoolean( pipelineCursor, "append" );
		String fileEncoding = IDataUtil.getString( pipelineCursor, "fileEncoding" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		BufferedWriter fileWriter = null;
		
		try {
			fileWriter = new BufferedWriter( new OutputStreamWriter( new FileOutputStream( fileName, append ), fileEncoding ) );
		} catch ( Exception e ) {
			errorMsg = e.toString(); 
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "fileWriter", fileWriter );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void readFileReader (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(readFileReader)>> ---
		// @sigtype java 3.5
		// [i] object:0:required fileReader
		// [o] field:0:required errorMsg
		// [o] field:0:required fileContent
		IDataCursor pipelineCursor = pipeline.getCursor();
		BufferedReader fileReader = ( BufferedReader )IDataUtil.get( pipelineCursor, "fileReader" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		String fileContent = "";
		
		try {
			fileContent = fileReader.readLine();
		} catch ( Exception e ) {
			errorMsg = e.toString(); 
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "fileContent", fileContent );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void writeFileWriter (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeFileWriter)>> ---
		// @sigtype java 3.5
		// [i] object:0:required fileWriter
		// [i] field:0:required fileContent
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		BufferedWriter fileWriter = ( BufferedWriter )IDataUtil.get( pipelineCursor, "fileWriter" );
		String fileContent = IDataUtil.getString( pipelineCursor, "fileContent" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			fileWriter.write( fileContent );
		} catch ( Exception e ) {
			errorMsg = e.toString(); 
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	public static void printLogAtIS( String message ) throws ServiceException {
		try	{
			IData inIData = IDataFactory.create();
	    	IDataCursor inputCursor = inIData.getCursor();
	    	IDataUtil.put( inputCursor, "message", message );
	    	IDataUtil.put( inputCursor, "function", Service.getServiceEntry().toString() );
	    	//IDataUtil.put( inputCursor, "level", DEBUG_LEVEL );
	    	Service.doInvoke( "pub.flow", "debugLog", inIData );
	    	inputCursor.destroy();
		} catch ( ServiceException se ) {
			throw se;
		} catch( Exception e ) {
			throw new ServiceException( e );
		}
	}
	// --- <<IS-END-SHARED>> ---
}

