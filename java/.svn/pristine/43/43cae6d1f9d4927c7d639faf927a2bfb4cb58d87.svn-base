/**
 * 文件名称：IProductImageService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.ProductImageDto;

/**
 * 功能描述：产品图片信息服务接口定义类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IProductImageService {

    /**
     * 根据前台传过来的ProductImageDto保存产品图片信息
     * 
     * @param saveProductImageDtos
     *            产品图片Dtos
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void saveProductImages(List<ProductImageDto> saveProductImageDtos) throws ProductServiceException;

    /**
     * 根据前台传过来的ProductImageDto保存单张产品图片信息
     * 
     * @param saveProductImageDto
     *            产品图片Dto
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void saveProductImage(ProductImageDto saveProductImageDto) throws ProductServiceException;

    /**
     * 根据id删除某一张图片信息
     * 
     * @param id
     *            图片信息ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void deleteProductImageById(Integer id) throws ProductServiceException;

    /**
     * 根据产品ID和渠道编码删除某产品的图片信息（该产品所有图片）
     * 
     * @param productId
     *            产品ID
     * @param channelCode
     *            渠道编码
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void deleteProductImageByProductIdAndChannelCode(Integer productId, String channelCode) throws ProductServiceException;

    /**
     * 根据imageUrl1删除某一张图片信息
     * 
     * @param 图片URL1
     *            imageUrl1
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void deleteProductImageByImageUrl1(String imageUrl1) throws ProductServiceException;

    /**
     * 根据id设置主图的标志
     * 
     * @param masterFlag
     *            设置是否为主图
     * @param id
     *            将被设置为主图的图片ID
     * @param modifyUserId
     *            更新者id
     * @param modifyTime
     *            更新时间
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateMasterFlagById(String masterFlag, Date modifyTime, Integer id, Integer modifyUserId)
            throws ProductServiceException;

    /**
     * 根据ID更新图片的排列顺序
     * 
     * @param id
     *            图片id
     * @param imageOrder
     *            排序序号
     * @param modifyUserId
     *            更新者id
     * @param modifyTime
     *            更新时间
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateImageOrderById(Integer id, Integer imageOrder, Date modifyTime, Integer modifyUserId)
            throws ProductServiceException;

    /**
     * 更新某产品其中一张图片 根据前台传过来的图片id更新产品图片信息
     * 
     * @param updateProductImageDto
     *            产品图片Dto
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateProductImage(ProductImageDto updateProductImageDto) throws ProductServiceException;

    /**
     * 更新某一产品的图片信息
     * 
     * @param updateProductImageDtos
     *            产品图片Dtos
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateProductImages(List<ProductImageDto> updateProductImageDtos) throws ProductServiceException;

    /**
     * 查询某一产品的某一张图片 根据前台传过来的产品图片id查询该产品图片信息
     * 
     * @param id
     *            产品图片ID
     * @throws ProductServiceException
     *             产品域服务异常
     * @return 产品图片
     */
    ProductImageDto loadProductImageById(Integer id) throws ProductServiceException;

    /**
     * 根据产品Id和渠道查询产品的图片
     * 
     * @param productId
     *            产品Id
     * @param channelCode
     *            产品渠道编码
     * @throws ProductServiceException
     *             产品域服务异常
     * @return 产品图片列表
     */
    List<ProductImageDto> listProductImagesByProductIdAndChannelCode(Integer productId, String channelCode)
            throws ProductServiceException;
}
