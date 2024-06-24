package JSocketAdapter.TEST.PERFORMANCE;

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




	public static final void getOnlineTestDataList (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getOnlineTestDataList)>> ---
		// @sigtype java 3.5
		// [i] field:0:required businessType
		// [o] field:0:required errorMsg
		// [o] recref:1:required INPUT_DOC JSocketAdapter.TEST.PERFORMANCE:INPUT_DOC
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	businessType = IDataUtil.getString( pipelineCursor, "businessType" );
		IData INPUT_DOC[] = null;
		Hashtable hashTable = null;
		Enumeration hashList = null;
		int hashSize = 0;
		
		String errorMsg = "";
		
		try {
			if ( businessType.equals( "KLTO" ) ) {
				hashTable = OnlineKLTOList;
			} else if ( businessType.equals( "KLDO" ) ) {
				hashTable = OnlineKLDOList;
			} else if ( businessType.equals( "KLLO" ) ) {
				hashTable = OnlineKLLOList;
			} else if ( businessType.equals( "KRTB" ) ) {
				hashTable = SynchKRTBList;
			}
			
			hashSize = hashTable.size();
			hashList = hashTable.elements();
			INPUT_DOC = new IData[ hashSize ];
			
			for ( int i = 0; i < hashSize; i++ ) {
				INPUT_DOC[ i ] = ( IData )hashList.nextElement();
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		hashTable = null;
		hashList = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "INPUT_DOC", INPUT_DOC );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void putOnlineTestData (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(putOnlineTestData)>> ---
		// @sigtype java 3.5
		// [i] field:0:required businessType
		// [i] field:0:required name
		// [i] record:0:required InputData
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	businessType = IDataUtil.getString( pipelineCursor, "businessType" );
		String	name = IDataUtil.getString( pipelineCursor, "name" );
		IData InputData	= IDataUtil.getIData( pipelineCursor, "InputData" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			createOnlineDataList( businessType );
			
			if ( businessType.equals( "KLTO" ) ) {
				OnlineKLTOList.put( name, InputData );
			} else if ( businessType.equals( "KLDO" ) ) {
				OnlineKLDOList.put( name, InputData );
			} else if ( businessType.equals( "KLLO" ) ) {
				OnlineKLLOList.put( name, InputData );
			} else if ( businessType.equals( "KRTB" ) ) {
				SynchKRTBList.put( name, InputData );
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
			
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	
	private static Hashtable OnlineKLTOList = null;
	private static Hashtable OnlineKLDOList = null;
	private static Hashtable OnlineKLLOList = null;
	private static Hashtable SynchKRTBList = null;
	
	private static void createOnlineDataList( String businessType ) {
		if ( businessType.equals( "KLTO" ) ) {
			if ( OnlineKLTOList == null ) {
				OnlineKLTOList = new Hashtable();
			}
		} else if ( businessType.equals( "KLDO" ) ) {
			if ( OnlineKLDOList == null ) {
				OnlineKLDOList = new Hashtable();
			}
		} else if ( businessType.equals( "KLLO" ) ) {
			if ( OnlineKLLOList == null ) {
				OnlineKLLOList = new Hashtable();
			}
		} else if ( businessType.equals( "KRTB" ) ) {
			if ( SynchKRTBList == null ) {
				SynchKRTBList = new Hashtable();
			}
		}
	}
	
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

