package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.FlittingStockInRelation;

/**
 * 调拨入库单关联信息数据层操作类
 * 
 * @author simpson
 * 
 */
public interface FlittingStockInRelationMapper {

    /**
     * 保存调拨入库单关联信息
     * 
     * @param record
     *            调拨入库单关联信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_STOCKIN_RELATION })
    Integer save(FlittingStockInRelation record);

    /**
     * 根据条件查询调拨入库单关联信息
     * 
     * @param flittingOperType
     *            调拨入库操作类型
     * @param flittingOrderNo
     *            调拨单号
     * @return 调拨入库单关联信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_FLITTING_STOCKIN_RELATION })
    List<FlittingStockInRelation> listFlittingStockInRelations(@Param("flittingOperType") String flittingOperType,
            @Param("flittingOrderNo") String flittingOrderNo);

}
