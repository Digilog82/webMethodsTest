package JSocketAdapter;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.app.b2b.server.InvokeState;
import com.wm.app.audit.IAuditRuntime;
import com.wm.lang.ns.*;
import java.io.OutputStream;
import java.io.InputStream;
import java.net.Socket;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Vector;
import java.io.*;
import java.net.SocketException;
import custom.java.com.log.DebugLogger;
import custom.java.socket.manager.*;
// --- <<IS-END-IMPORTS>> ---

public final class UTIL

{
	// ---( internal utility methods )---

	final static UTIL _instance = new UTIL();

	static UTIL _newInstance() { return new UTIL(); }

	static UTIL _cast(Object o) { return (UTIL)o; }

	// ---( server methods )---




	public static final void addStxEtx (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(addStxEtx)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [o] field:0:required outString
		IDataCursor pipelineCursor = pipeline.getCursor();
		String inString = IDataUtil.getString( pipelineCursor, "inString" );	
		pipelineCursor.destroy();		
		
		byte STX = 0x02; // Start of Text	
		byte ETX = 0x03; // End of Text	
		byte[] inBytes = inString.getBytes();	
		int inByteLength = inBytes.length;	
		int outByteLength = inByteLength + 2;	
		byte[] outBytes = new byte[ outByteLength ];
		
		// String \uC55E\uC5D0 STX \uCD94\uAC00
		outBytes[ 0 ] = STX;
		
		System.arraycopy( inBytes, 0, outBytes, 1, inByteLength );
		
		// String \uB4A4\uC5D0 ETX \uCD94\uAC00
		outBytes[ outByteLength - 1 ] = ETX;
			
		String outString = new String( outBytes );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outString", outString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void addStxFsEtxCr (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(addStxFsEtxCr)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [i] field:1:required insertFS
		// [o] field:0:required outString
		IDataCursor pipelineCursor = pipeline.getCursor();
		String inString = IDataUtil.getString( pipelineCursor, "inString" );
		String[] insertFS = IDataUtil.getStringArray( pipelineCursor, "insertFS" ); // FS\uB97C \uC0BD\uC785\uD560 \uC704\uCE58
		pipelineCursor.destroy();
		
		byte STX = 0x02; // Start of Text
		byte FS = 0x1C; // File separator
		byte ETX = 0x03; // End of Text
		byte CR = 0x0D; // Carriage return
		int fsCount = insertFS.length;
		byte[] inBytes = inString.getBytes();
		int inByteLength = inBytes.length;
		int outByteLength = inByteLength + fsCount + 3;
		int fsPosition = 0;
		int inPosition = 0;
		int outPosition = 1;
		int copySum = 0;
		int copyLength = 0;
		byte[] outBytes = new byte[ outByteLength ];
		outBytes[ 0 ] = STX;
		
		// FS \uC0BD\uC785
		for ( int i = 0; i < fsCount; i++ ) {
			fsPosition = Integer.parseInt( insertFS[ i ] );
			copyLength = fsPosition - copySum;
			
			System.arraycopy( inBytes, inPosition, outBytes, outPosition, copyLength );
			outBytes[ outPosition + copyLength ] = FS;
			
			inPosition = fsPosition;
			outPosition = outPosition + copyLength + 1;
			copySum = copySum + copyLength;
		}		
		
		System.arraycopy( inBytes, inPosition, outBytes, outPosition, inByteLength - copySum );
		outBytes[ outByteLength - 2 ] = ETX;
		outBytes[ outByteLength - 1 ] = CR;
		
		String outString = new String( outBytes );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outString", outString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void analyzeAuditData (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(analyzeAuditData)>> ---
		// @sigtype java 3.5
		// [i] record:0:required doc
		// [i] record:0:required schemaDef
		// [i] field:0:required changeSpace {"true","false"}
		// [o] field:0:required errorMsg
		// [o] record:1:required AuditDataList
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData doc = IDataUtil.getIData( pipelineCursor, "doc" );
		IData schemaDef = IDataUtil.getIData( pipelineCursor, "schemaDef" );
		String changeSpace = IDataUtil.getString( pipelineCursor, "changeSpace" );
		pipelineCursor.destroy();
		
		Hashtable ht = null;
		Hashtable hashTable = null;
		Hashtable htTitle = new Hashtable();
		Hashtable newHT = new Hashtable();
		int hashSize = 0;
		int seq = 0;
		boolean newUse = false;
		IData tempAuditData = null;
		IData backupTitleData = null;
		IData nextAuditData = null;
		IData[] AuditDataList = null;
		IDataCursor cur = null;
		IDataCursor nextCur = null;
		String[] schemaList = null;
		String idataType = "";
		String titleValue = "";
		String listDepth = "";
		String nextTitleValue = "";
		String nextTitleType = "";
		String errorMsg = "";
		
		if ( changeSpace == null || changeSpace.equals( "" ) ) {
			changeSpace = "true";
		}
		
		try {
			schemaList = makeSchemaList( schemaDef ).split( "\\|" );
			ht = makeAuditDoc( null, doc, 0, "field", "", "", 0, 0, schemaList, 0, changeSpace );
			hashTable = ( Hashtable )ht.get( "AUDITDATA" );
			
			hashSize = hashTable.size();
			AuditDataList = new IData[ hashSize ];
			
			for ( int i = 0; i < hashSize; i++ ) {
				// Hashtable\uC5D0\uB294 \uC785\uB825 \uBC1B\uC740 doc\uC758 \uD56D\uBAA9\uB4E4\uC758 \uC5ED\uC21C\uC73C\uB85C \uC800\uC7A5\uB418\uC5B4 \uC788\uC9C0\uB9CC Name\uC73C\uB85C \uCD94\uCD9C\uD558\uBBC0\uB85C i \uC21C\uC11C\uB300\uB85C \uC800\uC7A5\uD55C\uB2E4.
				tempAuditData = ( IData )hashTable.get( "ITEM_" + i );
				AuditDataList[ i ] = tempAuditData;
				newHT.put( "ITEM_" + seq, tempAuditData );
				
				cur = tempAuditData.getCursor();
				idataType = IDataUtil.getString( cur, "idataType" );
				
				if ( idataType.equals( "list" ) ) {
					titleValue = IDataUtil.getString( cur, "titleValue" );
					listDepth = IDataUtil.getString( cur, "listDepth" );
					
					// List Depth\uAC00 2 \uC774\uC0C1\uC774 \uB418\uB294 \uACBD\uC6B0\uC5D0\uB294 \uD654\uBA74\uC5D0\uC11C \uBCF4\uAE30 \uC88B\uAC8C Values \uB808\uCF54\uB4DC \uC55E\uC5D0 Title IData\uB97C \uCD94\uAC00 \uD574\uC900\uB2E4.
					if ( titleValue.equals( "title" ) ) {
						htTitle.put( "TITLE_" + listDepth, tempAuditData );
					} else if ( titleValue.equals( "listEnd" ) ) {
						if ( !listDepth.equals( "1" ) ) {
							if ( i < ( hashSize - 2 ) ) {
								nextAuditData = ( IData )hashTable.get( "ITEM_" + ( i + 1 ) );
								nextCur = nextAuditData.getCursor();
								nextTitleType = IDataUtil.getString( nextCur, "idataType" );
								nextTitleValue = IDataUtil.getString( nextCur, "titleValue" );
								nextCur.destroy();
								
								// List\uAC00 \uC5F0\uC18D\uC801\uC73C\uB85C \uB05D\uB098\uB294 \uACBD\uC6B0\uC5D0\uB294 Skip
								if ( nextTitleType.equals( "list" ) && !nextTitleValue.equals( "listEnd" ) ) {
									seq++;
									backupTitleData = ( IData )htTitle.get( "TITLE_" + (Integer.parseInt( listDepth ) - 1 ) );
									newHT.put( "ITEM_" + seq, backupTitleData );
									newUse = true;
								}
							}
						}
					}
				}
				
				cur.destroy();
				seq++;
			}
			
			if ( newUse == true ) {
				hashSize = newHT.size();
				AuditDataList = null;
				AuditDataList = new IData[ hashSize ];				
				
				for ( int i = 0; i < hashSize; i++ ) {
					AuditDataList[ i ] = ( IData )newHT.get( "ITEM_" + i );					
				}
			}
			
			errorMsg = ( String )ht.get( "ERRORMSG" );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		hashTable = null;
		ht = null;
		htTitle = null;
		newHT = null;
		tempAuditData = null;
		backupTitleData = null;
		nextAuditData = null;
		schemaList = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "AuditDataList", AuditDataList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void analyzeDocData (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(analyzeDocData)>> ---
		// @sigtype java 3.5
		// [i] field:0:required docData
		// [i] field:0:required charset
		// [i] field:1:required recCountFieldName
		// [i] field:0:required sourceTargetType {"sourceSide","targetSide"}
		// [i] field:0:required changeSpace {"true","false"}
		// [i] record:0:required docSchemaDef
		// [o] field:0:required errorMsg
		// [o] field:0:required schemaDefType
		// [o] record:1:required DocDataList
		IDataCursor pipelineCursor = pipeline.getCursor();
		String docData = IDataUtil.getString( pipelineCursor, "docData" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		String[] recCountFieldName = IDataUtil.getStringArray( pipelineCursor, "recCountFieldName" );
		String sourceTargetType = IDataUtil.getString( pipelineCursor, "sourceTargetType" );
		String changeSpace = IDataUtil.getString( pipelineCursor, "changeSpace" );
		IData docSchemaDef = IDataUtil.getIData( pipelineCursor, "docSchemaDef" );
		
		pipelineCursor.destroy();
		
		Hashtable ht = null;
		Hashtable hashTable = null;
		int hashSize = 0;
		String schemaDefType = "";
		IData[] DocDataList = null;		
		String errorMsg = "";
		
		try {
			ht = makeDocData( null, docData, 0, charset, recCountFieldName, sourceTargetType, docSchemaDef, 0, 0, 0, changeSpace, "true" );
			schemaDefType = ( String )ht.get( "SCHEMADEFTYPE" );
			hashTable = ( Hashtable )ht.get( "DOCDATA" );
			
			hashSize = hashTable.size();
			DocDataList = new IData[ hashSize ];
			
			for ( int i = 0; i < hashSize; i++ ) {
				// Hashtable\uC5D0\uB294 \uC785\uB825 \uBC1B\uC740 doc\uC758 \uD56D\uBAA9\uB4E4\uC758 \uC5ED\uC21C\uC73C\uB85C \uC800\uC7A5\uB418\uC5B4 \uC788\uC9C0\uB9CC Name\uC73C\uB85C \uCD94\uCD9C\uD558\uBBC0\uB85C i \uC21C\uC11C\uB300\uB85C \uC800\uC7A5\uD55C\uB2E4.
				DocDataList[ i ] = ( IData )hashTable.get( "ITEM_" + i );
			}
			
			errorMsg = ( String )ht.get( "ERRORMSG" );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		hashTable = null;
		ht = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "schemaDefType", schemaDefType );
		IDataUtil.put( pipelineCursor_1, "DocDataList", DocDataList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void analyzeSchemaDef (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(analyzeSchemaDef)>> ---
		// @sigtype java 3.5
		// [i] record:0:required doc
		// [i] field:1:required recCountFieldName
		// [o] field:0:required errorMsg
		// [o] field:0:required schemaDefType
		// [o] record:1:required SchemaDefList
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData doc = IDataUtil.getIData( pipelineCursor, "doc" );
		String[] recCountFieldName = IDataUtil.getStringArray( pipelineCursor, "recCountFieldName" );
		pipelineCursor.destroy();
		
		Hashtable ht = null;
		Hashtable hashTable = null;
		int hashSize = 0;
		String schemaDefType = "";
		IData[] SchemaDefList = null;
		String errorMsg = "";
		
		try {
			ht = makeSchemaDefDoc( null, doc, 0, 0, recCountFieldName, 0 );
			schemaDefType = ( String )ht.get( "SCHEMADEFTYPE" );
			hashTable = ( Hashtable )ht.get( "SCHEMADATA" );
			
			hashSize = hashTable.size();
			SchemaDefList = new IData[ hashSize ];
			
			for ( int i = 0; i < hashSize; i++ ) {
				// Hashtable\uC5D0\uB294 \uC785\uB825 \uBC1B\uC740 doc\uC758 \uD56D\uBAA9\uB4E4\uC758 \uC5ED\uC21C\uC73C\uB85C \uC800\uC7A5\uB418\uC5B4 \uC788\uC9C0\uB9CC Name\uC73C\uB85C \uCD94\uCD9C\uD558\uBBC0\uB85C i \uC21C\uC11C\uB300\uB85C \uC800\uC7A5\uD55C\uB2E4.
				SchemaDefList[ i ] = ( IData )hashTable.get( "ITEM_" + i );
			}
			
			errorMsg = ( String )ht.get( "ERRORMSG" );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		hashTable = null;
		ht = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "schemaDefType", schemaDefType );
		IDataUtil.put( pipelineCursor_1, "SchemaDefList", SchemaDefList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void changeAuditData (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(changeAuditData)>> ---
		// @sigtype java 3.5
		// [i] record:0:required doc
		// [i] field:0:required changeData
		// [o] record:0:required doc
		// [o] field:1:required changeList
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData doc = IDataUtil.getIData( pipelineCursor, "doc" );
		String changeData = IDataUtil.getString( pipelineCursor, "changeData" );
		pipelineCursor.destroy();
		
		Hashtable ht = null;
		Hashtable chgList = new Hashtable();
		Enumeration hashList = null;
		String[] changeDataList = null;
		String[] nameValue = null;
		String[] changeList = null;
		int chgSize = 0;
		
		try {
			changeDataList = changeData.split( "\\|\\|" );
			
			for ( int i = 0; i < changeDataList.length; i++ ) {
				nameValue = changeDataList[ i ].split( "\\$\\$" );
				ht = setAuditData( doc, "field", "", "", 0, nameValue[ 0 ], nameValue[ 1 ], chgList );
				doc = ( IData )ht.get( "AUDITDATA" );
				chgList = ( Hashtable )ht.get( "CHGLIST" );
			}
			
			chgSize = chgList.size();
			hashList = chgList.elements();
			changeList = new String[ chgSize ];
			
			for ( int i = 0; i < chgSize; i++ ) {
				changeList[ i ] = ( String )hashList.nextElement();
			}
		} catch ( Exception e ) {
			
		}
		
		ht = null;
		chgList = null;
		hashList = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "doc", doc );
		IDataUtil.put( pipelineCursor_1, "changeList", changeList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertBytesToHexString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertBytesToHexString)>> ---
		// @sigtype java 3.5
		// [i] object:0:required inputBytes
		// [o] field:0:required hexString
		IDataCursor pipelineCursor = pipeline.getCursor();
		byte[] inputBytes = ( byte[] )IDataUtil.get( pipelineCursor, "inputBytes" );
		pipelineCursor.destroy();
		
		StringBuffer result = new StringBuffer();
		
		/*
		for ( byte b : inputBytes ) {
			result.append( Integer.toString( ( b & 0xF0 ) >> 4, 16 ) );
			result.append( Integer.toString( b & 0x0F, 16 ) );
		}
		*/
		
		for ( int i = 0; i < inputBytes.length; i++ ) {
			result.append( Integer.toHexString( 0x0100 + ( inputBytes[ i ] & 0x00FF ) ).substring( 1 ) );
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "hexString", result.toString() );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertHexStringToBytes (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertHexStringToBytes)>> ---
		// @sigtype java 3.5
		// [i] field:0:required hexString
		// [o] object:0:required outputBytes
		// [o] field:0:required outputBytesLen
		IDataCursor pipelineCursor = pipeline.getCursor();
		String hexString = IDataUtil.getString( pipelineCursor, "hexString" );
		pipelineCursor.destroy();
		
		hexString = hexString.replace( "0x", "" );
		byte[] outputBytes = new byte[ hexString.length() / 2 ];
		
		/*
		 * \uC601\uBB38, \uD55C\uAE00, \uC22B\uC790 \uC0C1\uAD00 \uC5C6\uC774 Hex Char \uB450 \uAC1C\uB97C 1byte\uC5D0 \uC800\uC7A5\uD55C\uB2E4.
		 * '\uAC00\uB098\uB2E4' \uB77C\uB294 \uD55C\uAE00\uC758 \uACBD\uC6B0 KSC5601\uB85C Encoding \uD55C(\uD55C \uAE00\uC790\uB2F9 2bytes) Hex String\uC740  2 * 6 = 12\uAC1C\uC758 Length \uC774\uACE0
		 * byte\uB85C \uBCC0\uD658\uD558\uBA74 byte length\uB294 6\uC774\uB2E4.
		 * UTF-8\uB85C Encoding \uD55C(\uD55C \uAE00\uC790\uB2F9 3bytes) Hex String\uC740  2 * 9 = 18\uAC1C\uC758 Length \uC774\uACE0
		 * byte\uB85C \uBCC0\uD658\uD558\uBA74 byte length\uB294 9\uC774\uB2E4.
		 * \uC774\uB807\uAC8C \uD558\uBA74 Hex String \uC790\uCCB4\uAC00 Byte\uB85C \uBCC0\uD658\uB41C \uAC83\uC774 \uC544\uB2C8\uB77C Hex String\uC73C\uB85C \uBCC0\uD658\uD558\uAE30 \uC774\uC804\uC758 \uC6D0\uB798 \uB370\uC774\uD130\uAC00 Byte\uB85C \uBCC0\uD658\uB41C\uB2E4.
		 * 
		 */
		
		for ( int i = 0; i < outputBytes.length; i++ ) {
			outputBytes[ i ] = ( byte )Integer.parseInt( hexString.substring( 2 * i, 2 * i + 2 ), 16 );
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outputBytes", outputBytes );
		IDataUtil.put( pipelineCursor_1, "outputBytesLen", outputBytes.length + "" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertHexStringToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertHexStringToString)>> ---
		// @sigtype java 3.5
		// [i] field:0:required hexString
		// [i] field:0:required encoding
		// [o] field:0:required outputString
		IDataCursor pipelineCursor = pipeline.getCursor();
		String hexString = IDataUtil.getString( pipelineCursor, "hexString" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();
		
		if ( encoding == null || encoding.equals( "" ) ) {
			encoding = "UTF-8";
		}
		
		String outputString = null;
		
		hexString = hexString.replace( "0x", "" );
		byte[] outputBytes = new byte[ hexString.length() / 2 ];
		
		/*
		 * \uC601\uBB38, \uD55C\uAE00, \uC22B\uC790 \uC0C1\uAD00 \uC5C6\uC774 Hex Char \uB450 \uAC1C\uB97C 1byte\uC5D0 \uC800\uC7A5\uD55C\uB2E4.
		 * '\uAC00\uB098\uB2E4' \uB77C\uB294 \uD55C\uAE00\uC758 \uACBD\uC6B0 KSC5601\uB85C Encoding \uD55C(\uD55C \uAE00\uC790\uB2F9 2bytes) Hex String\uC740  2 * 6 = 12\uAC1C\uC758 Length \uC774\uACE0
		 * byte\uB85C \uBCC0\uD658\uD558\uBA74 byte length\uB294 6\uC774\uB2E4.
		 * UTF-8\uB85C Encoding \uD55C(\uD55C \uAE00\uC790\uB2F9 3bytes) Hex String\uC740  2 * 9 = 18\uAC1C\uC758 Length \uC774\uACE0
		 * byte\uB85C \uBCC0\uD658\uD558\uBA74 byte length\uB294 9\uC774\uB2E4.
		 * 
		 */
		
		try {
			for ( int i = 0; i < outputBytes.length; i++ ) {
				outputBytes[ i ] = ( byte )Integer.parseInt( hexString.substring( 2 * i, 2 * i + 2 ), 16 );
			}
		
			outputString = new String( outputBytes, encoding );
		} catch ( Exception e ) {
			
		}
		
		outputBytes = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outputString", outputString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertStringToHexString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertStringToHexString)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inputString
		// [i] field:0:required encoding
		// [o] field:0:required hexString
		IDataCursor pipelineCursor = pipeline.getCursor();
		String inputString = IDataUtil.getString( pipelineCursor, "inputString" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();
		
		if ( encoding == null || encoding.equals( "" ) ) {
			encoding = "UTF-8";
		}
		
		byte[] inputBytes = null;
		StringBuffer result = new StringBuffer();
		
		try {
			inputBytes = inputString.getBytes( encoding );
			
			for ( int i = 0; i < inputBytes.length; i++ ) {
				result.append( Integer.toHexString( 0x0100 + ( inputBytes[ i ] & 0x00FF ) ).substring( 1 ) );
			}
		} catch ( Exception e ) {
			
		}
		
		inputBytes = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "hexString", result.toString() );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertToDocument (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertToDocument)>> ---
		// @sigtype java 3.5
		// [i] field:0:required socketString
		// [i] record:0:required schemaDef
		// [i] field:1:required recCountFieldName
		// [i] field:0:required charset
		// [i] field:0:required byteLength
		// [o] field:0:required errorMsg
		// [o] record:0:required doc
		IDataCursor pipelineCursor = pipeline.getCursor();
		String socketString = IDataUtil.getString( pipelineCursor, "socketString" );
		IData schemaDef = IDataUtil.getIData( pipelineCursor, "schemaDef" );		
		// Multi Record\uAC00 \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0 Record\uC758 \uAC2F\uC218\uB97C \uD3EC\uD568\uD558\uACE0 \uC788\uB294 Field Name ==> \uC5EC\uB7EC\uAC1C \uC874\uC7AC\uD560 \uC218 \uC788\uC73C\uBBC0\uB85C Array\uB85C \uC804\uB2EC \uBC1B\uB294\uB2E4.
		// Record\uC758 \uAC2F\uC218\uB97C \uD3EC\uD568\uD558\uACE0 \uC788\uB294 Field Name\uC774 \uC804\uBB38 \uC548\uC5D0 \uC5C6\uB294 \uACBD\uC6B0\uC5D0\uB294 Record\uC758 \uAC2F\uC218\uB97C \uC9C1\uC811 \uC804\uB2EC \uBC1B\uB294\uB2E4.
		String[] recCountFieldName = IDataUtil.getStringArray( pipelineCursor, "recCountFieldName" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		int byteLength = IDataUtil.getInt( pipelineCursor, "byteLength", 0 );
		pipelineCursor.destroy();
		
		IData[] convertInfo = null;
		IData doc = null;
		IData error = null;
		IDataCursor errorCursor = null;
		String errorMsg = "";
		
		try {
			// socketString\uC758 byte \uAE38\uC774
			// socketString\uC758 byte \uAE38\uC774\uB97C \uC785\uB825\uBC1B\uC9C0 \uBABB\uD55C \uACBD\uC6B0\uC5D0\uB294 \uC5EC\uAE30\uC5D0\uC11C \uC9C1\uC811 \uAE38\uC774\uB97C \uAD6C\uD55C\uB2E4.
			if ( byteLength == 0 ) {
				byteLength = ( socketString.getBytes( charset ) ).length;
			}
			
			convertInfo = makeStringIData_ApplySchema( socketString, byteLength, schemaDef, 0, recCountFieldName, 0, charset );
			
			doc = convertInfo[ 0 ];
			error = convertInfo[ 3 ];
			errorCursor = error.getCursor();
			errorMsg = IDataUtil.getString( errorCursor, "errorMsg" );
			errorCursor.destroy();
		}  catch ( Exception e ) {
			errorMsg = e.toString();
		}		
		
		convertInfo = null;
		error = null;
		schemaDef = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "doc", doc );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertToString)>> ---
		// @sigtype java 3.5
		// [i] record:0:required doc
		// [i] record:0:required schemaDef
		// [i] field:0:required stringLength
		// [i] field:0:required charset
		// [o] field:0:required errorMsg
		// [o] field:0:required socketString
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData doc = IDataUtil.getIData( pipelineCursor, "doc" );
		IData schemaDef = IDataUtil.getIData( pipelineCursor, "schemaDef" );
		String stringLength = IDataUtil.getString( pipelineCursor, "stringLength" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );		
		pipelineCursor.destroy();
		
		String socketString = "";
		String errorMsg = "";
		String iDataString = "";
		String[] schemaList = null;
		String[] convertInfo = null;
		
		IData inIData = null;
		IDataCursor inputCursor = null;
		IData outIData = null;
		IDataCursor outputCursor = null;
		
		try {
			/*
			schemaList = makeSchemaList( schemaDef ).split( "\\|" );
			convertInfo = makeIDataString_ApplySchema( doc, schemaList, 0, charset );
			*/
			schemaList = makeSchemaList2( schemaDef, "S" ).split( "\\|" );
			convertInfo = makeIDataString_ApplySchema2( doc, schemaList, 0, charset, "S" );
			iDataString = convertInfo[ 0 ];
			errorMsg = convertInfo[ 2 ];
			
			// stringLength\uAC00 null \uB610\uB294 \uACF5\uBC31\uC77C \uACBD\uC6B0 doc \uC804\uCCB4\uB97C String\uC73C\uB85C \uBCC0\uD658
			// String \uAE38\uC774\uAC00 \uC9C0\uC815\uB41C \uACBD\uC6B0\uB294 Substring
			if ( stringLength == null || stringLength.equals( "" ) ) {
				socketString = iDataString;
			} else {
				inIData = IDataFactory.create();
				inputCursor = inIData.getCursor();
				
				IDataUtil.put( inputCursor, "inString", iDataString );
				IDataUtil.put( inputCursor, "startOffset", "0" );
				IDataUtil.put( inputCursor, "length", stringLength );
				IDataUtil.put( inputCursor, "charset", charset );
			
				outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
				outputCursor = outIData.getCursor();
				socketString = IDataUtil.getString( outputCursor, "outString" );
			
				inputCursor.destroy();
				outputCursor.destroy();
			}
		}  catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		doc = null;
		inIData = null;
		outIData = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "socketString", socketString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void deleteFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(deleteFile)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		File file = null;
		
		try {
			file = new File( fileName );
			
			if ( file.isFile() ) {
				if ( file.exists() ) {
					file.delete();
				} else {
					errorMsg = fileName + " \uD30C\uC77C\uC774 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
				}
			} else {
				errorMsg = fileName + "\uB294(\uC740) \uC62C\uBC14\uB978 \uD30C\uC77C\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
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



	public static final void deleteIDataByKeyValue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(deleteIDataByKeyValue)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] record:1:required docList
		// [i] field:0:required key
		// [i] field:0:required value
		// [i] field:0:optional ignoreCase {"true","false"}
		// [o] record:1:required docList
		IDataCursor	pipelineCursor = pipeline.getCursor();
		IData[]	docList	= IDataUtil.getIDataArray( pipelineCursor, "docList" );
		
		if ( docList == null ) {
			docList = new IData[ 0 ]; 
		}
		
		String key = IDataUtil.getString( pipelineCursor, "key" );
		String value = IDataUtil.getString( pipelineCursor, "value" );
		String ignoreCase = IDataUtil.getString( pipelineCursor, "ignoreCase" );
		pipelineCursor.destroy();
		
		if ( ignoreCase == null ) {
			ignoreCase = "false";
		}
		
		Vector vtDocs = new Vector();	
		
		for ( int i = 0; i < docList.length; i++ ) {
			IDataCursor	tcur = docList[ i ].getCursor();
			String tval = IDataUtil.getString( tcur, key );
			boolean same = false;
			
			if ( "true".equals( ignoreCase ) ) {
				same = value.equalsIgnoreCase( tval );
			} else {
				same = value.equals( tval );
			}
			
			tcur.destroy();
			
			if ( same ) {
				continue;
			} else {
				vtDocs.add( docList[ i ] );
			}
		}
		
		IData[] newDocs = new IData[ vtDocs.size() ];
		vtDocs.toArray( newDocs );
		
		if ( newDocs == null )
			newDocs = new IData[ 0 ];
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "docList", newDocs );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void documentToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(documentToString)>> ---
		// @sigtype java 3.5
		// [i] record:0:required doc
		// [i] field:0:required stringLength
		// [i] field:0:required charset
		// [o] field:0:required errorMsg
		// [o] field:0:required socketString
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData doc = IDataUtil.getIData( pipelineCursor, "doc" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		int stringLength = IDataUtil.getInt( pipelineCursor, "stringLength", 0 );
		pipelineCursor.destroy();
		
		byte[] iDataBytes = null;
		byte[] subBytes = null;
		String socketString = "";
		String errorMsg = "";
		String iDataString = "";
		
		IData inIData = IDataFactory.create();
		IDataCursor inputCursor = inIData.getCursor();
		IData outIData = null;
		IDataCursor outputCursor = null;
		
		try {
			iDataString = makeIDataString( doc );
			
			IDataUtil.put( inputCursor, "inString", iDataString );
			IDataUtil.put( inputCursor, "startOffset", "0" );
			IDataUtil.put( inputCursor, "length", stringLength );
			IDataUtil.put( inputCursor, "charset", charset );
			
			outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
			outputCursor = outIData.getCursor();
			socketString = IDataUtil.getString( outputCursor, "outString" );
			
			inputCursor.destroy();
			outputCursor.destroy();
		}  catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		doc = null;
		inIData = null;
		outIData = null;
		iDataBytes = null;
		subBytes = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "socketString", socketString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void documentToString_ApplySchema (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(documentToString_ApplySchema)>> ---
		// @sigtype java 3.5
		// [i] record:0:required doc
		// [i] field:0:required stringLength
		// [i] field:0:required charset
		// [i] field:1:required schemaList
		// [o] field:0:required errorMsg
		// [o] field:0:required socketString
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData doc = IDataUtil.getIData( pipelineCursor, "doc" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		String stringLength = IDataUtil.getString( pipelineCursor, "stringLength" );
		String[] schemaList = IDataUtil.getStringArray( pipelineCursor, "schemaList" );
		pipelineCursor.destroy();
		
		byte[] iDataBytes = null;
		byte[] subBytes = null;
		String socketString = "";
		String errorMsg = "";
		String iDataString = "";
		
		IData inIData = null;
		IDataCursor inputCursor = null;
		IData outIData = null;
		IDataCursor outputCursor = null;
		
		try {
			iDataString = makeIDataString_ApplySchema( doc, schemaList, 0, charset )[ 0 ];
			
			// stringLength\uAC00 null \uB610\uB294 \uACF5\uBC31\uC77C \uACBD\uC6B0 doc \uC804\uCCB4\uB97C String\uC73C\uB85C \uBCC0\uD658
			// String \uAE38\uC774\uAC00 \uC9C0\uC815\uB41C \uACBD\uC6B0\uB294 Substring
			if ( stringLength == null || stringLength.equals( "" ) ) {
				socketString = iDataString;
			} else {
				inIData = IDataFactory.create();
				inputCursor = inIData.getCursor();
							
				IDataUtil.put( inputCursor, "inString", iDataString );
				IDataUtil.put( inputCursor, "startOffset", "0" );
				IDataUtil.put( inputCursor, "length", stringLength );
				IDataUtil.put( inputCursor, "charset", charset );
						
				outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
				outputCursor = outIData.getCursor();
				socketString = IDataUtil.getString( outputCursor, "outString" );
						
				inputCursor.destroy();
				outputCursor.destroy();
			}
		}  catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		doc = null;
		inIData = null;
		outIData = null;
		iDataBytes = null;
		subBytes = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "socketString", socketString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void existFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(existFile)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [o] field:0:required exists
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		pipelineCursor.destroy();
		
		String exists = "";
		String errorMsg = "";
		File file = null;
		
		try {
			file = new File( fileName );
			
			if ( file.isFile() ) {
				if ( file.exists() ) {
					exists = "true";
				} else {
					exists = "false";
					errorMsg = fileName + " \uD30C\uC77C\uC774 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
				}
			} else {
				exists = "false";
				errorMsg = fileName + "\uB294(\uC740) \uC62C\uBC14\uB978 \uD30C\uC77C\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			exists = "false";
			errorMsg = e.getMessage();
		}
		
		file = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exists", exists );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getArrayCountFieldNames (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getArrayCountFieldNames)>> ---
		// @sigtype java 3.5
		// [i] field:0:required schemaDefine
		// [o] field:1:required arrayCountFieldNameList
		IDataCursor pipelineCursor = pipeline.getCursor();
		String schemaDefine = IDataUtil.getString( pipelineCursor, "schemaDefine" );
		pipelineCursor.destroy();
		
		String[] schemaList = null;
		String[] itemList = null;
		String parentPath = "";
		String fieldName = "";
		String arrayCountYN = "";
		int arrayCount = 0;
		String arrayCountFieldName = "";		
		String[] arrayCountFieldNameList = null;
		
		// \uD544\uB4DC\uBCC4 \uC2A4\uD0A4\uB9C8 \uC815\uC758 \uBAA9\uB85D \uAD6C\uD558\uAE30
		schemaList = schemaDefine.split( "\\n" );
		
		for ( int i = 0; i < schemaList.length; i++ ) {
			// \uAC01 \uD544\uB4DC\uC5D0 \uB300\uD55C \uC2A4\uD0A4\uB9C8 \uC815\uC758 \uD56D\uBAA9\uB4E4 \uAD6C\uD558\uAE30
			itemList = schemaList[ i ].split( "\\t" );
			parentPath = itemList[ 0 ].trim();
			fieldName = itemList[ 1 ];
			arrayCountYN = itemList[ 3 ].trim(); // Array Count \uC815\uBCF4\uB97C \uD3EC\uD568\uD558\uB294 \uD544\uB4DC\uC778\uC9C0 \uC5EC\uBD80
			
			if ( arrayCountYN.equals( "" ) || arrayCountYN.equals( "N" ) ) {
				// Array Count \uC815\uBCF4\uB97C \uD3EC\uD568\uD558\uB294 \uD544\uB4DC\uAC00 \uC544\uB2CC \uACBD\uC6B0 ==> Skip
			} else {
				// Array Count \uC815\uBCF4\uB97C \uD3EC\uD568\uD558\uB294 \uD544\uB4DC\uC778 \uACBD\uC6B0
				try {
					arrayCount = Integer.parseInt( arrayCountYN );
					// Array Count \uC815\uBCF4\uB97C \uD3EC\uD568\uD558\uB294 \uD544\uB4DC\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC73C\uBA74\uC11C Array Count\uAC00 \uACE0\uC815\uAC12\uC778 \uACBD\uC6B0 ==> \uC22B\uC790 \uC815\uBCF4\uB9CC \uD544\uC694
					if ( arrayCountFieldName.equals( "" ) ) {
							arrayCountFieldName = arrayCount + "";
					} else {
							arrayCountFieldName = arrayCountFieldName + "|" + arrayCount + "";
					}
				} catch ( Exception ne ) {
					// Array Count \uC815\uBCF4\uB97C \uD3EC\uD568\uD558\uB294 \uD544\uB4DC\uAC00 \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0
					if ( itemList.length >= 14 ) {
						// Socket To REST API \uBC29\uC2DD, REST API To Socket \uBC29\uC2DD, Socket To Socket \uBC29\uC2DD\uC774\uBA74\uC11C Source, Target \uD3EC\uB9F7\uC774 \uC11C\uB85C \uB2E4\uB978 \uACBD\uC6B0
						if ( arrayCountFieldName.equals( "" ) ) {
							if ( parentPath.equals( "" ) ) {
								arrayCountFieldName = fieldName;
							} else {
								arrayCountFieldName = parentPath + "/" + fieldName;
							}
						} else {
							if ( parentPath.equals( "" ) ) {
								arrayCountFieldName = arrayCountFieldName + "|" + fieldName;
							} else {
								arrayCountFieldName = arrayCountFieldName + "|" + parentPath + "/" + fieldName;
							}
						}
					} else {
						// Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0, \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0, \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
						if ( arrayCountFieldName.equals( "" ) ) {
							arrayCountFieldName = fieldName;
						} else {
							arrayCountFieldName = arrayCountFieldName + "|" + fieldName;
						}
					}
				}
			}
		}
		
		if ( !arrayCountFieldName.equals( "" ) ) {
			arrayCountFieldNameList = arrayCountFieldName.split( "\\|" );
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "arrayCountFieldNameList", arrayCountFieldNameList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getEndianFieldsLengthSum (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getEndianFieldsLengthSum)>> ---
		// @sigtype java 3.5
		// [i] record:0:required schemaDef
		// [i] field:0:required startIndex
		// [i] field:0:required endIndex
		// [o] field:0:required lengthSum
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData schemaDef = IDataUtil.getIData( pipelineCursor, "schemaDef" );
		int startIndex = IDataUtil.getInt( pipelineCursor, "startIndex", 0 );
		int endIndex = IDataUtil.getInt( pipelineCursor, "endIndex", 0 );
		pipelineCursor.destroy();
		
		int lengthSum = 0;
		String[] schemaList = null;
		String[] token = null;
		String fieldLength = "";
		String fieldArray = "";
		int schemaCount = 0;
		
		try {
			schemaList = makeSchemaList( schemaDef ).split( "\\|" );
			schemaCount = schemaList.length;
			
			if ( endIndex == 0 ) {
				endIndex = schemaCount - 1;
			}
			
			for ( int i = 0; i < schemaCount; i++ ) {
				if ( i < startIndex ) {
					// Skip
				} else if ( i >= startIndex && i <= endIndex ) {
					token = schemaList[ i ].split( "/" );
					
					if ( token.length == 4 ) {
						fieldLength = token[ 1 ];
						fieldArray = token[ 2 ];
					} else if ( token.length == 7 ) {
						fieldLength = token[ 5 ];
						fieldArray = token[ 6 ];
					}
					
					lengthSum += ( Integer.parseInt( fieldLength ) * Integer.parseInt( fieldArray ) );
				} else if ( i <= endIndex ) {
					break;
				}
			}
		}  catch ( Exception e ) {
			throw new ServiceException( e.getMessage() );
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "lengthSum", lengthSum + "" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getFieldsLengthSum (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getFieldsLengthSum)>> ---
		// @sigtype java 3.5
		// [i] record:0:required schemaDef
		// [i] field:0:required startIndex
		// [i] field:0:required endIndex
		// [o] field:0:required lengthSum
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData schemaDef = IDataUtil.getIData( pipelineCursor, "schemaDef" );
		int startIndex = IDataUtil.getInt( pipelineCursor, "startIndex", 0 );
		int endIndex = IDataUtil.getInt( pipelineCursor, "endIndex", 0 );
		pipelineCursor.destroy();
		
		int lengthSum = 0;
		String[] schemaList = null;
		String[] token = null;
		String fieldLength = "";
		int schemaCount = 0;
		
		try {
			schemaList = makeSchemaList( schemaDef ).split( "\\|" );
			schemaCount = schemaList.length;
			
			if ( endIndex == 0 ) {
				endIndex = schemaCount - 1;
			}
			
			for ( int i = 0; i < schemaCount; i++ ) {
				if ( i < startIndex ) {
					// Skip
				} else if ( i >= startIndex && i <= endIndex ) {
					token = schemaList[ i ].split( "/" );
					fieldLength = token[ 0 ];
					lengthSum += Integer.parseInt( fieldLength );
				} else if ( i <= endIndex ) {
					break;
				}
			}
		}  catch ( Exception e ) {
			throw new ServiceException( e.getMessage() );
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "lengthSum", lengthSum + "" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getFileLength (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getFileLength)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [o] field:0:required fileLength
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		pipelineCursor.destroy();
		
		String fileLength = "";
		String errorMsg = "";
		File file = null;
		
		try {
			file = new File( fileName );
			
			if ( file.isFile() ) {
				if ( file.exists() ) {
					fileLength = file.length() + "";
				} else {
					errorMsg = fileName + " \uD30C\uC77C\uC774 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
				}
			} else {
				errorMsg = fileName + "\uB294(\uC740) \uC62C\uBC14\uB978 \uD30C\uC77C\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.getMessage();
		}
		
		file = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "fileLength", fileLength );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getFileNameFromFullName (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getFileNameFromFullName)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fullFileName
		// [o] field:0:required fileName
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fullFileName = IDataUtil.getString( pipelineCursor, "fullFileName" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		String fileName = "";
		File file = null;
		
		try {
			file = new File( fullFileName );
			
			if ( file.exists() ) {
				fileName = file.getName();
			} else {
				errorMsg = fullFileName + " \uD30C\uC77C\uC774 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.getMessage();
		}
		
		file = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "fileName", fileName );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getFileNameList (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getFileNameList)>> ---
		// @sigtype java 3.5
		// [i] field:0:required dir
		// [o] field:1:required fileNameList
		// [o] field:0:required fileCount
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String dir = IDataUtil.getString( pipelineCursor, "dir" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		String fileNameList[] = null;
		String fileCount = "0";
		File directory = null;
		
		try {
			directory = new File( dir );
			
			if ( directory.isDirectory() ) {
				if ( directory.exists() ) {
					fileNameList = directory.list();
					fileCount = fileNameList.length + "";
				} else {
					errorMsg = dir + " \uB514\uB809\uD1A0\uB9AC\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
				}
			} else {
				errorMsg = dir + "\uB294(\uC740) \uC62C\uBC14\uB978 \uB514\uB809\uD1A0\uB9AC\uBA85\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.getMessage();
		}
		
		directory = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "fileNameList", fileNameList );
		IDataUtil.put( pipelineCursor_1, "fileCount", fileCount );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getLastSequence (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getLastSequence)>> ---
		// @sigtype java 3.5
		// [i] field:0:required totalCount
		// [i] field:0:required maxCount
		// [o] field:0:required lastSeq
		IDataCursor pipelineCursor = pipeline.getCursor();
		double totalCount = ( double )IDataUtil.getInt( pipelineCursor, "totalCount", 0 );
		double maxCount = ( double )IDataUtil.getInt( pipelineCursor, "maxCount", 0 );
		
		String lastSeq = ( ( int )Math.ceil( totalCount / maxCount ) ) + "";
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "lastSeq", lastSeq );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getRootServiceName (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getRootServiceName)>> ---
		// @sigtype java 3.5
		// [o] field:0:required rootContextID
		// [o] field:0:required parentContextID
		// [o] field:0:required contextID
		// [o] record:0:required iData
		// [o] field:0:required rootServiceName
		debugLogger.printLogAtIS( "### getRootServiceName Start!!!", "asynch" );
		InvokeState is = InvokeState.getCurrentState();
		IAuditRuntime iar = is.getAuditRuntime();
		String[] acs = iar.getContextStack();		
		
		for ( int i = 0; i < acs.length; i++ ) {
			debugLogger.printLogAtIS( "acs[" + i + "] : " + acs[ i ], "asynch" );
		}
		
		String rootContextID = acs[ 0 ];
		String parentContextID = "";
		String contextID = acs[ 0 ];
		
		IData iData = is.getPipeline();
		
		if ( iData == null ) {
			debugLogger.printLogAtIS( "iData is null", "asynch" );
		} else {
			debugLogger.printLogAtIS( "iData is not null", "asynch" );
			debugLogger.printLogAtIS( iData.toString(), "asynch" );
		}
		
		IDataCursor idc = iData.getCursor();
		String rootServiceName = IDataUtil.getString( idc, "$service" );
				
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "rootContextID", rootContextID );
		IDataUtil.put( pipelineCursor_1, "parentContextID", parentContextID );
		IDataUtil.put( pipelineCursor_1, "contextID", contextID );
		IDataUtil.put( pipelineCursor_1, "iData", iData );
		IDataUtil.put( pipelineCursor_1, "rootServiceName", rootServiceName );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getSortingFileNameList (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getSortingFileNameList)>> ---
		// @sigtype java 3.5
		// [i] field:0:required dir
		// [o] field:1:required fileNameList
		// [o] field:0:required fileCount
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String dir = IDataUtil.getString( pipelineCursor, "dir" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		String fileNameList[] = null;
		String fileCount = "0";
		File directory = null;
		File[] fileList = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			directory = new File( dir );
			
			if ( directory.isDirectory() ) {
				if ( directory.exists() ) {
					fileList = directory.listFiles();
					
					if ( fileList.length > 0 ) {
						Arrays.sort( fileList, new Comparator() {
							public int compare( Object arg0, Object arg1 ) {
								File file1 = ( File )arg0;
								File file2 = ( File )arg1;
								return file1.getName().compareToIgnoreCase( file2.getName() );
							}
						});
						
						for ( int i = 0; i < fileList.length; i++ ) {
							if ( fileList[ i ].isFile() ) {
								if ( sb.length() == 0 ) {
									sb.append( fileList[ i ].getName() );
								} else {
									sb.append( "|" + fileList[ i ].getName() );
								}
							}
						}
						
						if ( sb.length() > 0 ) {
							fileNameList = sb.toString().split( "\\|" );
							fileCount = fileNameList.length + "";
						}
					}
				} else {
					errorMsg = dir + " \uB514\uB809\uD1A0\uB9AC\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
				}
			} else {
				errorMsg = dir + "\uB294(\uC740) \uC62C\uBC14\uB978 \uB514\uB809\uD1A0\uB9AC\uBA85\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.getMessage();
		}
		
		directory = null;
		fileList = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "fileNameList", fileNameList );
		IDataUtil.put( pipelineCursor_1, "fileCount", fileCount );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void isFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(isFile)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [o] field:0:required isFile
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		pipelineCursor.destroy();
		
		String isFile = "";
		File file = null;
		
		try {
			file = new File( fileName );
			
			if ( file.isFile() ) {
				isFile = "true";
			} else {
				isFile = "false";
			}
		} catch ( Exception e ) {
			
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "isFile", isFile );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void makeBuffer (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(makeBuffer)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required size
		// [o] object:0:required buffer
		IDataCursor	pipelineCursor = pipeline.getCursor();
		int	size = IDataUtil.getInt( pipelineCursor, "size", 0 );
		pipelineCursor.destroy();
		
		byte[] buffer = new byte[ size ];
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "buffer", buffer );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void searchAuditLogFileNameList (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(searchAuditLogFileNameList)>> ---
		// @sigtype java 3.5
		// [i] field:0:required dir
		// [i] field:1:required containNameList
		// [i] field:0:required containsDate {"true","false"}
		// [i] field:0:required sorting {"ascending","descending","queueTopic"}
		// [o] field:1:required fileNameList
		// [o] field:0:required fileCount
		// [o] field:0:required dirTotalFileCount
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String dirt = IDataUtil.getString( pipelineCursor, "dir" );
		String[] containNameList = IDataUtil.getStringArray( pipelineCursor, "containNameList" );
		String containsDate = IDataUtil.getString( pipelineCursor, "containsDate" );
		String sorting = IDataUtil.getString( pipelineCursor, "sorting" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		String fileNameList[] = null;
		String totFileNameList[] = null;
		String fileCount = "0";
		String dirTotalFileCount = "0";
		File directory = null;
		
		if ( sorting == null || sorting.equals( "" ) ) {
			sorting = "ascending";
		}
		
		try {
			directory = new File( dirt );
			
			if ( directory.isDirectory() ) {
				if ( directory.exists() ) {
					if ( containNameList == null ) {
						// \uD574\uB2F9 \uB514\uB809\uD1A0\uB9AC\uC758 \uC804\uCCB4 \uD30C\uC77C\uBA85 \uBAA9\uB85D \uAD6C\uD558\uAE30									
						fileNameList = directory.list();
						fileCount = fileNameList.length + "";
						dirTotalFileCount = fileCount;
					} else {
						// \uD574\uB2F9 \uB514\uB809\uD1A0\uB9AC\uC758 \uC804\uCCB4 \uD30C\uC77C\uC218 \uAD6C\uD558\uAE30
						totFileNameList = directory.list();
						dirTotalFileCount = totFileNameList.length + "";
						
						// \uD30C\uC77C\uBA85\uC5D0 \uAC80\uC0C9\uD558\uACE0\uC790 \uD558\uB294 \uBB38\uAD6C\uAC00 \uD3EC\uD568\uB41C \uD30C\uC77C\uBA85 \uBAA9\uB85D\uB9CC \uAD6C\uD558\uAE30
						fileNameList = directory.list( new FilenameFilter() {
							@Override
							public boolean accept( File dir, String name ) {
								boolean match = false;
								
								if ( containsDate != null && containsDate.equals( "true" ) ) {
									// \uC870\uD68C\uC870\uAC74\uC5D0 \uB0A0\uC9DC, \uC2DC\uAC04\uC774 \uD3EC\uD568\uB418\uC5B4 \uC788\uB294 \uACBD\uC6B0
									// \uD30C\uC77C\uBA85\uC744 \uD56D\uBAA9\uBCC4\uB85C \uBD84\uB9AC
									String[] fileNames = name.split( "\\$" );
									
									// Audit Start Time \uCD94\uCD9C
									String auditStartTime = fileNames[ 1 ];
									String fromTime = "";
									String toTime = "";
									
									for ( int i = 0; i < containNameList.length; i++ ) {
										if ( i == 0 ) {
											// \uC870\uD68C\uC870\uAC74 fromTime \uCD94\uCD9C
											fromTime = containNameList[ i ];
										} else if ( i == 1 ) {
											// \uC870\uD68C\uC870\uAC74 toTime \uCD94\uCD9C
											toTime = containNameList[ i ];
											
											match = isContainFromToDate( auditStartTime, fromTime, toTime, "yyyyMMddHHmmssSSS", "yyyyMMddHHmmss", "yyyyMMddHHmmss" );
											
											if ( match == false ) {
												break;
											}
										} else {
											if ( name.contains( containNameList[ i ] ) ) {							
												match = true;
											} else {
												match = false;
												break;
											}
										}
									}
									
									fileNames = null;
								} else {
									for ( int i = 0; i < containNameList.length; i++ ) {
										if ( name.contains( containNameList[ i ] ) ) {
											match = true;
										} else {
											match = false;
											break;
										}
									}
								}
								
								return match;
							}
						});
						
						fileCount = fileNameList.length + "";
					}
				} else {
					errorMsg = dirt + " \uB514\uB809\uD1A0\uB9AC\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
				}
			} else {
				errorMsg = dirt + "\uB294(\uC740) \uC62C\uBC14\uB978 \uB514\uB809\uD1A0\uB9AC\uBA85\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
			}
			
			if ( !fileCount.equals( "0" ) ) {
				if ( sorting.equals( "descending" ) ) {
					fileNameList = sortStartTime( fileNameList, sorting );
				} else if ( sorting.equals( "queueTopic" ) ) {
					fileNameList = sortQueueTopic( fileNameList );
				}
			}
		} catch ( Exception e ) {
			errorMsg = e.getMessage();
		}
		
		directory = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "fileNameList", fileNameList );
		IDataUtil.put( pipelineCursor_1, "fileCount", fileCount );
		IDataUtil.put( pipelineCursor_1, "dirTotalFileCount", dirTotalFileCount );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void searchFileNameList (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(searchFileNameList)>> ---
		// @sigtype java 3.5
		// [i] field:0:required dir
		// [i] field:1:required containNameList
		// [o] field:1:required fileNameList
		// [o] field:0:required fileCount
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String dirt = IDataUtil.getString( pipelineCursor, "dir" );
		String[] containNameList = IDataUtil.getStringArray( pipelineCursor, "containNameList" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		String fileNameList[] = null;
		String fileCount = "0";
		File directory = null;
		
		try {
			directory = new File( dirt );
			
			if ( directory.isDirectory() ) {
				if ( directory.exists() ) {
					if ( containNameList == null ) {
						// \uD574\uB2F9 \uB514\uB809\uD1A0\uB9AC\uC758 \uC804\uCCB4 \uD30C\uC77C\uBA85 \uBAA9\uB85D \uAD6C\uD558\uAE30									
						fileNameList = directory.list();
						fileCount = fileNameList.length + "";
					} else {
						// \uD30C\uC77C\uBA85\uC5D0 \uAC80\uC0C9\uD558\uACE0\uC790 \uD558\uB294 \uBB38\uAD6C\uAC00 \uD3EC\uD568\uB41C \uD30C\uC77C\uBA85 \uBAA9\uB85D\uB9CC \uAD6C\uD558\uAE30
						fileNameList = directory.list( new FilenameFilter() {
							@Override
							public boolean accept( File dir, String name ) {
								boolean match = false;
								
								for ( int i = 0; i < containNameList.length; i++ ) {
									if ( name.contains( containNameList[ i ] ) ) {
										match = true;
									} else {
										match = false;
										break;
									}
								}
								
								return match;
							}
						});
						
						fileCount = fileNameList.length + "";
					}
				} else {
					errorMsg = dirt + " \uB514\uB809\uD1A0\uB9AC\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
				}
			} else {
				errorMsg = dirt + "\uB294(\uC740) \uC62C\uBC14\uB978 \uB514\uB809\uD1A0\uB9AC\uBA85\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.getMessage();
		}
		
		directory = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "fileNameList", fileNameList );
		IDataUtil.put( pipelineCursor_1, "fileCount", fileCount );
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void sortIDataArrayByKey (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sortIDataArrayByKey)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] record:1:required docs
		// [i] field:0:required key
		// [i] field:0:optional compareType {"COLLATION","TIME"}
		// [i] field:0:optional pattern
		// [i] field:0:optional ascending {"false","true"}
		// [o] record:1:required docs
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData[] docs = IDataUtil.getIDataArray( pipelineCursor, "docs" );
		String key = IDataUtil.getString( pipelineCursor, "key" );
		String compareType = IDataUtil.getString( pipelineCursor, "compareType" );
		String pattern = IDataUtil.getString( pipelineCursor, "pattern" );
		boolean ascending = new Boolean( IDataUtil.getString( pipelineCursor, "ascending" ) ).booleanValue();
		int cType = IDataUtil.COMPARE_TYPE_COLLATION;
		
		if ( docs == null ) {
			return;
		}
		
		if ( "TIME".equals( compareType ) ) {
			cType = IDataUtil.COMPARE_TYPE_TIME;
			
			if ( pattern == null ) {
				pattern = "yyyyMMdd HH:mm:ss.SSS";
			}
		}
		
		docs = IDataUtil.sortIDataArrayByKey( docs, key, cType, pattern, ascending );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "docs", docs );
		// --- <<IS-END>> ---

                
	}



	public static final void sortQueueTopicName (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sortQueueTopicName)>> ---
		// @sigtype java 3.5
		// [i] field:1:required InFileNameList
		// [o] field:1:required OutFileNameList
		IDataCursor pipelineCursor = pipeline.getCursor();
		String[] InFileNameList = IDataUtil.getStringArray( pipelineCursor, "InFileNameList" );
		pipelineCursor.destroy();
		
		String[] OutFileNameList = sortQueueTopic( InFileNameList );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "OutFileNameList", OutFileNameList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void sosiTrim (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sosiTrim)>> ---
		// @sigtype java 3.5
		// [i] field:0:required sosiString
		// [i] field:0:required charset
		// [o] field:0:required sosiTrim
		IDataCursor pipelineCursor = pipeline.getCursor();
		String sosiString = IDataUtil.getString( pipelineCursor, "sosiString" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		pipelineCursor.destroy();
		
		if ( charset == null ) {
			charset = "UTF-8";
		}
		
		byte[] sosiBytes = null;
		byte[] newSosiBytes = null;
		byte SO = Byte.parseByte( "0E", 16 );
		byte SI = Byte.parseByte( "0F", 16 );
		int idx = 0;
		String sosiTrim = "";
		
		try {
			sosiBytes = sosiString.getBytes( charset );
			newSosiBytes = new byte[ sosiBytes.length ];
			
			for ( int i = 0; i < sosiBytes.length; i++ ) {				
				byte b = sosiBytes[ i ];
		
				if ( b == SO || b == SI ) {
					continue;
				} else {
					newSosiBytes[ idx ] = b;
					idx++;
				}
			}
			
			if ( idx == sosiBytes.length ) { // SOSI \uBB38\uC790\uAC00 \uD3EC\uD568\uB418\uC9C0 \uC54A\uC740 \uACBD\uC6B0
				sosiTrim = new String( newSosiBytes, charset );
			} else { // SOSI \uBB38\uC790\uAC00 \uD3EC\uD568\uB41C \uACBD\uC6B0
				byte[] newBuffer = new byte[ idx ];
				System.arraycopy( newSosiBytes, 0, newBuffer, 0, idx );
				sosiTrim = new String( newBuffer, charset );
				newBuffer = null;
			}
		} catch ( Exception e ) {
			
		}
		
		sosiBytes = null;
		newSosiBytes = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "sosiTrim", sosiTrim );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void startWithStx (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(startWithStx)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [o] field:0:required startStx
		IDataCursor pipelineCursor = pipeline.getCursor();
		String inString = IDataUtil.getString( pipelineCursor, "inString" );
		pipelineCursor.destroy();
		
		byte STX = 0x02; // Start of Text
		String startStx = "";
		
		if ( STX == inString.charAt( 0 ) ) {
				startStx = "true";
		} else {
				startStx = "false";
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "startStx", startStx );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void stringToDocument (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(stringToDocument)>> ---
		// @sigtype java 3.5
		// [i] field:0:required socketString
		// [i] record:0:required schemaDef
		// [i] field:0:required startOffSet
		// [i] field:0:required charset
		// [i] field:0:required recCount
		// [o] field:0:required errorMsg
		// [o] record:0:required doc
		// [o] record:1:required docList
		// [o] field:0:required nextStartOffSet
		IDataCursor pipelineCursor = pipeline.getCursor();
		String socketString = IDataUtil.getString( pipelineCursor, "socketString" );
		IData schemaDef = IDataUtil.getIData( pipelineCursor, "schemaDef" );
		int startOffSet = IDataUtil.getInt( pipelineCursor, "startOffSet", 0 );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		int recCount = IDataUtil.getInt( pipelineCursor, "recCount", 1 );
		pipelineCursor.destroy();
		
		IData doc = null;
		IDataCursor docCursor = null;
		IData[] docList = null;
		IDataCursor cur = null;
		String curKey = null;
		String keyValue = "";
		String fieldValue = "";
		String errorMsg = "";
		int nextStartOffSet = 0;
		
		IData inIData = IDataFactory.create();
		IDataCursor inputCursor = inIData.getCursor();
		IData outIData = null;
		IDataCursor outputCursor = null;
		
		try {
			if ( recCount == 1 ) {
				doc = IDataFactory.create();
				docCursor = doc.getCursor();
				cur = schemaDef.getCursor();
				
				while ( cur.next() ) {
					curKey = cur.getKey();
					keyValue = ( String )cur.getValue(); // field\uC758 \uAE38\uC774
		
					IDataUtil.put( inputCursor, "inString", socketString );
					IDataUtil.put( inputCursor, "startOffset", startOffSet + "" );
					IDataUtil.put( inputCursor, "length", keyValue );
					IDataUtil.put( inputCursor, "charset", charset );
				
					outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
					outputCursor = outIData.getCursor();
					fieldValue = IDataUtil.getString( outputCursor, "outString" );
					
					docCursor.insertAfter( curKey, fieldValue );
					
					// Next startOffSet
					startOffSet = startOffSet + Integer.parseInt( keyValue );
				}
			} else if ( recCount > 1 ) {
				docList = new IData[ recCount ];
				
				for ( int i = 0; i < recCount; i++ ) {
					doc = IDataFactory.create();
					docCursor = doc.getCursor();
					cur = schemaDef.getCursor();
					
					while ( cur.next() ) {
						curKey = cur.getKey();
						keyValue = ( String )cur.getValue(); // field\uC758 \uAE38\uC774
		
						IDataUtil.put( inputCursor, "inString", socketString );
						IDataUtil.put( inputCursor, "startOffset", startOffSet + "" );
						IDataUtil.put( inputCursor, "length", keyValue );
						IDataUtil.put( inputCursor, "charset", charset );
					
						outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
						outputCursor = outIData.getCursor();
						fieldValue = IDataUtil.getString( outputCursor, "outString" );
						
						docCursor.insertAfter( curKey, fieldValue );
						
						// Next startOffSet
						startOffSet = startOffSet + Integer.parseInt( keyValue );
					}
					
					docList[ i ] = doc;
					
					doc = null;
					docCursor = null;
					cur = null;
				}
				
			}
			
			// Next startOffSet
			nextStartOffSet = startOffSet;
		}  catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		schemaDef = null;
		docCursor = null;
		cur = null;
		inIData = null;
		inputCursor = null;
		outIData = null;
		outputCursor = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "doc", doc );
		IDataUtil.put( pipelineCursor_1, "docList", docList );
		IDataUtil.put( pipelineCursor_1, "nextStartOffSet", nextStartOffSet + "" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void synchronizedCheckDQListener (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(synchronizedCheckDQListener)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [o] field:0:required exists
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName	= IDataUtil.getString( pipelineCursor, "fileName" );
		pipelineCursor.destroy();
		
		String exists = checkDQListener( fileName );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exists", exists );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void throwException (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(throwException)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required message
		IDataCursor pipelineCursor = pipeline.getCursor();
		String message = IDataUtil.getString( pipelineCursor, "message" );
		pipelineCursor.destroy();
		
		String callingService = Service.getCallingService().toString();
		throw new ServiceException( callingService + " : - :" + message );
			
		// --- <<IS-END>> ---

                
	}



	public static final void updateFileContent (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(updateFileContent)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [i] object:0:required srcBytes
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		byte[] srcBytes = ( byte[] )IDataUtil.get( pipelineCursor, "srcBytes" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		File file = null;
		OutputStream os = null;
		
		try {
			file = new File( fileName );
			
			if ( file.isFile() ) {
				if ( file.exists() ) {
					// overwrite OutputStream
					os = new FileOutputStream( file, false );
					os.write( srcBytes );
					os.flush();
				} else {
					errorMsg = fileName + " \uD30C\uC77C\uC774 \uC874\uC7AC\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
				}
			} else {
				errorMsg = fileName + "\uB294(\uC740) \uC62C\uBC14\uB978 \uD30C\uC77C\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.getMessage();
		} finally {
			// Close the output stream....
			try {
				if ( os != null ) {
					os.close();
				}
			} catch ( Exception e ) {
				
			}
		}
		
		file = null;
		os = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void verifySchemaDef (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(verifySchemaDef)>> ---
		// @sigtype java 3.5
		// [i] record:0:required schemaDef
		// [i] field:0:required existVariableField {"false","true"}
		// [o] field:0:required valid
		// [o] field:1:required errorList
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData schemaDef = IDataUtil.getIData( pipelineCursor, "schemaDef" );
		String existVariableField = IDataUtil.getString( pipelineCursor, "existVariableField" );
		pipelineCursor.destroy();
		
		String valid = "";
		String errorMsgs = "";
		String[] errorList = null;
		
		if ( existVariableField == null || existVariableField.equals( "" ) ) {
			existVariableField = "false";
		}
		
		try {
			errorMsgs = schemaDefValidation( schemaDef, existVariableField );
			
			if ( errorMsgs.equals( "" ) ) {
				valid = "true";
			} else {
				valid = "false";
				errorList = errorMsgs.split( "\\|" );
			}
		}  catch ( Exception e ) {
			throw new ServiceException( e.getMessage() );
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "valid", valid );
		IDataUtil.put( pipelineCursor_1, "errorList", errorList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void writeBinaryToFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeBinaryToFile)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [i] field:0:required appendOverwrite {"append","overwrite"}
		// [i] field:0:required encoding
		// [i] object:0:required srcBytes
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		String appendOverwrite = IDataUtil.getString( pipelineCursor, "appendOverwrite" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		byte[] srcBytes = ( byte[] )IDataUtil.get( pipelineCursor, "srcBytes" );
		
		if ( encoding == null ) {
			encoding = "utf-8";
		}
		
		// Separate filename into path and filename
		// This is done so that the directory can be written (if necessary)
		String separator = System.getProperty( "file.separator" );
		int indexSeparator = fileName.lastIndexOf( separator );
		
		if ( indexSeparator == -1 ) {
			// Account for fact that you can use either '\' or '/' in Windows
			indexSeparator = fileName.lastIndexOf( '/' );
		}
		
		String strPathName = fileName.substring( 0, indexSeparator + 1 );
		String strFileName = fileName.substring( indexSeparator + 1 );
				
		File dir = null;
		File file = null;
		OutputStream os = null;
		InputStream is = null;
		
		try {
			dir = new File( strPathName );
			
			// \uB514\uB809\uD1A0\uB9AC \uC0DD\uC131
			if ( !dir.exists() ) {
				dir.mkdirs();
			}
			
			// \uD30C\uC77C \uC0DD\uC131
			file = new File( fileName );
			
			if ( !file.exists() ) {
				file.createNewFile();
			}
			
			// Write the file...
			if ( appendOverwrite != null && appendOverwrite.equals("overwrite") ) {
				// overwrite
				os = new FileOutputStream( file, false );
			} else {
				// append
				os = new FileOutputStream( file, true );
			}
			
			if ( srcBytes != null ) {
				os.write( srcBytes );
			} else {
				is = ( InputStream )IDataUtil.get( pipelineCursor, "srcStream" );
				srcBytes = new byte[ 5120 ];
				int len = 0;
		
				while ( ( len = is.read( srcBytes ) ) > -1 ) {
					os.write( srcBytes, 0, len );
				}
			}
			
			os.flush();
		} catch ( Exception e ) {
			throw new ServiceException( e );
		} finally {
			// Close the output stream....
			try {
				if ( os != null ) {
					os.close();
				}
				
				if ( is != null ) {
					is.close();
				}
			} catch ( Exception e ) {				
			}
		}
		
		pipelineCursor.destroy();
		
		dir = null;
		file = null;
		os = null;
		is = null;
		// --- <<IS-END>> ---

                
	}



	public static final void writeClientSocketLog (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeClientSocketLog)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [i] field:0:required strData
		// [i] field:0:required appendOverwrite {"append","overwrite"}
		// [i] field:0:required encoding
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		String strData = IDataUtil.getString( pipelineCursor, "strData" );
		String appendOverwrite = IDataUtil.getString( pipelineCursor, "appendOverwrite" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();		
		
		if ( encoding == null ) {
			encoding = "UTF-8";
		}
		
		SynchronizedInvoker synchInvoker = new SynchronizedInvoker();
		String errorMsg = synchInvoker.writeClientSocketLog( fileName, strData, appendOverwrite, encoding );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void writeClientTempHistoryLog (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeClientTempHistoryLog)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [i] field:0:required strData
		// [i] field:0:required appendOverwrite {"append","overwrite"}
		// [i] field:0:required encoding
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		String strData = IDataUtil.getString( pipelineCursor, "strData" );
		String appendOverwrite = IDataUtil.getString( pipelineCursor, "appendOverwrite" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();		
		
		if ( encoding == null ) {
			encoding = "UTF-8";
		}
		
		SynchronizedInvoker synchInvoker = new SynchronizedInvoker();
		String errorMsg = synchInvoker.writeClientTempHistoryLog( fileName, strData, appendOverwrite, encoding );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void writeClientTraceLog (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeClientTraceLog)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [i] field:0:required strData
		// [i] field:0:required appendOverwrite {"append","overwrite"}
		// [i] field:0:required encoding
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		String strData = IDataUtil.getString( pipelineCursor, "strData" );
		String appendOverwrite = IDataUtil.getString( pipelineCursor, "appendOverwrite" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();		
		
		if ( encoding == null ) {
			encoding = "UTF-8";
		}
		
		SynchronizedInvoker synchInvoker = new SynchronizedInvoker();
		String errorMsg = synchInvoker.writeClientTraceLog( fileName, strData, appendOverwrite, encoding );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void writeMailNotiLog (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeMailNotiLog)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [i] field:0:required strData
		// [i] field:0:required appendOverwrite {"append","overwrite"}
		// [i] field:0:required encoding
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		String strData = IDataUtil.getString( pipelineCursor, "strData" );
		String appendOverwrite = IDataUtil.getString( pipelineCursor, "appendOverwrite" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();		
		
		if ( encoding == null ) {
			encoding = "UTF-8";
		}
		
		SynchronizedInvoker synchInvoker = new SynchronizedInvoker();
		String errorMsg = synchInvoker.writeMailNotiLog( fileName, strData, appendOverwrite, encoding );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void writeServerSocketLog (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeServerSocketLog)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [i] field:0:required strData
		// [i] field:0:required appendOverwrite {"append","overwrite"}
		// [i] field:0:required encoding
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		String strData = IDataUtil.getString( pipelineCursor, "strData" );
		String appendOverwrite = IDataUtil.getString( pipelineCursor, "appendOverwrite" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();		
		
		if ( encoding == null ) {
			encoding = "UTF-8";
		}
		
		SynchronizedInvoker synchInvoker = new SynchronizedInvoker();
		String errorMsg = synchInvoker.writeServerSocketLog( fileName, strData, appendOverwrite, encoding );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void writeServerTraceLog (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeServerTraceLog)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [i] field:0:required strData
		// [i] field:0:required appendOverwrite {"append","overwrite"}
		// [i] field:0:required encoding
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		String strData = IDataUtil.getString( pipelineCursor, "strData" );
		String appendOverwrite = IDataUtil.getString( pipelineCursor, "appendOverwrite" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();		
		
		if ( encoding == null ) {
			encoding = "UTF-8";
		}
		
		SynchronizedInvoker synchInvoker = new SynchronizedInvoker();
		String errorMsg = synchInvoker.writeServerTraceLog( fileName, strData, appendOverwrite, encoding );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void writeStringToFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeStringToFile)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [i] field:0:required strData
		// [i] field:0:required appendOverwrite {"append","overwrite"}
		// [i] field:0:required encoding
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		String strData = IDataUtil.getString( pipelineCursor, "strData" );
		String appendOverwrite = IDataUtil.getString( pipelineCursor, "appendOverwrite" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();
		
		byte byteData[] = null;
		int byteLen = 0;
		int readLen = 0;
		int totalReadLen = 0;
		int remainLen = 0;
		String errorMsg = "";
		
		if ( encoding == null ) {
			encoding = "UTF-8";
		}
		
		// Separate filename into path and filename
		// This is done so that the directory can be written (if necessary)
		String separator = System.getProperty( "file.separator" );
		int indexSeparator = fileName.lastIndexOf( separator );
		if ( indexSeparator == -1 ) {
			// Account for fact that you can use either '\' or '/' in Windows
			indexSeparator = fileName.lastIndexOf( '/' );
		}
		String strPathName = fileName.substring( 0, indexSeparator + 1 );
		String strFileName = fileName.substring( indexSeparator + 1 );
		
		File dir = null;
		File file = null;
		FileOutputStream fos = null;
		
		try {
			dir = new File( strPathName );
		
			// \uB514\uB809\uD1A0\uB9AC \uC0DD\uC131
			if ( !dir.exists() ) {
				dir.mkdirs();
			}
		
			// \uD30C\uC77C \uC0DD\uC131
			file = new File( fileName );
			
			if ( !file.exists() ) {
				file.createNewFile();
			}
		
			// Write the file...
			if ( appendOverwrite != null && appendOverwrite.equals("overwrite") ) {
				// overwrite
				fos = new FileOutputStream( fileName, false );
			} else {
				// append
				fos = new FileOutputStream( fileName, true );
			}
			
			byteData = strData.getBytes( encoding );
			byteLen = byteData.length;
			
			if ( byteLen <= 5120 ) {
				readLen = byteLen;
			} else {
				readLen = 5120;
			}
			
			while ( true ) {
				fos.write( byteData, totalReadLen, readLen );
				totalReadLen += readLen;
				
				if ( totalReadLen == byteLen ) {
					break;
				} else {
					remainLen = byteLen - totalReadLen;
					
					if ( remainLen <= 5120 ) {
						readLen = remainLen;
					} else {
						readLen = 5120;
					}
				}
			}
			
			fos.flush();
		} catch ( Exception e ) {
			errorMsg = e.getMessage();
		} finally {
			// Close the output stream....
			try {
				if ( fos != null ) {
					fos.close();
				}
			} catch ( Exception e ) {				
			}
		}
		
		dir = null;
		file = null;
		fos = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static DebugLogger debugLogger = new DebugLogger();
	private static final String DEBUG_LEVEL = "4";
	
	public static synchronized String checkDQListener( String fileName ) {
		String exists = "";
		File file = null;
		
		try {
			file = new File( fileName );
			
			if ( file.exists() ) {
					exists = "true";
			} else {				
				file.createNewFile();
				exists = "false";
			}
		} catch ( Exception e ) {
			exists = "false";
		}
		
		file = null;
		
		return exists;
	}
	
	public static String makeIDataString( IData iData ) {
		String curKey = null;
		Object obj = null;
		String keyValue = "";
		IData[] iDataList = null;
		IDataCursor cur = iData.getCursor();
		StringBuffer strBuffer = new StringBuffer();
		String iDataString = "";		
		
		try {
			while ( cur.next() ) {
				curKey = cur.getKey();
				obj = cur.getValue();
	
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) {	// 1. obj is String
					keyValue = ( String )obj;
					strBuffer.append( keyValue );
				} else if ( obj instanceof IData[] ) {
					iDataList = ( IData[] )obj;
					
					if ( iDataList == null ) {
						continue;
					}
					
					for ( int i = 0; i < iDataList.length; i++ ) {
						if ( iDataList[ i ] == null ) {
							continue;
						}
						
						keyValue = makeIDataString( iDataList[ i ] );
						strBuffer.append( keyValue );
					}
				}
			}
			
			iDataString = strBuffer.toString();
		} catch ( Exception e ) {
			
		}
		
		cur.destroy();
		iDataList = null;
		
		return iDataString;
	}
	
	public static String[] makeIDataString_ApplySchema( IData iData, String[] schemaList, int schemaIndex, String charset ) {
		String curKey = null;
		Object obj = null;
		String keyValue = "";
		IData[] iDataList = null;
		IDataCursor cur = iData.getCursor();
		StringBuffer strBuffer = new StringBuffer();
		String[] iDataString = new String[ 3 ];
		String[] token = null;
		String fieldLength = "";
		String paddingChar = "";
		String paddingType = "";
		String byteLength = "";
		int fieldLen = 0;
		int byteLen = 0;
		int paddingLength = 0;
		String paddingString = "";
		String[] strIndex = null;
		String errorMsg = "";
		
		IData inIData = IDataFactory.create();
		IDataCursor inputCursor = inIData.getCursor();
		IData outIData = null;
		IDataCursor outputCursor = null;
		
		try {
			while ( cur.next() ) {
				curKey = cur.getKey();
				obj = cur.getValue();
	
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) {	// 1. obj is String
					keyValue = ( String )obj;
					
					token = schemaList[ schemaIndex ].split( "/" );
					fieldLength = token[ 0 ];
					paddingChar = token[ 1 ];
					paddingType = token[ 2 ];
					
					try {
						// fieldLength\uC5D0 \uC2E4\uC81C\uB85C Field\uC758 \uAE38\uC774 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uACE0\uC815\uAE38\uC774\uC778 \uACBD\uC6B0
						fieldLen = Integer.parseInt( fieldLength );
					} catch ( Exception ie ) {
						// fieldLength\uC5D0 Field\uC758 \uAE38\uC774 \uC815\uBCF4\uB97C \uD3EC\uD568\uD558\uB294 Field\uBA85 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uAC00\uBCC0\uAE38\uC774\uC778 \uACBD\uC6B0
						fieldLength = IDataUtil.getString( cur, fieldLength ).trim();
						fieldLen = Integer.parseInt( fieldLength );
						
						// IDataUtil.getString \uC2E4\uD589 \uC2DC Cursor \uC704\uCE58\uAC00 \uC774\uB3D9\uD558\uBBC0\uB85C Cursor\uB97C \uC6D0\uB798 \uC704\uCE58\uB85C \uB2E4\uC2DC \uC774\uB3D9\uD55C\uB2E4.
						IDataUtil.getString( cur, curKey );
					}
					
					IDataUtil.put( inputCursor, "content", keyValue );
					IDataUtil.put( inputCursor, "charset", charset );
					
					outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "getByteLength", inIData );
					outputCursor = outIData.getCursor();
					byteLength = IDataUtil.getString( outputCursor, "byteLength" );
					byteLen = Integer.parseInt( byteLength );
					
					if ( fieldLen == byteLen ) {
						strBuffer.append( keyValue );
					} else if ( fieldLen < byteLen ) {
						IDataUtil.put( inputCursor, "inString", keyValue );
						IDataUtil.put( inputCursor, "startOffset", "0" );
						IDataUtil.put( inputCursor, "length", fieldLength );
						IDataUtil.put( inputCursor, "charset", charset );
						
						outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
						outputCursor = outIData.getCursor();
						keyValue = IDataUtil.getString( outputCursor, "outString" );
						strBuffer.append( keyValue );
					} else if ( fieldLen > byteLen ) {
						paddingLength = fieldLen - byteLen;
						
						for ( int i = 0; i < paddingLength; i++ ) {
							paddingString += paddingChar;
						}
						
						if ( paddingType.equals( "LP" ) ) {							
							keyValue = paddingString + keyValue;						
						} else if ( paddingType.equals( "RP" ) ) {							
							keyValue = keyValue + paddingString;						
						}
						
						strBuffer.append( keyValue );
						
						paddingLength = 0;
						paddingString = "";
					}
					
					schemaIndex++;
				} else if ( obj instanceof IData[] ) {
					iDataList = ( IData[] )obj;
					
					if ( iDataList == null ) {
						continue;
					}
					
					for ( int i = 0; i < iDataList.length; i++ ) {
						if ( iDataList[ i ] == null ) {
							continue;
						}
						
						strIndex = makeIDataString_ApplySchema( iDataList[ i ], schemaList, schemaIndex, charset );
						keyValue = strIndex[ 0 ];
						strBuffer.append( keyValue );
					}
					
					schemaIndex = Integer.parseInt( strIndex[ 1 ] );
				}
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		cur.destroy();
		iDataList = null;
		
		iDataString[ 0 ] = strBuffer.toString();
		iDataString[ 1 ] = schemaIndex + "";
		iDataString[ 2 ] = errorMsg;
		
		return iDataString;
	}
	
	public static String[] makeIDataString_ApplySchema2( IData iData, String[] schemaList, int schemaIndex, String charset, String singleArray ) {
		String curKey = null;
		Object obj = null;
		String keyValue = "";
		IData[] iDataList = null;
		IDataCursor cur = iData.getCursor();
		StringBuffer strBuffer = new StringBuffer();
		String[] iDataString = new String[ 3 ];
		String[] token = null;
		String schemaSingleArray = "";
		String fieldName = "";
		String fieldLength = "";
		String paddingChar = "";
		String paddingType = "";
		String byteLength = "";
		int fieldLen = 0;
		int byteLen = 0;
		int paddingLength = 0;
		String paddingString = "";
		String[] strIndex = null;
		String errorMsg = "";
		
		IData inIData = IDataFactory.create();
		IDataCursor inputCursor = inIData.getCursor();
		IData outIData = null;
		IDataCursor outputCursor = null;
		
		try {
			while ( cur.next() ) {
				curKey = cur.getKey();
				obj = cur.getValue();
	
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) {	// 1. obj is String
					keyValue = ( String )obj;
					
					token = schemaList[ schemaIndex ].split( "/" );
					schemaSingleArray = token[ 0 ];
					fieldName = token[ 1 ];
					fieldLength = token[ 2 ];
					paddingChar = token[ 3 ];
					paddingType = token[ 4 ];
					
					// Schema \uC815\uC758\uC5D0\uB294 Array\uC5D0 \uB300\uD55C \uC815\uC758\uAC00 \uC874\uC7AC\uD558\uC9C0\uB9CC iData\uC5D0\uB294 Array Record Count\uAC00 0 \uC774\uC5B4\uC11C Array\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0\uC5D0 \uB300\uD574\uC11C \uACE0\uB824\uD574\uC57C \uD55C\uB2E4.					
					if ( singleArray.equals( "S" ) && schemaSingleArray.equals( "A" ) ) {
						// Single Record\uC758 \uD544\uB4DC\uC5D0 \uB300\uD574\uC11C \uCC98\uB9AC\uD558\uACE0 \uC788\uB294\uB370 Schema \uC815\uC758\uB294 Array\uC5D0 \uB300\uD55C \uAC12\uC774\uBA74 Array Record Count\uAC00 0 \uC774\uC5B4\uC11C Array\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uACE0					
						// \uB2E4\uC74C Single Record\uC758 \uD544\uB4DC\uAC00 \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0\uC774\uB2E4.
						
						while( true ) {
							schemaIndex++;
							token = schemaList[ schemaIndex ].split( "/" );
							schemaSingleArray = token[ 0 ];
							fieldName = token[ 1 ];
							fieldLength = token[ 2 ];
							paddingChar = token[ 3 ];
							paddingType = token[ 4 ];
							
							if ( schemaSingleArray.equals( "S" ) && curKey.equals( fieldName ) ) {
								break;
							}
						}
					} else if ( singleArray.equals( "A" ) && !curKey.equals( fieldName ) ) {
						// Array Record\uC758 \uD544\uB4DC\uC5D0 \uB300\uD574\uC11C \uCC98\uB9AC\uD558\uACE0 \uC788\uB294\uB370  Schema \uC815\uC758\uB294 Array \uD558\uC704\uC5D0 \uB610 \uB2E4\uB978 Array\uAC00 \uC874\uC7AC\uD558\uB294 \uAD6C\uC870\uC778\uB370 \uD558\uC704 Array Record Count\uAC00 0 \uC774\uC5B4\uC11C \uD558\uC704 Array\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uACE0					
						// \uB2E4\uC74C Array Record\uC758 \uD544\uB4DC\uAC00 \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0\uC774\uB2E4.
						while( true ) {
							schemaIndex++;
							token = schemaList[ schemaIndex ].split( "/" );
							schemaSingleArray = token[ 0 ];
							fieldName = token[ 1 ];
							fieldLength = token[ 2 ];
							paddingChar = token[ 3 ];
							paddingType = token[ 4 ];
							
							if ( schemaSingleArray.equals( "A" ) && curKey.equals( fieldName ) ) {
								break;
							}
						}
					}
					
					try {
						// fieldLength\uC5D0 \uC2E4\uC81C\uB85C Field\uC758 \uAE38\uC774 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uACE0\uC815\uAE38\uC774\uC778 \uACBD\uC6B0
						fieldLen = Integer.parseInt( fieldLength );
					} catch ( Exception ie ) {
						// fieldLength\uC5D0 Field\uC758 \uAE38\uC774 \uC815\uBCF4\uB97C \uD3EC\uD568\uD558\uB294 Field\uBA85 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uAC00\uBCC0\uAE38\uC774\uC778 \uACBD\uC6B0
						fieldLength = IDataUtil.getString( cur, fieldLength ).trim();
						fieldLen = Integer.parseInt( fieldLength );
						
						// IDataUtil.getString \uC2E4\uD589 \uC2DC Cursor \uC704\uCE58\uAC00 \uC774\uB3D9\uD558\uBBC0\uB85C Cursor\uB97C \uC6D0\uB798 \uC704\uCE58\uB85C \uB2E4\uC2DC \uC774\uB3D9\uD55C\uB2E4.
						IDataUtil.getString( cur, curKey );
					}
					
					IDataUtil.put( inputCursor, "content", keyValue );
					IDataUtil.put( inputCursor, "charset", charset );
					
					outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "getByteLength", inIData );
					outputCursor = outIData.getCursor();
					byteLength = IDataUtil.getString( outputCursor, "byteLength" );
					byteLen = Integer.parseInt( byteLength );
					
					if ( fieldLen == byteLen ) {
						strBuffer.append( keyValue );
					} else if ( fieldLen < byteLen ) {
						IDataUtil.put( inputCursor, "inString", keyValue );
						IDataUtil.put( inputCursor, "startOffset", "0" );
						IDataUtil.put( inputCursor, "length", fieldLength );
						IDataUtil.put( inputCursor, "charset", charset );
						
						outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
						outputCursor = outIData.getCursor();
						keyValue = IDataUtil.getString( outputCursor, "outString" );
						strBuffer.append( keyValue );
					} else if ( fieldLen > byteLen ) {
						paddingLength = fieldLen - byteLen;
						
						for ( int i = 0; i < paddingLength; i++ ) {
							paddingString += paddingChar;
						}
						
						if ( paddingType.equals( "LP" ) ) {							
							keyValue = paddingString + keyValue;						
						} else if ( paddingType.equals( "RP" ) ) {							
							keyValue = keyValue + paddingString;						
						}
						
						strBuffer.append( keyValue );
						
						paddingLength = 0;
						paddingString = "";
					}
					
					schemaIndex++;
				} else if ( obj instanceof IData[] ) {
					iDataList = ( IData[] )obj;
					
					if ( iDataList == null ) {
						continue;
					}
					
					for ( int i = 0; i < iDataList.length; i++ ) {
						if ( iDataList[ i ] == null ) {
							continue;
						}
						
						strIndex = makeIDataString_ApplySchema2( iDataList[ i ], schemaList, schemaIndex, charset, "A" );
						keyValue = strIndex[ 0 ];
						strBuffer.append( keyValue );
					}
					
					schemaIndex = Integer.parseInt( strIndex[ 1 ] );
				}
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		cur.destroy();
		iDataList = null;
		
		iDataString[ 0 ] = strBuffer.toString();
		iDataString[ 1 ] = schemaIndex + "";
		iDataString[ 2 ] = errorMsg;
		
		return iDataString;
	}
	
	public static IData[] makeStringIData_ApplySchema( String socketString, int byteLength, IData schemaDef, int startOffSet, String[] recCountFieldName, int recIndex, String charset ) {
		IDataCursor cur = schemaDef.getCursor(); // Schema \uC815\uC758 IData
		String curKey = null;
		Object obj = null;
		String keyValue = ""; // Field\uC5D0 \uB300\uD55C Schema \uC815\uC758 String ==> Field Length/Padding String/Left Padding, Right Padding \uAD6C\uBD84
		String fieldValue = "";
		String[] token = null;
		String fieldLength = "";
		IData[] recList = null;
		String recCountValue = null;
		int fieldLen = 0;
		int recCount = 0; // Record \uAC2F\uC218
		
		IData[] docInfo = new IData[ 4 ];
		IData doc = IDataFactory.create();
		IDataCursor docCursor = doc.getCursor();
		IData nextStart = IDataFactory.create();
		IDataCursor nextCursor = nextStart.getCursor();
		IData error = IDataFactory.create();
		IDataCursor errorCursor = error.getCursor();
		IData recCountIndex = IDataFactory.create();
		IDataCursor recCountCursor = recCountIndex.getCursor();
		int tempRecIndex = 0;
		String errorMsg = "";
		
		IData[] docList = null;
		IData[] tempDocInfo = null;
		IDataCursor tempCursor = null;
		
		IData inIData = IDataFactory.create();
		IDataCursor inputCursor = inIData.getCursor();
		IData outIData = null;
		IDataCursor outputCursor = null;
		
		try {
			while ( cur.next() ) {
				curKey = cur.getKey();
				obj = cur.getValue();
	
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) { // obj is String
					keyValue = ( String )obj;
					
					token = keyValue.split( "/" );
					fieldLength = token[ 0 ];
					
					try {
						// fieldLength\uC5D0 \uC2E4\uC81C\uB85C Field\uC758 \uAE38\uC774 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uACE0\uC815\uAE38\uC774\uC778 \uACBD\uC6B0
						fieldLen = Integer.parseInt( fieldLength );
					} catch ( Exception ie ) {
						// fieldLength\uC5D0 Field\uC758 \uAE38\uC774 \uC815\uBCF4\uB97C \uD3EC\uD568\uD558\uB294 Field\uBA85 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uAC00\uBCC0\uAE38\uC774\uC778 \uACBD\uC6B0
						fieldLength = IDataUtil.getString( docCursor, fieldLength ).trim();
						fieldLen = Integer.parseInt( fieldLength );
						
						// IDataUtil.getString \uC2E4\uD589 \uC2DC  Cursor \uC704\uCE58\uAC00 \uC774\uB3D9\uD588\uC744 \uC218 \uC788\uAE30 \uB54C\uBB38\uC5D0 \uB2E4\uC2DC \uB9C8\uC9C0\uB9C9 \uC704\uCE58\uB85C Cursor\uB97C \uC774\uB3D9\uC2DC\uD0A8\uB2E4.
						docCursor.last();
					}
	
					IDataUtil.put( inputCursor, "inString", socketString );
					IDataUtil.put( inputCursor, "startOffset", startOffSet + "" );
					IDataUtil.put( inputCursor, "length", fieldLength );
					IDataUtil.put( inputCursor, "charset", charset );
				
					outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
					outputCursor = outIData.getCursor();
					fieldValue = IDataUtil.getString( outputCursor, "outString" );
					
					docCursor.insertAfter( curKey, fieldValue );
					
					// Next startOffSet
					startOffSet = startOffSet + fieldLen;
					
					if ( startOffSet >= byteLength ) {
						break;
					}
				} else if ( obj instanceof IData[] ) { // obj is IData[]
					recList = ( IData[] )obj;
					
					if ( recList == null ) {
						continue;
					}
					
					// Record \uAC2F\uC218 \uCD94\uCD9C
					if ( recCountFieldName == null || recCountFieldName.length == 0 ) {
						// \uD558\uB098\uC758 Array\uB9CC \uC788\uB294 \uD3EC\uB9F7\uC774\uBA74\uC11C \uAC00\uBCC0\uAE38\uC774\uC774\uACE0 Array Count\uB97C \uD3EC\uD568\uD558\uB294 \uD544\uB4DC\uAC00 \uC5C6\uB294 \uC804\uBB38\uC778 \uACBD\uC6B0 Array Count\uB97C \uAD6C\uD55C\uB2E4.
						recCount = getArrayCount( socketString, schemaDef, charset );
					} else {					
						recCountValue = IDataUtil.getString( docCursor, recCountFieldName[ recIndex ] );
					
						if ( recCountValue == null ) {
							// \uB808\uCF54\uB4DC \uAC2F\uC218\uAC00 \uD3EC\uD568\uB41C Field\uC758 Name\uC774 \uC544\uB2C8\uACE0 \uB808\uCF54\uB4DC\uC758 \uAC2F\uC218\uB97C \uC9C1\uC811 \uC804\uB2EC \uBC1B\uC740 \uACBD\uC6B0 ==> \uACE0\uC815\uAE38\uC774
							recCount = Integer.parseInt( recCountFieldName[ recIndex ].trim() );
						} else {
							// \uB808\uCF54\uB4DC \uAC2F\uC218\uAC00 \uD3EC\uD568\uB41C Field\uC758 Name\uC744 \uC804\uB2EC \uBC1B\uC740 \uACBD\uC6B0 ==> \uAC00\uBCC0\uAE38\uC774
							recCount = Integer.parseInt( recCountValue.trim() );
						}
					}
					
					// Record \uAC2F\uC218 \uCD94\uCD9C\uD560 \uB54C Cursor \uC704\uCE58\uAC00 \uC774\uB3D9\uD588\uC744 \uC218 \uC788\uAE30 \uB54C\uBB38\uC5D0 \uB2E4\uC2DC \uB9C8\uC9C0\uB9C9 \uC704\uCE58\uB85C Cursor\uB97C \uC774\uB3D9\uC2DC\uD0A8\uB2E4.
					docCursor.last();
					
					if ( recCount == 0 ) {
						// recCountFieldName\uC758 Index \uC911\uAC00
						recIndex += 1;
					} else {
						docList = new IData[ recCount ];
					
						for ( int i = 0; i < recCount; i++ ) {
							tempDocInfo = makeStringIData_ApplySchema( socketString, byteLength, recList[ 0 ], startOffSet, recCountFieldName, recIndex + 1, charset );
							tempCursor = tempDocInfo[ 1 ].getCursor();
							startOffSet = IDataUtil.getInt( tempCursor, "nextStartOffSet", 0 );
							
							if ( i == 0 ) {
								tempCursor.destroy();
								tempCursor = tempDocInfo[ 2 ].getCursor();
								tempRecIndex = IDataUtil.getInt( tempCursor, "recIndex", 0 );
							}
							
							docList[ i ] = tempDocInfo[ 0 ];
						
							tempCursor.destroy();
							tempDocInfo = null;
						}
						
						// recCountFieldName\uC758 Index \uC911\uAC00
						recIndex = tempRecIndex;
						docCursor.insertAfter( curKey, docList );
					}
					
					if ( startOffSet >= byteLength ) {
						break;
					}
				}
			}
			
			// Next startOffSet
			nextCursor.insertAfter( "nextStartOffSet", startOffSet + "" );
			
			// recCountFieldName Index
			recCountCursor.insertAfter( "recIndex", recIndex + "" );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		errorCursor.insertAfter( "errorMsg", errorMsg );
		
		cur.destroy();
		docCursor.destroy();
		inputCursor.destroy();
		nextCursor.destroy();
		errorCursor.destroy();
		recCountCursor.destroy();
		
		// Single Record\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uACE0 Array\uB9CC \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0\uC5D0\uB294 outputCursor\uAC00 null \uC774\uB2E4.
		if ( outputCursor != null ) {
			outputCursor.destroy();
		}
		
		obj = null;
		recList = null;
		docList = null;
		inIData = null;
		outIData = null;
		
		docInfo[ 0 ] = doc;
		docInfo[ 1 ] = nextStart;
		docInfo[ 2 ] = recCountIndex;
		docInfo[ 3 ] = error;
		
		return docInfo;
	}
	
	public static int getArrayCount( String socketString, IData schemaDef, String charset ) {		
		// \uD558\uB098\uC758 Array\uB9CC \uC788\uB294 \uD3EC\uB9F7\uC774\uBA74\uC11C \uAC00\uBCC0\uAE38\uC774\uC774\uACE0 Array Count\uB97C \uD3EC\uD568\uD558\uB294 \uD544\uB4DC\uAC00 \uC5C6\uB294 \uC804\uBB38\uC778 \uACBD\uC6B0 Array Count\uB97C \uAD6C\uD55C\uB2E4.
		IData inIData = IDataFactory.create();
		IDataCursor inputCursor = inIData.getCursor();
		IData outIData = null;
		IDataCursor outputCursor = null;
		String recLengthSum = "";
		String docLength = "";
		int arrayCount = 0;
		
		try {
			// \uD55C \uB808\uCF54\uB4DC\uC758 \uD544\uB4DC\uAE38\uC774 \uD569 \uAD6C\uD558\uAE30
			IDataUtil.put( inputCursor, "schemaDef", schemaDef );
			IDataUtil.put( inputCursor, "startIndex", "0" );
			
			outIData = Service.doInvoke( "JSocketAdapter.UTIL", "getFieldsLengthSum", inIData );
			outputCursor = outIData.getCursor();
			recLengthSum = IDataUtil.getString( outputCursor, "lengthSum" );
			
			outputCursor.destroy();
			outIData = null;
			
			// \uC804\uBB38 \uC804\uCCB4 \uAE38\uC774 \uAD6C\uD558\uAE30
			inputCursor.destroy();
			inIData = null;
			inIData = IDataFactory.create();
			inputCursor = inIData.getCursor();
			
			IDataUtil.put( inputCursor, "content", socketString );
			IDataUtil.put( inputCursor, "charset", charset );
			
			outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "getByteLength", inIData );
			outputCursor = outIData.getCursor();
			docLength = IDataUtil.getString( outputCursor, "byteLength" );
			
			// Array Count \uAD6C\uD558\uAE30
			arrayCount = Integer.parseInt( docLength ) / Integer.parseInt( recLengthSum );
		} catch ( Exception e ) {
			
		}
		
		return arrayCount;
	}
	
	public static String makeSchemaList( IData schemaDef ) {
		IDataCursor cur = schemaDef.getCursor(); // Schema \uC815\uC758 IData
		Object obj = null;
		String keyValue = ""; // Field\uC5D0 \uB300\uD55C Schema \uC815\uC758 String ==> Field Length/Padding String/Left Padding, Right Padding \uAD6C\uBD84
		IData[] recList = null;
		StringBuffer strBuffer = new StringBuffer();
		String schema = "";
		String schemaList = "";		
		
		try {
			while ( cur.next() ) {
				obj = cur.getValue();
	
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) { // obj is String
					keyValue = ( String )obj;
					
					if ( schemaList.equals( "" ) ) {
						strBuffer.append( keyValue );
						schemaList = "NE"; // Not Empty
					} else {
						strBuffer.append( "|" + keyValue );
					}
				} else if ( obj instanceof IData ) { // obj is IData
					schema = makeSchemaList( ( IData )obj );
					
					if ( schemaList.equals( "" ) ) {
						strBuffer.append( schema );
						schemaList = "NE"; // Not Empty
					} else {
						strBuffer.append( "|" + schema );
					}
				} else if ( obj instanceof IData[] ) { // obj is IData[]
					recList = ( IData[] )obj;
					
					if ( recList == null ) {
						continue;
					}
					
					schema = makeSchemaList( recList[ 0 ] );
					
					if ( schemaList.equals( "" ) ) {
						strBuffer.append( schema );
						schemaList = "NE"; // Not Empty
					} else {
						strBuffer.append( "|" + schema );
					}
				}
			}
			
			schemaList = strBuffer.toString();
		} catch ( Exception e ) {
			
		}		
		
		return schemaList;
	}
	
	public static String makeSchemaList2( IData schemaDef, String singleArray ) {
		IDataCursor cur = schemaDef.getCursor(); // Schema \uC815\uC758 IData
		String curKey = null;
		Object obj = null;
		String keyValue = ""; // Field\uC5D0 \uB300\uD55C Schema \uC815\uC758 String ==> Field Length/Padding String/Left Padding, Right Padding \uAD6C\uBD84
		IData[] recList = null;
		StringBuffer strBuffer = new StringBuffer();
		String schema = "";
		String schemaList = "";
		// singleArray ==> S : Single Record\uC758 \uD544\uB4DC, A : Array Record\uC758 \uD544\uB4DC
		
		try {
			while ( cur.next() ) {
				curKey = cur.getKey();
				obj = cur.getValue();
	
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) { // obj is String
					keyValue = ( String )obj;
					keyValue = singleArray + "/" + curKey + "/" + keyValue;
					
					if ( schemaList.equals( "" ) ) {
						strBuffer.append( keyValue );
						schemaList = "NE"; // Not Empty
					} else {
						strBuffer.append( "|" + keyValue );
					}
				} else if ( obj instanceof IData[] ) { // obj is IData[]
					recList = ( IData[] )obj;
					
					if ( recList == null ) {
						continue;
					}
					
					schema = makeSchemaList2( recList[ 0 ], "A" );
					
					if ( schemaList.equals( "" ) ) {
						strBuffer.append( schema );
						schemaList = "NE"; // Not Empty
					} else {
						strBuffer.append( "|" + schema );
					}
				}
			}
			
			schemaList = strBuffer.toString();
		} catch ( Exception e ) {
			
		}		
		
		return schemaList;
	}
	
	public static String schemaDefValidation( IData schemaDef, String existVariableField ) {
		IDataCursor cur = schemaDef.getCursor(); // Schema \uC815\uC758 IData
		Object obj = null;
		String curKey = "";
		// Field\uC5D0 \uB300\uD55C Schema \uC815\uC758 String
		// Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0  : Field Length/Padding String/Left Padding, Right Padding \uAD6C\uBD84/Field Desc
		// \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0 : Data Type/Field Length/Array Count/Field Desc
		// \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0 : Field Length/Padding String/Left Padding, Right Padding \uAD6C\uBD84/Field Desc/Data Type/Field Length/Array Count
		// Socket To REST API \uBC29\uC2DD, REST API To Socket \uBC29\uC2DD, Socket To Socket \uBC29\uC2DD\uC774\uBA74\uC11C Source, Target \uD3EC\uB9F7\uC774 \uC11C\uB85C \uB2E4\uB978 \uACBD\uC6B0 : Field Length/Padding String/Left Padding, Right Padding \uAD6C\uBD84/Field Desc/Data Type/Length Calculation Start/Field Type
		String keyValue = "";
		IData[] recList = null;
		StringBuffer strBuffer = new StringBuffer();
		String schema = "";
		String errorMsg = "";
		String errorList = "";
		String[] token = null;
		String fieldLength = "";
		String paddingChar = "";
		String paddingType = "";
		String arrayCount = "";
		int fieldLen = 0;
		String schemaDefType = "";
		String fieldCalStart = "";
		String[] fieldCalStartAttrs = null;
		int startIndex = 0;
		int lengthSize = 0;
		String fieldType = "";
		String[] fieldTypeAttrs = null;
		// EN : Endian No(Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0), ER : Endian Receive(\uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0), ES : Endian Send(\uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0)
		
		try {
			while ( cur.next() ) {
				curKey = cur.getKey();
				obj = cur.getValue();
	
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) { // obj is String
					keyValue = ( String )obj;
					token = keyValue.split( "/" );
					
					if ( token.length >= 3 ) {
						// \uCD5C\uCD08\uC5D0 \uD55C \uBC88\uB9CC \uC218\uD589
						if ( schemaDefType.equals( "" ) ) {
							if ( token.length == 7 ) {
								try {
									Integer.parseInt( token[ 6 ] );
									// \uC77C\uACF1\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790(Array Count)\uC778 \uACBD\uC6B0 ==> \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
									schemaDefType = "ES";
								} catch ( Exception ne ) {
									// \uC77C\uACF1\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790\uAC00 \uC544\uB2CC(Field Type) \uACBD\uC6B0 ==> Socket To REST API \uBC29\uC2DD, REST API To Socket \uBC29\uC2DD, Socket To Socket \uBC29\uC2DD\uC774\uBA74\uC11C Source, Target \uD3EC\uB9F7\uC774 \uC11C\uB85C \uB2E4\uB978 \uACBD\uC6B0
									schemaDefType = "EN";
								}
							} else if ( token.length <= 4 ) {
								try {
									Integer.parseInt( token[ 0 ] );
									// \uCCAB\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790(\uD544\uB4DC\uC758 \uAE38\uC774)\uC778 \uACBD\uC6B0 ==> Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0
									schemaDefType = "EN";
								} catch ( Exception ne ) {
									// \uCCAB\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790\uAC00 \uC544\uB2CC(Data Type) \uACBD\uC6B0 ==> \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
									schemaDefType = "ER";
								}
							}
						}
						
						if ( schemaDefType.equals( "EN" ) || schemaDefType.equals( "ES" ) ) {
							fieldLength = token[ 0 ];
							paddingChar = token[ 1 ];
							paddingType = token[ 2 ];
						
							// \uAC00\uBCC0\uAE38\uC774 \uD544\uB4DC\uAC00 \uD3EC\uD568\uB418\uC5B4 \uC788\uC9C0 \uC54A\uC740 \uACBD\uC6B0\uC5D0\uB9CC Field Length\uAC00 \uC22B\uC790 \uD0C0\uC785\uC778\uC9C0 \uC544\uB2CC\uC9C0 \uCCB4\uD06C\uD55C\uB2E4.
							if ( existVariableField.equals( "false" ) ) {
								try {
									fieldLen = Integer.parseInt( fieldLength );
								} catch ( Exception fe ) {
									errorMsg = "Field(" + curKey + ")\uC5D0 \uB300\uD55C Field Length\uAC00 \uC22B\uC790 \uD0C0\uC785\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
							
									if ( errorList.equals( "" ) ) {
										strBuffer.append( errorMsg );
										errorList = "NE";
									} else {
										strBuffer.append( "|" + errorMsg );
									}
								}
							}
						
							if ( paddingChar.length() != 1 ) {
								errorMsg = "Field(" + curKey + ")\uC5D0 \uB300\uD55C Padding String\uC774 1byte\uAC00 \uC544\uB2D9\uB2C8\uB2E4.";
							
								if ( errorList.equals( "" ) ) {
									strBuffer.append( errorMsg );
									errorList = "NE";
								} else {
									strBuffer.append( "|" + errorMsg );
								}
							}
						
							if ( !paddingType.equals( "LP" ) && !paddingType.equals( "RP" ) ) {
								errorMsg = "Field(" + curKey + ")\uC5D0 \uB300\uD55C Left Padding, Right Padding \uAD6C\uBD84\uC774 LP \uB610\uB294 RP\uAC00 \uC544\uB2D9\uB2C8\uB2E4.";
							
								if ( errorList.equals( "" ) ) {
									strBuffer.append( errorMsg );
									errorList = "NE";
								} else {
									strBuffer.append( "|" + errorMsg );
								}
							}
						}
						
						if ( schemaDefType.equals( "EN" ) && token.length == 7 ) {
							// Socket To REST API \uBC29\uC2DD, REST API To Socket \uBC29\uC2DD, Socket To Socket \uBC29\uC2DD\uC774\uBA74\uC11C Source, Target \uD3EC\uB9F7\uC774 \uC11C\uB85C \uB2E4\uB978 \uACBD\uC6B0
							fieldCalStart = token[ 5 ];
							fieldType = token[ 6 ];
							
							// Length Calculation Start \uD56D\uBAA9 \uAC80\uC0AC
							if ( fieldCalStart.equals( "" ) || fieldCalStart.equals( "N" ) ) {
								// \uC815\uC0C1
							} else {
								if ( fieldCalStart.startsWith( "Y$" ) ) {
									fieldCalStartAttrs = fieldCalStart.split( "\\$" );
									
									if ( fieldCalStartAttrs.length == 3 ) {
										try {
											startIndex = Integer.parseInt( fieldCalStartAttrs[ 1 ] );
											// \uC815\uC0C1
										} catch ( Exception fe ) {
											// \uBE44\uC815\uC0C1
											errorMsg = "Field(" + curKey + ")\uC5D0 \uB300\uD55C Length Calculation Start \uC124\uC815\uC758 \uB450\uBC88\uC9F8 \uD56D\uBAA9\uC774(Doc Length Index) \uC22B\uC790 \uD0C0\uC785\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
										
											if ( errorList.equals( "" ) ) {
												strBuffer.append( errorMsg );
												errorList = "NE";
											} else {
												strBuffer.append( "|" + errorMsg );
											}
										}
										
										try {
											lengthSize = Integer.parseInt( fieldCalStartAttrs[ 2 ] );
											// \uC815\uC0C1
										} catch ( Exception fe ) {
											// \uBE44\uC815\uC0C1
											errorMsg = "Field(" + curKey + ")\uC5D0 \uB300\uD55C Length Calculation Start \uC124\uC815\uC758 \uC138\uBC88\uC9F8 \uD56D\uBAA9\uC774(Field Length) \uC22B\uC790 \uD0C0\uC785\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
										
											if ( errorList.equals( "" ) ) {
												strBuffer.append( errorMsg );
												errorList = "NE";
											} else {
												strBuffer.append( "|" + errorMsg );
											}
										}
									} else {
										// \uBE44\uC815\uC0C1
										errorMsg = "Field(" + curKey + ")\uC5D0 \uB300\uD55C Length Calculation Start\uC758 \uD3EC\uB9F7\uC774 \uC62C\uBC14\uB974\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
										
										if ( errorList.equals( "" ) ) {
											strBuffer.append( errorMsg );
											errorList = "NE";
										} else {
											strBuffer.append( "|" + errorMsg );
										}
									}
								} else {
									// \uBE44\uC815\uC0C1
									errorMsg = "Field(" + curKey + ")\uC5D0 \uB300\uD55C Length Calculation Start\uC758 \uD3EC\uB9F7\uC774 \uC62C\uBC14\uB974\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
									
									if ( errorList.equals( "" ) ) {
										strBuffer.append( errorMsg );
										errorList = "NE";
									} else {
										strBuffer.append( "|" + errorMsg );
									}
								}
							}
							
							// Field Type \uD56D\uBAA9 \uAC80\uC0AC
							if ( fieldType.equals( "ST" ) || fieldType.equals( "OS" ) ) {
								// \uC815\uC0C1
							} else {
								if ( fieldType.startsWith( "OT$" ) ) {
									fieldTypeAttrs = fieldType.split( "\\$" );
									
									if ( fieldTypeAttrs.length == 3 ) {										
										if ( fieldTypeAttrs[ 1 ].equals( "FV" ) || fieldTypeAttrs[ 1 ].equals( "VV" ) ) {
											// \uC815\uC0C1
										} else {
											// \uBE44\uC815\uC0C1
											errorMsg = "Field(" + curKey + ")\uC5D0 \uB300\uD55C Field Type \uC124\uC815\uC758 \uB450\uBC88\uC9F8 \uD56D\uBAA9\uC740(Value Type) FV \uB610\uB294 VV \uC774\uC5B4\uC57C \uD569\uB2C8\uB2E4.";
											
											if ( errorList.equals( "" ) ) {
												strBuffer.append( errorMsg );
												errorList = "NE";
											} else {
												strBuffer.append( "|" + errorMsg );
											}
										}										
									} else {
										// \uBE44\uC815\uC0C1
										errorMsg = "Field(" + curKey + ")\uC5D0 \uB300\uD55C Field Type\uC758 \uD3EC\uB9F7\uC774 \uC62C\uBC14\uB974\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
										
										if ( errorList.equals( "" ) ) {
											strBuffer.append( errorMsg );
											errorList = "NE";
										} else {
											strBuffer.append( "|" + errorMsg );
										}
									}
								} else {
									// \uBE44\uC815\uC0C1
									errorMsg = "Field(" + curKey + ")\uC5D0 \uB300\uD55C Field Type\uC758 \uD3EC\uB9F7\uC774 \uC62C\uBC14\uB974\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
									
									if ( errorList.equals( "" ) ) {
										strBuffer.append( errorMsg );
										errorList = "NE";
									} else {
										strBuffer.append( "|" + errorMsg );
									}
								}
							}
						}
						
						if ( schemaDefType.equals( "ER" ) || schemaDefType.equals( "ES" ) ) {
							if ( schemaDefType.equals( "ER" ) ) {
								fieldLength = token[ 1 ];
								arrayCount = token[ 2 ];
							} else if ( schemaDefType.equals( "ES" ) ) {
								fieldLength = token[ 5 ];
								arrayCount = token[ 6 ];
							}
							
							try {
								fieldLen = Integer.parseInt( fieldLength );
							} catch ( Exception fe ) {
								errorMsg = "Field(" + curKey + ")\uC5D0 \uB300\uD55C Field Length\uAC00 \uC22B\uC790 \uD0C0\uC785\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
							
								if ( errorList.equals( "" ) ) {
									strBuffer.append( errorMsg );
									errorList = "NE";
								} else {
									strBuffer.append( "|" + errorMsg );
								}
							}
							
							try {
								fieldLen = Integer.parseInt( arrayCount );
							} catch ( Exception fe ) {
								errorMsg = "Field(" + curKey + ")\uC5D0 \uB300\uD55C Array Count\uAC00 \uC22B\uC790 \uD0C0\uC785\uC774 \uC544\uB2D9\uB2C8\uB2E4.";
							
								if ( errorList.equals( "" ) ) {
									strBuffer.append( errorMsg );
									errorList = "NE";
								} else {
									strBuffer.append( "|" + errorMsg );
								}
							}
						}
					} else {
						errorMsg = "Field(" + curKey + ")\uC5D0 \uB300\uD55C \uC815\uC758 \uD3EC\uB9F7(Field Length/Padding String/Left Padding, Right Padding \uAD6C\uBD84/Field Desc \uB610\uB294 Data Type/Field Length/Array Count/Field Desc \uB610\uB294 Field Length/Padding String/Left Padding, Right Padding \uAD6C\uBD84/Field Desc/Data Type/Field Length/Array Count)\uC774 \uC62C\uBC14\uB974\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.";
						
						if ( errorList.equals( "" ) ) {
							strBuffer.append( errorMsg );
							errorList = "NE";
						} else {
							strBuffer.append( "|" + errorMsg );
						}
					}
				} else if ( obj instanceof IData ) { // obj is IData
					errorMsg = schemaDefValidation( ( IData )obj, existVariableField );
					
					if (!errorMsg.equals( "" ) ) {
						if ( errorList.equals( "" ) ) {
							strBuffer.append( errorMsg );
							errorList = "NE";
						} else {
							strBuffer.append( "|" + errorMsg );
						}
					}
				} else if ( obj instanceof IData[] ) { // obj is IData[]
					recList = ( IData[] )obj;
					
					if ( recList == null ) {
						continue;
					}
					
					errorMsg = schemaDefValidation( recList[ 0 ], existVariableField );
					
					if (!errorMsg.equals( "" ) ) {
						if ( errorList.equals( "" ) ) {
							strBuffer.append( errorMsg );
							errorList = "NE";
						} else {
							strBuffer.append( "|" + errorMsg );
						}
					}
				}
			}
			
			errorList = strBuffer.toString();
		} catch ( Exception e ) {
			
		}		
		
		return errorList;
	}
	
	public static Hashtable makeAuditDoc( Hashtable hashTable, IData iData, int seq, String idataType, String highListName, String highListSeq, int listSeq, int listDepth, String[] schemaList, int schemaIndex, String changeSpace ) {
		IDataCursor cur = iData.getCursor();
		Hashtable ht = new Hashtable();
		Hashtable tempht = null;
		Hashtable titleHashTable = new Hashtable();
		Hashtable valueHashTable = new Hashtable();
		String curKey = null;
		Object obj = null;
		String keyValue = "";
		IData doc = null;
		IDataCursor docCursor = null;
		IData[] recList = null;
		String listName = "";
		int fieldIndex = 0;
		int fieldCount = 0;
		String[] listValues = null;
		String fieldSave = "false";
		String[] schemaDef = null;
		String fieldDesc = "";
		String highListSeqDesc = "";
		String beforeListExist = "false";
		String errorMsg = "";
		
		// \uCD5C\uCD08\uC5D0 makeAuditDoc \uBA54\uC18C\uB4DC\uB97C \uD638\uCD9C\uD560 \uB54C \uD55C \uBC88 \uC0DD\uC131
		if ( hashTable == null ) {
			hashTable = new Hashtable();
		}
		
		// Array\uC758 Depth\uAC00 2 \uC774\uC0C1\uC778 \uACBD\uC6B0 \uB808\uCF54\uB4DC \uB9C8\uB2E4 Unique \uD55C \uBC88\uD638\uB97C \uB9CC\uB4E4\uAE30 \uC704\uD574\uC11C \uC0C1\uC704 \uB808\uCF54\uB4DC\uC758 \uBC88\uD638\uB97C \uAC19\uC774 \uBD99\uC5EC\uC11C \uB9CC\uB4E0\uB2E4.
		// Depth\uAC00 1\uC778 \uACBD\uC6B0\uC5D0\uB294 \uC0C1\uC704 \uB808\uCF54\uB4DC\uAC00 \uC5C6\uC73C\uBBC0\uB85C Depth 1\uC758 \uB808\uCF54\uB4DC Index \uBC88\uD638\uB9CC\uC73C\uB85C \uB9CC\uB4E4\uACE0 Depth\uAC00 2 \uC774\uC0C1\uC778 \uACBD\uC6B0\uC5D0\uB294 "\uC0C1\uC704 \uB808\uCF54\uB4DC Index \uBC88\uD638" - "\uD604\uC7AC \uB808\uCF54\uB4DC Index \uBC88\uD638"\uB85C \uB9CC\uB4E0\uB2E4.
		if ( highListSeq.equals( "" ) ) {
			// Skip
		} else {
			highListSeqDesc = highListSeq + "-";
		}
		
		try {
			while ( cur.next() ) {				
				curKey = cur.getKey();
				obj = cur.getValue();
				
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) {	// obj is String
					keyValue = ( String )obj;
					// \uD654\uBA74\uC5D0 Display \uD560 \uB54C Space\uB294 \uAD6C\uBD84\uD558\uAE30 \uC5B4\uB824\uC6B0\uBBC0\uB85C Space\uB97C \u25A1 \uB85C \uBCC0\uD658\uD55C\uB2E4.
					if ( changeSpace.equals( "true" ) ) {
						keyValue = keyValue.replaceAll( " ", "\u25A1" );
					}
					
					if ( idataType.equals( "field" ) ) {
						// Single Record\uC758 \uD544\uB4DC\uC778 \uACBD\uC6B0
						doc = IDataFactory.create();
						docCursor = doc.getCursor();
						
						// Schema \uC815\uC758 \uD56D\uBAA9\uBCC4\uB85C \uBD84\uB9AC
						schemaDef = schemaList[ schemaIndex ].split( "\\/" );
						
						// Field\uC5D0 \uB300\uD55C \uC124\uBA85 \uD56D\uBAA9\uC774 \uC788\uB294 \uACBD\uC6B0
						if ( schemaDef.length >= 4 ) {
							fieldDesc = "(" + schemaDef[ 3 ] + ")";
						} else {
							fieldDesc = "";
						}
						
						docCursor.insertAfter( "idataType", "field" );
						docCursor.insertAfter( "fieldNameOnly", curKey );
						docCursor.insertAfter( "fieldName", curKey + fieldDesc );
						docCursor.insertAfter( "fieldValue", keyValue );
						
						// \uC0C1\uC704\uC5D0\uC11C List \uB05D\uB09C \uD6C4\uC5D0 Single Record\uAC00 \uB098\uC624\uB294 \uACBD\uC6B0
						if ( beforeListExist.equals( "true" ) ) {
							// \uCD5C\uCD08\uC5D0 \uB098\uC624\uB294 \uD544\uB4DC\uC5D0\uC11C \uD55C \uBC88\uB9CC \uC218\uD589\uD558\uBA74 \uB41C\uB2E4.
							docCursor.insertAfter( "beforeListExist", "true" );
							beforeListExist = "false";
						}
						
						hashTable.put( "ITEM_" + seq, doc );
						
						docCursor.destroy();
						doc = null;
						seq++;
						schemaIndex++;
					} else {
						// List\uC758 \uD55C \uB808\uCF54\uB4DC\uB97C \uC800\uC7A5\uD558\uB294 \uACBD\uC6B0
						// List\uC758 Title \uC800\uC7A5
						if ( listSeq == 0 ) {
							// Schema \uC815\uC758 \uD56D\uBAA9\uBCC4\uB85C \uBD84\uB9AC
							schemaDef = schemaList[ schemaIndex ].split( "\\/" );
							
							// Field\uC5D0 \uB300\uD55C \uC124\uBA85 \uD56D\uBAA9\uC774 \uC788\uB294 \uACBD\uC6B0
							if ( schemaDef.length >= 4 ) {
								fieldDesc = "(" + schemaDef[ 3 ] + ")";
							} else {
								fieldDesc = "";
							}
							
							titleHashTable.put( "FIELD_" + fieldIndex, curKey + fieldDesc );
							schemaIndex++;
						} else {
							schemaIndex++;
						}
						
						// List\uC758 Value \uC800\uC7A5
						valueHashTable.put( "FIELD_" + fieldIndex, keyValue );
						fieldIndex++;
						fieldCount++;
					}
				} else if ( obj instanceof IData[] ) { // obj is IData[]
					recList = ( IData[] )obj;
					listName = curKey;
					
					if ( recList == null ) {
						continue;
					}									
					
					// List \uC544\uB798\uC5D0 \uB610 List\uAC00 \uC788\uB294 \uAD6C\uC870\uC778 \uACBD\uC6B0(listDepth\uAC00 2 \uC774\uC0C1\uC778 \uACBD\uC6B0) \uC55E\uC5D0\uC11C \uC800\uC7A5\uD55C \uC0C1\uC704 List Depth\uC758 titleHashTable, valueHashTable \uC815\uBCF4\uB97C \uC800\uC7A5\uD55C\uB2E4.
					// \uCCAB\uBC88\uC9F8 List\uB97C \uB9CC\uB0AC\uC744 \uB54C idataType\uC740 "field" \uC0C1\uD0DC\uC774\uAE30 \uB54C\uBB38\uC5D0 \uCCAB\uBC88\uC9F8 List\uB294 \uC544\uB798 \uB85C\uC9C1\uC774 Skip \uB41C\uB2E4.
					if ( idataType.equals( "list" ) ) {
						if ( listSeq == 0 ) {
							doc = IDataFactory.create();
							docCursor = doc.getCursor();
							listValues = new String[ fieldCount ];
							
							for ( int i = 0; i < fieldCount; i++ ) {
								// Hashtable\uC5D0\uB294 \uC785\uB825 \uBC1B\uC740 doc\uC758 \uD56D\uBAA9\uB4E4\uC758 \uC5ED\uC21C\uC73C\uB85C \uC800\uC7A5\uB418\uC5B4 \uC788\uC9C0\uB9CC Name\uC73C\uB85C \uCD94\uCD9C\uD558\uBBC0\uB85C i \uC21C\uC11C\uB300\uB85C \uC800\uC7A5\uD55C\uB2E4.
								listValues[ i ] = ( String )titleHashTable.get( "FIELD_" + i );
							}
							
							docCursor.insertAfter( "idataType", "list" );
							docCursor.insertAfter( "listNameOnly", highListName );
							docCursor.insertAfter( "listIndex", highListSeq );
							docCursor.insertAfter( "fieldCount", fieldCount + "" );
							docCursor.insertAfter( "listDepth", listDepth + "" );
							docCursor.insertAfter( "titleValue", "title" );
							docCursor.insertAfter( "valueList", listValues );
							hashTable.put( "ITEM_" + seq, doc );
							seq++;
							
							docCursor.destroy();
							doc = null;
							listValues = null;
						}
						
						doc = IDataFactory.create();
						docCursor = doc.getCursor();
						listValues = new String[ fieldCount ];
						
						for ( int i = 0; i < fieldCount; i++ ) {
							// Hashtable\uC5D0\uB294 \uC785\uB825 \uBC1B\uC740 doc\uC758 \uD56D\uBAA9\uB4E4\uC758 \uC5ED\uC21C\uC73C\uB85C \uC800\uC7A5\uB418\uC5B4 \uC788\uC9C0\uB9CC Name\uC73C\uB85C \uCD94\uCD9C\uD558\uBBC0\uB85C i \uC21C\uC11C\uB300\uB85C \uC800\uC7A5\uD55C\uB2E4.
							listValues[ i ] = ( String )valueHashTable.get( "FIELD_" + i );
						}
						
						docCursor.insertAfter( "idataType", "list" );
						docCursor.insertAfter( "listNameOnly", highListName );
						docCursor.insertAfter( "listIndex", highListSeq );
						docCursor.insertAfter( "listDepth", listDepth + "" );
						docCursor.insertAfter( "titleValue", "value" );
						docCursor.insertAfter( "valueList", listValues );
						hashTable.put( "ITEM_" + seq, doc );
						seq++;
						
						docCursor.destroy();
						doc = null;
						listValues = null;
						fieldSave = "true";
					}
					
					listDepth++;
					
					for ( int i = 0; i < recList.length; i++ ) {
						tempht = makeAuditDoc( hashTable, recList[ i ], seq, "list", listName, highListSeqDesc + i, i, listDepth, schemaList, schemaIndex, changeSpace );
						hashTable = ( Hashtable )tempht.get( "AUDITDATA" );
						seq = Integer.parseInt( ( String )tempht.get( "NEXTSEQ" ) );						
					}
					
					// \uB9C8\uC9C0\uB9C9 Record \uCC98\uB9AC \uD6C4 \uB9AC\uD134 \uBC1B\uC740 schemaIndex\uAC00 Next Cursor\uC758 schemaIndex\uAC00 \uB41C\uB2E4.
					schemaIndex = Integer.parseInt( ( String )tempht.get( "SCHEMAINDEX" ) );
					
					// List \uB05D\uB098\uB294 \uBD80\uBD84\uC744 \uD45C\uC2DC
					doc = IDataFactory.create();
					docCursor = doc.getCursor();
					docCursor.insertAfter( "idataType", "list" );
					docCursor.insertAfter( "listNameOnly", listName );
					docCursor.insertAfter( "listIndex", highListSeq );
					docCursor.insertAfter( "listDepth", listDepth + "" );
					docCursor.insertAfter( "titleValue", "listEnd" );
					hashTable.put( "ITEM_" + seq, doc );
					seq++;
					beforeListExist = "true";
					
					docCursor.destroy();
					doc = null;
					
					listDepth--;
				}
			}
			
			// List\uC758 \uD55C \uB808\uCF54\uB4DC\uB97C \uC800\uC7A5\uD558\uB294 \uACBD\uC6B0 ==> List \uC544\uB798\uC5D0 \uB610 \uB2E4\uB978 List\uAC00 \uC5C6\uB294 \uAD6C\uC870\uC778 \uACBD\uC6B0
			if ( idataType.equals( "list" ) && fieldSave.equals( "false" ) ) {
				if ( listSeq == 0 ) {
					doc = IDataFactory.create();
					docCursor = doc.getCursor();
					listValues = new String[ fieldCount ];
					
					for ( int i = 0; i < fieldCount; i++ ) {
						// Hashtable\uC5D0\uB294 \uC785\uB825 \uBC1B\uC740 doc\uC758 \uD56D\uBAA9\uB4E4\uC758 \uC5ED\uC21C\uC73C\uB85C \uC800\uC7A5\uB418\uC5B4 \uC788\uC9C0\uB9CC Name\uC73C\uB85C \uCD94\uCD9C\uD558\uBBC0\uB85C i \uC21C\uC11C\uB300\uB85C \uC800\uC7A5\uD55C\uB2E4.
						listValues[ i ] = ( String )titleHashTable.get( "FIELD_" + i );
					}
					
					docCursor.insertAfter( "idataType", "list" );
					docCursor.insertAfter( "listNameOnly", highListName );
					docCursor.insertAfter( "listIndex", highListSeq );
					docCursor.insertAfter( "fieldCount", fieldCount + "" );
					docCursor.insertAfter( "listDepth", listDepth + "" );
					docCursor.insertAfter( "titleValue", "title" );
					docCursor.insertAfter( "valueList", listValues );
					hashTable.put( "ITEM_" + seq, doc );
					seq++;
					
					docCursor.destroy();
					doc = null;
					listValues = null;
				}
				
				doc = IDataFactory.create();
				docCursor = doc.getCursor();
				listValues = new String[ fieldCount ];
				
				for ( int i = 0; i < fieldCount; i++ ) {
					// Hashtable\uC5D0\uB294 \uC785\uB825 \uBC1B\uC740 doc\uC758 \uD56D\uBAA9\uB4E4\uC758 \uC5ED\uC21C\uC73C\uB85C \uC800\uC7A5\uB418\uC5B4 \uC788\uC9C0\uB9CC Name\uC73C\uB85C \uCD94\uCD9C\uD558\uBBC0\uB85C i \uC21C\uC11C\uB300\uB85C \uC800\uC7A5\uD55C\uB2E4.
					listValues[ i ] = ( String )valueHashTable.get( "FIELD_" + i );
				}
				
				docCursor.insertAfter( "idataType", "list" );
				docCursor.insertAfter( "listNameOnly", highListName );
				docCursor.insertAfter( "listIndex", highListSeq );
				docCursor.insertAfter( "listDepth", listDepth + "" );
				docCursor.insertAfter( "titleValue", "value" );
				docCursor.insertAfter( "valueList", listValues );
				hashTable.put( "ITEM_" + seq, doc );
				seq++;
				
				docCursor.destroy();
				doc = null;
				listValues = null;
			}
			
			ht.put( "AUDITDATA", hashTable );
			ht.put( "NEXTSEQ", seq + "" );
			ht.put( "ERRORMSG", errorMsg );
			ht.put( "SCHEMAINDEX", schemaIndex + "" );
		} catch ( Exception e ) {
			ht.put( "AUDITDATA", hashTable );
			ht.put( "NEXTSEQ", seq + "" );
			ht.put( "ERRORMSG", e.toString() );
			ht.put( "SCHEMAINDEX", schemaIndex + "" );
		}
		
		tempht = null;
		titleHashTable = null;
		valueHashTable = null;
		recList = null;
		listValues = null;
		
		return ht;
	}
	
	/* 2022.08.04 \uC218\uC815 ==> JSON \uBCC0\uD658\uC5D0 \uB300\uD55C Schema Define \uC801\uC6A9
	public static Hashtable makeSchemaDefDoc( Hashtable hashTable, IData iData, int seq, int listDepth, String[] recCountFieldName, int recIndex ) {
		IDataCursor cur = iData.getCursor();
		Hashtable ht = new Hashtable();
		Hashtable tempht = null;
		String curKey = null;
		Object obj = null;
		String keyValue = "";
		IData doc = null;
		IDataCursor docCursor = null;
		IData[] recList = null;
		String[] token = null;
		String[] fieldSchema = null;
		int tempRecIndex = 0;
		int recCount = 0; // Record \uAC2F\uC218
		String recCountDesc = "";
		String errorMsg = "";
		String schemaDefType = "";
		// EN : Endian No(Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0), ER : Endian Receive(\uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0), ES : Endian Send(\uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0)
		
		// \uCD5C\uCD08\uC5D0 makeSchemaDefDoc \uBA54\uC18C\uB4DC\uB97C \uD638\uCD9C\uD560 \uB54C \uD55C \uBC88 \uC0DD\uC131
		if ( hashTable == null ) {
			hashTable = new Hashtable();
		}
		
		try {
			while ( cur.next() ) {				
				curKey = cur.getKey();
				obj = cur.getValue();
				
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) {	// obj is String
					keyValue = ( String )obj;		
					token = keyValue.split( "/" );
					
					// \uCD5C\uCD08\uC5D0 \uD55C \uBC88\uB9CC \uC218\uD589
					if ( schemaDefType.equals( "" ) ) {
						if ( token.length == 7 ) {
							// \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
							schemaDefType = "ES";							
						} else if ( token.length <= 4 ) {
							try {
								Integer.parseInt( token[ 0 ] );
								// \uCCAB\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790(\uD544\uB4DC\uC758 \uAE38\uC774)\uC778 \uACBD\uC6B0 ==> Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0
								schemaDefType = "EN";
							} catch ( Exception ne ) {
								// \uCCAB\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790\uAC00 \uC544\uB2CC(Data Type) \uACBD\uC6B0 ==> \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
								schemaDefType = "ER";
							}
						}
					}
					
					if ( token.length == 7 ) {
						fieldSchema = new String[ 8 ];
					} else if ( token.length <= 4 ) {
						fieldSchema = new String[ 5 ];
					}
					
					if ( schemaDefType.equals( "EN" ) ) {
						// \uD544\uB4DC\uBA85
						fieldSchema[ 0 ] = curKey;
						
						// \uD544\uB4DC\uC124\uBA85
						if ( token.length == 3 ) {
							// \uD544\uB4DC\uC124\uBA85\uC774 \uC5C6\uB294 \uACBD\uC6B0
							fieldSchema[ 1 ] = "";
						} else {
							fieldSchema[ 1 ] = token[ 3 ];
						}
						
						// \uD544\uB4DC\uAE38\uC774
						fieldSchema[ 2 ] = token[ 0 ];
					
						// \uD328\uB529\uBB38\uC790
						if ( token[ 1 ].equals( " " ) ) {
							// \uD328\uB529 \uBB38\uC790\uAC00 \uC2A4\uD398\uC774\uC2A4\uC778 \uACBD\uC6B0
							fieldSchema[ 3 ] = "Space";
						} else {
							fieldSchema[ 3 ] = token[ 1 ];
						}
					
						// \uD328\uB529\uBC29\uD5A5
						if ( token[ 2 ].equals( "LP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Left Padding";
						} else if ( token[ 2 ].equals( "RP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Right Padding";
						}
					} else if ( schemaDefType.equals( "ER" ) ) {
						// \uD544\uB4DC\uBA85
						fieldSchema[ 0 ] = curKey;
						
						// \uD544\uB4DC\uC124\uBA85
						fieldSchema[ 1 ] = token[ 3 ];
						
						// Data Type
						fieldSchema[ 2 ] = token[ 0 ];
						
						// Length
						fieldSchema[ 3 ] = token[ 1 ];
						
						// Array Count
						fieldSchema[ 4 ] = token[ 2 ];
					} else if ( schemaDefType.equals( "ES" ) ) {
						// \uD544\uB4DC\uBA85
						fieldSchema[ 0 ] = curKey;
						
						// \uD544\uB4DC\uC124\uBA85
						fieldSchema[ 1 ] = token[ 3 ];
						
						// \uD544\uB4DC\uAE38\uC774
						fieldSchema[ 2 ] = token[ 0 ];
					
						// \uD328\uB529\uBB38\uC790
						if ( token[ 1 ].equals( " " ) ) {
							// \uD328\uB529 \uBB38\uC790\uAC00 \uC2A4\uD398\uC774\uC2A4\uC778 \uACBD\uC6B0
							fieldSchema[ 3 ] = "Space";
						} else {
							fieldSchema[ 3 ] = token[ 1 ];
						}
					
						// \uD328\uB529\uBC29\uD5A5
						if ( token[ 2 ].equals( "LP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Left Padding";
						} else if ( token[ 2 ].equals( "RP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Right Padding";
						}
						
						// Data Type
						fieldSchema[ 5 ] = token[ 4 ];
						
						// Length
						fieldSchema[ 6 ] = token[ 5 ];
						
						// Array Count
						fieldSchema[ 7 ] = token[ 6 ];
					}
					
					doc = IDataFactory.create();
					docCursor = doc.getCursor();
					
					docCursor.insertAfter( "idataType", "field" );
					docCursor.insertAfter( "listDepth", listDepth + "" );
					docCursor.insertAfter( "schemaList", fieldSchema );
					hashTable.put( "ITEM_" + seq, doc );
					seq++;
					
					docCursor.destroy();
					doc = null;					
				} else if ( obj instanceof IData[] ) { // obj is IData[]
					recList = ( IData[] )obj;
					
					if ( recList == null ) {
						continue;
					}
					
					if ( recCountFieldName == null || recCountFieldName.length == 0 ) {
						recCountDesc = "Record Count/Field Name : Undefined";
					} else {
						try {
							recCount = Integer.parseInt( recCountFieldName[ recIndex ] ); // \uACE0\uC815\uAE38\uC774\uC778 \uACBD\uC6B0
							recCountDesc = "Record Count : " + recCount;
						} catch ( Exception ce ) {
							recCountDesc = "Record Count Field Name : " + recCountFieldName[ recIndex ]; // \uAC00\uBCC0\uAE38\uC774\uC778 \uACBD\uC6B0
						}
					}
					
					listDepth++;
					
					doc = IDataFactory.create();
					docCursor = doc.getCursor();
					
					docCursor.insertAfter( "idataType", "list" );
					docCursor.insertAfter( "listDepth", listDepth + "" );
					docCursor.insertAfter( "listName", curKey );
					docCursor.insertAfter( "listCountDesc", recCountDesc );
					hashTable.put( "ITEM_" + seq, doc );
					seq++;
					
					docCursor.destroy();
					doc = null;					
					
					for ( int i = 0; i < recList.length; i++ ) {
						tempht = makeSchemaDefDoc( hashTable, recList[ i ], seq, listDepth, recCountFieldName, recIndex + 1 );
						hashTable = ( Hashtable )tempht.get( "SCHEMADATA" );
						seq = Integer.parseInt( ( String )tempht.get( "NEXTSEQ" ) );
						
						if ( i == 0 ) {
							tempRecIndex = Integer.parseInt( ( String )tempht.get( "RECINDEX" ) );
							
							if ( schemaDefType.equals( "" ) ) {
								schemaDefType = ( String )tempht.get( "SCHEMADEFTYPE" );
							}
						}
					}
					
					listDepth--;
					
					// recCountFieldName\uC758 Index \uC99D\uAC00
					recIndex = tempRecIndex;
				}
			}			
			
			ht.put( "SCHEMADATA", hashTable );
			ht.put( "NEXTSEQ", seq + "" );
			ht.put( "RECINDEX", recIndex + "" );
			ht.put( "ERRORMSG", errorMsg );
			ht.put( "SCHEMADEFTYPE", schemaDefType );
		} catch ( Exception e ) {
			ht.put( "SCHEMADATA", hashTable );
			ht.put( "NEXTSEQ", seq + "" );
			ht.put( "RECINDEX", recIndex + "" );
			ht.put( "ERRORMSG", e.toString() );
			ht.put( "SCHEMADEFTYPE", schemaDefType );
		}
		
		tempht = null;
		recList = null;
		
		return ht;
	}
	*/
	
	public static Hashtable makeSchemaDefDoc( Hashtable hashTable, IData iData, int seq, int listDepth, String[] recCountFieldName, int recIndex ) {
		IDataCursor cur = iData.getCursor();
		Hashtable ht = new Hashtable();
		Hashtable tempht = null;
		String curKey = null;
		Object obj = null;
		String keyValue = "";
		IData doc = null;
		IDataCursor docCursor = null;
		IData[] recList = null;
		String[] token = null;
		String[] fieldSchema = null;
		int tempRecIndex = 0;
		int recCount = 0; // Record \uAC2F\uC218
		String recCountDesc = "";
		String errorMsg = "";
		String schemaDefType = "";
		// EN : Endian No(Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0), ER : Endian Receive(\uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0), ES : Endian Send(\uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0)
		// EJ : Endian No(Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0) & JSON \uBCC0\uD658\uC774 \uC788\uB294 \uACBD\uC6B0
		
		// \uCD5C\uCD08\uC5D0 makeSchemaDefDoc \uBA54\uC18C\uB4DC\uB97C \uD638\uCD9C\uD560 \uB54C \uD55C \uBC88 \uC0DD\uC131
		if ( hashTable == null ) {
			hashTable = new Hashtable();
		}
		
		try {
			while ( cur.next() ) {				
				curKey = cur.getKey();
				obj = cur.getValue();
				//debugLogger.printLogAtIS("curKey : " + curKey + ", obj : " + obj);
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) {	// obj is String
					keyValue = ( String )obj;		
					token = keyValue.split( "/" );
					
					// \uCD5C\uCD08\uC5D0 \uD55C \uBC88\uB9CC \uC218\uD589
					if ( schemaDefType.equals( "" ) ) {
						if ( token.length == 7 ) {
							try {
								Integer.parseInt( token[ 6 ] );
								// \uC77C\uACF1\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790(Array Count)\uC778 \uACBD\uC6B0 ==> \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
								schemaDefType = "ES";
							} catch ( Exception ne ) {
								// \uC77C\uACF1\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790\uAC00 \uC544\uB2CC(Field Type) \uACBD\uC6B0 ==> Socket To REST API \uBC29\uC2DD, REST API To Socket \uBC29\uC2DD, Socket To Socket \uBC29\uC2DD\uC774\uBA74\uC11C Source, Target \uD3EC\uB9F7\uC774 \uC11C\uB85C \uB2E4\uB978 \uACBD\uC6B0
								schemaDefType = "EJ";
							}
						} else if ( token.length <= 4 ) {
							try {
								Integer.parseInt( token[ 0 ] );
								// \uCCAB\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790(\uD544\uB4DC\uC758 \uAE38\uC774)\uC778 \uACBD\uC6B0 ==> Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0
								schemaDefType = "EN";
							} catch ( Exception ne ) {
								// \uCCAB\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790\uAC00 \uC544\uB2CC(Data Type) \uACBD\uC6B0 ==> \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
								schemaDefType = "ER";
							}
						}
					}
					
					if ( token.length == 7 ) {
						fieldSchema = new String[ 8 ];
					} else if ( token.length <= 4 ) {
						fieldSchema = new String[ 5 ];
					}
					
					if ( schemaDefType.equals( "EN" ) ) {
						// \uD544\uB4DC\uBA85
						fieldSchema[ 0 ] = curKey;
						
						// \uD544\uB4DC\uC124\uBA85
						if ( token.length == 3 ) {
							// \uD544\uB4DC\uC124\uBA85\uC774 \uC5C6\uB294 \uACBD\uC6B0
							fieldSchema[ 1 ] = "";
						} else {
							fieldSchema[ 1 ] = token[ 3 ];
						}
						
						// \uD544\uB4DC\uAE38\uC774
						fieldSchema[ 2 ] = token[ 0 ];
					
						// \uD328\uB529\uBB38\uC790
						if ( token[ 1 ].equals( " " ) ) {
							// \uD328\uB529 \uBB38\uC790\uAC00 \uC2A4\uD398\uC774\uC2A4\uC778 \uACBD\uC6B0
							fieldSchema[ 3 ] = "Space";
						} else {
							fieldSchema[ 3 ] = token[ 1 ];
						}
					
						// \uD328\uB529\uBC29\uD5A5
						if ( token[ 2 ].equals( "LP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Left Padding";
						} else if ( token[ 2 ].equals( "RP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Right Padding";
						}
					} else if ( schemaDefType.equals( "ER" ) ) {
						// \uD544\uB4DC\uBA85
						fieldSchema[ 0 ] = curKey;
						
						// \uD544\uB4DC\uC124\uBA85
						fieldSchema[ 1 ] = token[ 3 ];
						
						// Data Type
						fieldSchema[ 2 ] = token[ 0 ];
						
						// Length
						fieldSchema[ 3 ] = token[ 1 ];
						
						// Array Count
						fieldSchema[ 4 ] = token[ 2 ];
					} else if ( schemaDefType.equals( "ES" ) ) {
						// \uD544\uB4DC\uBA85
						fieldSchema[ 0 ] = curKey;
						
						// \uD544\uB4DC\uC124\uBA85
						fieldSchema[ 1 ] = token[ 3 ];
						
						// \uD544\uB4DC\uAE38\uC774
						fieldSchema[ 2 ] = token[ 0 ];
					
						// \uD328\uB529\uBB38\uC790
						if ( token[ 1 ].equals( " " ) ) {
							// \uD328\uB529 \uBB38\uC790\uAC00 \uC2A4\uD398\uC774\uC2A4\uC778 \uACBD\uC6B0
							fieldSchema[ 3 ] = "Space";
						} else {
							fieldSchema[ 3 ] = token[ 1 ];
						}
					
						// \uD328\uB529\uBC29\uD5A5
						if ( token[ 2 ].equals( "LP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Left Padding";
						} else if ( token[ 2 ].equals( "RP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Right Padding";
						}
						
						// Data Type
						fieldSchema[ 5 ] = token[ 4 ];
						
						// Length
						fieldSchema[ 6 ] = token[ 5 ];
						
						// Array Count
						fieldSchema[ 7 ] = token[ 6 ];
					} else if ( schemaDefType.equals( "EJ" ) ) {
						// \uD544\uB4DC\uBA85
						fieldSchema[ 0 ] = curKey;
						
						// \uD544\uB4DC\uC124\uBA85
						fieldSchema[ 1 ] = token[ 3 ];
						
						// \uD544\uB4DC\uAE38\uC774
						fieldSchema[ 2 ] = token[ 0 ];
					
						// \uD328\uB529\uBB38\uC790
						if ( token[ 1 ].equals( " " ) ) {
							// \uD328\uB529 \uBB38\uC790\uAC00 \uC2A4\uD398\uC774\uC2A4\uC778 \uACBD\uC6B0
							fieldSchema[ 3 ] = "Space";
						} else {
							fieldSchema[ 3 ] = token[ 1 ];
						}
					
						// \uD328\uB529\uBC29\uD5A5
						if ( token[ 2 ].equals( "LP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Left Padding";
						} else if ( token[ 2 ].equals( "RP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Right Padding";
						}
						
						// Data Type
						fieldSchema[ 5 ] = token[ 4 ];
						
						// Length Calculation Start
						if ( token[ 5 ].equals( "N" ) ) {
							fieldSchema[ 6 ] = "";
						} else {
							fieldSchema[ 6 ] = token[ 5 ];
						}
						
						// Field Type
						fieldSchema[ 7 ] = token[ 6 ];
					}
					
					doc = IDataFactory.create();
					docCursor = doc.getCursor();
					
					docCursor.insertAfter( "idataType", "field" );
					docCursor.insertAfter( "listDepth", listDepth + "" );
					docCursor.insertAfter( "schemaList", fieldSchema );
					hashTable.put( "ITEM_" + seq, doc );
					seq++;
					
					docCursor.destroy();
					doc = null;
				} else if ( obj instanceof IData ) { // obj is IData
					listDepth++;
					
					doc = IDataFactory.create();
					docCursor = doc.getCursor();
					
					docCursor.insertAfter( "idataType", "group" );
					docCursor.insertAfter( "listDepth", listDepth + "" );
					docCursor.insertAfter( "groupName", curKey );
					hashTable.put( "ITEM_" + seq, doc );
					seq++;
					
					docCursor.destroy();
					doc = null;
					
					tempht = makeSchemaDefDoc( hashTable, ( IData )obj, seq, listDepth, recCountFieldName, recIndex );
					hashTable = ( Hashtable )tempht.get( "SCHEMADATA" );
					seq = Integer.parseInt( ( String )tempht.get( "NEXTSEQ" ) );
					errorMsg = ( String )tempht.get( "ERRORMSG" );
					tempRecIndex = Integer.parseInt( ( String )tempht.get( "RECINDEX" ) );
					
					if ( schemaDefType.equals( "" ) ) {
						schemaDefType = ( String )tempht.get( "SCHEMADEFTYPE" );
					}
					
					listDepth--;
					
					// recCountFieldName\uC758 Index \uC99D\uAC00
					recIndex = tempRecIndex;
				} else if ( obj instanceof IData[] ) { // obj is IData[]
					recList = ( IData[] )obj;
					//debugLogger.printLogAtIS("IData[] : " + curKey);
					//debugLogger.printLogAtIS("recList : " + recList);
					if ( recList == null ) {
						continue;
					}
					//debugLogger.printLogAtIS("recIndex : " + recIndex);
					if ( recCountFieldName == null || recCountFieldName.length == 0 ) {
						//debugLogger.printLogAtIS("recCountFieldName NULL !!!");
						recCountDesc = "Record Count/Field Name : Undefined";
					} else {
						//debugLogger.printLogAtIS("recCountFieldName NOT NULL !!!");
						try {
							recCount = Integer.parseInt( recCountFieldName[ recIndex ] ); // \uACE0\uC815\uAE38\uC774\uC778 \uACBD\uC6B0
							//debugLogger.printLogAtIS("recCount : " + recCount);
							recCountDesc = "Record Count : " + recCount;
						} catch ( Exception ce ) {
							//debugLogger.printLogAtIS("Exception : " + ce.toString());
							recCountDesc = "Record Count Field Name : " + recCountFieldName[ recIndex ]; // \uAC00\uBCC0\uAE38\uC774\uC778 \uACBD\uC6B0
						}
					}
					//debugLogger.printLogAtIS("IData[] ::: recCountDesc " + recCountDesc);
					listDepth++;
					
					doc = IDataFactory.create();
					docCursor = doc.getCursor();
					
					docCursor.insertAfter( "idataType", "list" );
					docCursor.insertAfter( "listDepth", listDepth + "" );
					docCursor.insertAfter( "listName", curKey );
					docCursor.insertAfter( "listCountDesc", recCountDesc );
					hashTable.put( "ITEM_" + seq, doc );
					seq++;
					
					docCursor.destroy();
					doc = null;					
					
					for ( int i = 0; i < recList.length; i++ ) {
						tempht = makeSchemaDefDoc( hashTable, recList[ i ], seq, listDepth, recCountFieldName, recIndex + 1 );
						hashTable = ( Hashtable )tempht.get( "SCHEMADATA" );
						seq = Integer.parseInt( ( String )tempht.get( "NEXTSEQ" ) );
						errorMsg = ( String )tempht.get( "ERRORMSG" );
						
						if ( i == 0 ) {
							tempRecIndex = Integer.parseInt( ( String )tempht.get( "RECINDEX" ) );
							
							if ( schemaDefType.equals( "" ) ) {
								schemaDefType = ( String )tempht.get( "SCHEMADEFTYPE" );
							}
						}
					}
					
					listDepth--;
					//debugLogger.printLogAtIS("recIndex : " + recIndex);
					// recCountFieldName\uC758 Index \uC99D\uAC00
					recIndex = tempRecIndex;
				}
			}			
			
			ht.put( "SCHEMADATA", hashTable );
			ht.put( "NEXTSEQ", seq + "" );
			ht.put( "RECINDEX", recIndex + "" );
			ht.put( "ERRORMSG", errorMsg );
			ht.put( "SCHEMADEFTYPE", schemaDefType );
		} catch ( Exception e ) {
			ht.put( "SCHEMADATA", hashTable );
			ht.put( "NEXTSEQ", seq + "" );
			ht.put( "RECINDEX", recIndex + "" );
			ht.put( "ERRORMSG", e.toString() );
			ht.put( "SCHEMADEFTYPE", schemaDefType );
		}
		
		tempht = null;
		recList = null;
		
		return ht;
	}
	
	public static Hashtable makeDocData( Hashtable hashTable, String docData, int startOffSet, String charset, String[] recCountFieldName, String sourceTargetType, IData iData, int seq, int listDepth, int recIndex, String changeSpace, String firstInvoke ) {
		IDataCursor cur = iData.getCursor();
		Hashtable ht = new Hashtable();
		Hashtable tempht = null;
		String curKey = null;
		Object obj = null;
		String keyValue = "";
		IData doc = null;
		IDataCursor docCursor = null;
		IData[] recList = null;
		String[] token = null;
		String[] fieldSchema = null;
		String fieldLength = "";
		String fieldValue = "";
		String fieldType = "";
		String realFieldType = "";
		String[] otToken = null;
		int fieldLen = 0;
		int tempRecIndex = 0;
		int recCount = 0; // Record \uAC2F\uC218
		String remainData = "";
		String recCountDesc = "";
		String[] recCountFieldPath = null;
		String arrayCountFieldName = "";
		String recCountValue = null;
		String errorMsg = "";
		String schemaDefType = "";
		// EN : Endian No(Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0), ER : Endian Receive(\uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0), ES : Endian Send(\uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0)
		// EJ : Endian No(Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0) & JSON \uBCC0\uD658\uC774 \uC788\uB294 \uACBD\uC6B0
		
		IData tempDoc = IDataFactory.create();
		IDataCursor tempDocCursor = tempDoc.getCursor();
		IData inIData = IDataFactory.create();
		IDataCursor inputCursor = inIData.getCursor();
		IData outIData = null;
		IDataCursor outputCursor = null;
		
		// \uCD5C\uCD08\uC5D0 makeDocData \uBA54\uC18C\uB4DC\uB97C \uD638\uCD9C\uD560 \uB54C \uD55C \uBC88 \uC0DD\uC131
		if ( hashTable == null ) {
			hashTable = new Hashtable();
		}
		
		try {
			while ( cur.next() ) {				
				curKey = cur.getKey();
				obj = cur.getValue();
				//debugLogger.printLogAtIS("curKey : " + curKey + ", obj : " + obj);
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) {	// obj is String
					keyValue = ( String )obj;		
					token = keyValue.split( "/" );
					
					// \uCD5C\uCD08\uC5D0 \uD55C \uBC88\uB9CC \uC218\uD589
					if ( schemaDefType.equals( "" ) ) {
						if ( token.length == 7 ) {
							try {
								Integer.parseInt( token[ 6 ] );
								// \uC77C\uACF1\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790(Array Count)\uC778 \uACBD\uC6B0 ==> \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
								schemaDefType = "ES";
							} catch ( Exception ne ) {
								// \uC77C\uACF1\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790\uAC00 \uC544\uB2CC(Field Type) \uACBD\uC6B0 ==> Socket To REST API \uBC29\uC2DD, REST API To Socket \uBC29\uC2DD, Socket To Socket \uBC29\uC2DD\uC774\uBA74\uC11C Source, Target \uD3EC\uB9F7\uC774 \uC11C\uB85C \uB2E4\uB978 \uACBD\uC6B0
								schemaDefType = "EJ";
							}
						} else if ( token.length <= 4 ) {
							try {
								Integer.parseInt( token[ 0 ] );
								// \uCCAB\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790(\uD544\uB4DC\uC758 \uAE38\uC774)\uC778 \uACBD\uC6B0 ==> Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0
								schemaDefType = "EN";
							} catch ( Exception ne ) {
								// \uCCAB\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790\uAC00 \uC544\uB2CC(Data Type) \uACBD\uC6B0 ==> \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
								schemaDefType = "ER";
							}
						}
					}
					
					if ( schemaDefType.equals( "EJ" ) ) {
						fieldSchema = new String[ 5 ];
					} else {
						fieldSchema = new String[ 4 ];
					}
					
					if ( schemaDefType.equals( "EN" ) ) {
						// \uD544\uB4DC\uBA85
						fieldSchema[ 0 ] = curKey;
						
						// \uD544\uB4DC\uC124\uBA85
						if ( token.length == 3 ) {
							// \uD544\uB4DC\uC124\uBA85\uC774 \uC5C6\uB294 \uACBD\uC6B0
							fieldSchema[ 1 ] = "";
						} else {
							fieldSchema[ 1 ] = token[ 3 ];
						}
						
						// \uD544\uB4DC\uAE38\uC774
						fieldSchema[ 2 ] = token[ 0 ];
						fieldLength = token[ 0 ];
						
						/*
						// \uD328\uB529\uBB38\uC790
						if ( token[ 1 ].equals( " " ) ) {
							// \uD328\uB529 \uBB38\uC790\uAC00 \uC2A4\uD398\uC774\uC2A4\uC778 \uACBD\uC6B0
							fieldSchema[ 3 ] = "Space";
						} else {
							fieldSchema[ 3 ] = token[ 1 ];
						}
					
						// \uD328\uB529\uBC29\uD5A5
						if ( token[ 2 ].equals( "LP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Left Padding";
						} else if ( token[ 2 ].equals( "RP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Right Padding";
						}
						*/
						
						try {
							// fieldLength\uC5D0 \uC2E4\uC81C\uB85C Field\uC758 \uAE38\uC774 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uACE0\uC815\uAE38\uC774\uC778 \uACBD\uC6B0
							fieldLen = Integer.parseInt( fieldLength );
						} catch ( Exception ie ) {
							// fieldLength\uC5D0 Field\uC758 \uAE38\uC774 \uC815\uBCF4\uB97C \uD3EC\uD568\uD558\uB294 Field\uBA85 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uAC00\uBCC0\uAE38\uC774\uC778 \uACBD\uC6B0
							fieldLength = IDataUtil.getString( tempDocCursor, fieldLength ).trim();
							fieldLen = Integer.parseInt( fieldLength );
							
							// IDataUtil.getString \uC2E4\uD589 \uC2DC  Cursor \uC704\uCE58\uAC00 \uC774\uB3D9\uD588\uC744 \uC218 \uC788\uAE30 \uB54C\uBB38\uC5D0 \uB2E4\uC2DC \uB9C8\uC9C0\uB9C9 \uC704\uCE58\uB85C Cursor\uB97C \uC774\uB3D9\uC2DC\uD0A8\uB2E4.
							tempDocCursor.last();
						}
						
						IDataUtil.put( inputCursor, "inString", docData );
						IDataUtil.put( inputCursor, "startOffset", startOffSet + "" );
						IDataUtil.put( inputCursor, "length", fieldLength );
						IDataUtil.put( inputCursor, "charset", charset );
					
						outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
						outputCursor = outIData.getCursor();
						fieldValue = IDataUtil.getString( outputCursor, "outString" );
						
						// \uD654\uBA74\uC5D0 Display \uD560 \uB54C Space\uB294 \uAD6C\uBD84\uD558\uAE30 \uC5B4\uB824\uC6B0\uBBC0\uB85C Space\uB97C \u25A1 \uB85C \uBCC0\uD658\uD55C\uB2E4.
						if ( changeSpace.equals( "true" ) ) {
							fieldValue = fieldValue.replaceAll( " ", "\u25A1" );
						}
						
						outputCursor.destroy();
						outIData = null;
						
						fieldSchema[ 3 ] = fieldValue;
						tempDocCursor.insertAfter( curKey, fieldValue );
						
						// Next startOffSet
						startOffSet = startOffSet + fieldLen;
					} else if ( schemaDefType.equals( "ER" ) ) {
						// \uD544\uB4DC\uBA85
						fieldSchema[ 0 ] = curKey;
						
						// \uD544\uB4DC\uC124\uBA85
						fieldSchema[ 1 ] = token[ 3 ];
						
						// Data Type
						//fieldSchema[ 2 ] = token[ 0 ];
						
						// Length
						fieldSchema[ 2 ] = token[ 1 ];
						fieldLength = token[ 1 ];
						
						// Array Count
						//fieldSchema[ 4 ] = token[ 2 ];
						
						try {
							// fieldLength\uC5D0 \uC2E4\uC81C\uB85C Field\uC758 \uAE38\uC774 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uACE0\uC815\uAE38\uC774\uC778 \uACBD\uC6B0
							fieldLen = Integer.parseInt( fieldLength );
						} catch ( Exception ie ) {
							// fieldLength\uC5D0 Field\uC758 \uAE38\uC774 \uC815\uBCF4\uB97C \uD3EC\uD568\uD558\uB294 Field\uBA85 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uAC00\uBCC0\uAE38\uC774\uC778 \uACBD\uC6B0
							fieldLength = IDataUtil.getString( tempDocCursor, fieldLength ).trim();
							fieldLen = Integer.parseInt( fieldLength );
							
							// IDataUtil.getString \uC2E4\uD589 \uC2DC  Cursor \uC704\uCE58\uAC00 \uC774\uB3D9\uD588\uC744 \uC218 \uC788\uAE30 \uB54C\uBB38\uC5D0 \uB2E4\uC2DC \uB9C8\uC9C0\uB9C9 \uC704\uCE58\uB85C Cursor\uB97C \uC774\uB3D9\uC2DC\uD0A8\uB2E4.
							tempDocCursor.last();
						}
						
						IDataUtil.put( inputCursor, "inString", docData );
						IDataUtil.put( inputCursor, "startOffset", startOffSet + "" );
						IDataUtil.put( inputCursor, "length", fieldLength );
						IDataUtil.put( inputCursor, "charset", charset );
					
						outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
						outputCursor = outIData.getCursor();
						fieldValue = IDataUtil.getString( outputCursor, "outString" );
						
						// \uD654\uBA74\uC5D0 Display \uD560 \uB54C Space\uB294 \uAD6C\uBD84\uD558\uAE30 \uC5B4\uB824\uC6B0\uBBC0\uB85C Space\uB97C \u25A1 \uB85C \uBCC0\uD658\uD55C\uB2E4.
						if ( changeSpace.equals( "true" ) ) {
							fieldValue = fieldValue.replaceAll( " ", "\u25A1" );
						}
						outputCursor.destroy();
						outIData = null;
						
						fieldSchema[ 3 ] = fieldValue;
						tempDocCursor.insertAfter( curKey, fieldValue );
						
						// Next startOffSet
						startOffSet = startOffSet + fieldLen;
					} else if ( schemaDefType.equals( "ES" ) ) {
						// \uD544\uB4DC\uBA85
						fieldSchema[ 0 ] = curKey;
						
						// \uD544\uB4DC\uC124\uBA85
						fieldSchema[ 1 ] = token[ 3 ];
						
						// \uD544\uB4DC\uAE38\uC774
						fieldSchema[ 2 ] = token[ 0 ];
						fieldLength = token[ 0 ];
						
						/*
						// \uD328\uB529\uBB38\uC790
						if ( token[ 1 ].equals( " " ) ) {
							// \uD328\uB529 \uBB38\uC790\uAC00 \uC2A4\uD398\uC774\uC2A4\uC778 \uACBD\uC6B0
							fieldSchema[ 3 ] = "Space";
						} else {
							fieldSchema[ 3 ] = token[ 1 ];
						}
					
						// \uD328\uB529\uBC29\uD5A5
						if ( token[ 2 ].equals( "LP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Left Padding";
						} else if ( token[ 2 ].equals( "RP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Right Padding";
						}
						
						// Data Type
						fieldSchema[ 5 ] = token[ 4 ];
						
						// Length
						fieldSchema[ 6 ] = token[ 5 ];
						
						// Array Count
						fieldSchema[ 7 ] = token[ 6 ];
						*/
						
						try {
							// fieldLength\uC5D0 \uC2E4\uC81C\uB85C Field\uC758 \uAE38\uC774 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uACE0\uC815\uAE38\uC774\uC778 \uACBD\uC6B0
							fieldLen = Integer.parseInt( fieldLength );
						} catch ( Exception ie ) {
							// fieldLength\uC5D0 Field\uC758 \uAE38\uC774 \uC815\uBCF4\uB97C \uD3EC\uD568\uD558\uB294 Field\uBA85 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uAC00\uBCC0\uAE38\uC774\uC778 \uACBD\uC6B0
							fieldLength = IDataUtil.getString( tempDocCursor, fieldLength ).trim();
							fieldLen = Integer.parseInt( fieldLength );
							
							// IDataUtil.getString \uC2E4\uD589 \uC2DC  Cursor \uC704\uCE58\uAC00 \uC774\uB3D9\uD588\uC744 \uC218 \uC788\uAE30 \uB54C\uBB38\uC5D0 \uB2E4\uC2DC \uB9C8\uC9C0\uB9C9 \uC704\uCE58\uB85C Cursor\uB97C \uC774\uB3D9\uC2DC\uD0A8\uB2E4.
							tempDocCursor.last();
						}
						
						IDataUtil.put( inputCursor, "inString", docData );
						IDataUtil.put( inputCursor, "startOffset", startOffSet + "" );
						IDataUtil.put( inputCursor, "length", fieldLength );
						IDataUtil.put( inputCursor, "charset", charset );
					
						outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
						outputCursor = outIData.getCursor();
						fieldValue = IDataUtil.getString( outputCursor, "outString" );
						
						// \uD654\uBA74\uC5D0 Display \uD560 \uB54C Space\uB294 \uAD6C\uBD84\uD558\uAE30 \uC5B4\uB824\uC6B0\uBBC0\uB85C Space\uB97C \u25A1 \uB85C \uBCC0\uD658\uD55C\uB2E4.
						if ( changeSpace.equals( "true" ) ) {
							fieldValue = fieldValue.replaceAll( " ", "\u25A1" );
						}
						
						outputCursor.destroy();
						outIData = null;
						
						fieldSchema[ 3 ] = fieldValue;
						tempDocCursor.insertAfter( curKey, fieldValue );
						
						// Next startOffSet
						startOffSet = startOffSet + fieldLen;
					} else if ( schemaDefType.equals( "EJ" ) ) {
						// \uD544\uB4DC\uBA85
						fieldSchema[ 0 ] = curKey;
						
						// \uD544\uB4DC\uC124\uBA85
						fieldSchema[ 1 ] = token[ 3 ];
						
						// \uD544\uB4DC\uAE38\uC774
						fieldSchema[ 2 ] = token[ 0 ];
						fieldLength = token[ 0 ];
						
						/*
						// \uD328\uB529\uBB38\uC790
						if ( token[ 1 ].equals( " " ) ) {
							// \uD328\uB529 \uBB38\uC790\uAC00 \uC2A4\uD398\uC774\uC2A4\uC778 \uACBD\uC6B0
							fieldSchema[ 3 ] = "Space";
						} else {
							fieldSchema[ 3 ] = token[ 1 ];
						}
					
						// \uD328\uB529\uBC29\uD5A5
						if ( token[ 2 ].equals( "LP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Left Padding";
						} else if ( token[ 2 ].equals( "RP" ) ) {
							// \uC67C\uCABD \uD328\uB529\uC778 \uACBD\uC6B0
							fieldSchema[ 4 ] = "Right Padding";
						}
						
						// Data Type
						fieldSchema[ 5 ] = token[ 4 ];
						
						// Length Calculation Start
						if ( token[ 5 ].equals( "N" ) ) {
							fieldSchema[ 6 ] = "";
						} else {
							fieldSchema[ 6 ] = token[ 5 ];
						}
						*/
						
						// Field Type
						fieldSchema[ 3 ] = token[ 6 ];
						fieldType = token[ 6 ];
						otToken = fieldType.split( "\\$" );
						realFieldType = otToken[ 0 ].trim().toUpperCase();
						
						/* 
						 * realFieldType
						 * ST : Field\uAC00 Source, Target\uC5D0 \uBAA8\uB450 \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0
						 * OS : Field\uAC00 Source\uC5D0\uB9CC \uC874\uC7AC\uD558\uACE0 Target\uC5D0\uB294  \uC874\uC7AC\uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0
						 * OT : Field\uAC00 Target\uC5D0\uB9CC \uC874\uC7AC\uD558\uACE0 Source\uC5D0\uB294  \uC874\uC7AC\uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0					 
						 */
						
						if ( sourceTargetType.equals( "sourceSide" ) ) {
							// Socket Schema Define\uC774 Source \uCABD\uC778 \uACBD\uC6B0
							if ( realFieldType.equals( "ST" ) || realFieldType.equals( "OS" ) ) {
								// Socket String\uC5D0 \uC874\uC7AC\uD558\uB294 \uD544\uB4DC\uC778 \uACBD\uC6B0
								try {
									// fieldLength\uC5D0 \uC2E4\uC81C\uB85C Field\uC758 \uAE38\uC774 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uACE0\uC815\uAE38\uC774\uC778 \uACBD\uC6B0
									fieldLen = Integer.parseInt( fieldLength );
								} catch ( Exception ie ) {
									// fieldLength\uC5D0 Field\uC758 \uAE38\uC774 \uC815\uBCF4\uB97C \uD3EC\uD568\uD558\uB294 Field\uBA85 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uAC00\uBCC0\uAE38\uC774\uC778 \uACBD\uC6B0
									fieldLength = IDataUtil.getString( tempDocCursor, fieldLength ).trim();
									fieldLen = Integer.parseInt( fieldLength );
									
									// IDataUtil.getString \uC2E4\uD589 \uC2DC  Cursor \uC704\uCE58\uAC00 \uC774\uB3D9\uD588\uC744 \uC218 \uC788\uAE30 \uB54C\uBB38\uC5D0 \uB2E4\uC2DC \uB9C8\uC9C0\uB9C9 \uC704\uCE58\uB85C Cursor\uB97C \uC774\uB3D9\uC2DC\uD0A8\uB2E4.
									tempDocCursor.last();
								}
				
								IDataUtil.put( inputCursor, "inString", docData );
								IDataUtil.put( inputCursor, "startOffset", startOffSet + "" );
								IDataUtil.put( inputCursor, "length", fieldLength );
								IDataUtil.put( inputCursor, "charset", charset );
							
								outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
								outputCursor = outIData.getCursor();
								fieldValue = IDataUtil.getString( outputCursor, "outString" );
								
								// \uD654\uBA74\uC5D0 Display \uD560 \uB54C Space\uB294 \uAD6C\uBD84\uD558\uAE30 \uC5B4\uB824\uC6B0\uBBC0\uB85C Space\uB97C \u25A1 \uB85C \uBCC0\uD658\uD55C\uB2E4.
								if ( changeSpace.equals( "true" ) ) {
									fieldValue = fieldValue.replaceAll( " ", "\u25A1" );
								}
								
								outputCursor.destroy();
								outIData = null;
								
								fieldSchema[ 4 ] = fieldValue;
								tempDocCursor.insertAfter( curKey, fieldValue );
								
								// Next startOffSet
								startOffSet = startOffSet + fieldLen;
							} else {
								fieldSchema[ 4 ] = "$FIELD_NA$";
							}
						} else {
							// Socket Schema Define\uC774 Target \uCABD\uC778 \uACBD\uC6B0
							if ( realFieldType.equals( "ST" ) || realFieldType.equals( "OT" ) ) {
								// Socket String\uC5D0 \uC874\uC7AC\uD558\uB294 \uD544\uB4DC\uC778 \uACBD\uC6B0
								try {
									// fieldLength\uC5D0 \uC2E4\uC81C\uB85C Field\uC758 \uAE38\uC774 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uACE0\uC815\uAE38\uC774\uC778 \uACBD\uC6B0
									fieldLen = Integer.parseInt( fieldLength );
								} catch ( Exception ie ) {
									// fieldLength\uC5D0 Field\uC758 \uAE38\uC774 \uC815\uBCF4\uB97C \uD3EC\uD568\uD558\uB294 Field\uBA85 \uC815\uBCF4\uAC00 \uC788\uB294 \uACBD\uC6B0 ==> Field\uAC00 \uAC00\uBCC0\uAE38\uC774\uC778 \uACBD\uC6B0
									fieldLength = IDataUtil.getString( tempDocCursor, fieldLength ).trim();
									fieldLen = Integer.parseInt( fieldLength );
									
									// IDataUtil.getString \uC2E4\uD589 \uC2DC  Cursor \uC704\uCE58\uAC00 \uC774\uB3D9\uD588\uC744 \uC218 \uC788\uAE30 \uB54C\uBB38\uC5D0 \uB2E4\uC2DC \uB9C8\uC9C0\uB9C9 \uC704\uCE58\uB85C Cursor\uB97C \uC774\uB3D9\uC2DC\uD0A8\uB2E4.
									tempDocCursor.last();
								}
				
								IDataUtil.put( inputCursor, "inString", docData );
								IDataUtil.put( inputCursor, "startOffset", startOffSet + "" );
								IDataUtil.put( inputCursor, "length", fieldLength );
								IDataUtil.put( inputCursor, "charset", charset );
							
								outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
								outputCursor = outIData.getCursor();
								fieldValue = IDataUtil.getString( outputCursor, "outString" );
								
								// \uD654\uBA74\uC5D0 Display \uD560 \uB54C Space\uB294 \uAD6C\uBD84\uD558\uAE30 \uC5B4\uB824\uC6B0\uBBC0\uB85C Space\uB97C \u25A1 \uB85C \uBCC0\uD658\uD55C\uB2E4.
								if ( changeSpace.equals( "true" ) ) {
									fieldValue = fieldValue.replaceAll( " ", "\u25A1" );
								}
								
								outputCursor.destroy();
								outIData = null;
								
								fieldSchema[ 4 ] = fieldValue;
								tempDocCursor.insertAfter( curKey, fieldValue );
								
								// Next startOffSet
								startOffSet = startOffSet + fieldLen;
							} else {
								fieldSchema[ 4 ] = "$FIELD_NA$";
							}
						}
					}
					
					doc = IDataFactory.create();
					docCursor = doc.getCursor();
					
					docCursor.insertAfter( "idataType", "field" );
					docCursor.insertAfter( "listDepth", listDepth + "" );
					docCursor.insertAfter( "fieldDataList", fieldSchema );
					hashTable.put( "ITEM_" + seq, doc );
					seq++;
					
					docCursor.destroy();
					doc = null;
				} else if ( obj instanceof IData ) { // obj is IData
					listDepth++;
					
					doc = IDataFactory.create();
					docCursor = doc.getCursor();
					
					docCursor.insertAfter( "idataType", "group" );
					docCursor.insertAfter( "listDepth", listDepth + "" );
					docCursor.insertAfter( "groupName", curKey );
					hashTable.put( "ITEM_" + seq, doc );
					seq++;
					
					docCursor.destroy();
					doc = null;
					
					tempht = makeDocData( hashTable, docData, startOffSet, charset, recCountFieldName, sourceTargetType, ( IData )obj, seq, listDepth, recIndex, changeSpace, "false" );
					hashTable = ( Hashtable )tempht.get( "DOCDATA" );
					startOffSet = Integer.parseInt( ( String )tempht.get( "NEXTSTARTOFFSET" ) );
					seq = Integer.parseInt( ( String )tempht.get( "NEXTSEQ" ) );
					errorMsg = ( String )tempht.get( "ERRORMSG" );
					tempRecIndex = Integer.parseInt( ( String )tempht.get( "RECINDEX" ) );
					
					if ( schemaDefType.equals( "" ) ) {
						schemaDefType = ( String )tempht.get( "SCHEMADEFTYPE" );
					}
					
					listDepth--;
					
					// recCountFieldName\uC758 Index \uC99D\uAC00
					recIndex = tempRecIndex;
				} else if ( obj instanceof IData[] ) { // obj is IData[]
					recList = ( IData[] )obj;
					//debugLogger.printLogAtIS("IData[] : " + curKey);
					//debugLogger.printLogAtIS("recList : " + recList);
					if ( recList == null ) {
						continue;
					}
					//debugLogger.printLogAtIS("recIndex : " + recIndex);
					if ( recCountFieldName == null || recCountFieldName.length == 0 ) {
						//debugLogger.printLogAtIS("recCountFieldName NULL !!!");
						recCountDesc = "Record Count/Field Name : Undefined";
					} else {
						//debugLogger.printLogAtIS("recCountFieldName NOT NULL !!!");
						try {
							recCount = Integer.parseInt( recCountFieldName[ recIndex ] ); // \uACE0\uC815\uAE38\uC774\uC778 \uACBD\uC6B0
							//debugLogger.printLogAtIS("recCount : " + recCount);
							recCountDesc = "Record Count : " + recCount;
						} catch ( Exception ce ) {
							//debugLogger.printLogAtIS("Exception : " + ce.toString());
							recCountDesc = "Record Count Field Name : " + recCountFieldName[ recIndex ]; // \uAC00\uBCC0\uAE38\uC774\uC778 \uACBD\uC6B0
						}
					}
					//debugLogger.printLogAtIS("IData[] ::: recCountDesc " + recCountDesc);
					listDepth++;
					
					doc = IDataFactory.create();
					docCursor = doc.getCursor();
					
					docCursor.insertAfter( "idataType", "list" );
					docCursor.insertAfter( "listDepth", listDepth + "" );
					docCursor.insertAfter( "listName", curKey );
					docCursor.insertAfter( "listCountDesc", recCountDesc );
					hashTable.put( "ITEM_" + seq, doc );
					seq++;
					
					docCursor.destroy();
					doc = null;
					
					// Record \uAC2F\uC218 \uCD94\uCD9C
					if ( recCountFieldName == null || recCountFieldName.length == 0 ) {
						// \uD558\uB098\uC758 Array\uB9CC \uC788\uB294 \uD3EC\uB9F7\uC774\uBA74\uC11C \uAC00\uBCC0\uAE38\uC774\uC774\uACE0 Array Count\uB97C \uD3EC\uD568\uD558\uB294 \uD544\uB4DC\uAC00 \uC5C6\uB294 \uC804\uBB38\uC778 \uACBD\uC6B0 Array Count\uB97C \uAD6C\uD55C\uB2E4.
						recCount = getArrayCount( docData, iData, charset );
					} else {
						// 2022.08.05 \uC218\uC815. Array Count\uB97C \uD3EC\uD568\uD558\uACE0 \uC788\uB294 \uD544\uB4DC\uAC00 Path \uD615\uD0DC\uB85C \uBC14\uB00C\uC5B4\uC11C \uD544\uB4DC\uBA85\uB9CC \uBF51\uB294 \uCC98\uB9AC\uB97C \uC218\uD589\uD568.
						recCountFieldPath = recCountFieldName[ recIndex ].split( "/" );
						arrayCountFieldName = recCountFieldPath[ recCountFieldPath.length - 1 ];
						recCountValue = IDataUtil.getString( tempDocCursor, arrayCountFieldName );
					
						if ( recCountValue == null ) {
							// \uB808\uCF54\uB4DC \uAC2F\uC218\uAC00 \uD3EC\uD568\uB41C Field\uC758 Name\uC774 \uC544\uB2C8\uACE0 \uB808\uCF54\uB4DC\uC758 \uAC2F\uC218\uB97C \uC9C1\uC811 \uC804\uB2EC \uBC1B\uC740 \uACBD\uC6B0 ==> \uACE0\uC815\uAE38\uC774
							recCount = Integer.parseInt( recCountFieldName[ recIndex ].trim() );
						} else {
							// \uB808\uCF54\uB4DC \uAC2F\uC218\uAC00 \uD3EC\uD568\uB41C Field\uC758 Name\uC744 \uC804\uB2EC \uBC1B\uC740 \uACBD\uC6B0 ==> \uAC00\uBCC0\uAE38\uC774
							recCount = Integer.parseInt( recCountValue.trim() );
						}
					}
					
					if ( recCount == 0 ) {
						// recCountFieldName\uC758 Index \uC99D\uAC00
						recIndex += 1;
					} else {
						for ( int i = 0; i < recCount; i++ ) {
							tempht = makeDocData( hashTable, docData, startOffSet, charset, recCountFieldName, sourceTargetType, recList[ 0 ], seq, listDepth, recIndex + 1, changeSpace, "false" );
							hashTable = ( Hashtable )tempht.get( "DOCDATA" );
							startOffSet = Integer.parseInt( ( String )tempht.get( "NEXTSTARTOFFSET" ) );
							seq = Integer.parseInt( ( String )tempht.get( "NEXTSEQ" ) );
							errorMsg = ( String )tempht.get( "ERRORMSG" );
							
							if ( i == 0 ) {
								tempRecIndex = Integer.parseInt( ( String )tempht.get( "RECINDEX" ) );
								
								if ( schemaDefType.equals( "" ) ) {
									schemaDefType = ( String )tempht.get( "SCHEMADEFTYPE" );
								}
							}
							
							if ( i < ( recCount - 1 ) ) {
								// Record\uB97C \uAD6C\uBD84\uD558\uAE30 \uC704\uD574\uC11C \uBE48 \uC904 \uD558\uB098\uB97C \uCD94\uAC00\uD55C\uB2E4.
								doc = IDataFactory.create();
								docCursor = doc.getCursor();
								
								docCursor.insertAfter( "idataType", "emptylist" );
								docCursor.insertAfter( "listDepth", listDepth + "" );
								docCursor.insertAfter( "listName", curKey );
								hashTable.put( "ITEM_" + seq, doc );
								seq++;
								
								docCursor.destroy();
								doc = null;
							}
						}
						
						listDepth--;
						//debugLogger.printLogAtIS("recIndex : " + recIndex);
						// recCountFieldName\uC758 Index \uC99D\uAC00
						recIndex = tempRecIndex;
					}
				}
			}
			
			if ( firstInvoke.equals( "true" ) ) {
				// makeDocData \uBA54\uC18C\uB4DC\uB97C \uCD5C\uCD08\uC5D0 \uD638\uCD9C\uD55C \uACBD\uC6B0\uC5D0\uB9CC \uC218\uD589\uD55C\uB2E4.
				// Schema Define\uC5D0 \uC815\uC758\uB41C \uB370\uC774\uD130 \uC774\uC678\uC5D0 \uCD94\uAC00\uB85C \uB370\uC774\uD130\uB97C \uC218\uC2E0\uD588\uB294\uC9C0\uB97C \uCCB4\uD06C\uD55C\uB2E4.
				IDataUtil.put( inputCursor, "inString", docData );
				IDataUtil.put( inputCursor, "startOffset", startOffSet + "" );
				IDataUtil.put( inputCursor, "length", "" );
				IDataUtil.put( inputCursor, "charset", charset );
			
				outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
				outputCursor = outIData.getCursor();
				remainData = IDataUtil.getString( outputCursor, "outString" );
				
				if ( !remainData.equals( "" ) ) {
					// \uD654\uBA74\uC5D0 Display \uD560 \uB54C Space\uB294 \uAD6C\uBD84\uD558\uAE30 \uC5B4\uB824\uC6B0\uBBC0\uB85C Space\uB97C \u25A1 \uB85C \uBCC0\uD658\uD55C\uB2E4.
					if ( changeSpace.equals( "true" ) ) {
						remainData = remainData.replaceAll( " ", "\u25A1" );
					}
					
					// \uCD08\uACFC\uB85C \uC218\uC2E0\uD55C \uB370\uC774\uD130\uB97C \uCD94\uAC00\uD55C\uB2E4.
					doc = IDataFactory.create();
					docCursor = doc.getCursor();
					
					docCursor.insertAfter( "idataType", "remaindata" );
					docCursor.insertAfter( "remainData", remainData );
					hashTable.put( "ITEM_" + seq, doc );
					seq++;
					
					docCursor.destroy();
					doc = null;
				}
				
				outputCursor.destroy();
				outIData = null;
			}
			
			ht.put( "DOCDATA", hashTable );
			ht.put( "NEXTSTARTOFFSET", startOffSet + "" );
			ht.put( "NEXTSEQ", seq + "" );
			ht.put( "RECINDEX", recIndex + "" );
			ht.put( "ERRORMSG", errorMsg );
			ht.put( "SCHEMADEFTYPE", schemaDefType );
		} catch ( Exception e ) {
			ht.put( "DOCDATA", hashTable );
			ht.put( "NEXTSTARTOFFSET", startOffSet + "" );
			ht.put( "NEXTSEQ", seq + "" );
			ht.put( "RECINDEX", recIndex + "" );
			ht.put( "ERRORMSG", e.toString() );
			ht.put( "SCHEMADEFTYPE", schemaDefType );
		}
		
		tempDocCursor.destroy();
		inputCursor.destroy();
		tempDoc = null;
		inIData = null;
		
		tempht = null;
		recList = null;
		
		return ht;
	}
	
	public static Hashtable setAuditData( IData doc, String idataType, String highListName, String highListSeq, int listDepth, String chgName, String chgValue, Hashtable chgList ) {
		IDataCursor cur = doc.getCursor();
		Hashtable ht = new Hashtable();
		Hashtable tempht = null;
		String curKey = null;
		Object obj = null;
		String keyValue = "";
		String partType = "";
		String partTypeName = "";
		String changeDesc = "";
		String fieldName = "";
		int fieldIndex = 0;
		String change = "false";
		String listChange = "";
		IData[] recList = null;
		String listName = "";
		String highListSeqDesc = "";
		
		// Array\uC758 Depth\uAC00 2 \uC774\uC0C1\uC778 \uACBD\uC6B0 \uB808\uCF54\uB4DC \uB9C8\uB2E4 Unique \uD55C \uBC88\uD638\uB97C \uB9CC\uB4E4\uAE30 \uC704\uD574\uC11C \uC0C1\uC704 \uB808\uCF54\uB4DC\uC758 \uBC88\uD638\uB97C \uAC19\uC774 \uBD99\uC5EC\uC11C \uB9CC\uB4E0\uB2E4.
		// Depth\uAC00 1\uC778 \uACBD\uC6B0\uC5D0\uB294 \uC0C1\uC704 \uB808\uCF54\uB4DC\uAC00 \uC5C6\uC73C\uBBC0\uB85C Depth 1\uC758 \uB808\uCF54\uB4DC Index \uBC88\uD638\uB9CC\uC73C\uB85C \uB9CC\uB4E4\uACE0 Depth\uAC00 2 \uC774\uC0C1\uC778 \uACBD\uC6B0\uC5D0\uB294 "\uC0C1\uC704 \uB808\uCF54\uB4DC Index \uBC88\uD638" - "\uD604\uC7AC \uB808\uCF54\uB4DC Index \uBC88\uD638"\uB85C \uB9CC\uB4E0\uB2E4.
		if ( highListSeq.equals( "" ) ) {
			// Skip
		} else {
			highListSeqDesc = highListSeq + "-";
		}
		
		try {
			partType = chgName.substring( 0, 1 );
			
			if ( partType.equals( "C" ) ) {
				partTypeName = "\uACF5\uD1B5\uC815\uBCF4\uBD80";
			} else if ( partType.equals( "B" ) ) {
				partTypeName = "\uC5C5\uBB34\uC815\uBCF4\uBD80";
			}
			
			while ( cur.next() ) {				
				curKey = cur.getKey();
				obj = cur.getValue();
				
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) {	// obj is String
					keyValue = ( String )obj;
					
					if ( idataType.equals( "field" ) ) {
						// Single Record\uC758 \uD544\uB4DC\uC778 \uACBD\uC6B0
						fieldName = partType + "_S_" + curKey;
						
						if ( chgName.equals( fieldName ) ) {
							// \uB370\uC774\uD130 \uC218\uC815
							cur.setValue( chgValue );
							changeDesc = partTypeName + " Signle Record Part Field " + curKey + " \uC218\uC815 : " + keyValue + " ==> " + chgValue;
							chgList.put( chgName, changeDesc );
							change = "true";
							break;
						}
					} else {
						// List\uC758 Record\uC758 \uD544\uB4DC\uC778 \uACBD\uC6B0
						fieldName = partType + "_A_" + listDepth + "_" + highListName + "_" + highListSeq + "_" + fieldIndex;
						
						if ( chgName.equals( fieldName ) ) {
							// \uB370\uC774\uD130 \uC218\uC815
							cur.setValue( chgValue );
							changeDesc = partTypeName + " Array Record Part " + highListName + " Record Index " + highListSeq + " Field " + curKey + " \uC218\uC815 : " + keyValue + " ==> " + chgValue;
							chgList.put( chgName, changeDesc );
							change = "true";
							break;
						}
						
						fieldIndex++;
					}
				} else if ( obj instanceof IData[] ) { // obj is IData[]
					recList = ( IData[] )obj;
					listName = curKey;
					
					if ( recList == null ) {
						continue;
					}
					
					listDepth++;
					
					for ( int i = 0; i < recList.length; i++ ) {
						tempht = setAuditData( recList[ i ], "list", listName, highListSeqDesc + i, listDepth, chgName, chgValue, chgList );
						listChange = ( String )tempht.get( "CHANGE" );
						chgList = ( Hashtable )tempht.get( "CHGLIST" );
						
						if ( listChange.equals( "true" ) ) {
							recList[ i ] = ( IData )tempht.get( "AUDITDATA" );
							cur.setValue( recList );
							break;
						}
					}
					
					if ( listChange.equals( "true" ) ) {
						change = listChange;
						break;
					}
					
					listDepth--;
				}
			} // while End
			
			ht.put( "AUDITDATA", doc );
			ht.put( "CHGLIST", chgList );
			ht.put( "CHANGE", change );
		} catch ( Exception e ) {
			ht.put( "AUDITDATA", doc );
			ht.put( "CHGLIST", chgList );
			ht.put( "CHANGE", change );
			ht.put( "ERRORMSG", e.toString() );
		}
		
		tempht = null;
		recList = null;
		
		return ht;
	}
	
	public static boolean isContainFromToDate( String compareTime, String fromTime, String toTime, String comparePattern, String fromPattern, String toPattern ) {
		boolean contains = false;
		
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
				contains = true;
			}
		} catch ( Exception e ) {
			
		}
		
		sdfCompare = null;
		sdfFrom = null;
		sdfTo = null;
		compareDate = null;
		fromDate = null;
		toDate = null;
		
		return contains;
	}
	
	public static String[] sortStartTime( String[] fileNameList, String sorting ) {
		String[] outFileNameList = new String[ fileNameList.length ];
		ArrayList< HashMap< String, String > > fileList = new ArrayList< HashMap< String, String > >();
		HashMap< String, String > fileInfo = null;
		HashMap< String, String > fileHM = null;
		String[] fileNames = null;
		String auditStartTime = "";
		Comparator< HashMap< String, String > > sort = null;
		
		try {
			for ( int i = 0; i < fileNameList.length; i++ ) {
				fileNames = fileNameList[ i ].split( "\\$" );
				auditStartTime = fileNames[ 1 ];
				fileInfo = new HashMap< String, String >();
				fileInfo.put( "auditStartTime", auditStartTime );
				fileInfo.put( "fileName", fileNameList[ i ] );
				fileList.add( fileInfo );
			}
			
			sort = new Comparator< HashMap< String, String > >() {
				public int compare( HashMap< String, String > hm1, HashMap< String, String > hm2 ) {
					long date1 = Long.parseLong( hm1.get( "auditStartTime" ) );
					long date2 = Long.parseLong( hm2.get( "auditStartTime" ) );
					int ie = 0;
					int ip = 1;
					int im = -1;
					
					if ( sorting.equals( "descending" ) ) {
						ip = -1;
						im = 1;
					}
					
					return date1 == date2 ? ie : ( date1 > date2 ? ip : im );
				}
			};
			
			Collections.sort( fileList, sort );
			
			for ( int i = 0; i < fileList.size(); i++ ) {
				fileHM = ( HashMap< String, String > )fileList.get( i );
				outFileNameList[ i ] = fileHM.get( "fileName" );
			}
		} catch ( Exception e ) {
			debugLogger.printLogAtIS( "### Audit Start Time Sorting Error : " + e.toString() );
		}
		
		fileList = null;
		fileInfo = null;
		fileHM = null;
		fileNames = null;
		sort = null;
		
		return outFileNameList;
	}
	
	public static String[] sortQueueTopic( String[] fileNameList ) {
		String[] outFileNameList = new String[ fileNameList.length ];
		ArrayList< HashMap< String, String > > fileList = new ArrayList< HashMap< String, String > >();
		HashMap< String, String > fileInfo = null;
		HashMap< String, String > fileHM = null;
		String[] fileNames = null;
		String queueTopicName = "";
		Comparator< HashMap< String, String > > sort = null;
		
		try {
			for ( int i = 0; i < fileNameList.length; i++ ) {
				fileNames = fileNameList[ i ].split( "\\$" );
				queueTopicName = fileNames[ 1 ];
				fileInfo = new HashMap< String, String >();
				fileInfo.put( "queueTopicName", queueTopicName );
				fileInfo.put( "fileName", fileNameList[ i ] );
				fileList.add( fileInfo );
			}
			
			sort = new Comparator< HashMap< String, String > >() {
				public int compare( HashMap< String, String > hm1, HashMap< String, String > hm2 ) {
					String queueTopic1 = ( String )hm1.get( "queueTopicName" );
					String queueTopic2 = ( String )hm2.get( "queueTopicName" );
					
					return queueTopic1.compareTo( queueTopic2 );
				}
			};
			
			Collections.sort( fileList, sort );
			
			for ( int i = 0; i < fileList.size(); i++ ) {
				fileHM = ( HashMap< String, String > )fileList.get( i );
				outFileNameList[ i ] = fileHM.get( "fileName" );
			}
		} catch ( Exception e ) {
			debugLogger.printLogAtIS( "### Queue/Topic Name Sorting Error : " + e.toString() );
		}
		
		fileList = null;
		fileInfo = null;
		fileHM = null;
		fileNames = null;
		sort = null;
		
		return outFileNameList;
	}
		
	// --- <<IS-END-SHARED>> ---
}

