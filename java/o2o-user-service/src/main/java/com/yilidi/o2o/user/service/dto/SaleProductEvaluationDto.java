package com.yilidi.o2o.user.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**DTO
 * @Description:TODO(商品评价与评价用户，门店相关信息进行组合封装DTO) 
 * @author:	llp
 * @date:	2015年12月7日 上午10:10:30 
 */
public class SaleProductEvaluationDto extends BaseDto {
	private static final long serialVersionUID = 888270809267748337L;
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
     * 店铺ID
     */
    private String storeItems;
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
     * 产品ID，关联产品域P_PRODUCT表ID
     */
    private Integer productId;
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
     * 评价图片的FULLURL
     */
    private List<SaleProductEvaluationImageProfileDto> saleProductEvaluationImageProfileDtos;
    /**
     * 是否上传图片标志：是和否，关联系统域字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SALEPRODUCTEVALUATIONPHOTOFLAG)
     */
    private String uploadPhotoFlag;
    /**
     * app端需要删除的图片url组
     */
    private String deleteImageUrls;
    /**
     * app端第一张图片Dto
     */
    private SaleProductEvaluationImageProfileDto firstAppImageProfileDto;
    /**
     * app端第二张图片Dto
     */
    private SaleProductEvaluationImageProfileDto secondAppImageProfileDto;
    /**
     * app端第三张图片Dto
     */
    private SaleProductEvaluationImageProfileDto thirdAppImageProfileDto;
    /**
     * app端第四张图片Dto
     */
    private SaleProductEvaluationImageProfileDto fouthAppImageProfileDto;
    /**
     * app端第五张图片Dto
     */
    private SaleProductEvaluationImageProfileDto fiveAppImageProfileDto;
    
	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getStoreItems() {
		return storeItems;
	}

	public void setStoreItems(String storeItems) {
		this.storeItems = storeItems;
	}

	public List<SaleProductEvaluationImageProfileDto> getSaleProductEvaluationImageProfileDtos() {
		return saleProductEvaluationImageProfileDtos;
	}

	public void setSaleProductEvaluationImageProfileDtos(
			List<SaleProductEvaluationImageProfileDto> saleProductEvaluationImageProfileDtos) {
		this.saleProductEvaluationImageProfileDtos = saleProductEvaluationImageProfileDtos;
	}

	public String getDeleteImageUrls() {
		return deleteImageUrls;
	}

	public void setDeleteImageUrls(String deleteImageUrls) {
		this.deleteImageUrls = deleteImageUrls;
	}

	public SaleProductEvaluationImageProfileDto getFirstAppImageProfileDto() {
		return firstAppImageProfileDto;
	}

	public void setFirstAppImageProfileDto(SaleProductEvaluationImageProfileDto firstAppImageProfileDto) {
		this.firstAppImageProfileDto = firstAppImageProfileDto;
	}

	public SaleProductEvaluationImageProfileDto getSecondAppImageProfileDto() {
		return secondAppImageProfileDto;
	}

	public void setSecondAppImageProfileDto(SaleProductEvaluationImageProfileDto secondAppImageProfileDto) {
		this.secondAppImageProfileDto = secondAppImageProfileDto;
	}

	public SaleProductEvaluationImageProfileDto getThirdAppImageProfileDto() {
		return thirdAppImageProfileDto;
	}

	public void setThirdAppImageProfileDto(SaleProductEvaluationImageProfileDto thirdAppImageProfileDto) {
		this.thirdAppImageProfileDto = thirdAppImageProfileDto;
	}

	public SaleProductEvaluationImageProfileDto getFouthAppImageProfileDto() {
		return fouthAppImageProfileDto;
	}

	public void setFouthAppImageProfileDto(SaleProductEvaluationImageProfileDto fouthAppImageProfileDto) {
		this.fouthAppImageProfileDto = fouthAppImageProfileDto;
	}

	public SaleProductEvaluationImageProfileDto getFiveAppImageProfileDto() {
		return fiveAppImageProfileDto;
	}

	public void setFiveAppImageProfileDto(SaleProductEvaluationImageProfileDto fiveAppImageProfileDto) {
		this.fiveAppImageProfileDto = fiveAppImageProfileDto;
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