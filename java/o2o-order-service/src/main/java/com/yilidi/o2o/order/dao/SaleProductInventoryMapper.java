package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.order.model.SaleProductInventory;
import com.yilidi.o2o.order.model.query.SaleProductInventoryQuery;
import com.yilidi.o2o.order.model.result.SimpleSaleProductInventory;

/**
 * 功能描述：商品库存数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleProductInventoryMapper {

    /**
     * 保存商品的库存信息
     * 
     * @param record
     *            库存记录
     * @return 影响的行数
     */
    Integer save(SaleProductInventory record);

    /**
     * 更新库存数量
     * 
     * @param id
     *            库存ID
     * @param delta
     *            库存变化量
     * @param modifyUserId
     *            最后操作用户ID
     * @param modifyTime
     *            最后操作时间
     * @return 影响的行数
     */
    Integer updateRemainCountById(@Param("id") Integer id, @Param("delta") Integer delta,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 更新已订购数量
     * 
     * @param id
     *            库存ID
     * @param orderCount
     *            订购数量变化量
     * @param modifyUserId
     *            最后操作用户ID
     * @param modifyTime
     *            最后操作时间
     * @return 影响行数
     */
    Integer updateOrderedCountById(@Param("id") Integer id, @Param("orderCount") Integer orderCount,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 更新已订购数量
     * 
     * @param saleProductId
     *            商品ID
     * @param orderCount
     *            订购数量变化量
     * @param modifyUserId
     *            最后操作用户ID
     * @param modifyTime
     *            最后操作时间
     * @return 影响行数
     */
    Integer updateOrderedCountBySaleProductId(@Param("saleProductId") Integer saleProductId,
            @Param("orderCount") Integer orderCount, @Param("modifyUserId") Integer modifyUserId,
            @Param("modifyTime") Date modifyTime);

    /**
     * 更新待发货数量
     * 
     * @param id
     *            库存ID
     * @param standByCount
     *            待发货数量的变化量
     * @param modifyUserId
     *            最后操作用户ID
     * @param modifyTime
     *            最后操作时间
     * @return 影响行数
     */
    Integer updateStandByCountById(@Param("id") Integer id, @Param("standByCount") Integer standByCount,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 发货时更新库存信息
     * 
     * @param id
     *            库存ID
     * @param sendCount
     *            发货数量
     * @param modifyUserId
     *            最后操作用户ID
     * @param modifyTime
     *            最后操作时间
     * @return 影响行数
     */
    Integer updateForSendById(@Param("id") Integer id, @Param("sendCount") Integer sendCount,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 根据条件查询商品的库存信息
     * 
     * @param saleProductIds
     *            商品id列表
     * @param storeId
     *            店铺ID
     * @return 商品库存信息列表
     */
    List<SaleProductInventory> listByStoreIdAndSaleProductIds(@Param("storeId") Integer storeId,
            @Param("saleProductIds") List<Integer> saleProductIds);

    /**
     * 根据商品id查询该商品的库存信息
     * 
     * @param saleProductId
     *            商品id
     * @param storeId
     *            店铺ID
     * @return 商品库存信息
     */
    SaleProductInventory loadByStoreIdAndSaleProductId(@Param("storeId") Integer storeId,
            @Param("saleProductId") Integer saleProductId);

    /**
     * 接单时更新待发货数量
     * 
     * @param saleProductId
     *            商品id
     * @param standbyCount
     *            待发货数量
     * @param modifyUserId
     *            最后操作用户ID
     * @param modifyTime
     *            最后操作时间
     * @return Integer 影响条数
     */
    Integer updateStandbyCountForAccept(@Param("saleProductId") Integer saleProductId,
            @Param("standbyCount") Integer standbyCount, @Param("modifyUserId") Integer modifyUserId,
            @Param("modifyTime") Date modifyTime);

    /**
     * 取消时更新订购数量
     * 
     * @param saleProductId
     *            商品id
     * @param returnCount
     *            返还数量
     * @param modifyUserId
     *            最后操作用户ID
     * @param modifyTime
     *            最后操作时间
     * @return Integer 影响条数
     */
    Integer updateOrderedCountForCancel(@Param("saleProductId") Integer saleProductId,
            @Param("returnCount") Integer returnCount, @Param("modifyUserId") Integer modifyUserId,
            @Param("modifyTime") Date modifyTime);

    /**
     * 发货时更新库存数量、待发货数量、已订购数量
     * 
     * @param saleProductId
     *            商品id
     * @param sendCount
     *            发货数量
     * @param modifyUserId
     *            最后操作用户ID
     * @param modifyTime
     *            最后操作时间
     * @return Integer 影响条数
     */
    Integer updateAllCountForSend(@Param("saleProductId") Integer saleProductId, @Param("sendCount") Integer sendCount,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 更新库存数量
     * 
     * @param saleProductId
     *            商品id
     * @param delta
     *            库存变化量
     * @param modifyUserId
     *            最后操作用户ID
     * @param modifyTime
     *            最后操作时间
     * @return 影响的行数
     */
    Integer updateRemainCountBySaleProductId(@Param("saleProductId") Integer saleProductId, @Param("delta") Integer delta,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 查询出店铺下所有的商品库存简单信息列表
     * 
     * @param storeId
     *            店铺ID
     * @return 商品库存简单信息列表
     */
    List<SimpleSaleProductInventory> listSimpleSaleProductInventoryByStoreId(@Param("storeId") Integer storeId);

    /**
     * 根据商品ID列表分页获取商品库存信息
     * 
     * @param saleProductInventoryQuery
     * @return Page<SimpleSaleProductInventory>
     */
    Page<SimpleSaleProductInventory> findInventoriesBySaleProductIds(SaleProductInventoryQuery saleProductInventoryQuery);

    /**
     * 待发货状态时取消订单更新待已订购数量和待发货数量
     * 
     * @param saleProductId
     *            商品id
     * @param cancelCount
     *            取消数量
     * @param modifyUserId
     *            最后操作用户ID
     * @param modifyTime
     *            最后操作时间
     * @return Integer 影响条数
     */
    Integer updateOrderCountAndStandbyCountForAcceptCancel(@Param("saleProductId") Integer saleProductId,
            @Param("cancelCount") Integer cancelCount, @Param("modifyUserId") Integer modifyUserId,
            @Param("modifyTime") Date modifyTime);

}