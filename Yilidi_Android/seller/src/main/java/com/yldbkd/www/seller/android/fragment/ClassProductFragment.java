package com.yldbkd.www.seller.android.fragment;

import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.RelativeLayout;

import com.yldbkd.www.library.android.common.DisplayUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.RefreshLayout;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.SearchActivity;
import com.yldbkd.www.seller.android.adapter.BaseAdapter;
import com.yldbkd.www.seller.android.adapter.ClassProductAdapter;
import com.yldbkd.www.seller.android.adapter.PopupWindowAdapter;
import com.yldbkd.www.seller.android.bean.BaseModel;
import com.yldbkd.www.seller.android.bean.ClassBean;
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
public class ClassProductFragment extends BaseFragment {
    private int position;
    private ClassBean mClassBean;
    private boolean isSecType = false;
    private List<ClassBean> subClassList;

    private RadioGroup radioGroup;
    private RadioButton onLineBtn;
    private View backView;
    private View mSearchBtn;
    private boolean isOnline = true;

    private boolean isStock = true;
    private boolean isUpToDown = false;
    private boolean isDefault = true;
    private RadioGroup classRadioGroup;
    private RadioButton thirdClassBtn;
    private RadioButton sortBtn;
    private PopupWindow mPopupWindow;
    private RecyclerView popupwindowRecycle;

    private List<ProductDetail> products = new ArrayList<>();
    private LinearLayout llProductView;
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

    private int[] sortMenu = {R.string.class_default_sort, R.string.class_sale_up_to_down, R.string.class_sale_down_to_up,
            R.string.class_stock_up_to_down, R.string.class_stock_down_to_up};
    private PopupWindowAdapter mPopAdapter;
    private LinearLayout.LayoutParams mLayoutParams;
    private GridLayoutManager gridLayoutManager;
    private int classChoosePosition = 0;
    private int sortChoosePosition = 0;
    private String classCode;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        mClassBean = (ClassBean) bundle.getSerializable(Constants.BundleName.CLASSITY_DATA);
        position = bundle.getInt(Constants.BundleName.CLASSITY_CHECKED);
        classChoosePosition = position;
        subClassList = mClassBean.getSubClassList();
        isSecType = subClassList == null || subClassList.size() == 0;
        classCode = isSecType ? mClassBean.getClassCode() : subClassList.get(position).getClassCode();
    }

    @Override
    public int setLayoutId() {
        return R.layout.fragment_class_product;
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.ll_back_radio_bar);
        radioGroup = (RadioGroup) view.findViewById(R.id.rg_class_product);
        onLineBtn = (RadioButton) view.findViewById(R.id.rb_class_online);
        mSearchBtn = view.findViewById(R.id.ll_class_product_search);
        mSearchBtn.setVisibility(View.VISIBLE);

        classRadioGroup = (RadioGroup) view.findViewById(R.id.rg_class_sort);
        thirdClassBtn = (RadioButton) view.findViewById(R.id.rb_class_stock_sort);
        sortBtn = (RadioButton) view.findViewById(R.id.rb_class_sale_sort);

        llProductView = (LinearLayout) view.findViewById(R.id.ll_product_view);
        refreshLayout = (RefreshLayout) view.findViewById(R.id.rl_class_product);
        refreshLayout.init(getActivity());
        productRecyclerView = (RecyclerView) view.findViewById(R.id.rv_class_products);
        emptyLayout = (LinearLayout) view.findViewById(R.id.ll_class_product_empty);

        rlBottom = (RelativeLayout) view.findViewById(R.id.rl_bottom);

        confirmBtn = (Button) view.findViewById(R.id.btn_class_product_confirm);
        allCheckLayout = (LinearLayout) view.findViewById(R.id.ll_class_product_all_check);
        allCheckView = (ImageView) view.findViewById(R.id.iv_class_product_all_check);
    }

    @Override
    public void initData() {
        thirdClassBtn.setText(isSecType ? mClassBean.getClassName() : subClassList.get(position).getClassName());
        sortBtn.setText(getResources().getString(sortMenu[0]));
        rlBottom.setVisibility(UserUtils.getStore().getShareFlag() == 1 ? View.GONE : View.VISIBLE);
    }

    @Override
    public void initAdapter() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        productRecyclerView.setLayoutManager(layoutManager);
        productRecyclerView.getItemAnimator().setSupportsChangeAnimations(false);
        productAdapter = new ClassProductAdapter(getActivity(), products);
        productRecyclerView.setAdapter(productAdapter);
        productRecyclerView.addItemDecoration(DefaultItemDecoration.getNormal(getActivity()));
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
    public void initRequest() {
        productRequest(1);
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
        mSearchBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), SearchActivity.class);
                intent.setAction(ProductSearchRecordFragment.class.getSimpleName());
                startActivity(intent);
            }
        });

        thirdClassBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (isSecType || subClassList.size() <= 1) {
                    return;
                }
                showPopupwindow(v, true);
                changePopupwindowStatus(true);
            }
        });
        sortBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showPopupwindow(v, false);
                changePopupwindowStatus(false);
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

    private void showPopupwindow(View view, final boolean isClass) {
        if (mPopupWindow != null && mPopupWindow.isShowing()) {
            mPopupWindow.dismiss();
            return;
        }
        changePopupwindowStatus(isClass);

        LayoutInflater inflater = (LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View popView = inflater.inflate(R.layout.class_sort_layout, null);
        if (mPopupWindow == null) {
            mPopupWindow = new PopupWindow(popView, WindowManager.LayoutParams.MATCH_PARENT,
                    WindowManager.LayoutParams.MATCH_PARENT, true);
        }
        mPopupWindow.setOutsideTouchable(true);
        mPopupWindow.setBackgroundDrawable(new ColorDrawable(0x00000000));
        mPopupWindow.showAsDropDown(view);

        popupwindowRecycle = (RecyclerView) popView.findViewById(R.id.popupwindow_recycle_view);
        View popupwindowEmptyView = popView.findViewById(R.id.popupwindow_empty_view);
        //指定recycleView高度
        int typeCount = isClass ? subClassList.size() : sortMenu.length;
        if (mLayoutParams == null) {
            mLayoutParams = (LinearLayout.LayoutParams) popupwindowRecycle.getLayoutParams();
        }
        mLayoutParams.height = (int) (90f / 3 * DisplayUtils.density + 0.5) * (typeCount % 4 > 0 ? typeCount / 4 + 1 : typeCount / 4);
        mLayoutParams.width = WindowManager.LayoutParams.MATCH_PARENT;
        popupwindowRecycle.setLayoutParams(mLayoutParams);

        if (gridLayoutManager == null) {
            gridLayoutManager = new GridLayoutManager(getActivity(), 4);
            gridLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
            popupwindowRecycle.setLayoutManager(gridLayoutManager);
        }
        if (mPopAdapter == null) {
            mPopAdapter = new PopupWindowAdapter(getActivity(), subClassList, sortMenu, isClass, classChoosePosition, sortChoosePosition);
            popupwindowRecycle.setAdapter(mPopAdapter);
        } else {
            mPopAdapter.setType(isClass);
            mPopAdapter.setChoosePosition(classChoosePosition, sortChoosePosition);
            mPopAdapter.notifyDataSetChanged();
        }
        mPopAdapter.setItemClickListener(new PopupWindowAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                if (isClass) {
                    thirdClassBtn.setText(subClassList.get(position).getClassName());
                    classChoosePosition = position;
                    classCode = subClassList.get(position).getClassCode();
                } else {
                    isDefault = position == 0;
                    sortBtn.setText(getResources().getString(sortMenu[position]));
                    sortChoosePosition = position;
                    changeSortInfo(sortChoosePosition);
                }
                if (mPopupWindow != null && mPopupWindow.isShowing()) {
                    mPopupWindow.dismiss();
                }
                products.clear();
                productRequest(1);
            }
        });
        mPopupWindow.setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                changePopupwindowStatus(true);
            }
        });
        popupwindowEmptyView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mPopupWindow.dismiss();
            }
        });
    }

    private void changePopupwindowStatus(boolean isClass) {
        boolean isClosePop = mPopupWindow == null || !mPopupWindow.isShowing();
        thirdClassBtn.setCompoundDrawablesWithIntrinsicBounds(null, null,
                getResources().getDrawable(isClosePop ? R.mipmap.down : isClass ? R.mipmap.up : R.mipmap.down), null);
        sortBtn.setCompoundDrawablesWithIntrinsicBounds(null, null,
                getResources().getDrawable(isClosePop ? R.mipmap.down : isClass ? R.mipmap.down : R.mipmap.up), null);
    }

    private void changeSortInfo(int num) {
        switch (num) {
            case 1:
                isStock = false;
                isUpToDown = true;
                break;
            case 2:
                isStock = false;
                isUpToDown = false;
                break;
            case 3:
                isStock = true;
                isUpToDown = true;
                break;
            case 0:
            case 4:
                isStock = true;
                isUpToDown = false;
                break;
        }
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        popupwindowDismiss();
    }

    private void popupwindowDismiss() {
        if (mPopupWindow != null) {
            if (mPopupWindow.isShowing()) {
                mPopupWindow.dismiss();
            }
            mPopupWindow = null;
        }
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
        map.put("classCode", classCode);
        map.put("orderBy", isDefault ? 0 : (isStock ? 1 : 2));//排序类型。默认1。1-	库存排序 2-销量排序
        map.put("sortBy", isUpToDown ? 2 : 1);//排序模式。默认1。1-从低到高 2-从高到低
        map.put("enabledFlag", isOnline ? 1 : 2);//上下架标识。默认0。0-全部 1-上架 2-下架
        RetrofitUtils.getInstance(true).searchProducts(ParamUtils.getParam(map), productHttpBack);
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
        private WeakReference<ClassProductFragment> productWeakReference;

        public RefreshHandler(ClassProductFragment fragment) {
            this.productWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            ClassProductFragment fragment = productWeakReference.get();
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
