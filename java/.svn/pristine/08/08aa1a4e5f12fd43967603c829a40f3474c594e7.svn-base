package com.yilidi.o2o.controller.warehouse.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.WarehouseBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.service.IAreaDictService;
import com.yilidi.o2o.system.service.dto.AreaDictDto;

/**
 * 
 * 区域字典Controller
 * 
 * @author: chenb
 * @date: 2016年7月7日 下午3:07:24
 * 
 */
@Controller("warehouseAreaDictController")
@RequestMapping(value = "/warehouse")
public class AreaDictController extends WarehouseBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IAreaDictService areaDictService;

    /**
     * 
     * 根据父级节点Code获取其下所有的区域信息列表
     * 
     * @param parentCode
     *            父级编码
     * @return MsgBean
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
}