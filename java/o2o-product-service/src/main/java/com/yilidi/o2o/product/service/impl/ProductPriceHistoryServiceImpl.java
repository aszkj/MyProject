/**
 * 文件名称：productPriceHistoryService.java
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
import com.yilidi.o2o.product.dao.ProductPriceHistoryMapper;
import com.yilidi.o2o.product.model.ProductPriceHistory;
import com.yilidi.o2o.product.service.IProductPriceHistoryService;
import com.yilidi.o2o.product.service.dto.ProductPriceHistoryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("productPriceHistoryService")
public class ProductPriceHistoryServiceImpl extends BasicDataService implements IProductPriceHistoryService {

	@Autowired
	private ProductPriceHistoryMapper productPriceHistoryMapper;

	@Override
	public void saveProductPriceHistory(ProductPriceHistoryDto saveProductPriceHistoryDto) throws ProductServiceException {
		// 保存产品历史价格表开始
		logger.debug("saveProductPriceHistoryDto -> " + saveProductPriceHistoryDto);
		// 检查产品参数对象是否为空
		if (ObjectUtils.isNullOrEmpty(saveProductPriceHistoryDto)) {
			logger.error("ProductService.saveProductPriceHistoryDto => 产品参数为空");
			throw new ProductServiceException("ProductService的saveProductPriceHistory方法参数为空");
		}
		try {
			// 产品修改后零售价是否为空
			if (ObjectUtils.isNullOrEmpty(saveProductPriceHistoryDto.getRetailPrice())) {
				logger.error("saveProductPriceHistory.retailPrice => 产品修改后零售价参数为空");
				throw new ProductServiceException("产品修改后零售价参数为空");
			}
			// 产品ID是否为空
			if (ObjectUtils.isNullOrEmpty(saveProductPriceHistoryDto.getProductId())) {
				logger.error("saveProductPriceHistory.productId => 产品修改前零售价参数为空");
				throw new ProductServiceException("产品ID参数为空");
			}
			// 产品ProductPriceId是否为空
			if (ObjectUtils.isNullOrEmpty(saveProductPriceHistoryDto.getProductPriceId())) {
				logger.error("saveProductPriceHistory.productPriceId => 产品ProductPriceId为空");
				throw new ProductServiceException("产品ProductPriceId参数为空");
			}
			ProductPriceHistory productPriceHistory = new ProductPriceHistory();
			ObjectUtils.fastCopy(saveProductPriceHistoryDto, productPriceHistory);
			productPriceHistoryMapper.saveProductPriceHistory(productPriceHistory);
		} catch (ProductServiceException e) {
			logger.error("保存产品历史价格出错");
			throw new ProductServiceException("异常：保存产品历史价格出错");
		}
	}

}
