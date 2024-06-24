package JSocketAdapter.TEST;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.File;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.DataLine;
// --- <<IS-END-IMPORTS>> ---

public final class MEDIA

{
	// ---( internal utility methods )---

	final static MEDIA _instance = new MEDIA();

	static MEDIA _newInstance() { return new MEDIA(); }

	static MEDIA _cast(Object o) { return (MEDIA)o; }

	// ---( server methods )---




	public static final void playAudio (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(playAudio)>> ---
		// @sigtype java 3.5
		// [i] field:0:required audioFileName
		// [i] field:0:required playInterval
		// [i] field:0:required playCount
		IDataCursor pipelineCursor = pipeline.getCursor();
		String audioFileName = IDataUtil.getString( pipelineCursor, "audioFileName" );
		int playInterval = IDataUtil.getInt( pipelineCursor, "playInterval", 0 );
		int playCount = IDataUtil.getInt( pipelineCursor, "playCount", 0 );
		pipelineCursor.destroy();
		
		File audioFile = null;
		AudioInputStream audioStream = null;
		AudioFormat audioFormat = null;
		DataLine.Info dlInfo = null;
		Clip clip = null;
		
		try {
			if ( playCount <= 1 ) {
				audioFile = new File( audioFileName );
				audioStream = AudioSystem.getAudioInputStream( audioFile );
				audioFormat = audioStream.getFormat();
				dlInfo = new DataLine.Info( Clip.class, audioFormat );
				clip = ( Clip )AudioSystem.getLine( dlInfo );
				clip.open( audioStream );
				clip.start();
			} else {			
				for ( int i = 0; i < playCount; i++ ) {
					audioFile = new File( audioFileName );
					audioStream = AudioSystem.getAudioInputStream( audioFile );
					audioFormat = audioStream.getFormat();
					dlInfo = new DataLine.Info( Clip.class, audioFormat );
					clip = ( Clip )AudioSystem.getLine( dlInfo );
					clip.open( audioStream );
					clip.start();
					
					if ( i <= ( playCount - 2 ) ) {
						Thread.sleep( playInterval * 1000 );
					}
					
					audioFile = null;
					audioStream = null;
					audioFormat = null;
					dlInfo = null;
					clip = null;					
				}
			}
		} catch ( Exception e ) {
			throw new ServiceException( e );
		}
		
		audioFile = null;
		audioStream = null;
		audioFormat = null;
		dlInfo = null;
		clip = null;
		// --- <<IS-END>> ---

                
	}
}

