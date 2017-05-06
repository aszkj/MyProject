package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ProductBrand;
import com.yilidi.o2o.product.model.SaleProductByBrandCode;
import com.yilidi.o2o.product.model.query.ProductBrandQuery;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;

/**
 * 功能描述：产品品牌数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductBrandMapper {

	/**
	 * 保存产品品牌信息
	 * 
	 * @param record
	 *            品牌信息对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_BRAND })
	Integer saveProductBrand(ProductBrand record);

	/**
	 * 根据品牌编码更新品牌名称
	 * 
	 * @param brandCode
	 *            品牌编码
	 * @param name
	 *            品牌名称
	 * @param modifyUserId
	 *            更新者id
	 * @param modifyTime
	 *            更新时间
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_BRAND })
	Integer updateBrandNameByBrandCode(@Param("brandCode") String brandCode, @Param("name") String name,
			@Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

	/**
	 * 根据品牌编码更新品牌状态
	 * 
	 * @param brandCode
	 *            品牌编码
	 * @param statusCode
	 *            状态
	 * @param modifyUserId
	 *            更新者id
	 * @param modifyTime
	 *            更新时间
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_BRAND })
	Integer updateStatusCodeByBrandCode(@Param("brandCode") String brandCode, @Param("statusCode") String statusCode,
			@Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

	/**
	 * 根据品牌ID更新品牌
	 * 
	 * @param record
	 *            品牌信息对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_BRAND })
	Integer updateProductBrandById(ProductBrand record);

	/**
	 * 根据品牌id查询品牌信息
	 * 
	 * @param id
	 *            品牌Id
	 * @return 品牌信息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_BRAND })
	ProductBrand loadProductBrandById(@Param("id") Integer id);

	/**
	 * 根据品牌编码查询品牌信息
	 * 
	 * @param brandCode
	 *            品牌编码
	 * @return 品牌信息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_BRAND })
	ProductBrand loadProductBrandByBrandCode(@Param("brandCode") String brandCode);

	/**
	 * 根据条件查询产品品牌相关信息列表
	 * 
	 * <pre>
	 * 注：使用缓存查询数据
	 * </pre>
	 * 
	 * @param record
	 *            产品品牌查询实体，
	 * @return 产品品牌基础信息列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_BRAND })
	Page<ProductBrand> findProductBrandInfos(ProductBrandQuery record);

	/**
	 * 查询所有的产品品牌信息列表
	 * 
	 * <pre>
	 * 注：使用缓存查询数据
	 * </pre>
	 * 
	 * @param productBrandQuery
	 * 
	 * @return 产品品牌信息列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_BRAND })
	List<ProductBrand> getProductBrands(ProductBrandQuery productBrandQuery);

	/**
	 * 
	 * @param saleProductQuery
	 * @return
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT,
			DBTablesName.Product.P_SALE_PRODUCT_PROFILE, DBTablesName.Product.P_PRODUCT_BRAND,
			DBTablesName.Product.P_PRODUCT_PRICE, DBTablesName.Product.P_PRODUCT_IMAGE })
	Page<SaleProductByBrandCode> findSaleProductByBrandCode(SaleProductQuery saleProductQuery);

	/**
	 * 根据用户名称加载用户对象
	 * @param brandName
	 * @return
	 */
	ProductBrand loadProductBrandByName(@Param("brandName") String brandName);
	
	 /**
     * 获取所有品牌（通用）
     * 
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_BRAND })
    List<ProductBrand> getAllBrandBasic();

    /**
     * 根据品牌名称获取品牌
     * 
     * @param brandName
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_BRAND })
    ProductBrand getBrandByName(@Param("brandName") String brandName);

    /**
     * 根据品牌code获取品牌
     * 
     * @param brandName
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_BRAND })
    ProductBrand getBrandByCode(@Param("brandCode") String brandCode);
}