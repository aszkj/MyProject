/**
 * 文件名称：TestFreeMarkerController.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.report.export.user.UserReportExport;
import com.yilidi.o2o.report.imports.user.UserReportImport;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 功能描述：<概要描述> 作者： chenl
 */
@Controller
public class TestFreeMarkerController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IUserService userService;

    @Autowired
    private UserReportExport userReportExport;

    @Autowired
    private UserReportImport userReportImport;

    /**
     * 测试FreeMarker
     * 
     * @param id
     * @param model
     * @return String
     */
    @RequestMapping(value = "/{id}/showUserForFreeMarker")
    public String showUserForFreeMarker(@PathVariable String id, Model model) {
        Integer userId = Integer.parseInt(id);
        UserDto uDto = userService.viewUserDetail(userId);
        model.addAttribute("userDto", uDto);
        return "/user/userDetail";
    }

    @RequestMapping("/uploadToTemp")
    @ResponseBody
    public MsgBean uploadToTemp(HttpServletRequest req) throws Exception {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + JsonUtils.toJsonStringWithDateFormat(items));
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.PRODUCT_PIC_RELATIVE_PATH);
            String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.IMAGE);
            logger.info("===========filePathSub : " + filePathSub);
            return super.encapsulateMsgBean(filePathSub, MsgBean.MsgCode.SUCCESS, "上传图片到本地服务器临时目录成功");
        } catch (Exception e) {
            logger.error("上传图片到本地服务器临时目录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    @RequestMapping("/uploadToPublish")
    @ResponseBody
    public MsgBean uploadToPublish(HttpServletRequest req) throws Exception {
        try {
            String tempPicPath = req.getParameter("tempPicPath");
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            String remotePublishFileFullPath = fileUploadUtils.uploadPublishFile(tempPicPath);
            logger.info("===========remotePublishFileFullPath : " + remotePublishFileFullPath);
            return super.encapsulateMsgBean(remotePublishFileFullPath, MsgBean.MsgCode.SUCCESS, "图片上传远程服务器成功");
        } catch (Exception e) {
            logger.error("图片上传远程服务器失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    @RequestMapping("/deleteTemp")
    @ResponseBody
    public MsgBean deleteTemp(HttpServletRequest req) throws Exception {
        try {
            String tempPicPath = req.getParameter("tempPicPath");
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            fileUploadUtils.deleteTempFile(tempPicPath);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "删除本地服务器中的临时文件成功");
        } catch (Exception e) {
            logger.error("删除本地服务器中的临时文件失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    @RequestMapping("/deletePublish")
    @ResponseBody
    public MsgBean deletePublish(HttpServletRequest req) throws Exception {
        try {
            String picPath = req.getParameter("picPath");
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            fileUploadUtils.deletePublishFile(picPath);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "删除远程服务器中的正式文件成功");
        } catch (Exception e) {
            logger.error("删除远程服务器中的正式文件失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    @RequestMapping("/export")
    public String export(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // MsgBean msgBean = new MsgBean();
        try {
            UserDto userDto = new UserDto();
            userDto.setCreateTime(new Date());
            userReportExport.exportExcel(userDto, "用户报表");
        } catch (Exception e) {
            e.printStackTrace();
            // msgBean.setMsg("上传失败").setMsgCode(MsgBean.MsgCode.FAILURE);
        }
        return null;
    }

    @RequestMapping("/uploadToTempForUserReport")
    @ResponseBody
    public MsgBean uploadToTempForUserReport(HttpServletRequest req) throws Exception {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.USER_REPORT_IMPORT_RELATIVE_PATH);
            String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.EXCEL);
            logger.info("===========filePathSub : " + filePathSub);
            return super.encapsulateMsgBean(filePathSub, MsgBean.MsgCode.SUCCESS, "上传用户报表到本地服务器临时目录成功");
        } catch (Exception e) {
            logger.error("上传用户报表到本地服务器临时目录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    @RequestMapping("/importUserReport")
    @ResponseBody
    public MsgBean importUserReport(HttpServletRequest req) throws Exception {
        try {
            String reportRelativePath = req.getParameter("reportRelativePath");
            List<String> validateTipsList = userReportImport.importExcel(reportRelativePath, null);
            if (!ObjectUtils.isNullOrEmpty(validateTipsList)) {
                // logger.info("===========validateTipsList : " + JsonUtils.toJsonStringWithDateFormat(validateTipsList));
                return super.encapsulateMsgBean(validateTipsList, MsgBean.MsgCode.FAILURE, "导入用户报表失败");
            } else {
                logger.info("导入用户报表成功");
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "导入用户报表成功");
            }
        } catch (Exception e) {
            logger.error("导入用户报表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}
