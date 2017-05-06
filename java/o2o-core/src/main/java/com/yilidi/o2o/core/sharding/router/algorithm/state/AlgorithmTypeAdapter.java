package com.yilidi.o2o.core.sharding.router.algorithm.state;

import com.yilidi.o2o.core.sharding.model.TableShardingModel;

/**
 * 算法类型适配，继承该类的子类不必实现IAlgorithmType接口中定义的全部方法，只需按需实现即可，以免IAlgorithmType接口中方法的变动对实现它的子类造成较大影响。
 * 
 * @author chenl
 * 
 */
public abstract class AlgorithmTypeAdapter implements IAlgorithmType {

	@Override
	public abstract void check(TableShardingModel tableShardingModel);

}
