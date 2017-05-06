package com.yilidi.o2o.product.dao;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SaleProductTemp;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;
import com.yilidi.o2o.product.service.dto.query.SaleProductTempQuery;

/**
 * 功能描述：临时商品信息数据层操作接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleProductTempMapper {

	/**
	 * 保存商品基础信息
	 * 
	 * @param record
	 *            临时商品信息对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_TEMP })
	Integer saveSaleProductTemp(SaleProductTemp record);
	/**
	 * 删除商品基础信息
	 * 
	 * @param tempId
	 *            临时商品信息Id
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_TEMP })
	Integer deleteSaleProductTemp(@Param("tempId") Integer tempId);

	/**
	 * 更新临时商品基础信息
	 * 
	 * @param record
	 *            临时商品对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_TEMP })
	Integer updateSaleProductTempById(SaleProductTemp record);

	/**
	 * 根据临时商品id查询临时商品基础基础信息
	 * 
	 * @param tempId
	 *            临时商品ID
	 * @return 临时商品对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_TEMP })
	SaleProductTemp loadSaleProductTempById(@Param("tempId") Integer tempId);

	/**
	 * 根据商品id和渠道编码查询商品基础基础信息
	 * 
	 * @param saleProductId
	 *            临时商品ID
	 * @param channelCode
	 *            临时商品channelCode
	 * @return 临时商品对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_TEMP })
	SaleProductTemp loadSaleProductTempBasicInfoByIdAndChannelCode(@Param("saleProductId") Integer saleProductId,
			@Param("channelCode") String channelCode);

	/**
	 * 根据商店查询临时商品的基础信息
	 * 
	 * @param storeId
	 *            商店ID
	 * @return 临时商品基础信息列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_TEMP })
	Page<SaleProductTemp> findSaleProductTempByStoreId(@Param("storeId") Integer storeId);

	/**
	 * 条件查询商品列表（库存基础信息通过商品来关联获取）
	 * 
	 * @param saleProductTempQuery
	 *            商品查询实体记录
	 * @return 商品信息列表(除图片列表以外)
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_TEMP })
	Page<SaleProductTemp> findSaleProductTemps(SaleProductTempQuery saleProductTempQuery);

}