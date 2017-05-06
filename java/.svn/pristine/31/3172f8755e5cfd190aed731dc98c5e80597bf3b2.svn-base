package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ProductClass;
import com.yilidi.o2o.product.service.dto.query.ProductClassQuery;

/**
 * 功能描述：产品类别数据层操作接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductClassMapper {

    /**
     * 保存产品类别
     * 
     * @param record
     *            产品类别对象
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    Integer saveProductClass(ProductClass record);

    /**
     * 删除产品类别
     * 
     * @param id
     *            产品类别ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    Integer deleteProductClassById(@Param("id") Integer id);

    /**
     * 根据产品类别编码更新产品类别名称
     * 
     * @param record
     *            产品类别对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    Integer updateProductClassByClassCode(ProductClass record);

    /**
     * 根据产品类别编码更新产品类别名称
     * 
     * @param record
     *            产品类别对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    Integer updateClassNameByClassCode(ProductClass record);

    /**
     * 根据产品类别编码更新产品类别状态
     * 
     * @param statusCode
     *            产品类别状态
     * @param classCode
     *            产品类别编码classCode
     * @param modifyUserId
     *            产品类别modifyUserId
     * @param modifyTime
     *            产品类别modifyTime
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    Integer updateStatusCodeById(@Param("statusCode") String statusCode, @Param("classCode") String classCode,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 根据类别编码更新类别状态
     * 
     * @param record
     *            产品类别对象
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    Integer updateStatusCodeByClassCode(ProductClass record);

    /**
     * 根据产品类别编码查询产品类别
     * 
     * @param classCode
     *            类别编码
     * @param statusCode
     *            状态编码
     * @return 类别对象信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    ProductClass loadProductClassByClassCode(@Param("classCode") String classCode, @Param("statusCode") String statusCode);

    /**
     * 根据产品类别Id查询产品类别
     * 
     * @param id
     *            类别Id
     * @return 类别对象信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    ProductClass loadProductClassById(@Param("id") Integer id);

    /**
     * 根据产品类别编码查询产品类别
     * 
     * @param className
     *            类别名称
     * @param classLevel
     *            类别级别
     * @param statusCode
     *            是否有效
     * @return 类别对象信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    ProductClass loadProductClassByClassName(@Param("className") String className);

    /**
     * 根据状态查询所有的产品类别（如果状态为null，则获取所有的记录）
     * 
     * @param queryProductClass
     *            类别查询实体
     * @return 类别列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    List<ProductClass> listProductClass(ProductClassQuery queryProductClass);

    /**
     * 根据条件查询所有的产品类别（如果状态为null，则获取所有的记录）
     * 
     * @param queryProductClass
     *            类别查询实体
     * @return 类别列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    Page<ProductClass> findProductClass(ProductClassQuery queryProductClass);

    /**
     * 根据产品类别编码查询其子产品类别
     * 
     * @param classLevel
     *            类别级别
     * @param statusCode
     *            是否有效
     * @return 类别列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    List<ProductClass> getProClassBasic(@Param("classLevel") String classLevel, @Param("statusCode") String statusCode);

    /**
     * 根据code列表查找商品类别名称列表
     * 
     * @param codesList
     *            类别编码列表
     * @return 类别名称列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    List<String> listProductClassNamesByCodes(@Param("codesList") List<String> codesList);

    /**
     * 根据code列表和状态查找商品类别列表
     * 
     * @param codesList
     *            类别编码列表
     * @param statusCode
     *            分类状态
     * @param display
     *            是否显示
     * @return 类别列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    List<ProductClass> listProductClassByClassCodesAndStatus(@Param("codesList") List<String> codesList,
            @Param("statusCode") String statusCode, @Param("display") String display);

    /**
     * 根据店铺类型状态查找产品基础分类
     * 
     * @param storeType
     *            店铺类型
     * @param statusCode
     *            分类状态
     * @param display
     *            是否显示
     * @return List<ProductClass>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS,
            DBTablesName.Product.P_STORE_TYPE_PRODUCT_CLASS })
    List<ProductClass> listProductClassByStoreType(@Param("storeType") String storeType,
            @Param("statusCode") String statusCode, @Param("display") String display);

    /**
     * 根据子类ClassCode列表获取父类ClassCode列表
     * 
     * @param codesList
     *            产品分类编码列表
     * @param statusCode
     *            产品分类状态
     * @param display
     *            是否显示
     * @return List<ProductClass>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS,
            DBTablesName.Product.P_PRODUCT_CLASS_MAPPING })
    List<ProductClass> listParentClassByChildClassCodes(@Param("codesList") List<String> codesList,
            @Param("statusCode") String statusCode, @Param("display") String display);

    /**
     * 根据上级classCode查下级分类list
     * 
     * @param productClassQuery
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS,
            DBTablesName.Product.P_PRODUCT_CLASS_MAPPING })
    List<ProductClass> getAllNextProductClassByUpCode(ProductClassQuery productClassQuery);

    /**
     * 根据下级classCode查上级分类
     * 
     * @param classCode
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS,
            DBTablesName.Product.P_PRODUCT_CLASS_MAPPING })
    ProductClass getUpProductClassByClassCode(@Param("classCode") String classCode);

}