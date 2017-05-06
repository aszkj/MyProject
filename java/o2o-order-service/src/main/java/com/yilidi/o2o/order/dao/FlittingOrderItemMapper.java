package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.FlittingOrderItem;

/**
 * 调拨单明细数据层操作类
 * 
 * @author simpson
 * 
 */
public interface FlittingOrderItemMapper {

    /**
     * 保存调拨单明细信息
     * 
     * @param record
     *            调拨单明细信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_ORDER_ITEM })
    Integer save(FlittingOrderItem record);

    /**
     * 根据调拨单号更新接收和拒绝数量
     * 
     * @param flittingOrderItem
     *            调拨单明细
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_ORDER_ITEM })
    Integer updateReceiveQuantityByFlittingOrderItemId(FlittingOrderItem flittingOrderItem);

    /**
     * 根据条件查询调拨单明细信息，根据PRODUCTID升序返回
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return 调拨单明细列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_FLITTING_ORDER_ITEM })
    List<FlittingOrderItem> listFlittingOrderItems(String flittingOrderNo);

    /**
     * 根据条件查询调拨单明细信息
     * 
     * @param flittingOrderItemId
     *            调拨明细ID
     * @return 调拨单明细信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_FLITTING_ORDER_ITEM })
    FlittingOrderItem loadById(@Param("flittingOrderItemId") Integer flittingOrderItemId);
}
