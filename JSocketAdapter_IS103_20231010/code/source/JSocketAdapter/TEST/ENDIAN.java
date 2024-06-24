package JSocketAdapter.TEST;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
// --- <<IS-END-IMPORTS>> ---

public final class ENDIAN

{
	// ---( internal utility methods )---

	final static ENDIAN _instance = new ENDIAN();

	static ENDIAN _newInstance() { return new ENDIAN(); }

	static ENDIAN _cast(Object o) { return (ENDIAN)o; }

	// ---( server methods )---




	public static final void convertBytesToNumber (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertBytesToNumber)>> ---
		// @sigtype java 3.5
		// [i] object:0:required inputBytes
		// [i] field:0:required endianType {"little","big"}
		// [i] field:0:required numberType {"byte","short","int","long","float","double"}
		// [o] field:0:required outputNumber
		IDataCursor pipelineCursor = pipeline.getCursor();
		byte[] inputBytes = ( byte[] )IDataUtil.get( pipelineCursor, "inputBytes" );
		String endianType = IDataUtil.getString( pipelineCursor, "endianType" );
		String numberType = IDataUtil.getString( pipelineCursor, "numberType" );
		pipelineCursor.destroy();
		
		if ( endianType == null || endianType.equals( "" ) ) {
			endianType = "little";
		}
		
		ByteBuffer byteBuffer = null;
		byte bNumber = 0;
		short sNumber = 0;
		int iNumber = 0;
		long lNumber = 0;
		float fNumber = 0;
		double dNumber = 0;
		String outputNumber = "";
		
		try {
			byteBuffer = ByteBuffer.wrap( inputBytes );
			
			if ( endianType.equals( "little" ) ) {
				byteBuffer.order( ByteOrder.LITTLE_ENDIAN );
			} else {
				byteBuffer.order( ByteOrder.BIG_ENDIAN );
			}
			
			while( byteBuffer.hasRemaining() ) {
				if ( numberType.equals( "byte" ) ) {
					bNumber = byteBuffer.get();
				} else if ( numberType.equals( "short" ) ) {
					sNumber = byteBuffer.getShort();
				} else if ( numberType.equals( "int" ) ) {
					iNumber = byteBuffer.getInt();
				} else if ( numberType.equals( "long" ) ) {
					lNumber = byteBuffer.getLong();
				} else if ( numberType.equals( "float" ) ) {
					fNumber = byteBuffer.getFloat();
				} else if ( numberType.equals( "double" ) ) {
					dNumber = byteBuffer.getDouble();
				}
			}
			
			if ( numberType.equals( "byte" ) ) {
				outputNumber = bNumber + "";
			} else if ( numberType.equals( "short" ) ) {
				outputNumber = sNumber + "";
			} else if ( numberType.equals( "int" ) ) {
				outputNumber = iNumber + "";
			} else if ( numberType.equals( "long" ) ) {
				outputNumber = lNumber + "";
			} else if ( numberType.equals( "float" ) ) {
				outputNumber = fNumber + "";
			} else if ( numberType.equals( "double" ) ) {
				outputNumber = dNumber + "";
			}
		} catch ( Exception e ) {
			
		}
		
		byteBuffer = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outputNumber", outputNumber );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertBytesToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertBytesToString)>> ---
		// @sigtype java 3.5
		// [i] object:0:required inputBytes
		// [o] field:0:required outputString
		IDataCursor pipelineCursor = pipeline.getCursor();
		byte[] inputBytes = ( byte[] )IDataUtil.get( pipelineCursor, "inputBytes" );
		pipelineCursor.destroy();
		
		StringBuilder sb = new StringBuilder();
		
		for ( byte b : inputBytes ) {
			sb.append( String.format( " %02x  ", b ) );
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outputString", sb.toString() );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void convertNumberToBytes (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(convertNumberToBytes)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inputNumber
		// [i] field:0:required endianType {"little","big"}
		// [i] field:0:required numberType {"byte","short","int","long","float","double"}
		// [o] object:0:required outputBytes
		IDataCursor pipelineCursor = pipeline.getCursor();
		String inputNumber = IDataUtil.getString( pipelineCursor, "inputNumber" );
		String endianType = IDataUtil.getString( pipelineCursor, "endianType" );
		String numberType = IDataUtil.getString( pipelineCursor, "numberType" );
		pipelineCursor.destroy();
		
		if ( endianType == null || endianType.equals( "" ) ) {
			endianType = "little";
		}
		
		byte[] outputBytes = null;
		byte bNumber = 0;
		short sNumber = 0;
		int iNumber = 0;
		long lNumber = 0;
		float fNumber = 0;
		double dNumber = 0;
		
		try {
			if ( numberType.equals( "byte" ) ) {
				outputBytes = new byte[ 1 ];
				bNumber = Byte.parseByte( inputNumber );
				
				if ( endianType.equals( "little" ) ) {
					outputBytes[ 0 ] = ( byte )bNumber;
				} else {
					outputBytes[ 0 ] = ( byte )( bNumber >> 8 );
				}
			} else if ( numberType.equals( "short" ) ) {
				outputBytes = new byte[ 2 ];
				sNumber = Short.parseShort( inputNumber );
				
				if ( endianType.equals( "little" ) ) {
					outputBytes[ 0 ] = ( byte )sNumber;
					outputBytes[ 1 ] = ( byte )( sNumber >> 8 );
				} else {
					outputBytes[ 0 ] = ( byte )( sNumber >> 8 );
					outputBytes[ 1 ] = ( byte )sNumber;
				}
			} else if ( numberType.equals( "int" ) ) {
				outputBytes = new byte[ 4 ];
				iNumber = Integer.parseInt( inputNumber );
				
				if ( endianType.equals( "little" ) ) {
					for ( int i = 0; i < 4; i++ ) {
						outputBytes[ i ] = ( byte )( iNumber % ( 0xff + 1 ) );
						iNumber = iNumber >> 8;
					}
				} else {
					for ( int i = 0; i < 4; i++ ) {
						outputBytes[ 3 - i ] = ( byte )( iNumber % ( 0xff + 1 ) );
						iNumber = iNumber >> 8;
					}
				}
			} else if ( numberType.equals( "long" ) ) {
				outputBytes = new byte[ 8 ];
				lNumber = Long.parseLong( inputNumber );
				
				if ( endianType.equals( "little" ) ) {
					for ( int i = 0; i < 8; i++ ) {
						outputBytes[ i ] = ( byte )( lNumber % ( 0xff + 1 ) );
						lNumber = lNumber >> 8;
					}
				} else {
					for ( int i = 0; i < 8; i++ ) {
						outputBytes[ 7 - i ] = ( byte )( lNumber % ( 0xff + 1 ) );
						lNumber = lNumber >> 8;
					}
				}
			} else if ( numberType.equals( "float" ) ) {
				outputBytes = new byte[ 4 ];
				fNumber = Float.parseFloat( inputNumber );
				int bits = Float.floatToIntBits( fNumber );
				
				if ( endianType.equals( "little" ) ) {
					for ( int i = 0; i < 4; i++ ) {
						outputBytes[ i ] = ( byte )( ( bits >> ( i * 8 ) ) & 0xff );
					}
				} else {
					for ( int i = 0; i < 4; i++ ) {
						outputBytes[ i ] = ( byte )( ( bits >> ( ( 3 - i ) * 8 ) ) & 0xff );
						iNumber = iNumber >> 8;
					}
				}
			} else if ( numberType.equals( "double" ) ) {
				outputBytes = new byte[ 8 ];
				dNumber = Double.parseDouble( inputNumber );
				long bits = Double.doubleToLongBits( dNumber );
				
				if ( endianType.equals( "little" ) ) {
					for ( int i = 0; i < 8; i++ ) {
						outputBytes[ i ] = ( byte )( ( bits >> ( i * 8 ) ) & 0xff );
					}
				} else {
					for ( int i = 0; i < 8; i++ ) {
						outputBytes[ i ] = ( byte )( ( bits >> ( ( 7 - i ) * 8 ) ) & 0xff );
						iNumber = iNumber >> 8;
					}
				}
			}
		} catch ( Exception e ) {
			
		}
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outputBytes", outputBytes );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}
}

