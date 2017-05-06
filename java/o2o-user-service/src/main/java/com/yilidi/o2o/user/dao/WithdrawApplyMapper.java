package com.yilidi.o2o.user.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.user.model.WithdrawApply;
import com.yilidi.o2o.user.model.combination.WithdrawApplyRelatedInfo;
import com.yilidi.o2o.user.service.dto.query.WithdrawApplyQuery;

/**
 * 功能描述：取款申请数据层操作接口类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface WithdrawApplyMapper {

	/**
	 * 保存提款申请记录
	 * 
	 * @param record
	 *            提款申请记录
	 * @return 影响行数
	 */
	Integer save(WithdrawApply record);

	/**
	 * 根据ID更新审核 (转账申请，进行审核：通过与不通过)
	 * 
	 * @param id
	 *            申请Id
	 * @param statusCode
	 *            审核状态编码：未审核，审核通过，审核不通过，提现成功
	 * @param auditNote
	 *            审核意见
	 * @param auditUserId
	 *            审核用户Id
	 * @return 影响行数
	 */
	Integer updateForAudit(@Param("id") Integer id, @Param("statusCode") String statusCode,
			@Param("auditNote") String auditNote, @Param("auditUserId") Integer auditUserId);

	/**
	 * 根据Id更新提款的最终交易状态 (提现审核通过后，进行转账，成功后修改提现状态)
	 * 
	 * @param id
	 *            申请Id
	 * @param statusCode
	 *            状态编码：提现成功
	 * @return 影响行数
	 */
	Integer updateStatus(@Param("id") Integer id, @Param("statusCode") String statusCode);

	/**
	 * 根据Id更新提款的当前余额
	 * 
	 * @param id 申请Id
	 * @param currentBalance 当前余额
	 * @return 影响行数
	 */
	Integer updateCurrentBalance(@Param("id") Integer id, @Param("currentBalance") Long currentBalance);

	/**
	 * 根据Id查询提款申请记录
	 * 
	 * @param id 提款申请Id
	 * @return 提款申请记录
	 */
	WithdrawApply loadById(Integer id);
	
	/**
	 * 根据Id查询提款申请记录的详细信息
	 * 
	 * @param id 提款申请Id
	 * @return 提款申请记录详细信息
	 */
	WithdrawApplyRelatedInfo loadWithdrawApplyById(Integer id);
	
	/**
	 * 统计门店（卖家）申请提现中的总金额
	 * 统计每个门店(卖家)的提现总金额（分状态查询统计：未审核，审核不通过，审核通过和提现成功）
	 * 提现中：未审核和审核通过的提现申请，但还未提现以及不包括审核失败
	 * @param query
	 * @return Long
	 */
	Long countSellerWithdrawBalance(WithdrawApplyQuery query);
	
	/**
	 * 根据查询条件分页查询提款申请记录
	 * 
	 * @param query 查询条件对象
	 * @return Page<WithdrawApplyRelatedInfo>
	 */
	Page<WithdrawApplyRelatedInfo> findWithdrawApplies(WithdrawApplyQuery query);
	
	/**
	 * @Description TODO(分页获取导出用户提现记录报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<WithdrawApplyRelatedInfo>
	 * 报表导出不使用缓存
	 */
	List<WithdrawApplyRelatedInfo> listDataForExportWithdrawApply(@Param("withdrawApplyQuery") WithdrawApplyQuery query,
			@Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

	/**
	 * @Description TODO(获取报表数据的总记录数)
	 * @param query
	 * @return Long
	 * 报表导出不适用缓存
	 */
	Long getCountsForExportWithdrawApply(WithdrawApplyQuery query);
}