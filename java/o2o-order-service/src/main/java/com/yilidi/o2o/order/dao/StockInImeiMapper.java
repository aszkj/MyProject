package com.yilidi.o2o.order.dao;

import com.yilidi.o2o.order.model.StockInImei;

/**
 * 功能描述：串号入库记录 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface StockInImeiMapper {

	/**
	 * 保存入库的串号信息
	 * 
	 * @param record
	 *            记录
	 * @return 影响行数
	 */
	Integer save(StockInImei record);

}