package com.yldbkd.www.buyer.android.fragment;

import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.MessageDetail;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.TextChangeUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2017/3/27 16:01
 * @描述 一里递活动信息列表
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class MessageActivityDetailFragment extends BaseFragment {
    private int msgId;
    private RelativeLayout backView;
    private TextView titleView;
    private HttpBack<MessageDetail> messageDetailHttpBack;
    private LinearLayout layoutMessageDetail;
    private RelativeLayout rlNodata;
    private TextView mMessageAbstract;
    private TextView mMessageContext;
    private ImageView mMessageImage;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        msgId = bundle.getInt(Constants.BundleName.MESSAGE_ID);
    }

    @Override
    public int setLayoutId() {
        return R.layout.message_activity_detail_fragment;
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);

        layoutMessageDetail = (LinearLayout) view.findViewById(R.id.layout_message_detail);
        rlNodata = (RelativeLayout) view.findViewById(R.id.rl_nodata);

        mMessageAbstract = (TextView) view.findViewById(R.id.message_abstract);
        mMessageContext = (TextView) view.findViewById(R.id.message_content);
        mMessageImage = (ImageView) view.findViewById(R.id.message_image);
    }

    @Override
    public void initHttpBack() {
        messageDetailHttpBack = new HttpBack<MessageDetail>(getBaseActivity()) {
            @Override
            public void onSuccess(MessageDetail messageDetail) {
                if (messageDetail == null) {
                    activityEnd();
                    return;
                }
                titleView.setText(TextUtils.isEmpty(messageDetail.getMsgTitle()) ? getResources().getString(R.string.message_activity) : messageDetail.getMsgTitle());
                List<Integer> countStyles = new ArrayList<>();
                countStyles.add(R.style.TextAppearance_Normal_Secondary);
                TextChangeUtils.setDifferentText(getActivity(), mMessageAbstract, R.string.message_abstract_title_desc,
                        countStyles, messageDetail.getMsgAbstract());
                mMessageContext.setText(messageDetail.getMsgContent());
                ImageLoaderUtils.load(mMessageImage, messageDetail.getMsgImage(), R.drawable.no_picture_rect);
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                activityEnd();
            }

            @Override
            public void onTimeOut() {
                super.onTimeOut();
                activityEnd();
            }
        };
    }

    private void activityEnd() {
        titleView.setText(getResources().getString(R.string.message_activity));
        layoutMessageDetail.setVisibility(View.GONE);
        rlNodata.setVisibility(View.VISIBLE);
    }

    @Override
    public void initData() {
        initRequest();
    }

    @Override
    public void initRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("msgId", msgId);
        RetrofitUtils.getInstance(true).messageDetail(ParamUtils.getParam(map), messageDetailHttpBack);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
    }
}
