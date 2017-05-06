package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.PurchaseOrderHistory;

/**
 * 采购单状态历史数据层操作类
 * 
 * @author chenb
 * 
 */
public interface PurchaseOrderHistoryMapper {

    /**
     * 保存采购单状态历史信息
     * 
     * @param record
     *            采购单状态历史信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_PURCHASE_ORDER_HISTORY })
    Integer save(PurchaseOrderHistory record);

    /**
     * 根据条件查询采购单状态历史信息
     * 
     * @param purchaseOrderNo
     *            采购单号
     * @return 采购单状态历史列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_PURCHASE_ORDER_HISTORY })
    List<PurchaseOrderHistory> listPurchaseOrderHistorys(String purchaseOrderNo);

}
