package JSocketAdapter.COMMON.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.app.b2b.server.ACLManager;
// --- <<IS-END-IMPORTS>> ---

public final class ACL

{
	// ---( internal utility methods )---

	final static ACL _instance = new ACL();

	static ACL _newInstance() { return new ACL(); }

	static ACL _cast(Object o) { return (ACL)o; }

	// ---( server methods )---




	public static final void getExecAclGroup (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getExecAclGroup)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fullName
		// [o] field:0:required aclName
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fullName = IDataUtil.getString( pipelineCursor, "fullName" );
		pipelineCursor.destroy();
		
		String aclName = ACLManager.getAclGroup( fullName );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "aclName", aclName );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void setExecAclGroup (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(setExecAclGroup)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fullName
		// [i] field:0:required aclName
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fullName = IDataUtil.getString( pipelineCursor, "fullName" );
		String aclName = IDataUtil.getString( pipelineCursor, "aclName" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		try {
			ACLManager.setAclGroup( fullName, aclName );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}
}

