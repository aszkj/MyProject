package com.yilidi.o2o.controller.operation.system;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.service.IAreaDictService;
import com.yilidi.o2o.system.service.dto.AreaDictDto;

/**
 * 
 * @Description:TODO(区域字典Controller)
 * @author: chenlian
 * @date: 2015年12月3日 下午5:05:41
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class AreaDictController extends OperationBaseController {

	protected Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private IAreaDictService areaDictService;

	/**
	 * 
	 * @Description TODO(根据父级节点Code获取其下所有的区域信息列表)
	 * @param parentCode
	 * @return
	 */
	@RequestMapping(value = "/{parentCode}/getAreaDictsByParentCode")
	@ResponseBody
	public MsgBean getAreaDictsByParentCode(@PathVariable("parentCode") String parentCode) {
		try {
			List<AreaDictDto> areaDictDtoList = areaDictService.listByParentCode(parentCode);
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			if (!ObjectUtils.isNullOrEmpty(areaDictDtoList)) {
				for (AreaDictDto areaDictDto : areaDictDtoList) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("text", areaDictDto.getAreaName());
					map.put("id", areaDictDto.getAreaCode());
					map.put("pid", areaDictDto.getParentCode());
					map.put("expanded", false);
					map.put("areaType", areaDictDto.getAreaType());
					if (SystemContext.SystemDomain.AREATYPE_PROVINCE.equals(areaDictDto.getAreaType())
							|| SystemContext.SystemDomain.AREATYPE_CITY.equals(areaDictDto.getAreaType())) {
						map.put("hasChildren", true);
					}
					list.add(map);
				}
			}
			return super.encapsulateMsgBean(list, MsgBean.MsgCode.SUCCESS, "根据父级节点Code获取其下所有的区域信息列表成功");
		} catch (Exception e) {
			logger.error("根据父级节点Code获取其下所有的区域信息列表失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	@RequestMapping(value = "/addAreaDict")
	@ResponseBody
	public MsgBean addAreaDict(@RequestBody AreaDictDto areaDictDto) {
		try {
			Param areaName = new Param.Builder("区域名称", Param.ParamType.STR_NORMAL.getType(), areaDictDto.getAreaName(),
					false).build();
			super.validateParams(areaName);
			String parentAreaType = areaDictDto.getParentAreaType();
			if (SystemContext.SystemDomain.AREATYPE_NATION.equals(parentAreaType)) {
				areaDictDto.setAreaType(SystemContext.SystemDomain.AREATYPE_PROVINCE);
				List<AreaDictDto> provinceList = areaDictService.listByParentCode(areaDictDto.getParentCode());
				int maxIntProvinceCode = Integer.parseInt(areaDictDto.getParentCode());
				if (!ObjectUtils.isNullOrEmpty(provinceList)) {
					for (AreaDictDto province : provinceList) {
						if (Integer.parseInt(province.getAreaCode()) > maxIntProvinceCode) {
							maxIntProvinceCode = Integer.parseInt(province.getAreaCode());
						}
					}
				}
				areaDictDto.setAreaCode(Integer.toString(maxIntProvinceCode + 10000));
			}
			if (SystemContext.SystemDomain.AREATYPE_PROVINCE.equals(parentAreaType)) {
				areaDictDto.setAreaType(SystemContext.SystemDomain.AREATYPE_CITY);
				List<AreaDictDto> cityList = areaDictService.listByParentCode(areaDictDto.getParentCode());
				int maxIntCityCode = Integer.parseInt(areaDictDto.getParentCode());
				if (!ObjectUtils.isNullOrEmpty(cityList)) {
					for (AreaDictDto city : cityList) {
						if (Integer.parseInt(city.getAreaCode()) > maxIntCityCode) {
							maxIntCityCode = Integer.parseInt(city.getAreaCode());
						}
					}
				}
				areaDictDto.setAreaCode(Integer.toString(maxIntCityCode + 100));
			}
			if (SystemContext.SystemDomain.AREATYPE_CITY.equals(parentAreaType)) {
				areaDictDto.setAreaType(SystemContext.SystemDomain.AREATYPE_COUNTY);
				List<AreaDictDto> countyList = areaDictService.listByParentCode(areaDictDto.getParentCode());
				int maxIntCountyCode = Integer.parseInt(areaDictDto.getParentCode());
				if (!ObjectUtils.isNullOrEmpty(countyList)) {
					for (AreaDictDto county : countyList) {
						if (Integer.parseInt(county.getAreaCode()) > maxIntCountyCode) {
							maxIntCountyCode = Integer.parseInt(county.getAreaCode());
						}
					}
				}
				areaDictDto.setAreaCode(Integer.toString(maxIntCountyCode + 1));
			}
			areaDictDto.setCreateUserId(super.getUserId());
			areaDictDto.setCreateTime(new Date());
			AreaDictDto aDto = areaDictService.save(areaDictDto);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("text", aDto.getAreaName());
			map.put("id", aDto.getAreaCode());
			map.put("pid", aDto.getParentCode());
			map.put("expanded", false);
			map.put("areaType", aDto.getAreaType());
			if (SystemContext.SystemDomain.AREATYPE_PROVINCE.equals(aDto.getAreaType())
					|| SystemContext.SystemDomain.AREATYPE_CITY.equals(aDto.getAreaType())) {
				map.put("hasChildren", true);
			}
			return super.encapsulateMsgBean(map, MsgBean.MsgCode.SUCCESS, "创建区域成功");
		} catch (Exception e) {
			logger.error("创建区域失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	@RequestMapping(value = "/modifyAreaDict")
	@ResponseBody
	public MsgBean modifyAreaDict(@RequestBody AreaDictDto areaDictDto) {
		try {
			Param areaName = new Param.Builder("区域名称", Param.ParamType.STR_NORMAL.getType(), areaDictDto.getAreaName(),
					false).build();
			super.validateParams(areaName);
			AreaDictDto aDto = areaDictService.loadByAreaCode(areaDictDto.getAreaCode());
			if (null == aDto) {
				return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "需修改的区域不存在");
			}
			aDto.setAreaName(areaDictDto.getAreaName());
			aDto.setModifyUserId(super.getUserId());
			aDto.setModifyTime(new Date());
			areaDictService.updateByAreaCode(aDto);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("text", aDto.getAreaName());
			map.put("id", aDto.getAreaCode());
			map.put("nid", areaDictDto.getAreaTreeNid());
			map.put("pid", aDto.getParentCode());
			map.put("expanded", areaDictDto.isAreaTreeExpanded());
			map.put("areaType", aDto.getAreaType());
			if (SystemContext.SystemDomain.AREATYPE_PROVINCE.equals(aDto.getAreaType())
					|| SystemContext.SystemDomain.AREATYPE_CITY.equals(aDto.getAreaType())) {
				map.put("hasChildren", true);
			}
			return super.encapsulateMsgBean(map, MsgBean.MsgCode.SUCCESS, "修改区域成功");
		} catch (Exception e) {
			logger.error("修改区域失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

}