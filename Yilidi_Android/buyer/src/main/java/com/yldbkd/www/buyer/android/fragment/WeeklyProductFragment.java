package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.content.ContextCompat;
import android.text.TextUtils;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.activity.MainActivity;
import com.yldbkd.www.buyer.android.activity.ProductActivity;
import com.yldbkd.www.buyer.android.activity.PurchaseActivity;
import com.yldbkd.www.buyer.android.adapter.ZoneProductAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.AnimUtils;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.viewCustomer.GridInScrollView;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 专区产品列表页面Fragment
 * <p/>
 * Created by linghuxj on 15/10/10.
 */
public class WeeklyProductFragment extends BaseFragment {
    private View backView;
    private TextView titleView;
    //购物车
    private RelativeLayout cartBtn;
    private TextView cartNumView;
    private ImageView cartNumBg;
    private WeeklyHandler weeklyHandler = new WeeklyHandler(this);

    //刷新数据
    private List<SaleProduct> saleProductLists = new ArrayList<>();
    private HttpBack<List<SaleProduct>> producHttpBack;
    private ZoneProductAdapter productAdapter;
    private RelativeLayout mNodataRL;
    private GridInScrollView guidView;
    private ImageView weeklyBannerImage;
    private ScrollView scrollview;

    private String floorId;
    private String floorName;
    private boolean isRefreshItem = true;

    @Override
    public int setLayoutId() {
        return R.layout.weekly_fragment;
    }

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        floorId = bundle.getString(Constants.BundleName.FLOOR_ID);
        floorName = bundle.getString(Constants.BundleName.FLOOR_NAME);
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);
        cartNumBg = (ImageView) view.findViewById(R.id.cart_bottom_num_bg);
        cartNumView = (TextView) view.findViewById(R.id.cart_bottom_num_view);
        cartBtn = (RelativeLayout) view.findViewById(R.id.cart_bottom_button);

        guidView = (GridInScrollView) view.findViewById(R.id.lv_weekly_product);
        mNodataRL = (RelativeLayout) view.findViewById(R.id.rl_nodata);
        weeklyBannerImage = (ImageView) view.findViewById(R.id.weekly_banner_image_view);
        scrollview = (ScrollView) view.findViewById(R.id.scrollview);
    }

    @Override
    public void initData() {
        if (TextUtils.isEmpty(floorId)) {
            titleView.setText(getResources().getString(R.string.home_function_shark));
            weeklyBannerImage.setVisibility(View.VISIBLE);
            scrollview.setBackgroundColor(ContextCompat.getColor(getActivity(), R.color.redSecondary));
        } else {
            titleView.setText(floorName);
            weeklyBannerImage.setVisibility(View.GONE);
            scrollview.setBackgroundColor(ContextCompat.getColor(getActivity(), R.color.background));
        }
        initAdapter();
        initRequest();
    }

    private void initAdapter() {
        productAdapter = new ZoneProductAdapter(saleProductLists, getActivity(), 1, weeklyHandler);
        guidView.setAdapter(productAdapter);
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

    @Override
    public void initHttpBack() {
        producHttpBack = new HttpBack<List<SaleProduct>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<SaleProduct> saleProducts) {
                saleProductLists.clear();
                if (saleProducts == null || saleProducts.size() == 0) {
                    mNodataRL.setVisibility(View.VISIBLE);
                    return;
                }
                saleProductLists.addAll(saleProducts);
                CartUtils.calculateProductNum(saleProductLists);
                productAdapter.notifyDataSetChanged();
            }
        };
    }

    @Override
    public void initRequest() {
        if (TextUtils.isEmpty(floorId)) {
            request();
        } else {
            floorRequest();
        }
    }

    @Override
    public void initListener() {
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
                    intent = new Intent(getBaseActivity(), PurchaseActivity.class);
                    intent.setAction(CartFragment.class.getSimpleName());
                    startActivity(intent);
                } else {
                    intent = new Intent(getBaseActivity(), LoginActivity.class);
                    intent.setAction(LoginFragment.class.getSimpleName());
                    startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
                }
            }
        });

    }

    private void request() {
        Map<String, Object> map = new HashMap<>();
        map.put("zoneType", Constants.ZoneType.ZONE_WEEKLY);
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance(true).zoneProduct(ParamUtils.getParam(map), producHttpBack);
    }

    private void floorRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("floorId", floorId);
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance(true).floorProducts(ParamUtils.getParam(map), producHttpBack);
    }

    private static class WeeklyHandler extends Handler {
        WeakReference<WeeklyProductFragment> fragmentWeakReference;

        public WeeklyHandler(WeeklyProductFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(final Message msg) {
            final WeeklyProductFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            SaleProduct product = fragment.saleProductLists.get(msg.arg2);
            switch (msg.what) {
                case Constants.HandlerCode.PRODUCT_PLUS:
                    CartUtils.validateOperationCart(fragment.getActivity(), product, this, msg.obj, msg.arg2);
                    break;
                case Constants.HandlerCode.CLEANPRODUCTFORVIP:
                    fragment.isRefreshItem = false;
                    break;
                case Constants.HandlerCode.CART_SUCCESS:
                    CartUtils.calculateProductNum(fragment.saleProductLists);
                    int[] startLocation = (int[]) msg.obj;
                    int[] endLocation = new int[2];
                    fragment.cartNumView.getLocationInWindow(endLocation);
                    AnimUtils.setAddCartAnim(fragment.getBaseActivity(), startLocation, endLocation,
                            fragment.cartNumBg, fragment.cartNumView, null);
                    break;
                case Constants.HandlerCode.PRODUCT_MINUS:
                    product.setCartNum(product.getCartNum() - 1);
                    CartUtils.removeCart(product);
                    fragment.flushCart();
                    break;
                case Constants.HandlerCode.PRODUCT_DETAIL:
                    Intent intent = new Intent(fragment.getActivity(), ProductActivity.class);
                    intent.putExtra(Constants.BundleName.SALE_PRODUCT_ID, product.getSaleProductId());
                    fragment.startActivity(intent);
                    break;
            }
            if (fragment.isRefreshItem) {
                fragment.productAdapter.changeProductNum(
                        fragment.productAdapter.getItemView(fragment.guidView, msg.arg2), msg.arg2);
            } else {
                fragment.productAdapter.notifyDataSetChanged();
            }
            fragment.isRefreshItem = true;
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
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == Constants.RequestCode.LOGIN_CODE && resultCode == Activity.RESULT_OK) {
            if (UserUtils.isLogin()) {
                Intent intent = new Intent(getBaseActivity(), MainActivity.class);
                startActivity(intent);
            }
        }
    }
}
