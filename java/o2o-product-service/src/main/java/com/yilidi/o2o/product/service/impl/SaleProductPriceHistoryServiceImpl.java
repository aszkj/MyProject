/**
 * 文件名称：SaleProductPriceHistoryService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.SaleProductPriceHistoryMapper;
import com.yilidi.o2o.product.model.SaleProductPriceHistory;
import com.yilidi.o2o.product.service.ISaleProductPriceHistoryService;
import com.yilidi.o2o.product.service.dto.SaleProductPriceHistoryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:商品价格历史记录服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("saleProductPriceHistoryService")
public class SaleProductPriceHistoryServiceImpl extends BasicDataService implements ISaleProductPriceHistoryService {

	@Autowired
	private SaleProductPriceHistoryMapper saleProductPriceHistoryMapper;

	@Override
	public void saveSaleProductPriceHistory(SaleProductPriceHistoryDto saveSaleProductPriceHistoryDto)
			throws ProductServiceException {
		// 保存商品历史价格表开始
		logger.debug("saveSaleProductPriceHistoryDto -> " + saveSaleProductPriceHistoryDto);
		// 检查商品参数对象是否为空
		if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceHistoryDto)) {
			logger.error("SaleProductPriceHistoryService.saveSaleProductPriceHistoryDto => 商品参数为空");
			throw new ProductServiceException("SaleProductPriceHistoryService的saveSaleProductPriceHistoryDto方法参数为空");
		}
		try {
			// 商品saleProductPriceId是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceHistoryDto.getSaleProductPriceId())) {
				logger.error("saveProductPriceHistory.saleProductPriceId => 商品saleProductPriceId为空");
				throw new ProductServiceException("商品saleProductPriceId参数为空");
			}
			// 商品ID是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceHistoryDto.getSaleProductId())) {
				logger.error("saveProductPriceHistory.saleProductId => 商品ID参数为空");
				throw new ProductServiceException("商品ID参数为空");
			}
			// 商品修改后零售价是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceHistoryDto.getRetailPrice())) {
				logger.error("saveProductPriceHistory.retailPrice => 商品修改后零售价参数为空");
				throw new ProductServiceException("商品修改后零售价参数为空");
			}
			// 商品渠道编码是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceHistoryDto.getChannelCode())) {
				logger.error("saveProductPriceHistory.channelCode => 商品渠道编码参数为空");
				throw new ProductServiceException("商品渠道编码参数为空");
			}
			// 商品修改人ID是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceHistoryDto.getOperateUserId())) {
				logger.error("saveProductPriceHistory.operateUserId => 商品修改人ID参数为空");
				throw new ProductServiceException("商品修改人ID参数为空");
			}
			// 商品修改时间是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceHistoryDto.getOperateTime())) {
				logger.error("saveProductPriceHistory.operateTime => 商品修改时间参数为空");
				throw new ProductServiceException("商品修改时间参数为空");
			}
			// 商品修改类型是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceHistoryDto.getOperateType())) {
				logger.error("saveProductPriceHistory.operateType => 商品修改类型参数为空");
				throw new ProductServiceException("商品修改类型参数为空");
			}
			SaleProductPriceHistory saleProductPriceHistory = new SaleProductPriceHistory();
			ObjectUtils.fastCopy(saveSaleProductPriceHistoryDto, saleProductPriceHistory);
			saleProductPriceHistoryMapper.saveSaleProductPriceHistory(saleProductPriceHistory);
		} catch (ProductServiceException e) {
			logger.error("保存商品历史价格出错");
			throw new ProductServiceException("异常：保存商品历史价格出错");
		}
	}

}