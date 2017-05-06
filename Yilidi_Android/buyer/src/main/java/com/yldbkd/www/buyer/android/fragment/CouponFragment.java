package com.yldbkd.www.buyer.android.fragment;

import android.os.Bundle;
import android.os.Handler;
import android.support.v4.content.ContextCompat;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.CouponAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Page;
import com.yldbkd.www.buyer.android.bean.Ticket;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshBase;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshListView;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2016/10/19 17:37
 * @描述 优惠券列表页面
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class CouponFragment extends BaseFragment {
    //页面参数
    private int mCouponType;
    private int mCouponColor;
    private String mCouponName;
    private int mCouponEmpty;
    private int mCouponTitleColor;
    private int mCouponItemBg;
    private boolean isVisibleToUser;
    private boolean isViewShown = false;
    //优惠券标题
    private RadioGroup radioGroup;
    private RadioButton validRadioBtn;
    private RadioButton invalidRadioBtn;
    private View mMiddleTitleView;
    //优惠券列表
    private List<Ticket> mCouponLists = new ArrayList<>();
    private ListView mCouponListView;
    private PullToRefreshListView refreshListView;
    private CouponAdapter mCouponAdapter;
    private int pageNum = 1, totalPages;
    private HttpBack<Page<Ticket>> couponHttpBack;
    private Handler refreshHandler = new RefreshHandler(this);
    //没有优惠券
    private LinearLayout mCouponEmptyLayout;
    private ImageView mCouponEmptyImage;
    private TextView mCouponEmptyContent;
    //优惠券状态
    private boolean isValid = true;
    private int inValid = 0;//无效优惠券
    private int valid = 1;//有效优惠券

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        mCouponType = bundle.getInt(Constants.BundleName.COUPON_TYPE, Constants.TicketType.YOUHUI);
        mCouponColor = bundle.getInt(Constants.BundleName.COUPON_COLOR, R.color.colorPrimary);
        mCouponName = bundle.getString(Constants.BundleName.COUPON_TYPE_NAME);
        mCouponEmpty = bundle.getInt(Constants.BundleName.COUPON_EMPTY_IMAGE, R.mipmap.empty_coupon);
        mCouponTitleColor = bundle.getInt(Constants.BundleName.COUPON_TITLE_COLOR, R.drawable.selector_coupon_rb_text);
        mCouponItemBg = bundle.getInt(Constants.BundleName.COUPON_ITEM_BG, R.drawable.coupon_left);
    }

    @Override
    public int setLayoutId() {
        return R.layout.coupon_fragment;
    }

    @Override
    public void initView(View view) {
        radioGroup = (RadioGroup) view.findViewById(R.id.coupon_radio_group);
        validRadioBtn = (RadioButton) view.findViewById(R.id.valid_radio_button);
        invalidRadioBtn = (RadioButton) view.findViewById(R.id.invalid_radio_button);
        mMiddleTitleView = view.findViewById(R.id.middle_title_view);
        //优惠券
        refreshListView = (PullToRefreshListView) view.findViewById(R.id.coupon_valid_list_view);
        mCouponListView = refreshListView.getRefreshableView();
        //无优惠券信息
        mCouponEmptyLayout = (LinearLayout) view.findViewById(R.id.coupon_empty_layout);
        mCouponEmptyImage = (ImageView) view.findViewById(R.id.coupon_empty_image);
        mCouponEmptyContent = (TextView) view.findViewById(R.id.coupon_empty_content);
    }

    @Override
    public void initData() {
        validRadioBtn.setText(String.format(getResources().getString(R.string.valid), mCouponName));
        invalidRadioBtn.setText(String.format(getResources().getString(R.string.invalid), mCouponName));
        mMiddleTitleView.setBackgroundColor(ContextCompat.getColor(getActivity(), mCouponColor));
        validRadioBtn.setTextColor(getResources().getColorStateList(mCouponTitleColor));
        invalidRadioBtn.setTextColor(getResources().getColorStateList(mCouponTitleColor));

        mCouponEmptyImage.setImageResource(mCouponEmpty);
        mCouponEmptyContent.setText(String.format(getResources().getString(R.string.coupon_empty_content), mCouponName));
        initAdapter();
    }


    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        isViewShown = getView() != null;
        this.isVisibleToUser = isVisibleToUser;
        if (isVisibleToUser && isViewShown) {
            initRequest();
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        setUserVisibleHint(isVisibleToUser);
    }

    @Override
    public void initRequest() {
        request(1);
    }

    @Override
    public void initHttpBack() {
        couponHttpBack = new HttpBack<Page<Ticket>>(getBaseActivity()) {
            @Override
            public void onSuccess(Page<Ticket> couponList) {
                if (couponList == null) {
                    mCouponEmptyLayout.setVisibility(View.VISIBLE);
                    refreshListView.setVisibility(View.GONE);
                    return;
                }
                if (couponList.getPageNum() <= 1) {
                    mCouponLists.clear();
                }
                if (couponList.getList() != null) {
                    mCouponLists.addAll(couponList.getList());
                }
                if (mCouponLists.size() == 0) {
                    mCouponEmptyLayout.setVisibility(View.VISIBLE);
                    refreshListView.setVisibility(View.GONE);
                } else {
                    mCouponEmptyLayout.setVisibility(View.GONE);
                    refreshListView.setVisibility(View.VISIBLE);
                }
                pageNum = couponList.getPageNum() + 1;
                totalPages = couponList.getTotalPages();
                mCouponAdapter.notifyDataSetChanged();
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
            }

            @Override
            public void onTimeOut() {
                super.onTimeOut();
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
            }
        };
    }

    private void request(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        map.put("ticketStatus", isValid ? valid : inValid);
        map.put("ticketType", mCouponType);
        RetrofitUtils.getInstance().userticketList(ParamUtils.getParam(map), couponHttpBack);
    }

    private void initAdapter() {
        mCouponAdapter = new CouponAdapter(getActivity(), mCouponLists, mCouponColor, mCouponItemBg);
        mCouponListView.setAdapter(mCouponAdapter);
    }

    @Override
    public void initListener() {
        refreshListView.setOnRefreshListener(new PullToRefreshBase.OnRefreshListener() {
            @Override
            public void onRefreshPullDown() {
                request(1);
            }

            @Override
            public void onRefreshPullUp() {
                if (pageNum > totalPages) {
                    refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
                    ToastUtils.show(getActivity(), R.string.pull_up_no_more_data);
                    return;
                }
                request(pageNum);
            }
        });
        radioGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                switch (checkedId) {
                    case R.id.valid_radio_button:
                        isValid = true;
                        mCouponAdapter.setColorResource(mCouponColor);
                        mCouponAdapter.setBgResource(mCouponItemBg);
                        mCouponAdapter.setContentTextColor(R.color.primaryText, R.color.secondaryText, R.color.lightText);
                        break;
                    case R.id.invalid_radio_button:
                        isValid = false;
                        mCouponAdapter.setColorResource(R.color.secondaryText);
                        mCouponAdapter.setBgResource(R.drawable.invalid);
                        mCouponAdapter.setContentTextColor(R.color.lightText, R.color.lightText, R.color.lightText);
                        break;
                }
                mCouponLists.clear();
                mCouponAdapter.notifyDataSetChanged();
                request(1);
            }
        });
    }

    static class RefreshHandler extends Handler {
        private WeakReference<CouponFragment> couponWeakReference;

        public RefreshHandler(CouponFragment fragment) {
            this.couponWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(android.os.Message msg) {
            CouponFragment fragment = couponWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.REFRESH_LIST) {
                fragment.refreshListView.onRefreshComplete();
            }
        }
    }
}
