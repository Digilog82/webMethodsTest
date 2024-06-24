package JSocketAdapter.COMMON.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
// --- <<IS-END-IMPORTS>> ---

public final class DATE

{
	// ---( internal utility methods )---

	final static DATE _instance = new DATE();

	static DATE _newInstance() { return new DATE(); }

	static DATE _cast(Object o) { return (DATE)o; }

	// ---( server methods )---




	public static final void calculateMillisDifference (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(calculateMillisDifference)>> ---
		// @sigtype java 3.5
		// [i] field:0:required startTime
		// [i] field:0:required endTime
		// [i] field:0:required startPattern
		// [i] field:0:required endPattern
		// [o] field:0:required diff
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String startTime = IDataUtil.getString( pipelineCursor, "startTime" );
		String endTime = IDataUtil.getString( pipelineCursor, "endTime" );
		String startPattern = IDataUtil.getString( pipelineCursor, "startPattern" );
		String endPattern = IDataUtil.getString( pipelineCursor, "endPattern" );
		pipelineCursor.destroy();
		
		SimpleDateFormat sdfStart = null;
		SimpleDateFormat sdfEnd = null;		
		Date startDate = null;
		Date endDate = null;		
		Calendar startCal = null;
		Calendar endCal = null;
		
		long diff = 0;
		
		try {
			sdfStart = new SimpleDateFormat( startPattern );
			sdfEnd = new SimpleDateFormat( endPattern );
			startDate = sdfStart.parse( startTime );
			endDate = sdfStart.parse( endTime );
			startCal = Calendar.getInstance();
			endCal = Calendar.getInstance();
			
			startCal.setTime( startDate );
			endCal.setTime( endDate );
			diff = endCal.getTimeInMillis() - startCal.getTimeInMillis();
		} catch ( Exception e ) {
			
		}
		
		sdfStart = null;
		sdfEnd = null;
		startCal = null;
		endCal = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "diff", diff + "" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void isContainFromToDate (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(isContainFromToDate)>> ---
		// @sigtype java 3.5
		// [i] field:0:required compareTime
		// [i] field:0:required fromTime
		// [i] field:0:required toTime
		// [i] field:0:required comparePattern
		// [i] field:0:required fromPattern
		// [i] field:0:required toPattern
		// [o] field:0:required contains
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String compareTime = IDataUtil.getString( pipelineCursor, "compareTime" );
		String fromTime = IDataUtil.getString( pipelineCursor, "fromTime" );
		String toTime = IDataUtil.getString( pipelineCursor, "toTime" );
		String comparePattern = IDataUtil.getString( pipelineCursor, "comparePattern" );
		String fromPattern = IDataUtil.getString( pipelineCursor, "fromPattern" );
		String toPattern = IDataUtil.getString( pipelineCursor, "toPattern" );
		pipelineCursor.destroy();
		
		String contains = "false";
		
		SimpleDateFormat sdfCompare = null;
		SimpleDateFormat sdfFrom = null;
		SimpleDateFormat sdfTo = null;		
		Date compareDate = null;
		Date fromDate = null;
		Date toDate = null;
		
		if ( fromTime == null || fromTime.equals( "" ) ) {
			fromTime = "00010101000000";
			fromPattern = "yyyyMMddHHmmss";
		}
		
		if ( toTime == null || toTime.equals( "" ) ) {
			toTime = "99991231235959";
			toPattern = "yyyyMMddHHmmss";
		}
		
		try {
			sdfCompare = new SimpleDateFormat( comparePattern );
			sdfFrom = new SimpleDateFormat( fromPattern );
			sdfTo = new SimpleDateFormat( toPattern );
			compareDate = sdfCompare.parse( compareTime );
			fromDate = sdfFrom.parse( fromTime );
			toDate = sdfTo.parse( toTime );
			
			if ( compareDate.getTime() >= fromDate.getTime() && compareDate.getTime() <= toDate.getTime() ) {
				contains = "true";
			}
		} catch ( Exception e ) {
			
		}
		
		sdfCompare = null;
		sdfFrom = null;
		sdfTo = null;		
		compareDate = null;
		fromDate = null;
		toDate = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "contains", contains );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}
}

