package com.yilidi.o2o.user.service.impl;

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
import com.yilidi.o2o.user.dao.StoreDeliveryOrderRecordMapper;
import com.yilidi.o2o.user.model.combination.StoreDeliveryOrderRecordInfo;
import com.yilidi.o2o.user.service.IStoreDeliveryOrderRecordService;
import com.yilidi.o2o.user.service.dto.StoreDeliveryOrderRecordDto;
import com.yilidi.o2o.user.service.dto.query.StoreDeliveryOrderRecordQuery;

/**
 * 门店接单员处理订单记录管理service
 * 
 * @author: heyong
 * @date: 2015年12月10日 下午8:21:50
 * 
 */
@Service("storeDeliveryOrderRecordService")
public class StoreDeliveryOrderRecordServiceImpl extends BasicDataService implements IStoreDeliveryOrderRecordService {

	@Autowired
	private StoreDeliveryOrderRecordMapper storeDeliveryOrderRecordMapper;

	@Override
	public YiLiDiPage<StoreDeliveryOrderRecordDto> findStoreDeliveryOrderRecord(StoreDeliveryOrderRecordQuery query) throws UserServiceException {
		try {
			if (null == query.getStart() || query.getStart() <= 0) {
				query.setStart(1);
			}
			if (null == query.getPageSize() || query.getPageSize() <= 0) {
				query.setPageSize(CommonConstants.PAGE_SIZE);
			}
			String strStartCreateTime = query.getStrStartCreateTime();
			if (!ObjectUtils.isNullOrEmpty(strStartCreateTime)) {
				query.setStrStartCreateTime(strStartCreateTime + StringUtils.STARTTIMESTRING);
			}
			String strEndCreateTime = query.getStrEndCreateTime();
			if (!ObjectUtils.isNullOrEmpty(strEndCreateTime)) {
				query.setStrEndCreateTime(strEndCreateTime + StringUtils.ENDTIMESTRING);
			}

			PageHelper.startPage(query.getStart(), query.getPageSize());
			Page<StoreDeliveryOrderRecordInfo> page = storeDeliveryOrderRecordMapper.findStoreDeliveryOrderRecord(query);
			Page<StoreDeliveryOrderRecordDto> pageDto = new Page<StoreDeliveryOrderRecordDto>(query.getStart(),
					query.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);
			List<StoreDeliveryOrderRecordInfo> infos = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(infos)) {
				for (StoreDeliveryOrderRecordInfo info : infos) {
					StoreDeliveryOrderRecordDto dto = new StoreDeliveryOrderRecordDto();
					ObjectUtils.fastCopy(info, dto);
					pageDto.add(dto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("findStoreDelivery异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
}
