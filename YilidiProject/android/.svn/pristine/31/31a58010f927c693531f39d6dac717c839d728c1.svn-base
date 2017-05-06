package com.yldbkd.www.buyer.android.fragment;

import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.ToastUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2016/11/21 10:49
 * @描述 意见反馈
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */

public class FeedBackFragment extends BaseFragment {
    private View backView;
    private TextView mTitleView;
    private EditText etQuestionDesc;
    private TextView count;
    private Button mBtnSubmit;
    private HttpBack<BaseModel> feedBackHttpBack;

    @Override
    public int setLayoutId() {
        return R.layout.feedback_fragment;
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.back_view);
        mTitleView = (TextView) view.findViewById(R.id.title_view);
        etQuestionDesc = (EditText) view.findViewById(R.id.et_question_desc);
        count = (TextView) view.findViewById(R.id.content_count);
        mBtnSubmit = (Button) view.findViewById(R.id.btn_submit);
    }

    @Override
    public void initData() {
        mTitleView.setText(getResources().getString(R.string.setting_feedback));
        count.setText(String.format(getResources().getString(R.string.feedback_text_count), String.valueOf(0)));
    }

    @Override
    public void initHttpBack() {
        feedBackHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel baseModel) {
                ToastUtils.showShort(getActivity(), getResources().getString(R.string.feedback_toast));
                getActivity().onBackPressed();
            }
        };
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        etQuestionDesc.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                count.setText(String.format(getResources().getString(R.string.feedback_text_count),
                        etQuestionDesc.getText().toString().length()));
            }
        });
        mBtnSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String questionContent = etQuestionDesc.getText().toString();
                if (TextUtils.isEmpty(questionContent)) {
                    ToastUtils.show(getActivity(), R.string.profile_feedback_content);
                    return;
                }
                request(CheckUtils.filterSpecialCharacter(questionContent));
            }
        });
    }

    private void request(String question) {
        Map<String, Object> map = new HashMap<>();
        map.put("content", question);
        RetrofitUtils.getInstance(true).feedback(ParamUtils.getParam(map), feedBackHttpBack);
    }
}
