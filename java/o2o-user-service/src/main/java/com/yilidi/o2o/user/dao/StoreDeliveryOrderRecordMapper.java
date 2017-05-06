package com.yilidi.o2o.user.dao;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.StoreDeliveryOrderRecord;
import com.yilidi.o2o.user.model.combination.StoreDeliveryOrderRecordInfo;
import com.yilidi.o2o.user.service.dto.query.StoreDeliveryOrderRecordQuery;

/**
 * 店铺接单员处理订单记录数据接口类
 * 
 * @author: heyong
 * @date: 2015年12月10日 下午8:15:15
 * 
 */
public interface StoreDeliveryOrderRecordMapper {

	/**
	 * 新增保存
	 * 
	 * @param storeDeliveryOrderRecord
	 *            实体
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_DELIVERY_ORDER_RECORD })
	Integer save(StoreDeliveryOrderRecord storeDeliveryOrderRecord);

	/**
	 * 根据ID查询实体
	 * 
	 * @param id
	 *            门店接单员处理订单的ID
	 * @return StoreDeliveryOrderRecord
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_DELIVERY_ORDER_RECORD })
	StoreDeliveryOrderRecord loadById(Integer id);

	/**
	 * 
	 * 查询店铺接单员处理订单分页列表
	 * 
	 * @param query
	 *            查询条件
	 * @return Page<StoreDeliveryOrderRecordInfo>
	 */
	Page<StoreDeliveryOrderRecordInfo> findStoreDeliveryOrderRecord(StoreDeliveryOrderRecordQuery query);
}
