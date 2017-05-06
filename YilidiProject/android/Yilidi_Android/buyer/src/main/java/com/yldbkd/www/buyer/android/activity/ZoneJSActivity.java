package com.yldbkd.www.buyer.android.activity;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.view.View;
import android.webkit.JavascriptInterface;
import android.webkit.JsResult;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.bean.WebUrl;
import com.yldbkd.www.buyer.android.fragment.CartFragment;
import com.yldbkd.www.buyer.android.fragment.LoginFragment;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.Logger;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.ZoneUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;

import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 专区页面H5的Fragment
 * <p/>
 * Created by linghuxj on 16/07/16.
 */
public class ZoneJSActivity extends BaseActivity {

    private WebView webView;

    private String urlType;

    private HttpBack<WebUrl> webHttpBack;

    private CartHandler cartHandler = new CartHandler(this);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.fragment_zone_js);
        urlType = getIntent().getStringExtra(Constants.BundleName.TYPE_AGREEMENT);
        setTitle();
        initHttpBack();
        initView();
    }

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }

    public void initHttpBack() {
        webHttpBack = new HttpBack<WebUrl>(this) {
            @Override
            public void onSuccess(WebUrl webUrl) {
                webView.loadUrl(webUrl.getValue());
            }
        };
    }

    @SuppressLint({"SetJavaScriptEnabled", "AddJavascriptInterface"})
    public void initView() {
        RelativeLayout backView = (RelativeLayout) findViewById(R.id.back_view);
        webView = (WebView) findViewById(R.id.zone_web_view);
        webView.setWebViewClient(new WebViewClient() {
            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
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

        webView.addJavascriptInterface(new JSObject(this, cartHandler), "cartObject");

        request();
        ZoneUtils.getZoneProducts();
    }

    private void request() {
        Map<String, Object> map = new HashMap<>();
        map.put("typeCode", urlType);
        RetrofitUtils.getInstance(true).getRuleAgreementURL(ParamUtils.getParam(map), webHttpBack);
    }

    private void setTitle() {
        TextView titleView = (TextView) findViewById(R.id.title_view);
        if (Constants.RuleAgreementType.VIP_ZONE.equals(urlType)) {
            titleView.setText(getText(R.string.zone_vip));
        } else if (Constants.RuleAgreementType.FEN_ZONE.equals(urlType)) {
            titleView.setText(getText(R.string.zone_new));
        }
    }

    private void addCartSuccess() {
        if (UserUtils.isLogin()) {
            Intent intent = new Intent(new Intent(this, PurchaseActivity.class));
            intent.setAction(CartFragment.class.getSimpleName());
            startActivity(intent);
        } else {
            Intent intent = new Intent(this, LoginActivity.class);
            intent.setAction(LoginFragment.class.getSimpleName());
            startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
        }
    }

    private String getParam() {
        Map<String, Object> map = new HashMap<>();
        map.put("zoneType", Constants.ZoneType.ZONE_VIP_TYPE);
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        return ParamUtils.getParamJson(map);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (Constants.RequestCode.LOGIN_CODE == requestCode && Activity.RESULT_OK == resultCode) {
            Intent intent = new Intent(new Intent(this, PurchaseActivity.class));
            intent.setAction(CartFragment.class.getSimpleName());
            startActivity(intent);
        }
    }

    class JSObject {

        private Context context;
        private Handler handler;

        public JSObject(Context context, Handler handler) {
            this.context = context;
            this.handler = handler;
        }

        @JavascriptInterface
        public void addFenToCart() {
            Logger.d("测试JS是否请求该方法：addFenToCart");
            List<SaleProduct> fenProducts = ZoneUtils.getZoneFen();
            if (fenProducts == null || fenProducts.size() == 0) {
                return;
            }
            CartUtils.validateOperationCart(context, fenProducts.get(0), handler, null);
        }

        @JavascriptInterface
        public void addVipToCart(@NonNull String barCode) {
            Logger.d("测试JS是否请求该方法：addVipToCart" + barCode);
            List<SaleProduct> vipProducts = ZoneUtils.getZoneVip();
            if (vipProducts == null) {
                return;
            }
            for (SaleProduct product : vipProducts) {
                if (barCode.equals(product.getBarCode())) {
                    CartUtils.validateOperationCart(context, product, handler, null);
                }
            }
        }

        @JavascriptInterface
        public void toVipHtml() {
            urlType = Constants.RuleAgreementType.VIP_ZONE;
            request();
            setTitle();
        }
    }

    private static class CartHandler extends Handler {
        WeakReference<ZoneJSActivity> fragmentWeakReference;

        public CartHandler(ZoneJSActivity fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            ZoneJSActivity fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.CART_SUCCESS:
                    fragment.addCartSuccess();
                    break;
            }
        }
    }
}
