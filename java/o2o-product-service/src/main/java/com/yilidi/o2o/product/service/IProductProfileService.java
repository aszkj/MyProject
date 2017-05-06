/**
 * 文件名称：IProductProfileService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.ProductProfileDto;

/**
 * 功能描述：产品服务接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IProductProfileService {

	/**
	 * 根据产品id和渠道编码查询产品描述信息
	 * 
	 * @param productId
	 *            产品id
	 * @param channelCode
	 *            渠道编码
	 * @return 产品描述信息
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	ProductProfileDto loadProductProfileByProductIdAndChannelCode(Integer productId, String channelCode)
			throws ProductServiceException;

	/**
	 * 根据前台传过来的saveProductDescDto保存产品描述信息
	 * 
	 * @param saveProductDescDto
	 *            产品id
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void saveProductProfile(ProductProfileDto saveProductDescDto) throws ProductServiceException;

	/**
	 * 根据前台传过来的ProductProfileDto更新产品信息
	 * 
	 * @param updateProductProfileDto
	 *            产品productDto
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void updateProductProfile(ProductProfileDto updateProductProfileDto) throws ProductServiceException;

	/**
	 * 根据ID和渠道编码更新产品上下架信息
	 * 
	 * @param productId
	 *            产品productId
	 * @param saleStatus
	 *            产品上下架状态
	 * @param channelCode
	 *            产品渠道编码
	 * @param modifyUserId
	 *            产品更新人
	 * @param modifyTime
	 *            产品更新时间
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void updateSaleStatusByProductIdAndChannelCode(Integer productId, String saleStatus, String channelCode,
			Integer modifyUserId, Date modifyTime) throws ProductServiceException;

	/**
	 * 根据ID和渠道编码更新产品上下架信息
	 * 
	 * @param productId
	 *            产品productId
	 * @param hotSaleFlag
	 *            产品热卖状态
	 * @param channelCode
	 *            产品渠道编码
	 * @param modifyUserId
	 *            产品更新人
	 * @param modifyTime
	 *            产品更新时间
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void updateHotSaleFlagByProductIdAndChannelCode(Integer productId, String hotSaleFlag, String channelCode,
			Integer modifyUserId, Date modifyTime) throws ProductServiceException;

}