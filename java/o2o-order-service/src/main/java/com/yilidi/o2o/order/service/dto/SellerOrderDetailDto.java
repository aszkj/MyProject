package com.yilidi.o2o.order.service.dto;

import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * @Description: TODO(订单详细信息数据DTO)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:09:56
 */
public class SellerOrderDetailDto extends BaseDto {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -5032122769817788820L;
    /**
     * 订单ID
     */
    private Integer saleOrderId;
    /**
     * 订单编码
     */
    private String saleOrderNo;
    /**
     * 订单创建时间
     */
    private String createTime;
    /**
     * 订单付款时间
     */
    private String payTime;
    /**
     * 商品金额
     */
    private Long totalAmount;
    /**
     * 商品总数
     */
    private Integer orderCount;
    /**
     * 订单状态
     */
    private Integer statusCode;
    /**
     * 订单状态名称
     */
    private String statusCodeName;
    /**
     * 支付方式Code
     */
    private String payTypeCode;
    /**
     * 支付方式名称
     */
    private String payTypeName;
    /**
     * 配送方式
     */
    private String deliveryMode;
    /**
     * 配送方式名称
     */
    private String deliveryModeName;
    /**
     * 送货时间
     */
    private String bestTime;
    /**
     * 接单时间
     */
    private String acceptTime;
    /**
     * 配送时间
     */
    private String deliveryTime;
    /**
     * 取消时间
     */
    private String cancelTime;
    /**
     * 完成时间
     */
    private String finishTime;
    /**
     * 订单备注
     */
    private String note;
    /**
     * 门店热线
     */
    private String storePhoneNo;
    /**
     * 优惠金额
     */
    private Long preferentialAmt;
    /**
     * 配送金额
     */
    private Long transferFee;
    /**
     * 应付金额
     */
    private Long payableAmount;
    /**
     * 结算商品数量
     */
    private Integer settleProductCount;
    /**
     * 结算总金额
     */
    private Long settleTotalAmount;
    /**
     * 收货码
     */
    private String receiveNo;
    /**
     * 订单类型编码
     */
    private String typeCode;
    /**
     * 下单的用户ID
     */
    private Integer userId;
    /**
     * 订单收获地址
     */
    private OrderConsigneeAddressDto orderConsigneeAddressDto;
    /**
     * 商品列表
     */
    private List<SaleOrderItemDto> saleOrderItemDtoList;
    /**
     * 商品结算列表
     */
    private List<SaleProductSettleDto> saleProductSettleDtoList;
    /**
     * 退款审核不通过原因
     */
    private String refundAuditFailureReason;

    public Integer getSaleOrderId() {
        return saleOrderId;
    }

    public void setSaleOrderId(Integer saleOrderId) {
        this.saleOrderId = saleOrderId;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getPayTime() {
        return payTime;
    }

    public void setPayTime(String payTime) {
        this.payTime = payTime;
    }

    public Long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Long totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Integer getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(Integer orderCount) {
        this.orderCount = orderCount;
    }

    public Integer getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(Integer statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusCodeName() {
        return statusCodeName;
    }

    public void setStatusCodeName(String statusCodeName) {
        this.statusCodeName = statusCodeName;
    }

    public String getPayTypeCode() {
        return payTypeCode;
    }

    public void setPayTypeCode(String payTypeCode) {
        this.payTypeCode = payTypeCode;
    }

    public String getPayTypeName() {
        return payTypeName;
    }

    public void setPayTypeName(String payTypeName) {
        this.payTypeName = payTypeName;
    }

    public String getDeliveryMode() {
        return deliveryMode;
    }

    public void setDeliveryMode(String deliveryMode) {
        this.deliveryMode = deliveryMode;
    }

    public String getDeliveryModeName() {
        return deliveryModeName;
    }

    public void setDeliveryModeName(String deliveryModeName) {
        this.deliveryModeName = deliveryModeName;
    }

    public String getBestTime() {
        return bestTime;
    }

    public void setBestTime(String bestTime) {
        this.bestTime = bestTime;
    }

    public String getAcceptTime() {
        return acceptTime;
    }

    public void setAcceptTime(String acceptTime) {
        this.acceptTime = acceptTime;
    }

    public String getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(String deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public String getCancelTime() {
        return cancelTime;
    }

    public void setCancelTime(String cancelTime) {
        this.cancelTime = cancelTime;
    }

    public String getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(String finishTime) {
        this.finishTime = finishTime;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getStorePhoneNo() {
        return storePhoneNo;
    }

    public void setStorePhoneNo(String storePhoneNo) {
        this.storePhoneNo = storePhoneNo;
    }

    public Long getPreferentialAmt() {
        return preferentialAmt;
    }

    public void setPreferentialAmt(Long preferentialAmt) {
        this.preferentialAmt = preferentialAmt;
    }

    public Long getTransferFee() {
        return transferFee;
    }

    public void setTransferFee(Long transferFee) {
        this.transferFee = transferFee;
    }

    public Long getPayableAmount() {
        return payableAmount;
    }

    public void setPayableAmount(Long payableAmount) {
        this.payableAmount = payableAmount;
    }

    public Integer getSettleProductCount() {
        return settleProductCount;
    }

    public void setSettleProductCount(Integer settleProductCount) {
        this.settleProductCount = settleProductCount;
    }

    public Long getSettleTotalAmount() {
        return settleTotalAmount;
    }

    public void setSettleTotalAmount(Long settleTotalAmount) {
        this.settleTotalAmount = settleTotalAmount;
    }

    public String getReceiveNo() {
        return receiveNo;
    }

    public void setReceiveNo(String receiveNo) {
        this.receiveNo = receiveNo;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public OrderConsigneeAddressDto getOrderConsigneeAddressDto() {
        return orderConsigneeAddressDto;
    }

    public void setOrderConsigneeAddressDto(OrderConsigneeAddressDto orderConsigneeAddressDto) {
        this.orderConsigneeAddressDto = orderConsigneeAddressDto;
    }

    public List<SaleOrderItemDto> getSaleOrderItemDtoList() {
        return saleOrderItemDtoList;
    }

    public void setSaleOrderItemDtoList(List<SaleOrderItemDto> saleOrderItemDtoList) {
        this.saleOrderItemDtoList = saleOrderItemDtoList;
    }

    public List<SaleProductSettleDto> getSaleProductSettleDtoList() {
        return saleProductSettleDtoList;
    }

    public void setSaleProductSettleDtoList(List<SaleProductSettleDto> saleProductSettleDtoList) {
        this.saleProductSettleDtoList = saleProductSettleDtoList;
    }

    public String getRefundAuditFailureReason() {
        return refundAuditFailureReason;
    }

    public void setRefundAuditFailureReason(String refundAuditFailureReason) {
        this.refundAuditFailureReason = refundAuditFailureReason;
    }

}
