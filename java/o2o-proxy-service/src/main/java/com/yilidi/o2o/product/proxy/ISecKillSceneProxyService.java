package com.yilidi.o2o.product.proxy;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.proxy.dto.SecKillSceneProxyDto;

/**
 * 功能描述：秒杀场次代理服务接口类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISecKillSceneProxyService {

    /**
     * 获取已开始的场次和正在疯抢中的场次
     * 
     * @param nowTime
     *            当前时间
     * @return 秒杀场次列表
     * @throws ProductServiceException
     *             产品服务异常
     */
    List<SecKillSceneProxyDto> listStartedAndStaring(Date nowTime) throws ProductServiceException;
}