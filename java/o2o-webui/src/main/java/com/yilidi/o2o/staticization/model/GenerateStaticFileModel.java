package com.yilidi.o2o.staticization.model;

import java.util.Map;

/**
 * 生成静态文件Model
 * 
 * @author chenl
 * 
 */
public class GenerateStaticFileModel {

	/**
	 * 模板所在文件夹相对路径（相对于SystemContext.TEMPLATE_HTML_BASE_PATH）
	 */
	private String templateFoldersPath;

	/**
	 * 模板名称
	 */
	private String templateName;

	/**
	 * 静态HTML所在文件夹相对路径（相对于SystemContext.LOCAL_STATIC_HTML_BASE_PATH或SystemContext.REMOTE_WEB_SERVER_STATIC_HTML_PATH）
	 */
	private String staticHtmlFoldersPath;

	/**
	 * 静态HTML文件名称
	 */
	private String staticHtmlName;

	/**
	 * 为获取模板填充内容而需传入的查询参数Map，如不需要参数就可以获取模板填充内容，则可以为空。
	 */
	private Map<String, Object> parameterMap;

	public String getTemplateFoldersPath() {
		return templateFoldersPath;
	}

	public void setTemplateFoldersPath(String templateFoldersPath) {
		this.templateFoldersPath = templateFoldersPath;
	}

	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

	public String getStaticHtmlFoldersPath() {
		return staticHtmlFoldersPath;
	}

	public void setStaticHtmlFoldersPath(String staticHtmlFoldersPath) {
		this.staticHtmlFoldersPath = staticHtmlFoldersPath;
	}

	public String getStaticHtmlName() {
		return staticHtmlName;
	}

	public void setStaticHtmlName(String staticHtmlName) {
		this.staticHtmlName = staticHtmlName;
	}

	public Map<String, Object> getParameterMap() {
		return parameterMap;
	}

	public void setParameterMap(Map<String, Object> parameterMap) {
		this.parameterMap = parameterMap;
	}

}
