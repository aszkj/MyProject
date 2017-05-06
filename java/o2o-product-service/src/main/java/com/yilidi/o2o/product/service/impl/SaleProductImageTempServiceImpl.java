/**
 * 文件名称：SaleProductImageTempService.java
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
import com.yilidi.o2o.product.dao.SaleProductImageTempMapper;
import com.yilidi.o2o.product.model.SaleProductImageTemp;
import com.yilidi.o2o.product.service.ISaleProductImageTempService;
import com.yilidi.o2o.product.service.dto.SaleProductImageTempDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:临时商品图片服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("saleProductImageTempService")
public class SaleProductImageTempServiceImpl extends BasicDataService implements ISaleProductImageTempService {

	@Autowired
	private SaleProductImageTempMapper saleProductImageTempMapper;

	@Override
	public void saveSaleProductImageTemps(List<SaleProductImageTempDto> saveSaleProductImageTempDtos)
			throws ProductServiceException {
		logger.debug("saveSaleProductImageTempDtos -> " + saveSaleProductImageTempDtos);
		try {
			// 检查临时商品参数对象是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageTempDtos)) {
				logger.error("SaleProductImageTempService.saveSaleProductImageTempDtos => 临时商品图片参数为空");
				throw new ProductServiceException("SaleProductImageTempService的saveSaleProductImageTemps方法参数为空");
			}
			// 保存临时商品所有图片
			for (SaleProductImageTempDto saleProductImageTempDto : saveSaleProductImageTempDtos) {
				this.saveSaleProductImageTemp(saleProductImageTempDto);
			}
		} catch (ProductServiceException e) {
			logger.error("保存临时商品所有图片出错");
			throw new ProductServiceException("异常：保存临时商品所有图片出错");
		}

	}

	private void saveSaleProductImageTemp(SaleProductImageTempDto saveSaleProductImageTempDto)
			throws ProductServiceException {
		logger.debug("saveSaleProductImageTempDto -> " + saveSaleProductImageTempDto);
		// 保存临时商品一张图片
		try {
			// 检查临时商品参数对象是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageTempDto)) {
				logger.error("SaleProductImageTempService.saveSaleProductImageTempDto => 保存临时商品单张图片参数为空");
				throw new ProductServiceException("SaleProductImageTempService的saveSaleProductImageTemp方法参数为空");
			}
			// 临时商品ID是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageTempDto.getSaleProductId())) {
				logger.error("SaleProductImageTempService.saleProductId => 临时商品ID参数为空");
				throw new ProductServiceException("临时商品ID参数为空");
			}
			// 临时商品渠道编码是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageTempDto.getChannelCode())) {
				logger.error("SaleProductImageTempService.channelCode => 保存临时商品channelCode参数为空");
				throw new ProductServiceException("临时商品渠道编码channelCode参数为空");
			}
			// 保存临时商品createUserId是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageTempDto.getCreateUserId())) {
				logger.error("SaleProductImageTempService.createUserId => 临时商品createUserId为空");
				throw new ProductServiceException("临时商品createUserId参数为空");
			}
			// 保存临时商品createTime是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageTempDto.getCreateTime())) {
				logger.error("SaleProductImageTempService.createTime => 临时商品createTime为空");
				throw new ProductServiceException("临时商品createTime参数为空");
			}
			// 临时商品ImageTempUrl是否为空
			if (ObjectUtils.isNullOrEmpty(saveSaleProductImageTempDto.getImageUrl())) {
				logger.error("SaleProductImageTempService.ImageTempUrl => 临时商品ImageTempUrl为空");
				throw new ProductServiceException("临时商品ImageTempUrl参数为空");
			} else {
				SaleProductImageTemp saleProductImageTemp = new SaleProductImageTemp();
				saleProductImageTemp.setTempId(saveSaleProductImageTempDto.getTempId());
				saleProductImageTemp.setSaleProductId(saveSaleProductImageTempDto.getSaleProductId());
				saleProductImageTemp.setChannelCode(saveSaleProductImageTempDto.getChannelCode());
				// 获取图片路径
				String ext = this.getExtensionName(saveSaleProductImageTempDto.getImageUrl()).replace(".", "");
				saleProductImageTemp.setImageUrl1(saveSaleProductImageTempDto.getImageUrl().replaceAll("\\." + ext,
						"\\_1." + ext));
				saleProductImageTemp.setImageUrl2(saveSaleProductImageTempDto.getImageUrl().replaceAll("\\." + ext,
						"\\_2." + ext));
				saleProductImageTemp.setImageUrl3(saveSaleProductImageTempDto.getImageUrl().replaceAll("\\." + ext,
						"\\_3." + ext));
				// 设置图片顺序
				saleProductImageTemp.setImageOrder(saveSaleProductImageTempDto.getImageOrder());
				// 设置主图标示
				saleProductImageTemp.setMasterFlag(saveSaleProductImageTempDto.getMasterFlag());
				saleProductImageTemp.setCreateTime(saveSaleProductImageTempDto.getModifyTime());
				// 此处创建人id需要取到用户登录的id
				saleProductImageTemp.setCreateUserId(saveSaleProductImageTempDto.getModifyUserId());
				saleProductImageTempMapper.saveSaleProductImageTemp(saleProductImageTemp);
				saveSaleProductImageTempDto.setTempId(saleProductImageTemp.getTempId());
			}
		} catch (ProductServiceException e) {
			logger.error("保存临时商品单张图片出错");
			throw new ProductServiceException("异常：保存临时商品单张图片出错");
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
	public void updateSaleProductImageTemp(SaleProductImageTempDto updateSaleProductImageTempDto)
			throws ProductServiceException {
		logger.debug("updateSaleProductImageTempDto -> " + updateSaleProductImageTempDto);
		// 更新临时商品某一张图片
		try {
			// 检查临时商品参数对象是否为空
			if (ObjectUtils.isNullOrEmpty(updateSaleProductImageTempDto)) {
				logger.error("SaleProductImageTempService.updateSaleProductImageTempDto => 临时商品其中一张图片的参数为空");
				throw new ProductServiceException("SaleProductImageTempService的updateSaleProductImageTemp方法参数为空");
			}
			// 检查临时商品图片修改人是否为空
			if (ObjectUtils.isNullOrEmpty(updateSaleProductImageTempDto.getModifyUserId())) {
				logger.error("ProductService.updateSaleProductImageTempDto.modifyUserId=> 临时商品图片修改人为空");
				throw new ProductServiceException("ProductService的updateSaleProductImageTemp.modifyUserId方法参数modifyUserId为空");
			}
			// 检查临时商品图片修改时间是否为空
			if (ObjectUtils.isNullOrEmpty(updateSaleProductImageTempDto.getModifyTime())) {
				logger.error("ProductService.updateSaleProductImageTempDto.modifyTime => 临时商品图片修改时间为空");
				throw new ProductServiceException("ProductService的updateSaleProductImageTemp方法参数modifyTime为空");
			}
			// 检查产品图片ID是否为空
			if (!ObjectUtils.isNullOrEmpty(updateSaleProductImageTempDto.getId())) {
				SaleProductImageTemp saleProductImageTemp = saleProductImageTempMapper
						.loadSaleProductImageTempById(updateSaleProductImageTempDto.getId());
				// 检查临时商品参数对象是否为空
				if (!ObjectUtils.isNullOrEmpty(saleProductImageTemp)) {
					String ext = this.getExtensionName(updateSaleProductImageTempDto.getImageUrl()).replace(".", "");
					if (ObjectUtils.whetherModified(saleProductImageTemp.getImageOrder(),
							updateSaleProductImageTempDto.getImageOrder())
							|| ObjectUtils.whetherModified(saleProductImageTemp.getMasterFlag(),
									updateSaleProductImageTempDto.getMasterFlag())
							|| ObjectUtils.whetherModified(saleProductImageTemp.getImageUrl1(),
									updateSaleProductImageTempDto.getImageUrl().replaceAll("\\." + ext, "\\_1." + ext))) {
						// 更新临时商品图片信息
						saleProductImageTemp.setImageUrl1(updateSaleProductImageTempDto.getImageUrl().replaceAll(
								"\\." + ext, "\\_1." + ext));
						saleProductImageTemp.setImageUrl2(updateSaleProductImageTempDto.getImageUrl().replaceAll(
								"\\." + ext, "\\_2." + ext));
						saleProductImageTemp.setImageUrl3(updateSaleProductImageTempDto.getImageUrl().replaceAll(
								"\\." + ext, "\\_3." + ext));
						// 设置图片上顺序
						saleProductImageTemp.setImageOrder(updateSaleProductImageTempDto.getImageOrder());
						// 设置主图标示
						saleProductImageTemp.setMasterFlag(updateSaleProductImageTempDto.getMasterFlag());
						saleProductImageTemp.setModifyTime(updateSaleProductImageTempDto.getModifyTime());
						// 此处创建人id需要取到用户登录的id
						saleProductImageTemp.setModifyUserId(updateSaleProductImageTempDto.getModifyUserId());
						saleProductImageTempMapper.updateSaleProductImageTemp(saleProductImageTemp);
					}
				}
			} else {
				updateSaleProductImageTempDto.setCreateUserId(updateSaleProductImageTempDto.getModifyUserId());
				updateSaleProductImageTempDto.setCreateTime(updateSaleProductImageTempDto.getModifyTime());
				this.saveSaleProductImageTemp(updateSaleProductImageTempDto);
			}
		} catch (ProductServiceException e) {
			logger.error("更新临时商品某一张图片出错");
			throw new ProductServiceException("异常：更新临时商品某一张图片出错");
		}

	}

	@Override
	public void updateSaleProductImageTemps(List<SaleProductImageTempDto> updateSaleProductImageTempDtos)
			throws ProductServiceException {
		logger.debug("updateSaleProductImageTempDtos -> " + updateSaleProductImageTempDtos);
		// 更新临时商品所有图片
		try {
			// 检查临时商品参数对象是否为空
			if (ObjectUtils.isNullOrEmpty(updateSaleProductImageTempDtos)) {
				logger.error("SaleProductImageTempService.updateSaleProductImageTempDtos => 临时商品图片参数为空");
				throw new ProductServiceException("SaleProductImageTempService的updateSaleProductImageTemps方法参数为空");
			}
			for (SaleProductImageTempDto saleProductImageTempDto : updateSaleProductImageTempDtos) {
				this.updateSaleProductImageTemp(saleProductImageTempDto);
			}
		} catch (ProductServiceException e) {
			logger.error("更新临时商品图片出错");
			throw new ProductServiceException("异常：更新临时商品图片出错");
		}

	}

	@Override
	public List<SaleProductImageTempDto> listSaleProductImageTempsBySaleProductIdAndChannelCode(Integer saleProductId,
			String channelCode) throws ProductServiceException {
		logger.debug("saleProductId -> " + saleProductId + "channelCode -> " + channelCode);
		try {
			// 检查临时商品参数临时商品Id是否为空
			if (ObjectUtils.isNullOrEmpty(saleProductId)) {
				logger.error("SaleProductImageTempService.saleProductId => 临时商品Id参数为空");
				throw new ProductServiceException(
						"SaleProductImageTempService的listSaleProductImageTempsBySaleProductIdAndChannelCode方法参数saleProductId为空");
			}
			// 检查临时商品参数临时商品编码渠道是否为空
			if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
			}
			// 查询临时商品所有图片
			List<SaleProductImageTemp> listSaleProductImageTemp = saleProductImageTempMapper
					.listSaleProductImageTempsBySaleProductIdAndChannelCode(saleProductId, channelCode);
			List<SaleProductImageTempDto> saleProductImageTempDtos = null;
			if (!ObjectUtils.isNullOrEmpty(listSaleProductImageTemp)) {
				saleProductImageTempDtos = new ArrayList<SaleProductImageTempDto>();
				for (SaleProductImageTemp saleProductImageTemp : listSaleProductImageTemp) {
					SaleProductImageTempDto saleProductImageTempDto = null;
					if (!ObjectUtils.isNullOrEmpty(saleProductImageTemp)) {
						saleProductImageTempDto = new SaleProductImageTempDto();
						ObjectUtils.fastCopy(saleProductImageTemp, saleProductImageTempDto);
						saleProductImageTempDto.setImageUrl(saleProductImageTemp.getImageUrl1().replace("_1.", "."));
						saleProductImageTempDtos.add(saleProductImageTempDto);
					}
				}
			}
			return saleProductImageTempDtos;
		} catch (ProductServiceException e) {
			logger.error("查询临时商品图片出错");
			throw new ProductServiceException("异常：查询临时商品图片出错");
		}
	}

	@Override
	public void deleteSaleProductImageTemps(Integer tempId, String channelCode) throws ProductServiceException {
		try {
			// 检查商品ID参数对象是否为空
			if (ObjectUtils.isNullOrEmpty(tempId)) {
				logger.error("ProductService.deleteSaleProductTemp.tempId => 商品ID为空");
				throw new ProductServiceException("需要删除的临时商品Id为空");
			}
			// 商品渠道编码是否为空
			if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
			}
			// 删除临时图片信息
			saleProductImageTempMapper.deleteSaleProductImageTempByTempIdAndChannelCode(tempId, channelCode);

		} catch (ProductServiceException e) {
			logger.error("删除临时商品图片出错", e);
			throw new ProductServiceException("异常：删除临时商品图片出错");
		}

	}

}