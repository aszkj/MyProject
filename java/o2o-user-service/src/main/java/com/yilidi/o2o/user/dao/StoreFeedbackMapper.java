package com.yilidi.o2o.user.dao;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.StoreFeedback;

/**
 * @Description: TODO(店铺意见反馈Mapper)
 * @author: chenlian
 * @date: 2016年6月21日 上午10:42:53
 */
public interface StoreFeedbackMapper {

    /**
     * @Description TODO(新增店铺意见反馈)
     * @param StoreFeedback
     * @return Integer
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_FEEDBACK })
    Integer save(StoreFeedback StoreFeedback);

}
