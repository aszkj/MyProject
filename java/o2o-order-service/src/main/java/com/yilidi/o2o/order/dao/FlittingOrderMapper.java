package com.yilidi.o2o.order.dao;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.FlittingOrder;
import com.yilidi.o2o.order.model.query.FlittingOrderQuery;

/**
 * 调拨单数据层操作接口类
 * 
 * @author simpson
 * 
 */
public interface FlittingOrderMapper {

    /**
     * 保存调拨单信息
     * 
     * @param record
     *            调拨单记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_ORDER })
    Integer save(FlittingOrder record);

    /**
     * 根据调拨单号更新接收状态
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param oriAcceptStatus
     *            原接收状态
     * @param flittingOrder
     *            调拨单信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_ORDER })
    Integer updateAcceptStautsByFlittingOrderNo(@Param("flittingOrderNo") String flittingOrderNo,
            @Param("oriAcceptStatus") String oriAcceptStatus, @Param("flittingOrder") FlittingOrder flittingOrder);

    /**
     * 根据调拨单号更新发货状态
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param oriSendStatus
     *            原发货状态
     * @param oriAcceptStatus
     *            原接收状态
     * @param flittingOrder
     *            调拨单信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_ORDER })
    Integer updateSendStautsByFlittingOrderNo(@Param("flittingOrderNo") String flittingOrderNo,
            @Param("oriSendStatus") String oriSendStatus, @Param("oriAcceptStatus") String oriAcceptStatus,
            @Param("flittingOrder") FlittingOrder flittingOrder);

    /**
     * 根据调拨单号更新验货状态
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param oriCheckStatus
     *            原验货状态
     * @param oriSendStatus
     *            原发货状态
     * @param flittingOrder
     *            调拨单信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_ORDER })
    Integer updateCheckStautsByFlittingOrderNo(@Param("flittingOrderNo") String flittingOrderNo,
            @Param("oriCheckStatus") String oriCheckStatus, @Param("oriSendStatus") String oriSendStatus,
            @Param("flittingOrder") FlittingOrder flittingOrder);

    /**
     * 更新调拨单实际调拨数量、金额和更新验货状态
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param oriCheckStatus
     *            原验货状态
     * @param oriSendStatus
     *            原发货状态
     * @param flittingOrder
     *            调拨单信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_ORDER })
    Integer updateCheckedByFlittingOrderNo(@Param("flittingOrderNo") String flittingOrderNo,
            @Param("oriCheckStatus") String oriCheckStatus, @Param("oriSendStatus") String oriSendStatus,
            @Param("flittingOrder") FlittingOrder flittingOrder);

    /**
     * 根据调拨单号更新完成审核状态
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param oriAuditStatus
     *            原完成审核状态
     * @param oriCheckStatus
     *            原验货状态
     * @param flittingOrder
     *            调拨单信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_ORDER })
    Integer updateAuditStautsByFlittingOrderNo(@Param("flittingOrderNo") String flittingOrderNo,
            @Param("oriAuditStatus") String oriAuditStatus, @Param("oriCheckStatus") String oriCheckStatus,
            @Param("flittingOrder") FlittingOrder flittingOrder);

    /**
     * 根据调拨单号查询调拨单信息
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return 订单信息对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_FLITTING_ORDER })
    FlittingOrder loadByFlittingOrderNo(String flittingOrderNo);

    /**
     * 根据调拨单号查询调拨单信息 for update
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return 订单信息对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_FLITTING_ORDER })
    FlittingOrder loadForUpdateByFlittingOrderNo(String flittingOrderNo);

    /**
     * 根据条件查询调拨单
     * 
     * @param query
     *            查询条件对象
     * @return 调拨单列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_FLITTING_ORDER })
    Page<FlittingOrder> findFlittingOrderInfos(FlittingOrderQuery query);

}
