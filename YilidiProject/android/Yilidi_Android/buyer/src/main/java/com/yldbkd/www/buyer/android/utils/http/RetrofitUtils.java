package com.yldbkd.www.buyer.android.utils.http;


import android.text.TextUtils;

import com.squareup.okhttp.Interceptor;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;
import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.utils.Logger;
import com.yldbkd.www.buyer.android.utils.PreferenceName;
import com.yldbkd.www.library.android.common.PreferenceUtils;

import java.io.IOException;
import java.net.CookieManager;
import java.net.CookiePolicy;
import java.util.concurrent.TimeUnit;

import retrofit.Profiler;
import retrofit.RestAdapter;
import retrofit.client.OkClient;

/**
 * 网络请求工具类
 * <p/>
 * Created by linghuxj on 15/9/23.
 */
public class RetrofitUtils {

    private static RestAdapter restAdapter;

    private static RestAdapter restLoadAdapter;

    private static CookieManager cookieManager;

    private static final String IDENTITY = "YiLiDiSessionID";

    static {
        cookieManager = new CookieManager();
        cookieManager.setCookiePolicy(CookiePolicy.ACCEPT_ALL);
    }

    private RetrofitUtils() {
    }

    public static HttpService getInstance() {
        return getInstance(false);
    }

    public static HttpService getInstance(boolean isLoading) {
        if (isLoading) {
            return getLoadInstance();
        }
        if (restAdapter == null) {
            synchronized (RetrofitUtils.class) {
                if (restAdapter == null) {
                    RestAdapter.Builder builder = new RestAdapter.Builder();
                    builder.setEndpoint(BuyerApp.getInstance().getDomain());
                    builder.setLogLevel(BuyerApp.getInstance().isDebug() ? RestAdapter.LogLevel.FULL : RestAdapter.LogLevel.NONE);
                    builder.setClient(getClient());
                    restAdapter = builder.build();
                }
            }
        }
        return restAdapter.create(HttpService.class);
    }

    public static HttpService getLoadInstance() {
        if (restLoadAdapter == null) {
            synchronized (RetrofitUtils.class) {
                if (restLoadAdapter == null) {
                    RestAdapter.Builder builder = new RestAdapter.Builder();
                    builder.setEndpoint(BuyerApp.getInstance().getDomain());
                    builder.setLogLevel(BuyerApp.getInstance().isDebug() ? RestAdapter.LogLevel.FULL : RestAdapter.LogLevel.NONE);
                    builder.setClient(getClient());

                    UrlRequestProfiler profiler = new UrlRequestProfiler(true);
                    builder.setProfiler(profiler);
                    restLoadAdapter = builder.build();
                }
            }
        }
        return restLoadAdapter.create(HttpService.class);
    }

    private static OkClient getClient() {
        OkHttpClient client = new OkHttpClient();
        client.setCookieHandler(cookieManager);
        client.setConnectTimeout(10, TimeUnit.SECONDS);
        client.setReadTimeout(30, TimeUnit.SECONDS);
        client.interceptors().add(new AddCookiesInterceptor());
        client.interceptors().add(new ReceivedCookiesInterceptor());
        return new OkClient(client);
    }

    public static class UrlRequestProfiler implements Profiler<Boolean> {

        private boolean isLoading;

        public UrlRequestProfiler(boolean isLoading) {
            this.isLoading = isLoading;
        }

        @Override
        public Boolean beforeCall() {
            if (isLoading) {
                BuyerApp.getInstance().addLoading();
            }
            return isLoading;
        }

        @Override
        public void afterCall(RequestInformation requestInfo, long elapsedTime, int statusCode, Boolean beforeCallData) {
            if (beforeCallData) {
                BuyerApp.getInstance().removeLoading();
            }
        }
    }

    public static class AddCookiesInterceptor implements Interceptor {
        @Override
        public Response intercept(Chain chain) throws IOException {
            Request.Builder builder = chain.request().newBuilder();
            String preferences = getCookie();
            Logger.d("测试当前请求Cookie数据：" + preferences);
            if (!TextUtils.isEmpty(preferences)) {
                builder.addHeader("Cookie", preferences);
            }
            return chain.proceed(builder.build());
        }
    }

    public static class ReceivedCookiesInterceptor implements Interceptor {
        @Override
        public Response intercept(Chain chain) throws IOException {
            Response originalResponse = chain.proceed(chain.request());
            if (!originalResponse.headers("Set-Cookie").isEmpty()) {
                for (String header : originalResponse.headers("Set-Cookie")) {
                    if (header.startsWith(IDENTITY)) {
                        setCookie(header);
                    }
                    Logger.d("测试当前返回Cookie数据：" + header);
                }
            }
            return originalResponse;
        }
    }

    public static String getCookie() {
        BuyerApp app = BuyerApp.getInstance();
        if (TextUtils.isEmpty(app.sessionId)) {
            app.sessionId = PreferenceUtils.getStringPref(app.getApplicationContext(), PreferenceName.PREF_COOKIES, null);
        }
        return app.sessionId;
    }

    public static void setCookie(String sessionId) {
        BuyerApp app = BuyerApp.getInstance();
        if (sessionId.equals(app.sessionId)) {
            return;
        }
        app.sessionId = sessionId;
        PreferenceUtils.setStringPref(app.getApplicationContext(), PreferenceName.PREF_COOKIES, sessionId);
    }
}
