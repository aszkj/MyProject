package com.yilidi.o2o.controller.operation.user;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.user.service.IAccountBindingService;
import com.yilidi.o2o.user.service.dto.AccountBindingDto;
import com.yilidi.o2o.user.service.dto.query.AccountBindingQuery;

/**
 * @Description:TODO(绑定账户控制器)
 * @author: llp
 * @date: 2015年11月16日 下午21:12:48
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class AccountBindingController extends OperationBaseController {

	protected Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private IAccountBindingService accountBindingService;

	/**
	 * @Description TODO(查询用户账号绑定记录管理)
	 * @param query
	 * @return Page<AccountBindingDto>
	 */
	@RequestMapping(value = "/listAccountBinding")
	@ResponseBody
	public MsgBean listAccountBinding(@RequestBody AccountBindingQuery query) {
		try {
			YiLiDiPage<AccountBindingDto> page = accountBindingService.findAccountBindingBanks(query);
			logger.info("=========YiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(page));
			return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询用户账户绑定记录成功");
		} catch (Exception e) {
			logger.error("查询用户账户绑定记录失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * @Description TODO(获取绑定账户类型列表)
	 * @return accountBindingTypeMapList
	 */
	@RequestMapping(value = "/getAccountBindingType")
	@ResponseBody
	public MsgBean getAccountBindingType() {
		try {
			List<Map<String, String>> accountBindingTypeMapList = systemBasicDataInfoUtils
					.getSystemDictInfoList(SystemContext.UserDomain.DictType.ACCOUNTBINDINGTYPE.getValue());
			return super.encapsulateMsgBean(accountBindingTypeMapList, MsgBean.MsgCode.SUCCESS, "获取绑定账户类型列表成功");
		} catch (Exception e) {
			logger.error("获取绑定账户类型列表失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * @Description TODO(查询用户账户绑定记录详情)
	 * @param query
	 * @return accountBindingDto
	 */
	@RequestMapping(value = "/{id}/loadAccountBindingDetailById")
	@ResponseBody
	public MsgBean loadAccountBindingDetailById(@PathVariable("id") Integer id) {
		try {
			AccountBindingDto accountBindingDto = accountBindingService.loadAccountBindingDetailById(id);
			logger.info("accountBindingDto : " + JsonUtils.toJsonStringWithDateFormat(accountBindingDto));
			return super.encapsulateMsgBean(accountBindingDto, MsgBean.MsgCode.SUCCESS, "查询用户账户绑定记录详细信息成功");
		} catch (Exception e) {
			logger.error("查询用户账户绑定记录详细信息失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * @Description TODO(修改用户绑定记录)
	 * @param accountBindingDto
	 * @return MsgBean
	 */
	@RequestMapping(value = "/updateAccountBinding")
	@ResponseBody
	public MsgBean updateAccountBinding(@RequestBody AccountBindingDto accountBindingDto) {
		try {
			Param accountBindingType = new Param.Builder("开户银行", Param.ParamType.STR_NORMAL.getType(),
					accountBindingDto.getAccountBindingType(), false).build();
			Param transferAccountType = new Param.Builder("账户类型", Param.ParamType.STR_NORMAL.getType(),
					accountBindingDto.getTransferAccountType(), false).build();
			Param accountName = new Param.Builder("开户人姓名", Param.ParamType.STR_NORMAL.getType(),
					accountBindingDto.getAccountName(), false).build();
			Param accountNo = new Param.Builder("银行卡号", Param.ParamType.STR_NUMBER.getType(),
					accountBindingDto.getAccountNo(), false).build();
			Param subBankName = new Param.Builder("支行名称", Param.ParamType.STR_NORMAL.getType(),
					accountBindingDto.getSubBankName(), false).build();
			Param masterName = new Param.Builder("真实姓名", Param.ParamType.STR_NORMAL.getType(),
					accountBindingDto.getMasterName(), false).build();
			Param masterIDcardNo = new Param.Builder("身份证号码", Param.ParamType.STR_NORMAL.getType(),
					accountBindingDto.getMasterIDcardNo(), false).build();
			Param masterPhoneNo = new Param.Builder("手机号码", Param.ParamType.STR_MOBILE.getType(),
					accountBindingDto.getMasterPhoneNo(), false).build();
			super.validateParams(accountBindingType, transferAccountType, accountName, accountNo, subBankName, masterName,
					masterIDcardNo, masterPhoneNo);
			accountBindingDto.setCreateUserId(super.getUserId());
			accountBindingDto.setCreateTime(new Date());
			accountBindingService.updateAccountBinding(accountBindingDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改提现申请审核状态成功");
		} catch (Exception e) {
			logger.error("修改提现申请审核状态失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}
}