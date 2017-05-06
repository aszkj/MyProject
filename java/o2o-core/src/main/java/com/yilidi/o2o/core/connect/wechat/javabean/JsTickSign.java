package com.yilidi.o2o.core.connect.wechat.javabean;

import java.lang.reflect.Field;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.yilidi.o2o.core.payment.tencent.common.RandomStringGenerator;

public class JsTickSign {

	private String jsapi_ticket;
	private String noncestr;
	private Long timestamp;
	private String url;

	public JsTickSign(String jsapi_ticket, String url) {
		super();
		setJsapi_ticket(jsapi_ticket);
		setNoncestr(RandomStringGenerator.getRandomStringByLength(32));
		setTimestamp(new Date().getTime());
		setUrl(url);
	}

	public String getJsapi_ticket() {
		return jsapi_ticket;
	}

	public void setJsapi_ticket(String jsapi_ticket) {
		this.jsapi_ticket = jsapi_ticket;
	}

	public String getNoncestr() {
		return noncestr;
	}

	public void setNoncestr(String noncestr) {
		this.noncestr = noncestr;
	}

	public Long getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Long timestamp) {
		this.timestamp = timestamp;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * 转换为Map
	 * 
	 * @return map
	 */
	public Map<String, Object> toMap() {
		Map<String, Object> map = new HashMap<String, Object>();
		Field[] fields = this.getClass().getDeclaredFields();
		for (Field field : fields) {
			Object obj;
			try {
				obj = field.get(this);
				if (obj != null) {
					map.put(field.getName(), obj);
				}
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
		return map;
	}
}
