package com.yilidi.o2o.controller.common;

import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.sessionmodel.seller.user.SellerSessionModel;

/**
 * 
 * @Description:TODO(卖家（店铺）的Controller基类)
 * @author: chenlian
 * @date: 2015年11月7日 上午9:36:08
 * 
 */
public class SellerBaseController extends AppBaseController {

	/**
     * @Description TODO(获取用户标识)
     * @return
     */
    protected String getMasterFlag() {
        SellerSessionModel sellerSessionModel = SessionUtils.getSellerUserSession();
        return sellerSessionModel.getMasterFlag();
    }
	
    /**
     * @Description TODO(获取用户ID)
     * @return
     */
    protected Integer getUserId() {
        SellerSessionModel sellerSessionModel = SessionUtils.getSellerUserSession();
        return sellerSessionModel.getUserId();
    }

    /**
     * @Description TODO(获取用户名)
     * @return
     */
    protected String getUserName() {
        SellerSessionModel sellerSessionModel = SessionUtils.getSellerUserSession();
        return sellerSessionModel.getUserName();
    }

    /**
     * @Description TODO(获取用户手机号)
     * @return
     */
    protected String getUserMobile() {
        SellerSessionModel sellerSessionModel = SessionUtils.getSellerUserSession();
        return sellerSessionModel.getUserMobile();
    }

    /**
     * @Description TODO(获取用户图片url)
     * @return
     */
    protected String getUserImageUrl() {
        SellerSessionModel sellerSessionModel = SessionUtils.getSellerUserSession();
        return sellerSessionModel.getUserImageUrl();
    }

    /**
     * @Description TODO(获取店铺ID)
     * @return
     */
    protected Integer getStoreId() {
        SellerSessionModel sellerSessionModel = SessionUtils.getSellerUserSession();
        return sellerSessionModel.getStoreId();
    }

    /**
     * @Description TODO(获取店铺所在经度)
     * @return
     */
    protected String getLongitude() {
        SellerSessionModel sellerSessionModel = SessionUtils.getSellerUserSession();
        return sellerSessionModel.getLongitude();
    }

    /**
     * @Description TODO(获取店铺所在纬度)
     * @return
     */
    protected String getLatitude() {
        SellerSessionModel sellerSessionModel = SessionUtils.getSellerUserSession();
        return sellerSessionModel.getLatitude();
    }

}
