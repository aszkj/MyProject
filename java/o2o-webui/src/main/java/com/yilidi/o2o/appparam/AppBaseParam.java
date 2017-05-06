package com.yilidi.o2o.appparam;

import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.model.BaseParam;

/**
 * APP端传给后台参数基类
 * 
 * @author: chenlian
 * @date: 2016年6月3日 上午9:47:43
 */
public abstract class AppBaseParam extends BaseParam {

    private static final long serialVersionUID = 4971955272559408454L;

    
    /**
     * 获取参数字段名称
     * 
     * @param name
     * @return String
     */
    protected String getFieldName(String name) {
        try {
            return getDeclaredField(this, name).getAnnotation(Field.class).value();
        } catch (Exception e) {
            throw new IllegalArgumentException("参数字段解析出现异常");
        }
    }

    private java.lang.reflect.Field getDeclaredField(Object object, String fieldName) {
        Class<?> clazz = object.getClass();
        if (clazz == Object.class) {
            return null;
        }
        return getDeclaredField(clazz, fieldName);
    }

    private java.lang.reflect.Field getDeclaredField(Class<?> clazz, String fieldName) {
        if (clazz == Object.class) {
            return null;
        }
        try {
            return clazz.getDeclaredField(fieldName);
        } catch (NoSuchFieldException e) {
            return getDeclaredField(clazz.getSuperclass(), fieldName);
        } catch (Exception e) {
            // Do nothing
            logger.warn(e);
        }
        return null;
    }

    /**
     * 验证参数，由其具体子类来实现)
     * 
     */
    public abstract void validateParams();

}
