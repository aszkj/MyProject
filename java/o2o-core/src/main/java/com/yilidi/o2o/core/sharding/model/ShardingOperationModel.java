package com.yilidi.o2o.core.sharding.model;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.yilidi.o2o.core.model.BaseQuery;
import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * 分片数据库操作实体（DAO中凡是涉及到分片的数据库操作，均需将该实体作为参数传入各个方法中）
 * 
 * @author chenl
 * 
 */
public class ShardingOperationModel extends BaseQuery {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 8326475469654008762L;

	/**
	 * 表分片Model实体
	 */
	private TableShardingModel tableShardingModel;

	/**
	 * 表分片Model实体List
	 */
	private List<TableShardingModel> tableShardingModelList;

	/**
	 * 操作类型
	 */
	private String operationType;

	/**
	 * 进行数据库操作所需的参数Map
	 */
	private Map<String, Object> operationArgumentMap;

	/**
	 * 分片表名称Map
	 */
	private Map<String, String> shardingTableNameMap;

	/**
	 * 操作类型枚举
	 * 
	 * @author chenl
	 * 
	 */
	public static enum OperationType {

		/**
		 * 多维度写操作（定义了该操作，在写数据库时，不必编码对每个维度都调用一次DAO，拦截器会对每个维度调用统一的DAO接口，只用告知是哪几个维度，组装tableShardingModelList即可）
		 */
		MULTI_DIMENSION_WRITE("multi_dimension_write"),

		/**
		 * 一条SQL语句中包含有多个分表（支持在一条SQL语句中多分表多维度的操作，拦截器会将各分表按指定的各维度拆分到同一个SQL中，组装tableShardingModelList即可）
		 */
		MULTI_TABLE_ON_ONE_SQL("multi_table_on_one_sql");

		private String value;

		private OperationType(String value) {
			this.value = value;
		}

		public String getValue() {
			return value;
		}

	}

	public ShardingOperationModel(TableShardingModel tableShardingModel) {
		String msg = null;
		if (ObjectUtils.isNullOrEmpty(tableShardingModel)) {
			msg = "tableShardingModel不能为空";
			throw new IllegalArgumentException(msg);
		}
		this.tableShardingModel = tableShardingModel;
	}

	public ShardingOperationModel(List<TableShardingModel> tableShardingModelList, String operationType) {
		String msg = null;
		if (ObjectUtils.isNullOrEmpty(tableShardingModelList)) {
			msg = "tableShardingModelList不能为空";
			throw new IllegalArgumentException(msg);
		}
		if (StringUtils.isEmpty(operationType)) {
			msg = "operationType不能为空";
			throw new IllegalArgumentException(msg);
		}
		this.tableShardingModelList = tableShardingModelList;
		this.operationType = operationType;
	}

	public TableShardingModel getTableShardingModel() {
		return tableShardingModel;
	}

	public void setTableShardingModel(TableShardingModel tableShardingModel) {
		this.tableShardingModel = tableShardingModel;
	}

	public List<TableShardingModel> getTableShardingModelList() {
		return tableShardingModelList;
	}

	public void setTableShardingModelList(List<TableShardingModel> tableShardingModelList) {
		this.tableShardingModelList = tableShardingModelList;
	}

	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}

	public Map<String, Object> getOperationArgumentMap() {
		return operationArgumentMap;
	}

	public void setOperationArgumentMap(Map<String, Object> operationArgumentMap) {
		this.operationArgumentMap = operationArgumentMap;
	}

	public Map<String, String> getShardingTableNameMap() {
		return shardingTableNameMap;
	}

	public void setShardingTableNameMap(Map<String, String> shardingTableNameMap) {
		this.shardingTableNameMap = shardingTableNameMap;
	}

}
