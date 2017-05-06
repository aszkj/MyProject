package com.yldbkd.www.seller.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.AllotOrderDetailActivity;
import com.yldbkd.www.seller.android.activity.MainActivity;
import com.yldbkd.www.seller.android.bean.AllotOrderBase;
import com.yldbkd.www.seller.android.utils.Constants;

/**
 * 调货单生成成功页面
 * <p/>
 * Created by linghuxj on 16/6/6.
 */
public class AllotResultFragment extends BaseFragment {

    private AllotOrderBase allotOrder;

    private LinearLayout backView;

    private TextView allotNoView;
    private TextView allotWarehouseView;
    private TextView allotCountView;
    private TextView allotCreateTimeView;

    private Button homeBtn;
    private Button orderBtn;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        allotOrder = (AllotOrderBase) bundle.getSerializable(Constants.BundleName.ALLOT_ORDER_BASE_INFO);
    }

    @Override
    public int setLayoutId() {
        return R.layout.fragment_allot_result;
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_allot_result));

        allotNoView = (TextView) view.findViewById(R.id.tv_allot_order_no);
        allotWarehouseView = (TextView) view.findViewById(R.id.tv_allot_warehouse);
        allotCountView = (TextView) view.findViewById(R.id.tv_allot_total_count);
        allotCreateTimeView = (TextView) view.findViewById(R.id.tv_allot_create_time);

        homeBtn = (Button) view.findViewById(R.id.btn_allot_home);
        orderBtn = (Button) view.findViewById(R.id.btn_allot_order);
    }

    @Override
    public void initData() {
        allotNoView.setText(allotOrder.getAllotOrderNo());
        allotWarehouseView.setText(allotOrder.getAllotFromStoreName());
        allotCountView.setText(String.valueOf(allotOrder.getAllotTotalCount()));
        allotCreateTimeView.setText(allotOrder.getCreateTime());
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        homeBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), MainActivity.class);
                intent.setAction(MainFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
        orderBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), AllotOrderDetailActivity.class);
                intent.putExtra(Constants.BundleName.ALLOT_ORDER_NO, allotOrder.getAllotOrderNo());
                startActivity(intent);
                AppManager.getAppManager().finishActivity();
            }
        });
    }
}
