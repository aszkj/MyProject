package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.FlittingOrderHistory;

/**
 * 调拨单状态历史数据层操作类
 * 
 * @author simpson
 * 
 */
public interface FlittingOrderHistoryMapper {

    /**
     * 保存调拨单状态历史信息
     * 
     * @param record
     *            调拨单状态历史信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_ORDER_HISTORY })
    Integer save(FlittingOrderHistory record);

    /**
     * 根据条件查询调拨单状态历史信息
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return 调拨单状态历史列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_FLITTING_ORDER_HISTORY })
    List<FlittingOrderHistory> listFlittingOrderHistorys(String flittingOrderNo);

}
