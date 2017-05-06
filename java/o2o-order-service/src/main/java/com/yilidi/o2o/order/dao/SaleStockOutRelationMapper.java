package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.SaleStockOutRelation;

/**
 * 订单出库单关联信息数据层操作类
 * 
 * @author simpson
 * 
 */
public interface SaleStockOutRelationMapper {

    /**
     * 保存订单出库单关联信息
     * 
     * @param record
     *            订单出库单关联信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_SALE_ORDER_STOCKOUT_RELATION })
    Integer save(SaleStockOutRelation record);

    /**
     * 根据条件查询订单出库单关联信息
     * 
     * @param operType
     *            出库操作类型
     * @param saleOrderNo
     *            订单单编号
     * @return 订单出库单关联信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_SALE_ORDER_STOCKOUT_RELATION })
    List<SaleStockOutRelation> listSaleStockOutRelations(@Param("operType") String operType,
            @Param("saleOrderNo") String saleOrderNo);

}
