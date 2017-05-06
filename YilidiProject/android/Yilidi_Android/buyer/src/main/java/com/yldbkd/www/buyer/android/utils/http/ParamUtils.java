package com.yldbkd.www.buyer.android.utils.http;

import com.google.gson.Gson;
import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.Logger;
import com.yldbkd.www.buyer.android.utils.update.UpdateManager;
import com.yldbkd.www.library.android.common.Base64Utils;

import java.util.HashMap;
import java.util.Map;

/**
 * 请求参数封装工具类工具类
 * <p/>
 * Created by linghuxj on 15/10/9.
 */
public class ParamUtils {

    public static String getParam(Map<String, Object> map) {
        String json = getParamJson(map);
        Logger.d("请求参数：" + json);
        Logger.d("请求参数编码后：" + Base64Utils.base64Encode(json));
        return Base64Utils.base64Encode(json);
    }

    public static String getParamJson(Map<String, Object> map) {
        Map<String, Object> contentMap = new HashMap<>();
        contentMap.put("key", BuyerApp.getInstance().getJsonKey());
        contentMap.put("intfCallChannel", Constants.CHANNEL);
        contentMap.put("deviceId", BuyerApp.getInstance().getDeviceId());
        contentMap.put("entity", map == null ? null : map);
        contentMap.put("versionCode", UpdateManager.getUpdateManager().getCurrentVersionCode(
                BuyerApp.getInstance().getApplicationContext()));
        Gson gson = new Gson();
        return gson.toJson(contentMap);
    }
}
