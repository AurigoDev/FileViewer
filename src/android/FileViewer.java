package org.aurigo.mobile.plugins;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;

import android.content.Intent;
import android.net.Uri;
import android.webkit.MimeTypeMap;

/**
 * This class echoes a string called from JavaScript.
 */

	public class CDVFileViewer extends CordovaPlugin {
	    @Override
	    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
	        if (action.equals("openDocument")) {
	            String message = args.getString(0); 
	            openFile(message);
	            return true;
	        }
	        return false;
	    } 
   
    
    //Function for opening file
    
    private PluginResult openDocument(String fileUrl){
        Intent intent = new Intent();
        intent.setAction(android.content.Intent.ACTION_VIEW);
        
        String extension = fileUrl.substring(fileUrl.lastIndexOf(".")+1);
        String type = "";

        String type = getMimeType(fileUrl);

        intent.setDataAndType(Uri.parse(fileUrl), type);
        cordova.getActivity().startActivity(intent);

        return new PluginResult(PluginResult.Status.OK, fileUrl);
    }
    
	private static String getMimeType(String url)
    {
        String type = null;
        String extension = MimeTypeMap.getFileExtensionFromUrl(url);
        if (extension != null) {
            MimeTypeMap mime = MimeTypeMap.getSingleton();
            type = mime.getMimeTypeFromExtension(extension);
        }
        return type;
    }
}
