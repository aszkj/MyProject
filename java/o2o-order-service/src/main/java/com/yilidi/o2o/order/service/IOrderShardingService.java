/**
 * 文件名称：IOrderShardingService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service;

import com.yilidi.o2o.core.exception.OrderServiceException;

/**
 * 功能描述：订单分表服务接口 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IOrderShardingService {

	/**
	 * 根据订单生成时间分表
	 * 
	 * @param tableIndex
	 *            T_SALE_ORDER_CREATETIME_XXX 中的序号
	 * @throws OrderServiceException
	 */
	public void createShardingByCreateTime(int tableIndex) throws OrderServiceException;

}
