/**
 * 文件名称：MainTransactionAnnotation.java
 * 
 * 描述： 跨域事务情况下，主事务的Annotation
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.transaction.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 功能描述：跨域事务情况下，主事务的Annotation ，主要用于标识该跨域事务，以便于发生异常时进行跟踪。<br/>
 * 
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Documented
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface MainTransactionAnnotation {

	public String crossDomainTransactionName();

}
