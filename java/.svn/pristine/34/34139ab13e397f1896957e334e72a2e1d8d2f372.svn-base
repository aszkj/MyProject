package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.IAreaDictProxyService;
import com.yilidi.o2o.system.proxy.ISystemDictProxyService;
import com.yilidi.o2o.system.proxy.ISystemParamsProxyService;
import com.yilidi.o2o.system.proxy.dto.AreaDictProxyDto;
import com.yilidi.o2o.system.proxy.dto.SystemDictProxyDto;
import com.yilidi.o2o.user.dao.AccountMapper;
import com.yilidi.o2o.user.dao.WithdrawApplyMapper;
import com.yilidi.o2o.user.model.WithdrawApply;
import com.yilidi.o2o.user.model.combination.WithdrawApplyRelatedInfo;
import com.yilidi.o2o.user.service.IAccountService;
import com.yilidi.o2o.user.service.IWithdrawApplyService;
import com.yilidi.o2o.user.service.dto.AccountDto;
import com.yilidi.o2o.user.service.dto.WithdrawApplyDto;
import com.yilidi.o2o.user.service.dto.query.WithdrawApplyQuery;

/**
 * 功能描述：提款申请Service服务实现类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("withdrawApplyService")
public class WithdrawApplyServiceImpl extends BasicDataService implements IWithdrawApplyService {

	@Autowired
	private WithdrawApplyMapper withdrawApplyMapper;

	@Autowired
	private AccountMapper accountMapper;

	@Autowired
	private ISystemParamsProxyService systemParamsProxyService;

	@Autowired
	private IAccountService accountService;
	
	@Autowired
	private IAreaDictProxyService areaDictProxyService;
	
	@Autowired
	private ISystemDictProxyService systemDictProxyService;

	@Override
	public void saveWithdrawApply(WithdrawApplyDto withdrawApplyDto) throws UserServiceException {
		try {
			AccountDto accountDto = accountService.loadByCustomerIdAndAccountTypeCode(withdrawApplyDto.getCustomerId(),
					withdrawApplyDto.getAccountTypeCode());
			// 提交申请的时候，写入到申请记录currentBalance(当前可提现金额)字段
			Long totalWithdrawBalance = new Long(0);
			if (null != withdrawApplyDto.getCustomerId()) {
				// 当前可提现金额=现金账本+优惠补贴+产品差价补贴
				totalWithdrawBalance = accountMapper.countSellerTotalWithdrawBalance(withdrawApplyDto.getCustomerId());
				withdrawApplyDto.setCurrentBalance(totalWithdrawBalance);
			}
			if (totalWithdrawBalance.longValue() < withdrawApplyDto.getAmount().longValue()) {
				logger.error("用户账户可提现金额不足，无法进行提款操作！");
				throw new UserServiceException("用户账户可提现金额不足，无法进行提款操作！");
			}
			WithdrawApply withdrawApply = new WithdrawApply();
			ObjectUtils.fastCopy(withdrawApplyDto, withdrawApply);
			withdrawApply.setCurrentBalance(accountDto.getCurrentBalance());
			withdrawApplyMapper.save(withdrawApply);
			
			/*目前后台未设置限额，进行自动审核功能
			SystemParamsProxyDto systemParamsProxyDto = systemParamsProxyService
					.loadByParamsCode(SystemContext.SystemParams.WITHDRAWAL_AUTOMATIC_AUDIT_LIMIT);
			String paramValue = systemParamsProxyDto.getParamValue();
			if (!StringUtils.isEmpty(paramValue)) {
				Long limitAmount = Long.valueOf(paramValue);
				if (withdrawApplyDto.getAmount().longValue() <= limitAmount) {
					this.updateForAudit(withdrawApply.getApplyId(), SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_PASSED,
							"申请提款金额未超过提款自动审核限额，系统自动审核", -1);
				}
			}*/
		} catch (Exception e) {
			logger.error("saveWithdrawApply异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void updateForAudit(Integer id, String statusCode, String auditNote, Integer auditUserId)
			throws UserServiceException {
		try {
			withdrawApplyMapper.updateForAudit(id, statusCode, auditNote, auditUserId);
			/*提现申请审核，只修改状态，由于门店申请的时候必须满足一定条件才能提现
			WithdrawApply withdrawApply = withdrawApplyMapper.loadById(id);
			if (SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_PASSED.equals(statusCode)) {
				Integer affectedCount = accountService.updateForWithdraw(withdrawApply.getApplyUserId(),
						withdrawApply.getAmount());
				if (affectedCount.intValue() != 1) {
					String msg = "余额账户不足，无法进行提款！";
					logger.error(msg);
					throw new UserServiceException(msg);
				}
				AccountDto accountDto = accountService.loadByCustomerIdAndAccountTypeCode(withdrawApply.getCustomerId(),
						withdrawApply.getAccountTypeCode());
				withdrawApplyMapper.updateCurrentBalance(id, accountDto.getCurrentBalance());
				// 调银行接口，往申请人绑定账户里打款
				withdrawApply.getBindingAccountId();
			}*/
		} catch (Exception e) {
			logger.error("upateForAudit异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void updateForWithdrawTransferStatus(Integer id, String statusCode) throws UserServiceException {
		try {
			withdrawApplyMapper.updateStatus(id, statusCode);
		} catch (Exception e) {
			logger.error("upateForWithdrawStatus异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public WithdrawApplyDto loadById(Integer id) throws UserServiceException {
		try {
			WithdrawApply withdrawApply = withdrawApplyMapper.loadById(id);
			WithdrawApplyDto withdrawApplyDto = null;
			if (null != withdrawApply) {
				withdrawApplyDto = new WithdrawApplyDto();
				ObjectUtils.fastCopy(withdrawApply, withdrawApplyDto);
			}
			return withdrawApplyDto;
		} catch (Exception e) {
			logger.error("loadById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public YiLiDiPage<WithdrawApplyDto> findWithdrawApplies(WithdrawApplyQuery withdrawApplyQuery) throws UserServiceException {
		try {
			if (null == withdrawApplyQuery.getStart() || withdrawApplyQuery.getStart() <= 0) {
				withdrawApplyQuery.setStart(1);
			}
			if (null == withdrawApplyQuery.getPageSize() || withdrawApplyQuery.getPageSize() <= 0) {
				withdrawApplyQuery.setPageSize(CommonConstants.PAGE_SIZE);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getStartApplyTime())) {
				withdrawApplyQuery.setStartApplyTime(withdrawApplyQuery.getStartApplyTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getEndApplyTime())) {
				withdrawApplyQuery.setEndApplyTime(withdrawApplyQuery.getEndApplyTime() + StringUtils.ENDTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getStartAuditTime())) {
				withdrawApplyQuery.setStartAuditTime(withdrawApplyQuery.getStartAuditTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getEndAuditTime())) {
				withdrawApplyQuery.setEndAuditTime(withdrawApplyQuery.getEndAuditTime() + StringUtils.ENDTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getStartTransferTime())) {
				withdrawApplyQuery.setStartTransferTime(withdrawApplyQuery.getStartTransferTime()
						+ StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getEndTransferTime())) {
				withdrawApplyQuery.setEndTransferTime(withdrawApplyQuery.getEndTransferTime() + StringUtils.ENDTIMESTRING);
			}
			if (null != withdrawApplyQuery.getMinAmount()) {
				withdrawApplyQuery.setMinAmount(ArithUtils.convertsToLongNoRound(ArithUtils.mul(
						withdrawApplyQuery.getMinAmount(), StringUtils.BASE_AMOUNT)));
			}
			if (null != withdrawApplyQuery.getMaxAmount()) {
				withdrawApplyQuery.setMaxAmount(ArithUtils.convertsToLongNoRound(ArithUtils.mul(
						withdrawApplyQuery.getMaxAmount(), StringUtils.BASE_AMOUNT)));
			}
			PageHelper.startPage(withdrawApplyQuery.getStart(), withdrawApplyQuery.getPageSize());
			Page<WithdrawApplyRelatedInfo> page = withdrawApplyMapper.findWithdrawApplies(withdrawApplyQuery);
			Page<WithdrawApplyDto> pageDto = new Page<WithdrawApplyDto>(withdrawApplyQuery.getStart(),
					withdrawApplyQuery.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<WithdrawApplyRelatedInfo> withdrawApplyRelatedInfos = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(withdrawApplyRelatedInfos)) {
				for (WithdrawApplyRelatedInfo wari : withdrawApplyRelatedInfos) {
					WithdrawApplyDto withdrawApplyDto = new WithdrawApplyDto();
					ObjectUtils.fastCopy(wari, withdrawApplyDto);
					// 获取市、区县名称
					if (!ObjectUtils.isNullOrEmpty(withdrawApplyDto.getCityCode())) {
						AreaDictProxyDto areaDictProxyDto = areaDictProxyService.loadByAreaCode(withdrawApplyDto
								.getCityCode());
						if (!ObjectUtils.isNullOrEmpty(areaDictProxyDto)) {
							withdrawApplyDto.setCityCode(areaDictProxyDto.getAreaName());
						}
					}
					if (!ObjectUtils.isNullOrEmpty(withdrawApplyDto.getCountyCode())) {
						AreaDictProxyDto areaDictProxyDto = areaDictProxyService.loadByAreaCode(withdrawApplyDto
								.getCountyCode());
						if (!ObjectUtils.isNullOrEmpty(areaDictProxyDto)) {
							withdrawApplyDto.setCountyCode(areaDictProxyDto.getAreaName());
						}
					}
					// 获得提现申请状态名称
					String withdrawStatusName = SystemBasicDataUtils.getSystemDictName(
							SystemContext.UserDomain.DictType.WITHDRAWAPPLYAUDITSTATUS.getValue(),
							withdrawApplyDto.getStatusCode());
					if (!StringUtils.isEmpty(withdrawStatusName)) {
						withdrawApplyDto.setStatusName(withdrawStatusName);
					} else {
						SystemDictProxyDto systemDictProxyDto = systemDictProxyService.loadByDictCode(withdrawApplyDto
								.getStatusCode());
						if (!ObjectUtils.isNullOrEmpty(systemDictProxyDto)) {
							withdrawApplyDto.setStatusName(systemDictProxyDto.getDictName());
						}
					}
					pageDto.add(withdrawApplyDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("findWithdrawApplies异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public WithdrawApplyDto loadWithdrawApplyById(Integer id) throws UserServiceException {
		try {
			WithdrawApplyRelatedInfo withdrawApplyRelatedInfo = withdrawApplyMapper.loadWithdrawApplyById(id);
			WithdrawApplyDto withdrawApplyDto = null;
			if (null != withdrawApplyRelatedInfo) {
				withdrawApplyDto = new WithdrawApplyDto();
				ObjectUtils.fastCopy(withdrawApplyRelatedInfo, withdrawApplyDto);
			}
			return withdrawApplyDto;
		} catch (Exception e) {
			logger.error("loadWithdrawApplyById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Long countSellerWithdrawBalance(WithdrawApplyQuery query) throws UserServiceException {
		try {
			return withdrawApplyMapper.countSellerWithdrawBalance(query);
		} catch (Exception e) {
			logger.error("countSellerWithdrawBalance异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<WithdrawApplyDto> listDataForExportWithdrawApply(WithdrawApplyQuery withdrawApplyQuery, Long startLineNum,
			Integer pageSize) throws UserServiceException {
		try {
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getStartApplyTime())) {
				withdrawApplyQuery.setStartApplyTime(withdrawApplyQuery.getStartApplyTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getEndApplyTime())) {
				withdrawApplyQuery.setEndApplyTime(withdrawApplyQuery.getEndApplyTime() + StringUtils.ENDTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getStartAuditTime())) {
				withdrawApplyQuery.setStartAuditTime(withdrawApplyQuery.getStartAuditTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getEndAuditTime())) {
				withdrawApplyQuery.setEndAuditTime(withdrawApplyQuery.getEndAuditTime() + StringUtils.ENDTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getStartTransferTime())) {
				withdrawApplyQuery.setStartTransferTime(withdrawApplyQuery.getStartTransferTime()
						+ StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getEndTransferTime())) {
				withdrawApplyQuery.setEndTransferTime(withdrawApplyQuery.getEndTransferTime() + StringUtils.ENDTIMESTRING);
			}
			if (null != withdrawApplyQuery.getMinAmount()) {
				withdrawApplyQuery.setMinAmount(ArithUtils.convertsToLongNoRound(ArithUtils.mul(
						withdrawApplyQuery.getMinAmount(), StringUtils.BASE_AMOUNT)));
			}
			if (null != withdrawApplyQuery.getMaxAmount()) {
				withdrawApplyQuery.setMaxAmount(ArithUtils.convertsToLongNoRound(ArithUtils.mul(
						withdrawApplyQuery.getMaxAmount(), StringUtils.BASE_AMOUNT)));
			}
			List<WithdrawApplyRelatedInfo> withdrawApplyRelatedInfos = withdrawApplyMapper.listDataForExportWithdrawApply(
					withdrawApplyQuery, startLineNum, pageSize);
			List<WithdrawApplyDto> withdrawApplyDtos = new ArrayList<WithdrawApplyDto>();
			if (!ObjectUtils.isNullOrEmpty(withdrawApplyRelatedInfos)) {
				for (WithdrawApplyRelatedInfo wf : withdrawApplyRelatedInfos) {
					WithdrawApplyDto withdrawApplyDto = new WithdrawApplyDto();
					ObjectUtils.fastCopy(wf, withdrawApplyDto);
					// 获取市、区县名称
					if (!ObjectUtils.isNullOrEmpty(withdrawApplyDto.getCityCode())) {
						AreaDictProxyDto areaDictProxyDto = areaDictProxyService.loadByAreaCode(withdrawApplyDto
								.getCityCode());
						if (!ObjectUtils.isNullOrEmpty(areaDictProxyDto)) {
							withdrawApplyDto.setCityCode(areaDictProxyDto.getAreaName());
						}
					}
					if (!ObjectUtils.isNullOrEmpty(withdrawApplyDto.getCountyCode())) {
						AreaDictProxyDto areaDictProxyDto = areaDictProxyService.loadByAreaCode(withdrawApplyDto
								.getCountyCode());
						if (!ObjectUtils.isNullOrEmpty(areaDictProxyDto)) {
							withdrawApplyDto.setCountyCode(areaDictProxyDto.getAreaName());
						}
					}
					withdrawApplyDtos.add(withdrawApplyDto);
				}
			}
			return withdrawApplyDtos;
		} catch (Exception e) {
			logger.error("listDataForExportWithdrawApply异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Long getCountsForExportWithdrawApply(WithdrawApplyQuery withdrawApplyQuery) throws UserServiceException {
		try {
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getStartApplyTime())) {
				withdrawApplyQuery.setStartApplyTime(withdrawApplyQuery.getStartApplyTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getEndApplyTime())) {
				withdrawApplyQuery.setEndApplyTime(withdrawApplyQuery.getEndApplyTime() + StringUtils.ENDTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getStartAuditTime())) {
				withdrawApplyQuery.setStartAuditTime(withdrawApplyQuery.getStartAuditTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getEndAuditTime())) {
				withdrawApplyQuery.setEndAuditTime(withdrawApplyQuery.getEndAuditTime() + StringUtils.ENDTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getStartTransferTime())) {
				withdrawApplyQuery.setStartTransferTime(withdrawApplyQuery.getStartTransferTime()
						+ StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(withdrawApplyQuery.getEndTransferTime())) {
				withdrawApplyQuery.setEndTransferTime(withdrawApplyQuery.getEndTransferTime() + StringUtils.ENDTIMESTRING);
			}
			if (null != withdrawApplyQuery.getMinAmount()) {
				withdrawApplyQuery.setMinAmount(ArithUtils.convertsToLongNoRound(ArithUtils.mul(
						withdrawApplyQuery.getMinAmount(), StringUtils.BASE_AMOUNT)));
			}
			if (null != withdrawApplyQuery.getMaxAmount()) {
				withdrawApplyQuery.setMaxAmount(ArithUtils.convertsToLongNoRound(ArithUtils.mul(
						withdrawApplyQuery.getMaxAmount(), StringUtils.BASE_AMOUNT)));
			}
			return withdrawApplyMapper.getCountsForExportWithdrawApply(withdrawApplyQuery);
		} catch (Exception e) {
			logger.error("getCountsForExportWithdrawApply异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
}
