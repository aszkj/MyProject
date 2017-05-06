/**
 * 文件名称：ISaleProductImageHistoryService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.SaleProductImageHistoryDto;

/**
 * 功能描述：商品图片历史接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISaleProductImageHistoryService {

	/**
	 * 根据前台传过来的ProductImageDto保存商品图片信息
	 * 
	 * @param saveSaleProductImageHistoryDtos
	 *            商品图片Dtos
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void saveSaleProductImageHistorys(List<SaleProductImageHistoryDto> saveSaleProductImageHistoryDtos)
			throws ProductServiceException;
	/**
	 * 根据前台传过来的saveSaleProductImageHistoryDto保存商品一张图片信息
	 * 
	 * @param saveSaleProductImageHistoryDto
	 *            商品图片Dtos
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void saveSaleProductImageHistory(SaleProductImageHistoryDto saveSaleProductImageHistoryDto)
			throws ProductServiceException;

	/**
	 * 查询某一商品的图片 根据前台传过来的商品id查询商品图片信息
	 * 
	 * @param querySaleProductImageHistoryDtos
	 *            商品图片Dtos
	 * @throws ProductServiceException
	 *             产品域服务异常
	 * @return 商品图片列表
	 */
	List<SaleProductImageHistoryDto> listSaleProductImageHistoryBySaleProductId(
			List<SaleProductImageHistoryDto> querySaleProductImageHistoryDtos) throws ProductServiceException;

	/**
	 * 根据商品Id和渠道查编码询商品的图片
	 * 
	 * @param saleProductId
	 *            商品Id
	 * @param channelCode
	 *            商品渠道编码
	 * @throws ProductServiceException
	 *             产品域服务异常
	 * @return 商品图片列表
	 */
	List<SaleProductImageHistoryDto> listProductImageHistorysBySaleProductIdAndChannelCode(Integer saleProductId,
			String channelCode) throws ProductServiceException;
}