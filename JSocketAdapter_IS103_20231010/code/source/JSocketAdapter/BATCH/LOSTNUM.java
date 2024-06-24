package JSocketAdapter.BATCH;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class LOSTNUM

{
	// ---( internal utility methods )---

	final static LOSTNUM _instance = new LOSTNUM();

	static LOSTNUM _newInstance() { return new LOSTNUM(); }

	static LOSTNUM _cast(Object o) { return (LOSTNUM)o; }

	// ---( server methods )---




	public static final void checkLostNum (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(checkLostNum)>> ---
		// @sigtype java 3.5
		// [i] field:0:required lastSeqNo
		// [i] record:1:required receiveDataList
		// [o] field:0:required errorMsg
		// [o] field:0:required lostNumCount
		// [o] field:0:required checkResult
		// [o] record:1:required receiveDataList
		IDataCursor pipelineCursor = pipeline.getCursor();
		int lastSeqNo = Integer.parseInt( IDataUtil.getString( pipelineCursor, "lastSeqNo" ) );
		IData[] receiveDataList = IDataUtil.getIDataArray( pipelineCursor, "receiveDataList" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		int receiveDataCount = 0;
		int receiveSeqNo = 0;
		int normalSeqNo = 1;
		String checkResult = "";
		int lostNumCount = 0;
		
		String key = "seqNo";
		int compareType = IDataUtil.COMPARE_TYPE_COLLATION;
		String pattern = "yyyyMMdd HH:mm:ss.SSS";
		boolean reverse = false;
		
		IDataCursor curCursor = null;
		String lostYN = ""; // 1 : \uC218\uC2E0\uC644\uB8CC, 0 : \uC218\uC2E0\uBBF8\uC644\uB8CC
		
		try {
			// \uC2E4\uC81C\uB85C \uC218\uC2E0\uD55C \uB808\uCF54\uB4DC \uC218
			receiveDataCount = receiveDataList.length;
			
			// seqNo \uAE30\uC900\uC73C\uB85C Sorting.
			receiveDataList = IDataUtil.sortIDataArrayByKey( receiveDataList, key, compareType, pattern, reverse );
		
			for ( int i = 0; i < receiveDataCount; i++ ) {
				curCursor = receiveDataList[ i ].getCursor();
				receiveSeqNo = Integer.parseInt( IDataUtil.getString( curCursor, key ) );
			
				if ( normalSeqNo == receiveSeqNo ) {
					// \uC218\uC2E0\uC644\uB8CC
					lostYN = "1";
				
					// Next Normal seqNo
					normalSeqNo++;
				} else {
					// \uACB0\uBC88 \uAC2F\uC218
					lostNumCount = lostNumCount + ( receiveSeqNo - normalSeqNo );
				
					// \uACB0\uBC88 \uACB0\uACFC ==> \uACB0\uBC88 \uAC2F\uC218\uB9CC\uD07C "0" \uC744 \uBD99\uC784
					for ( int j = 0; j < receiveSeqNo - normalSeqNo; j++ ) {
						lostYN += "0";
					}
				
					// \uD604\uC7AC \uB808\uCF54\uB4DC\uC5D0 \uB300\uD574\uC11C\uB294 \uC218\uC2E0\uC644\uB8CC "1" \uC744 \uBD99\uC784
					lostYN += "1";
				
					// Next Normal seqNo
					normalSeqNo = receiveSeqNo + 1;				
				}
			
				// \uACB0\uBC88\uD655\uC778 \uACB0\uACFC Concat
				checkResult += lostYN;
				lostYN = "";
			
				// Next Normal seqNo \uAC00 lastSeqNo \uBCF4\uB2E4 \uD074 \uACBD\uC6B0\uC5D0\uB294 Break
				if ( normalSeqNo > lastSeqNo ) {
					break;
				}
			}
		
			if ( receiveSeqNo == lastSeqNo ) {
				// Skip
			} else if ( receiveSeqNo < lastSeqNo ) {
				// \uC2E4\uC81C\uB85C \uC218\uC2E0\uD55C \uB9C8\uC9C0\uB9C9 seqNo \uAC00 lastSeqNo \uBCF4\uB2E4 \uC791\uC740 \uACBD\uC6B0\uC5D0\uB294 \uB098\uBA38\uC9C0 seqNo \uC5D0 \uB300\uD574\uC11C \uACB0\uBC88 \uCC98\uB9AC\uD55C\uB2E4.
				for ( int k = 0; k < lastSeqNo - receiveSeqNo; k++ ) {
					checkResult += "0";
				}
			
				// \uACB0\uBC88 \uAC2F\uC218
				lostNumCount = lostNumCount + ( lastSeqNo - receiveSeqNo );
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "lostNumCount", lostNumCount + "" );
		IDataUtil.put( pipelineCursor_1, "checkResult", checkResult );
		IDataUtil.put( pipelineCursor_1, "receiveDataList", receiveDataList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getLostSeqNo (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getLostSeqNo)>> ---
		// @sigtype java 3.5
		// [i] field:0:required lostNumCount
		// [i] field:0:required checkResult
		// [o] field:1:required lostSeqNo
		IDataCursor pipelineCursor = pipeline.getCursor();
		int lostNumCount = Integer.parseInt( IDataUtil.getString( pipelineCursor, "lostNumCount" ) );
		String checkResult = IDataUtil.getString( pipelineCursor, "checkResult" );
		pipelineCursor.destroy();
		
		String[] lostSeqNo = new String[ lostNumCount ];
		String result = "";
		int recCount = checkResult.length();
		int lostIndex = 0;
		
		for ( int i = 0; i < recCount; i++ ) {
			result = checkResult.substring( i, i + 1 );
			
			// \uACB0\uBC88\uC778 \uACBD\uC6B0 seqNo \uAD6C\uD558\uAE30
			if ( result.equals( "0" ) ) {
				lostSeqNo[ lostIndex ] = ( i + 1 ) + "";
				lostIndex++;
			}
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "lostSeqNo", lostSeqNo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}
}

