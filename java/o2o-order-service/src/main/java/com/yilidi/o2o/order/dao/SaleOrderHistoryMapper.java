package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.order.model.SaleOrderHistory;

/**
 * 功能描述： 订单状态历史记录数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleOrderHistoryMapper {

	/**
	 * 保存订单状态历史记录
	 * 
	 * @param record
	 *            记录
	 * @return 影响行数
	 */
	Integer save(SaleOrderHistory record);

	/**
	 * 根据订单编号查询订单的历史记录
	 * 
	 * @param saleOrderNo
	 *            订单编号
	 * @return 订单历史记录列表
	 */
	List<SaleOrderHistory> listBySaleOrderNo(String saleOrderNo);

}