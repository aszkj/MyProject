/**
 * 文件名称：SaleProductProfileHistoryService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.SaleProductProfileHistoryMapper;
import com.yilidi.o2o.product.model.SaleProductProfileHistory;
import com.yilidi.o2o.product.service.ISaleProductProfileHistoryService;
import com.yilidi.o2o.product.service.dto.SaleProductProfileHistoryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:商品历史描述服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("saleProductProfileHistoryService")
public class SaleProductProfileHistoryServiceImpl extends BasicDataService implements ISaleProductProfileHistoryService {
	@Autowired
	private SaleProductProfileHistoryMapper saleProductProfileHistoryMapper;

	@Override
	public List<SaleProductProfileHistoryDto> listSaleProductProfileHistoryBySaleProductIdAndChannelCode(
			Integer saleProductId, String channelCode) throws ProductServiceException {
		// 查询商品历史描述表开始
		logger.debug("saleProductId -> " + saleProductId + "channelCode -> " + channelCode);
		// 检查商品ID参数是否为空
		if (ObjectUtils.isNullOrEmpty(saleProductId)) {
			logger.error("SaleProductProfileHistoryService.saleProductId => 商品参数saleProductId为空");
			throw new ProductServiceException(
					"SaleProductProfileHistoryService的listSaleProductProfileHistoryBySaleProductIdAndChannelCode方法参数saleProductId为空");
		}
		// 检查商品渠道编码参数是否为空
		if (ObjectUtils.isNullOrEmpty(channelCode)) {
            channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
		}
		SaleProductProfileHistoryDto saleProductProfileHistoryDto = null;
		List<SaleProductProfileHistoryDto> saleProductProfileHistoryDtos = new ArrayList<SaleProductProfileHistoryDto>();
		try {
			List<SaleProductProfileHistory> saleProductProfileHistorys = saleProductProfileHistoryMapper
					.listSaleProductProfileHistoryBySaleProductIdAndChannelCode(saleProductId, channelCode);
			// 检查商品对象是否为空
			for (SaleProductProfileHistory saleProductProfileHistory : saleProductProfileHistorys) {
				if (ObjectUtils.isNullOrEmpty(saleProductProfileHistorys)) {
					logger.error("SaleProductProfileHistoryService."
							+ "listSaleProductProfileHistoryBySaleProductIdAndChannelCode => 商品历史描述为空");
					throw new ProductServiceException("商品历史描述为空");
				}
				saleProductProfileHistoryDto = new SaleProductProfileHistoryDto();
				ObjectUtils.fastCopy(saleProductProfileHistory, saleProductProfileHistoryDto);
				saleProductProfileHistoryDtos.add(saleProductProfileHistoryDto);
			}
		} catch (ProductServiceException e) {
			logger.error("查询商品历史描述出错");
			throw new ProductServiceException("异常：查询商品历史描述出错");
		}
		return saleProductProfileHistoryDtos;
	}

	@Override
	public void saveSaleProductProfileHistory(SaleProductProfileHistoryDto saveSaleProductProfileHistoryDto)
			throws ProductServiceException {
		// 保存商品历史描述表开始
		logger.debug("saveSaleProductProfileHistoryDto -> " + saveSaleProductProfileHistoryDto);
		// 检查商品参数对象是否为空
		if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileHistoryDto)) {
			logger.error("SaleProductProfileHistoryService.saveSaleProductProfileHistoryDto => 商品参数为空");
			throw new ProductServiceException("SaleProductProfileHistoryService的saveSaleProductProfileHistory方法参数为空");
		}
		try {
			// 商品描述ID是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileHistoryDto.getSaleProductProfileId())) {
				logger.error("SaleProductProfileHistoryService.saleProductProfileId => 商品描述ID参数为空");
				throw new ProductServiceException("商品描述ID参数为空");
			}
			// 商品ID是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileHistoryDto.getSaleProductId())) {
				logger.error("SaleProductProfileHistoryService.saleProductId => 商品ID参数为空");
				throw new ProductServiceException("商品ID参数为空");
			}
			// 商品渠道编码是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileHistoryDto.getChannelCode())) {
				logger.error("SaleProductProfileHistoryService.channelCode => 保存商品channelCode参数为空");
				throw new ProductServiceException("商品渠道编码channelCode参数为空");
			}
			// 产品归属是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileHistoryDto.getProductOwner())) {
				logger.error("SaleProductProfileHistoryService.productOwner => 保存产品归属productOwner参数为空");
				throw new ProductServiceException("产品归属productOwner参数为空");
			}
			// 商品productSpec是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileHistoryDto.getSaleProductSpec())) {
				logger.error("SaleProductProfileHistoryService.productSpec => 商品productSpec为空");
				throw new ProductServiceException("商品productSpec参数为空");
			}
			// 保存商品operateType是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileHistoryDto.getOperateType())) {
				logger.error("SaleProductProfileHistoryService.operateType => 商品operateType为空");
				throw new ProductServiceException("商品operateType参数为空");
			}
			// 保存商品operateTime是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileHistoryDto.getOperateTime())) {
				logger.error("SaleProductProfileHistoryService.operateTime => 商品operateTime为空");
				throw new ProductServiceException("商品operateTime参数为空");
			}
			SaleProductProfileHistory saleProductProfileHistory = new SaleProductProfileHistory();
			saleProductProfileHistory.setSaleProductProfileId(saveSaleProductProfileHistoryDto.getSaleProductProfileId());
			saleProductProfileHistory.setSaleProductId(saveSaleProductProfileHistoryDto.getSaleProductId());
			saleProductProfileHistory.setChannelCode(saveSaleProductProfileHistoryDto.getChannelCode());
			saleProductProfileHistory.setContent(saveSaleProductProfileHistoryDto.getContent());
			saleProductProfileHistory.setProductOwner(saveSaleProductProfileHistoryDto.getProductOwner());
			saleProductProfileHistory.setSellPoint(saveSaleProductProfileHistoryDto.getSellPoint());
			saleProductProfileHistory.setHotSaleFlag(saveSaleProductProfileHistoryDto.getHotSaleFlag());
			saleProductProfileHistory.setSaleStatus(saveSaleProductProfileHistoryDto.getSaleStatus());
			saleProductProfileHistory.setSaleProductSpec(saveSaleProductProfileHistoryDto.getSaleProductSpec());
			saleProductProfileHistory.setSaleProductSource(saveSaleProductProfileHistoryDto.getSaleProductSource());
			saleProductProfileHistory.setDisplayOrder(saveSaleProductProfileHistoryDto.getDisplayOrder());
			saleProductProfileHistory.setOperateUserId(saveSaleProductProfileHistoryDto.getOperateUserId());
			saleProductProfileHistory.setOperateType(saveSaleProductProfileHistoryDto.getOperateType());
			saleProductProfileHistory.setOperateTime(saveSaleProductProfileHistoryDto.getOperateTime());
			saleProductProfileHistoryMapper.saveSaleProductProfileHistory(saleProductProfileHistory);
		} catch (ProductServiceException e) {
			logger.error("保存商品历史描述出错");
			throw new ProductServiceException("异常：保存商品历史描述出错");
		}
	}

}
