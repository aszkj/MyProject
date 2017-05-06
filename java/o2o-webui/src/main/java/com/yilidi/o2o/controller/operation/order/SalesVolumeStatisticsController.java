package com.yilidi.o2o.controller.operation.order;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.ISaleOrderItemService;
import com.yilidi.o2o.order.service.dto.SaleDailyStatisticsInfoDto;
import com.yilidi.o2o.order.service.dto.query.StatisticsParamQueryDto;

/**
 * 销量统计
 *
 * @author: zhangkun
 * @date: 2016年12月2日 下午4:48:08
 */
@Controller
@RequestMapping(value = "/operation")
public class SalesVolumeStatisticsController extends OperationBaseController {
    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ISaleOrderItemService saleOrderItemService;

    /**
     * 订单销量统计
     * 
     * @return
     */
    @RequestMapping(value = "/getOrderStatistics")
    @ResponseBody
    public MsgBean getOrderStatistics() {
        try {
            Map<String, Map<String, Object>> mapList = saleOrderItemService.getOrderStatistics();
            if (!ObjectUtils.isNullOrEmpty(mapList)) {
                return super.encapsulateMsgBean(mapList, MsgBean.MsgCode.SUCCESS, "");
            }
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "");
        } catch (OrderServiceException e) {
            logger.info("订单销量统计异常");
            e.printStackTrace();
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "");
        }
    }

    /**
     * 商品销量统计
     * 
     * @return
     */
    @RequestMapping(value = "/getProductStatistics")
    @ResponseBody
    public MsgBean getProductStatistics(StatisticsParamQueryDto queryDto) {
        try {
            setProductStatisticsParam(queryDto);
            Map<String, List<SaleDailyStatisticsInfoDto>> saleDailyStatisticsInfoDtoListMap = saleOrderItemService
                    .getProductStatistics(queryDto);
            if (!ObjectUtils.isNullOrEmpty(saleDailyStatisticsInfoDtoListMap)) {
                return super.encapsulateMsgBean(saleDailyStatisticsInfoDtoListMap, MsgBean.MsgCode.SUCCESS, "");
            }
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "");
        } catch (OrderServiceException e) {
            logger.info("商品销量统计异常");
            e.printStackTrace();
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "");
        } catch (ParseException e) {
            logger.info("日期转换异常");
            e.printStackTrace();
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "");
        }
    }

    /**
     * 用于设置查询销量排行的参数
     * 
     * @param query
     * @throws ParseException
     */
    private void setProductStatisticsParam(StatisticsParamQueryDto queryDto) throws ParseException {
        if (queryDto.getSearchDateType() != null && queryDto.getSearchDateType() == 1) {// 点击今日
            queryDto.setBeginTime(DateUtils.getSpecificStartDate(new Date()));
            queryDto.setEndTime(new Date());
        } else if (queryDto.getSearchDateType() != null && queryDto.getSearchDateType() == -1) {// 点击昨日
            queryDto.setBeginTime(DateUtils.getSpecificStartDate(DateUtils.addDays(new Date(), -1)));
            queryDto.setEndTime(DateUtils.getSpecificEndDate(DateUtils.addDays(new Date(), -1)));
        } else if (queryDto.getSearchDateType() != null && queryDto.getSearchDateType() == 7) {// 点击本周
            queryDto.setBeginTime(
                    DateUtils.getSpecificStartDate(DateUtils.getConcreteDateByPutOffWeeks(0, Calendar.MONDAY)));
            queryDto.setEndTime(new Date());
        } else if (queryDto.getSearchDateType() != null && queryDto.getSearchDateType() == 30) {// 点击本月
            queryDto.setBeginTime(DateUtils.getSpecificStartDate(DateUtils.getFirstDateByPutOffMonths(0)));
            queryDto.setEndTime(new Date());
        } else {
            if (StringUtils.isEmpty(queryDto.getBeginTimeStr()) && StringUtils.isEmpty(queryDto.getEndTimeStr())
                    && StringUtils.isEmpty(queryDto.getBarCode()) && StringUtils.isEmpty(queryDto.getProductClassName())) {
                // 默认时间搜索
                queryDto.setBeginTime(DateUtils.getSpecificStartDate(DateUtils.addDays(new Date(), -1)));
                queryDto.setEndTime(DateUtils.getSpecificEndDate(DateUtils.addDays(new Date(), -1)));
            } else {
                // 根据所选时间搜索
                if (!StringUtils.isEmpty(queryDto.getBeginTimeStr())) {
                    queryDto.setBeginTime(DateUtils.getSpecificStartDate(queryDto.getBeginTimeStr()));
                }
                if (!StringUtils.isEmpty(queryDto.getEndTimeStr())) {
                    queryDto.setEndTime(DateUtils.getSpecificEndDate(queryDto.getEndTimeStr()));
                }
            }
            if (!StringUtils.isEmpty(queryDto.getBarCode())) {
                queryDto.setBarCode(queryDto.getBarCode().trim());
            }
            if (!StringUtils.isEmpty(queryDto.getProductClassName())) {
                queryDto.setProductClassName(queryDto.getProductClassName().trim());
            }
        }

    }
}
