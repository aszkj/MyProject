package com.yilidi.o2o.system.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import redis.clients.jedis.Jedis;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.SerializableUtils;
import com.yilidi.o2o.system.dao.AreaDictMapper;
import com.yilidi.o2o.system.model.AreaDict;
import com.yilidi.o2o.system.service.IAreaDictService;
import com.yilidi.o2o.system.service.dto.AreaDictDto;

/**
 * 
 * @Description:TODO(区域字典Service接口)
 * @author: chenlian
 * @date: 2015年12月3日 下午4:24:42
 * 
 */
@Service("areaDictService")
public class AreaDictServiceImpl extends SystemBaseService implements IAreaDictService {

	@Autowired
	private AreaDictMapper areaDictMapper;

	@Override
	public AreaDictDto save(AreaDictDto areaDictDto) throws SystemServiceException {
		Jedis jedis = null;
		try {
			AreaDict areaDictForCode = this.areaDictMapper.loadByAreaCode(areaDictDto.getAreaCode());
			if (null != areaDictForCode) {
				throw new IllegalArgumentException("地区字典编码已经存在");
			}
			AreaDict areaDict = new AreaDict();
			ObjectUtils.fastCopy(areaDictDto, areaDict);
			this.areaDictMapper.save(areaDict);
			areaDictDto.setId(areaDict.getId());
			jedis = JedisUtils.getJedis();
			jedis.set(areaDict.getAreaCode().getBytes(), areaDict.getAreaName().getBytes());
			List<AreaDict> areaDictList = null;
			areaDictList = this.areaDictMapper.listByParentCode(areaDict.getParentCode());
			setAreaDictListToRedisCache(jedis, areaDict, areaDictList);
			return areaDictDto;
		} catch (Exception e) {
			String msg = "";
			if (!StringUtils.isEmpty(e.getMessage())) {
				msg = e.getMessage();
			} else {
				msg = "创建地区字典信息出现系统异常";
			}
			logger.error(msg, e);
			throw new SystemServiceException(msg);
		} finally {
			if (null != jedis) {
				JedisUtils.returnResource(jedis);
			}
		}
	}

	@Override
	public AreaDictDto loadByAreaCode(String areaCode) throws SystemServiceException {
		try {
			AreaDict areaDict = this.areaDictMapper.loadByAreaCode(areaCode);
			AreaDictDto areaDictDto = null;
			if (null != areaDict) {
				areaDictDto = new AreaDictDto();
				ObjectUtils.fastCopy(areaDict, areaDictDto);
			}
			return areaDictDto;
		} catch (Exception e) {
			String msg = "根据区域编码加载区域信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg);
		}
	}

	@Override
	public List<AreaDictDto> listByAreaType(String areaType) throws SystemServiceException {
		try {
			List<AreaDictDto> areaDictDtoList = null;
			List<AreaDict> areaDictList = this.areaDictMapper.listByAreaType(areaType);
			if (!ObjectUtils.isNullOrEmpty(areaDictList)) {
				areaDictDtoList = new ArrayList<AreaDictDto>();
				for (AreaDict model : areaDictList) {
					AreaDictDto dto = new AreaDictDto();
					ObjectUtils.fastCopy(model, dto);
					areaDictDtoList.add(dto);
				}
			}
			return areaDictDtoList;
		} catch (Exception e) {
			String msg = "根据地区的区域类型来查询区域信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg);
		}
	}

	@Override
	public List<AreaDictDto> listByParentCode(String parentCode) throws SystemServiceException {
		try {
			List<AreaDictDto> areaDictDtoList = null;
			List<AreaDict> areaDictList = this.areaDictMapper.listByParentCode(parentCode);
			if (!ObjectUtils.isNullOrEmpty(areaDictList)) {
				areaDictDtoList = new ArrayList<AreaDictDto>();
				for (AreaDict model : areaDictList) {
					AreaDictDto dto = new AreaDictDto();
					ObjectUtils.fastCopy(model, dto);
					areaDictDtoList.add(dto);
				}
			}
			return areaDictDtoList;
		} catch (Exception e) {
			String msg = "根据父级节点Code加载所有的区域信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg);
		}
	}

	@Override
	public void updateByAreaCode(AreaDictDto areaDictDto) throws SystemServiceException {
		Jedis jedis = null;
		try {
			String areaCode = areaDictDto.getAreaCode();
			if (!StringUtils.isEmpty(areaCode)) {
				AreaDict areaDict = this.areaDictMapper.loadByAreaCode(areaCode);
				if (null != areaDict) {
					areaDict.setAreaName(areaDictDto.getAreaName());
					areaDict.setModifyTime(areaDictDto.getModifyTime());
					areaDict.setModifyUserId(areaDictDto.getModifyUserId());
					this.areaDictMapper.updateByAreaCode(areaDict);
					jedis = JedisUtils.getJedis();
					jedis.set(areaDict.getAreaCode().getBytes(), areaDict.getAreaName().getBytes());
					List<AreaDict> areaDictList = this.areaDictMapper.listByParentCode(areaDict.getParentCode());
					if (!ObjectUtils.isNullOrEmpty(areaDictList)) {
						for (AreaDict ad : areaDictList) {
							if (ad.getAreaCode().equals(areaCode)) {
								ad.setAreaName(areaDictDto.getAreaName());
							}
						}
						setAreaDictListToRedisCache(jedis, areaDict, areaDictList);
					}
				}
			}
		} catch (Exception e) {
			String msg = "根据区域编码更新区域信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg);
		} finally {
			if (null != jedis) {
				JedisUtils.returnResource(jedis);
			}
		}
	}

	/**
	 * 
	 * @Description TODO(封装区域MapList)
	 * @param areaList
	 * @return List<Map<String, String>>
	 */
	protected List<Map<String, String>> encapsulateAreaMapList(List<AreaDict> areaList) {
		List<Map<String, String>> mapList = null;
		if (!ObjectUtils.isNullOrEmpty(areaList)) {
			mapList = new ArrayList<Map<String, String>>();
			for (AreaDict area : areaList) {
				Map<String, String> areaDictInfoMap = new HashMap<String, String>();
				areaDictInfoMap.put("id", area.getAreaCode());
				areaDictInfoMap.put("name", area.getAreaName());
				mapList.add(areaDictInfoMap);
			}
		}
		return mapList;
	}

	/**
	 * 
	 * @Description TODO(将区域字典列表信息存入Redis缓存)
	 * @param jedis
	 * @param areaDict
	 * @param areaDictList
	 */
	private void setAreaDictListToRedisCache(Jedis jedis, AreaDict areaDict, List<AreaDict> areaDictList) {
		if (SystemContext.SystemDomain.AREATYPE_PROVINCE.equals(areaDict.getAreaType())) {
			jedis.set((SystemContext.SystemDomain.AREATYPE_NATION + areaDict.getParentCode()).getBytes(),
					SerializableUtils.write(encapsulateAreaMapList(areaDictList)));
		}
		if (SystemContext.SystemDomain.AREATYPE_CITY.equals(areaDict.getAreaType())) {
			jedis.set((SystemContext.SystemDomain.AREATYPE_PROVINCE + areaDict.getParentCode()).getBytes(),
					SerializableUtils.write(encapsulateAreaMapList(areaDictList)));
		}
		if (SystemContext.SystemDomain.AREATYPE_COUNTY.equals(areaDict.getAreaType())) {
			jedis.set((SystemContext.SystemDomain.AREATYPE_CITY + areaDict.getParentCode()).getBytes(),
					SerializableUtils.write(encapsulateAreaMapList(areaDictList)));
		}
	}

}
