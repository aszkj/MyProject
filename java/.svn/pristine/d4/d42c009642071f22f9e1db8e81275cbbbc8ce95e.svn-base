package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.WithdrawApplyDto;
import com.yilidi.o2o.user.service.dto.query.WithdrawApplyQuery;

/**
 * 功能描述：WithdrawApply服务层接口 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IWithdrawApplyService {

	/**
	 * 新增提款申请
	 * 
	 * @param withdrawApplyDto
	 * @throws UserServiceException
	 */
	public void saveWithdrawApply(WithdrawApplyDto withdrawApplyDto) throws UserServiceException;

	/**
	 * 更新提款申请（审核更新）
	 * 
	 * @param id
	 * @param statusCode
	 * @param auditNote
	 * @param auditUserId
	 * @throws UserServiceException
	 */
	public void updateForAudit(Integer id, String statusCode, String auditNote, Integer auditUserId)
			throws UserServiceException;
	
	/**
	 * 更新提现转账成功状态（提现转账成功，更新状态）
	 * @param id
	 * @param statusCode
	 * @throws UserServiceException
	 */
	public void updateForWithdrawTransferStatus(Integer id, String statusCode) throws UserServiceException;

	/**
	 * 根据申请ID获取提款申请纪录
	 * 
	 * @param id
	 * @return WithdrawApplyDto
	 * @throws UserServiceException
	 */
	public WithdrawApplyDto loadById(Integer id) throws UserServiceException;
	
	/**
	 * 统计门店（卖家）申请提现中的总金额
	 * 统计每个门店(卖家)的提现总金额（分状态查询统计：未审核，审核不通过，审核通过和提现成功）
	 * 提现中：未审核和审核通过的提现申请，但还未提现以及不包括审核失败
	 * @param query
	 * @return
	 */
	public Long countSellerWithdrawBalance(WithdrawApplyQuery query) throws UserServiceException;
	
	/**
	 * @Description  TODO(根据申请ID查询申请记录的详细信息)
	 * @param id
	 * @return
	 * @throws UserServiceException
	 */
	public WithdrawApplyDto loadWithdrawApplyById(Integer id) throws UserServiceException;

	/**
	 * 根据查询条件分页查询提款申请纪录信息
	 * 
	 * @param withdrawApplyQuery
	 * @return Page<WithdrawApplyDto> YiLiDiPage 分页数据
	 * @throws UserServiceException
	 */
	public YiLiDiPage<WithdrawApplyDto> findWithdrawApplies(WithdrawApplyQuery withdrawApplyQuery) throws UserServiceException;

	/**
	 * @Description TODO(分页获取导出用户提现记录报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<UserDto>
	 * @throws UserServiceException
	 */
	public List<WithdrawApplyDto> listDataForExportWithdrawApply(WithdrawApplyQuery withdrawApplyQuery, Long startLineNum,
			Integer pageSize) throws UserServiceException;

	/**
	 * @Description TODO(获取报表数据的总记录数)
	 * @param query
	 * @return Long
	 * @throws UserServiceException
	 */
	public Long getCountsForExportWithdrawApply(WithdrawApplyQuery query) throws UserServiceException;

}
