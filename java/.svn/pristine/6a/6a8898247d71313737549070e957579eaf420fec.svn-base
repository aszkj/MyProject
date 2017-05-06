package com.yilidi.o2o.product.dao;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.Activity;

/**
 * 功能描述：活动数据层操作接口类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ActivityMapper {

    /**
     * 保存活动基础信息
     * 
     * @param record
     *            活动基础信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_ACTIVITY })
    Integer save(Activity record);

    /**
     * 根据ID删除活动基础信息
     * 
     * @param id
     *            活动ID
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_ACTIVITY })
    Integer deleteById(@Param("id") Integer id);

    /**
     * 根据活动id查询活动基础信息
     * 
     * @param id
     *            活动ID
     * @return 活动信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_ACTIVITY })
    Activity loadById(@Param("id") Integer id);

}