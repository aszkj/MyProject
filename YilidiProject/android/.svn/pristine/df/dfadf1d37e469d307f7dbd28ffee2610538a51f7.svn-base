package com.yldbkd.www.seller.android.activity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.seller.android.R;

/**
 * @创建者 李贞高
 * @创建时间 2017/1/16 11:11
 * @描述 联系客服
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class ConnectActivity extends BaseActivity {
    private LinearLayout backView;
    private RelativeLayout mKfPhone;
    private RelativeLayout mKfManagerPhone;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.activity_connect);

        initView();
        initListener();
    }

    private void initView() {
        backView = (LinearLayout) findViewById(R.id.ll_back);
        TextView titleView = (TextView) findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.connect_title));

        mKfPhone = (RelativeLayout) findViewById(R.id.rl_kf_phone);
        mKfManagerPhone = (RelativeLayout) findViewById(R.id.rl_kf_manager_phone);
    }

    private void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });
        mKfPhone.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //用intent启动拨打电话
                Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" +
                        getResources().getString(R.string.customer_service_line)));
                startActivity(intent);
            }
        });
        mKfManagerPhone.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //用intent启动拨打电话
                Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" +
                        getResources().getString(R.string.investment_service_line)));
                startActivity(intent);
            }
        });
    }

    @Override
    Fragment newFragmentByTag(String tag) {
        return null;
    }
}
