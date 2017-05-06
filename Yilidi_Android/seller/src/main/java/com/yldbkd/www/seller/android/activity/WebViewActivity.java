package com.yldbkd.www.seller.android.activity;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.View;
import android.webkit.JsResult;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.WebUrl;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;
import com.yldbkd.www.seller.android.utils.update.UpdateManager;

import java.util.HashMap;
import java.util.Map;

/**
 * 产品详情页面
 * <p/>
 * Created by linghuxj on 15/11/7.
 */
public class WebViewActivity extends BaseActivity {

    private Integer urlType;
    private String title;

    private LinearLayout backView;
    private WebView webView;

    private HttpBack<WebUrl> webHttpBack;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.activity_web);
        urlType = getIntent().getIntExtra(Constants.BundleName.WEB_URL, 1);
        title = getIntent().getStringExtra(Constants.BundleName.TITLE);
        initView();
        webHttpBack = new HttpBack<WebUrl>() {
            @Override
            public void onSuccess(WebUrl webUrl) {
                webView.loadUrl(webUrl.getValue());
            }
        };
        request();
    }

    @SuppressLint("SetJavaScriptEnabled")
    public void initView() {
        backView = (LinearLayout) findViewById(R.id.ll_back);
        TextView titleView = (TextView) findViewById(R.id.tv_title);
        titleView.setText(title);

        webView = (WebView) findViewById(R.id.wv_web);

        final String versionName = UpdateManager.getUpdateManager().getCurrentVersionName(this);
        webView.setWebViewClient(new WebViewClient() {
            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
                webView.loadUrl("javascript:getVersionCode('" + String.format(getString(R.string.profile_version_name),
                        versionName) + "');");
            }
        });
        webView.setWebChromeClient(new WebChromeClient() {
            @Override
            public boolean onJsAlert(WebView view, String url, String message, JsResult result) {
                return super.onJsAlert(view, url, message, result);
            }

        });
        WebSettings settings = webView.getSettings();
        settings.setSupportZoom(false);
        settings.setJavaScriptEnabled(true);
        settings.setBuiltInZoomControls(false);
        settings.setDisplayZoomControls(false);

        webView.setHorizontalScrollBarEnabled(false);
        webView.setVerticalScrollBarEnabled(false);

        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });
    }

    private void request() {
        Map<String, Object> map = new HashMap<>();
        map.put("type", urlType);
        RetrofitUtils.getInstance(true).helpAddress(ParamUtils.getParam(map), webHttpBack);
    }

    @Override
    Fragment newFragmentByTag(String tag) {
        return null;
    }
}
