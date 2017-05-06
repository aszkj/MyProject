package com.yilidi.o2o.order.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.StockOutOrder;
import com.yilidi.o2o.order.model.query.StockOutOrderQuery;

/**
 * 出库单数据层操作接口类
 * 
 * @author chenb
 * 
 */
public interface StockOutOrderMapper {

    /**
     * 保存出库单信息
     * 
     * @param record
     *            出库单记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_STOCKOUT_ORDER })
    Integer save(StockOutOrder record);

    /**
     * 根据出库单号查询出库单信息
     * 
     * @param stockOutOrderNo
     *            出库单号
     * @return 出库订单信息对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_STOCKOUT_ORDER })
    StockOutOrder loadByStockOutOrderNo(@Param("stockOutOrderNo") String stockOutOrderNo);

    /**
     * 根据出库单号查询出库单信息 for update
     * 
     * @param stockOutOrderNo
     *            出库单号
     * @return 出库订单信息对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_STOCKOUT_ORDER })
    StockOutOrder loadForUpdateByStockOutOrderNo(@Param("stockOutOrderNo") String stockOutOrderNo);

    /**
     * 根据出库单号更新完成审核通过状态
     * 
     * @param stockOutOrderNo
     *            出库单号
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
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_STOCKOUT_ORDER })
    Integer updateOrderStautsForAuditPassedByStockOutOrderNo(@Param("stockOutOrderNo") String stockOutOrderNo,
            @Param("oriOrderStauts") String oriOrderStauts, @Param("auditPassOrderStatus") String auditPassOrderStatus,
            @Param("auditTime") Date auditTime, @Param("auditUserId") Integer auditUserId);

    /**
     * 根据出库单号更新完成审核不通过状态
     * 
     * @param stockOutOrderNo
     *            出库单号
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
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_STOCKOUT_ORDER })
    Integer updateOrderStautsForAuditNotPassedByStockOutOrderNo(@Param("stockOutOrderNo") String stockOutOrderNo,
            @Param("oriOrderStauts") String oriOrderStauts, @Param("auditNotPassOrderStatus") String auditNotPassOrderStatus,
            @Param("auditRejectReason") String auditRejectReason, @Param("auditTime") Date auditTime,
            @Param("auditUserId") Integer auditUserId);

    /**
     * 根据条件查询出库单
     * 
     * @param stockOutOrderQuery
     *            查询条件对象
     * @return 出库单列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_STOCKOUT_ORDER })
    Page<StockOutOrder> findStockOutOrderInfos(StockOutOrderQuery stockOutOrderQuery);

    /**
     * 
     * 获取需要导出的出库的数量
     * 
     * @param stockOutOrderQuery
     *            查询条件对象
     * @return long 记录总数
     */
    Long getCountsForExportStockOutOrder(StockOutOrderQuery stockOutOrderQuery);
}
