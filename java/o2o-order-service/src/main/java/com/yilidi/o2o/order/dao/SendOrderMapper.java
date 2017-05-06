package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.order.model.SendOrder;

/**
 * 功能描述：发货记录数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SendOrderMapper {

	/**
	 * 保存发货记录
	 * 
	 * @param record
	 *            发货记录
	 * @return 影响的行数
	 */
	Integer save(SendOrder record);

	/**
	 * 根据订单编号查询发货记录
	 * 
	 * @param saleOrderNo
	 *            订单编号
	 * @return 发货记录列表
	 */
	List<SendOrder> listBySaleOrderNo(String saleOrderNo);

}