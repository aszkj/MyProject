package com.yilidi.o2o.controller.common;

import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.common.session.model.YiLiDiSession;

/**
 * 
 * 微仓基础类
 * 
 * @author: chenb
 * @date: 2016年7月6日 下午12:07:30
 * 
 */
public class WarehouseBaseController extends BaseController {

    /** 微仓ID SESSION KEY **/
    protected static final String STOREID_WAREHOUSE_SESSIONKEY = "STOREID_WAREHOUSE";
    /** 微仓ID SESSION KEY **/
    protected static final String USERID_WAREHOUSE_SESSIONKEY = "USERID_WAREHOUSE";
    /** 微仓主用户ID SESSION KEY **/
    protected static final String MASTER_USERID_WAREHOUSE_SESSIONKEY = "MASTER_USERID_WAREHOUSE";
    /** 微仓用户名 SESSION KEY **/
    protected static final String STORENAME_WAREHOUSE_SESSIONKEY = "USERNAME_WAREHOUSE";

    /**
     * 
     * 获取微仓用户ID
     * 
     * @return Integer
     */
    protected Integer getUserId() {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        return (Integer) session.getAttribute(USERID_WAREHOUSE_SESSIONKEY);
    }

    /**
     * 
     * 获取微仓店铺ID
     * 
     * @return Integer
     */
    protected Integer getStoreId() {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        return (Integer) session.getAttribute(STOREID_WAREHOUSE_SESSIONKEY);
    }

    /**
     * 
     * 获取用户名
     * 
     * @return String
     */
    protected String getUserName() {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        return (String) session.getAttribute(STORENAME_WAREHOUSE_SESSIONKEY);
    }

    /**
     * 
     * 获取主用户ID
     * 
     * @return Integer
     */
    protected Integer getMasterUserId() {
        YiLiDiSession session = YiLiDiSessionHolder.getSession();
        return (Integer) session.getAttribute(MASTER_USERID_WAREHOUSE_SESSIONKEY);
    }

}
