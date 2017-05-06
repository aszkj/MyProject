package org.apache.cordova.customer;

import android.os.Message;

import com.yldbkd.www.buyer.android.activity.H5CordovaActivity;
import com.yldbkd.www.buyer.android.utils.Constants;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

/**
 * 买家版购物车操作插件
 * <p/>
 * Created by linghuxj on 15/11/30.
 */
public class ProductCartPlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (Constants.CordovaPlugin.PRODUCTCARTADDPRODUCTBYFEN.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                //                callbackContext.error("");
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_ADD_CART_FEN;
            message.obj = args.get(0).toString();//json字符串
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.PRODUCTCARTADDPRODUCTBYBARCODE.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_ADD_CART_BAR_CODE;
            message.obj = args.get(0).toString();//json字符串
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.PRODUCTCARTADDTOCART.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_ADD_PRODUCT_CART;
            message.obj = args.get(0).toString();//json字符串
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.PRODUCTCARTREMOVETOCART.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_REMOVE_PRODUCT_CART;
            message.obj = args.get(0).toString();//json字符串
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.PRODUCTCARTBUYATONCE.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_BUY_AT_ONCE;
            message.obj = args.get(0).toString();//json字符串
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        if (Constants.CordovaPlugin.PRODUCTCARTCLEARCART.equals(action)) {
            H5CordovaActivity activity = (H5CordovaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.CORDOVA_CLEAN_CART;
            activity.getSharePluginHandler().sendMessage(message);
            return true;
        }
        return false;
    }
}
