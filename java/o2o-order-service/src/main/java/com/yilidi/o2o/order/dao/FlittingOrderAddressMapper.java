package com.yilidi.o2o.order.dao;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.FlittingOrderAddress;

/**
 * 调拨单收货地址信息数据层操作类
 * 
 * @author simpson
 * 
 */
public interface FlittingOrderAddressMapper {

    /**
     * 保存调拨单收货地址信息
     * 
     * @param record
     *            调拨单收货地址信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_FLITTING_ORDER_ADDRESS })
    Integer save(FlittingOrderAddress record);

    /**
     * 根据条件查询调拨单收货地址信息
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return 调拨单收货地址信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_FLITTING_ORDER_ADDRESS })
    FlittingOrderAddress loadByFlittingOrderNo(String flittingOrderNo);

}
