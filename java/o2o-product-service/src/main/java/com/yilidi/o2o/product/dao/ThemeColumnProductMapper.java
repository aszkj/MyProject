package com.yilidi.o2o.product.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ThemeColumnProduct;
import com.yilidi.o2o.product.model.combination.ProductRelatedInfo;
import com.yilidi.o2o.product.model.combination.ThemeColumnProductInfo;

/**
 * 专题栏目与产品关联关系Mapper
 * 
 * @author: chenlian
 * @date: 2016年9月10日 下午3:56:09
 */
public interface ThemeColumnProductMapper {

    /**
     * 保存专题栏目与产品关联关系
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_THEMECOLUMN_PRODUCT })
    Integer save(ThemeColumnProduct record);

    /**
     * 根据id删除记录
     * 
     * @param id
     *            记录id
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_THEMECOLUMN_PRODUCT })
    Integer deleteById(Integer id);

    /**
     * 根据专题栏目ID删除记录
     * 
     * @param themeColumnId
     *            专题栏目ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_THEMECOLUMN_PRODUCT })
    Integer deleteByThemeColumnId(Integer themeColumnId);

    /**
     * 根据id加载记录信息
     * 
     * @param id
     *            记录id
     * @return 专题栏目与产品关联关系记录
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_THEMECOLUMN_PRODUCT })
    ThemeColumnProduct loadById(Integer id);

    /**
     * 根据专题栏目ID获取其所关联的产品相关信息列表
     * 
     * @param themeColumnId
     *            专题栏目ID
     * @return 专题栏目与产品关联关系列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_THEMECOLUMN_PRODUCT })
    List<ThemeColumnProduct> listByThemeColumnId(Integer themeColumnId);

    /**
     * 根据专题栏目查询信息获取其所关联的产品相关信息列表
     * 
     * @param themeColumnProductInfo
     *            专题栏目与产品关联关系查询信息
     * @return 专题栏目ID所关联的产品相关信息列表
     */
    List<ProductRelatedInfo> listProductInfosByThemeColumnId(ThemeColumnProductInfo themeColumnProductInfo);

}