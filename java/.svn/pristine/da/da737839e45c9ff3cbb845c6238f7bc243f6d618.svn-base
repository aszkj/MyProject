package com.yilidi.o2o.product.dao;

import java.util.List;

import com.yilidi.o2o.product.model.SaleProductHistory;

/**
 * 功能描述：商品历史记录数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleProductHistoryMapper {

	/**
	 * 保存商品历史记录信息
	 * 
	 * @param record
	 *            历史记录
	 * @return 影响行数
	 */
	Integer saveSaleProductHistory(SaleProductHistory record);

	/**
	 * 根据商品id查询商品的历史记录信息
	 * 
	 * @param saleProductId
	 *            商品id
	 * @return 商品历史记录列表
	 */
	List<SaleProductHistory> listSaleProductHistoryBySaleProductId(Integer saleProductId);

}