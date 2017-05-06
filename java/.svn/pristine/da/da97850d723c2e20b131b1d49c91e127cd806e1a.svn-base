package com.yilidi.o2o.core.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;

import redis.clients.jedis.Jedis;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;

/**
 * 
 * 获取系统域相关数据信息工具类，主要是先尝试从Redis缓存中取数据，如果取不到，再调Service接口获取，从而避免不必要地远程接口调用
 * 
 * @author: chenlian
 * @date: 2015年11月16日 下午8:36:42
 * 
 */
public final class SystemBasicDataUtils {

    private static Logger logger = Logger.getLogger(SystemBasicDataUtils.class);

    private SystemBasicDataUtils() {
    }

    /**
     * 
     * 根据系统参数编码获取系统参数值
     * 
     * @param systemParamCode
     *            系统参数编码
     * @return String 参数值
     */
    public static String getSystemParamValue(String systemParamCode) {
        Jedis jedis = null;
        try {
            String paramValue = null;
            if (!StringUtils.isEmpty(systemParamCode)) {
                jedis = JedisUtils.getJedis();
                if (jedis.exists(systemParamCode.getBytes())) {
                    logger.debug("======直接从缓存中取出系统参数======");
                    paramValue = StringUtils.byteToString(jedis.get(systemParamCode.getBytes()));
                }
            }
            return paramValue;
        } catch (Exception e) {
            logger.error("getSystemParamValue异常", e);
            throw new IllegalStateException("根据系统参数编码获取系统参数值出现异常");
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
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
    public static String getSystemDictName(String systemDictType, String systemDictCode) {
        Jedis jedis = null;
        try {
            String dictName = StringUtils.EMPTY;
            if (!StringUtils.isEmpty(systemDictType) && !StringUtils.isEmpty(systemDictCode)) {
                jedis = JedisUtils.getJedis();
                if (jedis.hexists(systemDictType.getBytes(), systemDictCode.getBytes())) {
                    logger.debug("======直接从缓存中取出系统字典名称======");
                    dictName = StringUtils.byteToString(jedis.hget(systemDictType.getBytes(), systemDictCode.getBytes()));
                }
            }
            return dictName;
        } catch (Exception e) {
            logger.error("getSystemDictName异常", e);
            throw new IllegalStateException("根据系统字典类型和系统字典编码获取系统字典名称出现异常");
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
        }
    }

    /**
     * 
     * 根据系统字典类型获取系统字典信息List，该List里存放的是Key为DictCode，Value为DictName的Map
     * 
     * @param systemDictType
     *            字典类型
     * @return List<Map<String, String>> 字典列表
     */
    public static List<Map<String, String>> getSystemDictInfoList(String systemDictType) {
        Jedis jedis = null;
        try {
            List<Map<String, String>> mapList = null;
            if (!StringUtils.isEmpty(systemDictType)) {
                jedis = JedisUtils.getJedis();
                Map<byte[], byte[]> map = jedis.hgetAll(systemDictType.getBytes());
                if (!ObjectUtils.isNullOrEmpty(map)) {
                    logger.debug("======直接从缓存中取出系统字典信息======");
                    Set<Integer> sortSet = new HashSet<Integer>();
                    for (Map.Entry<byte[], byte[]> entry : map.entrySet()) {
                        int sort = Integer.parseInt(StringUtils.byteToString(jedis.get(entry.getKey())));
                        sortSet.add(sort);
                    }
                    mapList = new ArrayList<Map<String, String>>();
                    for (Integer sortForSet : sortSet) {
                        for (Map.Entry<byte[], byte[]> entry : map.entrySet()) {
                            int sort = Integer.parseInt(StringUtils.byteToString(jedis.get(entry.getKey())));
                            if (sortForSet.intValue() == sort) {
                                Map<String, String> systemDictInfoMap = new HashMap<String, String>();
                                systemDictInfoMap.put("id", StringUtils.byteToString(entry.getKey()));
                                systemDictInfoMap.put("name", StringUtils.byteToString(entry.getValue()));
                                mapList.add(systemDictInfoMap);
                            }
                        }
                    }
                }
            }
            return mapList;
        } catch (Exception e) {
            logger.error("getSystemDictInfoList异常", e);
            throw new IllegalStateException("根据系统字典类型获取系统字典信息出现异常");
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
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
    public static String getAreaName(String areaCode) {
        Jedis jedis = null;
        try {
            String areaName = StringUtils.EMPTY;
            if (!StringUtils.isEmpty(areaCode)) {
                jedis = JedisUtils.getJedis();
                if (jedis.exists(areaCode.getBytes())) {
                    logger.debug("======直接从缓存中取出地区名称======");
                    areaName = StringUtils.byteToString(jedis.get(areaCode.getBytes()));
                }
            }
            return areaName;
        } catch (Exception e) {
            logger.error("getAreaName异常", e);
            throw new IllegalStateException("根据地区字典编码获取地区名称出现异常");
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
        }
    }

    /**
     * 
     * 获取省份列表信息
     * 
     * @return List<Map<String, String>> 省份列表
     */
    @SuppressWarnings("unchecked")
    public static List<Map<String, String>> getProvinceList() {
        Jedis jedis = null;
        try {
            List<Map<String, String>> mapList = null;
            jedis = JedisUtils.getJedis();
            if (jedis.exists(StringUtils.stringToByte(SystemContext.SystemDomain.AREATYPE_NATION
                    + CommonConstants.NATION_AREA_CODE_CHINA))) {
                logger.debug("======直接从缓存中取出省份列表信息======");
                mapList = (List<Map<String, String>>) SerializableUtils.read(jedis.get(StringUtils
                        .stringToByte(SystemContext.SystemDomain.AREATYPE_NATION + CommonConstants.NATION_AREA_CODE_CHINA)));
            }
            return mapList;
        } catch (Exception e) {
            logger.error("getProvinceList异常", e);
            throw new IllegalStateException("获取省份列表信息出现异常");
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
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
    @SuppressWarnings("unchecked")
    public static List<Map<String, String>> getCityList(String provinceCode) {
        Jedis jedis = null;
        try {
            List<Map<String, String>> mapList = null;
            if (!StringUtils.isEmpty(provinceCode)) {
                jedis = JedisUtils.getJedis();
                if (jedis.exists(StringUtils.stringToByte(SystemContext.SystemDomain.AREATYPE_PROVINCE + provinceCode))) {
                    logger.debug("======直接从缓存中取出地市列表信息======");
                    mapList = (List<Map<String, String>>) SerializableUtils.read(jedis.get(StringUtils
                            .stringToByte(SystemContext.SystemDomain.AREATYPE_PROVINCE + provinceCode)));
                }
            }
            return mapList;
        } catch (Exception e) {
            logger.error("getCityList异常", e);
            throw new IllegalStateException("根据省份编码获取地市列表信息出现异常");
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
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
    @SuppressWarnings("unchecked")
    public static List<Map<String, String>> getCountyList(String cityCode) {
        Jedis jedis = null;
        try {
            List<Map<String, String>> mapList = null;
            if (!StringUtils.isEmpty(cityCode)) {
                jedis = JedisUtils.getJedis();
                if (jedis.exists(StringUtils.stringToByte(SystemContext.SystemDomain.AREATYPE_CITY + cityCode))) {
                    logger.debug("======直接从缓存中取出区县列表信息======");
                    mapList = (List<Map<String, String>>) SerializableUtils.read(jedis.get(StringUtils
                            .stringToByte(SystemContext.SystemDomain.AREATYPE_CITY + cityCode)));
                }
            }
            return mapList;
        } catch (Exception e) {
            logger.error("getCountyList异常", e);
            throw new IllegalStateException("根据地市编码获取区县列表信息出现异常");
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
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
    public static String getAddressPrefix(String provinceCode, String cityCode, String countyCode) {
        try {
            StringBuilder prefixBuilder = new StringBuilder();
            prefixBuilder.append(getAreaName(provinceCode)).append(getAreaName(cityCode)).append(getAreaName(countyCode));
            return prefixBuilder.toString();
        } catch (Exception e) {
            logger.error("getAddressPrefix异常", e);
            throw new IllegalStateException("获取地址前缀出现异常");
        }
    }

}
