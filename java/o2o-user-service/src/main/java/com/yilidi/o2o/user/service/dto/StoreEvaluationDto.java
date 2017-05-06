package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**DTO
 * @Description:TODO(门店评价与门店，用户相关信息进行组合封装Dto) 
 * @author:	llp
 * @date:	2015年12月7日 下午1:52:53 
 *
 */
public class StoreEvaluationDto extends BaseDto {
	private static final long serialVersionUID = -7634315894783442523L;
	/**
     * 评价ID，主键
     */
    private Integer id;
    /**
     * 订单编号
     */
    private String saleOrderNo;
    /**
     * 城市编码
     */
    private String cityCode;
	/**
     * 区县编码
     */
    private String countyCode;
    /**
     * 小区编码
     */
    private String communityCode;
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
     * 门店登入账号
     */
    private String storeUserName;
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
    
    
    public String getStoreUserName() {
		return storeUserName;
	}

	public void setStoreUserName(String storeUserName) {
		this.storeUserName = storeUserName;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	public String getCountyCode() {
		return countyCode;
	}

	public void setCountyCode(String countyCode) {
		this.countyCode = countyCode;
	}

	public String getCommunityCode() {
		return communityCode;
	}

	public void setCommunityCode(String communityCode) {
		this.communityCode = communityCode;
	}

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