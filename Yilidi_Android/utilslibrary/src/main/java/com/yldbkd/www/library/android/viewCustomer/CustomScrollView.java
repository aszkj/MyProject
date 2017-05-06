package com.yldbkd.www.library.android.viewCustomer;

import android.content.Context;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ScrollView;

/**
 * fix scrollview 和viewpager冲突的问题
 */
public class CustomScrollView extends ScrollView {

    boolean noScrolling = false;
    float oldX, oldY;

    public CustomScrollView(Context context) {
        super(context);
    }

    public CustomScrollView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        if (noScrolling) {
            return false;
        }
        return super.onTouchEvent(event);
    }

    @Override
    public boolean onInterceptTouchEvent(MotionEvent event) {
        int action = event.getActionMasked();

        if (action == MotionEvent.ACTION_DOWN) {
            oldX = event.getX();
            oldY = event.getY();
            noScrolling = false;

        } else if (action == MotionEvent.ACTION_MOVE) {
            float dx = event.getX() - oldX;
            float dy = event.getY() - oldY;

            if (Math.abs(dy) > Math.abs(dx) && dy != 0) {
                View hsvChild = getChildAt(0);
                int childH = hsvChild.getHeight();
                int H = getHeight();
                if (childH > H) {
                    int scrollY = getScrollY();
                    if ((dy < 0 && scrollY + H >= childH) || (dy > 0 && scrollY <= 0)) {
                        noScrolling = true;
                        return false;
                    } else {
                        noScrolling = false;
                    }
                } else {
                    noScrolling = true;
                    return false;
                }
            }
        }
        return super.onInterceptTouchEvent(event);
    }
}
