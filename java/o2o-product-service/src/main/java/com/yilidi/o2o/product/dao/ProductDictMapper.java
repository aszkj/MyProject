package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ProductDict;

/**
 * 功能描述：产品字典数据层操作接口 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductDictMapper {

	/**
	 * 保存产品字典信息
	 * 
	 * @param record
	 *            产品字典对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_DICT })
	Integer save(ProductDict record);

	/**
	 * 根据字典编码更新字典名称
	 * 
	 * @param dictCode
	 *            字典编码
	 * @param dictName
	 *            字典名称
	 * @param modifyUserId
	 *            修改用户ID
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_DICT })
	Integer updateDictNameByDictCode(@Param("dictCode") String dictCode, @Param("dictName") String dictName,
			@Param("modifyUserId") Integer modifyUserId);

	/**
	 * 根据ID更新字典名称
	 * 
	 * @param id
	 *            字典ID
	 * @param dictName
	 *            字典名称
	 * @param modifyUserId
	 *            修改用户ID
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_DICT })
	Integer updateDictNameById(@Param("id") Integer id, @Param("dictName") String dictName,
			@Param("modifyUserId") Integer modifyUserId);

	/**
	 * 根据ID查询字典信息
	 * 
	 * <pre>
	 * 注：使用缓存查询数据
	 * </pre>
	 * 
	 * @param id
	 *            字典id
	 * @return 产品字典
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_DICT })
	ProductDict loadById(Integer id);

	/**
	 * 根据字典编码查询字典信息
	 * 
	 * <pre>
	 * 注：使用缓存查询数据
	 * </pre>
	 * 
	 * @param dictCode
	 *            字典编码
	 * @return 产品字典
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_DICT })
	ProductDict loadByDictCode(String dictCode);

	/**
	 * 根据字典名称模糊查询字典信息
	 * 
	 * <pre>
	 * 注：使用缓存查询数据
	 * </pre>
	 * 
	 * @param dictName
	 *            字典名称
	 * @return 产品字典列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_DICT })
	List<ProductDict> listByDictName(@Param("dictName") String dictName);

	/**
	 * 根据产品类别编码和字典类型查询字典信息
	 * 
	 * <pre>
	 * 注：使用缓存查询数据
	 * </pre>
	 * 
	 * @param productClass
	 *            产品类别编码， 取值可以为null
	 * @param dictType
	 *            地址类型， 取值可以为null
	 * @return 产品字典列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_DICT })
	List<ProductDict> list(@Param("productClass") String productClass, @Param("dictType") String dictType);

}