package com.yilidi.o2o.controller.operation.user;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.user.service.IStoreDeliveryOrderRecordService;
import com.yilidi.o2o.user.service.dto.StoreDeliveryOrderRecordDto;
import com.yilidi.o2o.user.service.dto.query.StoreDeliveryOrderRecordQuery;

/**
 * 门店接单员处理订单记录管理
 * 
 * @author: heyong
 * @date: 2015年12月10日 下午8:35:39
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class StoreDeliveryOrderRecordController extends OperationBaseController {

	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private IStoreDeliveryOrderRecordService storeDeliveryOrderRecordService;

	/**
	 * 查询门店接单员处理订单列表
	 * 
	 * @param query
	 *            查询条件
	 * @return MsgBean
	 */
	@RequestMapping(value = "/listStoreDeliveryOrderRecord")
	@ResponseBody
	public MsgBean listStoreDeliveryOrderRecord(@RequestBody StoreDeliveryOrderRecordQuery query) {
		try {
			YiLiDiPage<StoreDeliveryOrderRecordDto> yiLiDiPage = storeDeliveryOrderRecordService.findStoreDeliveryOrderRecord(query);
			logger.info("listStoreDeliveryOrderRecord->yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
			return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询接单员处理订单列表成功");
		} catch (Exception e) {
			logger.error("查询接单员处理订单列表失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}
}
