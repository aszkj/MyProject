package com.yldbkd.www.seller.android.viewCustomer;

import android.content.Context;
import android.support.v7.widget.RecyclerView;

import com.yldbkd.www.seller.android.R;
import com.yqritc.recyclerviewflexibledivider.HorizontalDividerItemDecoration;
import com.yqritc.recyclerviewflexibledivider.VerticalDividerItemDecoration;

/**
 * 应用默认规定分割线大小
 * <p/>
 * Created by linghuxj on 16/6/20.
 */
public class DefaultItemDecoration {

    /**
     * 默认divider，透明，默认间隔的水平分割线
     */
    public static RecyclerView.ItemDecoration getDefault(Context context) {
        return getItemDecoration(context, R.color.dividerColor, R.dimen.default_1_px, false);
    }

    /**
     * 默认divider，透明，默认间隔的垂直分割线
     */
    public static RecyclerView.ItemDecoration getDefaultVertical(Context context) {
        return getItemDecoration(context, R.color.dividerColor, R.dimen.default_1_px, true);
    }

    /**
     * 普通divider，透明，通常间隔的水平分割线
     */
    public static RecyclerView.ItemDecoration getNormal(Context context) {
        return getItemDecoration(context, R.color.transparent, R.dimen.normal_divider, false);
    }

    /**
     * 普通divider，透明，通常间隔的垂直分割线
     */
    public static RecyclerView.ItemDecoration getNormalVertical(Context context) {
        return getItemDecoration(context, R.color.transparent, R.dimen.normal_divider, true);
    }

    private static RecyclerView.ItemDecoration getItemDecoration(Context context, int colorResId,
                                                                 int sizeResId, boolean isVertical) {
        return isVertical ? new VerticalDividerItemDecoration.Builder(context).colorResId(colorResId).sizeResId(sizeResId).build()
                : new HorizontalDividerItemDecoration.Builder(context).colorResId(colorResId).sizeResId(sizeResId).build();
    }
}
