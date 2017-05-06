package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.order.model.ProductImeiLog;

/**
 * 功能描述：商品IMEI号日志数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductImeiLogMapper {

	/**
	 * 保存商品串号日志信息
	 * 
	 * @param record
	 *            商品串号信息记录
	 * @return 影响行数
	 */
	Integer save(ProductImeiLog record);

	/**
	 * 根据入库串号查询日志记录
	 * 
	 * @param imeiNo
	 *            商品串号
	 * @return 串号日志列表
	 */
	List<ProductImeiLog> listByImeiNo(String imeiNo);

}