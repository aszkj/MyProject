package com.yilidi.o2o.controller.operation.system;

import java.util.Date;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.system.service.ISystemParamsService;
import com.yilidi.o2o.system.service.dto.SystemParamsDto;
import com.yilidi.o2o.system.service.dto.query.SystemParamsQuery;

/**
 * 
 * @Description:TODO(系统参数Controller)
 * @author: chenlian
 * @date: 2015年12月1日 下午7:24:00
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class SystemParamsController extends OperationBaseController {

	protected Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private ISystemParamsService systemParamsService;

	/**
	 * @Description TODO(分页查询系统参数)
	 * @param query
	 * @return MsgBean
	 */
	@RequestMapping(value = "/searchSystemParams")
	@ResponseBody
	public MsgBean searchSystemParams(@RequestBody SystemParamsQuery query) {
		try {
			YiLiDiPage<SystemParamsDto> page = systemParamsService.findSystemParams(query);
			return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "分页查询系统参数成功");
		} catch (Exception e) {
			logger.error("分页查询系统参数失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * @Description TODO(根据参数ID查询系统参数详情信息)
	 * @param id
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{id}/loadSystemParamsById")
	@ResponseBody
	public MsgBean loadSystemParamsById(@PathVariable("id") Integer id) {
		try {
			SystemParamsDto systemParamsDto = systemParamsService.loadByParamsId(id);
			return super.encapsulateMsgBean(systemParamsDto, MsgBean.MsgCode.SUCCESS, "根据参数ID查询系统参数详情信息成功");
		} catch (Exception e) {
			logger.error("根据参数ID查询系统参数详情信息失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * @Description TODO(根据参数编码验证该编码是否存在)
	 * @param paramsCode
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{id}-{paramsCode}/checkParamsCodeIsExist")
	@ResponseBody
	public MsgBean checkParamsCodeIsExist(@PathVariable("id") Integer id, @PathVariable("paramsCode") String paramsCode) {
		try {
			SystemParamsDto systemParamsDto = systemParamsService.loadByParamsCode(paramsCode);
			if (null == systemParamsDto) {
				return super.encapsulateMsgBean(true, MsgBean.MsgCode.SUCCESS, "参数编码不存在");
			} else {
				if (null == id) {
					return super.encapsulateMsgBean(false, MsgBean.MsgCode.SUCCESS, "参数编码已存在");
				} else {
					SystemParamsDto sDto = systemParamsService.loadByParamsId(id);
					if (paramsCode.equals(sDto.getParamsCode())) {
						return super.encapsulateMsgBean(true, MsgBean.MsgCode.SUCCESS, "参数编码不存在");
					} else {
						return super.encapsulateMsgBean(false, MsgBean.MsgCode.SUCCESS, "参数编码已存在");
					}
				}
			}
		} catch (Exception e) {
			logger.error("对该编码是否存在的验证失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * @Description TODO(根据参数名称验证该名称是否存在)
	 * @param paramName
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{id}-{paramName}/checkParamNameIsExist")
	@ResponseBody
	public MsgBean checkParamNameIsExist(@PathVariable("id") Integer id, @PathVariable("paramName") String paramName) {
		try {
			SystemParamsDto systemParamsDto = systemParamsService.loadByParamName(paramName);
			if (null == systemParamsDto) {
				return super.encapsulateMsgBean(true, MsgBean.MsgCode.SUCCESS, "参数名称不存在");
			} else {
				if (null == id) {
					return super.encapsulateMsgBean(false, MsgBean.MsgCode.SUCCESS, "参数名称已存在");
				} else {
					SystemParamsDto sDto = systemParamsService.loadByParamsId(id);
					if (paramName.equals(sDto.getParamName())) {
						return super.encapsulateMsgBean(true, MsgBean.MsgCode.SUCCESS, "参数名称不存在");
					} else {
						return super.encapsulateMsgBean(false, MsgBean.MsgCode.SUCCESS, "参数名称已存在");
					}
				}
			}
		} catch (Exception e) {
			logger.error("对该名称是否存在的验证失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * @Description TODO(新增系统参数)
	 * @param systemParamsDto
	 * @return MsgBean
	 */
	@RequestMapping(value = "/saveSystemParam")
	@ResponseBody
	public MsgBean saveSystemParam(@RequestBody SystemParamsDto systemParamsDto) {
		try {
			Param paramsCode = new Param.Builder("参数编码", Param.ParamType.STR_NORMAL.getType(),
					systemParamsDto.getParamsCode(), false).build();
			Param paramName = new Param.Builder("参数名称", Param.ParamType.STR_NORMAL.getType(),
					systemParamsDto.getParamName(), false).build();
			Param paramValue = new Param.Builder("参数值", Param.ParamType.STR_NORMAL.getType(),
					systemParamsDto.getParamValue(), false).build();
			Param paramStatus = new Param.Builder("参数状态", Param.ParamType.STR_NORMAL.getType(),
					systemParamsDto.getParamStatus(), false).build();
			Param note = new Param.Builder("备注", Param.ParamType.STR_NORMAL.getType(), systemParamsDto.getNote(), true)
					.maxLength(50).build();
			super.validateParams(paramsCode, paramName, paramValue, paramStatus, note);
			systemParamsDto.setCreateUserId(super.getUserId());
			systemParamsDto.setCreateTime(new Date());
			systemParamsService.save(systemParamsDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "新增系统参数成功");
		} catch (Exception e) {
			logger.error("新增系统参数失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * @Description TODO(修改系统参数)
	 * @param systemParamsDto
	 * @return MsgBean
	 */
	@RequestMapping(value = "/updateSystemParam")
	@ResponseBody
	public MsgBean updateSystemParam(@RequestBody SystemParamsDto systemParamsDto) {
		try {
			Param paramsCode = new Param.Builder("参数编码", Param.ParamType.STR_NORMAL.getType(),
					systemParamsDto.getParamsCode(), false).build();
			Param paramName = new Param.Builder("参数名称", Param.ParamType.STR_NORMAL.getType(),
					systemParamsDto.getParamName(), false).build();
			Param paramValue = new Param.Builder("参数值", Param.ParamType.STR_NORMAL.getType(),
					systemParamsDto.getParamValue(), false).build();
			Param paramStatus = new Param.Builder("参数状态", Param.ParamType.STR_NORMAL.getType(),
					systemParamsDto.getParamStatus(), false).build();
			Param note = new Param.Builder("备注", Param.ParamType.STR_NORMAL.getType(), systemParamsDto.getNote(), true)
					.maxLength(50).build();
			super.validateParams(paramsCode, paramName, paramValue, paramStatus, note);
			systemParamsDto.setModifyUserId(super.getUserId());
			systemParamsDto.setModifyTime(new Date());
			systemParamsService.update(systemParamsDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改系统参数成功");
		} catch (Exception e) {
			logger.error("修改系统参数失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}
	
	/**
	 * @Description TODO(修改系统参数)
	 * @param systemParamsDto
	 * @return MsgBean
	 */
	@RequestMapping(value = "/updateSystemParamValue")
	@ResponseBody
	public MsgBean updateSystemParamValue(@RequestBody SystemParamsDto systemParamsDto) {
		try {
			if(ObjectUtils.isNullOrEmpty(systemParamsDto.getId()) || StringUtils.isEmpty(systemParamsDto.getParamValue())){
				return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE,"数据有误");
			}
			systemParamsDto.setModifyUserId(super.getUserId());
			systemParamsDto.setModifyTime(new Date());
			systemParamsService.updateSystemParamValue(systemParamsDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改系统参数成功");
		} catch (Exception e) {
			logger.error("修改系统参数失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	@RequestMapping(value = "/{id}-{paramStatus}/changeSystemParamStatus")
	@ResponseBody
	public MsgBean changeSystemParamStatus(@PathVariable("id") Integer id, @PathVariable("paramStatus") String paramStatus) {
		try {
			SystemParamsDto systemParamsDto = new SystemParamsDto();
			systemParamsDto.setId(id);
			systemParamsDto.setModifyUserId(super.getUserId());
			systemParamsDto.setModifyTime(new Date());
			systemParamsDto.setParamStatus(paramStatus);
			systemParamsService.updateStatus(systemParamsDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "更新系统参数状态成功");
		} catch (Exception e) {
			logger.error("更新系统参数状态失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}
	
	/**
	 * 根据参数code获取参数
	 * @param paramsCode
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{paramsCode}/getSystemParamByParamsCode")
	@ResponseBody
	public MsgBean getSystemParamByParamsCode(@PathVariable("paramsCode") String paramsCode) {
		try {
			SystemParamsDto systemParamsDto = new SystemParamsDto();
			systemParamsDto.setParamStatus(SystemContext.SystemDomain.SYSPARAMSTATUS_ON);
			systemParamsDto.setParamsCode(paramsCode);
			SystemParamsDto paramDto = systemParamsService.getSystemParamByParamsCode(systemParamsDto);
			return super.encapsulateMsgBean(paramDto,MsgBean.MsgCode.SUCCESS, "获取系统参数状态成功");
		} catch (Exception e) {
			logger.error("获取系统参数状态失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

}