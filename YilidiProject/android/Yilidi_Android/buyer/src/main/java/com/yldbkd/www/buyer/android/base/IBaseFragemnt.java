package com.yldbkd.www.buyer.android.base;

import android.view.View;

/**
 * @author 李贞高
 * @version $Rev$
 * @time 2016/5/25 14:43
 * @des
 * @updateAuthor $Author$
 * @updateDate $Date$
 * @updateDes
 */
public interface IBaseFragemnt {
    /**
     * 设置Fragment页面id
     */
     int setLayoutId();

    /**
     * 初始化页面控件
     */
    abstract void initView(View view);

    /**
     * 初始化网络请求回调方法
     */
    abstract void initHttpBack();

    /**
     * 初始化网络请求
     */
    abstract void initRequest();
}
