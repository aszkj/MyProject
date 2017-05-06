/**
 * 文件名称：SystemParamsProxyServiceImpl.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.system.proxy.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.dao.SystemParamsMapper;
import com.yilidi.o2o.system.model.SystemParams;
import com.yilidi.o2o.system.proxy.ISystemParamsProxyService;
import com.yilidi.o2o.system.proxy.dto.SystemParamsProxyDto;

/**
 * 功能描述：系统参数代理接口实现类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("systemParamsProxyService")
public class SystemParamsProxyServiceImpl extends BaseService implements ISystemParamsProxyService {

	@Autowired
	private SystemParamsMapper systemParamsMapper;

	@Override
	public SystemParamsProxyDto loadByParamsCode(String paramsCode) throws SystemServiceException {
		try {
			SystemParams systemParams = systemParamsMapper.loadByParamsCode(paramsCode);
			SystemParamsProxyDto systemParamsProxyDto = null;
			if (null != systemParams) {
				systemParamsProxyDto = new SystemParamsProxyDto();
				ObjectUtils.fastCopy(systemParams, systemParamsProxyDto);
			}
			return systemParamsProxyDto;
		} catch (Exception e) {
			logger.info(e);
			throw new SystemServiceException("系统异常 => " + e);
		}
	}

}
