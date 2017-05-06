package com.yldbkd.www.seller.android.fragment;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.AllotOrderDetailActivity;
import com.yldbkd.www.seller.android.adapter.AllotOrderProductAdapter;
import com.yldbkd.www.seller.android.bean.AllotOrderDetail;
import com.yldbkd.www.seller.android.bean.BaseModel;
import com.yldbkd.www.seller.android.bean.ProductAllot;
import com.yldbkd.www.seller.android.utils.AllotOrderStatusUtils;
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
 * 调货单详情页面
 * <p/>
 * Created by linghuxj on 16/6/6.
 */
public class AllotOrderDetailFragment extends BaseFragment {

    private AllotOrderDetail allotOrder;

    private TextView orderNoView;
    private TextView orderFromView;
    private TextView orderToView;
    private LinearLayout orderCountLayout;
    private TextView orderCountView;
    private TextView orderRealCountView;
    private TextView orderTimeView;

    private List<ProductAllot> productAllots;
    private RecyclerView recyclerView;
    private AllotOrderProductAdapter productAdapter;

    private LinearLayout orderBottomLayout;
    private TextView orderPostView;
    private TextView orderActView;

    private LinearLayout operationLayout;
    private Button cancelBtn;
    private Button confirmBtn;

    private AllotHandler allotHandler = new AllotHandler(this);
    private HttpBack<BaseModel> confirmAllotHttpBack;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_allot_order_detail;
    }

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        allotOrder = (AllotOrderDetail) bundle.getSerializable(Constants.BundleName.ALLOT_ORDER_DETAIL_INFO);
        if (allotOrder == null) {
            return;
        }
        productAllots = allotOrder.getAllotOrderItemList();
    }

    @Override
    public void initHttpBack() {
        confirmAllotHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel baseModel) {
                AllotOrderDetailActivity activity = (AllotOrderDetailActivity) getActivity();
                activity.initRequest();
            }
        };
    }

    @Override
    public void initView(View view) {
        recyclerView = (RecyclerView) view.findViewById(R.id.rv_allot_order_product);

        operationLayout = (LinearLayout) view.findViewById(R.id.ll_allot_order_detail_operation);
        cancelBtn = (Button) view.findViewById(R.id.btn_allot_order_detail_cancel);
        confirmBtn = (Button) view.findViewById(R.id.btn_allot_order_detail_confirm);
    }

    @Override
    public void initAdapter() {
        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getActivity());
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(linearLayoutManager);
        productAdapter = new AllotOrderProductAdapter(getActivity(), productAllots,
                allotOrder.getStatusCode(), allotHandler);
        recyclerView.setAdapter(productAdapter);
        recyclerView.addItemDecoration(DefaultItemDecoration.getDefault(getActivity()));
        recyclerView.getItemAnimator().setSupportsChangeAnimations(false);

        View headerView = View.inflate(getActivity(), R.layout.fragment_allot_order_detail_header, null);
        productAdapter.setHeaderView(headerView);

        orderNoView = (TextView) headerView.findViewById(R.id.tv_allot_order_detail_no);
        orderFromView = (TextView) headerView.findViewById(R.id.tv_allot_order_detail_from);
        orderToView = (TextView) headerView.findViewById(R.id.tv_allot_order_detail_to);
        orderTimeView = (TextView) headerView.findViewById(R.id.tv_allot_order_detail_time);
        orderCountLayout = (LinearLayout) headerView.findViewById(R.id.ll_allot_order_detail_count);
        orderCountView = (TextView) headerView.findViewById(R.id.tv_allot_order_detail_count);
        orderRealCountView = (TextView) headerView.findViewById(R.id.tv_allot_order_detail_real_count);

        View view = View.inflate(getActivity(), R.layout.fragment_allot_order_detail_footer, null);
        productAdapter.setFooterView(view);

        orderBottomLayout = (LinearLayout) view.findViewById(R.id.ll_allot_order_detail_bottom);
        orderPostView = (TextView) view.findViewById(R.id.tv_allot_order_detail_post);
        orderActView = (TextView) view.findViewById(R.id.tv_allot_order_detail_actual);
    }

    @Override
    public void initData() {
        orderNoView.setText(allotOrder.getAllotOrderNo());
        orderFromView.setText(allotOrder.getAllotFromStoreName());
        orderToView.setText(allotOrder.getAllotToStoreName());
        orderCountView.setText(String.valueOf(allotOrder.getAllotTotalCount()));
        orderRealCountView.setText(String.valueOf(allotOrder.getRealAllotTotalCount()));
        orderTimeView.setText(allotOrder.getCreateTime());

        boolean isBottomShown = AllotOrderStatusUtils.CHECKING_CODE >= allotOrder.getStatusCode();
        orderCountLayout.setVisibility(isBottomShown ? View.GONE : View.VISIBLE);
        orderBottomLayout.setVisibility(isBottomShown ? View.VISIBLE : View.GONE);
        orderPostView.setText(String.valueOf(allotOrder.getAllotTotalCount()));
        orderActView.setText(String.valueOf(getRealAllotCount()));

        operationLayout.setVisibility(AllotOrderStatusUtils.CHECKING_CODE == allotOrder.getStatusCode()
                ? View.VISIBLE : View.GONE);
    }

    @Override
    public void initListener() {
        cancelBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        confirmBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                confirmAllotCountRequest();
            }
        });
    }

    private void allotCountAdd(int position, int operateNum) {
        ProductAllot product = productAllots.get(position);
        product.setOperateAllotCount(product.getOperateAllotCount() + operateNum);
        productAdapter.notifyItemChanged(position + productAdapter.getHeaderCount(), product);
        orderActView.setText(String.valueOf(getRealAllotCount()));
    }

    private int getRealAllotCount() {
        int count = 0;
        for (ProductAllot product : productAllots) {
            count += product.getOperateAllotCount();
        }
        return count;
    }

    private List<CartUtils.CartInfo> getAllotInfo() {
        List<CartUtils.CartInfo> cartInfos = new ArrayList<>();
        for (ProductAllot product : productAllots) {
            CartUtils.CartInfo cartInfo = new CartUtils.CartInfo();
            cartInfo.setSaleProductId(product.getSaleProductId());
            cartInfo.setAllotNum(product.getOperateAllotCount());
            cartInfos.add(cartInfo);
        }
        return cartInfos;
    }

    private void confirmAllotCountRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("allotOrderNo", allotOrder.getAllotOrderNo());
        map.put("allotInfo", getAllotInfo());
        RetrofitUtils.getInstance(true).acceptAllotOrder(ParamUtils.getParam(map), confirmAllotHttpBack);
    }

    static class AllotHandler extends Handler {
        WeakReference<AllotOrderDetailFragment> fragmentWeakReference;

        public AllotHandler(AllotOrderDetailFragment fragment) {
            this.fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            AllotOrderDetailFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            fragment.allotCountAdd((Integer) msg.obj, Constants.HandlerCode.PRODUCT_PLUS == msg.what ? 1 : -1);
        }
    }
}
