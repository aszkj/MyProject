package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.activity.ProductActivity;
import com.yldbkd.www.buyer.android.activity.PurchaseActivity;
import com.yldbkd.www.buyer.android.activity.StoreActivity;
import com.yldbkd.www.buyer.android.adapter.ProductAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Page;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.AnimUtils;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshBase;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshGridView;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by HP on 2015/11/5.
 */
public class StoreSearchProductFragment extends BaseFragment {
    private PullToRefreshGridView productGridView;
    private GridView mGridView;
    private ProductAdapter productAdapter;
    private StoreHandler homeHandler = new StoreHandler(this);
    private List<SaleProduct> saleProductList = new ArrayList<>();
    private HttpBack<Page<SaleProduct>> productHttpBack;
    private String keyword;
    private int storeID;
    private String storeCartPromote;
    private Integer mPageNum;
    private Integer totalPages;
    private ClearableEditText searchTextView;
    private TextView searchBtn;
    private View backView;

    private RelativeLayout cartBtn;
    private ImageView cartNumBg;
    private TextView cartNumView;

    private RelativeLayout mNodataRL;

    private Handler refreshHandler = new RefreshHandler(this);


    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        storeID = bundle.getInt(Constants.BundleName.STORE_ID);
        keyword = bundle.getString(Constants.BundleName.SEARCH_KEYWORD);
        storeCartPromote = bundle.getString(Constants.BundleName.STORE_CART_PROMOTE);
    }

    @Override
    public int setLayoutId() {
        return R.layout.store_search_product_fragment;
    }

    @Override
    public void initView(View view) {
        productGridView = (PullToRefreshGridView) view.findViewById(R.id.gv_search_product);
        searchTextView = (ClearableEditText) view.findViewById(R.id.search_text_view);
        searchTextView.setHint(getText(R.string.store_please_input_product_name));
        searchBtn = (TextView) view.findViewById(R.id.right_view);
        backView = view.findViewById(R.id.back_view);
        searchTextView.setText(keyword);
        TextView bottomTextView = (TextView) view.findViewById(R.id.cart_bottom_text_view);
        if (!TextUtils.isEmpty(storeCartPromote)) {
            bottomTextView.setText(storeCartPromote);
        }
        cartBtn = (RelativeLayout) view.findViewById(R.id.cart_bottom_button);
        cartNumBg = (ImageView) view.findViewById(R.id.cart_bottom_num_bg);
        cartNumView = (TextView) view.findViewById(R.id.cart_bottom_num_view);
        mNodataRL = (RelativeLayout) view.findViewById(R.id.rl_nodata);
    }

    @Override
    public void initData() {
        initAdapter();
        initRequest();
    }

    @Override
    public void onResume() {
        super.onResume();
        flushCart();
    }

    @Override
    public void initHttpBack() {
        productHttpBack = new HttpBack<Page<SaleProduct>>(getBaseActivity()) {
            @Override
            public void onSuccess(Page<SaleProduct> data) {
                if (data == null) {// 数据不存在
                    ToastUtils.show(getActivity(), String.format(getString(R.string.store_no_search_product), keyword));
                    return;
                }
                if (data.getTotalRecords() == 0) {
                    mNodataRL.setVisibility(View.VISIBLE);
                    productGridView.setVisibility(View.GONE);
                    return;
                } else {
                    mNodataRL.setVisibility(View.GONE);
                    productGridView.setVisibility(View.VISIBLE);
                }
                if (data.getPageNum() == 1) {
                    saleProductList.clear();
                }
                mPageNum = data.getPageNum() + 1;
                totalPages = data.getTotalPages();
                saleProductList.addAll(data.getList());
                CartUtils.calculateProductNum(saleProductList);
                productAdapter.notifyDataSetChanged();
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
            }

            @Override
            public void onTimeOut() {
                super.onTimeOut();
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
        productGridView.setOnRefreshListener(new PullToRefreshBase.OnRefreshListener() {
            @Override
            public void onRefreshPullDown() {
                request(1);
            }

            @Override
            public void onRefreshPullUp() {
                if (mPageNum > totalPages) {
                    refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
                    ToastUtils.show(getActivity(), R.string.pull_up_no_more_data);
                    return;
                }
                request(mPageNum);
            }
        });

        searchBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                keyword = searchTextView.getText().toString();
                if (TextUtils.isEmpty(keyword.trim())) {
                    ToastUtils.show(getActivity(), R.string.search_location_empty_notify);
                    return;
                }
                if (CheckUtils.isConSpeCharacters(keyword.trim())) {
                    ToastUtils.show(getActivity(), R.string.search_error_notify);
                    return;
                }
                KeyboardUtils.close(getActivity());
                request(1);
            }
        });
        searchTextView.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (EditorInfo.IME_ACTION_SEARCH == i) {
                    keyword = textView.getText().toString();
                    if (TextUtils.isEmpty(keyword.trim())) {
                        ToastUtils.show(getActivity(), R.string.search_location_empty_notify);
                        return false;
                    }
                    if (CheckUtils.isConSpeCharacters(keyword.trim())) {
                        ToastUtils.show(getActivity(), R.string.search_error_notify);
                        return false;
                    }
                    KeyboardUtils.close(getActivity(), searchTextView);
                    request(1);
                }
                return false;
            }
        });

        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(getActivity());
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
                    intent = new Intent(getBaseActivity(), LoginActivity.class);
                    intent.setAction(LoginFragment.class.getSimpleName());
                    startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
                }
            }
        });
    }

    private void request(Integer mPageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("keyword", keyword);
        map.put("pageNum", mPageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        RetrofitUtils.getInstance(true).searchProducts(ParamUtils.getParam(map), productHttpBack);
    }

    private void initAdapter() {
        productAdapter = new ProductAdapter(saleProductList, getActivity(), 1, homeHandler);
        mGridView = productGridView.getRefreshableView();
        mGridView.setAdapter(productAdapter);
    }

    private static class StoreHandler extends Handler {
        WeakReference<StoreSearchProductFragment> fragmentWeakReference;

        public StoreHandler(StoreSearchProductFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            StoreSearchProductFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            SaleProduct product = fragment.saleProductList.get(msg.arg2);
            switch (msg.what) {
                case Constants.HandlerCode.PRODUCT_PLUS:
                    CartUtils.validateOperationCart(fragment.getActivity(), product, this, msg.obj);
                    break;
                case Constants.HandlerCode.CART_SUCCESS:
                    CartUtils.calculateProductNum(fragment.saleProductList);
                    fragment.flushCart();
                    int[] startLocation = (int[]) msg.obj;
                    int[] endLocation = new int[2];
                    fragment.cartNumView.getLocationInWindow(endLocation);
                    AnimUtils.setAddCartAnim(fragment.getBaseActivity(), startLocation, endLocation,
                            fragment.cartNumBg, fragment.cartNumView, fragment.cartBtn);
                    break;
                case Constants.HandlerCode.PRODUCT_MINUS:
                    product.setCartNum(product.getCartNum() - 1);
                    CartUtils.removeCart(product);
                    fragment.flushCart();
                    break;
                case Constants.HandlerCode.PRODUCT_DETAIL:
                    Intent intent = new Intent(fragment.getActivity(), ProductActivity.class);
                    intent.putExtra(Constants.BundleName.SALE_PRODUCT_ID, product.getSaleProductId());
//                    intent.putExtra(Constants.BundleName.STORE_ID, fragment.storeID);
                    fragment.startActivity(intent);
                    break;
                case Constants.HandlerCode.PRODUCT_MORE:
                    Intent moreIntent = new Intent(fragment.getActivity(), StoreActivity.class);
                    moreIntent.putExtra(Constants.BundleName.STORE_ID, fragment.storeID);
                    fragment.startActivity(moreIntent);
                    break;
            }
            fragment.productAdapter.notifyDataSetChanged();
        }
    }

    public void flushCart() {
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

    static class RefreshHandler extends Handler {
        private WeakReference<StoreSearchProductFragment> orderWeakReference;

        public RefreshHandler(StoreSearchProductFragment fragment) {
            this.orderWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            StoreSearchProductFragment fragment = orderWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.REFRESH_LIST) {
                fragment.productGridView.onRefreshComplete();
            }
        }
    }
}
