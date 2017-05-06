package com.yldbkd.www.seller.android.fragment;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.adapter.AllotProductAdapter;
import com.yldbkd.www.seller.android.adapter.BaseAdapter;
import com.yldbkd.www.seller.android.bean.AllotOrderBase;
import com.yldbkd.www.seller.android.bean.AllotOrderConfirm;
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
 * 调货单购物车页面
 * <p/>
 * Created by linghuxj on 16/6/4.
 */
public class AllotCartFragment extends BaseFragment {

    private AllotOrderConfirm allotOrderConfirm;

    private LinearLayout backView;
    private ImgTxtButton deleteBtn;

    private TextView addressView;
    private TextView warehouseNameView;

    private List<ProductAllot> products;
    private RecyclerView recyclerView;
    private AllotProductAdapter productAdapter;

    private TextView totalCountView;
    private TextView totalAmtView;
    private ClearableEditText remarkView;

    private LinearLayout allCheckLayout;
    private ImageView allCheckView;
    private boolean isAll = true;
    private Button confirmView;

    private HttpBack<AllotOrderBase> allotOrderBaseHttpBack;

    private CartHandler cartHandler = new CartHandler(this);
    private List<Integer> cartIds = new ArrayList<>();

    private CommonDialog singleDelDialog;
    private CommonDialog multiDelDialog;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_allot_cart;
    }

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        allotOrderConfirm = (AllotOrderConfirm) bundle.getSerializable(Constants.BundleName.ALLOT_ORDER_CONFIRM_INFO);
        if (allotOrderConfirm == null) {
            return;
        }
        products = allotOrderConfirm.getSaleProductList();
        CartUtils.calculateProductNum(products);
    }

    @Override
    public void initHttpBack() {
        allotOrderBaseHttpBack = new HttpBack<AllotOrderBase>() {
            @Override
            public void onSuccess(AllotOrderBase allotOrderBase) {
                CartUtils.clearCartProduct(cartIds);
                Bundle bundle = new Bundle();
                bundle.putSerializable(Constants.BundleName.ALLOT_ORDER_BASE_INFO, allotOrderBase);
                getBaseActivity().showFragment(AllotResultFragment.class.getSimpleName(), bundle, false);
            }
        };
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_allot_cart));
        deleteBtn = (ImgTxtButton) view.findViewById(R.id.itb_right);
        deleteBtn.setBackgroundResource(R.mipmap.delete);

        recyclerView = (RecyclerView) view.findViewById(R.id.rc_allot_cart);

        allCheckLayout = (LinearLayout) view.findViewById(R.id.ll_allot_cart_all_check_layout);
        allCheckView = (ImageView) view.findViewById(R.id.iv_allot_cart_all_check_view);
        confirmView = (Button) view.findViewById(R.id.btn_allot_cart_confirm);
    }

    @Override
    public void initAdapter() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(layoutManager);
        recyclerView.getItemAnimator().setSupportsChangeAnimations(false);
        productAdapter = new AllotProductAdapter(getActivity(), products, cartHandler, true);
        recyclerView.setAdapter(productAdapter);
        recyclerView.addItemDecoration(DefaultItemDecoration.getDefault(getActivity()));

        View headerView = View.inflate(getActivity(), R.layout.fragment_allot_cart_header, null);
        productAdapter.setHeaderView(headerView);
        addressView = (TextView) headerView.findViewById(R.id.tv_allot_cart_address);
        warehouseNameView = (TextView) headerView.findViewById(R.id.tv_allot_cart_warehouse_name);

        View footerView = View.inflate(getActivity(), R.layout.fragment_allot_cart_footer, null);
        productAdapter.setFooterView(footerView);
        totalCountView = (TextView) footerView.findViewById(R.id.tv_allot_cart_total_count);
        totalAmtView = (TextView) footerView.findViewById(R.id.tv_allot_cart_total_amount);
        remarkView = (ClearableEditText) footerView.findViewById(R.id.cet_allot_cart_remark);
    }

    @Override
    public void initData() {
        addressView.setText(allotOrderConfirm.getStoreAddress());
        warehouseNameView.setText(allotOrderConfirm.getWarehouseName());
        setTotalData();
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        deleteBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (isEmptySelected()) {
                    ToastUtils.show(getActivity(), R.string.allot_cart_empty_delete);
                    return;
                }
                multiDelDialog = new CommonDialog(getActivity(), new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        removeSelected();
                        multiDelDialog.dismiss();
                    }
                });
                multiDelDialog.setData(getString(R.string.allot_cart_multi_delete),
                        getString(R.string.allot_cart_delete));
                multiDelDialog.show();
            }
        });
        confirmView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                confirmRequest();
            }
        });
        productAdapter.setOnItemClickListener(new BaseAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                ProductAllot product = products.get(position);
                product.setCheck(!product.isCheck());
                checkAll();
                productAdapter.notifyItemChanged(position + 1, product); // 因有header
            }
        });
        allCheckLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                isAll = !isAll;
                setAllCheck(isAll);
            }
        });
    }

    private void confirmRequest() {
        Map<String, Object> map = new HashMap<>();
        List<CartUtils.CartInfo> cartInfos = getAllotInfo();
        if (cartInfos == null) {
            ToastUtils.showShort(getActivity(), R.string.allot_cart_empty_product_confirm);
            return;
        }
        map.put("allotInfo", cartInfos);
        map.put("allotNote", remarkView.getText().toString());
        RetrofitUtils.getInstance(true).createAllotOrder(ParamUtils.getParam(map), allotOrderBaseHttpBack);
    }

    private void checkAll() {
        if (products.size() == 0) {
            setAllView(false);
            return;
        }
        boolean isAllCheck = true;
        for (ProductAllot product : products) {
            isAllCheck &= product.isCheck();
        }
        isAll = isAllCheck;
        setAllView(isAll);
        setTotalData();
    }

    private void setAllView(boolean isAll) {
        allCheckView.setBackgroundResource(isAll ? R.mipmap.checkbox_checked : R.mipmap.checkbox_unchecked);
    }

    private void setAllCheck(boolean isAll) {
        if (products.size() == 0) {
            this.isAll = false;
            setAllView(false);
            return;
        }
        setAllView(isAll);
        for (ProductAllot product : products) {
            product.setCheck(isAll);
        }
        productAdapter.notifyDataSetChanged();
        setTotalData();
    }

    private void setTotalData() {
        totalCountView.setText(String.valueOf(getTotalCount()));
        totalAmtView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(getTotalAmt())));
    }

    private void cart(final int position, boolean isAdd) {
        if (!isAdd) {
            // 减掉购物车数量操作需要判断是否删除购物车列表项，不能让数据减为0
            ProductAllot product = products.get(position);
            Integer cartNum = CartUtils.carts.get(product.getSaleProductId());
            if (cartNum == null || cartNum <= product.getPerAllotCount()) {
                singleDelDialog = new CommonDialog(getActivity(), new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        operateCart(position, false);
                        singleDelDialog.dismiss();
                    }
                });
                singleDelDialog.setData(getString(R.string.allot_cart_single_delete),
                        getString(R.string.allot_cart_delete));
                singleDelDialog.show();
                return;
            }
        }
        operateCart(position, isAdd);
    }

    private void operateCart(int position, boolean isAdd) {
        ProductAllot product = products.get(position);
        Integer totalCount = isAdd ? CartUtils.addCart(getActivity(), product.getSaleProductId(),
                product.getWarehouseCount(), product.getPerAllotCount()) : CartUtils.removeCart(
                product.getSaleProductId(), product.getPerAllotCount());
        Integer cartNum = CartUtils.carts.get(product.getSaleProductId());
        product.setCartNum(cartNum == null ? 0 : cartNum);
        if (product.getCartNum() == 0) {
            products.remove(product);
            productAdapter.notifyItemRemoved(position + 1);
        } else {
            productAdapter.notifyItemChanged(position + 1, product); // 有header
        }
        setTotalData();
    }

    private int getTotalCount() {
        int count = 0;
        for (ProductAllot product : products) {
            if (product.isCheck()) {
                count += product.getCartNum();
            }
        }
        return count;
    }

    private long getTotalAmt() {
        long total = 0L;
        for (ProductAllot product : products) {
            if (product.isCheck()) {
                total += product.getCartNum() * product.getBasePrice();
            }
        }
        return total;
    }

    private List<CartUtils.CartInfo> getAllotInfo() {
        List<CartUtils.CartInfo> list = null;
        cartIds.clear();
        for (ProductAllot product : products) {
            if (product.isCheck()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                CartUtils.CartInfo cartInfo = new CartUtils.CartInfo();
                cartInfo.setAllotNum(product.getCartNum());
                cartInfo.setSaleProductId(product.getSaleProductId());
                cartIds.add(product.getSaleProductId());
                list.add(cartInfo);
            }
        }
        return list;
    }

    private boolean isEmptySelected() {
        for (ProductAllot product : products) {
            if (product.isCheck()) {
                return false;
            }
        }
        return true;
    }

    private void removeSelected() {
        List<ProductAllot> removeProducts = new ArrayList<>();
        List<Integer> removeIds = new ArrayList<>();
        for (ProductAllot product : products) {
            if (product.isCheck()) {
                removeProducts.add(product);
                removeIds.add(product.getSaleProductId());
            }
        }
        products.removeAll(removeProducts);
        CartUtils.clearCartProduct(removeIds);
        productAdapter.notifyDataSetChanged();
        setTotalData();
    }

    private static class CartHandler extends Handler {
        private WeakReference<AllotCartFragment> productWeakReference;

        public CartHandler(AllotCartFragment fragment) {
            this.productWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            AllotCartFragment fragment = productWeakReference.get();
            if (fragment == null) {
                return;
            }
            fragment.cart((Integer) msg.obj, Constants.HandlerCode.PRODUCT_PLUS == msg.what);
        }
    }
}
