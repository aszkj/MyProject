package com.yldbkd.www.seller.android.fragment;

import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.common.TextChangeUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.adapter.OrderSettleAdapter;
import com.yldbkd.www.seller.android.bean.ProductSettle;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.viewCustomer.DefaultItemDecoration;

import java.util.ArrayList;
import java.util.List;

/**
 * 订单返款详情页面
 * <p/>
 * Created by linghuxj on 16/5/31.
 */
public class OrderDetailBackFragment extends BaseFragment {

    private TextView settleCountView;
    private TextView settlePriceView;

    private List<ProductSettle> settles;
    private RecyclerView recyclerView;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_order_detail_back;
    }

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        settles = (List<ProductSettle>) bundle.getSerializable(Constants.BundleName.ORDER_DETAIL_BACK_INFO);
    }

    @Override
    public void initView(View view) {
        settleCountView = (TextView) view.findViewById(R.id.tv_order_detail_settle_count);
        settlePriceView = (TextView) view.findViewById(R.id.tv_order_detail_settle_price);

        recyclerView = (RecyclerView) view.findViewById(R.id.rv_order_detail_settle_products);
    }

    @Override
    public void initAdapter() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(layoutManager);
        OrderSettleAdapter settleAdapter = new OrderSettleAdapter(getActivity(), settles);
        recyclerView.setAdapter(settleAdapter);
        recyclerView.addItemDecoration(DefaultItemDecoration.getDefault(getActivity()));
    }

    @Override
    public void initData() {
        List<Integer> styles = new ArrayList<>();
        styles.add(R.style.TextAppearance_Normal_Red);
        TextChangeUtils.setDifferentText(getActivity(), settleCountView, R.string.order_detail_back_total_count,
                styles, getTotalCount());
        TextChangeUtils.setDifferentText(getActivity(), settlePriceView, R.string.order_detail_back_total_amount,
                styles, String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(getTotalPrice())));
    }

    private int getTotalCount() {
        int count = 0;
        if (settles != null && settles.size() > 0) {
            for (ProductSettle settle : settles) {
                count += settle.getSettleCount();
            }
        }
        return count;
    }

    private Long getTotalPrice() {
        Long total = 0L;
        if (settles != null && settles.size() > 0) {
            for (ProductSettle settle : settles) {
                total += settle.getSettleCount() * settle.getSettleAmount();
            }
        }
        return total;
    }
}
