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
import com.yilidi.o2o.user.dao.StoreSubsidyRecordMapper;
import com.yilidi.o2o.user.model.StoreSubsidyRecord;
import com.yilidi.o2o.user.model.combination.StoreSubsidyCountInfo;
import com.yilidi.o2o.user.model.combination.StoreSubsidyRecordInfo;
import com.yilidi.o2o.user.service.IStoreSubsidyRecordService;
import com.yilidi.o2o.user.service.dto.StoreSubsidyCountInfoDto;
import com.yilidi.o2o.user.service.dto.StoreSubsidyRecordDto;
import com.yilidi.o2o.user.service.dto.query.StoreSubsidyRecordQuery;

/**
 * @Description:TODO(补贴管理服务类 )
 * @author: llp
 * @date: 2015年11月10日 下午3:44:31
 * 
 */
@Service("storeSubsidyRecordService")
public class StoreSubsidyRecordServiceImpl extends BasicDataService implements IStoreSubsidyRecordService {
	@Autowired
	private StoreSubsidyRecordMapper storeSubsidyRecordMapper;
	@Autowired
	private StoreProductSubsidyMapper storeProductSubsidyMapper;

	@Override
	public void save(StoreSubsidyRecordDto recordDto) throws UserServiceException {
		try {
			StoreSubsidyRecord storeSubsidyRecord = new StoreSubsidyRecord();
			ObjectUtils.fastCopy(recordDto, storeSubsidyRecord);
			storeSubsidyRecordMapper.save(storeSubsidyRecord);
		} catch (Exception e) {
			logger.error("订单补贴保存出错");
			throw new UserServiceException("异常：订单补贴保存出错");
		}
	}

	@Override
	public YiLiDiPage<StoreSubsidyRecordDto> findStoreSubsidyRecords(StoreSubsidyRecordQuery query) throws UserServiceException {
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
			Page<StoreSubsidyRecordInfo> page = storeSubsidyRecordMapper.findStoreSubsidyRecords(query);
			Page<StoreSubsidyRecordDto> pageDto = new Page<StoreSubsidyRecordDto>(query.getStart(), query.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<StoreSubsidyRecordInfo> storeSubsidyRecordInfoList = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(storeSubsidyRecordInfoList)) {
				for (StoreSubsidyRecordInfo storeSubsidyRecordInfo : storeSubsidyRecordInfoList) {
					StoreSubsidyRecordDto storeSubsidyRecordDto = new StoreSubsidyRecordDto();
					ObjectUtils.fastCopy(storeSubsidyRecordInfo, storeSubsidyRecordDto);
					pageDto.add(storeSubsidyRecordDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("查询补贴信息出错");
			throw new UserServiceException("异常：查询补贴信息出错");
		}
	}

	@Override
	public YiLiDiPage<StoreSubsidyCountInfoDto> findStoreSubsidyCountInfos(StoreSubsidyRecordQuery query) throws UserServiceException {
		try {
			if (null == query.getStart() || query.getStart() <= 0) {
				query.setStart(1);
			}
			if (null == query.getPageSize() || query.getPageSize() <= 0) {
				query.setPageSize(CommonConstants.PAGE_SIZE);
			}
			PageHelper.startPage(query.getStart(), query.getPageSize());
			Page<StoreSubsidyCountInfo> page = storeSubsidyRecordMapper.findStoreSubsidyCountInfos(query);
			Page<StoreSubsidyCountInfoDto> pageDto = new Page<StoreSubsidyCountInfoDto>(query.getStart(),
					query.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<StoreSubsidyCountInfo> storeSubsidyCountInfoList = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(storeSubsidyCountInfoList)) {
				for (StoreSubsidyCountInfo storeSubsidyCountInfo : storeSubsidyCountInfoList) {
					StoreSubsidyCountInfoDto storeSubsidyCountInfoDto = new StoreSubsidyCountInfoDto();
					// 根据店铺ID，统计该店铺所有商品差价补贴金额
					Long priceSubsidy = storeProductSubsidyMapper.countPriceSubsidy(storeSubsidyCountInfo.getStoreId());
					storeSubsidyCountInfo.setPriceSubsidy(priceSubsidy);
					ObjectUtils.fastCopy(storeSubsidyCountInfo, storeSubsidyCountInfoDto);
					pageDto.add(storeSubsidyCountInfoDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("查询补贴统计管理信息出错");
			throw new UserServiceException("异常：查询补贴统计管理信息出错");
		}
	}

	@Override
	public List<StoreSubsidyRecordDto> listDataForExportStoreSubsidyRecord(StoreSubsidyRecordQuery query, Long startLineNum,
			Integer pageSize) throws UserServiceException {
		try {
			if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
				query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
				query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
			}
			List<StoreSubsidyRecordInfo> storeSubsidyRecordInfos = storeSubsidyRecordMapper
					.listDataForExportStoreSubsidyRecord(query, startLineNum, pageSize);
			List<StoreSubsidyRecordDto> storeSubsidyRecordDtos = new ArrayList<StoreSubsidyRecordDto>();
			if (!ObjectUtils.isNullOrEmpty(storeSubsidyRecordInfos)) {
				for (StoreSubsidyRecordInfo storeSubsidyRecordInfo : storeSubsidyRecordInfos) {
					StoreSubsidyRecordDto storeSubsidyRecordDto = new StoreSubsidyRecordDto();
					ObjectUtils.fastCopy(storeSubsidyRecordInfo, storeSubsidyRecordDto);
					storeSubsidyRecordDtos.add(storeSubsidyRecordDto);
				}
			}
			return storeSubsidyRecordDtos;
		} catch (Exception e) {
			logger.error("listDataForExportStoreSubsidyRecord异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Long getCountsForExportStoreSubsidyRecord(StoreSubsidyRecordQuery query) throws UserServiceException {
		try {
			return storeSubsidyRecordMapper.getCountsForExportStoreSubsidyRecord(query);
		} catch (Exception e) {
			logger.error("getCountsForExportStoreSubsidyRecord异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
}
