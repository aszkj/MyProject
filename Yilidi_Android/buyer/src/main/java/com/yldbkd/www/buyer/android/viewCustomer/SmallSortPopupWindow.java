package com.yldbkd.www.buyer.android.viewCustomer;

import android.app.Activity;
import android.content.Context;
import android.graphics.drawable.PaintDrawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.PopupWindow;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.SmallSortGridViewAdapter;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Liuxd on 2016/5/27.
 * 商品小类弹出框
 */
public abstract class SmallSortPopupWindow<T> {
    private Context mContext;
    private PopupWindow mPopupWindow;
    private LayoutInflater mLayoutInflater;
    private List<T> mSmallSortList;
    private GridView mGridView;
    private SmallSortGridViewAdapter<T> mSmallSortGridViewAdapter;

    public SmallSortPopupWindow(Context context) {
        this.mContext = context;
        mLayoutInflater = LayoutInflater.from(context);
        initView();
    }

    /**
     * 初始化PopupWindow
     */
    private void initView() {
        View view = mLayoutInflater.inflate(R.layout.layout_popwindow_samllsort, null);
        mGridView = (GridView) view.findViewById(R.id.gv_smallSort);
        mPopupWindow = new PopupWindow(view, ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        //设置可以获取焦点
        mPopupWindow.setFocusable(true);
        //设置点击外部可以收起
        mPopupWindow.setOutsideTouchable(true);
        //不加上这个setFocusable无效
        mPopupWindow.setBackgroundDrawable(new PaintDrawable());
//        mPopupWindow.setOnDismissListener(new PopupWindow.OnDismissListener() {
//            @Override
//            public void onDismiss() {
//                backgroundAlpha(1f);
//            }
//        });
    }

    /**
     * @param smallSortList 小分类列表数据
     * @Description 设置下拉框数据
     */
    public void setViewData(List<T> smallSortList) {
        if (smallSortList == null) {
            mSmallSortList = new ArrayList<T>();
        } else {
            this.mSmallSortList = smallSortList;
        }
        if (mSmallSortGridViewAdapter == null) {
            mSmallSortGridViewAdapter = new SmallSortGridViewAdapter<T>(mContext, mSmallSortList) {

                @Override
                public void handle2(ViewHolder holder, T t) {
                    handle(holder, t);
//                    if (t instanceof  GoodsSmallSort){
////                        holder.tvGoodsSmallSort.setText(goodsSmallSort.categoryName);
//                    }else if (t instanceof SortRule){
////                        holder.tvGoodsSmallSort.setText(goodsSmallSort.ruleName);
//                    }
                }
            };
        }
        mGridView.setAdapter(mSmallSortGridViewAdapter);
    }

    /**
     * @param width 宽度
     * @Description 设置下拉框宽度
     */
    public void setWidth(int width) {
        mPopupWindow.setWidth(width);
    }

    /**
     * @param itemClick 点击子项监听器
     * @Description 设置下拉框子项的监听器
     */
    public void setItemClick(AdapterView.OnItemClickListener itemClick) {
        mGridView.setOnItemClickListener(itemClick);
    }

    /**
     * @param parent 基于哪个父控件弹出
     * @Description 弹出下拉框
     */
    public void show(View parent) {
//        if (!mPopupWindow.isShowing()) {
//        backgroundAlpha(0.5f);
        mPopupWindow.showAsDropDown(parent, 0, 0);
//        }
    }

    /**
     * @Description 收起弹出框
     */
    public void dismiss() {
        if (mPopupWindow != null) {
            mPopupWindow.dismiss();
        }
    }

    public boolean isShowing() {
        return mPopupWindow.isShowing();
    }

    public void setSelectPosition(int position) {
        mSmallSortGridViewAdapter.setmSelectPosition(position);
        mSmallSortGridViewAdapter.notifyDataSetChanged();
    }

    /**
     * 设置添加屏幕的背景透明度
     *
     * @param bgAlpha
     */
    public void backgroundAlpha(float bgAlpha) {
        WindowManager.LayoutParams lp = ((Activity) mContext).getWindow().getAttributes();
        lp.alpha = bgAlpha; //0.0-1.0
        ((Activity) mContext).getWindow().setAttributes(lp);
    }

    //处理数据
    public abstract void handle(SmallSortGridViewAdapter.ViewHolder holder, T t);
}
