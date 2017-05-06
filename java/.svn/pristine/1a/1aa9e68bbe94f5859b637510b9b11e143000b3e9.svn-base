/**
 * 文件名称：OrderService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.order.service.dto.AcceptOrderItemDto;
import com.yilidi.o2o.order.service.dto.CancelOrderItemDto;
import com.yilidi.o2o.order.service.dto.CreateOrderItemDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderItemDto;
import com.yilidi.o2o.order.service.dto.PurchaseOrderItemDto;
import com.yilidi.o2o.order.service.dto.SaleProductInventoryDto;
import com.yilidi.o2o.order.service.dto.SendOrderItemDto;
import com.yilidi.o2o.order.service.dto.StockOutOrderItemDto;
import com.yilidi.o2o.order.service.dto.StoreTotalPrice;
import com.yilidi.o2o.order.service.dto.query.SaleProductInventoryQueryDto;
import com.yilidi.o2o.product.proxy.dto.SaleProductProxyDto;

/**
 * 功能描述：库存<br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISaleProductInventoryService {

    /**
     * 校验商品库存
     * 
     * @param saleProductId
     *            商品ID
     * @param orderCount
     *            订购数量
     * @throws OrderServiceException
     *             交易域服务异常
     */
    void validateRemainCount(Integer saleProductId, Integer orderCount) throws OrderServiceException;

    /**
     * 更新多条库存记录
     * 
     * @param pairs
     *            商品数量
     * @param orderNo
     *            订单编号
     * @param userId
     *            用户ID
     * @param currentTime
     *            操作时间
     * @throws OrderServiceException
     *             交易域服务异常
     */
    void updateOrderedCountBatch(List<KeyValuePair<Integer, Integer>> pairs, String orderNo, Integer userId,
            Date currentTime) throws OrderServiceException;

    /**
     * 订单接单时批量修改库存记录和插入库存变更记录
     * 
     * @param pairs
     *            接单订单明细列表
     * @param orderNo
     *            订单编号
     * @param userId
     *            操作用户ID
     * @param operateTime
     *            操作时间
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateInventoryForSellerAccept(List<KeyValuePair<Integer, Integer>> pairs, String orderNo, Integer userId,
            Date operateTime) throws OrderServiceException;

    /**
     * 卖家订单取消时批量修改库存记录和插入库存变更记录
     * 
     * @param pairs
     *            取消订单明细列表
     * @param saleOrderNo
     *            订单编号
     * @param cancelUserId
     *            取消用户ID
     * @param cancelTime
     *            取消时间
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateInventoryForSellerCancel(List<KeyValuePair<Integer, Integer>> pairs, String saleOrderNo,
            Integer cancelUserId, Date cancelTime) throws OrderServiceException;

    /**
     * 订单已发货时取消订单批量修改库存记录和插入库存变更记录
     * 
     * @param pairs
     *            取消订单明细列表
     * @param saleOrderNo
     *            订单编号
     * @param cancelUserId
     *            取消用户ID
     * @param cancelTime
     *            取消时间
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateInventoryForSendCancel(List<KeyValuePair<Integer, Integer>> pairs, String saleOrderNo,
            Integer cancelUserId, Date cancelTime) throws OrderServiceException;

    /**
     * 卖家订单发货时批量修改库存记录和插入库存变更记录
     * 
     * @param pairs
     *            发货订单明细列表
     * @param saleOrderNo
     *            订单编号
     * @param sendUserId
     *            发货用户ID
     * @param sendTime
     *            发货时间
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateInventoryForSellerSend(List<KeyValuePair<Integer, Integer>> pairs, String saleOrderNo,
            Integer sendUserId, Date sendTime) throws OrderServiceException;

    /**
     * 运营取消待收货状态订单时更新库存和插入库存变更记录
     * 
     * @param pairs
     *            取消订单明细列表
     * @param saleOrderNo
     *            订单号
     * @param cancelUserId
     *            取消用户ID
     * @param cancelTime
     *            取消时间
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateInventoryForReceiveCancel(List<KeyValuePair<Integer, Integer>> pairs, String saleOrderNo,
            Integer cancelUserId, Date cancelTime) throws OrderServiceException;

    /**
     * 调货单创建时批量修改库存记录和插入库存变更记录
     * 
     * @param flittingOrderItemDtoList
     *            调拨单明细列表
     * @param flittingOrderNo
     *            调货单编号
     * @param operateUserId
     *            操作用户ID
     * @param operateTime
     *            操作时间
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateInventoryForFlittingCreate(List<FlittingOrderItemDto> flittingOrderItemDtoList, String flittingOrderNo,
            Integer operateUserId, Date operateTime) throws OrderServiceException;

    /**
     * 调货单接单时批量修改库存记录和插入库存变更记录
     * 
     * @param flittingOrderItemDtoList
     *            调拨单明细列表
     * @param flittingOrderNo
     *            调货单编号
     * @param operateUserId
     *            操作用户ID
     * @param operateTime
     *            操作时间
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateInventoryForFlittingAccept(List<FlittingOrderItemDto> flittingOrderItemDtoList, String flittingOrderNo,
            Integer operateUserId, Date operateTime) throws OrderServiceException;

    /**
     * 调货单拒绝接单时批量修改库存记录和插入库存变更记录
     * 
     * @param flittingOrderItemDtoList
     *            调拨单明细列表
     * @param flittingOrderNo
     *            调货单编号
     * @param operateUserId
     *            操作用户ID
     * @param operateTime
     *            操作时间
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateInventoryForFlittingAcceptReject(List<FlittingOrderItemDto> flittingOrderItemDtoList,
            String flittingOrderNo, Integer operateUserId, Date operateTime) throws OrderServiceException;

    /**
     * 调货单发货时批量修改库存记录和插入库存变更记录
     * 
     * @param flittingOrderItemDtoList
     *            调拨单明细列表
     * @param flittingOrderNo
     *            调货单编号
     * @param operateUserId
     *            操作用户ID
     * @param operateTime
     *            操作时间
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateInventoryForFlittingSend(List<FlittingOrderItemDto> flittingOrderItemDtoList, String flittingOrderNo,
            Integer operateUserId, Date operateTime) throws OrderServiceException;

    /**
     * 调货单完成调拨时批量修改库存记录和插入库存变更记录
     * 
     * @param flittingOrderItemDtoList
     *            调拨单明细列表
     * @param flittingOrderNo
     *            调货单编号
     * @param operateUserId
     *            操作用户ID
     * @param operateTime
     *            操作时间
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateInventoryForFlittingFinish(List<FlittingOrderItemDto> flittingOrderItemDtoList, String flittingOrderNo,
            Integer operateUserId, Date operateTime) throws OrderServiceException;

    /**
     * 采购单审核通过时批量修改库存记录和插入库存变更记录
     * 
     * @param purchaseOrderItemDtoList
     *            调拨单明细列表
     * @param saleProductMap
     *            产品ID跟商品IDmap
     * @param operateUserId
     *            操作用户ID
     * @param operateTime
     *            操作时间
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateInventoryForPurchaseFinish(List<PurchaseOrderItemDto> purchaseOrderItemDtoList,
            Map<Integer, Integer> saleProductMap, Integer operateUserId, Date operateTime) throws OrderServiceException;

    /**
     * 根据店铺ID汇总所有商品的各项金额
     * 
     * @param storeId
     *            店铺ID
     * @return 店铺金额汇总信息
     * @throws OrderServiceException
     *             服务异常
     */
    public StoreTotalPrice sumTotalPriceByStoreId(Integer storeId) throws OrderServiceException;

    /**
     * 根据店铺ID与若干商品ID获取商品库存List
     * 
     * @param storeId
     *            店铺ID
     * @param saleProductIds
     *            商品ID列表
     * @return List<SaleProductInventoryDto> 店铺商品库存列表
     * @throws OrderServiceException
     *             服务异常
     */
    public List<SaleProductInventoryDto> listByStoreIdAndSaleProductIds(Integer storeId, List<Integer> saleProductIds)
            throws OrderServiceException;

    /**
     * 根据商品ID列表分页获取商品库存信息
     * 
     * @param saleProductInventoryQueryDto
     *            商品库存查询DTO
     * @return YiLiDiPage<SaleProductInventoryDto> 商品库存信息
     * @throws OrderServiceException
     *             服务异常
     */
    public YiLiDiPage<SaleProductInventoryDto> findInventoriesBySaleProductIds(
            SaleProductInventoryQueryDto saleProductInventoryQueryDto) throws OrderServiceException;

    /**
     * 出库单审核通过时批量修改库存记录和插入库存变更记录
     * 
     * @param stockOutOrderItemDtoList
     *            出库单商品明细列表
     * @param operateUserId
     *            操作用户ID
     * @param operateTime
     *            操作时间
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateInventoryForStockOutFinish(List<StockOutOrderItemDto> stockOutOrderItemDtoList, Integer operateUserId,
            Date operateTime) throws OrderServiceException;

    /**
     * 发送修改商品冗余库存值消息
     * 
     * @param saleProductIdAndRemainCountDeltaKeys
     *            商品冗余库存键值对列表
     * @param userId
     *            操作用户ID
     * @throws OrderServiceException
     *             订单服务异常
     */
    public void sendSaleProductRemainChangeMessage(List<KeyValuePair<Integer, Integer>> saleProductIdAndRemainCountDeltaKeys,
            Integer userId) throws OrderServiceException;
}
