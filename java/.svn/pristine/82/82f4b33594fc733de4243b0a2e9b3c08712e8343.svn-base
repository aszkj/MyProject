package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.FloorAdvertisementType;

/**
 * 楼层与广告类型关联关系Mapper
 * 
 * @author: chenlian
 * @date: 2016年8月25日 上午11:15:36
 */
public interface FloorAdvertisementTypeMapper {

    /**
     * 新增楼层与广告类型关联关系
     * 
     * @param recommendCustomerStore
     *            楼层与广告类型关联关系
     * @return Integer 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_FLOOR_ADVERTISEMENTTYPE })
    Integer save(FloorAdvertisementType floorAdvertisementType);

    /**
     * 根据楼层ID删除楼层与广告类型关联关系
     * 
     * @param floorId
     *            楼层ID
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_FLOOR_ADVERTISEMENTTYPE })
    void deleteByFloorId(@Param("floorId") Integer floorId);

    /**
     * 根据广告类型编码获取该店铺所关联的所有楼层ID列表
     * 
     * @param advertisementTypeCode
     *            广告类型编码
     * @return List<Integer> 楼层ID列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_FLOOR_ADVERTISEMENTTYPE })
    List<Integer> listFloorIdsByAdvertisementTypeCode(@Param("advertisementTypeCode") String advertisementTypeCode);

    /**
     * 根据楼层ID获取该楼层所关联的广告类型编码
     * 
     * @param floorId
     *            楼层ID
     * @return String 广告类型编码
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_FLOOR_ADVERTISEMENTTYPE })
    String loadAdvertisementTypeCodeByFloorId(@Param("floorId") Integer floorId);

}
