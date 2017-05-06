package com.yilidi.o2o.product.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SaleZone;
import com.yilidi.o2o.product.model.combination.ProductRelatedInfo;
import com.yilidi.o2o.product.model.combination.SaleZoneProductInfo;

/**
 * 专区（专题与产品关联）Mapper
 * 
 * @author: chenlian
 * @date: 2016年8月22日 上午9:42:25
 */
public interface SaleZoneMapper {

    /**
     * 保存配置信息
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_ZONE })
    Integer save(SaleZone record);

    /**
     * 根据id删除记录
     * 
     * @param id
     *            记录id
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_ZONE })
    Integer deleteById(Integer id);

    /**
     * 根据专区类型编码删除记录
     * 
     * @param typeCode
     *            专区类型编码
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_ZONE })
    Integer deleteByTypeCode(String typeCode);

    /**
     * 根据id更新专区配置信息（如果字段值为null，则不更新该字段）
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_ZONE })
    Integer updateByIdSelective(SaleZone record);

    /**
     * 根据id加载记录信息
     * 
     * @param id
     *            记录id
     * @return 专区配置记录
     */
    // @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_ZONE })
    SaleZone loadById(Integer id);

    /**
     * 根据专区类型编码加载
     * 
     * @param typeCode
     *            专区类型编码
     * @return 专区配置列表
     */
    // @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_ZONE })
    List<SaleZone> listByTypeCode(String typeCode);

    /**
     * 根据专区产品查询信息获取其所关联的产品相关信息列表
     * 
     * @param saleZoneProductInfo
     *            专区产品查询信息
     * @return 专区类型编码所关联的产品相关信息列表
     */
    List<ProductRelatedInfo> listProductInfosByThemeTypeCode(SaleZoneProductInfo saleZoneProductInfo);

}