package com.yilidi.o2o.controller.operation.product;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.product.service.IBuyRewardActivityAuditService;
import com.yilidi.o2o.product.service.dto.BuyRewardActivityAuditDto;
import com.yilidi.o2o.product.service.dto.query.BuyRewardActivityQueryDto;

/**
 * 功能描述：待审核买赠活动Controller 作者： xiasl<br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 * 
 * @date 2017年3月15日
 */
@Controller
@RequestMapping(value = "/operation")
public class BuyRewardActivityAuditController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IBuyRewardActivityAuditService buyRewardActivityAuditService;

    @Autowired
    private ICouponService couponService;

    /**
     * 分页获取待审核买赠活动信息列表
     * 
     * @param buyRewardActivityQueryDto
     *            买赠活动查询DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/findAuditBuyRewardActivitys")
    @ResponseBody
    public MsgBean findAuditBuyRewardActivitys(@RequestBody BuyRewardActivityQueryDto buyRewardActivityQueryDto) {
        try {
            logger.info("========= buyRewardActivityQueryDto : "
                    + JsonUtils.toJsonStringWithDateFormat(buyRewardActivityQueryDto));
            if (!StringUtils.isEmpty(buyRewardActivityQueryDto.getActivityBeginStr())) {
                buyRewardActivityQueryDto
                        .setActivityBegin(DateUtils.parseDate(buyRewardActivityQueryDto.getActivityBeginStr()));
            }
            if (!StringUtils.isEmpty(buyRewardActivityQueryDto.getActivityEndStr())) {
                buyRewardActivityQueryDto.setActivityEnd(DateUtils.parseDate(buyRewardActivityQueryDto.getActivityEndStr()));
            }
            buyRewardActivityQueryDto.setOrder(DBTablesColumnsName.BuyRewardActivity.CREATETIME);
            buyRewardActivityQueryDto.setSort(CommonConstants.SORT_ORDER_DESC + " ,MODIFYTIME DESC");
            YiLiDiPage<BuyRewardActivityAuditDto> yiLiDiPage = buyRewardActivityAuditService
                    .findBuyRewardActivitys(buyRewardActivityQueryDto);
            logger.info("========= yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询买赠活动列表成功");
        } catch (Exception e) {
            logger.error("查询买赠活动列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 删除待审核买赠活动
     * 
     * @param param
     *            删除待审核买赠活动相关参数
     * @return MsgBean
     */
    @RequestMapping(value = "/{param}/deleteAuditActivitys")
    @ResponseBody
    public MsgBean deleteAuditActivitys(@PathVariable String param) {
        try {
            List<String> auditStatusList = new ArrayList<String>();
            auditStatusList.add(SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FOR_AUDIT);
            auditStatusList.add(SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_INIT_AUDIT_REJECTED);
            auditStatusList.add(SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FINAL_AUDIT_REJECTED);
            @SuppressWarnings("unchecked")
            List<Integer> idList = StringUtils.parseList(param, CommonConstants.DELIMITER_COMMA, Integer.class);
            buyRewardActivityAuditService.deleteBuyRewardActivityById(idList, auditStatusList);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "删除买赠活动成功");
        } catch (Exception e) {
            logger.error("删除买赠活动成功失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 提交审核待审核买赠活动
     * 
     * @param param
     *            提交审核相关参数
     * @return MsgBean
     */
    @RequestMapping(value = "/{param}/doSubmitAuditActivity")
    @ResponseBody
    public MsgBean doSubmitAuditActivity(@PathVariable String param) {
        try {
            List<String> preAuditStatusList = new ArrayList<String>();
            preAuditStatusList.add(SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FOR_AUDIT);
            preAuditStatusList.add(SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FINAL_AUDIT_REJECTED);
            Date currentTime = DateUtils.getCurrentDateTime();
            Date submitTime = currentTime;
            String auditStatus = SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FOR_FINAL_AUDIT;
            Integer modifyUserId = super.getUserId();
            Date modifyTime = currentTime;
            @SuppressWarnings("unchecked")
            List<Integer> idList = StringUtils.parseList(param, CommonConstants.DELIMITER_COMMA, Integer.class);
            buyRewardActivityAuditService.updateAuditStatusByIds(idList, preAuditStatusList, submitTime, auditStatus,
                    modifyUserId, modifyTime);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "买赠活动提交审核成功");
        } catch (Exception e) {
            logger.error("买赠活动提交审核失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 分页获取买赠信息终审列表
     * 
     * @param auditProductQueryDto
     *            待审核产品信息查询DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/findAuditBuyRewardActivitysForFinalAudit")
    @ResponseBody
    public MsgBean findAuditBuyRewardActivitysForFinalAudit(
            @RequestBody BuyRewardActivityQueryDto buyRewardActivityQueryDto) {
        try {
            List<String> finalAuditStatusList = new ArrayList<String>();
            finalAuditStatusList.add(SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FOR_FINAL_AUDIT);
            finalAuditStatusList.add(SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FINAL_AUDIT_REJECTED);
            buyRewardActivityQueryDto.setFinalAuditStatusList(finalAuditStatusList);
            buyRewardActivityQueryDto.setOrder("MODIFYTIME");
            buyRewardActivityQueryDto.setSort("DESC");
            YiLiDiPage<BuyRewardActivityAuditDto> yiLiDiPage = buyRewardActivityAuditService
                    .findBuyRewardActivitys(buyRewardActivityQueryDto);
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "分页获取买赠活动信息审批列表成功");
        } catch (Exception e) {
            logger.error("分页获取买赠活动信息审批列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 审批买赠活动（通过）
     * 
     * @param id
     *            买赠活动ID
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/doFinalAuditActivityPass")
    @ResponseBody
    public MsgBean doFinalAuditActivityPass(@PathVariable String id) {
        try {
            String preAuditStatus = SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FOR_FINAL_AUDIT;
            Date currentTime = DateUtils.getCurrentDateTime();
            Date finalAuditTime = currentTime;
            String auditStatus = SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FINISHED;
            Integer finalAuditUserId = super.getUserId();
            Integer modifyUserId = super.getUserId();
            Date modifyTime = currentTime;
            String finalAuditRejectReason = null;
            BuyRewardActivityAuditDto buyRewardActivityAuditDto = buyRewardActivityAuditService
                    .loadById(Integer.valueOf(id));
            if (ObjectUtils.isNullOrEmpty(buyRewardActivityAuditDto)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "买赠活动信息查询异常");
            }
            buyRewardActivityAuditService.saveStandardByFinalAuditPass(Integer.valueOf(id), preAuditStatus, auditStatus,
                    finalAuditUserId, finalAuditTime, finalAuditRejectReason, modifyUserId, modifyTime);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "审批买赠活动成功");
        } catch (Exception e) {
            logger.error("审批买赠活动失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 审批买赠活动（不通过）
     * 
     * @param param
     *            终审相关参数
     * @return MsgBean
     */
    @RequestMapping(value = "/{param}/doFinalAuditActivityNoPass")
    @ResponseBody
    public MsgBean doFinalAuditActivityNoPass(@PathVariable String param) {
        try {
            Integer id = null;
            String finalAuditRejectReason = null;
            String[] finalAuditInfos = param.split(CommonConstants.DELIMITER_HR);
            if (finalAuditInfos.length == 2) {
                id = Integer.valueOf(finalAuditInfos[0]);
                finalAuditRejectReason = finalAuditInfos[1];
            } else {
                id = Integer.valueOf(finalAuditInfos[0]);
            }
            String preAuditStatus = SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FOR_FINAL_AUDIT;
            Date currentTime = DateUtils.getCurrentDateTime();
            Date finalAuditTime = currentTime;
            String auditStatus = SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FINAL_AUDIT_REJECTED;
            Integer finalAuditUserId = super.getUserId();
            Integer modifyUserId = super.getUserId();
            Date modifyTime = currentTime;
            BuyRewardActivityAuditDto buyRewardActivityAuditDto = buyRewardActivityAuditService.loadById(id);
            if (ObjectUtils.isNullOrEmpty(buyRewardActivityAuditDto)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "买赠活动信息查询异常");
            }
            buyRewardActivityAuditService.updateAuditStatusByFinalAudit(id, preAuditStatus, auditStatus, finalAuditUserId,
                    finalAuditTime, finalAuditRejectReason, modifyUserId, modifyTime);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "审批买赠活动成功");
        } catch (Exception e) {
            logger.error("审批买赠活动失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 审批买赠活动（不通过）
     * 
     * @param param
     *            终审相关参数
     * @return MsgBean
     */
    @RequestMapping(value = "/{param}/updateActivityTime")
    @ResponseBody
    public MsgBean updateActivityTime(@PathVariable String param) {
        try {
            Integer id = null;
            Date activityBegin = null;
            Date activityEnd = null;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            String[] Infos = param.split(CommonConstants.DELIMITER_UNDERLINE);
            String statusCode = null;
            if (Infos.length == 3) {
                statusCode = SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_NOTSTART;
                id = Integer.valueOf(Infos[0]);
                activityBegin = sdf.parse(Infos[1]);
                activityEnd = sdf.parse(Infos[2]);
            } else {
                statusCode = SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_STARTED;
                id = Integer.valueOf(Infos[0]);
                activityEnd = sdf.parse(Infos[1]);
            }
            String auditStatus = SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FINISHED;
            Date currentTime = DateUtils.getCurrentDateTime();
            Integer modifyUserId = super.getUserId();
            Date modifyTime = currentTime;
            BuyRewardActivityAuditDto buyRewardActivityAuditDto = buyRewardActivityAuditService.loadById(id);
            if (ObjectUtils.isNullOrEmpty(buyRewardActivityAuditDto)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "买赠活动信息查询异常");
            }
            buyRewardActivityAuditDto.setActivityBegin(activityBegin);
            buyRewardActivityAuditDto.setActivityEnd(activityEnd);
            buyRewardActivityAuditDto.setStatusCode(statusCode);
            buyRewardActivityAuditDto.setAuditStatus(auditStatus);
            buyRewardActivityAuditDto.setModifyUserId(modifyUserId);
            buyRewardActivityAuditDto.setModifyTime(modifyTime);
            buyRewardActivityAuditService.updateActivityTime(buyRewardActivityAuditDto);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "修改买赠活动时间段成功");
        } catch (Exception e) {
            logger.error("修改买赠活动时间段失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取买赠信息
     * 
     * @param 买赠活动id
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{id}/loadByAuditBuyRewardActivityId")
    @ResponseBody
    public MsgBean loadByBuyRewardActivityId(@PathVariable Integer id) {
        try {
            BuyRewardActivityAuditDto buyRewardAuditActivityDto = buyRewardActivityAuditService.loadById(id);
            return super.encapsulateMsgBean(buyRewardAuditActivityDto, MsgBean.MsgCode.SUCCESS, "查询活动信息成功");
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 新增买赠活动
     * 
     * @param buyRewardAuditActivityDto
     *            买赠活动DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/createAuditBuyRewardActivity")
    @ResponseBody
    public MsgBean createBuyRewardActivity(@RequestBody BuyRewardActivityAuditDto buyRewardAuditActivityDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(buyRewardAuditActivityDto)) {
                logger.info("buyRewardAuditActivityDto : " + buyRewardAuditActivityDto.toString());
                buyRewardAuditActivityDto.setCreateTime(new Date());
                buyRewardAuditActivityDto.setCreateUserId(super.getUserId());
                buyRewardActivityAuditService.saveBuyRewardActivity(buyRewardAuditActivityDto);
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "新增买赠活动成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "买赠活动参数为空");
            }
        } catch (Exception e) {
            logger.error("新增买赠活动失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 更新买赠活动
     * 
     * @param buyRewardAuditActivityDto
     *            买赠活动DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/updateAuditBuyRewardActivity")
    @ResponseBody
    public MsgBean updateBuyRewardActivity(@RequestBody BuyRewardActivityAuditDto buyRewardAuditActivityDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(buyRewardAuditActivityDto)) {
                logger.info("buyRewardAuditActivityDto : " + buyRewardAuditActivityDto.toString());
                buyRewardAuditActivityDto.setModifyTime(new Date());
                buyRewardAuditActivityDto.setModifyUserId(super.getUserId());
                buyRewardActivityAuditService.updateBuyRewardActivity(buyRewardAuditActivityDto);
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "更新买赠活动成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "买赠活动参数为空");
            }
        } catch (Exception e) {
            logger.error("新增买赠活动失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}
