package com.yilidi.o2o.user.proxy.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.StoreSubsidyRecordMapper;
import com.yilidi.o2o.user.model.combination.AllSubsidyInfo;
import com.yilidi.o2o.user.proxy.IStoreSubsidyRecordProxyService;
import com.yilidi.o2o.user.proxy.dto.AllSubsidyInfoProxyDto;

/**
 * 
 * 销量汇总统计 补贴相关
 * 
 * @author: heyong
 * @date: 2015年11月27日 上午9:55:01
 * 
 */
@Service("storeSubsidyRecordProxyService")
public class StoreSubsidyRecordProxyServiceImpl extends BasicDataService implements IStoreSubsidyRecordProxyService {

	@Autowired
	private StoreSubsidyRecordMapper storeSubsidyRecordMapper;

	@Override
	public AllSubsidyInfoProxyDto statisticsAllSubsidyInfo(List<String> saleOrderNos) throws UserServiceException {
		AllSubsidyInfo info = storeSubsidyRecordMapper.statisticsAllSubsidyInfo(saleOrderNos);
		AllSubsidyInfoProxyDto dto = null;
		if (!ObjectUtils.isNullOrEmpty(info)) {
			dto = new AllSubsidyInfoProxyDto();
			ObjectUtils.fastCopy(info, dto);
		}
		return dto;
	}

}
