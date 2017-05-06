/**
 * 文件名称：TestStaticizationController.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.controller.common.BaseController;
import com.yilidi.o2o.staticization.generator.concrete.UserDetailStaticizationGenerator;
import com.yilidi.o2o.staticization.model.GenerateStaticFileModel;

/**
 * 功能描述：<概要描述> 作者： chenl
 */
@Controller
public class TestStaticizationController extends BaseController {

	@Autowired
	private UserDetailStaticizationGenerator userDetailStaticizationGenerator;

	/**
	 * 测试静态化
	 * 
	 * @param id
	 *            用户ID
	 * @return Object
	 */
	@RequestMapping("/{id}/showUserForStaticization")
	@ResponseBody
	public Object showUserForStaticization(@PathVariable String id) {
		Integer userId = Integer.parseInt(id);
		GenerateStaticFileModel generateStaticFileModel = new GenerateStaticFileModel();
		generateStaticFileModel.setTemplateFoldersPath("/user");
		generateStaticFileModel.setTemplateName("userDetail.html");
		generateStaticFileModel.setStaticHtmlFoldersPath("/user/detail");
		generateStaticFileModel.setStaticHtmlName("user" + id + ".html");
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		parameterMap.put("userId", userId);
		generateStaticFileModel.setParameterMap(parameterMap);
		userDetailStaticizationGenerator.generate(generateStaticFileModel);
		return generateStaticFileModel;
	}

	/**
	 * 测试批量静态化
	 * 
	 * @param ids
	 *            用户ID字符串，以“_”号连接
	 * @return Object
	 */
	@RequestMapping("/{ids}/showUserForBatchStaticization")
	@ResponseBody
	public Object showUserForBatchStaticization(@PathVariable String ids) {
		if (!ids.contains("_")) {
			return null;
		}
		StringTokenizer st = new StringTokenizer(ids, "_");
		List<GenerateStaticFileModel> generateStaticFileModelList = new ArrayList<GenerateStaticFileModel>();
		while (st.hasMoreTokens()) {
			Integer userId = Integer.parseInt(st.nextToken());
			GenerateStaticFileModel generateStaticFileModel = new GenerateStaticFileModel();
			generateStaticFileModel.setTemplateFoldersPath("/user");
			generateStaticFileModel.setTemplateName("userDetail.html");
			generateStaticFileModel.setStaticHtmlFoldersPath("/user/detail");
			generateStaticFileModel.setStaticHtmlName("user" + userId + ".html");
			Map<String, Object> parameterMap = new HashMap<String, Object>();
			parameterMap.put("userId", userId);
			generateStaticFileModel.setParameterMap(parameterMap);
			generateStaticFileModelList.add(generateStaticFileModel);
		}
		String msg = userDetailStaticizationGenerator.generateBatch(generateStaticFileModelList);
		return msg;
	}

}
