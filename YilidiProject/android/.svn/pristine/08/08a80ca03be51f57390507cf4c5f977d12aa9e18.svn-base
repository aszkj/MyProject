package com.yldbkd.www.seller.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.library.android.viewCustomer.PagerSlidingTabStrip;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.adapter.FragmentAdapter;
import com.yldbkd.www.seller.android.fragment.AllotOrderListFragment;
import com.yldbkd.www.seller.android.fragment.OrderListFragment;
import com.yldbkd.www.seller.android.utils.Constants;

import java.util.ArrayList;
import java.util.List;

/**
 * 调货单列表Activity
 * <p/>
 * Created by linghuxj on 16/5/31.
 */
public class AllotOrderListActivity extends BaseActivity {

    private LinearLayout backView;

    private PagerSlidingTabStrip tabStrip;
    private ViewPager viewPager;

    private static final int[] VIEW_PAGER_TITLES = {R.string.allot_order_not_finish, R.string.allot_order_finished};
    private static final int[] STATUS_TYPES = {0, 1};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.activity_allot_order_list);
        initView();
        initAdapter();
        initListener();
    }

    private void initView() {
        backView = (LinearLayout) findViewById(R.id.ll_back);
        TextView titleView = (TextView) findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_allot_order_list));

        tabStrip = (PagerSlidingTabStrip) findViewById(R.id.psts_order_list);
        viewPager = (ViewPager) findViewById(R.id.vp_order_list);
        viewPager.setOffscreenPageLimit(VIEW_PAGER_TITLES.length);
    }

    private void initAdapter() {
        List<String> titles = new ArrayList<>();
        List<Fragment> fragments = new ArrayList<>();
        viewPager.removeAllViews();
        for (int i = 0; i < VIEW_PAGER_TITLES.length; i++) {
            AllotOrderListFragment fragment = new AllotOrderListFragment();
            Bundle bundle = new Bundle();
            bundle.putInt(Constants.BundleName.ALLOT_ORDER_STATUS_TYPE, STATUS_TYPES[i]);
            fragment.setArguments(bundle);
            fragments.add(fragment);
            titles.add(getResources().getString(VIEW_PAGER_TITLES[i]));
        }
        FragmentAdapter adapter = new FragmentAdapter(getSupportFragmentManager(), fragments, titles);
        viewPager.setAdapter(adapter);
        viewPager.setCurrentItem(0);
        tabStrip.setViewPager(viewPager);
        tabStrip.setTextSize((int) getResources().getDimension(R.dimen.text_size_normal));
    }

    private void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });
    }

    @Override
    Fragment newFragmentByTag(String tag) {
        return null;
    }

}
