package com.yilidi.o2o.core.sharding.dimension;

import com.yilidi.o2o.core.sharding.router.algorithm.IShardingAlgorithm;

/**
 * 不同的维度获取不同的分片算法接口
 * 
 * @author chenl
 * 
 */
public interface IDimensionAlgorithm {

	public IShardingAlgorithm getShardingAlgorithm();

}
