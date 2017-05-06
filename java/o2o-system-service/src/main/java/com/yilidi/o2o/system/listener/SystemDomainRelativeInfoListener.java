package com.yilidi.o2o.system.listener;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import redis.clients.jedis.Jedis;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.SerializableUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.system.service.IAreaDictService;
import com.yilidi.o2o.system.service.ISystemDictService;
import com.yilidi.o2o.system.service.ISystemParamsService;
import com.yilidi.o2o.system.service.dto.AreaDictDto;
import com.yilidi.o2o.system.service.dto.SystemDictDto;
import com.yilidi.o2o.system.service.dto.SystemParamsDto;

/**
 * 
 * @Description:TODO(加载系统基础数据相关信息监听器)
 * @author: chenlian
 * @date: 2015年11月16日 下午3:10:22
 * 
 */
public class SystemDomainRelativeInfoListener implements ServletContextListener {

    private static final String SYSTEM_PARAMS_SERVICE = "systemParamsService";

    private static final String SYSTEM_DICT_SERVICE = "systemDictService";

    private static final String AREA_DICT_SERVICE = "areaDictService";

    private Logger logger = Logger.getLogger(this.getClass());

    /**
     * 
     * <p>
     * Title: contextInitialized
     * </p>
     * <p>
     * Description: 当系统启动时，加载系统基础数据相关信息，并将这些信息存入Redis缓存
     * </p>
     * 
     * @param arg0
     * @see javax.servlet.ServletContextListener#contextInitialized(javax.servlet.ServletContextEvent)
     */
    @Override
    public void contextInitialized(ServletContextEvent arg0) {
        Jedis jedis = null;
        try {
            logger.info("=============加载系统基础数据信息开始=============");
            jedis = JedisUtils.getJedis();
            // 加载系统参数信息，存入Redis缓存。
            WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
            ISystemParamsService systemParamsService = (ISystemParamsService) wac.getBean(SYSTEM_PARAMS_SERVICE);
            List<SystemParamsDto> systemParamsDtoList = systemParamsService.listAllValidSystemParams();
            if (!ObjectUtils.isNullOrEmpty(systemParamsDtoList)) {
                for (SystemParamsDto systemParamsDto : systemParamsDtoList) {
                    jedis.set(systemParamsDto.getParamsCode().getBytes(), systemParamsDto.getParamValue().getBytes());
                }
            }
            // 加载系统字典信息，存入Redis缓存。
            ISystemDictService systemDictService = (ISystemDictService) wac.getBean(SYSTEM_DICT_SERVICE);
            List<Map<String, String>> mapList = systemDictService.listAllValidDictType();
            if (!ObjectUtils.isNullOrEmpty(mapList)) {
                for (Map<String, String> map : mapList) {
                    String dictType = map.get("dictType");
                    List<SystemDictDto> systemDictDtoList = systemDictService.listAllValidDictByDictType(dictType);
                    if (!ObjectUtils.isNullOrEmpty(systemDictDtoList)) {
                        for (SystemDictDto systemDictDto : systemDictDtoList) {
                            jedis.hset(dictType.getBytes(), systemDictDto.getDictCode().getBytes(), systemDictDto
                                    .getDictName().getBytes());
                            Integer sort = null == systemDictDto.getSort() ? 0 : systemDictDto.getSort();
                            jedis.set(systemDictDto.getDictCode().getBytes(),
                                    StringUtils.stringToByte(sort.toString(), "UTF-8"));
                        }
                    }
                }
            }
            // 加载地区字典信息，存入Redis缓存。
            IAreaDictService areaDictService = (IAreaDictService) wac.getBean(AREA_DICT_SERVICE);
            AreaDictDto nation = areaDictService.loadByAreaCode(CommonConstants.NATION_AREA_CODE_CHINA);
            if (null != nation) {
                jedis.set(nation.getAreaCode().getBytes(), nation.getAreaName().getBytes());
                List<AreaDictDto> provinceList = areaDictService.listByParentCode(nation.getAreaCode());
                if (!ObjectUtils.isNullOrEmpty(provinceList)) {
                    jedis.set((SystemContext.SystemDomain.AREATYPE_NATION + nation.getAreaCode()).getBytes(),
                            SerializableUtils.write(encapsulateAreaMapList(provinceList)));
                    for (AreaDictDto province : provinceList) {
                        jedis.set(province.getAreaCode().getBytes(), province.getAreaName().getBytes());
                        List<AreaDictDto> cityList = areaDictService.listByParentCode(province.getAreaCode());
                        if (!ObjectUtils.isNullOrEmpty(cityList)) {
                            jedis.set((SystemContext.SystemDomain.AREATYPE_PROVINCE + province.getAreaCode()).getBytes(),
                                    SerializableUtils.write(encapsulateAreaMapList(cityList)));
                            for (AreaDictDto city : cityList) {
                                jedis.set(city.getAreaCode().getBytes(), city.getAreaName().getBytes());
                                List<AreaDictDto> countyList = areaDictService.listByParentCode(city.getAreaCode());
                                if (!ObjectUtils.isNullOrEmpty(countyList)) {
                                    jedis.set((SystemContext.SystemDomain.AREATYPE_CITY + city.getAreaCode()).getBytes(),
                                            SerializableUtils.write(encapsulateAreaMapList(countyList)));
                                    for (AreaDictDto county : countyList) {
                                        jedis.set(county.getAreaCode().getBytes(), county.getAreaName().getBytes());
                                    }
                                }
                            }
                        }
                    }
                }
            }
            logger.info("=============加载系统基础数据信息结束=============");
        } catch (Exception e) {
            String message = "加载系统基础数据信息出现异常";
            logger.error(message, e);
            throw new IllegalStateException(message);
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
        }
    }

    /**
     * 
     * @Description TODO(封装区域MapList)
     * @param areaDictDtoList
     * @return List<Map<String, String>>
     */
    private List<Map<String, String>> encapsulateAreaMapList(List<AreaDictDto> areaDictDtoList) {
        List<Map<String, String>> mapList = null;
        if (!ObjectUtils.isNullOrEmpty(areaDictDtoList)) {
            mapList = new ArrayList<Map<String, String>>();
            for (AreaDictDto areaDictDto : areaDictDtoList) {
                Map<String, String> areaDictInfoMap = new HashMap<String, String>();
                areaDictInfoMap.put("id", areaDictDto.getAreaCode());
                areaDictInfoMap.put("name", areaDictDto.getAreaName());
                mapList.add(areaDictInfoMap);
            }
        }
        return mapList;
    }

    @Override
    public void contextDestroyed(ServletContextEvent arg0) {

    }

}
