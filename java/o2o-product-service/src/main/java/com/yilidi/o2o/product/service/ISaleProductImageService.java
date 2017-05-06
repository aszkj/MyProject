/**
 * 文件名称：ISaleProductImageService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.SaleProductImageDto;

/**
 * 功能描述：商品图片接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISaleProductImageService {
    /**
     * 根据前台传过来的saveSaleProductImageDtos保存商品图片信息
     * 
     * @param saveSaleProductImageDtos
     *            商品图片Dtos
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void saveSaleProductImages(List<SaleProductImageDto> saveSaleProductImageDtos) throws ProductServiceException;

    /**
     * 根据前台传过来的delSaleProductImageIds批量删除商品图片信息
     * 
     * @param delSaleProductImageIds
     *            商品图片Ids
     * @param delUserId
     *            商品图片删除人
     * @param delTime
     *            商品图片删除时间
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void deleteSaleProductImagesById(List<Integer> delSaleProductImageIds, Integer delUserId, Date delTime)
            throws ProductServiceException;

    /**
     * 根据前台传过来的delSaleProductImageId删除商品图片信息
     * 
     * @param delSaleProductImageId
     *            商品图片Id
     * @param delUserId
     *            商品图片删除人
     * @param delTime
     *            商品图片删除时间
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void deleteSaleProductImageById(Integer delSaleProductImageId, Integer delUserId, Date delTime)
            throws ProductServiceException;

    /**
     * 更新某商品其中一张图片 根据前台传过来的图片id更新商品图片信息
     * 
     * @param updateSaleProductImageDto
     *            商品图片Dto
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateSaleProductImage(SaleProductImageDto updateSaleProductImageDto) throws ProductServiceException;

    /**
     * 更新某一商品的图片 根据前台传过来的商品id更新商品图片信息
     * 
     * @param updateSaleProductImageDtos
     *            商品图片Dtos
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateSaleProductImages(List<SaleProductImageDto> updateSaleProductImageDtos) throws ProductServiceException;

    /**
     * 根据商品Id和渠道查询商品的图片
     * 
     * @param saleProductId
     *            商品Id
     * @param channelCode
     *            商品渠道编码
     * @throws ProductServiceException
     *             产品域服务异常
     * @return 商品图片列表
     */
    List<SaleProductImageDto> listSaleProductImagesBySaleProductIdAndChannelCode(Integer saleProductId, String channelCode)
            throws ProductServiceException;

    /**
     * 根据商品Id和渠道查询商品主图片
     * 
     * @param salesProductId
     *            商品Id
     * @param channelCode
     *            商品渠道编码
     * @return SaleProductImageDto
     */
    SaleProductImageDto loadSaleProductImageMaster(Integer salesProductId, String channelCode);
}