package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.StoreWarehouse;
import com.yilidi.o2o.user.model.query.WarehousePartnersQuery;

/**
 * 店铺与微仓关联关系Mapper
 * 
 * @author: chenlian
 * @date: 2016年6月23日 下午4:08:19
 */
public interface StoreWarehouseMapper {

    /**
     * 新增店铺与微仓关联关系
     * 
     * @param storeWarehouse
     *            店铺与微仓关联关系
     * @return Integer 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_WAREHOUSE })
    Integer save(StoreWarehouse storeWarehouse);

    /**
     * 根据店铺ID删除店铺与微仓关联关系
     * 
     * @param storeId
     *            店铺ID
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_WAREHOUSE })
    void deleteByStoreId(Integer storeId);

    /**
     * 根据微仓ID获取该微仓所关联的所有店铺ID列表
     * 
     * @param warehouseId
     *            微仓ID
     * @return List<Integer> 店铺ID列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_WAREHOUSE })
    List<Integer> listStoreIdsByWarehouseId(@Param("warehouseId") Integer warehouseId);

    /**
     * 根据店铺ID获取该店铺所关联的微仓ID
     * 
     * @param storeId
     *            店铺ID
     * @return Integer 微仓ID
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_WAREHOUSE })
    Integer loadWarehouseIdByStoreId(@Param("storeId") Integer storeId);

    /**
     * 分页获取店铺与微仓关联关系列表
     * 
     * @param warehousePartnersQuery
     * @return Page<StoreWarehouse>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_WAREHOUSE })
    Page<StoreWarehouse> findStoreWarehouseRelations(WarehousePartnersQuery warehousePartnersQuery);
}
