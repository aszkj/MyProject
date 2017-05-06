package com.yldbkd.www.buyer.android.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.view.View;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.CartCouponAdapter;
import com.yldbkd.www.buyer.android.bean.SerializableMap;
import com.yldbkd.www.buyer.android.bean.Ticket;
import com.yldbkd.www.buyer.android.bean.TicketTypes;
import com.yldbkd.www.buyer.android.utils.Constants;

import java.lang.ref.WeakReference;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2016/10/19 17:37
 * @描述 结算选择可用优惠券列表
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class CartCouponActivity extends Activity {
    private int mCouponSingle;
    private TicketTypes ticketType;
    private int mCouponItemBg;
    private int mCouponColor;
    private int mCouponCheckImage;

    private ListView mCouponListView;
    private CartCouponAdapter mCouponAdapter;
    private TextView mCouponTitle;
    private RelativeLayout mNoChooseCouponLayout;
    private TextView mNoChooseCouponText;
    private ImageView couponCheckbox;
    private Map<Integer, Integer> ticketMap;
    private SerializableMap mSerializableMap;
    private long mCouponMoney;
    private ImageView mClose;
    private boolean isChoose = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.cart_coupon_activity);
        ticketType = (TicketTypes) getIntent().getSerializableExtra(Constants.BundleName.COUPON_DATA);
        mCouponSingle = getIntent().getIntExtra(Constants.BundleName.TICKET_SINGLE, Constants.TicketSingleType.SINGLE);
        mCouponItemBg = getIntent().getIntExtra(Constants.BundleName.COUPON_ITEM_BG, R.drawable.cart_coupon_bg);
        mCouponColor = getIntent().getIntExtra(Constants.BundleName.COUPON_COLOR, R.color.colorPrimary);
        mCouponCheckImage = getIntent().getIntExtra(Constants.BundleName.COUPON_CHECK_IMAGE, R.mipmap.checked_red);
        mSerializableMap = (SerializableMap) getIntent().getSerializableExtra(Constants.BundleName.COUPON_CHECKED_DATA);
        mCouponMoney = getIntent().getLongExtra(Constants.BundleName.COUPON_MONEY, 0);

        initView();
        initData();
        initListener();
    }

    public void initView() {
        mCouponTitle = (TextView) findViewById(R.id.coupon_title);
        mClose = (ImageView) findViewById(R.id.close_coupon);
        mNoChooseCouponLayout = (RelativeLayout) findViewById(R.id.no_choose_coupon_layout);
        mNoChooseCouponText = (TextView) findViewById(R.id.no_choose_coupon_text);
        couponCheckbox = (ImageView) findViewById(R.id.coupon_checkbox);
        //优惠券
        mCouponListView = (ListView) findViewById(R.id.coupon_list_view);
    }

    public void initData() {
        ticketMap = mSerializableMap.getMap();
        mCouponTitle.setText(String.format(getResources().getString(R.string.cart_shoose_coupon_title), ticketType.getTicketTypeName() == null ? getResources().getString(R.string.profile_coupon_text) : ticketType.getTicketTypeName()));
        mNoChooseCouponText.setText(String.format(getResources().getString(R.string.cart_confirm_coupon_empty), ticketType.getTicketTypeName() == null ? getResources().getString(R.string.profile_coupon_text) : ticketType.getTicketTypeName()));
        initAdapter();
    }

    private void initAdapter() {
        //TODO 数据进行排序
        mCouponAdapter = new CartCouponAdapter(this, ticketType.getTicketInfoList(), ticketMap, new CouponHandler(this));
        mCouponAdapter.setCouponColorResources(mCouponItemBg, mCouponColor, mCouponCheckImage);
        mCouponListView.setAdapter(mCouponAdapter);
    }

    public void initListener() {
        mClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setResultData();
            }
        });

        mNoChooseCouponLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                isChoose = !isChoose;
                noChooseCoupon(isChoose);
                mCouponMoney = 0l;
                ticketMap.clear();
                allCheckCoupon(false);
            }
        });
    }

    private void setResultData() {
        mSerializableMap.setMap(ticketMap);
        Intent intent = new Intent();
        intent.putExtra(Constants.BundleName.COUPON_CHECKED_DATA, mSerializableMap);
        intent.putExtra(Constants.BundleName.COUPON_MONEY, mCouponMoney);
        setResult(Constants.RequestCode.COUPON_CHOOSE_CODE, intent);
        finish();
    }

    @Override
    public void finish() {
        super.finish();
        overridePendingTransition(0, R.anim.down_push_out);
    }

    @Override
    public void onBackPressed() {
        setResultData();
    }

    private void noChooseCoupon(boolean isChoose) {
        couponCheckbox.setImageResource(isChoose ? mCouponCheckImage : R.mipmap.checkbox_unchecked);
    }

    private void toCouponCheck(int position) {
        Ticket ticket = ticketType.getTicketInfoList().get(position);
        if (mCouponSingle == Constants.TicketSingleType.SINGLE) {
            allCheckCoupon(false);
        }
        //页面效果
        noChooseCoupon(false);
        isChoose = false;
        ticket.setCheck(!ticket.isCheck());
        mCouponAdapter.changeProductCheck(getViewByPosition(mCouponListView, position), position);
        //数据选中的数据保存Map中
        saveCheckedCouponInfo(ticket.isCheck(), ticket.getTicketId(), ticket.getTicketType(), mCouponSingle, ticket.getTicketAmount());
    }

    private void saveCheckedCouponInfo(boolean isCheck, Integer ticketId, Integer ticketType, Integer isSingle, Long amont) {
        if (isSingle == Constants.TicketSingleType.SINGLE) {
            ticketMap.clear();
            mCouponMoney = 0l;
            if (isCheck) {
                addTicketToMap(ticketId, ticketType);
                mCouponMoney = amont;
            }
        } else {
            if (isCheck) {
                addTicketToMap(ticketId, ticketType);
                mCouponMoney += amont;
            } else {
                removeTicketFromMap(ticketId);
                mCouponMoney -= amont;
            }
        }
    }

    private void addTicketToMap(Integer ticketId, Integer ticketType) {
        ticketMap.put(ticketId, ticketType);
    }

    private void removeTicketFromMap(Integer ticketId) {
        ticketMap.remove(ticketId);
    }

    private void allCheckCoupon(boolean allCheckFlag) {//选择前先将选中的清空
        for (int i = 0; i < ticketType.getTicketInfoList().size(); i++) {
            ticketType.getTicketInfoList().get(i).setCheck(allCheckFlag);
        }
        mCouponAdapter.notifyDataSetChanged();
    }

    public View getViewByPosition(ListView listView, int pos) {
        pos += listView.getHeaderViewsCount();
        final int firstListItemPosition = listView.getFirstVisiblePosition();
        final int lastListItemPosition = firstListItemPosition + listView.getChildCount() - 1;

        if (pos < firstListItemPosition || pos > lastListItemPosition) {
            return listView.getAdapter().getView(pos, null, listView);
        } else {
            final int childIndex = pos - firstListItemPosition;
            return listView.getChildAt(childIndex);
        }
    }

    private static class CouponHandler extends Handler {
        private WeakReference<CartCouponActivity> fragmentWeakReference;

        CouponHandler(CartCouponActivity fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            CartCouponActivity activity = fragmentWeakReference.get();
            if (activity == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.CHECK_COUPON:
                    activity.toCouponCheck((Integer) msg.obj);
                    break;
            }
        }
    }
}
