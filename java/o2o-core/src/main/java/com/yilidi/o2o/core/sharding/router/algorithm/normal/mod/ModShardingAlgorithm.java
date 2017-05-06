package com.yilidi.o2o.core.sharding.router.algorithm.normal.mod;

import java.util.Map;

import com.yilidi.o2o.core.sharding.model.TableShardingModel;
import com.yilidi.o2o.core.sharding.router.algorithm.IShardingAlgorithm;
import com.yilidi.o2o.core.sharding.router.algorithm.ShardingHelper;
import com.yilidi.o2o.core.sharding.router.algorithm.state.concrete.ModAlgorithmType;

/**
 * 取模切分算法
 * 
 * @author chenl
 * 
 */
public class ModShardingAlgorithm extends ShardingHelper implements IShardingAlgorithm {

	@Override
	public Map<String, String> sharding(TableShardingModel tableShardingModel) {
		check(tableShardingModel, new ModAlgorithmType());
		return generateShardingTableNameMap(tableShardingModel);
	}

	public String generateShardingTablePostfix(TableShardingModel tableShardingModel) {
		int index = ((Integer) tableShardingModel.getDimension().getValue()).intValue()
				% tableShardingModel.getDimension().getShardingCount().intValue();
		return Integer.toString(index);
	}

}
