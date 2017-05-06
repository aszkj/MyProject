package com.yilidi.o2o.user.service.dto.query;

import java.util.List;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * @Description:TODO(商品评论查询封装类) 
 * @author:	llp
 * @date:	2015年12月7日 上午10:17:11 
 */
public class SaleProductEvaluateQuery extends BaseQuery {
	private static final long serialVersionUID = -2459186698921956793L;
	 /**
     * 产品条形码
     */
    private String barCode;
    /**
     * 商品名称
     */
    private String saleProductName;
    /**
     * 商品id
     */
    private Integer saleProductId;
	/**
	 * 评论用户账号
	 */
	private String userName;
	 /**
     * 订单号，关联订单域T_SALE_ORDER表的SALEORDERNO
     */
    private String saleOrderNo;
    /**
     * 评价内容
     */
    private String content;
    /**
     * 是否系统评论
     */
    private String systemEvaluate;
    /**
     * 是否匿名评价
     */
    private String anonymityEvaluate;
    /**
     * 显示状态编码
     */
    private String showStatus;
    
	/**
	 * 评论开始时间
	 */
	private String startCreateTime;
	
	/**
	 * 评论结束时间
	 */
	private String endCreateTime;
	
	/**
	 * 排序方式
	 */
	private String sortFormat;
	/**
     * 排序方式
     */
    private List<Integer> productStars;
    /**
     * 是否上传图片标志：是和否，关联系统域字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SALEPRODUCTEVALUATIONPHOTOFLAG)
     */
    private String uploadPhotoFlag;
    
	public String getUploadPhotoFlag() {
        return uploadPhotoFlag;
    }

    public void setUploadPhotoFlag(String uploadPhotoFlag) {
        this.uploadPhotoFlag = uploadPhotoFlag;
    }

    public List<Integer> getProductStars() {
        return productStars;
    }

    public void setProductStars(List<Integer> productStars) {
        this.productStars = productStars;
    }

    public String getSortFormat() {
		return sortFormat;
	}

	public void setSortFormat(String sortFormat) {
		this.sortFormat = sortFormat;
	}

	public String getSaleOrderNo() {
		return saleOrderNo;
	}

	public void setSaleOrderNo(String saleOrderNo) {
		this.saleOrderNo = saleOrderNo;
	}

	public String getStartCreateTime() {
		return startCreateTime;
	}

	public void setStartCreateTime(String startCreateTime) {
		this.startCreateTime = startCreateTime;
	}

	public String getEndCreateTime() {
		return endCreateTime;
	}

	public void setEndCreateTime(String endCreateTime) {
		this.endCreateTime = endCreateTime;
	}
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public Integer getSaleProductId() {
		return saleProductId;
	}

	public void setSaleProductId(Integer saleProductId) {
		this.saleProductId = saleProductId;
	}

	public String getAnonymityEvaluate() {
		return anonymityEvaluate;
	}

	public void setAnonymityEvaluate(String anonymityEvaluate) {
		this.anonymityEvaluate = anonymityEvaluate;
	}
	
}
