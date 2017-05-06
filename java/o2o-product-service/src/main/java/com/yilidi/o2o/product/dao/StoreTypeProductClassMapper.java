package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.StoreTypeProductClass;

/**
 * 店铺类型与产品类别关系映射表
 * 
 * @author: chenb
 * @date: 2016年6月17日 上午9:55:37
 */
public interface StoreTypeProductClassMapper {

    /**
     * 保存店铺类型与产品类别关系
     * 
     * @param record
     *            店铺类型与产品类别关系
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_STORE_TYPE_PRODUCT_CLASS })
    Integer save(StoreTypeProductClass record);

    /**
     * 
     * 根据ID删除
     * 
     * @param id
     *            主键ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_STORE_TYPE_PRODUCT_CLASS })
    Integer deleteById(Integer id);

    /**
     * 根据店铺类型和产品分类code查找
     * 
     * @param storeType
     *            店铺类型
     * @param classCode
     *            产品一级分类
     * @return 店铺产品分类信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_STORE_TYPE_PRODUCT_CLASS })
    StoreTypeProductClass loadStoreProductClassByStoreTypeAndClassCode(@Param("storeType") String storeType,
            @Param("classCode") String classCode);

    /**
     * 根据店铺类型查找商品基础分类列表
     * 
     * @param storeType
     *            店铺类型
     * @return 商品基础分类列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_STORE_TYPE_PRODUCT_CLASS })
    List<StoreTypeProductClass> listStoreProductsByStoreType(@Param("storeType") String storeType);

    /**
     * 根据产品分类Code列表获取店铺与产品分类关联关系列表
     * 
     * @param codesList
     * @return List<StoreTypeProductClass>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_STORE_TYPE_PRODUCT_CLASS })
    List<StoreTypeProductClass> listStoreProductClassesByClassCodes(@Param("codesList") List<String> codesList);

}