package com.yilidi.o2o.user.model.combination;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * @Description:TODO(商品评价与评价用户，门店相关信息进行组合封装，供Mybatis使用) 
 * @author:	llp
 * @date:	2015年12月7日 上午10:10:30 
 */
public class SaleProductEvaluationInfo extends BaseModel {
	private static final long serialVersionUID = 7981147680612861777L;
	/**
     * 评价ID，主键
     */
    private Integer id;
    /**
     * 订单编号
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
     * 产品ID，关联产品域P_SALEPRODUCT表ID
     */
    private Integer saleProductId;
    /**
     * 产品条形码
     */
    private String barCode;
    /**
     * 商品名称
     */
    private String saleProductName;
    /**
     * 评价内容
     */
    private String content;
    /**
     * 产品评价星级，范围0-5'
     */
    private Integer productStar;
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
    /**
     * 评价图片的URL
     */
    private String photoUrl;
    /**
     * 是否上传图片标志：是和否，关联系统域字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SALEPRODUCTEVALUATIONPHOTOFLAG)
     */
    private String uploadPhotoFlag;
    
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

	public Integer getProductStar() {
		return productStar;
	}

	public void setProductStar(Integer productStar) {
		this.productStar = productStar;
	}

	public String getBarCode() {
		return barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}

	public String getSaleProductName() {
		return saleProductName;
	}

	public void setSaleProductName(String saleProductName) {
		this.saleProductName = saleProductName;
	}

	public String getPhotoUrl() {
		return photoUrl;
	}

	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}

	public String getUploadPhotoFlag() {
		return uploadPhotoFlag;
	}

	public void setUploadPhotoFlag(String uploadPhotoFlag) {
		this.uploadPhotoFlag = uploadPhotoFlag;
	}

	public Integer getSaleProductId() {
		return saleProductId;
	}

	public void setSaleProductId(Integer saleProductId) {
		this.saleProductId = saleProductId;
	}
}