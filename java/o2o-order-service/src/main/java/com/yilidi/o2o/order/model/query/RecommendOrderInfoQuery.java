package com.yilidi.o2o.order.model.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 推荐订单信息查询参数
 * 
 * @author: chenlian
 * @date: 2016年8月12日 上午1:22:06
 */
public class RecommendOrderInfoQuery extends BaseQuery {

    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = 7681492515562233746L;

    /**
     * 推荐人
     */
    private String recommendRealName;

    /**
     * 推荐码
     */
    private String invitationCode;

    /**
     * 订单编号
     */
    private String saleOrderNo;

    /**
     * 订单状态
     */
    private String saleOrderStatus;

    /**
     * 注册开始时间
     */
    private String startRegisterTime;

    /**
     * 注册结束时间
     */
    private String endRegisterTime;

    /**
     * 注册开始时间
     */
    private Date startRegisterDate;

    /**
     * 注册结束时间
     */
    private Date endRegisterDate;

    public String getRecommendRealName() {
        return recommendRealName;
    }

    public void setRecommendRealName(String recommendRealName) {
        this.recommendRealName = recommendRealName;
    }

    public String getInvitationCode() {
        return invitationCode;
    }

    public void setInvitationCode(String invitationCode) {
        this.invitationCode = invitationCode;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public String getSaleOrderStatus() {
        return saleOrderStatus;
    }

    public void setSaleOrderStatus(String saleOrderStatus) {
        this.saleOrderStatus = saleOrderStatus;
    }

    public String getStartRegisterTime() {
        return startRegisterTime;
    }

    public void setStartRegisterTime(String startRegisterTime) {
        this.startRegisterTime = startRegisterTime;
    }

    public String getEndRegisterTime() {
        return endRegisterTime;
    }

    public void setEndRegisterTime(String endRegisterTime) {
        this.endRegisterTime = endRegisterTime;
    }

    public Date getStartRegisterDate() {
        return startRegisterDate;
    }

    public void setStartRegisterDate(Date startRegisterDate) {
        this.startRegisterDate = startRegisterDate;
    }

    public Date getEndRegisterDate() {
        return endRegisterDate;
    }

    public void setEndRegisterDate(Date endRegisterDate) {
        this.endRegisterDate = endRegisterDate;
    }

}