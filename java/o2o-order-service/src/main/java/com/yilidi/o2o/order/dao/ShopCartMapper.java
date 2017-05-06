package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.ShopCart;
import com.yilidi.o2o.order.service.dto.query.ShopCartQuery;

/**
 * 功能描述：购物车数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ShopCartMapper {

    /**
     * 添加购物车
     * 
     * @param record
     *            购物车商品信息
     * @return 影响行数
     */
    Integer save(ShopCart record);

    /**
     * 批量添加购物车
     * 
     * @param shopCartList
     *            购物车列表
     * @return 影响行数
     */
    Integer saveBatch(@Param("shopCartList") List<ShopCart> shopCartList);

    /**
     * 根据id删除购物车中的商品信息
     * 
     * @param id
     *            id
     * @return 影响行数
     */
    Integer deleteById(@Param("id") Integer id);

    /**
     * 根据用户id删除购物车中该用户的保存的信息
     * 
     * @param userId
     *            用户id
     * @return 影响行数
     */
    Integer deleteByUserId(Integer userId);

    /**
     * 根据用户ID从购物车中删除指定的商品信息
     * 
     * @param userId
     *            用户id
     * @param saleProductIds
     *            商品ID列表
     * @return 影响行数
     */
    Integer deleteByUserIdAndProductIds(@Param("userId") Integer userId,
            @Param("saleProductIds") List<Integer> saleProductIds);

    /**
     * 根据id加载购物车中商品信息
     * 
     * @param id
     *            id
     * @return 购物车信息
     */
    ShopCart loadById(Integer id);

    /**
     * 查找购物车信息
     * 
     * @param userId
     *            用户ID
     * @param storeId
     *            店铺ID
     * @param saleProductId
     *            商品ID
     * @return ShopCart
     */
    ShopCart loadShopCart(@Param("userId") Integer userId, @Param("storeId") Integer storeId,
            @Param("saleProductId") Integer saleProductId);

    /**
     * 查询购物车列表
     * 
     * @param shopCartQuery
     *            购物车商品查询条件
     * @return List<ShopCart> 购物车商品列表
     */
    List<ShopCart> listUserShopCart(ShopCartQuery shopCartQuery);

    /**
     * 修改购物车商品数量
     * 
     * @param shopCart
     *            购物车信息
     * @return 影响行数
     */
    Integer updateUserShopCartNumber(ShopCart shopCart);

    /**
     * 查询购物车列表
     * 
     * @param saleProductIdList
     *            商品列表
     * @param userId
     *            用户ID
     * @param storeId
     *            店铺ID
     * @return List<ShopCart>
     */
    List<ShopCart> listUserShopCartBySaleProductIds(@Param("saleProductIdList") List<Integer> saleProductIdList,
            @Param("userId") Integer userId, @Param("storeId") Integer storeId);
}