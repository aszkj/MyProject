package com.yilidi.o2o.core.sharding.dimension.concrete;

import com.yilidi.o2o.core.sharding.dimension.Dimension;
import com.yilidi.o2o.core.sharding.router.algorithm.IShardingAlgorithm;
import com.yilidi.o2o.core.sharding.router.algorithm.enumeration.EnumerationShardingAlgorithm;

/**
 * 枚举维度
 * 
 * @author chenl
 * 
 */
public class EnumerationDimension extends Dimension {

	public EnumerationDimension(String name, String value) {
		this.name = name;
		this.value = value;
	}

	@Override
	public IShardingAlgorithm getShardingAlgorithm() {
		return new EnumerationShardingAlgorithm();
	}

}
