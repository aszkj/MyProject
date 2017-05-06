package com.yilidi.o2o.product.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ProductBasicProps;

/**
 * 功能描述：产品基础属性数据层操作接口<br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductBasicPropsMapper {

	/**
	 * 保存产品的基本属性信息
	 * 
	 * @param record
	 *            基本属性对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_BASIC_PROPS })
	Integer save(ProductBasicProps record);

	/**
	 * 根据产品的基本属性ID更新属性信息
	 * 
	 * @param record
	 *            产品基本属性对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_BASIC_PROPS })
	Integer updateByIdSelective(ProductBasicProps record);

	/**
	 * 根据产品的类型查询产品的基本属性信息
	 * 
	 * @param classCode
	 *            产品类别编码
	 * @return 产品基本属性列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_BASIC_PROPS })
	List<ProductBasicProps> listByClassCode(String classCode);

}