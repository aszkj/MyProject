package com.yilidi.o2o.controller.operation.product;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductService;

/**
 * 
 * 产品图片上传Controller
 * 
 * @author: zxs
 * @date: 2015年11月2日 上午11:40:11
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class ProductImageUploadController extends OperationBaseController {

	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private IProductClassService productClassService;

	@Autowired
	private IProductService productService;

	/**
	 * 上传文件到临时服务器
	 * 
	 * @param req
	 *            参数req
	 * @return String
	 * @throws ProductServiceException
	 */
	@RequestMapping("/uploadFileTemp")
	@ResponseBody
	public MsgBean uploadFileTemp(HttpServletRequest req) {
		try {
			FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
			List<FileItem> items = fileUploadUtils.getUploadFiles(req);
			logger.info("items : " + items);
			String fileRelativePath = systemBasicDataInfoUtils
					.getSystemParamValue(SystemContext.SystemParams.PRODUCT_PIC_RELATIVE_PATH);
			String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
					FileUploadUtils.UploadFileType.IMAGE);
			logger.info("===========filePathSub : " + filePathSub);
			return super.encapsulateMsgBean(filePathSub, MsgBean.MsgCode.SUCCESS, "上传文件成功");
		} catch (Exception e) {
			logger.error("上传文件失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 内容详情上传文件到临时服务器
	 * 
	 * @param req
	 *            参数req
	 * @return String
	 * @throws ProductServiceException
	 */
	@RequestMapping("/uploadContentFileTemp")
	@ResponseBody
	public HashMap<String, Object> uploadContentFileTemp(HttpServletRequest req) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
			List<FileItem> items = fileUploadUtils.getUploadFiles(req);
			if (!ObjectUtils.isNullOrEmpty(items)) {
				logger.info("items : " + items);
				String fileRelativePath = systemBasicDataInfoUtils
						.getSystemParamValue(SystemContext.SystemParams.PRODUCT_PIC_RELATIVE_PATH);
				String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
						FileUploadUtils.UploadFileType.IMAGE);
				logger.info("===========filePathSub : " + filePathSub);
				String uploadFileTempUrl = systemBasicDataInfoUtils
						.getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_TEMP_URL);
				if (StringUtils.isEmpty(uploadFileTempUrl)) {
					resultMap.put("error", 1);
					resultMap.put("url", "请配置系统参数：UPLOAD_FILE_TEMP_URL（上传文件临时基础URL）");
					return resultMap;
				}
				resultMap.put("error", 0);
				resultMap.put("url", uploadFileTempUrl + filePathSub);
				return resultMap;
			} else {
				resultMap.put("error", 1);
				resultMap.put("url", "没有可上传的文件");
				return resultMap;
			}
		} catch (Exception e) {
			logger.error("上传文件到本地服务器临时目录失败：" + e.getMessage(), e);
			resultMap.put("error", 1);
			resultMap.put("url", "上传文件失败");
			return resultMap;
		}
	}

	/**
	 * 删除临时服务器文件
	 * 
	 * @param req
	 *            参数req
	 * @return String
	 * @throws ProductServiceException
	 */
	@RequestMapping("/deleteFileTemp")
	@ResponseBody
	public MsgBean deleteFileTemp(HttpServletRequest req) {
		try {
			String tempPicPath = req.getParameter("tempPicPath");
			if (!ObjectUtils.isNullOrEmpty(tempPicPath)) {
				String[] arrParam = tempPicPath.split(",");
				for (String idString : arrParam) {
					FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
					fileUploadUtils.deleteTempFile(idString);
				}
				return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "删除文件成功");
			} else {
				return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "删除文件失败");
			}
		} catch (Exception e) {
			logger.error("删除文件失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}
}
