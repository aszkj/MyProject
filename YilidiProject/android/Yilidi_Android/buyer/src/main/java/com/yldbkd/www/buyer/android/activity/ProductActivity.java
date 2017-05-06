package com.yldbkd.www.buyer.android.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.support.v4.view.ViewPager;
import android.text.TextUtils;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.FragmentAdapter;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.fragment.CartFragment;
import com.yldbkd.www.buyer.android.fragment.LoginFragment;
import com.yldbkd.www.buyer.android.fragment.ProductDetailFragment;
import com.yldbkd.www.buyer.android.fragment.ProductFragment;
import com.yldbkd.www.buyer.android.utils.AnimUtils;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.viewCustomer.VerticalViewPager;

import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;

/**
 * 商品详情页面
 * <p/>
 * Created by linghuxj on 15/11/7.
 */
public class ProductActivity extends BaseActivity {

    private RelativeLayout mainToorBar;
    private RelativeLayout backView;
    private ImageView backImage, dividerLine;
    private TextView titleView;
    private TextView addCartBtn;
    private LinearLayout cartBtn;
    private ImageView cartNumBg;
    private TextView cartNumView;
    private View mProductBottomLayout;
    private View mLlCollectionView;
    private TextView mCollectionTextView;

    private VerticalViewPager viewPager;
    private FragmentAdapter fragmentAdapter;
    private ProductDetailHandler mProductDetailHandler = new ProductDetailHandler(this);

    private HttpBack<SaleProduct> productHttpBack;
    private HttpBack<BaseModel> collectSaveHttpBack;
    private HttpBack<BaseModel> collectCancelHttpBack;

    private Integer saleProductId;
    private String storeCartPromote;
    private SaleProduct saleProduct;
    private static final int[] TITLES = {R.string.product, R.string.product_detail};
    private boolean isFirstLoad = true;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.product_activity);
        initData();
        initHttpBack();
        initViews();
        initListener();
        request();
    }

    private void initData() {
        Bundle bundle = getIntent().getExtras();
        if (bundle == null) {
            return;
        }
        saleProductId = bundle.getInt(Constants.BundleName.SALE_PRODUCT_ID);
        storeCartPromote = bundle.getString(Constants.BundleName.STORE_CART_PROMOTE);
    }

    private void initHttpBack() {
        productHttpBack = new HttpBack<SaleProduct>(this) {

            @Override
            public void onSuccess(SaleProduct product) {
                mProductBottomLayout.setVisibility(View.VISIBLE);
                saleProduct = product;
                showCollectionState();
                CartUtils.calculateProductNum(saleProduct);
                initAdapter(saleProduct, product.getProductDetail());
                initAddCartBtn();
            }
        };
        collectSaveHttpBack = new HttpBack<BaseModel>(this) {
            @Override
            public void onSuccess(BaseModel baseModel) {
                saleProduct.setIsCollected(1);
                showCollectionState();
            }
        };
        collectCancelHttpBack = new HttpBack<BaseModel>(this) {
            @Override
            public void onSuccess(BaseModel baseModel) {
                saleProduct.setIsCollected(0);
                showCollectionState();
            }
        };
    }

    private void showCollectionState() {
        if (saleProduct.getIsCollected() == 0) {
            mCollectionTextView.setTextColor(ContextCompat.getColor(this, R.color.secondaryText));
            mCollectionTextView.setCompoundDrawablesWithIntrinsicBounds(null, getResources().getDrawable(R.mipmap.collection_no), null, null);
        } else {
            mCollectionTextView.setTextColor(ContextCompat.getColor(this, R.color.colorPrimary));
            mCollectionTextView.setCompoundDrawablesWithIntrinsicBounds(null, getResources().getDrawable(R.mipmap.collection), null, null);
        }
    }

    private void initViews() {
        mainToorBar = (RelativeLayout) findViewById(R.id.main_toor_bar);
        mainToorBar.setBackgroundResource(R.color.trans_bg);

        backView = (RelativeLayout) findViewById(R.id.back_view);
        backImage = (ImageView) findViewById(R.id.back_image);
        dividerLine = (ImageView) findViewById(R.id.divider_line);
        backImage.setBackgroundResource(R.mipmap.back_btn_product_detail);
        backImage.setBackgroundResource(R.mipmap.back_btn_product_detail);
        titleView = (TextView) findViewById(R.id.title_view);
        titleView.setText(TITLES[0]);
        titleView.setVisibility(View.GONE);
        dividerLine.setVisibility(View.GONE);

        viewPager = (VerticalViewPager) findViewById(R.id.product_view_pager);
        fragmentAdapter = new FragmentAdapter(getSupportFragmentManager());
        TextView bottomTextView = (TextView) findViewById(R.id.cart_bottom_text_view);
        if (!TextUtils.isEmpty(storeCartPromote)) {
            bottomTextView.setText(storeCartPromote);
        }
        mProductBottomLayout = findViewById(R.id.product_bottom_layout);
        mLlCollectionView = findViewById(R.id.ll_collection_view);
        mCollectionTextView = (TextView) findViewById(R.id.colletion_text_view);
        addCartBtn = (TextView) findViewById(R.id.cart_bottom_add_view);
        cartBtn = (LinearLayout) findViewById(R.id.cart_bottom_button);
        cartNumBg = (ImageView) findViewById(R.id.cart_bottom_num_bg);
        cartNumView = (TextView) findViewById(R.id.cart_bottom_num_view);
    }

    private void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                onBackPressed();
            }
        });
        cartBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent;
                if (UserUtils.isLogin()) {
                    intent = new Intent(ProductActivity.this, PurchaseActivity.class);
                    intent.setAction(CartFragment.class.getSimpleName());
                    startActivity(intent);
                } else {
                    intent = new Intent(ProductActivity.this, LoginActivity.class);
                    intent.setAction(LoginFragment.class.getSimpleName());
                    startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
                }
            }
        });
        viewPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {
            }

            @Override
            public void onPageSelected(int position) {
                titleView.setText(TITLES[position]);
                if (position == 1) {
                    titleView.setVisibility(View.VISIBLE);
                    mainToorBar.setBackgroundResource(R.color.white);
                    backImage.setBackgroundResource(R.mipmap.back_btn);
                    dividerLine.setVisibility(View.VISIBLE);
                } else {
                    titleView.setVisibility(View.GONE);
                    backImage.setBackgroundResource(R.mipmap.back_btn_product_detail);
                    dividerLine.setVisibility(View.GONE);
                    mainToorBar.setBackgroundResource(R.color.trans_bg);
                }
            }

            @Override
            public void onPageScrollStateChanged(int state) {
            }
        });
        mLlCollectionView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent;
                if (!UserUtils.isLogin()) {
                    intent = new Intent(ProductActivity.this, LoginActivity.class);
                    intent.setAction(LoginFragment.class.getSimpleName());
                    startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
                } else {
                    if (saleProduct.getIsCollected() == 0) {
                        collectSaleProductRequest();
                    } else {
                        collectCancleSaleProductRequest();
                    }
                }
            }
        });
    }

    private void collectSaleProductRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("productId", saleProduct.getProductId());
        RetrofitUtils.getInstance(true).collectSaleProduct(ParamUtils.getParam(map), collectSaveHttpBack);
    }

    private void collectCancleSaleProductRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("productIds", saleProduct.getProductId().toString());
        RetrofitUtils.getInstance(true).collectCancelSaleProduct(ParamUtils.getParam(map), collectCancelHttpBack);
    }

    private void initAdapter(SaleProduct product, String productDetail) {
        if (!isFirstLoad) {
            return;
        }
        isFirstLoad = false;
        ProductFragment productFragment = new ProductFragment();
        Bundle bundle = new Bundle();
        bundle.putSerializable(Constants.BundleName.PRODUCT_INFO, product);
        bundle.putBoolean(Constants.BundleName.HAS_PRODUCT_DETAIL, !TextUtils.isEmpty(productDetail));
        productFragment.setArguments(bundle);
        productFragment.setProHandler(new CartHandler(this));
        fragmentAdapter.addItem(productFragment);
        if (!TextUtils.isEmpty(productDetail)) {
            ProductDetailFragment detailFragment = new ProductDetailFragment();
            Bundle detailBundle = new Bundle();
            detailBundle.putString(Constants.BundleName.PRODUCT_DETAIL, productDetail);
            detailFragment.setArguments(detailBundle);
            fragmentAdapter.addItem(detailFragment);
        }
        viewPager.setAdapter(fragmentAdapter);
    }

    private void request() {
        Map<String, Object> map = new HashMap<>();
        map.put("saleProductId", saleProductId);
        RetrofitUtils.getInstance(true).getProductDetail(ParamUtils.getParam(map), productHttpBack);
    }

    private void initAddCartBtn() {
        if (saleProduct.getStockNum() <= saleProduct.getCartNum()) {
            addCartBtn.setOnClickListener(null);
            addCartBtn.setBackgroundResource(R.drawable.button_gray);
            addCartBtn.setTextColor(ContextCompat.getColor(this, R.color.lightText));
        } else {
            addCartBtn.setBackgroundResource(R.drawable.button_yellow_selector);
            addCartBtn.setTextColor(ContextCompat.getColor(this, R.color.white));
            addCartBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    mProductDetailHandler.obtainMessage(Constants.HandlerCode.PRODUCT_PLUS).sendToTarget();
                }
            });
        }
    }

    private static class ProductDetailHandler extends Handler {
        WeakReference<ProductActivity> fragmentWeakReference;

        public ProductDetailHandler(ProductActivity activity) {
            fragmentWeakReference = new WeakReference<>(activity);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            ProductActivity activity = fragmentWeakReference.get();
            if (activity == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.PRODUCT_PLUS:
                    CartUtils.validateOperationCart(activity, activity.saleProduct, this, msg.obj);
                    break;
                case Constants.HandlerCode.CART_SUCCESS:
                    CartUtils.calculateProductNum(activity.saleProduct);
                    activity.flushCart();
                    break;
            }
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (Constants.RequestCode.LOGIN_CODE == requestCode && Activity.RESULT_OK == resultCode) {
            Intent intent = new Intent(ProductActivity.this, MainActivity.class);
            startActivity(intent);
        }
    }

    @Override
    public void onResume() {
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

    static class CartHandler extends Handler {
        private WeakReference<ProductActivity> activityWeakReference;

        public CartHandler(ProductActivity activity) {
            activityWeakReference = new WeakReference<>(activity);
        }

        @Override
        public void dispatchMessage(Message msg) {
            super.dispatchMessage(msg);
            ProductActivity activity = activityWeakReference.get();
            if (activity == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.PRODUCT_PLUS:
                    int[] startLocation = (int[]) msg.obj;
                    int[] endLocation = new int[2];
                    activity.cartNumView.getLocationInWindow(endLocation);
                    AnimUtils.setAddCartAnim(activity, startLocation, endLocation, activity.cartNumBg, activity.cartNumView
                            , activity.cartBtn);
                    break;
            }
        }
    }

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }
}
