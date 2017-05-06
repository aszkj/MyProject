package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.AuditProductImageDto;

/**
 * 数据包产品图片Service接口
 * 
 * @author: chenlian
 * @date: 2016年12月12日 下午2:32:52
 */
public interface IAuditProductImageService {

    /**
     * 根据前台传过来的AuditProductImageDto保存产品图片信息
     * 
     * @param saveAuditProductImageDtos
     *            产品图片Dtos
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void saveAuditProductImages(List<AuditProductImageDto> saveAuditProductImageDtos) throws ProductServiceException;

    /**
     * 根据前台传过来的AuditProductImageDto保存单张产品图片信息
     * 
     * @param saveAuditProductImageDto
     *            产品图片Dto
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void saveAuditProductImage(AuditProductImageDto saveAuditProductImageDto) throws ProductServiceException;

    /**
     * 根据id删除某一张图片信息
     * 
     * @param id
     *            图片信息ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void deleteAuditProductImageById(Integer id) throws ProductServiceException;

    /**
     * 根据数据包产品导入批次号删除该批次的所有产品图片
     * 
     * @param batchNo
     *            数据包产品导入批次号
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void deleteAuditProductImageByBatchNo(String batchNo) throws ProductServiceException;

    /**
     * 根据数据包产品ID和渠道编码删除某产品的图片信息（该数据包产品所有图片）
     * 
     * @param auditProductId
     *            数据包产品ID
     * @param channelCode
     *            渠道编码
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void deleteImageByAuditProductIdAndChannelCode(Integer auditProductId, String channelCode)
            throws ProductServiceException;

    /**
     * 根据imageUrl1删除某一张图片信息
     * 
     * @param 图片URL1
     *            imageUrl1
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void deleteAuditProductImageByImageUrl1(String imageUrl1) throws ProductServiceException;

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
     * @param updateAuditProductImageDto
     *            产品图片Dto
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateAuditProductImage(AuditProductImageDto updateAuditProductImageDto) throws ProductServiceException;

    /**
     * 更新某一产品的图片信息
     * 
     * @param updateAuditProductImageDtos
     *            产品图片Dtos
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateAuditProductImages(List<AuditProductImageDto> updateAuditProductImageDtos) throws ProductServiceException;

    /**
     * 查询某一产品的某一张图片 根据前台传过来的产品图片id查询该产品图片信息
     * 
     * @param id
     *            产品图片ID
     * @throws ProductServiceException
     *             产品域服务异常
     * @return 产品图片
     */
    AuditProductImageDto loadAuditProductImageById(Integer id) throws ProductServiceException;

    /**
     * 根据数据包产品Id和渠道查询产品的图片
     * 
     * @param auditProductId
     *            数据包产品Id
     * @param channelCode
     *            产品渠道编码
     * @throws ProductServiceException
     *             产品域服务异常
     * @return 产品图片列表
     */
    List<AuditProductImageDto> listImagesByAuditProductIdAndChannelCode(Integer auditProductId, String channelCode)
            throws ProductServiceException;

    /**
     * 根据数据包产品导入批次号获取产品图片列表
     * 
     * @param batchNo
     *            数据包产品导入批次号
     * @throws ProductServiceException
     *             产品域服务异常
     * @return 产品图片列表
     */
    List<AuditProductImageDto> listImagesByBatchNo(String batchNo) throws ProductServiceException;

}
