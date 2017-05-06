package com.yilidi.o2o.core.sharding.dimension;

/**
 * 维度基类
 * 
 * @author chenl
 * 
 */
public abstract class Dimension implements IDimensionAlgorithm {

	/**
	 * 分片维度名称（例如：buyerId、sellerId等）
	 */
	protected String name;

	/**
	 * 分片维度值
	 */
	protected Object value;

	/**
	 * 分片数量
	 */
	protected Integer shardingCount;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Object getValue() {
		return value;
	}

	public void setValue(Object value) {
		this.value = value;
	}

	public Integer getShardingCount() {
		return shardingCount;
	}

	public void setShardingCount(Integer shardingCount) {
		this.shardingCount = shardingCount;
	}

}
