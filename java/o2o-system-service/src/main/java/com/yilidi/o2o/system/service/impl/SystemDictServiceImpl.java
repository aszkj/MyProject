package com.yilidi.o2o.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import redis.clients.jedis.Jedis;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.system.dao.SystemDictHistoryMapper;
import com.yilidi.o2o.system.dao.SystemDictMapper;
import com.yilidi.o2o.system.model.SystemDict;
import com.yilidi.o2o.system.model.SystemDictHistory;
import com.yilidi.o2o.system.service.ISystemDictService;
import com.yilidi.o2o.system.service.dto.SystemDictDto;
import com.yilidi.o2o.system.service.dto.query.SystemDictQuery;

/**
 * 
 * @Description:TODO(这里用一句话描述这个类的作用)
 * @author: chenlian
 * @date: 2015年11月16日 上午11:53:55
 * 
 */
@Service("systemDictService")
public class SystemDictServiceImpl extends BaseService implements ISystemDictService {

	@Autowired
	private SystemDictMapper systemDictMapper;

	@Autowired
	private SystemDictHistoryMapper systemDictHistoryMapper;

	@Override
	public void save(SystemDictDto systemDictDto) throws SystemServiceException {
		Jedis jedis = null;
		try {
			SystemDict dictForCode = this.systemDictMapper.loadByDictCode(systemDictDto.getDictCode());
			if (null != dictForCode) {
				throw new IllegalArgumentException("系统字典编码已经存在");
			}
			SystemDict systemDict = new SystemDict();
			Integer count = this.systemDictMapper.getDictCountsByDictType(systemDictDto.getDictCode());
			systemDictDto.setSort(count.intValue() + 1);
			ObjectUtils.fastCopy(systemDictDto, systemDict);
			this.systemDictMapper.save(systemDict);
			SystemDictHistory systemDictHistory = new SystemDictHistory();
			ObjectUtils.fastCopy(systemDictDto, systemDictHistory);
			systemDictHistory.setDictId(systemDict.getId());
			systemDictHistory.setOperateUserId(systemDict.getCreateUserId());
			systemDictHistory.setOperateTime(systemDict.getCreateTime());
			systemDictHistory.setOperateType(SystemContext.SystemDomain.SYSDICTOPERTYPE_CREATE);
			systemDictHistoryMapper.save(systemDictHistory);
			jedis = JedisUtils.getJedis();
			if (SystemContext.SystemDomain.SYSDICTSTATUS_ON.equals(systemDictDto.getDictStatus())) {
				jedis.hset(systemDictDto.getDictType().getBytes(), systemDictDto.getDictCode().getBytes(), systemDictDto
						.getDictName().getBytes());
				jedis.set(systemDictDto.getDictCode().getBytes(),
						StringUtils.stringToByte(systemDictDto.getSort().toString(), "UTF-8"));
			}
		} catch (Exception e) {
			String msg = "";
			if (!StringUtils.isEmpty(e.getMessage())) {
				msg = e.getMessage();
			} else {
				msg = "创建系统字典信息出现系统异常";
			}
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		} finally {
			if (null != jedis) {
				JedisUtils.returnResource(jedis);
			}
		}
	}

	@Override
	public SystemDictDto loadById(Integer id) throws SystemServiceException {
		try {
			SystemDict systemDict = this.systemDictMapper.loadById(id);
			SystemDictDto systemDictDto = null;
			if (null != systemDict) {
				systemDictDto = new SystemDictDto();
				ObjectUtils.fastCopy(systemDict, systemDictDto);
			}
			return systemDictDto;
		} catch (Exception e) {
			String msg = "根据字典ID获取字典信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public SystemDictDto loadByDictCode(String dictCode) throws SystemServiceException {
		try {
			SystemDict systemDict = this.systemDictMapper.loadByDictCode(dictCode);
			SystemDictDto systemDictDto = null;
			if (null != systemDict) {
				systemDictDto = new SystemDictDto();
				ObjectUtils.fastCopy(systemDict, systemDictDto);
			}
			return systemDictDto;
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
	public List<SystemDictDto> listAllValidDictByDictType(String dictType) throws SystemServiceException {
		try {
			List<SystemDict> systemDictList = this.systemDictMapper.listAllValidDictByDictType(dictType);
			List<SystemDictDto> systemDictDtoList = new ArrayList<SystemDictDto>();
			if (!ObjectUtils.isNullOrEmpty(systemDictList)) {
				for (SystemDict model : systemDictList) {
					SystemDictDto dto = new SystemDictDto();
					ObjectUtils.fastCopy(model, dto);
					systemDictDtoList.add(dto);
				}
			}
			return systemDictDtoList;
		} catch (Exception e) {
			String msg = "根据字典类型获取有效的字典列表信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public YiLiDiPage<SystemDictDto> findSystemDict(SystemDictQuery systemDictQuery) throws SystemServiceException {
		try {
			if (null == systemDictQuery.getStart() || systemDictQuery.getStart() <= 0) {
				systemDictQuery.setStart(1);
			}
			if (null == systemDictQuery.getPageSize() || systemDictQuery.getPageSize() <= 0) {
				systemDictQuery.setPageSize(CommonConstants.PAGE_SIZE);
			}
			PageHelper.startPage(systemDictQuery.getStart(), systemDictQuery.getPageSize());
			Page<SystemDict> page = systemDictMapper.findSystemDict(systemDictQuery);
			Page<SystemDictDto> pageDto = new Page<SystemDictDto>(systemDictQuery.getStart(), systemDictQuery.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);
			List<SystemDict> systemDicts = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(systemDicts)) {
				for (SystemDict systemDict : systemDicts) {
					SystemDictDto systemDictDto = new SystemDictDto();
					ObjectUtils.fastCopy(systemDict, systemDictDto);
					pageDto.add(systemDictDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			String msg = "分页获取系统字典信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public void update(SystemDictDto systemDictDto) throws SystemServiceException {
		Jedis jedis = null;
		try {
			Integer systemDictId = systemDictDto.getId();
			if (null != systemDictId) {
				SystemDict systemDict = this.systemDictMapper.loadById(systemDictId);
				if (null != systemDict) {
					systemDict.setDictName(systemDictDto.getDictName());
					systemDict.setTypeName(systemDictDto.getTypeName());
					systemDict.setDictDesc(systemDictDto.getDictDesc());
					systemDict.setDictStatus(systemDictDto.getDictStatus());
					systemDict.setModifyTime(systemDictDto.getModifyTime());
					systemDict.setModifyUserId(systemDictDto.getModifyUserId());
					this.systemDictMapper.updateById(systemDict);
					SystemDictHistory systemDictHistory = new SystemDictHistory();
					ObjectUtils.fastCopy(systemDict, systemDictHistory);
					systemDictHistory.setDictId(systemDict.getId());
					systemDictHistory.setOperateUserId(systemDict.getModifyUserId());
					systemDictHistory.setOperateTime(systemDict.getModifyTime());
					systemDictHistory.setOperateType(SystemContext.SystemDomain.SYSDICTOPERTYPE_MODIFY);
					systemDictHistoryMapper.save(systemDictHistory);
					jedis = JedisUtils.getJedis();
					if (SystemContext.SystemDomain.SYSDICTSTATUS_OFF.equals(systemDictDto.getDictStatus())) {
						jedis.hdel(systemDict.getDictType().getBytes(), systemDict.getDictCode().getBytes());
						//jedis.del(systemDict.getDictCode().getBytes());
					} else {
						jedis.hset(systemDict.getDictType().getBytes(), systemDict.getDictCode().getBytes(), systemDict
								.getDictName().getBytes());
					}
				}
			}
		} catch (Exception e) {
			String msg = "修改系统字典信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		} finally {
			if (null != jedis) {
				JedisUtils.returnResource(jedis);
			}
		}
	}

	@Override
	public void updateStatus(SystemDictDto systemDictDto) throws SystemServiceException {
		Jedis jedis = null;
		try {
			Integer systemDictId = systemDictDto.getId();
			if (null != systemDictId) {
				SystemDict systemDict = this.systemDictMapper.loadById(systemDictId);
				if (null != systemDict) {
					systemDict.setDictStatus(systemDictDto.getDictStatus());
					systemDict.setModifyTime(systemDictDto.getModifyTime());
					systemDict.setModifyUserId(systemDictDto.getModifyUserId());
					this.systemDictMapper.updateById(systemDict);
					SystemDictHistory systemDictHistory = new SystemDictHistory();
					ObjectUtils.fastCopy(systemDict, systemDictHistory);
					systemDictHistory.setDictId(systemDict.getId());
					systemDictHistory.setOperateUserId(systemDict.getModifyUserId());
					systemDictHistory.setOperateTime(systemDict.getModifyTime());
					if (SystemContext.SystemDomain.SYSDICTSTATUS_ON.equals(systemDictDto.getDictStatus())) {
						systemDictHistory.setOperateType(SystemContext.SystemDomain.SYSDICTOPERTYPE_ON);
					} else {
						systemDictHistory.setOperateType(SystemContext.SystemDomain.SYSDICTOPERTYPE_OFF);
					}
					systemDictHistoryMapper.save(systemDictHistory);
					jedis = JedisUtils.getJedis();
					if (SystemContext.SystemDomain.SYSDICTSTATUS_OFF.equals(systemDictDto.getDictStatus())) {
						jedis.hdel(systemDict.getDictType().getBytes(), systemDict.getDictCode().getBytes());
						//jedis.del(systemDict.getDictCode().getBytes());
					} else {
						jedis.hset(systemDict.getDictType().getBytes(), systemDict.getDictCode().getBytes(), systemDict
								.getDictName().getBytes());
					}
				}
			}
		} catch (Exception e) {
			String msg = "修改系统字典状态出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		} finally {
			if (null != jedis) {
				JedisUtils.returnResource(jedis);
			}
		}
	}

	@Override
	public void updateSort(SystemDictDto systemDictDto) throws SystemServiceException {
		Jedis jedis = null;
		try {
			Integer systemDictId = systemDictDto.getId();
			if (null != systemDictId) {
				SystemDict systemDict = this.systemDictMapper.loadById(systemDictId);
				if (null != systemDict) {
					systemDict.setSort(systemDictDto.getSort());
					systemDict.setModifyTime(systemDictDto.getModifyTime());
					systemDict.setModifyUserId(systemDictDto.getModifyUserId());
					this.systemDictMapper.updateById(systemDict);
					SystemDictHistory systemDictHistory = new SystemDictHistory();
					ObjectUtils.fastCopy(systemDict, systemDictHistory);
					systemDictHistory.setDictId(systemDict.getId());
					systemDictHistory.setOperateUserId(systemDict.getModifyUserId());
					systemDictHistory.setOperateTime(systemDict.getModifyTime());
					systemDictHistory.setOperateType(SystemContext.SystemDomain.SYSDICTOPERTYPE_MODIFY);
					systemDictHistoryMapper.save(systemDictHistory);
					jedis = JedisUtils.getJedis();
					jedis.set(systemDict.getDictCode().getBytes(),
							StringUtils.stringToByte(systemDict.getSort().toString(), "UTF-8"));
				}
			}
		} catch (Exception e) {
			String msg = "修改系统字典排序出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		} finally {
			if (null != jedis) {
				JedisUtils.returnResource(jedis);
			}
		}
	}

}
