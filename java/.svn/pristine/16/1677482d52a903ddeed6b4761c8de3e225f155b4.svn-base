package com.yilidi.o2o.controller.mobile.buyer.system;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.yilidi.o2o.appparam.seller.system.SystemMessageParam;
import com.yilidi.o2o.appvo.buyer.system.SystemDictVO;
import com.yilidi.o2o.appvo.buyer.system.SystemMessageVO;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.AppParamModel;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.system.service.ISystemMessageService;
import com.yilidi.o2o.system.service.dto.SystemDictDto;
import com.yilidi.o2o.system.service.dto.SystemMessageDto;
import com.yilidi.o2o.system.service.dto.query.SystemMessageQueryDto;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;

@Controller("buyerSystemMessageController")
@RequestMapping(value = "/interfaces/buyer")
public class SystemMessageController extends BuyerBaseController  {
	
	@Autowired
	private ISystemMessageService systemMessageService;
	@Autowired
	private IUserService userService;
	
	
	/**
	 * 获取消息模块
	 * @return
	 */
	@RequestMapping(value = "/message/usermessages")
	@ResponseBody
	public ResultParamModel getMessageModule() {
		List<SystemDictVO> systemDictVoList = null; 
		SystemDictVO systemDictVo = null;
		try {
			//获取当前对象
			UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
			UserDto userDto = userService.loadBuyerUserById(userSessionModel.getUserId());
			if(ObjectUtils.isNullOrEmpty(userDto)){
				return super.encapsulateParam( AppMsgBean.MsgCode.FAILURE, "session不存在");
			}
			List<SystemDictDto> messageModuleList = systemMessageService.getMessageModule(userDto.getCreateTime());
			if(!ObjectUtils.isNullOrEmpty(messageModuleList)){
				systemDictVoList = new ArrayList<SystemDictVO>();	
				for (SystemDictDto systemDictDto : messageModuleList) {
					systemDictVo = new SystemDictVO();
					systemDictVo.setTypeName(systemDictDto.getDictName());
					systemDictVo.setTypeValue(ConverterUtils.getMessageTypeValue(systemDictDto.getDictCode()));
					systemDictVo.setMsgTime(systemDictDto.getNewMessage().getAddTime());
					systemDictVo.setMsgAbstract(systemDictDto.getNewMessage().getMessageIntro());
					systemDictVoList.add(systemDictVo);
				}
			}
			return super.encapsulateParam(systemDictVoList, AppMsgBean.MsgCode.SUCCESS, "查询消息列表接口成功");
		} catch (Exception e) {
			e.printStackTrace();
			return super.encapsulateParam( AppMsgBean.MsgCode.FAILURE, "查询消息列表接口失败");
		}
	}
	
	/**
	 * 获取消息列表
	 */
	@RequestMapping(value = "/message/usermessagesbytype")
	@ResponseBody
	public ResultParamModel getMessageList(HttpServletRequest req){
		SystemMessageParam systemMessageParam = super.getEntityParam(req, SystemMessageParam.class);
		if(ObjectUtils.isNullOrEmpty(systemMessageParam.getTypeValue())){
			return encapsulateParam( AppMsgBean.MsgCode.FAILURE, "请求参数有误");
		}
		//获取当前对象
		UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
		UserDto userDto = userService.loadBuyerUserById(userSessionModel.getUserId());
		if(ObjectUtils.isNullOrEmpty(userDto)){
			return super.encapsulateParam( AppMsgBean.MsgCode.FAILURE, "session不存在");
		}
		SystemMessageQueryDto systemMessageQueryDto = new SystemMessageQueryDto();
		systemMessageQueryDto.setStart(systemMessageParam.getPageNum());
		systemMessageQueryDto.setPageSize(systemMessageParam.getPageSize());
		systemMessageQueryDto.setMessageType(ConverterUtils.getMessageType(systemMessageParam.getTypeValue()));
		systemMessageQueryDto.setCheckStatus(SystemContext.SystemDomain.MESSAGECHECKSTATUS_OK);
		systemMessageQueryDto.setCreateTime(userDto.getCreateTime());
		List<SystemMessageVO> systemMessageList = null;
		SystemMessageVO systemMessageVo = null;
		YiLiDiPage<SystemMessageDto> systemMessagePageInfo = systemMessageService.getAppSystemMessageList(systemMessageQueryDto,userSessionModel.getUserId());
		List<SystemMessageDto> systemMessageDtoList = systemMessagePageInfo.getResultList();
		if(!ObjectUtils.isNullOrEmpty(systemMessageDtoList)){
			systemMessageList = new ArrayList<SystemMessageVO>();
			for (SystemMessageDto systemMessageDto : systemMessageDtoList) {
				systemMessageVo = new SystemMessageVO();
				systemMessageVo.setMsgId(systemMessageDto.getId());
				systemMessageVo.setMsgTitle(systemMessageDto.getMessageTitle());
				systemMessageVo.setMsgTime(systemMessageDto.getAddTime());
				systemMessageVo.setMsgImage(systemMessageDto.getMessageImage());
				systemMessageVo.setMsgAbstract(systemMessageDto.getMessageIntro());
				systemMessageVo.setDirectType((ConverterUtils.getSkipTypeValue(systemMessageDto.getSkipType())));
				systemMessageVo.setDirectCode(systemMessageDto.getSkipObject());
				systemMessageList.add(systemMessageVo);
			}
		}
		return super.encapsulatePageParam(systemMessagePageInfo, systemMessageList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
	}
	
	/**
	 * 获取消息详情
	 */
	@RequestMapping(value = "/message/messagedetail")
	@ResponseBody
	public ResultParamModel getMessageById(HttpServletRequest req){
		AppParamModel param = super.getParameter(req);
        JSONObject entity = param.getEntity();
        Integer id = entity.getInteger("msgId");
        if(ObjectUtils.isNullOrEmpty(id)){
        	return encapsulateParam( AppMsgBean.MsgCode.FAILURE, "请求参数有误");
        }
        SystemMessageVO systemMessageVo = null;
        SystemMessageDto systemMessageDto = systemMessageService.loadById(id);
        if(!ObjectUtils.isNullOrEmpty(systemMessageDto)){
        	systemMessageVo = new SystemMessageVO();
			systemMessageVo.setMsgId(systemMessageDto.getId());
			systemMessageVo.setMsgTime(systemMessageDto.getAddTime());
			systemMessageVo.setMsgImage(systemMessageDto.getMessageImage());
			systemMessageVo.setMsgAbstract(systemMessageDto.getMessageIntro());
			systemMessageVo.setMsgContent(systemMessageDto.getMessageContent());
        }
        return super.encapsulateParam(systemMessageVo, AppMsgBean.MsgCode.SUCCESS, "查询消息列表接口成功");
	}
	
}
