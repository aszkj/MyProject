package com.yilidi.o2o.core.connect.wechat.cache;

public interface IJsapiTicketCache {

	Object get(String key);

	void set(String key, Object value);

	void set(String key, Object value, int timeOut);

	void remove(String key);

}
