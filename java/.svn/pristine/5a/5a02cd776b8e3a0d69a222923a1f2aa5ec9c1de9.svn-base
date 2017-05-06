package com.yilidi.o2o.staticization.generator;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.staticization.RemoteFileDuplicateClient;
import com.yilidi.o2o.staticization.model.GenerateStaticFileModel;
import com.yilidi.o2o.system.service.ISystemParamsService;
import com.yilidi.o2o.system.service.dto.SystemParamsDto;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

/**
 * 静态化生成器抽象类，先本地生成静态页面，然后利用NIO将其复制到远程Web反向代理服务器的静态目录下，供其直接访问。
 * 
 * @author chenl
 * 
 */
public abstract class AbstractStaticizationGenerator implements IStaticizationGenerator {

	private Logger logger = Logger.getLogger(this.getClass());

	private static final Configuration CONFIG = new Configuration();

	private static final String PATH_SEPARATOR = "/";

	private ISystemParamsService systemParamsService;

	static {
		CONFIG.setLocale(Locale.CHINA);
		CONFIG.setDefaultEncoding("UTF-8");
		CONFIG.setEncoding(Locale.CHINA, "UTF-8");
		CONFIG.setOutputEncoding("UTF-8");
		CONFIG.setTemplateUpdateDelay(0);
		CONFIG.setTemplateExceptionHandler(TemplateExceptionHandler.HTML_DEBUG_HANDLER);
		CONFIG.setObjectWrapper(new DefaultObjectWrapper());
	}

	@Override
	public void generate(GenerateStaticFileModel generateStaticFileModel) {
		Writer out = null;
		try {
			checkGenerateStaticFileModelBasicInfo(generateStaticFileModel);
			CONFIG.setDirectoryForTemplateLoading(new File(templateHtmlBasePath()));
			Template template = CONFIG.getTemplate(generateStaticFileModel.getTemplateFoldersPath() + PATH_SEPARATOR
					+ generateStaticFileModel.getTemplateName(), "UTF-8");
			out = writer(localStaticHtmlPath(generateStaticFileModel));
			Map<String, Object> map = templateFillingContent(generateStaticFileModel.getParameterMap());
			encapsulateStaticResourcesPath(map);
			template.process(map, out);
			// 启动远程文件复制客户端1，前提是需先利用 o2o-staticization 工程，来启动远程文件复制服务端。
			new RemoteFileDuplicateClient(remoteWebServerOneIp(), remoteWebServerOnePort(),
					localStaticHtmlPath(generateStaticFileModel), remoteStaticHtmlPath(generateStaticFileModel)).run();
			// 如果有2台远程Web服务器，则需启动远程文件复制客户端2，依此类推。
			// 启动远程文件复制客户端2。
			// new RemoteFileDuplicateClient(remoteWebServerTwoIp(), remoteWebServerTwoPort(),
			// localStaticHtmlPath(generateStaticFileModel), remoteStaticHtmlPath(generateStaticFileModel)).run();
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new IllegalStateException("生成静态页面出现系统异常：" + e.getMessage(), e);
		} finally {
			try {
				out.flush();
				out.close();
			} catch (IOException e) {
				logger.error(e.getMessage());
				throw new IllegalStateException("生成静态页面出现系统异常：" + e.getMessage(), e);
			}
		}
	}

	private void checkGenerateStaticFileModelBasicInfo(GenerateStaticFileModel generateStaticFileModel) {
		if (StringUtils.isEmpty(generateStaticFileModel.getTemplateFoldersPath())) {
			String msg = "generateStaticFileModel里的参数：templateFoldersPath不能为空！";
			logger.error(msg);
			throw new IllegalStateException(msg);
		}
		if (StringUtils.isEmpty(generateStaticFileModel.getTemplateName())) {
			String msg = "generateStaticFileModel里的参数：templateName不能为空！";
			logger.error(msg);
			throw new IllegalStateException(msg);
		}
		if (StringUtils.isEmpty(generateStaticFileModel.getStaticHtmlFoldersPath())) {
			generateStaticFileModel.setStaticHtmlFoldersPath(generateStaticFileModel.getTemplateFoldersPath());
		}
		if (StringUtils.isEmpty(generateStaticFileModel.getStaticHtmlName())) {
			generateStaticFileModel.setStaticHtmlName(generateStaticFileModel.getTemplateName());
		}
	}

	private void encapsulateStaticResourcesPath(Map<String, Object> map) {
		map.put("jsPath", buyerWebUIDomain() + "/static-resource/js");
		map.put("cssPath", buyerWebUIDomain() + "/static-resource/css");
		map.put("imagesPath", buyerWebUIDomain() + "/static-resource/images");
		map.put("version", System.currentTimeMillis());
	}

	@Override
	public String generateBatch(List<GenerateStaticFileModel> generateStaticFileModelList) {
		try {
			String msg = null;
			if (!ObjectUtils.isNullOrEmpty(generateStaticFileModelList)) {
				int successfulCount = 0;
				int failureCount = 0;
				for (GenerateStaticFileModel generateStaticFileModel : generateStaticFileModelList) {
					try {
						generate(generateStaticFileModel);
						successfulCount++;
					} catch (Exception e) {
						logger.error(e.getMessage());
						failureCount++;
					}
				}
				if (successfulCount == generateStaticFileModelList.size()) {
					msg = "批量生成静态页面全部成功";
					logger.info(msg);
				} else {
					if (failureCount == generateStaticFileModelList.size()) {
						msg = "批量生成静态页面全部失败";
						logger.info(msg);
					} else {
						msg = "批量生成静态页面部分成功，其中，成功" + successfulCount + "个，失败" + failureCount + "个";
						logger.info(msg);
					}
				}
			}
			return msg;
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new IllegalStateException("批量生成静态页面出现系统异常：" + e.getMessage(), e);
		}
	}

	private String buyerWebUIDomain() {
		String paramValue = SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.OPERATION_SYSTEM_DOMAIN);
		if (!StringUtils.isEmpty(paramValue)) {
			return paramValue;
		}
		SystemParamsDto frontWebDomainDto = systemParamsService
				.loadByParamsCode(SystemContext.SystemParams.BUYER_SYSTEM_DOMAIN);
		if (null == frontWebDomainDto || StringUtils.isEmpty(frontWebDomainDto.getParamValue())) {
			String msg = "前台WEB域名 BUYER_SYSTEM_DOMAIN，需被配置！";
			logger.error(msg);
			throw new IllegalStateException(msg);
		}
		return frontWebDomainDto.getParamValue();
	}

	private String templateHtmlBasePath() {
		String paramValue = SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.TEMPLATE_HTML_BASE_PATH);
		if (!StringUtils.isEmpty(paramValue)) {
			return paramValue;
		}
		SystemParamsDto templateHtmlBasePathDto = systemParamsService
				.loadByParamsCode(SystemContext.SystemParams.TEMPLATE_HTML_BASE_PATH);
		if (null == templateHtmlBasePathDto || StringUtils.isEmpty(templateHtmlBasePathDto.getParamValue())) {
			String msg = "系统参数编码：模板Template的HTML文件根目录 TEMPLATE_HTML_BASE_PATH，需被配置！";
			logger.error(msg);
			throw new IllegalStateException(msg);
		}
		return templateHtmlBasePathDto.getParamValue();
	}

	private Writer writer(String localStaticHtmlPath) {
		try {
			File file = new File(localStaticHtmlPath);
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			if (!file.exists()) {
				file.createNewFile();
			}
			return new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"));
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			throw new IllegalStateException(e.getMessage(), e);
		}
	}

	private String localStaticHtmlBasePath() {
		String paramValue = SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.LOCAL_STATIC_HTML_BASE_PATH);
		if (!StringUtils.isEmpty(paramValue)) {
			return paramValue;
		}
		SystemParamsDto localStaticHtmlBasePathDto = systemParamsService
				.loadByParamsCode(SystemContext.SystemParams.LOCAL_STATIC_HTML_BASE_PATH);
		if (null == localStaticHtmlBasePathDto || StringUtils.isEmpty(localStaticHtmlBasePathDto.getParamValue())) {
			String msg = "系统参数编码：本地静态HTML文件根目录 LOCAL_STATIC_HTML_BASE_PATH，需被配置！";
			logger.error(msg);
			throw new IllegalStateException(msg);
		}
		return localStaticHtmlBasePathDto.getParamValue();
	}

	private String localStaticHtmlPath(GenerateStaticFileModel generateStaticFileModel) {
		return localStaticHtmlBasePath() + generateStaticFileModel.getStaticHtmlFoldersPath() + PATH_SEPARATOR
				+ generateStaticFileModel.getStaticHtmlName();
	}

	private String remoteStaticHtmlBasePath() {
		String paramValue = SystemBasicDataUtils
				.getSystemParamValue(SystemContext.SystemParams.REMOTE_WEB_SERVER_STATIC_HTML_PATH);
		if (!StringUtils.isEmpty(paramValue)) {
			return paramValue;
		}
		SystemParamsDto remoteWebServerStaticHtmlPathDto = systemParamsService
				.loadByParamsCode(SystemContext.SystemParams.REMOTE_WEB_SERVER_STATIC_HTML_PATH);
		if (null == remoteWebServerStaticHtmlPathDto
				|| StringUtils.isEmpty(remoteWebServerStaticHtmlPathDto.getParamValue())) {
			String msg = "系统参数编码：远程Web服务器Nginx或Apache存放静态HTML文件目录 REMOTE_WEB_SERVER_STATIC_HTML_PATH，需被配置！";
			logger.error(msg);
			throw new IllegalStateException(msg);
		}
		return remoteWebServerStaticHtmlPathDto.getParamValue();
	}

	private String remoteStaticHtmlPath(GenerateStaticFileModel generateStaticFileModel) {
		return remoteStaticHtmlBasePath() + generateStaticFileModel.getStaticHtmlFoldersPath() + PATH_SEPARATOR
				+ generateStaticFileModel.getStaticHtmlName();
	}

	private String remoteWebServerOneIp() {
		String paramValue = SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.REMOTE_WEB_SERVER_ONE_IP);
		if (!StringUtils.isEmpty(paramValue)) {
			return paramValue;
		}
		SystemParamsDto remoteWebServerOneIpDto = systemParamsService
				.loadByParamsCode(SystemContext.SystemParams.REMOTE_WEB_SERVER_ONE_IP);
		if (null == remoteWebServerOneIpDto || StringUtils.isEmpty(remoteWebServerOneIpDto.getParamValue())) {
			String msg = "系统参数编码：远程Web服务器Nginx或Apache所在节点1的IP地址 REMOTE_WEB_SERVER_ONE_IP，需被配置！";
			logger.error(msg);
			throw new IllegalStateException(msg);
		}
		return remoteWebServerOneIpDto.getParamValue();
	}

	private int remoteWebServerOnePort() {
		String paramValue = SystemBasicDataUtils
				.getSystemParamValue(SystemContext.SystemParams.REMOTE_WEB_SERVER_ONE_DUPLICATE_PORT);
		if (!StringUtils.isEmpty(paramValue)) {
			return Integer.valueOf(paramValue);
		}
		SystemParamsDto remoteWebServerOnePortDto = systemParamsService
				.loadByParamsCode(SystemContext.SystemParams.REMOTE_WEB_SERVER_ONE_DUPLICATE_PORT);
		if (null == remoteWebServerOnePortDto || StringUtils.isEmpty(remoteWebServerOnePortDto.getParamValue())) {
			String msg = "系统参数编码：远程Web服务器Nginx所在节点1的文件复制监听端口 REMOTE_WEB_SERVER_ONE_DUPLICATE_PORT，需被配置！";
			logger.error(msg);
			throw new IllegalStateException(msg);
		}
		return Integer.valueOf(remoteWebServerOnePortDto.getParamValue());
	}

	// private String remoteWebServerTwoIp() {
	// SystemParamsDto remoteWebServerTwoIpDto = systemParamsService
	// .loadByParamsCode(SystemContext.SystemParams.REMOTE_WEB_SERVER_TWO_IP);
	// if (null == remoteWebServerTwoIpDto || StringUtils.isEmpty(remoteWebServerTwoIpDto.getParamValue())) {
	// String msg = "系统参数编码：远程Web服务器Nginx或Apache所在节点2的IP地址 REMOTE_WEB_SERVER_TWO_IP，需被配置！";
	// logger.error(msg);
	// throw new IllegalStateException(msg);
	// }
	// return remoteWebServerTwoIpDto.getParamValue();
	// }
	//
	// private int remoteWebServerTwoPort() {
	// SystemParamsDto remoteWebServerTwoPortDto = systemParamsService
	// .loadByParamsCode(SystemContext.SystemParams.REMOTE_WEB_SERVER_TWO_PORT);
	// if (null == remoteWebServerTwoPortDto || StringUtils.isEmpty(remoteWebServerTwoPortDto.getParamValue())) {
	// String msg = "系统参数编码：远程Web服务器Nginx或Apache所在节点2的端口 REMOTE_WEB_SERVER_TWO_PORT，需被配置！";
	// logger.error(msg);
	// throw new IllegalStateException(msg);
	// }
	// return Integer.valueOf(remoteWebServerTwoPortDto.getParamValue());
	// }

	protected abstract Map<String, Object> templateFillingContent(Map<String, Object> parameterMap);

	public ISystemParamsService getSystemParamsService() {
		return systemParamsService;
	}

	public void setSystemParamsService(ISystemParamsService systemParamsService) {
		this.systemParamsService = systemParamsService;
	}

}
