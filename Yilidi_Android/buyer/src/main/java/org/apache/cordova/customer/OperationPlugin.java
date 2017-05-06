package org.apache.cordova.customer;

import android.os.Message;

import com.yldbkd.www.buyer.android.activity.H5CordovaActivity;
import com.yldbkd.www.buyer.android.utils.Constants;

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
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.OPERATIONTOCARTPAGE.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_TO_CART_PAGE;
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.OPERATIONTOLOGINPAGE.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_TO_LOGIN_PAGE;
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.OPERATIONTOORDERLISTPAGE.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_TO_ORDER_LIST_PAGE;
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.OPERATIONTOORDERDETAILPAGE.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_TO_ORDER_DETAIL_PAGE;
            message.obj = args.getString(0);
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.OPERATIONTOCLASSPAGE.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_TO_CLASS_PAGE;
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.OPERATIONTOBRANDPAGE.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_TO_BRAND_PAGE;
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.OPERATIONTOREDIRECTPAGE.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_TO_REDIRECTPAGE;
            message.obj = args.getString(0);
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        return false;
    }
}
