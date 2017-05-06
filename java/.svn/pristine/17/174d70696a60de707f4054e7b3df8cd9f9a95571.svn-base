package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ProductFavorite;
import com.yilidi.o2o.product.model.query.ProductFavoriteQuery;

/**
 * 功能描述：商品收藏数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductFavoriteMapper {

	/**
	 * 保存用户收藏
	 * 
	 * @param record
	 *            用户收藏信息
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_FAVORITE })
	Integer save(ProductFavorite record);

	/**
	 * 根据Id删除收藏
	 * 
	 * @param id
	 *            收藏ID
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_FAVORITE })
	Integer deleteById(Integer id);

	/**
	 * 根据用户ID查询该用户的收藏
	 * 
	 * <pre>
	 * 注：使用缓存查询数据
	 * </pre>
	 * 
	 * @param userId
	 *            用户id
	 * @return 用户收藏列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_FAVORITE })
	List<ProductFavorite> listByUserId(Integer userId);
	
	/**
     * 根据条件查询产品收藏信息列表
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param record
     *            产品收藏查询实体，
     * @return 产品收藏信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_FAVORITE })
    Page<ProductFavorite> findProductFavorites(ProductFavoriteQuery record);
    /**
     * 根据用户id和产品id取消收藏的商品
     * @param productId
     * @param userId
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_FAVORITE })
    void deleteByByProductIdAndUserId(@Param("productId")Integer productId, @Param("userId")Integer userId);
    /**
     * 根据用户id和产品id获取收藏的商品
     * @param userId
     * @param productId
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_FAVORITE })
    ProductFavorite loadProductFavoriteByUserIdAndProductId(@Param("userId")Integer userId, @Param("productId")Integer productId);
    

}