package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.Floor;

/**
 * 楼层Mapper
 * 
 * @author: chenlian
 * @date: 2016年8月24日 下午2:24:52
 */
public interface FloorMapper {

    /**
     * 新增楼层信息
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_FLOOR })
    Integer save(Floor record);

    /**
     * 根据id更新楼层信息（如果字段值为null，则不更新该字段）
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_FLOOR })
    Integer updateByIdSelective(Floor record);

    /**
     * 根据id加载楼层信息
     * 
     * @param id
     *            记录id
     * @return 楼层信息记录
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_FLOOR })
    Floor loadById(@Param("id") Integer id);

    /**
     * 获取楼层信息列表
     * 
     * @return 楼层信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_FLOOR })
    List<Floor> listFloors();

}