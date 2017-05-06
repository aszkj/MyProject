package com.yilidi.o2o.system.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.dao.SiteMessagePublishedMapper;
import com.yilidi.o2o.system.model.combination.SiteMessagePublishedRelationInfo;
import com.yilidi.o2o.system.service.ISiteMessagePublishedService;
import com.yilidi.o2o.system.service.dto.SiteMessagePublishedDto;
import com.yilidi.o2o.system.service.dto.query.SiteMessagePublishedQuery;

/**
 * 已发布消息
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午11:57:58
 * 
 */
@Service("siteMessagePublishedService")
public class SiteMessagePublishedServiceImpl extends SystemBaseService implements ISiteMessagePublishedService {

    @Autowired
    private SiteMessagePublishedMapper siteMessagePublishedMapper;

    @Override
    public YiLiDiPage<SiteMessagePublishedDto> listSiteMessagePublishedRelationInfo(
            SiteMessagePublishedQuery siteMessagePublishedQuery) {
        try {
            if (null == siteMessagePublishedQuery.getStart() || siteMessagePublishedQuery.getStart() <= 0) {
                siteMessagePublishedQuery.setStart(1);
            }
            if (null == siteMessagePublishedQuery.getPageSize() || siteMessagePublishedQuery.getPageSize() <= 0) {
                siteMessagePublishedQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(siteMessagePublishedQuery.getStart(), siteMessagePublishedQuery.getPageSize());
            Page<SiteMessagePublishedRelationInfo> page = siteMessagePublishedMapper
                    .listSiteMessagePublishedRelationInfo(siteMessagePublishedQuery);
            Page<SiteMessagePublishedDto> pageDto = new Page<SiteMessagePublishedDto>(siteMessagePublishedQuery.getStart(),
                    siteMessagePublishedQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<SiteMessagePublishedRelationInfo> messageInfoList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(messageInfoList)) {
                for (int i = 0, size = messageInfoList.size(); i < size; i++) {
                    SiteMessagePublishedRelationInfo messageInfo = messageInfoList.get(i);
                    SiteMessagePublishedDto siteMessagePublishedDto = new SiteMessagePublishedDto();
                    ObjectUtils.fastCopy(messageInfo, siteMessagePublishedDto);
                    pageDto.add(siteMessagePublishedDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("listSiteMessagePublishedRelationInfo异常", e);
            throw new SystemServiceException(e.getMessage());
        }
    }

}
