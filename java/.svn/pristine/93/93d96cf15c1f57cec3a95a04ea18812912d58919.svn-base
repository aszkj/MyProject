package com.yilidi.o2o.system.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ImageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.proxy.dto.ThemeProxyDto;
import com.yilidi.o2o.product.proxy.IThemeProxyService;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.dao.SystemMessageMapper;
import com.yilidi.o2o.system.model.SystemMessage;
import com.yilidi.o2o.system.model.query.SystemMessageQuery;
import com.yilidi.o2o.system.service.ISystemDictService;
import com.yilidi.o2o.system.service.ISystemMessageService;
import com.yilidi.o2o.system.service.dto.SystemDictDto;
import com.yilidi.o2o.system.service.dto.SystemMessageDto;
import com.yilidi.o2o.system.service.dto.query.SystemMessageQueryDto;
import com.yilidi.o2o.user.proxy.IStoreProfileProxyService;
import com.yilidi.o2o.user.proxy.IUserProxyService;
import com.yilidi.o2o.user.proxy.dto.StoreProfileProxyDto;
import com.yilidi.o2o.user.proxy.dto.UserProxyDto;

@Service("systemMessageService")
public class SystemMessageServiceImpl extends BasicDataService implements ISystemMessageService {

	@Autowired
	private SystemMessageMapper systemMessageMapper;
	@Autowired
	private IThemeProxyService themeProxyService; 
	@Autowired
	private IUserProxyService userProxyService;
	@Autowired
	private IStoreProfileProxyService storeProfileProxyService;
	@Autowired
	private ISystemDictService systemDictService;
	
	
	@Override
	public SystemMessageDto loadById(Integer id) {
		SystemMessageDto systemMessageDto = null; 
		SystemMessage systemMessage = systemMessageMapper.loadById(id);
		if(!ObjectUtils.isNullOrEmpty(systemMessage)){
			systemMessageDto = new SystemMessageDto();
			ObjectUtils.fastCopy(systemMessage, systemMessageDto);
		}
		return systemMessageDto;
	}
	
	@Override
	public int addSystemMessage(SystemMessageDto systemMessageDto) throws SystemServiceException{
		SystemMessage systemMessage = new SystemMessage();
		ObjectUtils.fastCopy(systemMessageDto, systemMessage);
		systemMessage.setAddTime(new Date());
		int num = systemMessageMapper.saveSelective(systemMessage);
		if(num > 0){
			if(!StringUtils.isEmpty(systemMessageDto.getDelImageUrl())){
				ImageUtils.operateImage(systemMessageDto.getImageFlag(), systemMessageDto.getDelImageUrl(),
						systemMessageDto.getMessageImage());
			}
		}
		return num;
	}

	@Override
	public int updateSystemMessage(SystemMessageDto systemMessageDto) throws SystemServiceException{
		SystemMessage systemMessage = new SystemMessage();
		ObjectUtils.fastCopy(systemMessageDto, systemMessage);
		systemMessage.setCheckTime(new Date());
		systemMessage.setCheckStatus(SystemContext.SystemDomain.MESSAGECHECKSTATUS_AWAIT);
		int num = systemMessageMapper.updateByIdSelective(systemMessage);
		if(num > 0){
			if(!StringUtils.isEmpty(systemMessageDto.getDelImageUrl())){
				ImageUtils.operateImage(systemMessageDto.getImageFlag(), systemMessageDto.getDelImageUrl(),
						systemMessageDto.getMessageImage());
			}
		}
		return num;
	}

	@Override
	public SystemMessageDto getSystemMessageById(Integer id) throws SystemServiceException{
		SystemMessageDto systemMessageDto = this.loadById(id);
		if(!ObjectUtils.isNullOrEmpty(systemMessageDto)){
			if(!StringUtils.isEmpty(systemMessageDto.getPublishObjectValue())){
				String publishObjectValueNames = "";
				String[] publishObjectValues = systemMessageDto.getPublishObjectValue().split(",");
				for (String publishObjectValue : publishObjectValues) {
					if(systemMessageDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_SPECIAL)){
						UserProxyDto userProxyDto = userProxyService.getUserById(Integer.parseInt(publishObjectValue));
						publishObjectValueNames += userProxyDto.getUserName() + ",";
					}
					if(systemMessageDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_SELLER_SPECIAL)){
						 StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(Integer.parseInt(publishObjectValue));
						 publishObjectValueNames += storeProfileProxyDto.getStoreName()+ ",";
					}
				}
				publishObjectValueNames = publishObjectValueNames.substring(0,publishObjectValueNames.length()-1);
				systemMessageDto.setPublishObjectValueNames(publishObjectValueNames);
			}
			
			//判断跳转类型
			if(!StringUtils.isEmpty(systemMessageDto.getSkipObject())){
				if(systemMessageDto.getSkipType().equals(SystemContext.SystemDomain.MESSAGESKIPTYPE_THEME)){
					ThemeProxyDto themeProxyDto = themeProxyService.loadByTypeCode(systemMessageDto.getSkipObject());
					if(!ObjectUtils.isNullOrEmpty(themeProxyDto)){
						systemMessageDto.setSkipObjectName(themeProxyDto.getThemeName());
					}
				}else{
					systemMessageDto.setSkipObjectName(systemMessageDto.getSkipObject());
				}
			}
		}
		return systemMessageDto;
	}

	@Override
	public YiLiDiPage<SystemMessageDto> getSystemMessageList(SystemMessageQueryDto systemMessageQueryDto) {
		SystemMessageQuery systemMessageQuery = new SystemMessageQuery();
		ObjectUtils.fastCopy(systemMessageQueryDto, systemMessageQuery);
		if (null == systemMessageQuery.getStart() || systemMessageQuery.getStart() <= 0) {
			systemMessageQuery.setStart(1);
		}
		if (null == systemMessageQuery.getPageSize() || systemMessageQuery.getPageSize() <= 0) {
			systemMessageQuery.setPageSize(CommonConstants.PAGE_SIZE);
		}
		PageHelper.startPage(systemMessageQuery.getStart(), systemMessageQuery.getPageSize());
		Page<SystemMessage> page = systemMessageMapper.findList(systemMessageQuery);
		Page<SystemMessageDto> pageDto = new Page<SystemMessageDto>(systemMessageQuery.getStart(),
				systemMessageQuery.getPageSize());
		ObjectUtils.fastCopy(page, pageDto);
		List<SystemMessage> systemMessageList = page.getResult();
		if(!ObjectUtils.isNullOrEmpty(systemMessageList)){
			SystemMessageDto systemMessageDto = null;
			for (SystemMessage systemMessage : systemMessageList) {
				systemMessageDto = new SystemMessageDto();
				ObjectUtils.fastCopy(systemMessage, systemMessageDto);
				systemMessageDto.setMessageTypeName(
						super.getSystemDictName(SystemContext.SystemDomain.DictType.SYSTEMMESSAGETYPE.getValue(),
							systemMessageDto.getMessageType()));
				systemMessageDto.setPublishObjectName(
						super.getSystemDictName(SystemContext.SystemDomain.DictType.MESSAGEPUBLISHOBJECT.getValue(),
								systemMessageDto.getPublishObject()));
				systemMessageDto.setCheckStatusName(
						super.getSystemDictName(SystemContext.SystemDomain.DictType.MESSAGECHECKSTATUS.getValue(),
								systemMessageDto.getCheckStatus()));
				pageDto.add(systemMessageDto);
				
			}
		}
		return YiLiDiPageUtils.encapsulatePageResult(pageDto);
	}

	@Override
	public int updateCheckStatus(SystemMessageDto systemMessageDto) {
		SystemMessage systemMessage = new SystemMessage();
		ObjectUtils.fastCopy(systemMessageDto, systemMessage);
		systemMessage.setCheckTime(new Date());
		if(systemMessage.getCheckStatus().equals(SystemContext.SystemDomain.MESSAGECHECKSTATUS_OK)){
			systemMessage.setCheckReason("本次消息已通过审核！");
		}
		return systemMessageMapper.updateByIdSelective(systemMessage);
	}

	@Override
	public List<SystemDictDto> getMessageModule(Date createTime) {
		List<SystemDictDto> messageTyepList = new ArrayList<SystemDictDto>();
		SystemMessage newMessage = null;
		SystemMessageDto systemMessageDto = null;
		//获取用户消息类型
		List<SystemDictDto> userMessageTypeList = systemDictService.listAllValidDictByDictType(SystemContext.SystemDomain.DictType.USERMESSAGETYPE.getValue());
		for (SystemDictDto systemDictDto : userMessageTypeList) {
			//根据消息类型获取最新一条消息
			newMessage = systemMessageMapper.findNewMessageByMessageType(systemDictDto.getDictCode(),createTime);
			if(!ObjectUtils.isNullOrEmpty(newMessage)){
				systemMessageDto = new SystemMessageDto();
				ObjectUtils.fastCopy(newMessage, systemMessageDto);
				systemDictDto.setNewMessage(systemMessageDto);
			}
			messageTyepList.add(systemDictDto);
		}
		//获取系统消息类型
		List<SystemDictDto> systemMessageTypeList = systemDictService.listAllValidDictByDictType(SystemContext.SystemDomain.DictType.SYSTEMMESSAGETYPE.getValue());
		for (SystemDictDto systemDictDto : systemMessageTypeList) {
			//根据消息类型获取最新一条消息
			newMessage = systemMessageMapper.findNewMessageByMessageType(systemDictDto.getDictCode(),createTime);
			if(!ObjectUtils.isNullOrEmpty(newMessage)){
				systemMessageDto = new SystemMessageDto();
				ObjectUtils.fastCopy(newMessage, systemMessageDto);
				systemDictDto.setNewMessage(systemMessageDto);
			}
			messageTyepList.add(systemDictDto);
		}
		return messageTyepList;
	}

	@Override
	public YiLiDiPage<SystemMessageDto> getAppSystemMessageList(SystemMessageQueryDto systemMessageQueryDto,
			Integer userId) {
		SystemMessageQuery systemMessageQuery = new SystemMessageQuery();
        ObjectUtils.fastCopy(systemMessageQueryDto, systemMessageQuery);
		if (null == systemMessageQuery.getStart() || systemMessageQuery.getStart() <= 0) {
			systemMessageQuery.setStart(1);
        }
        if (null == systemMessageQuery.getPageSize() || systemMessageQuery.getPageSize() <= 0) {
        	systemMessageQuery.setPageSize(CommonConstants.PAGE_SIZE);
        }
        PageHelper.startPage(systemMessageQuery.getStart(), systemMessageQuery.getPageSize());
		Page<SystemMessage> page = systemMessageMapper.findAppSystemMessageList(systemMessageQuery);
		Page<SystemMessageDto> pageDto = new Page<SystemMessageDto>(systemMessageQuery.getStart(), systemMessageQuery.getPageSize());		
		ObjectUtils.fastCopy(page, pageDto);
		SystemMessageDto systemMessageDto = null;
		List<SystemMessage> systemMessageList = page.getResult();
		if(!ObjectUtils.isNullOrEmpty(systemMessageList)){
			for (SystemMessage systemMessage : systemMessageList) {
				boolean flag = false; //标识是否是此用户的消息
				if(systemMessage.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_ALL)){
					flag = true;
				}else if(systemMessage.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_ALL)){
					flag = true;
				}else if(systemMessage.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_SPECIAL)){
					String[] publishObjectValues = systemMessage.getPublishObjectValue().split(","); 
					if(!ObjectUtils.isNullOrEmpty(publishObjectValues)){
						for (String publishObjectValue : publishObjectValues) {
							if(userId == Integer.parseInt(publishObjectValue)){
								flag = true;
								break;
							}
						}
					}
				}
				if(flag){
					systemMessageDto = new SystemMessageDto();
					ObjectUtils.fastCopy(systemMessage, systemMessageDto);
					pageDto.add(systemMessageDto);
				}
			}
		}
		return YiLiDiPageUtils.encapsulatePageResult(pageDto);
	}
	
	
}
