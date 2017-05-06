package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.dao.StoreProductSubsidySettingMapper;
import com.yilidi.o2o.product.model.StoreProductSubsidySetting;
import com.yilidi.o2o.product.model.combination.StoreProductSubsidySettingInfo;
import com.yilidi.o2o.product.service.IStoreProductSubsidySettingService;
import com.yilidi.o2o.product.service.dto.StoreProductSubsidySettingDto;
import com.yilidi.o2o.product.service.dto.query.StoreProductSubsidySettingQuery;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.ICustomerProxyService;
import com.yilidi.o2o.user.proxy.dto.StoreProxyDto;

/**
 * @Description:TODO(差价补贴商品设置服务类 )
 * @author: llp
 * @date: 2015年11月10日 下午3:44:31
 * 
 */
@Service("storeProductSubsidySettingService")
public class StoreProductSubsidySettingServiceImpl extends BasicDataService implements IStoreProductSubsidySettingService {
	@Autowired
	private StoreProductSubsidySettingMapper storeProductSubsidySettingMapper;

	@Autowired
	private ICustomerProxyService customerProxyService;

	@Override
	public void save(StoreProductSubsidySettingDto recordDto) throws ProductServiceException {
		try {
			StoreProductSubsidySetting storeProductSubsidySetting = new StoreProductSubsidySetting();
			ObjectUtils.fastCopy(recordDto, storeProductSubsidySetting);
			storeProductSubsidySettingMapper.save(storeProductSubsidySetting);
		} catch (ProductServiceException e) {
			logger.error("保存差价补贴商品配置信息出错");
			throw new ProductServiceException("异常：保存差价补贴商品配置信息出错");
		}
	}

	@Override
	public void deleteById(Integer id) throws ProductServiceException {
		try {
			storeProductSubsidySettingMapper.deleteById(id);
		} catch (ProductServiceException e) {
			logger.error("删除差价补贴商品配置信息出错");
			throw new ProductServiceException("异常：删除差价补贴商品配置信息出错");
		}
	}

	@Override
	public YiLiDiPage<StoreProductSubsidySettingDto> findStoreProductSubsidySettings(StoreProductSubsidySettingQuery query) throws ProductServiceException {
		try {
			if (null == query.getStart() || query.getStart() <= 0) {
				query.setStart(1);
			}
			if (null == query.getPageSize() || query.getPageSize() <= 0) {
				query.setPageSize(CommonConstants.PAGE_SIZE);
			}
			PageHelper.startPage(query.getStart(), query.getPageSize());
			// 通过前端输入的店铺编码和店铺名称，查找到店铺ID
			if (StringUtils.isNotEmpty(query.getStoreCode()) || StringUtils.isNotEmpty(query.getStoreName())) {
				StoreProxyDto storeProxyDtoQuery = new StoreProxyDto();
				List<Integer> storeIdList = new ArrayList<Integer>();
				storeProxyDtoQuery.setStoreCode(query.getStoreCode());
				storeProxyDtoQuery.setStoreName(query.getStoreName());
				List<StoreProxyDto> storeProxyDtos = customerProxyService.listStoreInfoByQuery(storeProxyDtoQuery);
				if (!ObjectUtils.isNullOrEmpty(storeProxyDtos)) {
					for (StoreProxyDto storeProxyDto : storeProxyDtos) {
						storeIdList.add(storeProxyDto.getId());
					}
				}
				if (!ObjectUtils.isNullOrEmpty(storeIdList)) {
					query.setStoreIdList(storeIdList);
				} else {
					// 当输入了店铺编码和店铺名称，查找不到相关店铺的时候，是不能查找到相应的记录
					query.setStoreId(0);
				}
			}
			Page<StoreProductSubsidySettingInfo> page = storeProductSubsidySettingMapper
					.findStoreProductSubsidySettings(query);
			Page<StoreProductSubsidySettingDto> pageDto = new Page<StoreProductSubsidySettingDto>(query.getStart(),
					query.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<StoreProductSubsidySettingInfo> storeProductSubsidySettingInfoList = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(storeProductSubsidySettingInfoList)) {
				for (StoreProductSubsidySettingInfo storeProductSubsidySettingInfo : storeProductSubsidySettingInfoList) {
					// 根据店铺ID，获得店铺信息
					StoreProxyDto storeQuery = new StoreProxyDto();
					storeQuery.setId(storeProductSubsidySettingInfo.getStoreId());
					List<StoreProxyDto> storeInfos = customerProxyService.listStoreInfoByQuery(storeQuery);
					if (!ObjectUtils.isNullOrEmpty(storeInfos)) {
						storeProductSubsidySettingInfo.setStoreCode(storeInfos.get(0).getStoreCode());
						storeProductSubsidySettingInfo.setStoreName(storeInfos.get(0).getStoreName());
					}
					StoreProductSubsidySettingDto storeProductSubsidySettingDto = new StoreProductSubsidySettingDto();
					ObjectUtils.fastCopy(storeProductSubsidySettingInfo, storeProductSubsidySettingDto);
					pageDto.add(storeProductSubsidySettingDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("查询差价补贴商品配置信息出错", e);
			throw new ProductServiceException("异常：查询差价补贴商品配置信息出错");
		}
	}

	@Override
	public YiLiDiPage<StoreProductSubsidySettingDto> findStoreProducts(StoreProductSubsidySettingQuery query) throws ProductServiceException {
		try {
			if (null == query.getStart() || query.getStart() <= 0) {
				query.setStart(1);
			}
			if (null == query.getPageSize() || query.getPageSize() <= 0) {
				query.setPageSize(CommonConstants.PAGE_SIZE);
			}
			PageHelper.startPage(query.getStart(), query.getPageSize());
			// 通过前端输入的店铺编码和店铺名称，查找到店铺ID
			if (StringUtils.isNotEmpty(query.getStoreCode()) || StringUtils.isNotEmpty(query.getStoreName())) {
				StoreProxyDto storeProxyDtoQuery = new StoreProxyDto();
				List<Integer> storeIdList = new ArrayList<Integer>();
				storeProxyDtoQuery.setStoreCode(query.getStoreCode());
				storeProxyDtoQuery.setStoreName(query.getStoreName());
				List<StoreProxyDto> storeProxyDtos = customerProxyService.listStoreInfoByQuery(storeProxyDtoQuery);
				if (!ObjectUtils.isNullOrEmpty(storeProxyDtos)) {
					for (StoreProxyDto storeProxyDto : storeProxyDtos) {
						storeIdList.add(storeProxyDto.getId());
					}
				}
				if (!ObjectUtils.isNullOrEmpty(storeIdList)) {
					query.setStoreIdList(storeIdList);
				} else {
					// 当输入了店铺编码和店铺名称，查找不到相关店铺的时候，是不能查找到相应的记录
					query.setStoreId(0);
				}
			}
			Page<StoreProductSubsidySettingInfo> page = storeProductSubsidySettingMapper.findStoreProducts(query);
			Page<StoreProductSubsidySettingDto> pageDto = new Page<StoreProductSubsidySettingDto>(query.getStart(),
					query.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<StoreProductSubsidySettingInfo> storeProductSubsidySettingInfoList = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(storeProductSubsidySettingInfoList)) {
				for (StoreProductSubsidySettingInfo storeProductSubsidySettingInfo : storeProductSubsidySettingInfoList) {
					// 根据店铺ID，获得店铺信息
					StoreProxyDto storeQuery = new StoreProxyDto();
					storeQuery.setId(storeProductSubsidySettingInfo.getStoreId());
					List<StoreProxyDto> storeInfos = customerProxyService.listStoreInfoByQuery(storeQuery);
					if (!ObjectUtils.isNullOrEmpty(storeInfos)) {
						storeProductSubsidySettingInfo.setStoreCode(storeInfos.get(0).getStoreCode());
						storeProductSubsidySettingInfo.setStoreName(storeInfos.get(0).getStoreName());
					}
					StoreProductSubsidySettingDto storeProductSubsidySettingDto = new StoreProductSubsidySettingDto();
					ObjectUtils.fastCopy(storeProductSubsidySettingInfo, storeProductSubsidySettingDto);
					// 根据商品ID 和 店铺ID，查询该产品是否已经添加到该门店
					StoreProductSubsidySetting storeProductSubsidySetting = storeProductSubsidySettingMapper
							.loadStoreProductSubsidy(storeProductSubsidySettingInfo.getStoreId(),
									storeProductSubsidySettingInfo.getSaleProductId());
					if (!ObjectUtils.isNullOrEmpty(storeProductSubsidySetting)) {
						// 存在,变为已添加状态，不能再添加
						storeProductSubsidySettingDto.setAddStatusCode(StringUtils.ADDSTATUS_YES);
					} else {
						storeProductSubsidySettingDto.setAddStatusCode(StringUtils.ADDSTATUS_NO);
					}
					pageDto.add(storeProductSubsidySettingDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("查询门店商品信息出错", e);
			throw new ProductServiceException("异常：查询门店商品信息出错");
		}
	}
}
