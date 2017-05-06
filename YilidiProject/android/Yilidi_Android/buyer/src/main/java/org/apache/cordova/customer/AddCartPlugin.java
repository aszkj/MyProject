package org.apache.cordova.customer;

import android.os.Bundle;
import android.os.Message;
import com.yldbkd.www.buyer.android.activity.SpecialAreaActivity;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.fragment.SpecialAreaFragment;
import com.yldbkd.www.buyer.android.utils.Constants;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;

/**
 * 买家版加入购物车插件
 * <p/>
 * Created by linghuxj on 15/11/30.
 */
public class AddCartPlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (Constants.CordovaPlugin.ADD_CART.equals(action)) {
            SpecialAreaActivity activity = (SpecialAreaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            SpecialAreaFragment fragment = (SpecialAreaFragment) activity.getSupportFragmentManager()
                    .findFragmentByTag(SpecialAreaFragment.class.getSimpleName());
            if (fragment == null) {
                return false;
            }
            Message message = new Message();
            message.what = Constants.HandlerCode.SPECIAL_AREA_ADD;
            SaleProduct saleProduct = new SaleProduct();
            saleProduct.setSaleProductId(args.getInt(0));
            Integer stockNum = args.getInt(1);
            if (stockNum > 0) {
                saleProduct.setStockNum(stockNum);
            }
            saleProduct.setStockNum(args.getInt(2));
            Bundle bundle = new Bundle();
            bundle.putSerializable(Constants.BundleName.PRODUCT, saleProduct);
            bundle.putString(Constants.BundleName.PLUGIN_CALLBACK_ID, callbackContext.getCallbackId());
            message.setData(bundle);
            int[] position = new int[2];
            position[0] = args.getInt(3);
            position[1] = args.getInt(4);
            message.obj = position;
            fragment.getPluginHandler().sendMessage(message);
            PluginResult result = new PluginResult(PluginResult.Status.NO_RESULT);
            result.setKeepCallback(true);
            callbackContext.sendPluginResult(result);
            return true;
        }
        if (Constants.CordovaPlugin.REMOVE_CART.equals(action)) {
            SpecialAreaActivity activity = (SpecialAreaActivity) this.cordova.getActivity();
            if (activity == null) {
                return false;
            }
            SpecialAreaFragment fragment = (SpecialAreaFragment) activity.getSupportFragmentManager()
                    .findFragmentByTag(SpecialAreaFragment.class.getSimpleName());
            if (fragment == null) {
                return false;
            }
            Integer productId = args.getInt(0);
            fragment.getPluginHandler().obtainMessage(Constants.HandlerCode.SPECIAL_AREA_REMOVE, productId)
                    .sendToTarget();
            PluginResult result = new PluginResult(PluginResult.Status.OK, true);
            callbackContext.sendPluginResult(result);
            return true;
        }
        return false;
    }
}
