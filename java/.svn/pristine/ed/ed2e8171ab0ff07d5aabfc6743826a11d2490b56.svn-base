package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.SaleProductEvaluationDto;
import com.yilidi.o2o.user.service.dto.query.SaleProductEvaluateQuery;

/**
 * Service
 * 
 * @Description:TODO(商品评价数据层操作接口服务类)
 * @author: llp
 * @date: 2015年12月7日 下午2:01:47
 */
public interface ISaleProductEvaluationService {

	/**
	 * @Description TODO(保存运营系统生成的商品评价)
	 * @param record
	 * @throws UserServiceException
	 */
	public void save(SaleProductEvaluationDto record) throws UserServiceException;
	
	/**
	 * @Description TODO(保存App端商品评价)
	 * @param record
	 * @throws UserServiceException
	 */
	public void saveForApp(SaleProductEvaluationDto saleProductEvaluationDto);
	/**
	 * @Description TODO(根据ID删商品评论)
	 * @param id
	 * @throws UserServiceException
	 */
	public void deleteById(Integer id) throws UserServiceException;

	/**
	 * 根据ID, 修改评论是否显示状态
	 * 
	 * @param id 绑定的评论ID
	 * @return
	 * @throws UserServiceException
	 */
	public void updateShowStatusById(Integer id, String showStatus) throws UserServiceException;
	
	/**
	 * @Description TODO(根据Id查询商品评论信息)
	 * @param id
	 * @return SaleProductEvaluationDto
	 * @throws UserServiceException
	 */
	public SaleProductEvaluationDto loadById(Integer id) throws UserServiceException;

	/**
	 * @Description TODO(通过评论主键id，查询评论的详细信息)
	 * @param id
	 * @return SaleProductEvaluationDto
	 * @throws UserServiceException
	 */
	public SaleProductEvaluationDto loadSaleProductEvaluationDetailById(Integer id) throws UserServiceException;

	/**
	 * @Description TODO(根据商品id查询该商品的所有评论（前端用，暂未考虑分页查询）)
	 * @param saleProductId
	 * @return list
	 * @throws UserServiceException
	 */
	public List<SaleProductEvaluationDto> listSaleProductEvaluationBysaleProductId(Integer saleProductId)
			throws UserServiceException;

	/**
	 * @Description TODO(根据查询条件分页查询所有商品的评论明细记录)
	 * @param query
	 * @return page
	 * @throws UserServiceException
	 */
	public YiLiDiPage<SaleProductEvaluationDto> findSaleProductEvaluations(SaleProductEvaluateQuery query) throws UserServiceException;

	/**
	 * 查找产品评论导出报表记录
	 * 
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<SaleProductEvaluationDto>
	 * @throws UserServiceException
	 */
	public List<SaleProductEvaluationDto> listDataExportSaleProductEvaluation(SaleProductEvaluateQuery query,
			Long startLineNum, Integer pageSize) throws UserServiceException;

	/**
	 * @Description TODO(获取报表数据的总记录数)
	 * @param query
	 * @return Long
	 * @throws UserServiceException
	 */
	public Long getCountsForExportSaleProductEvaluation(SaleProductEvaluateQuery query) throws UserServiceException;
	/**
	 * 根据查询条件分页查询所有商品的临时评论明细记录
	 * @param query
	 * @return
	 * @throws UserServiceException
	 */
	public YiLiDiPage<SaleProductEvaluationDto> findSaleProductEvaluationsTemps(SaleProductEvaluateQuery query) throws UserServiceException;
	/**
	 * 清空全部临时商品评论库信息
	 */
	public void deleteAllSaleProductEvaluationTemps()throws UserServiceException;
	/**
	 * 批量保存临时商品评论
	 * @param saleProductEvaluationDtoList
	 * @throws UserServiceException
	 */
	public void saveSaleProductEvaluationDtosBatch(List<SaleProductEvaluationDto> saleProductEvaluationDtoList)throws UserServiceException;
	/**
	 * 批量保存产品评价到临时表
	 * 
	 * @param record
	 *            评价记录
	 * @return
	 * @throws UserServiceException
	 */
	void batchSaveSaleProductEvaluationTemp(List<SaleProductEvaluationDto> records) throws UserServiceException;
	/**
	 * 将所有临时商品评论添加到正式库
	 * @param query
	 * @return
	 * @throws UserServiceException
	 */
	public List<String> addAllTempSaleProductEvaluateToStandard(SaleProductEvaluateQuery query) throws UserServiceException;


}