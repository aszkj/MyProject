/**
 * 文件名称：SaleOrderQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.dto.query;

import java.util.List;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 销售统计 ->用户销售统计查询Dto
 * 
 * @author: heyong
 * @date: 2015年11月25日 下午5:02:42
 * 
 */
public class SaleOrderStatisticsQuery extends BaseQuery {
	private static final long serialVersionUID = -9013587603194686868L;

	/**
	 * 订单用户账号
	 */
	private String userName;

	/**
	 * 查询下订单开始时间字符串
	 */
	private String strBeginOrderTime;

	/**
	 * 查询下订单结束时间字符串
	 */
	private String strEndOrderTime;

	/**
	 * 订单状态列表
	 */
	private List<String> orderStatusList;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getStrBeginOrderTime() {
		return strBeginOrderTime;
	}

	public void setStrBeginOrderTime(String strBeginOrderTime) {
		this.strBeginOrderTime = strBeginOrderTime;
	}

	public String getStrEndOrderTime() {
		return strEndOrderTime;
	}

	public void setStrEndOrderTime(String strEndOrderTime) {
		this.strEndOrderTime = strEndOrderTime;
	}

	public List<String> getOrderStatusList() {
		return orderStatusList;
	}

	public void setOrderStatusList(List<String> orderStatusList) {
		this.orderStatusList = orderStatusList;
	}
}