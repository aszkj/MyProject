package com.yilidi.o2o.controller.operation.system;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.system.service.ISystemDictService;
import com.yilidi.o2o.system.service.dto.SystemDictDto;
import com.yilidi.o2o.system.service.dto.query.SystemDictQuery;

/**
 * 
 * @Description:TODO(系统字典Controller)
 * @author: chenlian
 * @date: 2015年12月2日 下午4:07:22
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class SystemDictController extends OperationBaseController {

	protected Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private ISystemDictService systemDictService;

	/**
	 * @Description TODO(分页查询系统字典)
	 * @param query
	 * @return MsgBean
	 */
	@RequestMapping(value = "/searchSystemDict")
	@ResponseBody
	public MsgBean searchSystemDict(@RequestBody SystemDictQuery query) {
		try {
			YiLiDiPage<SystemDictDto> page = systemDictService.findSystemDict(query);
			return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "分页查询系统字典成功");
		} catch (Exception e) {
			logger.error("分页查询系统字典失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(获取所有有效的系统字典类型列表)
	 * @return MsgBean
	 */
	@RequestMapping(value = "/getAllValidDictTypes")
	@ResponseBody
	public MsgBean getAllValidDictTypes() {
		try {
			List<Map<String, String>> mapList = systemDictService.listAllValidDictType();
			return super.encapsulateMsgBean(mapList, MsgBean.MsgCode.SUCCESS, "获取所有有效的系统字典类型列表成功");
		} catch (Exception e) {
			logger.error("获取所有有效的系统字典类型列表失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * @Description TODO(根据字典ID查询系统字典详情信息)
	 * @param id
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{id}/loadSystemDictById")
	@ResponseBody
	public MsgBean loadSystemDictById(@PathVariable("id") Integer id) {
		try {
			SystemDictDto systemDictDto = systemDictService.loadById(id);
			return super.encapsulateMsgBean(systemDictDto, MsgBean.MsgCode.SUCCESS, "根据字典ID查询系统字典详情信息成功");
		} catch (Exception e) {
			logger.error("根据字典ID查询系统字典详情信息失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * @Description TODO(根据字典编码验证该编码是否存在)
	 * @param paramsCode
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{id}-{dictCode}/checkDictCodeIsExist")
	@ResponseBody
	public MsgBean checkDictCodeIsExist(@PathVariable("id") Integer id, @PathVariable("dictCode") String dictCode) {
		try {
			SystemDictDto systemDictDto = systemDictService.loadByDictCode(dictCode);
			if (null == systemDictDto) {
				return super.encapsulateMsgBean(true, MsgBean.MsgCode.SUCCESS, "字典编码不存在");
			} else {
				if (null == id) {
					return super.encapsulateMsgBean(false, MsgBean.MsgCode.SUCCESS, "字典编码已存在");
				} else {
					SystemDictDto sDto = systemDictService.loadById(id);
					if (dictCode.equals(sDto.getDictCode())) {
						return super.encapsulateMsgBean(true, MsgBean.MsgCode.SUCCESS, "字典编码不存在");
					} else {
						return super.encapsulateMsgBean(false, MsgBean.MsgCode.SUCCESS, "字典编码已存在");
					}
				}
			}
		} catch (Exception e) {
			logger.error("对该编码是否存在的验证失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * @Description TODO(新增系统字典)
	 * @param systemDictDto
	 * @return MsgBean
	 */
	@RequestMapping(value = "/saveSystemDict")
	@ResponseBody
	public MsgBean saveSystemDict(@RequestBody SystemDictDto systemDictDto) {
		try {
			Param dictType = new Param.Builder("字典类型编码", Param.ParamType.STR_NORMAL.getType(), systemDictDto.getDictType(),
					false).build();
			Param typeName = new Param.Builder("字典类型名称", Param.ParamType.STR_NORMAL.getType(), systemDictDto.getTypeName(),
					false).build();
			Param dictCode = new Param.Builder("字典编码", Param.ParamType.STR_NORMAL.getType(), systemDictDto.getDictCode(),
					false).build();
			Param dictName = new Param.Builder("字典名称", Param.ParamType.STR_NORMAL.getType(), systemDictDto.getDictName(),
					false).build();
			Param dictStatus = new Param.Builder("字典状态", Param.ParamType.STR_NORMAL.getType(),
					systemDictDto.getDictStatus(), false).build();
			Param dictDesc = new Param.Builder("字典描述", Param.ParamType.STR_NORMAL.getType(), systemDictDto.getDictDesc(),
					true).maxLength(50).build();
			super.validateParams(dictType, typeName, dictCode, dictName, dictStatus, dictDesc);
			systemDictDto.setCreateUserId(super.getUserId());
			systemDictDto.setCreateTime(new Date());
			systemDictService.save(systemDictDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "新增系统字典成功");
		} catch (Exception e) {
			logger.error("新增系统字典失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * @Description TODO(修改系统字典)
	 * @param systemDictDto
	 * @return MsgBean
	 */
	@RequestMapping(value = "/updateSystemDict")
	@ResponseBody
	public MsgBean updateSystemDict(@RequestBody SystemDictDto systemDictDto) {
		try {
			Param dictType = new Param.Builder("字典类型编码", Param.ParamType.STR_NORMAL.getType(), systemDictDto.getDictType(),
					false).build();
			Param typeName = new Param.Builder("字典类型名称", Param.ParamType.STR_NORMAL.getType(), systemDictDto.getTypeName(),
					false).build();
			Param dictCode = new Param.Builder("字典编码", Param.ParamType.STR_NORMAL.getType(), systemDictDto.getDictCode(),
					false).build();
			Param dictName = new Param.Builder("字典名称", Param.ParamType.STR_NORMAL.getType(), systemDictDto.getDictName(),
					false).build();
			Param dictStatus = new Param.Builder("字典状态", Param.ParamType.STR_NORMAL.getType(),
					systemDictDto.getDictStatus(), false).build();
			Param dictDesc = new Param.Builder("字典描述", Param.ParamType.STR_NORMAL.getType(), systemDictDto.getDictDesc(),
					true).maxLength(50).build();
			super.validateParams(dictType, typeName, dictCode, dictName, dictStatus, dictDesc);
			systemDictDto.setModifyUserId(super.getUserId());
			systemDictDto.setModifyTime(new Date());
			systemDictService.update(systemDictDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改系统字典成功");
		} catch (Exception e) {
			logger.error("修改系统字典失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(更新系统字典状态)
	 * @param id
	 * @param dictStatus
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{id}-{dictStatus}/changeSystemDictStatus")
	@ResponseBody
	public MsgBean changeSystemDictStatus(@PathVariable("id") Integer id, @PathVariable("dictStatus") String dictStatus) {
		try {
			SystemDictDto systemDictDto = new SystemDictDto();
			systemDictDto.setId(id);
			systemDictDto.setModifyUserId(super.getUserId());
			systemDictDto.setModifyTime(new Date());
			systemDictDto.setDictStatus(dictStatus);
			systemDictService.updateStatus(systemDictDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "更新系统字典状态成功");
		} catch (Exception e) {
			logger.error("更新系统字典状态失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	@RequestMapping(value = "/{id}-{sort}/changeDictSort")
	@ResponseBody
	public MsgBean changeDictSort(@PathVariable("id") Integer id, @PathVariable("sort") Integer sort) {
		try {
			SystemDictDto systemDictDto = new SystemDictDto();
			systemDictDto.setId(id);
			systemDictDto.setModifyUserId(super.getUserId());
			systemDictDto.setModifyTime(new Date());
			systemDictDto.setSort(sort);
			systemDictService.updateSort(systemDictDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "更新系统字典排序成功");
		} catch (Exception e) {
			logger.error("更新系统字典排序失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

}