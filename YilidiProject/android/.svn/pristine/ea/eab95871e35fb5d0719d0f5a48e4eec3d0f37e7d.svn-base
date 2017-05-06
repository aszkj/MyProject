package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.EditorInfo;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.SearchResultActivity;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Keywords;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.HistoryUtils;
import com.yldbkd.www.buyer.android.utils.PreferenceName;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.DisplayUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.LabelFlowView;

import java.util.Collections;
import java.util.List;

/**
 * 搜索页面Fragment
 * <p/>
 * Created by linghuxj on 15/10/12.
 */
public class SearchFragment extends BaseFragment {

    private HttpBack<List<Keywords>> keyHttpBack;

    private RelativeLayout backView;
    private ClearableEditText searchTextView;
    private TextView searchBtn;
    private ImageView delBtn;
    private Button delBtn1;
    private RelativeLayout historyEmptyLayout;
    private LabelFlowView hotLabelView;
    private LabelFlowView historyLabelView;
    private List<String> mList;

    @Override
    public int setLayoutId() {
        return R.layout.search_fragment;
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        backView.setVisibility(View.GONE);
        searchTextView = (ClearableEditText) view.findViewById(R.id.search_text_view);
        searchBtn = (TextView) view.findViewById(R.id.right_view);
        searchBtn.setText(getResources().getString(R.string.search_cancel));

        delBtn = (ImageView) view.findViewById(R.id.search_history_del_btn);
        delBtn1 = (Button) view.findViewById(R.id.btn_clean_history);
        historyEmptyLayout = (RelativeLayout) view.findViewById(R.id.search_history_empty_layout);
        hotLabelView = (LabelFlowView) view.findViewById(R.id.label_hot_layout);
        historyLabelView = (LabelFlowView) view.findViewById(R.id.label_history_layout);
    }

    @Override
    public void initData() {
        initRequest();
    }

    @Override
    public void onResume() {
        super.onResume();
        historyLabelView.removeAllViews();
        historyRequest();
    }

    @Override
    public void onPause() {
        super.onPause();
        KeyboardUtils.close(getActivity(), searchTextView);
    }

    @Override
    public void initHttpBack() {
        keyHttpBack = new HttpBack<List<Keywords>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<Keywords> keywordsList) {
                if (keywordsList == null) {
                    return;
                }
                setLabelList(keywordsList, hotLabelView);
            }
        };
    }

    @Override
    public void initRequest() {
        hotRequest();
    }

    @Override
    public void initListener() {
        searchBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        searchTextView.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (EditorInfo.IME_ACTION_SEARCH == i) {
                    if (searchProductForResult(textView))
                        return false;
                }
                return false;
            }
        });
        delBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                HistoryUtils.clearHistory(getActivity(), PreferenceName.Search.SEARCH_HISTORY);
                historyRequest();
            }
        });
        delBtn1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                HistoryUtils.clearHistory(getActivity(), PreferenceName.Search.SEARCH_HISTORY);
                historyRequest();
            }
        });
    }

    private boolean searchProductForResult(TextView textView) {
        String keywords = textView.getText().toString().trim();
        if (TextUtils.isEmpty(keywords.trim())) {
            ToastUtils.show(getActivity(), R.string.search_location_empty_notify);
            return true;
        }
        if (CheckUtils.isConSpeCharacters(keywords.trim())) {
            ToastUtils.show(getActivity(), R.string.search_error_notify);
            return true;
        }
        saveDateToHistory(keywords);
        Intent intent = new Intent(getActivity(), SearchResultActivity.class);
        intent.putExtra(Constants.BundleName.SEARCH_KEYWORD, keywords);
        startActivity(intent);
        return false;
    }

    private void saveDateToHistory(String keywords) {
        HistoryUtils.addHistory(getActivity(), keywords, PreferenceName.Search.SEARCH_HISTORY);
    }

    /**
     * 热门搜索
     */
    private void hotRequest() {
        RetrofitUtils.getInstance().getHotProductKey(ParamUtils.getParam(null), keyHttpBack);
    }

    /**
     * 获取搜索历史
     */
    private void historyRequest() {
        mList = HistoryUtils.getHistory(getActivity(), PreferenceName.Search.SEARCH_HISTORY);
        if (mList == null || mList.size() == 0) {
            historyEmptyLayout.setVisibility(View.VISIBLE);
            delBtn.setVisibility(View.GONE);
            delBtn1.setVisibility(View.GONE);
            historyLabelView.setVisibility(View.GONE);
        } else {
            historyEmptyLayout.setVisibility(View.GONE);
            delBtn.setVisibility(View.VISIBLE);
            delBtn1.setVisibility(View.VISIBLE);
            historyLabelView.setVisibility(View.VISIBLE);
            Collections.reverse(mList);
            setLabel(mList, historyLabelView);
        }
    }

    /**
     * 标签内容设置
     */
    private void setLabel(List<String> keywordsList, LabelFlowView labelView) {
        ViewGroup.MarginLayoutParams lp = new ViewGroup.MarginLayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT);
        BaseActivity activity = (BaseActivity) getActivity();
        if (activity == null) {
            return;
        }
        int marginLR = DisplayUtils.dp2px(getActivity(), 8);
        int marginTB = DisplayUtils.dp2px(getActivity(), 3);
        int margin = DisplayUtils.dp2px(getActivity(), 4);
        lp.setMargins(margin, margin, margin, margin);
        for (final String keywords : keywordsList) {
            showLabelContent(labelView, lp, marginLR, marginTB, keywords);
        }
    }

    /**
     * 热门内容设置
     */
    private void setLabelList(List<Keywords> keywordsList, LabelFlowView labelView) {
        ViewGroup.MarginLayoutParams lp = new ViewGroup.MarginLayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT);
        BaseActivity activity = (BaseActivity) getActivity();
        if (activity == null) {
            return;
        }
        int marginLR = DisplayUtils.dp2px(activity, 8);
        int marginTB = DisplayUtils.dp2px(activity, 3);
        int margin = DisplayUtils.dp2px(activity, 4);
        lp.setMargins(margin, margin, margin, margin);
        for (final Keywords keywords : keywordsList) {
            final String keyword = keywords.getValue();
            showLabelContent(labelView, lp, marginLR, marginTB, keyword);
        }
    }

    private void showLabelContent(LabelFlowView labelView, ViewGroup.MarginLayoutParams lp, int marginLR, int marginTB, final String keywords) {
        TextView view = new TextView(getActivity());
        view.setText(keywords);
        view.setTextColor(getResources().getColor(R.color.primaryText));
        view.setTextSize(12f);
        view.setBackgroundResource(R.drawable.button_white_gray_selector);
        view.setPadding(marginLR, marginTB, marginLR, marginTB);
        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                saveDateToHistory(keywords);

                GotoSearchResult(keywords);
            }
        });
        labelView.addView(view, lp);
    }

    private void GotoSearchResult(String keywords) {
        Intent intent = new Intent(getActivity(), SearchResultActivity.class);
        intent.putExtra(Constants.BundleName.SEARCH_KEYWORD, keywords);
        startActivity(intent);
    }
}
