package com.yilidi.o2o.order.service.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 优惠券DTO
 * 
 * @author: chenlian
 * @date: 2016年10月18日 下午6:42:46
 */
public class CouponDto extends BaseDto {

    public CouponDto() {
		super();
	}

	public CouponDto(Integer conPackId) {
		super();
		this.conPackId = conPackId;
	}

	private static final long serialVersionUID = -7232227312868193568L;

    /**
     * ID
     */
    private Integer id;
    
    /**
     * 优惠券包ID
     */
    private Integer conPackId;
    /**
     * 优惠券包name 
     */
    private String conPackName;

    /**
     * 使用范围编码
     */
    private String useRangeCode;

	/**
	 * 使用范围编码code名称
	 */
	private String useRangeCodeName;
    /**
     * 使用范围
     */
    private String useRange;
    /**
     * 使用范围
     */
    private List<String> useRangeNames = new ArrayList<String>();

    /**
     * 发放范围编码
     */
    private String grantRange;
    /**
     * 发放范围编码名称
     */
    private String grantRangeName;

    /**
     * 发放方式编码
     */
    private String grantWay;
    
    /**
     * 发放方式名称
     */
    private String grantWayName;

    /**
     * 客户类型编码
     */
    private String customerType;

    /**
     * 买家用户类型标示编码
     */
    private String buyerUserType;

    /**
     * 卖家用户类型标示编码
     */
    private String sellerUserType;

    /**
     * 发放时间
     */
    private Date grantTime;
    
    /**
     * 发放人
     */
    private Integer grantUserId;
    
    /**
     * 发放人名称
     */
    private String grantUserName;

    /**
     * 使用规格说明
     */
    private String rule;

    /**
     * 用户账号，可以1个或者多个，多个以逗号隔开保存
     */
    private String userNames;
    
    private String userType;

    /**
     * 产品品类复选框name
     */
    private String proclassname;

    /**
     * 产品标示复选框name
     */
    private String prolabelname;

    /**
     * 单个产品的产品ID
     */
    private Integer productId;
    
    /**
     * 批次号  
     */
    private String batchNo;
    /**
     * 阶段编号
     */
    private Integer stageNo;
    /**
     * 优惠券有效期类型
     */
    private String validType;
    /**
     * 优惠券有效期类型
     */
    private String validTypeName;
    /**
     * 优惠券有效期类型值
     */
    private String  validTypeValue;
    /**
     * 优惠券有效期时间集合
     */
    private List<String> validTimes = new ArrayList<String>();
    
    /**
     * 发放数量
     */
    private int grantNum;
    /**
     * 使用数量
     */
    private int useNum;
    /**
     * 过期数量
     */
    private int overdueNum;
    /**
     * 使用率
     */
    private double useRate;
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getConPackId() {
        return conPackId;
    }

    public void setConPackId(Integer conPackId) {
        this.conPackId = conPackId;
    }

    public String getUseRangeCode() {
        return useRangeCode;
    }

    public void setUseRangeCode(String useRangeCode) {
        this.useRangeCode = useRangeCode;
    }

    public String getUseRange() {
        return useRange;
    }

    public void setUseRange(String useRange) {
        this.useRange = useRange;
    }

    public String getGrantRange() {
        return grantRange;
    }

    public void setGrantRange(String grantRange) {
        this.grantRange = grantRange;
    }

    public String getGrantWay() {
        return grantWay;
    }

    public void setGrantWay(String grantWay) {
        this.grantWay = grantWay;
    }

    public String getCustomerType() {
        return customerType;
    }

    public void setCustomerType(String customerType) {
        this.customerType = customerType;
    }

    public String getBuyerUserType() {
        return buyerUserType;
    }

    public void setBuyerUserType(String buyerUserType) {
        this.buyerUserType = buyerUserType;
    }

    public String getSellerUserType() {
        return sellerUserType;
    }

    public void setSellerUserType(String sellerUserType) {
        this.sellerUserType = sellerUserType;
    }

    public Date getGrantTime() {
        return grantTime;
    }

    public void setGrantTime(Date grantTime) {
        this.grantTime = grantTime;
    }

    public Integer getGrantUserId() {
        return grantUserId;
    }

    public void setGrantUserId(Integer grantUserId) {
        this.grantUserId = grantUserId;
    }

    public String getRule() {
        return rule;
    }

    public void setRule(String rule) {
        this.rule = rule;
    }

    public String getUserNames() {
        return userNames;
    }

    public void setUserNames(String userNames) {
        this.userNames = userNames;
    }

    public String getProclassname() {
        return proclassname;
    }

    public void setProclassname(String proclassname) {
        this.proclassname = proclassname;
    }

    public String getProlabelname() {
        return prolabelname;
    }

    public void setProlabelname(String prolabelname) {
        this.prolabelname = prolabelname;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	public String getValidType() {
		return validType;
	}

	public void setValidType(String validType) {
		this.validType = validType;
	}

	public String getValidTypeValue() {
		return validTypeValue;
	}

	public void setValidTypeValue(String validTypeValue) {
		this.validTypeValue = validTypeValue;
	}

	public int getGrantNum() {
		return grantNum;
	}

	public void setGrantNum(int grantNum) {
		this.grantNum = grantNum;
	}

	public int getUseNum() {
		return useNum;
	}

	public void setUseNum(int useNum) {
		this.useNum = useNum;
	}

	public int getOverdueNum() {
		return overdueNum;
	}

	public void setOverdueNum(int overdueNum) {
		this.overdueNum = overdueNum;
	}

	public double getUseRate() {
		return useRate;
	}

	public void setUseRate(double useRate) {
		this.useRate = useRate;
	}

	public String getGrantWayName() {
		return grantWayName;
	}

	public void setGrantWayName(String grantWayName) {
		this.grantWayName = grantWayName;
	}

	public String getGrantUserName() {
		return grantUserName;
	}

	public void setGrantUserName(String grantUserName) {
		this.grantUserName = grantUserName;
	}

	public String getUseRangeCodeName() {
		return useRangeCodeName;
	}

	public void setUseRangeCodeName(String useRangeCodeName) {
		this.useRangeCodeName = useRangeCodeName;
	}

	public List<String> getUseRangeNames() {
		return useRangeNames;
	}

	public void setUseRangeNames(List<String> useRangeNames) {
		this.useRangeNames = useRangeNames;
	}

	public String getValidTypeName() {
		return validTypeName;
	}

	public void setValidTypeName(String validTypeName) {
		this.validTypeName = validTypeName;
	}

	public String getGrantRangeName() {
		return grantRangeName;
	}

	public void setGrantRangeName(String grantRangeName) {
		this.grantRangeName = grantRangeName;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getConPackName() {
		return conPackName;
	}

	public void setConPackName(String conPackName) {
		this.conPackName = conPackName;
	}

	public List<String> getValidTimes() {
		return validTimes;
	}

	public void setValidTimes(List<String> validTimes) {
		this.validTimes = validTimes;
	}

	public Integer getStageNo() {
		return stageNo;
	}

	public void setStageNo(Integer stageNo) {
		this.stageNo = stageNo;
	}

}
