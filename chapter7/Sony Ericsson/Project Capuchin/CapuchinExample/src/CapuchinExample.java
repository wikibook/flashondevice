/*****************************************************************************
 *
 * Description: Simple Capuchin Example
 * 
 *
 *****************************************************************************/

import java.io.InputStream;
import javax.microedition.lcdui.Display;
import javax.microedition.midlet.MIDlet;
import com.sonyericsson.capuchin.FlashDataRequest;
import com.sonyericsson.capuchin.FlashDataRequestListener;
import com.sonyericsson.capuchin.FlashImage;
import com.sonyericsson.capuchin.FlashPlayer;
import com.sonyericsson.capuchin.FlashCanvas;

public class CapuchinExample extends MIDlet implements FlashDataRequestListener {

    private FlashPlayer flashPlayer;
    private FlashImage flashImage;
    private FlashCanvas flashCanvas;

    public CapuchinExample() {        
        try {
            InputStream inp = getClass().getResourceAsStream("/CapuchinExample.swf");
            flashImage = FlashImage.createImage(inp,null);
            flashCanvas = new FlashCanvas(flashImage);
            flashPlayer = FlashPlayer.createFlashPlayer(flashImage,flashCanvas);
            flashCanvas.setFullScreenMode(true);
            flashImage.setFlashDataRequestListener(this);    
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void destroyApp(boolean arg) {
    	flashPlayer = null;
    	flashImage = null;
    	flashCanvas = null;
    }

    protected void pauseApp() {}

    protected void startApp() {
        if (flashPlayer != null) {
            Display.getDisplay(this).setCurrent(flashCanvas);
        }

    }

    public synchronized void dataRequested(FlashDataRequest dr) {
        String[] is = dr.getArgs();
        if (is[0].compareTo(new String("quit")) == 0) {   
            notifyDestroyed();
        } 

    }

}