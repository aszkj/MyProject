package com.yilidi.o2o.system.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
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
import com.yilidi.o2o.system.dao.SystemParamsHistoryMapper;
import com.yilidi.o2o.system.dao.SystemParamsMapper;
import com.yilidi.o2o.system.model.SystemParams;
import com.yilidi.o2o.system.model.SystemParamsHistory;
import com.yilidi.o2o.system.service.ISystemParamsService;
import com.yilidi.o2o.system.service.dto.SystemParamsDto;
import com.yilidi.o2o.system.service.dto.query.SystemParamsQuery;

/**
 * 系统参数服务接口实现类
 * 
 * @author chenl
 * 
 */
@Service("systemParamsService")
public class SystemParamsServiceImpl extends BaseService implements ISystemParamsService {

	@Autowired
	private SystemParamsMapper systemParamsMapper;

	@Autowired
	private SystemParamsHistoryMapper systemParamsHistoryMapper;

	@Override
	public void save(SystemParamsDto systemParamsDto) throws SystemServiceException {
		Jedis jedis = null;
		try {
			SystemParams paramForCode = this.systemParamsMapper.loadByParamsCode(systemParamsDto.getParamsCode());
			SystemParams paramForName = this.systemParamsMapper.loadByParamName(systemParamsDto.getParamName());
			if (null != paramForCode) {
				throw new IllegalArgumentException("系统参数编码已经存在");
			}
			if (null != paramForName) {
				throw new IllegalArgumentException("系统参数名称已经存在");
			}
			SystemParams systemParams = new SystemParams();
			ObjectUtils.fastCopy(systemParamsDto, systemParams);
			this.systemParamsMapper.save(systemParams);
			SystemParamsHistory systemParamsHistory = new SystemParamsHistory();
			ObjectUtils.fastCopy(systemParamsDto, systemParamsHistory);
			systemParamsHistory.setParamsId(systemParams.getId());
			systemParamsHistory.setOperateUserId(systemParams.getCreateUserId());
			systemParamsHistory.setOperateTime(systemParams.getCreateTime());
			systemParamsHistory.setOperateType(SystemContext.SystemDomain.SYSPARAMOPERTYPE_CREATE);
			systemParamsHistoryMapper.save(systemParamsHistory);
			jedis = JedisUtils.getJedis();
			if (SystemContext.SystemDomain.SYSPARAMSTATUS_ON.equals(systemParamsDto.getParamStatus())) {
				jedis.set(systemParamsDto.getParamsCode().getBytes(), systemParamsDto.getParamValue().getBytes());
			}
		} catch (Exception e) {
			String msg = "";
			if (!StringUtils.isEmpty(e.getMessage())) {
				msg = e.getMessage();
			} else {
				msg = "创建系统参数信息出现系统异常";
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
	public SystemParamsDto loadByParamsId(Integer paramsId) throws SystemServiceException {
		try {
			SystemParams systemParams = systemParamsMapper.loadById(paramsId);
			SystemParamsDto systemParamsDto = null;
			if (null != systemParams) {
				systemParamsDto = new SystemParamsDto();
				ObjectUtils.fastCopy(systemParams, systemParamsDto);
			}
			return systemParamsDto;
		} catch (Exception e) {
			String msg = "根据参数ID加载系统参数出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg);
		}
	}

	@Override
	public SystemParamsDto loadByParamsCode(String paramsCode) throws SystemServiceException {
		try {
			SystemParams systemParams = systemParamsMapper.loadByParamsCode(paramsCode);
			SystemParamsDto systemParamsDto = null;
			if (null != systemParams) {
				systemParamsDto = new SystemParamsDto();
				ObjectUtils.fastCopy(systemParams, systemParamsDto);
			}
			return systemParamsDto;
		} catch (Exception e) {
			String msg = "根据参数编码加载系统参数出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg);
		}
	}

	@Override
	public SystemParamsDto loadByParamName(String paramName) throws SystemServiceException {
		try {
			SystemParams systemParams = systemParamsMapper.loadByParamName(paramName);
			SystemParamsDto systemParamsDto = null;
			if (null != systemParams) {
				systemParamsDto = new SystemParamsDto();
				ObjectUtils.fastCopy(systemParams, systemParamsDto);
			}
			return systemParamsDto;
		} catch (Exception e) {
			String msg = "根据参数名称加载系统参数出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg);
		}
	}

	@Override
	public List<SystemParamsDto> listAllValidSystemParams() throws SystemServiceException {
		try {
			List<SystemParamsDto> systemParamsDtoList = null;
			List<SystemParams> systemParamsList = systemParamsMapper
					.listByParamStatus(SystemContext.SystemDomain.SYSPARAMSTATUS_ON);
			if (!ObjectUtils.isNullOrEmpty(systemParamsList)) {
				systemParamsDtoList = new ArrayList<SystemParamsDto>();
				for (SystemParams model : systemParamsList) {
					SystemParamsDto dto = new SystemParamsDto();
					ObjectUtils.fastCopy(model, dto);
					systemParamsDtoList.add(dto);
				}
			}
			return systemParamsDtoList;
		} catch (Exception e) {
			String msg = "获取所有有效的系统参数列表信息出现异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg);
		}
	}

	@Override
	public YiLiDiPage<SystemParamsDto> findSystemParams(SystemParamsQuery systemParamsQuery) throws SystemServiceException {
		try {
			if (null == systemParamsQuery.getStart() || systemParamsQuery.getStart() <= 0) {
				systemParamsQuery.setStart(1);
			}
			if (null == systemParamsQuery.getPageSize() || systemParamsQuery.getPageSize() <= 0) {
				systemParamsQuery.setPageSize(CommonConstants.PAGE_SIZE);
			}
			PageHelper.startPage(systemParamsQuery.getStart(), systemParamsQuery.getPageSize());
			Page<SystemParams> page = systemParamsMapper.findSystemParams(systemParamsQuery);
			Page<SystemParamsDto> pageDto = new Page<SystemParamsDto>(systemParamsQuery.getStart(),
					systemParamsQuery.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);
			List<SystemParams> systemParamss = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(systemParamss)) {
				for (SystemParams systemParams : systemParamss) {
					SystemParamsDto systemParamsDto = new SystemParamsDto();
					ObjectUtils.fastCopy(systemParams, systemParamsDto);
					pageDto.add(systemParamsDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			String msg = "分页获取系统参数信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg);
		}
	}

	@Override
	public void update(SystemParamsDto systemParamsDto) throws SystemServiceException {
		Jedis jedis = null;
		try {
			Integer systemParamsId = systemParamsDto.getId();
			if (null != systemParamsId) {
				SystemParams systemParams = this.systemParamsMapper.loadById(systemParamsId);
				if (null != systemParams) {
					SystemParams paramForCode = this.systemParamsMapper.loadByParamsCode(systemParamsDto.getParamsCode());
					SystemParams paramForName = this.systemParamsMapper.loadByParamName(systemParamsDto.getParamName());
					if (null != paramForCode) {
						if (!systemParams.getParamsCode().equals(paramForCode.getParamsCode())) {
							throw new IllegalArgumentException("系统参数编码已经存在");
						}
					}
					if (null != paramForName) {
						if (!systemParams.getParamName().equals(paramForName.getParamName())) {
							throw new IllegalArgumentException("系统参数名称已经存在");
						}
					}
					systemParams.setParamName(systemParamsDto.getParamName());
					systemParams.setParamValue(systemParamsDto.getParamValue());
					systemParams.setParamStatus(systemParamsDto.getParamStatus());
					systemParams.setModifyTime(systemParamsDto.getModifyTime());
					systemParams.setModifyUserId(systemParamsDto.getModifyUserId());
					systemParams.setNote(systemParamsDto.getNote());
					this.systemParamsMapper.updateById(systemParams);
					SystemParamsHistory systemParamsHistory = new SystemParamsHistory();
					ObjectUtils.fastCopy(systemParams, systemParamsHistory);
					systemParamsHistory.setParamsId(systemParams.getId());
					systemParamsHistory.setOperateUserId(systemParams.getModifyUserId());
					systemParamsHistory.setOperateTime(systemParams.getModifyTime());
					systemParamsHistory.setOperateType(SystemContext.SystemDomain.SYSPARAMOPERTYPE_MODIFY);
					systemParamsHistoryMapper.save(systemParamsHistory);
					jedis = JedisUtils.getJedis();
					if (SystemContext.SystemDomain.SYSPARAMSTATUS_OFF.equals(systemParamsDto.getParamStatus())) {
						jedis.del(systemParams.getParamsCode().getBytes());
					} else {
						jedis.set(systemParams.getParamsCode().getBytes(), systemParams.getParamValue().getBytes());
					}
				}
			}
		} catch (Exception e) {
			String msg = "";
			if (!StringUtils.isEmpty(e.getMessage())) {
				msg = e.getMessage();
			} else {
				msg = "修改系统参数信息出现系统异常";
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
	public void updateStatus(SystemParamsDto systemParamsDto) throws SystemServiceException {
		Jedis jedis = null;
		try {
			Integer systemParamsId = systemParamsDto.getId();
			if (null != systemParamsId) {
				SystemParams systemParams = this.systemParamsMapper.loadById(systemParamsId);
				if (null != systemParams) {
					systemParams.setParamStatus(systemParamsDto.getParamStatus());
					systemParams.setModifyTime(systemParamsDto.getModifyTime());
					systemParams.setModifyUserId(systemParamsDto.getModifyUserId());
					this.systemParamsMapper.updateById(systemParams);
					SystemParamsHistory systemParamsHistory = new SystemParamsHistory();
					ObjectUtils.fastCopy(systemParams, systemParamsHistory);
					systemParamsHistory.setParamsId(systemParams.getId());
					systemParamsHistory.setOperateUserId(systemParams.getModifyUserId());
					systemParamsHistory.setOperateTime(systemParams.getModifyTime());
					if (SystemContext.SystemDomain.SYSPARAMSTATUS_ON.equals(systemParamsDto.getParamStatus())) {
						systemParamsHistory.setOperateType(SystemContext.SystemDomain.SYSPARAMOPERTYPE_ON);
					} else {
						systemParamsHistory.setOperateType(SystemContext.SystemDomain.SYSPARAMOPERTYPE_OFF);
					}
					systemParamsHistoryMapper.save(systemParamsHistory);
					jedis = JedisUtils.getJedis();
					if (SystemContext.SystemDomain.SYSPARAMSTATUS_OFF.equals(systemParamsDto.getParamStatus())) {
						jedis.del(systemParams.getParamsCode().getBytes());
					} else {
						jedis.set(systemParams.getParamsCode().getBytes(), systemParams.getParamValue().getBytes());
					}
				}
			}
		} catch (Exception e) {
			String msg = "";
			if (!StringUtils.isEmpty(e.getMessage())) {
				msg = e.getMessage();
			} else {
				msg = "修改系统参数状态出现系统异常";
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
	public SystemParamsDto getSystemParamByParamsCode(SystemParamsDto systemParamsDto) {
		SystemParams systemParams = new SystemParams();
		ObjectUtils.fastCopy(systemParamsDto, systemParams);
		SystemParamsDto paramsDto = null;
		SystemParams params = systemParamsMapper.getSystemParamByParamsCode(systemParams);
		if(!ObjectUtils.isNullOrEmpty(params)){
			paramsDto = new SystemParamsDto();
			ObjectUtils.fastCopy(params, paramsDto);
		}
		return paramsDto;
		
	}

	@Override
	public void updateSystemParamValue(SystemParamsDto systemParamsDto) {
		SystemParams systemParams = new SystemParams();
		ObjectUtils.fastCopy(systemParamsDto, systemParams);
		this.systemParamsMapper.updateByIdSelective(systemParams);
	}

}
