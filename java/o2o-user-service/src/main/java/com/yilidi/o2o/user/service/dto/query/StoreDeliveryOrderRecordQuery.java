/**
 * 文件名称：StoreQuery.java
 * 
 * 描述：
 * 
 * 修改
 */
package com.yilidi.o2o.user.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 店铺接单员处理订单查询封装类
 * 
 * @author: heyong
 * @date: 2015年12月10日 下午8:06:01
 * 
 */
public class StoreDeliveryOrderRecordQuery extends BaseQuery {

	private static final long serialVersionUID = -1031339839094208077L;

	/**
	 * 登录账号
	 */
	private String userName;
	/**
	 * 处理订单号
	 */
	private String orderNo;
	/**
	 * 处理步骤
	 */
	private String step;
	/**
	 * 查询开始处理时间
	 */
	private String strStartCreateTime;
	/**
	 * 查询结束处理时间
	 */
	private String strEndCreateTime;

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getStep() {
		return step;
	}

	public void setStep(String step) {
		this.step = step;
	}

	public String getStrStartCreateTime() {
		return strStartCreateTime;
	}

	public void setStrStartCreateTime(String strStartCreateTime) {
		this.strStartCreateTime = strStartCreateTime;
	}

	public String getStrEndCreateTime() {
		return strEndCreateTime;
	}

	public void setStrEndCreateTime(String strEndCreateTime) {
		this.strEndCreateTime = strEndCreateTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
}
