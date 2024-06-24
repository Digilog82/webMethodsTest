package JSocketAdapter.BATCH.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class RECORD

{
	// ---( internal utility methods )---

	final static RECORD _instance = new RECORD();

	static RECORD _newInstance() { return new RECORD(); }

	static RECORD _cast(Object o) { return (RECORD)o; }

	// ---( server methods )---




	public static final void concatDataRecord (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(concatDataRecord)>> ---
		// @sigtype java 3.5
		// [i] field:0:required dataRecord
		// [i] field:0:required addData
		// [o] field:0:required dataRecord
		IDataCursor pipelineCursor = pipeline.getCursor();
		String dataRecord = IDataUtil.getString( pipelineCursor, "dataRecord" );
		String addData = IDataUtil.getString( pipelineCursor, "addData" );
		pipelineCursor.destroy();
		
		StringBuffer strBuffer = new StringBuffer();
		
		strBuffer.append( dataRecord );
		strBuffer.append( addData );
		
		dataRecord = strBuffer.toString();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "dataRecord", dataRecord );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertToRecord (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertToRecord)>> ---
		// @sigtype java 3.5
		// [i] field:0:required dataRecord
		// [i] field:0:required recLength
		// [i] field:0:required recCount
		// [i] field:0:required encoding
		// [o] field:0:required errorMsg
		// [o] field:0:required dataRecord
		IDataCursor pipelineCursor = pipeline.getCursor();
		String dataRecord = IDataUtil.getString( pipelineCursor, "dataRecord" );
		int recLength = Integer.parseInt( IDataUtil.getString( pipelineCursor, "recLength" ) );
		int recCount = Integer.parseInt( IDataUtil.getString( pipelineCursor, "recCount" ) );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		byte[] dataBytes = null;
		StringBuffer strBuffer = new StringBuffer();
		String recData = "";
		String tempData = "";
		int startIndex = 0;
		
		try {
			dataBytes = dataRecord.getBytes( encoding );
			
			for ( int i = 0; i < recCount; i++ ) {
				tempData = new String( dataBytes, startIndex, recLength, encoding );
				strBuffer.append( tempData );
				strBuffer.append( "\n" );
				startIndex += recLength;
			}
			
			recData = strBuffer.toString();
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		dataBytes = null;
		strBuffer = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "dataRecord", recData );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertToRecordByDelim (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertToRecordByDelim)>> ---
		// @sigtype java 3.5
		// [i] field:0:required dataRecord
		// [i] field:0:required delim
		// [o] field:0:required outDataRecords
		IDataCursor pipelineCursor = pipeline.getCursor();
		String dataRecord = IDataUtil.getString( pipelineCursor, "dataRecord" );
		String delim = IDataUtil.getString( pipelineCursor, "delim" );
		pipelineCursor.destroy();
		
		StringBuffer strBuffer = new StringBuffer();
		String outDataRecords = "";
		
		String[] recordList = dataRecord.split( delim );
		
		for ( int i = 0; i < recordList.length; i++ ) {
			strBuffer.append( recordList[ i ] );
			strBuffer.append( "\n" );
		}
		
		outDataRecords = strBuffer.toString();
		
		strBuffer = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outDataRecords", outDataRecords );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getSendRecordCount (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getSendRecordCount)>> ---
		// @sigtype java 3.5
		// [i] field:0:required maxLength
		// [i] field:0:required headerLength
		// [i] field:0:required recLength
		// [o] field:0:required sendRecCount
		IDataCursor pipelineCursor = pipeline.getCursor();
		int maxLength = Integer.parseInt( IDataUtil.getString( pipelineCursor, "maxLength" ) );
		int headerLength = Integer.parseInt( IDataUtil.getString( pipelineCursor, "headerLength" ) );
		int recLength = Integer.parseInt( IDataUtil.getString( pipelineCursor, "recLength" ) );
		pipelineCursor.destroy();
		
		int sendRecCount = ( maxLength - headerLength ) / recLength;
		
		// sendRecCount\uC5D0\uC11C 1\uC744 \uBE7C\uC900\uB2E4.
		sendRecCount--;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "sendRecCount", sendRecCount + "" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}
}

