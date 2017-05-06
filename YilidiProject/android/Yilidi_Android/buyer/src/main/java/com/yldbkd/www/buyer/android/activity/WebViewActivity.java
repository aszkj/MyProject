package com.yldbkd.www.buyer.android.activity;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.View;
import android.webkit.JsResult;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.WebUrl;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.buyer.android.utils.update.UpdateManager;

import java.util.HashMap;
import java.util.Map;

/**
 * 产品详情页面
 * <p/>
 * Created by linghuxj on 15/11/7.
 */
public class WebViewActivity extends BaseActivity {

    private String urlType;
    private RelativeLayout backView;
    private WebView webView;

    private HttpBack<WebUrl> webHttpBack;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.activity_web);
        urlType = getIntent().getStringExtra(Constants.BundleName.TYPE_AGREEMENT);
        initView();
        initHttpBack();
        request();
    }

    private void initHttpBack() {
        webHttpBack = new HttpBack<WebUrl>(this) {
            @Override
            public void onSuccess(WebUrl webUrl) {
                webView.loadUrl(webUrl.getValue());
            }
        };
    }

    @SuppressLint("SetJavaScriptEnabled")
    public void initView() {
        backView = (RelativeLayout) findViewById(R.id.back_view);
        TextView titleView = (TextView) findViewById(R.id.title_view);
        webView = (WebView) findViewById(R.id.wv_web);

        if (Constants.RuleAgreementType.JOIN.equals(urlType)) {
            titleView.setText(getText(R.string.profile_my_join));
        } else if (Constants.RuleAgreementType.NORMAL_ASK.equals(urlType)) {
            titleView.setText(getText(R.string.setting_question));
        } else if (Constants.RuleAgreementType.ABOUT_US.equals(urlType)) {
            titleView.setText(getText(R.string.setting_about_we));
        } else if (Constants.RuleAgreementType.SHARE_RULE.equals(urlType)) {
            titleView.setText(getText(R.string.share_rule_title));
        }

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
        map.put("typeCode", urlType);
        RetrofitUtils.getInstance(true).getRuleAgreementURL(ParamUtils.getParam(map), webHttpBack);
    }

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }
}
