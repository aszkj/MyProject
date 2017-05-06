package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.RecommendCustomerStore;

/**
 * 推广客户与店铺关联关系Mapper
 * 
 * @author: chenlian
 * @date: 2016年8月11日 下午4:50:11
 */
public interface RecommendCustomerStoreMapper {

    /**
     * 新增推广客户与店铺关联关系
     * 
     * @param recommendCustomerStore
     *            推广客户与店铺关联关系
     * @return Integer 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_RECOMMENDCUSTOMER_STORE })
    Integer save(RecommendCustomerStore recommendCustomerStore);

    /**
     * 根据推广客户ID删除推广客户与店铺关联关系
     * 
     * @param recommendCustomerId
     *            推广客户ID
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_RECOMMENDCUSTOMER_STORE })
    void deleteByRecommendCustomerId(Integer recommendCustomerId);

    /**
     * 根据店铺ID获取该店铺所关联的所有推广客户ID列表
     * 
     * @param storeId
     *            店铺ID
     * @return List<Integer> 推广客户ID列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_RECOMMENDCUSTOMER_STORE })
    List<Integer> listRecommendCustomerIdsByStoreId(@Param("storeId") Integer storeId);

    /**
     * 根据推广客户ID获取该推广客户所关联的店铺ID
     * 
     * @param recommendCustomerId
     *            推广客户ID
     * @return Integer 店铺ID
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_RECOMMENDCUSTOMER_STORE })
    Integer loadStoreIdByRecommendCustomerId(@Param("recommendCustomerId") Integer recommendCustomerId);

}
