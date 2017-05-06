/**
 * 文件名称：ISalesaleProductProfileService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.SaleProductProfileDto;

/**
 * 功能附属：商品附属接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISaleProductProfileService {

    /**
     * 根据商品id和渠道编码查询商品附属信息
     * 
     * @param saleProductId
     *            商品id
     * @param saleStatus
     *            上下架状态
     * @param channelCode
     *            渠道编码
     * @return 商品附属信息
     * @throws ProductServiceException
     *             商品域服务异常
     */
    SaleProductProfileDto loadSaleProductProfileBySaleProductIdAndChannelCode(Integer saleProductId, String saleStatus,
            String channelCode) throws ProductServiceException;

    /**
     * 根据商品条形码以及店铺Id和渠道编码查询商品附属信息
     * 
     * @param barCode
     *            商品条形码
     * @param storeId
     *            店铺id
     * @param channelCode
     *            渠道编码
     * @return 商品附属信息
     * @throws ProductServiceException
     *             商品域服务异常
     */
    SaleProductProfileDto loadSaleProductProfileByBarCodeAndChannelCode(String barCode, Integer storeId, String channelCode)
            throws ProductServiceException;

    /**
     * 根据前台传过来的savesaleProductProfileDto保存商品附属信息
     * 
     * @param saveSaleProductProfileDto
     *            商品id
     * @throws ProductServiceException
     *             商品域服务异常
     */
    void saveSaleProductProfile(SaleProductProfileDto saveSaleProductProfileDto) throws ProductServiceException;

    /**
     * 根据前台传过来的saleProductProfileDto更新商品信息
     * 
     * @param updateSaleProductProfileDto
     *            商品saleProductDto
     * @throws ProductServiceException
     *             商品域服务异常
     */
    void updateSaleProductProfile(SaleProductProfileDto updateSaleProductProfileDto) throws ProductServiceException;

    /**
     * 根据ID和渠道编码更新商品上下架信息
     * 
     * @param saleProductId
     *            商品productId
     * @param saleStatus
     *            商品上下架状态
     * @param channelCode
     *            商品渠道编码
     * @param modifyUserId
     *            商品更新人
     * @param modifyTime
     *            商品更新时间
     * @throws ProductServiceException
     *             商品域服务异常
     */
    void updateSaleStatusBySaleProductIdAndChannelCode(Integer saleProductId, String saleStatus, String channelCode,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException;

    /**
     * 根据ID和渠道编码更新商品上下架信息
     * 
     * @param saleProductId
     *            商品saleProductId
     * @param hotSaleFlag
     *            商品热卖状态
     * @param channelCode
     *            商品渠道编码
     * @param modifyUserId
     *            商品更新人
     * @param modifyTime
     *            商品更新时间
     * @throws ProductServiceException
     *             商品域服务异常
     */
    void updateHotSaleFlagBySaleProductIdAndChannelCode(Integer saleProductId, String hotSaleFlag, String channelCode,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException;

    /**
     * 根据saleProductId更新商品的顺序
     * 
     * @param saleProductId
     *            商品saleProductId
     * @param displayOrder
     *            商品displayOrder
     * @param channelCode
     *            商品渠道编码
     * @param modifyUserId
     *            商品modifyUserId
     * @param modifyTime
     *            商品modifyTime
     * @return 是否更新成功
     * @throws ProductServiceException
     *             产品域服务异常
     */
    boolean updateSaleProductDisplayOrder(Integer saleProductId, Integer displayOrder, String channelCode,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException;

    /**
     * 根据barCode和渠道编码更新商品的商品顺序
     * 
     * @param barCode
     *            商品顺序map列表
     * @param displayOrder
     *            商品顺序
     * @param storeId
     *            商店Id
     * @param modifyUserId
     *            修改人
     * @param modifyTime
     *            修改时间
     * @param channelCode
     *            渠道编码
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateDisplayOrderByBarCodeAndChannelCode(String barCode, Integer displayOrder, Integer storeId,
            Integer modifyUserId, Date modifyTime, String channelCode) throws ProductServiceException;

    /**
     * @Description TODO(卖家批量设置商品上下架)
     * @param saleProductIdList
     * @param saleStatus
     * @param channelCode
     * @param modifyUserId
     * @param modifyTime
     * @throws ProductServiceException
     */
    void updateSaleStatusBatchBySeller(List<Integer> saleProductIdList, String saleStatus, String channelCode,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException;

}