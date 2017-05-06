/**
 * 文件名称：SaleProductImageHistoryService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.SaleProductImageHistoryMapper;
import com.yilidi.o2o.product.model.SaleProductImageHistory;
import com.yilidi.o2o.product.service.ISaleProductImageHistoryService;
import com.yilidi.o2o.product.service.dto.SaleProductImageHistoryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:商品历史图片服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("saleProductImageHistoryService")
public class SaleProductImageHistoryServiceImpl extends BasicDataService implements ISaleProductImageHistoryService {

	@Autowired
	private SaleProductImageHistoryMapper saleProductImageHistoryMapper;

	@Override
	public void saveSaleProductImageHistorys(List<SaleProductImageHistoryDto> saveProductImageHistoryDtos)
			throws ProductServiceException {
		logger.debug("saveProductImageHistoryDtos -> " + saveProductImageHistoryDtos);
		// 检查商品参数对象是否为空
		if (ObjectUtils.isNullOrEmpty(saveProductImageHistoryDtos)) {
			logger.error("SaleProductImageHistoryService.saveProductImageHistoryDtos => 商品历史图片参数为空");
			throw new ProductServiceException("SaleProductImageHistoryService的saveSaleProductImageHistorys方法参数为空");
		}
		// 保存商品所有历史图片
		try {
			for (SaleProductImageHistoryDto saleProductImageHistoryDto : saveProductImageHistoryDtos) {
				saveSaleProductImageHistory(saleProductImageHistoryDto);
			}
		} catch (ProductServiceException e) {
			logger.error("保存商品所有历史图片出错");
			throw new ProductServiceException("异常：保存商品所有历史图片出错");
		}

	}

	@Override
	public void saveSaleProductImageHistory(SaleProductImageHistoryDto saveSaleProductImageHistoryDto)
			throws ProductServiceException {
		// 保存商品单张图片表开始
		logger.debug("saveSaleProductImageHistoryDto -> " + saveSaleProductImageHistoryDto);
		// 检查商品参数对象是否为空
		if (ObjectUtils.isNullOrEmpty(saveSaleProductImageHistoryDto)) {
			logger.error("SaleProductImageHistoryService.saveSaleProductImageHistoryDto => 商品参数为空");
			throw new ProductServiceException("SaleProductImageHistoryService的saveSaleProductImageHistory方法参数为空");
		}
		try {
			// 商品ID是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageHistoryDto.getSaleProductId())) {
				logger.error("SaleProductImageHistoryService.saleProductId => 商品ID参数为空");
				throw new ProductServiceException("商品ID参数为空");
			}
			// 商品渠道编码是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageHistoryDto.getChannelCode())) {
				logger.error("SaleProductImageHistoryService.channelCode => 商品channelCode参数为空");
				throw new ProductServiceException("商品渠道编码channelCode参数为空");
			}
			// 商品SaleProductImageId是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageHistoryDto.getSaleProductImageId())) {
				logger.error("SaleProductImageHistoryService.saleProductImageId => 商品saleProductImageId为空");
				throw new ProductServiceException("商品saleProductImageId参数为空");
			}
			// 保存商品masterFlag是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageHistoryDto.getMasterFlag())) {
				logger.error("SaleProductImageHistoryService.masterFlag => 商品masterFlag为空");
				throw new ProductServiceException("商品masterFlag参数为空");
			}
			// 商品imageUrl是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageHistoryDto.getImageUrl())) {
				logger.error("SaleProductImageHistoryService.imageUrl => 商品imageUrl为空");
				throw new ProductServiceException("商品imageUrl参数为空");
			}
			// 商品imageOrder是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageHistoryDto.getImageOrder())) {
				logger.error("SaleProductImageHistoryService.imageOrder => 商品imageOrder为空");
				throw new ProductServiceException("商品imageOrder参数为空");
			}
			// 保存商品operateUserId是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageHistoryDto.getOperateUserId())) {
				logger.error("SaleProductImageHistoryService.operateUserId => 商品operateUserId为空");
				throw new ProductServiceException("商品operateUserId参数为空");
			}
			// 保存商品operateType是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageHistoryDto.getOperateType())) {
				logger.error("SaleProductImageHistoryService.operateType => 商品operateType为空");
				throw new ProductServiceException("商品operateType参数为空");
			}
			// 保存商品operateTime是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageHistoryDto.getOperateTime())) {
				logger.error("SaleProductImageHistoryService.operateTime => 商品operateTime为空");
				throw new ProductServiceException("商品operateTime参数为空");
			}
			String ext = this.getExtensionName(saveSaleProductImageHistoryDto.getImageUrl()).replace(".", "");
			SaleProductImageHistory saleProductImageHistory = new SaleProductImageHistory();
			saleProductImageHistory.setSaleProductId(saveSaleProductImageHistoryDto.getSaleProductId());
			saleProductImageHistory.setSaleProductImageId(saveSaleProductImageHistoryDto.getSaleProductImageId());
			saleProductImageHistory.setChannelCode(saveSaleProductImageHistoryDto.getChannelCode());
			// 更新商品图片信息
			saleProductImageHistory.setImageUrl1(saveSaleProductImageHistoryDto.getImageUrl().replaceAll("\\." + ext,
					"\\_1." + ext));
			saleProductImageHistory.setImageUrl2(saveSaleProductImageHistoryDto.getImageUrl().replaceAll("\\." + ext,
					"\\_2." + ext));
			saleProductImageHistory.setImageUrl3(saveSaleProductImageHistoryDto.getImageUrl().replaceAll("\\." + ext,
					"\\_3." + ext));
			saleProductImageHistory.setImageOrder(saveSaleProductImageHistoryDto.getImageOrder());
			saleProductImageHistory.setMasterFlag(saveSaleProductImageHistoryDto.getMasterFlag());
			saleProductImageHistory.setOperateTime(saveSaleProductImageHistoryDto.getOperateTime());
			saleProductImageHistory.setOperateUserId(saveSaleProductImageHistoryDto.getOperateUserId());
			saleProductImageHistory.setOperateType(saveSaleProductImageHistoryDto.getOperateType());
			saleProductImageHistoryMapper.saveSaleProductImageHistory(saleProductImageHistory);
		} catch (ProductServiceException e) {
			logger.error("保存商品单张图片出错");
			throw new ProductServiceException("异常：保存商品单张图片出错");
		}
	}

	/**
	 * 
	 * @Description TODO(获取文件的后缀名)
	 * @param filename
	 * @return String
	 */
	private String getExtensionName(String filename) {
		String ext = "";
		if ((filename != null) && (filename.length() > 0)) {
			int dot = filename.lastIndexOf('.');
			if ((dot >= 0) && (dot < (filename.length() - 1))) {
				ext = filename.substring(dot);
			}
		}
		return ext;
	}

	@Override
	public List<SaleProductImageHistoryDto> listSaleProductImageHistoryBySaleProductId(
			List<SaleProductImageHistoryDto> querySaleProductImageHistoryDtos) throws ProductServiceException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SaleProductImageHistoryDto> listProductImageHistorysBySaleProductIdAndChannelCode(Integer saleProductId,
			String channelCode) throws ProductServiceException {
		// TODO Auto-generated method stub
		return null;
	}

}