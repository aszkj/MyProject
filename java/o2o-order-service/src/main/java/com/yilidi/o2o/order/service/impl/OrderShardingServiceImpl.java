package com.yilidi.o2o.order.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.sharding.dimension.concrete.DateDimension;
import com.yilidi.o2o.core.sharding.dimension.concrete.DateDimensionArgument;
import com.yilidi.o2o.core.sharding.model.ShardingOperationModel;
import com.yilidi.o2o.core.sharding.model.TableShardingModel;
import com.yilidi.o2o.core.sharding.model.concrete.SaleOrderShardingModel;
import com.yilidi.o2o.order.dao.SaleOrderShardingMapper;
import com.yilidi.o2o.order.service.IOrderShardingService;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 订单分表Service
 * 
 * @author chenl
 * 
 */
@Service("orderShardingService")
public class OrderShardingServiceImpl extends BasicDataService implements IOrderShardingService {

	@Autowired
	private SaleOrderShardingMapper saleOrderShardingMapper;

	@Override
	public void createShardingByCreateTime(int tableIndex) throws OrderServiceException {
		try {
			shardingByCreateTimeForSpecificTable(tableIndex);
		} catch (Exception e) {
			String msg = "根据订单生成时间分表出现系统异常";
			logger.error(msg, e);
			throw new OrderServiceException(msg, e);
		}

	}

	private void shardingByCreateTimeForSpecificTable(int tableIndex) {
		List<TableShardingModel> tableShardingModelList = new ArrayList<TableShardingModel>();
		Date currentDate = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(currentDate);
		calendar.add(Calendar.MONTH, -SaleOrderShardingModel.INTERVAL_MONTHS * (tableIndex - 1));
		TableShardingModel saleOrderShardingModel1 = new SaleOrderShardingModel(new DateDimension(
				SaleOrderShardingModel.ShardingKey.CREATETIME.getValue(), new DateDimensionArgument.Builder().concreteDate(
						calendar.getTime()).build()));
		calendar.add(Calendar.MONTH, SaleOrderShardingModel.INTERVAL_MONTHS);
		TableShardingModel saleOrderShardingModel2 = new SaleOrderShardingModel(new DateDimension(
				SaleOrderShardingModel.ShardingKey.CREATETIME.getValue(), new DateDimensionArgument.Builder().concreteDate(
						calendar.getTime()).build()));
		tableShardingModelList.add(saleOrderShardingModel1);
		tableShardingModelList.add(saleOrderShardingModel2);
		Map<String, Object> operationArgumentMap = new HashMap<String, Object>();
		operationArgumentMap.put("beginIntervalMonths", SaleOrderShardingModel.INTERVAL_MONTHS * (tableIndex - 1));
		if (tableIndex < 5) {
			operationArgumentMap.put("endIntervalMonths", SaleOrderShardingModel.INTERVAL_MONTHS * tableIndex);
		}
		ShardingOperationModel shardingOperationModel = new ShardingOperationModel(tableShardingModelList,
				ShardingOperationModel.OperationType.MULTI_TABLE_ON_ONE_SQL.getValue());
		shardingOperationModel.setOperationArgumentMap(operationArgumentMap);
		saleOrderShardingMapper.shardingByCreateTime(shardingOperationModel);
		saleOrderShardingMapper.deleteByCreateTimeForSharding(shardingOperationModel);
	}

}
