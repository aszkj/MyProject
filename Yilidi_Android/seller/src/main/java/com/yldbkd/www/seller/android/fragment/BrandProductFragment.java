package com.yldbkd.www.seller.android.fragment;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.RefreshLayout;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.adapter.BaseAdapter;
import com.yldbkd.www.seller.android.adapter.ClassProductAdapter;
import com.yldbkd.www.seller.android.bean.BaseModel;
import com.yldbkd.www.seller.android.bean.Page;
import com.yldbkd.www.seller.android.bean.ProductDetail;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.UserUtils;
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
 * update by lizhg on 2017/1/7
 */
public class BrandProductFragment extends BaseFragment {
    private String brandName;
    private String brandCode;
    private RadioGroup radioGroup;
    private RadioButton onLineBtn;
    private RadioButton offLineBtn;
    private View backView;

    private boolean isOnline = true;
    private List<ProductDetail> products = new ArrayList<>();
    private RefreshLayout refreshLayout;
    private RecyclerView productRecyclerView;
    private ClassProductAdapter productAdapter;
    private LinearLayout emptyLayout;

    private RelativeLayout rlBottom;
    private Button confirmBtn;
    private boolean isAll = false;
    private LinearLayout allCheckLayout;
    private ImageView allCheckView;

    private int pageNum = 0;
    private int totalPages = 1;
    private HttpBack<Page<ProductDetail>> productHttpBack;
    private HttpBack<BaseModel> confirmHttpBack;

    private CommonDialog dialog;

    private RefreshHandler refreshHandler = new RefreshHandler(this);

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        brandName = bundle.getString(Constants.BundleName.BRAND_NAME);
        brandCode = bundle.getString(Constants.BundleName.BRAND_CODE);
    }

    @Override
    public int setLayoutId() {
        return R.layout.fragment_brand_product;
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(TextUtils.isEmpty(brandName) ? getString(R.string.title_brand) : brandName);

        View back = view.findViewById(R.id.ll_back_radio_bar);
        back.setVisibility(View.GONE);
        radioGroup = (RadioGroup) view.findViewById(R.id.rg_class_product);
        onLineBtn = (RadioButton) view.findViewById(R.id.rb_class_online);
        offLineBtn = (RadioButton) view.findViewById(R.id.rb_class_offline);

        refreshLayout = (RefreshLayout) view.findViewById(R.id.rl_brand_product);
        refreshLayout.init(getActivity());
        productRecyclerView = (RecyclerView) view.findViewById(R.id.rv_brand_products);
        emptyLayout = (LinearLayout) view.findViewById(R.id.ll_brand_product_empty);

        rlBottom = (RelativeLayout) view.findViewById(R.id.rl_bottom);

        confirmBtn = (Button) view.findViewById(R.id.btn_brand_product_confirm);
        allCheckLayout = (LinearLayout) view.findViewById(R.id.ll_brand_product_all_check);
        allCheckView = (ImageView) view.findViewById(R.id.iv_brand_product_all_check);
    }

    @Override
    public void initAdapter() {
        rlBottom.setVisibility(UserUtils.getStore().getShareFlag() == 1 ? View.GONE : View.VISIBLE);

        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        productRecyclerView.setLayoutManager(layoutManager);
        productRecyclerView.getItemAnimator().setSupportsChangeAnimations(false);
        productAdapter = new ClassProductAdapter(getActivity(), products);
        productRecyclerView.setAdapter(productAdapter);
        productRecyclerView.addItemDecoration(DefaultItemDecoration.getNormal(getActivity()));
    }

    @Override
    public void initRequest() {
        productRequest(1);
    }

    @Override
    public void initHttpBack() {
        productHttpBack = new HttpBack<Page<ProductDetail>>() {
            @Override
            public void onSuccess(Page<ProductDetail> productAllotPage) {
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
                productAdapter.notifyDataSetChanged();
                checkAll();
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
        confirmHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel baseModel) {
                productRequest(1);
            }
        };
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        radioGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                isOnline = checkedId == onLineBtn.getId();
                confirmBtn.setText(isOnline ? R.string.class_product_offline : R.string.class_product_online);
                products.clear();
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
        productAdapter.setOnItemClickListener(new BaseAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                ProductDetail product = products.get(position);
                product.setCheck(!product.isCheck());
                checkAll();
                productAdapter.notifyItemChanged(position, product);
            }
        });
        allCheckLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                isAll = !isAll;
                setAllCheck(isAll);
            }
        });
        confirmBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                confirm();
            }
        });
    }

    private void confirm() {
        List<Integer> checkIds = getCheckIds();
        if (checkIds.size() == 0) {
            ToastUtils.showShort(getActivity(), R.string.no_choice_product);
            return;
        }
        dialog = new CommonDialog(getActivity(), new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                confirmRequest();
                dialog.dismiss();
            }
        });
        dialog.setData(getString(isOnline ? R.string.class_product_choice_off_confirm :
                R.string.class_product_choice_on_confirm), getString(isOnline ? R.string.class_product_offline
                : R.string.class_product_online));
        dialog.show();
    }

    private void productRequest(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        map.put("brandCode", brandCode);
        map.put("enabledFlag", isOnline ? 1 : 2);//上下架标识。默认0。0-全部 1-上架 2-下架
        RetrofitUtils.getInstance(true).searchProductByBrand(ParamUtils.getParam(map), productHttpBack);
    }

    private void confirmRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("saleProductIds", TextUtils.join(",", getCheckIds().toArray()));
        map.put("enabledFlag", isOnline ? 2 : 1);//上下架操作标识。1-上架 2-下架
        RetrofitUtils.getInstance(true).changeProductStatus(ParamUtils.getParam(map), confirmHttpBack);
    }

    private void checkAll() {
        if (products.size() == 0) {
            setAllView(false);
            return;
        }
        boolean isAllCheck = true;
        for (ProductDetail product : products) {
            isAllCheck &= product.isCheck();
        }
        isAll = isAllCheck;
        setAllView(isAll);
    }

    private void setAllCheck(boolean isAll) {
        if (products.size() == 0) {
            this.isAll = false;
            setAllView(false);
            return;
        }
        setAllView(isAll);
        for (ProductDetail product : products) {
            product.setCheck(isAll);
        }
        productAdapter.notifyDataSetChanged();
    }

    private void setAllView(boolean isAll) {
        allCheckView.setBackgroundResource(isAll ? R.mipmap.checkbox_checked : R.mipmap.checkbox_unchecked);
    }

    private void isEmptyView(boolean isEmpty) {
        emptyLayout.setVisibility(isEmpty ? View.VISIBLE : View.GONE);
        refreshLayout.setVisibility(isEmpty ? View.GONE : View.VISIBLE);
    }

    private List<Integer> getCheckIds() {
        List<Integer> checkProductIds = new ArrayList<>();
        for (ProductDetail product : products) {
            if (product.isCheck()) {
                checkProductIds.add(product.getSaleProductId());
            }
        }
        return checkProductIds;
    }

    private static class RefreshHandler extends Handler {
        private WeakReference<BrandProductFragment> productWeakReference;

        public RefreshHandler(BrandProductFragment fragment) {
            this.productWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            BrandProductFragment fragment = productWeakReference.get();
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
