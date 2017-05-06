package com.yldbkd.www.seller.android.fragment;

import android.support.v4.content.ContextCompat;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.library.android.viewCustomer.SwitchButton;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.BaseModel;
import com.yldbkd.www.seller.android.bean.StoreDetail;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * 店铺管理页面
 * <p/>
 * Created by linghuxj on 16/6/14.
 */
public class StoreManageFragment extends BaseFragment {

    private StoreDetail storeDetail;

    private LinearLayout backView;
    private ImgTxtButton saveBtn;

    private TextView nameView;
    private TextView businessView;
    private TextView priceView;
    private TextView hotLineView;
    private TextView areaView;
    private TextView addressView;
    private SwitchButton statusBtn;

    private HttpBack<StoreDetail> storeDetailHttpBack;
    private HttpBack<BaseModel> saveHttpBack;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_store_manage;
    }

    @Override
    public void initHttpBack() {
        saveHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel baseModel) {
                ToastUtils.show(getActivity(), R.string.store_save_success);
            }
        };
        storeDetailHttpBack = new HttpBack<StoreDetail>() {
            @Override
            public void onSuccess(StoreDetail store) {
                storeDetail = store;
                setData();
            }
        };
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_store_manage));
        saveBtn = (ImgTxtButton) view.findViewById(R.id.itb_right);
        saveBtn.setText(getString(R.string.store_save_btn));
        saveBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.white));
        saveBtn.getTextView().setBackgroundResource(R.drawable.blue_bg);

        nameView = (TextView) view.findViewById(R.id.tv_store_manage_name);
        businessView = (TextView) view.findViewById(R.id.tv_store_manage_business);
        priceView = (TextView) view.findViewById(R.id.tv_store_manage_deduce_price);
        hotLineView = (TextView) view.findViewById(R.id.tv_store_manage_hot_line);
        areaView = (TextView) view.findViewById(R.id.tv_store_manage_area);
        addressView = (TextView) view.findViewById(R.id.tv_store_manage_address);
        statusBtn = (SwitchButton) view.findViewById(R.id.sb_store_status);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        saveBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                saveRequest();
            }
        });
        statusBtn.setOnStatusChangeListener(new SwitchButton.OnStatusChangeListener() {
            @Override
            public void onChange(SwitchButton.STATUS status) {
                storeDetail.setStoreStatus(SwitchButton.STATUS.ON == status ? Constants.STORE_STATUS.PAUSE
                        : Constants.STORE_STATUS.NORMAL);
            }
        });
    }

    @Override
    public void initRequest() {
        storeRequest();
    }

    private void setData() {
        nameView.setText(storeDetail.getStoreName());
        businessView.setText(String.format(getString(R.string.store_business_data),
                storeDetail.getBeginBusinessHours(), storeDetail.getEndBusinessHours()));
        priceView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(storeDetail.getDeduceTransCostAmount())));
        hotLineView.setText(storeDetail.getHotline());
        areaView.setText(String.valueOf(storeDetail.getProvinceName() + storeDetail.getCityName() + storeDetail.getCountyName()));
        addressView.setText(storeDetail.getAddressDetail());
        statusBtn.setStatus(storeDetail.getStoreStatus() == Constants.STORE_STATUS.PAUSE ? SwitchButton.STATUS.ON :
                SwitchButton.STATUS.OFF);
    }

    private void storeRequest() {
        RetrofitUtils.getInstance(true).storeDetail(ParamUtils.getParam(null), storeDetailHttpBack);
    }

    private void saveRequest() {
        Map<String, Object> map = new HashMap<>();
        if (storeDetail == null) {
            ToastUtils.show(getActivity(), R.string.store_error);
            return;
        }
        map.put("storeName", storeDetail.getStoreName());
        map.put("beginBusinessHour", storeDetail.getBeginBusinessHours());
        map.put("endBusinessHour", storeDetail.getEndBusinessHours());
        map.put("deduceTransCostAmount", storeDetail.getDeduceTransCostAmount());
        map.put("transCostAmount", storeDetail.getTransCostAmount());
        map.put("hotline", storeDetail.getHotline());
        map.put("storeStatus", storeDetail.getStoreStatus());
        RetrofitUtils.getInstance(true).updateStore(ParamUtils.getParam(map), saveHttpBack);
    }
}
