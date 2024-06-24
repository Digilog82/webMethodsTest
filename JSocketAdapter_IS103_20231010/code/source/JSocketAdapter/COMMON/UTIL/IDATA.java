package JSocketAdapter.COMMON.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
import custom.java.com.log.DebugLogger;
// --- <<IS-END-IMPORTS>> ---

public final class IDATA

{
	// ---( internal utility methods )---

	final static IDATA _instance = new IDATA();

	static IDATA _newInstance() { return new IDATA(); }

	static IDATA _cast(Object o) { return (IDATA)o; }

	// ---( server methods )---




	public static final void changeDocName (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(changeDocName)>> ---
		// @sigtype java 3.5
		// [i] record:0:required orgDoc
		// [i] field:0:required newName
		// [o] record:0:required newDoc
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData orgDoc = IDataUtil.getIData( pipelineCursor, "orgDoc" );
		String newName = IDataUtil.getString( pipelineCursor, "newName" );
		pipelineCursor.destroy();
		
		IData newDoc = IDataFactory.create();
		IDataCursor docCursor = newDoc.getCursor();
		docCursor.insertAfter( newName, orgDoc );
		docCursor.destroy();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "newDoc", newDoc );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void changeFieldValue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(changeFieldValue)>> ---
		// @sigtype java 3.5
		// [i] record:0:required orgDoc
		// [i] field:0:required fieldName
		// [i] field:0:required fieldValue
		// [o] record:0:required newDoc
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData orgDoc = IDataUtil.getIData( pipelineCursor, "orgDoc" );
		String fieldName = IDataUtil.getString( pipelineCursor, "fieldName" );
		String fieldValue = IDataUtil.getString( pipelineCursor, "fieldValue" );
		pipelineCursor.destroy();
		
		IDataCursor cur = orgDoc.getCursor();
		String curKey = "";
		
		try {
			while ( cur.next() ) {
				curKey = cur.getKey();
				
				if ( curKey.equals( fieldName ) ) {
					cur.setValue( fieldValue );
					break;
				}
			}
		} catch ( Exception e ) {
			
		}
		
		cur.destroy();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "newDoc", orgDoc );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void createSchemaDef (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createSchemaDef)>> ---
		// @sigtype java 3.5
		// [i] field:0:required schemaDefine
		// [i] field:0:required existArrayCount
		// [o] field:0:required errorMsg
		// [o] record:0:required schemaDef
		IDataCursor pipelineCursor = pipeline.getCursor();
		String schemaDefine = IDataUtil.getString( pipelineCursor, "schemaDefine" );
		String existArrayCount = IDataUtil.getString( pipelineCursor, "existArrayCount" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		Hashtable ht = new Hashtable();
		Hashtable htArrayName = new Hashtable();
		IData schemaDef = IDataFactory.create();
		IDataCursor docCursor = schemaDef.getCursor();
		IData tempIdata = null;
		IData tempIdata2 = null;
		IDataCursor tempCursor = null;
		IData[] tempArray = null;
		String tempArrayName = "";
		String[] schemaList = null;
		String[] itemList = null;
		String[] arrayAttrList = null;
		String arrayFlag = "";
		String fieldName = "";
		String fieldDesc = "";
		String dataType = "";
		String paddingChar = "";
		String paddingDirection = "";
		String fieldLength = "";
		String fieldSchema = "";
		String arrayDepth = "";
		int arrayDepthNum = 0;
		String arrayName = "";
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
				
				if ( existArrayCount.equals( "true" ) ) {
					// Array Count YN \uD56D\uBAA9\uC774 \uD3EC\uD568\uB418\uC5B4 \uC788\uB294 \uACBD\uC6B0 ==> 2022.08.07 \uC774\uD6C4\uC758 \uC591\uC2DD
					if ( itemList.length == 7 ) {
						// \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
						arrayFlag = itemList[ 0 ].trim();
						//fieldName = itemList[ 1 ].trim();
						fieldName = itemList[ 1 ];
						fieldDesc = itemList[ 2 ];
						endianDataType = itemList[ 4 ];
						endianLength = itemList[ 5 ].trim();
						endianArrayCount = itemList[ 6 ].trim();
						
						// \uD544\uB4DC\uC5D0 \uB300\uD55C Schema \uC815\uC758 \uC0DD\uC131
						fieldSchema = endianDataType + "/" + endianLength + "/" + endianArrayCount + "/" + fieldDesc;
					} else {
						// Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uACBD\uC6B0 \uB610\uB294 \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
						arrayFlag = itemList[ 0 ].trim();
						//fieldName = itemList[ 1 ].trim();
						fieldName = itemList[ 1 ];
						fieldDesc = itemList[ 2 ];
						dataType = itemList[ 4 ].trim().toUpperCase();
						paddingChar = itemList[ 5 ];
						paddingDirection = itemList[ 6 ].trim().toUpperCase();
						fieldLength = itemList[ 7 ].trim();
						
						if ( itemList.length == 11 ) {
							// \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
							endianDataType = itemList[ 8 ];
							endianLength = itemList[ 9 ].trim();
							endianArrayCount = itemList[ 10 ].trim();
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
					
						// \uD544\uB4DC\uC5D0 \uB300\uD55C Schema \uC815\uC758 \uC0DD\uC131
						fieldSchema = fieldLength + "/" + paddingChar + "/" + paddingDirection + "/" + fieldDesc;
						
						if ( itemList.length == 11 ) {
							fieldSchema = fieldSchema + "/" + endianDataType + "/" + endianLength + "/" + endianArrayCount;
						}
					}
				} else {
					// Array Count YN \uD56D\uBAA9\uC774 \uD3EC\uD568\uB418\uC5B4 \uC788\uC9C0 \uC54A\uC740 \uACBD\uC6B0 ==> 2022.08.07 \uC774\uC804\uC758 \uC591\uC2DD
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
					
						// \uD544\uB4DC\uC5D0 \uB300\uD55C Schema \uC815\uC758 \uC0DD\uC131
						fieldSchema = fieldLength + "/" + paddingChar + "/" + paddingDirection + "/" + fieldDesc;
						
						if ( itemList.length == 10 ) {
							fieldSchema = fieldSchema + "/" + endianDataType + "/" + endianLength + "/" + endianArrayCount;
						}
					}
				}
				
				if ( arrayFlag.equals( "S" ) ) {
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
					
					docCursor.insertAfter( fieldName, fieldSchema );
				} else {
					// Array Record \uC601\uC5ED\uC758 \uD544\uB4DC\uC778 \uACBD\uC6B0
					arrayAttrList = arrayFlag.split( "/" );
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
					
					beforeArrayDepth = arrayDepth;
					beforeArrayName = arrayName;
				}
				
				arrayFlag = "";
				fieldName = "";
				fieldSchema = "";
			}
			
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



	public static final void createSchemaDef_20191230 (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createSchemaDef_20191230)>> ---
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
		IData tempIdata = null;
		IData tempIdata2 = null;
		IDataCursor tempCursor = null;
		IData[] tempArray = null;
		String tempArrayName = "";
		String[] schemaList = null;
		String[] itemList = null;
		String[] arrayAttrList = null;
		String arrayFlag = "";
		String fieldName = "";
		String fieldDesc = "";
		String dataType = "";
		String paddingChar = "";
		String paddingDirection = "";
		String fieldLength = "";
		String fieldSchema = "";
		String arrayDepth = "";
		int arrayDepthNum = 0;
		String arrayName = "";
		String beforeArrayDepth = "0";
		int beforeArrayDepthNum = 0;
		String beforeArrayName = "";
		String addArray = "false";
		
		try {
			// \uD544\uB4DC\uBCC4 \uC2A4\uD0A4\uB9C8 \uC815\uC758 \uBAA9\uB85D \uAD6C\uD558\uAE30
			schemaList = schemaDefine.split( "\\n" );
			
			for ( int i = 0; i < schemaList.length; i++ ) {
				// \uAC01 \uD544\uB4DC\uC5D0 \uB300\uD55C \uC2A4\uD0A4\uB9C8 \uC815\uC758 \uD56D\uBAA9\uB4E4 \uAD6C\uD558\uAE30
				itemList = schemaList[ i ].split( "\\t" );
				arrayFlag = itemList[ 0 ].trim();
				//fieldName = itemList[ 1 ].trim();
				fieldName = itemList[ 1 ];
				fieldDesc = itemList[ 2 ];
				dataType = itemList[ 3 ].trim().toUpperCase();
				paddingChar = itemList[ 4 ];
				paddingDirection = itemList[ 5 ].trim().toUpperCase();
				fieldLength = itemList[ 6 ].trim();
				
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
				
				// \uD544\uB4DC\uC5D0 \uB300\uD55C Schema \uC815\uC758 \uC0DD\uC131
				fieldSchema = fieldLength + "/" + paddingChar + "/" + paddingDirection + "/" + fieldDesc;
				
				if ( arrayFlag.equals( "S" ) ) {
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
					
					docCursor.insertAfter( fieldName, fieldSchema );
				} else {
					// Array Record \uC601\uC5ED\uC758 \uD544\uB4DC\uC778 \uACBD\uC6B0
					arrayAttrList = arrayFlag.split( "/" );
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
					
					beforeArrayDepth = arrayDepth;
					beforeArrayName = arrayName;
				}
				
				arrayFlag = "";
				fieldName = "";
				fieldSchema = "";
			}
			
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



	public static final void createTestData (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createTestData)>> ---
		// @sigtype java 3.5
		// [i] record:0:required schemaDef
		// [i] field:1:required recCountFieldName
		// [o] field:0:required errorMsg
		// [o] record:0:required TestData
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData schemaDef = IDataUtil.getIData( pipelineCursor, "schemaDef" );		
		String[] recCountFieldName = IDataUtil.getStringArray( pipelineCursor, "recCountFieldName" );
		pipelineCursor.destroy();
		
		IData[] TestDataInfo = null;
		IData TestData = null;
		String errorMsg = "";
		
		try {
			TestDataInfo = makeTestData( schemaDef, recCountFieldName, 0 );
			TestData = TestDataInfo[ 0 ];
		}  catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		schemaDef = null;
		recCountFieldName = null;
		TestDataInfo = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "TestData", TestData );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void extractXpathValue (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(extractXpathValue)>> ---
		// @sigtype java 3.5
		// [i] record:0:required inDoc
		// [i] field:0:required XPath
		// [i] field:0:required rootMapLoc {"0","1"}
		// [o] field:0:required exist
		// [o] field:0:required XPathValue
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData inDoc = IDataUtil.getIData( pipelineCursor, "inDoc" );
		String XPath = IDataUtil.getString( pipelineCursor, "XPath" );
		int rootMapLoc = IDataUtil.getInt( pipelineCursor, "rootMapLoc", 0 );
		pipelineCursor.destroy();
		
		String exist = "";
		String XPathValue = null;
		String[] xpathList = null;
		String firstString = "";
		int startSeq = 0;
		
		try {
			if ( rootMapLoc == 0 ) {
				startSeq = 1;
			} else {
				startSeq = 0;
			}
			
			firstString = XPath.substring( 0, 1 );
			
			if ( firstString.equals( "/" ) ) {
				XPath = XPath.substring( 1 );
			}
			
			XPath = XPath.replaceAll( " ", "" );
			xpathList = XPath.split( "/" );
			XPathValue = extractValue( inDoc, xpathList, startSeq );
			
			if ( XPathValue == null ) {
				exist = "false";
				XPathValue = "";
			} else {
				exist = "true";
			}
		} catch ( Exception e ) {
			throw new ServiceException( e.toString() );
		}
		
		inDoc = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exist", exist );
		IDataUtil.put( pipelineCursor_1, "XPathValue", XPathValue );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getChildDoc (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getChildDoc)>> ---
		// @sigtype java 3.5
		// [i] record:0:required parentDoc
		// [i] field:0:required childSeq
		// [o] record:0:required childDoc
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData parentDoc = IDataUtil.getIData( pipelineCursor, "parentDoc" );
		int childSeq = IDataUtil.getInt( pipelineCursor, "childSeq", 1 );
		pipelineCursor.destroy();
		
		IDataCursor cur = parentDoc.getCursor();
		Object obj = null;
		IData childDoc = null;
		int searchSeq = 1;
		
		try {
			while ( cur.next() ) {
				obj = cur.getValue();
				
				if ( obj instanceof IData ) { // obj is IData
					if ( searchSeq == childSeq ) {
						childDoc = ( IData )obj;
						break;
					} else {
						searchSeq++;
					}
				} else {
					continue;
				}
			}
		} catch ( Exception e ) {
			throw new ServiceException( e.toString() );
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "childDoc", childDoc );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getChildDocFromUnknown (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getChildDocFromUnknown)>> ---
		// @sigtype java 3.5
		// [i] field:0:required partName
		// [i] field:0:required childSeq
		// [o] record:0:required rootDoc
		// [o] record:0:required childDoc
		IDataCursor pipelineCursor = pipeline.getCursor();
		String partName = IDataUtil.getString( pipelineCursor, "partName" );
		int childSeq = IDataUtil.getInt( pipelineCursor, "childSeq", 1 );
		pipelineCursor.destroy();
		
		if ( partName == null ) {
			partName = "";
		}
		
		IDataCursor cur = null;
		Object obj = null;
		Object childObj = null;
		IData rootDoc = null;
		IData childDoc = null;
		String curKey = null;
		int searchSeq = 1;
		
		// pipeline\uC5D0 \uC874\uC7AC\uD558\uB294 IData \uC774\uB984\uC744 \uC544\uC608 \uC54C \uC218 \uC5C6\uB294 \uACBD\uC6B0\uC5D0\uB294 \uCCAB\uBC88\uC9F8 IData Object\uC758 Child IData Object\uB97C \uAD6C\uD558\uACE0
		// \uC774\uB984\uC744 \uC77C\uBD80 \uC54C\uACE0 \uC788\uB294 \uACBD\uC6B0\uC5D0\uB294 \uC774\uB984 \uC77C\uBD80\uAC00 \uC77C\uCE58\uD558\uB294 \uCCAB\uBC88\uC9F8 IData Object\uC758 Child IData Object\uB97C \uAD6C\uD55C\uB2E4.
		
		try {
			if ( partName.equals( "" ) ) {
				// \uCCAB\uBC88\uC9F8 IData Object\uC758 Child IData Object\uB97C \uAD6C\uD55C\uB2E4.
				while ( pipelineCursor.next() ) {
					obj = pipelineCursor.getValue();
					
					if ( obj instanceof IData ) { // obj is IData
						rootDoc = ( IData )obj;
						cur = rootDoc.getCursor();
						
						while ( cur.next() ) {
							childObj = cur.getValue();
							
							if ( childObj instanceof IData ) { // childObj is IData
								if ( searchSeq == childSeq ) {
									childDoc = ( IData )childObj;
									break;
								} else {
									searchSeq++;
								}
							} else {
								continue;
							}
						}
					} else {
						continue;
					}
				}
			} else {
				// \uC77C\uBD80 \uC774\uB984\uC744 \uD3EC\uD568\uD558\uACE0 \uC788\uB294 \uCCAB\uBC88\uC9F8 IData Object\uC758 Child IData Object\uB97C \uAD6C\uD55C\uB2E4.
				while ( pipelineCursor.next() ) {
					obj = pipelineCursor.getValue();
					curKey = pipelineCursor.getKey();
					
					if ( obj instanceof IData ) { // obj is IData
						// IData Object\uC758 \uC774\uB984\uC774 partName\uC744 \uD3EC\uD568\uD558\uACE0 \uC788\uB294\uC9C0 \uCCB4\uD06C\uD55C\uB2E4.
						if ( curKey.contains( partName ) ) {
							rootDoc = ( IData )obj;
							cur = rootDoc.getCursor();
						
							while ( cur.next() ) {
								childObj = cur.getValue();
							
								if ( childObj instanceof IData ) { // childObj is IData
									if ( searchSeq == childSeq ) {
										childDoc = ( IData )childObj;
										break;
									} else {
										searchSeq++;
									}
								} else {
									continue;
								}
							}
						} else {
							continue;
						}
					} else {
						continue;
					}
				}
			}
		} catch ( Exception e ) {
			throw new ServiceException( e.toString() );
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "rootDoc", rootDoc );
		IDataUtil.put( pipelineCursor_1, "childDoc", childDoc );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void mergeDoc (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(mergeDoc)>> ---
		// @sigtype java 3.5
		// [i] record:0:required inputDoc1
		// [i] record:0:required inputDoc2
		// [o] record:0:required outputDoc
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData inputDoc1 = IDataUtil.getIData( pipelineCursor, "inputDoc1" );
		IData inputDoc2 = IDataUtil.getIData( pipelineCursor, "inputDoc2" );
		pipelineCursor.destroy();
		
		IDataCursor cur = inputDoc2.getCursor();
		IDataCursor outCursor = inputDoc1.getCursor();
		
		try {
			while ( cur.next() ) {
				outCursor.insertAfter( cur.getKey(), cur.getValue() );
			}
		} catch ( Exception e ) {
			throw new ServiceException( e.toString() );
		}
		
		cur.destroy();
		outCursor.destroy();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outputDoc", inputDoc1 );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void setPipelineData (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(setPipelineData)>> ---
		// @sigtype java 3.5
		// [o] record:0:required pipelineData
		IData pipelineData = null;
		
		try {
			pipelineData = IDataUtil.deepClone( pipeline );
		} catch ( Exception e ) {
			
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "pipelineData", pipelineData );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static DebugLogger debugLogger = new DebugLogger();
	
	public static IData[] makeTestData( IData schemaDef, String[] recCountFieldName, int recIndex ) throws ServiceException {
		IDataCursor cur = schemaDef.getCursor(); // Schema \uC815\uC758 IData
		String curKey = null;
		Object obj = null;
		String keyValue = ""; // Field\uC5D0 \uB300\uD55C Schema \uC815\uC758 String ==> Field Length/Padding String/Left Padding, Right Padding \uAD6C\uBD84
		String fieldValue = "";
		String[] token = null;
		String padding = "";
		IData[] recList = null;
		int recCount = 0; // Record \uAC2F\uC218
		IData[] docList = null;
		IData[] docInfo = new IData[ 2 ];		
		IData doc = IDataFactory.create();
		IDataCursor docCursor = doc.getCursor();
		IData recCountIndex = IDataFactory.create();
		IDataCursor recCountCursor = recCountIndex.getCursor();
		int tempRecIndex = 0;
		IData[] tempDocInfo = null;
		IDataCursor tempCursor = null;
		String currentTime = "";
		
		try {
			while ( cur.next() ) {
				curKey = cur.getKey();
				obj = cur.getValue();
	
				if ( obj == null ) {
					continue;
				} else if ( obj instanceof String ) { // obj is String
					keyValue = ( String )obj;
					
					token = keyValue.split( "/" );
					
					if ( token.length == 7 ) {
						// \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
						padding = token[ 4 ]; // Data Type
						padding = padding.toLowerCase();
						
						if ( padding.equals( "pcsstring" ) || padding.equals( "string" ) || padding.equals( "char" ) ) {
							fieldValue = "a";
						} else if ( padding.equals( "timestamp" ) ) {
							if ( currentTime.equals( "" ) ) {
								// \uCD5C\uCD08\uC5D0 \uD55C \uBC88\uB9CC \uC218\uD589
								SimpleDateFormat sdf = new SimpleDateFormat( "yyyyMMddHHmmssSSS" );
								Date curDate = new Date();
								currentTime = sdf.format( curDate ).substring( 0, 16 );
								fieldValue = currentTime;
								curDate = null;
								sdf = null;
							} else {
								fieldValue = currentTime;
							}
						} else {
							fieldValue = "3";
						}
					} else if ( token.length <= 4 ) {
						try {
							Integer.parseInt( token[ 0 ] );
							// \uCCAB\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790(\uD544\uB4DC\uC758 \uAE38\uC774)\uC778 \uACBD\uC6B0 ==> Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0
							padding = token[ 2 ]; // Left Padding, Right Padding \uAD6C\uBD84
							
							if ( padding.equals( "RP" ) ) {
								fieldValue = "a";
							} else if ( padding.equals( "LP" ) ) {
								fieldValue = "3";
							}
						} catch ( Exception ne ) {
							// \uCCAB\uBC88\uC9F8 \uD56D\uBAA9\uC774 \uC22B\uC790\uAC00 \uC544\uB2CC(Data Type) \uACBD\uC6B0 ==> \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
							padding = token[ 0 ]; // Data Type
							padding = padding.toLowerCase();
							
							if ( padding.equals( "pcsstring" ) || padding.equals( "string" ) || padding.equals( "char" ) ) {
								fieldValue = "a";
							} else if ( padding.equals( "timestamp" ) ) {
								if ( currentTime.equals( "" ) ) {
									// \uCD5C\uCD08\uC5D0 \uD55C \uBC88\uB9CC \uC218\uD589
									SimpleDateFormat sdf = new SimpleDateFormat( "yyyyMMddHHmmssSSS" );
									Date curDate = new Date();
									currentTime = sdf.format( curDate ).substring( 0, 16 );
									fieldValue = currentTime;
									curDate = null;
									sdf = null;
								} else {
									fieldValue = currentTime;
								}
							} else {
								fieldValue = "3";
							}
						}
					}
					
					docCursor.insertAfter( curKey, fieldValue );
				} else if ( obj instanceof IData[] ) { // obj is IData[]
					recList = ( IData[] )obj;
					
					if ( recList == null ) {
						continue;
					}
					
					if ( recCountFieldName == null || recCountFieldName.length == 0 ) {
						recCount = 3; // \uAC00\uBCC0\uAE38\uC774\uC774\uBA74\uC11C Array Count \uD544\uB4DC\uAC00 \uC5C6\uB294 \uACBD\uC6B0 ==> 3\uC73C\uB85C \uACE0\uC815 \uC14B\uD305
					} else {
						try {
							recCount = Integer.parseInt( recCountFieldName[ recIndex ] ); // \uACE0\uC815\uAE38\uC774\uC778 \uACBD\uC6B0
						} catch ( Exception ce ) {
							recCount = 3; // \uAC00\uBCC0\uAE38\uC774\uC778 \uACBD\uC6B0 ==> 3\uC73C\uB85C \uACE0\uC815 \uC14B\uD305
						}
					}
					
					docList = new IData[ recCount ];
					
					for ( int i = 0; i < recCount; i++ ) {
						tempDocInfo = makeTestData( recList[ 0 ], recCountFieldName, recIndex + 1 );
						
						if ( i == 0 ) {
							tempCursor = tempDocInfo[ 1 ].getCursor();
							tempRecIndex = IDataUtil.getInt( tempCursor, "recIndex", 0 );
							tempCursor.destroy();
						}
						
						docList[ i ] = tempDocInfo[ 0 ];
						tempDocInfo = null;
					}
					
					// recCountFieldName\uC758 Index \uC99D\uAC00
					recIndex = tempRecIndex;
					docCursor.insertAfter( curKey, docList );
				}
			}
			
			// recCountFieldName Index \uB9AC\uD134
			recCountCursor.insertAfter( "recIndex", recIndex + "" );
		} catch ( Exception e ) {
			throw new ServiceException( e );
		}
		
		docInfo[ 0 ] = doc;
		docInfo[ 1 ] = recCountIndex;
		
		cur.destroy();
		docCursor.destroy();
		recCountCursor.destroy();
		obj = null;
		recList = null;
		docList = null;
		doc = null;
		recCountIndex = null;
		
		return docInfo;
	}
	
	public static String extractValue( IData idata, String[] xpathList, int xpathSeq ) {
		String xpathValue = null;
		IDataCursor cur = idata.getCursor();
		IData nextIData = null;
		IData[] nextIDataList = null;
		Object obj = null;
		String[] xpathValueList = null;
		String curKey = null;
		String xpathName = "";
		String pathSeq = "";
		String pathName = "";
		int seqSIndex = 0;
		int seqEIndex = 0;
		
		try {
			while ( cur.next() ) {
				curKey = cur.getKey();
				obj = cur.getValue();
				
				if ( obj instanceof IData ) { // obj is IData
					if ( curKey.equals( xpathList[ xpathSeq ] ) ) {
						nextIData = ( IData )obj;
						xpathSeq++;
						xpathValue = extractValue( nextIData, xpathList, xpathSeq );
						break;
					}
				} else if ( obj instanceof IData[] ) { // obj is IData[]
					xpathName = xpathList[ xpathSeq ];
					seqSIndex = xpathName.indexOf( "[" );
					pathName = xpathName.substring( 0, seqSIndex );
					
					if ( curKey.equals( pathName ) ) {					
						seqEIndex = xpathName.indexOf( "]" );
						pathSeq = xpathName.substring( seqSIndex + 1, seqEIndex );
						nextIDataList = ( IData[] )obj;
						xpathSeq++;
						xpathValue = extractValue( nextIDataList[ Integer.parseInt( pathSeq ) ], xpathList, xpathSeq );
						break;
					}
				} else if ( obj instanceof String ) { // obj is String
					if ( curKey.equals( xpathList[ xpathSeq ] ) ) {
						xpathValue = ( String )obj;
						break;
					}
				} else if ( obj instanceof String[] ) { // obj is String[]
					xpathName = xpathList[ xpathSeq ];
					seqSIndex = xpathName.indexOf( "[" );
					pathName = xpathName.substring( 0, seqSIndex );
					
					if ( curKey.equals( pathName ) ) {					
						seqEIndex = xpathName.indexOf( "]" );
						pathSeq = xpathName.substring( seqSIndex + 1, seqEIndex );
						xpathValueList = ( String[] )obj;
						xpathValue = xpathValueList[ Integer.parseInt( pathSeq ) ];
						break;
					}
				}
			}
		} catch ( Exception e ) {
			
		}
		
		cur.destroy();
		nextIData = null;
		obj = null;
		
		return xpathValue;
	}
	// --- <<IS-END-SHARED>> ---
}

