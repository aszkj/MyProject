package com.yilidi.o2o.core.sharding.router.algorithm.state.concrete;

import java.util.Date;

import com.yilidi.o2o.core.sharding.dimension.concrete.DateDimension;
import com.yilidi.o2o.core.sharding.model.TableShardingModel;
import com.yilidi.o2o.core.sharding.router.algorithm.state.AlgorithmTypeAdapter;
import com.yilidi.o2o.core.sharding.dimension.concrete.DateDimensionArgument;

/**
 * 时间算法类型
 * 
 * @author chenl
 * 
 */
public class DateAlgorithmType extends AlgorithmTypeAdapter {

	@Override
	public void check(TableShardingModel tableShardingModel) {
		if (null == tableShardingModel.getDimension().getShardingCount()) {
			throw new IllegalArgumentException("参数tableShardingModel中的dimension属性中的shardingCount属性不能为空");
		}
		if ((null == ((DateDimension) tableShardingModel.getDimension()).getIntervalDays())
				&& (null == ((DateDimension) tableShardingModel.getDimension()).getIntervalMonths())
				&& (null == ((DateDimension) tableShardingModel.getDimension()).getIntervalYears())) {
			throw new IllegalArgumentException(
					"参数tableShardingModel中的dimension属性中的intervalDays或intervalMonths或intervalYears属性必须有一个不能为空");
		}
		Date concreteDate = ((DateDimensionArgument) tableShardingModel.getDimension().getValue()).getConcreteDate();
		Date fromDate = ((DateDimensionArgument) tableShardingModel.getDimension().getValue()).getFromDate();
		Date toDate = ((DateDimensionArgument) tableShardingModel.getDimension().getValue()).getToDate();
		if (null != concreteDate && (null != fromDate || null != toDate)) {
			throw new IllegalArgumentException("参数tableShardingModel中的dimension属性中的concreteDate不为空的情况下，fromDate和toDate必须全为空");
		}
		if (null != fromDate && null != toDate && fromDate.getTime() > toDate.getTime()) {
			throw new IllegalArgumentException("参数tableShardingModel中的dimension属性中的fromDate的值必须小于等于toDate的值");
		}
	}

}
