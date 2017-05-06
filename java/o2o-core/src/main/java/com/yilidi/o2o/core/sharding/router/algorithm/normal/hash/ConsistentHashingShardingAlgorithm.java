package com.yilidi.o2o.core.sharding.router.algorithm.normal.hash;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.sharding.model.TableShardingModel;
import com.yilidi.o2o.core.sharding.router.algorithm.IShardingAlgorithm;
import com.yilidi.o2o.core.sharding.router.algorithm.ShardingHelper;
import com.yilidi.o2o.core.sharding.router.algorithm.state.concrete.ConsistentHashingAlgorithmType;

/**
 * 一致性Hash切分算法
 * 
 * @author chenl
 * 
 */
public class ConsistentHashingShardingAlgorithm extends ShardingHelper implements IShardingAlgorithm {

	private static final Integer VIRTUAL_NODE_COUNT = 1024;

	@Override
	public Map<String, String> sharding(TableShardingModel tableShardingModel) {
		check(tableShardingModel, new ConsistentHashingAlgorithmType());
		return generateShardingTableNameMap(tableShardingModel);
	}

	public String generateShardingTablePostfix(TableShardingModel tableShardingModel) {
		List<Node> nodeList = new ArrayList<Node>();
		for (int i = 1; i <= tableShardingModel.getDimension().getShardingCount().intValue(); i++) {
			Node node = new Node(Integer.toString(i));
			nodeList.add(node);
		}
		KetamaNodeLocator locator = new KetamaNodeLocator(nodeList, HashAlgorithm.KETAMA_HASH, VIRTUAL_NODE_COUNT);
		Node node = locator.getPrimary(tableShardingModel.getDimension().getValue().toString());
		return node.getName();
	}

}
