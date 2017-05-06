package com.yldbkd.www.buyer.android.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.Fragment;
import android.view.View;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.FragmentAdapter;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.CartEmptyFragment;
import com.yldbkd.www.buyer.android.fragment.CartFragment;
import com.yldbkd.www.buyer.android.fragment.ClassificationTabFragment;
import com.yldbkd.www.buyer.android.fragment.HomeFragment;
import com.yldbkd.www.buyer.android.fragment.LoginFragment;
import com.yldbkd.www.buyer.android.fragment.ProfileFragment;
import com.yldbkd.www.buyer.android.utils.AnimUtils;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.NoSwipeViewPager;

import java.lang.ref.WeakReference;

/**
 * 应用最主要页面Activity
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class MainActivity extends BaseActivity {

    private boolean isDoubleExist = false;
    private Integer lastedItem = 0;
    private Integer currentItem = 0;
    public static final int HOME = 0, CLASSIFICATION = 1, CART = 2, ORDER = 3, PROFILE = 4;

    private FragmentAdapter fragmentAdapter;
    private NoSwipeViewPager viewPager;
    private RadioGroup group;
    private RadioButton homeBtn, classificationBtn, cartBtn, profileBtn;
    private ImageView cartNumBg;
    private TextView cartNumView;
    public CartHandler cartHandler = new CartHandler(this);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.main_activity);
        initViews();
        initPager();
        initListener();
    }

    private boolean isNotification() {
        return getIntent().getBooleanExtra(Constants.BundleName.IS_NOTIFICATION, false);
    }

    private void initViews() {
        viewPager = (NoSwipeViewPager) findViewById(R.id.main_view_pager);
        fragmentAdapter = new FragmentAdapter(getSupportFragmentManager());
        group = (RadioGroup) findViewById(R.id.radio_group);
        homeBtn = (RadioButton) findViewById(R.id.home_tab);
        classificationBtn = (RadioButton) findViewById(R.id.classification_tab);
        cartBtn = (RadioButton) findViewById(R.id.cart_tab);
        profileBtn = (RadioButton) findViewById(R.id.profile_tab);
        cartNumBg = (ImageView) findViewById(R.id.cart_num_bg);
        cartNumView = (TextView) findViewById(R.id.cart_num_text);
    }

    private void initPager() {
        HomeFragment homeFragment = new HomeFragment();
        homeFragment.setCartHandler(cartHandler);
        Bundle bundle = new Bundle();
        bundle.putBoolean(Constants.BundleName.IS_NOTIFICATION, isNotification());
        homeFragment.setArguments(bundle);

        fragmentAdapter.addItem(homeFragment);
        fragmentAdapter.addItem(new ClassificationTabFragment());
        fragmentAdapter.addItem(new CartEmptyFragment());
        fragmentAdapter.addItem(new ProfileFragment());
        viewPager.setAdapter(fragmentAdapter);
        viewPager.setOffscreenPageLimit(4);
    }

    private void initListener() {
        group.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                switch (checkedId) {
                    case R.id.classification_tab:
                        viewPager.setCurrentItem(CLASSIFICATION);
                        lastedItem = CLASSIFICATION;
                        currentItem = CLASSIFICATION;
                        break;
                    case R.id.cart_tab:
                        if (UserUtils.isLogin()) {
                            if (CartUtils.getCartCount() > 0) {
                                Intent intent = new Intent(MainActivity.this, PurchaseActivity.class);
                                intent.setAction(CartFragment.class.getSimpleName());
                                startActivity(intent);
                                changeChecked(lastedItem);
                            } else {
                                viewPager.setCurrentItem(CART);
                                lastedItem = CART;
                            }
                        } else {
                            Intent intent = new Intent(MainActivity.this, LoginActivity.class);
                            intent.setAction(LoginFragment.class.getSimpleName());
                            startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
                        }
                        currentItem = CART;
                        break;
                    case R.id.profile_tab:
                        if (UserUtils.isLogin()) {
                            viewPager.setCurrentItem(PROFILE);
                            lastedItem = PROFILE;
                        } else {
                            Intent intent = new Intent(MainActivity.this, LoginActivity.class);
                            intent.setAction(LoginFragment.class.getSimpleName());
                            startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
                        }
                        currentItem = PROFILE;
                        break;
                    case R.id.home_tab:
                    default:
                        viewPager.setCurrentItem(HOME);
                        lastedItem = HOME;
                        break;
                }
            }
        });
    }

    static class CartHandler extends Handler {
        private WeakReference<MainActivity> activityWeakReference;

        public CartHandler(MainActivity activity) {
            activityWeakReference = new WeakReference<>(activity);
        }

        @Override
        public void dispatchMessage(Message msg) {
            super.dispatchMessage(msg);
            MainActivity activity = activityWeakReference.get();
            if (activity == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.PRODUCT_PLUS:
                    int[] startLocation = (int[]) msg.obj;
                    int[] endLocation = new int[2];
                    activity.cartNumView.getLocationInWindow(endLocation);
                    AnimUtils.setAddCartAnim(activity, startLocation, endLocation, activity.cartNumBg, activity.cartNumView
                            , null);
                    break;
                case Constants.HandlerCode.PRODUCT_MINUS:
                    activity.flushCart();
                    break;
            }
        }
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        changeChecked(HOME);
    }

    @Override
    protected void onResume() {
        super.onResume();
        flushCart();
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

    @Override
    public void onBackPressed() {
        if (isDoubleExist) {
            AppManager.getAppManager().appExit();
            return;
        }
        isDoubleExist = true;
        ToastUtils.show(this, getString(R.string.double_exit_notify));
        new Handler().postDelayed(new Runnable() {

            @Override
            public void run() {
                isDoubleExist = false;
            }
        }, 2000);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (Constants.RequestCode.LOGIN_CODE == requestCode && Activity.RESULT_OK == resultCode) {
            if (currentItem == CART && CartUtils.getCartCount() > 0) {
                Intent intent = new Intent(MainActivity.this, PurchaseActivity.class);
                intent.setAction(CartFragment.class.getSimpleName());
                startActivity(intent);
                changeChecked(lastedItem);
            } else {
                changeChecked(currentItem);
                viewPager.setCurrentItem(currentItem);
            }
        } else {
            changeChecked(lastedItem);
        }
    }

    public void changeChecked(int index) {
        switch (index) {
            case HOME:
                homeBtn.setChecked(true);
                flushCart();
                break;
            case CLASSIFICATION:
                classificationBtn.setChecked(true);
                flushCart();
                break;
            case CART:
                cartBtn.setChecked(true);
                flushCart();
                break;
            case PROFILE:
                profileBtn.setChecked(true);
                flushCart();
                break;
        }
    }

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }
}
