package com.yilidi.o2o.appvo;

import java.io.Serializable;

import com.yilidi.o2o.core.model.BaseVO;
import com.yilidi.o2o.core.utils.JsonUtils;

/**
 * 
 * @Description:TODO(APP端VO基类)
 * @author: chenlian
 * @date: 2015年12月15日 上午10:37:58
 * 
 */
public class AppBaseVO extends BaseVO implements Serializable {

    /**
     * @Fields serialVersionUID
     */
    private static final long serialVersionUID = 4971955272559408454L;

    @Override
    public String toString() {
        return JsonUtils.toJsonStringWithDateFormat(this);
    }
}
