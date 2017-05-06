/**
 * 文件名称：Address.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.model;

import java.io.Serializable;

/**
 * 功能描述：
 * 作者：chenl
 * 
 * 
 */
public class Address implements Serializable {
	private static final long serialVersionUID = 156129291600578123L;
	
	private Integer id;
    private String address;
    
    public Address() {
    }
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    
    public Address(Integer id, String address) {
        this.id = id;
        this.address = address;
    }
	@Override
	public String toString() {
		return "Address [id=" + id + ", address=" + address + "]";
	}
    
}
