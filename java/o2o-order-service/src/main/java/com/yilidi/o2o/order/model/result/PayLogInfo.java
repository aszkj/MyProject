package com.yilidi.o2o.order.model.result;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：支付日志记录表，映射交易域表YiLiDiOrderCenter.T_PAY_LOG <br/>
 * 作者：Simpson <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class PayLogInfo extends BaseModel {

    private static final long serialVersionUID = -2798947456120934634L;
    /**
     * 记录编号，主键
     */
    private Integer id;
    /**
     * 支付日志编号
     */
    private String payLogOrderNo;
    /**
     * 支付日志类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PAYLOGTYPE)
     */
    private String payLogType;
    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 支付用户名称
     */
    private String userName;
    /**
     * 订单编号
     */
    private String saleOrderNo;
    /**
     * 支付平台编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERPAYPLATFORM)
     */
    private String payPlatformCode;
    /**
     * 支付平台流水号
     */
    private String paySequence;
    /**
     * 支付平台的订单编号
     */
    private String payPlatformOrderId;
    /**
     * 支付日志状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PAYLOGSTATUS)
     */
    private String payLogStatus;
    /**
     * 支付金额
     */
    private Long payPrice;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 操作员类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PAYLOGOPERUSERTYPE)
     */
    private String operUserType;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 更新时间
     */
    private Date updateTime;
    /**
     * 支付内容
     */
    private String content;
    /**
     * 接口数据内容
     */
    private String interfaceContent;
    /**
     * 接口返回内容
     */
    private String returnContent;
    /**
     * 支付设备ID
     */
    private String deviceId;
    /**
     * 支付系统用户ID。支付宝为支付宝账号，微信为OPENID
     */
    private String payerId;
    /**
     * 支付用户账号
     */
    private String payerEmail;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPayLogOrderNo() {
        return payLogOrderNo;
    }

    public void setPayLogOrderNo(String payLogOrderNo) {
        this.payLogOrderNo = payLogOrderNo;
    }

    public String getPayLogType() {
        return payLogType;
    }

    public void setPayLogType(String payLogType) {
        this.payLogType = payLogType;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public String getPayPlatformCode() {
        return payPlatformCode;
    }

    public void setPayPlatformCode(String payPlatformCode) {
        this.payPlatformCode = payPlatformCode;
    }

    public String getPaySequence() {
        return paySequence;
    }

    public void setPaySequence(String paySequence) {
        this.paySequence = paySequence;
    }

    public String getPayPlatformOrderId() {
        return payPlatformOrderId;
    }

    public void setPayPlatformOrderId(String payPlatformOrderId) {
        this.payPlatformOrderId = payPlatformOrderId;
    }

    public String getPayLogStatus() {
        return payLogStatus;
    }

    public void setPayLogStatus(String payLogStatus) {
        this.payLogStatus = payLogStatus;
    }

    public Long getPayPrice() {
        return payPrice;
    }

    public void setPayPrice(Long payPrice) {
        this.payPrice = payPrice;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getOperUserType() {
        return operUserType;
    }

    public void setOperUserType(String operUserType) {
        this.operUserType = operUserType;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getInterfaceContent() {
        return interfaceContent;
    }

    public void setInterfaceContent(String interfaceContent) {
        this.interfaceContent = interfaceContent;
    }

    public String getReturnContent() {
        return returnContent;
    }

    public void setReturnContent(String returnContent) {
        this.returnContent = returnContent;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getPayerId() {
        return payerId;
    }

    public void setPayerId(String payerId) {
        this.payerId = payerId;
    }

    public String getPayerEmail() {
        return payerEmail;
    }

    public void setPayerEmail(String payerEmail) {
        this.payerEmail = payerEmail;
    }

}