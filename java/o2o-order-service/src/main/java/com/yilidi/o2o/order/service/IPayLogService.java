package com.yilidi.o2o.order.service;

import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.order.service.dto.PayLogDto;
import com.yilidi.o2o.order.service.dto.query.PayLogQueryDto;

/**
 * 支付日志服务接口定义
 * 
 * @author simpson
 * 
 */
public interface IPayLogService {

    /**
     * 保存支付日志
     * 
     * @param payLogDto
     *            支付日志DTO
     * @return 保存后的支付日志DTO
     * @throws OrderServiceException
     *             服务异常
     */
    public PayLogDto savePayLog(PayLogDto payLogDto) throws OrderServiceException;

    /**
     * 生成支付订单时更新支付日志
     * 
     * @param payLogDto
     *            支付日志DTO
     * @param payLogOrderNo
     *            支付日志编码
     * @throws OrderServiceException
     *             服务异常
     */
    public void updatePayLogForMakeOrder(PayLogDto payLogDto, String payLogOrderNo) throws OrderServiceException;

    /**
     * 接收通知时更新支付日志
     * 
     * @param payLogDto
     *            支付日志DTO
     * @param payLogOrderNo
     *            支付日志编码
     * @throws OrderServiceException
     *             服务异常
     */
    public void updatePayLogForNotify(PayLogDto payLogDto, String payLogOrderNo) throws OrderServiceException;

    /**
     * 分页查询支付日志信息
     * 
     * @param payLogQueryDto
     *            支付日志查询DTO
     * @return 分页支付日志信息
     * @throws OrderServiceException
     *             服务异常
     */
    public YiLiDiPage<PayLogDto> findPayLogs(PayLogQueryDto payLogQueryDto) throws OrderServiceException;

    /**
     * 查询支付日志信息
     * 
     * @param saleOrderNo
     *            订单编码
     * @return 支付日志信息
     * @throws OrderServiceException
     *             服务异常
     */
    public List<PayLogDto> listPayLogs(String saleOrderNo) throws OrderServiceException;

    /**
     * 获取支付日志信息
     * 
     * @param payLogOrderNo
     *            支付日志编码
     * @return 支付日志信息
     * @throws OrderServiceException
     *             服务异常
     */
    public PayLogDto loadByPayLogOrderNo(String payLogOrderNo) throws OrderServiceException;

    /**
     * 获取支付日志信息
     * 
     * @param saleOrderNo
     *            订单编码
     * @return 支付日志信息
     * @throws OrderServiceException
     *             服务异常
     */
    public PayLogDto loadPaidBySaleOrderNo(String saleOrderNo) throws OrderServiceException;

    /**
     * 
     * 支付日志导出的总记录数
     * 
     * @param payLogQueryDto
     *            查询条件
     * @return Long
     * @throws OrderServiceException
     *             销售域服务异常
     */
	public Long getCountsForExportPayLog(PayLogQueryDto payLogQueryDto)throws OrderServiceException;

	/**
	 * 分页获取导出在线支付日志报表数据
	 * 
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<PayLogDto>
	 * @throws OrderServiceException
	 */
	public List<PayLogDto> listDataForExportPayLog(PayLogQueryDto payLogQueryDto, Long startLineNum, Integer pageSize)
			throws OrderServiceException;

}
