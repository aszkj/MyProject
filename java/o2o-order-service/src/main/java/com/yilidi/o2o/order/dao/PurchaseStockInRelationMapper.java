package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.PurchaseStockInRelation;

/**
 * 采购入库单关联信息数据层操作类
 * 
 * @author chenb
 * 
 */
public interface PurchaseStockInRelationMapper {

    /**
     * 保存采购入库单关联信息
     * 
     * @param record
     *            采购入库单关联信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_PURCHASE_STOCKIN_RELATION })
    Integer save(PurchaseStockInRelation record);

    /**
     * 根据条件查询采购入库单关联信息
     * 
     * @param purchaseOperType
     *            采购入库操作类型
     * @param purchaseOrderNo
     *            采购单号
     * @return 采购入库单关联信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_PURCHASE_STOCKIN_RELATION })
    List<PurchaseStockInRelation> listPurchaseStockInRelations(@Param("purchaseOperType") String purchaseOperType,
            @Param("purchaseOrderNo") String purchaseOrderNo);

}
