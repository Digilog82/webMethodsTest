package JSocketAdapter.COMMON.UTIL;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.lang.StringEscapeUtils;
import java.util.Random;
// --- <<IS-END-IMPORTS>> ---

public final class STRING

{
	// ---( internal utility methods )---

	final static STRING _instance = new STRING();

	static STRING _newInstance() { return new STRING(); }

	static STRING _cast(Object o) { return (STRING)o; }

	// ---( server methods )---




	public static final void convertBytesToHexString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertBytesToHexString)>> ---
		// @sigtype java 3.5
		// [i] object:0:required inputBytes
		// [o] field:0:required outputString
		IDataCursor pipelineCursor = pipeline.getCursor();
		byte[] inputBytes = ( byte[] )IDataUtil.get( pipelineCursor, "inputBytes" );
		pipelineCursor.destroy();
		
		String outputString = byteArrayToHex( inputBytes );
		
		inputBytes = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outputString", outputString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertFileName (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertFileName)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inFileName
		// [o] field:0:required errorMsg
		// [o] field:0:required outFileName
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String inFileName = IDataUtil.getString( pipelineCursor, "inFileName" );
		pipelineCursor.destroy();
		
		String outFileName = "";
		String errorMsg = "";
		
		try {
			outFileName = new String( inFileName.getBytes( "8859_1" ), "UTF-8" );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "outFileName", outFileName );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertHexBytesToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertHexBytesToString)>> ---
		// @sigtype java 3.5
		// [i] object:0:required inputBytes
		// [i] field:0:required encoding
		// [o] field:0:required outputString
		IDataCursor pipelineCursor = pipeline.getCursor();
		byte[] inputBytes = ( byte[] )IDataUtil.get( pipelineCursor, "inputBytes" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();
		
		if ( encoding == null || encoding.equals( "" ) ) {
			encoding = "UTF-8";
		}
		
		byte[] outputBytes = null;
		String hexString = "";
		String outputString = "";
		
		try {
			hexString = new String( inputBytes, encoding );
			outputBytes = Hex.decodeHex( hexString.toCharArray() );
			outputString = new String( outputBytes, encoding );
		} catch ( Exception e ) {
			
		}
		
		outputBytes = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outputString", outputString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertHexStringToBytes (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertHexStringToBytes)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inputString
		// [o] object:0:required outputBytes
		IDataCursor pipelineCursor = pipeline.getCursor();
		String inputString = IDataUtil.getString( pipelineCursor, "inputString" );
		pipelineCursor.destroy();
		
		byte[] outputBytes = hexToByteArray( inputString );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outputBytes", outputBytes );
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
		
		byte[] outputBytes = null;
		String outputString = "";
		
		try {
			hexString = hexString.replace( "0x", "" );
			outputBytes = Hex.decodeHex( hexString.toCharArray() );
			outputString = new String( outputBytes, encoding );
		} catch ( Exception e ) {
			
		}
		
		outputBytes = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outputString", outputString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertNullToSpace (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertNullToSpace)>> ---
		// @sigtype java 3.5
		// [i] field:0:required content
		// [i] field:0:required charset
		// [o] field:0:required newContent
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String content = IDataUtil.getString( pipelineCursor, "content" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		pipelineCursor.destroy();
		
		byte[] inBytes = null;
		byte[] outBytes = null;
		String hexString = "";
		String newContent = "";
		StringBuffer sb = new StringBuffer();
		int startIdx = 0;
		int endIdx = 2;
		String subHexString = "";
		int hexLength = 0;
		
		try {
			if ( charset == null || charset.equals( "" ) ) {
				charset = "UTF-8";
			}
			
			if ( content == null || content.equals( "" ) ) {
				
			} else {			
				inBytes = content.getBytes( charset );
				hexString = byteArrayToHex( inBytes );
				hexLength = hexString.length();
			
				// null Hex Code --> space Hex Code
				while( true ) {
					subHexString = hexString.substring( startIdx, endIdx );
					
					if ( subHexString.equals( "00" ) ) {
						subHexString = "20";
					}
					
					sb.append( subHexString );
					
					if ( endIdx == hexLength ) {
						break;
					}
					
					startIdx = endIdx;
					endIdx = endIdx + 2;
				}
				
				hexString = sb.toString();			
				outBytes = hexToByteArray( hexString );
				newContent = new String( outBytes, charset );
			}
		} catch ( Exception e ) {
			throw new ServiceException( e );
		}
		
		inBytes = null;
		outBytes = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "newContent", newContent );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertNumberToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertNumberToString)>> ---
		// @sigtype java 3.5
		// [i] object:0:required inNumber
		// [o] field:0:required outString
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		Object inNumber = IDataUtil.get( pipelineCursor, "inNumber" );
		pipelineCursor.destroy();
		
		String outString = "";
		
		if ( inNumber == null ) {
			// \uACF5\uBC31\uC73C\uB85C \uB9AC\uD134
		} else {			
			if ( inNumber instanceof Integer ) {
				outString = ( int )inNumber + "";
			} else if ( inNumber instanceof Long ) {
				outString = ( long )inNumber + "";
			} else if ( inNumber instanceof Float ) {
				outString = ( float )inNumber + "";
			} else if ( inNumber instanceof Double ) {
				outString = ( double )inNumber + "";
			} else if ( inNumber instanceof String ) {
				outString = ( String )inNumber;
			}
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outString", outString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertStringToHexBytes (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertStringToHexBytes)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inputString
		// [i] field:0:required encoding
		// [o] object:0:required outputBytes
		// [o] field:0:required outputBytesLen
		IDataCursor pipelineCursor = pipeline.getCursor();
		String inputString = IDataUtil.getString( pipelineCursor, "inputString" );
		String encoding = IDataUtil.getString( pipelineCursor, "encoding" );
		pipelineCursor.destroy();
		
		if ( encoding == null || encoding.equals( "" ) ) {
			encoding = "UTF-8";
		}
		
		byte[] inputBytes = null;
		String hexString = "";
		byte[] outputBytes = null;
		
		try {			
			inputBytes = inputString.getBytes( encoding );
			hexString = Hex.encodeHexString( inputBytes );
			
			// \uC544\uB798\uC640 \uAC19\uC774 \uD558\uBA74 Hex String \uC790\uCCB4\uAC00 Byte\uB85C \uBCC0\uD658\uB41C \uAC83\uC774 \uC544\uB2C8\uB77C Hex String\uC73C\uB85C \uBCC0\uD658\uD558\uAE30 \uC774\uC804\uC758 \uC6D0\uB798 \uB370\uC774\uD130\uAC00 Byte\uB85C \uBCC0\uD658\uB41C\uB2E4.
			//outputBytes = Hex.decodeHex( hexString.toCharArray() );
			
			outputBytes = hexString.getBytes( encoding );
		} catch ( Exception e ) {
			
		}
		
		inputBytes = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outputBytes", outputBytes );
		IDataUtil.put( pipelineCursor_1, "outputBytesLen", outputBytes.length + "" );
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
		String hexString = "";
		
		try {
			inputBytes = inputString.getBytes( encoding );
			hexString = Hex.encodeHexString( inputBytes );
		} catch ( Exception e ) {
			
		}
		
		inputBytes = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "hexString", hexString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertStringToNumber (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertStringToNumber)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inNumber
		// [o] object:0:required outNumber
		IDataCursor pipelineCursor = pipeline.getCursor();
		String inNumber = IDataUtil.getString( pipelineCursor, "inNumber" );
		pipelineCursor.destroy();
		
		if ( inNumber == null || inNumber.equals( "" ) ) {
			// JSON Field\uC758 Data Type\uC774 \uC22B\uC790\uD615\uC77C \uACBD\uC6B0\uC5D0 null\uC744 \uB9E4\uD551\uD558\uBA74 "field" : null \uD615\uD0DC\uB85C JSON\uC774 \uC0DD\uC131\uB41C\uB2E4.
			// "field" : \uB4A4\uC5D0 \uAC12\uC774 \uC0DD\uB7B5\uB41C \uACBD\uC6B0\uC5D0\uB294 \uD30C\uC2F1\uD560 \uB54C \uC5D0\uB7EC\uAC00 \uBC1C\uC0DD\uD558\uBBC0\uB85C \uC22B\uC790\uD615 \uD544\uB4DC\uC778\uB370 \uAC12\uC774 \uC5C6\uB294 \uACBD\uC6B0\uC5D0\uB294 \uD544\uB4DC \uC790\uCCB4\uB97C \uC0DD\uB7B5\uD558\uB294 \uD615\uD0DC\uAC00 \uB420 \uC218 \uC788\uB3C4\uB85D \uD55C\uB2E4.
			return;
		} else {
			inNumber = inNumber.trim();
		}
		
		Object outNumber;
		
		if ( inNumber.contains( "." ) ) {
			outNumber = Double.parseDouble( inNumber );
		} else {
			outNumber = Long.parseLong( inNumber );
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outNumber", outNumber );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void decodeUnicode (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(decodeUnicode)>> ---
		// @sigtype java 3.5
		// [i] field:0:required unicodeString
		// [o] field:0:required decodeString
		IDataCursor pipelineCursor = pipeline.getCursor();
		String unicodeString = IDataUtil.getString( pipelineCursor, "unicodeString" );
		pipelineCursor.destroy();
		
		String decodeString = StringEscapeUtils.unescapeJava( unicodeString );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "decodeString", decodeString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void encodeUnicode (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(encodeUnicode)>> ---
		// @sigtype java 3.5
		// [i] field:0:required decodeString
		// [o] field:0:required unicodeString
		IDataCursor pipelineCursor = pipeline.getCursor();
		String decodeString = IDataUtil.getString( pipelineCursor, "decodeString" );
		pipelineCursor.destroy();
		
		String unicodeString = StringEscapeUtils.escapeJava( decodeString );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "unicodeString", unicodeString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getAsciiCode (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getAsciiCode)>> ---
		// @sigtype java 3.5
		// [i] field:0:required str
		// [o] field:0:required asciiCode
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String str = IDataUtil.getString( pipelineCursor, "str" );
		pipelineCursor.destroy();
		
		char chr = str.charAt( 0 );
		int asciiCode = ( int )chr;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "asciiCode", asciiCode );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getByteLength (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getByteLength)>> ---
		// @sigtype java 3.5
		// [i] field:0:required content
		// [i] field:0:required charset
		// [o] field:0:required byteLength
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String content = IDataUtil.getString( pipelineCursor, "content" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		pipelineCursor.destroy();
		
		if ( charset == null ) {
			charset = "";
		}
		
		String byteLength = "0";
		
		try {
			if ( charset.equals( "" ) ) {
				byteLength = ( content.getBytes() ).length + "";
			} else {
				byteLength = ( content.getBytes( charset ) ).length + "";
			}
		} catch ( Exception e ) {
			
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "byteLength", byteLength );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getRandomNumber (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getRandomNumber)>> ---
		// @sigtype java 3.5
		// [i] field:0:required bound
		// [o] field:0:required randomNum
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		int bound = IDataUtil.getInt( pipelineCursor, "bound", 0 );
		pipelineCursor.destroy();
		
		Random random = new Random();
		int randomNum = random.nextInt( bound );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "randomNum", randomNum + "" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void multiConcat (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(multiConcat)>> ---
		// @sigtype java 3.5
		// [i] field:1:required concatList
		// [o] field:0:required concatString
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String[] concatList = IDataUtil.getStringArray( pipelineCursor, "concatList" );
		pipelineCursor.destroy();
		
		String concatString = "";
		StringBuffer strBuffer = new StringBuffer();
		
		for ( int i = 0; i < concatList.length; i++ ) {
			strBuffer.append( concatList[ i ] );
		}
		
		concatString = strBuffer.toString();
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "concatString", concatString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void split (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(split)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [i] field:0:required separator
		// [i] field:0:required fieldCount
		// [o] field:1:required fieldList
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String inString = IDataUtil.getString( pipelineCursor, "inString" );
		String separator = IDataUtil.getString( pipelineCursor, "separator" );
		int fieldCount = IDataUtil.getInt( pipelineCursor, "fieldCount", 0 );
		pipelineCursor.destroy();
		
		String[] fieldList = null;
		String[] splitList = null;
		int splitLength = 0;
		
		if ( inString != null && !inString.equals( "" ) ) {
			splitList = inString.split( separator );
			splitLength = splitList.length;
			
			// fieldCount\uAC00 0 \uC778 \uACBD\uC6B0 \uC989, \uD544\uB4DC \uAC2F\uC218\uB97C \uC54C \uC218 \uC5C6\uB294 \uACBD\uC6B0
			if ( fieldCount == 0 ) {
				fieldCount = splitLength;
			}
		
			if ( fieldCount == splitLength ) {
				fieldList = splitList;
			} else {
				// separator \uB4A4\uB85C \uAC12\uC774 \uC5C6\uB294 \uACBD\uC6B0. \uC608\uB97C \uB4E4\uC5B4\uC11C aaa|bbb|ccc|, aaa|bbb|ccc|| ...
				// \uC911\uAC04 \uBD80\uBD84\uC5D0 separator \uB4A4\uB85C \uAC12\uC774 \uC5C6\uB294 \uACBD\uC6B0\uC5D0\uB294 separator\uC640 separator \uC0AC\uC774\uB97C \uBE48 \uAC12\uC73C\uB85C \uC778\uC2DD\uD568.
				fieldList = new String[ fieldCount ];
			
				for ( int i = 0; i < fieldCount; i++ ) {
					if ( i < splitLength ) {
						fieldList[ i ] = splitList[ i ];
					} else {
						fieldList[ i ] = "";
					}
				}
			}
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "fieldList", fieldList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void stringListToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(stringListToString)>> ---
		// @sigtype java 3.5
		// [i] field:1:required inStringList
		// [i] field:0:required separatorEnter {"true","false"}
		// [i] field:0:optional separator
		// [o] field:0:required outString
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String[] inStringList = IDataUtil.getStringArray( pipelineCursor, "inStringList" );
		String separatorEnter = IDataUtil.getString( pipelineCursor, "separatorEnter" );
		String separator = IDataUtil.getString( pipelineCursor, "separator" );		
		pipelineCursor.destroy();
		
		StringBuffer strBuffer = new StringBuffer();
		String outString = "";
		
		if ( separatorEnter.equals( "true" ) ) {
			separator = "\n";
		}
		
		for ( int i = 0; i < inStringList.length; i++ ) {
			if ( i == 0 ) {
				strBuffer.append( inStringList[ i ] );
			} else {
				strBuffer.append( separator );
				strBuffer.append( inStringList[ i ] );
			}
		}
		
		outString = strBuffer.toString();
		
		strBuffer = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outString", outString );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void stringToStringList (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(stringToStringList)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [i] field:0:required separator
		// [o] field:1:required outStringList
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String inString = IDataUtil.getString( pipelineCursor, "inString" );
		String separator = IDataUtil.getString( pipelineCursor, "separator" );
		pipelineCursor.destroy();
		
		String[] outStringList = inString.split( separator );
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outStringList", outStringList );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void substringByBytes (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(substringByBytes)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [i] field:0:required startOffset
		// [i] field:0:required length
		// [i] field:0:required charset
		// [o] field:0:required outString
		// [o] field:0:required exceed
		// [o] field:0:required exceedCount
		IDataCursor	pipelineCursor	= pipeline.getCursor();
		String inString = IDataUtil.getString( pipelineCursor, "inString" );
		String startOffset = IDataUtil.getString( pipelineCursor, "startOffset" );
		String length = IDataUtil.getString( pipelineCursor, "length" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		pipelineCursor.destroy();
		
		int off = 0;
		int len = 0;
		byte[] inBytes = null;
		byte[] subBytes = null;
		String outString = "";
		String exceed = "false";
		String exceedCount = "0";
		
		try {
			if ( charset == null || charset.equals( "" ) ) {
				charset = "UTF-8";
			}
			
			if ( startOffset == null || startOffset.equals( "" ) ) {
				startOffset = "0";
			}
			
			off = Integer.parseInt( startOffset );
			inBytes = inString.getBytes( charset );
			
			if ( off > inBytes.length ) {
				off = inBytes.length;
			}
		
			if ( length == null || length.equals( "" ) ) {
				length = ( inBytes.length - off ) + "";
			} else {
				if ( Integer.parseInt( length ) > ( inBytes.length - off ) ) {
					exceed = "true";
					exceedCount = ( Integer.parseInt( length ) ) - ( inBytes.length - off ) + "";
					length = ( inBytes.length - off ) + "";
				}
			}
			
			len = Integer.parseInt( length );
			
			subBytes = new byte[ len ];
			System.arraycopy( inBytes, off, subBytes, 0, len );
			outString = new String( subBytes, charset );
		} catch ( Exception e ) {
			throw new ServiceException( e );
		}
		
		inBytes = null;
		subBytes = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outString", outString );
		IDataUtil.put( pipelineCursor_1, "exceed", exceed );
		IDataUtil.put( pipelineCursor_1, "exceedCount", exceedCount );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void substringRT (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(substringRT)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [i] field:0:required size
		// [o] field:0:required value
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	strString = IDataUtil.getString( pipelineCursor, "inString" );
		int	iSize = Integer.parseInt(IDataUtil.getString( pipelineCursor, "size" ));
		pipelineCursor.destroy();
		 
		String result;
		int strLen = strString.length();
		
		if (strLen > iSize) {
			result = strString.substring(strLen-iSize,strLen);
		} else {	
			result = strString.trim();
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "value", result );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	public static String byteArrayToHex( byte[] byteArray ) {
		if ( byteArray == null || byteArray.length == 0 ) {
			return null;
		}
		
		StringBuffer sb = new StringBuffer( byteArray.length * 2 );
		String hexNumber;
		
		for ( int x = 0; x < byteArray.length; x++ ) {
			hexNumber = "0" + Integer.toHexString( 0xff & byteArray[ x ] );
			sb.append( hexNumber.substring( hexNumber.length() - 2 ) );
		}
		
		return sb.toString();
	}
	
	public static byte[] hexToByteArray( String hex ) {
		if ( hex == null || hex.length() == 0 ) {
			return null;
		}
		
		byte[] byteArray = new byte[ hex.length() / 2 ];
		
		for ( int i = 0; i < byteArray.length; i++ ) {
			byteArray[ i ] = ( byte )Integer.parseInt( hex.substring( 2 * i, 2 * i + 2 ), 16 );
		}
		
		return byteArray;
	}
	// --- <<IS-END-SHARED>> ---
}

