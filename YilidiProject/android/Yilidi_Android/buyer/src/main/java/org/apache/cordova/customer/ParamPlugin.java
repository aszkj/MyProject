package org.apache.cordova.customer;

import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;

/**
 * 参数获取插件
 * <p/>
 * Created by linghuxj on 15/12/8.
 */
public class ParamPlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        HashMap<String, Object> map = null;
        if (Constants.CordovaPlugin.PARAM.equals(action)) {
            JSONObject param = args.getJSONObject(0);
            Iterator<String> iterator = param.keys();
            while (iterator.hasNext()) {
                String key = iterator.next();
                Object value = param.get(key);
                if (map == null) {
                    map = new HashMap<>();
                }
                map.put(key, value);
            }
            callbackContext.success("param=" + ParamUtils.getParam(map));
            return true;
        }
        if (Constants.CordovaPlugin.LOCATION_PARAM.equals(action)) {
            map = new HashMap<>();
            map.put("storeId", CommunityUtils.getCurrentStoreId());
            map.put("latitude", CommunityUtils.getLatitude());
            map.put("longitude", CommunityUtils.getLongitude());
            callbackContext.success("param=" + ParamUtils.getParam(map));
            return true;
        }
        if (Constants.CordovaPlugin.CANCEL_LOADING.equals(action)) {
            BuyerApp.getInstance().removeLoading();
            return true;
        }
        return false;
    }
}
