package com.yilidi.o2o.system.service.impl;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.alibaba.druid.util.StringUtils;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.dao.ExceptionMessageInfoMapper;
import com.yilidi.o2o.system.dao.ExceptionMessageManualHandlingMapper;
import com.yilidi.o2o.system.jms.sender.IBaseSender;
import com.yilidi.o2o.system.model.ExceptionMessageInfo;
import com.yilidi.o2o.system.model.ExceptionMessageManualHandling;
import com.yilidi.o2o.system.service.IExceptionMessageOperationService;
import com.yilidi.o2o.system.service.dto.ExceptionMessageInfoDto;
import com.yilidi.o2o.system.service.dto.ExceptionMessageManualHandlingDto;
import com.yilidi.o2o.system.service.dto.query.ExceptionMessageManualHandlingQuery;

/**
 * 消息服务接口实现类
 * 
 * @author chenl
 * 
 */
@Service("exceptionMessageOperationService")
public class ExceptionMessageOperationServiceImpl extends BaseService implements IExceptionMessageOperationService {

    @Autowired
    private ExceptionMessageInfoMapper exceptionMessageInfoMapper;

    @Autowired
    private ExceptionMessageManualHandlingMapper exceptionMessageManualHandlingMapper;

    @Override
    public ExceptionMessageInfoDto loadExceptionMessageInfo(String exceptionJmsMessageId) throws SystemServiceException {
        try {
            ExceptionMessageInfo exceptionMessageInfo = exceptionMessageInfoMapper
                    .loadByExceptionJmsMessageId(exceptionJmsMessageId);
            ExceptionMessageInfoDto exceptionMessageInfoDto = null;
            if (null != exceptionMessageInfo) {
                exceptionMessageInfoDto = new ExceptionMessageInfoDto();
                ObjectUtils.fastCopy(exceptionMessageInfo, exceptionMessageInfoDto);
            }
            return exceptionMessageInfoDto;
        } catch (Exception e) {
            logger.error("loadExceptionMessageInfo异常", e);
            throw new SystemServiceException(e.getMessage(), e);
        }
    }

    @Override
    public void updateRetryCountByExceptionJmsMessageId(String exceptionJmsMessageId) throws SystemServiceException {
        try {
            exceptionMessageInfoMapper.updateRetryCountByExceptionJmsMessageId(exceptionJmsMessageId);
        } catch (Exception e) {
            logger.error("updateRetryCountByExceptionJmsMessageId异常", e);
            throw new SystemServiceException(e.getMessage(), e);
        }
    }

    @Override
    public void deleteExceptionMessageInfo(String exceptionJmsMessageId) throws SystemServiceException {
        try {
            exceptionMessageInfoMapper.deleteByExceptionJmsMessageId(exceptionJmsMessageId);
        } catch (Exception e) {
            logger.error("deleteExceptionMessageInfo异常", e);
            throw new SystemServiceException(e.getMessage(), e);
        }
    }

    @Override
    public ExceptionMessageManualHandlingDto loadExceptionMessageManualHandling(Integer exceptionMessageManualHandlingId)
            throws SystemServiceException {
        try {
            ExceptionMessageManualHandling exceptionMessageManualHandling = exceptionMessageManualHandlingMapper
                    .loadById(exceptionMessageManualHandlingId);
            ExceptionMessageManualHandlingDto exceptionMessageManualHandlingDto = null;
            if (null != exceptionMessageManualHandling) {
                exceptionMessageManualHandlingDto = new ExceptionMessageManualHandlingDto();
                ObjectUtils.fastCopy(exceptionMessageManualHandling, exceptionMessageManualHandlingDto);
            }
            return exceptionMessageManualHandlingDto;
        } catch (Exception e) {
            logger.error("loadExceptionMessageManualHandling异常", e);
            throw new SystemServiceException(e.getMessage(), e);
        }
    }

    @Override
    public void deleteExceptionMessageManualHandling(Integer exceptionMessageManualHandlingId) throws SystemServiceException {
        try {
            exceptionMessageManualHandlingMapper.deleteById(exceptionMessageManualHandlingId);
        } catch (Exception e) {
            logger.error("deleteExceptionMessageManualHandling异常", e);
            throw new SystemServiceException(e.getMessage(), e);
        }
    }

    @Override
    public void saveExceptionMessageInfo(ExceptionMessageInfoDto exceptionMessageInfoDto) throws SystemServiceException {
        try {
            ExceptionMessageInfo exceptionMessageInfo = new ExceptionMessageInfo();
            ObjectUtils.fastCopy(exceptionMessageInfoDto, exceptionMessageInfo);
            exceptionMessageInfoMapper.save(exceptionMessageInfo);
        } catch (Exception e) {
            logger.error("saveExceptionMessageInfo异常", e);
            throw new SystemServiceException(e.getMessage(), e);
        }
    }

    @Override
    public void saveExceptionMessageManualHandling(ExceptionMessageManualHandlingDto exceptionMessageManualHandlingDto)
            throws SystemServiceException {
        try {
            ExceptionMessageManualHandling exceptionMessageManualHandling = new ExceptionMessageManualHandling();
            ObjectUtils.fastCopy(exceptionMessageManualHandlingDto, exceptionMessageManualHandling);
            exceptionMessageManualHandlingMapper.save(exceptionMessageManualHandling);
        } catch (Exception e) {
            logger.error("saveExceptionMessageManualHandling异常", e);
            throw new SystemServiceException(e.getMessage(), e);
        }
    }

    @Override
    public void saveExceptionMessageManualHandlingFromExceptionMessageInfo(String exceptionJmsMessageId)
            throws SystemServiceException {
        try {
            if (!StringUtils.isEmpty(exceptionJmsMessageId)) {
                ExceptionMessageInfo emi = exceptionMessageInfoMapper.loadByExceptionJmsMessageId(exceptionJmsMessageId);
                if (null != emi) {
                    ExceptionMessageManualHandling emmh = new ExceptionMessageManualHandling();
                    emmh.setMessageName(emi.getMessageName());
                    emmh.setProducerClassName(emi.getProducerClassName());
                    emmh.setParameterClassName(emi.getParameterClassName());
                    emmh.setParameterJsonString(emi.getParameterJsonString());
                    exceptionMessageManualHandlingMapper.save(emmh);
                    exceptionMessageInfoMapper.deleteByExceptionJmsMessageId(exceptionJmsMessageId);
                }
            }
        } catch (Exception e) {
            logger.error("saveExceptionMessageManualHandlingFromExceptionMessageInfo异常", e);
            throw new SystemServiceException(e.getMessage(), e);
        }
    }

    @Override
    public List<ExceptionMessageInfoDto> listNeedScheduledHandleExceptionMessages() throws SystemServiceException {
        try {
            List<ExceptionMessageInfo> exceptionMessageInfos = exceptionMessageInfoMapper
                    .listNeedScheduledHandleExceptionMessages();
            List<ExceptionMessageInfoDto> exceptionMessageInfoDtos = new ArrayList<ExceptionMessageInfoDto>();
            if (!ObjectUtils.isNullOrEmpty(exceptionMessageInfos)) {
                for (ExceptionMessageInfo emi : exceptionMessageInfos) {
                    ExceptionMessageInfoDto emiDto = new ExceptionMessageInfoDto();
                    ObjectUtils.fastCopy(emi, emiDto);
                    exceptionMessageInfoDtos.add(emiDto);
                }
            }
            return exceptionMessageInfoDtos;
        } catch (Exception e) {
            logger.error("listNeedScheduledHandleExceptionMessages异常", e);
            throw new SystemServiceException(e.getMessage(), e);
        }
    }

    @Override
    public Page<ExceptionMessageManualHandlingDto> findExceptionMessageManualHandlings(
            ExceptionMessageManualHandlingQuery query) throws SystemServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());
            Page<ExceptionMessageManualHandling> page = exceptionMessageManualHandlingMapper
                    .findExceptionMessageManualHandlings(query);
            Page<ExceptionMessageManualHandlingDto> pageDto = new Page<ExceptionMessageManualHandlingDto>(query.getStart(),
                    query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<ExceptionMessageManualHandling> exceptionMessageManualHandlings = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(exceptionMessageManualHandlings)) {
                for (ExceptionMessageManualHandling emmh : exceptionMessageManualHandlings) {
                    ExceptionMessageManualHandlingDto emmhDto = new ExceptionMessageManualHandlingDto();
                    ObjectUtils.fastCopy(emmh, emmhDto);
                    pageDto.add(emmhDto);
                }
            }
            return pageDto;
        } catch (Exception e) {
            logger.error("findExceptionMessageManualHandlings异常", e);
            throw new SystemServiceException(e.getMessage(), e);
        }
    }

    @Override
    public void sendMessageForScheduled(String exceptionJmsMessageId) throws MessageException {
        try {
            ExceptionMessageInfo exceptionMessageInfo = exceptionMessageInfoMapper
                    .loadByExceptionJmsMessageId(exceptionJmsMessageId);
            if (null != exceptionMessageInfo) {
                WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
                IBaseSender bs = (IBaseSender) wac.getBean(Class.forName(exceptionMessageInfo.getProducerClassName()));
                Object obj = JsonUtils.parseObject(exceptionMessageInfo.getParameterJsonString(),
                        Class.forName(exceptionMessageInfo.getParameterClassName()));
                bs.sendMessage((JmsMessageModel) obj);
            }
        } catch (Exception e) {
            logger.error(e);
        }
    }

    @Override
    public void sendMessageForManual(Integer exceptionMessageManualHandlingId) throws MessageException {
        try {
            ExceptionMessageManualHandling exceptionMessageManualHandling = exceptionMessageManualHandlingMapper
                    .loadById(exceptionMessageManualHandlingId);
            if (null != exceptionMessageManualHandling) {
                WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
                IBaseSender bs = (IBaseSender) wac.getBean(Class.forName(exceptionMessageManualHandling
                        .getProducerClassName()));
                Class<?> sourceClass = Class.forName(exceptionMessageManualHandling.getParameterClassName());
                Object obj = JsonUtils.parseObject(exceptionMessageManualHandling.getParameterJsonString(),
                        Class.forName(exceptionMessageManualHandling.getParameterClassName()));
                Method[] methodArray = sourceClass.getMethods();
                if (!ObjectUtils.isNullOrEmpty(methodArray)) {
                    for (Method method : methodArray) {
                        if ("setExceptionMessageManualHandlingId".equals(method.getName())) {
                            method.invoke(obj, new Object[] { exceptionMessageManualHandlingId });
                        }
                    }
                }
                bs.sendMessage((JmsMessageModel) obj);
            }
        } catch (Exception e) {
            logger.error(e);
        }
    }

}
