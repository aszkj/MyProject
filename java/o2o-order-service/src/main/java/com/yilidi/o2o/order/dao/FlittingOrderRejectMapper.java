package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.FlittingOrderReject;

/**
 * 调拨单数量变更变化数据层操作类
 * 
 * @author simpson
 * 
 */
public interface FlittingOrderRejectMapper {

    /**
     * 保存调拨单数量变更变化信息
     * 
     * @param record
     *            调拨单数量变更变化信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_ORDER_REJECT })
    Integer save(FlittingOrderReject record);

    /**
     * 根据条件查询调拨单数量变更变化信息
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return 调拨单数量变更变化信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_FLITTING_ORDER_REJECT })
    List<FlittingOrderReject> listFlittingOrderRejects(String flittingOrderNo);

}
