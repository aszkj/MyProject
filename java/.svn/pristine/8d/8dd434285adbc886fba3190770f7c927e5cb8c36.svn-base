package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：账户绑定实体类，映射用户域表YiLiDiUserCenter.U_ACCOUNT_BINDING <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class AccountBinding extends BaseModel {

    private static final long serialVersionUID = 1718438212876797153L;
    /**
     * 绑定ID，自增主键
     */
    private Integer bingdingAccountId;
    /**
     * 客户Id
     */
    private Integer customerId;
    /**
     * 绑定账户类型，关联系统域系统字典表S_SYSTEM_DICT的DICTCODE字段(DICTTYPE=ACCOUNTBINDINGTYPE)
     * 账户类型：开户各银行名称，支付宝，微支付等等
     */
    private String accountBindingType;
    /**
     * 开户人姓名
     */
    private String accountName;
    /**
     * 账户转账类型：对公和对私
     */
    private String transferAccountType;
    /**
     * 绑定账户账号(银行卡号，支付宝账号，微信支付账号等)
     */
    private String accountNo;
    /**
     * 绑定银行的支行名称(针对银行)
     */
    private String subBankName;
    /**
     * 持卡人姓名（开户人真实姓名）
     */
    private String masterName;
    /**
     * 持卡人身份证号码
     */
    private String masterIDcardNo;
    /**
     * 持卡人手机号
     */
    private String masterPhoneNo;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建时间
     */
    private Date createTime;

    public Integer getBingdingAccountId() {
        return bingdingAccountId;
    }

    public void setBingdingAccountId(Integer bingdingAccountId) {
        this.bingdingAccountId = bingdingAccountId;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getAccountBindingType() {
        return accountBindingType;
    }

    public void setAccountBindingType(String accountBindingType) {
        this.accountBindingType = accountBindingType;
    }

    public String getMasterName() {
        return masterName;
    }

    public void setMasterName(String masterName) {
        this.masterName = masterName;
    }

    public String getMasterPhoneNo() {
        return masterPhoneNo;
    }

    public void setMasterPhoneNo(String masterPhoneNo) {
        this.masterPhoneNo = masterPhoneNo;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	public String getMasterIDcardNo() {
		return masterIDcardNo;
	}

	public void setMasterIDcardNo(String masterIDcardNo) {
		this.masterIDcardNo = masterIDcardNo;
	}
	
	public String getSubBankName() {
		return subBankName;
	}

	public void setSubBankName(String subBankName) {
		this.subBankName = subBankName;
	}
	
	public String getTransferAccountType() {
		return transferAccountType;
	}

	public void setTransferAccountType(String transferAccountType) {
		this.transferAccountType = transferAccountType;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

}