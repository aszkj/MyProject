package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.StoreProductSubsidyMapper;
import com.yilidi.o2o.user.model.StoreProductSubsidy;
import com.yilidi.o2o.user.model.combination.StoreProductSubsidyInfo;
import com.yilidi.o2o.user.service.IStoreProductSubsidyService;
import com.yilidi.o2o.user.service.dto.StoreProductSubsidyDto;
import com.yilidi.o2o.user.service.dto.query.StoreProductSubsidyQuery;

/**
 * @Description:TODO(商品差价补贴详细管理服务类 )
 * @author: llp
 * @date: 2015年11月10日 下午3:44:31
 * 
 */
@Service("storeProductSubsidyService")
public class StoreProductSubsidyServiceImpl extends BasicDataService implements IStoreProductSubsidyService {
	@Autowired
	private StoreProductSubsidyMapper storeProductSubsidyMapper;

	@Override
	public void save(StoreProductSubsidyDto storeProductSubsidyDto) throws UserServiceException {
		try {
			StoreProductSubsidy storeProductSubsidy = new StoreProductSubsidy();
			ObjectUtils.fastCopy(storeProductSubsidyDto, storeProductSubsidy);
			storeProductSubsidyMapper.save(storeProductSubsidy);
		} catch (UserServiceException e) {
			logger.error("商品差价补贴保存出错");
			throw new UserServiceException("异常：商品差价保存出错");
		}
	}

	@Override
	public YiLiDiPage<StoreProductSubsidyDto> findStoreProductSubsidies(StoreProductSubsidyQuery query) throws UserServiceException {
		try {
			if (null == query.getStart() || query.getStart() <= 0) {
				query.setStart(1);
			}
			if (null == query.getPageSize() || query.getPageSize() <= 0) {
				query.setPageSize(CommonConstants.PAGE_SIZE);
			}
			if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
				query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
				query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
			}
			PageHelper.startPage(query.getStart(), query.getPageSize());
			Page<StoreProductSubsidyInfo> page = storeProductSubsidyMapper.findStoreProductSubsidies(query);
			Page<StoreProductSubsidyDto> pageDto = new Page<StoreProductSubsidyDto>(query.getStart(), query.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<StoreProductSubsidyInfo> storeProductSubsidyInfoList = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(storeProductSubsidyInfoList)) {
				for (StoreProductSubsidyInfo storeProductSubsidyInfo : storeProductSubsidyInfoList) {
					StoreProductSubsidyDto storeProductSubsidyDto = new StoreProductSubsidyDto();
					ObjectUtils.fastCopy(storeProductSubsidyInfo, storeProductSubsidyDto);
					pageDto.add(storeProductSubsidyDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (UserServiceException e) {
			logger.error("查询商品差价补贴信息出错");
			throw new UserServiceException("异常：查询商品差价补贴信息出错");
		}
	}

	@Override
	public Long countPriceSubsidy(Integer storeId) throws UserServiceException {
		try {
			if (null == storeId) {
				logger.error("店铺ID不能为空");
				throw new UserServiceException("店铺ID不能为空");
			}
			return storeProductSubsidyMapper.countPriceSubsidy(storeId);
		} catch (UserServiceException e) {
			logger.error("统计店铺所有商品差价补贴总额出错");
			throw new UserServiceException("异常：统计店铺所有商品差价补贴总额出错");
		}
	}

	@Override
	public List<StoreProductSubsidyDto> listDataForExportProductSubsidy(StoreProductSubsidyQuery query, Long startLineNum,
			Integer pageSize) throws UserServiceException {
		try {
			if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
				query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
				query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
			}
			List<StoreProductSubsidyInfo> storeProductSubsidyInfos = storeProductSubsidyMapper
					.listDataForExportProductSubsidy(query, startLineNum, pageSize);
			List<StoreProductSubsidyDto> storeProductSubsidyDtos = new ArrayList<StoreProductSubsidyDto>();
			if (!ObjectUtils.isNullOrEmpty(storeProductSubsidyInfos)) {
				for (StoreProductSubsidyInfo storeProductSubsidyInfo : storeProductSubsidyInfos) {
					StoreProductSubsidyDto storeProductSubsidyDto = new StoreProductSubsidyDto();
					ObjectUtils.fastCopy(storeProductSubsidyInfo, storeProductSubsidyDto);
					storeProductSubsidyDtos.add(storeProductSubsidyDto);
				}
			}
			return storeProductSubsidyDtos;
		} catch (Exception e) {
			logger.error("listDataForExportProductSubsidy异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Long getCountsForExportProductSubsidy(StoreProductSubsidyQuery query) throws UserServiceException {
		try {
			return storeProductSubsidyMapper.getCountsForExportProductSubsidy(query);
		} catch (Exception e) {
			logger.error("getCountsForExportProductSubsidy异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
}
