package com.yldbkd.www.buyer.android.bean;

/**
 * 支付方式数据类型
 * <p/>
 * Created by linghuxj on 15/10/21.
 */
public class PayType extends BaseModel {

    /**
     * 支付类型编码
     */
    private Integer payTypeCode;
    /**
     * 支付名称
     */
    private String payTypeName;

    private Boolean isCheck = false;

    public PayType(Integer payTypeCode, String payTypeName) {
        this.payTypeCode = payTypeCode;
        this.payTypeName = payTypeName;
    }

    public Integer getPayTypeCode() {
        return payTypeCode;
    }

    public void setPayTypeCode(Integer payTypeCode) {
        this.payTypeCode = payTypeCode;
    }

    public String getPayTypeName() {
        return payTypeName;
    }

    public void setPayTypeName(String payTypeName) {
        this.payTypeName = payTypeName;
    }

    public Boolean getIsCheck() {
        return isCheck;
    }

    public void setIsCheck(Boolean isCheck) {
        this.isCheck = isCheck;
    }
}
