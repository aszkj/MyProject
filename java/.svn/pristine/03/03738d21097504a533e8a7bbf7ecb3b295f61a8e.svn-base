package com.yilidi.o2o.controller.mobile.buyer.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.AppBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.StringUtils;

/**
 * 
 * 文件上传请求,用于APP端上传文件用
 * 
 * @author: chenb
 * @date: 2015年12月3日 下午5:05:41
 * 
 */
@Controller
@RequestMapping(value = "/interfaces/buyer")
public class FileUploadController extends AppBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    private static final String USER_PIC_RELATIVE_PATH_DEFAULT = "/pic/user";
    /** 用户上传头像最大宽度 **/
    private static final int USERAVATAR_MAX_WIDTH = 240;
    /** 缩放比例 **/
    private static final double AVATAR_SCALE = 1 / 3d;

    private static final String SALEPRODUCTEVALUATION_PIC_RELATIVE_PATH = "/pic/evaluation";
    /** 上传评论图片最大宽度 **/
    private static final int SALEPRODUCT_EVALUATION_IMAGE_MAX_WIDTH = 750;
    /** 上传评论图片最小宽度 **/
    private static final int SALEPRODUCT_EVALUATION_IMAGE_MIN_WIDTH = 300;

    /**
     * 上传用户头像
     * 
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/upload/userimage")
    @ResponseBody
    public ResultParamModel uploadUserImage(HttpServletRequest req, HttpServletResponse resp) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.USER_PIC_RELATIVE_PATH);
            fileRelativePath = StringUtils.isEmpty(fileRelativePath) ? USER_PIC_RELATIVE_PATH_DEFAULT : fileRelativePath;
            String filePathSub = fileUploadUtils.uploadTempFileByWidthAndHeight(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.IMAGE, USERAVATAR_MAX_WIDTH, USERAVATAR_MAX_WIDTH, 1);
            logger.info("===========filePathSub : " + filePathSub);
            String fullPath = StringUtils.toFullLocalImageUrl(filePathSub);
            return super.encapsulateParam(fullPath, AppMsgBean.MsgCode.SUCCESS, "上传头像成功");
        } catch (Exception e) {
            logger.error("上传头像失败：" + e.getMessage(), e);
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 上传商品评论头像
     * 
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/upload/evaluateimage")
    @ResponseBody
    public ResultParamModel uploadEvaluateImage(HttpServletRequest req, HttpServletResponse resp) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.SALEPRODUCTEVALUATION_PIC_RELATIVE_PATH);
            fileRelativePath = StringUtils.isEmpty(fileRelativePath) ? SALEPRODUCTEVALUATION_PIC_RELATIVE_PATH
                    : fileRelativePath;
            String filePathSub = fileUploadUtils.uploadAndScaleTempFile(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.IMAGE, SALEPRODUCT_EVALUATION_IMAGE_MAX_WIDTH,
                    SALEPRODUCT_EVALUATION_IMAGE_MAX_WIDTH * 2, AVATAR_SCALE);
            // filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
            // FileUploadUtils.UploadFileType.IMAGE);
            logger.info("===========filePathSub : " + filePathSub);
            String fullPath = StringUtils.toFullLocalImageUrl(filePathSub);
            return super.encapsulateParam(fullPath, AppMsgBean.MsgCode.SUCCESS, "上传头像");
        } catch (Exception e) {
            logger.error("上传头像失败：" + e.getMessage(), e);
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}