package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.SaleProductEvaluationDto;
import com.yilidi.o2o.user.service.dto.StoreEvaluationDto;
import com.yilidi.o2o.user.service.dto.StoreEvaluationScoreDto;
import com.yilidi.o2o.user.service.dto.query.StoreEvaluateQuery;

/**
 * 功能描述：门店评价数据层操作接口服务类 <br/>
 * 作者：llp <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IStoreEvaluationService {

	/**
	 * 保存门店评价
	 * 
	 * @param record
	 *            评价记录
	 * @return
	 * @throws UserServiceException
	 */
	public void save(StoreEvaluationDto record) throws UserServiceException;
	/**
	 * 批量保存门店评价
	 * 
	 * @param record
	 *            评价记录
	 * @return
	 * @throws UserServiceException
	 */
	public void batchSaveStoreProfileDtoTemp(List<StoreEvaluationDto> records) throws UserServiceException;

	/**
	 * 根据ID删门店评论
	 * 
	 * @param id
	 *            绑定的评论ID
	 * @return
	 * @throws UserServiceException
	 */
	public void deleteById(Integer id) throws UserServiceException;

	/**
	 * 根据ID, 修改评论是否显示状态
	 * 
	 * @param id
	 *            绑定的评论ID
	 * @return
	 * @throws UserServiceException
	 */
	public void updateShowStatusById(Integer id, String showStatus) throws UserServiceException;

	/**
	 * 根据Id查询门店评论信息
	 * 
	 * @param id 绑定的评论Id
	 * @return 绑定的门店评论对象
	 * @throws UserServiceException
	 */
	public StoreEvaluationDto loadById(Integer id) throws UserServiceException;

	/**
	 * @Description TODO(通过评论主键id，查询评论的详细信息)
	 * @param id
	 * @return StoreEvaluationDto
	 * @throws UserServiceException
	 */
	public StoreEvaluationDto loadStoreEvaluationDetailById(Integer id) throws UserServiceException;

	/**
	 * 根据门店id查询该门店的所有评论（前端用，暂未考虑分页查询）
	 * 
	 * @param storeId 门店id
	 * @return 门店评价列表
	 * @throws UserServiceException
	 */
	public List<StoreEvaluationDto> listStoreEvaluationByStoreId(Integer storeId) throws UserServiceException;

	/**
	 * 根据查询条件分页查询所有门店的评论明细记录
	 * 
	 * @param query 查询条件对象
	 * @return Page<StoreEvaluationDto>
	 * @throws UserServiceException
	 */
	public YiLiDiPage<StoreEvaluationDto> findStoreEvaluations(StoreEvaluateQuery query) throws UserServiceException;
	
	/**
	 * 查找门店评论导出报表记录
	 * 
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<StoreEvaluationDto>
	 * @throws UserServiceException
	 */
	public List<StoreEvaluationDto> listDataExportStoreEvaluation(StoreEvaluateQuery query,
			Long startLineNum, Integer pageSize) throws UserServiceException;

	/**
	 * @Description TODO(获取报表数据的总记录数)
	 * @param query
	 * @return Long
	 * @throws UserServiceException
	 */
	public Long getCountsForExportStoreEvaluation(StoreEvaluateQuery query) throws UserServiceException;
	/**
	 * 批量保存店铺评论
	 * @param productTempDtoList
	 * @param objs
	 */
	public void saveStoreEvaluationDtoBatch(List<StoreEvaluationDto> productTempDtoList)throws UserServiceException;;
	/**
	 * 
	 * @param records
	 * @return
	 * @throws UserServiceException
	 */
	public boolean checkStoreInfoByStoreCode(String code,String name) throws UserServiceException;
	/**
	 * 根据查询条件分页查询临时表中所有门店的评论明细记录
	 * 
	 * @param query 查询条件对象
	 * @return Page<StoreEvaluationDto>
	 * @throws UserServiceException
	 */
	public YiLiDiPage<StoreEvaluationDto> findStoreEvaluationTemps(StoreEvaluateQuery query) throws UserServiceException;
	/**
	 * 添加临时表的店铺评论到标准库
	 * @param query
	 * @return
	 * @throws UserServiceException
	 */
	public List<String> addAllTempStoreEvaluateToStandard(StoreEvaluateQuery query)throws UserServiceException;
	/**
	 * 清空店铺评论临时表
	 * @throws UserServiceException
	 */
	public void deleteAllStoreEvaluationTemps() throws UserServiceException;
	/**
	 * 获取店铺评分
	 * @param storeId
	 * @return
	 * @throws UserServiceException
	 */
	public Float getAvgStoreScoreByStoreId(Integer storeId) throws UserServiceException;
	/**
	 * 根据查询条件查询临时表中所有门店的评论明细记录(四舍五入，小数点后位数暂定0，店铺初始分5分)
	 * @param query
	 * @return
	 */
    public List<StoreEvaluationScoreDto> listStoreEvaluations(StoreEvaluateQuery query)throws UserServiceException;
    /**
     * 保存APP客户端的评论
     * @param storeEvaluationDto
     * @param saleProductEvaluations
     * @param ifAnonymity
     */
    public void saveForApp(StoreEvaluationDto storeEvaluationDto,
            List<SaleProductEvaluationDto> saleProductEvaluations)throws UserServiceException;

}