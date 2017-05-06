package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.order.model.SaleOrder;
import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.core.sharding.model.ShardingOperationModel;

/**
 * 功能描述：订单分片数据层操作接口类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleOrderShardingMapper {

	/**
	 * 保存订单信息
	 * 
	 * @param shardingOperationModel
	 * @return 影响行数
	 */
	Integer save(ShardingOperationModel shardingOperationModel);

	/**
	 * 根据订单id查询订单信息
	 * 
	 * @param shardingOperationModel
	 * @return 订单信息对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_SALE_ORDER })
	SaleOrder loadBySaleOrderNo(ShardingOperationModel shardingOperationModel);

	/**
	 * 更新订单的总价
	 * 
	 * @param shardingOperationModel
	 * @return 影响行数
	 */
	Integer updatePriceBySaleOrderNo(ShardingOperationModel shardingOperationModel);

	/**
	 * 根据订单生成时间分表
	 * 
	 * @param shardingOperationModel
	 */
	void shardingByCreateTime(ShardingOperationModel shardingOperationModel);

	/**
	 * 删除根据订单生成时间分表所移动的纪录数据
	 * 
	 * @param shardingOperationModel
	 */
	void deleteByCreateTimeForSharding(ShardingOperationModel shardingOperationModel);

	/**
	 * 根据条件查询订单信息（分页）
	 * 
	 * @param shardingOperationModel
	 * @return Page<SaleOrder>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_SALE_ORDER })
	Page<SaleOrder> findSaleOrders(ShardingOperationModel shardingOperationModel);

	/**
	 * 根据条件查询订单信息（不分页）
	 * 
	 * @param shardingOperationModel
	 * @return Page<SaleOrder>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_SALE_ORDER })
	List<SaleOrder> listSaleOrders(ShardingOperationModel shardingOperationModel);

}