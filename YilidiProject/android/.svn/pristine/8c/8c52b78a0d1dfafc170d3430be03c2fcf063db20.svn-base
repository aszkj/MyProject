package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.activity.MainActivity;
import com.yldbkd.www.buyer.android.activity.ProductActivity;
import com.yldbkd.www.buyer.android.activity.PurchaseActivity;
import com.yldbkd.www.buyer.android.adapter.ZoneProductAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Page;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.AnimUtils;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshBase;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshGridView;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2016/12/14 12:43
 * @描述 品牌商品
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class BrandProductFragment extends BaseFragment {
    private String brandCode;
    private String brandName;
    //title
    private View backView;
    private TextView titleView;
    //购物车
    private RelativeLayout cartBtn;
    private TextView cartNumView;
    private ImageView cartNumBg;
    private BrandHandler brandHandler = new BrandHandler(this);
    //刷新数据
    private List<SaleProduct> brandProductLists = new ArrayList<>();
    private HttpBack<Page<SaleProduct>> brandProducHttpBack;
    private Integer pageNum = 1;
    private Integer totalPages = 1;
    private PullToRefreshGridView productGridView;
    private ZoneProductAdapter productAdapter;
    private Handler refreshHandler = new RefreshHandler(this);
    private RelativeLayout mNodataRL;
    private GridView mGridView;
    private boolean isRefreshItem = true;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        brandName = bundle.getString(Constants.BundleName.BRAND_NAME, getResources().getString(R.string.brand_tab_title));
        brandCode = bundle.getString(Constants.BundleName.BRAND_CODE);
    }

    @Override
    public int setLayoutId() {
        return R.layout.brand_product_fragment;
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);

        cartNumBg = (ImageView) view.findViewById(R.id.cart_bottom_num_bg);
        cartNumView = (TextView) view.findViewById(R.id.cart_bottom_num_view);
        cartBtn = (RelativeLayout) view.findViewById(R.id.cart_bottom_button);

        productGridView = (PullToRefreshGridView) view.findViewById(R.id.lv_brand_product);
        mNodataRL = (RelativeLayout) view.findViewById(R.id.rl_nodata);
    }

    @Override
    public void initData() {
        titleView.setText(brandName);
        initAdapter();
        initRequest();
    }

    private void initAdapter() {
        productAdapter = new ZoneProductAdapter(brandProductLists, getActivity(), 1, brandHandler);
        mGridView = productGridView.getRefreshableView();
        mGridView.setAdapter(productAdapter);
    }

    @Override
    public void onResume() {
        super.onResume();
        flushCart();
        CartUtils.calculateProductNum(brandProductLists);
        if (productAdapter != null) {
            productAdapter.notifyDataSetChanged();
        }
    }

    @Override
    public void initHttpBack() {
        brandProducHttpBack = new HttpBack<Page<SaleProduct>>(getBaseActivity()) {
            @Override
            public void onSuccess(Page<SaleProduct> data) {
                if (data == null) {
                    mNodataRL.setVisibility(View.VISIBLE);
                    productGridView.setVisibility(View.GONE);
                    return;
                }
                if (data.getPageNum() <= 1) {
                    brandProductLists.clear();
                }
                if (data.getList() != null) {
                    brandProductLists.addAll(data.getList());
                }
                if (brandProductLists.size() == 0) {
                    mNodataRL.setVisibility(View.VISIBLE);
                    productGridView.setVisibility(View.GONE);
                } else {
                    mNodataRL.setVisibility(View.GONE);
                    productGridView.setVisibility(View.VISIBLE);
                }
                pageNum = data.getPageNum() + 1;
                totalPages = data.getTotalPages();

                CartUtils.calculateProductNum(brandProductLists);

                productAdapter.notifyDataSetChanged();
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
            }
        };
    }

    @Override
    public void initRequest() {
        request(1);
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

        productGridView.setOnRefreshListener(new PullToRefreshBase.OnRefreshListener() {
            @Override
            public void onRefreshPullDown() {
                initRequest();
            }

            @Override
            public void onRefreshPullUp() {
                if (pageNum > totalPages) {
                    refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
                    ToastUtils.show(getActivity(), R.string.pull_up_no_more_data);
                    return;
                }
                request(pageNum);
            }
        });
    }

    private void request(Integer mPageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        map.put("brandCode", brandCode);
        map.put("pageNum", mPageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        RetrofitUtils.getInstance(true).searchBrandProduct(ParamUtils.getParam(map), brandProducHttpBack);
    }

    private static class BrandHandler extends Handler {
        WeakReference<BrandProductFragment> fragmentWeakReference;

        public BrandHandler(BrandProductFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            BrandProductFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            SaleProduct product = fragment.brandProductLists.get(msg.arg2);
            switch (msg.what) {
                case Constants.HandlerCode.PRODUCT_PLUS:
                    CartUtils.validateOperationCart(fragment.getActivity(), product, this, msg.obj, msg.arg2);
                    break;
                case Constants.HandlerCode.CLEANPRODUCTFORVIP:
                    fragment.isRefreshItem = false;
                    break;
                case Constants.HandlerCode.CART_SUCCESS:
                    CartUtils.calculateProductNum(fragment.brandProductLists);

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
                        fragment.productAdapter.getItemView(fragment.mGridView, msg.arg2), msg.arg2);
            } else {
                fragment.productAdapter.notifyDataSetChanged();
            }
            fragment.isRefreshItem = true;
        }
    }

    private void flushCart() {
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

    static class RefreshHandler extends Handler {
        private WeakReference<BrandProductFragment> orderWeakReference;

        public RefreshHandler(BrandProductFragment fragment) {
            this.orderWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            BrandProductFragment fragment = orderWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.REFRESH_LIST) {
                fragment.productGridView.onRefreshComplete();
            }
        }
    }
}
