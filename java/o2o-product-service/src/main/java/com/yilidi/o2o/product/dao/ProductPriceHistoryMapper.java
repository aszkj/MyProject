package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ProductPriceHistory;

/**
 * 功能描述：产品历史价格数据层操作接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductPriceHistoryMapper {
	/**
	 * 保存产品的历史价格信息
	 * 
	 * @param record
	 *            价格信息对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PRICE_HISTORY })
	Integer saveProductPriceHistory(ProductPriceHistory record);

	/**
	 * 依据产品价格ID查询产品的历史价格信息列表
	 * 
	 * @param productPriceId
	 *            价格信息对象Id
	 * @return 价格信息列表
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PRICE_HISTORY })
	List<ProductPriceHistory> listProductPriceHistoryByProductPriceId(@Param("productPriceId") Integer productPriceId);

	/**
	 * 依据产品历史价格ID查询产品的历史价格信息
	 * 
	 * @param id
	 *            历史价格信息Id
	 * @return 历史价格信息
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PRICE_HISTORY })
	ProductPriceHistory loadProductPriceHistoryById(@Param("id") Integer id);

	/**
	 * 依据产品价格ID查询产品的历史价格信息列表
	 * 
	 * @param productId
	 *            产品ID
	 * @param channelCode
	 *            渠道编码
	 * @return 历史价格信息列表
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PRICE_HISTORY })
	List<ProductPriceHistory> listProductPriceHistoryByProductIdAndChannelCode(@Param("productId") Integer productId,
			@Param("channelCode") Integer channelCode);
}