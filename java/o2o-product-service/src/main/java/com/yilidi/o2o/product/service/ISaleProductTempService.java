/**
 * 文件名称：ISaleProductTempService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.SaleProductTempDto;

/**
 * 功能描述：临时商品服务接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISaleProductTempService {

	/**
	 * 根据前台传过来的saleProductTempDto保存临时商品基础信息(卖家修改用)
	 * 
	 * @param saveSaleProductDto
	 *            临时商品信息
	 * @param channelCode
	 *            渠道编码
	 * @param modifyUserId
	 *            修改人modifyUserId
	 * @param modifyTime
	 *            修改时间modifyTime
	 * @return 保存错误信息
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	String saveSaleProductTemp(SaleProductDto saveSaleProductDto, String channelCode, Integer modifyUserId, Date modifyTime)
			throws ProductServiceException;

	/**
	 * 根据前台传过来的deleteId删除临时商品基础信息(卖家修改用)
	 * 
	 * @param deleteId
	 *            临时商品信息Id
	 * @param channelCode
	 *            渠道编码
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void deleteSaleProductTemp(Integer deleteId, String channelCode) throws ProductServiceException;

	/**
	 * 根据id查询临时商品基础信息
	 * 
	 * @param tempId
	 *            临时商品tempId
	 * @throws ProductServiceException
	 *             产品域服务异常
	 * @return 临时商品基础信息
	 */
	SaleProductTempDto loadSaleProductTempBasicInfoById(Integer tempId) throws ProductServiceException;

	/**
	 * 根据saleProductId和渠道编码查询临时商品基础信息
	 * 
	 * @param saleProductId
	 *            临时商品Id
	 * @param channelCode
	 *            渠道编码
	 * @throws ProductServiceException
	 *             产品域服务异常
	 * @return 临时商品基础信息
	 */
	SaleProductTempDto loadSaleProductTempBasicInfoByIdAndChannelCode(Integer saleProductId, String channelCode)
			throws ProductServiceException;

	/**
	 * 根据saleProductId和渠道编码查询临时商品信息（包括图片信息）
	 * 
	 * @param saleProductId
	 *            临时商品Id
	 * @param channelCode
	 *            渠道编码
	 * @throws ProductServiceException
	 *             产品域服务异常
	 * @return 临时商品信息
	 */
	SaleProductDto loadSaleProductTempByIdAndChannelCode(Integer saleProductId, String channelCode)
			throws ProductServiceException;

	/**
	 * 根据saleProductId和渠道编码审核临时商品信息
	 * 
	 * @param auditSaleProductDto
	 *            临时商品auditSaleProductDto
	 * @param channelCode
	 *            渠道编码
	 * @param auditUserId
	 *            审核人id
	 * @param auditTime
	 *            审核时间
	 * @throws ProductServiceException
	 *             产品域服务异常
	 * @return 错误信息
	 */
	String auditSaleProductTemp(SaleProductDto auditSaleProductDto, String channelCode, Integer auditUserId, Date auditTime)
			throws ProductServiceException;
}
