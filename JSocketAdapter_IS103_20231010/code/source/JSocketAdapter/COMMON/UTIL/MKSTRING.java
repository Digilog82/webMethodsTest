package JSocketAdapter.COMMON.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class MKSTRING

{
	// ---( internal utility methods )---

	final static MKSTRING _instance = new MKSTRING();

	static MKSTRING _newInstance() { return new MKSTRING(); }

	static MKSTRING _cast(Object o) { return (MKSTRING)o; }

	// ---( server methods )---




	public static final void makeSpace (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(makeSpace)>> ---
		// @sigtype java 3.5
		// [i] field:0:required spaceCount
		// [o] field:0:required spaceString
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String spaceCount = IDataUtil.getString( pipelineCursor, "spaceCount" );
		pipelineCursor.destroy();
		
		int sCount = Integer.parseInt( spaceCount );
		String spaceString = "";
		StringBuffer strBuffer = new StringBuffer();
		
		for ( int i = 0; i < sCount; i++ ) {
			strBuffer.append( " " );
		}
		
		spaceString = strBuffer.toString();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "spaceString", spaceString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}
}

