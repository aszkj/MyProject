package com.yilidi.o2o.core.sharding.dimension.concrete;

import java.util.Date;

/**
 * 时间维度值所属的实体类
 * 
 * @author chenl
 * 
 */
public class DateDimensionArgument {

	private Date concreteDate;

	private Date fromDate;

	private Date toDate;

	public static class Builder {

		private Date concreteDate;

		private Date fromDate;

		private Date toDate;

		public Builder() {
		}

		public Builder concreteDate(Date date) {
			concreteDate = date;
			return this;
		}

		public Builder fromDate(Date date) {
			fromDate = date;
			return this;
		}

		public Builder toDate(Date date) {
			toDate = date;
			return this;
		}

		public DateDimensionArgument build() {
			return new DateDimensionArgument(this);
		}
	}

	private DateDimensionArgument(Builder builder) {
		concreteDate = builder.concreteDate;
		fromDate = builder.fromDate;
		toDate = builder.toDate;
	}

	public Date getConcreteDate() {
		return concreteDate;
	}

	public void setConcreteDate(Date concreteDate) {
		this.concreteDate = concreteDate;
	}

	public Date getFromDate() {
		return fromDate;
	}

	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}

	public Date getToDate() {
		return toDate;
	}

	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}

}
