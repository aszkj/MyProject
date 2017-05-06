package com.yldbkd.www.seller.android.fragment;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.yldbkd.www.seller.android.activity.BaseActivity;
import com.yldbkd.www.seller.android.utils.Logger;

/**
 * Fragment基本类，应用所有Fragment都需要继承该类统一管理
 * <p/>
 * Created by linghuxj on 15/9/24.
 */
public abstract class BaseFragment extends Fragment {

    private View mContextView;

    public BaseActivity getBaseActivity() {
        return (BaseActivity) getActivity();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        initBundle();
        initHttpBack();
        Logger.d(this.getClass().getSimpleName() + " onCreate.");
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        if (mContextView != null) {
            ViewGroup parent = (ViewGroup) mContextView.getParent();
            if (null != parent) {
                parent.removeView(mContextView);
            }
        }
        mContextView = inflater.inflate(setLayoutId(), container, false);
        initView(mContextView);
        initAdapter();
        initListener();
        initData();
        initRequest();
        Logger.d(this.getClass().getSimpleName() + " onCreateView.");
        return mContextView;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        Logger.d(this.getClass().getSimpleName() + " onViewCreated.");
    }

    public void initBundle() {
    }

    public void initHttpBack() {
    }

    public abstract int setLayoutId();

    public void initView(View view) {
    }

    public void initData() {
    }

    public void initAdapter() {
    }

    public void initListener() {
    }

    public void initRequest(){
    }

    @Override
    public void onResume() {
        super.onResume();
        Logger.d(this.getClass().getSimpleName() + " onResume.");
    }

    @Override
    public void onPause() {
        super.onPause();
        Logger.d(this.getClass().getSimpleName() + " onPause.");
    }

    @Override
    public void onStop() {
        super.onStop();
        Logger.d(this.getClass().getSimpleName() + " onStop.");
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        Logger.d(this.getClass().getSimpleName() + " onDestroy.");
    }

    @Override
    public void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        Logger.d(this.getClass().getSimpleName() + " onSaveInstanceState.");
    }
}
