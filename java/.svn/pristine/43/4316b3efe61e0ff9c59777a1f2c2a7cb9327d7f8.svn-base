package com.yilidi.o2o.core.sharding.router.algorithm.state.concrete;

import com.yilidi.o2o.core.sharding.model.TableShardingModel;
import com.yilidi.o2o.core.sharding.router.algorithm.state.AlgorithmTypeAdapter;

/**
 * 枚举算法类型
 * 
 * @author chenl
 * 
 */
public class EnumerationAlgorithmType extends AlgorithmTypeAdapter {

	@Override
	public void check(TableShardingModel tableShardingModel) {
		if (!String.class.isInstance(tableShardingModel.getDimension().getValue())) {
			throw new IllegalArgumentException("参数tableShardingModel中的dimension属性中的value属性只能为String类型");
		}
	}

}
