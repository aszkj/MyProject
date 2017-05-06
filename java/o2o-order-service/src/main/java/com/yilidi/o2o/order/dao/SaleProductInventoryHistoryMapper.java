package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.order.model.SaleProductInventoryHistory;

/**
 * 功能描述：库存变化历史记录数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleProductInventoryHistoryMapper {

	/**
	 * 保存历史记录
	 * 
	 * @param record
	 *            库存历史记录
	 * @return 影响行数
	 */
	Integer save(SaleProductInventoryHistory record);

	/**
	 * 根据商品id查询库存历史记录
	 * 
	 * @param saleProductId
	 *            商品id
	 * @return 库存历史记录列表
	 */
	List<SaleProductInventoryHistory> listBySaleProductId(Integer saleProductId);

}