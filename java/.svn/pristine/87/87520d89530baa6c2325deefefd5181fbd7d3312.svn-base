package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.Product;
import com.yilidi.o2o.product.model.combination.ProductRelatedInfo;
import com.yilidi.o2o.product.service.dto.query.ProductQuery;

/**
 * 功能描述：产品数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductMapper {

    /**
     * 保存产品基础信息(需要提供除外的所有信息)
     * 
     * @param record
     *            产品记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT })
    Integer saveProductBasicInfo(Product record);

    /**
     * 更新产品基础信息
     * 
     * @param record
     *            产品记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT })
    Integer updateProductBasicInfoById(Product record);

    /**
     * 更新产品基础信息（如果字段值为null，则不更新该字段）
     * 
     * @param record
     *            产品记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT })
    Integer updateProductBasicInfoByIdSelective(Product record);

    /**
     * 根据id更新产品的状态
     * 
     * @param id
     *            产品id
     * @param statusCode
     *            状态编码
     * @param modifyUserId
     *            更新者id
     * @param modifyTime
     *            更新时间
     * @return 影响 的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT })
    Integer updateStatusCodeById(@Param("id") Integer id, @Param("statusCode") String statusCode,
            @Param("modifyTime") Date modifyTime, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 根据id更新产品类别
     * 
     * @param id
     *            产品id
     * @param productClassCode
     *            产品类别编码
     * @param modifyUserId
     *            更新者id
     * @param modifyTime
     *            更新时间
     * @return 影响 的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT })
    Integer updateProductClassById(@Param("id") Integer id, @Param("productClassCode") String productClassCode,
            @Param("modifyTime") Date modifyTime, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 根据id查询产品基础信息
     * 
     * @param id
     *            产品id
     * @return 产品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT })
    Product loadProductBasicInfoById(@Param("id") Integer id);

    /**
     * 根据条形码查询产品基础信息
     * 
     * @param barCode
     *            产品条形码
     * @return 产品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT })
    Product loadProductBasicInfoByBarCode(@Param("barCode") String barCode);

    /**
     * 根据产品类别编码、品牌编码、产品名称查询产品基础信息
     * 
     * @param productClassCode
     *            产品类别编码
     * @param brandCode
     *            产品品牌编码
     * @param productName
     *            产品名称
     * @return 产品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT })
    Product loadProductsBasicInfo(@Param("productClassCode") String productClassCode, @Param("brandCode") String brandCode,
            @Param("productName") String productName);

    /**
     * 根据条件查询产品基础信息列表
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param record
     *            产品查询实体，
     * @return 产品列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT,
            DBTablesName.Product.P_PRODUCT_PROFILE, DBTablesName.Product.P_PRODUCT_PRICE })
    Page<Product> findProductsByBasicInfo(ProductQuery record);

    /**
     * 查询所有的产品基础信息列表
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @return 产品基础信息列表
     */
    // @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT })
    List<Product> getProductBasicInfos();

    /**
     * 根据产品列别查询产品基础信息列表
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param classCodeList
     *            产品类别列表
     * @param statusCode
     *            产品状态 是否有效
     * @return 产品基础信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT })
    List<Product> listProductBasicInfosByClassCode(@Param("classCodeList") List<String> classCodeList,
            @Param("statusCode") String statusCode);

    /**
     * 根据条件查询产品相关信息列表
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param record
     *            产品查询实体，
     * @return 产品基础信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT,
            DBTablesName.Product.P_PRODUCT_PROFILE, DBTablesName.Product.P_PRODUCT_IMAGE,
            DBTablesName.Product.P_PRODUCT_PRICE, DBTablesName.Product.P_PRODUCT_CLASS })
    Page<ProductRelatedInfo> findProductRelativeInfos(ProductQuery record);

    /**
     * 根据条件查询可以添加到指定店铺类型的产品相关信息列表
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param classCodeList
     *            产品类别List，
     * @param record
     *            产品查询实体，
     * @return 产品基础信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT,
            DBTablesName.Product.P_PRODUCT_PROFILE, DBTablesName.Product.P_PRODUCT_IMAGE,
            DBTablesName.Product.P_PRODUCT_PRICE, DBTablesName.Product.P_PRODUCT_CLASS, DBTablesName.Product.P_SALE_PRODUCT })
    Page<ProductRelatedInfo> findProductRelativeInfosByStoreType(@Param("storeId") Integer storeId,
            @Param("classCodeList") List<String> classCodeList, @Param("productQuery") ProductQuery record);

    /**
     * 
     * 获取需要导出的产品的数量
     * 
     * @param productQuery
     *            产品查询实体
     * @return long 产品数量
     */
    Long getCountsForExportProduct(ProductQuery productQuery);

    /**
     * 
     * 获取需要导出的产品列表
     * 
     * @param productQuery
     *            产品查询实体
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            每页大小
     * @return List<Product> 产品列表
     */
    List<ProductRelatedInfo> listDataForExportProduct(@Param("productQuery") ProductQuery productQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 查询所有产品的条形码
     * 
     * @return List<String> 产品条形码列表
     */
    Set<String> getProductBarCode();

    /**
     * 
     * 查询指定产品类别的所有产品的条形码
     * 
     * @param classCodeList
     *            产品类别list
     * @return List<String> 产品条形码列表
     */
    Set<String> getProductBarCodeByClassCode(@Param("classCodeList") List<String> classCodeList);

    /**
     * 根据id和状态查询产品基础信息
     * 
     * @param id
     *            产品id
     * @param statusCode
     *            产品状态
     * @return 产品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT })
    Product loadProductBasicInfoByIdAndStatusCode(@Param("id") Integer id, @Param("statusCode") String statusCode);

}