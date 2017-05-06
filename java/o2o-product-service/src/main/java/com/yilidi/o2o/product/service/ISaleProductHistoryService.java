/**
 * 文件名称：ISaleProductHistoryService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.SaleProductHistoryDto;


/**
 * 功能描述：商品历史记录服务接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public interface ISaleProductHistoryService {
	/**
	 * 根据前台传过来的saveSaleProductHistoryDto保存商品历史信息
	 * 
	 * @param saveSaleProductHistoryDto
	 *            商品信息
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void saveSaleProductHistory(SaleProductHistoryDto saveSaleProductHistoryDto) throws ProductServiceException;
	/**
	 * 根据前台传过来的saveSaleProductHistoryDto保存商品历史信息
	 * 
	 * @param saveSaleProductHistoryDto
	 *            商品信息
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void saveSaleProductHistoryBasicInfo(SaleProductHistoryDto saveSaleProductHistoryDto) throws ProductServiceException;

	/**
	 * 根据id查询商品信息
	 * @param id 商品id
	 * @throws ProductServiceException
	 *             产品域服务异常
	 * @return 商品信息
	 */
	SaleProductHistoryDto loadSaleProductHistoryById(Integer id) throws ProductServiceException;
}