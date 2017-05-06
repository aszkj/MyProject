package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.CommunityDto;
import com.yilidi.o2o.user.service.dto.CommunityStoreRelatedDto;
import com.yilidi.o2o.user.service.dto.SimpleCommunityDto;
import com.yilidi.o2o.user.service.dto.query.CommunityQuery;
import com.yilidi.o2o.user.service.dto.query.CommunityStoreRelatedQuery;

/**
 * 功能描述：Community服务层接口 <br/>
 * 作者： bincun <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ICommunityService {

    /**
     * 查看小区列表
     * 
     * @param communityName
     *            小区名称
     * @return CustomerDto
     * @throws UserServiceException
     *             服务端异常
     */
    public List<CommunityDto> listCommunityByName(String communityName) throws UserServiceException;

    /**
     * 添加小区
     * 
     * @param communityDto
     * @throws UserServiceException
     */
    public void save(CommunityDto communityDto) throws UserServiceException;

    /**
     * 修改小区
     * 
     * @param accountDto
     * @throws UserServiceException
     */
    public void update(CommunityDto communityDto) throws UserServiceException;

    /**
     * 根据ID查询
     * 
     * @param id
     *            查询条件
     * @return CommunityDto
     */
    public CommunityDto loadById(Integer id) throws UserServiceException;

    /**
     * 
     * 查询分页列表
     * 
     * @param communityQuery
     *            查询条件
     * @return YiLiDiPage
     * @throws UserServiceException
     *             用户域服务异常
     */
    public YiLiDiPage<CommunityDto> findCommunitys(CommunityQuery communityQuery) throws UserServiceException;

    /**
     * 查询门店管理列表
     * 
     * @param query
     *            查询条件
     * @return YiLiDiPage
     * @throws UserServiceException
     *             用户域服务异常
     */
    public YiLiDiPage<CommunityStoreRelatedDto> findCommunityStores(CommunityStoreRelatedQuery query)
            throws UserServiceException;

    /**
     * 查询小区门店列表
     * 
     * @param query
     *            查询条件
     * @return YiLiDiPage
     * @throws UserServiceException
     *             用户域服务异常
     */
    public YiLiDiPage<CommunityStoreRelatedDto> findCommunityStoresByCommunityId(CommunityStoreRelatedQuery query)
            throws UserServiceException;

    /**
     * 根据 门店ID,小区ID, 删除小区门店关系
     * 
     * @param storeId
     *            门店ID
     * @param communityId
     *            小区ID
     * @return Boolean
     * @throws UserServiceException
     *             用户域服务异常
     */
    public Boolean cancelRelatedById(Integer storeId, Integer communityId) throws UserServiceException;

    /**
     * 
     * 门店导出的总记录数
     * 
     * @param communityStoreRelatedQuery
     *            查询条件
     * @return Long
     * @throws UserServiceException
     *             用户域服务异常
     */
    public Long getCountsForExportStore(CommunityStoreRelatedQuery communityStoreRelatedQuery) throws UserServiceException;

    /**
     * 
     * @Description TODO(分页获取报表数据)
     * @param communityStoreRelatedQuery
     *            门店查询实体
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            分页大小
     * @return List<CommunityStoreRelatedDto>
     * 
     * @throws UserServiceException
     *             用户域服务异常
     */
    public List<CommunityStoreRelatedDto> listDataForExportStore(CommunityStoreRelatedQuery communityStoreRelatedQuery,
            Long startLineNum, Integer pageSize) throws UserServiceException;

    /**
     * 
     * 查询小区列表->APP
     * 
     * @param communityQuery
     *            查询条件
     * @return YiLiDiPage
     * @throws UserServiceException
     *             用户域服务异常
     */
    public YiLiDiPage<CommunityDto> listCommunitys(CommunityQuery communityQuery) throws UserServiceException;

    /**
     * 
     * 根据经度和纬度获取定位
     * 
     * @param longitude
     *            经度
     * @param latitude
     *            纬度
     * @param distance
     *            距离范围
     * @throws UserServiceException
     *             用户域异常
     * @return CommunityDto
     */
    public CommunityDto getLocation(String longitude, String latitude, Integer distance) throws UserServiceException;

    /**
     * 
     * 根据经度和纬度定位到附近小区列表
     * 
     * @param communityQuery
     *            查询条件
     * @param longitude
     *            经度
     * @param latitude
     *            纬度
     * @throws UserServiceException
     *             用户域异常
     * @return CommunityLocationInfo
     */
    public YiLiDiPage<CommunityDto> findAroundCommunityList(CommunityQuery communityQuery, String longitude, String latitude)
            throws UserServiceException;

    /**
     * 
     * 根据经度和纬度定位到指定距离范围内小区列表
     * 
     * @param distance
     *            指定距离
     * @param longitude
     *            经度
     * @param latitude
     *            纬度
     * @throws UserServiceException
     *             用户域异常
     * @return List<CommunityDto>
     */
    public List<CommunityDto> listAroundCommunities(Integer distance, String longitude, String latitude)
            throws UserServiceException;

    /**
     * 根据商家ID获取其关联的小区列表信息
     * 
     * @param storeId
     * @return List<SimpleCommunityDto>
     * @throws UserServiceException
     */
    public List<SimpleCommunityDto> listSimpleCommunityInfoByStoreId(Integer storeId) throws UserServiceException;

    /**
     * 保存商家与小区的关联关系
     * 
     * @param storeId
     * @param communityIds
     * @throws UserServiceException
     */
    public void saveStoreCommunityRelations(Integer storeId, String communityIds) throws UserServiceException;

    /**
     * 根据区县编码获取该区县范围内的小区列表
     * 
     * @param countyCode
     * @return List<CommunityDto>
     * @throws UserServiceException
     */
    public List<CommunityDto> listCommunitiesByCountyCode(String countyCode) throws UserServiceException;
    /**
     * 根据产品id和店铺相关信息查询门店
     * @param query
     * @return
     * @throws UserServiceException
     */
	public YiLiDiPage<CommunityStoreRelatedDto> findCommunityStoresByProductId(CommunityStoreRelatedQuery query)throws UserServiceException;

}
