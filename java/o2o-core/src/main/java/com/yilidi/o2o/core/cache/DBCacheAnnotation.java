/**
 * 文件名称：QueryCacheAnnotation.java
 * 
 * 描述： 数据库缓存的Annotation
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.cache;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 功能描述： 功能描述：数据库使用缓存的annotation定义，使用该注解时，将根据注解的参数来获取或更新redis中的缓存对象 <br/>
 * 
 * <pre>
 * (1) 若查询时需要使用缓存，则需要在查询的方法签名上使用
 * "@DBCacheAnnotation(CacheType.QUERY)"注解，将会从redis缓存中获取数据 <br/>
 * 如果redis中没有，则会从数据库中查询，然后将数据缓存到redis中 <br />
 * 在redis中，缓存的key为表名_方法名_参数值1_参数值2... 的形式，value为查询结果返回的对象<br />
 * (2)
 * 在增、改、查中使用@DBCacheAnnotation(CacheType.MODIFY)注解，将会通知redis数据已经更改，redis需要更新数据。<br />
 * 注意：该注解只能Dao层的方法上使用
 * </pre>
 * 
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Documented
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface DBCacheAnnotation {

	public CacheType value();

	public String[] tables();
}
