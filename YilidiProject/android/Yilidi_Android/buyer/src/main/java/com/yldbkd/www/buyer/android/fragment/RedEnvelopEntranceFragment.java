package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.SecKillActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.RedEnvelopeInfo;
import com.yldbkd.www.buyer.android.bean.UserRedEnvelopeInfo;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.TextChangeUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 抢红包入口页面
 * <p>
 * Created by linghuxj on 2016/10/18.
 */

public class RedEnvelopEntranceFragment extends BaseFragment {

    private View backView;

    private ScrollView contentLayout;
    private TextView gradCountView;
    private Button gradBtn;
    private TextView residueCountView;
    private TextView ruleView;

    private LinearLayout emptyLayout;
    private Button emptyBtn;

    private HttpBack<UserRedEnvelopeInfo> userRedEnvelopInfoHttpBack;
    private HttpBack<UserRedEnvelopeInfo> startRedEnvelopInfoHttpBack;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_red_envelop_entrance;
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.back_view);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(R.string.grad_red_envelop);

        contentLayout = (ScrollView) view.findViewById(R.id.sv_content);
        gradCountView = (TextView) view.findViewById(R.id.tv_grad_count);
        gradBtn = (Button) view.findViewById(R.id.btn_grad);
        residueCountView = (TextView) view.findViewById(R.id.tv_residue_count);
        ruleView = (TextView) view.findViewById(R.id.tv_rule);

        emptyLayout = (LinearLayout) view.findViewById(R.id.ll_empty);
        emptyBtn = (Button) view.findViewById(R.id.btn_no_game);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        emptyBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getActivity(), SecKillActivity.class));
                AppManager.getAppManager().finishActivity(getActivity());
            }
        });
    }

    @Override
    public void onResume() {
        super.onResume();
        request();
    }

    @Override
    public void initHttpBack() {
        userRedEnvelopInfoHttpBack = new HttpBack<UserRedEnvelopeInfo>() {
            @Override
            public void onSuccess(UserRedEnvelopeInfo userRedEnvelopeInfo) {
                boolean hasActivity = userRedEnvelopeInfo != null && userRedEnvelopeInfo.getRedEnvelopeActivityInfo() != null;
                showActivityInfo(hasActivity, userRedEnvelopeInfo);
            }

            @Override
            public void onFailure(String msg) {
                showActivityInfo(false, null);
            }
        };
        startRedEnvelopInfoHttpBack = new HttpBack<UserRedEnvelopeInfo>() {
            @Override
            public void onSuccess(UserRedEnvelopeInfo userRedEnvelopeInfo) {
                boolean hasActivity = userRedEnvelopeInfo != null && userRedEnvelopeInfo.getRedEnvelopeActivityInfo() != null;
                if (hasActivity && userRedEnvelopeInfo.getResidueTimes() > 0) {
                    toGradRedEnvelop(userRedEnvelopeInfo.getRedEnvelopeActivityInfo());
                } else {
                    showActivityInfo(hasActivity, userRedEnvelopeInfo);
                }
            }

            @Override
            public void onFailure(String msg) {
                showActivityInfo(false, null);
            }
        };
    }

    private void showActivityInfo(boolean hasActivity, UserRedEnvelopeInfo userRedEnvelopeInfo) {
        emptyLayout.setVisibility(!hasActivity ? View.VISIBLE : View.GONE);
        contentLayout.setVisibility(hasActivity ? View.VISIBLE : View.GONE);
        if (hasActivity) {
            gradCountView.setText(String.format(getString(R.string.red_envelop_count),
                    String.valueOf(userRedEnvelopeInfo.getReceivedRedEnvelopeCount())));
            final int residueTimes = userRedEnvelopeInfo.getResidueTimes();// 剩余次数
            gradBtn.setBackgroundResource(residueTimes > 0 ? R.drawable.button_yellow_special_red_envelop_selector :
                    R.mipmap.button_red_envelop_grad_uncheck);
            gradBtn.setOnClickListener(residueTimes > 0 ? new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    startRequest();
                }
            } : null);
            List<Integer> styles = new ArrayList<>();
            styles.add(R.style.TextAppearance_RedEnvelopCount);
            TextChangeUtils.setDifferentText(getActivity(), residueCountView, R.string.residue_times_today,
                    styles, residueTimes);
            ruleView.setText(userRedEnvelopeInfo.getRedEnvelopeActivityInfo().getActivityRule());
        }
    }

    private void toGradRedEnvelop(RedEnvelopeInfo redEnvelopeInfo) {
        Bundle bundle = new Bundle();
        bundle.putSerializable(Constants.BundleName.RED_ENVELOP_INFO, redEnvelopeInfo);
        getBaseActivity().showFragment(RedEnvelopFragment.class.getSimpleName(), bundle, true);
    }

    private void request() {
        RetrofitUtils.getInstance(true).userRedEnvelopInfo(ParamUtils.getParam(null), userRedEnvelopInfoHttpBack);
    }

    private void startRequest() {
        RetrofitUtils.getInstance(true).startGradRedEnvelop(ParamUtils.getParam(null), startRedEnvelopInfoHttpBack);
    }
}
