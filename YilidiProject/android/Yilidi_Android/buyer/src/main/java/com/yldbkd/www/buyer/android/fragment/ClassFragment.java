package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.content.ContextCompat;
import android.text.TextUtils;
import android.view.MotionEvent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.activity.ProductActivity;
import com.yldbkd.www.buyer.android.activity.PurchaseActivity;
import com.yldbkd.www.buyer.android.activity.SearchActivity;
import com.yldbkd.www.buyer.android.adapter.ClassProductAdapter;
import com.yldbkd.www.buyer.android.adapter.ClassifyAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Classification;
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
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshBase;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshListView;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 类型Fragment
 * <p/>
 * Created by linghuxj on 15/10/9.
 */
public class ClassFragment extends BaseFragment {

    //title
    private RelativeLayout backView;
    private TextView searchBtn;
    //没有商品
    private RelativeLayout rlNoData;
    //排序
    private LinearLayout mLmPriceSort;
    private LinearLayout mLmSaleSort;
    private ImageView mSaleDownImage;
    private ImageView mSaleUpImage;
    private ImageView mPriceUpImage;
    private ImageView mPriceDownImage;
    private TextView mTvSale;
    private TextView mTvPrice;

    //类目列表
    private List<Classification> classifyList = new ArrayList<>();
    private ListView mainTypeListView;
    private ClassifyAdapter classifyAdapter;
    private PullToRefreshListView refreshListView;
    private ListView productsListView;
    private List<SaleProduct> saleProductList = new ArrayList<>();
    private ClassProductAdapter productAdapter;
    private Integer sortBy = 1;//1低到高 2高到低
    private Integer orderBy = 1;//1价格 2销量

    private HttpBack<List<Classification>> classHttpBack;
    private HttpBack<Page<SaleProduct>> productHttpBack;

    private StoreHandler storeHandler = new StoreHandler(this);
    private Handler refreshHandler = new RefreshHandler(this);

    private String mClassCode = "";
    boolean isSalesUpToDown = true;
    boolean isPriceUpToDown = true;
    private int mPageNum = 1, totalPages;
    private RelativeLayout cartBtn;
    private ImageView cartNumBg;
    private TextView cartNumView;
    private LinearLayout mLlsearch;
    private int clickPosition = 0;
    private ClearableEditText mSearchTextView;
    private RelativeLayout mNodataRL;
    private ListView listView;
    private int detailItem;
    private Integer mCurrentStoreId;


    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        //获取类型code
        mClassCode = bundle.getString(Constants.BundleName.CLASS_CODE, "");
    }

    @Override
    public int setLayoutId() {
        return R.layout.class_fragment;
    }

    @Override
    public void initView(View view) {
        //title
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        mLlsearch = (LinearLayout) view.findViewById(R.id.search_layout);
        mSearchTextView = (ClearableEditText) view.findViewById(R.id.search_text_view);
        searchBtn = (TextView) view.findViewById(R.id.right_view);
        searchBtn.setVisibility(View.INVISIBLE);
        mLlsearch.setFocusable(true);
        mLlsearch.setFocusableInTouchMode(true);

        KeyboardUtils.close(getActivity());
        //        titleView = (TextView) view.findViewById(R.id.title_view);
        //cart
        cartBtn = (RelativeLayout) view.findViewById(R.id.cart_bottom_button);
        cartNumBg = (ImageView) view.findViewById(R.id.cart_bottom_num_bg);
        cartNumView = (TextView) view.findViewById(R.id.cart_bottom_num_view);
        //排序
        mLmSaleSort = (LinearLayout) view.findViewById(R.id.ll_sale_sort);
        mLmPriceSort = (LinearLayout) view.findViewById(R.id.ll_price_sort);
        mPriceUpImage = (ImageView) view.findViewById(R.id.price_up_image);
        mPriceDownImage = (ImageView) view.findViewById(R.id.price_down_image);
        mSaleUpImage = (ImageView) view.findViewById(R.id.sale_up_image);
        mSaleDownImage = (ImageView) view.findViewById(R.id.sale_down_image);
        mTvPrice = (TextView) view.findViewById(R.id.tv_price_sort);
        mTvSale = (TextView) view.findViewById(R.id.tv_sale_sort);

        mNodataRL = (RelativeLayout) view.findViewById(R.id.rl_noData);
        mainTypeListView = (ListView) view.findViewById(R.id.product_list_mainType);
        refreshListView = (PullToRefreshListView) view.findViewById(R.id.product_list_layout);
        listView = refreshListView.getRefreshableView();

    }

    @Override
    public void initData() {
        mCurrentStoreId = CommunityUtils.getCurrentStoreId();
        initAdapter();
        initRequest();
    }

    @Override
    public void onResume() {
        super.onResume();
        flushCart();
        CartUtils.calculateProductNum(saleProductList);
        if (productAdapter != null) {
            productAdapter.notifyDataSetChanged();
        }
    }

    @Override
    public void initRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("parentClassCode", Constants.ClassType.TOP_CLASS);
        map.put("storeId", mCurrentStoreId);
        RetrofitUtils.getInstance(true).getProductType(ParamUtils.getParam(map), classHttpBack);
    }

    @Override
    public void initHttpBack() {
        classHttpBack = new HttpBack<List<Classification>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<Classification> classifications) {
                classifyList.clear();
                if (classifications != null && classifications.size() > 0) {
                    classifyList.addAll(classifications);
                    if (TextUtils.isEmpty(mClassCode)) {
                        //默认选择第一大分类
                        chooseDefaultType(classifications);
                    } else {
                        checkedType();
                    }
                    //传入了mClassCode，但是mClassCode不在我们默认列表中，默认选中第一个
                    if (clickPosition >= classifyList.size()) {
                        chooseDefaultType(classifyList);
                    }
                    //选中的条目
                    classifyAdapter.setSelectItem(clickPosition);
                    getProductsByMainType(1);
                } else {
                    ToastUtils.showShort(getActivity(), R.string.type_noData);
                }
                classifyAdapter.notifyDataSetChanged();
            }
        };
        productHttpBack = new HttpBack<Page<SaleProduct>>(getBaseActivity()) {
            @Override
            public void onSuccess(Page<SaleProduct> data) {
                if (data == null) {
                    mNodataRL.setVisibility(View.VISIBLE);
                    refreshListView.setVisibility(View.GONE);
                    return;
                }
                if (data.getPageNum() == 1) {
                    saleProductList.clear();
                }
                if (data.getList() != null) {
                    saleProductList.addAll(data.getList());
                }
                if (saleProductList.size() == 0) {
                    mNodataRL.setVisibility(View.VISIBLE);
                    refreshListView.setVisibility(View.GONE);
                } else {
                    mNodataRL.setVisibility(View.GONE);
                    refreshListView.setVisibility(View.VISIBLE);
                }
                mPageNum = data.getPageNum() + 1;
                totalPages = data.getTotalPages();
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

    private void checkedType() {
        for (Classification classInfo : classifyList) {
            if (mClassCode.equals(classInfo.getClassCode())) {
                break;
            }
            clickPosition++;
        }
    }

    private void chooseDefaultType(List<Classification> classifications) {
        clickPosition = 0;
        mClassCode = classifications.get(0).getClassCode();
    }

    @Override
    public void initListener() {
        mLlsearch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), SearchActivity.class);
                intent.setAction(SearchFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
        mSearchTextView.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                if (event.getAction() == MotionEvent.ACTION_DOWN) {
                    Intent intent = new Intent(getActivity(), SearchActivity.class);
                    intent.setAction(SearchFragment.class.getSimpleName());
                    startActivity(intent);
                    return true;
                }
                return false;
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
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        mLmPriceSort.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                sortBy = isPriceUpToDown ? 1 : 2;
                isPriceUpToDown = !isPriceUpToDown;
                orderBy = 1;
                showSortRule(orderBy, sortBy);
                getProductsByMainType(1);
            }
        });
        mLmSaleSort.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                sortBy = isSalesUpToDown ? 1 : 2;
                isSalesUpToDown = !isSalesUpToDown;
                orderBy = 2;
                showSortRule(orderBy, sortBy);
                getProductsByMainType(1);
            }
        });

        mainTypeListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                if (position != clickPosition) {
                    clickPosition = position;
                    classifyAdapter.setSelectItem(clickPosition);
                } else {
                    clickPosition = -1;
                }
                classifyAdapter.notifyDataSetChanged();
                Classification classification = classifyList.get(position);
                mClassCode = classification.getClassCode();
                getProductsByMainType(1);
            }
        });
        refreshListView.setOnRefreshListener(new PullToRefreshBase.OnRefreshListener() {
            @Override
            public void onRefreshPullDown() {
                //下拉刷新
                //如果没有大类数据
                if (classifyList.size() <= 0) {
                    initRequest();
                } else {
                    //如果有大类数据
                    getProductsByMainType(1);
                }
            }

            @Override
            public void onRefreshPullUp() {
                //上拉加载更多
                if (mPageNum > totalPages) {
                    refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
                    ToastUtils.showShort(getActivity(), R.string.pull_up_no_more_data);
                    return;
                }
                getProductsByMainType(mPageNum);
            }
        });
        productsListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                detailItem = position;
                Intent intent = new Intent(getActivity(), ProductActivity.class);
                intent.putExtra(Constants.BundleName.SALE_PRODUCT_ID, saleProductList.get(position).getSaleProductId());
                startActivityForResult(intent, Constants.RequestCode.PRODUCT_DETAIL_CODE);
            }
        });
    }

    /**
     * 通过类型查询商品
     */
    private void getProductsByMainType(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("classCode", mClassCode);
        map.put("storeId", mCurrentStoreId);
        map.put("orderBy", orderBy);
        map.put("sortBy", sortBy);
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);

        RetrofitUtils.getInstance(true).searchProducts(ParamUtils.getParam(map), productHttpBack);
    }

    private void initAdapter() {
        classifyAdapter = new ClassifyAdapter(classifyList, getActivity());
        //单选模式
        mainTypeListView.setChoiceMode(ListView.CHOICE_MODE_SINGLE);

        mainTypeListView.setAdapter(classifyAdapter);
        productAdapter = new ClassProductAdapter(saleProductList, getActivity(), 1, storeHandler);
        productsListView = refreshListView.getRefreshableView();
        productsListView.setAdapter(productAdapter);
    }

    private void flushCart() {
        Integer count = CartUtils.getCartCount();
        if (count > 0) {
            //            cartBtn.setBackgroundResource(R.drawable.search_cart_full_selector);
            cartNumBg.setVisibility(View.VISIBLE);
            cartNumView.setVisibility(View.VISIBLE);
            if (count > 99) {
                cartNumView.setText(getString(R.string.num_too_much));
                cartNumView.setTextSize(5f);
            } else {
                cartNumView.setText(String.valueOf(count));
                cartNumView.setTextSize(10f);
            }
        } else {
            //            cartBtn.setBackgroundResource(R.drawable.search_cart_none_selector);
            cartNumBg.setVisibility(View.INVISIBLE);
            cartNumView.setVisibility(View.INVISIBLE);
        }
    }

    private static class StoreHandler extends Handler {
        WeakReference<ClassFragment> fragmentWeakReference;

        public StoreHandler(ClassFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            ClassFragment fragment = fragmentWeakReference.get();
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
                    fragment.productAdapter.notifyDataSetChanged();

                    int[] startLocation = (int[]) msg.obj;
                    int[] endLocation = new int[2];
                    fragment.cartNumView.getLocationInWindow(endLocation);
                    AnimUtils.setAddCartAnim(fragment.getBaseActivity(), startLocation, endLocation, fragment.cartNumBg,
                            fragment.cartNumView, null);
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
                    fragment.startActivityForResult(intent, Constants.RequestCode.PRODUCT_DETAIL_CODE);
            }
            fragment.productAdapter.notifyDataSetChanged();
        }
    }

    static class RefreshHandler extends Handler {
        private WeakReference<ClassFragment> orderWeakReference;

        public RefreshHandler(ClassFragment fragment) {
            this.orderWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            ClassFragment fragment = orderWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.REFRESH_LIST) {
                fragment.refreshListView.onRefreshComplete();
            }
        }
    }

    public void showSortRule(int orderType, int sortType) {
        boolean isPriceOrder = orderType == 1;
        boolean isUpToDown = sortType == 1;
        mTvPrice.setTextColor(ContextCompat.getColor(getActivity(), isPriceOrder ? R.color.colorYellow : R.color.primaryText));
        mTvSale.setTextColor(ContextCompat.getColor(getActivity(), isPriceOrder ? R.color.primaryText : R.color.colorYellow));
        showChooseStatus(mSaleUpImage, mSaleDownImage, mPriceUpImage, mPriceDownImage,
                isPriceOrder, isUpToDown);
    }

    public void showChooseStatus(ImageView view1, ImageView view2, ImageView view3,
                                 ImageView view4, boolean isPrice, boolean isUp) {
        if (isPrice) {
            view1.setImageResource(R.mipmap.up);
            view2.setImageResource(R.mipmap.down);
            view3.setImageResource(isUp ? R.mipmap.up_press : R.mipmap.up);
            view4.setImageResource(isUp ? R.mipmap.down : R.mipmap.down_press);
        } else {
            view1.setImageResource(isUp ? R.mipmap.up_press : R.mipmap.up);
            view2.setImageResource(isUp ? R.mipmap.down : R.mipmap.down_press);
            view3.setImageResource(R.mipmap.up);
            view4.setImageResource(R.mipmap.down);
        }
    }
}