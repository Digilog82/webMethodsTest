package JSocketAdapter;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.File;
import java.io.FileInputStream;
import java.security.cert.Certificate;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.PublicKey;
// --- <<IS-END-IMPORTS>> ---

public final class CERTIFICATE

{
	// ---( internal utility methods )---

	final static CERTIFICATE _instance = new CERTIFICATE();

	static CERTIFICATE _newInstance() { return new CERTIFICATE(); }

	static CERTIFICATE _cast(Object o) { return (CERTIFICATE)o; }

	// ---( server methods )---




	public static final void getKeyAndChainFromKeyStore (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getKeyAndChainFromKeyStore)>> ---
		// @sigtype java 3.5
		// [i] field:0:required keyStoreFileName
		// [i] field:0:required keyAlias
		// [i] field:0:required keyStorePassword
		// [i] field:0:required keyPassword
		// [i] field:0:required keyStoreType {"JKS"}
		// [o] object:0:required privateKey
		// [o] object:1:required certChain
		IDataCursor pipelineCursor = pipeline.getCursor();
		String keyStoreFileName = IDataUtil.getString( pipelineCursor, "keyStoreFileName" );
		String keyAlias = IDataUtil.getString( pipelineCursor, "keyAlias" );
		String keyStorePassword = IDataUtil.getString( pipelineCursor, "keyStorePassword" );
		String keyPassword = IDataUtil.getString( pipelineCursor, "keyPassword" );
		String keyStoreType = IDataUtil.getString( pipelineCursor, "keyStoreType" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		File file = null;
		FileInputStream fis = null;
		KeyStore ks = null;
		KeyStore.ProtectionParameter protParam = null;
		KeyStore.PrivateKeyEntry pkEntry = null;
		PrivateKey privateKey = null;
		Certificate[] certiChain = null;
		PublicKey[] certChain = null;
		
		try {
			file = new File( keyStoreFileName );
			fis = new FileInputStream( file );
			ks = KeyStore.getInstance( keyStoreType );
			ks.load( fis, keyStorePassword.toCharArray() );
			protParam = new KeyStore.PasswordProtection( keyPassword.toCharArray() );
			pkEntry = ( KeyStore.PrivateKeyEntry )ks.getEntry( keyAlias, protParam );
			privateKey = pkEntry.getPrivateKey();
			certiChain = ks.getCertificateChain( keyAlias );
			certChain = new PublicKey[ certiChain.length ];
			
			for ( int i = 0; i < certiChain.length; i++ ) {
				certChain[ i ] = certiChain[ i ].getPublicKey();
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		} finally {
			if ( fis != null ) {
				try {
					fis.close();
				} catch ( Exception fe ) {
					errorMsg = fe.toString();
				}
			}
		}
		
		file = null;
		fis = null;
		ks = null;
		protParam = null;
		pkEntry = null;
		certiChain = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "privateKey", privateKey );
		IDataUtil.put( pipelineCursor_1, "certChain", certChain );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getPublicKeyFromTrustStore (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getPublicKeyFromTrustStore)>> ---
		// @sigtype java 3.5
		// [i] field:0:required trustStoreFileName
		// [i] field:0:required certAlias
		// [i] field:0:required trustStorePassword
		// [i] field:0:required keyStoreType {"JKS"}
		// [o] object:0:required publicKey
		IDataCursor pipelineCursor = pipeline.getCursor();
		String trustStoreFileName = IDataUtil.getString( pipelineCursor, "trustStoreFileName" );
		String certAlias = IDataUtil.getString( pipelineCursor, "certAlias" );
		String trustStorePassword = IDataUtil.getString( pipelineCursor, "trustStorePassword" );
		String keyStoreType = IDataUtil.getString( pipelineCursor, "keyStoreType" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		File file = null;
		FileInputStream fis = null;
		KeyStore ks = null;
		Certificate cert = null;
		PublicKey publicKey = null;
		
		try {
			file = new File( trustStoreFileName );
			fis = new FileInputStream( file );
			ks = KeyStore.getInstance( keyStoreType );
			ks.load( fis, trustStorePassword.toCharArray() );
			cert = ks.getCertificate( certAlias );
			publicKey = cert.getPublicKey();
		} catch ( Exception e ) {
			errorMsg = e.toString();
		} finally {
			if ( fis != null ) {
				try {
					fis.close();
				} catch ( Exception fe ) {
					errorMsg = fe.toString();
				}
			}
		}
		
		file = null;
		fis = null;
		ks = null;
		cert = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "publicKey", publicKey );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}
}

