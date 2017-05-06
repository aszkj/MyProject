package com.yilidi.o2o.product.dao;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SaleProductPriceHistory;

/**
 * 功能描述：商品历史价格数据层操作接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleProductPriceHistoryMapper {
	/**
	 * 保存商品的历史价格信息
	 * 
	 * @param record
	 *            价格信息对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PRICE_HISTORY })
	Integer saveSaleProductPriceHistory(SaleProductPriceHistory record);
	/**
	 * 依据商品价格ID查询商品的历史价格信息
	 * 
	 * @param saleProductPriceId
	 *            历史价格信息对象Id
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PRICE_HISTORY })
	SaleProductPriceHistory listSaleProductPriceHistoryBySaleProductPriceId(Integer saleProductPriceId);
	/**
	 * 依据商品ID以及渠道查询商品该渠道的的历史价格信息
	 * 
	 * @param saleProductPriceId
	 *            历史价格信息对象Id
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PRICE_HISTORY })
	SaleProductPriceHistory listSaleProductPriceHistoryBySaleProductIdAndChannelCode(Integer saleProductPriceId);
}