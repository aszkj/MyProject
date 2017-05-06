package com.yilidi.o2o.system.proxy.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.proxy.ISystemMessageProxyService;
import com.yilidi.o2o.system.proxy.dto.SystemMessageProxyDto;
import com.yilidi.o2o.system.service.ISystemMessageService;
import com.yilidi.o2o.system.service.dto.SystemMessageDto;

@Service("systemMessageProxyService")
public class IMystemMessageProxyServiceImpl extends BaseService implements ISystemMessageProxyService{

	@Autowired
	private ISystemMessageService systemMessageService;
	
	
	@Override
	public int addSystemMessage(SystemMessageProxyDto systemMessageProxyDto) {
		SystemMessageDto systemMessageDto = new SystemMessageDto();
		ObjectUtils.fastCopy(systemMessageProxyDto, systemMessageDto);
		return systemMessageService.addSystemMessage(systemMessageDto);
	}

}
