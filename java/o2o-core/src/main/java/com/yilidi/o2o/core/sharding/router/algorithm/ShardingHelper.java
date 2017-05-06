package com.yilidi.o2o.core.sharding.router.algorithm;

import java.util.Map;
import java.util.StringTokenizer;
import java.util.TreeMap;

import org.apache.commons.lang.StringUtils;

import com.yilidi.o2o.core.sharding.model.TableShardingModel;
import com.yilidi.o2o.core.sharding.router.algorithm.state.IAlgorithmType;

/**
 * 分片Helper类
 * 
 * @author chenl
 * 
 */
public abstract class ShardingHelper {

	public static final String POUND_SIGN = "#";

	public static final String TABLE_BOUND_SYMBOL = "_";

	protected void check(TableShardingModel tableShardingModel, IAlgorithmType algorithmType) {
		if (null == tableShardingModel) {
			throw new IllegalArgumentException("参数tableShardingModel不能为空");
		}
		if (StringUtils.isEmpty(tableShardingModel.getBaseTableName())) {
			throw new IllegalArgumentException("参数tableShardingModel中的baseTableName属性不能为空");
		}
		if (StringUtils.isEmpty(tableShardingModel.getTableVariableName())) {
			throw new IllegalArgumentException("参数tableShardingModel中的tableVariableName属性不能为空");
		}
		if (null == tableShardingModel.getDimension()) {
			throw new IllegalArgumentException("参数tableShardingModel中的dimension属性不能为空");
		}
		if (StringUtils.isEmpty(tableShardingModel.getDimension().getName())) {
			throw new IllegalArgumentException("参数tableShardingModel中的dimension属性中的name属性不能为空");
		}
		if (null == tableShardingModel.getDimension().getValue()) {
			throw new IllegalArgumentException("参数tableShardingModel中的dimension属性中的value属性不能为空");
		}
		algorithmType.check(tableShardingModel);
	}

	protected abstract String generateShardingTablePostfix(TableShardingModel tableShardingModel);

	protected Map<String, String> generateShardingTableNameMap(TableShardingModel tableShardingModel) {
		Map<String, String> shardingTableNameMap = new TreeMap<String, String>();
		if (StringUtils.isEmpty(generateShardingTablePostfix(tableShardingModel))) {
			throw new IllegalStateException("无法定位到合适的切分表");
		}
		if (!generateShardingTablePostfix(tableShardingModel).contains(POUND_SIGN)) {
			bulidShardingTableNameMap(tableShardingModel, generateShardingTablePostfix(tableShardingModel),
					shardingTableNameMap, null);
		} else {
			StringTokenizer st = new StringTokenizer(generateShardingTablePostfix(tableShardingModel), POUND_SIGN);
			int i = 0;
			while (st.hasMoreTokens()) {
				bulidShardingTableNameMap(tableShardingModel, st.nextToken(), shardingTableNameMap, ++i);
			}
		}
		return shardingTableNameMap;
	}

	private void bulidShardingTableNameMap(TableShardingModel tableShardingModel, String shardingTablePostfix,
			Map<String, String> shardingTableNameMap, Integer index) {
		String shardingTableName = tableShardingModel.getBaseTableName() + TABLE_BOUND_SYMBOL
				+ tableShardingModel.getDimension().getName().toUpperCase() + TABLE_BOUND_SYMBOL + shardingTablePostfix;
		if (null == index) {
			shardingTableNameMap.put(tableShardingModel.getTableVariableName(), shardingTableName);
		} else {
			shardingTableNameMap.put(tableShardingModel.getTableVariableName() + POUND_SIGN + index, shardingTableName);
		}
	}

}
