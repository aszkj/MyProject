package com.yilidi.o2o.order.dao;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.OrderConsigneeAddress;

/**
 * 功能描述：订单的收货地址数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface OrderConsigneeAddressMapper {

    /**
     * 保存订单的收货地址
     * 
     * @param record
     *            地址记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_ORDER_CONSIGNEE_ADDRESS })
    Integer save(OrderConsigneeAddress record);

    /**
     * 根据订单编号获取订单的地址
     * 
     * @param orderNo
     *            订单编号
     * @return 订单地址
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_ORDER_CONSIGNEE_ADDRESS })
    OrderConsigneeAddress loadByOrderNo(String orderNo);
}