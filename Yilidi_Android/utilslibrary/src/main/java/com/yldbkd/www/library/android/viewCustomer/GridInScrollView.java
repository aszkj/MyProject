package com.yldbkd.www.library.android.viewCustomer;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.GridView;

public class GridInScrollView extends GridView {

    public GridInScrollView(Context context) {
        super(context);
    }

    public GridInScrollView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    /**
     * 重写该方法，达到使GridView适应ScrollView的效果
     */
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        int expandSpec = MeasureSpec.makeMeasureSpec(Integer.MAX_VALUE >> 2,
                MeasureSpec.AT_MOST);
        super.onMeasure(widthMeasureSpec, expandSpec);
    }
}
