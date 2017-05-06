package com.yldbkd.www.seller.android.utils.http;

import android.content.Context;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.yldbkd.www.seller.android.SellerApp;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.utils.Logger;
import com.yldbkd.www.seller.android.utils.UserUtils;
import com.yldbkd.www.seller.android.utils.update.UpdateManager;
import com.yldbkd.www.library.android.bean.MsgBean;
import com.yldbkd.www.library.android.common.Base64Utils;
import com.yldbkd.www.library.android.common.ToastUtils;

import org.json.JSONException;
import org.json.JSONObject;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

import retrofit.Callback;
import retrofit.RetrofitError;
import retrofit.client.Response;

/**
 * 请求返回数据统一处理，其他实现需继承该类
 * <p/>
 * Created by linghuxj on 15/10/8.
 */
public abstract class HttpBack<T> implements Callback<CallbackBean> {

    private Context context = SellerApp.getInstance().getBaseContext();

    @Override
    public void success(CallbackBean callbackBean, Response response) {
        MsgBean<T> msgBean = getMsg(callbackBean);
        Logger.d("请求的Url地址信息：" + response.getUrl());
        Logger.d("请求返回成功的接口数据：" + new Gson().toJson(msgBean));
        if (msgBean == null) {
            return;
        }
        switch (msgBean.getMsgCode()) {
            case MsgBean.SUCCESS:
                onSuccess(msgBean.getEntity());
                break;
            case MsgBean.NOLOGIN:
                onNoLogin();
                break;
            case MsgBean.UPDATE:
                UpdateManager.getUpdateManager().checkAppUpdate(context, null);
                break;
            case MsgBean.FAILURE:
            default:
                onFailure(msgBean.getMsg());
                break;
        }
    }

    @Override
    public void failure(RetrofitError error) {
        Logger.d("请求的Url地址信息：" + error.getUrl());
        Logger.e("网络请求失败，失败信息：" + error.getKind() + " - " + error.getMessage());
        SellerApp.getInstance().removeLoading();
        switch (error.getKind()) {
            case NETWORK:
                onTimeOut();
                break;
            case CONVERSION:
            case HTTP:
            case UNEXPECTED:
            default:
                onFailure(null);
                break;
        }
    }

    /**
     * 请求成功必须继承
     *
     * @param t 返回的实体数据
     */
    public abstract void onSuccess(T t);

    /**
     * 请求失败时默认调用，可重写
     */
    public void onFailure(String msg) {
        if (msg == null) {
            ToastUtils.show(context, R.string.http_failure);
        } else {
            ToastUtils.show(context, msg);
        }
    }

    public void onNoLogin() {
        UserUtils.clearLoginInfo();
    }

    public void onTimeOut() {
        ToastUtils.show(context, R.string.http_time_out);
    }

    public void onException() {
        ToastUtils.showShort(context, R.string.http_exception);
    }

    private MsgBean<T> getMsg(CallbackBean callbackBean) {
        String response = Base64Utils.base64Decode(callbackBean.getResult());
        Logger.d("请求返回的数据Json：" + response);
        Gson gson = new Gson();
        Type msgType = new TypeToken<MsgBean<T>>() {
        }.getType();
        MsgBean<T> msgBean = gson.fromJson(response, msgType);
//        if (!SellerApp.getInstance().getJsonKey().equals(msgBean.getKey())) {
//            ToastUtils.show(context, R.string.http_own_response);
//            return null;
//        }
        try {
            JSONObject jsonObject = new JSONObject(response);
            if (jsonObject.get("entity") == JSONObject.NULL) {
                msgBean.setEntity(null);
            } else {
                String entityStr = jsonObject.getString("entity");
                T entity = msgBean.getEntity();
                T outEntityBean;
                if (entity instanceof String) {
                    outEntityBean = (T) entityStr;
                } else {
                    Type genType = getClass().getGenericSuperclass();
                    Type[] params = ((ParameterizedType) genType).getActualTypeArguments();
                    outEntityBean = gson.fromJson(entityStr, params[0]);
                }
                msgBean.setEntity(outEntityBean);
            }
        } catch (JSONException e) {
            Logger.e("系统发生数据转换异常：" + e);
        }
        return msgBean;
    }
}
