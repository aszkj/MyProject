package com.yldbkd.www.seller.android.activity;

import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.text.TextUtils;
import android.webkit.JsResult;
import android.webkit.WebView;

import com.google.gson.Gson;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.WebUrl;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;
import com.yldbkd.www.seller.android.utils.update.UpdateManager;

import org.apache.cordova.ConfigXmlParser;
import org.apache.cordova.CordovaInterfaceImpl;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CordovaWebViewImpl;
import org.apache.cordova.engine.SystemWebChromeClient;
import org.apache.cordova.engine.SystemWebView;
import org.apache.cordova.engine.SystemWebViewClient;
import org.apache.cordova.engine.SystemWebViewEngine;

import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2016/11/16 14:39
 * @描述 h5界面
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class H5CordovaActivity extends BaseActivity {
    private SystemWebView webView;
    private HttpBack<WebUrl> webHttpBack;
    private Integer h5Type;
    private String h5URL;
    private Gson gson;
    private SystemWebViewEngine mSystemWebViewEngine;
    private Handler pluginHandler = new PluginHandler(this);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.h5_activity);
        h5Type = getIntent().getIntExtra(Constants.BundleName.WEB_URL, Constants.URL_TYPE.ABOUT_US);
        h5URL = getIntent().getStringExtra(Constants.BundleName.H5URL);

        initHttpBack();
        initView();
        initData();
        initListener();
    }

    private void initData() {
        gson = new Gson();
    }

    private void initView() {
        webView = (SystemWebView) findViewById(R.id.h5_web_view);
        setWebViewInfo();
        if (TextUtils.isEmpty(h5URL)) {
            request();
        } else {
            webView.loadUrl(h5URL + "?intfCallChannel=android");
        }
    }

    private void sendDataToHtmlJs() {
        webView.loadUrl("javascript:corVersionCode('" + String.format(getString(R.string.profile_version_name),
                UpdateManager.getUpdateManager().getCurrentVersionName(this)) + "');");
    }

    private void setWebViewInfo() {//监听js方法
        ConfigXmlParser parser = new ConfigXmlParser();
        parser.parse(this);//这里会解析res/xml/config.xml配置文件
        mSystemWebViewEngine = new SystemWebViewEngine(webView);
        CordovaWebView cordovaWebView = new CordovaWebViewImpl(mSystemWebViewEngine);//创建一个cordovawebview
        cordovaWebView.init(new CordovaInterfaceImpl(this), parser.getPluginEntries(), parser.getPreferences());//初始化
    }

    private void request() {
        Map<String, Object> map = new HashMap<>();
        map.put("type", h5Type);
        RetrofitUtils.getInstance(true).helpAddress(ParamUtils.getParam(map), webHttpBack);
    }

    private void initListener() {
        webView.setWebViewClient(new SystemWebViewClient(mSystemWebViewEngine) {
            @Override
            public void onPageStarted(WebView view, String url, Bitmap favicon) {
                super.onPageStarted(view, url, favicon);
            }

            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
                //调用html js
                sendDataToHtmlJs();
            }
        });
        webView.setWebChromeClient(new SystemWebChromeClient(mSystemWebViewEngine) {
            @Override
            public boolean onJsAlert(WebView view, String url, String message, JsResult result) {
                return super.onJsAlert(view, url, message, result);
            }
        });
    }


    public void initHttpBack() {
        webHttpBack = new HttpBack<WebUrl>() {
            @Override
            public void onSuccess(WebUrl webUrl) {
                webView.loadUrl(webUrl.getAndroidValue());
            }
        };
    }

    public Handler getPluginHandler() {
        return pluginHandler;
    }

    static class PluginHandler extends Handler {
        private WeakReference<H5CordovaActivity> fragmentWeakReference;

        public PluginHandler(H5CordovaActivity activity) {
            this.fragmentWeakReference = new WeakReference<>(activity);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            super.dispatchMessage(msg);
            H5CordovaActivity activity = fragmentWeakReference.get();
            if (activity == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.CORDOVA_BACK:
                    activity.onBackPressed();
                    break;
            }
        }
    }

    private void toH5Page(String url) {
        if (TextUtils.isEmpty(url)) {
            return;
        }
        webView.loadUrl(url + "?intfCallChannel=android");
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        finish();
    }

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }
}
