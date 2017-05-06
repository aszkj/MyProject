package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.alibaba.dubbo.config.support.Parameter;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.PurchaseOrderAddress;
import com.yilidi.o2o.order.model.query.PurchaseOrderAddressQuery;

/**
 * 采购单收货地址信息数据层操作类
 * 
 * @author chenb
 * 
 */
public interface PurchaseOrderAddressMapper {

    /**
     * 保存采购单收货地址信息
     * 
     * @param record
     *            采购单收货地址信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_PURCHASE_ORDER_ADDRESS })
    Integer save(PurchaseOrderAddress record);

    /**
     * 根据条件查询采购单收货地址信息
     * 
     * @param purhcaseOrderNo
     *            采购单号
     * @return 采购单收货地址信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_PURCHASE_ORDER_ADDRESS })
    PurchaseOrderAddress loadByPurchaseOrderNo(@Param("purchaseOrderNo") String purhcaseOrderNo);

    /**
     * 根据查询条件查询收货地址列表
     * 
     * @param purchaseOrderAddressQuery
     *            查询条件
     * @return 收货地址列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_PURCHASE_ORDER_ADDRESS })
    List<PurchaseOrderAddress> listPurchaseOrderAddress(PurchaseOrderAddressQuery purchaseOrderAddressQuery);

}
