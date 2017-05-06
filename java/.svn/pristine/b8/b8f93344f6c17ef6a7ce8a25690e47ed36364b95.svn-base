package com.yilidi.o2o.system.service;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.system.service.dto.SiteMessagePublishedDto;
import com.yilidi.o2o.system.service.dto.query.SiteMessagePublishedQuery;

/**
 * 已发布的系统消息
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:17:57
 * 
 */
public interface ISiteMessagePublishedService {

    /**
     * 查询已发布消息
     * 
     * @param siteMessagePublishedQuery
     *            查询实体类
     * @return YiLiDiPage<SiteMessagePublishedDto>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SITE_MESSAGE_PUBLISHED,
            DBTablesName.System.S_SITE_MESSAGE })
    YiLiDiPage<SiteMessagePublishedDto> listSiteMessagePublishedRelationInfo(SiteMessagePublishedQuery siteMessagePublishedQuery);
}
