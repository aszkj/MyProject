package com.yilidi.o2o.core.sharding.dimension.concrete;

import com.yilidi.o2o.core.sharding.dimension.Dimension;
import com.yilidi.o2o.core.sharding.router.algorithm.IShardingAlgorithm;
import com.yilidi.o2o.core.sharding.router.algorithm.date.DateShardingAlgorithm;

/**
 * 时间维度
 * 
 * @author chenl
 * 
 */
public class DateDimension extends Dimension {

	private Integer intervalDays;

	private Integer intervalMonths;

	private Integer intervalYears;

	public DateDimension(String name, DateDimensionArgument value) {
		this.name = name;
		this.value = value;
	}

	public Integer getIntervalDays() {
		return intervalDays;
	}

	public void setIntervalDays(Integer intervalDays) {
		this.intervalDays = intervalDays;
	}

	public Integer getIntervalMonths() {
		return intervalMonths;
	}

	public void setIntervalMonths(Integer intervalMonths) {
		this.intervalMonths = intervalMonths;
	}

	public Integer getIntervalYears() {
		return intervalYears;
	}

	public void setIntervalYears(Integer intervalYears) {
		this.intervalYears = intervalYears;
	}

	@Override
	public IShardingAlgorithm getShardingAlgorithm() {
		return new DateShardingAlgorithm();
	}

}
