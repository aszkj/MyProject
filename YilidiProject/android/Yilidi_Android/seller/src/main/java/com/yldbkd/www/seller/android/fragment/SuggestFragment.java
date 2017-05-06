package com.yldbkd.www.seller.android.fragment;

import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.google.zxing.common.StringUtils;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.BaseModel;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * 意见
 * <p/>
 * Created by linghuxj on 16/6/14.
 */
public class SuggestFragment extends BaseFragment {

    private LinearLayout backView;

    private EditText contentView;
    private TextView countView;
    private Button submitBtn;

    private HttpBack<BaseModel> suggestHttpBack;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_suggest;
    }

    @Override
    public void initHttpBack() {
        suggestHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel baseModel) {
                ToastUtils.show(getActivity(), R.string.profile_suggest_submit_success);
                getActivity().onBackPressed();
            }
        };
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_suggest));

        contentView = (EditText) view.findViewById(R.id.et_suggest);
        countView = (TextView) view.findViewById(R.id.tv_suggest_count);
        submitBtn = (Button) view.findViewById(R.id.btn_suggest_submit);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        contentView.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
            }

            @Override
            public void afterTextChanged(Editable s) {
                showCount();
            }
        });
        submitBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                suggestRequest();
            }
        });
    }

    @Override
    public void initData() {
        showCount();
    }

    @Override
    public void onStop() {
        super.onStop();
        KeyboardUtils.close(getActivity());
    }

    private void showCount() {
        String content = contentView.getText().toString();
        int length = TextUtils.isEmpty(content) ? 0 : content.length();
        countView.setText(String.format(getString(R.string.profile_suggest_count), length));
    }

    private boolean validateContent(String content) {
        if (TextUtils.isEmpty(content)) {
            ToastUtils.show(getActivity(), R.string.profile_suggest_empty);
            return false;
        }
        if (CheckUtils.isConSpeCharacters(content)) {
            ToastUtils.show(getActivity(), R.string.profile_suggest_error);
            return false;
        }
        return true;
    }

    private void suggestRequest() {
        String content = contentView.getText().toString();
        if (!validateContent(content)) {
            return;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("feebackContent", content);
        RetrofitUtils.getInstance(true).feeback(ParamUtils.getParam(map), suggestHttpBack);
    }
}
