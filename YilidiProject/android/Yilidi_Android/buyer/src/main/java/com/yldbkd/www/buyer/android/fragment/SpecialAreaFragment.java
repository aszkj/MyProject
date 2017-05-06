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
import com.yldbkd.www.buyer.android.activity.MainActivity;
import com.yldbkd.www.buyer.android.activity.PurchaseActivity;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.bean.ZoneInfo;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.DisplayUtils;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.ConfigXmlParser;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaInterfaceImpl;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaPreferences;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CordovaWebViewImpl;
import org.apache.cordova.PluginEntry;
import org.apache.cordova.PluginResult;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * 专区页面H5的Fragment
 * <p/>
 * Created by linghuxj on 15/11/27.
 */
public class SpecialAreaFragment  extends Fragment implements CordovaInterface {

    private ZoneInfo area;
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
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Bundle bundle = getArguments();
        BuyerApp.getInstance().addLoading();
        if (bundle == null) {
            return;
        }
        area = (ZoneInfo) bundle.getSerializable(Constants.BundleName.SPECIAL_AREA);
    }

    protected void loadConfig() {
        ConfigXmlParser parser = new ConfigXmlParser();
        parser.parse(getActivity());
        preferences = parser.getPreferences();
        preferences.setPreferencesBundle(getActivity().getIntent().getExtras());
        launchUrl = parser.getLaunchUrl();
        pluginEntries = parser.getPluginEntries();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        cordovaInterface = new CordovaInterfaceImpl(getActivity());
        if (savedInstanceState != null) {
            cordovaInterface.restoreInstanceState(savedInstanceState);
        }

        LayoutInflater localInflater = inflater.cloneInContext(new CordovaContext(getActivity(), this));

        View rootView = localInflater.inflate(R.layout.special_area_fragment, container, false);
        initView(rootView);
        RelativeLayout webLayout = (RelativeLayout) rootView.findViewById(R.id.cordova_web_view);
        initWebView(webLayout);
        initListener();
        return rootView;
    }

    private void initView(View view) {
        headerView = (RelativeLayout) view.findViewById(R.id.header_view);
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(area.getSaleZoneName());
        cartBtn = (RelativeLayout) view.findViewById(R.id.cart_bottom_button);
        cartNumBg = (ImageView) view.findViewById(R.id.cart_bottom_num_bg);
        cartNumView = (TextView) view.findViewById(R.id.cart_bottom_num_view);
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
        webView.getCookieManager().setCookie(area.getSaleZoneAdvInfo().getImageUrl(), RetrofitUtils.getCookie());
        webView.loadUrl(area.getSaleZoneAdvInfo().getImageUrl());
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

    private void addCart(SaleProduct product, int[] checkPosition,
                         String callbackId) {
        boolean isSuccess = CartUtils.addCart(product);
        CallbackContext context = new CallbackContext(callbackId, webView);
        PluginResult result = new PluginResult(PluginResult.Status.OK, isSuccess);
        result.setKeepCallback(false);
        context.sendPluginResult(result);
        if (isSuccess) {
            //因页面传递过来的是对于屏幕的相对位移（单位像素），所以要对该地方进行头部的像素累加；
            checkPosition[0] = DisplayUtils.dp2px(getActivity(), checkPosition[0]);
            checkPosition[1] = DisplayUtils.dp2px(getActivity(), checkPosition[1]);
            checkPosition[1] += headerView.getLayoutParams().height;
            addCartAnim(checkPosition);
        }
    }

    private void remove(Integer productId) {
//        CartUtils.removeCart(productId);
        flushCart();
    }

    private void addCartAnim(int[] startLocation) {
        int[] endLocation = new int[2];
        cartNumView.getLocationInWindow(endLocation);
      // 这里需要BaseFragment，后续调整
      // AnimUtils.setAddCartAnim(getBaseActivity(), startLocation, endLocation, cartNumBg, cartNumView, cartBtn);
    }

    public Handler getPluginHandler() {
        return pluginHandler;
    }

    static class PluginHandler extends Handler {
        private WeakReference<SpecialAreaFragment> fragmentWeakReference;

        public PluginHandler(SpecialAreaFragment fragment) {
            this.fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            super.dispatchMessage(msg);
            SpecialAreaFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.SPECIAL_AREA_ADD:
                    SaleProduct product = (SaleProduct) msg.getData().getSerializable(Constants.BundleName.PRODUCT);
                    String callbackId = msg.getData().getString(Constants.BundleName.PLUGIN_CALLBACK_ID);
                    fragment.addCart(product,  (int[]) msg.obj, callbackId);
                    break;
                case Constants.HandlerCode.SPECIAL_AREA_REMOVE:
                    fragment.remove((int) msg.obj);
                    break;
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
        if (Constants.RequestCode.LOGIN_CODE == requestCode && requestCode == Activity.RESULT_OK) {
            Intent intent = new Intent(getActivity(), MainActivity.class);
            startActivity(intent);
        } else {
            CordovaPlugin callback = this.activityResultCallback;
            if (callback != null) {
                callback.onActivityResult(requestCode, resultCode, data);
            }
        }
    }

}
