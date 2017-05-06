package com.yilidi.o2o.core.sharding.interceptor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.sharding.model.ShardingOperationModel;
import com.yilidi.o2o.core.sharding.model.TableShardingModel;
import com.yilidi.o2o.core.sharding.router.TableShardingRouter;
import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * 分表拦截器
 * 
 * @author chenl
 * 
 */
public class TableShardingInterceptor implements MethodInterceptor {

	public static final String POUND_SIGN = "#";

	public static final String UNDERSCORE = "_";

	private Logger logger = Logger.getLogger(this.getClass());

	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		try {
			logger.info("-----------------------------进入分表拦截器-----------------------------");
			Object[] params = invocation.getArguments();
			if (!ObjectUtils.isNullOrEmpty(params) && params.length == 1 && params[0] instanceof ShardingOperationModel) {
				ShardingOperationModel shardingOperationModel = (ShardingOperationModel) params[0];
				TableShardingModel tableShardingModel = shardingOperationModel.getTableShardingModel();
				if (!ObjectUtils.isNullOrEmpty(tableShardingModel)) {
					TableShardingRouter router = new TableShardingRouter(tableShardingModel.getDimension()
							.getShardingAlgorithm());
					Map<String, String> routerMap = router.router(tableShardingModel);
					if (routerMap.size() == 1) {
						shardingOperationModel.setShardingTableNameMap(routerMap);
						return invocation.proceed();
					} else {
						Integer originStart = shardingOperationModel.getStart();
						Integer originPageSize = shardingOperationModel.getPageSize();
						List<Object> resultList = new ArrayList<Object>();
						long total = 0;
						for (Map.Entry<String, String> entry : routerMap.entrySet()) {
							Map<String, String> map = new HashMap<String, String>();
							map.put(entry.getKey().substring(0, entry.getKey().indexOf(POUND_SIGN)), entry.getValue());
							shardingOperationModel.setShardingTableNameMap(map);
							total += handleDBOperations(invocation, shardingOperationModel, originStart, originPageSize,
									resultList);
						}
						return returnDBOperations(originStart, originPageSize, resultList, total);
					}
				} else {
					List<TableShardingModel> tableShardingModelList = shardingOperationModel.getTableShardingModelList();
					String operationType = shardingOperationModel.getOperationType();
					if (!StringUtils.isEmpty(operationType)) {
						if (ShardingOperationModel.OperationType.MULTI_DIMENSION_WRITE.getValue().equals(operationType)) {
							for (TableShardingModel tsm : tableShardingModelList) {
								TableShardingRouter router = new TableShardingRouter(tsm.getDimension()
										.getShardingAlgorithm());
								Map<String, String> routerMap = router.router(tsm);
								shardingOperationModel.setShardingTableNameMap(routerMap);
								invocation.proceed();
							}
						}
						if (ShardingOperationModel.OperationType.MULTI_TABLE_ON_ONE_SQL.getValue().equals(operationType)) {
							int count = 0;
							List<Map<String, String>> shardingTableNameMapList = new ArrayList<Map<String, String>>();
							Map<String, String> singleTableNameMap = new TreeMap<String, String>();
							Map<String, String> multiTableNameMap = new TreeMap<String, String>();
							for (TableShardingModel tsm : tableShardingModelList) {
								TableShardingRouter router = new TableShardingRouter(tsm.getDimension()
										.getShardingAlgorithm());
								Map<String, String> routerMap = router.router(tsm);
								if (routerMap.size() > 1) {
									count++;
									multiTableNameMap.putAll(routerMap);
								} else {
									Set<String> keys = routerMap.keySet();
									String key = keys.iterator().next();
									if (singleTableNameMap.containsKey(key)) {
										int index = 0;
										for (Map.Entry<String, String> entry : singleTableNameMap.entrySet()) {
											String[] existedKeys = entry.getKey().split(UNDERSCORE);
											if (existedKeys[0].equals(key)) {
												index++;
											}
										}
										singleTableNameMap.put(key + UNDERSCORE + index, routerMap.get(key));
									} else {
										singleTableNameMap.putAll(routerMap);
									}
								}
								if (count > 1) {
									String msg = "存在多组可路由到多张分表的情况，这往往是存在多个时间分片维度引起的，请合理使用恰当维度的分表进行数据库操作";
									throw new IllegalStateException(msg);
								}
							}
							if (!ObjectUtils.isNullOrEmpty(multiTableNameMap)) {
								for (Map.Entry<String, String> entry : multiTableNameMap.entrySet()) {
									Map<String, String> map = new HashMap<String, String>();
									map.put(entry.getKey().substring(0, entry.getKey().indexOf(POUND_SIGN)),
											entry.getValue());
									shardingTableNameMapList.add(map);
									if (!ObjectUtils.isNullOrEmpty(singleTableNameMap)) {
										shardingTableNameMapList.add(singleTableNameMap);
									}
								}
							} else {
								shardingTableNameMapList.add(singleTableNameMap);
							}
							if (shardingTableNameMapList.size() == 1) {
								shardingOperationModel.setShardingTableNameMap(shardingTableNameMapList.get(0));
								return invocation.proceed();
							} else {
								Integer originStart = shardingOperationModel.getStart();
								Integer originPageSize = shardingOperationModel.getPageSize();
								List<Object> resultList = new ArrayList<Object>();
								long total = 0;
								for (Map<String, String> shardingTableNameMap : shardingTableNameMapList) {
									shardingOperationModel.setShardingTableNameMap(shardingTableNameMap);
									total += handleDBOperations(invocation, shardingOperationModel, originStart,
											originPageSize, resultList);
								}
								return returnDBOperations(originStart, originPageSize, resultList, total);
							}
						}
					}
				}
			} else {
				return invocation.proceed();
			}
			return null;
		} catch (Exception e) {
			logger.error(e);
			throw new Exception("分片表路由出现系统异常：" + e.getMessage(), e);
		}
	}

	private Long handleDBOperations(MethodInvocation invocation, ShardingOperationModel shardingOperationModel,
			Integer originStart, Integer originPageSize, List<Object> resultList) throws Throwable {
		if (!ObjectUtils.isNullOrEmpty(originStart) && !ObjectUtils.isNullOrEmpty(originPageSize)) {
			Integer start = 1;
			Integer pageSize = ((originStart - 1) < 0 ? 0 : (originStart - 1)) * originPageSize + originPageSize;
			shardingOperationModel.setStart(start);
			shardingOperationModel.setPageSize(pageSize);
			PageHelper.startPage(shardingOperationModel.getStart(), shardingOperationModel.getPageSize());
			Page<?> page = (Page<?>) invocation.proceed();
			if (!ObjectUtils.isNullOrEmpty(page.getResult())) {
				resultList.addAll(page.getResult());
			}
			return page.getTotal();
		} else {
			Object result = invocation.proceed();
			if (null != result && !Integer.class.isInstance(result)) {
				if (result instanceof List) {
					if (!ObjectUtils.isNullOrEmpty(result)) {
						resultList.addAll((List<?>) result);
					}
				}
			}
			return 0L;
		}
	}

	private Object returnDBOperations(Integer originStart, Integer originPageSize, List<Object> resultList, Long total) {
		if (!ObjectUtils.isNullOrEmpty(originStart) && !ObjectUtils.isNullOrEmpty(originPageSize)) {
			Page<Object> page = new Page<Object>(originStart, originPageSize);
			page.setPageSize(originPageSize);
			page.setTotal(total);
			page.setPageNum((int) Math.ceil((double) page.getTotal() / (double) page.getPageSize()) < originStart ? (int) Math
					.ceil((double) page.getTotal() / (double) page.getPageSize()) : originStart);
			List<Object> list = new ArrayList<Object>();
			if (!ObjectUtils.isNullOrEmpty(resultList)) {
				int startResultNum = ((originStart - 1) < 0 ? 0 : (originStart - 1)) * originPageSize + 1;
				int endResultNum = ((originStart - 1) < 0 ? 0 : (originStart - 1)) * originPageSize + originPageSize;
				if (resultList.size() >= startResultNum) {
					if (resultList.size() <= endResultNum) {
						for (int i = startResultNum; i <= resultList.size(); i++) {
							list.add(resultList.get(i - 1));
						}
					} else {
						for (int i = startResultNum; i <= endResultNum; i++) {
							list.add(resultList.get(i - 1));
						}
					}
				}
			}
			if (!ObjectUtils.isNullOrEmpty(list)) {
				for (Object object : list) {
					page.add(object);
				}
			}
			return page;
		} else {
			return resultList;
		}
	}

}
