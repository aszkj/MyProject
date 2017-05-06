/**
 * 文件名称：RollbackTransactionAnnotation.java
 * 
 * 描述： 跨域事务情况下，回滚事务进行补偿的Annotation
 * 
 * 修改
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
 * 功能描述：跨域事务情况下，回滚事务进行补偿的Annotation <br/>
 * 
 * <pre>
 * 
 * 每个跨域事务的正向接口都必须有它的配套反向回滚接口，该接口通过异步接收消息进行调用，利用自定义的消息异常处理机制保证事务的最终一致性。 <br/>
 * 
 * 在正向接口上需标注该Annotation，指明用于发送回滚消息的生产者rollbackMessageProducerBeanName。<br/>
 * 
 * 正向接口的返回结果需要是发送回滚消息的参数值，其基类为MessageModel，在正向接口里组装返回，以便在拦截器中统一处理。<br/>
 * 
 * 跨域事务的总体原则是：正向同步，反向异步。<br/>
 * 
 * 主事务中调用各个子域的分事务是同步调用的，如果为异步调用，则事务的先后顺序或事务的异常处理会相当麻烦。
 * 比如，生成订单时，主事务很快就成功生成了订单，但扣减库存的子域分事务却很耗时并最终由于库存不足，而无法进行库存的扣减，且公司业务也不打算再增加新的库存，
 * 那么，主事务已经完成，这时，成功生成的订单无论怎么处理都不太合理。因此，正向跨域事务是同步调用的，由于本项目各域之间物理跨度并不大，网络上的消耗并不会很大，故，同步是可行的。<br/>
 * 
 * 事务的补偿，即反向回滚接口的调用是异步的，利用可靠消息达到事务的最终一致即可，因为分布式事务中数据也不可能每时每刻都是强一致性的。<br/>
 * 
 * </pre>
 * 
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Documented
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface RollbackTransactionAnnotation {

	public String rollbackMessageProducerBeanName();

}
