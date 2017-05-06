package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.Community;
import com.yilidi.o2o.user.model.combination.CommunityLocationInfo;
import com.yilidi.o2o.user.model.combination.CommunityStoreRelatedInfo;
import com.yilidi.o2o.user.service.dto.query.CommunityQuery;
import com.yilidi.o2o.user.service.dto.query.CommunityStoreRelatedQuery;

/**
 * 功能描述：用户对象操作DAO <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface CommunityMapper {

    /**
     * 保存小区信息
     * 
     * <pre>
     * 	注：将更新community缓存
     * </pre>
     * 
     * @param community
     *            用户对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_COMMUNITY })
    Integer save(Community community);

    /**
     * 
     * 更新小区信息
     * 
     * @param community
     *            小区对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_COMMUNITY })
    Integer update(Community community);

    /**
     * 小区管理列表
     * 
     * @param communityQuery
     *            查询条件
     * @return Page<Community>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMUNITY })
    Page<Community> findCommunitys(CommunityQuery communityQuery);

    /**
     * 根据小区名字查询
     * 
     * @param distName
     *            小区名称
     * @return List<Community>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMUNITY })
    List<Community> listCommunityByName(String distName);

    /**
     * 根据ID查询
     * 
     * @param id
     *            小区ID
     * @return Community
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMUNITY })
    Community loadById(Integer id);

    /**
     * 
     * 查询门店管理列表
     * 
     * @param communityStoreRelatedQuery
     *            查询条件
     * @return Page<CommunityStoreRelatedInfo>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMUNITY, DBTablesName.User.U_DISTRICT_STORE,
            DBTablesName.User.U_STORE_PROFILE })
    Page<CommunityStoreRelatedInfo> findCommunityStores(CommunityStoreRelatedQuery communityStoreRelatedQuery);

    /**
     * 
     * 查询小区门店列表
     * 
     * @param communityStoreRelatedQuery
     *            查询条件
     * @return Page<CommunityStoreRelatedInfo>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMUNITY, DBTablesName.User.U_DISTRICT_STORE,
            DBTablesName.User.U_STORE_PROFILE })
    Page<CommunityStoreRelatedInfo> findCommunityStoresByCommunityId(CommunityStoreRelatedQuery communityStoreRelatedQuery);

    /**
     * 根据小区ID 更新小区 门店数量
     * 
     * @param id
     *            小区ID
     * @param storeCount
     *            门店数量
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_COMMUNITY })
    Integer updateStoreCountById(@Param("id") Integer id, @Param("storeCount") Integer storeCount);

    /**
     * 
     * 门店导出的总记录数
     * 
     * @param communityStoreRelatedQuery
     *            查询条件
     * @return Long
     */
    Long getCountsForExportStore(CommunityStoreRelatedQuery communityStoreRelatedQuery);

    /**
     * 
     * 分页获取报表数据
     * 
     * @param communityStoreRelatedQuery
     *            门店查询实体
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            分页大小
     * @return List<CommunityStoreRelatedInfo>
     * 
     */
    List<CommunityStoreRelatedInfo> listDataForExportStore(
            @Param("communityStoreRelatedQuery") CommunityStoreRelatedQuery communityStoreRelatedQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 
     * 查询小区列表->APP
     * 
     * @param communityQuery
     *            查询条件
     * @return List<Community>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMUNITY })
    Page<Community> findCommunitysPage(@Param("communityQuery") CommunityQuery communityQuery);

    /**
     * 
     * 根据经度和纬度定位到最近小区
     * 
     * @param longitude
     *            经度
     * @param latitude
     *            纬度
     * @param distance
     *            纬度
     * @return CommunityLocationInfo
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMUNITY })
    CommunityLocationInfo findNearestCommunity(@Param("longitude") String longitude, @Param("latitude") String latitude,
            @Param("distance") Integer distance);

    /**
     * 
     * 根据经度和纬度定位到附近小区列表
     * 
     * @param communityQuery
     *            查询条件
     * @param longitude
     *            经度
     * @param latitude
     *            纬度
     * @return CommunityLocationInfo
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMUNITY })
    Page<CommunityLocationInfo> findAroundCommunityList(@Param("communityQuery") CommunityQuery communityQuery,
            @Param("longitude") String longitude, @Param("latitude") String latitude);

    /**
     * 
     * 根据经度和纬度定位到指定距离范围内小区列表
     * 
     * @param distance
     *            指定距离
     * @param longitude
     *            经度
     * @param latitude
     *            纬度
     * @return CommunityLocationInfo
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMUNITY })
    List<CommunityLocationInfo> listAroundCommunities(@Param("distance") Integer distance,
            @Param("longitude") String longitude, @Param("latitude") String latitude);

    /**
     * 根据区县编码获取该区县范围内的小区列表
     * 
     * @param countyCode
     * @return List<Community>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMUNITY })
    List<Community> listCommunitiesByCountyCode(@Param("countyCode") String countyCode);

}