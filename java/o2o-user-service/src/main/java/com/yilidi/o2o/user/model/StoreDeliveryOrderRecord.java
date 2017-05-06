package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 店铺接单员处理订单实体类，映射数据库表 YiLiDiUserCenter.U_STORE_DELIVERY_ORDER_RECORD
 * 
 * @author: heyong
 * @date: 2015年12月10日 上午11:45:25
 * 
 */
public class StoreDeliveryOrderRecord extends BaseModel {

	private static final long serialVersionUID = 3829758790071970960L;

	/**
	 * ID，自增主键
	 */
	private Integer id;

	/**
	 * 店铺接单员ID, 关联用户域U_STORE_DELIVERY表的ID
	 */
	private Integer deliveryId;

	/**
	 * 订单编号
	 */
	private String orderNo;

	/**
	 * 处理步骤 接单，接单-发货，发货
	 * 
	 * （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STOREDELIVERYORDERRECORDSTEP的内容）
	 */
	private String step;

	/**
	 * 处理时间
	 */
	private Date createTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getDeliveryId() {
		return deliveryId;
	}

	public void setDeliveryId(Integer deliveryId) {
		this.deliveryId = deliveryId;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getStep() {
		return step;
	}

	public void setStep(String step) {
		this.step = step;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

}
