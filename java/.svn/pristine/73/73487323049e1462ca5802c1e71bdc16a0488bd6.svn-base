package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.StockOutOrderStockOutRelation;

/**
 * 出库单出库关联信息数据层操作类
 * 
 * @author chenb
 * 
 */
public interface StockOutOrderStockOutRelationMapper {

    /**
     * 保存出库单出库单关联信息
     * 
     * @param record
     *            出库单出库单关联信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_STOCKOUT_ORDER_STOCKOUT_RELATION })
    Integer save(StockOutOrderStockOutRelation record);

    /**
     * 根据条件查询出库单出库单关联信息
     * 
     * @param stockOutOperType
     *            出库单出库操作类型
     * @param stockOutOrderNo
     *            出库单单编号
     * @return 出库单出库单关联信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_STOCKOUT_ORDER_STOCKOUT_RELATION })
    List<StockOutOrderStockOutRelation> listStockOutOrderStockOutRelations(@Param("stockOutOperType") String stockOutOperType,
            @Param("stockOutOrderNo") String stockOutOrderNo);

}
