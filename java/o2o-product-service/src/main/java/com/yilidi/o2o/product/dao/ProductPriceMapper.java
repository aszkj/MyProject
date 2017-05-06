package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ProductPrice;

/**
 * 功能描述：产品价格数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductPriceMapper {
	/**
	 * 保存产品的价格信息（所有值都不能为null）
	 * 
	 * @param record
	 *            价格信息对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PRICE })
	Integer saveProductPrice(ProductPrice record);

	/**
	 * 根据产品价格id更新的促销价和零售价
	 * 
	 * @param record
	 *            价格信息对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PRICE })
	Integer updateProductPriceById(ProductPrice record);

	/**
	 * 根据产品id和渠道编码更新产品的促销价和零售价
	 * 
	 * @param record
	 *            价格信息对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PRICE })
	Integer updateProductPriceByProductIdAndChannelCode(ProductPrice record);

	/**
	 * 根据价格ID查询价格信息
	 * 
	 * @param id
	 *            价格id
	 * @return 产品价格信息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_PRICE })
	ProductPrice loadProductPriceById(@Param("id") Integer id);

	/**
	 * 根据产品id和渠道编码查询产品的价格信息
	 * 
	 * @param productId
	 *            产品ID
	 * @param channelCode
	 *            渠道编码
	 * @return 产品价格信息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_PRICE })
	ProductPrice loadProductPriceByProductIdAndChannelCode(@Param("productId") Integer productId,
			@Param("channelCode") String channelCode);

	/**
	 * 根据产品id查询产品的价格信息（包含不同渠道的价格）
	 * 
	 * @param productId
	 *            产品id
	 * @return 产品价格信息列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_PRICE })
	List<ProductPrice> listProductPricesByProductId(@Param("productId") Integer productId);

}