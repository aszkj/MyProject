package com.yilidi.o2o.product.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.FloorProduct;
import com.yilidi.o2o.product.model.combination.FloorProductInfo;
import com.yilidi.o2o.product.model.combination.ProductRelatedInfo;

/**
 * 楼层与产品关联关系Mapper
 * 
 * @author: chenlian
 * @date: 2016年8月24日 下午5:24:52
 */
public interface FloorProductMapper {

    /**
     * 保存楼层与产品关联关系
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_FLOOR_PRODUCT })
    Integer save(FloorProduct record);

    /**
     * 根据id删除记录
     * 
     * @param id
     *            记录id
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_FLOOR_PRODUCT })
    Integer deleteById(Integer id);

    /**
     * 根据楼层ID删除记录
     * 
     * @param floorId
     *            楼层ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_FLOOR_PRODUCT })
    Integer deleteByFloorId(Integer floorId);

    /**
     * 根据id加载记录信息
     * 
     * @param id
     *            记录id
     * @return 楼层与产品关联关系记录
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_FLOOR_PRODUCT })
    FloorProduct loadById(Integer id);

    /**
     * 根据楼层ID获取其所关联的产品相关信息列表
     * 
     * @param floorId
     *            楼层ID
     * @return 楼层与产品关联关系列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_FLOOR_PRODUCT })
    List<FloorProduct> listByFloorId(Integer floorId);

    /**
     * 根据楼层查询信息获取其所关联的产品相关信息列表
     * 
     * @param floorProductInfo
     *            楼层与产品关联关系查询信息
     * @return 楼层ID所关联的产品相关信息列表
     */
    List<ProductRelatedInfo> listProductInfosByFloorId(FloorProductInfo floorProductInfo);

}