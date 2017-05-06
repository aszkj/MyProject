package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.Advertisement;
import com.yilidi.o2o.product.service.dto.query.AdvertisementQuery;

/**
 * 功能描述：广告管理数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface AdvertisementMapper {

    /**
     * 保存广告信息
     * 
     * @param record
     *            广告信息对象
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_ADVERTISEMENT })
    Integer save(Advertisement record);

    /**
     * 根据Id更新广告内容
     * 
     * @param record
     *            广告记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_ADVERTISEMENT })
    Integer updateByIdSelective(Advertisement record);

    /**
     * 根据Id更新广告的状态
     * 
     * @param id
     *            广告Id
     * @param statusCode
     *            广告状态
     * @param modifyUserId
     *            更新人id
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_ADVERTISEMENT })
    Integer updateStatus(@Param("id") Integer id, @Param("statusCode") String statusCode,
            @Param("modifyUserId") Integer modifyUserId);

    /**
     * 更新广告的点击次数
     * 
     * @param id
     *            广告id
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_ADVERTISEMENT })
    Integer updateClickCount(@Param("id") Integer id);

    /**
     * 根据id查询广告记录
     * 
     * @param id
     *            广告id
     * @return 广告记录
     */
    // @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_ADVERTISEMENT })
    Advertisement loadById(@Param("id") Integer id);

    /**
     * 根据广告类型编码查询广告记录
     * 
     * @param typeCode
     *            广告类型编码
     * @return 广告列表
     */
    // @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_ADVERTISEMENT })
    List<Advertisement> listByTypeCode(String typeCode);

    /**
     * 根据条件查询广告记录
     * 
     * @param query
     *            查询条件对象
     * @return 广告列表
     */
    // @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_ADVERTISEMENT })
    List<Advertisement> list(AdvertisementQuery query);
    
    /**
     * 根据条件分页查询广告记录
     * 
     * @param query
     *            查询条件对象
     * @return 广告列表
     */
    // @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_ADVERTISEMENT })
    Page<Advertisement> findAdvertisements(AdvertisementQuery query);
}