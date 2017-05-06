package org.apache.cordova.customer;

import android.os.Message;

import com.yldbkd.www.seller.android.activity.H5CordovaActivity;
import com.yldbkd.www.seller.android.utils.Constants;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

/**
 * cordova操作
 * <p/>
 * Created by lizhg on 16/12/10.
 */
public class OperationPlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (Constants.CordovaPlugin.OPERATIONBACK.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_BACK;
            activity.getPluginHandler().sendMessage(message);
            return true;
        }
        return false;
    }
}
