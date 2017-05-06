package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.SecKillSaleProductInventory;

/**
 * 功能描述：秒杀商品库存数据层操作接口类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SecKillSaleProductInventoryMapper {

    /**
     * 保存商品的库存信息
     * 
     * @param record
     *            库存记录
     * @return 影响的行数
     */
    Integer save(SecKillSaleProductInventory record);

    /**
     * 更新库存数量
     * 
     * @param id
     *            库存ID
     * @param delta
     *            库存变化量
     * @return 影响的行数
     */
    Integer updateRemainCountById(@Param("id") Integer id, @Param("delta") Integer delta);

    /**
     * 根据商品id查询该商品的库存信息
     * 
     * @param saleProductId
     *            商品id
     * @param activityId
     *            活动ID
     * @return 商品库存信息
     */
    SecKillSaleProductInventory loadByActivityIdAndSaleProductIdForUpdate(@Param("saleProductId") Integer saleProductId,
            @Param("activityId") Integer activityId);

    /**
     * 根据商品id查询该商品的库存信息
     * 
     * @param saleProductId
     *            商品id
     * @param activityId
     *            活动ID
     * @return 商品库存信息
     */
    SecKillSaleProductInventory loadByActivityIdAndSaleProductId(@Param("saleProductId") Integer saleProductId,
            @Param("activityId") Integer activityId);

    /**
     * 根据商品id删除该商品的库存信息
     * 
     * @param saleProductId
     *            商品id
     * @param activityId
     *            活动ID
     * @return 商品库存信息
     */
    SecKillSaleProductInventory deleteByActivityIdAndSaleProductId(@Param("saleProductId") Integer saleProductId,
            @Param("activityId") Integer activityId);

    /**
     * 更新库存数量
     * 
     * @param saleProductId
     *            商品id
     * @param activityId
     *            活动ID
     * @param delta
     *            库存变化量
     * @return 影响的行数
     */
    Integer updateRemainCountBySaleProductIdAndActivityId(@Param("saleProductId") Integer saleProductId,
            @Param("activityId") Integer activityId, @Param("delta") Integer delta);

    /**
     * 根据条件查询商品的库存信息
     * 
     * @param activityId
     *            活动ID
     * @param storeId
     *            店铺ID
     * @param saleProductIds
     *            商品id列表
     * @return 商品库存信息列表
     */
    List<SecKillSaleProductInventory> listByActivityIdAndStoreIdAndSaleProductIds(@Param("activityId") Integer activityId,
            @Param("storeId") Integer storeId, @Param("saleProductIds") List<Integer> saleProductIds);

}