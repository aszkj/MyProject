package com.yilidi.o2o.schedule.order;

import org.apache.log4j.Logger;

import com.yilidi.o2o.order.service.IOrderShardingService;

/**
 * 根据订单生成时间分表定时任务
 * 
 * @author chenl
 * 
 */
public class OrderShardingByCreateTimeJob {

	private Logger logger = Logger.getLogger(OrderShardingByCreateTimeJob.class);

	private IOrderShardingService orderShardingService;

	protected synchronized void performance() {
		try {
			logger.info("===============根据订单生成时间分表定时任务开始===============");
			for (int i = 2; i <= 5; i++) {
				try {
					orderShardingService.createShardingByCreateTime(i);
				} catch (Exception e) {
					logger.error(e.getMessage());
				}
			}
			logger.info("===============根据订单生成时间分表定时任务结束===============");
		} catch (Exception e) {
			logger.error("根据订单生成时间分表定时任务出现系统故障！", e);
			throw new IllegalStateException("根据订单生成时间分表定时任务出现系统故障！", e);
		}
	}

	public IOrderShardingService getOrderShardingService() {
		return orderShardingService;
	}

	public void setOrderShardingService(IOrderShardingService orderShardingService) {
		this.orderShardingService = orderShardingService;
	}

}
