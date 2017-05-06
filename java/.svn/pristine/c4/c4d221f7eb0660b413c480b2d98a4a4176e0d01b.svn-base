/**
 * 文件名称：LogisticProxyService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.proxy.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.ILogisticProxyService;
import com.yilidi.o2o.user.proxy.dto.FreightCalculateProxyDto;
import com.yilidi.o2o.user.service.ILogisticSettingService;
import com.yilidi.o2o.user.service.dto.FreightCalculateDto;

/**
 * 功能描述：物流服务代理实现类<br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("logisticProxyService")
public class LogisticProxyService extends BasicDataService implements ILogisticProxyService {

	@Autowired
	private ILogisticSettingService logisticSettingService;

	@Override
	public Long getFreight(FreightCalculateProxyDto freightCalculateProxyDto) throws UserServiceException {
		FreightCalculateDto freightCalculateDto = new FreightCalculateDto();
		ObjectUtils.fastCopy(freightCalculateProxyDto, freightCalculateDto);
		return logisticSettingService.getFreight(freightCalculateDto);
	}

}
