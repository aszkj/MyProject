package com.yilidi.o2o.order.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.PurchaseOrder;
import com.yilidi.o2o.order.model.query.PurchaseOrderQuery;

/**
 * 采购单数据层操作接口类
 * 
 * @author chenb
 * 
 */
public interface PurchaseOrderMapper {

    /**
     * 保存采购单信息
     * 
     * @param record
     *            采购单记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_PURCHASE_ORDER })
    Integer save(PurchaseOrder record);

    /**
     * 根据采购单号查询采购单信息
     * 
     * @param purchaseOrderNo
     *            采购单号
     * @return 采购订单信息对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_PURCHASE_ORDER })
    PurchaseOrder loadByPurchaseOrderNo(@Param("purchaseOrderNo") String purchaseOrderNo);

    /**
     * 根据采购单号查询调拨单信息 for update
     * 
     * @param purchaseOrderNo
     *            调拨单号
     * @return 采购订单信息对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_PURCHASE_ORDER })
    PurchaseOrder loadForUpdateByPurchaseOrderNo(@Param("purchaseOrderNo") String purchaseOrderNo);

    /**
     * 根据采购单号更新完成审核通过状态
     * 
     * @param purchaseOrderNo
     *            采购单号
     * @param oriOrderStauts
     *            未审核状态
     * @param auditPassOrderStatus
     *            审核通过状态
     * @param auditTime
     *            审核时间
     * @param auditUserId
     *            审核用户ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_PURCHASE_ORDER })
    Integer updateOrderStautsForAuditPassedByPurchaseOrderNo(@Param("purchaseOrderNo") String purchaseOrderNo,
            @Param("oriOrderStauts") String oriOrderStauts, @Param("auditPassOrderStatus") String auditPassOrderStatus,
            @Param("auditTime") Date auditTime, @Param("auditUserId") Integer auditUserId);

    /**
     * 根据采购单号更新完成审核不通过状态
     * 
     * @param purchaseOrderNo
     *            采购单号
     * @param oriOrderStauts
     *            未审核状态
     * @param auditNotPassOrderStatus
     *            审核通过状态
     * @param auditRejectReason
     *            审核不通过原因
     * @param auditTime
     *            审核时间
     * @param auditUserId
     *            审核用户ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_PURCHASE_ORDER })
    Integer updateOrderStautsForAuditNotPassedByPurchaseOrderNo(@Param("purchaseOrderNo") String purchaseOrderNo,
            @Param("oriOrderStauts") String oriOrderStauts, @Param("auditNotPassOrderStatus") String auditNotPassOrderStatus,
            @Param("auditRejectReason") String auditRejectReason, @Param("auditTime") Date auditTime,
            @Param("auditUserId") Integer auditUserId);

    /**
     * 根据条件查询采购单
     * 
     * @param purchaseOrderQuery
     *            查询条件对象
     * @return 采购单列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_PURCHASE_ORDER })
    Page<PurchaseOrder> findPurchaseOrderInfos(PurchaseOrderQuery purchaseOrderQuery);

    /**
     * 
     * 获取需要导出的采购的数量
     * 
     * @param purchaseOrderQuery
     *            查询条件对象
     * @return long 记录总数
     */
    Long getCountsForExportPurchaseOrder(PurchaseOrderQuery purchaseOrderQuery);
}
