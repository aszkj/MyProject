package com.yldbkd.www.buyer.android.bean;

/**
 * @创建者     李贞高
 * @创建时间   2016/11/29 9:56
 * @描述	      账本详情
 *
 * @更新者     $Author$
 * @更新时间   $Date$
 * @更新描述
 */
public class AccountInfo extends BaseModel {
    private String accountName;
    private Long accountNum;
    private Integer accountNumType;

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public Long getAccountNum() {
        return accountNum;
    }

    public void setAccountNum(Long accountNum) {
        this.accountNum = accountNum;
    }

    public Integer getAccountNumType() {
        return accountNumType;
    }

    public void setAccountNumType(Integer accountNumType) {
        this.accountNumType = accountNumType;
    }
}
