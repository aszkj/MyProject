/**
 * 文件名称：SerializableUtil.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.net.URI;
import java.util.Arrays;
import java.util.BitSet;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.EnumMap;
import java.util.EnumSet;
import java.util.GregorianCalendar;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

import com.esotericsoftware.kryo.Kryo;
import com.esotericsoftware.kryo.Serializer;
import com.esotericsoftware.kryo.io.Input;
import com.esotericsoftware.kryo.io.Output;
import com.esotericsoftware.kryo.serializers.DefaultSerializers;

import de.javakaffee.kryoserializers.ArraysAsListSerializer;
import de.javakaffee.kryoserializers.BitSetSerializer;
import de.javakaffee.kryoserializers.CollectionsEmptyListSerializer;
import de.javakaffee.kryoserializers.CollectionsEmptyMapSerializer;
import de.javakaffee.kryoserializers.CollectionsEmptySetSerializer;
import de.javakaffee.kryoserializers.CollectionsSingletonListSerializer;
import de.javakaffee.kryoserializers.CollectionsSingletonMapSerializer;
import de.javakaffee.kryoserializers.CollectionsSingletonSetSerializer;
import de.javakaffee.kryoserializers.CopyForIterateCollectionSerializer;
import de.javakaffee.kryoserializers.CopyForIterateMapSerializer;
import de.javakaffee.kryoserializers.DateSerializer;
import de.javakaffee.kryoserializers.EnumMapSerializer;
import de.javakaffee.kryoserializers.EnumSetSerializer;
import de.javakaffee.kryoserializers.GregorianCalendarSerializer;
import de.javakaffee.kryoserializers.JdkProxySerializer;
import de.javakaffee.kryoserializers.KryoReflectionFactorySupport;
import de.javakaffee.kryoserializers.RegexSerializer;
import de.javakaffee.kryoserializers.SynchronizedCollectionsSerializer;
import de.javakaffee.kryoserializers.URISerializer;
import de.javakaffee.kryoserializers.UUIDSerializer;
import de.javakaffee.kryoserializers.UnmodifiableCollectionsSerializer;

/**
 * 功能描述：序列化与反序列化工具类，借助高性能工具Kryo实现 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public final class SerializableUtils {

	private static Logger logger = Logger.getLogger(SerializableUtils.class);
	private static final String CGLIB_METHOD = "de.javakaffee.kryoserializers.cglib.CGLibProxySerializer";
	private static final String CGLIB_PROXY_MARKER = "$CGLibProxyMarker";

	private SerializableUtils() {
	}

	private static final ThreadLocal<Kryo> THREAD_LOCAL_KRYO = new ThreadLocal<Kryo>() {
		protected Kryo initialValue() {
			Kryo kryo = new KryoReflectionFactorySupport() {

				@Override
				@SuppressWarnings({ "rawtypes", "unchecked" })
				public Serializer<?> getDefaultSerializer(final Class type) {
					if (EnumSet.class.isAssignableFrom(type)) {
						return new EnumSetSerializer();
					}
					if (EnumMap.class.isAssignableFrom(type)) {
						return new EnumMapSerializer();
					}
					if (Collection.class.isAssignableFrom(type)) {
						return new CopyForIterateCollectionSerializer();
					}
					if (Map.class.isAssignableFrom(type)) {
						return new CopyForIterateMapSerializer();
					}
					if (Date.class.isAssignableFrom(type)) {
						return new DateSerializer(type);
					}

					// 判断是否是EnhancerByCGLIB
					try {
						if (type.getName().indexOf("$$EnhancerByCGLIB$$") > 0) {
							Method method = Class.forName(CGLIB_METHOD).getDeclaredMethod("canSerialize", Class.class);
							if ((Boolean) method.invoke(null, type)) {
								return getSerializer(Class.forName(CGLIB_METHOD + CGLIB_PROXY_MARKER));
							}
						}
					} catch (Throwable thex) {
						logger.error("Kryo初始化异常.", thex);
					}

					return super.getDefaultSerializer(type);
				}
			};

			kryo.setClassLoader(Thread.currentThread().getContextClassLoader());
			kryo.setRegistrationRequired(false);

			kryo.register(Arrays.asList("").getClass(), new ArraysAsListSerializer());
			kryo.register(Collections.EMPTY_LIST.getClass(), new CollectionsEmptyListSerializer());
			kryo.register(Collections.EMPTY_MAP.getClass(), new CollectionsEmptyMapSerializer());
			kryo.register(Collections.EMPTY_SET.getClass(), new CollectionsEmptySetSerializer());
			kryo.register(Collections.singletonList("").getClass(), new CollectionsSingletonListSerializer());
			kryo.register(Collections.singleton("").getClass(), new CollectionsSingletonSetSerializer());
			kryo.register(Collections.singletonMap("", "").getClass(), new CollectionsSingletonMapSerializer());
			kryo.register(BigDecimal.class, new DefaultSerializers.BigDecimalSerializer());
			kryo.register(BigInteger.class, new DefaultSerializers.BigIntegerSerializer());
			kryo.register(Pattern.class, new RegexSerializer());
			kryo.register(BitSet.class, new BitSetSerializer());
			kryo.register(URI.class, new URISerializer());
			kryo.register(UUID.class, new UUIDSerializer());
			kryo.register(GregorianCalendar.class, new GregorianCalendarSerializer());
			kryo.register(InvocationHandler.class, new JdkProxySerializer());

			UnmodifiableCollectionsSerializer.registerSerializers(kryo);
			SynchronizedCollectionsSerializer.registerSerializers(kryo);

			// 动态注册JodaDateTimeSerializer
			try {
				Class<?> clazz = Class.forName("org.joda.time.DateTime");
				Serializer<?> serializer = (Serializer<?>) Class.forName(
						"de.javakaffee.kryoserializers.jodatime.JodaDateTimeSerializer").newInstance();
				kryo.register(clazz, serializer);
			} catch (Throwable thex) {
				logger.error("动态注册JodaDateTimeSerializer异常。", thex);
			}

			// 动态注册CGLibProxySerializer
			try {
				Class<?> clazz = Class.forName(CGLIB_METHOD + CGLIB_PROXY_MARKER);
				Serializer<?> serializer = (Serializer<?>) Class.forName(CGLIB_METHOD).newInstance();
				kryo.register(clazz, serializer);
			} catch (Throwable thex) {
				logger.error("动态注册CGLibProxySerializer异常。", thex);
			}

			return kryo;
		}
	};

	/**
	 * 将对象序列化为字节数组, 默认实用化的缓冲区大小为 Integer.MAX_VALUE, 2<sup>31</sup>-1.
	 * 
	 * @param obj
	 *            待序列化的对象
	 * @return 序列化后的字节数组
	 */
	public static byte[] write(Object obj) {
		return write(obj, -1);
	}

	/**
	 * 将对象序列化为字节数组
	 * 
	 * @param obj
	 *            待序列化的对象
	 * @param maxBufferSize
	 *            最大缓冲区大小，若为-1，则取值为Integer.MAX_VALUE, 2<sup>31</sup>-1.
	 * @return 序列化后的字节数组
	 */
	public static byte[] write(Object obj, int maxBufferSize) {
		Kryo kryo = THREAD_LOCAL_KRYO.get();
		Output output = new Output(1024, maxBufferSize);
		kryo.writeClassAndObject(output, obj);
		return output.toBytes();
	}

	/**
	 * 将字节数组反序列化 为对象
	 * 
	 * @param bytes
	 *            字节数组
	 * @return 对象
	 */
	public static Object read(byte[] bytes) {
		Kryo kryo = THREAD_LOCAL_KRYO.get();
		Input input = new Input(bytes);
		return kryo.readClassAndObject(input);
	}
}
