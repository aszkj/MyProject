package com.yilidi.o2o.appvo.buyer.order;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 加入购物车业务判断VO
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class ValidationBeforeAddCartVO extends AppBaseVO {

    private static final long serialVersionUID = 2803910838254325663L;
    /**
     * 业务判断状态：<br/>
     * 0：成功 <br/>
     * 1：失败提示<br/>
     * 2：失败提示并需要确认<br/>
     * 3：提示并提供选择
     */
    private Integer status;
    /**
     * 提示语
     */
    private String notification;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getNotification() {
        return notification;
    }

    public void setNotification(String notification) {
        this.notification = notification;
    }

}
