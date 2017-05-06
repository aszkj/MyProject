package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.order.model.StockOutItem;

/**
 * 功能描述：出库明细数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface StockOutItemMapper {

	/**
	 * 保存出库明细记录
	 * 
	 * @param record
	 *            出库明细记录
	 * @return 影响行数
	 */
	Integer save(StockOutItem record);

	/**
	 * 根据出库记录查询出库明细
	 * 
	 * @param stockOutId
	 *            出库ID
	 * @return 出库明细列表
	 */
	List<StockOutItem> listByStockOutId(Integer stockOutId);
}