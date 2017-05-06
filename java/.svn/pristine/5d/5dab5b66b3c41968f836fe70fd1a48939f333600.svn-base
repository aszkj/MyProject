package com.yilidi.o2o.core.sharding.dimension.concrete;

import com.yilidi.o2o.core.sharding.dimension.Dimension;
import com.yilidi.o2o.core.sharding.router.algorithm.IShardingAlgorithm;
import com.yilidi.o2o.core.sharding.router.algorithm.normal.hash.ConsistentHashingShardingAlgorithm;

/**
 * 普通维度（利用一致性hash或取模等方式进行处理）
 * 
 * @author chenl
 * 
 */
public class NormalDimension extends Dimension {

	public NormalDimension(String name, Object value) {
		this.name = name;
		this.value = value;
	}

	@Override
	public IShardingAlgorithm getShardingAlgorithm() {
		return new ConsistentHashingShardingAlgorithm();
	}

}
