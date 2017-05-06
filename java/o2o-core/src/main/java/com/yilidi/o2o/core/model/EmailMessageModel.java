package com.yilidi.o2o.core.model;

import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.KeyValuePair;

/**
 * 
 * @Description:TODO(发送Email消息抽象实体类)
 * @author: chenlian
 * @date: 2015年10月29日 下午5:21:44
 * 
 */
public abstract class EmailMessageModel extends JmsMessageModel {

	/**
	 * @Fields serialVersionUID : TODO(serialVersionUID)
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 发送者的用户名和邮箱地址键值对
	 */
	protected KeyValuePair<String, String> fromUserNameAndEmailInfo;

	/**
	 * 接收者的用户名和邮箱地址键值对List，如果Email内容不用区分各用户，则用户名可以为空，但邮箱地址不能为空
	 */
	protected List<KeyValuePair<String, String>> toUserNameAndEmailInfoList;

	/**
	 * 邮件主题在config.properties配置文件中的属性Key值
	 */
	protected String titlePropertiesKey;

	/**
	 * 邮件内容模版名称在config.properties配置文件中的属性Key值
	 */
	protected String contentTemplateNamePropertiesKey;

	/**
	 * 邮件内容模版中变量参数Map
	 */
	protected Map<String, String> contentVariablesMap;

	public KeyValuePair<String, String> getFromUserNameAndEmailInfo() {
		return fromUserNameAndEmailInfo;
	}

	public void setFromUserNameAndEmailInfo(KeyValuePair<String, String> fromUserNameAndEmailInfo) {
		this.fromUserNameAndEmailInfo = fromUserNameAndEmailInfo;
	}

	public List<KeyValuePair<String, String>> getToUserNameAndEmailInfoList() {
		return toUserNameAndEmailInfoList;
	}

	public void setToUserNameAndEmailInfoList(List<KeyValuePair<String, String>> toUserNameAndEmailInfoList) {
		this.toUserNameAndEmailInfoList = toUserNameAndEmailInfoList;
	}

	public String getTitlePropertiesKey() {
		return titlePropertiesKey;
	}

	public void setTitlePropertiesKey(String titlePropertiesKey) {
		this.titlePropertiesKey = titlePropertiesKey;
	}

	public String getContentTemplateNamePropertiesKey() {
		return contentTemplateNamePropertiesKey;
	}

	public void setContentTemplateNamePropertiesKey(String contentTemplateNamePropertiesKey) {
		this.contentTemplateNamePropertiesKey = contentTemplateNamePropertiesKey;
	}

	public Map<String, String> getContentVariablesMap() {
		return contentVariablesMap;
	}

	public void setContentVariablesMap(Map<String, String> contentVariablesMap) {
		this.contentVariablesMap = contentVariablesMap;
	}

}
