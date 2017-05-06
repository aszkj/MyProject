package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.FlittingOrderItemHistory;

/**
 * 调拨单明细历史变化数据层操作类
 * 
 * @author simpson
 * 
 */
public interface FlittingOrderItemHistoryMapper {

    /**
     * 保存调拨单数量变更变化信息
     * 
     * @param record
     *            调拨单数量变更变化明细信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_ORDER_ITEM_HISTORY })
    Integer save(FlittingOrderItemHistory record);

    /**
     * 根据条件查询调拨单数量变更变化明细信息
     * 
     * @param flittingOrderRejectId
     *            调拨单变化记录ID
     * @return 调拨单数量变更变化明细信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_FLITTING_ORDER_ITEM_HISTORY })
    List<FlittingOrderItemHistory> listFlittingOrderItemHistorys(Integer flittingOrderRejectId);

}
