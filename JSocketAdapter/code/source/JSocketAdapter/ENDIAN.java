package JSocketAdapter;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.Hashtable;
// --- <<IS-END-IMPORTS>> ---

public final class ENDIAN

{
	// ---( internal utility methods )---

	final static ENDIAN _instance = new ENDIAN();

	static ENDIAN _newInstance() { return new ENDIAN(); }

	static ENDIAN _cast(Object o) { return (ENDIAN)o; }

	// ---( server methods )---




	public static final void convertBytesToOrgData (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertBytesToOrgData)>> ---
		// @sigtype java 3.5
		// [i] object:0:required readBytes
		// [i] record:0:required schemaDef
		// [i] field:0:required byteOrder {"LITTLE","BIG"}
		// [i] field:0:required readLen
		// [i] field:0:required encoding
		// [o] record:0:required readDoc
		// [o] field:0:required orgData
		IDataCursor pipelineCursor = pipeline.getCursor();
		byte[] readBytes = ( byte[] )IDataUtil.get( pipelineCursor, "readBytes" );
		IData schemaDef = IDataUtil.getIData( pipelineCursor, "schemaDef" );
		String byteOrder = IDataUtil.getString( pipelineCursor, "byteOrder" );
		int readLen = IDataUtil.getInt( pipelineCursor, "readLen", 0 );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();
		
		if ( encoding == null ) {
			encoding = "";
		}
		
		ByteBuffer byteBuffer = null;
		IDataCursor cur = schemaDef.getCursor(); // Schema \uC815\uC758 IData
		IDataCursor subCur = null;
		String[] schemaDefList = null;
		String schemaDefs = "";
		String curKey = null;
		String subCurKey = null;
		Object obj = null;
		Object subObj = null;
		String keyValue = ""; // Field\uC5D0 \uB300\uD55C Schema \uC815\uC758 String ==> Data Type/Field Length/Array Count
		String[] token = null;
		String dataType = "";
		String fieldLength = "";
		String fieldArray = "";
		int fieldArrayCount = 0;
		byte[] fieldBuffer = null;
		String fieldValue = "";
		IData[] idataList1 = null;
		IData[] idataList2 = null;
		String[] dataList = null;
		IData arrayDoc = null;
		IDataCursor arrayCur = null;
		IData readDoc = IDataFactory.create();
		IDataCursor readCur = readDoc.getCursor();
		Hashtable ht = null;
		StringBuffer strBuffer = new StringBuffer();
		boolean strBufferAppend = false;
		int readBytesLength = readBytes.length;
		int fieldLengthSum = 0;
		
		try {
			if ( readLen == readBytesLength ) {
				byteBuffer = ByteBuffer.allocate( readLen );
			} else {
				// \uC9E7\uC740 \uB370\uC774\uD130\uB97C \uC218\uC2E0\uD55C \uACBD\uC6B0
				byteBuffer = ByteBuffer.allocate( readBytesLength );
			}
			
			// \uBC84\uD37C\uC758 position\uC744 0\uC73C\uB85C \uC124\uC815\uD558\uACE0 Read/Write \uD560 \uC218 \uC788\uB294 \uD55C\uACC4 position\uC744 readLen\uACFC \uAC19\uAC8C \uC124\uC815\uD55C\uB2E4.
			byteBuffer.clear();
			
			// Endian \uBC29\uC2DD \uC124\uC815
			if ( byteOrder.equals( "LITTLE" ) ) {
				byteBuffer.order( ByteOrder.LITTLE_ENDIAN );
			} else {
				byteBuffer.order( ByteOrder.BIG_ENDIAN );
			}
			
			// Read \uD55C Bytes \uB370\uC774\uD130\uB97C ByteBuffer\uC5D0 \uB2F4\uB294\uB2E4.
			byteBuffer.put( readBytes );
			
			// \uBC84\uD37C\uC758 \uB370\uC774\uD130\uB97C Read \uD558\uAE30 \uC704\uD574\uC11C position\uC744 0\uC73C\uB85C \uC124\uC815\uD55C\uB2E4.
			byteBuffer.rewind();
			
			while ( cur.next() ) {
				curKey = cur.getKey();
				obj = cur.getValue();
		
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) { // obj is String
					keyValue = ( String )obj;					
					token = keyValue.split( "/" );
					dataType = token[ 0 ].toLowerCase();
					fieldLength = token[ 1 ];
					fieldArray = token[ 2 ];
					
					if ( fieldArray.equals( "1" ) ) {
						fieldLengthSum += Integer.parseInt( fieldLength );
						
						if ( fieldLengthSum > readBytesLength ) {
							break;
						}
						
						ht = getBuffer( byteBuffer, dataType, fieldLength, encoding );
						byteBuffer = ( ByteBuffer )ht.get( "byteBuffer" );
						fieldValue = ( String )ht.get( "fieldValue" );
						readCur.insertAfter( curKey, fieldValue );
						ht = null;
						
						if ( strBufferAppend == false ) {
							strBuffer.append( fieldValue );
							strBufferAppend = true;
						} else {
							strBuffer.append( "|" + fieldValue );
						}
					} else {
						dataList = new String[ Integer.parseInt( fieldArray ) ];
						
						for ( int i = 0; i < Integer.parseInt( fieldArray ); i++ ) {
							fieldLengthSum += Integer.parseInt( fieldLength );
							
							if ( fieldLengthSum > readBytesLength ) {
								break;
							}
							
							ht = getBuffer( byteBuffer, dataType, fieldLength, encoding );
							byteBuffer = ( ByteBuffer )ht.get( "byteBuffer" );
							fieldValue = ( String )ht.get( "fieldValue" );
							dataList[ i ] = fieldValue;
							ht = null;
							
							if ( strBufferAppend == false ) {
								strBuffer.append( fieldValue );
								strBufferAppend = true;
							} else {
								strBuffer.append( "|" + fieldValue );
							}
						}
						
						readCur.insertAfter( curKey, dataList );
					}
				} else if ( obj instanceof IData[] ) { // obj is IData[]
					idataList1 = ( IData[] )obj;
					subCur = idataList1[ 0 ].getCursor();
					
					while ( subCur.next() ) {
						subCurKey = subCur.getKey();
						subObj = subCur.getValue();
						keyValue = ( String )subObj;
						
						if ( schemaDefs.equals( "" ) ) {
							schemaDefs = keyValue;
						} else {
							schemaDefs = schemaDefs + "|" + keyValue;
						}
					}
					
					// \uCCAB\uBC88\uC9F8 \uD544\uB4DC\uC5D0\uC11C Array Count \uAD6C\uD558\uAE30
					schemaDefList = schemaDefs.split( "\\|" );
					token = schemaDefList[ 0 ].split( "/" );
					fieldArrayCount = Integer.parseInt( token[ 2 ] );
					schemaDefs = "";
					
					idataList2 = new IData[ fieldArrayCount ];
					
					for ( int i = 0; i < fieldArrayCount; i++ ) {
						arrayDoc = IDataFactory.create();
						arrayCur = arrayDoc.getCursor();
		
						for ( int j = 0; j < schemaDefList.length; j++ ) {
							token = schemaDefList[ j ].split( "/" );
							dataType = token[ 0 ].toLowerCase();
							fieldLength = token[ 1 ];
							
							fieldLengthSum += Integer.parseInt( fieldLength );
							
							if ( fieldLengthSum > readBytesLength ) {
								break;
							}
							
							ht = getBuffer( byteBuffer, dataType, fieldLength, encoding );
							byteBuffer = ( ByteBuffer )ht.get( "byteBuffer" );
							fieldValue = ( String )ht.get( "fieldValue" );
							arrayCur.insertAfter( subCurKey, fieldValue );
							ht = null;
							
							if ( strBufferAppend == false ) {
								strBuffer.append( fieldValue );
								strBufferAppend = true;
							} else {
								strBuffer.append( "|" + fieldValue );
							}
						}
						
						idataList2[ i ] = arrayDoc;
						arrayDoc = null;
						arrayCur.destroy();
					}
					
					readCur.insertAfter( curKey, idataList2 );
					subCur.destroy();
				}
			}
		} catch ( Exception e ) {
			throw new ServiceException( e );
		}
		
		readBytes = null;
		schemaDef = null;
		byteBuffer = null;
		idataList1 = null;
		idataList2 = null;
		ht = null;
		cur.destroy();
		readCur.destroy();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "readDoc", readDoc );
		IDataUtil.put( pipelineCursor_1, "orgData", strBuffer.toString() );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertBytesToOrgData_20191205 (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertBytesToOrgData_20191205)>> ---
		// @sigtype java 3.5
		// [i] object:0:required readBytes
		// [i] record:0:required schemaDef
		// [i] field:0:required byteOrder {"LITTLE","BIG"}
		// [i] field:0:required readLen
		// [i] field:0:required encoding
		// [o] record:0:required readDoc
		IDataCursor pipelineCursor = pipeline.getCursor();
		byte[] readBytes = ( byte[] )IDataUtil.get( pipelineCursor, "readBytes" );
		IData schemaDef = IDataUtil.getIData( pipelineCursor, "schemaDef" );
		String byteOrder = IDataUtil.getString( pipelineCursor, "byteOrder" );
		int readLen = IDataUtil.getInt( pipelineCursor, "readLen", 0 );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();
		
		if ( encoding == null ) {
			encoding = "";
		}
		
		ByteBuffer byteBuffer = null;
		IDataCursor cur = schemaDef.getCursor(); // Schema \uC815\uC758 IData
		String curKey = null;
		Object obj = null;
		String keyValue = ""; // Field\uC5D0 \uB300\uD55C Schema \uC815\uC758 String ==> Data Type/Field Length/Array Count
		String[] token = null;
		String dataType = "";
		String fieldLength = "";
		String fieldArray = "";
		byte[] fieldBuffer = null;
		String fieldValue = "";
		String[] dataList = null;
		IData readDoc = IDataFactory.create();
		IDataCursor readCur = readDoc.getCursor();
		
		try {
			byteBuffer = ByteBuffer.allocate( readLen );
			
			// \uBC84\uD37C\uC758 position\uC744 0\uC73C\uB85C \uC124\uC815\uD558\uACE0 Read/Write \uD560 \uC218 \uC788\uB294 \uD55C\uACC4 position\uC744 readLen\uACFC \uAC19\uAC8C \uC124\uC815\uD55C\uB2E4.
			byteBuffer.clear();
			
			// Endian \uBC29\uC2DD \uC124\uC815
			if ( byteOrder.equals( "LITTLE" ) ) {
				byteBuffer.order( ByteOrder.LITTLE_ENDIAN );
			} else {
				byteBuffer.order( ByteOrder.BIG_ENDIAN );
			}
			
			// Read \uD55C Bytes \uB370\uC774\uD130\uB97C ByteBuffer\uC5D0 \uB2F4\uB294\uB2E4.
			byteBuffer.put( readBytes );
			
			// \uBC84\uD37C\uC758 \uB370\uC774\uD130\uB97C Read \uD558\uAE30 \uC704\uD574\uC11C position\uC744 0\uC73C\uB85C \uC124\uC815\uD55C\uB2E4.
			byteBuffer.rewind();
			
			while ( cur.next() ) {
				curKey = cur.getKey();
				obj = cur.getValue();
		
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) { // obj is String
					keyValue = ( String )obj;					
					token = keyValue.split( "/" );
					dataType = token[ 0 ].toLowerCase();
					fieldLength = token[ 1 ];
					fieldArray = token[ 2 ];
					
					if ( dataType.equals( "ubyte" ) ) {
						// Unsigned Byte
						if ( fieldArray.equals( "1" ) ) {
							readCur.insertAfter( curKey, ( ( short )( byteBuffer.get() & 0xff ) ) + "" );
						} else {
							dataList = new String[ Integer.parseInt( fieldArray ) ];
							
							for ( int i = 0; i < Integer.parseInt( fieldArray ); i++ ) {
								dataList[ i ] = ( ( short )( byteBuffer.get() & 0xff ) ) + "";
							}
							
							readCur.insertAfter( curKey, dataList );
						}
					} else if ( dataType.equals( "short" ) ) {
						// Short
						if ( fieldArray.equals( "1" ) ) {
							readCur.insertAfter( curKey, byteBuffer.getShort() + "" );
						} else {
							dataList = new String[ Integer.parseInt( fieldArray ) ];
							
							for ( int i = 0; i < Integer.parseInt( fieldArray ); i++ ) {
								dataList[ i ] = byteBuffer.getShort() + "";
							}
							
							readCur.insertAfter( curKey, dataList );
						}
					} else if ( dataType.equals( "ushort" ) ) {
						// Unsigned Short
						if ( fieldArray.equals( "1" ) ) {
							readCur.insertAfter( curKey, ( ( int )( byteBuffer.getShort() & 0xffff ) ) + "" );
						} else {
							dataList = new String[ Integer.parseInt( fieldArray ) ];
							
							for ( int i = 0; i < Integer.parseInt( fieldArray ); i++ ) {
								dataList[ i ] = ( ( int )( byteBuffer.getShort() & 0xffff ) ) + "";
							}
							
							readCur.insertAfter( curKey, dataList );
						}
					} else if ( dataType.equals( "int" ) ) {
						// Int
						if ( fieldArray.equals( "1" ) ) {
							readCur.insertAfter( curKey, byteBuffer.getInt() + "" );
						} else {
							dataList = new String[ Integer.parseInt( fieldArray ) ];
							
							for ( int i = 0; i < Integer.parseInt( fieldArray ); i++ ) {
								dataList[ i ] = byteBuffer.getInt() + "";
							}
							
							readCur.insertAfter( curKey, dataList );
						}
					} else if ( dataType.equals( "uint" ) ) {
						// Unsigned Int
						if ( fieldArray.equals( "1" ) ) {
							readCur.insertAfter( curKey, ( ( long )( byteBuffer.getInt() & 0xffffffffL ) ) + "" );
						} else {
							dataList = new String[ Integer.parseInt( fieldArray ) ];
							
							for ( int i = 0; i < Integer.parseInt( fieldArray ); i++ ) {
								dataList[ i ] = ( ( long )( byteBuffer.getInt() & 0xffffffffL ) ) + "";
							}
							
							readCur.insertAfter( curKey, dataList );
						}
					} else if ( dataType.equals( "long" ) ) {
						// Long
						if ( fieldArray.equals( "1" ) ) {
							if ( fieldLength.equals( "4" ) ) {
								readCur.insertAfter( curKey, byteBuffer.getInt() + "" );
							} else if ( fieldLength.equals( "8" ) ) {
								readCur.insertAfter( curKey, byteBuffer.getLong() + "" );
							}
						} else {
							dataList = new String[ Integer.parseInt( fieldArray ) ];
							
							for ( int i = 0; i < Integer.parseInt( fieldArray ); i++ ) {
								if ( fieldLength.equals( "4" ) ) {
									dataList[ i ] = byteBuffer.getInt() + "";
								} else if ( fieldLength.equals( "8" ) ) {
									dataList[ i ] = byteBuffer.getLong() + "";
								}
							}
							
							readCur.insertAfter( curKey, dataList );
						}
					} else if ( dataType.equals( "float" ) ) {
						// Float
						if ( fieldArray.equals( "1" ) ) {
							readCur.insertAfter( curKey, byteBuffer.getFloat() + "" );
						} else {
							dataList = new String[ Integer.parseInt( fieldArray ) ];
							
							for ( int i = 0; i < Integer.parseInt( fieldArray ); i++ ) {
								dataList[ i ] = byteBuffer.getFloat() + "";
							}
							
							readCur.insertAfter( curKey, dataList );
						}
					} else if ( dataType.equals( "double" ) ) {
						// Double
						if ( fieldArray.equals( "1" ) ) {
							readCur.insertAfter( curKey, byteBuffer.getDouble() + "" );
						} else {
							dataList = new String[ Integer.parseInt( fieldArray ) ];
							
							for ( int i = 0; i < Integer.parseInt( fieldArray ); i++ ) {
								dataList[ i ] = byteBuffer.getDouble() + "";
							}
							
							readCur.insertAfter( curKey, dataList );
						}
					} else if ( dataType.equals( "char" ) ) {
						// Char
						if ( fieldArray.equals( "1" ) ) {
							readCur.insertAfter( curKey, byteBuffer.getChar() + "" );
						} else {
							dataList = new String[ Integer.parseInt( fieldArray ) ];
							
							for ( int i = 0; i < Integer.parseInt( fieldArray ); i++ ) {
								dataList[ i ] = byteBuffer.getChar() + "";
							}
							
							readCur.insertAfter( curKey, dataList );
						}
					} else if ( dataType.equals( "pcsstring" ) ) {
						// PcsString												
						if ( fieldArray.equals( "1" ) ) {
							fieldBuffer = new byte[ Integer.parseInt( fieldLength ) ];
							byteBuffer.get( fieldBuffer );
							
							if ( encoding.equals( "" ) ) {
								fieldValue = new String( fieldBuffer );
							} else {
								fieldValue = new String( fieldBuffer, encoding );
							}
							
							readCur.insertAfter( curKey, fieldValue );
							fieldBuffer = null;
						} else {
							dataList = new String[ Integer.parseInt( fieldArray ) ];
							
							for ( int i = 0; i < Integer.parseInt( fieldArray ); i++ ) {
								fieldBuffer = new byte[ Integer.parseInt( fieldLength ) ];
								byteBuffer.get( fieldBuffer );
								
								if ( encoding.equals( "" ) ) {
									fieldValue = new String( fieldBuffer );
								} else {
									fieldValue = new String( fieldBuffer, encoding );
								}
								
								dataList[ i ] = fieldValue;
								fieldBuffer = null;
							}
							
							readCur.insertAfter( curKey, dataList );
						}
					}
				}
			}
		} catch ( Exception e ) {
			throw new ServiceException( e );
		}
		
		readBytes = null;
		schemaDef = null;
		byteBuffer = null;
		cur.destroy();
		readCur.destroy();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "readDoc", readDoc );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertOrgDataToBytes (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertOrgDataToBytes)>> ---
		// @sigtype java 3.5
		// [i] record:0:required orgData
		// [i] record:0:required schemaDef
		// [i] field:0:required byteOrder {"LITTLE","BIG"}
		// [i] field:0:required dataLength
		// [i] field:0:required encoding
		// [o] object:0:required writeBytes
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData orgData = IDataUtil.getIData( pipelineCursor, "orgData" );
		IData schemaDef = IDataUtil.getIData( pipelineCursor, "schemaDef" );
		String byteOrder = IDataUtil.getString( pipelineCursor, "byteOrder" );
		int dataLength = IDataUtil.getInt( pipelineCursor, "dataLength", 0 );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();
		
		if ( encoding == null ) {
			encoding = "";
		}
		
		ByteBuffer byteBuffer = null;
		byte[] writeBytes = null;
		IDataCursor dataCur = orgData.getCursor();
		IDataCursor dataSubCur = null;
		IDataCursor schemaCur = schemaDef.getCursor();
		IDataCursor schemaSubCur = null;
		String[] schemaDefList = null;
		String schemaDefs = "";
		int schemaDefIndex = 0;
		String curKey1 = null;
		String subCurKey1 = null;
		String curKey2 = null;
		String subCurKey2 = null;
		Object obj1 = null;
		Object subObj1 = null;
		Object obj2 = null;
		Object subObj2 = null;
		String keyValue1 = "";
		IData[] idataList1 = null;
		IData[] idataList2 = null;
		String[] keyValueList1 = null;
		String keyValue2 = ""; // Field\uC5D0 \uB300\uD55C Schema \uC815\uC758 String ==> Field Length/Padding Char/Padding Direction/Field Desc/Data Type/Field Length/Array Count
		String[] token = null;
		String paddingChar = "";
		String paddingType = "";
		String dataType = "";
		String fieldLength = "";
		String fieldArray = "";		
		
		try {
			byteBuffer = ByteBuffer.allocate( dataLength );
			
			// \uBC84\uD37C\uC758 position\uC744 0\uC73C\uB85C \uC124\uC815\uD558\uACE0 Read/Write \uD560 \uC218 \uC788\uB294 \uD55C\uACC4 position\uC744 dataLength\uC640 \uAC19\uAC8C \uC124\uC815\uD55C\uB2E4.
			byteBuffer.clear();
			
			// Endian \uBC29\uC2DD \uC124\uC815
			if ( byteOrder.equals( "LITTLE" ) ) {
				byteBuffer.order( ByteOrder.LITTLE_ENDIAN );
			} else {
				byteBuffer.order( ByteOrder.BIG_ENDIAN );
			}
			
			while ( dataCur.next() ) {
				curKey1 = dataCur.getKey();
				obj1 = dataCur.getValue();
				
				schemaCur.next();
				curKey2 = schemaCur.getKey();
				obj2 = schemaCur.getValue();
		
				if ( obj1 == null ) {
					continue;
				} else if ( obj1 instanceof String ) { // obj is String
					keyValue1 = ( String )obj1;
					keyValue2 = ( String )obj2;
					token = keyValue2.split( "/" );
					paddingChar = token[ 1 ];
					paddingType = token[ 2 ];
					dataType = token[ 4 ].toLowerCase();
					fieldLength = token[ 5 ];
					
					byteBuffer = putBuffer( byteBuffer, keyValue1, dataType, fieldLength, paddingChar, paddingType, encoding );
				} else if ( obj1 instanceof String[] ) { // obj is String[]
					keyValueList1 = ( String[] )obj1;
					keyValue2 = ( String )obj2;
					token = keyValue2.split( "/" );
					paddingChar = token[ 1 ];
					paddingType = token[ 2 ];
					dataType = token[ 4 ].toLowerCase();
					fieldLength = token[ 5 ];
					
					for ( int i = 0; i < keyValueList1.length; i++ ) {
						byteBuffer = putBuffer( byteBuffer, keyValueList1[ i ], dataType, fieldLength, paddingChar, paddingType, encoding );
					}
				} else if ( obj1 instanceof IData[] ) { // obj is IData[]
					idataList1 = ( IData[] )obj1;
					idataList2 = ( IData[] )obj2;
					schemaSubCur = idataList2[ 0 ].getCursor();
					
					while ( schemaSubCur.next() ) {
						subCurKey2 = schemaSubCur.getKey();
						subObj2 = schemaSubCur.getValue();
						keyValue2 = ( String )subObj2;
						
						if ( schemaDefs.equals( "" ) ) {
							schemaDefs = keyValue2;
						} else {
							schemaDefs = schemaDefs + "|" + keyValue2;
						}
					}
					
					schemaSubCur.destroy();
					
					// Schema \uC815\uC758\uB97C String List\uC5D0 \uB2F4\uB294\uB2E4.
					schemaDefList = schemaDefs.split( "\\|" );
					schemaDefs = "";
					
					for ( int i = 0; i < idataList1.length; i++ ) {
						dataSubCur = idataList1[ i ].getCursor();
						schemaDefIndex = 0;
						
						while ( dataSubCur.next() ) {
							subCurKey1 = dataSubCur.getKey();
							subObj1 = dataSubCur.getValue();							
							keyValue1 = ( String )subObj1;
							token = schemaDefList[ schemaDefIndex ].split( "/" );
							paddingChar = token[ 1 ];
							paddingType = token[ 2 ];
							dataType = token[ 4 ].toLowerCase();
							fieldLength = token[ 5 ];
							
							byteBuffer = putBuffer( byteBuffer, keyValue1, dataType, fieldLength, paddingChar, paddingType, encoding );
							
							schemaDefIndex++;
						}
						
						dataSubCur.destroy();
					}
				}
			}
			
			// ByteBuffer\uC5D0 \uB2F4\uAE34 \uB370\uC774\uD130\uB97C Byte Array\uC5D0 \uB2F4\uB294\uB2E4.
			writeBytes = byteBuffer.array();
		} catch ( Exception e ) {
			throw new ServiceException( e );
		}
		
		orgData = null;
		schemaDef = null;
		byteBuffer = null;
		obj1 = null;
		subObj1 = null;
		obj2 = null;
		subObj2 = null;
		idataList1 = null;
		idataList2 = null;
		dataCur.destroy();
		schemaCur.destroy();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "writeBytes", writeBytes );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertOrgDataToBytes_20191205 (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertOrgDataToBytes_20191205)>> ---
		// @sigtype java 3.5
		// [i] record:0:required orgData
		// [i] record:0:required schemaDef
		// [i] field:0:required byteOrder {"LITTLE","BIG"}
		// [i] field:0:required dataLength
		// [i] field:0:required encoding
		// [o] object:0:required writeBytes
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData orgData = IDataUtil.getIData( pipelineCursor, "orgData" );
		IData schemaDef = IDataUtil.getIData( pipelineCursor, "schemaDef" );
		String byteOrder = IDataUtil.getString( pipelineCursor, "byteOrder" );
		int dataLength = IDataUtil.getInt( pipelineCursor, "dataLength", 0 );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();
		
		if ( encoding == null ) {
			encoding = "";
		}
		
		ByteBuffer byteBuffer = null;
		byte[] writeBytes = null;
		IDataCursor dataCur = orgData.getCursor();
		IDataCursor schemaCur = schemaDef.getCursor();
		String curKey1 = null;
		String curKey2 = null;
		Object obj1 = null;
		Object obj2 = null;
		String keyValue1 = "";
		String[] keyValueList1 = null;
		String keyValue2 = ""; // Field\uC5D0 \uB300\uD55C Schema \uC815\uC758 String ==> Field Length/Padding Char/Padding Direction/Field Desc/Data Type/Field Length/Array Count
		String[] token = null;
		String dataType = "";
		String fieldLength = "";
		String fieldArray = "";
		
		try {
			byteBuffer = ByteBuffer.allocate( dataLength );
			
			// \uBC84\uD37C\uC758 position\uC744 0\uC73C\uB85C \uC124\uC815\uD558\uACE0 Read/Write \uD560 \uC218 \uC788\uB294 \uD55C\uACC4 position\uC744 dataLength\uC640 \uAC19\uAC8C \uC124\uC815\uD55C\uB2E4.
			byteBuffer.clear();
			
			// Endian \uBC29\uC2DD \uC124\uC815
			if ( byteOrder.equals( "LITTLE" ) ) {
				byteBuffer.order( ByteOrder.LITTLE_ENDIAN );
			} else {
				byteBuffer.order( ByteOrder.BIG_ENDIAN );
			}
			
			while ( dataCur.next() ) {
				curKey1 = dataCur.getKey();
				obj1 = dataCur.getValue();
				
				schemaCur.next();
				curKey2 = schemaCur.getKey();
				obj2 = schemaCur.getValue();
		
				if ( obj1 == null ) {
					continue;
				} else if ( obj1 instanceof String ) { // obj is String
					keyValue1 = ( String )obj1;
					keyValue2 = ( String )obj2;
					token = keyValue2.split( "/" );
					dataType = token[ 4 ].toLowerCase();
					fieldLength = token[ 5 ];
					
					if ( dataType.equals( "ubyte" ) ) {
						// Unsigned Byte
						byteBuffer.put( ( byte )( Short.parseShort( keyValue1 ) & 0xff ) );
					} else if ( dataType.equals( "short" ) ) {
						// Short
						byteBuffer.putShort( Short.parseShort( keyValue1 ) );
					} else if ( dataType.equals( "ushort" ) ) {
						// Unsigned Short
						byteBuffer.putShort( ( short )( Integer.parseInt( keyValue1 ) & 0xffff ) );
					} else if ( dataType.equals( "int" ) ) {
						// Int
						byteBuffer.putInt( Integer.parseInt( keyValue1 ) );
					} else if ( dataType.equals( "uint" ) ) {
						// Unsigned Int
						byteBuffer.putInt( ( int )( Long.parseLong( keyValue1 ) & 0xffffffffL ) );
					} else if ( dataType.equals( "long" ) ) {
						// Long
						if ( fieldLength.equals( "4" ) ) {
							byteBuffer.putInt( Integer.parseInt( keyValue1 ) );
						} else if ( fieldLength.equals( "8" ) ) {
							byteBuffer.putLong( Long.parseLong( keyValue1 ) );
						}
					} else if ( dataType.equals( "float" ) ) {
						// Float
						byteBuffer.putFloat( Float.parseFloat( keyValue1 ) );
					} else if ( dataType.equals( "double" ) ) {
						// Double
						byteBuffer.putDouble( Double.parseDouble( keyValue1 ) );
					} else if ( dataType.equals( "char" ) ) {
						// Char
						byteBuffer.putChar( keyValue1.charAt( 0 ) );
					} else if ( dataType.equals( "pcsstring" ) ) {
						// PcsString
						if ( encoding.equals( "" ) ) {
							byteBuffer.put( keyValue1.getBytes() );
						} else {
							byteBuffer.put( keyValue1.getBytes( encoding ) );
						}
					}
				} else if ( obj1 instanceof String[] ) { // obj is String[]
					keyValueList1 = ( String[] )obj1;
					keyValue2 = ( String )obj2;
					token = keyValue2.split( "/" );
					dataType = token[ 4 ].toLowerCase();
					fieldLength = token[ 5 ];
					
					for ( int i = 0; i < keyValueList1.length; i++ ) {
						if ( dataType.equals( "ubyte" ) ) {
							// Unsigned Byte
							byteBuffer.put( ( byte )( Short.parseShort( keyValueList1[ i ] ) & 0xff ) );
						} else if ( dataType.equals( "short" ) ) {
							// Short
							byteBuffer.putShort( Short.parseShort( keyValueList1[ i ] ) );
						} else if ( dataType.equals( "ushort" ) ) {
							// Unsigned Short
							byteBuffer.putShort( ( short )( Integer.parseInt( keyValueList1[ i ] ) & 0xffff ) );
						} else if ( dataType.equals( "int" ) ) {
							// Int
							byteBuffer.putInt( Integer.parseInt( keyValueList1[ i ] ) );
						} else if ( dataType.equals( "uint" ) ) {
							// Unsigned Int
							byteBuffer.putInt( ( int )( Long.parseLong( keyValueList1[ i ] ) & 0xffffffffL ) );
						} else if ( dataType.equals( "long" ) ) {
							// Long
							if ( fieldLength.equals( "4" ) ) {
								byteBuffer.putInt( Integer.parseInt( keyValueList1[ i ] ) );
							} else if ( fieldLength.equals( "8" ) ) {
								byteBuffer.putLong( Long.parseLong( keyValueList1[ i ] ) );
							}
						} else if ( dataType.equals( "float" ) ) {
							// Float
							byteBuffer.putFloat( Float.parseFloat( keyValueList1[ i ] ) );
						} else if ( dataType.equals( "double" ) ) {
							// Double
							byteBuffer.putDouble( Double.parseDouble( keyValueList1[ i ] ) );
						} else if ( dataType.equals( "char" ) ) {
							// Char
							byteBuffer.put( keyValueList1[ i ].getBytes( encoding ) );
						} else if ( dataType.equals( "pcsstring" ) ) {
							// PcsString
							byteBuffer.put( keyValueList1[ i ].getBytes( encoding ) );
						}
					}
				} else if ( obj1 instanceof IData[] ) { // obj is IData[]
					
				}
			}
			
			// ByteBuffer\uC5D0 \uB2F4\uAE34 \uB370\uC774\uD130\uB97C Byte Array\uC5D0 \uB2F4\uB294\uB2E4.
			writeBytes = byteBuffer.array();
		} catch ( Exception e ) {
			throw new ServiceException( e );
		}
		
		orgData = null;
		schemaDef = null;
		byteBuffer = null;
		dataCur.destroy();
		schemaCur.destroy();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "writeBytes", writeBytes );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	public static ByteBuffer putBuffer( ByteBuffer byteBuffer, String keyValue, String dataType, String fieldLength, String paddingChar, String paddingType, String encoding ) throws ServiceException {
		try {
			
			if ( dataType.equals( "byte" ) ) {
				// Byte
				byteBuffer.put( ( byte )( Byte.parseByte( keyValue ) ) );
			} else if ( dataType.equals( "ubyte" ) ) {
				// Unsigned Byte
				byteBuffer.put( ( byte )( Short.parseShort( keyValue ) & 0xff ) );
			} else if ( dataType.equals( "short" ) ) {
				// Short
				byteBuffer.putShort( Short.parseShort( keyValue ) );
			} else if ( dataType.equals( "ushort" ) ) {
				// Unsigned Short
				byteBuffer.putShort( ( short )( Integer.parseInt( keyValue ) & 0xffff ) );
			} else if ( dataType.equals( "int" ) ) {
				// Int
				byteBuffer.putInt( Integer.parseInt( keyValue ) );
			} else if ( dataType.equals( "uint" ) ) {
				// Unsigned Int
				byteBuffer.putInt( ( int )( Long.parseLong( keyValue ) & 0xffffffffL ) );
			} else if ( dataType.equals( "long" ) ) {
				// Long
				if ( fieldLength.equals( "4" ) ) {
					byteBuffer.putInt( Integer.parseInt( keyValue ) );
				} else if ( fieldLength.equals( "8" ) ) {
					byteBuffer.putLong( Long.parseLong( keyValue ) );
				}
			} else if ( dataType.equals( "float" ) ) {
				// Float
				byteBuffer.putFloat( Float.parseFloat( keyValue ) );
			} else if ( dataType.equals( "double" ) ) {
				// Double
				byteBuffer.putDouble( Double.parseDouble( keyValue ) );
			} else if ( dataType.equals( "char" ) ) {
				// Char
				// putChar\uB294 2bytes\uB97C \uC785\uB825\uD568.
				if ( fieldLength.equals( "1" ) ) {
					// \uBC18\uB4DC\uC2DC 1byte \uB370\uC774\uD130\uAC00 \uB118\uC5B4\uC640\uC57C \uC5D0\uB7EC\uAC00 \uB098\uC9C0 \uC54A\uB294\uB2E4.
					if ( encoding.equals( "" ) ) {
						byteBuffer.put( keyValue.getBytes() );
					} else {
						byteBuffer.put( keyValue.getBytes( encoding ) );
					}
				} else if ( fieldLength.equals( "2" ) ) {
					// Ascii \uB370\uC774\uD130\uB85C\uB294 \uD55C \uC790\uB9AC\uC778\uB370 \uAE38\uC774\uB294 2bytes\uC778 \uACBD\uC6B0
					byteBuffer.putChar( keyValue.charAt( 0 ) );
				}				
			} else if ( dataType.equals( "pcsstring" ) || dataType.equals( "string" ) ) {
				// PcsString
				byteBuffer.put( getStringBytes( keyValue, Integer.parseInt( fieldLength ), paddingChar, paddingType, encoding ) );
			} else if ( dataType.equals( "timestamp" ) ) {
				// \uBE44\uD45C\uC900 16 \uC790\uB9AC Timestamp(yyyyMMddHHmmssSS) ==> \uB450 \uC790\uB9AC\uC529 \uB04A\uC5B4\uC11C 8\uBC88 Put \uD55C\uB2E4. ==> byte \uAE38\uC774\uB294 8bytes
				int sInx = 0;
				int eInx = 2;
				
				for ( int i = 0; i < 8; i++ ) {
					byteBuffer.put( ( byte )( Byte.parseByte( keyValue.substring( sInx, eInx ) ) ) );
					sInx += 2;
					eInx += 2;
				}
			}
		} catch ( Exception e ) {
			throw new ServiceException( e );
		}
		
		return byteBuffer;
	}
	
	public static byte[] getStringBytes( String keyValue, int fieldLen, String paddingChar, String paddingType, String encoding ) {
		int byteLen = 0;
		int paddingLength = 0;
		String paddingString = "";
		String correctKeyValue = "";
		byte[] keyBytes = null;
		byte[] correctKeyBytes = null;
		
		try {
			if ( encoding.equals( "" ) ) {
				byteLen = keyValue.getBytes().length;
			} else {
				byteLen = keyValue.getBytes( encoding ).length;
			}
			
			if ( fieldLen == byteLen ) {
				if ( encoding.equals( "" ) ) {
					correctKeyBytes = keyValue.getBytes();
				} else {
					correctKeyBytes = keyValue.getBytes( encoding );
				}
			} else if ( fieldLen > byteLen ) {
				paddingLength = fieldLen - byteLen;
				
				for ( int i = 0; i < paddingLength; i++ ) {
					paddingString += paddingChar;
				}
				
				if ( paddingType.equals( "LP" ) ) {							
					correctKeyValue = paddingString + keyValue;						
				} else if ( paddingType.equals( "RP" ) ) {							
					correctKeyValue = keyValue + paddingString;						
				}
				
				if ( encoding.equals( "" ) ) {
					correctKeyBytes = correctKeyValue.getBytes();
				} else {
					correctKeyBytes = correctKeyValue.getBytes( encoding );
				}
			} else if ( fieldLen < byteLen ) {
				if ( encoding.equals( "" ) ) {
					keyBytes = keyValue.getBytes();
				} else {
					keyBytes = keyValue.getBytes( encoding );
				}
				
				correctKeyBytes = new byte[ fieldLen ];
				System.arraycopy( keyBytes, 0, correctKeyBytes, 0, fieldLen );
			}
		} catch ( Exception e ) {
			
		}
		
		return correctKeyBytes;
	}
	
	public static Hashtable getBuffer( ByteBuffer byteBuffer, String dataType, String fieldLength, String encoding ) throws ServiceException {
		Hashtable ht = new Hashtable();
		String fieldValue = "";
		byte[] fieldBuffer = null;
		byte b = 0;
		
		try {
			if ( dataType.equals( "byte" ) ) {
				// Byte
				fieldValue = byteBuffer.get() + "";
			} else if ( dataType.equals( "ubyte" ) ) {
				// Unsigned Byte
				fieldValue = ( ( short )( byteBuffer.get() & 0xff ) ) + "";
			} else if ( dataType.equals( "short" ) ) {
				// Short
				fieldValue = byteBuffer.getShort() + "";
			} else if ( dataType.equals( "ushort" ) ) {
				// Unsigned Short
				fieldValue = ( ( int )( byteBuffer.getShort() & 0xffff ) ) + "";
			} else if ( dataType.equals( "int" ) ) {
				// Int
				fieldValue = byteBuffer.getInt() + "";
			} else if ( dataType.equals( "uint" ) ) {
				// Unsigned Int
				fieldValue = ( ( long )( byteBuffer.getInt() & 0xffffffffL ) ) + "";
			} else if ( dataType.equals( "long" ) ) {
				// Long
				if ( fieldLength.equals( "4" ) ) {
					fieldValue = byteBuffer.getInt() + "";
				} else if ( fieldLength.equals( "8" ) ) {
					fieldValue = byteBuffer.getLong() + "";
				}
			} else if ( dataType.equals( "float" ) ) {
				// Float
				fieldValue = byteBuffer.getFloat() + "";
			} else if ( dataType.equals( "double" ) ) {
				// Double
				fieldValue = byteBuffer.getDouble() + "";
			} else if ( dataType.equals( "char" ) ) {
				// Char
				// getChar\uB294 2bytes\uB97C \uC785\uB825\uD568.
				if ( fieldLength.equals( "1" ) ) {
					fieldBuffer = new byte[ 1 ];
					byteBuffer.get( fieldBuffer );
						
					if ( encoding.equals( "" ) ) {
						fieldValue = new String( fieldBuffer );
					} else {
						fieldValue = new String( fieldBuffer, encoding );
					}
					
					fieldBuffer = null;
				} else if ( fieldLength.equals( "2" ) ) {
					// Ascii \uB370\uC774\uD130\uB85C\uB294 \uD55C \uC790\uB9AC\uC778\uB370 \uAE38\uC774\uB294 2bytes\uC778 \uACBD\uC6B0
					fieldValue = Character.toString( byteBuffer.getChar() );
				}
			} else if ( dataType.equals( "pcsstring" ) || dataType.equals( "string" ) ) {
				// PcsString												
				fieldBuffer = new byte[ Integer.parseInt( fieldLength ) ];
				byteBuffer.get( fieldBuffer );
					
				if ( encoding.equals( "" ) ) {
					fieldValue = new String( fieldBuffer );
				} else {
					fieldValue = new String( fieldBuffer, encoding );
				}
				
				fieldBuffer = null;
			} else if ( dataType.equals( "timestamp" ) ) {
				// \uBE44\uD45C\uC900 16 \uC790\uB9AC Timestamp(yyyyMMddHHmmssSS) ==> \uB450 \uC790\uB9AC\uC529 \uB04A\uC5B4\uC11C 8\uBC88 Get \uD55C\uB2E4. ==> byte \uAE38\uC774\uB294 8bytes
				for ( int i = 0; i < 8; i++ ) {
					b = byteBuffer.get();
					
					if ( b < 10 ) {
						// \uD55C \uC790\uB9AC \uC218\uC778 \uACBD\uC6B0\uC5D0\uB294 \uC55E\uC5D0 '0'\uC73C\uB85C \uD328\uB529\uD55C\uB2E4.
						fieldValue += ( "0" + b );
					} else {
						fieldValue += ( b + "" );
					}
				}
			}
			
			ht.put( "byteBuffer", byteBuffer );
			ht.put( "fieldValue", fieldValue );
		} catch ( Exception e ) {
			throw new ServiceException( e );
		}
		
		return ht;
	}
	// --- <<IS-END-SHARED>> ---
}

