package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.ProductActivity;
import com.yldbkd.www.buyer.android.adapter.ZoneListProductAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.ActSecKill;
import com.yldbkd.www.buyer.android.bean.SecKillProduct;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.DateUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.CountDown;
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
 * @author 李贞高
 * @version $Rev$
 * @time 2016/8/16 14:29
 * @des 秒杀内页
 * @updateAuthor $Author$
 * @updateDate $Date$
 * @updateDes
 */
public class SecondKillFragment extends BaseFragment {
    private ActSecKill actInfo;
    private long mTimeDifference;
    private int mCurrentPageItem;
    private int mCountPageItem;
    private String mBeforeActName;
    private String mNextActName;

    private final int ACTWILLStart = 1;
    private final int ACTBUYING = 2;
    private final int ACTEND = 3;

    private ListView orderListView;
    private ZoneListProductAdapter productAdapter;
    private List<SecKillProduct> seckillProductLists = new ArrayList<>();

    private HttpBack<List<SecKillProduct>> productHttpBack;
    private Handler handler;
    public ZoneHandler zoneHandler = new ZoneHandler(this);

    private RelativeLayout mNodataRL;
    private TextView tvTimesShow;
    private TextView actNoteView;
    private PagerSlidingTabStrip pagerIndicator;

    private boolean isViewShown = false;
    private boolean isVisibleToUser;
    private Integer mCurrentStoreId;

    private long times;
    private int statusCode;
    private long mLocalTime;
    private long mSystemTime;
    private long mBeginTime;
    private long mEndTime;
    private boolean isEndAct = false;

    //倒计时
    private static final long COUNT_DOWN_INTERVAL = 1000L;
    private CountDown countDown;
    private CountDownHandler timeHandler = new CountDownHandler(this);

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        actInfo = (ActSecKill) bundle.getSerializable(Constants.BundleName.INSTANT_KILL);
        mCurrentPageItem = bundle.getInt(Constants.BundleName.CURRENT_PAGE_ITEM, 0);
        mCountPageItem = bundle.getInt(Constants.BundleName.COUNT_PAGE_ITEM, 0);
        mTimeDifference = bundle.getLong(Constants.BundleName.TIME_DIFFERENCE, 0);
        mBeforeActName = bundle.getString(Constants.BundleName.BEFORE_PAGE_TITLE, null);
        mNextActName = bundle.getString(Constants.BundleName.NEXT_PAGE_TITLE, null);
    }

    @Override
    public int setLayoutId() {
        return R.layout.second_kill_list_fragment;
    }

    @Override
    public void initView(View view) {
        orderListView = (ListView) view.findViewById(R.id.instant_kill_list_layout);
        mNodataRL = (RelativeLayout) view.findViewById(R.id.rl_nodata);
        tvTimesShow = (TextView) view.findViewById(R.id.tv_times_show);
        actNoteView = (TextView) view.findViewById(R.id.act_note_view);
    }

    @Override
    public void initData() {
        mCurrentStoreId = CommunityUtils.getCurrentStoreId();
        initAdapter();
    }

    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        isViewShown = getView() != null;
        this.isVisibleToUser = isVisibleToUser;
        if (isVisibleToUser && isViewShown) {
            refreshCartNum();
            initRequest();
            showTimeToView();//显示倒计时
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        setUserVisibleHint(isVisibleToUser);
    }

    private void refreshCartNum() {
        CartUtils.calculateProductNum(seckillProductLists);
        if (productAdapter != null) {
            productAdapter.notifyDataSetChanged();
        }
    }

    private void showTimeToView() {
        mLocalTime = new Date().getTime();
        mSystemTime = mLocalTime - mTimeDifference;
        statusCode = getStatusCode();
        actNoteView.setText(getResources().getString(statusCode == ACTWILLStart ? R.string.second_kill_note_will
                : statusCode == ACTBUYING ? R.string.second_kill_note_ing : R.string.second_kill_note_end));
        productAdapter.setActStatusCode(statusCode);

        if (statusCode != ACTEND) {
            tvTimesShow.setVisibility(View.VISIBLE);
            if (statusCode == ACTWILLStart) {
                times = mBeginTime - mSystemTime;
            } else {
                times = mEndTime - mSystemTime;
            }
            startCountDown(times);
        } else {
            tvTimesShow.setVisibility(View.GONE);
        }
    }

    private int getStatusCode() {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        isEndAct = actInfo.getEndTime() == null ? true : false;
        try {
            mBeginTime = format.parse(actInfo.getBeginTime()).getTime();
            if (!isEndAct) {
                mEndTime = format.parse(actInfo.getEndTime()).getTime();
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        if (mBeginTime > mSystemTime) {
            return ACTWILLStart;
        } else if (mBeginTime <= mSystemTime && (isEndAct || mEndTime > mSystemTime)) {
            return ACTBUYING;
        } else if (mEndTime <= mSystemTime) {
            return ACTEND;
        }
        return ACTWILLStart;
    }

    @Override
    public void onPause() {
        super.onPause();
        stopCountDown();
    }

    @Override
    public void initHttpBack() {
        productHttpBack = new HttpBack<List<SecKillProduct>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<SecKillProduct> data) {
                if (data == null || data.size() <= 0) {
                    mNodataRL.setVisibility(View.VISIBLE);
                    return;
                }
                seckillProductLists.clear();
                seckillProductLists.addAll(data);

                CartUtils.calculateProductNum(seckillProductLists);
                productAdapter.notifyDataSetChanged();
            }
        };
    }

    @Override
    public void initRequest() {
        request();
    }

    private void request() {
        Map<String, Object> map = new HashMap<>();
        map.put("storeId", mCurrentStoreId);
        map.put("actId", actInfo.getActId());
        RetrofitUtils.getInstance(true).seckillProducts(ParamUtils.getParam(map), productHttpBack);
    }

    public void setPagerIndicatorView(PagerSlidingTabStrip pagerIndicator) {
        this.pagerIndicator = pagerIndicator;
    }

    public void setCartHandler(Handler handler) {
        this.handler = handler;
    }

    private void initAdapter() {
        productAdapter = new ZoneListProductAdapter(seckillProductLists, getActivity(), 1, zoneHandler);
        orderListView.setAdapter(productAdapter);
    }

    private static class ZoneHandler extends Handler {
        WeakReference<SecondKillFragment> fragmentWeakReference;

        public ZoneHandler(SecondKillFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(final Message msg) {
            final SecondKillFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            SecKillProduct product = fragment.seckillProductLists.get(msg.arg2);
            switch (msg.what) {
                case Constants.HandlerCode.PRODUCT_PLUS:
                    CartUtils.validateOperationCart(fragment.getActivity(), product, this, msg.obj, msg.arg2);
                    break;
                case Constants.HandlerCode.CART_SUCCESS:
                    CartUtils.calculateProductNum(fragment.seckillProductLists);
                    if (fragment.handler != null) {
                        fragment.handler.obtainMessage(Constants.HandlerCode.PRODUCT_PLUS, msg.obj).sendToTarget();
                    }
                    break;
                case Constants.HandlerCode.PRODUCT_DETAIL:
                    Intent intent = new Intent(fragment.getActivity(), ProductActivity.class);
                    intent.putExtra(Constants.BundleName.SALE_PRODUCT_ID, product.getSaleProductId());
                    fragment.startActivity(intent);
                    break;
            }
            fragment.productAdapter.notifyDataSetChanged();
        }
    }

    public void startCountDown(long millisInFuture) {
        stopCountDown();
        countDown = new CountDown(millisInFuture, COUNT_DOWN_INTERVAL, timeHandler);
        countDown.start();
    }

    public void stopCountDown() {
        if (countDown != null) {
            countDown.cancel();
            countDown = null;
        }
    }

    static class CountDownHandler extends Handler {
        WeakReference<SecondKillFragment> activityWeakReference;

        public CountDownHandler(SecondKillFragment fragment) {
            this.activityWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            SecondKillFragment fragment = activityWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case CountDown.COUNT_DOWN_TIMER:
                    fragment.checkCodeCountDownTimer((Long) msg.obj);
                    break;
                case CountDown.COUNT_DOWN_FINISH:
                    fragment.checkCodeCountDownFinish();
                    break;
            }
        }
    }

    private void checkCodeCountDownTimer(long millisUntilFinished) {
        if (tvTimesShow == null) {
            return;
        }
        String hour = DateUtils.getHour(millisUntilFinished);
        String minute = DateUtils.getMinute(millisUntilFinished);
        String second = DateUtils.getSecond(millisUntilFinished);
        String timerContent;
        timerContent = String.format(getResources().getString(R.string.second_kill_time), hour, minute, second);
        tvTimesShow.setText(String.format(getString(statusCode == ACTWILLStart ? R.string.second_kill_start_time : R.string.second_kill_end_time),
                timerContent));
    }

    private void checkCodeCountDownFinish() {
        if (tvTimesShow == null) {
            return;
        }
        stopCountDown();
        if (pagerIndicator == null)
            return;

        int currentActNameId;
        int beforeActNameId;
        int nextActNameId;
        if (statusCode == ACTWILLStart) {
            currentActNameId = R.string.second_kill_status_ing;
            if (mCurrentPageItem != 0) {
                beforeActNameId = R.string.second_kill_status_over;
                ((TextView) ((LinearLayout) pagerIndicator.getChildAt(0)).getChildAt(mCurrentPageItem - 1))
                        .setText(String.format(getResources().getString(R.string.second_kill_title_show)
                                , mBeforeActName, getResources().getString(beforeActNameId)));
            }
        } else {
            currentActNameId = R.string.second_kill_status_over;
            if (mCountPageItem != mCurrentPageItem) {
                nextActNameId = R.string.second_kill_status_ing;
                ((TextView) ((LinearLayout) pagerIndicator.getChildAt(0)).getChildAt(mCurrentPageItem + 1))
                        .setText(String.format(getResources().getString(R.string.second_kill_title_show)
                                , mNextActName, getResources().getString(nextActNameId)));
            }
        }
        ((TextView) ((LinearLayout) pagerIndicator.getChildAt(0)).getChildAt(mCurrentPageItem))
                .setText(String.format(getResources().getString(R.string.second_kill_title_show)
                        , actInfo.getActName(), getResources().getString(currentActNameId)));
        //重新计算倒计时，列表产品购买状态需要刷新
        setUserVisibleHint(isVisibleToUser);
    }
}

