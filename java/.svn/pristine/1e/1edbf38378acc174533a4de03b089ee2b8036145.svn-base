package com.yilidi.o2o.common.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.system.service.IAreaDictService;
import com.yilidi.o2o.system.service.ISystemDictService;
import com.yilidi.o2o.system.service.ISystemParamsService;
import com.yilidi.o2o.system.service.dto.AreaDictDto;
import com.yilidi.o2o.system.service.dto.SystemDictDto;
import com.yilidi.o2o.system.service.dto.SystemParamsDto;

/**
 * 
 * 系统基础数据信息工具类
 * 
 * @author: chenlian
 * @date: 2015年12月8日 上午10:55:24
 * 
 */
public class SystemBasicDataInfoUtils {

    private Logger logger = Logger.getLogger(this.getClass());

    private ISystemParamsService systemParamsService;

    private ISystemDictService systemDictService;

    private IAreaDictService areaDictService;

    /**
     * 
     * 根据系统参数编码获取系统参数值
     * 
     * @param systemParamCode
     *            参数编码
     * @return String 参数内容
     */
    public String getSystemParamValue(String systemParamCode) {
        try {
            String paramValue = null;
            if (!StringUtils.isEmpty(systemParamCode)) {
                // 从缓存中取数据
                paramValue = SystemBasicDataUtils.getSystemParamValue(systemParamCode);
                if (StringUtils.isEmpty(paramValue)) {
                    logger.debug("======查询数据库获取系统参数======");
                    // 查询数据库
                    SystemParamsDto systemParamsDto = systemParamsService.loadByParamsCode(systemParamCode);
                    if (null != systemParamsDto) {
                        paramValue = systemParamsDto.getParamValue();
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
    public String getSystemDictName(String systemDictType, String systemDictCode) {
        try {
            String dictName = StringUtils.EMPTY;
            if (!StringUtils.isEmpty(systemDictType) && !StringUtils.isEmpty(systemDictCode)) {
                // 从缓存中取数据
                dictName = SystemBasicDataUtils.getSystemDictName(systemDictType, systemDictCode);
                if (StringUtils.isEmpty(dictName)) {
                    logger.debug("======查询数据库获取系统字典名称======");
                    // 查询数据库
                    SystemDictDto systemDictDto = systemDictService.loadByDictCode(systemDictCode);
                    if (null != systemDictDto) {
                        dictName = systemDictDto.getDictName();
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
     * @return List<Map<String, String>> 字典映射列表
     */
    public List<Map<String, String>> getSystemDictInfoList(String systemDictType) {
        try {
            List<Map<String, String>> mapList = null;
            if (!StringUtils.isEmpty(systemDictType)) {
                // 从缓存中取数据
                mapList = SystemBasicDataUtils.getSystemDictInfoList(systemDictType);
                if (ObjectUtils.isNullOrEmpty(mapList)) {
                    logger.debug("======查询数据库获取系统字典信息======");
                    // 查询数据库
                    List<SystemDictDto> systemDictDtoList = systemDictService.listAllValidDictByDictType(systemDictType);
                    if (!ObjectUtils.isNullOrEmpty(systemDictDtoList)) {
                        mapList = new ArrayList<Map<String, String>>();
                        for (SystemDictDto systemDictDto : systemDictDtoList) {
                            Map<String, String> systemDictInfoMap = new HashMap<String, String>();
                            systemDictInfoMap.put(CommonConstants.APPOINTED_KEY_ID, systemDictDto.getDictCode());
                            systemDictInfoMap.put(CommonConstants.APPOINTED_KEY_NAME, systemDictDto.getDictName());
                            mapList.add(systemDictInfoMap);
                        }
                    }
                }
            }
            return mapList;
        } catch (Exception e) {
            logger.error("getSystemDictInfoList异常", e);
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
    public String getAreaName(String areaCode) {
        try {
            String areaName = StringUtils.EMPTY;
            if (!StringUtils.isEmpty(areaCode)) {
                // 从缓存中取数据
                areaName = SystemBasicDataUtils.getAreaName(areaCode);
                if (StringUtils.isEmpty(areaName)) {
                    logger.debug("======查询数据库获取地区名称======");
                    // 查询数据库
                    AreaDictDto areaDictDto = areaDictService.loadByAreaCode(areaCode);
                    if (null != areaDictDto) {
                        areaName = areaDictDto.getAreaName();
                    }
                }
            }
            return areaName;
        } catch (Exception e) {
            logger.error("getAreaName异常", e);
            throw new IllegalStateException("根据地区字典编码获取地区名称出现异常");
        }
    }

    /**
     * 
     * 获取省份列表信息
     * 
     * @return List<Map<String, String>> 省份列表
     */
    public List<Map<String, String>> getProvinceList() {
        try {
            List<Map<String, String>> mapList = null;
            // 从缓存中取数据
            mapList = SystemBasicDataUtils.getProvinceList();
            if (ObjectUtils.isNullOrEmpty(mapList)) {
                logger.debug("======查询数据库获取省份列表信息======");
                // 查询数据库
                List<AreaDictDto> areaDictDtoList = areaDictService.listByParentCode(CommonConstants.NATION_AREA_CODE_CHINA);
                mapList = encapsulateAreaMapList(areaDictDtoList);
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
    public List<Map<String, String>> getCityList(String provinceCode) {
        try {
            List<Map<String, String>> mapList = null;
            if (!StringUtils.isEmpty(provinceCode)) {
                // 从缓存中取数据
                mapList = SystemBasicDataUtils.getCityList(provinceCode);
                if (ObjectUtils.isNullOrEmpty(mapList)) {
                    logger.debug("======查询数据库获取地市列表信息======");
                    // 查询数据库
                    List<AreaDictDto> areaDictDtoList = areaDictService.listByParentCode(provinceCode);
                    mapList = encapsulateAreaMapList(areaDictDtoList);
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
    public List<Map<String, String>> getCountyList(String cityCode) {
        try {
            List<Map<String, String>> mapList = null;
            if (!StringUtils.isEmpty(cityCode)) {
                // 从缓存中取数据
                mapList = SystemBasicDataUtils.getCountyList(cityCode);
                if (ObjectUtils.isNullOrEmpty(mapList)) {
                    logger.debug("======查询数据库获取区县列表信息======");
                    // 查询数据库
                    List<AreaDictDto> areaDictDtoList = areaDictService.listByParentCode(cityCode);
                    mapList = encapsulateAreaMapList(areaDictDtoList);
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
    public String getAddressPrefix(String provinceCode, String cityCode, String countyCode) {
        try {
            StringBuilder prefixBuilder = new StringBuilder();
            prefixBuilder.append(getAreaName(provinceCode)).append(getAreaName(cityCode)).append(getAreaName(countyCode));
            return prefixBuilder.toString();
        } catch (Exception e) {
            logger.error("getAddressPrefix异常", e);
            throw new IllegalStateException("获取地址前缀出现异常");
        }
    }

    /**
     * 
     * 封装区域MapList
     * 
     * @param areaDictDtoList
     *            地市列表dto
     * @return List<Map<String, String>> 地市列表
     */
    private List<Map<String, String>> encapsulateAreaMapList(List<AreaDictDto> areaDictDtoList) {
        List<Map<String, String>> mapList = null;
        if (!ObjectUtils.isNullOrEmpty(areaDictDtoList)) {
            mapList = new ArrayList<Map<String, String>>();
            for (AreaDictDto areaDictDto : areaDictDtoList) {
                Map<String, String> areaDictInfoMap = new HashMap<String, String>();
                areaDictInfoMap.put(CommonConstants.APPOINTED_KEY_ID, areaDictDto.getAreaCode());
                areaDictInfoMap.put(CommonConstants.APPOINTED_KEY_NAME, areaDictDto.getAreaName());
                mapList.add(areaDictInfoMap);
            }
        }
        return mapList;
    }

    public ISystemParamsService getSystemParamsService() {
        return systemParamsService;
    }

    public void setSystemParamsService(ISystemParamsService systemParamsService) {
        this.systemParamsService = systemParamsService;
    }

    public ISystemDictService getSystemDictService() {
        return systemDictService;
    }

    public void setSystemDictService(ISystemDictService systemDictService) {
        this.systemDictService = systemDictService;
    }

    public IAreaDictService getAreaDictService() {
        return areaDictService;
    }

    public void setAreaDictService(IAreaDictService areaDictService) {
        this.areaDictService = areaDictService;
    }

}
