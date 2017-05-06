package com.yldbkd.www.library.android.common;

import android.view.View;
import android.view.View.MeasureSpec;
import android.view.ViewGroup;
import android.widget.AbsListView.LayoutParams;
import android.widget.BaseAdapter;
import android.widget.ListAdapter;
import android.widget.ListView;

/**
 * 多ListView嵌套列表高度计算工具类:用于ScrollView中嵌套ListView中再嵌套ListView的情况
 * <p/>
 * Created by linghuxj on 15/10/20.
 */
public class ViewMultiUtils {

    private static ViewMultiUtils viewMultiUtils;

    private static Integer itemAddHeightDefault;

    private boolean isChildrenVisible;

    private ViewMultiUtils() {
    }

    public static ViewMultiUtils getInstance() {
        if (viewMultiUtils == null) {
            viewMultiUtils = new ViewMultiUtils();
        }
        return viewMultiUtils;
    }

    private ListViewHeightListener listViewHeightListener;

    public void setListViewHeightBasedOnChildren(ListView listView, int otherHeight) {
        ListAdapter listAdapter = listView.getAdapter();
        if (listAdapter == null) {
            return;
        }
        int desiredWidth = MeasureSpec.makeMeasureSpec(listView.getWidth(), MeasureSpec.UNSPECIFIED);
        int totalHeight = 0;
        View view = null;
        clearItemDefault();
        for (int i = 0; i < listAdapter.getCount(); i++) {
            view = listAdapter.getView(i, view, listView);
            if (i == 0) {
                view.setLayoutParams(new ViewGroup.LayoutParams(desiredWidth, LayoutParams.WRAP_CONTENT));
            }

            view.measure(desiredWidth, MeasureSpec.UNSPECIFIED);
            int itemHeight = view.getMeasuredHeight();
            if (listViewHeightListener != null && isChildrenVisible) {
                int addItemHeight = listViewHeightListener.itemAddHeight();
                if (getItemAddHeightDefault() > 0) {
                    addItemHeight -= getItemAddHeightDefault();
                }
                itemHeight += addItemHeight;
            }
            totalHeight += itemHeight;
        }
        ViewGroup.LayoutParams params = listView.getLayoutParams();
        params.height = totalHeight + (listView.getDividerHeight() * (listAdapter.getCount() - 1)) + otherHeight;
        listView.setLayoutParams(params);
    }

    public int setListViewHeightBasedOnChildrenInChildren(ListView listView, BaseAdapter baseAdapter,
                                                          boolean hasListData, boolean isVisible) {
        if (!hasListData) {
            isChildrenVisible = false;
            return 0;
        }
        if (baseAdapter == null) {
            isChildrenVisible = false;
            return 0;
        }
        int desiredWidth = MeasureSpec.makeMeasureSpec(listView.getWidth(), MeasureSpec.UNSPECIFIED);
        int totalHeight = 0;
        View view = null;
        for (int i = 0; i < baseAdapter.getCount(); i++) {
            view = baseAdapter.getView(i, view, listView);
            if (i == 0) {
                view.setLayoutParams(new ViewGroup.LayoutParams(desiredWidth, LayoutParams.WRAP_CONTENT));
            }

            view.measure(desiredWidth, MeasureSpec.UNSPECIFIED);
            int itemHeight = view.getMeasuredHeight();
            totalHeight += itemHeight;
            isChildrenVisible = isVisible;
        }
        setItemAddHeightDefault(totalHeight);
        ViewGroup.LayoutParams params = listView.getLayoutParams();
        params.height = totalHeight + (listView.getDividerHeight() * (baseAdapter.getCount() - 1));
        listView.setLayoutParams(params);
        return params.height;
    }

    private void clearItemDefault() {
        setItemAddHeightDefault(null);
    }

    private void setItemAddHeightDefault(Integer heightDefault) {
        if (getItemAddHeightDefault() > 0 && heightDefault != null) {
            return;
        }
        itemAddHeightDefault = heightDefault;
    }

    private Integer getItemAddHeightDefault() {
        return itemAddHeightDefault == null ? 0 : itemAddHeightDefault;
    }

    public interface ListViewHeightListener {
        public int itemAddHeight();
    }

    public ListViewHeightListener getListViewHeightListener() {
        return listViewHeightListener;
    }

    public void setListViewHeightListener(ListViewHeightListener listViewHeightListener) {
        this.listViewHeightListener = listViewHeightListener;
    }
}
