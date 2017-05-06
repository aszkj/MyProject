package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.StockOutOrderHistory;

/**
 * 出库单状态历史数据层操作类
 * 
 * @author chenb
 * 
 */
public interface StockOutOrderHistoryMapper {

    /**
     * 保存出库单状态历史信息
     * 
     * @param record
     *            出库单状态历史信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_STOCKOUT_ORDER_HISTORY })
    Integer save(StockOutOrderHistory record);

    /**
     * 根据条件查询出库单状态历史信息
     * 
     * @param stockOutOrderNo
     *            出库单号
     * @return 出库单状态历史列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_STOCKOUT_ORDER_HISTORY })
    List<StockOutOrderHistory> listStockOutOrderHistorys(String stockOutOrderNo);

}
