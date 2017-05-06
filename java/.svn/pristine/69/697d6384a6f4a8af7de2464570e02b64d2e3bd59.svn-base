package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.order.model.SendOrderDetail;

/**
 * 功能描述： 发货记录明细数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SendOrderDetailMapper {

	/**
	 * 保存发货明细记录
	 * 
	 * @param record
	 *            发货明细
	 * @return 影响行数
	 */
	Integer save(SendOrderDetail record);

	/**
	 * 根据发货记录ID查询发货明细
	 * 
	 * @param sendOrderId
	 *            发货记录ID
	 * @return 发货明细列表
	 */
	List<SendOrderDetail> listBySendOrderId(Integer sendOrderId);

}