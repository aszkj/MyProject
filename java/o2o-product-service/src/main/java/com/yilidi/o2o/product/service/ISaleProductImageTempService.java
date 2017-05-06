/**
 * 文件名称：ISaleProductImageTempService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.SaleProductImageTempDto;

/**
 * 功能描述：临时商品图片接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISaleProductImageTempService {
	/**
	 * 根据前台传过来的saveSaleProductImageTempDtos保存临时商品图片信息
	 * 
	 * @param saveSaleProductImageTempDtos
	 *            临时商品图片Dtos
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void saveSaleProductImageTemps(List<SaleProductImageTempDto> saveSaleProductImageTempDtos)
			throws ProductServiceException;

	/**
	 * 根据前台传过来的tempId和渠道编码删除临时商品图片信息
	 * 
	 * @param tempId
	 *            临时商品图片tempId
	 * @param channelCode
	 *            临时商品图片渠道编码
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void deleteSaleProductImageTemps(Integer tempId, String channelCode) throws ProductServiceException;

	/**
	 * 更新某临时商品其中一张图片 根据前台传过来的图片id更新临时商品图片信息
	 * 
	 * @param updateSaleProductImageTempDto
	 *            临时商品图片Dto
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void updateSaleProductImageTemp(SaleProductImageTempDto updateSaleProductImageTempDto) throws ProductServiceException;

	/**
	 * 更新某一临时商品的图片 根据前台传过来的临时商品id更新临时商品图片信息
	 * 
	 * @param updateSaleProductImageTempDtos
	 *            临时商品图片Dtos
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void updateSaleProductImageTemps(List<SaleProductImageTempDto> updateSaleProductImageTempDtos)
			throws ProductServiceException;

	/**
	 * 根据临时商品Id和渠道查询临时商品的图片
	 * 
	 * @param saleProductId
	 *            临时商品Id
	 * @param channelCode
	 *            临时商品渠道编码
	 * @throws ProductServiceException
	 *             产品域服务异常
	 * @return 临时商品图片列表
	 */
	List<SaleProductImageTempDto> listSaleProductImageTempsBySaleProductIdAndChannelCode(Integer saleProductId,
			String channelCode) throws ProductServiceException;

}