package com.yilidi.o2o.system.proxy.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.dao.AreaDictMapper;
import com.yilidi.o2o.system.model.AreaDict;
import com.yilidi.o2o.system.proxy.IAreaDictProxyService;
import com.yilidi.o2o.system.proxy.dto.AreaDictProxyDto;

/**
 * 
 * @Description:TODO(区域字典代理Service接口实现类)
 * @author: chenlian
 * @date: 2015年12月5日 下午2:13:49
 * 
 */
@Service("areaDictProxyService")
public class AreaDictProxyServiceImpl extends BaseService implements IAreaDictProxyService {

	@Autowired
	private AreaDictMapper areaDictMapper;

	@Override
	public String encapsulateAreaNameByCodes(String provinceCode, String cityCode, String countyCode, String townCode,
			String addressDetail) throws SystemServiceException {
		try {
			String areaNameInfo = null;
			List<String> areaCodes = new ArrayList<String>();
			if (!StringUtils.isEmpty(provinceCode)) {
				areaCodes.add(provinceCode);
			}
			if (!StringUtils.isEmpty(cityCode)) {
				areaCodes.add(cityCode);
			}
			if (!StringUtils.isEmpty(countyCode)) {
				areaCodes.add(countyCode);
			}
			if (!StringUtils.isEmpty(townCode)) {
				areaCodes.add(townCode);
			}
			if (areaCodes.isEmpty()) {
				return null;
			}
			List<AreaDict> areaDictList = areaDictMapper.listByAreaCodes(areaCodes);
			if (null != areaDictList && !areaDictList.isEmpty()) {
				areaNameInfo = "";
				for (AreaDict areaDict : areaDictList) {
					areaNameInfo += areaDict.getAreaName();
				}
			}
			return areaNameInfo + (addressDetail == null ? "" : addressDetail);
		} catch (Exception e) {
			logger.info(e);
			throw new SystemServiceException("系统异常 => " + e);
		}
	}

	@Override
	public AreaDictProxyDto loadByAreaCode(String areaCode) throws SystemServiceException {
		AreaDict areaDict = areaDictMapper.loadByAreaCode(areaCode);
		if (!ObjectUtils.isNullOrEmpty(areaDict)) {
			AreaDictProxyDto dto = new AreaDictProxyDto();
			ObjectUtils.fastCopy(areaDict, dto);
			return dto;
		}
		return new AreaDictProxyDto();
	}

	@Override
	public List<AreaDictProxyDto> listByParentCode(String parentCode) throws SystemServiceException {
		try {
			List<AreaDictProxyDto> areaDictProxyDtoList = null;
			List<AreaDict> areaDictList = areaDictMapper.listByParentCode(parentCode);
			if (!ObjectUtils.isNullOrEmpty(areaDictList)) {
				areaDictProxyDtoList = new ArrayList<AreaDictProxyDto>();
				for (AreaDict model : areaDictList) {
					AreaDictProxyDto dto = new AreaDictProxyDto();
					ObjectUtils.fastCopy(model, dto);
					areaDictProxyDtoList.add(dto);
				}
			}
			return areaDictProxyDtoList;
		} catch (Exception e) {
			String msg = "根据父级节点Code加载所有的区域信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg);
		}
	}

}
