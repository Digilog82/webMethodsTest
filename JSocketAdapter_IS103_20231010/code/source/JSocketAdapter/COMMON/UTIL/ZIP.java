package JSocketAdapter.COMMON.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.EOFException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;
import com.wm.util.Base64;
import custom.java.com.log.DebugLogger;
// --- <<IS-END-IMPORTS>> ---

public final class ZIP

{
	// ---( internal utility methods )---

	final static ZIP _instance = new ZIP();

	static ZIP _newInstance() { return new ZIP(); }

	static ZIP _cast(Object o) { return (ZIP)o; }

	// ---( server methods )---




	public static final void compressFileToZip (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(compressFileToZip)>> ---
		// @sigtype java 3.5
		// [i] field:0:optional unzipFilePath
		// [i] field:0:required zipFileName
		// [o] field:0:required errorMsg
		// [o] field:0:required fileCountZipped
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String unzipFilePath = IDataUtil.getString( pipelineCursor, "unzipFilePath" );
		String zipFileName = IDataUtil.getString( pipelineCursor, "zipFileName" );
		pipelineCursor.destroy();
		
		FileOutputStream fos = null;
		BufferedOutputStream bos = null;
		ZipOutputStream zipos = null;
		File dir = null;
		String fileSep = System.getProperty( "file.separator" );
		int fileCountZipped = 0;
		int fileNameIndex = 0;
		String fileName = "";
		String errorMsg = "";
		
		try {
			fos = new FileOutputStream( zipFileName );
			bos = new BufferedOutputStream( fos );
			zipos = new ZipOutputStream( bos );
			dir = new File( unzipFilePath );
			
			if ( !dir.exists() ) {
				throw new Exception( dir + " \uAC00(\uC774) \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4." );
			}
			
			if ( dir.isDirectory() ) {
				// \uB514\uB809\uD1A0\uB9AC \uC544\uB798\uC5D0 \uC788\uB294 \uBAA8\uB4E0 \uD30C\uC77C\uB4E4\uC744 \uC555\uCD95\uD558\uB294 \uACBD\uC6B0
				fileCountZipped = addDirectoryToZip( unzipFilePath, "", zipos );
			} else {
				// \uD558\uB098\uC758 \uD2B9\uC815 \uD30C\uC77C\uC744 \uC555\uCD95\uD558\uB294 \uACBD\uC6B0
				fileNameIndex = unzipFilePath.lastIndexOf( fileSep );
				
				// Path\uB97C \uC81C\uC678\uD55C \uD30C\uC77C\uBA85\uB9CC \uAD6C\uD558\uAE30
				fileName = unzipFilePath.substring( fileNameIndex + 1 );
				
				addFileToZip( unzipFilePath, fileName, zipos );
				fileCountZipped++;
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		} finally {
			// \uC555\uCD95 \uD30C\uC77C\uC740 \uD558\uB098\uC774\uBBC0\uB85C \uC5EC\uAE30\uC5D0\uC11C Output Stream Close \uD55C\uB2E4.
			if ( zipos != null ) {
				try {
			      zipos.close();
			    } catch ( Exception e ) {
			    	errorMsg = e.toString();
			    }
			}
			
			if (fos != null ) {
				try {
			      fos.close();
			    } catch ( Exception e ) {
			    	errorMsg = e.toString();
			    }
			}
			
			if ( bos != null ) {
				try {
					bos.flush();
					bos.close();
			    } catch ( Exception e ) {
			    	errorMsg = e.toString();
			    }
			}
		}
		
		fos = null;
		bos = null;
		zipos = null;
		dir = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "fileCountZipped", fileCountZipped + "" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void compressToZip (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(compressToZip)>> ---
		// @sigtype java 3.5
		// [i] field:0:optional unzipString
		// [i] field:0:optional charset
		// [i] object:0:optional unzipBytes
		// [i] field:0:optional zipEntryName
		// [o] field:0:required zipString
		// [o] object:0:required zipBytes
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String unzipString = IDataUtil.getString( pipelineCursor, "unzipString" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		byte[] unzipBytes = ( byte[] )IDataUtil.get( pipelineCursor, "unzipBytes" );
		String zipEntryName = IDataUtil.getString( pipelineCursor, "zipEntryName" );
		pipelineCursor.destroy();
		
		String zipString = "";
		byte[] zipBytes = null;
		ByteArrayOutputStream baos = null;
		ZipEntry zipEntry = null;
		ZipOutputStream zipos = null;
				
		if ( charset == null || charset.equals( "" ) ) {
			charset = "UTF-8";
		}
		
		if ( zipEntryName == null || zipEntryName.equals( "" ) ) {
			zipEntryName = "fileEntry";
		}
		
		try {
			if ( unzipString != null && !unzipString.equals( "" ) ) {
				unzipBytes = unzipString.getBytes( charset );
			} else {
				if ( unzipBytes == null ) {
					throw new ServiceException( "Missing required parameter unzipString or unzipBytes." );
				}
			}
						
			baos = new ByteArrayOutputStream();
			zipEntry = new ZipEntry( zipEntryName );
			zipos = new ZipOutputStream( baos );
			zipos.putNextEntry( zipEntry );
			zipos.write( unzipBytes, 0, unzipBytes.length );
			zipos.closeEntry(); // baos.toByteArray() \uC55E\uC5D0\uC11C zipos.closeEntry()\uB97C \uD574\uC57C baos\uC5D0 \uC788\uB294 \uAC12\uC744 \uCD94\uCD9C\uD560 \uC218 \uC788\uB2E4.
			zipBytes = baos.toByteArray();
			zipString = new String( Base64.encode( zipBytes ), "UTF-8" );
		} catch( Exception e ) {
			throw new ServiceException( e );
		} finally {
			if ( baos != null ) {
				try {
					baos.close();
				} catch ( Exception fe ) {
					throw new ServiceException( fe );
				}
			}
			
			if ( zipos != null ) {
				try {
					zipos.close();
				} catch ( Exception fe ) {
					throw new ServiceException( fe );
				}
			}
		}
		
		unzipBytes = null;
		baos = null;
		zipEntry = null;
		zipos = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "zipString", zipString );
		IDataUtil.put( pipelineCursor_1, "zipBytes", zipBytes );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void decompressFileFromZip (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(decompressFileFromZip)>> ---
		// @sigtype java 3.5
		// [i] field:0:required zipFileName
		// [i] field:0:required targetDirectory
		// [o] field:0:required errorMsg
		// [o] field:0:required fileCountUnzipped
		// [o] field:1:required unzippedFileNames
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String zipFileName = IDataUtil.getString( pipelineCursor, "zipFileName" );
		String targetDirectory = IDataUtil.getString( pipelineCursor, "targetDirectory" );
		pipelineCursor.destroy();
		
		FileInputStream fis = null;
		BufferedInputStream bis = null;
		ZipInputStream zipis = null;
		BufferedOutputStream bos = null;
		FileOutputStream fos = null;
		ZipEntry ze = null;
		File dir = null;
		String strUnzippedFileName = "";
		byte data[] = null;
		int readData;
		String unzippedFiles = "";
		int i = 0;
		String fileSep = System.getProperty( "file.separator" );
		
		String errorMsg = "";
		int fileCountUnzipped = 0;
		String[] unzippedFileNames = null;
		
		try {
			fis = new FileInputStream( zipFileName );
			bis = new BufferedInputStream( fis );
			zipis = new ZipInputStream( bis );
			
			while ( ( ze = zipis.getNextEntry() ) != null ) {
				// OS \uC0C1\uAD00 \uC5C6\uC774 Entry\uAC00 "/" \uB85C \uB05D\uB098\uC57C \uB514\uB809\uD1A0\uB9AC\uB85C \uC778\uC2DD\uD55C\uB2E4.
				if ( ze.isDirectory() ) {
					// \uB514\uB809\uD1A0\uB9AC\uC778 \uACBD\uC6B0\uC5D0\uB294 \uB514\uB809\uD1A0\uB9AC\uB97C \uC0DD\uC131
					dir = new File( targetDirectory + fileSep + ze.getName() );
					dir.mkdirs();
					continue;
			    }
			
			    // Output \uD30C\uC77C \uC0DD\uC131
			    strUnzippedFileName = targetDirectory + fileSep + ze.getName();
			    fos = new FileOutputStream( strUnzippedFileName );
			    bos = new BufferedOutputStream( fos );
			    data = new byte[ 4096 ];
			
			    while ( ( readData = zipis.read( data ) ) != -1 ) {
			    	bos.write( data, 0, readData );
			    }
			    
			    // \uC555\uCD95\uD574\uC81C \uD30C\uC77C \uB2E8\uC704\uB85C Output Stream Close \uD574\uC57C \uD55C\uB2E4.
			    bos.flush();
			    bos.close();
			    
			    if ( unzippedFiles.equals( "" ) ) {
			    	unzippedFiles = strUnzippedFileName;
			    } else {
			    	unzippedFiles = unzippedFiles + "|" + strUnzippedFileName;
			    }
			    
			    fileCountUnzipped++;
			}
			
			zipis.closeEntry();
			unzippedFileNames = unzippedFiles.split( "\\|" );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		} finally {
			// \uC555\uCD95 \uD30C\uC77C\uC740 \uD558\uB098\uC774\uBBC0\uB85C \uC5EC\uAE30\uC5D0\uC11C Input Stream Close \uD55C\uB2E4.
			if ( zipis != null ) {
				try {
			      zipis.close();
			    } catch ( Exception e ) {
			    	debugLogger.printLogAtIS("### zipis close error");
			    	errorMsg = e.toString();
			    }
			}
			
			if ( bis != null ) {
				try {
					bis.close();
			    } catch ( Exception e ) {
			    	debugLogger.printLogAtIS("### bis close error");
			    	errorMsg = e.toString();
			    }
			}
			
			if (fis != null ) {
				try {
			      fis.close();
			    } catch ( Exception e ) {
			    	debugLogger.printLogAtIS("### fis close error");
			    	errorMsg = e.toString();
			    }
			}
			
			if ( bos != null ) {
				try {
					//bos.flush();
					bos.close();
			    } catch ( Exception e ) {
			    	debugLogger.printLogAtIS("### bos close error");
			    	errorMsg = e.toString();
			    }
			}
			
			if (fos != null ) {
				try {
			      fos.close();
			    } catch ( Exception e ) {
			    	debugLogger.printLogAtIS("### fos close error");
			    	errorMsg = e.toString();
			    }
			}
		}
		
		fis = null;
		bis = null;
		zipis = null;
		bos = null;
		fos = null;
		ze = null;
		dir = null;
		data = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "fileCountUnzipped", fileCountUnzipped + "" );
		IDataUtil.put( pipelineCursor_1, "unzippedFileNames", unzippedFileNames );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void decompressFromZip (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(decompressFromZip)>> ---
		// @sigtype java 3.5
		// [i] field:0:optional zipString
		// [i] object:0:optional zipBytes
		// [i] field:0:required convertString {"true","false"}
		// [i] field:0:optional charset
		// [o] field:0:required unzipString
		// [o] object:0:required unzipBytes
		// [o] field:0:required zipEntryName
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String zipString = IDataUtil.getString( pipelineCursor, "zipString" ); // Base64 Encoded String
		byte[] zipBytes = ( byte[] )IDataUtil.get( pipelineCursor, "zipBytes" );
		String convertString = IDataUtil.getString( pipelineCursor, "convertString" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		pipelineCursor.destroy();
		
		String unzipString = "";
		byte[] unzipBytes = null;
		String zipEntryName = "";
		ByteArrayInputStream bais = null;
		ByteArrayOutputStream baos = null;
		ZipEntry zipEntry = null;
		ZipInputStream zipis = null;
		int len = 0;
		byte[] tempIn = new byte[ 2048 ];
		
		if ( convertString == null || convertString.equals( "" ) ) {
			convertString = "true";
		}
		
		if ( charset == null || charset.equals( "" ) ) {
			charset = "UTF-8";
		}
		
		try {
			if ( zipString != null && !zipString.equals( "" ) ) {
				zipBytes = Base64.decode( zipString.getBytes( "UTF-8" ) );
			} else {
				if ( zipBytes == null ) {
					throw new ServiceException( "Missing required parameter zipString or zipBytes." );
				}
			}
			
			bais = new ByteArrayInputStream( zipBytes );
			zipis = new ZipInputStream( bais );
			baos = new ByteArrayOutputStream();
			zipEntry = zipis.getNextEntry();
			
			if ( zipEntry != null ) {
				zipEntryName = zipEntry.getName(); // \uD30C\uC77C\uBA85
				
				while ( len != -1 ) {
					try {
						len = zipis.read( tempIn );
					} catch ( EOFException e ) {
						len = -1;
					}
				
					if ( len > 0 ) {					
						baos.write( tempIn, 0, len );
					}
				}
				
				unzipBytes = baos.toByteArray();
				
				if ( convertString.equals( "true" ) ) {
					unzipString = new String( unzipBytes, charset );
				}
			}
		} catch( Exception e ) {
			throw new ServiceException( e );
		} finally {
			if ( bais != null ) {
				try {
					bais.close();
				} catch ( Exception fe ) {
					throw new ServiceException( fe );
				}
			}
			
			if ( baos != null ) {
				try {
					baos.close();
				} catch ( Exception fe ) {
					throw new ServiceException( fe );
				}
			}
			
			if ( zipis != null ) {
				try {
					zipis.close();
				} catch ( Exception fe ) {
					throw new ServiceException( fe );
				}
			}
		}
		
		tempIn = null;
		zipBytes = null;
		bais = null;
		baos = null;
		zipEntry = null;
		zipis = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "unzipString", unzipString );
		IDataUtil.put( pipelineCursor_1, "unzipBytes", unzipBytes );
		IDataUtil.put( pipelineCursor_1, "zipEntryName", zipEntryName );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void gzip (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(gzip)>> ---
		// @sigtype java 3.5
		// [i] field:0:optional unzipString
		// [i] field:0:optional charset
		// [i] object:0:optional unzipBytes
		// [o] field:0:required zipString
		// [o] object:0:required zipBytes
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String unzipString = IDataUtil.getString( pipelineCursor, "unzipString" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		byte[] unzipBytes = ( byte[] )IDataUtil.get( pipelineCursor, "unzipBytes" );
		pipelineCursor.destroy();
		
		String zipString = "";
		byte[] zipBytes = null;
		ByteArrayOutputStream baos = null;
		GZIPOutputStream gzipos = null;
		
		if ( charset == null || charset.equals( "" ) ) {
			charset = "UTF-8";
		}
		
		try {
			if ( unzipString != null && !unzipString.equals( "" ) ) {
				unzipBytes = unzipString.getBytes( charset );
			} else {
				if ( unzipBytes == null ) {
					throw new ServiceException( "Missing required parameter unzipString or unzipBytes." );
				}
			}
			
			baos = new ByteArrayOutputStream();
			gzipos = new GZIPOutputStream( baos );
			gzipos.write( unzipBytes, 0, unzipBytes.length );
			gzipos.close(); // baos.toByteArray() \uC55E\uC5D0\uC11C gzipos.close()\uB97C \uD574\uC57C baos\uC5D0 \uC788\uB294 \uAC12\uC744 \uCD94\uCD9C\uD560 \uC218 \uC788\uB2E4.
			zipBytes = baos.toByteArray();
			zipString = new String( Base64.encode( zipBytes ), "UTF-8" );
		} catch( Exception e ) {
			throw new ServiceException( e );
		} finally {
			if ( baos != null ) {
				try {
					baos.close();
				} catch ( Exception fe ) {
					throw new ServiceException( fe );
				}
			}
			
			if ( gzipos != null ) {
				try {
					gzipos.close();
				} catch ( Exception fe ) {
					throw new ServiceException( fe );
				}
			}
		}
		
		unzipBytes = null;
		baos = null;
		gzipos = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "zipString", zipString );
		IDataUtil.put( pipelineCursor_1, "zipBytes", zipBytes );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void ungzip (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(ungzip)>> ---
		// @sigtype java 3.5
		// [i] field:0:optional zipString
		// [i] object:0:optional zipBytes
		// [i] field:0:required convertString {"true","false"}
		// [i] field:0:optional charset
		// [o] field:0:required unzipString
		// [o] object:0:required unzipBytes
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String zipString = IDataUtil.getString( pipelineCursor, "zipString" ); // Base64 Encoded String
		byte[] zipBytes = ( byte[] )IDataUtil.get( pipelineCursor, "zipBytes" );
		String convertString = IDataUtil.getString( pipelineCursor, "convertString" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		pipelineCursor.destroy();
		
		String unzipString = "";
		byte[] unzipBytes = null;
		ByteArrayInputStream bais = null;
		ByteArrayOutputStream baos = null;
		GZIPInputStream gzipis = null;
		int len = 0;
		byte[] tempIn = new byte[ 2048 ];
		
		if ( convertString == null || convertString.equals( "" ) ) {
			convertString = "true";
		}
		
		if ( charset == null || charset.equals( "" ) ) {
			charset = "UTF-8";
		}
		
		try {
			if ( zipString != null && !zipString.equals( "" ) ) {
				zipBytes = Base64.decode( zipString.getBytes( "UTF-8" ) );
			} else {
				if ( zipBytes == null ) {
					throw new ServiceException( "Missing required parameter zipString or zipBytes." );
				}
			}
			
			bais = new ByteArrayInputStream( zipBytes );			
			gzipis = new GZIPInputStream( bais );
			baos = new ByteArrayOutputStream();
			
			while ( len != -1 ) {
				try {
					len = gzipis.read( tempIn );
				} catch ( EOFException e ) {
					len = -1;
				}
				
				if ( len > 0 ) {					
					baos.write( tempIn, 0, len );
				}
			}
			
			unzipBytes = baos.toByteArray();
			
			if ( convertString.equals( "true" ) ) {
				unzipString = new String( unzipBytes, charset );
			}
		} catch( Exception e ) {
			throw new ServiceException( e );
		} finally {
			if ( bais != null ) {
				try {
					bais.close();
				} catch ( Exception fe ) {
					throw new ServiceException( fe );
				}
			}
			
			if ( baos != null ) {
				try {
					baos.close();
				} catch ( Exception fe ) {
					throw new ServiceException( fe );
				}
			}
			
			if ( gzipis != null ) {
				try {
					gzipis.close();
				} catch ( Exception fe ) {
					throw new ServiceException( fe );
				}
			}
		}
		
		tempIn = null;
		zipBytes = null;
		bais = null;
		baos = null;
		gzipis = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "unzipString", unzipString );
		IDataUtil.put( pipelineCursor_1, "unzipBytes", unzipBytes );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static DebugLogger debugLogger = new DebugLogger();
	
	public static int addDirectoryToZip( String unzipFilePath, String relativePath, ZipOutputStream zipos ) {
		File fileCurrentFile = null;
		int fileCountZipped = 0;
		String fileSep = System.getProperty( "file.separator" );
		int dirIndex = 0;
		
		if ( relativePath.equals( "" ) ) {
			// \uCD5C\uC0C1\uC704 \uB514\uB809\uD1A0\uB9AC\uB97C \uCC98\uC74C\uC73C\uB85C \uC555\uCD95\uD558\uB294 \uACBD\uC6B0
			dirIndex = unzipFilePath.lastIndexOf( fileSep );
			
			// \uC808\uB300 \uACBD\uB85C\uC640 \uC0C1\uB300 \uACBD\uB85C\uB97C \uBD84\uB9AC\uD55C\uB2E4.
			relativePath = unzipFilePath.substring( dirIndex + 1 );
			unzipFilePath = unzipFilePath.substring( 0, dirIndex );
		}
		
		// \uB514\uB809\uD1A0\uB9AC\uB97C Entry\uC5D0 \uCD94\uAC00
		try {
			/*
			if ( relativePath.endsWith( fileSep ) ) {
				zipos.putNextEntry( new ZipEntry( relativePath ) );
			} else {
				zipos.putNextEntry( new ZipEntry( relativePath + fileSep ) );
			}
			*/
			
			// OS\uC5D0 \uC0C1\uAD00 \uC5C6\uC774 \uB514\uB809\uD1A0\uB9AC Entry\uB85C \uCD94\uAC00\uD558\uAE30 \uC704\uD574\uC11C\uB294 \uBB34\uC870\uAC74 \uB9E8 \uB05D\uC5D0 "/" \uB97C \uBD99\uC5EC\uC57C \uD55C\uB2E4.
			if ( relativePath.endsWith( "/" ) ) {
				zipos.putNextEntry( new ZipEntry( relativePath ) );
			} else {
				zipos.putNextEntry( new ZipEntry( relativePath + "/" ) );
			}
			
			zipos.closeEntry();
		} catch ( Exception e ) {
			return fileCountZipped;
		}
		
		File fileSourceDir = new File( unzipFilePath + fileSep + relativePath );
		String fileDirList[] = fileSourceDir.list();
		int filesAndDirectories = fileDirList.length;
		
		if ( filesAndDirectories < 1) {
			// No files to compress
			return 0;
		}
	
		String strCurrentFileName = "";
		String strCurrentRelativeFileName = "";
		
		for ( int i = 0; i < filesAndDirectories; i++ ) {
			strCurrentFileName = unzipFilePath + fileSep + relativePath + fileSep + fileDirList[ i ];
			strCurrentRelativeFileName = relativePath + fileSep + fileDirList[ i ];
			fileCurrentFile = new File( strCurrentFileName );
			
			if ( fileCurrentFile.isDirectory() ) {
				fileCountZipped = fileCountZipped + addDirectoryToZip( unzipFilePath, strCurrentRelativeFileName, zipos );
			} else {
				fileCountZipped++;
				addFileToZip( strCurrentFileName, strCurrentRelativeFileName, zipos );
			}
		}
	
		fileCurrentFile = null;
		fileSourceDir = null;
		return fileCountZipped;
	}
	
	public static void addFileToZip( String strCurrentFileName, String strCurrentRelativeFileName, ZipOutputStream zipos ) {
		FileInputStream fis = null;
		BufferedInputStream bis = null;
		ZipEntry ze = null;
		byte data[] = null;
		int readData;
		
		try {
			fis = new FileInputStream( strCurrentFileName );
			bis = new BufferedInputStream( fis );
	
			// \uD30C\uC77C\uC744 \uC555\uCD95\uD574\uC11C Archive\uC5D0 \uCD94\uAC00\uD55C\uB2E4.
			ze = new ZipEntry( strCurrentRelativeFileName );
			zipos.putNextEntry( ze );
	
			data = new byte[ 4096 ];
	
			while ( ( readData = bis.read( data ) ) != -1 ) {
				zipos.write( data, 0, readData );
			}
			
			zipos.closeEntry();
		} catch ( Exception e ) {
			Service.throwError( e.toString() );
		} finally {
			// \uD30C\uC77C \uB2E8\uC704\uB85C Input Stream Close \uD574\uC57C \uD55C\uB2E4.
			if (bis != null) {
				try {
					bis.close();
				} catch ( Exception e ) {
				}
			}
			
			if (fis != null) {
				try {
					fis.close();
				} catch ( Exception e ) {
				}
			}
		}
		
		fis = null;
		bis = null;
		ze = null;
		data = null;
	}
	// --- <<IS-END-SHARED>> ---
}

