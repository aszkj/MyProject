package com.yilidi.o2o.common.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @Description: TODO(卖家登录验证注解)
 * @author: chenlian
 * @date: 2016年6月12日 上午9:07:38
 */
@Documented
@Inherited
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface SellerLoginValidation {
    boolean validate() default true;
}
