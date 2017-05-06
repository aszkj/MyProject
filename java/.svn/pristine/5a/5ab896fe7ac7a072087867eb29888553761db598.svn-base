package com.yilidi.o2o.user.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;
/**
 * 
 * @Description:TODO(门店评论查询封装类 ) 
 * @author: llp
 * @date:	2015年11月13日 上午9:27:21 
 *
 */
public class StoreEvaluateQuery extends BaseQuery {
	/** 
	 * @Fields serialVersionUID : TODO(序列号) 
	 */ 
	private static final long serialVersionUID = -7054793990448861294L;

	/**
	 * 门店编码
	 */
	private String storeCode;
	/**
	 * 客户名称：零售商名称，供应商名称，运营商（机构）名称
	 */
	private String storeName;
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
     * 是否匿名评价编码 ：是 ，否' ,关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=STOREEVALUATIONANONYMITYEVAL)
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
	
	public String getAnonymityEvaluate() {
		return anonymityEvaluate;
	}

	public void setAnonymityEvaluate(String anonymityEvaluate) {
		this.anonymityEvaluate = anonymityEvaluate;
	}
	
	public String getStoreCode() {
		return storeCode;
	}

	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
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
}
