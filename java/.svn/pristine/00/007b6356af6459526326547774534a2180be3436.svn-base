package com.yilidi.o2o.system.proxy.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.dao.SystemDictMapper;
import com.yilidi.o2o.system.model.SystemDict;
import com.yilidi.o2o.system.proxy.ISystemDictProxyService;
import com.yilidi.o2o.system.proxy.dto.SystemDictProxyDto;

/**
 * 
 * @Description:TODO(系统字典代理Service接口实现类)
 * @author: chenlian
 * @date: 2015年11月16日 下午5:45:59
 * 
 */
@Service("systemDictProxyService")
public class SystemDictProxyServiceImpl extends BaseService implements ISystemDictProxyService {

	@Autowired
	private SystemDictMapper systemDictMapper;

	@Override
	public SystemDictProxyDto loadByDictCode(String dictCode) throws SystemServiceException {
		try {
			SystemDict systemDict = this.systemDictMapper.loadByDictCode(dictCode);
			SystemDictProxyDto systemDictProxyDto = null;
			if (null != systemDict) {
				systemDictProxyDto = new SystemDictProxyDto();
				ObjectUtils.fastCopy(systemDict, systemDictProxyDto);
			}
			return systemDictProxyDto;
		} catch (Exception e) {
			String msg = "根据字典编码获取字典信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public List<Map<String, String>> listAllValidDictType() throws SystemServiceException {
		try {
			return this.systemDictMapper.listAllValidDictType();
		} catch (Exception e) {
			String msg = "获取所有有效的字典类型与字典类型名称出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public List<SystemDictProxyDto> listAllValidDictByDictType(String dictType) throws SystemServiceException {
		try {
			List<SystemDict> systemDictList = this.systemDictMapper.listAllValidDictByDictType(dictType);
			List<SystemDictProxyDto> systemDictProxyDtoList = new ArrayList<SystemDictProxyDto>();
			if (!ObjectUtils.isNullOrEmpty(systemDictList)) {
				for (SystemDict model : systemDictList) {
					SystemDictProxyDto dto = new SystemDictProxyDto();
					ObjectUtils.fastCopy(model, dto);
					systemDictProxyDtoList.add(dto);
				}
			}
			return systemDictProxyDtoList;
		} catch (Exception e) {
			String msg = "根据字典类型获取有效的字典列表信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

}
