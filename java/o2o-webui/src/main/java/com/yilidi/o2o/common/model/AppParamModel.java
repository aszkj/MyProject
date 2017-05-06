package com.yilidi.o2o.common.model;

import com.alibaba.fastjson.JSONObject;

public class AppParamModel {

	private Integer versionCode;

	private String intfCallChannel;

	private String key;

	private String deviceId;

	private JSONObject entity;

	public Integer getVersionCode() {
		return versionCode;
	}

	public void setVersionCode(Integer versionCode) {
		this.versionCode = versionCode;
	}

	public String getIntfCallChannel() {
		return intfCallChannel;
	}

	public void setIntfCallChannel(String intfCallChannel) {
		this.intfCallChannel = intfCallChannel;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}

	public JSONObject getEntity() {
		return entity;
	}

	public void setEntity(JSONObject entity) {
		this.entity = entity;
	}

}
