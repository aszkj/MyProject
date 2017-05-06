/**
 * 文件名称：OrderService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service;

import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.service.dto.CreateOrderDto;
import com.yilidi.o2o.order.service.dto.SettlementOrderDto;
import com.yilidi.o2o.order.service.dto.ShopCartDto;
import com.yilidi.o2o.order.service.dto.query.ShopCartQuery;

/**
 * 功能描述：购物车<br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IShopCartService {

    /**
     * 确认购物车
     * 
     * @param shopCartQueryList
     *            购物车查询条件封装类
     * @param storeId
     *            店铺ID
     * @param userId
     *            用户ID
     * @param customerId
     *            客户ID
     * @return List<ShopCartDto>
     * @throws OrderServiceException
     *             订单服务异常
     */
    List<ShopCartDto> updateConfirmCart(List<ShopCartQuery> shopCartQueryList, Integer storeId, Integer userId,
            Integer customerId) throws OrderServiceException;

    /**
     * 同步购物车
     * 
     * @param shopCartQueryList
     *            购物车查询条件封装类
     * @param storeId
     *            店铺ID
     * @param userId
     *            用户ID
     * @return List<ShopCartDto>
     * @throws OrderServiceException
     *             订单服务异常
     */
    List<ShopCartDto> updateSynchronousCart(List<ShopCartQuery> shopCartQueryList, Integer storeId, Integer userId)
            throws OrderServiceException;

    /**
     * 调整购物车数量
     * 
     * @param shopCartDto
     *            商品参数
     * @return 影响行数
     * @throws OrderServiceException
     *             订单域服务异常
     */
    Integer updateAdjustmentCartCount(ShopCartDto shopCartDto) throws OrderServiceException;

    /**
     * 根据用户ID从购物车中删除指定的商品列表
     * 
     * @param userId
     *            用户ID
     * @param saleProductIds
     *            商品ID列表
     * @return Integer
     * @throws OrderServiceException
     *             订单服务异常
     */
    Integer deleteByUserIdAndProductIds(Integer userId, List<Integer> saleProductIds) throws OrderServiceException;

    /**
     * 订单去结算
     * 
     * @param createOrderDto
     *            订单信息
     * @return SettlementOrderDto
     * @throws OrderServiceException
     *             订单域服务异常
     */
    SettlementOrderDto settlementOrder(CreateOrderDto createOrderDto) throws OrderServiceException;

    /**
     * 购物车奖券结算信息
     * 
     * @param createOrderDto
     *            订单信息
     * @return SettlementOrderDto
     * @throws OrderServiceException
     *             订单域服务异常
     */
    SettlementOrderDto settlementOrderTickets(CreateOrderDto createOrderDto) throws OrderServiceException;

    /**
     * 查询购物车列表
     * 
     * @param shopCartQuery
     *            商品查询条件
     * @return List<ShopCart> 购物车商品列表
     * @throws OrderServiceException
     *             订单域服务异常
     */
    List<ShopCartDto> listUserShopCart(ShopCartQuery shopCartQuery) throws OrderServiceException;

    /**
     * 同步调整购物车数量
     * 
     * @param shopCartDto
     *            商品参数
     * @return List<ShopCartDto>
     * @throws OrderServiceException
     *             订单域服务异常
     */
    List<ShopCartDto> updateAsycnChangeCart(ShopCartDto shopCartDto) throws OrderServiceException;

    /**
     * 校验购物车商品
     * 
     * @param shopCartDto
     *            购物车商品信息
     * @return 提示字符串
     * @throws OrderServiceException
     *             订单域服务异常
     */
    String validateShopCartSaleProduct(ShopCartDto shopCartDto) throws OrderServiceException;

    /**
     * 发送同步购物车消息
     * 
     * @param userId
     *            用户ID
     * @param shopCartDtoList
     *            购物车商品列表
     * @throws OrderServiceException
     *             订单服务异常
     */
    public void sendAsycnShopCartMessage(Integer userId, List<ShopCartDto> shopCartDtoList) throws OrderServiceException;
}
