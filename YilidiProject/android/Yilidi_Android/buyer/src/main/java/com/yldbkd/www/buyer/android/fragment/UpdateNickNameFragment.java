package com.yldbkd.www.buyer.android.fragment;

import android.text.TextUtils;
import android.view.View;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;

import java.util.HashMap;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2017/2/20 18:26
 * @描述 账户安全
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */

public class UpdateNickNameFragment extends BaseFragment {
    private View backView;
    private TextView titleView;
    private ImgTxtButton rightBtn;
    private ClearableEditText nickName;
    private HttpBack<BaseModel> updateNickNameHttpBack;
    private String newNickName;

    @Override
    public int setLayoutId() {
        return R.layout.update_nickname_fragment;
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.update_nickname_title));
        rightBtn = (ImgTxtButton) view.findViewById(R.id.right_view);
        rightBtn.setText(getResources().getString(R.string.define_button_text));
        nickName = (ClearableEditText) view.findViewById(R.id.nickname_text_view);
    }

    @Override
    public void initData() {
        nickName.setText(UserUtils.getNickName());
        nickName.requestFocus();
        KeyboardUtils.openDelay(getContext(), nickName);
    }

    @Override
    public void initHttpBack() {
        updateNickNameHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel baseModel) {
                UserUtils.setNickName(newNickName);
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
        rightBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                newNickName = nickName.getText().toString().trim();
                if (TextUtils.isEmpty(newNickName)) {
                    ToastUtils.show(getActivity(), R.string.nickname_empty_toast);
                    return;
                }
                if (!CheckUtils.checkChineseName(newNickName)) {
                    ToastUtils.show(getActivity(), R.string.nickname_espical_word_toast);
                    return;
                }
                saveNicknameRequest();
            }
        });
    }

    private void saveNicknameRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("nickName", newNickName);
        RetrofitUtils.getInstance(true).modifyUserInfo(ParamUtils.getParam(map), updateNickNameHttpBack);
    }

    @Override
    public void onPause() {
        super.onPause();
        KeyboardUtils.close(getActivity(), nickName);
    }
}
