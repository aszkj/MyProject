/**
 * 文件名称：keyValuePair.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core;

import java.io.Serializable;
/**
 * 功能描述：键值对 <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 * @param <K> 键的泛型
 * @param <V> 值得泛型
 */ 
public class KeyValuePair<K, V> implements Serializable {

	private static final long serialVersionUID = 1003388752556985897L;

	private K key;
	private V value;

	/**
	 * 无参构造函数
	 */
	public KeyValuePair() {
	}

	/**
	 * 带参构造函数
	 * 
	 * @param key
	 *            键
	 * @param value
	 *            值
	 */
	public KeyValuePair(K key, V value) {
		this.key = key;
		this.value = value;
	}

	public K getKey() {
		return key;
	}

	public void setKey(K key) {
		this.key = key;
	}

	public V getValue() {
		return value;
	}

	public void setValue(V value) {
		this.value = value;
	}

	@Override
	public String toString() {
		return "KeyValuePair [key=" + key + ", value=" + value + "]";
	}

}
