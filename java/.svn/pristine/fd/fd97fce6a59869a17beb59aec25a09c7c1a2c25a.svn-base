/**
 * 文件名称：ISaleProductProfileHistoryService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.SaleProductProfileHistoryDto;

/**
 * 功能描述：商品历史描述接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISaleProductProfileHistoryService {
	/**
	 * 根据商品id和渠道编码查询商品历史描述信息
	 * 
	 * @param saleProductId
	 *            商品id
	 * @param channelCode
	 *            渠道编码
	 * @return 商品历史描述信息列表
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	List<SaleProductProfileHistoryDto> listSaleProductProfileHistoryBySaleProductIdAndChannelCode(Integer saleProductId,
			String channelCode) throws ProductServiceException;

	/**
	 * 根据前台传过来的saveProductDescDto保存商品历史描述信息
	 * 
	 * @param saveSaleProductDescHistoryDto
	 *            商品id
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void saveSaleProductProfileHistory(SaleProductProfileHistoryDto saveSaleProductDescHistoryDto)
			throws ProductServiceException;
}
