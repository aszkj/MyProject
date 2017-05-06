package com.yilidi.o2o.core.sharding.model;

import com.yilidi.o2o.core.sharding.dimension.Dimension;

/**
 * 表分片Model
 * 
 * @author chenl
 * 
 */
public class TableShardingModel {

	/**
	 * 基表名称（例如：T_SALE_ORDER、T_SALE_ORDER_ITEMS等）
	 */
	private String baseTableName;

	/**
	 * 表变量名称
	 */
	private String tableVariableName;

	/**
	 * 分片维度
	 */
	private Dimension dimension;

	public TableShardingModel(Dimension dimension) {
		super();
		this.dimension = dimension;
	}

	public String getBaseTableName() {
		return baseTableName;
	}

	public void setBaseTableName(String baseTableName) {
		this.baseTableName = baseTableName;
	}

	public String getTableVariableName() {
		return tableVariableName;
	}

	public void setTableVariableName(String tableVariableName) {
		this.tableVariableName = tableVariableName;
	}

	public Dimension getDimension() {
		return dimension;
	}

	public void setDimension(Dimension dimension) {
		this.dimension = dimension;
	}

}
