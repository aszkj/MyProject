/**
 * 文件名称：Person.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 功能描述：
 * 作者：chenl
 * 
 * 
 */
public class PersonDto implements Serializable {
	
	private static final long serialVersionUID = 8478574869228865402L;

	private Integer userid;

	private String username;

	private String userpassword;

	private Date birthday;
	
	private Integer age;



	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUserpassword() {
		return userpassword;
	}

	public void setUserpassword(String userpassword) {
		this.userpassword = userpassword;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public PersonDto() {
	}
	public PersonDto(Integer userid, String username, String userpassword, Date birthday) {
		super();
		this.userid = userid;
		this.username = username;
		this.userpassword = userpassword;
		this.birthday = birthday;
	}

	@Override
	public String toString() {
		return "UserDto [userid=" + userid + ", username=" + username + ", userpassword=" + userpassword + ", birthday="
				+ birthday + "]";
	}

}
