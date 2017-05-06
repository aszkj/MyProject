package com.yldbkd.www.seller.android.fragment;

import android.os.Bundle;
import android.support.v4.content.ContextCompat;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.EditorInfo;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.DisplayUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.library.android.viewCustomer.LabelFlowView;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.HistoryUtils;
import com.yldbkd.www.seller.android.utils.PreferenceName;

import java.util.Collections;
import java.util.List;

/**
 * 产品搜索记录页面
 * <p/>
 * Created by linghuxj on 16/6/3.
 */
public class OrderSearchFragment extends BaseFragment {

    private LinearLayout backView;
    private ClearableEditText searchTextView;
    private ImgTxtButton searchBtn;

    private ImageView delBtn;
    private RelativeLayout historyEmptyLayout;
    private LabelFlowView historyLabelView;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_order_search;
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back_search_bar);
        searchTextView = (ClearableEditText) view.findViewById(R.id.cet_search_bar);
        searchTextView.setHint(R.string.order_search_hint);
        searchBtn = (ImgTxtButton) view.findViewById(R.id.itb_right_search_bar);
        searchBtn.setText(getString(R.string.search));

        delBtn = (ImageView) view.findViewById(R.id.iv_search_history_del);
        historyEmptyLayout = (RelativeLayout) view.findViewById(R.id.rl_search_history_empty);
        historyLabelView = (LabelFlowView) view.findViewById(R.id.lfv_label_history);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        searchTextView.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (EditorInfo.IME_ACTION_SEARCH == i) {
                    String keywords = textView.getText().toString().trim();
                    return addHistory(keywords);
                }
                return false;
            }
        });
        searchBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String keywords = searchTextView.getText().toString().trim();
                addHistory(keywords);
            }
        });
        delBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                HistoryUtils.clearHistory(getActivity(), PreferenceName.Search.SEARCH_ORDER_HISTORY);
                historyRequest();
            }
        });
    }

    @Override
    public void onResume() {
        super.onResume();
        historyRequest();
    }

    @Override
    public void onPause() {
        super.onPause();
        KeyboardUtils.close(getActivity(), searchTextView);
    }

    private boolean addHistory(String keywords) {
        if (TextUtils.isEmpty(keywords)) {
            ToastUtils.show(getActivity(), R.string.order_search_empty_notify);
            return false;
        }
        if (CheckUtils.isConSpeCharacters(keywords)) {
            ToastUtils.show(getActivity(), R.string.search_error_notify);
            return false;
        }
        HistoryUtils.addHistory(getActivity(), keywords, PreferenceName.Search.SEARCH_ORDER_HISTORY);
        Bundle bundle = new Bundle();
        bundle.putString(Constants.BundleName.SEARCH_KEYWORD, keywords);
        getBaseActivity().showFragment(OrderListFragment.class.getSimpleName(), bundle, true);
        return true;
    }

    /**
     * 获取搜索历史
     */
    private void historyRequest() {
        List<String> list = HistoryUtils.getHistory(getActivity(), PreferenceName.Search.SEARCH_ORDER_HISTORY);
        if (list == null || list.size() == 0) {
            historyEmptyLayout.setVisibility(View.VISIBLE);
            delBtn.setVisibility(View.GONE);
            historyLabelView.setVisibility(View.GONE);
        } else {
            historyEmptyLayout.setVisibility(View.GONE);
            delBtn.setVisibility(View.VISIBLE);
            historyLabelView.setVisibility(View.VISIBLE);
            Collections.reverse(list);
            setLabel(list, historyLabelView);
        }
    }

    /**
     * 标签内容设置
     */
    private void setLabel(List<String> keywordsList, LabelFlowView labelView) {
        ViewGroup.MarginLayoutParams lp = new ViewGroup.MarginLayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT);
        int marginLR = DisplayUtils.dp2px(getActivity(), 8);
        int marginTB = DisplayUtils.dp2px(getActivity(), 3);
        int margin = DisplayUtils.dp2px(getActivity(), 4);
        lp.setMargins(margin, margin, margin, margin);
        for (final String keywords : keywordsList) {
            TextView view = new TextView(getActivity());
            view.setText(keywords);
            view.setTextColor(ContextCompat.getColor(getActivity(), R.color.primaryText));
            view.setTextSize(getResources().getDimension(R.dimen.search_record_text_size));
            view.setBackgroundResource(R.drawable.button_white_gray_selector);
            view.setPadding(marginLR, marginTB, marginLR, marginTB);
            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    HistoryUtils.addHistory(getActivity(), keywords, PreferenceName.Search.SEARCH_ORDER_HISTORY);
                    Bundle bundle = new Bundle();
                    bundle.putString(Constants.BundleName.SEARCH_KEYWORD, keywords);
                    getBaseActivity().showFragment(OrderListFragment.class.getSimpleName(), bundle, true);
                }
            });
            labelView.addView(view, lp);
        }
    }
}
