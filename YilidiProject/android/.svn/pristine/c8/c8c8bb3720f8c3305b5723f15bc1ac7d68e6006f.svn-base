package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.content.ContextCompat;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.SearchActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.AddressBase;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.bean.Community;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;

import java.util.HashMap;
import java.util.Map;

/**
 * 地址新增或修改页面Fragment
 * <p/>
 * Created by linghuxj on 15/10/14.
 */
public class AddressFragment extends BaseFragment {

    private Integer addressId;
    private String provinceCode;
    private String cityCode;
    private String countyCode;
    private Integer communityId;

    private HttpBack<AddressBase> addressDetailHttpBack;
    private HttpBack<AddressBase> saveHttpBack;
    private HttpBack<BaseModel> delHttpBack;

    private RelativeLayout backView;
    private ImgTxtButton saveBtn;
    private ImageView mIvNearbyAddress;
    private ClearableEditText consigneeView;
    private ClearableEditText phoneView;
    private TextView cityView, mTvAddressNotice;
    private ClearableEditText detailView;
    private Button delBtn;

    private CommonDialog dialog;

    private boolean isCartSelected = false;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        addressId = bundle.getInt(Constants.BundleName.ADDRESS_ID, 0);
        isCartSelected = bundle.getBoolean(Constants.BundleName.CART_SELECT_ADDRESS);
    }

    @Override
    public int setLayoutId() {
        return R.layout.address_fragment;
    }

    @Override
    public void initView(View view) {
        //title
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(addressId == null || addressId <= 0 ? R.string.address_title_add :
                R.string.address_title_modify));
        saveBtn = (ImgTxtButton) view.findViewById(R.id.right_view);
        saveBtn.setText(getResources().getString(R.string.address_save));
        saveBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.colorOrange));
        // content
        mIvNearbyAddress = (ImageView) view.findViewById(R.id.iv_nearby_address);
        consigneeView = (ClearableEditText) view.findViewById(R.id.address_consignee_name_view);
        phoneView = (ClearableEditText) view.findViewById(R.id.address_phone_no_view);

        cityView = (TextView) view.findViewById(R.id.address_city_view);
        mTvAddressNotice = (TextView) view.findViewById(R.id.tv_address_notice);
        detailView = (ClearableEditText) view.findViewById(R.id.address_consignee_detail_view);
        delBtn = (Button) view.findViewById(R.id.address_save_btn);
        if (addressId == null || addressId <= 0) {
            delBtn.setText(getResources().getString(R.string.address_save));
            saveBtn.setVisibility(View.GONE);
        } else {
            delBtn.setText(getResources().getString(R.string.address_delete));
            saveBtn.setVisibility(View.VISIBLE);
        }

        detailView.requestFocus();
        KeyboardUtils.openDelay(getContext(), detailView);
    }

    @Override
    public void initData() {
        initRequest();
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(getActivity());
                getActivity().onBackPressed();
            }
        });
        mIvNearbyAddress.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), SearchActivity.class);
                intent.setAction(LocationNearbyFragment.class.getSimpleName());
                intent.putExtra(Constants.BundleName.IS_ADDRESS_LIST, true);
                startActivityForResult(intent, Constants.RequestCode.SEARCH_LOCATION_CODE);
            }
        });
        cityView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), SearchActivity.class);
                intent.setAction(SearchLocationResultFragment.class.getSimpleName());
                intent.putExtra(Constants.BundleName.IS_ADDRESS_LIST, true);
                startActivityForResult(intent, Constants.RequestCode.SEARCH_LOCATION_CODE);
            }
        });
        saveBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                requestSave();
            }
        });
        delBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (addressId == null || addressId <= 0) {
                    requestSave();
                } else {
                    if(dialog != null && dialog.isShowing()){
                        return;
                    }
                    dialog = new CommonDialog(getActivity(), new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            requestDel();
                            dialog.dismiss();
                        }
                    });
                    dialog.setData(getResources().getString(R.string.address_dialog_del_content),
                            getResources().getString(R.string.address_dialog_del_button));
                    dialog.show();
                }
            }
        });
    }

    @Override
    public void initHttpBack() {
        addressDetailHttpBack = new HttpBack<AddressBase>(getBaseActivity()) {
            @Override
            public void onSuccess(AddressBase addressDetail) {
                setViewData(addressDetail);
            }
        };
        saveHttpBack = new HttpBack<AddressBase>(getBaseActivity()) {
            @Override
            public void onSuccess(AddressBase addressBase) {
                KeyboardUtils.close(getActivity());
                if (isCartSelected) {
                    Intent intent = new Intent();
                    intent.putExtra(Constants.BundleName.ADDRESS_INFO, addressBase);
                    getActivity().setResult(Activity.RESULT_OK, intent);
                    getActivity().finish();
                } else {
                    getActivity().onBackPressed();
                }
            }
        };
        delHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel baseModel) {
                KeyboardUtils.close(getActivity());
                getActivity().onBackPressed();
            }
        };
    }

    @Override
    public void initRequest() {
        if (addressId == null || addressId <= 0) {
            // 代表着新增地址，将初始化地址信息
            if (CommunityUtils.getCurrentCommunity() != null) {
                setLocationData(CommunityUtils.getCurrentCommunity(), false);
            }
            phoneView.setText(UserUtils.getLoginName());
            return;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("addressId", addressId);
        RetrofitUtils.getInstance(true).getAddressDetail(ParamUtils.getParam(map), addressDetailHttpBack);
    }

    private boolean validate() {
        String name = consigneeView.getText().toString().trim();
        if (TextUtils.isEmpty(name)) {
            ToastUtils.show(getActivity(), R.string.address_consignee_name_notify);
            return false;
        }
        if (CheckUtils.isConSpeCharacters(name)) {
            ToastUtils.show(getActivity(), R.string.address_consignee_error_name_notify);
            return false;
        }
        String phone = phoneView.getText().toString().trim();
        if (TextUtils.isEmpty(phone) || !CheckUtils.isMobileNO(phone)) {
            ToastUtils.show(getActivity(), R.string.address_phone_no_notify);
            return false;
        }
        if (TextUtils.isEmpty(provinceCode) || TextUtils.isEmpty(cityCode) || TextUtils.isEmpty(countyCode)) {
            ToastUtils.show(getActivity(), R.string.address_city_notify);
            return false;
        }
        if (communityId == null) {
            ToastUtils.show(getActivity(), R.string.address_community_notify);
            return false;
        }
        String detail = detailView.getText().toString().trim();
        if (TextUtils.isEmpty(detail)) {
            ToastUtils.show(getActivity(), R.string.address_detail_notify);
            return false;
        }
        if (CheckUtils.isConSpeCharacters(detail)) {
            ToastUtils.show(getActivity(), R.string.address_detail_error_notify);
            return false;
        }
        return true;
    }

    private void requestSave() {
        if (!validate()) {
            return;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("consigneeName", consigneeView.getText().toString().trim());
        map.put("phoneNo", phoneView.getText().toString().trim());
        map.put("provinceCode", provinceCode);
        map.put("cityCode", cityCode);
        map.put("countyCode", countyCode);
        map.put("addressDetail", detailView.getText().toString().trim());
        map.put("communityId", communityId);
        if (addressId != null && addressId > 0) {
            map.put("addressId", addressId);
        }
        RetrofitUtils.getInstance(true).updateUserAddress(ParamUtils.getParam(map), saveHttpBack);
    }

    private void requestDel() {
        if (addressId == null || addressId <= 0) {
            ToastUtils.showShort(getActivity(), R.string.address_delete_exception);
            return;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("addressId", addressId);
        RetrofitUtils.getInstance(true).deleteUserAddress(ParamUtils.getParam(map), delHttpBack);
    }

    private void setViewData(AddressBase addressDetail) {
        if (addressDetail == null) {
            return;
        }
        consigneeView.setText(addressDetail.getConsigneeName());
        phoneView.setText(addressDetail.getPhoneNo());
        Community community = addressDetail.getCommunity();
        provinceCode = community.getProvinceCode();
        cityCode = community.getCityCode();
        countyCode = community.getCountyCode();
        cityView.setText(String.valueOf(community.getCommunityName()));
        communityId = community.getCommunityId();
        detailView.setText(community.getAddressDetail());

        detailView.setSelection(community.getAddressDetail().trim().length());

        if (community.getStoreInfo() != null) {
            addressNoticeShow(community.getStoreInfo().getStoreId() == null ? 0 : community.getStoreInfo().getStoreId());
        }
    }

    private void addressNoticeShow(int storeId) {
        if (storeId != CommunityUtils.getCurrentStoreId()) {
            mTvAddressNotice.setVisibility(View.VISIBLE);
        } else {
            mTvAddressNotice.setVisibility(View.GONE);
        }
    }

    private void setLocationData(Community community, boolean falg) {
        if (community == null) {
            return;
        }
        provinceCode = community.getProvinceCode();
        cityCode = community.getCityCode();
        countyCode = community.getCountyCode();
        cityView.setText(String.valueOf(community.getCommunityName()));
        communityId = community.getCommunityId();
        if (falg) {
            detailView.setText("");
        }
        if (community.getStoreInfo() != null) {
            addressNoticeShow(community.getStoreInfo().getStoreId());
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (Constants.RequestCode.SEARCH_LOCATION_CODE == requestCode) {
            if (resultCode == Activity.RESULT_FIRST_USER) {
                Community community = (Community) data.getSerializableExtra(Constants.BundleName.LOCATION_INFO);
                setLocationData(community, true);
            }
        }
    }
}