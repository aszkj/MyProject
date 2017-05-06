package com.yilidi.o2o.product.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SaleDaily;

/**
 * 功能描述： 商品每日的销量记录数据层操作接口类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleDailyMapper {

    /**
     * 保存销售记录
     * 
     * @param record
     *            销售记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_DAILY })
    Integer save(SaleDaily record);

    /**
     * 根据订单号删除销售记录
     * 
     * @param wareHouseId
     *            微仓ID
     * @param storeId
     *            店铺ID
     * @param saleProductId
     *            商品ID
     * @param saleDate
     *            销量日期
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_DAILY })
    Integer deleteByWareHouseIdAndStoreIdAndSaleProductIdAndSaleDate(@Param("wareHouseId") Integer wareHouseId,
            @Param("storeId") Integer storeId, @Param("saleProductId") Integer saleProductId,
            @Param("saleDate") Date saleDate);

}