package com.yilidi.o2o.core.sharding.router.algorithm;

import java.util.Map;

import com.yilidi.o2o.core.sharding.model.TableShardingModel;

/**
 * 分片算法接口
 * 
 * @author chenl
 * 
 */
public interface IShardingAlgorithm {

	public Map<String, String> sharding(TableShardingModel tableShardingModel);
}
