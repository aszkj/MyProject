package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.ConsigneeAddress;

/**
 * 功能描述：收货地址数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ConsigneeAddressMapper {
    /**
     * 保存收货地址
     * 
     * @param record
     *            收货地址对象
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_CONSIGNEE_ADDRESS })
    Integer save(ConsigneeAddress record);

    /**
     * 根据Id删除收货地址
     * 
     * @param id
     *            收货地址Id
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_CONSIGNEE_ADDRESS })
    Integer deleteById(Integer id);

    /**
     * 根据Id更新收货地址
     * 
     * @param record
     *            收货地址对象
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_CONSIGNEE_ADDRESS })
    Integer updateByIdSelective(ConsigneeAddress record);

    /**
     * 根据Id更新收货地址 传空值不修改
     * 
     * @param record
     *            收货地址对象
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_CONSIGNEE_ADDRESS })
    Integer updateById(ConsigneeAddress record);

    /**
     * 根据Id查询收货地址
     * 
     * <pre>
     * 注：该方法 使用缓存
     * </pre>
     * 
     * @param id
     *            收货地址ID
     * @param status
     *            收货地址状态
     * @return 收货地址对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CONSIGNEE_ADDRESS })
    ConsigneeAddress loadById(@Param("id") Integer id, @Param("status") String status);

    /**
     * 根据客户Id获取该客户的收货地址列表
     * 
     * <pre>
     * 注：该方法 使用缓存
     * </pre>
     * 
     * @param customerId
     *            客户Id
     * @return 客户收货地址列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CONSIGNEE_ADDRESS })
    List<ConsigneeAddress> listByCustomerId(Integer customerId);

    /**
     * 根据小区ID获取最近修改的收货地址信息
     * 
     * @param communityId
     *            小区ID
     * @param customerId
     *            小区ID
     * @param status
     *            地址状态
     * @return 收货地址信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CONSIGNEE_ADDRESS })
    ConsigneeAddress loadLatelyUpdateByCommunityId(@Param("communityId") Integer communityId,
            @Param("customerId") Integer customerId, @Param("status") String status);

}