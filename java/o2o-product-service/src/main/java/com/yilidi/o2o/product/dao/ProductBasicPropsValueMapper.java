package com.yilidi.o2o.product.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ProductBasicPropsValue;

/**
 * 功能描述：产品基本属性数据层操作接口 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductBasicPropsValueMapper {

	/**
	 * 保存属性值
	 * @param record 属性值对象
	 * @return 影响行数
	 */
	Integer save(ProductBasicPropsValue record);

	/**
	 * 根据属性值ID更新属性值
	 * @param id 属性值ID
	 * @param value 属性值
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = {DBTablesName.Product.P_PRODUCT_BASIC_PROPS_VALUE})
	Integer updateValueById(Integer id, String value);

	/**
	 * 根据产品id和属性编码更新属性值
	 * @param productId 产品id
	 * @param propCode 属性编码
	 * @param value 属性值
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = {DBTablesName.Product.P_PRODUCT_BASIC_PROPS_VALUE})
	Integer updateValueByProductIdAndCode(Integer productId, String propCode, String value);
	
	/**
	 * 根据产品ID加载产品的属性值
	 * <pre>
	 * 注： 使用缓存查数据
	 * </pre>
	 * @param productId 产品Id 
	 * @return 产品属性值列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = {DBTablesName.Product.P_PRODUCT_BASIC_PROPS_VALUE})
	List<ProductBasicPropsValue> listByProductId(Integer productId);

}