/**
 * 文件名称：SaleProductHistoryService.java
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
import com.yilidi.o2o.product.dao.SaleProductHistoryMapper;
import com.yilidi.o2o.product.model.SaleProductHistory;
import com.yilidi.o2o.product.service.ISaleProductHistoryService;
import com.yilidi.o2o.product.service.ISaleProductImageHistoryService;
import com.yilidi.o2o.product.service.ISaleProductPriceHistoryService;
import com.yilidi.o2o.product.service.ISaleProductProfileHistoryService;
import com.yilidi.o2o.product.service.dto.SaleProductHistoryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:商品历史记录服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("saleProductHistoryService")
public class SaleProductHistoryServiceImpl extends BasicDataService implements ISaleProductHistoryService {
	@Autowired
	private SaleProductHistoryMapper saleProductHistoryMapper;
	@Autowired
	private ISaleProductProfileHistoryService saleProductProfileHistoryService;
	@Autowired
	private ISaleProductPriceHistoryService saleProductPriceHistoryService;
	@Autowired
	private ISaleProductImageHistoryService saleProductImageHistoryService;

	@Override
	public void saveSaleProductHistory(SaleProductHistoryDto saveSaleProductHistoryDto) throws ProductServiceException {
		// 保存商品历史基础信息记录
		saveSaleProductHistoryBasicInfo(saveSaleProductHistoryDto);
		// 保存商品历史描述信息
		saleProductProfileHistoryService.saveSaleProductProfileHistory(saveSaleProductHistoryDto
				.getSaleProductProfileHistoryDto());
		// 保存商品历史价格信息
		saleProductPriceHistoryService
				.saveSaleProductPriceHistory(saveSaleProductHistoryDto.getSaleProductPriceHistoryDto());
		// 保存商品历史图片信息
		saleProductImageHistoryService.saveSaleProductImageHistorys(saveSaleProductHistoryDto
				.getSaleProductImageHistoryDtos());
	}

	@Override
	public void saveSaleProductHistoryBasicInfo(SaleProductHistoryDto saveSaleProductHistoryDto)
			throws ProductServiceException {
		// 保存商品历史基础信息开始
		logger.debug("saveSaleProductHistoryDto -> " + saveSaleProductHistoryDto);
		// 检查商品基础参数对象是否为空
		if (ObjectUtils.isNullOrEmpty(saveSaleProductHistoryDto)) {
			logger.error("SaleProductHistoryService.saveSaleProductHistoryDto => 商品参数为空");
			throw new ProductServiceException("SaleProductHistoryService的saveSaleProductHistory方法参数为空");
		}
		try {
			// 店铺商品ID是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductHistoryDto.getSaleProductId())) {
				logger.error("saveProductPriceHistory.saleProductId => 店铺商品ID参数为空");
				throw new ProductServiceException("店铺商品ID参数为空");
			}
			// 店铺ID是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductHistoryDto.getStoreId())) {
				logger.error("saveSaleProductHistoryDto.storeId => 店铺ID参数为空");
				throw new ProductServiceException("店铺ID参数为空");
			}
			// 商品的产品ID是否为空
			// if (ObjectUtils.isNullOrEmpty(saveSaleProductHistoryDto.getProductId())) {
			// logger.error("saveSaleProductHistoryDto.productId => 商品的产品ID参数为空");
			// throw new ProductServiceException("商品的产品ID参数为空");
			// }
			// 商品名称是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductHistoryDto.getSaleProductName())) {
				logger.error("saveSaleProductHistoryDto.productName => 商品的产品productName为空");
				throw new ProductServiceException("商品的产品productName参数为空");
			}
			// 产品条形码是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductHistoryDto.getBarCode())) {
				logger.error("saveSaleProductHistoryDto.barCode => 商品的产品条形码为空");
				throw new ProductServiceException("商品的产品条形码参数为空");
			}
			// 商品的操作人是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductHistoryDto.getOperateUserId())) {
				logger.error("saveSaleProductHistoryDto.operateUserId => 商品的操作人为空");
				throw new ProductServiceException("商品的操作人参数为空");
			}
			SaleProductHistory saleProductHistory = new SaleProductHistory();
			saleProductHistory.setSaleProductId(saveSaleProductHistoryDto.getSaleProductId());
			saleProductHistory.setStoreId(saveSaleProductHistoryDto.getStoreId());
			saleProductHistory.setProductId(saveSaleProductHistoryDto.getProductId());
			saleProductHistory.setSaleProductName(saveSaleProductHistoryDto.getSaleProductName());
			saleProductHistory.setProductClassCode(saveSaleProductHistoryDto.getProductClassCode());
			saleProductHistory.setBrandCode(saveSaleProductHistoryDto.getBrandCode());
			saleProductHistory.setBarCode(saveSaleProductHistoryDto.getBarCode());
			saleProductHistory.setMarketTime(saveSaleProductHistoryDto.getMarketTime());
			saleProductHistory.setAuditStatusCode(saveSaleProductHistoryDto.getAuditStatusCode());
			saleProductHistory.setEnabledFlag(saveSaleProductHistoryDto.getEnabledFlag());
			saleProductHistory.setOperateUserId(saveSaleProductHistoryDto.getOperateUserId());
			saleProductHistory.setOperateTime(saveSaleProductHistoryDto.getOperateTime());
			saleProductHistory.setOperateType(saveSaleProductHistoryDto.getOperateType());
			saleProductHistoryMapper.saveSaleProductHistory(saleProductHistory);
		} catch (ProductServiceException e) {
			logger.error("保存商品基础历史信息记录出错");
			throw new ProductServiceException("异常：保存商品基础历史信息记录出错");
		}

	}

	@Override
	public SaleProductHistoryDto loadSaleProductHistoryById(Integer id) throws ProductServiceException {
		// TODO Auto-generated method stub
		return null;
	}

}