/**
 * 文件名称：IProductPriceService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.ProductPriceDto;

/**
 * 功能描述：产品价格服务接口定义类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IProductPriceService {
	/**
	 * 保存产品的价格信息
	 * 
	 * @param saveProductPriceDto
	 *            价格信息dto
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void saveProductPrice(ProductPriceDto saveProductPriceDto) throws ProductServiceException;

	/**
	 * 更新产品的价格信息
	 * 
	 * @param updateProductPriceDto
	 *            价格信息dto
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void updateProductPrice(ProductPriceDto updateProductPriceDto) throws ProductServiceException;

	/**
	 * 根据产品id和下单用户id获取产品的价格
	 * 
	 * @param saleProductId
	 *            产品id
	 * @param retailerId
	 *            零售商id
	 * @return 产品价格信息
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	ProductPriceDto loadProductPriceByProductIdAndUserId(Integer saleProductId, Integer retailerId)
			throws ProductServiceException;

	/**
	 * 根据产品id和渠道编码获取产品的价格
	 * 
	 * @param productId
	 *            产品id
	 * @param channelCode
	 *            渠道编码
	 * @return 产品价格信息
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	ProductPriceDto loadProductPriceByProductIdAndChannelCode(Integer productId, String channelCode)
			throws ProductServiceException;

}
