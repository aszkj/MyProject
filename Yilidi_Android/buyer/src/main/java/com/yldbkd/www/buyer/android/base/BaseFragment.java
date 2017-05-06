package com.yldbkd.www.buyer.android.base;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.umeng.analytics.MobclickAgent;
import com.yldbkd.www.buyer.android.utils.Logger;

/**
 * Fragment基本类，应用所有Fragment都需要继承该类统一管理
 * <p/>
 * Created by linghuxj on 15/9/24.
 */
public abstract class BaseFragment extends Fragment {
    /**
     * Fragment视图View
     */
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

    /**
     * 初始化bundle数据
     */
    public void initBundle() {
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        if (null != mContextView) {
            ViewGroup parent = (ViewGroup) mContextView.getParent();
            if (null != parent) {
                parent.removeView(mContextView);
            }
        }
        mContextView = inflater.inflate(setLayoutId(), null);
        initView(mContextView);
        initData();
        initListener();
        Logger.d(this.getClass().getSimpleName() + " onCreateView.");
        return mContextView;
    }

    /**
     * 初始化监听器
     */
    public void initListener() {
    }

    /**
     * 初始化页面数据
     */
    public void initData() {
    }

    public void initHttpBack(){}

    public void initRequest(){}

    public abstract int setLayoutId();

    public abstract void initView(View view);


    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        Logger.d(this.getClass().getSimpleName() + " onViewCreated.");
    }

    @Override
    public void onResume() {
        super.onResume();
        //友盟统计
        MobclickAgent.onPageStart("BaseFragment");
        Logger.d(this.getClass().getSimpleName() + " onResume.");
    }

    @Override
    public void onPause() {
        super.onPause();
        //友盟统计
        MobclickAgent.onPageEnd("BaseFragment");
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
