package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Message;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2017/3/27 16:01
 * @描述 消息汇总页面
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class MessageFragment extends BaseFragment {
    private RelativeLayout backView;
    private HttpBack<List<Message>> messageHttpBack;
    private TextView mActivityMessageContent;
    private TextView mActivityMessageTime;
    private ImageView mActivityMessageImage;
    private TextView mActivityMessageTitle;
    private RelativeLayout mActivityMessageLayout;
    private TextView mRefundMessageContent;
    private ImageView mRefundMessageImage;
    private TextView mRefundMessageTime;
    private TextView mRefundMessageTitle;
    private RelativeLayout mRefundMessageLayout;
    private TextView mCouponMessageContent;
    private ImageView mCouponMessageImage;
    private TextView mCouponMessageTime;
    private RelativeLayout mCouponMessageLayout;
    private TextView mCouponMessageTitle;
    private int[] messageImageRes = {R.mipmap.message_coupon, R.mipmap.message_refund, R.mipmap.message_activity};

    @Override
    public int setLayoutId() {
        return R.layout.message_fragment;
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.profile_message));
        //优惠信息
        mCouponMessageLayout = (RelativeLayout) view.findViewById(R.id.coupon_message_layout);
        mCouponMessageTitle = (TextView) view.findViewById(R.id.coupon_message_title);
        mCouponMessageTime = (TextView) view.findViewById(R.id.coupon_message_time);
        mCouponMessageContent = (TextView) view.findViewById(R.id.coupon_message_content);
        mCouponMessageImage = (ImageView) view.findViewById(R.id.coupon_message_image);
        //退款信息
        mRefundMessageLayout = (RelativeLayout) view.findViewById(R.id.refund_message_layout);
        mRefundMessageTitle = (TextView) view.findViewById(R.id.refund_message_title);
        mRefundMessageTime = (TextView) view.findViewById(R.id.refund_message_time);
        mRefundMessageContent = (TextView) view.findViewById(R.id.refund_message_content);
        mRefundMessageImage = (ImageView) view.findViewById(R.id.refund_message_image);
        //一里递活动
        mActivityMessageLayout = (RelativeLayout) view.findViewById(R.id.activity_message_layout);
        mActivityMessageTitle = (TextView) view.findViewById(R.id.activity_message_title);
        mActivityMessageTime = (TextView) view.findViewById(R.id.activity_message_time);
        mActivityMessageContent = (TextView) view.findViewById(R.id.activity_message_content);
        mActivityMessageImage = (ImageView) view.findViewById(R.id.activity_message_image);
    }

    @Override
    public void initData() {
        if (UserUtils.isLogin()) {
            initRequest();
        } else {
            Intent intent = new Intent(getActivity(), LoginActivity.class);
            intent.setAction(LoginFragment.class.getSimpleName());
            startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
        }
    }

    @Override
    public void initHttpBack() {
        messageHttpBack = new HttpBack<List<Message>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<Message> messages) {
                if (messages == null || messages.size() < 3) {
                    return;
                }
                showCouponMessage(messages.get(0));
                showRefundMessage(messages.get(1));
                showActivityMessage(messages.get(2));
            }
        };
    }

    private void showCouponMessage(Message message) {
        mCouponMessageTitle.setText(message.getTypeName());
        mCouponMessageTime.setText(TextUtils.isEmpty(message.getMsgTime()) ? "" : message.getMsgTime().substring(0, 10));
        mCouponMessageContent.setText(TextUtils.isEmpty(message.getMsgAbstract()) ? getResources().getString(R.string.message_nearly_empty) : message.getMsgAbstract());
        mCouponMessageImage.setImageResource(messageImageRes[message.getTypeValue() - 1]);
    }

    private void showRefundMessage(Message message) {
        mRefundMessageTitle.setText(message.getTypeName());
        mRefundMessageTime.setText(TextUtils.isEmpty(message.getMsgTime()) ? "" : message.getMsgTime().substring(0, 10));
        mRefundMessageContent.setText(TextUtils.isEmpty(message.getMsgAbstract()) ? getResources().getString(R.string.message_nearly_empty) : message.getMsgAbstract());
        mRefundMessageImage.setImageResource(messageImageRes[message.getTypeValue() - 1]);
    }

    private void showActivityMessage(Message message) {
        mActivityMessageTitle.setText(message.getTypeName());
        mActivityMessageTime.setText(TextUtils.isEmpty(message.getMsgTime()) ? "" : message.getMsgTime().substring(0, 10));
        mActivityMessageContent.setText(TextUtils.isEmpty(message.getMsgAbstract()) ? getResources().getString(R.string.message_nearly_empty) : message.getMsgAbstract());
        mActivityMessageImage.setImageResource(messageImageRes[message.getTypeValue() - 1]);
    }

    @Override
    public void initRequest() {
        RetrofitUtils.getInstance(true).userMessage(ParamUtils.getParam(null), messageHttpBack);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        mCouponMessageLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Bundle bundle = new Bundle();
                bundle.putInt(Constants.BundleName.MESSAGE_TYPE, Constants.MessageType.MESSAGECOUPON);
                getBaseActivity().showFragment(MessageListFragment.class.getSimpleName(), bundle, true);
            }
        });
        mRefundMessageLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Bundle bundle = new Bundle();
                bundle.putInt(Constants.BundleName.MESSAGE_TYPE, Constants.MessageType.MESSAGEREFUND);
                getBaseActivity().showFragment(MessageListFragment.class.getSimpleName(), bundle, true);
            }
        });
        mActivityMessageLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getBaseActivity().showFragment(MessageActivityFragment.class.getSimpleName(), null, true);
            }
        });
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode != Activity.RESULT_OK) {
            return;
        }
        if (requestCode == Constants.RequestCode.LOGIN_CODE) {
            initRequest();
        }
    }
}
