/**
 * 文件名称：OrderChangePriceDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.dto;

import java.util.HashMap;
import java.util.Map;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：订单价格修改实体DTO <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleOrderChangePriceDto extends BaseDto {

	private static final long serialVersionUID = -7243024379718168922L;

	/**
	 * 订单编号
	 */
	private String saleOrderNo;

	/**
	 * 订单中商品价格修改map key:订单明细编号， value： 修改后的价格
	 */
	private Map<String, Long> changedPriceMap = new HashMap<String, Long>();

	/**
	 * 修改后的运费
	 */
	private Long changedTransferFee;

	/**
	 * 操作用户id
	 */
	private Integer operateUserId;

	public String getSaleOrderNo() {
		return saleOrderNo;
	}

	public void setSaleOrderNo(String saleOrderNo) {
		this.saleOrderNo = saleOrderNo;
	}

	public Map<String, Long> getChangedPriceMap() {
		return changedPriceMap;
	}

	public void setChangedPriceMap(Map<String, Long> changedPriceMap) {
		this.changedPriceMap = changedPriceMap;
	}

	public Long getChangedTransferFee() {
		return changedTransferFee;
	}

	public void setChangedTransferFee(Long changedTransferFee) {
		this.changedTransferFee = changedTransferFee;
	}

	public Integer getOperateUserId() {
		return operateUserId;
	}

	public void setOperateUserId(Integer operateUserId) {
		this.operateUserId = operateUserId;
	}

}
