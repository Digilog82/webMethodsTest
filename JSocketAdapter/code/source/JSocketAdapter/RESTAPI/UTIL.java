package JSocketAdapter.RESTAPI;

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




	public static final void convertStringToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertStringToString)>> ---
		// @sigtype java 3.5
		// [i] field:0:required socketString
		// [i] record:0:required schemaDef
		// [i] field:1:required recCountFieldName
		// [i] field:0:required charset
		// [i] field:0:required byteLength
		// [o] field:0:required errorMsg
		// [o] field:0:required targetSocketString
		IDataCursor pipelineCursor = pipeline.getCursor();
		String socketString = IDataUtil.getString( pipelineCursor, "socketString" );
		IData schemaDef = IDataUtil.getIData( pipelineCursor, "schemaDef" );		
		// Multi Record\uAC00 \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0 Record\uC758 \uAC2F\uC218\uB97C \uD3EC\uD568\uD558\uACE0 \uC788\uB294 Field Name ==> \uC5EC\uB7EC\uAC1C \uC874\uC7AC\uD560 \uC218 \uC788\uC73C\uBBC0\uB85C Array\uB85C \uC804\uB2EC \uBC1B\uB294\uB2E4.
		// Record\uC758 \uAC2F\uC218\uB97C \uD3EC\uD568\uD558\uACE0 \uC788\uB294 Field Name\uC774 \uC804\uBB38 \uC548\uC5D0 \uC5C6\uB294 \uACBD\uC6B0\uC5D0\uB294 Record\uC758 \uAC2F\uC218\uB97C \uC9C1\uC811 \uC804\uB2EC \uBC1B\uB294\uB2E4.
		String[] recCountFieldName = IDataUtil.getStringArray( pipelineCursor, "recCountFieldName" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		int byteLength = IDataUtil.getInt( pipelineCursor, "byteLength", 0 );
		pipelineCursor.destroy();
		
		String[] convertInfo = null;
		String targetSocketString = "";
		String errorMsg = "";
		IData pipelineData = null;		
		
		try {
			// socketString\uC758 byte \uAE38\uC774
			// socketString\uC758 byte \uAE38\uC774\uB97C \uC785\uB825\uBC1B\uC9C0 \uBABB\uD55C \uACBD\uC6B0\uC5D0\uB294 \uC5EC\uAE30\uC5D0\uC11C \uC9C1\uC811 \uAE38\uC774\uB97C \uAD6C\uD55C\uB2E4.
			if ( byteLength == 0 ) {
				byteLength = ( socketString.getBytes( charset ) ).length;
			}
			
			pipelineData = IDataUtil.deepClone( pipeline );
			
			convertInfo = makeStringToString_ApplySchema( socketString, byteLength, schemaDef, 0, recCountFieldName, 0, charset, pipelineData );
			
			targetSocketString = convertInfo[ 0 ];
			errorMsg = convertInfo[ 3 ];
		}  catch ( Exception e ) {
			errorMsg = e.toString();
		}		
		
		convertInfo = null;
		schemaDef = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "targetSocketString", targetSocketString );
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
		// [i] field:0:required convertJson {"Yes","No"}
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
		String convertJson = IDataUtil.getString( pipelineCursor, "convertJson" );
		pipelineCursor.destroy();
		
		IData pipelineData = null;
		IData[] convertInfo = null;
		IData doc = null;
		IData error = null;
		IDataCursor errorCursor = null;
		String errorMsg = "";
		
		if ( convertJson == null || convertJson.equals( "" ) ) {
			convertJson = "No";
		}
		
		try {
			// socketString\uC758 byte \uAE38\uC774
			// socketString\uC758 byte \uAE38\uC774\uB97C \uC785\uB825\uBC1B\uC9C0 \uBABB\uD55C \uACBD\uC6B0\uC5D0\uB294 \uC5EC\uAE30\uC5D0\uC11C \uC9C1\uC811 \uAE38\uC774\uB97C \uAD6C\uD55C\uB2E4.
			if ( byteLength == 0 ) {
				byteLength = ( socketString.getBytes( charset ) ).length;
			}
			
			pipelineData = IDataUtil.deepClone( pipeline );
			
			convertInfo = makeStringIData_ApplySchema( socketString, byteLength, schemaDef, 0, recCountFieldName, 0, charset, convertJson, pipelineData );
			
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
		
		IData pipelineData = null;
		IData inIData = null;
		IDataCursor inputCursor = null;
		IData outIData = null;
		IDataCursor outputCursor = null;
		
		try {
			schemaList = makeSchemaList( schemaDef, "S" ).split( "\\|" );
			pipelineData = IDataUtil.deepClone( pipeline );
			convertInfo = makeIDataString_ApplySchema( doc, schemaList, 0, charset, "S", "N", pipelineData, "true" );
			iDataString = convertInfo[ 0 ];
			errorMsg = convertInfo[ 6 ];
			
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



	public static final void createSchemaDef (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createSchemaDef)>> ---
		// @sigtype java 3.5
		// [i] field:0:required schemaDefine
		// [o] field:0:required errorMsg
		// [o] record:0:required schemaDef
		IDataCursor pipelineCursor = pipeline.getCursor();
		String schemaDefine = IDataUtil.getString( pipelineCursor, "schemaDefine" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		IData schemaDef = IDataFactory.create();
		IDataCursor docCursor = schemaDef.getCursor();
		String curKey = "";
		
		String[] schemaList = null;
		String[] itemList = null;
		String[] parentList = null;
		String[] existResult = null;
		String exists = "";
		int noSeq = 0;
		String noPath = "";
		String[] noPathList = null;
		String parentPath = "";
		String fieldName = "";
		String fieldDesc = "";
		String dataType = "";
		String paddingChar = "";
		String paddingDirection = "";
		String fieldLength = "";
		String lengthStart = "";
		String lengthLoc = "";
		String lengthLength = "";
		String fieldType = "";
		String otValueType = "";
		String otValue = "";
		String fieldSchema = "";
		String beforePath = "";
		int schemaDefineCount = 0;
		
		try {
			// \uD544\uB4DC\uBCC4 \uC2A4\uD0A4\uB9C8 \uC815\uC758 \uBAA9\uB85D \uAD6C\uD558\uAE30
			schemaList = schemaDefine.split( "\\n" );
			//debugLogger.printLogAtIS("schemaList.length : " + schemaList.length);
			for ( int i = 0; i < schemaList.length; i++ ) {				
				//debugLogger.printLogAtIS("schemaList[ " + i + " ] : " + schemaList[i]);
				// \uAC01 \uD544\uB4DC\uC5D0 \uB300\uD55C \uC2A4\uD0A4\uB9C8 \uC815\uC758 \uD56D\uBAA9\uB4E4 \uAD6C\uD558\uAE30
				itemList = schemaList[ i ].split( "\\t" );
				//debugLogger.printLogAtIS("itemList.length : " + itemList.length);
				parentPath = itemList[ 0 ].trim();
				fieldName = itemList[ 1 ];
				fieldDesc = itemList[ 2 ];
				dataType = itemList[ 4 ].trim().toUpperCase();
				paddingChar = itemList[ 5 ];
				paddingDirection = itemList[ 6 ].trim().toUpperCase();
				fieldLength = itemList[ 7 ].trim();
				lengthStart = itemList[ 8 ].trim();
				lengthLoc = itemList[ 9 ].trim();
				lengthLength = itemList[ 10 ].trim();
				fieldType = itemList[ 11 ].trim();
				
				// \uB9C8\uC9C0\uB9C9 Schema Define\uC758 Field Type\uC774 OT\uC778 \uACBD\uC6B0\uC5D0\uB294 OT Value Type, OT Value\uB3C4 \uAC12\uC774 \uC874\uC7AC\uD558\uAE30 \uB54C\uBB38\uC5D0 itemList.length == 14 \uAC00 \uB418\uB294\uB370
				// ST, OS\uC778 \uACBD\uC6B0\uC5D0\uB294 OT Value Type, OT Value \uAC12\uC774 \uC5C6\uAE30 \uB54C\uBB38\uC5D0 itemList.length == 12 \uAC00 \uB41C\uB2E4.
				// \uADF8\uB7EC\uB098 \uB9C8\uC9C0\uB9C9 Schema Define \uC774\uC804\uC5D0 \uC788\uB294 \uAC83\uB4E4\uC740 OT Value Type, OT Value \uAC12\uC774 \uC5C6\uB354\uB77C\uB3C4 \uB05D\uBD80\uBD84\uC5D0 \uC5D4\uD130\uAC00 \uC788\uAE30 \uB54C\uBB38\uC5D0 itemList.length == 14 \uAC00 \uB41C\uB2E4.
				// \uADF8\uB7EC\uBBC0\uB85C \uB9C8\uC9C0\uB9C9 Schema Define\uC758 Field Type\uC774 ST, OS\uC778 \uACBD\uC6B0\uC5D0 OT Value Type, OT Value \uAC12\uC774 \uC5C6\uB354\uB77C\uB3C4 \uB05D\uBD80\uBD84\uC5D0 \uC5D4\uD130\uAC00 \uC788\uC73C\uBA74 itemList.length == 14 \uAC00 \uB41C\uB2E4.
				if ( itemList.length <= 12 ) {
					otValueType = "";
					otValue = "";
				} else {
					otValueType = itemList[ 12 ].trim();
					otValue = itemList[ 13 ].replaceAll( "\r\n|\r|\n|\n\r", "");
				}
				// \uB9C8\uC9C0\uB9C9 \uBD80\uBD84\uC5D0\uB294 \uC5D4\uD130\uAC00 \uD3EC\uD568\uB418\uC5B4 \uC788\uAE30 \uB54C\uBB38\uC5D0 trim \uB610\uB294 replaceAll\uC744 \uC774\uC6A9\uD574\uC11C \uC5D4\uD130\uB97C \uC81C\uAC70\uD574\uC57C \uD55C\uB2E4.
				// fieldType\uC774 OT\uB85C \uC124\uC815\uB418\uC5B4 \uC788\uC744 \uACBD\uC6B0 Fixed Value \uAC12\uC744 \uADF8\uB300\uB85C \uC720\uC9C0\uD558\uAE30 \uC704\uD574\uC11C replaceAll\uC744 \uC0AC\uC6A9\uD55C\uB2E4.
				//debugLogger.printLogAtIS("parentPath : " + parentPath);
				//debugLogger.printLogAtIS("fieldName : " + fieldName);
				if ( paddingChar.equals( "" ) ) {
					if ( dataType.equals( "S" ) ) {
						// \uBB38\uC790\uD615\uC778 \uACBD\uC6B0
						paddingChar = " ";
					} else if ( dataType.equals( "N" ) ) {
						// \uC22B\uC790\uD615\uC778 \uACBD\uC6B0
						paddingChar = "0";
					}
				}
			
				if ( paddingDirection.equals( "" ) ) {
					if ( dataType.equals( "S" ) ) {
						// \uBB38\uC790\uD615\uC778 \uACBD\uC6B0
						paddingDirection = "RP";
					} else if ( dataType.equals( "N" ) ) {
						// \uC22B\uC790\uD615\uC778 \uACBD\uC6B0
						paddingDirection = "LP";
					}
				}
				
				if ( lengthStart.equals( "" ) ) {
					lengthStart = "N";
				}
				
				if ( fieldType.equals( "" ) ) {
					fieldType = "ST";
				}
				
				if ( lengthStart.equals( "Y" ) ) {
					lengthStart = lengthStart + "$" + lengthLoc + "$" + lengthLength;
				}
				
				if ( fieldType.equals( "OT" ) ) {
					fieldType = fieldType + "$" + otValueType + "$" + otValue;
				}
			
				// \uD544\uB4DC\uC5D0 \uB300\uD55C Schema \uC815\uC758 \uC0DD\uC131
				fieldSchema = fieldLength + "/" + paddingChar + "/" + paddingDirection + "/" + fieldDesc + "/" + dataType + "/" + lengthStart + "/" + fieldType;
				
				if ( parentPath.equals( "" ) ) {
					// Group \uB610\uB294 Array\uB85C \uBB36\uC774\uC9C0 \uC54A\uB294 Root Level\uC758 \uD544\uB4DC
					docCursor.last();
					docCursor.insertAfter( fieldName, fieldSchema );
					schemaDefineCount = schemaDefineCount + 1;
				} else {
					parentList = parentPath.split( "/" );
					
					if ( !beforePath.equals( parentPath ) ) {
						// Path\uAC00 \uBC14\uB010 \uACBD\uC6B0 ==> Path\uAC00 \uC0DD\uC131\uB418\uC5B4 \uC788\uB294\uC9C0 \uD655\uC778
						existResult = existParentPath( schemaDef, parentList, 0 );
						exists = existResult[ 0 ];
						noSeq = Integer.parseInt( existResult[ 1 ] );
						
						if ( exists.equals( "false" ) ) {
							// Path\uAC00 \uC0DD\uC131\uB418\uC5B4 \uC788\uC9C0 \uC54A\uC740 \uACBD\uC6B0 ==> Path\uAC00 \uC0DD\uC131\uB418\uC5B4 \uC788\uC9C0 \uC54A\uC740 \uC704\uCE58 \uC774\uD558\uC758 \uBAA8\uB4E0 Path\uB97C \uC0DD\uC131\uD55C\uB2E4.
							for ( int j = 0; j < parentList.length; j++ ) {
								if ( j == 0 ) {
									noPath = parentList[ j ];
								} else {
									noPath = noPath + "/" + parentList[ j ];
								}
								
								if ( j >= noSeq ) {
									noPathList = noPath.split( "/" );
									schemaDef = createParentPath( schemaDef, noPathList, 0 );
								}
							}
						}
					}
					
					// Schema Define Value \uC14B\uD305
					schemaDef = setSchemaDefValue( schemaDef, parentList, 0, fieldName, fieldSchema );
					schemaDefineCount = schemaDefineCount + 1;
				}
				
				beforePath = parentPath;
			}
			
			if ( schemaDefineCount == 0 ) {
				// schemaDef IData\uC5D0 Object\uAC00 \uD558\uB098\uB3C4 \uC0DD\uC131\uB418\uC9C0 \uC54A\uC740 \uACBD\uC6B0
				errorMsg = "Schema Define IData\uC5D0 Object\uAC00 \uD558\uB098\uB3C4 \uC0DD\uC131\uB418\uC9C0 \uC54A\uC558\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		docCursor.destroy();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "schemaDef", schemaDef );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void createSchemaDef2 (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createSchemaDef2)>> ---
		// @sigtype java 3.5
		// [i] field:0:required schemaDefine
		// [o] field:0:required errorMsg
		// [o] record:0:required schemaDef
		IDataCursor pipelineCursor = pipeline.getCursor();
		String schemaDefine = IDataUtil.getString( pipelineCursor, "schemaDefine" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		
		IData schemaDef = IDataFactory.create();
		IDataCursor docCursor = schemaDef.getCursor();
		String curKey = "";
		
		String[] schemaList = null;
		String[] itemList = null;
		String[] parentList = null;
		String[] existResult = null;
		String exists = "";
		int noSeq = 0;
		String noPath = "";
		String[] noPathList = null;
		String parentPath = "";
		String fieldName = "";
		String fieldDesc = "";
		String dataType = "";
		String paddingChar = "";
		String paddingDirection = "";
		String fieldLength = "";
		String lengthStart = "";
		String fieldType = "";
		String fieldSchema = "";
		String beforePath = "";		
		
		try {
			// \uD544\uB4DC\uBCC4 \uC2A4\uD0A4\uB9C8 \uC815\uC758 \uBAA9\uB85D \uAD6C\uD558\uAE30
			schemaList = schemaDefine.split( "\\n" );
			//debugLogger.printLogAtIS("schemaList.length : " + schemaList.length);
			for ( int i = 0; i < schemaList.length; i++ ) {
				//debugLogger.printLogAtIS("schemaList[ " + i + " ] : " + schemaList[i]);
				// \uAC01 \uD544\uB4DC\uC5D0 \uB300\uD55C \uC2A4\uD0A4\uB9C8 \uC815\uC758 \uD56D\uBAA9\uB4E4 \uAD6C\uD558\uAE30
				itemList = schemaList[ i ].split( "\\t" );
				parentPath = itemList[ 0 ].trim();
				fieldName = itemList[ 1 ];
				fieldDesc = itemList[ 2 ];
				dataType = itemList[ 3 ].trim().toUpperCase();
				paddingChar = itemList[ 4 ];
				paddingDirection = itemList[ 5 ].trim().toUpperCase();
				fieldLength = itemList[ 6 ].trim();
				lengthStart = itemList[ 7 ].trim();
				fieldType = itemList[ 8 ].replaceAll( "\r\n|\r|\n|\n\r", "");
				// \uB9C8\uC9C0\uB9C9 \uBD80\uBD84\uC5D0\uB294 \uC5D4\uD130\uAC00 \uD3EC\uD568\uB418\uC5B4 \uC788\uAE30 \uB54C\uBB38\uC5D0 trim \uB610\uB294 replaceAll\uC744 \uC774\uC6A9\uD574\uC11C \uC5D4\uD130\uB97C \uC81C\uAC70\uD574\uC57C \uD55C\uB2E4.
				// fieldType\uC774 OT\uB85C \uC124\uC815\uB418\uC5B4 \uC788\uC744 \uACBD\uC6B0 Fixed Value \uAC12\uC744 \uADF8\uB300\uB85C \uC720\uC9C0\uD558\uAE30 \uC704\uD574\uC11C replaceAll\uC744 \uC0AC\uC6A9\uD55C\uB2E4.
				debugLogger.printLogAtIS("parentPath : " + parentPath);
				debugLogger.printLogAtIS("fieldName : " + fieldName);
				if ( paddingChar.equals( "" ) ) {
					if ( dataType.equals( "S" ) ) {
						// \uBB38\uC790\uD615\uC778 \uACBD\uC6B0
						paddingChar = " ";
					} else if ( dataType.equals( "N" ) ) {
						// \uC22B\uC790\uD615\uC778 \uACBD\uC6B0
						paddingChar = "0";
					}
				}
			
				if ( paddingDirection.equals( "" ) ) {
					if ( dataType.equals( "S" ) ) {
						// \uBB38\uC790\uD615\uC778 \uACBD\uC6B0
						paddingDirection = "RP";
					} else if ( dataType.equals( "N" ) ) {
						// \uC22B\uC790\uD615\uC778 \uACBD\uC6B0
						paddingDirection = "LP";
					}
				}
				
				if ( lengthStart.equals( "" ) ) {
					lengthStart = "N";
				}
				
				if ( fieldType.equals( "" ) ) {
					fieldType = "ST";
				}
			
				// \uD544\uB4DC\uC5D0 \uB300\uD55C Schema \uC815\uC758 \uC0DD\uC131
				fieldSchema = fieldLength + "/" + paddingChar + "/" + paddingDirection + "/" + fieldDesc + "/" + dataType + "/" + lengthStart + "/" + fieldType;
				
				if ( parentPath.equals( "" ) ) {
					// Group \uB610\uB294 Array\uB85C \uBB36\uC774\uC9C0 \uC54A\uB294 Root Level\uC758 \uD544\uB4DC
					docCursor.last();
					docCursor.insertAfter( fieldName, fieldSchema );
				} else {
					parentList = parentPath.split( "/" );
					
					if ( !beforePath.equals( parentPath ) ) {
						// Path\uAC00 \uBC14\uB010 \uACBD\uC6B0 ==> Path\uAC00 \uC0DD\uC131\uB418\uC5B4 \uC788\uB294\uC9C0 \uD655\uC778
						existResult = existParentPath( schemaDef, parentList, 0 );
						exists = existResult[ 0 ];
						noSeq = Integer.parseInt( existResult[ 1 ] );
						
						if ( exists.equals( "false" ) ) {
							// Path\uAC00 \uC0DD\uC131\uB418\uC5B4 \uC788\uC9C0 \uC54A\uC740 \uACBD\uC6B0 ==> Path\uAC00 \uC0DD\uC131\uB418\uC5B4 \uC788\uC9C0 \uC54A\uC740 \uC704\uCE58 \uC774\uD558\uC758 \uBAA8\uB4E0 Path\uB97C \uC0DD\uC131\uD55C\uB2E4.
							for ( int j = 0; j < parentList.length; j++ ) {
								if ( j == 0 ) {
									noPath = parentList[ j ];
								} else {
									noPath = noPath + "/" + parentList[ j ];
								}
								
								if ( j >= noSeq ) {
									noPathList = noPath.split( "/" );
									schemaDef = createParentPath( schemaDef, noPathList, 0 );
								}
							}
						}
					}
					
					// Schema Define Value \uC14B\uD305
					schemaDef = setSchemaDefValue( schemaDef, parentList, 0, fieldName, fieldSchema );
				}
				
				beforePath = parentPath;
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		docCursor.destroy();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "schemaDef", schemaDef );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void createSchemaDef_20220715 (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createSchemaDef_20220715)>> ---
		// @sigtype java 3.5
		// [i] field:0:required schemaDefine
		// [o] field:0:required errorMsg
		// [o] record:0:required schemaDef
		IDataCursor pipelineCursor = pipeline.getCursor();
		String schemaDefine = IDataUtil.getString( pipelineCursor, "schemaDefine" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		Hashtable ht = new Hashtable();
		Hashtable htArrayName = new Hashtable();
		IData schemaDef = IDataFactory.create();
		IDataCursor docCursor = schemaDef.getCursor();
		IData groupDef = null; // Single Record \uAD6C\uC870\uC758 Group IData
		IDataCursor groupCursor = null;
		IData arrayGroupDef = null; // Array Record \uAD6C\uC870\uC758 Group IData
		IDataCursor arrayGroupCursor = null;
		IData tempIdata = null;
		IData tempIdata2 = null;
		IDataCursor tempCursor = null;
		IData[] tempArray = null;
		String tempArrayName = "";
		String[] schemaList = null;
		String[] itemList = null;
		String[] arrayAttrList = null;
		String arrayFlag = "";
		String realArrayFlag = "";
		String groupName = ""; // Single Record \uAD6C\uC870\uC758 Group Name
		String fieldName = "";
		String fieldDesc = "";
		String dataType = "";
		String paddingChar = "";
		String paddingDirection = "";
		String fieldLength = "";
		String targetFieldContainingYN = "";
		String fieldSchema = "";
		String arrayDepth = "";
		int arrayDepthNum = 0;
		String arrayName = "";
		String arrayGroupName = ""; // Array Record \uAD6C\uC870\uC758 Group Name
		String beforeArrayDepth = "0";
		int beforeArrayDepthNum = 0;
		String beforeArrayName = "";
		String addArray = "false";
		String endianDataType = "";
		String endianLength = "";
		String endianArrayCount = "";
		
		try {
			// \uD544\uB4DC\uBCC4 \uC2A4\uD0A4\uB9C8 \uC815\uC758 \uBAA9\uB85D \uAD6C\uD558\uAE30
			schemaList = schemaDefine.split( "\\n" );
			
			for ( int i = 0; i < schemaList.length; i++ ) {
				// \uAC01 \uD544\uB4DC\uC5D0 \uB300\uD55C \uC2A4\uD0A4\uB9C8 \uC815\uC758 \uD56D\uBAA9\uB4E4 \uAD6C\uD558\uAE30
				itemList = schemaList[ i ].split( "\\t" );
				
				if ( itemList.length == 6 ) {
					// \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
					arrayFlag = itemList[ 0 ].trim();
					//fieldName = itemList[ 1 ].trim();
					fieldName = itemList[ 1 ];
					fieldDesc = itemList[ 2 ];
					endianDataType = itemList[ 3 ];
					endianLength = itemList[ 4 ].trim();
					endianArrayCount = itemList[ 5 ].trim();
					
					// \uD544\uB4DC\uC5D0 \uB300\uD55C Schema \uC815\uC758 \uC0DD\uC131
					fieldSchema = endianDataType + "/" + endianLength + "/" + endianArrayCount + "/" + fieldDesc;
				} else {
					// Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uACBD\uC6B0 \uB610\uB294 \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
					arrayFlag = itemList[ 0 ].trim();
					//fieldName = itemList[ 1 ].trim();
					fieldName = itemList[ 1 ];
					fieldDesc = itemList[ 2 ];
					dataType = itemList[ 3 ].trim().toUpperCase();
					paddingChar = itemList[ 4 ];
					paddingDirection = itemList[ 5 ].trim().toUpperCase();
					fieldLength = itemList[ 6 ].trim();
					targetFieldContainingYN = itemList[ 7 ].trim().toUpperCase();
					
					if ( itemList.length == 10 ) {
						// \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
						endianDataType = itemList[ 7 ];
						endianLength = itemList[ 8 ].trim();
						endianArrayCount = itemList[ 9 ].trim();
					}
				
					if ( arrayFlag.equals( "s" ) ) {
						arrayFlag = "S";
					}
				
					if ( paddingChar.equals( "" ) ) {
						if ( dataType.equals( "S" ) ) {
							// \uBB38\uC790\uD615\uC778 \uACBD\uC6B0
							paddingChar = " ";
						} else if ( dataType.equals( "N" ) ) {
							// \uC22B\uC790\uD615\uC778 \uACBD\uC6B0
							paddingChar = "0";
						}
					}
				
					if ( paddingDirection.equals( "" ) ) {
						if ( dataType.equals( "S" ) ) {
							// \uBB38\uC790\uD615\uC778 \uACBD\uC6B0
							paddingDirection = "RP";
						} else if ( dataType.equals( "N" ) ) {
							// \uC22B\uC790\uD615\uC778 \uACBD\uC6B0
							paddingDirection = "LP";
						}
					}
					
					if ( targetFieldContainingYN.equals( "" ) ) {
						targetFieldContainingYN = "Y";
					}
				
					// \uD544\uB4DC\uC5D0 \uB300\uD55C Schema \uC815\uC758 \uC0DD\uC131
					fieldSchema = fieldLength + "/" + paddingChar + "/" + paddingDirection + "/" + fieldDesc + "/" + dataType + "/" + targetFieldContainingYN;
					
					if ( itemList.length == 10 ) {
						fieldSchema = fieldSchema + "/" + endianDataType + "/" + endianLength + "/" + endianArrayCount;
					}
				}
				
				arrayAttrList = arrayFlag.split( "/" );
				realArrayFlag = arrayAttrList[ 0 ].toUpperCase();
				
				if ( realArrayFlag.equals( "S" ) || realArrayFlag.equals( "SG" ) ) {
					// Single Record \uC601\uC5ED\uC758 \uD544\uB4DC\uC778 \uACBD\uC6B0
					if ( !arrayDepth.equals( "" ) ) {
						// \uC55E \uBD80\uBD84\uC5D0\uC11C Array\uAC00 \uC788\uC5C8\uACE0 Array\uAC00 \uB05D\uB09C \uD6C4 Single Record\uAC00 \uC788\uB294 \uACBD\uC6B0
						arrayDepthNum = Integer.parseInt( arrayDepth );
						
						for ( int j = arrayDepthNum; arrayDepthNum > 0; arrayDepthNum-- ) {
							tempArray = new IData[ 1 ];
							tempIdata = ( IData )ht.get( "tempIdata" + arrayDepthNum );
							tempArray[ 0 ] = tempIdata;
							tempArrayName = ( String )htArrayName.get( "arrayName" + arrayDepthNum );
							
							if ( arrayDepthNum == 1 ) {								
								// Root IData\uC5D0 IData Array Insert \uD558\uACE0 Hashtable \uCD08\uAE30\uD654
								docCursor.insertAfter( tempArrayName, tempArray );
								ht = null;
								htArrayName = null;
								ht = new Hashtable();
								htArrayName  = new Hashtable();
							} else {
								// \uD55C \uB2E8\uACC4 \uC704\uC758 Depth Idata\uC5D0 IData Array Insert \uD558\uACE0 Hashtable\uC5D0 \uB2E4\uC2DC \uC800\uC7A5
								tempIdata2 = ( IData )ht.get( "tempIdata" + ( arrayDepthNum - 1 ) );
								tempCursor = tempIdata2.getCursor();
								tempCursor.insertAfter( tempArrayName, tempArray );
								ht.put( "tempIdata" + ( arrayDepthNum - 1 ), tempIdata2) ;
								tempCursor.destroy();
								tempIdata2 = null;
							}
						}
						
						// Array \uC815\uBCF4 \uCD08\uAE30\uD654
						beforeArrayDepth = "0";
						beforeArrayName = "";
						arrayDepth = "";
					}					
					
					if ( realArrayFlag.equals( "S" ) ) {
						// Single Record \uAD6C\uC870\uC774\uBA74\uC11C Group\uC73C\uB85C \uBB36\uC774\uC9C0 \uC54A\uB294 \uACBD\uC6B0
						
						// \uC55E\uC5D0\uC11C SG \uC0DD\uC131\uC774 \uC788\uC5C8\uB358 \uACBD\uC6B0 schemaDef\uC5D0 SG\uB97C \uCD94\uAC00\uD55C\uB2E4.
						if ( groupDef != null ) {
							docCursor.insertAfter( groupName, groupDef );
							
							// SG \uC815\uBCF4 \uCD08\uAE30\uD654
							groupName = "";
							groupCursor.destroy();
							groupDef = null;
						}
						
						docCursor.insertAfter( fieldName, fieldSchema );
					} else if ( realArrayFlag.equals( "SG" ) ) {
						// Single Record \uAD6C\uC870\uC774\uBA74\uC11C Group\uC73C\uB85C \uBB36\uC774\uB294 \uACBD\uC6B0
						if ( groupName.equals( "" ) ) {
							groupName = arrayAttrList[ 1 ].trim();
						}
						
						if ( groupDef == null ) {
							groupDef  = IDataFactory.create();
							groupCursor = groupDef.getCursor();
						}
						
						groupCursor.insertAfter( fieldName, fieldSchema );
					}
				} else {
					// Array Record \uC601\uC5ED\uC758 \uD544\uB4DC\uC778 \uACBD\uC6B0
					
					// \uC55E\uC5D0\uC11C SG \uC0DD\uC131\uC774 \uC788\uC5C8\uB358 \uACBD\uC6B0 schemaDef\uC5D0 SG\uB97C \uCD94\uAC00\uD55C\uB2E4.
					if ( groupDef != null ) {
						docCursor.insertAfter( groupName, groupDef );
						
						// SG \uC815\uBCF4 \uCD08\uAE30\uD654
						groupName = "";
						groupCursor.destroy();
						groupDef = null;
					}
					
					//arrayAttrList = arrayFlag.split( "/" );
					arrayDepth = arrayAttrList[ 1 ].trim();
					arrayName = arrayAttrList[ 2 ].trim();
					
					if ( Integer.parseInt( beforeArrayDepth ) == Integer.parseInt( arrayDepth ) ) {
						if ( !beforeArrayName.equals( arrayName ) ) {
							// Array\uAC00 \uB05D\uB098\uACE0 \uBC14\uB85C \uAC19\uC740 Depth\uC758 \uB2E4\uB978 Array\uAC00 \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0 ==> \uC55E\uC758 Schema \uC815\uC758 IData Array \uCD94\uAC00
							arrayDepthNum = Integer.parseInt( arrayDepth );
							tempArray = new IData[ 1 ];
							tempIdata = ( IData )ht.get( "tempIdata" + arrayDepthNum );
							tempArray[ 0 ] = tempIdata;
							tempArrayName = ( String )htArrayName.get( "arrayName" + arrayDepthNum );
							
							if ( arrayDepthNum == 1 ) {								
								// Root IData\uC5D0 IData Array Insert \uD558\uACE0 Hashtable \uCD08\uAE30\uD654
								docCursor.insertAfter( tempArrayName, tempArray );
								ht = null;
								htArrayName = null;
								ht = new Hashtable();
								htArrayName  = new Hashtable();
							} else {
								// \uD55C \uB2E8\uACC4 \uC704\uC758 Depth Idata\uC5D0 IData Array Insert \uD558\uACE0 Hashtable\uC5D0 \uB2E4\uC2DC \uC800\uC7A5
								tempIdata2 = ( IData )ht.get( "tempIdata" + ( arrayDepthNum - 1 ) );
								tempCursor = tempIdata2.getCursor();
								tempCursor.insertAfter( tempArrayName, tempArray );
								ht.put( "tempIdata" + ( arrayDepthNum - 1 ), tempIdata2) ;
								ht.remove( "tempIdata" + arrayDepthNum );
								htArrayName.remove( "tempIdata" + arrayDepthNum );
								tempCursor.destroy();
								tempIdata2 = null;
							}
							
							addArray = "false";
						}
					} else if ( Integer.parseInt( beforeArrayDepth ) > Integer.parseInt( arrayDepth ) ) {
						// 2 Depth \uC774\uC0C1\uC758 Array\uAC00 \uB05D\uB098\uACE0 \uBC14\uB85C \uB2E4\uB978 Array\uAC00 \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0 ==> \uC55E\uC758 Schema \uC815\uC758 IData Array \uCD94\uAC00
						beforeArrayDepthNum = Integer.parseInt( beforeArrayDepth );
						
						for ( int j = beforeArrayDepthNum; beforeArrayDepthNum > 0; beforeArrayDepthNum-- ) {
							tempArray = new IData[ 1 ];
							tempIdata = ( IData )ht.get( "tempIdata" + beforeArrayDepthNum );
							tempArray[ 0 ] = tempIdata;
							tempArrayName = ( String )htArrayName.get( "arrayName" + beforeArrayDepthNum );
							
							if ( beforeArrayDepthNum == 1 ) {								
								// Root IData\uC5D0 IData Array Insert \uD558\uACE0 Hashtable \uCD08\uAE30\uD654
								docCursor.insertAfter( tempArrayName, tempArray );
								ht = null;
								htArrayName = null;
								ht = new Hashtable();
								htArrayName  = new Hashtable();
							} else {
								// \uD55C \uB2E8\uACC4 \uC704\uC758 Depth Idata\uC5D0 IData Array Insert \uD558\uACE0 Hashtable\uC5D0 \uB2E4\uC2DC \uC800\uC7A5
								tempIdata2 = ( IData )ht.get( "tempIdata" + ( beforeArrayDepthNum - 1 ) );
								tempCursor = tempIdata2.getCursor();
								tempCursor.insertAfter( tempArrayName, tempArray );
								ht.put( "tempIdata" + ( beforeArrayDepthNum - 1 ), tempIdata2) ;
								tempCursor.destroy();
								tempIdata2 = null;
							}
						}
						
						addArray = "false";
					} else  if ( Integer.parseInt( beforeArrayDepth ) < Integer.parseInt( arrayDepth ) ) {
						// 2 Depth \uC774\uC0C1\uC758 Array\uAC00 \uC874\uC7AC\uD558\uACE0 \uD558\uC704 2 Depth \uC774\uC0C1\uC758 Array\uB97C \uCC98\uB9AC\uD558\uB294 \uACBD\uC6B0
						addArray = "false";
					}
					
					if ( realArrayFlag.equals( "A" ) ) {
						// Array Record \uAD6C\uC870\uC774\uBA74\uC11C Group\uC73C\uB85C \uBB36\uC774\uC9C0 \uC54A\uB294 \uACBD\uC6B0
						if ( addArray.equals( "false" ) ) {
							// Hashtable\uC5D0 Array Schema \uC815\uC758\uB97C \uC704\uD55C IData\uB97C \uC800\uC7A5\uD558\uC9C0 \uC54A\uC740 \uACBD\uC6B0
							tempIdata = IDataFactory.create();
							tempCursor = tempIdata.getCursor();
							tempCursor.insertAfter( fieldName, fieldSchema );
							ht.put( "tempIdata" + arrayDepth, tempIdata) ;
							htArrayName.put( "arrayName" + arrayDepth, arrayName) ;
							addArray = "true";
							tempCursor.destroy();
							tempIdata = null;
						} else {
							// Hashtable\uC5D0 Array Schema \uC815\uC758\uB97C \uC704\uD55C IData\uB97C \uC55E\uC5D0\uC11C \uC800\uC7A5\uD55C \uACBD\uC6B0
							tempIdata = ( IData )ht.get( "tempIdata" + arrayDepth );
							tempCursor = tempIdata.getCursor();
							tempCursor.insertAfter( fieldName, fieldSchema );
							ht.put( "tempIdata" + arrayDepth, tempIdata) ;
							tempCursor.destroy();
							tempIdata = null;
						}
					} else if ( realArrayFlag.equals( "AG" ) ) {
						// Array Record \uAD6C\uC870\uC774\uBA74\uC11C Group\uC73C\uB85C \uBB36\uC774\uB294 \uACBD\uC6B0
						arrayGroupName = arrayAttrList[ 3 ].trim();
						
						if ( addArray.equals( "false" ) ) {
							// Hashtable\uC5D0 Array Schema \uC815\uC758\uB97C \uC704\uD55C IData\uB97C \uC800\uC7A5\uD558\uC9C0 \uC54A\uC740 \uACBD\uC6B0
							tempIdata = IDataFactory.create();
							tempCursor = tempIdata.getCursor();
							arrayGroupDef  = IDataFactory.create();
							arrayGroupCursor = arrayGroupDef.getCursor();
							arrayGroupCursor.insertAfter( fieldName, fieldSchema );
							tempCursor.insertAfter( arrayGroupName, arrayGroupDef ); // AG \uC0DD\uC131
							ht.put( "tempIdata" + arrayDepth, tempIdata) ;
							htArrayName.put( "arrayName" + arrayDepth, arrayName) ;
							addArray = "true";
							tempCursor.destroy();
							tempIdata = null;
							arrayGroupCursor.destroy();
							arrayGroupDef = null;
						} else {
							// Hashtable\uC5D0 Array Schema \uC815\uC758\uB97C \uC704\uD55C IData\uB97C \uC55E\uC5D0\uC11C \uC800\uC7A5\uD55C \uACBD\uC6B0
							tempIdata = ( IData )ht.get( "tempIdata" + arrayDepth );
							tempCursor = tempIdata.getCursor();
							arrayGroupDef = IDataUtil.getIData( tempCursor, arrayGroupName );
							
							if ( arrayGroupDef == null ) {
								// \uC544\uC9C1 AG \uC0DD\uC131\uC744 \uD558\uC9C0 \uC54A\uC740 \uACBD\uC6B0
								arrayGroupDef  = IDataFactory.create();
								arrayGroupCursor = arrayGroupDef.getCursor();
								arrayGroupCursor.insertAfter( fieldName, fieldSchema );
								tempCursor.insertAfter( arrayGroupName, arrayGroupDef ); // AG \uC0DD\uC131
							} else {
								// \uC55E\uC5D0\uC11C AG\uB97C \uC0DD\uC131\uD55C \uACBD\uC6B0
								arrayGroupCursor = arrayGroupDef.getCursor();
								arrayGroupCursor.insertAfter( fieldName, fieldSchema ); // \uAE30\uC874 AG\uC5D0 \uD544\uB4DC \uCD94\uAC00
							}
							
							ht.put( "tempIdata" + arrayDepth, tempIdata) ;
							tempCursor.destroy();
							tempIdata = null;
							arrayGroupCursor.destroy();
							arrayGroupDef = null;
						}
					}
					
					beforeArrayDepth = arrayDepth;
					beforeArrayName = arrayName;
				}
				
				arrayFlag = "";
				fieldName = "";
				fieldSchema = "";
			}
			
			// for\uBB38 \uBAA8\uB450 \uC218\uD589 \uD6C4 \uB9C8\uC9C0\uB9C9\uC5D0 schemaDef\uC5D0 \uCD94\uAC00\uD558\uC9C0 \uBABB\uD55C \uD56D\uBAA9\uC5D0 \uB300\uD574\uC11C \uCC98\uB9AC\uD558\uAE30
			if ( !arrayDepth.equals( "" ) ) {
				// \uC55E \uBD80\uBD84\uC5D0\uC11C Array\uAC00 \uC788\uC5C8\uACE0 Array \uB4A4\uC5D0 Single Record \uC5C6\uC774 Array\uAC00 \uB05D\uB09C \uACBD\uC6B0
				arrayDepthNum = Integer.parseInt( arrayDepth );
				
				for ( int j = arrayDepthNum; arrayDepthNum > 0; arrayDepthNum-- ) {
					tempArray = new IData[ 1 ];
					tempIdata = ( IData )ht.get( "tempIdata" + arrayDepthNum );
					tempArray[ 0 ] = tempIdata;
					tempArrayName = ( String )htArrayName.get( "arrayName" + arrayDepthNum );
					
					if ( arrayDepthNum == 1 ) {								
						// Root IData\uC5D0 IData Array Insert \uD558\uACE0 Hashtable \uCD08\uAE30\uD654
						docCursor.insertAfter( tempArrayName, tempArray );
						ht = null;
						htArrayName = null;
						ht = new Hashtable();
						htArrayName  = new Hashtable();
					} else {
						// \uD55C \uB2E8\uACC4 \uC704\uC758 Depth Idata\uC5D0 IData Array Insert \uD558\uACE0 Hashtable\uC5D0 \uB2E4\uC2DC \uC800\uC7A5
						tempIdata2 = ( IData )ht.get( "tempIdata" + ( arrayDepthNum - 1 ) );
						tempCursor = tempIdata2.getCursor();
						tempCursor.insertAfter( tempArrayName, tempArray );
						ht.put( "tempIdata" + ( arrayDepthNum - 1 ), tempIdata2) ;
						tempCursor.destroy();
						tempIdata2 = null;
					}
				}
			} else {
				// \uC55E\uC5D0\uC11C SG \uC0DD\uC131\uC774 \uC788\uC5C8\uACE0 SG\uB85C \uB05D\uB09C \uACBD\uC6B0 schemaDef\uC5D0 SG\uB97C \uCD94\uAC00\uD55C\uB2E4.
				if ( groupDef != null ) {
					docCursor.insertAfter( groupName, groupDef );
					
					// SG \uC815\uBCF4 \uCD08\uAE30\uD654
					groupName = "";
					groupCursor.destroy();
					groupDef = null;
				}
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		ht = null;
		htArrayName = null;
		docCursor.destroy();
		tempIdata = null;
		tempIdata2 = null;
		tempArray = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "schemaDef", schemaDef );
		pipelineCursor_1.destroy();		
		// --- <<IS-END>> ---

                
	}



	public static final void createSchemaDef_20220804 (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createSchemaDef_20220804)>> ---
		// @sigtype java 3.5
		// [i] field:0:required schemaDefine
		// [o] field:0:required errorMsg
		// [o] record:0:required schemaDef
		IDataCursor pipelineCursor = pipeline.getCursor();
		String schemaDefine = IDataUtil.getString( pipelineCursor, "schemaDefine" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		Hashtable ht = new Hashtable();
		Hashtable htArrayName = new Hashtable();
		IData schemaDef = IDataFactory.create();
		IDataCursor docCursor = schemaDef.getCursor();
		IData groupDef = null; // Single Record \uAD6C\uC870\uC758 Group IData
		IDataCursor groupCursor = null;
		IData arrayGroupDef = null; // Array Record \uAD6C\uC870\uC758 Group IData
		IDataCursor arrayGroupCursor = null;
		IData tempIdata = null;
		IData tempIdata2 = null;
		IDataCursor tempCursor = null;
		IData[] tempArray = null;
		String tempArrayName = "";
		String[] schemaList = null;
		String[] itemList = null;
		String[] arrayAttrList = null;
		String arrayFlag = "";
		String realArrayFlag = "";
		String groupName = ""; // Single Record \uAD6C\uC870\uC758 Group Name
		String fieldName = "";
		String fieldDesc = "";
		String dataType = "";
		String paddingChar = "";
		String paddingDirection = "";
		String fieldLength = "";
		String lengthStart = "";
		String fieldType = "";
		String fieldSchema = "";
		String arrayDepth = "";
		int arrayDepthNum = 0;
		String arrayName = "";
		String arrayGroupName = ""; // Array Record \uAD6C\uC870\uC758 Group Name
		String beforeArrayDepth = "0";
		int beforeArrayDepthNum = 0;
		String beforeArrayName = "";
		String addArray = "false";
		String endianDataType = "";
		String endianLength = "";
		String endianArrayCount = "";
		
		try {
			// \uD544\uB4DC\uBCC4 \uC2A4\uD0A4\uB9C8 \uC815\uC758 \uBAA9\uB85D \uAD6C\uD558\uAE30
			schemaList = schemaDefine.split( "\\n" );
			
			for ( int i = 0; i < schemaList.length; i++ ) {
				// \uAC01 \uD544\uB4DC\uC5D0 \uB300\uD55C \uC2A4\uD0A4\uB9C8 \uC815\uC758 \uD56D\uBAA9\uB4E4 \uAD6C\uD558\uAE30
				itemList = schemaList[ i ].split( "\\t" );
				
				if ( itemList.length == 6 ) {
					// \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
					arrayFlag = itemList[ 0 ].trim();
					//fieldName = itemList[ 1 ].trim();
					fieldName = itemList[ 1 ];
					fieldDesc = itemList[ 2 ];
					endianDataType = itemList[ 3 ];
					endianLength = itemList[ 4 ].trim();
					endianArrayCount = itemList[ 5 ].trim();
					
					// \uD544\uB4DC\uC5D0 \uB300\uD55C Schema \uC815\uC758 \uC0DD\uC131
					fieldSchema = endianDataType + "/" + endianLength + "/" + endianArrayCount + "/" + fieldDesc;
				} else {
					// Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uACBD\uC6B0 \uB610\uB294 \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
					arrayFlag = itemList[ 0 ].trim();
					//fieldName = itemList[ 1 ].trim();
					fieldName = itemList[ 1 ];
					fieldDesc = itemList[ 2 ];
					dataType = itemList[ 3 ].trim().toUpperCase();
					paddingChar = itemList[ 4 ];
					paddingDirection = itemList[ 5 ].trim().toUpperCase();
					fieldLength = itemList[ 6 ].trim();
					lengthStart = itemList[ 7 ].trim();
					fieldType = itemList[ 8 ].replaceAll( "\r\n|\r|\n|\n\r", "");
					// \uB9C8\uC9C0\uB9C9 \uBD80\uBD84\uC5D0\uB294 \uC5D4\uD130\uAC00 \uD3EC\uD568\uB418\uC5B4 \uC788\uAE30 \uB54C\uBB38\uC5D0 trim \uB610\uB294 replaceAll\uC744 \uC774\uC6A9\uD574\uC11C \uC5D4\uD130\uB97C \uC81C\uAC70\uD574\uC57C \uD55C\uB2E4.
					// fieldType\uC774 OT\uB85C \uC124\uC815\uB418\uC5B4 \uC788\uC744 \uACBD\uC6B0 Fixed Value \uAC12\uC744 \uADF8\uB300\uB85C \uC720\uC9C0\uD558\uAE30 \uC704\uD574\uC11C replaceAll\uC744 \uC0AC\uC6A9\uD55C\uB2E4.
					
					if ( itemList.length == 10 ) {
						// \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
						endianDataType = itemList[ 7 ];
						endianLength = itemList[ 8 ].trim();
						endianArrayCount = itemList[ 9 ].trim();
					}
				
					if ( arrayFlag.equals( "s" ) ) {
						arrayFlag = "S";
					}
				
					if ( paddingChar.equals( "" ) ) {
						if ( dataType.equals( "S" ) ) {
							// \uBB38\uC790\uD615\uC778 \uACBD\uC6B0
							paddingChar = " ";
						} else if ( dataType.equals( "N" ) ) {
							// \uC22B\uC790\uD615\uC778 \uACBD\uC6B0
							paddingChar = "0";
						}
					}
				
					if ( paddingDirection.equals( "" ) ) {
						if ( dataType.equals( "S" ) ) {
							// \uBB38\uC790\uD615\uC778 \uACBD\uC6B0
							paddingDirection = "RP";
						} else if ( dataType.equals( "N" ) ) {
							// \uC22B\uC790\uD615\uC778 \uACBD\uC6B0
							paddingDirection = "LP";
						}
					}
					
					if ( lengthStart.equals( "" ) ) {
						lengthStart = "N";
					}
					
					if ( fieldType.equals( "" ) ) {
						fieldType = "ST";
					}
				
					// \uD544\uB4DC\uC5D0 \uB300\uD55C Schema \uC815\uC758 \uC0DD\uC131
					fieldSchema = fieldLength + "/" + paddingChar + "/" + paddingDirection + "/" + fieldDesc + "/" + dataType + "/" + lengthStart + "/" + fieldType;
					
					if ( itemList.length == 10 ) {
						fieldSchema = fieldSchema + "/" + endianDataType + "/" + endianLength + "/" + endianArrayCount;
					}
				}
				
				arrayAttrList = arrayFlag.split( "/" );
				realArrayFlag = arrayAttrList[ 0 ].toUpperCase();
				
				if ( realArrayFlag.equals( "S" ) || realArrayFlag.equals( "SG" ) ) {
					// Single Record \uC601\uC5ED\uC758 \uD544\uB4DC\uC778 \uACBD\uC6B0
					if ( !arrayDepth.equals( "" ) ) {
						// \uC55E \uBD80\uBD84\uC5D0\uC11C Array\uAC00 \uC788\uC5C8\uACE0 Array\uAC00 \uB05D\uB09C \uD6C4 Single Record\uAC00 \uC788\uB294 \uACBD\uC6B0
						arrayDepthNum = Integer.parseInt( arrayDepth );
						
						for ( int j = arrayDepthNum; arrayDepthNum > 0; arrayDepthNum-- ) {
							tempArray = new IData[ 1 ];
							tempIdata = ( IData )ht.get( "tempIdata" + arrayDepthNum );
							tempArray[ 0 ] = tempIdata;
							tempArrayName = ( String )htArrayName.get( "arrayName" + arrayDepthNum );
							
							if ( arrayDepthNum == 1 ) {								
								// Root IData\uC5D0 IData Array Insert \uD558\uACE0 Hashtable \uCD08\uAE30\uD654
								docCursor.insertAfter( tempArrayName, tempArray );
								ht = null;
								htArrayName = null;
								ht = new Hashtable();
								htArrayName  = new Hashtable();
							} else {
								// \uD55C \uB2E8\uACC4 \uC704\uC758 Depth Idata\uC5D0 IData Array Insert \uD558\uACE0 Hashtable\uC5D0 \uB2E4\uC2DC \uC800\uC7A5
								tempIdata2 = ( IData )ht.get( "tempIdata" + ( arrayDepthNum - 1 ) );
								tempCursor = tempIdata2.getCursor();
								tempCursor.insertAfter( tempArrayName, tempArray );
								ht.put( "tempIdata" + ( arrayDepthNum - 1 ), tempIdata2) ;
								tempCursor.destroy();
								tempIdata2 = null;
							}
						}
						
						// Array \uC815\uBCF4 \uCD08\uAE30\uD654
						beforeArrayDepth = "0";
						beforeArrayName = "";
						arrayDepth = "";
					}					
					
					if ( realArrayFlag.equals( "S" ) ) {
						// Single Record \uAD6C\uC870\uC774\uBA74\uC11C Group\uC73C\uB85C \uBB36\uC774\uC9C0 \uC54A\uB294 \uACBD\uC6B0
						docCursor.insertAfter( fieldName, fieldSchema );
					} else if ( realArrayFlag.equals( "SG" ) ) {
						// Single Record \uAD6C\uC870\uC774\uBA74\uC11C Group\uC73C\uB85C \uBB36\uC774\uB294 \uACBD\uC6B0
						groupName = arrayAttrList[ 1 ].trim();
						groupDef = IDataUtil.getIData( docCursor, groupName );						
						
						if ( groupDef == null ) {
							// \uC544\uC9C1 SG \uC0DD\uC131\uC744 \uD558\uC9C0 \uC54A\uC740 \uACBD\uC6B0
							groupDef  = IDataFactory.create();
							groupCursor = groupDef.getCursor();
							groupCursor.insertAfter( fieldName, fieldSchema );
							docCursor.insertAfter( groupName, groupDef ); // SG \uC0DD\uC131
						} else {
							// \uC55E\uC5D0\uC11C SG\uB97C \uC0DD\uC131\uD55C \uACBD\uC6B0
							groupCursor = groupDef.getCursor();
							groupCursor.insertAfter( fieldName, fieldSchema ); // \uAE30\uC874 SG\uC5D0 \uD544\uB4DC \uCD94\uAC00
						}
						
						groupCursor.destroy();
						groupDef = null;
					}
				} else {
					// Array Record \uC601\uC5ED\uC758 \uD544\uB4DC\uC778 \uACBD\uC6B0
					arrayDepth = arrayAttrList[ 1 ].trim();
					arrayName = arrayAttrList[ 2 ].trim();
					
					if ( Integer.parseInt( beforeArrayDepth ) == Integer.parseInt( arrayDepth ) ) {
						if ( !beforeArrayName.equals( arrayName ) ) {
							// Array\uAC00 \uB05D\uB098\uACE0 \uBC14\uB85C \uAC19\uC740 Depth\uC758 \uB2E4\uB978 Array\uAC00 \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0 ==> \uC55E\uC758 Schema \uC815\uC758 IData Array \uCD94\uAC00
							arrayDepthNum = Integer.parseInt( arrayDepth );
							tempArray = new IData[ 1 ];
							tempIdata = ( IData )ht.get( "tempIdata" + arrayDepthNum );
							tempArray[ 0 ] = tempIdata;
							tempArrayName = ( String )htArrayName.get( "arrayName" + arrayDepthNum );
							
							if ( arrayDepthNum == 1 ) {								
								// Root IData\uC5D0 IData Array Insert \uD558\uACE0 Hashtable \uCD08\uAE30\uD654
								docCursor.insertAfter( tempArrayName, tempArray );
								ht = null;
								htArrayName = null;
								ht = new Hashtable();
								htArrayName  = new Hashtable();
							} else {
								// \uD55C \uB2E8\uACC4 \uC704\uC758 Depth Idata\uC5D0 IData Array Insert \uD558\uACE0 Hashtable\uC5D0 \uB2E4\uC2DC \uC800\uC7A5
								tempIdata2 = ( IData )ht.get( "tempIdata" + ( arrayDepthNum - 1 ) );
								tempCursor = tempIdata2.getCursor();
								tempCursor.insertAfter( tempArrayName, tempArray );
								ht.put( "tempIdata" + ( arrayDepthNum - 1 ), tempIdata2) ;
								ht.remove( "tempIdata" + arrayDepthNum );
								htArrayName.remove( "tempIdata" + arrayDepthNum );
								tempCursor.destroy();
								tempIdata2 = null;
							}
							
							addArray = "false";
						}
					} else if ( Integer.parseInt( beforeArrayDepth ) > Integer.parseInt( arrayDepth ) ) {
						// 2 Depth \uC774\uC0C1\uC758 Array\uAC00 \uB05D\uB098\uACE0 \uBC14\uB85C \uB2E4\uB978 Array\uAC00 \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0 ==> \uC55E\uC758 Schema \uC815\uC758 IData Array \uCD94\uAC00
						beforeArrayDepthNum = Integer.parseInt( beforeArrayDepth );
						
						for ( int j = beforeArrayDepthNum; beforeArrayDepthNum > 0; beforeArrayDepthNum-- ) {
							tempArray = new IData[ 1 ];
							tempIdata = ( IData )ht.get( "tempIdata" + beforeArrayDepthNum );
							tempArray[ 0 ] = tempIdata;
							tempArrayName = ( String )htArrayName.get( "arrayName" + beforeArrayDepthNum );
							
							if ( beforeArrayDepthNum == 1 ) {								
								// Root IData\uC5D0 IData Array Insert \uD558\uACE0 Hashtable \uCD08\uAE30\uD654
								docCursor.insertAfter( tempArrayName, tempArray );
								ht = null;
								htArrayName = null;
								ht = new Hashtable();
								htArrayName  = new Hashtable();
							} else {
								// \uD55C \uB2E8\uACC4 \uC704\uC758 Depth Idata\uC5D0 IData Array Insert \uD558\uACE0 Hashtable\uC5D0 \uB2E4\uC2DC \uC800\uC7A5
								tempIdata2 = ( IData )ht.get( "tempIdata" + ( beforeArrayDepthNum - 1 ) );
								tempCursor = tempIdata2.getCursor();
								tempCursor.insertAfter( tempArrayName, tempArray );
								ht.put( "tempIdata" + ( beforeArrayDepthNum - 1 ), tempIdata2) ;
								tempCursor.destroy();
								tempIdata2 = null;
							}
						}
						
						addArray = "false";
					} else  if ( Integer.parseInt( beforeArrayDepth ) < Integer.parseInt( arrayDepth ) ) {
						// 2 Depth \uC774\uC0C1\uC758 Array\uAC00 \uC874\uC7AC\uD558\uACE0 \uD558\uC704 2 Depth \uC774\uC0C1\uC758 Array\uB97C \uCC98\uB9AC\uD558\uB294 \uACBD\uC6B0
						addArray = "false";
					}
					
					if ( realArrayFlag.equals( "A" ) ) {
						// Array Record \uAD6C\uC870\uC774\uBA74\uC11C Group\uC73C\uB85C \uBB36\uC774\uC9C0 \uC54A\uB294 \uACBD\uC6B0
						if ( addArray.equals( "false" ) ) {
							// Hashtable\uC5D0 Array Schema \uC815\uC758\uB97C \uC704\uD55C IData\uB97C \uC800\uC7A5\uD558\uC9C0 \uC54A\uC740 \uACBD\uC6B0
							tempIdata = IDataFactory.create();
							tempCursor = tempIdata.getCursor();
							tempCursor.insertAfter( fieldName, fieldSchema );
							ht.put( "tempIdata" + arrayDepth, tempIdata) ;
							htArrayName.put( "arrayName" + arrayDepth, arrayName) ;
							addArray = "true";
							tempCursor.destroy();
							tempIdata = null;
						} else {
							// Hashtable\uC5D0 Array Schema \uC815\uC758\uB97C \uC704\uD55C IData\uB97C \uC55E\uC5D0\uC11C \uC800\uC7A5\uD55C \uACBD\uC6B0
							tempIdata = ( IData )ht.get( "tempIdata" + arrayDepth );
							tempCursor = tempIdata.getCursor();
							tempCursor.insertAfter( fieldName, fieldSchema );
							ht.put( "tempIdata" + arrayDepth, tempIdata) ;
							tempCursor.destroy();
							tempIdata = null;
						}
					} else if ( realArrayFlag.equals( "AG" ) ) {
						// Array Record \uAD6C\uC870\uC774\uBA74\uC11C Group\uC73C\uB85C \uBB36\uC774\uB294 \uACBD\uC6B0
						arrayGroupName = arrayAttrList[ 3 ].trim();
						
						if ( addArray.equals( "false" ) ) {
							// Hashtable\uC5D0 Array Schema \uC815\uC758\uB97C \uC704\uD55C IData\uB97C \uC800\uC7A5\uD558\uC9C0 \uC54A\uC740 \uACBD\uC6B0
							tempIdata = IDataFactory.create();
							tempCursor = tempIdata.getCursor();
							arrayGroupDef  = IDataFactory.create();
							arrayGroupCursor = arrayGroupDef.getCursor();
							arrayGroupCursor.insertAfter( fieldName, fieldSchema );
							tempCursor.insertAfter( arrayGroupName, arrayGroupDef ); // AG \uC0DD\uC131
							ht.put( "tempIdata" + arrayDepth, tempIdata) ;
							htArrayName.put( "arrayName" + arrayDepth, arrayName) ;
							addArray = "true";
							tempCursor.destroy();
							tempIdata = null;
							arrayGroupCursor.destroy();
							arrayGroupDef = null;
						} else {
							// Hashtable\uC5D0 Array Schema \uC815\uC758\uB97C \uC704\uD55C IData\uB97C \uC55E\uC5D0\uC11C \uC800\uC7A5\uD55C \uACBD\uC6B0
							tempIdata = ( IData )ht.get( "tempIdata" + arrayDepth );
							tempCursor = tempIdata.getCursor();
							arrayGroupDef = IDataUtil.getIData( tempCursor, arrayGroupName );
							
							if ( arrayGroupDef == null ) {
								// \uC544\uC9C1 AG \uC0DD\uC131\uC744 \uD558\uC9C0 \uC54A\uC740 \uACBD\uC6B0
								arrayGroupDef  = IDataFactory.create();
								arrayGroupCursor = arrayGroupDef.getCursor();
								arrayGroupCursor.insertAfter( fieldName, fieldSchema );
								tempCursor.insertAfter( arrayGroupName, arrayGroupDef ); // AG \uC0DD\uC131
							} else {
								// \uC55E\uC5D0\uC11C AG\uB97C \uC0DD\uC131\uD55C \uACBD\uC6B0
								arrayGroupCursor = arrayGroupDef.getCursor();
								arrayGroupCursor.insertAfter( fieldName, fieldSchema ); // \uAE30\uC874 AG\uC5D0 \uD544\uB4DC \uCD94\uAC00
							}
							
							ht.put( "tempIdata" + arrayDepth, tempIdata) ;
							tempCursor.destroy();
							tempIdata = null;
							arrayGroupCursor.destroy();
							arrayGroupDef = null;
						}
					}
					
					beforeArrayDepth = arrayDepth;
					beforeArrayName = arrayName;
				}
				
				arrayFlag = "";
				fieldName = "";
				fieldSchema = "";
			}
			
			// for\uBB38 \uBAA8\uB450 \uC218\uD589 \uD6C4 \uB9C8\uC9C0\uB9C9\uC5D0 schemaDef\uC5D0 \uCD94\uAC00\uD558\uC9C0 \uBABB\uD55C \uD56D\uBAA9\uC5D0 \uB300\uD574\uC11C \uCC98\uB9AC\uD558\uAE30
			if ( !arrayDepth.equals( "" ) ) {
				// \uC55E \uBD80\uBD84\uC5D0\uC11C Array\uAC00 \uC788\uC5C8\uACE0 Array \uB4A4\uC5D0 Single Record \uC5C6\uC774 Array\uAC00 \uB05D\uB09C \uACBD\uC6B0
				arrayDepthNum = Integer.parseInt( arrayDepth );
				
				for ( int j = arrayDepthNum; arrayDepthNum > 0; arrayDepthNum-- ) {
					tempArray = new IData[ 1 ];
					tempIdata = ( IData )ht.get( "tempIdata" + arrayDepthNum );
					tempArray[ 0 ] = tempIdata;
					tempArrayName = ( String )htArrayName.get( "arrayName" + arrayDepthNum );
					
					if ( arrayDepthNum == 1 ) {								
						// Root IData\uC5D0 IData Array Insert \uD558\uACE0 Hashtable \uCD08\uAE30\uD654
						docCursor.insertAfter( tempArrayName, tempArray );
						ht = null;
						htArrayName = null;
						ht = new Hashtable();
						htArrayName  = new Hashtable();
					} else {
						// \uD55C \uB2E8\uACC4 \uC704\uC758 Depth Idata\uC5D0 IData Array Insert \uD558\uACE0 Hashtable\uC5D0 \uB2E4\uC2DC \uC800\uC7A5
						tempIdata2 = ( IData )ht.get( "tempIdata" + ( arrayDepthNum - 1 ) );
						tempCursor = tempIdata2.getCursor();
						tempCursor.insertAfter( tempArrayName, tempArray );
						ht.put( "tempIdata" + ( arrayDepthNum - 1 ), tempIdata2) ;
						tempCursor.destroy();
						tempIdata2 = null;
					}
				}
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		ht = null;
		htArrayName = null;
		docCursor.destroy();
		tempIdata = null;
		tempIdata2 = null;
		tempArray = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "schemaDef", schemaDef );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getHttpHeaderNameValue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getHttpHeaderNameValue)>> ---
		// @sigtype java 3.5
		// [i] record:0:required httpHeader
		// [i] field:0:required delim {"comma","enter"}
		// [o] field:0:required headerNameValue
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData httpHeader = IDataUtil.getIData( pipelineCursor, "httpHeader" );
		String delim = IDataUtil.getString( pipelineCursor, "delim" );
		pipelineCursor.destroy();
		
		IDataCursor cur = httpHeader.getCursor();
		String curKey = null;
		Object obj = null;
		String keyValue = "";
		
		String headerNameValue = "";
		
		try {
			while ( cur.next() ) {
				curKey = cur.getKey();
				obj = cur.getValue();
		
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) { // obj is String
					keyValue = ( String )obj;
					
					if ( headerNameValue.equals( "" ) ) {
						headerNameValue = curKey + ": " + keyValue;
					} else {
						if ( delim.equals( "comma" ) ) {
							headerNameValue = headerNameValue + ", " + curKey + ": " + keyValue;
						} else if ( delim.equals( "enter" ) ) {
							headerNameValue = headerNameValue + "\n" + curKey + ": " + keyValue;
						} else {
							headerNameValue = headerNameValue + ", " + curKey + ": " + keyValue;
						}
					}
				} else {
					continue;
				}
			}
		} catch ( Exception e ) {
			
		}
		
		cur.destroy();
		obj = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "headerNameValue", headerNameValue );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void setHttpHeaderNameValue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(setHttpHeaderNameValue)>> ---
		// @sigtype java 3.5
		// [i] field:1:required headerNameValueList
		// [i] field:0:required delim
		// [o] field:0:required errorMsg
		// [o] record:0:required httpHeader
		IDataCursor pipelineCursor = pipeline.getCursor();
		String[] headerNameValueList = IDataUtil.getStringArray( pipelineCursor, "headerNameValueList" );
		// delimiter\uAC00 \uD2B9\uC218\uBB38\uC790\uC77C \uACBD\uC6B0\uC5D0\uB294 Input/delim \uC5D0 \\uD2B9\uC218\uBB38\uC790 \uD615\uD0DC\uB85C \uB118\uACA8\uC918\uC57C \uD55C\uB2E4 (/ \uB294 \uC0AC\uC6A9\uD560 \uC218 \uC5C6\uB2E4).
		String delim = IDataUtil.getString( pipelineCursor, "delim" );
		pipelineCursor.destroy();
		
		IData httpHeader = IDataFactory.create();
		IDataCursor cur = httpHeader.getCursor();
		int headerCount = headerNameValueList.length;
		String[] nameValue = null;
		
		String errorMsg = "";
		
		try {
			for ( int i = 0; i < headerCount; i++ ) {
				nameValue = headerNameValueList[ i ].split( delim );
				cur.insertAfter( nameValue[ 0 ], nameValue[ 1 ] );
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		cur.destroy();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "httpHeader", httpHeader );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static DebugLogger debugLogger = new DebugLogger();
	private static final String DEBUG_LEVEL = "4";
	
	public static String[] existParentPath( IData schemaDef, String[] pathList, int pathSeq ) {
		IDataCursor cur = schemaDef.getCursor();
		Object obj = null;
		String curKey = "";
		String pathName = pathList[ pathSeq ].replace( "[0]", "" );
		int pathSize = pathList.length;
		IData[] arrayIdata = null;
		String[] existResult = new String[ 2 ];
		String[] tempExistResult = new String[ 2 ];
		String exists = "false";
		String noSeq = pathSeq + "";
		//debugLogger.printLogAtIS("Exist ::: pathName : " + pathName);
		//debugLogger.printLogAtIS("Exist ::: pathSeq : " + pathSeq);
		while ( cur.next() ) {
			curKey = cur.getKey();
			obj = cur.getValue();
			
			if ( obj == null ) {
				break;
			}
				
			if ( curKey.equals( pathName ) ) {
				exists = "true";
				
				if ( ( pathSize - 1 ) == pathSeq ) {
					break;
				}
				
				// existParentPath \uD638\uCD9C \uC2DC \uD30C\uB77C\uBA54\uD130\uB85C pathSeq++ \uB85C \uB118\uACA8\uC8FC\uBA74 pathSeq\uAC00 \uC99D\uAC00\uB418\uC9C0 \uC54A\uC740 \uC0C1\uD0DC\uB85C \uB118\uC5B4\uAC04\uB2E4.
				pathSeq++;
				
				if ( obj instanceof IData ) {
					tempExistResult = existParentPath( ( IData )obj, pathList, pathSeq );
					exists = tempExistResult[ 0 ];
					noSeq = tempExistResult[ 1 ];
					
					if ( exists.equals( "false" ) ) {
						break;
					}
				} else if ( obj instanceof IData[] ) {
					arrayIdata = ( IData[] )obj;
					tempExistResult = existParentPath( arrayIdata[ 0 ], pathList, pathSeq );
					exists = tempExistResult[ 0 ];
					noSeq = tempExistResult[ 1 ];
					
					if ( exists.equals( "false" ) ) {
						break;
					}
				}
			}
		}
		//debugLogger.printLogAtIS("exists : " + exists);
		//debugLogger.printLogAtIS("noSeq : " + noSeq);
		cur.destroy();
		obj = null;
		arrayIdata = null;
		
		existResult[ 0 ] = exists;
		existResult[ 1 ] = noSeq;
		
		return existResult;
	}
	
	public static IData createParentPath( IData schemaDef, String[] pathList, int pathSeq ) {
		IDataCursor cur = schemaDef.getCursor();
		Object obj = null;
		String curKey = "";
		String pathName = pathList[ pathSeq ].replace( "[0]", "" );
		int pathSize = pathList.length;
		IData groupIdata = null;
		IData[] arrayIdata = null;
		//debugLogger.printLogAtIS("Create ::: pathName : " + pathName);
		//debugLogger.printLogAtIS("Create ::: pathSeq : " + pathSeq);
		while ( cur.next() ) {
			curKey = cur.getKey();
			obj = cur.getValue();
				
			if ( ( pathSize - 1 ) == pathSeq ) {
				// \uB9C8\uC9C0\uB9C9 Path\uC77C \uACBD\uC6B0 Path \uC0DD\uC131
				cur.last();
					
				if ( pathList[ pathSeq ].endsWith( "]" ) ) {
					// Array \uD615\uD0DC\uC758 Path\uC778 \uACBD\uC6B0
					groupIdata = IDataFactory.create();
					arrayIdata = new IData[ 1 ];
					arrayIdata[ 0 ] = groupIdata;
					cur.insertAfter( pathName, arrayIdata );
				} else {
					// Group \uD615\uD0DC\uC758 Path\uC778 \uACBD\uC6B0
					groupIdata = IDataFactory.create();
					cur.insertAfter( pathName, groupIdata );
				}
					
				break;
			}
				
			if ( curKey.equals( pathName ) ) {
				// createParentPath \uD638\uCD9C \uC2DC \uD30C\uB77C\uBA54\uD130\uB85C pathSeq++ \uB85C \uB118\uACA8\uC8FC\uBA74 pathSeq\uAC00 \uC99D\uAC00\uB418\uC9C0 \uC54A\uC740 \uC0C1\uD0DC\uB85C \uB118\uC5B4\uAC04\uB2E4.
				pathSeq++;
					
				if ( obj instanceof IData ) {
					createParentPath( ( IData )obj, pathList, pathSeq );
				} else if ( obj instanceof IData[] ) {
					arrayIdata = ( IData[] )obj;
					createParentPath( arrayIdata[ 0 ], pathList, pathSeq );
				}
			}
		}
		
		if ( curKey.equals( "" ) ) {
			// while\uC774 \uC2E4\uD589\uB418\uC9C0 \uC54A\uC740 \uACBD\uC6B0 ==> schemaDef IData\uC5D0 \uC0DD\uC131\uB41C Object\uAC00 \uD558\uB098\uB3C4 \uC5C6\uB294 \uACBD\uC6B0 ==> \uCD5C\uCD08\uB85C Object\uB97C \uC0DD\uC131\uD574\uC90C.
			if ( pathList[ pathSeq ].endsWith( "]" ) ) {
				// Array \uD615\uD0DC\uC758 Path\uC778 \uACBD\uC6B0
				groupIdata = IDataFactory.create();
				arrayIdata = new IData[ 1 ];
				arrayIdata[ 0 ] = groupIdata;
				cur.insertAfter( pathName, arrayIdata );
			} else {
				// Group \uD615\uD0DC\uC758 Path\uC778 \uACBD\uC6B0
				groupIdata = IDataFactory.create();
				cur.insertAfter( pathName, groupIdata );
			}
		}
		
		cur.destroy();
		obj = null;
		arrayIdata = null;
		groupIdata = null;
		
		return schemaDef;
	}
	
	public static IData setSchemaDefValue( IData schemaDef, String[] pathList, int pathSeq, String fieldName, String fieldValue ) {
		IDataCursor cur = schemaDef.getCursor();
		Object obj = null;
		String curKey = "";
		String pathName = pathList[ pathSeq ].replace( "[0]", "" );
		int pathSize = pathList.length;
		IData groupIdata = null;
		IData[] arrayIdata = null;
		IDataCursor groupCur = null;
		
		while ( cur.next() ) {
			curKey = cur.getKey();
			obj = cur.getValue();
			
			if ( curKey.equals( pathName ) ) {
				//debugLogger.printLogAtIS("pathName : " + pathName);
				//debugLogger.printLogAtIS("pathSeq : " + pathSeq);
				//debugLogger.printLogAtIS("fieldName : " + fieldName);
				if ( ( pathSize - 1 ) == pathSeq ) {
					// \uB9C8\uC9C0\uB9C9 Path\uC77C \uACBD\uC6B0 Name/Value \uC0DD\uC131					
					if ( obj instanceof IData ) {
						groupIdata = ( IData )obj;
						groupCur = groupIdata.getCursor();
						groupCur.insertAfter( fieldName, fieldValue );
						IDataUtil.put( cur, curKey, groupIdata );
						groupCur.destroy();
					} else if ( obj instanceof IData[] ) {
						arrayIdata = ( IData[] )obj;
						
						if ( arrayIdata.length == 0 ) {
							// \uCD5C\uCD08\uB85C Name/Value \uC0DD\uC131\uD558\uB294 \uACBD\uC6B0
							groupIdata = IDataFactory.create();
							groupCur = groupIdata.getCursor();
							groupCur.insertAfter( fieldName, fieldValue );
							arrayIdata = new IData[ 1 ];
							arrayIdata[ 0 ] = groupIdata;
							IDataUtil.put( cur, curKey, arrayIdata );
							groupCur.destroy();
						} else {
							groupIdata = arrayIdata[ 0 ];
							groupCur = groupIdata.getCursor();
							groupCur.insertAfter( fieldName, fieldValue );
							arrayIdata[ 0 ] = groupIdata;
							IDataUtil.put( cur, curKey, arrayIdata );
							groupCur.destroy();
						}
					}
					
					break;
				}
				
				// setSchemaDefValue \uD638\uCD9C \uC2DC \uD30C\uB77C\uBA54\uD130\uB85C pathSeq++ \uB85C \uB118\uACA8\uC8FC\uBA74 pathSeq\uAC00 \uC99D\uAC00\uB418\uC9C0 \uC54A\uC740 \uC0C1\uD0DC\uB85C \uB118\uC5B4\uAC04\uB2E4.
				pathSeq++;
				
				if ( obj instanceof IData ) {
					setSchemaDefValue( ( IData )obj, pathList, pathSeq, fieldName, fieldValue );
				} else if ( obj instanceof IData[] ) {
					arrayIdata = ( IData[] )obj;
					setSchemaDefValue( arrayIdata[ 0 ], pathList, pathSeq, fieldName, fieldValue );
				}
			}
		}
		
		cur.destroy();
		obj = null;
		arrayIdata = null;
		groupIdata = null;
		
		return schemaDef;
	}
	
	public static IData[] makeStringIData_ApplySchema( String socketString, int byteLength, IData schemaDef, int startOffSet, String[] recCountFieldName, int recIndex, String charset, String convertJson, IData pipelineData ) {
		IDataCursor cur = schemaDef.getCursor(); // Schema \uC815\uC758 IData
		String curKey = null;
		Object obj = null;
		String keyValue = ""; // Field\uC5D0 \uB300\uD55C Schema \uC815\uC758 String ==> Field Length/Padding String/Left Padding, Right Padding \uAD6C\uBD84/Field Desc/Data Type/Length Calculation Start/Field Type
		String fieldValue = "";
		Object outNumber = null;
		String[] token = null;
		String fieldLength = "";
		String dataType = "";
		String fieldType = "";
		String realFieldType = "";
		String valueType = "";
		String[] svcInfo = null;
		String[] otToken = null;
		IData[] recList = null;
		String[] recCountFieldPath = null;
		String arrayCountFieldName = "";
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
		IData groupDef = null; // Single Record \uAD6C\uC870\uC758 Group IData
		int tempRecIndex = 0;
		String errorMsg = "";
		String tempErrorMsg = "";
		IDataCursor tempErrorCursor = null;
		
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
					dataType = token[ 4 ];
					fieldType = token[ 6 ];
					otToken = fieldType.split( "\\$" );
					realFieldType = otToken[ 0 ].trim().toUpperCase();
					
					/* 
					 * realFieldType
					 * ST : Field\uAC00 Source, Target\uC5D0 \uBAA8\uB450 \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0 ==> Source\uC5D0\uC11C Value \uCD94\uCD9C, Target\uC5D0 Field \uC0DD\uC131 \uBC0F Value \uB9E4\uD551
					 * OS : Field\uAC00 Source\uC5D0\uB9CC \uC874\uC7AC\uD558\uACE0 Target\uC5D0\uB294  \uC874\uC7AC\uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0 ==> Source\uC5D0\uC11C Value \uCD94\uCD9C, Target\uC5D0 Field \uC0DD\uC131 \uBC0F Value \uB9E4\uD551 \uC0DD\uB7B5
					 * OT : Field\uAC00 Target\uC5D0\uB9CC \uC874\uC7AC\uD558\uACE0 Source\uC5D0\uB294  \uC874\uC7AC\uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0 ==> Source\uC5D0\uC11C Value \uCD94\uCD9C \uC0DD\uB7B5, Target\uC5D0 Field \uC0DD\uC131 \uBC0F Value \uB9E4\uD551					 
					 */
					
					// Source\uC5D0\uC11C Value \uCD94\uCD9C
					if ( realFieldType.equals( "ST" ) || realFieldType.equals( "OS" ) ) {
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
					} else if ( realFieldType.equals( "OT" ) ) {						
						// OT$FV$Value : \uACE0\uC815\uAC12\uC778 \uACBD\uC6B0 ==> Value \uBD80\uBD84\uC5D0 \uC788\uB294 \uAC12\uC774 Value\uAC00 \uB41C\uB2E4.
						// OT$VV$Service Full Name : \uAC00\uBCC0\uAC12\uC778 \uACBD\uC6B0 ==> Service Full Name\uC744 \uD638\uCD9C\uD574\uC11C Value\uB97C \uAD6C\uD55C\uB2E4.
						fieldLen = 0;
						valueType = otToken[ 1 ].trim().toUpperCase();
						
						if ( valueType.equals( "FV" ) ) {
							fieldValue = otToken[ 2 ];
						} else if ( valueType.equals( "VV" ) ) {
							svcInfo = otToken[ 2 ].trim().split( ":" );
							IDataUtil.put( inputCursor, "pipelineData", pipelineData );
							outIData = Service.doInvoke( svcInfo[ 0 ], svcInfo[ 1 ], inIData );
							outputCursor = outIData.getCursor();
							fieldValue = IDataUtil.getString( outputCursor, "outValue" );
						}
					}
					
					// Target Field \uC0DD\uC131 \uBC0F Value \uB9E4\uD551
					if ( realFieldType.equals( "ST" ) || realFieldType.equals( "OT" ) ) {					
						if ( dataType.equals( "S" ) ) {
							// Data Type\uC774 String\uC778 \uACBD\uC6B0
							docCursor.insertAfter( curKey, fieldValue );
						} else {
							// Data Type\uC774 Number\uC778 \uACBD\uC6B0
							// JSON \uBCC0\uD658\uC744 \uD558\uB294 \uACBD\uC6B0\uC5D0\uB294 \uC22B\uC790 \uD0C0\uC785\uC73C\uB85C \uAC12\uC744 \uB9E4\uD551\uD558\uACE0 JSON \uBCC0\uD658\uC744 \uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0\uC5D0\uB294 Number \uD0C0\uC785\uC774\uB77C \uD574\uB3C4 String \uD0C0\uC785\uC73C\uB85C \uAC12\uC744 \uB9E4\uD551\uD55C\uB2E4.
							if ( convertJson.equals( "Yes" ) ) {
								if ( fieldValue.contains( "." ) ) {
									outNumber = Double.parseDouble( fieldValue );
								} else {
									outNumber = Long.parseLong( fieldValue );
								}
						
								docCursor.insertAfter( curKey, outNumber );
							} else {
								docCursor.insertAfter( curKey, fieldValue );
							}
						}
					}
					
					// Next startOffSet
					startOffSet = startOffSet + fieldLen;
					/*
					if ( startOffSet >= byteLength ) {
						break;
					}
					*/
				} else if ( obj instanceof IData ) { // obj is IData
					groupDef = ( IData )obj;
					tempDocInfo = makeStringIData_ApplySchema( socketString, byteLength, groupDef, startOffSet, recCountFieldName, recIndex, charset, convertJson, pipelineData );					
					tempCursor = tempDocInfo[ 1 ].getCursor();
					startOffSet = IDataUtil.getInt( tempCursor, "nextStartOffSet", 0 );
					
					tempCursor.destroy();
					tempCursor = tempDocInfo[ 2 ].getCursor();
					tempRecIndex = IDataUtil.getInt( tempCursor, "recIndex", 0 );
					
					tempErrorCursor = tempDocInfo[ 3 ].getCursor();
					tempErrorMsg = IDataUtil.getString( tempErrorCursor, "errorMsg" );
					
					if ( !tempErrorMsg.equals( "" ) ) {
						errorMsg = errorMsg + "\n" + tempErrorMsg;
					}
					
					// recCountFieldName\uC758 Index \uC99D\uAC00
					recIndex = tempRecIndex;
					docCursor.insertAfter( curKey, tempDocInfo[ 0 ] );
					
					tempCursor.destroy();
					tempErrorCursor.destroy();
					tempDocInfo = null;
					groupDef = null;
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
						// 2022.08.05 \uC218\uC815. Array Count\uB97C \uD3EC\uD568\uD558\uACE0 \uC788\uB294 \uD544\uB4DC\uAC00 Path \uD615\uD0DC\uB85C \uBC14\uB00C\uC5B4\uC11C \uD544\uB4DC\uBA85\uB9CC \uBF51\uB294 \uCC98\uB9AC\uB97C \uC218\uD589\uD568.
						//recCountValue = IDataUtil.getString( docCursor, recCountFieldName[ recIndex ] );
						recCountFieldPath = recCountFieldName[ recIndex ].split( "/" );
						arrayCountFieldName = recCountFieldPath[ recCountFieldPath.length - 1 ];
						recCountValue = IDataUtil.getString( docCursor, arrayCountFieldName );
					
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
						// recCountFieldName\uC758 Index \uC99D\uAC00
						recIndex += 1;
					} else {
						docList = new IData[ recCount ];
					
						for ( int i = 0; i < recCount; i++ ) {
							tempDocInfo = makeStringIData_ApplySchema( socketString, byteLength, recList[ 0 ], startOffSet, recCountFieldName, recIndex + 1, charset, convertJson, pipelineData );
							tempCursor = tempDocInfo[ 1 ].getCursor();
							startOffSet = IDataUtil.getInt( tempCursor, "nextStartOffSet", 0 );
							
							if ( i == 0 ) {
								tempCursor.destroy();
								tempCursor = tempDocInfo[ 2 ].getCursor();
								tempRecIndex = IDataUtil.getInt( tempCursor, "recIndex", 0 );
							}
							
							docList[ i ] = tempDocInfo[ 0 ];
							
							tempErrorCursor = tempDocInfo[ 3 ].getCursor();
							tempErrorMsg = IDataUtil.getString( tempErrorCursor, "errorMsg" );
							
							if ( !tempErrorMsg.equals( "" ) ) {
								errorMsg = errorMsg + "\n" + tempErrorMsg;
							}
						
							tempCursor.destroy();
							tempErrorCursor.destroy();
							tempDocInfo = null;
						}
						
						// recCountFieldName\uC758 Index \uC99D\uAC00
						recIndex = tempRecIndex;
						docCursor.insertAfter( curKey, docList );
					}
					/*
					if ( startOffSet >= byteLength ) {
						break;
					}
					*/
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
		groupDef = null;
		
		docInfo[ 0 ] = doc;
		docInfo[ 1 ] = nextStart;
		docInfo[ 2 ] = recCountIndex;
		docInfo[ 3 ] = error;
		
		return docInfo;
	}
	
	public static String[] makeStringToString_ApplySchema( String socketString, int byteLength, IData schemaDef, int startOffSet, String[] recCountFieldName, int recIndex, String charset, IData pipelineData ) {
		IDataCursor cur = schemaDef.getCursor(); // Schema \uC815\uC758 IData
		String curKey = null;
		Object obj = null;
		String keyValue = ""; // Field\uC5D0 \uB300\uD55C Schema \uC815\uC758 String ==> Field Length/Padding String/Left Padding, Right Padding \uAD6C\uBD84/Field Desc/Data Type/Length Calculation Start/Field Type
		String fieldValue = "";
		String[] token = null;
		String fieldLength = "";
		String fieldType = "";
		String realFieldType = "";
		String valueType = "";
		String[] svcInfo = null;
		String[] otToken = null;
		IData[] recList = null;
		String[] recCountFieldPath = null;
		String arrayCountFieldName = "";
		String recCountValue = null;
		int fieldLen = 0;
		int recCount = 0; // Record \uAC2F\uC218
		
		IData doc = IDataFactory.create();
		IDataCursor docCursor = doc.getCursor();
		String[] docInfo = new String[ 4 ];
		StringBuffer strBuffer = new StringBuffer();
		String targetSocketString = "";
		String[] tempDocInfo = null;
		
		IData groupDef = null; // Single Record \uAD6C\uC870\uC758 Group IData
		int tempRecIndex = 0;
		String errorMsg = "";
		String tempErrorMsg = "";
		
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
					fieldType = token[ 6 ];
					otToken = fieldType.split( "\\$" );
					realFieldType = otToken[ 0 ].trim().toUpperCase();
					
					/* 
					 * realFieldType
					 * ST : Field\uAC00 Source, Target\uC5D0 \uBAA8\uB450 \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0 ==> Source\uC5D0\uC11C Value \uCD94\uCD9C, Target\uC5D0 Field \uC0DD\uC131 \uBC0F Value \uB9E4\uD551
					 * OS : Field\uAC00 Source\uC5D0\uB9CC \uC874\uC7AC\uD558\uACE0 Target\uC5D0\uB294  \uC874\uC7AC\uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0 ==> Source\uC5D0\uC11C Value \uCD94\uCD9C, Target\uC5D0 Field \uC0DD\uC131 \uBC0F Value \uB9E4\uD551 \uC0DD\uB7B5
					 * OT : Field\uAC00 Target\uC5D0\uB9CC \uC874\uC7AC\uD558\uACE0 Source\uC5D0\uB294  \uC874\uC7AC\uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0 ==> Source\uC5D0\uC11C Value \uCD94\uCD9C \uC0DD\uB7B5, Target\uC5D0 Field \uC0DD\uC131 \uBC0F Value \uB9E4\uD551					 
					 */
					
					// Source\uC5D0\uC11C Value \uCD94\uCD9C
					if ( realFieldType.equals( "ST" ) || realFieldType.equals( "OS" ) ) {
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
					} else if ( realFieldType.equals( "OT" ) ) {						
						// OT$FV$Value : \uACE0\uC815\uAC12\uC778 \uACBD\uC6B0 ==> Value \uBD80\uBD84\uC5D0 \uC788\uB294 \uAC12\uC774 Value\uAC00 \uB41C\uB2E4.
						// OT$VV$Service Full Name : \uAC00\uBCC0\uAC12\uC778 \uACBD\uC6B0 ==> Service Full Name\uC744 \uD638\uCD9C\uD574\uC11C Value\uB97C \uAD6C\uD55C\uB2E4.
						fieldLen = 0;
						valueType = otToken[ 1 ].trim().toUpperCase();
						
						if ( valueType.equals( "FV" ) ) {
							fieldValue = otToken[ 2 ];
						} else if ( valueType.equals( "VV" ) ) {
							svcInfo = otToken[ 2 ].trim().split( ":" );
							IDataUtil.put( inputCursor, "pipelineData", pipelineData );
							outIData = Service.doInvoke( svcInfo[ 0 ], svcInfo[ 1 ], inIData );
							outputCursor = outIData.getCursor();
							fieldValue = IDataUtil.getString( outputCursor, "outValue" );
						}
					}
					
					// IData\uC5D0 \uC784\uC2DC\uB85C \uC800\uC7A5 ==> Array Count \uAC12 \uAD6C\uD560 \uB54C \uC0AC\uC6A9\uD55C\uB2E4.
					docCursor.insertAfter( curKey, fieldValue );
					
					// Target Value Append
					if ( realFieldType.equals( "ST" ) || realFieldType.equals( "OT" ) ) {					
						strBuffer.append( fieldValue );
					}
					
					// Next startOffSet
					startOffSet = startOffSet + fieldLen;
					/*
					if ( startOffSet >= byteLength ) {
						break;
					}
					*/
				} else if ( obj instanceof IData ) { // obj is IData
					groupDef = ( IData )obj;
					tempDocInfo = makeStringToString_ApplySchema( socketString, byteLength, groupDef, startOffSet, recCountFieldName, recIndex, charset, pipelineData );
					
					strBuffer.append( tempDocInfo[ 0 ] );
					startOffSet = Integer.parseInt( tempDocInfo[ 1 ] );
					tempRecIndex = Integer.parseInt( tempDocInfo[ 2 ] );
					tempErrorMsg = tempDocInfo[ 3 ];
					
					if ( !tempErrorMsg.equals( "" ) ) {
						errorMsg = errorMsg + "\n" + tempErrorMsg;
					}
					
					// recCountFieldName\uC758 Index \uC99D\uAC00
					recIndex = tempRecIndex;					
					
					tempDocInfo = null;
					groupDef = null;
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
						// 2022.08.05 \uC218\uC815. Array Count\uB97C \uD3EC\uD568\uD558\uACE0 \uC788\uB294 \uD544\uB4DC\uAC00 Path \uD615\uD0DC\uB85C \uBC14\uB00C\uC5B4\uC11C \uD544\uB4DC\uBA85\uB9CC \uBF51\uB294 \uCC98\uB9AC\uB97C \uC218\uD589\uD568.
						//recCountValue = IDataUtil.getString( docCursor, recCountFieldName[ recIndex ] );
						recCountFieldPath = recCountFieldName[ recIndex ].split( "/" );
						arrayCountFieldName = recCountFieldPath[ recCountFieldPath.length - 1 ];
						recCountValue = IDataUtil.getString( docCursor, arrayCountFieldName );
						
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
							tempDocInfo = makeStringToString_ApplySchema( socketString, byteLength, recList[ 0 ], startOffSet, recCountFieldName, recIndex + 1, charset, pipelineData );
							
							strBuffer.append( tempDocInfo[ 0 ] );
							startOffSet = Integer.parseInt( tempDocInfo[ 1 ] );
							
							if ( i == 0 ) {
								tempRecIndex = Integer.parseInt( tempDocInfo[ 2 ] );
							}
							
							tempErrorMsg = tempDocInfo[ 3 ];
							
							if ( !tempErrorMsg.equals( "" ) ) {
								errorMsg = errorMsg + "\n" + tempErrorMsg;
							}
						
							tempDocInfo = null;
						}
						
						// recCountFieldName\uC758 Index \uC99D\uAC00
						recIndex = tempRecIndex;
					}
					/*
					if ( startOffSet >= byteLength ) {
						break;
					}
					*/
				}
			}
			
			targetSocketString = strBuffer.toString();
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
				
		cur.destroy();
		docCursor.destroy();
		inputCursor.destroy();
		
		// Single Record\uAC00 \uC874\uC7AC\uD558\uC9C0 \uC54A\uACE0 Array\uB9CC \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0\uC5D0\uB294 outputCursor\uAC00 null \uC774\uB2E4.
		if ( outputCursor != null ) {
			outputCursor.destroy();
		}
		
		obj = null;
		recList = null;
		inIData = null;
		outIData = null;
		groupDef = null;
		
		docInfo[ 0 ] = targetSocketString;
		docInfo[ 1 ] = startOffSet + "";
		docInfo[ 2 ] = recIndex + "";
		docInfo[ 3 ] = errorMsg;
		
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
	
	public static String makeSchemaList( IData schemaDef, String singleArray ) {
		IDataCursor cur = schemaDef.getCursor(); // Schema \uC815\uC758 IData
		String curKey = null;
		Object obj = null;
		String keyValue = ""; // Field\uC5D0 \uB300\uD55C Schema \uC815\uC758 String ==> Field Length/Padding String/Left Padding, Right Padding \uAD6C\uBD84/Field Desc/Data Type/Length Calculation Start/Field Type
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
				} else if ( obj instanceof IData ) { // obj is IData
					// Group\uC73C\uB85C \uBB36\uB294 \uACBD\uC6B0
					schema = makeSchemaList( ( IData )obj, "S" );
					
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
					
					schema = makeSchemaList( recList[ 0 ], "A" );
					
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
	
	public static String[] makeIDataString_ApplySchema( IData iData, String[] schemaList, int schemaIndex, String charset, String singleArray, String paramAddDocLen, IData pipelineData, String firstInvoke ) {
		String curKey = null;
		Object obj = null;
		String keyValue = "";
		IData[] iDataList = null;
		IDataCursor cur = iData.getCursor();
		StringBuffer strBuffer = new StringBuffer();
		String[] iDataString = new String[ 7 ];
		String[] token = null;
		String schemaSingleArray = "";
		String fieldName = "";
		String fieldLength = "";
		String paddingChar = "";
		String paddingType = "";
		String byteLength = "";
		String lengthStartInfo = "";
		String addDocLen = paramAddDocLen;
		int lengthStartIndex = 0;
		int lengthFieldLen = 0;
		String lengthLocType = "";
		String curLengthLocType = "";
		String fieldType = "";
		String realFieldType = "";
		String valueType = "";
		String otValue = "";
		String[] lengthToken = null;
		String[] svcInfo = null;
		String[] otToken = null;
		String docLen = "";
		int docTotalLen = 0;
		int fieldLen = 0;
		int byteLen = 0;
		int paddingLength = 0;
		int otIndex = 0;
		String paddingString = "";
		String[] strIndex = null;
		String errorMsg = "";
		
		IData inIData = IDataFactory.create();
		IDataCursor inputCursor = inIData.getCursor();
		IData outIData = null;
		IDataCursor outputCursor = null;
		
		String socketString = "";
		String beforeLengthLoc = "";
		String afterLengthLoc = "";
		IData groupDoc = null; // Single Record \uAD6C\uC870\uC758 Group IData
		
		try {
			while ( cur.next() ) {
				curKey = cur.getKey();
				obj = cur.getValue();
	
				if ( obj == null ) {
					continue;
				} else if ( ( obj instanceof String ) || ( obj instanceof Integer ) || ( obj instanceof Long ) || ( obj instanceof Float ) || ( obj instanceof Double ) ) {	// 1. obj is String or Number
					if ( obj instanceof String ) {
						keyValue = ( String )obj;
					} else if ( obj instanceof Integer ) {
						keyValue = ( int )obj + "";
					} else if ( obj instanceof Long ) {
						keyValue = ( long )obj + "";
					} else if ( obj instanceof Float ) {
						keyValue = ( float )obj + "";
					} else if ( obj instanceof Double ) {
						keyValue = ( double )obj + "";
					}
					//debugLogger.printLogAtIS( "Log 1 : " + schemaList[ schemaIndex ] );
					token = schemaList[ schemaIndex ].split( "/" );
					schemaSingleArray = token[ 0 ];
					fieldName = token[ 1 ];
					fieldLength = token[ 2 ];
					paddingChar = token[ 3 ];
					paddingType = token[ 4 ];
					lengthStartInfo = token[ 7 ];
					fieldType = token[ 8 ];
					otToken = fieldType.split( "\\$" );
					realFieldType = otToken[ 0 ].trim().toUpperCase();
					//debugLogger.printLogAtIS( "Log 2 " );
					/* 
					 * realFieldType
					 * ST : Field\uAC00 Source, Target\uC5D0 \uBAA8\uB450 \uC874\uC7AC\uD558\uB294 \uACBD\uC6B0 ==> Source\uC5D0\uC11C Value \uCD94\uCD9C, Target Field \uC704\uCE58\uC5D0 Value\uB97C Append
					 * OS : Field\uAC00 Source\uC5D0\uB9CC \uC874\uC7AC\uD558\uACE0 Target\uC5D0\uB294  \uC874\uC7AC\uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0 ==> Source\uC5D0\uC11C Value \uCD94\uCD9C, Target Field \uC704\uCE58\uC5D0 Value Append \uC0DD\uB7B5
					 * OT : Field\uAC00 Target\uC5D0\uB9CC \uC874\uC7AC\uD558\uACE0 Source\uC5D0\uB294  \uC874\uC7AC\uD558\uC9C0 \uC54A\uB294 \uACBD\uC6B0 ==> \uD604\uC7AC \uCEE4\uC11C \uC55E\uB2E8\uC5D0\uC11C OT\uC5D0 \uB300\uD55C \uCC98\uB9AC\uB97C \uD588\uC5B4\uC57C \uD558\uB294\uB370 \uBABB\uD55C \uACBD\uC6B0\uC774\uBBC0\uB85C OT\uC5D0 \uB300\uD55C \uCC98\uB9AC\uB97C \uBA3C\uC800 \uC218\uD589\uD55C\uB2E4.
					 *      (Target Field \uC704\uCE58\uC5D0 Value\uB97C Append)
					 *      OT Field\uAC00 \uC5F0\uC18D\uC73C\uB85C \uC5EC\uB7EC \uAC1C\uAC00 \uC788\uC744 \uC218 \uC788\uAE30 \uB54C\uBB38\uC5D0 while \uBB38\uC744 \uC774\uC6A9\uD574\uC11C \uCC98\uB9AC\uD558\uACE0 curKey == fieldName \uC774\uBA74 while \uBB38\uC744 break \uD55C\uB2E4.
					 *      break \uD558\uAE30 \uC804 \uB2E8\uACC4\uC5D0\uC11C schemaIndex\uB97C +1 \uD574\uC11C \uD604\uC7AC \uCEE4\uC11C\uC5D0 \uB300\uD55C schema \uC815\uBCF4\uB97C \uAD6C\uD574\uC57C \uD55C\uB2E4.
					 *      
					 * lengthStartInfo ==> Y$Doc Length Index$Field Length \uD615\uD0DC. ex) Y$3$4
					 */
					
					// \uC804\uBB38 \uAE38\uC774 \uACC4\uC0B0 \uBC0F \uC804\uBB38 \uAE38\uC774 \uC14B\uD305\uC744 \uC704\uD55C \uC815\uBCF4 \uCD94\uCD9C ==> Converting \uD558\uB294 \uC911\uC5D0 \uD55C\uBC88\uB9CC \uC2E4\uD589\uB41C\uB2E4.
					if ( !lengthStartInfo.equals( "" ) ) {
						if ( lengthStartInfo.startsWith( "Y" ) ) {
							//debugLogger.printLogAtIS( "Log 3 : " + lengthStartInfo );
							addDocLen = "Y";
							lengthToken = lengthStartInfo.split( "\\$" );
							lengthStartIndex = Integer.parseInt( lengthToken[ 1 ].trim() );
							lengthFieldLen = Integer.parseInt( lengthToken[ 2 ].trim() );
							//lengthLocType = lengthToken[ 2 ].trim();
							//curLengthLocType = lengthToken[ 2 ].trim();
							//debugLogger.printLogAtIS( "Log 4 " );
							/*
							if ( curLengthLocType.equals( "I" ) ) {
								realFieldType = "OT";
							} else if ( curLengthLocType.equals( "R" ) ) {
								realFieldType = "ST";
							}
							*/
						} else {
							// curLengthLocType\uC758 \uAC12\uC740 \uD574\uB2F9 Field\uC5D0\uC11C \uD55C\uBC88\uB9CC \uC0AC\uC6A9\uB418\uACE0 \uB098\uBA38\uC9C0 Field\uC5D0\uC11C\uB294 \uC0AC\uC6A9\uB418\uBA74 \uC548\uB418\uAE30 \uB54C\uBB38\uC5D0 \uCD08\uAE30\uD654\uB97C \uD574\uC57C \uD55C\uB2E4.
							//curLengthLocType = "";
						}
					} else {
						// curLengthLocType\uC758 \uAC12\uC740 \uD574\uB2F9 Field\uC5D0\uC11C \uD55C\uBC88\uB9CC \uC0AC\uC6A9\uB418\uACE0 \uB098\uBA38\uC9C0 Field\uC5D0\uC11C\uB294 \uC0AC\uC6A9\uB418\uBA74 \uC548\uB418\uAE30 \uB54C\uBB38\uC5D0 \uCD08\uAE30\uD654\uB97C \uD574\uC57C \uD55C\uB2E4.
						//curLengthLocType = "";
					}
					
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
							lengthStartInfo = token[ 7 ];
							fieldType = token[ 8 ];
							otToken = fieldType.split( "\\$" );
							realFieldType = otToken[ 0 ].trim().toUpperCase();
							
							// \uC804\uBB38 \uAE38\uC774 \uACC4\uC0B0 \uBC0F \uC804\uBB38 \uAE38\uC774 \uC14B\uD305\uC744 \uC704\uD55C \uC815\uBCF4 \uCD94\uCD9C ==> Converting \uD558\uB294 \uC911\uC5D0 \uD55C\uBC88\uB9CC \uC2E4\uD589\uB41C\uB2E4.
							if ( !lengthStartInfo.equals( "" ) ) {
								if ( lengthStartInfo.startsWith( "Y" ) ) {
									addDocLen = "Y";
									lengthToken = lengthStartInfo.split( "\\$" );
									lengthStartIndex = Integer.parseInt( lengthToken[ 1 ].trim() );
									lengthFieldLen = Integer.parseInt( lengthToken[ 2 ].trim() );
									//lengthLocType = lengthToken[ 2 ].trim();
									//curLengthLocType = lengthToken[ 2 ].trim();
									/*
									if ( curLengthLocType.equals( "I" ) ) {
										realFieldType = "OT";
									} else if ( curLengthLocType.equals( "R" ) ) {
										realFieldType = "ST";
									}
									*/
								} else {
									// curLengthLocType\uC758 \uAC12\uC740 \uD574\uB2F9 Field\uC5D0\uC11C \uD55C\uBC88\uB9CC \uC0AC\uC6A9\uB418\uACE0 \uB098\uBA38\uC9C0 Field\uC5D0\uC11C\uB294 \uC0AC\uC6A9\uB418\uBA74 \uC548\uB418\uAE30 \uB54C\uBB38\uC5D0 \uCD08\uAE30\uD654\uB97C \uD574\uC57C \uD55C\uB2E4.
									//curLengthLocType = "";
								}
							} else {
								// curLengthLocType\uC758 \uAC12\uC740 \uD574\uB2F9 Field\uC5D0\uC11C \uD55C\uBC88\uB9CC \uC0AC\uC6A9\uB418\uACE0 \uB098\uBA38\uC9C0 Field\uC5D0\uC11C\uB294 \uC0AC\uC6A9\uB418\uBA74 \uC548\uB418\uAE30 \uB54C\uBB38\uC5D0 \uCD08\uAE30\uD654\uB97C \uD574\uC57C \uD55C\uB2E4.
								//curLengthLocType = "";
							}
							
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
							lengthStartInfo = token[ 7 ];
							fieldType = token[ 8 ];
							otToken = fieldType.split( "\\$" );
							realFieldType = otToken[ 0 ].trim().toUpperCase();
							
							// \uC804\uBB38 \uAE38\uC774 \uACC4\uC0B0 \uBC0F \uC804\uBB38 \uAE38\uC774 \uC14B\uD305\uC744 \uC704\uD55C \uC815\uBCF4 \uCD94\uCD9C ==> Converting \uD558\uB294 \uC911\uC5D0 \uD55C\uBC88\uB9CC \uC2E4\uD589\uB41C\uB2E4.
							if ( !lengthStartInfo.equals( "" ) ) {
								if ( lengthStartInfo.startsWith( "Y" ) ) {
									addDocLen = "Y";
									lengthToken = lengthStartInfo.split( "\\$" );
									lengthStartIndex = Integer.parseInt( lengthToken[ 1 ].trim() );
									lengthFieldLen = Integer.parseInt( lengthToken[ 2 ].trim() );
									//lengthLocType = lengthToken[ 2 ].trim();
									//curLengthLocType = lengthToken[ 2 ].trim();
									/*
									if ( curLengthLocType.equals( "I" ) ) {
										realFieldType = "OT";
									} else if ( curLengthLocType.equals( "R" ) ) {
										realFieldType = "ST";
									}
									*/
								} else {
									// curLengthLocType\uC758 \uAC12\uC740 \uD574\uB2F9 Field\uC5D0\uC11C \uD55C\uBC88\uB9CC \uC0AC\uC6A9\uB418\uACE0 \uB098\uBA38\uC9C0 Field\uC5D0\uC11C\uB294 \uC0AC\uC6A9\uB418\uBA74 \uC548\uB418\uAE30 \uB54C\uBB38\uC5D0 \uCD08\uAE30\uD654\uB97C \uD574\uC57C \uD55C\uB2E4.
									//curLengthLocType = "";
								}
							} else {
								// curLengthLocType\uC758 \uAC12\uC740 \uD574\uB2F9 Field\uC5D0\uC11C \uD55C\uBC88\uB9CC \uC0AC\uC6A9\uB418\uACE0 \uB098\uBA38\uC9C0 Field\uC5D0\uC11C\uB294 \uC0AC\uC6A9\uB418\uBA74 \uC548\uB418\uAE30 \uB54C\uBB38\uC5D0 \uCD08\uAE30\uD654\uB97C \uD574\uC57C \uD55C\uB2E4.
								//curLengthLocType = "";
							}
							
							if ( schemaSingleArray.equals( "A" ) && curKey.equals( fieldName ) ) {
								break;
							}
						}
					}
					
					// realFieldType == OT \uC778 \uACBD\uC6B0\uC5D0 \uD604\uC7AC \uCEE4\uC11C \uC55E\uB2E8\uC5D0\uC11C OT\uC5D0 \uB300\uD55C \uCC98\uB9AC\uB97C \uD588\uC5B4\uC57C \uD558\uB294\uB370 \uBABB\uD55C \uACBD\uC6B0\uC774\uBBC0\uB85C OT\uC5D0 \uB300\uD55C \uCC98\uB9AC\uB97C \uBA3C\uC800 \uC218\uD589\uD55C\uB2E4.
					// OT Field\uAC00 \uC5F0\uC18D\uC73C\uB85C \uC5EC\uB7EC \uAC1C\uAC00 \uC788\uC744 \uC218 \uC788\uAE30 \uB54C\uBB38\uC5D0 while \uBB38\uC744 \uC774\uC6A9\uD55C\uB2E4. \uD604\uC7AC \uCEE4\uC11C\uC5D0 \uB300\uD55C schema \uC815\uBCF4\uB97C \uAD6C\uD558\uBA74 while \uBB38 break \uD55C\uB2E4.
					if ( realFieldType.equals( "OT" ) ) {
						while ( true ) {
							//debugLogger.printLogAtIS( "Log 5 : " + otIndex );
							if ( otIndex == 0 ) {
								// \uC704\uC5D0\uC11C schema \uC815\uBCF4\uB97C \uAD6C\uD588\uC73C\uBBC0\uB85C schema \uC815\uBCF4 \uAD6C\uD558\uB294 \uAC83 \uC0DD\uB7B5
								otIndex++;
							} else {
								// \uB2E4\uC74C schema \uC815\uBCF4 \uAD6C\uD558\uAE30
								schemaIndex++;
								token = schemaList[ schemaIndex ].split( "/" );
								schemaSingleArray = token[ 0 ];
								fieldName = token[ 1 ];
								fieldLength = token[ 2 ];
								paddingChar = token[ 3 ];
								paddingType = token[ 4 ];
								lengthStartInfo = token[ 7 ];
								fieldType = token[ 8 ];
								otToken = fieldType.split( "\\$" );
								realFieldType = otToken[ 0 ].trim().toUpperCase();
								
								// \uC804\uBB38 \uAE38\uC774 \uACC4\uC0B0 \uBC0F \uC804\uBB38 \uAE38\uC774 \uC14B\uD305\uC744 \uC704\uD55C \uC815\uBCF4 \uCD94\uCD9C ==> Converting \uD558\uB294 \uC911\uC5D0 \uD55C\uBC88\uB9CC \uC2E4\uD589\uB41C\uB2E4.
								if ( !lengthStartInfo.equals( "" ) ) {
									if ( lengthStartInfo.startsWith( "Y" ) ) {
										addDocLen = "Y";
										lengthToken = lengthStartInfo.split( "\\$" );
										lengthStartIndex = Integer.parseInt( lengthToken[ 1 ].trim() );
										lengthFieldLen = Integer.parseInt( lengthToken[ 2 ].trim() );
										//lengthLocType = lengthToken[ 2 ].trim();
										//curLengthLocType = lengthToken[ 2 ].trim();
										/*
										if ( curLengthLocType.equals( "I" ) ) {
											realFieldType = "OT";
										} else if ( curLengthLocType.equals( "R" ) ) {
											realFieldType = "ST";
										}
										*/
									} else {
										// curLengthLocType\uC758 \uAC12\uC740 \uD574\uB2F9 Field\uC5D0\uC11C \uD55C\uBC88\uB9CC \uC0AC\uC6A9\uB418\uACE0 \uB098\uBA38\uC9C0 Field\uC5D0\uC11C\uB294 \uC0AC\uC6A9\uB418\uBA74 \uC548\uB418\uAE30 \uB54C\uBB38\uC5D0 \uCD08\uAE30\uD654\uB97C \uD574\uC57C \uD55C\uB2E4.
										//curLengthLocType = "";
									}
								} else {
									// curLengthLocType\uC758 \uAC12\uC740 \uD574\uB2F9 Field\uC5D0\uC11C \uD55C\uBC88\uB9CC \uC0AC\uC6A9\uB418\uACE0 \uB098\uBA38\uC9C0 Field\uC5D0\uC11C\uB294 \uC0AC\uC6A9\uB418\uBA74 \uC548\uB418\uAE30 \uB54C\uBB38\uC5D0 \uCD08\uAE30\uD654\uB97C \uD574\uC57C \uD55C\uB2E4.
									//curLengthLocType = "";
								}
								
								if ( ( realFieldType.equals( "ST" ) || realFieldType.equals( "OS" ) ) && curKey.equals( fieldName ) ) {
									// \uD604\uC7AC \uCEE4\uC11C\uC5D0 \uB300\uD55C schema \uC815\uBCF4\uB97C \uAD6C\uD55C \uACBD\uC6B0
									break;
								} else {
									// \uC5F0\uC18D\uC801\uC73C\uB85C OT\uAC00 \uC788\uB294 \uACBD\uC6B0
								}
							}
							//debugLogger.printLogAtIS( "Log 6 : " + curLengthLocType );
							// Target Field\uC5D0 \uB300\uD55C Value \uAD6C\uD558\uAE30
							valueType = otToken[ 1 ].trim().toUpperCase();
								
							if ( valueType.equals( "FV" ) ) {
								otValue = otToken[ 2 ];
							} else if ( valueType.equals( "VV" ) ) {
								svcInfo = otToken[ 2 ].trim().split( ":" );
								IDataUtil.put( inputCursor, "pipelineData", pipelineData );
								outIData = Service.doInvoke( svcInfo[ 0 ], svcInfo[ 1 ], inIData );
								outputCursor = outIData.getCursor();
								otValue = IDataUtil.getString( outputCursor, "outValue" );
							}
							
							// Target Field \uC704\uCE58\uC5D0 Value\uB97C Append
							if ( otValue.equals( "" ) ) {
								// Target Field \uC704\uCE58\uC5D0 Value Append \uC0DD\uB7B5
							} else {
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
								
								IDataUtil.put( inputCursor, "content", otValue );
								IDataUtil.put( inputCursor, "charset", charset );
								
								outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "getByteLength", inIData );
								outputCursor = outIData.getCursor();
								byteLength = IDataUtil.getString( outputCursor, "byteLength" );
								byteLen = Integer.parseInt( byteLength );
								
								if ( fieldLen == byteLen ) {
									strBuffer.append( otValue );
								} else if ( fieldLen < byteLen ) {
									IDataUtil.put( inputCursor, "inString", otValue );
									IDataUtil.put( inputCursor, "startOffset", "0" );
									IDataUtil.put( inputCursor, "length", fieldLength );
									IDataUtil.put( inputCursor, "charset", charset );
									
									outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
									outputCursor = outIData.getCursor();
									otValue = IDataUtil.getString( outputCursor, "outString" );
									strBuffer.append( otValue );
								} else if ( fieldLen > byteLen ) {
									paddingLength = fieldLen - byteLen;
									
									for ( int i = 0; i < paddingLength; i++ ) {
										paddingString += paddingChar;
									}
									
									if ( paddingType.equals( "LP" ) ) {							
										otValue = paddingString + otValue;						
									} else if ( paddingType.equals( "RP" ) ) {							
										otValue = otValue + paddingString;						
									}
									
									strBuffer.append( otValue );
									
									paddingLength = 0;
									paddingString = "";
								}
								
								// \uC804\uBB38 \uC804\uCCB4 \uAE38\uC774
								if ( addDocLen.equals( "Y" ) ) {
									docTotalLen += fieldLen;
								}
							}
						}
						
						otIndex = 0;						
					}
					
					// \uD604\uC7AC \uCEE4\uC11C\uC5D0 \uB300\uD574\uC11C Target Field \uC704\uCE58\uC5D0 Value\uB97C Append
					if ( realFieldType.equals( "ST" ) ) {
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
						
						// \uC804\uBB38 \uC804\uCCB4 \uAE38\uC774
						if ( addDocLen.equals( "Y" ) ) {
							docTotalLen += fieldLen;
						}
					}
					
					schemaIndex++;
				} else if ( obj instanceof IData ) {
					//debugLogger.printLogAtIS( "Log 7 Group" );
					groupDoc = ( IData )obj;
					strIndex = makeIDataString_ApplySchema( groupDoc, schemaList, schemaIndex, charset, "S", addDocLen, pipelineData, "false" );
					keyValue = strIndex[ 0 ]; // \uC0DD\uC131\uB41C Socket String
					strBuffer.append( keyValue );
					//debugLogger.printLogAtIS( "Log 8 Group String : " + keyValue );
					// makeIDataString_ApplySchema \uC2E4\uD589\uD558\uB294 \uB3C4\uC911\uC5D0 addDocLen\uC774 Y\uB85C \uBCC0\uACBD\uB418\uC5C8\uC744 \uC218 \uC788\uAE30 \uB54C\uBB38\uC5D0 addDocLen\uC758 \uACB0\uACFC\uB97C \uBC1B\uC544\uC57C \uD55C\uB2E4.
					addDocLen = strIndex[ 3 ];
					
					if ( !strIndex[ 4 ].equals( "0" ) && !strIndex[ 5 ].equals( "0" ) ) {
						// addDocLen\uC774 N\uC5D0\uC11C Y\uB85C \uBCC0\uACBD\uB41C \uACBD\uC6B0 ==> \uC804\uBB38\uAE38\uC774 \uC704\uCE58\uC758 \uC2DC\uC791 \uC778\uD14D\uC2A4, \uC804\uBB38\uAE38\uC774 \uD544\uB4DC\uC758 \uAE38\uC774\uB97C \uBC1B\uC544\uC57C \uD55C\uB2E4.
						// \uC804\uBB38\uAE38\uC774 \uC704\uCE58 \uC815\uBCF4 \uCD94\uCD9C\uC740 Converting \uD558\uB294 \uC911\uC5D0 \uD55C\uBC88\uB9CC \uC2E4\uD589\uB41C\uB2E4.
						lengthStartIndex = Integer.parseInt( strIndex[ 4 ] );
						lengthFieldLen = Integer.parseInt( strIndex[ 5 ] );
					}
					
					// \uC804\uBB38 \uC804\uCCB4 \uAE38\uC774
					/*
					if ( addDocLen.equals( "Y" ) ) {
						docTotalLen += Integer.parseInt( strIndex[ 2 ] );
					}
					*/
					docTotalLen = docTotalLen + Integer.parseInt( strIndex[ 2 ] );
					//debugLogger.printLogAtIS( "Log 9 Group Doc Length : " + strIndex[ 2 ] );
					schemaIndex = Integer.parseInt( strIndex[ 1 ] );
					//debugLogger.printLogAtIS( "Log 10 schemaIndex : " + schemaIndex );
				} else if ( obj instanceof IData[] ) {
					iDataList = ( IData[] )obj;
					//debugLogger.printLogAtIS( "Log 11 Array Size : " + iDataList.length );
					if ( iDataList == null ) {
						continue;
					}
					
					for ( int i = 0; i < iDataList.length; i++ ) {
						if ( iDataList[ i ] == null ) {
							continue;
						}
						
						strIndex = makeIDataString_ApplySchema( iDataList[ i ], schemaList, schemaIndex, charset, "A", addDocLen, pipelineData, "false" );
						keyValue = strIndex[ 0 ]; // \uC0DD\uC131\uB41C Socket String
						strBuffer.append( keyValue );
						//debugLogger.printLogAtIS( "Log 12 Array String : " + keyValue );
						// \uC804\uBB38 \uC804\uCCB4 \uAE38\uC774
						docTotalLen = docTotalLen + Integer.parseInt( strIndex[ 2 ] );
						//debugLogger.printLogAtIS( "Log 13 Array Doc Length : " + strIndex[ 2 ] );
					}
					
					schemaIndex = Integer.parseInt( strIndex[ 1 ] );
				}
			}
			//debugLogger.printLogAtIS( "schemaIndex : " + schemaIndex );
			//debugLogger.printLogAtIS( "docTotalLen : " + docTotalLen );
			//debugLogger.printLogAtIS( "firstInvoke : " + firstInvoke );
			// \uC804\uCCB4 Socket String
			socketString = strBuffer.toString();
			
			// \uC804\uBB38 \uC804\uCCB4 \uAE38\uC774 \uAC12 \uC0BD\uC785 \uB610\uB294 Replace
			//if ( singleArray.equals( "S" ) && addDocLen.equals( "Y" ) ) {
			if ( firstInvoke.equals( "true" ) && addDocLen.equals( "Y" ) ) {
				// \uC804\uBB38 \uC804\uCCB4 \uAE38\uC774 \uAC12\uC5D0 \uB300\uD574\uC11C \uD328\uB529 \uCC98\uB9AC
				IDataUtil.put( inputCursor, "inString", docTotalLen + "" );
				IDataUtil.put( inputCursor, "padString", "0" );
				IDataUtil.put( inputCursor, "length", lengthFieldLen + "" );
				
				outIData = Service.doInvoke( "pub.string", "padLeft", inIData );
				outputCursor = outIData.getCursor();
				docLen = IDataUtil.getString( outputCursor, "value" );
				
				// \uC804\uBB38 \uC804\uCCB4 \uAE38\uC774 \uAC12\uC744 \uC0BD\uC785\uD558\uAE30 \uC804\uAE4C\uC9C0\uC758 Socket String \uCD94\uCD9C
				IDataUtil.put( inputCursor, "inString", socketString );
				IDataUtil.put( inputCursor, "startOffset", "0" );
				IDataUtil.put( inputCursor, "length", lengthStartIndex + "" );
				IDataUtil.put( inputCursor, "charset", charset );
				
				outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
				outputCursor = outIData.getCursor();
				beforeLengthLoc = IDataUtil.getString( outputCursor, "outString" );
				
				// afterLengthLoc\uB294 lengthStartIndex + lengthFieldLen \uBD80\uD130 \uCD94\uCD9C\uD558\uBA74 \uB41C\uB2E4.
				lengthStartIndex = lengthStartIndex + lengthFieldLen;				
				
				// // \uC804\uBB38 \uC804\uCCB4 \uAE38\uC774 \uAC12\uC744 \uC0BD\uC785\uD55C \uC774\uD6C4\uC758 Socket String \uCD94\uCD9C
				IDataUtil.put( inputCursor, "inString", socketString );
				IDataUtil.put( inputCursor, "startOffset", lengthStartIndex + "" );
				IDataUtil.put( inputCursor, "length", "" );
				IDataUtil.put( inputCursor, "charset", charset );
					
				outIData = Service.doInvoke( "JSocketAdapter.COMMON.UTIL.STRING", "substringByBytes", inIData );
				outputCursor = outIData.getCursor();
				afterLengthLoc = IDataUtil.getString( outputCursor, "outString" );
				
				// \uC804\uCCB4 Socket String \uC7AC \uC0DD\uC131. \uD574\uB2F9 \uC704\uCE58\uC5D0 docTotalLen\uC744 Replace \uD55C\uB2E4.
				socketString = beforeLengthLoc + docLen + afterLengthLoc;
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
			//debugLogger.printLogAtIS( "Socket String : " + strBuffer.toString() );
			//debugLogger.printLogAtIS( "errorMsg : " + errorMsg );
		}
		
		cur.destroy();
		inputCursor.destroy();
		
		if ( outputCursor != null ) {
			outputCursor.destroy();
		}
		
		iDataList = null;
		inIData = null;
		outIData = null;
		groupDoc = null;
		
		iDataString[ 0 ] = socketString;
		iDataString[ 1 ] = schemaIndex + "";
		iDataString[ 2 ] = docTotalLen + "";
		iDataString[ 3 ] = addDocLen;
		iDataString[ 4 ] = lengthStartIndex + "";
		iDataString[ 5 ] = lengthFieldLen + "";
		iDataString[ 6 ] = errorMsg;
		
		return iDataString;
	}
	// --- <<IS-END-SHARED>> ---
}

