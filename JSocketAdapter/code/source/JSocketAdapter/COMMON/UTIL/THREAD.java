package JSocketAdapter.COMMON.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.app.b2b.server.stats.Statistics;
import com.wm.lang.ns.*;
// --- <<IS-END-IMPORTS>> ---

public final class THREAD

{
	// ---( internal utility methods )---

	final static THREAD _instance = new THREAD();

	static THREAD _newInstance() { return new THREAD(); }

	static THREAD _cast(Object o) { return (THREAD)o; }

	// ---( server methods )---




	public static final void doInvoke (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(doInvoke)>> ---
		// @sigtype java 3.5
		// [i] field:0:required folderPath
		// [i] field:0:required serviceName
		// [i] record:0:required inputData
		// [o] record:0:required outputData
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String folderPath = IDataUtil.getString( pipelineCursor, "folderPath" );
		String serviceName = IDataUtil.getString( pipelineCursor, "serviceName" );
		IData inputData	= IDataUtil.getIData( pipelineCursor, "inputData" );
		pipelineCursor.destroy();
		
		IData outputData = null;
		
		if ( serviceName == null || serviceName.equals( "" ) ) {
			String[] fs = folderPath.split( ":" );
			folderPath = fs[ 0 ];
			serviceName = fs[ 1 ];
		}
		
		try {
			outputData = Service.doInvoke( folderPath, serviceName, inputData );
		} catch ( Exception e ) {
			throw new ServiceException( e );
		}
		
		inputData = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outputData", outputData );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void doThreadInvoke (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(doThreadInvoke)>> ---
		// @sigtype java 3.5
		// [i] field:0:required folderPath
		// [i] field:0:required serviceName
		// [i] field:0:required insertParentService {"","true","false"}
		// [i] record:0:required inputData
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String folderPath = IDataUtil.getString( pipelineCursor, "folderPath" );
		String serviceName = IDataUtil.getString( pipelineCursor, "serviceName" );
		String insertParentService = IDataUtil.getString( pipelineCursor, "insertParentService" );
		IData inputData	= IDataUtil.getIData( pipelineCursor, "inputData" );
		pipelineCursor.destroy();
		
		if ( serviceName == null || serviceName.equals( "" ) ) {
			String[] fs = folderPath.split( ":" );
			folderPath = fs[ 0 ];
			serviceName = fs[ 1 ];
		}
		
		if ( insertParentService == null ) {
			insertParentService = "false";
		}
		
		IDataCursor idCur = null;
		NSService callingService = null;
		
		// Parent Full Service Name\uC744 Invoke \uD558\uB294 Service\uC758 Input parameter\uB85C \uC804\uB2EC\uD558\uACE0\uC790 \uD558\uB294 \uACBD\uC6B0
		if ( insertParentService.equals( "true" ) ) {
			callingService = Service.getCallingService();
			String parentFullName = callingService.toString();
			
			if ( inputData == null ) {
				inputData = IDataFactory.create();
			}
			
			idCur = inputData.getCursor();
			idCur.insertAfter( "parentFullName", parentFullName );
		}
		
		Service.doThreadInvoke( folderPath, serviceName, inputData, 0 );
		
		if ( insertParentService.equals( "true" ) ) {
			idCur.destroy();
			callingService = null;
		}
		
		inputData = null;
		// --- <<IS-END>> ---

                
	}



	public static final void getThreadID (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getThreadID)>> ---
		// @sigtype java 3.5
		// [o] field:0:required threadID
		Thread thread = Thread.currentThread();
		long threadID = thread.getId();
		
		thread = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "threadID", threadID + "" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void reduceServiceThreadCount (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(reduceServiceThreadCount)>> ---
		// @sigtype java 3.5
		// [i] field:0:required threadServiceName
		// [i] field:0:required startTime
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String threadServiceName = IDataUtil.getString( pipelineCursor, "threadServiceName" );
		long startTime = IDataUtil.getLong( pipelineCursor, "startTime", 0 );
		pipelineCursor.destroy();
		
		Statistics st = new Statistics();
		st.endServiceThreadCount( NSName.create( threadServiceName ), startTime );
		
		st = null;
		// --- <<IS-END>> ---

                
	}



	public static final void sleep (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sleep)>> ---
		// @sigtype java 3.5
		// [i] field:0:required sleepTime
		IDataCursor	pipelineCursor = pipeline.getCursor();
		String sleepTime = IDataUtil.getString( pipelineCursor, "sleepTime" );
		pipelineCursor.destroy();
		
		try {
			Thread.sleep( Long.parseLong( sleepTime ) );
		} catch ( InterruptedException e ) {
			
		}
		// --- <<IS-END>> ---

                
	}



	public static final void synchronizedInvoke (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(synchronizedInvoke)>> ---
		// @sigtype java 3.5
		// [i] field:0:required folderPath
		// [i] field:0:required serviceName
		// [i] record:0:required inputData
		// [o] record:0:required outputData
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String folderPath = IDataUtil.getString( pipelineCursor, "folderPath" );
		String serviceName = IDataUtil.getString( pipelineCursor, "serviceName" );
		IData inputData	= IDataUtil.getIData( pipelineCursor, "inputData" );
		pipelineCursor.destroy();
		
		IData outputData = null;
		
		if ( serviceName == null || serviceName.equals( "" ) ) {
			String[] fs = folderPath.split( ":" );
			folderPath = fs[ 0 ];
			serviceName = fs[ 1 ];
		}
		
		outputData = ISServiceInvoke( folderPath, serviceName, inputData );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outputData", outputData );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	public static synchronized IData ISServiceInvoke( String folderPath, String serviceName, IData inputData ) {
		IData outputData = null;
		
		try {
			outputData = Service.doInvoke( folderPath, serviceName, inputData );
		} catch ( Exception e ) {
		
		}
		
		inputData = null;
		
		return outputData;
	}
	// --- <<IS-END-SHARED>> ---
}

