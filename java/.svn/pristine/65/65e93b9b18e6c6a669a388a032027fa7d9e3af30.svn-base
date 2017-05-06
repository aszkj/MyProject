package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.PurchaseOrderItem;

/**
 * 采购单明细数据层操作类
 * 
 * @author chenb
 * 
 */
public interface PurchaseOrderItemMapper {

    /**
     * 保存采购单明细信息
     * 
     * @param record
     *            采购单明细信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_PURCHASE_ORDER_ITEM })
    Integer save(PurchaseOrderItem record);

    /**
     * 根据条件查询采购单明细信息，根据PRODUCTID升序返回
     * 
     * @param purchaseOrderNo
     *            采购单号
     * @return 采购单明细列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_PURCHASE_ORDER_ITEM })
    List<PurchaseOrderItem> listPurchaseOrderItems(String purchaseOrderNo);

}
