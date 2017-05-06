package com.yilidi.o2o.user.model.combination;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：门店评价与门店，用户相关信息进行组合封装，供Mybatis使用<br/>
 * 作者：llp <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class StoreEvaluationInfo extends BaseModel {
    /** 
	 * @Fields serialVersionUID : TODO(系列号) 
	 */ 
	private static final long serialVersionUID = 8542110499477059815L;
	
	/**
     * 评价ID，主键
     */
    private Integer id;
    /**
     * 订单编号, 可调用StringUtils.generateOrderNo()生成
     */
    private String saleOrderNo;
    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 门店编码
     */
    private String storeCode;
    /**
     * 店铺名称
     */
    private String storeName;
	/**
     * 用户ID
     */
    private Integer userId;
    /**
     * 用户账号
     */
    private String userName;
    /**
     * 评价内容
     */
    private String content;
    /**
     * 商家描述相符星级，范围0-5'
     */
    private Integer coincideStar;
    /**
     * 商家配送速度星级，范围0-5'
     */
    private Integer sendStar;
    /**
     * 商家服务态度星级，范围0-5'
     */
    private Integer attitudeStar;
    /**
     * 是否匿名评价编码 ：是 ，否' ,关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=STOREEVALUATIONANONYMITYEVAL)
     */
    private String anonymityEvaluate;
    /**
     * 是否系统评价编码：是 ， 否',关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=STOREEVALUATIONSYSTEMEVAL)
     */
    private String systemEvaluate;
    /**
     * 显示状态编码：显示，取消显示,关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=STOREEVALUATIONSTATUS)
     */
    private String showStatus;
    /**
     * 评价时间
     */
    private Date createTime;
    
    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    
    public Integer getCoincideStar() {
        return coincideStar;
    }

    public void setCoincideStar(Integer coincideStar) {
        this.coincideStar = coincideStar;
    }

    public Integer getSendStar() {
        return sendStar;
    }

    public void setSendStar(Integer sendStar) {
        this.sendStar = sendStar;
    }
    
    public Integer getAttitudeStar() {
        return attitudeStar;
    }

    public void setAttitudeStar(Integer attitudeStar) {
        this.attitudeStar = attitudeStar;
    }

    public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public String getShowStatus() {
		return showStatus;
	}

	public void setShowStatus(String showStatus) {
		this.showStatus = showStatus;
	}

	public String getSystemEvaluate() {
		return systemEvaluate;
	}

	public void setSystemEvaluate(String systemEvaluate) {
		this.systemEvaluate = systemEvaluate;
	}

	public String getAnonymityEvaluate() {
		return anonymityEvaluate;
	}

	public void setAnonymityEvaluate(String anonymityEvaluate) {
		this.anonymityEvaluate = anonymityEvaluate;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getStoreCode() {
		return storeCode;
	}

	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
	}
}