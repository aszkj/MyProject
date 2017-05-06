package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.order.model.OrderPayment;

/**
 * 功能描述：订单支付记录数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface OrderPaymentMapper {

	/**
	 * 保存订单的支付记录
	 * 
	 * @param record
	 *            支付记录
	 * @return 影响行数
	 */
	Integer save(OrderPayment record);

	/**
	 * 根据订单号查询支付记录
	 * 
	 * @param saleOrderNo
	 *            订单号
	 * @return 支付记录列表
	 */
	List<OrderPayment> listBySaleOrderNo(String saleOrderNo);

}