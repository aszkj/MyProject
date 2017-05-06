package com.yilidi.o2o.core.sharding.router.algorithm.date;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.sharding.dimension.concrete.DateDimension;
import com.yilidi.o2o.core.sharding.model.TableShardingModel;
import com.yilidi.o2o.core.sharding.router.algorithm.IShardingAlgorithm;
import com.yilidi.o2o.core.sharding.router.algorithm.ShardingHelper;
import com.yilidi.o2o.core.sharding.router.algorithm.state.concrete.DateAlgorithmType;
import com.yilidi.o2o.core.sharding.dimension.concrete.DateDimensionArgument;

/**
 * 时间切分算法（离当前时间最近的分片编号为1，次近的分片编号为2，依此类推）
 * 
 * @author chenl
 * 
 */
public class DateShardingAlgorithm extends ShardingHelper implements IShardingAlgorithm {

	@Override
	public Map<String, String> sharding(TableShardingModel tableShardingModel) {
		check(tableShardingModel, new DateAlgorithmType());
		return generateShardingTableNameMap(tableShardingModel);
	}

	public String generateShardingTablePostfix(TableShardingModel tableShardingModel) {
		List<Date> dateList = new ArrayList<Date>();
		Date currentDate = new Date();
		dateList.add(currentDate);
		for (int i = 1; i < tableShardingModel.getDimension().getShardingCount().intValue(); i++) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(currentDate);
			if (null != ((DateDimension) tableShardingModel.getDimension()).getIntervalDays()) {
				calendar.add(Calendar.DAY_OF_MONTH, -(((DateDimension) tableShardingModel.getDimension()).getIntervalDays())
						* i);
			}
			if (null != ((DateDimension) tableShardingModel.getDimension()).getIntervalMonths()) {
				calendar.add(Calendar.MONTH, -(((DateDimension) tableShardingModel.getDimension()).getIntervalMonths()) * i);
			}
			if (null != ((DateDimension) tableShardingModel.getDimension()).getIntervalYears()) {
				calendar.add(Calendar.YEAR, -(((DateDimension) tableShardingModel.getDimension()).getIntervalYears()) * i);
			}
			dateList.add(calendar.getTime());
		}
		Date concreteDate = ((DateDimensionArgument) tableShardingModel.getDimension().getValue()).getConcreteDate();
		Date fromDate = ((DateDimensionArgument) tableShardingModel.getDimension().getValue()).getFromDate();
		Date toDate = ((DateDimensionArgument) tableShardingModel.getDimension().getValue()).getToDate();
		String str = "";
		if (null == concreteDate && null == fromDate && null == toDate) {
			for (int i = 1; i <= tableShardingModel.getDimension().getShardingCount().intValue(); i++) {
				str += i + POUND_SIGN;
			}
			return removePoundSign(str);
		}
		if (null != concreteDate) {
			return tableNo(dateList, concreteDate);
		}
		if (null != fromDate && null == toDate) {
			String str1 = tableNo(dateList, fromDate);
			if (null == str1) {
				return null;
			}
			for (int i = 1; i <= Integer.valueOf(str1).intValue(); i++) {
				str += i + POUND_SIGN;
			}
			return removePoundSign(str);
		}
		if (null != toDate && null == fromDate) {
			String str2 = tableNo(dateList, toDate);
			if (null == str2) {
				for (int i = 1; i <= dateList.size(); i++) {
					str += i + POUND_SIGN;
				}
				return removePoundSign(str);
			}
			for (int i = Integer.valueOf(str2).intValue(); i <= dateList.size(); i++) {
				str += i + POUND_SIGN;
			}
			return removePoundSign(str);
		}
		if (null != fromDate && null != toDate) {
			String str1 = tableNo(dateList, fromDate);
			String str2 = tableNo(dateList, toDate);
			if (null == str1 && null == str2) {
				return null;
			}
			if (null != str1 && null == str2) {
				for (int i = 1; i <= Integer.valueOf(str1).intValue(); i++) {
					str += i + POUND_SIGN;
				}
				return removePoundSign(str);
			}
			if (null != str1 && null != str2) {
				for (int i = Integer.valueOf(str2).intValue(); i <= Integer.valueOf(str1).intValue(); i++) {
					str += i + POUND_SIGN;
				}
				return removePoundSign(str);
			}
		}
		return null;
	}

	private String removePoundSign(String str) {
		String result = "";
		if (str.endsWith(POUND_SIGN)) {
			result = str.substring(0, str.length() - 1);
		}
		return result;
	}

	private String tableNo(List<Date> dateList, Date date) {
		if (date.after(dateList.get(0))) {
			return null;
		}
		if (date.before(dateList.get(dateList.size() - 1))) {
			return Integer.toString(dateList.size());
		}
		for (int i = 0; i < dateList.size() - 1; i++) {
			if (date.getTime() == dateList.get(i + 1).getTime()) {
				return Integer.toString(i + 2);
			}
			if (date.getTime() == dateList.get(i).getTime()) {
				return Integer.toString(i + 1);
			}
			if (date.before(dateList.get(i)) && date.after(dateList.get(i + 1))) {
				return Integer.toString(i + 1);
			}
		}
		return null;
	}

}
