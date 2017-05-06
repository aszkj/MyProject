package com.yilidi.o2o.freemarker;

import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerView;

import freemarker.template.SimpleHash;

/**
 * 页面静态化统一处理类，先本地生成静态页面，然后利用NIO将其复制到远程Web反向代理服务器的静态目录下，供其直接访问。
 * 
 * @author chenl
 * 
 */
public class YiLiDiFreeMarkerView extends FreeMarkerView {

	@Override
	protected void doRender(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		model.put("jsPath", staticResourceBasePath(request) + "/static-resource/js");
		model.put("cssPath", staticResourceBasePath(request) + "/static-resource/css");
		model.put("imagesPath", staticResourceBasePath(request) + "/static-resource/images");
		model.put("version", System.currentTimeMillis());
		exposeModelAsRequestAttributes(model, request);
		SimpleHash simpleHash = buildTemplateModel(model, request, response);
		Locale locale = RequestContextUtils.getLocale(request);
		processTemplate(getTemplate(locale), simpleHash, response);
	}

	private String staticResourceBasePath(HttpServletRequest request) {
		return request.getSession().getServletContext().getContextPath();
	}

}
