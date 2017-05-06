package com.yldbkd.www.library.android.pullRefresh;

import android.content.Context;
import android.util.AttributeSet;
import android.view.MotionEvent;
import in.srain.cube.views.ptr.PtrClassicFrameLayout;

/**
 * Created by op on 2015/12/21.
 */
public class FixRequestDisallowPtrFrameLayout extends PtrClassicFrameLayout {

    private boolean disallowInterceptTouchEvent = false;

    public FixRequestDisallowPtrFrameLayout(Context context) {
        super(context);
    }

    public FixRequestDisallowPtrFrameLayout(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public FixRequestDisallowPtrFrameLayout(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    @Override
    public void requestDisallowInterceptTouchEvent(boolean disallowIntercept) {
        disallowInterceptTouchEvent = disallowIntercept;
        super.requestDisallowInterceptTouchEvent(disallowIntercept);
    }

    @Override
    public boolean dispatchTouchEvent(MotionEvent e) {
        if (disallowInterceptTouchEvent) {
            return dispatchTouchEventSupper(e);
        }
        return super.dispatchTouchEvent(e);
    }
}
