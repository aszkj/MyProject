/**
 * 文件名称：DBCacheInterceptor.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.cache;

import java.lang.reflect.Method;
import java.util.Set;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.log4j.Logger;

import redis.clients.jedis.Jedis;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.SerializableUtils;
import com.yilidi.o2o.core.utils.StringUtils;

/**
 * 功能描述：缓存拦截器 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class DBCacheInterceptor implements MethodInterceptor {

	private Logger logger = Logger.getLogger(this.getClass());

	private static final String TABLE_PREFIX = "YILIDI_";

	@Override
	public Object invoke(MethodInvocation methodInvocation) throws Throwable {

		Object result = null;
		Jedis jedis = null;
		try {
			Method method = methodInvocation.getMethod();
			String methodName = method.getName();
			String fullMethodName = method.getDeclaringClass().getName() + "." + methodName;

			// 判断该方法上使用有 DBCacheAnnotation注解
			if (method.isAnnotationPresent(DBCacheAnnotation.class)) {
				// 获取注解
				DBCacheAnnotation dbCacheAnnotation = method.getAnnotation(DBCacheAnnotation.class);

				String[] tables = dbCacheAnnotation.tables();
				CacheType cacheType = dbCacheAnnotation.value();
				logger.info("cacheType --------> " + cacheType.name());
				logger.info("method --------> " + methodName);

				// 生成hash key, 形式为table1~table2~table3~.....
				String hashKey = StringUtils.join(tables, "~");
				byte[] hashKeyBytes = hashKey.getBytes();

				// 获取jedis
				jedis = JedisUtils.getJedis();

				// 如果是通知类型
				if (cacheType.equals(CacheType.NOTIFY)) {
					result = methodInvocation.proceed();
					// 通知redis删除数据，等下一次查询在缓存
					removeCache(jedis, hashKeyBytes, tables);

				} else {
					// 生成SQL key, 形式为 函数名:参数值1,参数值2,参数值3,....
					Object[] params = methodInvocation.getArguments();
					String sqlKey = "";
					if (params.length > 0) {
						sqlKey = methodName + ":" + StringUtils.join(params, ",");
					} else {
						sqlKey = methodName;
					}

					byte[] sqlKeyBytes = sqlKey.getBytes();

					result = this.getResult(jedis, methodInvocation, hashKeyBytes, sqlKeyBytes, methodName, tables, hashKey);
				}
			} else {
				logger.debug("===================== 方法：" + fullMethodName + " 没有使用缓存 =======================");
				result = methodInvocation.proceed();
			}
			return result;
		} catch (Exception e) {
			logger.error(e);
			throw new Exception("Redis缓存操作异常：" + e.getMessage(), e);
		} finally {
			if (null != jedis) {
				JedisUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 获取执行结果：从redis中或从数据库中获取数据
	 * 
	 * @param jedis
	 * @param methodInvocation
	 * @param hashKeyBytes
	 * @param sqlKeyBytes
	 * @param methodName
	 * @return
	 * @throws Exception
	 */
	private Object getResult(Jedis jedis, MethodInvocation methodInvocation, byte[] hashKeyBytes, byte[] sqlKeyBytes,
			String methodName, String[] tables, String hashKey) throws Exception {
		Object result = null;
		if (jedis.hexists(hashKeyBytes, sqlKeyBytes)) {
			byte[] bys = jedis.hget(hashKeyBytes, sqlKeyBytes);
			if (methodName.startsWith(CommonConstants.PAGE_PREFIX)) {
				result = ObjectUtils.toObject(bys);
			} else {
				result = SerializableUtils.read(bys);
			}

			logger.info("<-------- 命中，从缓存中获取结果 ,hashkey：" + StringUtils.byteToString(hashKeyBytes) + ", sqlKey:"
					+ StringUtils.byteToString(sqlKeyBytes) + "----------->");
		} else {
			try {
				result = methodInvocation.proceed();
				logger.info("<-------- 未命中，从数据库中获取结果 -------->");
				if (null != result) {

					byte[] objBytes;
					if (methodName.startsWith(CommonConstants.PAGE_PREFIX)) {
						objBytes = ObjectUtils.toByteArray(result);
					} else {
						objBytes = SerializableUtils.write(result);
					}
					jedis.hset(hashKeyBytes, sqlKeyBytes, objBytes);

					// 将Key为table，value为table1~table2~table3~.....这种形式的Set，存入Redis，以便在该table发生写操作时，将其关联的多表联合查询产生的缓存清除掉。
					setJoinRelationshipCacheForSpecificTable(jedis, tables, hashKey);

					logger.info("<-------- 将数据库结果存入缓存，hashkey：" + StringUtils.byteToString(hashKeyBytes) + ",sqlKey:"
							+ StringUtils.byteToString(sqlKeyBytes) + "-------->");
				} else {
					logger.info("<-------- 查询结果为null，将不会缓存到redis中 -------->");
				}

			} catch (Throwable e) {
				logger.error(e);
				throw new Exception("methodInvocation 异常", e);
			}
		}
		return result;
	}

	/**
	 * 为指定的表设置与其关联的多表联合关系缓存
	 * 
	 * @param jedis
	 * @param tables
	 * @param hashKey
	 */
	private void setJoinRelationshipCacheForSpecificTable(Jedis jedis, String[] tables, String hashKey) {
		if (!ObjectUtils.isNullOrEmpty(tables) && tables.length > 1) {
			for (String table : tables) {
				jedis.sadd(TABLE_PREFIX + table, hashKey);
			}
		}
	}

	/**
	 * 从redis缓存中删除数据
	 * 
	 * @param jedis
	 * @param hashKey
	 *            hash key
	 * @param tables
	 *            表
	 */
	private void removeCache(Jedis jedis, byte[] hashKeyBytes, String[] tables) {

		Set<byte[]> sqlKeysBytes = jedis.hkeys(hashKeyBytes);
		for (byte[] sqlkey : sqlKeysBytes) {
			jedis.hdel(hashKeyBytes, sqlkey);

			logger.info("<-------- 清除缓存：hashkey：" + StringUtils.byteToString(hashKeyBytes) + ",sqlKey: "
					+ StringUtils.byteToString(sqlkey) + "--------->");
		}

		for (String table : tables) {
			byte[] tBytes = table.getBytes();
			Set<byte[]> sqlkeys = jedis.hkeys(tBytes);
			for (byte[] sqlkey : sqlkeys) {
				jedis.hdel(tBytes, sqlkey);
				logger.info("<--------- 清除缓存：hashkey：" + StringUtils.byteToString(tBytes) + ", sqlKey: "
						+ StringUtils.byteToString(sqlkey) + "---------->");
			}
			// 删除Key为table1~table2~table3~.....这种形式的与指定表有关联关系的缓存
			removeCacheForJoinRelationshipKeys(jedis, table);
		}
	}

	/**
	 * 删除Key为table1~table2~table3~.....这种形式的关联关系缓存
	 * 
	 * @param jedis
	 * @param table
	 */
	private void removeCacheForJoinRelationshipKeys(Jedis jedis, String table) {
		Set<String> joinHashKeyList = jedis.smembers(TABLE_PREFIX + table);
		if (!ObjectUtils.isNullOrEmpty(joinHashKeyList)) {
			for (String joinHashKey : joinHashKeyList) {
				Set<byte[]> joinSqlKeysBytes = jedis.hkeys(joinHashKey.getBytes());
				if (!ObjectUtils.isNullOrEmpty(joinSqlKeysBytes)) {
					for (byte[] joinSqlKey : joinSqlKeysBytes) {
						jedis.hdel(joinHashKey.getBytes(), joinSqlKey);
						logger.info("<-------- 清除缓存：hashkey：" + joinHashKey + ",sqlKey: "
								+ StringUtils.byteToString(joinSqlKey) + "--------->");
					}
				}
			}
		}
	}
}
