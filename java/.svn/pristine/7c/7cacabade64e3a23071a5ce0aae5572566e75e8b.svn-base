package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.SmallTableUserInfo;

/**
 * 用户信息小表Mapper
 * 
 * @author: chenlian
 * @date: 2016年8月11日 下午5:38:33
 */
public interface SmallTableUserInfoMapper {

    /**
     * 保存用户信息小表
     * 
     * @param smallTableUserInfo
     *            用户信息小表
     * @return 影响行数
     */
    Integer save(SmallTableUserInfo smallTableUserInfo);

    /**
     * 根据用户ID更新用户信息小表
     * 
     * @param smallTableUserInfo
     *            用户信息小表
     * @return 影响行数
     */
    Integer updateByUserId(SmallTableUserInfo smallTableUserInfo);

    /**
     * 根据用户ID获取用户信息小表
     * 
     * @param userId
     *            用户ID
     * @return SmallTableUserInfo
     */
    SmallTableUserInfo loadByUserId(@Param("userId") Integer userId);

    /**
     * 根据用户ID获取用户信息小表列表（当存在一个客户对应多个用户时就会返回列表）
     * 
     * @param customerId
     *            客户ID
     * @return List<SmallTableUserInfo>
     */
    List<SmallTableUserInfo> listByCustomerId(@Param("customerId") Integer customerId);

}
