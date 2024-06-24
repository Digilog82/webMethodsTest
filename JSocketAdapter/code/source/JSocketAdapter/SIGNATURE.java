package JSocketAdapter;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
// --- <<IS-END-IMPORTS>> ---

public final class SIGNATURE

{
	// ---( internal utility methods )---

	final static SIGNATURE _instance = new SIGNATURE();

	static SIGNATURE _newInstance() { return new SIGNATURE(); }

	static SIGNATURE _cast(Object o) { return (SIGNATURE)o; }

	// ---( server methods )---




	public static final void sign (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sign)>> ---
		// @sigtype java 3.5
		// [i] field:0:required signingData
		// [i] object:0:required signingBytes
		// [i] field:0:required signatureAlg {"MD2withRSA","MD5withRSA","SHA1withRSA","SHA256withRSA","SHA384withRSA","SHA512withRSA","SHA1withDSA"}
		// [i] field:0:required charset
		// [i] object:0:required privateKey
		// [o] field:0:required errorMsg
		// [o] object:0:required signedBytes
		// [o] field:0:required signInfo
		IDataCursor pipelineCursor = pipeline.getCursor();
		String signingData = IDataUtil.getString( pipelineCursor, "signingData" );
		byte[] signingBytes = ( byte[] )IDataUtil.get( pipelineCursor, "signingBytes" );
		String signatureAlg = IDataUtil.getString( pipelineCursor, "signatureAlg" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		PrivateKey privateKey = ( PrivateKey )IDataUtil.get( pipelineCursor, "privateKey" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		byte[] signedBytes = null;
		String signedData = "";
		Signature signature = null;
		String signInfo = "";
		
		try {
			if ( signingBytes == null ) {
				if ( charset == null ) {
					signingBytes = signingData.getBytes();
				} else {
					signingBytes = signingData.getBytes( charset );
				}
			}
			
			signature = Signature.getInstance( signatureAlg );
			signature.initSign( privateKey );
			signature.update( signingBytes );
			signedBytes = signature.sign();
			signInfo = signature.toString();
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		signature = null;
		privateKey = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "signedBytes", signedBytes );
		IDataUtil.put( pipelineCursor_1, "signInfo", signInfo );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void verify (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(verify)>> ---
		// @sigtype java 3.5
		// [i] field:0:required signingData
		// [i] object:0:required signingBytes
		// [i] field:0:required signatureAlg {"MD2withRSA","MD5withRSA","SHA1withRSA","SHA256withRSA","SHA384withRSA","SHA512withRSA","SHA1withDSA"}
		// [i] field:0:required charset
		// [i] object:0:required signedBytes
		// [i] object:0:required publicKey
		// [o] field:0:required errorMsg
		// [o] field:0:required verify
		IDataCursor pipelineCursor = pipeline.getCursor();
		String signingData = IDataUtil.getString( pipelineCursor, "signingData" );
		byte[] signingBytes = ( byte[] )IDataUtil.get( pipelineCursor, "signingBytes" );
		String signatureAlg = IDataUtil.getString( pipelineCursor, "signatureAlg" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		byte[] signedBytes = ( byte[] )IDataUtil.get( pipelineCursor, "signedBytes" );
		PublicKey publicKey = ( PublicKey )IDataUtil.get( pipelineCursor, "publicKey" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		boolean verify = true;
		Signature signature = null;
		
		try {
			if ( signingBytes == null ) {
				if ( charset == null ) {
					signingBytes = signingData.getBytes();
				} else {
					signingBytes = signingData.getBytes( charset );
				}
			}
			
			signature = Signature.getInstance( signatureAlg );
			signature.initVerify( publicKey );
			signature.update( signingBytes );
			verify = signature.verify( signedBytes );			
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		signature = null;
		publicKey = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "verify", verify + "" );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}
}

