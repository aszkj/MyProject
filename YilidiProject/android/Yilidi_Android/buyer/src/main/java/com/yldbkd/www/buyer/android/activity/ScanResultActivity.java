package com.yldbkd.www.buyer.android.activity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.Fragment;
import android.text.TextUtils;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.ProductListViewAdapter;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.fragment.CartFragment;
import com.yldbkd.www.buyer.android.fragment.LoginFragment;
import com.yldbkd.www.buyer.android.utils.AnimUtils;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李贞高
 * @version $Rev$
 * @time 2016/7/27 19:00
 * @des 对扫描各种结果处理
 * @updateAuthor $Author$
 * @updateDate $Date$
 * @updateDes
 */
public class ScanResultActivity extends BaseActivity {
    private View backView;
    private TextView mTitleView;
    private LinearLayout llScanNoProduct;
    private LinearLayout llCartCount;
    private String scanResult;
    private ImageView mScanImage;
    private TextView mScanContent;
    private ListView productListView;
    private HttpBack<SaleProduct> scanHttpBack;
    private ProductListViewAdapter productAdapter;
    private List<SaleProduct> saleProductLists = new ArrayList<>();

    //购物车
    private RelativeLayout cartBtn;
    private TextView cartNumView;
    private ImageView cartNumBg;
    private ScanHandler scanHandler = new ScanHandler(this);


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.scan_result_activity);
        scanResult = getIntent().getStringExtra(Constants.BundleName.SCAN_RESULT);

        initView();
        initHttpBack();
        initDate();
        initListener();
    }

    private void initView() {
        backView = findViewById(R.id.back_view);
        mTitleView = (TextView) findViewById(R.id.title_view);

        cartNumBg = (ImageView) findViewById(R.id.cart_bottom_num_bg);
        cartNumView = (TextView) findViewById(R.id.cart_bottom_num_view);
        cartBtn = (RelativeLayout) findViewById(R.id.cart_bottom_button);

        llScanNoProduct = (LinearLayout) findViewById(R.id.ll_scan_no_product);
        mScanImage = (ImageView) findViewById(R.id.scan_result_image);
        mScanContent = (TextView) findViewById(R.id.scan_result_textview);
        productListView = (ListView) findViewById(R.id.scan_list_layout);

        llCartCount = (LinearLayout) findViewById(R.id.ll_cart_count);
    }

    private void initDate() {
        if (TextUtils.isEmpty(scanResult)) {
            showContent(Constants.Scan.NOPRODUCT);
            return;
        }
        initAdapter();
        initRequest();
    }

    @Override
    public void onResume() {
        super.onResume();
        flushCart();
        CartUtils.calculateProductNum(saleProductLists);
        if (productAdapter != null) {
            productAdapter.notifyDataSetChanged();
        }
    }

    public void initRequest() {
        scanRequest(scanResult);
    }

    private void initAdapter() {
        productAdapter = new ProductListViewAdapter(saleProductLists, this, 1, scanHandler);
        productListView.setAdapter(productAdapter);
    }

    private void showContent(int contentFalg) {
        llScanNoProduct.setVisibility(View.VISIBLE);
        productListView.setVisibility(View.GONE);
        llCartCount.setVisibility(View.GONE);

        int titleId;
        int bgImageId;
        int contentId;
        if (contentFalg == Constants.Scan.OFFLINE) {
            titleId = R.string.scan_result_offline_titel;
            bgImageId = R.mipmap.product_nodata;
            contentId = R.string.scan_result_offline_content;
        } else {
            titleId = R.string.scan_result_noproduct_title;
            bgImageId = R.mipmap.product_nodata;
            contentId = R.string.scan_result_noproduct_content;
        }
        mTitleView.setText(getResources().getString(titleId));
        mScanImage.setBackgroundResource(bgImageId);
        mScanContent.setText(getResources().getString(contentId));
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
                    intent = new Intent(ScanResultActivity.this, PurchaseActivity.class);
                    intent.setAction(CartFragment.class.getSimpleName());
                    startActivity(intent);
                } else {
                    intent = new Intent(ScanResultActivity.this, LoginActivity.class);
                    intent.setAction(LoginFragment.class.getSimpleName());
                    startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
                }
            }
        });
    }

    private void initHttpBack() {
        scanHttpBack = new HttpBack<SaleProduct>(this) {
            @Override
            public void onSuccess(SaleProduct productInfo) {
                saleProductLists.clear();
                if (productInfo == null) {
                    showContent(Constants.Scan.NOPRODUCT);
                    return;
                }
                if (productInfo.getProductStatus() != Constants.ProductStatus.ON_LINE) {
                    showContent(Constants.Scan.OFFLINE);
                    return;
                }
                mTitleView.setText(getResources().getString(R.string.scan_result_titel));
                llCartCount.setVisibility(View.VISIBLE);
                saleProductLists.add(productInfo);
                CartUtils.calculateProductNum(saleProductLists);
                productAdapter.notifyDataSetChanged();
            }

            @Override
            public void onFailure(String msg) {
                showContent(Constants.Scan.NOPRODUCT);
            }
        };
    }

    /**
     * 扫描请求
     */
    private void scanRequest(String barcode) {
        Map<String, Object> map = new HashMap<>();
        map.put("barCode", barcode);
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance().productByBarcode(ParamUtils.getParam(map), scanHttpBack);
    }

    private static class ScanHandler extends Handler {
        WeakReference<ScanResultActivity> fragmentWeakReference;

        public ScanHandler(ScanResultActivity activity) {
            fragmentWeakReference = new WeakReference<>(activity);
        }

        @Override
        public void dispatchMessage(final Message msg) {
            final ScanResultActivity activity = fragmentWeakReference.get();
            if (activity == null) {
                return;
            }
            SaleProduct product = activity.saleProductLists.get(msg.arg2);
            switch (msg.what) {
                case Constants.HandlerCode.PRODUCT_PLUS:
                    CartUtils.validateOperationCart(activity, product, this, msg.obj);
                    break;
                case Constants.HandlerCode.CART_SUCCESS:
                    CartUtils.calculateProductNum(activity.saleProductLists);

                    int[] startLocation = (int[]) msg.obj;
                    int[] endLocation = new int[2];
                    activity.cartNumView.getLocationInWindow(endLocation);
                    AnimUtils.setAddCartAnim(activity, startLocation, endLocation,
                            activity.cartNumBg, activity.cartNumView, null);
                    activity.flushCart();
                    break;
                case Constants.HandlerCode.PRODUCT_MINUS:
                    product.setCartNum(product.getCartNum() - 1);
                    CartUtils.removeCart(product);
                    activity.flushCart();
                    break;
                case Constants.HandlerCode.PRODUCT_DETAIL:
                    Intent intent = new Intent(activity, ProductActivity.class);
                    intent.putExtra(Constants.BundleName.SALE_PRODUCT_ID, product.getSaleProductId());
                    activity.startActivity(intent);
                    break;
            }
            activity.productAdapter.notifyDataSetChanged();
        }
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
    public Fragment newFragmentByTag(String tag) {
        return null;
    }

}
