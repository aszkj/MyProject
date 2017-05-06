package com.yilidi.o2o.order.dao;

import com.yilidi.o2o.order.model.StockOutImei;

/**
 * 功能描述：出库串号记录数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface StockOutImeiMapper {

	/**
	 * 保存出库的串号信息
	 * 
	 * @param record
	 *            出库串号信息
	 * @return 影响的行数
	 */
	Integer save(StockOutImei record);

}