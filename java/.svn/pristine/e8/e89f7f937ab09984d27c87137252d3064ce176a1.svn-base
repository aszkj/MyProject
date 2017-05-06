package com.yilidi.o2o.user.dao;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.StoreDelivery;
import com.yilidi.o2o.user.model.combination.StoreDeliveryInfo;
import com.yilidi.o2o.user.service.dto.query.StoreDeliveryQuery;

/**
 * 
 * 店铺接单员数据接口类
 * 
 * @author: heyong
 * @date: 2015年12月10日 上午11:22:56
 * 
 */
public interface StoreDeliveryMapper {

	/**
	 * 新增保存
	 * 
	 * @param storeDelivery
	 *            实体
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_DELIVERY })
	Integer save(StoreDelivery storeDelivery);

	/**
	 * 根据ID查询实体
	 * 
	 * @param id
	 *            门店接单员ID
	 * @return StoreDelivery
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_DELIVERY })
	StoreDelivery loadById(Integer id);

	/**
	 * 修改
	 * 
	 * @param storeDelivery
	 *            实体
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_DELIVERY })
	Integer update(StoreDelivery storeDelivery);

	/**
	 * 失效/有效店铺接单员
	 * 
	 * @param id
	 *            店铺接单员id
	 * 
	 * @param state
	 *            店铺接单员是否有效
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_DELIVERY })
	void updateStateById(@Param("id") Integer id, @Param("state") String state);

	/**
	 * 
	 * 查询店铺接单员分页列表
	 * 
	 * @param query
	 *            查询条件
	 * @return Page<StoreDeliveryInfo>
	 */
	Page<StoreDeliveryInfo> findStoreDelivery(StoreDeliveryQuery query);
}
