package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SaleProductImageHistory;

/**
 * 功能描述：商品图片历史信息数据层操作接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleProductImageHistoryMapper {
	/**
	 * 根据图片id查询图片历史信息
	 * 
	 * <pre>
	 * 注：使用缓存查询数据
	 * </pre>
	 * 
	 * @param id
	 *            商品图片id
	 * @return 图片信息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE_HISTORY })
	SaleProductImageHistory loadSaleProductImageHistoryById(@Param("id") Integer id);

	/**
	 * 保存商品的图片信息（所有字段都不能为空）
	 * 
	 * @param record
	 *            图片信息对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE_HISTORY })
	Integer saveSaleProductImageHistory(SaleProductImageHistory record);

	/**
	 * 根据商品id和渠道查询该商品该渠道的图片历史列表信息
	 * 
	 * <pre>
	 * 注：使用缓存查询数据
	 * </pre>
	 * 
	 * @param saleProductId
	 *            商品id
	 * @param channelCode
	 *            渠道编码
	 * @return 图片信息列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE_HISTORY })
	List<SaleProductImageHistory> listSaleProductImageHistorysBySaleProductIdAndChannelCode(
			@Param("saleProductId") Integer saleProductId, @Param("channelCode") String channelCode);

}