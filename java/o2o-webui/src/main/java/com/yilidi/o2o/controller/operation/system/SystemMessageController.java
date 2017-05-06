package com.yilidi.o2o.controller.operation.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * 系統消息控制
 * @author Administrator
 *
 */
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.system.service.IMessageService;
import com.yilidi.o2o.system.service.ISystemMessageService;
import com.yilidi.o2o.system.service.dto.SystemMessageDto;
import com.yilidi.o2o.system.service.dto.query.SystemMessageQueryDto;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;
@Controller
@RequestMapping(value = "/operation")
public class SystemMessageController extends OperationBaseController{
private Logger logger = Logger.getLogger(this.getClass());
private static final String MESSAGE_PIC_RELATIVE_PATH_DEFAULT = "/pic/message";
	@Autowired
	private ISystemMessageService systemMessageService;
	@Autowired
	private IUserService userService;
	@Autowired 
	private IMessageService messageService;
	
	private Map<String, Object> validateParam(SystemMessageDto systemMessageDto){
		String msg = "";
		boolean flag = true;
		if(systemMessageDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_SPECIAL)){
			if(StringUtils.isEmpty(systemMessageDto.getPublishObjectValue())){
				msg = "請選擇定向發佈的用戶";
				flag = false;
			}
		}else if(systemMessageDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_SELLER_SPECIAL)){
			if(StringUtils.isEmpty(systemMessageDto.getPublishObjectValue())){
				msg = "請選擇定向發佈的門店";
				flag = false;
			}
		}else if(StringUtils.isEmpty(systemMessageDto.getMessageTitle())){
			msg = "消息標題不能為空";
			flag = false;
		}else if(StringUtils.isEmpty(systemMessageDto.getMessageImage())){
			msg = "消息圖片不能為空";
			flag = false;
		}else if(StringUtils.isEmpty(systemMessageDto.getMessageIntro())){
			msg = "消息簡介不能為空";
			flag = false;
		}else if(StringUtils.isEmpty(systemMessageDto.getMessageContent())){
			msg = "消息內容不能為空";
			flag = false;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("flag", flag);
		map.put("msg", msg);
		return map;
	}
	
	/**
	 * 添加消息
	 */
	@RequestMapping(value="/systemMessage/addSystemMessage")
	@ResponseBody
	public MsgBean addSystemMessage(@RequestBody SystemMessageDto systemMessageDto){
		Map<String, Object> map = validateParam(systemMessageDto);
		if(!(boolean)map.get("flag")){
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, map.get("msg").toString());
		}
		systemMessageDto.setAddUser(getUserId());
		systemMessageDto.setMessageTypeGroup(SystemContext.SystemDomain.MESSAGETYPEGROUP_SYSTEMGROUP);
		systemMessageDto.setCheckStatus(SystemContext.SystemDomain.MESSAGECHECKSTATUS_AWAIT);
		try {
			int num = systemMessageService.addSystemMessage(systemMessageDto);
			if(num > 0){
				return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "消息創建成功");
			}
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "消息創建失敗");
		} catch (Exception e) {
			logger.info("系統異常");
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "系統異常:"+e.getMessage());
		}
	}
	
	/**
	 * 修改消息
	 */
	@RequestMapping(value="/{id}/systemMessage/updateSystemMessage")
	@ResponseBody
	public MsgBean updateSystemMessage(@RequestBody SystemMessageDto systemMessageDto,@PathVariable("id") Integer id){
		if(ObjectUtils.isNullOrEmpty(id)){
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "數據有誤");
		}
		systemMessageDto.setId(id);
		Map<String, Object> map = validateParam(systemMessageDto);
		if(!(boolean)map.get("flag")){
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, map.get("msg").toString());
		}
		systemMessageDto.setUpdateUser(getUserId());
		try {
			int num = systemMessageService.updateSystemMessage(systemMessageDto);
			if(num > 0){
				return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "消息修改成功");
			}
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "消息修改失敗");
		} catch (Exception e) {
			logger.info("系統異常");
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "系統異常:"+e.getMessage());
		}
	}
	/**
	 * 根据id获取消息(用于回显)
	 */
	@RequestMapping(value="/{id}/systemMessage/getSystemMessageById")
	@ResponseBody
	public MsgBean getSystemMessageById(@PathVariable("id")Integer id){
		if(ObjectUtils.isNullOrEmpty(id)){
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "數據有誤");
		}
		try {
			SystemMessageDto systemMessageDto = systemMessageService.getSystemMessageById(id);
			if(!ObjectUtils.isNullOrEmpty(systemMessageDto)){
				return super.encapsulateMsgBean(systemMessageDto,MsgBean.MsgCode.SUCCESS, "");
			}
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "數據獲取失敗");
		} catch (Exception e) {
			logger.info("系統異常");
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "系統異常:"+e.getMessage());
		}
		
	}
	/**
	 * 消息审核
	 */
	@RequestMapping(value="/{id}/systemMessage/updateCheckStatus")
	@ResponseBody
	public MsgBean updateCheckStatus(@RequestBody SystemMessageDto systemMessageDto,@PathVariable("id") Integer id){
		if(ObjectUtils.isNullOrEmpty(id)){
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "數據有誤");
		}
		systemMessageDto.setId(id);
		systemMessageDto.setCheckUser(getUserId());
		try {
			int num = systemMessageService.updateCheckStatus(systemMessageDto);
			if(num > 0){
				//發送推送消息
				SystemMessageDto resultDto = systemMessageService.loadById(id);
				if(!ObjectUtils.isNullOrEmpty(resultDto)){
					List<Integer> buyerUserIdList = null;
					List<Integer> sellerUserIdList = null;
					int pushWay = 0;//1:单发;2:多发
					if(resultDto.getCheckStatus().equals(SystemContext.SystemDomain.MESSAGECHECKSTATUS_OK)){
						if(resultDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_ALL)
							||resultDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_ALL)){
							//查询买家所有主用户
							List<UserDto> buyerUserDtoList = userService.getPushUserByCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
							if(!ObjectUtils.isNullOrEmpty(buyerUserDtoList)){
								buyerUserIdList = new ArrayList<>();
								for (UserDto userDto : buyerUserDtoList) {
									buyerUserIdList.add(userDto.getId());
								}
							}
							pushWay = 2;
						}
						if(resultDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_ALL)
								||resultDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_SELLER_ALL)){
							//查询卖家所有主用户
							List<UserDto> sellerUserDtoList = userService.getPushUserByCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
							if(!ObjectUtils.isNullOrEmpty(sellerUserDtoList)){
								sellerUserIdList = new ArrayList<>();
								for (UserDto userDto : sellerUserDtoList) {
									sellerUserIdList.add(userDto.getId());
								}
							}
							pushWay = 2;
						}
						if(resultDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_SPECIAL)){
							if(!StringUtils.isEmpty(resultDto.getPublishObjectValue())){
								String[] publishObjectValues = resultDto.getPublishObjectValue().split(",");
								if(!ObjectUtils.isNullOrEmpty(publishObjectValues)){
									buyerUserIdList = new ArrayList<>();
									for (String publishObjectValue : publishObjectValues) {
										buyerUserIdList.add(Integer.parseInt(publishObjectValue));
									}
								}
							}
							pushWay = 1;
						}
						if(resultDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_SELLER_SPECIAL)){
							if(!StringUtils.isEmpty(resultDto.getPublishObjectValue())){
								String[] publishObjectValues = resultDto.getPublishObjectValue().split(",");
								if(!ObjectUtils.isNullOrEmpty(publishObjectValues)){
									buyerUserIdList = new ArrayList<>();
									for (String publishObjectValue : publishObjectValues) {
										UserDto userDto = userService.loadMainUser(Integer.parseInt(publishObjectValue), SystemContext.UserDomain.USERMASTERFLAG_MAIN);
										buyerUserIdList.add(userDto.getId());
									}
								}
							}
							pushWay = 1;
						}
						if(!ObjectUtils.isNullOrEmpty(buyerUserIdList)){
							messageService.sendBuyerPushMystemMessage(pushWay, buyerUserIdList, resultDto);
						}
						if(!ObjectUtils.isNullOrEmpty(sellerUserIdList)){
							messageService.sendSellerPushMystemMessage(pushWay, sellerUserIdList, resultDto);
						}
					}
				}
				return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作成功");
			}
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "操作失敗");
		} catch (Exception e) {
			logger.info("系統異常：");
			e.printStackTrace();
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "系統異常:"+e.getMessage());
		}
	}
	/**
	 * 消息列表
	 */
	@RequestMapping(value="/systemMessage/getSystemMessageList")
	@ResponseBody
	public MsgBean getSystemMessageList(@RequestBody SystemMessageQueryDto systemMessageQueryDto){
		if(!StringUtils.isEmpty(systemMessageQueryDto.getMessageTitle())){
			systemMessageQueryDto.setMessageTitle(systemMessageQueryDto.getMessageTitle().trim());
		}
		try {
			YiLiDiPage<SystemMessageDto> page = systemMessageService.getSystemMessageList(systemMessageQueryDto);
			return super.encapsulateMsgBean(page,MsgBean.MsgCode.SUCCESS, "");
		} catch (Exception e) {
			logger.info("系統異常");
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "系統異常:"+e.getMessage());
		}
	}
	
	/**
     * 上传消息图片到临时服务器
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/uploadMessageImageTemp")
    @ResponseBody
    public MsgBean uploadBrandImageTemp(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.MESSAGE_PIC_RELATIVE_PATH);
            fileRelativePath = StringUtils.isEmpty(fileRelativePath) ? MESSAGE_PIC_RELATIVE_PATH_DEFAULT
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
     * 删除消息图片相关临时图片
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/deleteMessageImageTemp")
    @ResponseBody
    public MsgBean deleteBrandTemp(HttpServletRequest req) {
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
