package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.SaleStockInRelation;

/**
 * 订单入库单关联信息数据层操作类
 * 
 * @author simpson
 * 
 */
public interface SaleStockInRelationMapper {

    /**
     * 保存订单入库单关联信息
     * 
     * @param record
     *            订单入库单关联信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_SALE_ORDER_STOCKIN_RELATION })
    Integer save(SaleStockInRelation record);

    /**
     * 根据条件查询订单入库单关联信息
     * 
     * @param operType
     *            入库操作类型
     * @param saleOrderNo
     *            订单号
     * @return 订单入库单关联信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_SALE_ORDER_STOCKIN_RELATION })
    List<SaleStockInRelation> listSaleStockInRelations(@Param("operType") String operType,
            @Param("operType") String saleOrderNo);

}
