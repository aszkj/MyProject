package com.yilidi.o2o.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.AccountTypeInfoMapper;
import com.yilidi.o2o.user.model.AccountTypeInfo;
import com.yilidi.o2o.user.service.IAccountTypeInfoService;
import com.yilidi.o2o.user.service.dto.AccountTypeInfoDto;

/**
 * 功能描述：账户类型信息Service服务实现类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("accountTypeInfoService")
public class AccountTypeInfoServiceImpl extends BasicDataService implements IAccountTypeInfoService {

	@Autowired
	private AccountTypeInfoMapper accountTypeInfoMapper;

	@Override
	public void saveAccountTypeInfo(AccountTypeInfoDto accountTypeInfoDto) throws UserServiceException {
		try {
			AccountTypeInfo accountTypeInfo = new AccountTypeInfo();
			ObjectUtils.fastCopy(accountTypeInfoDto, accountTypeInfo);
			this.accountTypeInfoMapper.save(accountTypeInfo);
		} catch (Exception e) {
			logger.error("saveAccountTypeInfo异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void updateAccountTypeInfo(AccountTypeInfoDto accountTypeInfoDto) throws UserServiceException {
		try {
			AccountTypeInfo accountTypeInfo = accountTypeInfoMapper.loadById(accountTypeInfoDto.getAccountTypeId());
			accountTypeInfo.setAccountTypeName(accountTypeInfoDto.getAccountTypeName());
			accountTypeInfo.setPayPriority(accountTypeInfoDto.getPayPriority());
			accountTypeInfo.setPayScale(accountTypeInfoDto.getPayScale());
			accountTypeInfo.setModifyUserId(accountTypeInfoDto.getModifyUserId());
			accountTypeInfo.setModifyTime(accountTypeInfoDto.getModifyTime());
			accountTypeInfo.setNote(accountTypeInfoDto.getNote());
			ObjectUtils.fastCopy(accountTypeInfoDto, accountTypeInfo);
			this.accountTypeInfoMapper.updateByIdSelective(accountTypeInfo);
		} catch (Exception e) {
			logger.error("updateAccountTypeInfo异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public AccountTypeInfoDto loadAccountTypeInfoById(Integer id) throws UserServiceException {
		try {
			AccountTypeInfo accountTypeInfo = accountTypeInfoMapper.loadById(id);
			AccountTypeInfoDto accountTypeInfoDto = null;
			if (null != accountTypeInfo) {
				accountTypeInfoDto = new AccountTypeInfoDto();
				ObjectUtils.fastCopy(accountTypeInfo, accountTypeInfoDto);
			}
			return accountTypeInfoDto;
		} catch (Exception e) {
			logger.error("loadAccountTypeInfoById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

}
