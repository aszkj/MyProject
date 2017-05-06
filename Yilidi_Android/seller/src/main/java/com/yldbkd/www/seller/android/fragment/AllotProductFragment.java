package com.yldbkd.www.seller.android.fragment;

import android.content.Intent;
import android.os.Handler;
import android.os.Message;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.RefreshLayout;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.AllotCartActivity;
import com.yldbkd.www.seller.android.activity.AllotOrderListActivity;
import com.yldbkd.www.seller.android.adapter.AllotProductAdapter;
import com.yldbkd.www.seller.android.adapter.BaseAdapter;
import com.yldbkd.www.seller.android.adapter.ClassAdapter;
import com.yldbkd.www.seller.android.bean.AllotOrderConfirm;
import com.yldbkd.www.seller.android.bean.ClassBean;
import com.yldbkd.www.seller.android.bean.Page;
import com.yldbkd.www.seller.android.bean.ProductAllot;
import com.yldbkd.www.seller.android.utils.CartUtils;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;
import com.yldbkd.www.seller.android.viewCustomer.DefaultItemDecoration;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 商品分类列表页面
 * <p/>
 * Created by linghuxj on 16/6/3.
 */
public class AllotProductFragment extends BaseFragment {

    private LinearLayout backView;
    private ImgTxtButton allotOrderView;

    private ClassBean checkClass;
    private List<ClassBean> classList = new ArrayList<>();
    private RecyclerView classRecyclerView;
    private ClassAdapter classAdapter;

    private TextView classNameView;
    private List<ProductAllot> products = new ArrayList<>();
    private RefreshLayout refreshLayout;
    private RecyclerView productRecyclerView;
    private AllotProductAdapter productAdapter;
    private LinearLayout emptyLayout;

    private Button confirmBtn;
    private TextView totalCountView;

    private int pageNum = 0;
    private int totalPages = 1;
    private HttpBack<List<ClassBean>> classHttpBack;
    private HttpBack<Page<ProductAllot>> productHttpBack;
    private HttpBack<AllotOrderConfirm> confirmHttpBack;

    private CartHandler cartHandler = new CartHandler(this);
    private RefreshHandler refreshHandler = new RefreshHandler(this);

    @Override
    public int setLayoutId() {
        return R.layout.fragment_allot_product;
    }

    @Override
    public void initHttpBack() {
        classHttpBack = new HttpBack<List<ClassBean>>() {
            @Override
            public void onSuccess(List<ClassBean> classBeen) {
                if (classBeen == null || classBeen.size() == 0) {
                    isEmptyView(true);
                    return;
                }
                classList.clear();
                classList.addAll(classBeen);
                checkClass = classList.get(0);
                setCheckClass();
                classAdapter.notifyDataSetChanged();
                productRequest(1);
            }
        };
        productHttpBack = new HttpBack<Page<ProductAllot>>() {
            @Override
            public void onSuccess(Page<ProductAllot> productAllotPage) {
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
                if (productAllotPage == null || productAllotPage.getTotalRecords() <= 0) {
                    isEmptyView(true);
                    return;
                }
                isEmptyView(false);
                pageNum = productAllotPage.getPageNum();
                totalPages = productAllotPage.getTotalPages();
                if (pageNum <= 1) {
                    products.clear();
                }
                products.addAll(productAllotPage.getList());
                CartUtils.calculateProductNum(products);
                productAdapter.notifyDataSetChanged();
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
            }

            @Override
            public void onTimeOut() {
                super.onTimeOut();
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
            }
        };
        confirmHttpBack = new HttpBack<AllotOrderConfirm>() {
            @Override
            public void onSuccess(AllotOrderConfirm allotOrderConfirm) {
                Intent intent = new Intent(getActivity(), AllotCartActivity.class);
                intent.setAction(AllotCartFragment.class.getSimpleName());
                intent.putExtra(Constants.BundleName.ALLOT_ORDER_CONFIRM_INFO, allotOrderConfirm);
                startActivity(intent);
            }
        };
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_allot_product));
        allotOrderView = (ImgTxtButton) view.findViewById(R.id.itb_right);
        allotOrderView.setImgResource(R.mipmap.catalog);

        classNameView = (TextView) view.findViewById(R.id.tv_allot_class_name);
        classRecyclerView = (RecyclerView) view.findViewById(R.id.rv_allot_class_list);
        refreshLayout = (RefreshLayout) view.findViewById(R.id.rl_allot_product);
        refreshLayout.init(getActivity());
        productRecyclerView = (RecyclerView) view.findViewById(R.id.rv_allot_products);
        emptyLayout = (LinearLayout) view.findViewById(R.id.ll_allot_product_empty);

        confirmBtn = (Button) view.findViewById(R.id.btn_allot_product_confirm);
        totalCountView = (TextView) view.findViewById(R.id.tv_allot_product_total_count);
    }

    @Override
    public void initAdapter() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        classRecyclerView.setLayoutManager(layoutManager);
        classAdapter = new ClassAdapter(getActivity(), classList);
        classRecyclerView.setAdapter(classAdapter);

        layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        productRecyclerView.setLayoutManager(layoutManager);
        productRecyclerView.getItemAnimator().setSupportsChangeAnimations(false);
        productAdapter = new AllotProductAdapter(getActivity(), products, cartHandler);
        productRecyclerView.setAdapter(productAdapter);
        productRecyclerView.addItemDecoration(DefaultItemDecoration.getDefault(getActivity()));
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        allotOrderView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getActivity(), AllotOrderListActivity.class));
            }
        });
        classAdapter.setOnItemClickListener(new BaseAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                int index = 0;
                for (ClassBean clazz : classList) {
                    if (index == position) {
                        checkClass = clazz;
                        setCheckClass();
                    } else {
                        clazz.setCheck(false);
                    }
                    index++;
                }
                classAdapter.notifyDataSetChanged();
                productRequest(1);
            }
        });
        refreshLayout.setRefreshListener(new RefreshLayout.OnDataRefreshListener() {
            @Override
            public void onDataRefresh() {
                productRequest(1);
            }
        });
        refreshLayout.setLoadListener(new RefreshLayout.OnDataLoadListener() {
            @Override
            public void onDataLoad() {
                if (pageNum >= totalPages) {
                    ToastUtils.showShort(getActivity(), R.string.pull_up_no_more_data);
                    refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
                    return;
                }
                productRequest(++pageNum);
            }
        });
        confirmBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                confirmRequest();
            }
        });
    }

    @Override
    public void initRequest() {
        classRequest();
    }

    @Override
    public void onResume() {
        super.onResume();
        flushCart();
    }

    private void setCheckClass() {
        checkClass.setCheck(true);
        classNameView.setText(checkClass.getClassName());
        totalCountView.setText(String.format(getString(R.string.allot_product_total), CartUtils.getCartCount()));
    }

    private void flushCart() {
        CartUtils.calculateProductNum(products);
        productAdapter.notifyDataSetChanged();
        totalCountView.setText(String.format(getString(R.string.allot_product_total), CartUtils.getCartCount()));
    }

    private void classRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("parentClassCode", Constants.TOP_CLASS);
        RetrofitUtils.getInstance(true).productTypes(ParamUtils.getParam(map), classHttpBack);
    }

    private void productRequest(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        map.put("classCode", checkClass.getClassCode());
        RetrofitUtils.getInstance(true).searchAllotProducts(ParamUtils.getParam(map), productHttpBack);
    }

    private void confirmRequest() {
        Map<String, Object> map = new HashMap<>();
        List<CartUtils.CartInfo> cartInfo = CartUtils.getCartInfo();
        if (cartInfo == null || cartInfo.size() == 0) {
            ToastUtils.show(getActivity(), R.string.allot_product_error_empty);
            return;
        }
        map.put("allotInfo", cartInfo);
        RetrofitUtils.getInstance(true).confirmAllotOrder(ParamUtils.getParam(map), confirmHttpBack);
    }

    private void isEmptyView(boolean isEmpty) {
        emptyLayout.setVisibility(isEmpty ? View.VISIBLE : View.GONE);
        refreshLayout.setVisibility(isEmpty ? View.GONE : View.VISIBLE);
    }

    private void cart(int position, boolean isAdd) {
        ProductAllot product = products.get(position);
        Integer totalCount = isAdd ? CartUtils.addCart(getActivity(), product.getSaleProductId(),
                product.getWarehouseCount(), product.getPerAllotCount()) : CartUtils.removeCart(
                product.getSaleProductId(), product.getPerAllotCount());
        Integer cartNum = CartUtils.carts.get(product.getSaleProductId());
        product.setCartNum(cartNum == null ? 0 : cartNum);
        productAdapter.notifyItemChanged(position, product);
        totalCountView.setText(String.format(getString(R.string.allot_product_total), totalCount));
    }

    private static class CartHandler extends Handler {
        private WeakReference<AllotProductFragment> productWeakReference;

        public CartHandler(AllotProductFragment fragment) {
            this.productWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            AllotProductFragment fragment = productWeakReference.get();
            if (fragment == null) {
                return;
            }
            fragment.cart((Integer) msg.obj, Constants.HandlerCode.PRODUCT_PLUS == msg.what);
        }
    }

    private static class RefreshHandler extends Handler {
        private WeakReference<AllotProductFragment> productWeakReference;

        public RefreshHandler(AllotProductFragment fragment) {
            this.productWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            AllotProductFragment fragment = productWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.REFRESH_COMPLETE) {
                fragment.refreshLayout.setRefreshing(false);
                fragment.refreshLayout.setLoadMore(false);
            }
        }
    }
}
