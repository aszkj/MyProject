package com.yldbkd.www.seller.android.fragment;

import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.adapter.AllotStatusAdapter;
import com.yldbkd.www.seller.android.bean.AllotStatus;
import com.yldbkd.www.seller.android.utils.Constants;

import java.util.List;

/**
 * 调货单状态页面
 * <p>
 * Created by linghuxj on 16/6/6.
 */
public class AllotOrderDetailRecordFragment extends BaseFragment {

    private List<AllotStatus> statuses;
    private RecyclerView recyclerView;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_allot_order_record;
    }

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        statuses = (List<AllotStatus>) bundle.getSerializable(Constants.BundleName.ALLOT_ORDER_DETAIL_RECORD_INFO);
    }

    @Override
    public void initView(View view) {
        recyclerView = (RecyclerView) view.findViewById(R.id.rv_allot_order_record);
    }

    @Override
    public void initAdapter() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(layoutManager);
        AllotStatusAdapter statusAdapter = new AllotStatusAdapter(getActivity(), statuses);
        recyclerView.setAdapter(statusAdapter);
    }
}
