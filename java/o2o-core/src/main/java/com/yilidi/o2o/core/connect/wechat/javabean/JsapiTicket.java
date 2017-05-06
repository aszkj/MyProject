package com.yilidi.o2o.core.connect.wechat.javabean;

import java.io.Serializable;
import java.util.Map;

import com.yilidi.o2o.core.connect.wechat.utils.RetryUtils.ResultCheck;
import com.yilidi.o2o.core.utils.JsonUtils;

public class JsapiTicket implements ResultCheck, Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3757972487626877886L;
	private Integer expires_in;// 正确获取到 ticket 时有值
	private String ticket;
	private Integer errcode; // 出错时有值
	private String errmsg; // 出错时有值

	private Long expiredTime; // 正确获取到 access_token 时有值，存放过期时间
	private String json;

	public String getJson() {
		return json;
	}

	public JsapiTicket(String jsonStr) {
		this.json = jsonStr;

		try {
			Map<String, Object> temp = JsonUtils.parserToMap(jsonStr);
			ticket = (String) temp.get("ticket");
			expires_in = getInt(temp, "expires_in");
			errcode = getInt(temp, "errcode");
			errmsg = (String) temp.get("errmsg");

			if (expires_in != null)
				expiredTime = System.currentTimeMillis() + expires_in * 3 / 4 * 1000;

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	private Integer getInt(Map<String, Object> temp, String key) {
		Number number = (Number) temp.get(key);
		return number == null ? null : number.intValue();
	}

	public boolean isAvailable() {
		if (expiredTime == null)
			return false;
		if (errcode != null && errcode != 0)
			return false;
		if (expiredTime < System.currentTimeMillis())
			return false;
		return ticket != null;
	}

	public Integer getExpires_in() {
		return expires_in;
	}

	public void setExpires_in(Integer expires_in) {
		this.expires_in = expires_in;
	}

	public String getTicket() {
		return ticket;
	}

	public void setTicket(String ticket) {
		this.ticket = ticket;
	}

	public Integer getErrcode() {
		return errcode;
	}

	public void setErrcode(Integer errcode) {
		this.errcode = errcode;
	}

	public String getErrmsg() {
		if (errcode != null && errcode != 0) {
			String result = ReturnCode.get(errcode);
			if (result != null)
				return result;
		}
		return errmsg;
	}

	public void setErrmsg(String errmsg) {
		this.errmsg = errmsg;
	}

	@Override
	public boolean matching() {
		return isAvailable();
	}

}
