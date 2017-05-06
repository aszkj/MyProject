/**
 * 文件名称：ISaleProductPriceService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.SaleProductPriceDto;


/**
 * 功能描述：商品价格接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public interface ISaleProductPriceService {
	/**
	 * 保存商品的价格信息
	 * 
	 * @param saveSaleProductPriceDto
	 *            价格信息dto
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void saveSaleProductPrice(SaleProductPriceDto saveSaleProductPriceDto) throws ProductServiceException;

	/**
	 * 更新商品的价格信息
	 * 
	 * @param updateSaleProductPriceDto
	 *            价格信息dto
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void updateSaleProductPrice(SaleProductPriceDto updateSaleProductPriceDto) throws ProductServiceException;

	/**
	 * 根据商品价格id获取商品的价格
	 * 
	 * @param id
	 *            商品价格id
	 * @return 商品价格信息
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	SaleProductPriceDto loadSaleProductPriceById(Integer id)
			throws ProductServiceException;
	/**
	 * 根据商品id和渠道编码获取商品的价格
	 * 
	 * @param saleProductId
	 *            商品id
	 * @param channelCode
	 *            渠道编码
	 * @return 商品价格信息
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	SaleProductPriceDto loadSaleProductPriceBySaleProductIdAndChannelCode(Integer saleProductId, String channelCode)
			throws ProductServiceException;
}