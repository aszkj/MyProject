/**
 * 文件名称：SaleOrderDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.dto;

import java.util.HashMap;
import java.util.Map;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：订单数据模型DTO <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleOrderSaveDto extends BaseDto {
    private static final long serialVersionUID = -5008967139849979608L;

    /**
     * 下单用户id
     */
    private Integer userId;
    /**
     * 买家CUSTOMERID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_BUYER）
     */
    private Integer buyerCustomerId;
    /**
     * 订单类型
     */
    private String typeCode;

    /**
     * 订单来源
     */
    private String channelCode;
    /**
     * 下单商品id及数量 <key:商品id， value：订购数量>
     */
    private Map<Integer, Integer> saleProductIdMap = new HashMap<Integer, Integer>();

    /**
     * 配送方式
     */
    private String deliveryMode;

    /**
     * 配送时间
     */
    private String bestTime;

    /**
     * 发票id
     */
    private Integer invoiceId;
    /**
     * 买家留言
     */
    private String leaveMessage;

    /**
     * 收货地址id
     */
    private Integer consigneeAddressId;

    /**
     * 提货人姓名
     */
    private String takeUserName;

    /**
     * 提货人身份证号码
     */
    private String takeUserIdNo;

    /**
     * 提货人手机号码
     */
    private String takeUserPhone;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getBuyerCustomerId() {
        return buyerCustomerId;
    }

    public void setBuyerCustomerId(Integer buyerCustomerId) {
        this.buyerCustomerId = buyerCustomerId;
    }

    public String getDeliveryMode() {
        return deliveryMode;
    }

    public void setDeliveryMode(String deliveryMode) {
        this.deliveryMode = deliveryMode;
    }

    public String getBestTime() {
        return bestTime;
    }

    public void setBestTime(String bestTime) {
        this.bestTime = bestTime;
    }

    public Integer getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(Integer invoiceId) {
        this.invoiceId = invoiceId;
    }

    public String getLeaveMessage() {
        return leaveMessage;
    }

    public void setLeaveMessage(String leaveMessage) {
        this.leaveMessage = leaveMessage;
    }

    public Integer getConsigneeAddressId() {
        return consigneeAddressId;
    }

    public void setConsigneeAddressId(Integer consigneeAddressId) {
        this.consigneeAddressId = consigneeAddressId;
    }

    public String getTakeUserName() {
        return takeUserName;
    }

    public void setTakeUserName(String takeUserName) {
        this.takeUserName = takeUserName;
    }

    public String getTakeUserIdNo() {
        return takeUserIdNo;
    }

    public void setTakeUserIdNo(String takeUserIdNo) {
        this.takeUserIdNo = takeUserIdNo;
    }

    public String getTakeUserPhone() {
        return takeUserPhone;
    }

    public void setTakeUserPhone(String takeUserPhone) {
        this.takeUserPhone = takeUserPhone;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public Map<Integer, Integer> getSaleProductIdMap() {
        return saleProductIdMap;
    }

    public void setSaleProductIdMap(Map<Integer, Integer> saleProductIdMap) {
        this.saleProductIdMap = saleProductIdMap;
    }

}
