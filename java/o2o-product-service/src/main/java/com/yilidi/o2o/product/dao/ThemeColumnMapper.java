package com.yilidi.o2o.product.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ThemeColumn;

/**
 * 专题栏目Mapper
 * 
 * @author: chenlian
 * @date: 2016年9月9日 下午3:53:11
 */
public interface ThemeColumnMapper {

    /**
     * 保存专题栏目
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_THEME_COLUMN })
    Integer save(ThemeColumn record);

    /**
     * 根据id删除记录
     * 
     * @param id
     *            记录id
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_THEME_COLUMN })
    Integer deleteById(Integer id);

    /**
     * 根据专题ID删除记录
     * 
     * @param themeId
     *            专题ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_THEME_COLUMN })
    Integer deleteByThemeId(Integer themeId);

    /**
     * 根据id加载记录信息
     * 
     * @param id
     *            记录id
     * @return 专题栏目记录
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_THEME_COLUMN })
    ThemeColumn loadById(Integer id);

    /**
     * 根据专题ID获取其所关联的栏目信息列表
     * 
     * @param themeId
     *            专题ID
     * @return 专题栏目列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_THEME_COLUMN })
    List<ThemeColumn> listByThemeId(Integer themeId);

}