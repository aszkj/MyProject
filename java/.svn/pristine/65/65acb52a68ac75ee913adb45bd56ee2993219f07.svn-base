package com.yilidi.o2o.system.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.system.proxy.IAreaDictProxyService;
import com.yilidi.o2o.system.proxy.ISystemDictProxyService;
import com.yilidi.o2o.system.proxy.ISystemParamsProxyService;
import com.yilidi.o2o.system.proxy.dto.AreaDictProxyDto;
import com.yilidi.o2o.system.proxy.dto.SystemDictProxyDto;
import com.yilidi.o2o.system.proxy.dto.SystemParamsProxyDto;

/**
 * 系统基础处理类
 * 
 * @author simpson
 * 
 */
public class SystemBaseService extends BaseService {

    @Autowired
    private ISystemParamsProxyService systemParamsProxyService;

    @Autowired
    private ISystemDictProxyService systemDictProxyService;

    @Autowired
    private IAreaDictProxyService areaDictProxyService;

    /**
     * 
     * 根据系统参数编码获取系统参数值
     * 
     * @param systemParamCode
     *            系统参数
     * @return String 参数值
     */

    protected String getSystemParamValue(String systemParamCode) {
        try {
            String paramValue = null;
            if (!StringUtils.isEmpty(systemParamCode)) {
                // 从缓存中取数据
                paramValue = SystemBasicDataUtils.getSystemParamValue(systemParamCode);
                if (StringUtils.isEmpty(paramValue)) {
                    logger.debug("======查询数据库获取系统参数======");
                    // 查询数据库
                    SystemParamsProxyDto systemParamsProxyDto = systemParamsProxyService.loadByParamsCode(systemParamCode);
                    if (null != systemParamsProxyDto) {
                        paramValue = systemParamsProxyDto.getParamValue();
                    }
                }
            }
            return paramValue;
        } catch (Exception e) {
            logger.error("getSystemParamValue异常", e);
            throw new IllegalStateException("根据系统参数编码获取系统参数值出现异常");
        }
    }

    /**
     * 
     * 根据系统字典类型和系统字典编码获取系统字典名称
     * 
     * @param systemDictType
     *            字典类型
     * @param systemDictCode
     *            字典编码
     * @return String 字典名称
     */
    protected String getSystemDictName(String systemDictType, String systemDictCode) {
        try {
            String dictName = null;
            if (!StringUtils.isEmpty(systemDictType) && !StringUtils.isEmpty(systemDictCode)) {
                // 从缓存中取数据
                dictName = SystemBasicDataUtils.getSystemDictName(systemDictType, systemDictCode);
                if (StringUtils.isEmpty(dictName)) {
                    logger.debug("======查询数据库获取系统字典名称======");
                    // 查询数据库
                    SystemDictProxyDto systemDictProxyDto = systemDictProxyService.loadByDictCode(systemDictCode);
                    if (null != systemDictProxyDto) {
                        dictName = systemDictProxyDto.getDictName();
                    }
                }
            }
            return dictName;
        } catch (Exception e) {
            logger.error("getSystemDictName异常", e);
            throw new IllegalStateException("根据系统字典类型和系统字典编码获取系统字典名称出现异常");
        }
    }

    /**
     * 
     * 根据系统字典类型获取系统字典信息List，该List里存放的是Key为DictCode，Value为DictName的Map
     * 
     * @param systemDictType
     *            字典类型
     * @return List<Map<String, String>> 字典名称列表
     */
    protected List<Map<String, String>> getSystemDictInfoList(String systemDictType) {
        try {
            List<Map<String, String>> mapList = null;
            if (!StringUtils.isEmpty(systemDictType)) {
                // 从缓存中取数据
                mapList = SystemBasicDataUtils.getSystemDictInfoList(systemDictType);
                if (ObjectUtils.isNullOrEmpty(mapList)) {
                    logger.debug("======查询数据库获取系统字典信息======");
                    // 查询数据库
                    List<SystemDictProxyDto> systemDictProxyDtoList = systemDictProxyService
                            .listAllValidDictByDictType(systemDictType);
                    if (!ObjectUtils.isNullOrEmpty(systemDictProxyDtoList)) {
                        mapList = new ArrayList<Map<String, String>>();
                        for (SystemDictProxyDto systemDictProxyDto : systemDictProxyDtoList) {
                            Map<String, String> systemDictInfoMap = new HashMap<String, String>();
                            systemDictInfoMap.put(CommonConstants.APPOINTED_KEY_ID, systemDictProxyDto.getDictCode());
                            systemDictInfoMap.put(CommonConstants.APPOINTED_KEY_NAME, systemDictProxyDto.getDictName());
                            mapList.add(systemDictInfoMap);
                        }
                    }
                }
            }
            return mapList;
        } catch (Exception e) {
            logger.info("getSystemDictInfoList异常", e);
            throw new IllegalStateException("根据系统字典类型获取系统字典信息出现异常");
        }
    }

    /**
     * 
     * 根据地区字典编码获取地区名称
     * 
     * @param areaCode
     *            地区编码
     * @return String 地区名称
     */
    protected String getAreaName(String areaCode) {
        try {
            String areaName = StringUtils.EMPTY;
            if (!StringUtils.isEmpty(areaCode)) {
                // 从缓存中取数据
                areaName = SystemBasicDataUtils.getAreaName(areaCode);
                if (StringUtils.isEmpty(areaName)) {
                    logger.debug("======查询数据库获取地区名称======");
                    // 查询数据库
                    AreaDictProxyDto areaProxyDto = areaDictProxyService.loadByAreaCode(areaCode);
                    if (null != areaProxyDto) {
                        areaName = areaProxyDto.getAreaName();
                    }
                }
            }
            return areaName;
        } catch (Exception e) {
            logger.info("getAreaName异常", e);
            throw new IllegalStateException("根据地区字典编码获取地区名称出现异常");
        }
    }

    /**
     * 
     * 获取省份列表信息
     * 
     * @return List<Map<String, String>> 省份编码
     */
    protected List<Map<String, String>> getProvinceList() {
        try {
            List<Map<String, String>> mapList = null;
            // 从缓存中取数据
            mapList = SystemBasicDataUtils.getProvinceList();
            if (ObjectUtils.isNullOrEmpty(mapList)) {
                logger.debug("======查询数据库获取省份列表信息======");
                // 查询数据库
                List<AreaDictProxyDto> areaProxyDtoList = areaDictProxyService
                        .listByParentCode(CommonConstants.NATION_AREA_CODE_CHINA);
                mapList = encapsulateAreaMapList(areaProxyDtoList);
            }
            return mapList;
        } catch (Exception e) {
            logger.error("getProvinceList异常", e);
            throw new IllegalStateException("获取省份列表信息出现异常");
        }
    }

    /**
     * 
     * 根据省份编码获取地市列表信息
     * 
     * @param provinceCode
     *            省份编码
     * @return List<Map<String, String>> 地市列表
     */
    protected List<Map<String, String>> getCityList(String provinceCode) {
        try {
            List<Map<String, String>> mapList = null;
            if (!StringUtils.isEmpty(provinceCode)) {
                // 从缓存中取数据
                mapList = SystemBasicDataUtils.getCityList(provinceCode);
                if (ObjectUtils.isNullOrEmpty(mapList)) {
                    logger.debug("======查询数据库获取地市列表信息======");
                    // 查询数据库
                    List<AreaDictProxyDto> areaProxyDtoList = areaDictProxyService.listByParentCode(provinceCode);
                    mapList = encapsulateAreaMapList(areaProxyDtoList);
                }
            }
            return mapList;
        } catch (Exception e) {
            logger.error("getCityList异常", e);
            throw new IllegalStateException("根据省份编码获取地市列表信息出现异常");
        }
    }

    /**
     * 
     * 根据地市编码获取区县列表信息
     * 
     * @param cityCode
     *            地市编码
     * @return List<Map<String, String>> 县区列表
     */
    protected List<Map<String, String>> getCountyList(String cityCode) {
        try {
            List<Map<String, String>> mapList = null;
            if (!StringUtils.isEmpty(cityCode)) {
                // 从缓存中取数据
                mapList = SystemBasicDataUtils.getCountyList(cityCode);
                if (ObjectUtils.isNullOrEmpty(mapList)) {
                    logger.debug("======查询数据库获取区县列表信息======");
                    // 查询数据库
                    List<AreaDictProxyDto> areaProxyDtoList = areaDictProxyService.listByParentCode(cityCode);
                    mapList = encapsulateAreaMapList(areaProxyDtoList);
                }
            }
            return mapList;
        } catch (Exception e) {
            logger.error("getCountyList异常", e);
            throw new IllegalStateException("根据地市编码获取区县列表信息出现异常");
        }
    }

    /**
     * 
     * 获取地址前缀，XX省XX市XX区
     * 
     * @param provinceCode
     *            省份编码
     * @param cityCode
     *            地市编码
     * @param countyCode
     *            县区编码
     * @return String 地址前缀
     */
    protected String getAddressPrefix(String provinceCode, String cityCode, String countyCode) {
        try {
            StringBuilder prefixBuilder = new StringBuilder();
            prefixBuilder.append(getAreaName(provinceCode)).append(getAreaName(cityCode)).append(getAreaName(countyCode));
            return prefixBuilder.toString();
        } catch (Exception e) {
            logger.info("getAddressPrefix异常", e);
            throw new IllegalStateException("获取地址前缀出现异常");
        }
    }

    /**
     * 
     * 封装区域MapList
     * 
     * @param areaProxyDtoList
     *            地区dto列表
     * @return List<Map<String, String>> 地区map列表
     */
    private List<Map<String, String>> encapsulateAreaMapList(List<AreaDictProxyDto> areaProxyDtoList) {
        List<Map<String, String>> mapList = null;
        if (!ObjectUtils.isNullOrEmpty(areaProxyDtoList)) {
            mapList = new ArrayList<Map<String, String>>();
            for (AreaDictProxyDto areaProxyDto : areaProxyDtoList) {
                Map<String, String> areaDictInfoMap = new HashMap<String, String>();
                areaDictInfoMap.put(CommonConstants.APPOINTED_KEY_ID, areaProxyDto.getAreaCode());
                areaDictInfoMap.put(CommonConstants.APPOINTED_KEY_NAME, areaProxyDto.getAreaName());
                mapList.add(areaDictInfoMap);
            }
        }
        return mapList;
    }

}
