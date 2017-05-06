package com.yilidi.o2o.system.proxy.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 
 * @Description:TODO(区域字典ProxyDto)
 * @author: chenlian
 * @date: 2015年12月5日 下午2:10:46
 * 
 */
public class AreaDictProxyDto extends BaseDto {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -7210716428126208072L;

	/**
	 * 区域编码
	 */
	private String areaCode;

	/**
	 * 区域名称
	 */
	private String areaName;

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

}
