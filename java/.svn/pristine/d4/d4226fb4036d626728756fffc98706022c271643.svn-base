package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.StockOutOrderItem;

/**
 * 出库单明细数据层操作类
 * 
 * @author chenb
 * 
 */
public interface StockOutOrderItemMapper {

    /**
     * 保存出库单明细信息
     * 
     * @param record
     *            出库单明细信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_STOCKOUT_ORDER_ITEM })
    Integer save(StockOutOrderItem record);

    /**
     * 根据条件查询出库单明细信息，根据PRODUCTID升序返回
     * 
     * @param stockOutOrderNo
     *            出库单号
     * @return 出库单明细列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_STOCKOUT_ORDER_ITEM })
    List<StockOutOrderItem> listStockOutOrderItems(String stockOutOrderNo);

}
