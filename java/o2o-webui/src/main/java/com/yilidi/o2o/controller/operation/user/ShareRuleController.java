package com.yilidi.o2o.controller.operation.user;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.IShareRuleService;
import com.yilidi.o2o.user.service.dto.ShareRuleDto;
import com.yilidi.o2o.user.service.dto.query.ShareRuleQueryDto;

/**
 * 分享规则 管理
 * 
 * @author: chenb
 * @date: 2015年11月17日 上午10:03:22
 * 
 */
@Controller("operationShareRuleController")
@RequestMapping(value = "/operation")
public class ShareRuleController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());
    /**
     * 分享背景图片相对路径
     */
    private static final String P_SHARERULEBACKGROUND_PIC_RELATIVE_PATH_DEFAULT = "/pic/sharerule";

    @Autowired
    private IShareRuleService shareRuleService;

    /**
     * 查询分享规则列表
     * 
     * @param shareRuleQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/sharerule/search")
    @ResponseBody
    public MsgBean search(@RequestBody ShareRuleQueryDto shareRuleQueryDto) {
        try {
            YiLiDiPage<ShareRuleDto> yiLiDiPage = shareRuleService.findShareRules(shareRuleQueryDto);
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询分享规则列表成功");
        } catch (Exception e) {
            logger.error("查询分享规则列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 新增分享规则
     * 
     * @param shareRuleDto
     *            分享规则DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/sharerule/create")
    @ResponseBody
    public MsgBean create(@RequestBody ShareRuleDto shareRuleDto) {
        try {
            if (ObjectUtils.isNullOrEmpty(shareRuleDto)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "参数不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getShareRuleName())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "规则名称不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getStrStartValidTime())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "活动开始时间不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getStrEndValidTime())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "活动结束时间不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getH5DrawUrl())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "分享领取h5页面不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getDescriptionUrl())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "分享规则说明页面不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getBackgroundImageUrl())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "分享背景图片不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getAvatarHeight())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "头像高度不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getMobileHeight())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "手机号码高度不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getQrCodeHeight())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "二维码高度不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getSmsContent())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "短信分享内容不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getFriendTitle())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "微信好友分享标题不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getFriendContent())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "微信好友分享内容不能为空");
            }
            Date startValidTime = DateUtils.parseDate(shareRuleDto.getStrStartValidTime(),
                    CommonConstants.DATE_FORMAT_CURRENTTIME);
            Date endValidTime = DateUtils.parseDate(shareRuleDto.getStrEndValidTime(),
                    CommonConstants.DATE_FORMAT_CURRENTTIME);
            shareRuleDto.setStartValidTime(startValidTime);
            shareRuleDto.setEndValidTime(endValidTime);
            if (!shareRuleDto.getEndValidTime().after(shareRuleDto.getStartValidTime())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "不是有效的活动时间范围");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getRoleType())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "角色类型不能为空");
            }
            shareRuleDto.setCreateUserId(super.getUserId());
            shareRuleService.saveShareRule(shareRuleDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "新增分享规则成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 修改分享规则
     * 
     * @param shareRuleDto
     *            分享规则DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/sharerule/edit")
    @ResponseBody
    public MsgBean edit(@RequestBody ShareRuleDto shareRuleDto) {
        try {
            if (ObjectUtils.isNullOrEmpty(shareRuleDto)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "参数不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getShareRuleName())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "规则名称不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getStrStartValidTime())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "活动开始时间不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getStrEndValidTime())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "活动结束时间不能为空");
            }
             if (ObjectUtils.isNullOrEmpty(shareRuleDto.getH5DrawUrl())) {
             return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "分享领取h5页面不能为空");
             }
             if (ObjectUtils.isNullOrEmpty(shareRuleDto.getDescriptionUrl())) {
             return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "分享规则说明页面不能为空");
             }
            if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getStrStartValidTime())) {
                Date startValidTime = DateUtils.parseDate(shareRuleDto.getStrStartValidTime(),
                        CommonConstants.DATE_FORMAT_CURRENTTIME);
                shareRuleDto.setStartValidTime(startValidTime);
            }
            if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getStrEndValidTime())) {
                Date endValidTime = DateUtils.parseDate(shareRuleDto.getStrEndValidTime(),
                        CommonConstants.DATE_FORMAT_CURRENTTIME);
                shareRuleDto.setEndValidTime(endValidTime);
            }
            if (!shareRuleDto.getEndValidTime().after(shareRuleDto.getStartValidTime())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "不是有效的活动时间范围");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getRoleType())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "角色类型不能为空");
            }
            shareRuleDto.setModifyUserId(super.getUserId());
            shareRuleDto.setModifyTime(new Date());
            shareRuleService.updateShareRule(shareRuleDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改分享规则成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 分享规则详细信息
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/sharerule/{ruleId}/detail")
    @ResponseBody
    public MsgBean updateStatus(@PathVariable Integer ruleId) {
        try {
            if (!ObjectUtils.isNullOrEmpty(ruleId)) {
                ShareRuleDto shareRuleDto = shareRuleService.loadDetailById(ruleId);
                return super.encapsulateMsgBean(shareRuleDto, MsgBean.MsgCode.SUCCESS, "操作成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作失败");
            }
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 修改分享规则状态
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/sharerule/{param}/updatestatus")
    @ResponseBody
    public MsgBean updateStatus(@PathVariable String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] params = param.split(",");
                Integer ruleId = Integer.valueOf(params[0]);
                String status = params[1];
                shareRuleService.updateStatusById(ruleId, status, super.getUserId(), new Date());
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作失败");
            }
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 上传分享背景图片到临时服务器
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/uploadShareRuleBackgroundImageTemp")
    @ResponseBody
    public MsgBean uploadShareRuleBackgroundImageTemp(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.P_SHARERULEBACKGROUND_PIC_RELATIVE_PATH);
            fileRelativePath = StringUtils.isEmpty(fileRelativePath) ? P_SHARERULEBACKGROUND_PIC_RELATIVE_PATH_DEFAULT
                    : fileRelativePath;
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
     * 删除分享背景临时图片
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/deleteShareRuleBackgroundImageTemp")
    @ResponseBody
    public MsgBean deleteShareRuleBackgroundImageTemp(HttpServletRequest req) {
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
