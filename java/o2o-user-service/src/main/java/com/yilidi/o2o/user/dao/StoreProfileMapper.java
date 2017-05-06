package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.StoreProfile;
import com.yilidi.o2o.user.model.combination.StoreLocationInfo;
import com.yilidi.o2o.user.model.combination.WarehouseLocationInfo;
import com.yilidi.o2o.user.model.query.StoreLocationQuery;

/**
 * 店铺属性数据接口类
 * 
 * @author: heyong
 * @date: 2015年11月10日 下午9:44:38
 * 
 */
public interface StoreProfileMapper {

    /**
     * 新增保存
     * 
     * @param storeProfile
     *            实体
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_PROFILE })
    Integer save(StoreProfile storeProfile);

    /**
     * 根据ID查询实体
     * 
     * @param id
     *            ID
     * @return StoreProfile
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE })
    StoreProfile loadById(Integer id);

    /**
     * 修改
     * 
     * @param storeProfile
     *            实体
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_PROFILE })
    Integer update(StoreProfile storeProfile);

    /**
     * 关闭或者开启店铺 修改状态
     * 
     * @param id
     *            门店id
     * 
     * @param storeStatus
     *            门店状态
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_PROFILE })
    void updateStatusById(@Param("id") Integer id, @Param("storeStatus") String storeStatus);

    /**
     * 修改共享库存状态
     * 
     * @param storeId
     *            门店id
     * 
     * @param stockShare
     *            共享库存状态
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_PROFILE })
    void updateStockShareByStoreId(@Param("storeId") Integer id, @Param("stockShare") String stockShare);

    /**
     * 根据storeCode查询实体
     * 
     * @param storeCode
     *            门店编号
     * @return StoreProfile
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE })
    StoreProfile loadByStoreCode(String storeCode);

    /**
     * 获取全国性的商家
     * 
     * @return StoreProfile
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE })
    StoreProfile loadNationalStore(@Param("storeType") String storeType, @Param("provinceCode") String provinceCode);

    /**
     * 根据storeCode查询实体
     * 
     * @param storeStatus
     *            门店状态
     * @return StoreProfile 门店列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE })
    List<StoreProfile> getStoreProfile(@Param("storeStatus") String storeStatus);

    /**
     * 根据storeID查询实体
     * 
     * @param storeId
     *            门店ID 对应customerId
     * @param storeStatus
     *            门店状态
     * @return StoreProfile
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE })
    StoreProfile loadByStoreId(@Param("storeId") Integer storeId, @Param("storeStatus") String storeStatus);

    /**
     * 根据小区ID查询店铺信息
     * 
     * @param communityId
     *            小区ID
     * @param storeStatus
     *            门店状态
     * @return StoreProfile
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE,
            DBTablesName.User.U_DISTRICT_STORE })
    StoreProfile loadByCommunityId(@Param("communityId") Integer communityId, @Param("storeStatus") String storeStatus);

    /**
     * 根据经纬度查找最近店铺信息
     * 
     * @param longitude
     *            经度
     * @param latitude
     *            纬度
     * @return StoreProfile
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE })
    StoreProfile loadNearestStoreProfileByLngAndLat(@Param("longitude") String longitude,
            @Param("latitude") String latitude);

    /**
     * @Description TODO(卖家修改店铺详细信息)
     * @param storeProfile
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_PROFILE })
    void updateStoreDetailsForSeller(StoreProfile storeProfile);

    /**
     * 根据店铺编码和店铺名称和店铺状态查询店铺列表
     * 
     * @param storeCode
     *            店铺编码
     * @param storeName
     *            店铺名称
     * @param storeStatus
     *            店铺状态
     * @return 店铺列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE })
    List<StoreProfile> listByStoreCodeAndStoreNameAndStoreStatus(@Param("storeCode") String storeCode,
            @Param("storeName") String storeName, @Param("storeStatus") String storeStatus);

    /**
     * 根据若干店铺类型查询店铺列表
     * 
     * @param storeTypes
     *            店铺类型List
     * @return 店铺列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE })
    List<StoreProfile> listByStoreTypes(@Param("storeTypes") List<String> storeTypes);

    /**
     * 根据经度和纬度定位到指定距离范围内微仓列表
     * 
     * @param distance
     * @param longitude
     * @param latitude
     * @param storeType
     * @return List<WarehouseLocationInfo>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE })
    List<WarehouseLocationInfo> listAroundWarehouses(@Param("distance") Integer distance,
            @Param("longitude") String longitude, @Param("latitude") String latitude, @Param("storeType") String storeType);

    /**
     * 根据若干店铺ID获取店铺信息列表
     * 
     * @param storeIds
     * @return List<StoreProfile>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE })
    List<StoreProfile> listStoreProfileByStoreIds(@Param("storeIds") List<Integer> storeIds);

    /**
     * 获取店铺信息列表
     * 
     * @return List<StoreProfile>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE })
    List<StoreProfile> listStoreProfiles();

    /**
     * 获取附近店铺列表
     * 
     * @param storeLocationQuery
     *            定位条件
     * @return 店铺列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE })
    List<StoreLocationInfo> listAroundStores(StoreLocationQuery storeLocationQuery);
    /**
     * 根据店铺名称查询店铺列表
     * @param storeName
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_PROFILE })
	List<StoreProfile> listByStoreName(String storeName);
    /**
     * 根据店铺id更新店铺评价得分(定时任务调用，默认五分)
     * @param storeId
     * @param storeScore
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_PROFILE })
    void updateStoreScoreByStoreId(@Param("storeId")Integer storeId,@Param("storeScore") Float storeScore);
}
