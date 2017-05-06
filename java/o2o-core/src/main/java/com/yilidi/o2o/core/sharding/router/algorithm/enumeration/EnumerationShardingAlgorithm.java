package com.yilidi.o2o.core.sharding.router.algorithm.enumeration;

import java.util.Map;

import com.yilidi.o2o.core.sharding.model.TableShardingModel;
import com.yilidi.o2o.core.sharding.router.algorithm.IShardingAlgorithm;
import com.yilidi.o2o.core.sharding.router.algorithm.ShardingHelper;
import com.yilidi.o2o.core.sharding.router.algorithm.state.concrete.EnumerationAlgorithmType;

/**
 * 枚举切分算法
 * 
 * @author chenl
 * 
 */
public class EnumerationShardingAlgorithm extends ShardingHelper implements IShardingAlgorithm {

	@Override
	public Map<String, String> sharding(TableShardingModel tableShardingModel) {
		check(tableShardingModel, new EnumerationAlgorithmType());
		return generateShardingTableNameMap(tableShardingModel);
	}

	public String generateShardingTablePostfix(TableShardingModel tableShardingModel) {
		return ((String) tableShardingModel.getDimension().getValue()).toUpperCase();
	}

}
