package JSocketAdapter.COMMON.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import custom.java.com.log.DebugLogger;
import java.io.File;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableWorkbook;
import jxl.write.WritableSheet;
// --- <<IS-END-IMPORTS>> ---

public final class EXCEL

{
	// ---( internal utility methods )---

	final static EXCEL _instance = new EXCEL();

	static EXCEL _newInstance() { return new EXCEL(); }

	static EXCEL _cast(Object o) { return (EXCEL)o; }

	// ---( server methods )---




	public static final void getSchemaDefine (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getSchemaDefine)>> ---
		// @sigtype java 3.5
		// [i] field:0:required filename
		// [o] field:0:required errorMsg
		// [o] field:0:required schemaDefine
		IDataCursor pipelineCursor = pipeline.getCursor();
		String filename = IDataUtil.getString( pipelineCursor, "filename" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		Sheet sh = null;
		Cell cell = null;
		Workbook wb = null;
		int colCnt = 0;
		// 6 : \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0, 7 : Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0, 9 : JSON \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0, 10 : \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
		int rowCnt = 0;
		String cellContent = "";
		StringBuffer schemaDefine = new StringBuffer();
		
		try {
			// \uC5D1\uC140\uD30C\uC77C Read
			wb = Workbook.getWorkbook( new File( filename ) );
			
			// Sheet Read
			sh = wb.getSheet( 0 );
			
			colCnt = sh.getColumns();
			rowCnt = sh.getRows();
			
			// Record \uAC2F\uC218 \uB9CC\uD07C Looping
			for ( int i = 0; i < rowCnt; i++ ) {
				// \uCCAB\uBC88\uC9F8 Record\uC5D0\uB294 Column\uC5D0 \uB300\uD55C Title\uC774 \uC788\uC73C\uBBC0\uB85C Read \uD558\uC9C0 \uC54A\uB294\uB2E4.
				if ( i > 0 ) {
					// Column \uAC2F\uC218 \uB9CC\uD07C Looping
					for ( int j = 0; j < colCnt; j++ ) {
						// Column Read						
						cell = sh.getCell( j, i );
						schemaDefine.append( cell.getContents() );
						
						// \uCEEC\uB7FC\uACFC \uCEEC\uB7FC \uC0AC\uC774\uC5D0 Tab \uCD94\uAC00. \uB9C8\uC9C0\uB9C9 \uCEEC\uB7FC \uB4A4\uC5D0\uB294 Tab\uC744 \uCD94\uAC00\uD558\uC9C0 \uC54A\uC74C.
						if ( j < ( colCnt - 1 ) ) {
							schemaDefine.append( "	" );
						}
					}
				
					// Record\uC640 Record \uC0AC\uC774\uC5D0 Enter \uCD94\uAC00. \uB9C8\uC9C0\uB9C9 Record \uB4A4\uC5D0\uB294 Enter\uB97C \uCD94\uAC00\uD558\uC9C0 \uC54A\uC74C.
					if ( i < ( rowCnt - 1 ) ) {
						schemaDefine.append( "\n" );
					}
				}
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		sh = null;
		cell = null;
		wb = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "schemaDefine", schemaDefine.toString() );		
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void makeAuditLogExcel (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(makeAuditLogExcel)>> ---
		// @sigtype java 3.5
		// [i] record:1:required ReqCommonSchemaList
		// [i] record:1:required ReqBodySchemaList
		// [i] record:1:required ResCommonSchemaList
		// [i] record:1:required ResBodySchemaList
		// [i] record:1:required ReqCommonDataList
		// [i] record:1:required ReqBodyDataList
		// [i] record:1:required ResCommonDataList
		// [i] record:1:required ResBodyDataList
		// [i] field:0:required reqSocketString
		// [i] field:0:required resSocketString
		// [i] field:0:required filePath
		// [i] field:0:required fileName
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData[] ReqCommonSchemaList = IDataUtil.getIDataArray( pipelineCursor, "ReqCommonSchemaList" );
		IData[] ReqBodySchemaList = IDataUtil.getIDataArray( pipelineCursor, "ReqBodySchemaList" );
		IData[] ResCommonSchemaList = IDataUtil.getIDataArray( pipelineCursor, "ResCommonSchemaList" );
		IData[] ResBodySchemaList = IDataUtil.getIDataArray( pipelineCursor, "ResBodySchemaList" );
		IData[] ReqCommonDataList = IDataUtil.getIDataArray( pipelineCursor, "ReqCommonDataList" );
		IData[] ReqBodyDataList = IDataUtil.getIDataArray( pipelineCursor, "ReqBodyDataList" );
		IData[] ResCommonDataList = IDataUtil.getIDataArray( pipelineCursor, "ResCommonDataList" );
		IData[] ResBodyDataList = IDataUtil.getIDataArray( pipelineCursor, "ResBodyDataList" );
		String reqSocketString = IDataUtil.getString( pipelineCursor, "reqSocketString" );
		String resSocketString = IDataUtil.getString( pipelineCursor, "resSocketString" );
		String filePath = IDataUtil.getString( pipelineCursor, "filePath" );
		String fileName = IDataUtil.getString( pipelineCursor, "fileName" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		File dir = null;
		File file = null;
		
		int reqCommonSchemaSize = 0;
		int reqBodySchemaSize = 0;
		int resCommonSchemaSize = 0;
		int resBodySchemaSize = 0;
		int reqCommonDataSize = 0;
		int reqBodyDataSize = 0;
		int resCommonDataSize = 0;
		int resBodyDataSize = 0;
		
		WritableWorkbook wb = null;
		WritableSheet wsh1 = null;
		WritableSheet wsh2 = null;
		Label label = null;
		int rowNum = 0;
		IDataCursor cur = null;
		String idataType = "";
		String[] schemaList = null;
		int listDepth = 0;
		String spaces = "";
		String listName = "";
		String fieldName = "";
		String fieldValue = "";
		String titleValue = "";
		String[] valueList = null;
		String create = "false";
		
		try {
			dir = new File( filePath );
			
			// \uB514\uB809\uD1A0\uB9AC\uAC00 \uC5C6\uC744 \uACBD\uC6B0 \uB514\uB809\uD1A0\uB9AC \uC0DD\uC131
			if ( !dir.exists() ) {
				dir.mkdirs();
			}
			
			// \uBE48 \uC5D1\uC140\uD30C\uC77C \uC0DD\uC131
			file = new File( filePath + fileName );
			
			// \uC5D1\uC140\uD30C\uC77C \uC0DD\uC131
			wb = Workbook.createWorkbook( file );
			
			if ( ReqCommonSchemaList != null ) {
				reqCommonSchemaSize = ReqCommonSchemaList.length;
			}
			
			if ( ReqBodySchemaList != null ) {
				reqBodySchemaSize = ReqBodySchemaList.length;
			}
			
			if ( ResCommonSchemaList != null ) {
				resCommonSchemaSize = ResCommonSchemaList.length;
			}
			
			if ( ResBodySchemaList != null ) {
				resBodySchemaSize = ResBodySchemaList.length;
			}
			
			if ( ReqCommonDataList != null ) {
				reqCommonDataSize = ReqCommonDataList.length;
			}
			
			if ( ReqBodyDataList != null ) {
				reqBodyDataSize = ReqBodyDataList.length;
			}
			
			if ( ResCommonDataList != null ) {
				resCommonDataSize = ResCommonDataList.length;
			}
			
			if ( ResBodyDataList != null ) {
				resBodyDataSize = ResBodyDataList.length;
			}
			
			if ( reqSocketString == null ) {
				reqSocketString = "";
			}
			
			if ( resSocketString == null ) {
				resSocketString = "";
			}
			
			// Schema Def Sheet \uC0DD\uC131
			if ( reqCommonSchemaSize > 0 || reqBodySchemaSize > 0 || resCommonSchemaSize > 0 || resBodySchemaSize > 0 ) {
				// Sheet \uC0DD\uC131
				wsh1 = wb.createSheet( "Shema Def", 0 );
				create = "true";
				
				// \uC694\uCCAD\uC804\uBB38 \uACF5\uD1B5\uC815\uBCF4\uBD80 Schema Def \uB370\uC774\uD130 \uC0DD\uC131
				if ( reqCommonSchemaSize > 0 ) {
					label = new Label( 0, rowNum, "\uC694\uCCAD\uC804\uBB38 \uACF5\uD1B5\uC815\uBCF4\uBD80 Schema Def" );
					wsh1.addCell( label );
					rowNum++;
					
					// Schema Def \uD544\uB4DC\uBA85 \uCD94\uAC00
					/*
					label = new Label( 0, rowNum, "\uD544\uB4DC\uBA85" );
					wsh1.addCell( label );
					label = new Label( 1, rowNum, "\uD544\uB4DC\uC124\uBA85" );
					wsh1.addCell( label );
					label = new Label( 2, rowNum, "\uD544\uB4DC\uAE38\uC774" );
					wsh1.addCell( label );
					label = new Label( 3, rowNum, "\uD328\uB529\uBB38\uC790" );
					wsh1.addCell( label );
					label = new Label( 4, rowNum, "\uD328\uB529\uD0C0\uC785" );
					wsh1.addCell( label );
					rowNum++;
					*/
					
					// Schema Def \uB370\uC774\uD130 \uCD94\uAC00
					for ( int i = 0; i < reqCommonSchemaSize; i++ ) {
						cur = ReqCommonSchemaList[ i ].getCursor();
						idataType = IDataUtil.getString( cur, "idataType" );
						listDepth = IDataUtil.getInt( cur, "listDepth", 0 );
						listName = IDataUtil.getString( cur, "listName" );
						schemaList = IDataUtil.getStringArray( cur, "schemaList" );
						
						// Schema Def \uD544\uB4DC\uBA85 \uCD94\uAC00 ==> \uCD5C\uCD08\uC5D0 \uD55C \uBC88\uB9CC \uC2E4\uD589
						if ( i == 0 ) {
							if ( schemaList.length == 5 ) {
								try {
									Integer.parseInt( schemaList[ 2 ] );
									
									// Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0 ==> schemaList[ 2 ]\uC5D0 Field Length(\uC22B\uC790)\uAC00 \uB2F4\uACA8\uC788\uB2E4.
									label = new Label( 0, rowNum, "Field Name" );
									wsh1.addCell( label );
									label = new Label( 1, rowNum, "Field Desc" );
									wsh1.addCell( label );
									label = new Label( 2, rowNum, "Field Length" );
									wsh1.addCell( label );
									label = new Label( 3, rowNum, "Padding Char" );
									wsh1.addCell( label );
									label = new Label( 4, rowNum, "Padding Type" );
									wsh1.addCell( label );
								} catch ( Exception ne ) {
									// \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0 ==> schemaList[ 2 ]\uC5D0 Data Type(\uBB38\uC790)\uAC00 \uB2F4\uACA8\uC788\uB2E4.
									label = new Label( 0, rowNum, "Field Name" );
									wsh1.addCell( label );
									label = new Label( 1, rowNum, "Field Desc" );
									wsh1.addCell( label );
									label = new Label( 2, rowNum, "Data Type" );
									wsh1.addCell( label );
									label = new Label( 3, rowNum, "Field Length" );
									wsh1.addCell( label );
									label = new Label( 4, rowNum, "Array Count" );
									wsh1.addCell( label );
								}
							} else if ( schemaList.length == 8 ) {
								// \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
								label = new Label( 0, rowNum, "Field Name" );
								wsh1.addCell( label );
								label = new Label( 1, rowNum, "Field Desc" );
								wsh1.addCell( label );
								label = new Label( 2, rowNum, "Field Length" );
								wsh1.addCell( label );
								label = new Label( 3, rowNum, "Padding Char" );
								wsh1.addCell( label );
								label = new Label( 4, rowNum, "Padding Type" );
								wsh1.addCell( label );
								label = new Label( 5, rowNum, "Data Type" );
								wsh1.addCell( label );
								label = new Label( 6, rowNum, "Field Length" );
								wsh1.addCell( label );
								label = new Label( 7, rowNum, "Array Count" );
								wsh1.addCell( label );
							}
							
							rowNum++;
						}
						
						if ( idataType.equals( "field" ) ) {
							// \uD544\uB4DC\uC758 Value \uCD94\uAC00
							for ( int j = 0; j < schemaList.length; j ++ ) {
								if ( j == 0 ) {
									// \uD544\uB4DC\uBA85 \uB370\uC774\uD130\uB97C \uCD94\uAC00\uD558\uAE30 \uC804\uC5D0 Indent\uB97C \uC704\uD55C Space \uB9CC\uB4E4\uAE30
									if ( listDepth > 0 ) {
										for ( int k = 0; k < ( listDepth * 2 ); k++ ) {
											spaces += " ";
										}
									} else {
										spaces = "";
									}
								} else {
									spaces = "";
								}
							
								label = new Label( j, rowNum, spaces + schemaList[ j ] );
								wsh1.addCell( label );
							}
						} else {
							// Array Title \uCD94\uAC00
							for ( int k = 0; k < ( listDepth * 2 ); k++ ) {
								spaces += " ";
							}
							
							label = new Label( 0, rowNum, spaces + listName + " Array Schema" );
							wsh1.addCell( label );
						}
						
						// \uBCC0\uC218 \uCD08\uAE30\uD654
						cur.destroy();
						idataType = "";
						listDepth = 0;
						listName = "";
						schemaList = null;
						spaces = "";
						rowNum++;
					}
				}
				
				// \uC694\uCCAD\uC804\uBB38 \uC5C5\uBB34\uC815\uBCF4\uBD80 Schema Def \uB370\uC774\uD130 \uC0DD\uC131
				if ( reqBodySchemaSize > 0 ) {
					if ( reqCommonSchemaSize > 0 ) {
						// \uC55E\uC5D0\uC11C \uACF5\uD1B5\uC815\uBCF4\uBD80 Schema Def \uB370\uC774\uD130\uB97C \uC0DD\uC131\uD55C \uACBD\uC6B0 Row Number\uB97C +1 \uD55C\uB2E4.
						rowNum++;
					}
					
					label = new Label( 0, rowNum, "\uC694\uCCAD\uC804\uBB38 \uC5C5\uBB34\uC815\uBCF4\uBD80 Schema Def" );
					wsh1.addCell( label );
					rowNum++;
					
					// Schema Def \uD544\uB4DC\uBA85 \uCD94\uAC00
					/*
					label = new Label( 0, rowNum, "\uD544\uB4DC\uBA85" );
					wsh1.addCell( label );
					label = new Label( 1, rowNum, "\uD544\uB4DC\uC124\uBA85" );
					wsh1.addCell( label );
					label = new Label( 2, rowNum, "\uD544\uB4DC\uAE38\uC774" );
					wsh1.addCell( label );
					label = new Label( 3, rowNum, "\uD328\uB529\uBB38\uC790" );
					wsh1.addCell( label );
					label = new Label( 4, rowNum, "\uD328\uB529\uD0C0\uC785" );
					wsh1.addCell( label );
					rowNum++;
					*/
					
					// Schema Def \uB370\uC774\uD130 \uCD94\uAC00
					for ( int i = 0; i < reqBodySchemaSize; i++ ) {
						cur = ReqBodySchemaList[ i ].getCursor();
						idataType = IDataUtil.getString( cur, "idataType" );
						listDepth = IDataUtil.getInt( cur, "listDepth", 0 );
						listName = IDataUtil.getString( cur, "listName" );
						schemaList = IDataUtil.getStringArray( cur, "schemaList" );
						
						// Schema Def \uD544\uB4DC\uBA85 \uCD94\uAC00 ==> \uCD5C\uCD08\uC5D0 \uD55C \uBC88\uB9CC \uC2E4\uD589
						if ( i == 0 ) {
							if ( schemaList.length == 5 ) {
								try {
									Integer.parseInt( schemaList[ 2 ] );
									
									// Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0 ==> schemaList[ 2 ]\uC5D0 Field Length(\uC22B\uC790)\uAC00 \uB2F4\uACA8\uC788\uB2E4.
									label = new Label( 0, rowNum, "Field Name" );
									wsh1.addCell( label );
									label = new Label( 1, rowNum, "Field Desc" );
									wsh1.addCell( label );
									label = new Label( 2, rowNum, "Field Length" );
									wsh1.addCell( label );
									label = new Label( 3, rowNum, "Padding Char" );
									wsh1.addCell( label );
									label = new Label( 4, rowNum, "Padding Type" );
									wsh1.addCell( label );
								} catch ( Exception ne ) {
									// \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0 ==> schemaList[ 2 ]\uC5D0 Data Type(\uBB38\uC790)\uAC00 \uB2F4\uACA8\uC788\uB2E4.
									label = new Label( 0, rowNum, "Field Name" );
									wsh1.addCell( label );
									label = new Label( 1, rowNum, "Field Desc" );
									wsh1.addCell( label );
									label = new Label( 2, rowNum, "Data Type" );
									wsh1.addCell( label );
									label = new Label( 3, rowNum, "Field Length" );
									wsh1.addCell( label );
									label = new Label( 4, rowNum, "Array Count" );
									wsh1.addCell( label );
								}
							} else if ( schemaList.length == 8 ) {
								// \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
								label = new Label( 0, rowNum, "Field Name" );
								wsh1.addCell( label );
								label = new Label( 1, rowNum, "Field Desc" );
								wsh1.addCell( label );
								label = new Label( 2, rowNum, "Field Length" );
								wsh1.addCell( label );
								label = new Label( 3, rowNum, "Padding Char" );
								wsh1.addCell( label );
								label = new Label( 4, rowNum, "Padding Type" );
								wsh1.addCell( label );
								label = new Label( 5, rowNum, "Data Type" );
								wsh1.addCell( label );
								label = new Label( 6, rowNum, "Field Length" );
								wsh1.addCell( label );
								label = new Label( 7, rowNum, "Array Count" );
								wsh1.addCell( label );
							}
							
							rowNum++;
						}
						
						if ( idataType.equals( "field" ) ) {
							for ( int j = 0; j < schemaList.length; j ++ ) {
								if ( j == 0 ) {
									// \uD544\uB4DC\uBA85 \uB370\uC774\uD130\uB97C \uCD94\uAC00\uD558\uAE30 \uC804\uC5D0 Indent\uB97C \uC704\uD55C Space \uB9CC\uB4E4\uAE30
									if ( listDepth > 0 ) {
										for ( int k = 0; k < ( listDepth * 2 ); k++ ) {
											spaces += " ";
										}
									} else {
										spaces = "";
									}
								} else {
									spaces = "";
								}
							
								label = new Label( j, rowNum, spaces + schemaList[ j ] );
								wsh1.addCell( label );
							}
						} else {
							// Array Title \uCD94\uAC00
							for ( int k = 0; k < ( listDepth * 2 ); k++ ) {
								spaces += " ";
							}
							
							label = new Label( 0, rowNum, spaces + listName + " Array Schema" );
							wsh1.addCell( label );
						}
						
						// \uBCC0\uC218 \uCD08\uAE30\uD654
						cur.destroy();
						idataType = "";
						listDepth = 0;
						listName = "";
						schemaList = null;
						spaces = "";
						rowNum++;
					}
				}
				
				// \uC751\uB2F5\uC804\uBB38 \uACF5\uD1B5\uC815\uBCF4\uBD80 Schema Def \uB370\uC774\uD130 \uC0DD\uC131
				if ( resCommonSchemaSize > 0 ) {
					if ( reqCommonSchemaSize > 0 || reqBodySchemaSize > 0 ) {
						// \uC55E\uC5D0\uC11C \uC694\uCCAD\uC804\uBB38 Schema Def \uB370\uC774\uD130\uB97C \uC0DD\uC131\uD55C \uACBD\uC6B0 Row Number\uB97C +1 \uD55C\uB2E4.
						rowNum++;
					}
					
					label = new Label( 0, rowNum, "\uC751\uB2F5\uC804\uBB38 \uACF5\uD1B5\uC815\uBCF4\uBD80 Schema Def" );
					wsh1.addCell( label );
					rowNum++;
					
					// Schema Def \uD544\uB4DC\uBA85 \uCD94\uAC00
					/*
					label = new Label( 0, rowNum, "\uD544\uB4DC\uBA85" );
					wsh1.addCell( label );
					label = new Label( 1, rowNum, "\uD544\uB4DC\uC124\uBA85" );
					wsh1.addCell( label );
					label = new Label( 2, rowNum, "\uD544\uB4DC\uAE38\uC774" );
					wsh1.addCell( label );
					label = new Label( 3, rowNum, "\uD328\uB529\uBB38\uC790" );
					wsh1.addCell( label );
					label = new Label( 4, rowNum, "\uD328\uB529\uD0C0\uC785" );
					wsh1.addCell( label );
					rowNum++;
					*/
					
					// Schema Def \uB370\uC774\uD130 \uCD94\uAC00
					for ( int i = 0; i < resCommonSchemaSize; i++ ) {
						cur = ResCommonSchemaList[ i ].getCursor();
						idataType = IDataUtil.getString( cur, "idataType" );
						listDepth = IDataUtil.getInt( cur, "listDepth", 0 );
						listName = IDataUtil.getString( cur, "listName" );
						schemaList = IDataUtil.getStringArray( cur, "schemaList" );
						
						// Schema Def \uD544\uB4DC\uBA85 \uCD94\uAC00 ==> \uCD5C\uCD08\uC5D0 \uD55C \uBC88\uB9CC \uC2E4\uD589
						if ( i == 0 ) {
							if ( schemaList.length == 5 ) {
								try {
									Integer.parseInt( schemaList[ 2 ] );
									
									// Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0 ==> schemaList[ 2 ]\uC5D0 Field Length(\uC22B\uC790)\uAC00 \uB2F4\uACA8\uC788\uB2E4.
									label = new Label( 0, rowNum, "Field Name" );
									wsh1.addCell( label );
									label = new Label( 1, rowNum, "Field Desc" );
									wsh1.addCell( label );
									label = new Label( 2, rowNum, "Field Length" );
									wsh1.addCell( label );
									label = new Label( 3, rowNum, "Padding Char" );
									wsh1.addCell( label );
									label = new Label( 4, rowNum, "Padding Type" );
									wsh1.addCell( label );
								} catch ( Exception ne ) {
									// \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0 ==> schemaList[ 2 ]\uC5D0 Data Type(\uBB38\uC790)\uAC00 \uB2F4\uACA8\uC788\uB2E4.
									label = new Label( 0, rowNum, "Field Name" );
									wsh1.addCell( label );
									label = new Label( 1, rowNum, "Field Desc" );
									wsh1.addCell( label );
									label = new Label( 2, rowNum, "Data Type" );
									wsh1.addCell( label );
									label = new Label( 3, rowNum, "Field Length" );
									wsh1.addCell( label );
									label = new Label( 4, rowNum, "Array Count" );
									wsh1.addCell( label );
								}
							} else if ( schemaList.length == 8 ) {
								// \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
								label = new Label( 0, rowNum, "Field Name" );
								wsh1.addCell( label );
								label = new Label( 1, rowNum, "Field Desc" );
								wsh1.addCell( label );
								label = new Label( 2, rowNum, "Field Length" );
								wsh1.addCell( label );
								label = new Label( 3, rowNum, "Padding Char" );
								wsh1.addCell( label );
								label = new Label( 4, rowNum, "Padding Type" );
								wsh1.addCell( label );
								label = new Label( 5, rowNum, "Data Type" );
								wsh1.addCell( label );
								label = new Label( 6, rowNum, "Field Length" );
								wsh1.addCell( label );
								label = new Label( 7, rowNum, "Array Count" );
								wsh1.addCell( label );
							}
							
							rowNum++;
						}
						
						if ( idataType.equals( "field" ) ) {
							// \uD544\uB4DC\uC758 Value \uCD94\uAC00
							for ( int j = 0; j < schemaList.length; j ++ ) {
								if ( j == 0 ) {
									// \uD544\uB4DC\uBA85 \uB370\uC774\uD130\uB97C \uCD94\uAC00\uD558\uAE30 \uC804\uC5D0 Indent\uB97C \uC704\uD55C Space \uB9CC\uB4E4\uAE30
									if ( listDepth > 0 ) {
										for ( int k = 0; k < ( listDepth * 2 ); k++ ) {
											spaces += " ";
										}
									} else {
										spaces = "";
									}
								} else {
									spaces = "";
								}
							
								label = new Label( j, rowNum, spaces + schemaList[ j ] );
								wsh1.addCell( label );
							}
						} else {
							// Array Title \uCD94\uAC00
							for ( int k = 0; k < ( listDepth * 2 ); k++ ) {
								spaces += " ";
							}
							
							label = new Label( 0, rowNum, spaces + listName + " Array Schema" );
							wsh1.addCell( label );
						}
						
						// \uBCC0\uC218 \uCD08\uAE30\uD654
						cur.destroy();
						idataType = "";
						listDepth = 0;
						listName = "";
						schemaList = null;
						spaces = "";
						rowNum++;
					}
				}
				
				// \uC751\uB2F5\uC804\uBB38 \uC5C5\uBB34\uC815\uBCF4\uBD80 Schema Def \uB370\uC774\uD130 \uC0DD\uC131
				if ( resBodySchemaSize > 0 ) {
					if ( reqCommonSchemaSize > 0 || reqBodySchemaSize > 0 || resCommonSchemaSize > 0 ) {
						// \uC55E\uC5D0\uC11C Schema Def \uB370\uC774\uD130\uB97C \uC0DD\uC131\uD55C \uACBD\uC6B0 Row Number\uB97C +1 \uD55C\uB2E4.
						rowNum++;
					}
					
					label = new Label( 0, rowNum, "\uC751\uB2F5\uC804\uBB38 \uC5C5\uBB34\uC815\uBCF4\uBD80 Schema Def" );
					wsh1.addCell( label );
					rowNum++;
					
					// Schema Def \uD544\uB4DC\uBA85 \uCD94\uAC00
					/*
					label = new Label( 0, rowNum, "\uD544\uB4DC\uBA85" );
					wsh1.addCell( label );
					label = new Label( 1, rowNum, "\uD544\uB4DC\uC124\uBA85" );
					wsh1.addCell( label );
					label = new Label( 2, rowNum, "\uD544\uB4DC\uAE38\uC774" );
					wsh1.addCell( label );
					label = new Label( 3, rowNum, "\uD328\uB529\uBB38\uC790" );
					wsh1.addCell( label );
					label = new Label( 4, rowNum, "\uD328\uB529\uD0C0\uC785" );
					wsh1.addCell( label );
					rowNum++;
					*/
					
					// Schema Def \uB370\uC774\uD130 \uCD94\uAC00
					for ( int i = 0; i < resBodySchemaSize; i++ ) {
						cur = ResBodySchemaList[ i ].getCursor();
						idataType = IDataUtil.getString( cur, "idataType" );
						listDepth = IDataUtil.getInt( cur, "listDepth", 0 );
						listName = IDataUtil.getString( cur, "listName" );
						schemaList = IDataUtil.getStringArray( cur, "schemaList" );
						
						// Schema Def \uD544\uB4DC\uBA85 \uCD94\uAC00 ==> \uCD5C\uCD08\uC5D0 \uD55C \uBC88\uB9CC \uC2E4\uD589
						if ( i == 0 ) {
							if ( schemaList.length == 5 ) {
								try {
									Integer.parseInt( schemaList[ 2 ] );
									
									// Endian \uBCC0\uD658\uC774 \uD544\uC694 \uC5C6\uB294 \uC77C\uBC18\uC801\uC778 \uACBD\uC6B0 ==> schemaList[ 2 ]\uC5D0 Field Length(\uC22B\uC790)\uAC00 \uB2F4\uACA8\uC788\uB2E4.
									label = new Label( 0, rowNum, "Field Name" );
									wsh1.addCell( label );
									label = new Label( 1, rowNum, "Field Desc" );
									wsh1.addCell( label );
									label = new Label( 2, rowNum, "Field Length" );
									wsh1.addCell( label );
									label = new Label( 3, rowNum, "Padding Char" );
									wsh1.addCell( label );
									label = new Label( 4, rowNum, "Padding Type" );
									wsh1.addCell( label );
								} catch ( Exception ne ) {
									// \uC804\uBB38 \uC218\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0 ==> schemaList[ 2 ]\uC5D0 Data Type(\uBB38\uC790)\uAC00 \uB2F4\uACA8\uC788\uB2E4.
									label = new Label( 0, rowNum, "Field Name" );
									wsh1.addCell( label );
									label = new Label( 1, rowNum, "Field Desc" );
									wsh1.addCell( label );
									label = new Label( 2, rowNum, "Data Type" );
									wsh1.addCell( label );
									label = new Label( 3, rowNum, "Field Length" );
									wsh1.addCell( label );
									label = new Label( 4, rowNum, "Array Count" );
									wsh1.addCell( label );
								}
							} else if ( schemaList.length == 8 ) {
								// \uC804\uBB38 \uC1A1\uC2E0 \uC2DC Endian \uBCC0\uD658\uC774 \uD544\uC694\uD55C \uACBD\uC6B0
								label = new Label( 0, rowNum, "Field Name" );
								wsh1.addCell( label );
								label = new Label( 1, rowNum, "Field Desc" );
								wsh1.addCell( label );
								label = new Label( 2, rowNum, "Field Length" );
								wsh1.addCell( label );
								label = new Label( 3, rowNum, "Padding Char" );
								wsh1.addCell( label );
								label = new Label( 4, rowNum, "Padding Type" );
								wsh1.addCell( label );
								label = new Label( 5, rowNum, "Data Type" );
								wsh1.addCell( label );
								label = new Label( 6, rowNum, "Field Length" );
								wsh1.addCell( label );
								label = new Label( 7, rowNum, "Array Count" );
								wsh1.addCell( label );
							}
							
							rowNum++;
						}
						
						if ( idataType.equals( "field" ) ) {
							for ( int j = 0; j < schemaList.length; j ++ ) {
								if ( j == 0 ) {
									// \uD544\uB4DC\uBA85 \uB370\uC774\uD130\uB97C \uCD94\uAC00\uD558\uAE30 \uC804\uC5D0 Indent\uB97C \uC704\uD55C Space \uB9CC\uB4E4\uAE30
									if ( listDepth > 0 ) {
										for ( int k = 0; k < ( listDepth * 2 ); k++ ) {
											spaces += " ";
										}
									} else {
										spaces = "";
									}
								} else {
									spaces = "";
								}
							
								label = new Label( j, rowNum, spaces + schemaList[ j ] );
								wsh1.addCell( label );
							}
						} else {
							// Array Title \uCD94\uAC00
							for ( int k = 0; k < ( listDepth * 2 ); k++ ) {
								spaces += " ";
							}
							
							label = new Label( 0, rowNum, spaces + listName + " Array Schema" );
							wsh1.addCell( label );
						}
						
						// \uBCC0\uC218 \uCD08\uAE30\uD654
						cur.destroy();
						idataType = "";
						listDepth = 0;
						listName = "";
						schemaList = null;
						spaces = "";
						rowNum++;
					}
				}
			} // Schema Def Sheet \uC0DD\uC131 End.
			
			// Audit Data Sheet \uC0DD\uC131
			if ( reqCommonDataSize > 0 || reqBodyDataSize > 0 || resCommonDataSize > 0 || resBodyDataSize > 0 ) {
				rowNum = 0;
				
				// Sheet \uC0DD\uC131
				if ( wsh1 == null ) {
					wsh2 = wb.createSheet( "Audit Data", 0 );
				} else {
					wsh2 = wb.createSheet( "Audit Data", 1 );
				}
				
				create = "true";
				
				// Request Socket String \uC6D0\uBCF8 \uB370\uC774\uD130 \uC0DD\uC131
				if ( !reqSocketString.equals( "" ) ) {
					label = new Label( 0, rowNum, "Original \uC694\uCCAD\uC804\uBB38 \uB370\uC774\uD130" );
					wsh2.addCell( label );
					rowNum++;
				
					label = new Label( 0, rowNum, reqSocketString );
					wsh2.addCell( label );
					rowNum += 2;
				}
				
				// \uC694\uCCAD\uC804\uBB38 \uACF5\uD1B5\uC815\uBCF4\uBD80 \uB370\uC774\uD130 \uC0DD\uC131
				if ( reqCommonDataSize > 0 ) {
					label = new Label( 0, rowNum, "\uC694\uCCAD\uC804\uBB38 \uACF5\uD1B5\uC815\uBCF4\uBD80 \uB370\uC774\uD130" );
					wsh2.addCell( label );
					rowNum++;
					
					// Audit \uB370\uC774\uD130 \uCD94\uAC00
					for ( int i = 0; i < reqCommonDataSize; i++ ) {
						cur = ReqCommonDataList[ i ].getCursor();
						idataType = IDataUtil.getString( cur, "idataType" );
						listDepth = IDataUtil.getInt( cur, "listDepth", 0 );
						fieldName = IDataUtil.getString( cur, "fieldName" );
						fieldValue = IDataUtil.getString( cur, "fieldValue" );
						titleValue = IDataUtil.getString( cur, "titleValue" );
						valueList = IDataUtil.getStringArray( cur, "valueList" );
						
						if ( idataType.equals( "field" ) ) {
							// Single Record\uC778 \uACBD\uC6B0
							// \uD544\uB4DC\uC758 Name/Value \uCD94\uAC00														
							label = new Label( 0, rowNum, fieldName );
							wsh2.addCell( label );
							label = new Label( 1, rowNum, fieldValue );
							wsh2.addCell( label );
							rowNum++;
						} else {
							// Multi Record\uC778 \uACBD\uC6B0
							if ( titleValue.equals( "listEnd" ) ) {
								// List \uB05D\uB098\uB294 \uBD80\uBD84\uC744 \uD45C\uC2DC\uD55C \uB370\uC774\uD130\uC778 \uACBD\uC6B0 ==> Skip								
							} else {
								for ( int j = 0; j < valueList.length; j ++ ) {
									if ( j == 0 ) {
										// \uB370\uC774\uD130\uB97C \uCD94\uAC00\uD558\uAE30 \uC804\uC5D0 Indent\uB97C \uC704\uD55C Space \uB9CC\uB4E4\uAE30
										if ( listDepth > 1 ) {
											for ( int k = 0; k < ((listDepth - 1) * 2); k++ ) {
												spaces += " ";
											}
										} else {
											spaces = "";
										}
									} else {
										spaces = "";
									}
								
									label = new Label( j, rowNum, spaces + valueList[ j ] );
									wsh2.addCell( label );
								}
								
								rowNum++;
							}
						}
						
						// \uBCC0\uC218 \uCD08\uAE30\uD654
						cur.destroy();
						idataType = "";
						listDepth = 0;
						fieldName = "";
						fieldValue = "";
						titleValue = "";
						valueList = null;
						spaces = "";
					}
				}
				
				// \uC694\uCCAD\uC804\uBB38 \uC5C5\uBB34\uC815\uBCF4\uBD80 \uB370\uC774\uD130 \uC0DD\uC131
				if ( reqBodyDataSize > 0 ) {
					if ( reqCommonDataSize > 0 ) {
						// \uC55E\uC5D0\uC11C \uACF5\uD1B5\uC815\uBCF4\uBD80 \uB370\uC774\uD130\uB97C \uC0DD\uC131\uD55C \uACBD\uC6B0 Row Number\uB97C +1 \uD55C\uB2E4.
						rowNum++;
					}
					
					label = new Label( 0, rowNum, "\uC694\uCCAD\uC804\uBB38 \uC5C5\uBB34\uC815\uBCF4\uBD80 \uB370\uC774\uD130" );
					wsh2.addCell( label );
					rowNum++;
					
					// Audit \uB370\uC774\uD130 \uCD94\uAC00
					for ( int i = 0; i < reqBodyDataSize; i++ ) {
						cur = ReqBodyDataList[ i ].getCursor();
						idataType = IDataUtil.getString( cur, "idataType" );
						listDepth = IDataUtil.getInt( cur, "listDepth", 0 );
						fieldName = IDataUtil.getString( cur, "fieldName" );
						fieldValue = IDataUtil.getString( cur, "fieldValue" );
						titleValue = IDataUtil.getString( cur, "titleValue" );
						valueList = IDataUtil.getStringArray( cur, "valueList" );
						
						if ( idataType.equals( "field" ) ) {
							// Single Record\uC778 \uACBD\uC6B0
							// \uD544\uB4DC\uC758 Name/Value \uCD94\uAC00														
							label = new Label( 0, rowNum, fieldName );
							wsh2.addCell( label );
							label = new Label( 1, rowNum, fieldValue );
							wsh2.addCell( label );
							rowNum++;
						} else {
							// Multi Record\uC778 \uACBD\uC6B0
							if ( titleValue.equals( "listEnd" ) ) {
								// List \uB05D\uB098\uB294 \uBD80\uBD84\uC744 \uD45C\uC2DC\uD55C \uB370\uC774\uD130\uC778 \uACBD\uC6B0 ==> Skip								
							} else {
								for ( int j = 0; j < valueList.length; j ++ ) {
									if ( j == 0 ) {
										// \uB370\uC774\uD130\uB97C \uCD94\uAC00\uD558\uAE30 \uC804\uC5D0 Indent\uB97C \uC704\uD55C Space \uB9CC\uB4E4\uAE30
										if ( listDepth > 1 ) {
											for ( int k = 0; k < ((listDepth - 1) * 2); k++ ) {
												spaces += " ";
											}
										} else {
											spaces = "";
										}
									} else {
										spaces = "";
									}
								
									label = new Label( j, rowNum, spaces + valueList[ j ] );
									wsh2.addCell( label );
								}
								
								rowNum++;
							}
						}
						
						// \uBCC0\uC218 \uCD08\uAE30\uD654
						cur.destroy();
						idataType = "";
						listDepth = 0;
						fieldName = "";
						fieldValue = "";
						titleValue = "";
						valueList = null;
						spaces = "";
					}
				}
				
				// Response Socket String \uC6D0\uBCF8 \uB370\uC774\uD130 \uC0DD\uC131
				if ( !resSocketString.equals( "" ) ) {
					if ( reqCommonDataSize > 0 || reqBodyDataSize > 0 ) {
						// \uC55E\uC5D0\uC11C \uACF5\uD1B5\uC815\uBCF4\uBD80 \uB610\uB294 \uC5C5\uBB34\uC815\uBCF4\uBD80 \uB370\uC774\uD130\uB97C \uC0DD\uC131\uD55C \uACBD\uC6B0 Row Number\uB97C +1 \uD55C\uB2E4.
						rowNum++;
					}
					
					label = new Label( 0, rowNum, "Original \uC751\uB2F5\uC804\uBB38 \uB370\uC774\uD130" );
					wsh2.addCell( label );
					rowNum++;
				
					label = new Label( 0, rowNum, resSocketString );
					wsh2.addCell( label );
					rowNum += 2;
				}
				
				// \uC751\uB2F5\uC804\uBB38 \uACF5\uD1B5\uC815\uBCF4\uBD80 \uB370\uC774\uD130 \uC0DD\uC131
				if ( resCommonDataSize > 0 ) {
					label = new Label( 0, rowNum, "\uC751\uB2F5\uC804\uBB38 \uACF5\uD1B5\uC815\uBCF4\uBD80 \uB370\uC774\uD130" );
					wsh2.addCell( label );
					rowNum++;
					
					// Audit \uB370\uC774\uD130 \uCD94\uAC00
					for ( int i = 0; i < resCommonDataSize; i++ ) {
						cur = ResCommonDataList[ i ].getCursor();
						idataType = IDataUtil.getString( cur, "idataType" );
						listDepth = IDataUtil.getInt( cur, "listDepth", 0 );
						fieldName = IDataUtil.getString( cur, "fieldName" );
						fieldValue = IDataUtil.getString( cur, "fieldValue" );
						titleValue = IDataUtil.getString( cur, "titleValue" );
						valueList = IDataUtil.getStringArray( cur, "valueList" );
						
						if ( idataType.equals( "field" ) ) {
							// Single Record\uC778 \uACBD\uC6B0
							// \uD544\uB4DC\uC758 Name/Value \uCD94\uAC00														
							label = new Label( 0, rowNum, fieldName );
							wsh2.addCell( label );
							label = new Label( 1, rowNum, fieldValue );
							wsh2.addCell( label );
							rowNum++;
						} else {
							// Multi Record\uC778 \uACBD\uC6B0
							if ( titleValue.equals( "listEnd" ) ) {
								// List \uB05D\uB098\uB294 \uBD80\uBD84\uC744 \uD45C\uC2DC\uD55C \uB370\uC774\uD130\uC778 \uACBD\uC6B0 ==> Skip								
							} else {
								for ( int j = 0; j < valueList.length; j ++ ) {
									if ( j == 0 ) {
										// \uB370\uC774\uD130\uB97C \uCD94\uAC00\uD558\uAE30 \uC804\uC5D0 Indent\uB97C \uC704\uD55C Space \uB9CC\uB4E4\uAE30
										if ( listDepth > 1 ) {
											for ( int k = 0; k < ((listDepth - 1) * 2); k++ ) {
												spaces += " ";
											}
										} else {
											spaces = "";
										}
									} else {
										spaces = "";
									}
								
									label = new Label( j, rowNum, spaces + valueList[ j ] );
									wsh2.addCell( label );
								}
								
								rowNum++;
							}
						}
						
						// \uBCC0\uC218 \uCD08\uAE30\uD654
						cur.destroy();
						idataType = "";
						listDepth = 0;
						fieldName = "";
						fieldValue = "";
						titleValue = "";
						valueList = null;
						spaces = "";
					}
				}
				
				// \uC751\uB2F5\uC804\uBB38 \uC5C5\uBB34\uC815\uBCF4\uBD80 \uB370\uC774\uD130 \uC0DD\uC131
				if ( resBodyDataSize > 0 ) {
					if ( resCommonDataSize > 0 ) {
						// \uC55E\uC5D0\uC11C \uACF5\uD1B5\uC815\uBCF4\uBD80 \uB370\uC774\uD130\uB97C \uC0DD\uC131\uD55C \uACBD\uC6B0 Row Number\uB97C +1 \uD55C\uB2E4.
						rowNum++;
					}
					
					label = new Label( 0, rowNum, "\uC751\uB2F5\uC804\uBB38 \uC5C5\uBB34\uC815\uBCF4\uBD80 \uB370\uC774\uD130" );
					wsh2.addCell( label );
					rowNum++;
					
					// Audit \uB370\uC774\uD130 \uCD94\uAC00
					for ( int i = 0; i < resBodyDataSize; i++ ) {
						cur = ResBodyDataList[ i ].getCursor();
						idataType = IDataUtil.getString( cur, "idataType" );
						listDepth = IDataUtil.getInt( cur, "listDepth", 0 );
						fieldName = IDataUtil.getString( cur, "fieldName" );
						fieldValue = IDataUtil.getString( cur, "fieldValue" );
						titleValue = IDataUtil.getString( cur, "titleValue" );
						valueList = IDataUtil.getStringArray( cur, "valueList" );
						
						if ( idataType.equals( "field" ) ) {
							// Single Record\uC778 \uACBD\uC6B0
							// \uD544\uB4DC\uC758 Name/Value \uCD94\uAC00														
							label = new Label( 0, rowNum, fieldName );
							wsh2.addCell( label );
							label = new Label( 1, rowNum, fieldValue );
							wsh2.addCell( label );
							rowNum++;
						} else {
							// Multi Record\uC778 \uACBD\uC6B0
							if ( titleValue.equals( "listEnd" ) ) {
								// List \uB05D\uB098\uB294 \uBD80\uBD84\uC744 \uD45C\uC2DC\uD55C \uB370\uC774\uD130\uC778 \uACBD\uC6B0 ==> Skip								
							} else {
								for ( int j = 0; j < valueList.length; j ++ ) {
									if ( j == 0 ) {
										// \uB370\uC774\uD130\uB97C \uCD94\uAC00\uD558\uAE30 \uC804\uC5D0 Indent\uB97C \uC704\uD55C Space \uB9CC\uB4E4\uAE30
										if ( listDepth > 1 ) {
											for ( int k = 0; k < ((listDepth - 1) * 2); k++ ) {
												spaces += " ";
											}
										} else {
											spaces = "";
										}
									} else {
										spaces = "";
									}
								
									label = new Label( j, rowNum, spaces + valueList[ j ] );
									wsh2.addCell( label );
								}
								
								rowNum++;
							}
						}
						
						// \uBCC0\uC218 \uCD08\uAE30\uD654
						cur.destroy();
						idataType = "";
						listDepth = 0;
						fieldName = "";
						fieldValue = "";
						titleValue = "";
						valueList = null;
						spaces = "";
					}
				}				
			} // Audit Data Sheet \uC0DD\uC131 End.
			
			// Excel File Write
			if ( create.equals( "true" ) ) {
				// \uC2E4\uC81C\uB85C \uC5D1\uC140 \uB370\uC774\uD130\uAC00 \uC0DD\uC131\uB41C \uACBD\uC6B0
				wb.write();
			} else {
				errorMsg = "\uC5D1\uC140 \uB370\uC774\uD130\uAC00 \uC0DD\uC131\uB418\uC9C0 \uC54A\uC558\uC2B5\uB2C8\uB2E4.";
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		} finally {
			try {
				wb.close();
				
				if ( create.equals( "false" ) ) {
					// \uC2E4\uC81C\uB85C \uC5D1\uC140 \uB370\uC774\uD130\uAC00 \uC0DD\uC131\uB418\uC9C0 \uC54A\uC740 \uACBD\uC6B0
					file.delete();
				}
			} catch ( Exception ce ) {
				errorMsg = ce.toString();
			}
		}
		
		dir = null;
		file = null;
		ReqCommonSchemaList = null;
		ReqBodySchemaList = null;
		ResCommonSchemaList = null;
		ResBodySchemaList = null;
		ReqCommonDataList = null;
		ReqBodyDataList = null;
		ResCommonDataList = null;
		ResBodyDataList = null;
		wb = null;
		wsh1 = null;
		wsh2 = null;
		label = null;
		cur = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static DebugLogger debugLogger = new DebugLogger();
	// --- <<IS-END-SHARED>> ---
}

