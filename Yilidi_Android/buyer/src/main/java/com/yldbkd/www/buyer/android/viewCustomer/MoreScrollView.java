package com.yldbkd.www.buyer.android.viewCustomer;

import android.annotation.TargetApi;
import android.content.Context;
import android.os.Build;
import android.util.AttributeSet;
import android.view.*;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import com.yldbkd.www.buyer.android.R;

/**
 * 查看更多的ScrollView
 * <p/>
 * Created by linghuxj on 15/11/19.
 */
public class MoreScrollView extends ScrollView {

    private ScrollView scrollView;
    private View footerView;
    private int footerViewHeight;
    private int lastMotionY;
    private int footerState;
    private int touchSlop;
    private static final int READY = 0, PULL_STATE = 1, REFRESHING = 2;
    private OnRefreshListener refreshListener;

    public MoreScrollView(Context context) {
        super(context);
        touchSlop = ViewConfiguration.get(context).getScaledTouchSlop();
    }

    public MoreScrollView(Context context, AttributeSet attrs) {
        super(context, attrs);
        touchSlop = ViewConfiguration.get(context).getScaledTouchSlop();
    }

    public MoreScrollView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        touchSlop = ViewConfiguration.get(context).getScaledTouchSlop();
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    public MoreScrollView(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        touchSlop = ViewConfiguration.get(context).getScaledTouchSlop();
    }

    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();
        addFootView();
        initContentView();
    }

    private void addFootView() {
        footerView = LayoutInflater.from(getContext()).inflate(R.layout.product_detail_more_view, this, false);
        measureView(footerView);
        footerViewHeight = footerView.getMeasuredHeight();
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,
                footerViewHeight);
        addView(footerView, params);
    }

    private void initContentView() {
        int count = getChildCount();
        View view;
        for (int i = 0; i < count; i++) {
            view = getChildAt(i);
            if (view instanceof ScrollView) {
                scrollView = (ScrollView) view;
            }
        }
        if (scrollView == null) {
            throw new IllegalArgumentException("must contain a ScrollView in this layout!");
        }
    }

    @Override
    public boolean onInterceptTouchEvent(MotionEvent e) {
        int y = (int) e.getRawY();
        switch (e.getAction()) {
            case MotionEvent.ACTION_DOWN:
                // 首先拦截down事件,记录y坐标
                lastMotionY = y;
                break;
            case MotionEvent.ACTION_MOVE:
                // deltaY > 0 是向下运动,< 0是向上运动
                int deltaY = y - lastMotionY;
                if (deltaY > 0) {
                    return false;
                }
                if (isRefreshViewScroll(deltaY)) {
                    return true;
                }
                break;
            case MotionEvent.ACTION_UP:
            case MotionEvent.ACTION_CANCEL:
                break;
        }
        return false;
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        int y = (int) event.getRawY();
        switch (event.getAction()) {
            case MotionEvent.ACTION_DOWN:
                break;
            case MotionEvent.ACTION_MOVE:
                int deltaY = y - lastMotionY;
                if (footerState == PULL_STATE) {// 执行上拉
                    footerPrepareToRefresh(deltaY);
                }
                lastMotionY = y;
                break;
            case MotionEvent.ACTION_UP:
            case MotionEvent.ACTION_CANCEL:
                int topMargin = getTopMargin();
                if (footerState == PULL_STATE) {
                    if (Math.abs(topMargin) >= footerViewHeight) {
                        // 开始执行footer 刷新
                        footerRefreshing();
                    } else {
                        // 还没有执行刷新，重新隐藏
                        setTopMargin(-footerViewHeight);
                    }
                }
                break;
        }
        return super.onTouchEvent(event);
    }

    private void footerPrepareToRefresh(int deltaY) {
        int newTopMargin = changingHeaderViewTopMargin(deltaY);
        // 如果header view topMargin 的绝对值大于或等于header + footer 的高度
        if (Math.abs(newTopMargin) >= footerViewHeight && footerState != PULL_STATE) {
            if (refreshListener != null) {
                refreshListener.onRefresh(this);
            }
        }
    }

    private boolean isRefreshViewScroll(int deltaY) {
        if (footerState == REFRESHING) {
            return false;
        }
        // 子scroll view滑动到最顶端
        View child = scrollView.getChildAt(0);
        if (deltaY < -touchSlop && child.getMeasuredHeight() <= getHeight() + scrollView.getScrollY()) {
            footerState = PULL_STATE;
            return true;
        }
        return false;
    }

    private int changingHeaderViewTopMargin(int deltaY) {
        LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) scrollView.getLayoutParams();
        float newTopMargin = params.topMargin + deltaY * 0.3f;
        // 这里对上拉做一下限制,因为当前上拉后然后不释放手指直接下拉,会把下拉刷新给触发了,感谢网友yufengzungzhe的指出
        // 表示如果是在上拉后一段距离,然后直接下拉
        if (deltaY > 0 && footerState == PULL_STATE && Math.abs(params.topMargin) <= footerViewHeight) {
            return params.topMargin;
        }
        params.topMargin = (int) newTopMargin;
        scrollView.setLayoutParams(params);
        invalidate();
        return params.topMargin;
    }

    private void footerRefreshing() {
        footerState = REFRESHING;
        setTopMargin(-footerViewHeight);
    }

    private void setTopMargin(int topMargin) {
        LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) scrollView.getLayoutParams();
        params.topMargin = topMargin;
        scrollView.setLayoutParams(params);
        invalidate();
    }

    private int getTopMargin() {
        LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) scrollView.getLayoutParams();
        return params.topMargin;
    }

    private void measureView(View child) {
        ViewGroup.LayoutParams p = child.getLayoutParams();
        if (p == null) {
            p = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT);
        }

        int childWidthSpec = ViewGroup.getChildMeasureSpec(0, 0 + 0, p.width);
        int lpHeight = p.height;
        int childHeightSpec;
        if (lpHeight > 0) {
            childHeightSpec = MeasureSpec.makeMeasureSpec(lpHeight,
                    MeasureSpec.EXACTLY);
        } else {
            childHeightSpec = MeasureSpec.makeMeasureSpec(0,
                    MeasureSpec.UNSPECIFIED);
        }
        child.measure(childWidthSpec, childHeightSpec);
    }

    public interface OnRefreshListener {
        void onRefresh(MoreScrollView view);
    }
}
