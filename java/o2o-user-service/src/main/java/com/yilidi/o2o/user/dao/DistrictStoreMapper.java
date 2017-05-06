package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.DistrictStore;
import com.yilidi.o2o.user.model.combination.SimpleCommunityInfo;

/**
 * 小区店铺关联表数据接口类
 * 
 * @author: heyong
 * @date: 2015年11月11日 下午3:06:03
 * 
 */
public interface DistrictStoreMapper {

	/**
	 * 新增保存
	 * 
	 * @param districtStore
	 *            实体
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_DISTRICT_STORE })
	Integer save(DistrictStore districtStore);

	/**
	 * 删除
	 * 
	 * @param storeId
	 *            门店ID
	 * @param communityId
	 *            小区ID
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_DISTRICT_STORE })
	Integer deleteByIds(@Param("storeId") Integer storeId, @Param("communityId") Integer communityId);

	/**
	 * 根据门店ID删除关联表记录
	 * 
	 * @param storeId
	 *            门店ID
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_DISTRICT_STORE })
	Integer deleteByStoreId(Integer storeId);

	/**
	 * 根据小区ID查询该小区的门店数量
	 * 
	 * @param communityId
	 *            小区ID
	 * @return 门店数量
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_DISTRICT_STORE })
	Integer getCountByCommunityId(Integer communityId);

	/**
	 * 根据门店ID 查询配送的小区info列表
	 * 
	 * @param storeId
	 *            门店ID
	 * @return List<SimpleCommunityInfo>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_DISTRICT_STORE, DBTablesName.User.U_COMMUNITY })
	List<SimpleCommunityInfo> listSimpleCommunityInfoByStoreId(@Param("storeId") Integer storeId);
	/**
	 * 根据社区code查询关联的店铺
	 * @param districtStore
	 * @return
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_DISTRICT_STORE })
	List<Integer> listStoreIdsByCommunityCode(@Param("communityCode")Integer communityCode);
}
