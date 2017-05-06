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
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.IAreaDictProxyService;
import com.yilidi.o2o.system.proxy.ISystemDictProxyService;
import com.yilidi.o2o.system.proxy.dto.AreaDictProxyDto;
import com.yilidi.o2o.system.proxy.dto.SystemDictProxyDto;
import com.yilidi.o2o.user.dao.AccountBindingMapper;
import com.yilidi.o2o.user.model.AccountBinding;
import com.yilidi.o2o.user.model.combination.AccountBindingRelatedInfo;
import com.yilidi.o2o.user.service.IAccountBindingService;
import com.yilidi.o2o.user.service.dto.AccountBindingDto;
import com.yilidi.o2o.user.service.dto.query.AccountBindingQuery;

/**
 * 功能描述：账户绑定Service服务实现类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("accountBindingService")
public class AccountBindingServiceImpl extends BasicDataService implements IAccountBindingService {

	@Autowired
	private AccountBindingMapper accountBindingMapper;

	@Autowired
	private ISystemDictProxyService systemDictProxyService;
	
	@Autowired
	private IAreaDictProxyService areaDictProxyService;
	
	@Override
	public void save(AccountBindingDto accountBindingDto) throws UserServiceException {
		try {
			AccountBinding accountBinding = new AccountBinding();
			ObjectUtils.fastCopy(accountBindingDto, accountBinding);
			this.accountBindingMapper.save(accountBinding);
		} catch (Exception e) {
			logger.error("save异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void deleteById(Integer id) throws UserServiceException {
		try {
			accountBindingMapper.deleteById(id);
		} catch (Exception e) {
			logger.error("deleteById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public AccountBindingDto loadById(Integer id) throws UserServiceException {
		try {
			AccountBinding accountBinding = accountBindingMapper.loadById(id);
			AccountBindingDto accountBindingDto = null;
			if (null != accountBinding) {
				accountBindingDto = new AccountBindingDto();
				ObjectUtils.fastCopy(accountBinding, accountBindingDto);
			}
			return accountBindingDto;
		} catch (Exception e) {
			logger.error("loadById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<AccountBindingDto> listByCustomerId(Integer customerId) throws UserServiceException {
		try {
			List<AccountBinding> accountBindings = accountBindingMapper.listByCustomerId(customerId);
			List<AccountBindingDto> accountBindingDtos = null;
			if (!ObjectUtils.isNullOrEmpty(accountBindings)) {
				accountBindingDtos = new ArrayList<AccountBindingDto>();
				for (AccountBinding accountBinding : accountBindings) {
					AccountBindingDto accountBindingDto = new AccountBindingDto();
					ObjectUtils.fastCopy(accountBinding, accountBindingDto);
					accountBindingDtos.add(accountBindingDto);
				}
			}
			return accountBindingDtos;
		} catch (Exception e) {
			logger.error("listByCustomerId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public AccountBindingDto loadAccountBindingDetailById(Integer id) throws UserServiceException {
		try {
			AccountBindingRelatedInfo accountBindingRelatedInfo = accountBindingMapper.loadAccountBindingDetailById(id);
			AccountBindingDto accountBindingDto = null;
			if (null != accountBindingRelatedInfo) {
				accountBindingDto = new AccountBindingDto();
				ObjectUtils.fastCopy(accountBindingRelatedInfo, accountBindingDto);
			}
			return accountBindingDto;
		} catch (Exception e) {
			logger.error("loadAccountBindingDetailById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Override
	public void updateAccountBinding(AccountBindingDto accountBindingDto) throws UserServiceException {
		try {
			AccountBinding accountBinding = accountBindingMapper.loadById(accountBindingDto.getBingdingAccountId());
			accountBinding.setAccountBindingType(accountBindingDto.getAccountBindingType());
			accountBinding.setTransferAccountType(accountBindingDto.getTransferAccountType());
			accountBinding.setAccountName(accountBindingDto.getAccountName());
			accountBinding.setAccountNo(accountBindingDto.getAccountNo());
			accountBinding.setSubBankName(accountBindingDto.getSubBankName());
			accountBinding.setMasterName(accountBindingDto.getMasterName());
			accountBinding.setMasterIDcardNo(accountBindingDto.getMasterIDcardNo());
			accountBinding.setMasterPhoneNo(accountBindingDto.getMasterPhoneNo());
			accountBinding.setCreateUserId(accountBindingDto.getCreateUserId());
			accountBinding.setCreateTime(accountBindingDto.getCreateTime());
			accountBindingMapper.updateAccountBinding(accountBinding);
		} catch (Exception e) {
			logger.error("updateAccountBinding异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}


	@Override
	public YiLiDiPage<AccountBindingDto> findAccountBindingBanks(AccountBindingQuery accountBingdingQuery)
			throws UserServiceException {
		try {
			if (null == accountBingdingQuery.getStart() || accountBingdingQuery.getStart() <= 0) {
				accountBingdingQuery.setStart(1);
			}
			if (null == accountBingdingQuery.getPageSize() || accountBingdingQuery.getPageSize() <= 0) {
				accountBingdingQuery.setPageSize(CommonConstants.PAGE_SIZE);
			}
			PageHelper.startPage(accountBingdingQuery.getStart(), accountBingdingQuery.getPageSize());
			Page<AccountBindingRelatedInfo> page = accountBindingMapper.findAccountBindingBanks(accountBingdingQuery);
			Page<AccountBindingDto> pageDto = new Page<AccountBindingDto>(accountBingdingQuery.getStart(),
					accountBingdingQuery.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<AccountBindingRelatedInfo>  accountBindingRelatedInfos = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(accountBindingRelatedInfos)) {
				for (AccountBindingRelatedInfo accountBindingRelatedInfo : accountBindingRelatedInfos) {
					AccountBindingDto accountBindingDto = new AccountBindingDto();
					ObjectUtils.fastCopy(accountBindingRelatedInfo, accountBindingDto);
					String accountBindingTypeName = SystemBasicDataUtils.getSystemDictName(
							SystemContext.UserDomain.DictType.ACCOUNTBINDINGTYPE.getValue(),
							accountBindingRelatedInfo.getAccountBindingType());
					if (!StringUtils.isEmpty(accountBindingTypeName)) {
						accountBindingDto.setAccountBindingTypeName(accountBindingTypeName);
					} else {
						SystemDictProxyDto systemDictProxyDto = systemDictProxyService
								.loadByDictCode(accountBindingRelatedInfo.getAccountBindingType());
						if (!ObjectUtils.isNullOrEmpty(systemDictProxyDto)) {
							accountBindingDto.setAccountBindingTypeName(systemDictProxyDto.getDictName());
						}
					}
					// 获取市、区县名称
					if (!ObjectUtils.isNullOrEmpty(accountBindingDto.getCityCode())) {
						AreaDictProxyDto areaDictProxyDto = areaDictProxyService.loadByAreaCode(accountBindingDto
								.getCityCode());
						if (!ObjectUtils.isNullOrEmpty(areaDictProxyDto)) {
							accountBindingDto.setCityCode(areaDictProxyDto.getAreaName());
						}
					}
					if (!ObjectUtils.isNullOrEmpty(accountBindingDto.getCountyCode())) {
						AreaDictProxyDto areaDictProxyDto = areaDictProxyService.loadByAreaCode(accountBindingDto
								.getCountyCode());
						if (!ObjectUtils.isNullOrEmpty(areaDictProxyDto)) {
							accountBindingDto.setCountyCode(areaDictProxyDto.getAreaName());
						}
					}
					pageDto.add(accountBindingDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("findAccountBindingBanks异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
}
