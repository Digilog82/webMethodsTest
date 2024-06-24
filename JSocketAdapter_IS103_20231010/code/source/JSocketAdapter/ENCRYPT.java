package JSocketAdapter;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.Socket;
import java.net.SocketException;
import java.security.Key;
import java.security.KeyStore;
import java.security.KeyFactory;
import java.security.PublicKey;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.spec.X509EncodedKeySpec;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import custom.java.com.log.DebugLogger;
// --- <<IS-END-IMPORTS>> ---

public final class ENCRYPT

{
	// ---( internal utility methods )---

	final static ENCRYPT _instance = new ENCRYPT();

	static ENCRYPT _newInstance() { return new ENCRYPT(); }

	static ENCRYPT _cast(Object o) { return (ENCRYPT)o; }

	// ---( server methods )---




	public static final void createAndSaveSecretKeyToKeyStore (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createAndSaveSecretKeyToKeyStore)>> ---
		// @sigtype java 3.5
		// [i] field:0:required algorithm {"DES","DESede","AES"}
		// [i] field:0:required aesKeyLength {"","128","192","256"}
		// [i] field:0:required keyStoreFileName
		// [i] field:0:required keyAlias
		// [i] field:0:required keyStorePassword
		// [i] field:0:required keyPassword
		// [i] field:0:required keyStoreType {"JKS"}
		// [o] field:0:required errorMsg
		IDataCursor pipelineCursor = pipeline.getCursor();
		String algorithm = IDataUtil.getString( pipelineCursor, "algorithm" );
		int aesKeyLength = IDataUtil.getInt( pipelineCursor, "aesKeyLength", 128 );
		String keyStoreFileName = IDataUtil.getString( pipelineCursor, "keyStoreFileName" );
		String keyAlias = IDataUtil.getString( pipelineCursor, "keyAlias" );
		String keyStorePassword = IDataUtil.getString( pipelineCursor, "keyStorePassword" );
		String keyPassword = IDataUtil.getString( pipelineCursor, "keyPassword" );
		String keyStoreType = IDataUtil.getString( pipelineCursor, "keyStoreType" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		int secretKeySize = 0;
		int ivSize = 0;
		String transformation = algorithm;
		
		KeyGenerator keyGenerator = null;
		SecretKey sk = null;
		KeyStore ks = null;
		File file = null;
		FileOutputStream fos = null;
				
		try {
			if ( algorithm.equals( "DES" ) ) {
				secretKeySize = 64;
			} else if ( algorithm.equals( "DESede" ) ) {
				secretKeySize = 192;
			} else if ( algorithm.equals( "AES" ) ) {
				secretKeySize = aesKeyLength;
			}
			
			keyGenerator = KeyGenerator.getInstance( algorithm );
			keyGenerator.init( secretKeySize );
			sk = keyGenerator.generateKey();
			
			file = new File( keyStoreFileName );
			fos = new FileOutputStream( file );
			ks = KeyStore.getInstance( keyStoreType );
			ks.load( null, keyStorePassword.toCharArray() );
			ks.setKeyEntry( keyAlias, sk, keyPassword.toCharArray(), null );
			ks.store( fos, keyStorePassword.toCharArray() );
		} catch ( Exception e ) {
			errorMsg = e.getMessage();
		} finally {
			if ( fos != null ) {
				try {
					fos.close();
				} catch ( Exception fe ) {
					errorMsg = fe.toString();
				}
			}
		}
		
		keyGenerator = null;
		sk = null;
		ks = null;
		file = null;
		fos = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void createRandomKeyIv (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createRandomKeyIv)>> ---
		// @sigtype java 3.5
		// [i] field:0:required algorithm {"DES","DESede","AES"}
		// [i] field:0:required mode
		// [i] field:0:required padding
		// [i] field:0:required aesKeyLength {"","128","192","256"}
		// [o] object:0:required secretKey
		// [o] object:0:required initialVector
		IDataCursor pipelineCursor = pipeline.getCursor();
		String algorithm = IDataUtil.getString( pipelineCursor, "algorithm" );
		String mode = IDataUtil.getString( pipelineCursor, "mode" );
		String padding = IDataUtil.getString( pipelineCursor, "padding" );
		int aesKeyLength = IDataUtil.getInt( pipelineCursor, "aesKeyLength", 128 );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		int secretKeySize = 0;
		int ivSize = 0;
		String transformation = algorithm;
		
		KeyGenerator keyGenerator = null;
		Key symmetricKey = null;
		Cipher cipher = null;
		byte[] secretKey = null;
		byte[] initialVector = null;
		
		if ( mode == null ) {
			mode = "";
		}
		
		if ( padding == null ) {
			padding = "";
		}
		
		try {
			if ( algorithm.equals( "DES" ) ) {
				secretKeySize = 64;
			} else if ( algorithm.equals( "DESede" ) ) {
				secretKeySize = 192;
			} else if ( algorithm.equals( "AES" ) ) {
				secretKeySize = aesKeyLength;
			}
			
			keyGenerator = KeyGenerator.getInstance( algorithm );
			keyGenerator.init( secretKeySize );
			symmetricKey = keyGenerator.generateKey();
			secretKey = symmetricKey.getEncoded();
			
			if ( !mode.equals( "" ) ) {
				transformation = transformation + "/" + mode;
			}
			
			if ( !padding.equals( "" ) ) {
				transformation = transformation + "/" + padding;
			}
			
			cipher = Cipher.getInstance( transformation );
			cipher.init( Cipher.ENCRYPT_MODE, symmetricKey );
			initialVector = cipher.getIV();
		} catch ( Exception e ) {
			errorMsg = e.getMessage();
		}
		
		keyGenerator = null;
		symmetricKey = null;
		cipher = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "secretKey", secretKey );
		IDataUtil.put( pipelineCursor_1, "initialVector", initialVector );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void decrypt (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(decrypt)>> ---
		// @sigtype java 3.5
		// [i] field:0:required secretKey
		// [i] field:0:required initialVector
		// [i] field:0:required algorithm {"DES","DESede","AES"}
		// [i] field:0:required mode {"","ECB","CBC"}
		// [i] field:0:required padding {"","NoPadding","PKCS5Padding","PKCS7Padding"}
		// [i] object:0:required encryptedBytes
		// [i] field:0:optional charset
		// [i] object:0:required secretKeyBytes
		// [i] object:0:required initialVectorBytes
		// [o] field:0:required errorMsg
		// [o] field:0:required plainData
		// [o] object:0:required plainBytes
		IDataCursor pipelineCursor = pipeline.getCursor();
		String secretKey = IDataUtil.getString( pipelineCursor, "secretKey" );
		String initialVector = IDataUtil.getString( pipelineCursor, "initialVector" );
		String algorithm = IDataUtil.getString( pipelineCursor, "algorithm" );
		String mode = IDataUtil.getString( pipelineCursor, "mode" );
		String padding = IDataUtil.getString( pipelineCursor, "padding" );
		byte[] encryptedBytes = ( byte[] )IDataUtil.get( pipelineCursor, "encryptedBytes" );
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		byte[] secretKeyBytes = ( byte[] )IDataUtil.get( pipelineCursor, "secretKeyBytes" );
		byte[] initialVectorBytes = ( byte[] )IDataUtil.get( pipelineCursor, "initialVectorBytes" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		String plainData = "";
		byte[] plainBytes = null;
		
		Cipher cipher = null;
		SecretKeyFactory skf = null;
		DESKeySpec desSpec = null;
		DESedeKeySpec desEdeSpec = null;
		SecretKeySpec aesSpec = null;
		Key key = null;
		IvParameterSpec iv = null;
		String transformation = algorithm;
		
		if ( mode == null ) {
			mode = "";
		}
		
		if ( padding == null ) {
			padding = "";
		}
		
		try {
			if ( secretKeyBytes == null ) {
				if ( secretKey == null || secretKey.equals( "" ) ) {
					throw new ServiceException( "Either secretKey or secretKeyBytes is required." );
				} else {
					secretKeyBytes = secretKey.getBytes( "US-ASCII" );
				}
			}
			
			if ( mode.equals( "CBC") ) {
				if ( initialVectorBytes == null ) {
					if ( initialVector == null || initialVector.equals( "" ) ) {
						throw new ServiceException( "Either initialVector or initialVectorBytes is required." );
					} else {
						initialVectorBytes = initialVector.getBytes( "US-ASCII" );
					}
				}
			}
			
			if ( !mode.equals( "" ) ) {
				transformation = transformation + "/" + mode;
			}
			
			if ( !padding.equals( "" ) ) {
				transformation = transformation + "/" + padding;
			}
			
			cipher = Cipher.getInstance( transformation );
			skf = SecretKeyFactory.getInstance( algorithm );
			
			if ( algorithm.equals( "DES" ) ) {
				desSpec = new DESKeySpec( secretKeyBytes );
				key = skf.generateSecret( desSpec );
			} else if ( algorithm.equals( "DESede" ) ) {
				desEdeSpec = new DESedeKeySpec( secretKeyBytes );
				key = skf.generateSecret( desEdeSpec );
			} else if ( algorithm.equals( "AES" ) ) {
				aesSpec = new SecretKeySpec( secretKeyBytes, "AES" );
				key = aesSpec;
			}
			
			if ( mode.equals( "CBC") ) {
				iv = new IvParameterSpec( initialVectorBytes );
				cipher.init( Cipher.DECRYPT_MODE, key, iv );
			} else {
				cipher.init( Cipher.DECRYPT_MODE, key );
			}
			
			plainBytes = cipher.doFinal( encryptedBytes );
			
			if ( charset == null ) {
				plainData = new String( plainBytes );
			} else { 
				plainData = new String( plainBytes, charset );
			}
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		skf = null;
		desSpec = null;
		desEdeSpec = null;
		aesSpec = null;
		key = null;
		iv = null;
		cipher = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "plainData", plainData );
		IDataUtil.put( pipelineCursor_1, "plainBytes", plainBytes );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void decryptSecretKey (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(decryptSecretKey)>> ---
		// @sigtype java 3.5
		// [i] object:0:required encryptedSecretKey
		// [i] field:0:required password
		// [o] field:0:required errorMsg
		// [o] field:0:required secretKey
		IDataCursor pipelineCursor = pipeline.getCursor();
		byte[] encryptedSecretKey = ( byte[] )IDataUtil.get( pipelineCursor, "encryptedSecretKey" );
		String password = IDataUtil.getString( pipelineCursor, "password" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		String secretKey = "";
		byte[] decryptedSecretKey = null;
		
		String algorithm = "DES";
		String mode = "CBC";
		String padding = "PKCS5Padding";
		
		Cipher cipher = null;
		SecretKeyFactory skf = null;
		DESKeySpec desSpec = null;
		DESedeKeySpec desEdeSpec = null;
		SecretKey sk = null;
		IvParameterSpec iv = null;
		
		try {
			cipher = Cipher.getInstance( algorithm + "/" + mode + "/" + padding );
			skf = SecretKeyFactory.getInstance( algorithm );
			desSpec = new DESKeySpec( password.getBytes( "UTF-8" ) );
			sk = skf.generateSecret( desSpec );
			iv = new IvParameterSpec( password.getBytes( "UTF-8" ) );			
			cipher.init( Cipher.DECRYPT_MODE, sk, iv );
			decryptedSecretKey = cipher.doFinal( encryptedSecretKey );
			secretKey = new String( decryptedSecretKey, "UTF-8" );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		skf = null;
		desSpec = null;
		desEdeSpec = null;
		sk = null;
		iv = null;
		cipher = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "secretKey", secretKey );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void encrypt (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(encrypt)>> ---
		// @sigtype java 3.5
		// [i] field:0:required secretKey
		// [i] field:0:required initialVector
		// [i] field:0:required algorithm {"DES","DESede","AES"}
		// [i] field:0:required mode {"","ECB","CBC"}
		// [i] field:0:required padding {"","NoPadding","PKCS5Padding","PKCS7Padding"}
		// [i] field:0:required plainData
		// [i] object:0:required plainBytes
		// [i] field:0:required charset
		// [i] object:0:required secretKeyBytes
		// [i] object:0:required initialVectorBytes
		// [o] field:0:required errorMsg
		// [o] object:0:required encryptedBytes
		// [o] field:0:required encryptedLength
		IDataCursor pipelineCursor = pipeline.getCursor();
		String secretKey = IDataUtil.getString( pipelineCursor, "secretKey" );
		String initialVector = IDataUtil.getString( pipelineCursor, "initialVector" );
		String algorithm = IDataUtil.getString( pipelineCursor, "algorithm" );
		String mode = IDataUtil.getString( pipelineCursor, "mode" );
		String padding = IDataUtil.getString( pipelineCursor, "padding" );
		String plainData = IDataUtil.getString( pipelineCursor, "plainData" );
		byte[] plainBytes = ( byte[] )IDataUtil.get( pipelineCursor, "plainBytes" );		
		String charset = IDataUtil.getString( pipelineCursor, "charset" );
		byte[] secretKeyBytes = ( byte[] )IDataUtil.get( pipelineCursor, "secretKeyBytes" );
		byte[] initialVectorBytes = ( byte[] )IDataUtil.get( pipelineCursor, "initialVectorBytes" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		byte[] encryptedBytes = null;
		String encryptedLength = "";
		
		Cipher cipher = null;
		SecretKeyFactory skf = null;
		DESKeySpec desSpec = null;
		DESedeKeySpec desEdeSpec = null;
		SecretKeySpec aesSpec = null;
		Key key = null;
		IvParameterSpec iv = null;
		String transformation = algorithm;
		
		if ( mode == null ) {
			mode = "";
		}
		
		if ( padding == null ) {
			padding = "";
		}
		
		try {
			if ( secretKeyBytes == null ) {
				if ( secretKey == null || secretKey.equals( "" ) ) {
					throw new ServiceException( "Either secretKey or secretKeyBytes is required." );
				} else {
					secretKeyBytes = secretKey.getBytes( "US-ASCII" );
				}
			}
			
			if ( mode.equals( "CBC") ) {
				if ( initialVectorBytes == null ) {
					if ( initialVector == null || initialVector.equals( "" ) ) {
						throw new ServiceException( "Either initialVector or initialVectorBytes is required." );
					} else {
						initialVectorBytes = initialVector.getBytes( "US-ASCII" );
					}
				}
			}
			
			if ( plainBytes == null ) {
				if ( charset == null ) {
					plainBytes = plainData.getBytes();
				} else {
					plainBytes = plainData.getBytes( charset );
				}
			}
			
			if ( !mode.equals( "" ) ) {
				transformation = transformation + "/" + mode;
			}
			
			if ( !padding.equals( "" ) ) {
				transformation = transformation + "/" + padding;
			}
			
			cipher = Cipher.getInstance( transformation );
			skf = SecretKeyFactory.getInstance( algorithm );
			
			if ( algorithm.equals( "DES" ) ) {
				desSpec = new DESKeySpec( secretKeyBytes );
				key = skf.generateSecret( desSpec );
			} else if ( algorithm.equals( "DESede" ) ) {
				desEdeSpec = new DESedeKeySpec( secretKeyBytes );
				key = skf.generateSecret( desEdeSpec );
			} else if ( algorithm.equals( "AES" ) ) {
				aesSpec = new SecretKeySpec( secretKeyBytes, "AES" );
				key = aesSpec;
			}
			
			if ( mode.equals( "CBC") ) {
				iv = new IvParameterSpec( initialVectorBytes );
				cipher.init( Cipher.ENCRYPT_MODE, key, iv );
			} else {
				cipher.init( Cipher.ENCRYPT_MODE, key );
			}
			
			encryptedBytes = cipher.doFinal( plainBytes );
			encryptedLength = encryptedBytes.length + "";
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		skf = null;
		desSpec = null;
		desEdeSpec = null;
		aesSpec = null;
		key = null;
		iv = null;
		cipher = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "encryptedBytes", encryptedBytes );
		IDataUtil.put( pipelineCursor_1, "encryptedLength", encryptedLength );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void encryptRSA (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(encryptRSA)>> ---
		// @sigtype java 3.5
		// [i] object:0:optional pubKeyBytes
		// [i] object:0:optional base64DecPubKeyBytes
		// [i] object:0:required dataBytes
		// [i] field:0:required mode
		// [i] field:0:required padding
		// [o] field:0:required errorMsg
		// [o] object:0:required encryptedBytes
		IDataCursor pipelineCursor = pipeline.getCursor();
		byte[] pubKeyBytes = ( byte[] )IDataUtil.get( pipelineCursor, "pubKeyBytes" ); // Public Key \uD30C\uC77C\uC744 Bytes\uB85C Read \uD55C \uAC12
		byte[] base64DecPubKeyBytes = ( byte[] )IDataUtil.get( pipelineCursor, "base64DecPubKeyBytes" ); // PEM \uD3EC\uB9F7\uC758 Public Key\uB97C Base64 Decoding \uD55C \uAC12
		byte[] dataBytes = ( byte[] )IDataUtil.get( pipelineCursor, "dataBytes" ); // \uC554\uD638\uD654 \uD560 \uB370\uC774\uD130
		String mode = IDataUtil.getString( pipelineCursor, "mode" );
		String padding = IDataUtil.getString( pipelineCursor, "padding" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		byte[] encryptedBytes = null;
		
		CertificateFactory certificateFactory = null;
		ByteArrayInputStream bis = null;
		X509Certificate X509Cert = null;
		KeyFactory keyFactory = null;
		X509EncodedKeySpec publicKeySpec = null;
		PublicKey publicKey = null;
		Cipher cipher = null;
		String transformation = "RSA";
		
		try {
			if ( mode != null && !mode.equals( "" ) && padding != null && !padding.equals( "" ) ) {
				transformation = transformation + "/" + mode + "/" + padding;
			}
			
			// PublicKey \uC0DD\uC131
			if ( pubKeyBytes != null ) {
				certificateFactory = CertificateFactory.getInstance( "X509" );
				bis = new ByteArrayInputStream( pubKeyBytes );
				X509Cert = ( X509Certificate )certificateFactory.generateCertificate( bis );
				publicKey = X509Cert.getPublicKey();
			} else {
				if ( base64DecPubKeyBytes != null ) {
					keyFactory = KeyFactory.getInstance( "RSA" );
					publicKeySpec = new X509EncodedKeySpec( base64DecPubKeyBytes );
					publicKey = keyFactory.generatePublic( publicKeySpec );
				} else {
					throw new ServiceException( "Either pubKeyBytes or base64DecPubKeyBytes is required." );
				}
			}
			
			// \uC554\uD638\uD654
			cipher = Cipher.getInstance( transformation );
			cipher.init( Cipher.ENCRYPT_MODE, publicKey );
			encryptedBytes = cipher.doFinal( dataBytes );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		certificateFactory = null;
		bis = null;
		X509Cert = null;
		keyFactory = null;
		publicKeySpec = null;
		publicKey = null;
		cipher = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "encryptedBytes", encryptedBytes );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void encryptSecretKey (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(encryptSecretKey)>> ---
		// @sigtype java 3.5
		// [i] field:0:required secretKey
		// [i] field:0:required password
		// [o] field:0:required errorMsg
		// [o] object:0:required encryptedSecretKey
		IDataCursor pipelineCursor = pipeline.getCursor();
		String secretKey = IDataUtil.getString( pipelineCursor, "secretKey" );
		String password = IDataUtil.getString( pipelineCursor, "password" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		byte[] secretKeyBytes = null;
		byte[] encryptedSecretKey = null;
		
		String algorithm = "DES";
		String mode = "CBC";
		String padding = "PKCS5Padding";
		
		Cipher cipher = null;
		SecretKeyFactory skf = null;
		DESKeySpec desSpec = null;
		DESedeKeySpec desEdeSpec = null;
		SecretKey sk = null;
		IvParameterSpec iv = null;
		
		try {
			secretKeyBytes = secretKey.getBytes( "UTF-8" );
			cipher = Cipher.getInstance( algorithm + "/" + mode + "/" + padding );
			skf = SecretKeyFactory.getInstance( algorithm );
			desSpec = new DESKeySpec( password.getBytes( "UTF-8" ) );
			sk = skf.generateSecret( desSpec );
			iv = new IvParameterSpec( password.getBytes( "UTF-8" ) );			
			cipher.init( Cipher.ENCRYPT_MODE, sk, iv );
			encryptedSecretKey = cipher.doFinal( secretKeyBytes );
		} catch ( Exception e ) {
			errorMsg = e.toString();
		}
		
		skf = null;
		desSpec = null;
		desEdeSpec = null;
		sk = null;
		iv = null;
		cipher = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "encryptedSecretKey", encryptedSecretKey );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getCipher (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getCipher)>> ---
		// @sigtype java 3.5
		// [i] field:0:required secretKey
		// [i] field:0:required initialVector
		// [i] field:0:required algorithm {"DES","DESede","AES"}
		// [i] field:0:required mode
		// [i] field:0:required padding
		// [i] field:0:required encDec {"ENCRYPT","DECRYPT"}
		// [o] object:0:required cipher
		IDataCursor pipelineCursor = pipeline.getCursor();
		String secretKey = IDataUtil.getString( pipelineCursor, "secretKey" );
		String initialVector = IDataUtil.getString( pipelineCursor, "initialVector" );
		String algorithm = IDataUtil.getString( pipelineCursor, "algorithm" );
		String mode = IDataUtil.getString( pipelineCursor, "mode" );
		String padding = IDataUtil.getString( pipelineCursor, "padding" );
		String encDec = IDataUtil.getString( pipelineCursor, "encDec" );
		pipelineCursor.destroy();
		
		Cipher cipher = null;
		SecretKeyFactory skf = null;
		DESKeySpec desSpec = null;
		DESedeKeySpec desEdeSpec = null;
		SecretKeySpec aesSpec = null;
		Key key = null;
		IvParameterSpec iv = null;
		String transformation = algorithm;
		
		if ( mode == null ) {
			mode = "";
		}
		
		if ( padding == null ) {
			padding = "";
		}
		
		try {
			if ( !mode.equals( "" ) ) {
				transformation = transformation + "/" + mode;
			}
			
			if ( !padding.equals( "" ) ) {
				transformation = transformation + "/" + padding;
			}
			
			cipher = Cipher.getInstance( transformation );
			skf = SecretKeyFactory.getInstance( algorithm );
			
			if ( algorithm.equals( "DES" ) ) {
				desSpec = new DESKeySpec( secretKey.getBytes( "US-ASCII" ) );
				key = skf.generateSecret( desSpec );
			} else if ( algorithm.equals( "DESede" ) ) {
				desEdeSpec = new DESedeKeySpec( secretKey.getBytes( "US-ASCII" ) );
				key = skf.generateSecret( desEdeSpec );
			} else if ( algorithm.equals( "AES" ) ) {
				aesSpec = new SecretKeySpec( secretKey.getBytes( "US-ASCII" ), "AES" );
				key = aesSpec;
			}					
			
			if ( encDec.equals( "ENCRYPT" ) ) {
				if ( mode.equals( "CBC") ) {
					iv = new IvParameterSpec( initialVector.getBytes( "US-ASCII" ) );
					cipher.init( Cipher.ENCRYPT_MODE, key, iv );
				} else {
					cipher.init( Cipher.ENCRYPT_MODE, key );
				}
			} else {
				if ( mode.equals( "CBC") ) {
					iv = new IvParameterSpec( initialVector.getBytes( "US-ASCII" ) );
					cipher.init( Cipher.DECRYPT_MODE, key, iv );
				} else {
					cipher.init( Cipher.DECRYPT_MODE, key );
				}
			}
		} catch ( Exception e ) {
			
		}
		
		skf = null;
		desSpec = null;
		desEdeSpec = null;
		key = null;
		iv = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "cipher", cipher );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getSecretKeyBytesFromKeyStore (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getSecretKeyBytesFromKeyStore)>> ---
		// @sigtype java 3.5
		// [i] field:0:required keyStoreFileName
		// [i] field:0:required keyAlias
		// [i] field:0:required keyStorePassword
		// [i] field:0:required keyPassword
		// [i] field:0:required keyStoreType {"JKS"}
		// [o] field:0:required errorMsg
		// [o] object:0:required secretKeyBytes
		IDataCursor pipelineCursor = pipeline.getCursor();
		String keyStoreFileName = IDataUtil.getString( pipelineCursor, "keyStoreFileName" );
		String keyAlias = IDataUtil.getString( pipelineCursor, "keyAlias" );
		String keyStorePassword = IDataUtil.getString( pipelineCursor, "keyStorePassword" );
		String keyPassword = IDataUtil.getString( pipelineCursor, "keyPassword" );
		String keyStoreType = IDataUtil.getString( pipelineCursor, "keyStoreType" );
		pipelineCursor.destroy();
		
		String errorMsg = "";
		byte[] secretKeyBytes = null;
		File file = null;
		FileInputStream fis = null;
		KeyStore ks = null;
		SecretKey sk = null;
		
		try {
			file = new File( keyStoreFileName );
			fis = new FileInputStream( file );
			ks = KeyStore.getInstance( keyStoreType );
			ks.load( fis, keyStorePassword.toCharArray() );
			sk = ( SecretKey )ks.getKey( keyAlias, keyPassword.toCharArray() );
			secretKeyBytes = sk.getEncoded();
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
		sk = null;
		
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "errorMsg", errorMsg );
		IDataUtil.put( pipelineCursor_1, "secretKeyBytes", secretKeyBytes );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static DebugLogger debugLogger = new DebugLogger();
	// --- <<IS-END-SHARED>> ---
}

