package com.yldbkd.www.buyer.android.activity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.ActSecKill;
import com.yldbkd.www.buyer.android.fragment.CartFragment;
import com.yldbkd.www.buyer.android.fragment.LoginFragment;
import com.yldbkd.www.buyer.android.fragment.SecondKillFragment;
import com.yldbkd.www.buyer.android.utils.AnimUtils;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.viewCustomer.PagerSlidingTabStrip;

import java.lang.ref.WeakReference;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2016/9/22 16:00
 * @描述 秒杀活动页面
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class SecKillActivity extends BaseActivity {
    private View backView;
    private PagerSlidingTabStrip pagerIndicator;
    private ViewPager viewPager;
    private RelativeLayout mRlNodate;

    private int VIEW_PAGER_COUNT = 0;
    private String[] VIEW_PAGER_TITLES;
    private List<Fragment> fragments = new ArrayList<>();
    private Integer mCurrentStoreId;
    private long timerDifference;

    private List<ActSecKill> actLists = new ArrayList<>();
    private HttpBack<List<ActSecKill>> actListHttpBack;
    public CartHandle cartHandle = new CartHandle(this);
    private RelativeLayout cartBtn;
    private ImageView cartNumBg;
    private TextView cartNumView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.second_kill_activity);

        initView();
        initData();
        initListener();
        initHttpBack();
        initRequest();
    }

    private void initView() {
        backView = findViewById(R.id.back_view);
        TextView titleView = (TextView) findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.instant_kill));

        mRlNodate = (RelativeLayout) findViewById(R.id.rl_nodata);
        mRlNodate.setVisibility(View.GONE);

        pagerIndicator = (PagerSlidingTabStrip) findViewById(R.id.instant_kill_page_indicator);
        viewPager = (ViewPager) findViewById(R.id.instant_kill_view_pager);

        cartBtn = (RelativeLayout) findViewById(R.id.cart_bottom_button);
        cartNumBg = (ImageView) findViewById(R.id.cart_bottom_num_bg);
        cartNumView = (TextView) findViewById(R.id.cart_bottom_num_view);
    }

    public void initData() {
        mCurrentStoreId = CommunityUtils.getCurrentStoreId();
    }

    @Override
    public void onResume() {
        super.onResume();
        flushCart();
    }

    public void initHttpBack() {
        actListHttpBack = new HttpBack<List<ActSecKill>>(this) {
            @Override
            public void onSuccess(List<ActSecKill> actList) {
                actLists.clear();
                if (actList == null || actList.size() <= 0) {
                    mRlNodate.setVisibility(View.VISIBLE);
                    pagerIndicator.setVisibility(View.GONE);
                    viewPager.setVisibility(View.GONE);
                    return;
                }
                mRlNodate.setVisibility(View.GONE);
                pagerIndicator.setVisibility(View.VISIBLE);
                viewPager.setVisibility(View.VISIBLE);

                actLists.addAll(actList);

                VIEW_PAGER_COUNT = actList.size();
                viewPager.setOffscreenPageLimit(VIEW_PAGER_COUNT);
                //得到时间差
                Long localTime = new Date().getTime();
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                try {
                    timerDifference = localTime - format.parse(actLists.get(0).getSystemTime()).getTime();
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                initAdapter();
            }
        };
    }

    public void initRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("storeId", mCurrentStoreId);
        RetrofitUtils.getInstance(true).seckillInfoList(ParamUtils.getParam(map), actListHttpBack);
    }

    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                onBackPressed();
            }
        });
        cartBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                gotoCartFragment();
            }
        });
    }

    private void initAdapter() {
        List<String> titles = new ArrayList<>();
        viewPager.removeAllViews();
        fragments.clear();

        VIEW_PAGER_TITLES = new String[VIEW_PAGER_COUNT];
        int currentItem = 0;
        Boolean isChoose = false;
        for (int i = 0; i < VIEW_PAGER_COUNT; i++) {
            String beforeTitle;
            String nextTitle;
            SecondKillFragment fragment = new SecondKillFragment();
            fragment.setPagerIndicatorView(pagerIndicator);
            fragment.setCartHandler(cartHandle);

            Bundle bundle = new Bundle();
            ActSecKill actInfo = actLists.get(i);

            beforeTitle = i > 0 ? actLists.get(i - 1).getActName() : null;
            nextTitle = (i < VIEW_PAGER_COUNT - 1 && i >= 0) ? actLists.get(i + 1).getActName() : null;

            bundle.putSerializable(Constants.BundleName.INSTANT_KILL, actInfo);
            //用来处理活动切换时候进行判断
            bundle.putInt(Constants.BundleName.CURRENT_PAGE_ITEM, i);
            bundle.putInt(Constants.BundleName.COUNT_PAGE_ITEM, VIEW_PAGER_COUNT);
            bundle.putLong(Constants.BundleName.TIME_DIFFERENCE, timerDifference);
            bundle.putString(Constants.BundleName.BEFORE_PAGE_TITLE, beforeTitle);
            bundle.putString(Constants.BundleName.NEXT_PAGE_TITLE, nextTitle);
            fragment.setArguments(bundle);
            fragments.add(fragment);

            VIEW_PAGER_TITLES[i] = String.format(getResources().getString(R.string.second_kill_title_show),
                    actLists.get(i).getActName(), actInfo.getStatusName());
            titles.add(VIEW_PAGER_TITLES[i]);
            //判断选中的item
            if (!isChoose && actInfo.getSystemTime().compareTo(actInfo.getBeginTime()) >= 0
                    && (actInfo.getEndTime() == null || actInfo.getSystemTime().compareTo(actInfo.getEndTime()) < 0)) {
                currentItem = i;
                isChoose = true;
            }
        }
        SecondKillAdapter adapter = new SecondKillAdapter(getSupportFragmentManager(), fragments, titles);
        viewPager.setAdapter(adapter);
        viewPager.setCurrentItem(currentItem);
        pagerIndicator.setViewPager(viewPager);
        pagerIndicator.setTextSize((int) getResources().getDimension(R.dimen.text_size_big));
    }


    private static class SecondKillAdapter extends FragmentStatePagerAdapter {

        private List<Fragment> fragments;
        private List<String> titles;

        public SecondKillAdapter(FragmentManager fm, List<Fragment> fragments, List<String> titles) {
            super(fm);
            this.fragments = fragments;
            this.titles = titles;
            notifyDataSetChanged();
        }

        @Override
        public Fragment getItem(int position) {
            return fragments.get(position);
        }

        @Override
        public int getCount() {
            return fragments.size();
        }

        @Override
        public int getItemPosition(Object object) {
            return PagerAdapter.POSITION_NONE;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            return titles.get(position);
        }
    }

    private static class CartHandle extends Handler {
        WeakReference<SecKillActivity> fragmentWeakReference;

        public CartHandle(SecKillActivity activity) {
            fragmentWeakReference = new WeakReference<>(activity);
        }

        @Override
        public void dispatchMessage(final Message msg) {
            final SecKillActivity activity = fragmentWeakReference.get();
            if (activity == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.PRODUCT_PLUS:
                    int[] startLocation = (int[]) msg.obj;
                    int[] endLocation = new int[2];
                    activity.cartNumView.getLocationInWindow(endLocation);
                    AnimUtils.setAddCartAnim(activity, startLocation, endLocation,
                            activity.cartNumBg, activity.cartNumView, null);
                    break;
                case Constants.HandlerCode.PRODUCT_MINUS:
                    activity.flushCart();
                    break;
            }
        }
    }

    private void gotoCartFragment() {
        Intent intent;
        if (UserUtils.isLogin()) {
            intent = new Intent(this, PurchaseActivity.class);
            intent.setAction(CartFragment.class.getSimpleName());
            startActivity(intent);
        } else {
            intent = new Intent(this, LoginActivity.class);
            intent.setAction(LoginFragment.class.getSimpleName());
            startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
        }
    }

    private void flushCart() {
        Integer count = CartUtils.getCartCount();
        if (count > 0) {
            cartNumBg.setVisibility(View.VISIBLE);
            cartNumView.setVisibility(View.VISIBLE);
            if (count > 99) {
                cartNumView.setText(getString(R.string.num_too_much));
                cartNumView.setTextSize(5f);
            } else {
                cartNumView.setText(String.valueOf(count));
                cartNumView.setTextSize(10f);
            }
        } else {
            cartNumBg.setVisibility(View.INVISIBLE);
            cartNumView.setVisibility(View.INVISIBLE);
        }
    }

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }

}
