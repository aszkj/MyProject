package com.yilidi.o2o.staticization.generator.concrete;

import java.util.HashMap;
import java.util.Map;

import com.yilidi.o2o.staticization.generator.AbstractStaticizationGenerator;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 具体静态化生成器类，获取模板填充内容，利用父类定义的模板方法generate或generateBatch来实现页面静态化。
 * 
 * @author chenl
 * 
 */
public class UserDetailStaticizationGenerator extends AbstractStaticizationGenerator {

	private IUserService userService;

	@Override
	protected Map<String, Object> templateFillingContent(Map<String, Object> parameterMap) {
		Integer userId = (Integer) parameterMap.get("userId");
		UserDto uDto = userService.viewUserDetail(userId);
		Map<String, Object> TemplateFillingContent = new HashMap<String, Object>();
		TemplateFillingContent.put("userDto", uDto);
		return TemplateFillingContent;
	}

	public IUserService getUserService() {
		return userService;
	}

	public void setUserService(IUserService userService) {
		this.userService = userService;
	}

}
