package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ProductClassMapping;
import com.yilidi.o2o.product.model.combination.ProductClassMappingRelatedInfo;

/**
 * 功能描述：产品类别与店铺类型映射关系数据层操作接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductClassMappingMapper {
    /**
     * 根据前台传过来的productClassStoreTypeDto保存一级产品类别与基础产品类别的映射关系
     * 
     * @param productClassMappingList
     *            产品类别映射基础类别
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_CLASS_MAPPING })
    void saveProductClassMapping(@Param("productClassMappingList") List<ProductClassMapping> productClassMappingList);

    /**
     * 根据前台传过来的一级产品类别与基础产品类别的映射删除产品类别信息*
     * 
     * @param classCode
     *            一级产品类别的classCode
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_CLASS_MAPPING })
    void deleteAllProductClassMapping(@Param("classCode") String classCode);

    /**
     * 查询一级产品类别与基础产品类别的映射列表
     * 
     * @param classCode
     *            一级产品类别编码
     * @param statusCode
     *            产品基础类别编码状态
     * @return List<ProductClassMappingRelatedInfo> 一级产品类别与基础产品类别的映射列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS_MAPPING })
    List<ProductClassMappingRelatedInfo> listProductClassMapping(@Param("classCode") String classCode,
            @Param("statusCode") String statusCode);

    /**
     * 根据父类查询子类列表
     * 
     * @param classCode
     *            商品父类
     * @return List<ProductClassMapping>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS_MAPPING })
    List<ProductClassMapping> listByClassCode(@Param("classCode") String classCode);

}