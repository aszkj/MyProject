package com.yldbkd.www.seller.android.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.view.MotionEvent;
import android.view.View;
import android.widget.FrameLayout;

import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.Logger;

import java.lang.ref.WeakReference;

/**
 * 基本Activity，所有Activity需要继承该Activity
 * <p/>
 * Created by linghuxj on 15/9/23.
 */
public abstract class BaseActivity extends FragmentActivity {

    private FrameLayout contentView;
    private FrameLayout progressLayout;
    private View decoratedView; // 每一个具体view
    private Handler progressHandler = new ProgressHandler(this);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_base);
        contentView = (FrameLayout) findViewById(R.id.content_container);
        progressLayout = (FrameLayout) findViewById(R.id.progress_container);
        progressLayout.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent motionEvent) {
                return true;
            }
        });
        // 记录Activity情况，在退出应用时进行清空处理
        AppManager.getAppManager().addActivity(this);
    }

    protected void setCustomContentView(int resId) {
        View view = View.inflate(this, resId, null);
        if (view != null) {
            if (decoratedView != null) {
                contentView.removeView(decoratedView);
            }
            contentView.addView(view);
            decoratedView = view;
        } else if (decoratedView != null) {
            contentView.removeView(decoratedView);
            decoratedView = null;
        }
    }

    public void showProgress() {
        if (progressLayout.getVisibility() == View.VISIBLE) {
            return;
        }
        progressLayout.setVisibility(View.VISIBLE);
        progressLayout.bringToFront();
    }

    public void hideProgress() {
        if (progressLayout.getVisibility() == View.VISIBLE) {
            progressLayout.setVisibility(View.GONE);
        }
    }

    public Handler getProgressHandler() {
        return progressHandler;
    }

    /**
     * 继承该Activity的类需要实现该方法用于获取Fragment页面实例
     *
     * @param tag Fragment的SimpleName（统一约定）
     * @return
     */
    abstract Fragment newFragmentByTag(String tag);

    /**
     * 打开Fragment页面
     *
     * @param tag            Fragment的SimpleName（统一约定）
     * @param bundle         所需要传递的数据信息
     * @param isAddBackStack 是否加入回退栈
     */
    public void showFragment(String tag, Bundle bundle, boolean isAddBackStack) {
        if (decoratedView == null) {
            Logger.e("decoratedView is NOT FOUND.");
            return;
        }
        Fragment fragment = getSupportFragmentManager().findFragmentByTag(tag);
        fragment = fragment == null ? newFragmentByTag(tag) : fragment;
        if (fragment == null) {
            Logger.e("NO fragment found by tag: " + tag);
            return;
        }
        if (bundle != null) {
            fragment.setArguments(bundle);
        }
        FragmentManager fragmentManager = getSupportFragmentManager();
        FragmentTransaction fragmenttransaction = fragmentManager
                .beginTransaction();
        fragmenttransaction.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_OPEN);
        fragmenttransaction.setCustomAnimations(R.anim.left_push_in,
                R.anim.left_push_out, R.anim.right_push_in,
                R.anim.right_push_out);
        fragmenttransaction.replace(decoratedView.getId(), fragment, tag);
        if (isAddBackStack) {
            fragmenttransaction.addToBackStack(tag);
        }
        fragmenttransaction.commitAllowingStateLoss();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
//        if (this instanceof MainActivity) {
//
//        } else {
        AppManager.getAppManager().finishActivity(this);
//        }
    }

    static class ProgressHandler extends Handler {
        WeakReference<BaseActivity> activityWeakReference;

        public ProgressHandler(BaseActivity activity) {
            this.activityWeakReference = new WeakReference<>(activity);
        }

        @Override
        public void dispatchMessage(Message msg) {
            super.dispatchMessage(msg);
            BaseActivity activity = activityWeakReference.get();
            if (activity == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.PROGRESS_SHOW:
                    activity.showProgress();
                    break;
                case Constants.HandlerCode.PROGRESS_HIDE:
                    activity.hideProgress();
                    break;
            }
        }
    }

}