package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ProductClassStoreType;
import com.yilidi.o2o.product.model.combination.ProductClassStoreTypeRelatedInfo;

/**
 * 功能描述：产品类别与店铺类型映射关系数据层操作接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductClassMapStoreTypeMapper {
    /**
     * 保存产品类别店铺类型映射关系
     * 
     * @param productClassStoreTypeList
     *            产品类别映射店铺list
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_STORE_TYPE_PRODUCT_CLASS })
    public void saveProductClassStoreType(
            @Param("productClassStoreTypeList") List<ProductClassStoreType> productClassStoreTypeList);

    /**
     * 根据前台传过来的产品类别店铺类型映射ID删除产品类别店铺类型映射信息*
     * 
     * @param storeType
     *            要产品类别映射店铺ids的list
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_STORE_TYPE_PRODUCT_CLASS })
    public void deleteAllProductClassStoreType(@Param("storeType") String storeType);

    /**
     * 查询产品类别与店铺类型的映射关系列表
     * 
     * @param storeType
     *            店铺类型storeType
     * @param statusCode
     *            店铺商品类别状态
     * @return List<ProductClassStoreTypeRelatedInfo> 产品类别与店铺类型的映射关系列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_STORE_TYPE_PRODUCT_CLASS })
    public List<ProductClassStoreTypeRelatedInfo> listBasicClassStoreType(@Param("storeType") String storeType,
            @Param("statusCode") String statusCode);

}