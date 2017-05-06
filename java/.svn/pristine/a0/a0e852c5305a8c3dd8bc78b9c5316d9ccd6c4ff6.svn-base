package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.FlittingStockOutRelation;

/**
 * 调拨出库单关联信息数据层操作类
 * 
 * @author simpson
 * 
 */
public interface FlittingStockOutRelationMapper {

    /**
     * 保存调拨出库单关联信息
     * 
     * @param record
     *            调拨出库单关联信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_STOCKOUT_RELATION })
    Integer save(FlittingStockOutRelation record);

    /**
     * 根据条件查询调拨出库单关联信息
     * 
     * @param flittingOperType
     *            调拨出库操作类型
     * @param flittingOrderNo
     *            调拨单编号
     * @return 调拨出库单关联信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_FLITTING_STOCKOUT_RELATION })
    List<FlittingStockOutRelation> listFlittingStockOutRelations(@Param("flittingOperType") String flittingOperType,
            @Param("flittingOrderNo") String flittingOrderNo);

}
