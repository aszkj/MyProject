package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.Theme;
import com.yilidi.o2o.product.model.query.ThemeQuery;

/**
 * 专题Mapper
 * 
 * @author: chenlian
 * @date: 2016年8月19日 下午3:14:56
 */
public interface ThemeMapper {

    /**
     * 新增专题信息
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_THEME })
    Integer save(Theme record);

    /**
     * 根据id更新专题信息（如果字段值为null，则不更新该字段）
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_THEME })
    Integer updateByIdSelective(Theme record);

    /**
     * 根据id加载专题信息
     * 
     * @param id
     *            记录id
     * @return 专题信息记录
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_THEME })
    Theme loadById(@Param("id") Integer id);

    /**
     * 根据专题类型编码加载专题信息
     * 
     * @param typeCode
     *            专题类型编码
     * @return 专题信息记录
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_THEME })
    Theme loadByTypeCode(@Param("typeCode") String typeCode);

    /**
     * 分页获取专题信息列表
     * 
     * @param themeQuery
     *            专题查询实体
     * @return 专题信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_THEME })
    Page<Theme> findThemes(ThemeQuery themeQuery);
    /**
     * 获取专题信息列表
     * @param themeQuery
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_THEME })
    List<Theme> listThemes(ThemeQuery themeQuery);

}