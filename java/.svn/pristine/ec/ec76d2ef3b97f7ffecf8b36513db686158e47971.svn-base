/**
 * 文件名称：SendGoodsDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.dto;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：发货信息模型DTO <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SendOrderDto extends BaseDto {
	private static final long serialVersionUID = 811609946623220025L;

	/**
	 * 发货单号
	 */
	private String sendNo;
	/**
	 * 订单编号
	 */
	private String saleOrderNo;
	/**
	 * 此次发货的物流单号，多个单号使用逗号分开
	 */
	private String logisticsNo;

	/**
	 * 发货数量信息 <key: saleProductId, value: 发货数量>
	 */
	private Map<Integer, Integer> sendCountInfo = new HashMap<Integer, Integer>();

	/**
	 * 发货时间
	 */
	private Date sendTime;
	/**
	 * 发货操作用户ID
	 */
	private Integer sendUserId;
	/**
	 * 收货状态 "0" 未收货 "1" 已收货
	 */
	private String takeStatus;
	/**
	 * 收货时间
	 */
	private Date takeTime;
	/**
	 * 收货操作用户ID
	 */
	private Integer takeUserId;

	public String getSendNo() {
		return sendNo;
	}

	public void setSendNo(String sendNo) {
		this.sendNo = sendNo;
	}

	public String getSaleOrderNo() {
		return saleOrderNo;
	}

	public void setSaleOrderNo(String saleOrderNo) {
		this.saleOrderNo = saleOrderNo;
	}

	public String getLogisticsNo() {
		return logisticsNo;
	}

	public void setLogisticsNo(String logisticsNo) {
		this.logisticsNo = logisticsNo;
	}

	public Map<Integer, Integer> getSendCountInfo() {
		return sendCountInfo;
	}

	public void setSendCountInfo(Map<Integer, Integer> sendCountInfo) {
		this.sendCountInfo = sendCountInfo;
	}

	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public Integer getSendUserId() {
		return sendUserId;
	}

	public void setSendUserId(Integer sendUserId) {
		this.sendUserId = sendUserId;
	}

	public String getTakeStatus() {
		return takeStatus;
	}

	public void setTakeStatus(String takeStatus) {
		this.takeStatus = takeStatus;
	}

	public Date getTakeTime() {
		return takeTime;
	}

	public void setTakeTime(Date takeTime) {
		this.takeTime = takeTime;
	}

	public Integer getTakeUserId() {
		return takeUserId;
	}

	public void setTakeUserId(Integer takeUserId) {
		this.takeUserId = takeUserId;
	}

}
