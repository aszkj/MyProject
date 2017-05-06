/**
 * 文件名称：SaleOrderItemService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.SaleOrderItemMapper;
import com.yilidi.o2o.order.model.SaleOrderItem;
import com.yilidi.o2o.order.model.query.StatisticsParamQuery;
import com.yilidi.o2o.order.model.result.SaleDailyStatisticsInfo;
import com.yilidi.o2o.order.service.ISaleOrderItemService;
import com.yilidi.o2o.order.service.dto.SaleDailyStatisticsInfoDto;
import com.yilidi.o2o.order.service.dto.SaleOrderItemDto;
import com.yilidi.o2o.order.service.dto.query.StatisticsParamQueryDto;
import com.yilidi.o2o.product.proxy.IProductClassProxyService;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.IStoreProfileProxyService;
import com.yilidi.o2o.user.proxy.dto.StoreProfileProxyDto;

/**
 * 功能描述：订单明细服务类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("saleOrderItemService")
public class SaleOrderItemServiceImpl extends BasicDataService implements ISaleOrderItemService {

    @Autowired
    private SaleOrderItemMapper saleOrderItemMapper;

    @Autowired
    private IStoreProfileProxyService storeProfileProxyService;
    
    @Autowired
    private IProductClassProxyService productClassProxyService;

    @Override
    public Integer save(SaleOrderItemDto item) throws OrderServiceException {
        if (ObjectUtils.isNullOrEmpty(item)) {
            logger.error("SaleOrderItemService.save 参数为null，请检查");
            throw new OrderServiceException("订单明细参数为null");
        }
        SaleOrderItem saleOrderItem = new SaleOrderItem();
        ObjectUtils.fastCopy(item, saleOrderItem);
        return saleOrderItemMapper.save(saleOrderItem);
    }

    @Override
    public void saveBatch(List<SaleOrderItemDto> items) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(items)) {
                logger.error("SaleOrderItemService.saveBatch 参数为null，请检查");
                throw new OrderServiceException("订单明细列表参数为null");
            }
            for (SaleOrderItemDto item : items) {
                this.save(item);
            }
        } catch (Exception e) {
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleOrderItemDto> listBySaleOrderNo(String saleOrderNo) throws OrderServiceException {
        if (ObjectUtils.isNullOrEmpty(saleOrderNo)) {
            logger.error("saleOrderItemService.listBySaleOrderNo -> 参数saleOrderNo为空");
            throw new OrderServiceException("参数saleOrderNo为空");
        }
        List<SaleOrderItem> items = saleOrderItemMapper.listBySaleOrderNo(saleOrderNo);
        List<SaleOrderItemDto> itemDtos = new ArrayList<SaleOrderItemDto>();
        if (!ObjectUtils.isNullOrEmpty(items)) {
            for (SaleOrderItem item : items) {
                if (!ObjectUtils.isNullOrEmpty(item)) {
                    SaleOrderItemDto saleOrderItemDto = new SaleOrderItemDto();
                    ObjectUtils.fastCopy(item, saleOrderItemDto);
                    itemDtos.add(saleOrderItemDto);
                }
            }
        }
        return itemDtos;
    }

    @Override
    public List<SaleDailyStatisticsInfoDto> listSaleDailyStatistictsByTakeTime(Date startTakeTime, Date endTakeTime)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(startTakeTime) || ObjectUtils.isNullOrEmpty(endTakeTime)) {
                throw new OrderServiceException("收货时间不能为空");
            }
            List<SaleDailyStatisticsInfo> saleDailyStatisticsInfos = saleOrderItemMapper
                    .listSaleDailyStatistictsByTakeTime(startTakeTime, endTakeTime);
            if (ObjectUtils.isNullOrEmpty(saleDailyStatisticsInfos)) {
                return Collections.emptyList();
            }
            List<SaleDailyStatisticsInfoDto> saleDailyStatisticsInfoDtos = new ArrayList<SaleDailyStatisticsInfoDto>();
            for (SaleDailyStatisticsInfo saleDailyStatisticsInfo : saleDailyStatisticsInfos) {
                SaleDailyStatisticsInfoDto saleDailyStatisticsInfoDto = new SaleDailyStatisticsInfoDto();
                ObjectUtils.fastCopy(saleDailyStatisticsInfo, saleDailyStatisticsInfoDto);
                saleDailyStatisticsInfoDtos.add(saleDailyStatisticsInfoDto);
            }
            return saleDailyStatisticsInfoDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    /**
     * 订单销量排行
     * 
     * <p>
     * Description:
     * </p>
     * 
     * @return
     * @throws OrderServiceException
     * @see com.yilidi.o2o.order.service.ISaleOrderItemService#getOrderStatistics()
     */
    @Override
    public Map<String, Map<String, Object>> getOrderStatistics() throws OrderServiceException {
        Map<String, Map<String, Object>> orderDateStatisticsMap = new HashMap<String, Map<String, Object>>();
        StatisticsParamQuery query = new StatisticsParamQuery();
        try {
            // 当日订单销量
            query.setBeginTime(DateUtils.getSpecificStartDate(new Date()));
            query.setEndTime(new Date());
            Map<String, Object> todayMap = saleOrderItemMapper.getOrderStatistics(query);
            if (!ObjectUtils.isNullOrEmpty(todayMap)) {
                todayMap.put("cation", "今日销量");
            }
            orderDateStatisticsMap.put("todayMap", todayMap);

            // 昨天订单销量
            query.setBeginTime(DateUtils.getSpecificStartDate(DateUtils.addDays(new Date(), -1)));
            query.setEndTime(DateUtils.getSpecificEndDate(DateUtils.addDays(new Date(), -1)));
            Map<String, Object> yesterdayMap = saleOrderItemMapper.getOrderStatistics(query);
            if (!ObjectUtils.isNullOrEmpty(yesterdayMap)) {
                yesterdayMap.put("cation", "昨日销量");
            }
            orderDateStatisticsMap.put("yesterdayMap", yesterdayMap);

            // 本周订单销量
            query.setBeginTime(DateUtils.getSpecificStartDate(DateUtils.getConcreteDateByPutOffWeeks(0, Calendar.MONDAY)));
            query.setEndTime(new Date());
            Map<String, Object> thisweekMap = saleOrderItemMapper.getOrderStatistics(query);
            if (!ObjectUtils.isNullOrEmpty(thisweekMap)) {
                thisweekMap.put("cation", "本周销量");
            }
            orderDateStatisticsMap.put("thisweekMap", thisweekMap);

            // 本月订单销量
            query.setBeginTime(DateUtils.getSpecificStartDate(DateUtils.getFirstDateByPutOffMonths(0)));
            query.setEndTime(new Date());
            Map<String, Object> thismonthMap = saleOrderItemMapper.getOrderStatistics(query);
            if (!ObjectUtils.isNullOrEmpty(thismonthMap)) {
                thismonthMap.put("cation", "本月销量");
            }
            orderDateStatisticsMap.put("thismonthMap", thismonthMap);
            return orderDateStatisticsMap;
        } catch (ParseException e) {
            logger.error(e);
            throw new OrderServiceException(e.getMessage());
        }

    }

    /**
     * 商品销量排行
     * 
     * <p>
     * Description:
     * </p>
     * 
     * @param queryDto
     * @return
     * @throws OrderServiceException
     * @see com.yilidi.o2o.order.service.ISaleOrderItemService#getProductStatistics(com.yilidi.o2o.order.service.dto.query.StatisticsParamQueryDto)
     */

    @Override
    public Map<String, List<SaleDailyStatisticsInfoDto>> getProductStatistics(StatisticsParamQueryDto queryDto)
            throws OrderServiceException {
        Map<String, List<SaleDailyStatisticsInfoDto>> saleDailyStatisticsInfoDtoMap = new HashMap<String, List<SaleDailyStatisticsInfoDto>>();
        try {
            StatisticsParamQuery query = new StatisticsParamQuery();
            ObjectUtils.fastCopy(queryDto, query);
            // 获取dao返回的统计总数
            SaleDailyStatisticsInfo saleDailyStatisticsInfo = saleOrderItemMapper.getProductStatisticsCount(query);
            if (!ObjectUtils.isNullOrEmpty(saleDailyStatisticsInfo)) {
                String barCode = query.getBarCode();
                String productClassCode = query.getProductClassCode();
                if (StringUtils.isEmpty(productClassCode) || !StringUtils.isEmpty(barCode)) {
                    // 商品销量排行
                    query.setGroupParam("a.BARCODE");
                    query.setOrderParam("z.SALECOUNT");
                    query.setClassCodes(null);
                    List<SaleDailyStatisticsInfoDto> productNumberList = getSaleDailyStatisticsInfoDtoList(query,
                            saleDailyStatisticsInfo);
                    saleDailyStatisticsInfoDtoMap.put("productNumberList", productNumberList);
                    // 商品销售额排行
                    query.setGroupParam("a.BARCODE");
                    query.setOrderParam("z.AMOUNT");
                    query.setClassCodes(null);
                    List<SaleDailyStatisticsInfoDto> productPriceList = getSaleDailyStatisticsInfoDtoList(query,
                            saleDailyStatisticsInfo);
                    saleDailyStatisticsInfoDtoMap.put("productPriceList", productPriceList);
                }
                if (StringUtils.isEmpty(barCode) || !StringUtils.isEmpty(productClassCode)) {
                    if(!StringUtils.isEmpty(productClassCode)){
                        List<Object> classCodes = productClassProxyService.getSubClassCodes(productClassCode);
                        if(!ObjectUtils.isNullOrEmpty(classCodes)){
                            query.setClassCodes(classCodes);
                        }
                    }
                    // 分类销量排行
                    query.setGroupParam("a.PRODUCTCLASSCODE");
                    query.setOrderParam("z.SALECOUNT");
                    query.setBarCode("");
                    List<SaleDailyStatisticsInfoDto> classesNumberList = getSaleDailyStatisticsInfoDtoList(query,
                            saleDailyStatisticsInfo);
                    saleDailyStatisticsInfoDtoMap.put("classesNumberList", classesNumberList);
                    // 分类销售额排行
                    query.setGroupParam("a.PRODUCTCLASSCODE");
                    query.setOrderParam("z.AMOUNT");
                    query.setBarCode("");
                    List<SaleDailyStatisticsInfoDto> classesPriceList = getSaleDailyStatisticsInfoDtoList(query,
                            saleDailyStatisticsInfo);
                    saleDailyStatisticsInfoDtoMap.put("classesPriceList", classesPriceList);
                }
                if (StringUtils.isEmpty(barCode) && StringUtils.isEmpty(productClassCode)) {
                    // 店铺销量排行
                    query.setGroupParam("a.STOREID");
                    query.setOrderParam("z.SALECOUNT");
                    query.setBarCode("");
                    query.setClassCodes(null);
                    List<SaleDailyStatisticsInfoDto> storeNumberList = getSaleDailyStatisticsInfoDtoList(query,
                            saleDailyStatisticsInfo);
                    saleDailyStatisticsInfoDtoMap.put("storeNumberList", storeNumberList);
                    // 店铺销售额排行
                    query.setGroupParam("a.STOREID");
                    query.setOrderParam("z.AMOUNT");
                    query.setBarCode("");
                    query.setClassCodes(null);
                    List<SaleDailyStatisticsInfoDto> storePriceList = getSaleDailyStatisticsInfoDtoList(query,
                            saleDailyStatisticsInfo);
                    saleDailyStatisticsInfoDtoMap.put("storePriceList", storePriceList);
                }
            }
            return saleDailyStatisticsInfoDtoMap;
        } catch (Exception e) {
            logger.error(e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    private List<SaleDailyStatisticsInfoDto> getSaleDailyStatisticsInfoDtoList(StatisticsParamQuery query,
            SaleDailyStatisticsInfo countInfo) {
        List<SaleDailyStatisticsInfoDto> saleDailyStatisticsInfoDtoList = null;
        // 获取返回的统计总数dto
        SaleDailyStatisticsInfoDto countDto = new SaleDailyStatisticsInfoDto();
        ObjectUtils.fastCopy(countInfo, countDto);
        // 根据排行基数获取排行
        List<SaleDailyStatisticsInfo> saleDailyStatisticsInfoList = saleOrderItemMapper.getProductStatistics(query);
        if (!ObjectUtils.isNullOrEmpty(saleDailyStatisticsInfoList)) {
            saleDailyStatisticsInfoDtoList = new ArrayList<SaleDailyStatisticsInfoDto>();
            SaleDailyStatisticsInfoDto infoDto = null;
            for (SaleDailyStatisticsInfo info : saleDailyStatisticsInfoList) {
                infoDto = new SaleDailyStatisticsInfoDto();
                ObjectUtils.fastCopy(info, infoDto);
                // 总数中减去从排行基数查出来的销量
                countDto.setSaleCount(countDto.getSaleCount() - infoDto.getSaleCount());
                countDto.setAmount(countDto.getAmount() - infoDto.getAmount());
                // 填充店铺名称
                StoreProfileProxyDto StoreProxyDto = storeProfileProxyService.loadByStoreId(infoDto.getStoreId());
                String storeName = ObjectUtils.isNullOrEmpty(StoreProxyDto) ? "" : StoreProxyDto.getStoreName();
                infoDto.setStoreName(storeName);
                saleDailyStatisticsInfoDtoList.add(infoDto);
            }
        }
        String other = "其它";
        countDto.setProductClassName(other);
        countDto.setProductName(other);
        countDto.setStoreName(other);
        saleDailyStatisticsInfoDtoList.add(countDto);
        return saleDailyStatisticsInfoDtoList;
    }

}
