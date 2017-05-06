package com.yilidi.o2o.product.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ProductProfile;

/**
 * 功能描述：产品描述数据层接口操作类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductProfileMapper {
	/**
	 * 保存产品描述信息(所有信息都不能为null)
	 * 
	 * @param record
	 *            产品描述信息记录
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PROFILE })
	Integer saveProductProfile(ProductProfile record);

	/**
	 * 根据ID删除产品描述信息
	 * 
	 * @param id
	 *            描述信息id
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PROFILE })
	Integer deleteProductProfileById(Integer id);

	/**
	 * 根据产品id和渠道类型删除产品描述信息
	 * 
	 * @param productId
	 *            产品ID
	 * @param channelCode
	 *            渠道编码
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PROFILE })
	Integer deleteProductProfileByProductIdAndChannelCode(@Param("productId") Integer productId,
			@Param("channelCode") String channelCode);

	/**
	 * 根据描述信息ID更新产品信息
	 * 
	 * @param record
	 *            产品信息
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PROFILE })
	Integer updateProductProfileById(ProductProfile record);

	/**
	 * 根据产品ID和渠道编码更新产品描述信息
	 * 
	 * @param record
	 *            产品信息
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PROFILE })
	Integer updateProductProfileByProductIdAndChannelCode(ProductProfile record);

	/**
	 * 根据id更新产品的上下架状态
	 * 
	 * @param productId
	 *            产品productId
	 * @param saleStatus
	 *            上下架状态
	 * @param channelCode
	 *            渠道编码
	 * @param modifyUserId
	 *            更新人
	 * @param modifyTime
	 *            更新时间
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PROFILE })
	Integer updateSaleStatusByProductIdAndChannelCode(@Param("productId") Integer productId,
			@Param("saleStatus") String saleStatus, @Param("channelCode") String channelCode,
			@Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

	/**
	 * 根据id更新产品的热卖状态
	 * 
	 * @param productId
	 *            产品productId
	 * @param hotSaleFlag
	 *            热卖状态
	 * @param channelCode
	 *            渠道编码
	 * @param modifyUserId
	 *            更新人
	 * @param modifyTime
	 *            更新时间
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_PROFILE })
	Integer updateHotSaleFlagByProductIdAndChannelCode(@Param("productId") Integer productId,
			@Param("hotSaleFlag") String hotSaleFlag, @Param("channelCode") String channelCode,
			@Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

	/**
	 * 根据产品描述信息id查询产品描述信息
	 * 
	 * <pre>
	 * 注： 使用缓存查询数据
	 * </pre>
	 * 
	 * @param id
	 *            描述id
	 * @return 产品描述信息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_PROFILE })
	ProductProfile loadProductProfileById(Integer id);

	/**
	 * 根据产品id和渠道查询产品的描述信息
	 * 
	 * <pre>
	 * 注： 使用缓存查询数据
	 * </pre>
	 * 
	 * @param productId
	 *            产品ID
	 * @param channelCode
	 *            渠道编码
	 * @return 产品描述信息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_PROFILE })
	ProductProfile loadProductProfileByProductIdAndChannelCode(@Param("productId") Integer productId,
			@Param("channelCode") String channelCode);

}