package com.yilidi.o2o.core.sharding.model.concrete;

import com.yilidi.o2o.core.sharding.dimension.Dimension;
import com.yilidi.o2o.core.sharding.dimension.concrete.DateDimension;
import com.yilidi.o2o.core.sharding.dimension.concrete.NormalDimension;
import com.yilidi.o2o.core.sharding.model.TableShardingModel;

/**
 * 订单表分片实体
 * 
 * @author chenl
 * 
 */
public class SaleOrderShardingModel extends TableShardingModel {

	private static final Integer NORMAL_DIMENSION_SHARDING_COUNT = 5;
	private static final Integer DATE_DIMENSION_SHARDING_COUNT = 5;
	private static final String BASE_TABLE_NAME = "T_SALE_ORDER";
	private static final String TABLE_VARIABLE_NAME = "saleOrderShardingTableName";
	public static final Integer INTERVAL_MONTHS = 3;

	public SaleOrderShardingModel(Dimension dimension) {
		super(dimension);
		if (dimension instanceof NormalDimension) {
			dimension.setShardingCount(NORMAL_DIMENSION_SHARDING_COUNT);
		}
		if (dimension instanceof DateDimension) {
			dimension.setShardingCount(DATE_DIMENSION_SHARDING_COUNT);
			((DateDimension) dimension).setIntervalMonths(INTERVAL_MONTHS);
		}
		this.setBaseTableName(BASE_TABLE_NAME);
		this.setTableVariableName(TABLE_VARIABLE_NAME);
	}

	/**
	 * 分片Key
	 * 
	 * @author chenl
	 * 
	 */
	public static enum ShardingKey {

		/**
		 * 订单编号
		 */
		SALEORDERNO("saleOrderNo"),

		/**
		 * 零售商ID
		 */
		RETAILERID("retailerId"),

		/**
		 * 供应商ID
		 */
		PROVIDERID("providerId"),

		/**
		 * 下订单的用户ID
		 */
		USERID("userId"),

		/**
		 * 订单状态编码
		 */
		STATUSCODE("statusCode"),

		/**
		 * 订单创建时间
		 */
		CREATETIME("createTime");

		private String value;

		private ShardingKey(String value) {
			this.value = value;
		}

		public String getValue() {
			return value;
		}

	}

}
