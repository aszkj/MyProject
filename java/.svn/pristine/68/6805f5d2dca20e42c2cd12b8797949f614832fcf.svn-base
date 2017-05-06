package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 店铺接单员处理订单封装dto
 * 
 * @author: heyong
 * @date: 2015年12月10日 下午8:09:54
 * 
 */
public class StoreDeliveryOrderRecordDto extends BaseDto {

	private static final long serialVersionUID = -1853894608405524853L;

	/**
	 * ID，自增主键
	 */
	private Integer id;

	/**
	 * 接单员登录账号： （对应user表的username）
	 */
	private String userName;

	/**
	 * 联系人
	 */
	private String contact;

	/**
	 * 手机号码
	 */
	private String mobile;

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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
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
