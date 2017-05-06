package com.yilidi.o2o.controller.operation.system;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.BaseController;

/**
 * 
 * @Description:TODO(系统基础数据信息Controller)
 * @author: chenlian
 * @date: 2015年11月17日 上午12:45:50
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class SystemBasicDataInfosController extends BaseController {

	/**
	 * 
	 * @Description TODO(根据系统字典类型获取系统字典信息List，该List里存放的是Key为DictCode，Value为DictName的Map)
	 * @param systemDictType
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{systemDictType}/getSystemDictInfoList")
	@ResponseBody
	public MsgBean getSystemDictInfoList(@PathVariable("systemDictType") String systemDictType) {
		try {
			return super.encapsulateMsgBean(systemBasicDataInfoUtils.getSystemDictInfoList(systemDictType),
					MsgBean.MsgCode.SUCCESS, "根据系统字典类型获取系统字典信息成功");
		} catch (Exception e) {
			logger.info("根据系统字典类型获取系统字典信息出现异常", e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(获取省份列表信息)
	 * @return MsgBean
	 */
	@RequestMapping(value = "/getProvinceList")
	@ResponseBody
	public MsgBean getProvinceList() {
		try {
			return super.encapsulateMsgBean(systemBasicDataInfoUtils.getProvinceList(), MsgBean.MsgCode.SUCCESS,
					"获取省份列表信息成功");
		} catch (Exception e) {
			logger.info("获取省份列表信息出现异常", e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(根据省份编码获取地市列表信息)
	 * @param provinceCode
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{provinceCode}/getCityList")
	@ResponseBody
	public MsgBean getCityList(@PathVariable("provinceCode") String provinceCode) {
		try {
			return super.encapsulateMsgBean(systemBasicDataInfoUtils.getCityList(provinceCode), MsgBean.MsgCode.SUCCESS,
					"根据省份编码获取地市列表信息成功");
		} catch (Exception e) {
			logger.info("根据省份编码获取地市列表信息出现异常", e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(根据地市编码获取区县列表信息)
	 * @param cityCode
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{cityCode}/getCountyList")
	@ResponseBody
	public MsgBean getCountyList(String cityCode) {
		try {
			return super.encapsulateMsgBean(systemBasicDataInfoUtils.getCountyList(cityCode), MsgBean.MsgCode.SUCCESS,
					"根据地市编码获取区县列表信息成功");
		} catch (Exception e) {
			logger.info("根据地市编码获取区县列表信息出现异常", e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

}
