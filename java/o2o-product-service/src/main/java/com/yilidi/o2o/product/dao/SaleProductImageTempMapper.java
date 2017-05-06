package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SaleProductImageTemp;

/**
 * 功能描述：商品临时图片信息数据层操作接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleProductImageTempMapper {
	/**
	 * 根据图片id查询临时图片信息
	 * 
	 * <pre>
	 * 注：使用缓存查询数据
	 * </pre>
	 * 
	 * @param tempId
	 *            商品临时图片tempId
	 * @return 图片信息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE_TEMP })
	SaleProductImageTemp loadSaleProductImageTempById(@Param("tempId") Integer tempId);

	/**
	 * 保存商品临时的图片信息
	 * 
	 * @param record
	 *            临时图片信息对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE_TEMP })
	Integer saveSaleProductImageTemp(SaleProductImageTemp record);

	/**
	 * 更新商品临时的图片信息
	 * 
	 * @param record
	 *            临时图片信息对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE_TEMP })
	Integer updateSaleProductImageTemp(SaleProductImageTemp record);

	/**
	 * 根据id删除图片信息
	 * 
	 * @param tempId
	 *            图片信息tempId
	 * @param channelCode
	 *            图片信息channelCode
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE_TEMP })
	Integer deleteSaleProductImageTempByTempIdAndChannelCode(@Param("tempId") Integer tempId,
			@Param("channelCode") String channelCode);

	/**
	 * 根据id删除图片信息
	 * 
	 * @param saleProductId
	 *            图片信息SaleProductId
	 * @param channelCode
	 *            图片信息渠道编码
	 * @return SaleProductImageTemp
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE_TEMP })
	List<SaleProductImageTemp> listSaleProductImageTempsBySaleProductIdAndChannelCode(
			@Param("saleProductId") Integer saleProductId, @Param("channelCode") String channelCode);
}