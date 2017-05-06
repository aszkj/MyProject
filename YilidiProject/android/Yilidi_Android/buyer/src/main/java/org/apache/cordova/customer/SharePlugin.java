package org.apache.cordova.customer;

import android.os.Message;

import com.yldbkd.www.buyer.android.activity.H5CordovaActivity;
import com.yldbkd.www.buyer.android.utils.Constants;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

/**
 * 分享页面操作
 * <p/>
 * Created by lizhg on 16/12/10.
 */
public class SharePlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (Constants.CordovaPlugin.SHARETOALL.equals(action)) {//弹出分享Menu
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                //                callbackContext.error("");
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.SHARE_MENU;
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.SHARETOFRIEND.equals(action)) {//分享好友
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.SHARE_WECHAT;
            activity.getSharePluginHandler().sendMessage(message);
            //            callbackContext.success("");
            return true;
        }
        if (Constants.CordovaPlugin.SHARETOMOMENT.equals(action)) {//分享朋友圈
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.SHARE_WECIRCLE;
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.SHARESMS.equals(action)) {//短信分享
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.SHARE_SMS;
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        return false;
    }
}
