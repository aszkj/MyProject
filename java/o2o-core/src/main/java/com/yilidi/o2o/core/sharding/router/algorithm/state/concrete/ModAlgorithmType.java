package com.yilidi.o2o.core.sharding.router.algorithm.state.concrete;

import com.yilidi.o2o.core.sharding.model.TableShardingModel;
import com.yilidi.o2o.core.sharding.router.algorithm.state.AlgorithmTypeAdapter;

/**
 * 取模算法类型
 * 
 * @author chenl
 * 
 */
public class ModAlgorithmType extends AlgorithmTypeAdapter {

	@Override
	public void check(TableShardingModel tableShardingModel) {
		if (null == tableShardingModel.getDimension().getShardingCount()) {
			throw new IllegalArgumentException("参数tableShardingModel中的dimension属性中的shardingCount属性不能为空");
		}
		if (!Integer.class.isInstance(tableShardingModel.getDimension().getValue())) {
			throw new IllegalArgumentException("参数tableShardingModel中的dimension属性中的value属性只能为Integer类型");
		}
	}

}
