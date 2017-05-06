package com.yldbkd.www.buyer.android.activity;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.webkit.JsResult;
import android.webkit.WebView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.google.gson.Gson;
import com.tencent.mm.sdk.modelmsg.SendMessageToWX;
import com.tencent.mm.sdk.modelmsg.WXImageObject;
import com.tencent.mm.sdk.modelmsg.WXMediaMessage;
import com.tencent.mm.sdk.modelmsg.WXWebpageObject;
import com.tencent.mm.sdk.openapi.WXAPIFactory;
import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.SMSContent;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.bean.WEChat;
import com.yldbkd.www.buyer.android.bean.WECircle;
import com.yldbkd.www.buyer.android.bean.WebUrl;
import com.yldbkd.www.buyer.android.fragment.BrandClassityFragment;
import com.yldbkd.www.buyer.android.fragment.CartFragment;
import com.yldbkd.www.buyer.android.fragment.LoginFragment;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.LocationUtils;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.ZoneUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.buyer.android.utils.update.UpdateManager;
import com.yldbkd.www.library.android.common.ToastUtils;

import org.apache.cordova.ConfigXmlParser;
import org.apache.cordova.CordovaInterfaceImpl;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CordovaWebViewImpl;
import org.apache.cordova.engine.SystemWebChromeClient;
import org.apache.cordova.engine.SystemWebView;
import org.apache.cordova.engine.SystemWebViewClient;
import org.apache.cordova.engine.SystemWebViewEngine;

import java.io.IOException;
import java.lang.ref.WeakReference;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import retrofit.RetrofitError;

/**
 * @创建者 李贞高
 * @创建时间 2016/11/16 14:39
 * @描述 h5界面
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class H5CordovaActivity extends BaseActivity {
    private static int WXFLAG = 0;
    private static int WXFRIENDFLAG = 1;
    private static int IMAGEWIDTH = 150;
    private static int IMAGEHEIGHT = 150;
    private SystemWebView webView;
    private HttpBack<WebUrl> webHttpBack;
    private HttpBack<SMSContent> smsHttpBack;
    private HttpBack<WEChat> weChatHttpBack;
    private HttpBack<WECircle> weCircleHttpBack;
    private View popupView;
    private TextView mWeiXinText;
    private TextView mWeiXinCircleText;
    private TextView mMessageText;
    private PopupWindow mPopupWindow;
    private Handler sharePluginHandler = new SharePluginHandler(this);
    private String h5Type;
    private String h5URL;
    private CartHandler cartHandler = new CartHandler(this);
    private Gson gson;
    private LocationUtils location = LocationUtils.getInstance();
    private double mLatitude;
    private double mLongitude;
    private SystemWebViewEngine mSystemWebViewEngine;

    //购物车
    private LinearLayout cartBtn;
    private TextView cartNumView;
    private ImageView cartNumBg;
    private boolean isToCart = true;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.cordova_activity);
        h5Type = getIntent().getStringExtra(Constants.BundleName.TYPE_AGREEMENT);
        h5URL = getIntent().getStringExtra(Constants.BundleName.H5URL);

        initHttpBack();
        initView();
        initData();
        initListener();
    }

    private void initData() {
        if (BuyerApp.iwxapi == null) {
            BuyerApp.iwxapi = WXAPIFactory.createWXAPI(this, Constants.WX_APP_ID, true);
            BuyerApp.iwxapi.registerApp(Constants.WX_APP_ID);
        }
        gson = new Gson();
        //定位
        location.init(this);
        location.registerLocationListener(new LocationListener());

        if (Constants.RuleAgreementType.VIP_ZONE.equals(h5Type) || Constants.RuleAgreementType.FEN_ZONE.equals(h5Type)) {
            ZoneUtils.getZoneProducts();
        }
    }

    private void initView() {
        webView = (SystemWebView) findViewById(R.id.share_web_view);
        setWebViewInfo();
        if (TextUtils.isEmpty(h5URL)) {
            request();
        } else {
            webView.loadUrl(h5URL + "?intfCallChannel=android");
        }

        //购物车
        cartBtn = (LinearLayout) findViewById(R.id.cart_layout);
        cartNumBg = (ImageView) findViewById(R.id.cart_bottom_num_bg);
        cartNumView = (TextView) findViewById(R.id.cart_bottom_num_view);
    }

    private void sendDataToHtmlJs() {
        Map<String, Object> careInfoMap = new HashMap<>();
        careInfoMap.put("cartInfo", CartUtils.getCartInfo());
        webView.loadUrl("javascript:corCartInfo('" + gson.toJson(careInfoMap) + "');");

        Map<String, Object> userInfoMap = new HashMap<>();
        userInfoMap.put("userName", UserUtils.getUserName());
        userInfoMap.put("vipExpireDate", UserUtils.getExpireDate());
        userInfoMap.put("memberType", UserUtils.getMemberType());
        userInfoMap.put("userImageUrl", UserUtils.getUserIamgeUrl());
        webView.loadUrl("javascript:corUserInfo('" + gson.toJson(userInfoMap) + "');");

        String sessionId = "";
        if (!TextUtils.isEmpty(BuyerApp.getInstance().sessionId)) {
            sessionId = getSessionId(BuyerApp.getInstance().sessionId);
        }
        webView.loadUrl("javascript:corUserSessionId('" + sessionId + "');");

        Map<String, Object> communityMap = new HashMap<>();
        communityMap.put("communityId", CommunityUtils.getCurrentCommunityId());
        communityMap.put("communityName", CommunityUtils.getCurrentCommunityName());
        webView.loadUrl("javascript:corCommunityInfo('" + gson.toJson(communityMap) + "');");

        Map<String, Object> storeMap = new HashMap<>();
        storeMap.put("storeId", CommunityUtils.getCurrentStoreId());
        storeMap.put("storeStatus", CommunityUtils.getCurrentStoreStatus());
        webView.loadUrl("javascript:corStoreInfo('" + gson.toJson(storeMap) + "');");

        Map<String, Object> localMap = new HashMap<>();
        localMap.put("latitude", mLatitude);
        localMap.put("longitude", mLongitude);
        webView.loadUrl("javascript:corLocationInfo('" + gson.toJson(localMap) + "');");

        webView.loadUrl("javascript:corVersionCode('" + String.format(getString(R.string.profile_version_name),
                UpdateManager.getUpdateManager().getCurrentVersionName(this)) + "');");
    }

    private String getSessionId(String sessionIdInfo) {
        String[] split = sessionIdInfo.split(";");
        if (split[0].contains("=")) {
            return split[0].split("=")[1];
        } else {
            return split[0];
        }
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
        map.put("typeCode", h5Type);
        RetrofitUtils.getInstance(true).getRuleAgreementURL(ParamUtils.getParam(map), webHttpBack);
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

        cartBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (UserUtils.isLogin()) {
                    gotoCartFragment(H5CordovaActivity.this);
                } else {
                    gotoLoginFragment(H5CordovaActivity.this);
                }
            }
        });

    }

    private void smsRequest() {
        Map<String, Object> map = new HashMap<>();
        RetrofitUtils.getInstance(true).shareSms(ParamUtils.getParam(map), smsHttpBack);
    }

    private void weChatRequest() {
        Map<String, Object> map = new HashMap<>();
        RetrofitUtils.getInstance(true).shareWEChat(ParamUtils.getParam(map), weChatHttpBack);
    }

    private void weCirclerequest() {
        Map<String, Object> map = new HashMap<>();
        RetrofitUtils.getInstance(true).shareWECircle(ParamUtils.getParam(map), weCircleHttpBack);
    }

    private void messageFunction(String content) {
        Uri smsToUri = Uri.parse("smsto:");
        Intent intent = new Intent(Intent.ACTION_SENDTO, smsToUri);
        intent.putExtra("sms_body", content);
        startActivity(intent);
    }

    private void ShareFunction(final int flag, final WEChat weChat) {//分享网页
        if (checkedIsHasWeiXin()) {
            return;
        }
        WXWebpageObject webpageObject = new WXWebpageObject();
        webpageObject.webpageUrl = weChat.getRedirectUrl();//链接
        final WXMediaMessage message = new WXMediaMessage(webpageObject);
        message.title = weChat.getTitle();//标题
        message.description = weChat.getContent();//内容

        new Thread() {
            @Override
            public void run() {
                super.run();
                Bitmap bitmap = getBitmapFromServer(weChat.getImageUrl());
                Bitmap thBitmap = (IMAGEWIDTH == bitmap.getWidth() && IMAGEHEIGHT == bitmap.getHeight())
                        ? bitmap : Bitmap.createScaledBitmap(bitmap, IMAGEWIDTH, IMAGEHEIGHT, true);
                bitmap.recycle();
                message.setThumbImage(thBitmap);//设置缩略图
                shareContentToView(message, flag, "web");
            }
        }.start();
    }

    private void ShareImageFunction(final int flag, final String imageUrl) {//分享图片
        if (checkedIsHasWeiXin()) {
            return;
        }
        new Thread() {
            @Override
            public void run() {
                super.run();
                Bitmap bitmap = getBitmapFromServer(imageUrl);
                WXImageObject wxImageObject = new WXImageObject(bitmap);
                WXMediaMessage msg = new WXMediaMessage();
                msg.mediaObject = wxImageObject;

                Bitmap thBitmap = (IMAGEWIDTH == bitmap.getWidth() && IMAGEHEIGHT == bitmap.getHeight())
                        ? bitmap : Bitmap.createScaledBitmap(bitmap, IMAGEWIDTH, IMAGEHEIGHT, true);
                bitmap.recycle();
                msg.setThumbImage(thBitmap);//设置缩略图
                shareContentToView(msg, flag, "img");
            }
        }.start();
    }

    private void shareContentToView(WXMediaMessage message, int flag, String str) {
        SendMessageToWX.Req req = new SendMessageToWX.Req();
        req.transaction = String.valueOf(str + System.currentTimeMillis());
        req.message = message;
        req.scene = flag;
        BuyerApp.iwxapi.sendReq(req);
    }

    private boolean checkedIsHasWeiXin() {//检查是否安装微信
        if (!BuyerApp.iwxapi.isWXAppInstalled()) {
            ToastUtils.show(this, getResources().getString(R.string.wx_no_checked));
            return true;
        }
        return false;
    }

    private Bitmap getBitmapFromServer(String url) {//处理分享图片
        Bitmap bitmap;
        try {
            if (!TextUtils.isEmpty(url)) {
                bitmap = BitmapFactory.decodeStream(new URL(url).openStream());
            } else {
                bitmap = BitmapFactory.decodeResource(getResources(), R.mipmap.buyer_logo);
            }
            return bitmap;
        } catch (IOException e) {
            return BitmapFactory.decodeResource(getResources(), R.mipmap.buyer_logo);
        }
    }

    private void showPopUpWindow() {
        LayoutInflater inflater = (LayoutInflater) getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View view = inflater.inflate(R.layout.share_menu_layout, null);
        if (mPopupWindow == null) {
            mPopupWindow = new PopupWindow(view);
            mPopupWindow.setHeight(WindowManager.LayoutParams.MATCH_PARENT);
            mPopupWindow.setWidth(WindowManager.LayoutParams.MATCH_PARENT);
        }
        mPopupWindow.setFocusable(true);
        mPopupWindow.setOutsideTouchable(true);
        mPopupWindow.setBackgroundDrawable(new ColorDrawable(0x00000000));
        mPopupWindow.showAtLocation(webView, Gravity.BOTTOM, 0, 0);
        mPopupWindow.showAsDropDown(webView);

        popupView = view.findViewById(R.id.view_popupwindow);
        mWeiXinText = (TextView) view.findViewById(R.id.weixin_choose_text);
        mWeiXinCircleText = (TextView) view.findViewById(R.id.weixin_circle_choose_text);
        mMessageText = (TextView) view.findViewById(R.id.message_choose_text);
        mWeiXinText.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                popupWindowDismiss();
                weChatRequest();
            }
        });
        mWeiXinCircleText.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                popupWindowDismiss();
                weCirclerequest();
            }
        });
        mMessageText.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                popupWindowDismiss();
                smsRequest();
            }
        });
        popupView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                popupWindowDismiss();
            }
        });
    }

    private void popupWindowDismiss() {
        if (mPopupWindow != null && mPopupWindow.isShowing()) {
            mPopupWindow.dismiss();
        }
    }

    public void initHttpBack() {
        webHttpBack = new HttpBack<WebUrl>(this) {
            @Override
            public void onSuccess(WebUrl webUrl) {
                webView.loadUrl(webUrl.getAndroidValue());
            }
        };
        smsHttpBack = new HttpBack<SMSContent>(this) {
            @Override
            public void onSuccess(SMSContent sms) {
                messageFunction(sms.getContent());
            }

            @Override
            public void failure(RetrofitError error) {
                ToastUtils.showShort(H5CordovaActivity.this, getResources().getString(R.string.network_error_toast));
            }

            @Override
            public void onTimeOut() {
                ToastUtils.showShort(H5CordovaActivity.this, getResources().getString(R.string.network_error_toast));
            }
        };
        weChatHttpBack = new HttpBack<WEChat>(this) {
            @Override
            public void onSuccess(WEChat wechatData) {
                ShareFunction(WXFLAG, wechatData);//网页
            }

            @Override
            public void failure(RetrofitError error) {
                ToastUtils.showShort(H5CordovaActivity.this, getResources().getString(R.string.network_error_toast));
            }

            @Override
            public void onTimeOut() {
                ToastUtils.showShort(H5CordovaActivity.this, getResources().getString(R.string.network_error_toast));
            }
        };
        weCircleHttpBack = new HttpBack<WECircle>(this) {
            @Override
            public void onSuccess(WECircle weCircle) {//图片
                ShareImageFunction(WXFRIENDFLAG, weCircle.getImageUrl());
            }

            @Override
            public void failure(RetrofitError error) {
                ToastUtils.showShort(H5CordovaActivity.this, getResources().getString(R.string.network_error_toast));
            }

            @Override
            public void onTimeOut() {
                ToastUtils.showShort(H5CordovaActivity.this, getResources().getString(R.string.network_error_toast));
            }
        };
    }

    @Override
    public void onStart() {
        super.onStart();
        IntentFilter filter = new IntentFilter();
        filter.addAction(Constants.Receiver.WXSHAREACTION);
        registerReceiver(wxSharereceiver, filter);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (wxSharereceiver != null) {
            unregisterReceiver(wxSharereceiver);
            wxSharereceiver = null;
        }
        if (mPopupWindow != null && mPopupWindow.isShowing()) {
            cleanPopupWindow();
        }
    }

    private class LocationListener implements BDLocationListener {
        @Override
        public void onReceiveLocation(BDLocation bdLocation) {
            if (bdLocation.getLocType() == BDLocation.TypeGpsLocation
                    || bdLocation.getLocType() == BDLocation.TypeOffLineLocation
                    || bdLocation.getLocType() == BDLocation.TypeNetWorkLocation) {
                mLatitude = bdLocation.getLatitude();
                mLongitude = bdLocation.getLongitude();
                location.stopLoc();
            }
        }
    }

    private BroadcastReceiver wxSharereceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (Constants.Receiver.WXSHAREACTION.equals(action)) {
                int wxLoginCode = intent.getExtras().getInt(Constants.BundleName.SHARERESULT);
                if (wxLoginCode == Constants.ResultCode.SUCCESS) {
                    //TODO  分享以后操作--刷新界面等
                    ToastUtils.show(H5CordovaActivity.this, getResources().getString(R.string.share_success_toast));
                } else {
                    ToastUtils.show(H5CordovaActivity.this, getResources().getString(R.string.share_fail_toast));
                }
            }
        }
    };

    public Handler getSharePluginHandler() {
        return sharePluginHandler;
    }

    static class SharePluginHandler extends Handler {
        private WeakReference<H5CordovaActivity> fragmentWeakReference;

        public SharePluginHandler(H5CordovaActivity activity) {
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
                case Constants.HandlerCode.SHARE_MENU:
                    activity.showPopUpWindow();
                    break;
                case Constants.HandlerCode.SHARE_WECHAT:
                    activity.weChatRequest();
                    break;
                case Constants.HandlerCode.SHARE_WECIRCLE:
                    activity.weCirclerequest();
                    break;
                case Constants.HandlerCode.SHARE_SMS:
                    activity.smsRequest();
                    break;
                case Constants.HandlerCode.CORDOVA_BACK:
                    activity.onBackPressed();
                    break;
                case Constants.HandlerCode.CORDOVA_ADD_CART_BAR_CODE:
                    activity.addCartBarCode(msg.obj.toString().trim());
                    break;
                case Constants.HandlerCode.CORDOVA_ADD_CART_FEN:
                    activity.addCartFen(msg.obj.toString().trim());
                    break;
                case Constants.HandlerCode.CORDOVA_TO_ORDER_LIST_PAGE:
                    activity.goToOrderList();
                    break;
                case Constants.HandlerCode.CORDOVA_TO_ORDER_DETAIL_PAGE:
                    activity.goToOrderDetail((String) msg.obj);
                    break;
                case Constants.HandlerCode.CORDOVA_TO_CLASS_PAGE:
                    //                    activity.goToClassPage();
                    break;
                case Constants.HandlerCode.CORDOVA_TO_BRAND_PAGE:
                    activity.goToBrandPage();
                    break;
                case Constants.HandlerCode.CORDOVA_TO_LOGIN_PAGE:
                    activity.goToLoginPage();
                    break;
                case Constants.HandlerCode.CORDOVA_TO_CART_PAGE:
                    activity.goToCartPage();
                    break;
                case Constants.HandlerCode.CORDOVA_ADD_PRODUCT_CART:
                    activity.addProductToCart(msg.obj.toString(), false);
                    break;
                case Constants.HandlerCode.CORDOVA_BUY_AT_ONCE:
                    activity.addProductToCart(msg.obj.toString(), true);
                    break;
                case Constants.HandlerCode.CORDOVA_REMOVE_PRODUCT_CART:
                    activity.removeProductToCart(msg.obj.toString());
                    break;
                case Constants.HandlerCode.CORDOVA_CLEAN_CART:
                    activity.cleanCart();
                    break;
                case Constants.HandlerCode.CORDOVA_TO_REDIRECTPAGE:
                    activity.toH5Page(msg.obj.toString());
                    break;
            }
        }
    }

    private void cleanCart() {
        cartBtn.setVisibility(View.GONE);
        CartUtils.clearCart();
        CartUtils.clearCartDao();
    }

    private void removeProductToCart(String productInfo) {
        SaleProduct saleProduct = new Gson().fromJson(productInfo, SaleProduct.class);
        if (saleProduct == null) {
            return;
        }
        CartUtils.removeCart(saleProduct);
        flushCart();
    }

    private void addProductToCart(String productInfo, boolean isCart) {
        isToCart = isCart;
        SaleProduct saleProduct = new Gson().fromJson(productInfo, SaleProduct.class);
        if (saleProduct == null) {
            return;
        }
        CartUtils.validateOperationCart(this, saleProduct, cartHandler, null);
    }

    private void toH5Page(String url) {
        cartBtn.setVisibility(View.GONE);
        if (TextUtils.isEmpty(url)) {
            return;
        }
        webView.loadUrl(url + "?intfCallChannel=android");
    }

    private void addCartFen(String params) {
        isToCart = true;
        List<SaleProduct> fenProducts = ZoneUtils.getZoneFen();
        if (fenProducts == null || fenProducts.size() == 0) {
            return;
        }
        for (SaleProduct product : fenProducts) {
            if (params.equals(product.getBarCode().trim())) {
                CartUtils.validateOperationCart(this, product, cartHandler, null);
            }
        }
    }

    private void addCartBarCode(String params) {
        isToCart = true;
        List<SaleProduct> vipProducts = ZoneUtils.getZoneVip();
        if (vipProducts == null) {
            return;
        }
        for (SaleProduct product : vipProducts) {
            if (params.equals(product.getBarCode().trim())) {
                CartUtils.validateOperationCart(this, product, cartHandler, null);
            }
        }
    }

    private void goToLoginPage() {
        gotoLoginFragment(this);
    }

    private void goToCartPage() {
        gotoCartFragment(this);
    }

    private void goToBrandPage() {
        Intent intent = new Intent(this, ClassActivity.class);
        intent.setAction(BrandClassityFragment.class.getSimpleName());
        startActivity(intent);
    }

    private void goToClassPage() {
    }

    private void goToOrderList() {
        Intent intent = new Intent(this, OrderListTabActivity.class);
        intent.putExtra(Constants.BundleName.ORDER_STATUS, 0);
        startActivity(intent);
    }

    private void goToOrderDetail(String obj) {
        Intent intent = new Intent(this, OrderDetailActivity.class);
        intent.putExtra(Constants.BundleName.ORDER_CODE, obj);
        startActivity(intent);
    }

    private void addCartSuccess() {
        flushCart();
        if (UserUtils.isLogin()) {
            if (isToCart) {
                gotoCartFragment(this);
            } else {
                cartBtn.setVisibility(View.VISIBLE);
            }
        } else {
            gotoLoginFragment(this);
        }
    }

    private void gotoLoginFragment(Context context) {
        Intent intent = new Intent(context, LoginActivity.class);
        intent.setAction(LoginFragment.class.getSimpleName());
        startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
    }

    private void gotoCartFragment(Context context) {
        Intent intent = new Intent(context, PurchaseActivity.class);
        intent.setAction(CartFragment.class.getSimpleName());
        startActivity(intent);
    }

    public void flushCart() {
        Integer count = CartUtils.getCartCount();
        if (count > 0) {
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
            cartNumBg.setVisibility(View.INVISIBLE);
            cartNumView.setVisibility(View.INVISIBLE);
        }
    }

    private static class CartHandler extends Handler {
        WeakReference<H5CordovaActivity> fragmentWeakReference;

        public CartHandler(H5CordovaActivity activity) {
            fragmentWeakReference = new WeakReference<>(activity);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            H5CordovaActivity activity = fragmentWeakReference.get();
            if (activity == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.CART_SUCCESS:
                    activity.addCartSuccess();
                    break;
            }
        }
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        if (mPopupWindow != null && mPopupWindow.isShowing()) {
            cleanPopupWindow();
        } else {
            finish();
        }
    }

    private void cleanPopupWindow() {
        mPopupWindow.dismiss();
        mPopupWindow = null;
    }

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }
}
