package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.order.model.PayLog;
import com.yilidi.o2o.order.model.query.PayLogQuery;
import com.yilidi.o2o.order.model.result.PayLogInfo;

/**
 * 支付日志数据层操作类
 * 
 * @author simpson
 * 
 */
public interface PayLogMapper {

    /**
     * 保存支付日志信息
     * 
     * @param record
     *            支付日志信息
     * @return 影响行数
     */
    Integer save(PayLog record);

    /**
     * 更新支付日志信息
     * 
     * @param payLog
     *            支付日志
     * @param payLogOrderNo
     *            支付日志编码
     * @param payLogStatus
     *            支付日志状态
     * @return 影响行数
     */
    Integer updatePayLogByPayLogOrderNoAndStatus(@Param("payLog") PayLog payLog,
            @Param("payLogOrderNo") String payLogOrderNo, @Param("payLogStatus") String payLogStatus);

    /**
     * 根据条件查询支付日志信息
     * 
     * @param payLogQuery
     *            支付日志查询条件
     * @return 支付日志列表
     */
    Page<PayLogInfo> findPayLogs(PayLogQuery payLogQuery);

    /**
     * 根据条件查询支付日志信息
     * 
     * @param saleOrderNo
     *            订单编码
     * @param payLogType
     *            支付日志类型
     * @param payLogStatus
     *            支付日志状态
     * @return 支付日志列表
     */
    List<PayLog> listInitPayLogs(@Param("saleOrderNo") String saleOrderNo, @Param("payLogType") String payLogType,
            @Param("payLogStatus") String payLogStatus);

    /**
     * 根据支付日志编码查询支付日志信息
     * 
     * @param payLogOrderNo
     *            支付日志编码
     * @return 支付日志信息
     */
    PayLog loadByPayLogOrderNo(@Param("payLogOrderNo") String payLogOrderNo);

    /**
     * 根据订单编码查询支付日志信息
     * 
     * @param saleOrderNo
     *            订单编码
     * @param payLogType
     *            支付日志类型
     * @param payLogStatus
     *            支付日志状态
     * @return 支付日志信息
     */
    PayLog loadBySaleOrderNo(@Param("saleOrderNo") String saleOrderNo, @Param("payLogType") String payLogType,
            @Param("payLogStatus") String payLogStatus);

    /**
     * 
     * 导出在线支付日志数量
     * 
     * @param query
     *            在线支付日志查询实体
     * @return long 在线支付日志数量
     */
	Long getCountsForExportPayLog(PayLogQuery payLogQuery);
	
	/**
	 * @Description TODO(分页获取导用户在线支付交易明细日志报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<PayLog> 报表导出不适用缓存
	 */
	List<PayLogInfo> listDataForExportOnlinePayLog(
			@Param("payLogQuery") PayLogQuery payLogQuery, @Param("startLineNum") Long startLineNum,
			@Param("pageSize") Integer pageSize);
}
