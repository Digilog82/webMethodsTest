package JSocketAdapter.SFTP.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.text.*;
import java.util.*;
import java.io.*;
import java.lang.*;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.*;
import com.wm.app.b2b.server.*;
import com.wm.util.*;
import com.wm.lang.ns.*;
import com.wm.net.HttpHeader;
import com.wm.util.coder.*;
// --- <<IS-END-IMPORTS>> ---

public final class FILE

{
	// ---( internal utility methods )---

	final static FILE _instance = new FILE();

	static FILE _newInstance() { return new FILE(); }

	static FILE _cast(Object o) { return (FILE)o; }

	// ---( server methods )---




	public static final void deleteFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(deleteFile)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required fullFileName
		// [o] field:0:required success
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fullFileName = IDataUtil.getString( pipelineCursor, "fullFileName" );	
		pipelineCursor.destroy();
		
		String success = "true";
		String errorMsg = "";
		File file = null;
		
		try {
			file = new File( fullFileName );
		
			if ( file.isFile() ) {		
				if ( file.exists() ) {
					file.delete();
				} else {
					success = "false";
					errorMsg = fullFileName + " \uD30C\uC77C\uC774 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4";
				}
			} else {
				success = "false";
				errorMsg = fullFileName + "\uB294(\uC740) \uC62C\uBC14\uB978 \uD30C\uC77C\uBA85\uC774 \uC544\uB2D9\uB2C8\uB2E4";
			}
		} catch ( Exception e ) {
			success = "false";
			errorMsg = e.getMessage();
		}
		
		file = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "success", success );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getFileList (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getFileList)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required directory
		// [o] field:0:required success
		// [o] field:0:required errorMsg
		// [o] field:1:required fileList
		IDataCursor pipelineCursor = pipeline.getCursor();
		String directory = IDataUtil.getString( pipelineCursor, "directory" );	
		pipelineCursor.destroy();
		
		String success = "true";
		String errorMsg = "";
		String fileList[] = null;
		File dir = null;
		
		try {
			dir = new File( directory );
			if ( dir.isDirectory() ) {		
				if ( dir.exists() ) {
					fileList = dir.list();
				} else {
					success = "false";
					errorMsg = directory + " \uB514\uB809\uD1A0\uB9AC\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4";
				}
			} else {
				success = "false";
				errorMsg = directory + "\uB294(\uC740) \uC62C\uBC14\uB978 \uB514\uB809\uD1A0\uB9AC\uBA85\uC774 \uC544\uB2D9\uB2C8\uB2E4";
			}
		} catch ( Exception e ) {
			success = "false";
			errorMsg = e.getMessage();
		}
		
		dir = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "success", success );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "fileList", fileList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void makeDir (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(makeDir)>> ---
		// @sigtype java 3.5
		// [i] field:0:required filePath
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String filePath = IDataUtil.getString( pipelineCursor, "filePath" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		File pathToBeWritten = null;
		
		try {
			pathToBeWritten = new File( filePath );
		
			// Create the directory
			if ( pathToBeWritten.exists() == false ) {
				pathToBeWritten.mkdirs();
			}
		} catch ( Exception e ) {
			errorMsg = e.getMessage();
		}
		
		pathToBeWritten = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void moveFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(moveFile)>> ---
		// @sigtype java 3.5
		// [i] field:0:required sourceFileName
		// [i] field:0:required targetFileName
		// [i] field:0:required sourceFileDelete {"YES","NO"}
		// [o] field:0:required success
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String sourceFileName = IDataUtil.getString( pipelineCursor, "sourceFileName" );
		String targetFileName = IDataUtil.getString( pipelineCursor, "targetFileName" );
		String sourceFileDelete = IDataUtil.getString( pipelineCursor, "sourceFileDelete" );
		pipelineCursor.destroy();
		
		String success = "true";
		String errorMsg = "";
		int data = 0;
		byte[] buffer = new byte[ 1024 * 8 ];
		FileInputStream fis = null;
		FileOutputStream fos = null;
		File file = null;
		
		try {
			fis = new FileInputStream( sourceFileName );
			fos = new FileOutputStream( targetFileName );			
			
			while ( ( data = fis.read( buffer ) ) != -1 ) {
				if ( data > 0 ) {
					fos.write( buffer, 0, data );
				}
			}
			
			if ( sourceFileDelete.equals( "YES") ) {
				file = new File( sourceFileName );
				file.delete();
			}
		}  catch ( Exception e ) {
			success = "false";
			errorMsg = e.getMessage();
		} finally {
			try {
				if ( fis != null ) {
					fis.close();
				}
				
				if ( fos != null ) {
					fos.close();
				}
			} catch ( Exception fe ) {
				errorMsg = fe.toString();
			}
		}
		
		fis = null;
		fos = null;
		file = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "success", success );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void renameFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(renameFile)>> ---
		// @sigtype java 3.5
		// [i] field:0:required sourceFileName
		// [i] field:0:required targetFileName
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String sourceFileName = IDataUtil.getString( pipelineCursor, "sourceFileName" );
		String targetFileName = IDataUtil.getString( pipelineCursor, "targetFileName" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		File file = null;
		File newFile = null;
		
		try {
			file = new File( sourceFileName );
			
			if ( file.isFile() ) {
				if ( file.exists() ) {
					newFile = new File( targetFileName );
					file.renameTo( newFile );
				} else {
					errorMsg = sourceFileName + " \uD30C\uC77C\uC774 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
				}
			} else {
				errorMsg = sourceFileName + "\uB294(\uC740) \uC62C\uBC14\uB978 \uD30C\uC77C\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.getMessage();
		}
		
		file = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	protected static final String hexByte( int digit ) {
		if( digit < 16 )
			return "0" + Integer.toHexString( digit );
	
		return Integer.toHexString( digit );
	}
	
	public static byte[] readFullyB( File file )  throws IOException { 
		FileInputStream fis = new FileInputStream( file );
	    byte[] img = null;
	    
	    try {
	    	img = readFullyS( fis );
	    } finally {
	    	try {
	    		fis.close();
	        } catch ( Throwable t ) { 
	        	
	        }
	    }
	    
	    return img;
	}
	
	public static byte[] readFullyS( InputStream is )  throws IOException {
		BufferedInputStream bi = new BufferedInputStream( is );
		ByteOutputBuffer os = new ByteOutputBuffer();
	
		int len = 0;
		byte tempIn[] = new byte[ 6144 ];
	
		while ( len != -1 ) {
			try {
				len = bi.read( tempIn );
	        } catch ( EOFException e ) {
	        	len = -1;
	        }
	        
			if ( len > 0 ) {
				os.write( tempIn, 0, len );
			}
		}
	    
		return os.toByteArray();
	}
	// --- <<IS-END-SHARED>> ---
}

