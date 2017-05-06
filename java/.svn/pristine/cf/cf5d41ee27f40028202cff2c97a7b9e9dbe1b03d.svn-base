package com.yilidi.o2o.controller.mobile.buyer.system;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.yilidi.o2o.appparam.buyer.system.LoadAreaParam;
import com.yilidi.o2o.appvo.buyer.system.AreaDictVO;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.AppParamModel;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.service.IAreaDictService;
import com.yilidi.o2o.system.service.dto.AreaDictDto;

/**
 * 区域字典接口
 * 
 * @author: chenb
 * @date: 2016年5月28日 下午2:25:29
 */
@Controller
@RequestMapping(value = "/interfaces/buyer")
public class AreaDictCodeController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IAreaDictService areaDictService;

    /**
     * 加载所需区域的地址信息字典数据接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/system/loadarea")
    @ResponseBody
    public ResultParamModel getAreaDictByParentCode(HttpServletRequest req, HttpServletResponse resp) {
        LoadAreaParam loadAreaParam = super.getEntityParam(req, LoadAreaParam.class);
        String parentAreaDictCode = loadAreaParam.getParentAreaDictCode(); // 查询所需的省市县等Code
        logger.info("=-=-=-=-=-=-=-=-=-=-=parentAreaDictCode : " + parentAreaDictCode);
        List<AreaDictDto> areaDictDtoList = null;
        if (StringUtils.isEmpty(parentAreaDictCode)) {
            areaDictDtoList = areaDictService.listByAreaType(SystemContext.SystemDomain.AREATYPE_PROVINCE);
        } else {
            areaDictDtoList = areaDictService.listByParentCode(parentAreaDictCode);
        }
        List<AreaDictVO> areaDictVOList = new ArrayList<AreaDictVO>();
        if (ObjectUtils.isNullOrEmpty(areaDictDtoList)) {
            return super.encapsulateParam(areaDictVOList, AppMsgBean.MsgCode.SUCCESS, "加载所需区域的地址信息字典数据为空");
        }
        for (int i = 0, size = areaDictDtoList.size(); i < size; i++) {
            AreaDictDto areaDictDto = areaDictDtoList.get(i);
            AreaDictVO areaDictVO = new AreaDictVO(areaDictDto.getAreaCode(), areaDictDto.getAreaName());
            areaDictVOList.add(areaDictVO);
        }
        return super.encapsulateParam(areaDictVOList, AppMsgBean.MsgCode.SUCCESS, "加载所需区域的地址信息字典数据接口成功");
    }
}
