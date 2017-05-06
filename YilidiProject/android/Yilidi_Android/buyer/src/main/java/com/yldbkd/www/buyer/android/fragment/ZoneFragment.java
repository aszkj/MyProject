package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.activity.PurchaseActivity;
import com.yldbkd.www.buyer.android.utils.AnimUtils;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.DisplayUtils;

import org.apache.cordova.*;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * 专区页面H5的Fragment
 * <p/>
 * Created by linghuxj on 16/07/16.
 */
public class ZoneFragment extends Fragment implements CordovaInterface {

    private CordovaWebView webView;
    private RelativeLayout headerView;
    private RelativeLayout backView;
    private RelativeLayout cartBtn;
    private ImageView cartNumBg;
    private TextView cartNumView;

    // Read from config.xml:
    protected CordovaPreferences preferences;
    protected String launchUrl;
    protected ArrayList<PluginEntry> pluginEntries;
    protected CordovaInterfaceImpl cordovaInterface;

    private Handler pluginHandler = new PluginHandler(this);

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        cordovaInterface = new CordovaInterfaceImpl(getActivity());
        if (savedInstanceState != null) {
            cordovaInterface.restoreInstanceState(savedInstanceState);
        }

        LayoutInflater localInflater = inflater.cloneInContext(new CordovaContext(getActivity(), this));
        View rootView = localInflater.inflate(R.layout.fragment_zone, container, false);
        initView(rootView);
        RelativeLayout webLayout = (RelativeLayout) rootView.findViewById(R.id.rl_web_view);
        initWebView(webLayout);
        initListener();
        return rootView;
    }

    private void initView(View view) {
        headerView = (RelativeLayout) view.findViewById(R.id.header_view);
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);

    }

    private void initWebView(RelativeLayout webLayout) {
        loadConfig();
        webView = new CordovaWebViewImpl(CordovaWebViewImpl.createEngine(getActivity(), preferences));

        RelativeLayout.LayoutParams wvlp = new RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.MATCH_PARENT,
                RelativeLayout.LayoutParams.MATCH_PARENT);
        webView.getView().setLayoutParams(wvlp);

        if (!webView.isInitialized()) {
            webView.init(cordovaInterface, pluginEntries, preferences);
        }
        cordovaInterface.onCordovaInit(webView.getPluginManager());

        webLayout.addView(webView.getView());
//        webView.getCookieManager().setCookie(area.getAreaUrl(), RetrofitUtils.getCookie());
//        webView.loadUrl(area.getAreaUrl());
    }

    protected void loadConfig() {
        ConfigXmlParser parser = new ConfigXmlParser();
        parser.parse(getActivity());
        preferences = parser.getPreferences();
        preferences.setPreferencesBundle(getActivity().getIntent().getExtras());
        launchUrl = parser.getLaunchUrl();
        pluginEntries = parser.getPluginEntries();
    }

    private void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        cartBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent;
                if (UserUtils.isLogin()) {
                    intent = new Intent(getActivity(), PurchaseActivity.class);
                    intent.setAction(CartFragment.class.getSimpleName());
                    startActivity(intent);
                } else {
                    intent = new Intent(getActivity(), LoginActivity.class);
                    intent.setAction(LoginFragment.class.getSimpleName());
                    startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
                }
            }
        });
    }

    @Override
    public void onResume() {
        super.onResume();
        flushCart();
    }

    private void flushCart() {
        Integer count = CartUtils.getCartCount();
        if (count > 0) {
            cartBtn.setBackgroundResource(R.drawable.cart_full_selector);
            cartNumBg.setVisibility(View.VISIBLE);
            cartNumView.setVisibility(View.VISIBLE);
            if (count > 99) {
                cartNumView.setText("99+");
                cartNumView.setTextSize(5f);
            } else {
                cartNumView.setText(String.valueOf(count));
                cartNumView.setTextSize(10f);
            }
        } else {
            cartBtn.setBackgroundResource(R.drawable.cart_none_selector);
            cartNumBg.setVisibility(View.INVISIBLE);
            cartNumView.setVisibility(View.INVISIBLE);
        }
    }

    private void addCart(Integer productId, Integer stockNum, Integer limitCount, int[] checkPosition,
                         String callbackId) {
        boolean isSuccess = false;//CartUtils.addCart(getActivity(), productId, stockNum, limitCount);
        CallbackContext context = new CallbackContext(callbackId, webView);
        PluginResult result = new PluginResult(PluginResult.Status.OK, isSuccess);
        result.setKeepCallback(false);
        context.sendPluginResult(result);
        if (isSuccess) {
            //因页面传递过来的是对于屏幕的相对位移（单位像素），所以要对该地方进行头部的像素累加；
            checkPosition[0] = DisplayUtils.dp2px(getActivity(), checkPosition[0]);
            checkPosition[1] = DisplayUtils.dp2px(getActivity(), checkPosition[1]);
            checkPosition[1] += headerView.getLayoutParams().height;
        }
    }

    public Handler getPluginHandler() {
        return pluginHandler;
    }

    static class PluginHandler extends Handler {
        private WeakReference<ZoneFragment> fragmentWeakReference;

        public PluginHandler(ZoneFragment fragment) {
            this.fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            super.dispatchMessage(msg);
            ZoneFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {

            }
        }
    }

    private class CordovaContext extends ContextWrapper implements CordovaInterface {

        CordovaInterface cordova;

        public CordovaContext(Context context, CordovaInterface cordova) {
            super(context);
            this.cordova = cordova;
        }

        public void startActivityForResult(CordovaPlugin command, Intent intent, int requestCode) {
            cordova.startActivityForResult(command, intent, requestCode);
        }

        public void setActivityResultCallback(CordovaPlugin plugin) {
            cordova.setActivityResultCallback(plugin);
        }

        public Activity getActivity() {
            return cordova.getActivity();
        }

        public Object onMessage(String id, Object data) {
            return cordova.onMessage(id, data);
        }

        public ExecutorService getThreadPool() {
            return cordova.getThreadPool();
        }
    }

    // Plugin to call when activity result is received
    protected CordovaPlugin activityResultCallback = null;
    protected boolean activityResultKeepRunning;

    // Keep app running when pause is received. (default = true)
    // If true, then the JavaScript and native code continue to run in the background
    // when another application (activity) is started.
    protected boolean keepRunning = true;

    private final ExecutorService threadPool = Executors.newCachedThreadPool();

    public Object onMessage(String id, Object data) {
        return null;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (webView.getPluginManager() != null) {
            webView.getPluginManager().onDestroy();
        }
        BuyerApp.getInstance().removeLoading();
    }

    @Override
    public ExecutorService getThreadPool() {
        return threadPool;
    }

    @Override
    public void setActivityResultCallback(CordovaPlugin plugin) {
        this.activityResultCallback = plugin;
    }

    public void startActivityForResult(CordovaPlugin command, Intent intent, int requestCode) {
        this.activityResultCallback = command;
        this.activityResultKeepRunning = this.keepRunning;

        // If multitasking turned on, then disable it for activities that return results
        if (command != null) {
            this.keepRunning = false;
        }

        // Start activity
        super.startActivityForResult(intent, requestCode);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
//        if (Constants.RequestCode.LOGIN_CODE == requestCode && requestCode == Activity.RESULT_OK) {
//            Intent intent = new Intent(getActivity(), MainActivity.class);
//            startActivity(intent);
//        } else {
        CordovaPlugin callback = this.activityResultCallback;
        if (callback != null) {
            callback.onActivityResult(requestCode, resultCode, data);
        }
//        }
    }

}
