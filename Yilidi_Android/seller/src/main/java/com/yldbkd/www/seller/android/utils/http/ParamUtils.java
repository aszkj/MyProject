package com.yldbkd.www.seller.android.utils.http;

import com.google.gson.Gson;
import com.yldbkd.www.seller.android.SellerApp;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.Logger;
import com.yldbkd.www.seller.android.utils.update.UpdateManager;
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
        Map<String, Object> contentMap = new HashMap<>();
        contentMap.put("key", SellerApp.getInstance().getJsonKey());
        contentMap.put("intfCallChannel", Constants.CHANNEL);
        contentMap.put("deviceId", SellerApp.getInstance().getDeviceId());
        contentMap.put("entity", map);
        contentMap.put("versionCode", UpdateManager.getUpdateManager().getCurrentVersionCode(
                SellerApp.getInstance().getApplicationContext()));
        Gson gson = new Gson();
        String json = gson.toJson(contentMap);
        Logger.d("请求参数：" + json);
        Logger.d("请求参数编码后：" + Base64Utils.base64Encode(json));
        return Base64Utils.base64Encode(json);
    }
}
