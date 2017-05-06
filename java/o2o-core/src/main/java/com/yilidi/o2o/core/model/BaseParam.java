package com.yilidi.o2o.core.model;

import java.io.Serializable;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.utils.JsonUtils;

/**
 * Param基类
 * 
 * @author: chenlian
 * @date: 2016年6月3日 上午9:45:51
 */
public class BaseParam implements Serializable {

    private static final long serialVersionUID = -9191310105031822857L;
    protected Logger logger = Logger.getLogger(this.getClass());

    @Override
    public String toString() {
        return JsonUtils.toJsonStringWithDateFormat(this);
    }
}
