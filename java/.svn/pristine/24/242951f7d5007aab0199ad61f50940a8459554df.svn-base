package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.Date;
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
import com.yilidi.o2o.system.proxy.IMessageProxyService;
import com.yilidi.o2o.system.proxy.ISystemDictProxyService;
import com.yilidi.o2o.system.proxy.dto.SystemDictProxyDto;
import com.yilidi.o2o.user.dao.AccountDetailMapper;
import com.yilidi.o2o.user.dao.AccountMapper;
import com.yilidi.o2o.user.dao.OnlinePayDetailMapper;
import com.yilidi.o2o.user.dao.WithdrawApplyMapper;
import com.yilidi.o2o.user.model.Account;
import com.yilidi.o2o.user.model.AccountDetail;
import com.yilidi.o2o.user.model.combination.AccountDetailCountInfo;
import com.yilidi.o2o.user.model.combination.AccountDetailRelatedInfo;
import com.yilidi.o2o.user.model.combination.AccountRelatedInfo;
import com.yilidi.o2o.user.model.combination.OnlinePayDetailRelatedInfo;
import com.yilidi.o2o.user.service.IAccountService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.AccountDetailCountDto;
import com.yilidi.o2o.user.service.dto.AccountDetailDto;
import com.yilidi.o2o.user.service.dto.AccountDto;
import com.yilidi.o2o.user.service.dto.AccountTypeInfoDto;
import com.yilidi.o2o.user.service.dto.OnlinePayDetailDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.query.AccountDetailQuery;
import com.yilidi.o2o.user.service.dto.query.CustomerBalanceQuery;
import com.yilidi.o2o.user.service.dto.query.WithdrawApplyQuery;

/**
 * 功能描述：账户Service服务实现类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("accountService")
public class AccountServiceImpl extends BasicDataService implements IAccountService {

	@Autowired
	private AccountMapper accountMapper;

	@Autowired
	private AccountDetailMapper accountDetailMapper;

	@Autowired
	private IUserService userService;

	@Autowired
	private WithdrawApplyMapper withdrawApplyMapper;

	@Autowired
	private OnlinePayDetailMapper onlinePayDetailMapper;
	
	@Autowired
	private ISystemDictProxyService systemDictProxyService;
	
    @Autowired
    private IMessageProxyService messageProxyService;
	
	@Override
	public void save(AccountDto accountDto) throws UserServiceException {
		try {
			Account account = new Account();
			ObjectUtils.fastCopy(accountDto, account);
			this.accountMapper.save(account);
		} catch (Exception e) {
			logger.error("save异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public AccountDto loadById(Integer id) throws UserServiceException {
		try {
			Account account = accountMapper.loadById(id);
			AccountDto accountDto = null;
			if (null != account) {
				accountDto = new AccountDto();
				ObjectUtils.fastCopy(account, accountDto);
			}
			return accountDto;
		} catch (Exception e) {
			logger.error("loadById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public AccountDto loadByCustomerIdAndAccountTypeCode(Integer customerId, String accountTypeCode)
			throws UserServiceException {
		try {
			Account account = accountMapper.loadByCustomerIdAndAccountTypeCode(customerId, accountTypeCode);
			AccountDto accountDto = null;
			if (null != account) {
				accountDto = new AccountDto();
				ObjectUtils.fastCopy(account, accountDto);
			}
			return accountDto;
		} catch (Exception e) {
			logger.error("loadByCustomerIdAndAccountTypeCode异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<AccountDto> listByCustomerId(Integer customerId) throws UserServiceException {
		try {
			List<Account> accounts = accountMapper.listByCustomerId(customerId);
			List<AccountDto> accountDtos = null;
			if (!ObjectUtils.isNullOrEmpty(accounts)) {
				accountDtos = new ArrayList<AccountDto>();
				for (Account account : accounts) {
					AccountDto accountDto = new AccountDto();
					ObjectUtils.fastCopy(account, accountDto);
					accountDtos.add(accountDto);
				}
			}
			return accountDtos;
		} catch (Exception e) {
			logger.error("listByCustomerId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public YiLiDiPage<AccountDto> findAccountsForCustomerBalance(CustomerBalanceQuery customerBalanceQuery)
			throws UserServiceException {
		try {
			if (null == customerBalanceQuery.getStart() || customerBalanceQuery.getStart() <= 0) {
				customerBalanceQuery.setStart(1);
			}
			if (null == customerBalanceQuery.getPageSize() || customerBalanceQuery.getPageSize() <= 0) {
				customerBalanceQuery.setPageSize(CommonConstants.PAGE_SIZE);
			}
			PageHelper.startPage(customerBalanceQuery.getStart(), customerBalanceQuery.getPageSize());
			Page<AccountRelatedInfo> page = accountMapper.findAccountsForCustomerBalance(customerBalanceQuery);
			Page<AccountDto> pageDto = new Page<AccountDto>(customerBalanceQuery.getStart(),
					customerBalanceQuery.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<AccountRelatedInfo> accountRelatedInfos = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(accountRelatedInfos)) {
				for (AccountRelatedInfo bari : accountRelatedInfos) {
					AccountDto accountDto = new AccountDto();
					accountDto.setAccountId(bari.getAccountId());
					accountDto.setCustomerId(bari.getCustomerId());
					accountDto.setCurrentBalance(bari.getCurrentBalance()); //用户当前可用账户余额
					
					AccountDetailQuery accountDetailQuery = new AccountDetailQuery();
					accountDetailQuery.setUserId(bari.getCustomerId());
					// 订单已支付总金额
					accountDetailQuery.setChangeType(SystemContext.UserDomain.ACCOUNTCHANGETYPE_PAY);
					double payAmount = ArithUtils.convertLongTodouble(accountDetailMapper
							.countsAccountDetailsAmount(accountDetailQuery));
					// 订单退款总金额
					accountDetailQuery.setChangeType(SystemContext.UserDomain.ACCOUNTCHANGETYPE_REFUND);
					double refundAmount = ArithUtils.convertLongTodouble(accountDetailMapper
							.countsAccountDetailsAmount(accountDetailQuery));
					// 用户当前已使用账户余额：订单已支付总金额-订单退款总金额
					accountDto.setUsedAccountTotalAmount(ArithUtils.convertsToLongNoRound(ArithUtils.sub(payAmount,
							refundAmount)));
					
					accountDto.setCustomerType(bari.getCustomerType());
					accountDto.setAccountTypeCode(bari.getAccountTypeCode());
					accountDto.setUserName(bari.getUserName());
					accountDto.setTelPhone(bari.getTelPhone());
					pageDto.add(accountDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("FindAccountsForCustomerBalance异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	private void accountBalancePlus(Integer userId, Long amount, String changeType, String serialNo)
			throws UserServiceException {
		try {
			UserDto userDto = userService.loadUserById(userId);
			if (null != userDto && null != userDto.getCustomerId()) {
				Account account = accountMapper.loadByCustomerIdAndAccountTypeCode(userDto.getCustomerId(),
						AccountTypeInfoDto.Type.YE);
				if (null != account) {
					accountMapper.updateBalanceIncreaseById(account.getAccountId(), userId, amount);
					AccountDetail accountDetail = new AccountDetail();
					accountDetail.setSerialNo(serialNo);
					//accountDetail.setAccountId(account.getAccountId());
					accountDetail.setUserId(userId);
					//accountDetail.setAccountTypeCode(AccountTypeInfoDto.Type.YE);
					accountDetail.setDetailType(SystemContext.UserDomain.ACCOUNTDETAILTYPE_IN);
					// Account ac = accountMapper.loadById(account.getAccountId());
					/*
					 * if (null != ac) { accountDetail.setCurrentBalance(ac.getCurrentBalance()); }
					 * accountDetail.setSpend(amount);
					 */
					accountDetail.setCreateTime(new Date());
					accountDetail.setChangeType(changeType);
					accountDetailMapper.save(accountDetail);
				}
			}
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	private Integer accountBalanceMinus(Integer userId, Long amount, String changeType, String serialNo)
			throws UserServiceException {
		try {
			Integer affectedCount = 0;
			UserDto userDto = userService.loadUserById(userId);
			if (null != userDto && null != userDto.getCustomerId()) {
				Account account = accountMapper.loadByCustomerIdAndAccountTypeCode(userDto.getCustomerId(),
						AccountTypeInfoDto.Type.YE);
				if (null != account) {
					affectedCount = accountMapper.updateBalanceDecreaseById(account.getAccountId(), userId, amount);
					if (affectedCount == 1) {
						AccountDetail accountDetail = new AccountDetail();
						accountDetail.setSerialNo(serialNo);
						//accountDetail.setAccountId(account.getAccountId());
						accountDetail.setUserId(userId);
						//accountDetail.setAccountTypeCode(AccountTypeInfoDto.Type.YE);
						accountDetail.setDetailType(SystemContext.UserDomain.ACCOUNTDETAILTYPE_OUT);
						// Account ac = accountMapper.loadById(account.getAccountId());
						/*
						 * if (null != ac) { accountDetail.setCurrentBalance(ac.getCurrentBalance()); }
						 * accountDetail.setSpend(amount);
						 */
						accountDetail.setCreateTime(new Date());
						accountDetail.setChangeType(changeType);
						accountDetailMapper.save(accountDetail);
					}
				}
			}
			return affectedCount;
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void updateForRecharge(Integer userId, Long rechargeAmount) throws UserServiceException {
		try {
			this.accountBalancePlus(userId, rechargeAmount, SystemContext.UserDomain.ACCOUNTCHANGETYPE_CHARGE, null);
		} catch (Exception e) {
			logger.error("updateForRecharge异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Integer updateForWithdraw(Integer userId, Long withdrawAmount) throws UserServiceException {
		try {
			return this.accountBalanceMinus(userId, withdrawAmount, SystemContext.UserDomain.ACCOUNTCHANGETYPE_WITHDRAW,
					null);
		} catch (Exception e) {
			logger.error("updateForWithdraw异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Integer updateForPayOrder(Integer userId, Long payOrderAmount, String orderNo) throws UserServiceException {
		try {
			return this.accountBalanceMinus(userId, payOrderAmount, SystemContext.UserDomain.ACCOUNTCHANGETYPE_PAY, orderNo);
		} catch (Exception e) {
			logger.error("updateForPayOrder异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void updateForRefund(Integer userId, Long refundAmount, String orderNo) throws UserServiceException {
		try {
			this.accountBalancePlus(userId, refundAmount, SystemContext.UserDomain.ACCOUNTCHANGETYPE_REFUND, orderNo);
		} catch (Exception e) {
			logger.error("updateForRefund异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void updateForAdjustBalancePlus(Integer userId, Long adjustAmount) throws UserServiceException {
		try {
			this.accountBalancePlus(userId, adjustAmount, SystemContext.UserDomain.ACCOUNTCHANGETYPE_ADJUST_BALANCE, null);
		} catch (Exception e) {
			logger.error("updateForAdjustBalancePlus异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Integer updateForAdjustBalanceMinus(Integer userId, Long adjustAmount) throws UserServiceException {
		try {
			return this.accountBalanceMinus(userId, adjustAmount, SystemContext.UserDomain.ACCOUNTCHANGETYPE_ADJUST_BALANCE,
					null);
		} catch (Exception e) {
			logger.error("updateForAdjustBalanceMinus异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Integer updateForConsumeDeposit(Integer userId, Long amount) throws UserServiceException {
		try {
			Integer affectedCount = 0;
			UserDto userDto = userService.loadUserById(userId);
			if (null != userDto && null != userDto.getCustomerId()) {
				Account account = accountMapper.loadByCustomerIdAndAccountTypeCode(userDto.getCustomerId(),
						AccountTypeInfoDto.Type.YE);
				// 赔付保证金，只用从冻结资金里面扣除该次保证金需赔付的金额即可，与余额账户没关系，因此无需记录账户流水信息
				if (null != account) {
					affectedCount = accountMapper.updateForConsumeDeposit(account.getAccountId(), userId, amount);
				}
			}
			return affectedCount;
		} catch (Exception e) {
			logger.error("updateForConsumeDeposit异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Integer updateForFreeze(Integer userId, Long amount) throws UserServiceException {
		try {
			Integer affectedCount = 0;
			UserDto userDto = userService.loadUserById(userId);
			if (null != userDto && null != userDto.getCustomerId()) {
				Account account = accountMapper.loadByCustomerIdAndAccountTypeCode(userDto.getCustomerId(),
						AccountTypeInfoDto.Type.YE);
				if (null != account) {
					affectedCount = accountMapper.updateFreezeById(account.getAccountId(), userId, amount);
					if (affectedCount == 1) {
						AccountDetail accountDetail = new AccountDetail();
						//accountDetail.setAccountId(account.getAccountId());
						accountDetail.setUserId(userId);
						//accountDetail.setAccountTypeCode(AccountTypeInfoDto.Type.YE);
						accountDetail.setDetailType(SystemContext.UserDomain.ACCOUNTDETAILTYPE_OUT);
						// Account ac = accountMapper.loadById(account.getAccountId());
						/*
						 * if (null != ac) { accountDetail.setCurrentBalance(ac.getCurrentBalance()); }
						 * accountDetail.setSpend(amount);
						 */
						accountDetail.setCreateTime(new Date());
						accountDetail.setChangeType(SystemContext.UserDomain.ACCOUNTCHANGETYPE_FREEZE_FUND);
						accountDetailMapper.save(accountDetail);
					}
				}
			}
			return affectedCount;
		} catch (Exception e) {
			logger.error("updateForFreeze异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Integer updateForUnfreezePartFrozenFund(Integer userId, Long amount) throws UserServiceException {
		try {
			Integer affectedCount = 0;
			UserDto userDto = userService.loadUserById(userId);
			if (null != userDto && null != userDto.getCustomerId()) {
				Account account = accountMapper.loadByCustomerIdAndAccountTypeCode(userDto.getCustomerId(),
						AccountTypeInfoDto.Type.YE);
				if (null != account) {
					affectedCount = accountMapper.updateUnFreezePartById(account.getAccountId(), userId, amount);
					if (affectedCount == 1) {
						AccountDetail accountDetail = new AccountDetail();
						//accountDetail.setAccountId(account.getAccountId());
						accountDetail.setUserId(userId);
						//accountDetail.setAccountTypeCode(AccountTypeInfoDto.Type.YE);
						accountDetail.setDetailType(SystemContext.UserDomain.ACCOUNTDETAILTYPE_IN);
						// Account ac = accountMapper.loadById(account.getAccountId());
						/*
						 * if (null != ac) { accountDetail.setCurrentBalance(ac.getCurrentBalance()); }
						 * accountDetail.setSpend(amount);
						 */
						accountDetail.setCreateTime(new Date());
						accountDetail.setChangeType(SystemContext.UserDomain.ACCOUNTCHANGETYPE_UNFREEZE_FROZEN_FUND);
						accountDetailMapper.save(accountDetail);
					}
				}
			}
			return affectedCount;
		} catch (Exception e) {
			logger.error("updateForUnfreezePartFrozenFund异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void updateForUnfreezeAllFrozenFund(Integer userId) throws UserServiceException {
		try {
			UserDto userDto = userService.loadUserById(userId);
			if (null != userDto && null != userDto.getCustomerId()) {
				Account account = accountMapper.loadByCustomerIdAndAccountTypeCode(userDto.getCustomerId(),
						AccountTypeInfoDto.Type.YE);
				if (null != account) {
					// Long freezeAmount = account.getFreezeAmount();
					accountMapper.updateUnFreezeAllById(account.getAccountId(), userId);
					AccountDetail accountDetail = new AccountDetail();
					//accountDetail.setAccountId(account.getAccountId());
					accountDetail.setUserId(userId);
					//accountDetail.setAccountTypeCode(AccountTypeInfoDto.Type.YE);
					accountDetail.setDetailType(SystemContext.UserDomain.ACCOUNTDETAILTYPE_IN);
					// Account ac = accountMapper.loadById(account.getAccountId());
					/*
					 * if (null != ac) { accountDetail.setCurrentBalance(ac.getCurrentBalance()); }
					 * accountDetail.setSpend(freezeAmount);
					 */
					accountDetail.setCreateTime(new Date());
					accountDetail.setChangeType(SystemContext.UserDomain.ACCOUNTCHANGETYPE_UNFREEZE_FROZEN_FUND);
					accountDetailMapper.save(accountDetail);
				}
			}
		} catch (Exception e) {
			logger.error("updateForUnfreezeAllFrozenFund异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public YiLiDiPage<AccountDetailDto> findAccountDetails(AccountDetailQuery accountDetailQuery) throws UserServiceException {
		try {
			if (null == accountDetailQuery.getStart() || accountDetailQuery.getStart() <= 0) {
				accountDetailQuery.setStart(1);
			}
			if (null == accountDetailQuery.getPageSize() || accountDetailQuery.getPageSize() <= 0) {
				accountDetailQuery.setPageSize(CommonConstants.PAGE_SIZE);
			}
			if (StringUtils.isNotEmpty(accountDetailQuery.getStartCreateTime())) {
				accountDetailQuery.setStartCreateTime(accountDetailQuery.getStartCreateTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(accountDetailQuery.getEndCreateTime())) {
				accountDetailQuery.setEndCreateTime(accountDetailQuery.getEndCreateTime() + StringUtils.ENDTIMESTRING);
			}
			PageHelper.startPage(accountDetailQuery.getStart(), accountDetailQuery.getPageSize());
			Page<AccountDetailRelatedInfo> page = accountDetailMapper.findAccountDetails(accountDetailQuery);
			Page<AccountDetailDto> pageDto = new Page<AccountDetailDto>(accountDetailQuery.getStart(),
					accountDetailQuery.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<AccountDetailRelatedInfo> accountDetailRelatedInfos = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(accountDetailRelatedInfos)) {
				for (AccountDetailRelatedInfo adri : accountDetailRelatedInfos) {
					AccountDetailDto accountDetailDto = new AccountDetailDto();
					ObjectUtils.fastCopy(adri, accountDetailDto);
					// 获得账本资金变动类型名称
					String changeTypeName = SystemBasicDataUtils
							.getSystemDictName(SystemContext.UserDomain.DictType.ACCOUNTCHANGETYPE.getValue(),
									accountDetailDto.getChangeType());
					if (!StringUtils.isEmpty(changeTypeName)) {
						accountDetailDto.setChangeTypeName(changeTypeName);
					} else {
						SystemDictProxyDto systemDictProxyDto = systemDictProxyService.loadByDictCode(accountDetailDto
								.getChangeType());
						if (!ObjectUtils.isNullOrEmpty(systemDictProxyDto)) {
							accountDetailDto.setChangeTypeName(systemDictProxyDto.getDictName());
						}
					}
					pageDto.add(accountDetailDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("findAccountDetails异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public AccountDetailDto loadAccountDetailByDetailId(Integer id) throws UserServiceException {
		try {
			AccountDetail accountDetail = accountDetailMapper.loadById(id);
			AccountDetailDto accountDetailDto = null;
			if (null != accountDetail) {
				accountDetailDto = new AccountDetailDto();
				ObjectUtils.fastCopy(accountDetail, accountDetailDto);
			}
			return accountDetailDto;
		} catch (Exception e) {
			logger.error("loadAccountDetailByDetailId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Long countSellerTotalSubsidyBalance(Integer customerId) throws UserServiceException {
		try {
			return accountMapper.countSellerTotalSubsidyBalance(customerId);
		} catch (Exception e) {
			logger.error("countSellerTotalSubsidyBalance异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Long countSellerTotalWithdrawBalance(Integer customerId) {
		try {
			return accountMapper.countSellerTotalWithdrawBalance(customerId);
		} catch (Exception e) {
			logger.error("countSellerTotalWithdrawBalance异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public YiLiDiPage<AccountDto> findCountSellerAccountsBalance(CustomerBalanceQuery customerBalanceQuery)
			throws UserServiceException {
		try {
			if (null == customerBalanceQuery.getStart() || customerBalanceQuery.getStart() <= 0) {
				customerBalanceQuery.setStart(1);
			}
			if (null == customerBalanceQuery.getPageSize() || customerBalanceQuery.getPageSize() <= 0) {
				customerBalanceQuery.setPageSize(CommonConstants.PAGE_SIZE);
			}
			PageHelper.startPage(customerBalanceQuery.getStart(), customerBalanceQuery.getPageSize());
			Page<AccountRelatedInfo> page = accountMapper.findCountSellerAccountsBalance(customerBalanceQuery);
			Page<AccountDto> pageDto = new Page<AccountDto>(customerBalanceQuery.getStart(),
					customerBalanceQuery.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<AccountRelatedInfo> accountRelatedInfos = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(accountRelatedInfos)) {
				for (AccountRelatedInfo bari : accountRelatedInfos) {
					AccountDto accountDto = new AccountDto();
					accountDto.setAccountId(bari.getAccountId());
					accountDto.setCustomerId(bari.getCustomerId());
					accountDto.setStoreCode(bari.getStoreCode());
					accountDto.setStoreName(bari.getStoreName());
					// 统计每个门店的账户当前余额总计
					accountDto.setTotalAccount(bari.getTotalAccount());
					// 统计每个门店用户的各种账本金额(现金账本+优惠券补贴+商品差价补贴+物流补贴)
					accountDto.setCashAccount(bari.getCashAccount());
					accountDto.setProdcutAccount(bari.getProdcutAccount());
					accountDto.setCouponAccount(bari.getCouponAccount());
					accountDto.setLogisticsAccount(bari.getLogisticsAccount());
					accountDto.setCustomerType(bari.getCustomerType());
					pageDto.add(accountDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("findAccountsForCustomerBalance异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<AccountDto> listDataForExportSellerAccount(CustomerBalanceQuery query, Long startLineNum, Integer pageSize)
			throws UserServiceException {
		try {
			List<AccountRelatedInfo> accountRelatedInfos = accountMapper.listDataForExportSellerAccount(query, startLineNum,
					pageSize);
			List<AccountDto> accountDtos = new ArrayList<AccountDto>();
			if (!ObjectUtils.isNullOrEmpty(accountRelatedInfos)) {
				for (AccountRelatedInfo arf : accountRelatedInfos) {
					AccountDto accountDto = new AccountDto();
					ObjectUtils.fastCopy(arf, accountDto);
					accountDtos.add(accountDto);
				}
			}
			return accountDtos;
		} catch (Exception e) {
			logger.error("listDataForExportSellerAccount异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Long getCountsForExportSellerAccount(CustomerBalanceQuery query) throws UserServiceException {
		try {
			return accountMapper.getCountsForExportSellerAccount(query);
		} catch (Exception e) {
			logger.error("getCountsForExportSellerAccount异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<AccountDetailDto> listDataForExportAccountDetails(AccountDetailQuery accountDetailQuery, Long startLineNum,
			Integer pageSize) throws UserServiceException {
		try {
			if (StringUtils.isNotEmpty(accountDetailQuery.getStartCreateTime())) {
				accountDetailQuery.setStartCreateTime(accountDetailQuery.getStartCreateTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(accountDetailQuery.getEndCreateTime())) {
				accountDetailQuery.setEndCreateTime(accountDetailQuery.getEndCreateTime() + StringUtils.ENDTIMESTRING);
			}
			List<AccountDetailRelatedInfo> accountDetailRelatedInfos = accountDetailMapper.listDataForExportAccountDetails(
					accountDetailQuery, startLineNum, pageSize);
			List<AccountDetailDto> accountDetailDtos = new ArrayList<AccountDetailDto>();
			if (!ObjectUtils.isNullOrEmpty(accountDetailRelatedInfos)) {
				for (AccountDetailRelatedInfo adri : accountDetailRelatedInfos) {
					AccountDetailDto accountDetailDto = new AccountDetailDto();
					ObjectUtils.fastCopy(adri, accountDetailDto);
					accountDetailDtos.add(accountDetailDto);
				}
			}
			return accountDetailDtos;
		} catch (Exception e) {
			logger.error("listDataForExportAccountDetails异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Long getCountsForExportAccountDetails(AccountDetailQuery accountDetailQuery) throws UserServiceException {
		try {
			if (StringUtils.isNotEmpty(accountDetailQuery.getStartCreateTime())) {
				accountDetailQuery.setStartCreateTime(accountDetailQuery.getStartCreateTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(accountDetailQuery.getEndCreateTime())) {
				accountDetailQuery.setEndCreateTime(accountDetailQuery.getEndCreateTime() + StringUtils.ENDTIMESTRING);
			}
			return accountDetailMapper.getCountsForExportAccountDetails(accountDetailQuery);
		} catch (Exception e) {
			logger.error("getCountsForExportAccountDetails异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Long getCountsForExportUserAccount(CustomerBalanceQuery query) throws UserServiceException {
		try {
			return accountMapper.getCountsForExportUserAccount(query);
		} catch (Exception e) {
			logger.error("getCountsForExportUserAccount异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<AccountDto> listDataForExportUserAccount(CustomerBalanceQuery query, Long startLineNum, Integer pageSize)
			throws UserServiceException {
		try {
			List<AccountRelatedInfo> accountRelatedInfos = accountMapper.listDataForExportUserAccount(query, startLineNum,
					pageSize);
			List<AccountDto> accountDtos = new ArrayList<AccountDto>();
			if (!ObjectUtils.isNullOrEmpty(accountRelatedInfos)) {
				for (AccountRelatedInfo arf : accountRelatedInfos) {
					AccountDto accountDto = new AccountDto();
					ObjectUtils.fastCopy(arf, accountDto);
					accountDtos.add(accountDto);
				}
			}
			return accountDtos;
		} catch (Exception e) {
			logger.error("listDataForExportUserAccount异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Long countsAccountDetailsAmount(AccountDetailQuery accountDetailQuery) throws UserServiceException {
		try {
			return accountDetailMapper.countsAccountDetailsAmount(accountDetailQuery);
		} catch (Exception e) {
			logger.error("countsAccountDetailsAmount异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public YiLiDiPage<OnlinePayDetailDto> findOnlinePayDetails(AccountDetailQuery accountDetailQuery) throws UserServiceException {
		try {
			if (null == accountDetailQuery.getStart() || accountDetailQuery.getStart() <= 0) {
				accountDetailQuery.setStart(1);
			}
			if (null == accountDetailQuery.getPageSize() || accountDetailQuery.getPageSize() <= 0) {
				accountDetailQuery.setPageSize(CommonConstants.PAGE_SIZE);
			}
			if (StringUtils.isNotEmpty(accountDetailQuery.getStartCreateTime())) {
				accountDetailQuery.setStartCreateTime(accountDetailQuery.getStartCreateTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(accountDetailQuery.getEndCreateTime())) {
				accountDetailQuery.setEndCreateTime(accountDetailQuery.getEndCreateTime() + StringUtils.ENDTIMESTRING);
			}
			PageHelper.startPage(accountDetailQuery.getStart(), accountDetailQuery.getPageSize());
			Page<OnlinePayDetailRelatedInfo> page = onlinePayDetailMapper.findOnlinePayDetails(accountDetailQuery);
			Page<OnlinePayDetailDto> pageDto = new Page<OnlinePayDetailDto>(accountDetailQuery.getStart(),
					accountDetailQuery.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<OnlinePayDetailRelatedInfo> onlinePayDetailRelatedInfos = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(onlinePayDetailRelatedInfos)) {
				for (OnlinePayDetailRelatedInfo adri : onlinePayDetailRelatedInfos) {
					OnlinePayDetailDto onlinePayDetailDto = new OnlinePayDetailDto();
					ObjectUtils.fastCopy(adri, onlinePayDetailDto);
					// 获得订单支付平台名称
					String payPlatformName = SystemBasicDataUtils.getSystemDictName(
							SystemContext.OrderDomain.DictType.SALEORDERPAYPLATFORM.getValue(),
							onlinePayDetailDto.getPayPlatform());
					if (!StringUtils.isEmpty(payPlatformName)) {
						onlinePayDetailDto.setPayPlatformName(payPlatformName);
					} else {
						SystemDictProxyDto systemDictProxyDto = systemDictProxyService.loadByDictCode(onlinePayDetailDto
								.getPayPlatform());
						if (!ObjectUtils.isNullOrEmpty(systemDictProxyDto)) {
							onlinePayDetailDto.setPayPlatformName(systemDictProxyDto.getDictName());
						}
					}
					// 获得订单支付状态名称
					String payStatusName = SystemBasicDataUtils.getSystemDictName(
							SystemContext.UserDomain.DictType.PAYSTATUSCODE.getValue(), onlinePayDetailDto.getPayPlatform());
					if (!StringUtils.isEmpty(payStatusName)) {
						onlinePayDetailDto.setPayStatusName(payStatusName);
					} else {
						SystemDictProxyDto systemDictProxyDto = systemDictProxyService.loadByDictCode(onlinePayDetailDto
								.getPayStatus());
						if (!ObjectUtils.isNullOrEmpty(systemDictProxyDto)) {
							onlinePayDetailDto.setPayStatusName(systemDictProxyDto.getDictName());
						}
					}
					pageDto.add(onlinePayDetailDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("findOnlinePayDetails异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<OnlinePayDetailDto> listDataForExportOnlinePayDetails(AccountDetailQuery accountDetailQuery,
			Long startLineNum, Integer pageSize) throws UserServiceException {
		try {
			if (StringUtils.isNotEmpty(accountDetailQuery.getStartCreateTime())) {
				accountDetailQuery.setStartCreateTime(accountDetailQuery.getStartCreateTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(accountDetailQuery.getEndCreateTime())) {
				accountDetailQuery.setEndCreateTime(accountDetailQuery.getEndCreateTime() + StringUtils.ENDTIMESTRING);
			}
			List<OnlinePayDetailRelatedInfo> onlinePayDetailRelatedInfos = onlinePayDetailMapper
					.listDataForExportOnlinePayDetails(accountDetailQuery, startLineNum, pageSize);
			List<OnlinePayDetailDto> onlinePayDetailDtos = new ArrayList<OnlinePayDetailDto>();
			if (!ObjectUtils.isNullOrEmpty(onlinePayDetailRelatedInfos)) {
				for (OnlinePayDetailRelatedInfo adri : onlinePayDetailRelatedInfos) {
					OnlinePayDetailDto onlinePayDetailDto = new OnlinePayDetailDto();
					ObjectUtils.fastCopy(adri, onlinePayDetailDto);
					onlinePayDetailDtos.add(onlinePayDetailDto);
				}
			}
			return onlinePayDetailDtos;
		} catch (Exception e) {
			logger.error("listDataForExportOnlinePayDetails异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Long getCountsForExportOnlinePayDetails(AccountDetailQuery accountDetailQuery) throws UserServiceException {
		try {
			if (StringUtils.isNotEmpty(accountDetailQuery.getStartCreateTime())) {
				accountDetailQuery.setStartCreateTime(accountDetailQuery.getStartCreateTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(accountDetailQuery.getEndCreateTime())) {
				accountDetailQuery.setEndCreateTime(accountDetailQuery.getEndCreateTime() + StringUtils.ENDTIMESTRING);
			}
			return onlinePayDetailMapper.getCountsForExportOnlinePayDetails(accountDetailQuery);
		} catch (Exception e) {
			logger.error("getCountsForExportOnlinePayDetails异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public YiLiDiPage<AccountDetailCountDto> findCountSellerAccountsDetail(CustomerBalanceQuery customerBalanceQuery) throws UserServiceException {
		try {
			if (null == customerBalanceQuery.getStart() || customerBalanceQuery.getStart() <= 0) {
				customerBalanceQuery.setStart(1);
			}
			if (null == customerBalanceQuery.getPageSize() || customerBalanceQuery.getPageSize() <= 0) {
				customerBalanceQuery.setPageSize(CommonConstants.PAGE_SIZE);
			}
			PageHelper.startPage(customerBalanceQuery.getStart(), customerBalanceQuery.getPageSize());
			Page<AccountDetailCountInfo> page = accountDetailMapper.findCountSellerAccountsDetail(customerBalanceQuery);
			Page<AccountDetailCountDto> pageDto = new Page<AccountDetailCountDto>(customerBalanceQuery.getStart(),
					customerBalanceQuery.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<AccountDetailCountInfo> accountDetailCountInfos = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(accountDetailCountInfos)) {
				for (AccountDetailCountInfo accountDetailCountInfo : accountDetailCountInfos) {
					AccountDetailCountDto accountDetailCountDto = new AccountDetailCountDto();
					ObjectUtils.fastCopy(accountDetailCountInfo, accountDetailCountDto);

					// 根据门店用户ID，统计该门店所有订单退款金额
					AccountDetailQuery accountDetailQuery = new AccountDetailQuery();
					accountDetailQuery.setUserId(accountDetailCountInfo.getStoreId());
					accountDetailQuery.setChangeType(SystemContext.UserDomain.ACCOUNTCHANGETYPE_REFUND);
					Long refundAmount = accountDetailMapper.countsAccountDetailsAmount(accountDetailQuery);

					// 根据门店用户ID，统计该门店所有的提现金额
					WithdrawApplyQuery withdrawApplyQuery = new WithdrawApplyQuery();
					withdrawApplyQuery.setCustomerId(accountDetailCountInfo.getStoreId());
					List<String> statusCodes = new ArrayList<String>();
					statusCodes.add(SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_DRAW_PASSED);
					withdrawApplyQuery.setStatusCodes(statusCodes);
					Long totalWithdrawAmount = withdrawApplyMapper.countSellerWithdrawBalance(withdrawApplyQuery);

					// 根据门店用户ID，统计该门店的所有订单采购支付金额
					accountDetailQuery.setChangeType(SystemContext.UserDomain.ACCOUNTCHANGETYPE_PAY);
					Long payAccountAmount = accountDetailMapper.countsAccountDetailsAmount(accountDetailQuery);

					accountDetailCountDto.setRefundAmount(refundAmount);
					accountDetailCountDto.setPayAccountAmount(payAccountAmount);
					accountDetailCountDto.setTotalWithdrawAmount(totalWithdrawAmount);

					// 门店账本总收入金额=现金账本金额+商品补贴金额+优惠券补贴金额+运费补贴金额+订单退款
					double cashAmountd = ArithUtils.convertLongTodouble(accountDetailCountInfo.getCashSubsidy());
					double priceAmountd = ArithUtils.convertLongTodouble(accountDetailCountInfo.getPriceSubsidy());
					double couponAmountd = ArithUtils.convertLongTodouble(accountDetailCountInfo.getCouponSubsidy());
					double logisticAmountd = ArithUtils.convertLongTodouble(accountDetailCountInfo.getLogisticsSubsidy());
					double refundAmountd = ArithUtils.convertLongTodouble(refundAmount);
					double[] param1 = { cashAmountd, priceAmountd, couponAmountd, logisticAmountd, refundAmountd };
					Long totalInAmount = new Double(ArithUtils.add(param1)).longValue();
					accountDetailCountDto.setTotalInAmount(totalInAmount);

					// 门店账本总支出金额=账本提现金额+采购订单支付金额
					double totalWithdrawAmountd = ArithUtils.convertLongTodouble(totalWithdrawAmount);
					double payAccountAmountd = ArithUtils.convertLongTodouble(payAccountAmount);
					double[] param2 = { totalWithdrawAmountd, payAccountAmountd };
					Long totalOutAmount = new Double(ArithUtils.add(param2)).longValue();
					accountDetailCountDto.setTotalOutAmount(totalOutAmount);
					pageDto.add(accountDetailCountDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("根据条件分页查询 卖家(门店)账本收入和支出统计金额管理出错", e);
			throw new UserServiceException("异常：根据条件分页查询 卖家(门店)账本收入和支出统计金额管理出错");
		}
	}

	@Override
	public List<AccountDetailCountDto> listDataForExportCountAccountDetails(CustomerBalanceQuery customerBalanceQuery,
			Long startLineNum, Integer pageSize) throws UserServiceException {
		try {
			List<AccountDetailCountInfo> accountDetailCountInfos = accountDetailMapper.listDataForExportCountAccountDetails(
					customerBalanceQuery, startLineNum, pageSize);
			List<AccountDetailCountDto> accountDetailCountDtos = new ArrayList<AccountDetailCountDto>();
			if (!ObjectUtils.isNullOrEmpty(accountDetailCountInfos)) {
				for (AccountDetailCountInfo accountDetailCountInfo : accountDetailCountInfos) {
					AccountDetailCountDto accountDetailCountDto = new AccountDetailCountDto();
					ObjectUtils.fastCopy(accountDetailCountInfo, accountDetailCountDto);

					// 根据门店用户ID，统计该门店所有订单退款金额
					AccountDetailQuery accountDetailQuery = new AccountDetailQuery();
					accountDetailQuery.setUserId(accountDetailCountInfo.getStoreId());
					accountDetailQuery.setChangeType(SystemContext.UserDomain.ACCOUNTCHANGETYPE_REFUND);
					Long refundAmount = accountDetailMapper.countsAccountDetailsAmount(accountDetailQuery);

					// 根据门店用户ID，统计该门店所有的提现金额
					WithdrawApplyQuery withdrawApplyQuery = new WithdrawApplyQuery();
					withdrawApplyQuery.setCustomerId(accountDetailCountInfo.getStoreId());
					List<String> statusCodes = new ArrayList<String>();
					statusCodes.add(SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_DRAW_PASSED);
					withdrawApplyQuery.setStatusCodes(statusCodes);
					Long totalWithdrawAmount = withdrawApplyMapper.countSellerWithdrawBalance(withdrawApplyQuery);

					// 根据门店用户ID，统计该门店的所有订单采购支付金额
					accountDetailQuery.setChangeType(SystemContext.UserDomain.ACCOUNTCHANGETYPE_PAY);
					Long payAccountAmount = accountDetailMapper.countsAccountDetailsAmount(accountDetailQuery);

					accountDetailCountDto.setRefundAmount(refundAmount);
					accountDetailCountDto.setPayAccountAmount(payAccountAmount);
					accountDetailCountDto.setTotalWithdrawAmount(totalWithdrawAmount);

					// 门店账本总收入金额=现金账本金额+商品补贴金额+优惠券补贴金额+运费补贴金额+订单退款
					double cashAmountd = ArithUtils.convertLongTodouble(accountDetailCountInfo.getCashSubsidy());
					double priceAmountd = ArithUtils.convertLongTodouble(accountDetailCountInfo.getPriceSubsidy());
					double couponAmountd = ArithUtils.convertLongTodouble(accountDetailCountInfo.getCouponSubsidy());
					double logisticAmountd = ArithUtils.convertLongTodouble(accountDetailCountInfo.getLogisticsSubsidy());
					double refundAmountd = ArithUtils.convertLongTodouble(refundAmount);
					double[] param1 = { cashAmountd, priceAmountd, couponAmountd, logisticAmountd, refundAmountd };
					Long totalInAmount = new Double(ArithUtils.add(param1)).longValue();
					accountDetailCountDto.setTotalInAmount(totalInAmount);

					// 门店账本总支出金额=账本提现金额+采购订单支付金额
					double totalWithdrawAmountd = ArithUtils.convertLongTodouble(totalWithdrawAmount);
					double payAccountAmountd = ArithUtils.convertLongTodouble(payAccountAmount);
					double[] param2 = { totalWithdrawAmountd, payAccountAmountd };
					Long totalOutAmount = new Double(ArithUtils.add(param2)).longValue();
					accountDetailCountDto.setTotalOutAmount(totalOutAmount);
					accountDetailCountDtos.add(accountDetailCountDto);
				}
			}
			return accountDetailCountDtos;
		} catch (Exception e) {
			logger.error("根据条件分页查询 卖家(门店)账本收入和支出统计金额导出报表出错", e);
			throw new UserServiceException("异常：根据条件分页查询 卖家(门店)账本收入和支出统计金额导出报表出错");
		}
	}

	@Override
	public Long getCountsForExportCountAccountDetails(CustomerBalanceQuery customerBalanceQuery)
			throws UserServiceException {
		try {
			return accountDetailMapper.getCountsForExportCountAccountDetails(customerBalanceQuery);
		} catch (Exception e) {
			logger.error("getCountsForExportCountAccountDetails异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void sendUserRegistAwardMessage(Integer userId, Date nowTime) {
		try {
			if(!ObjectUtils.isNullOrEmpty(userId) && !ObjectUtils.isNullOrEmpty(nowTime)){
				messageProxyService.sendUserRegistAwardMessage(userId,nowTime);
			}
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
		
	}
}
