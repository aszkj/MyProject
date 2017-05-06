package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.content.ContextCompat;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.AddressAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.AddressBase;
import com.yldbkd.www.buyer.android.bean.Community;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.library.android.viewCustomer.ListInScrollView;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.List;

/**
 * 地址列表页面Fragment
 * <p/>
 * Created by linghuxj on 15/10/13.
 */
public class AddressListFragment extends BaseFragment {

    private RelativeLayout backView;
    private ImgTxtButton mRightView;

    private RelativeLayout emptyLayout;
    private ListInScrollView addressListView;
    private AddressAdapter addressAdapter;

    private HttpBack<List<AddressBase>> addressHttpBack;
    private List<AddressBase> addressBaseList = new ArrayList<>();

    private boolean isCartSelected = false;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        isCartSelected = bundle.getBoolean(Constants.BundleName.CART_SELECT_ADDRESS);
    }

    @Override
    public int setLayoutId() {
        return R.layout.address_list_fragment;
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);
        mRightView = (ImgTxtButton) view.findViewById(R.id.right_view);
        mRightView.setText(getResources().getString(R.string.address_create));
        mRightView.setTextColor(ContextCompat.getColor(getActivity(), R.color.colorOrange));

        if (isCartSelected) {
            titleView.setText(getResources().getString(R.string.address_title_select));
        } else
            titleView.setText(getResources().getString(R.string.address_title_manage));
        emptyLayout = (RelativeLayout) view.findViewById(R.id.address_empty_layout);
        addressListView = (ListInScrollView) view.findViewById(R.id.address_list_layout);
    }

    @Override
    public void initData() {
        initAdapter();
    }

    @Override
    public void initHttpBack() {
        addressHttpBack = new HttpBack<List<AddressBase>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<AddressBase> addressBases) {
                addressBaseList.clear();
                if (addressBases != null) {
                    addressBaseList.addAll(addressBases);
                }
                addressAdapter.notifyDataSetChanged();
            }
        };
    }

    @Override
    public void initRequest() {
        RetrofitUtils.getInstance(true).getUserAddressList(ParamUtils.getParam(null), addressHttpBack);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().setResult(Activity.RESULT_CANCELED);
                getActivity().onBackPressed();
            }
        });
        mRightView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getBaseActivity().showFragment(AddressFragment.class.getSimpleName(), null, true);
            }
        });
    }

    @Override
    public void onResume() {
        super.onResume();
        initRequest();
    }

    private void initAdapter() {
        addressAdapter = new AddressAdapter(addressBaseList, getActivity(), new AddressHandler(this), isCartSelected);
        addressListView.setAdapter(addressAdapter);
    }

    private void modify(int position) {
        AddressBase addressBase = addressBaseList.get(position);
        Bundle bundle = new Bundle();
        bundle.putInt(Constants.BundleName.ADDRESS_ID, addressBase.getAddressId());
        getBaseActivity().showFragment(AddressFragment.class.getSimpleName(), bundle, true);
    }

    private void select(int position) {
        AddressBase addressBase = addressBaseList.get(position);
        Integer saveStoreId = CommunityUtils.getCurrentStoreId();
        Community community = addressBase.getCommunity();
        if (community.getStoreInfo() == null || community.getStoreInfo().getStoreId().intValue() != saveStoreId.intValue()) {
            return;
        }
        Intent intent = new Intent();
        intent.putExtra(Constants.BundleName.ADDRESS_INFO, addressBase);
        getActivity().setResult(Activity.RESULT_OK, intent);
        getActivity().finish();
    }

    static class AddressHandler extends Handler {
        private WeakReference<AddressListFragment> addressWeakReference;

        public AddressHandler(AddressListFragment fragment) {
            this.addressWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            AddressListFragment fragment = addressWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.ADDRESS_MODIFY:
                    fragment.modify((int) msg.obj);
                    break;
                case Constants.HandlerCode.ADDRESS_SELECT:
                    if (fragment.isCartSelected) {
                        fragment.select((int) msg.obj);
                    }
                    break;
            }
        }
    }
}