package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SaleProductProfileHistory;

/**
 * 功能描述：商品历史附属数据层操作接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleProductProfileHistoryMapper {
	/**
	 * 保存商品的历史附属信息
	 * 
	 * @param record
	 *            历史附属信息对象
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE_HISTORY })
	void saveSaleProductProfileHistory(SaleProductProfileHistory record);
	
	/**
	 * 查询商品的历史附属信息
	 * 
	 * @param id
	 *            历史附属信息Id
	 * @return 商品历史历史附属信息
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE_HISTORY })
	SaleProductProfileHistory loadSaleProductProfileHistoryById(@Param("id") Integer id);
	
	/**
	 * 查询商品的历史历史附属信息
	 * 
	 * @param saleProductId
	 *            商品ID
	 * @param channelCode
	 *            渠道编码
	 * @return 商品历史历史附属信息列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE_HISTORY })
	List<SaleProductProfileHistory> listSaleProductProfileHistoryBySaleProductIdAndChannelCode(
			@Param("saleProductId") Integer saleProductId, @Param("channelCode") String channelCode);
}