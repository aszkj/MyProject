package com.yilidi.o2o.controller.operation.user;

import java.util.Date;

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
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.IStoreDeliveryService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.StoreDeliveryDto;
import com.yilidi.o2o.user.service.dto.query.StoreDeliveryQuery;

/**
 * 
 * 门店接单员管理
 * 
 * @author: heyong
 * @date: 2015年12月10日 下午3:08:13
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class StoreDeliveryController extends OperationBaseController {

	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private IStoreDeliveryService storeDeliveryService;

	@Autowired
	private IUserService userService;

	/**
	 * 查询门店接单员列表
	 * 
	 * @param query
	 *            查询条件
	 * @return MsgBean
	 */
	@RequestMapping(value = "/listStoreDelivery")
	@ResponseBody
	public MsgBean listStoreDelivery(@RequestBody StoreDeliveryQuery query) {
		try {
			YiLiDiPage<StoreDeliveryDto> yiLiDiPage = storeDeliveryService.findStoreDelivery(query);
			logger.info("listStoreDelivery->yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
			return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询门店接单员列表成功");
		} catch (Exception e) {
			logger.error("查询门店接单员列表失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * 查询门店接单员详情
	 * 
	 * @param id
	 *            门店接单员ID
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{id}/getStoreDeliveryDetail")
	@ResponseBody
	public MsgBean getStoreDeliveryDetail(@PathVariable Integer id) {
		try {
			if (null == id) {
				throw new IllegalArgumentException("无法获取门店接单员ID");
			}
			StoreDeliveryDto dto = storeDeliveryService.loadById(id);
			return super.encapsulateMsgBean(dto, MsgBean.MsgCode.SUCCESS, "获取门店接单员详情信息成功");
		} catch (Exception e) {
			logger.error("获取门店接单员详情失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * 修改门店接单员
	 * 
	 * @param storeDeliveryDto
	 *            门店接单员DTO
	 * @return MsgBean
	 */
	@RequestMapping(value = "/updateStoreDelivery")
	@ResponseBody
	public MsgBean updateStoreDelivery(@RequestBody StoreDeliveryDto storeDeliveryDto) {
		try {
			Integer id = storeDeliveryDto.getId();
			if (null == id) {
				throw new IllegalArgumentException("无法获取需修改的门店接单员ID");
			}
			storeDeliveryService.update(storeDeliveryDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改门店接单员成功");
		} catch (Exception e) {
			logger.error("修改门店接单员失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * 新增门店接单员
	 * 
	 * @param storeDeliveryDto
	 *            门店接单员DTO
	 * @return MsgBean
	 */
	@RequestMapping(value = "/createStoreDelivery")
	@ResponseBody
	public MsgBean createStoreDelivery(@RequestBody StoreDeliveryDto storeDeliveryDto) {
		try {
			if (null == storeDeliveryDto) {
				throw new IllegalArgumentException("无法获取新增的storeDeliveryDto");
			}
			// 判断username唯一性
			if (userService.checkUserNameIsExist(storeDeliveryDto.getUserName(),
					SystemContext.UserDomain.CUSTOMERTYPE_SELLER)) {
				return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "新增接单员失败,登录账号已存在!");
			}
			// 默认有效
			storeDeliveryDto.setState(SystemContext.UserDomain.STOREDELIVERYSTATE_YES);
			storeDeliveryDto.setCreateDate(new Date());
			storeDeliveryDto.setCreateUserId(super.getUserId());
			storeDeliveryService.save(storeDeliveryDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "新增接单员成功");
		} catch (Exception e) {
			logger.error("新增接单员失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * 失效/有效 接单员
	 * 
	 * @param id
	 *            门店接单员ID
	 * @param state
	 *            是否有效
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{id}-{state}/updateStoreDeliveryState")
	@ResponseBody
	public MsgBean updateStoreDeliveryState(@PathVariable("id") Integer id, @PathVariable("state") Integer state) {
		String showmsg = "";
		try {
			if (null == id) {
				throw new IllegalArgumentException("无法获取接单员ID");
			}
			// 失效
			if (!ObjectUtils.isNullOrEmpty(state) && state == 1) {
				storeDeliveryService.updateStateById(id, SystemContext.UserDomain.STOREDELIVERYSTATE_NO);
				showmsg += "设为失效";
			}
			// 开启
			if (!ObjectUtils.isNullOrEmpty(state) && state == 2) {
				storeDeliveryService.updateStateById(id, SystemContext.UserDomain.STOREDELIVERYSTATE_YES);
				showmsg += "设为有效";
			}
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, showmsg + "成功");
		} catch (Exception e) {
			logger.error(showmsg + "失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * 重置接单员密码
	 * 
	 * @param id
	 *            门店接单员ID
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{id}/resetStoreDeliveryPassword")
	@ResponseBody
	public MsgBean resetStoreDeliveryPassword(@PathVariable Integer id) {
		try {
			if (null == id) {
				throw new IllegalArgumentException("无法获取接单员ID");
			}
			storeDeliveryService.resetStoreDeliveryPassword(id);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "重置密码成功");
		} catch (Exception e) {
			logger.error("重置密码失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}
}
