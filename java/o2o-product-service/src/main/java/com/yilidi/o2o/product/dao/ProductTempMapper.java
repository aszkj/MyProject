package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ProductTemp;
import com.yilidi.o2o.product.model.combination.ProductTempInfo;
import com.yilidi.o2o.product.service.dto.query.ProductTempQuery;

/**
 * 功能描述：临时产品数据层操作接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductTempMapper {

	/**
	 * 保存临时产品信息
	 * 
	 * @param record
	 *            临时产品记录
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_TEMP })
	Integer saveProductTemp(ProductTemp record);

	/**
	 * 根据id查询临时产品信息
	 * 
	 * @param tempId
	 *            临时产品id
	 * @return 临时产品对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_TEMP })
	ProductTemp loadProductTempById(@Param("tempId") Integer tempId);

	/**
	 * 根据条形码查询临时产品信息
	 * 
	 * @param barCode
	 *            临时产品条形码
	 * @param channelCode
	 *            渠道编码
	 * @return 临时产品对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_TEMP })
	ProductTemp loadProductTempByBarCodeAndChannelCode(@Param("barCode") String barCode,
			@Param("channelCode") String channelCode);

	/**
	 * 根据条件查询产品临时列表
	 * 
	 * <pre>
	 * 注：使用缓存查询数据
	 * </pre>
	 * 
	 * @param record
	 *            临时产品查询实体，
	 * @return 产品列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_TEMP,
			DBTablesName.Product.P_PRODUCT_CLASS })
	List<ProductTempInfo> listProductTemp(ProductTempQuery record);
	/**
	 * 根据id删除临时产品信息
	 * 
	 * @param tempId
	 *            临时产品Id
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_TEMP })
	void deleteProductTemp(@Param("tempId") Integer tempId);
	
	/**
	 * 删除所有临时产品信息
	 * 
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_TEMP })
	void deleteAllProductTemp();
	
	/**
	 * 查询产品临时列表
	 * 
	 * <pre>
	 * 注：使用缓存查询数据
	 * </pre>
	 * 
	 * @param record
	 *            临时产品查询实体，
	 * @return 产品列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_TEMP,
			DBTablesName.Product.P_PRODUCT_CLASS })
	Page<ProductTempInfo> findProductTemps(ProductTempQuery record);
	
	/**
	 * 查询所有产品临时的条形码列表
	 * 
	 * @return 产品列表
	 */
	List<String> getProductTempBarCode();
}