package com.yilidi.o2o.common.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @Description: TODO(买家登录验证注解)
 * @author: chenlian
 * @date: 2016年5月28日 下午8:21:42
 */
@Documented
@Inherited
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface BuyerLoginValidation {
    boolean validate() default true;
}
