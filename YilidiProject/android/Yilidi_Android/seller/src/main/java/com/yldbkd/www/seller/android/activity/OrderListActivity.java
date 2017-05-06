package com.yldbkd.www.seller.android.activity;

import android.content.Intent;
import android.graphics.Typeface;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.support.v4.view.ViewPager;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RadioButton;
import android.widget.RadioGroup;

import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.library.android.viewCustomer.PagerSlidingTabStrip;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.adapter.FragmentAdapter;
import com.yldbkd.www.seller.android.bean.OrderDetail;
import com.yldbkd.www.seller.android.fragment.OrderListFragment;
import com.yldbkd.www.seller.android.fragment.OrderSearchFragment;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 订单列表Activity
 * <p/>
 * Created by linghuxj on 16/5/31.
 */
public class OrderListActivity extends BaseActivity {

    private LinearLayout backView;
    private LinearLayout searchLayout;
    private ClearableEditText searchView;
    private ImgTxtButton receiveBtn;

    private String receiveNo;

    private List<Fragment> fragments;

    private boolean isNormal = true;
    private RadioGroup typeGroup;
    private RadioButton normalBtn;

    private PagerSlidingTabStrip tabStrip;
    private ViewPager viewPager;

    private static final int[] VIEW_PAGER_TITLES = {R.string.order_wait_receive, R.string.order_wait_send,
            R.string.order_wait_confirm, R.string.order_finished, R.string.order_canceled};
    private static final int[] STATUS_TYPES = {Constants.ORDER_STATUS.WAIT_RECEIVE, Constants.ORDER_STATUS.WAIT_SEND,
            Constants.ORDER_STATUS.WAIT_CONFIRM, Constants.ORDER_STATUS.FINISHED, Constants.ORDER_STATUS.CANCELED};

    private HttpBack<OrderDetail> orderHttpBack;

    private PopupWindow receiveView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.activity_order_list);
        initHttpBack();
        initView();
        initAdapter();
        initListener();
    }

    private void initHttpBack() {
        orderHttpBack = new HttpBack<OrderDetail>() {
            @Override
            public void onSuccess(OrderDetail orderDetail) {
                Intent intent = new Intent(OrderListActivity.this, OrderDetailActivity.class);
                intent.putExtra(Constants.BundleName.ORDER_DETAIL_INFO, orderDetail);
                intent.putExtra(Constants.BundleName.RECEIVE_NO, receiveNo);
                intent.putExtra(Constants.BundleName.ORDER_NO, orderDetail.getSaleOrderNo());
                startActivity(intent);
                if (receiveView != null && receiveView.isShowing()) {
                    receiveView.dismiss();
                }
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                if (receiveView != null && receiveView.isShowing()) {
                    searchView.setText(null);
                }
            }
        };
    }

    private void initView() {
        backView = (LinearLayout) findViewById(R.id.ll_back_search_bar);
        searchLayout = (LinearLayout) findViewById(R.id.rl_search);
        searchView = (ClearableEditText) findViewById(R.id.cet_search_bar);
        searchView.setHint(R.string.order_search_hint);
        searchView.setFocusable(false);
        receiveBtn = (ImgTxtButton) findViewById(R.id.itb_right_search_bar);
        receiveBtn.setImgResource(R.mipmap.receive_flag);

        typeGroup = (RadioGroup) findViewById(R.id.rg_order_list);
        normalBtn = (RadioButton) findViewById(R.id.rb_order_normal);

        tabStrip = (PagerSlidingTabStrip) findViewById(R.id.psts_order_list);
        viewPager = (ViewPager) findViewById(R.id.vp_order_list);
        viewPager.setOffscreenPageLimit(VIEW_PAGER_TITLES.length);
    }

    private void initAdapter() {
        List<String> titles = new ArrayList<>();
        fragments = new ArrayList<>();
        viewPager.removeAllViews();
        for (int i = 0; i < VIEW_PAGER_TITLES.length; i++) {
            OrderListFragment fragment = new OrderListFragment();
            Bundle bundle = new Bundle();
            bundle.putInt(Constants.BundleName.ORDER_STATUS, STATUS_TYPES[i]);
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
        searchView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(OrderListActivity.this, SearchActivity.class);
                intent.setAction(OrderSearchFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
        searchLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(OrderListActivity.this, SearchActivity.class);
                intent.setAction(OrderSearchFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
        receiveBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showReceiveWindow();
            }
        });
        typeGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                isNormal = checkedId == normalBtn.getId();
                OrderListFragment orderListFragment = (OrderListFragment) fragments.get(viewPager.getCurrentItem());
                orderListFragment.ordersRequest(1, isNormal);
            }
        });
    }

    private void showReceiveWindow() {
        View view = View.inflate(this, R.layout.receive_edit_window, null);
        receiveView = new PopupWindow(view, ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT, true);
        receiveView.setTouchable(true);
        receiveView.setTouchInterceptor(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                return false;
            }
        });
        receiveView.setBackgroundDrawable(ContextCompat.getDrawable(this, R.color.white));

        final EditText editText = (EditText) view.findViewById(R.id.et_receive);
        editText.setTypeface(Typeface.DEFAULT_BOLD);
        editText.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
            }

            @Override
            public void afterTextChanged(Editable s) {
                String result = s.toString();
                if (result.length() >= 4) {
                    receiveRequest(result);
                }
            }
        });
        receiveView.showAsDropDown(backView);
        KeyboardUtils.openDelay(this, editText);
    }

    private void receiveRequest(String receiveNo) {
        Map<String, Object> map = new HashMap<>();
        this.receiveNo = receiveNo;
        map.put("receiveNo", receiveNo);
        RetrofitUtils.getInstance(true).orderDetail(ParamUtils.getParam(map), orderHttpBack);
    }

    public boolean isNormal() {
        return isNormal;
    }

    @Override
    Fragment newFragmentByTag(String tag) {
        return null;
    }
}
