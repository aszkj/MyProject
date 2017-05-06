package com.yilidi.o2o.order.service.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.model.BaseDto;
import com.yilidi.o2o.product.proxy.dto.ProductProxyDto;

/**
 * 抵用券DTO
 * 
 * @author: chenlian
 * @date: 2016年10月27日 下午2:47:39
 */
public class VoucherDto extends BaseDto {

    private static final long serialVersionUID = -7232227312868193568L;

    /**
     * 抵用券ID
     */
    private Integer id;

    /**
     * 抵用券包ID
     */
    private Integer vouPackId;
    
    /**
     * 抵用券包名称
     */
    private String vouPackName;
    
    /**
     * 批次号
     */
    private String batchNo;

    /**
     * 抵用券金额
     */
    private Long vouAmount;

    /**
     * 订单金额限制
     */
    private Long orderAmountLimit;

    /**
     * 产品品类限制，其形式为产品类别编码以逗号连接
     */
    private String productClassLimit;
    
    /**
     * 产品品类限制的产品类别名称集合
     */
    private List<String> productClassNames = new ArrayList<>();

    /**
     * 业务规则限制，其形式为业务规则限制编码以逗号连接
     */
    private String businessRuleLimit;
    
    private List<Map<String, Object>> businessRuleLimitMaps = new ArrayList<Map<String, Object>>();

    /**
     * 产品限制，其形式为产品ID以逗号连接
     */
    private String productLimit;
    
    /**
     * 产品限制产品集合
     */
    private List<ProductProxyDto> products = new ArrayList<>();

    /**
     * 有效期开始时间
     */
    private Date validStartTime;

    /**
     * 有效期结束时间
     */
    private Date validEndTime;

    /**
     * 发放范围编码
     */
    private String grantRange;
    
    /**
     * 发放范围名称
     */
    private String grantRangeName;

    /**
     * 发放方式编码
     */
    private String grantWay;
    
    /**
     * 发放方式编码名称
     */
    private String grantWayName;
   

    /**
     * 使用规格说明
     */
    private String rule;

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
     * 用户账号，可以1个或者多个，多个以逗号隔开保存
     */
    private String userNames;

    /**
     * 产品品类复选框name
     */
    private String proclassname;

    /**
     * 产品品类限制复选框name
     */
    private String productClassLimitCheckbox;

    /**
     * 业务规则复选框name
     */
    private String businessRuleCheckbox;

    /**
     * 业务规则限制复选框name
     */
    private String businessRuleLimitCheckbox;

    /**
     * 订单金额限制复选框name
     */
    private String orderAmountLimitCheckbox;
    
    /**
     * 用户类型
     */
    private String userType;
    
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

    public Integer getVouPackId() {
        return vouPackId;
    }

    public void setVouPackId(Integer vouPackId) {
        this.vouPackId = vouPackId;
    }

    public Long getVouAmount() {
        return vouAmount;
    }

    public void setVouAmount(Long vouAmount) {
        this.vouAmount = vouAmount;
    }

    public Long getOrderAmountLimit() {
        return orderAmountLimit;
    }

    public void setOrderAmountLimit(Long orderAmountLimit) {
        this.orderAmountLimit = orderAmountLimit;
    }

    public String getProductClassLimit() {
        return productClassLimit;
    }

    public void setProductClassLimit(String productClassLimit) {
        this.productClassLimit = productClassLimit;
    }

    public String getBusinessRuleLimit() {
        return businessRuleLimit;
    }

    public void setBusinessRuleLimit(String businessRuleLimit) {
        this.businessRuleLimit = businessRuleLimit;
    }

    public String getProductLimit() {
        return productLimit;
    }

    public void setProductLimit(String productLimit) {
        this.productLimit = productLimit;
    }

    public Date getValidStartTime() {
        return validStartTime;
    }

    public void setValidStartTime(Date validStartTime) {
        this.validStartTime = validStartTime;
    }

    public Date getValidEndTime() {
        return validEndTime;
    }

    public void setValidEndTime(Date validEndTime) {
        this.validEndTime = validEndTime;
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

    public String getRule() {
        return rule;
    }

    public void setRule(String rule) {
        this.rule = rule;
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

    public String getProductClassLimitCheckbox() {
        return productClassLimitCheckbox;
    }

    public void setProductClassLimitCheckbox(String productClassLimitCheckbox) {
        this.productClassLimitCheckbox = productClassLimitCheckbox;
    }

    public String getBusinessRuleCheckbox() {
        return businessRuleCheckbox;
    }

    public void setBusinessRuleCheckbox(String businessRuleCheckbox) {
        this.businessRuleCheckbox = businessRuleCheckbox;
    }

    public String getBusinessRuleLimitCheckbox() {
        return businessRuleLimitCheckbox;
    }

    public void setBusinessRuleLimitCheckbox(String businessRuleLimitCheckbox) {
        this.businessRuleLimitCheckbox = businessRuleLimitCheckbox;
    }

    public String getOrderAmountLimitCheckbox() {
        return orderAmountLimitCheckbox;
    }

    public void setOrderAmountLimitCheckbox(String orderAmountLimitCheckbox) {
        this.orderAmountLimitCheckbox = orderAmountLimitCheckbox;
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

	public String getGrantUserName() {
		return grantUserName;
	}

	public void setGrantUserName(String grantUserName) {
		this.grantUserName = grantUserName;
	}

	public String getGrantWayName() {
		return grantWayName;
	}

	public void setGrantWayName(String grantWayName) {
		this.grantWayName = grantWayName;
	}

	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	public String getGrantRangeName() {
		return grantRangeName;
	}

	public void setGrantRangeName(String grantRangeName) {
		this.grantRangeName = grantRangeName;
	}

	public List<String> getProductClassNames() {
		return productClassNames;
	}

	public void setProductClassNames(List<String> productClassNames) {
		this.productClassNames = productClassNames;
	}

	public List<ProductProxyDto> getProducts() {
		return products;
	}

	public void setProducts(List<ProductProxyDto> products) {
		this.products = products;
	}

	public String getVouPackName() {
		return vouPackName;
	}

	public void setVouPackName(String vouPackName) {
		this.vouPackName = vouPackName;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public List<Map<String, Object>> getBusinessRuleLimitMaps() {
		return businessRuleLimitMaps;
	}

	public void setBusinessRuleLimitMaps(List<Map<String, Object>> businessRuleLimitMaps) {
		this.businessRuleLimitMaps = businessRuleLimitMaps;
	}

}
