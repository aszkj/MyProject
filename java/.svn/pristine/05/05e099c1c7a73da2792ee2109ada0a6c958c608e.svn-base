package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SaleProductPrice;

/**
 * 功能描述：商品价格数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleProductPriceMapper {
	/**
	 * 保存商品的价格信息
	 * 
	 * @param record
	 *            价格信息对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PRICE })
	Integer saveSaleProductPrice(SaleProductPrice record);

	/**
	 * 根据商品价格id更新的促销价和零售价
	 * 
	 * @param record
	 *            价格信息对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PRICE })
	Integer updateSaleProductPriceById(SaleProductPrice record);

	/**
	 * 根据商品id和渠道编码更新商品的促销价和零售价
	 * 
	 * @param saleProductId
	 *            商品id
	 * @param channelCode
	 *            渠道编码
	 * @param promotionalPrice
	 *            促销价， 如果该字段值为null，则不更新该字段
	 * @param retailPrice
	 *            零售价， 如果该字段值为null，则不更新该字段
	 * @param modifyUserId
	 *            修改人id
	 * @param modifyTime
	 *            用户修改时间
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PRICE })
	Integer updateSaleProductPriceBySaleProductIdAndChannelCode(@Param("saleProductId") Integer saleProductId,
			@Param("channelCode") String channelCode, @Param("promotionalPrice") Long promotionalPrice,
			@Param("retailPrice") Long retailPrice, @Param("modifyUserId") Integer modifyUserId,
			@Param("modifyTime") Date modifyTime);

	/**
	 * 根据价格ID查询价格信息
	 * 
	 * @param id
	 *            价格id
	 * @return 商品价格信息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PRICE })
	SaleProductPrice loadSaleProductPriceById(@Param("id") Integer id);

	/**
	 * 根据商品id和渠道编码查询商品的价格信息
	 * 
	 * @param saleProductId
	 *            商品ID
	 * @param channelCode
	 *            渠道编码
	 * @return 商品价格信息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PRICE })
	SaleProductPrice loadSaleProductPriceBySaleProductIdAndChannelCode(@Param("saleProductId") Integer saleProductId,
			@Param("channelCode") String channelCode);

	/**
	 * 根据商品id查询商品的价格信息（包含不同渠道的价格）
	 * 
	 * @param saleProductId
	 *            商品id
	 * @return 商品价格信息列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PRICE })
	List<SaleProductPrice> listSaleProductPricesBySaleProductId(@Param("saleProductId") Integer saleProductId);

}