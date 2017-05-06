package com.yilidi.o2o.controller.mobile.buyer.user;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.user.EvaluationInfoParam;
import com.yilidi.o2o.appparam.buyer.user.GetEvaluationParam;
import com.yilidi.o2o.appparam.buyer.user.SaleProductEvaluationImageParam;
import com.yilidi.o2o.appparam.buyer.user.SaleProductEvaluationInfoParam;
import com.yilidi.o2o.appvo.buyer.user.EvaluationImageVo;
import com.yilidi.o2o.appvo.buyer.user.EvaluationSummaryVO;
import com.yilidi.o2o.appvo.buyer.user.SaleProductEvaluationVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.BuyerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.SaleOrderDto;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.user.service.ISaleProductEvaluationService;
import com.yilidi.o2o.user.service.IStoreEvaluationService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.SaleProductEvaluationDto;
import com.yilidi.o2o.user.service.dto.SaleProductEvaluationImageProfileDto;
import com.yilidi.o2o.user.service.dto.StoreEvaluationDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.query.SaleProductEvaluateQuery;

/**
 * <p>
 * Company:Yilidi
 * </p>
 * <p>
 * Title:店铺及商品评论
 * </p>
 * 
 * @author xiasl
 * @date 2017年2月9日
 */
@Controller("buyerEvaluationController")
@RequestMapping(value = "/interfaces/buyer")
public class EvaluationController extends BuyerBaseController {
    private static final String CONTENT_STR_INIT = "此用户没有填写心得";
    private static final String ANONYMITY_STR = "匿名用户";
    @Autowired
    private IStoreEvaluationService storeEvaluationService;

    @Autowired
    private ISaleProductEvaluationService saleProductEvaluationService;

    @Autowired
    private IOrderService orderService;

    @Autowired
    private IUserService userService;

    /**
     * 保存店铺评论信息接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/evaluate/saveevaluation")
    @ResponseBody
    public ResultParamModel saveEvaluation(HttpServletRequest req, HttpServletResponse resp) {
        EvaluationInfoParam param = super.getEntityParam(req, EvaluationInfoParam.class);
        Float serviceScore = param.getServiceScore();
        Float deliverScore = param.getDeliverScore();
        Integer isAnonymous = param.getIsAnonymous();
        String saleOrderNo = param.getSaleOrderNo();
        SaleOrderDto saleOrderDto = orderService.loadBySaleOrderNo(saleOrderNo);
        if (ObjectUtils.isNullOrEmpty(saleOrderDto)) {
            throw new UserServiceException("订单：" + saleOrderNo + "不存在！");
        }
        if (!saleOrderDto.getStatusCode().equals(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED)) {
            throw new UserServiceException("订单：" + saleOrderNo + "未完成！");
        }
        if (saleOrderDto.getAppraiseFlag().equals(SystemContext.OrderDomain.APPRAISEFLAG_YES)) {
            throw new UserServiceException("订单：" + saleOrderNo + "已评价！");
        }
        Date currentTime = new Date();
        Integer storeId = saleOrderDto.getStoreId();
        List<String> photoUrls = new ArrayList<String>();
        List<SaleProductEvaluationInfoParam> saleProductEvaluations = param.getSaleProductEvaluations();
        StoreEvaluationDto storeEvaluationDto = new StoreEvaluationDto();
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        Integer attitudeStar = Integer.valueOf(serviceScore.toString().substring(0, 1));
        Integer sendStar = Integer.valueOf(deliverScore.toString().substring(0, 1));
        String ifAnonymity = SystemContext.UserDomain.STOREEVALUATIONANONYMITYEVAL_NO;
        if (1 == isAnonymous) {
            ifAnonymity = SystemContext.UserDomain.STOREEVALUATIONANONYMITYEVAL_YES;
        }

        storeEvaluationDto.setSaleOrderNo(saleOrderNo);
        storeEvaluationDto.setStoreId(storeId);
        storeEvaluationDto.setAttitudeStar(attitudeStar > 5 ? 5 : attitudeStar);
        storeEvaluationDto.setSendStar(sendStar > 5 ? 5 : sendStar);
        storeEvaluationDto.setUserId(userSession.getUserId());
        storeEvaluationDto.setSystemEvaluate(SystemContext.UserDomain.STOREEVALUATIONSYSTEMEVAL_NO);
        storeEvaluationDto.setAnonymityEvaluate(ifAnonymity);
        storeEvaluationDto.setShowStatus(SystemContext.UserDomain.STOREEVALUATIONSTATUS_YES);
        storeEvaluationDto.setCreateTime(currentTime);
        List<SaleProductEvaluationDto> list = new ArrayList<SaleProductEvaluationDto>();
        for (SaleProductEvaluationInfoParam spParam : saleProductEvaluations) {
            SaleProductEvaluationDto saleProductEvaluationDto = new SaleProductEvaluationDto();
            saleProductEvaluationDto.setSaleOrderNo(saleOrderNo);
            saleProductEvaluationDto.setAnonymityEvaluate(ifAnonymity);
            saleProductEvaluationDto.setShowStatus(SystemContext.UserDomain.STOREEVALUATIONSTATUS_YES);
            saleProductEvaluationDto.setSystemEvaluate(SystemContext.UserDomain.STOREEVALUATIONSYSTEMEVAL_NO);
            saleProductEvaluationDto.setUserName(userSession.getUserName());
            saleProductEvaluationDto.setSaleProductId(spParam.getSaleProductId());
            saleProductEvaluationDto.setStoreId(storeId);
            saleProductEvaluationDto.setCreateTime(currentTime);
            Integer productStar = Integer.valueOf(spParam.getSaleProductScore().toString().substring(0, 1));
            saleProductEvaluationDto.setProductStar(productStar > 5 ? 5 : productStar);
            if (!StringUtils.isEmpty(spParam.getEvaluateContent())) {
                saleProductEvaluationDto.setContent(spParam.getEvaluateContent());
            }
            if (ObjectUtils.isNullOrEmpty(spParam.getEvaluateImages())) {
                saleProductEvaluationDto.setUploadPhotoFlag(SystemContext.UserDomain.SALEPRODUCTEVALUATIONPHOTOFLAG_NO);
            } else {
                saleProductEvaluationDto.setUploadPhotoFlag(SystemContext.UserDomain.SALEPRODUCTEVALUATIONPHOTOFLAG_YES);
                StringBuffer imgUrl = new StringBuffer("");

                for (SaleProductEvaluationImageParam ImageParam : spParam.getEvaluateImages()) {
                    if (!StringUtils.isEmpty(ImageParam.getImageUrl())) {
                        imgUrl.append(StringUtils.getUrlPathName(ImageParam.getImageUrl()) + ";");
                        photoUrls.add(StringUtils.getUrlPathName(ImageParam.getImageUrl()));
                    }
                }
                if (imgUrl.toString().length() > 0) {
                    saleProductEvaluationDto.setPhotoUrl(imgUrl.toString().substring(0, imgUrl.toString().length() - 1));
                }
            }
            list.add(saleProductEvaluationDto);
        }
        if (!ObjectUtils.isNullOrEmpty(photoUrls)) {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            for (String photoUrl : photoUrls) {
                fileUploadUtils.uploadPublishFile(photoUrl);
                String srcPhotoUrl = getSrcImagePathByThumb(photoUrl);
                logger.info("photoUrl:" + photoUrl);
                logger.info("srcPhotoUrl:" + srcPhotoUrl);
                if (!photoUrl.equals(srcPhotoUrl)) {
                    fileUploadUtils.uploadPublishFile(srcPhotoUrl);
                }
            }
        }
        storeEvaluationService.saveForApp(storeEvaluationDto, list);
        return super.encapsulateParam(null, AppMsgBean.MsgCode.SUCCESS, "店铺商品评价保存成功");
    }

    /**
     * 获取商品评价内容信息接口
     * 
     * @Description 获取商品评价内容信息接口
     * @param req
     *            request请求
     * @param resp
     *            response响应
     * @return ResultParamModel
     */
    @RequestMapping(value = "/product/getevaluations")
    @ResponseBody
    public ResultParamModel getevaluations(HttpServletRequest req, HttpServletResponse resp) {
        GetEvaluationParam getEvaluationParam = super.getEntityParam(req, GetEvaluationParam.class);
        Integer saleProductId = getEvaluationParam.getSaleProductId();// 店铺Id
        String summaryValue = getEvaluationParam.getSummaryValue();
        Integer pageNum = getEvaluationParam.getPageNum();
        Integer pageSize = getEvaluationParam.getPageSize();
        if (StringUtils.isEmpty(summaryValue)) {
            summaryValue = WebConstants.ALL_EVALUATION_TYPE;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SaleProductEvaluateQuery saleProductEvaluateQuery = new SaleProductEvaluateQuery();
        saleProductEvaluateQuery.setSaleProductId(saleProductId);
        saleProductEvaluateQuery.setShowStatus(SystemContext.UserDomain.STOREEVALUATIONSTATUS_YES);
        List<Integer> productStars = new ArrayList<Integer>();
        saleProductEvaluateQuery.setOrder("A.PRODUCTSTAR DESC, A.CREATETIME "); // 评价排序
        saleProductEvaluateQuery.setSort("DESC");
        if (!summaryValue.equals(WebConstants.ALL_EVALUATION_TYPE)
                && !summaryValue.equals(WebConstants.PHOTO_EVALUATION_TYPE)) {
            String code = null;
            if (summaryValue.equals(WebConstants.MODERATE_EVALUATION_TYPE)) {
                code = WebConstants.MODERATE_EVALUATION_CODE;
            } else if (summaryValue.equals(WebConstants.NEGATIVE_EVALUATION_TYPE)) {
                code = WebConstants.NEGATIVE_EVALUATION_CODE;
            } else {
                code = WebConstants.POSITIVE_EVALUATION_CODE;
            }
            String[] codes = code.split(",");
            for (int i = 0; i < codes.length; i++) {
                productStars.add(Integer.parseInt(codes[i]));
            }
            saleProductEvaluateQuery.setProductStars(productStars);
        } else if (summaryValue.equals(WebConstants.PHOTO_EVALUATION_TYPE)) {
            saleProductEvaluateQuery.setUploadPhotoFlag(SystemContext.UserDomain.SALEPRODUCTEVALUATIONPHOTOFLAG_YES);
            saleProductEvaluateQuery.setOrder(" A.CREATETIME "); // 评价时间
        }
        saleProductEvaluateQuery.setPageSize(pageSize);
        saleProductEvaluateQuery.setStart(pageNum);
        YiLiDiPage<SaleProductEvaluationDto> page = saleProductEvaluationService
                .findSaleProductEvaluations(saleProductEvaluateQuery);
        List<SaleProductEvaluationDto> saleProductEvaluationDtoList = page.getResultList();
        List<SaleProductEvaluationVO> saleProductEvaluationVOList = new ArrayList<SaleProductEvaluationVO>();
        if (!ObjectUtils.isNullOrEmpty(saleProductEvaluationDtoList)) {
            for (SaleProductEvaluationDto spEvaluationDto : saleProductEvaluationDtoList) {
                SaleProductEvaluationVO saleProductEvaluationVO = new SaleProductEvaluationVO();
                if (!StringUtils.isEmpty(spEvaluationDto.getContent())) {
                    saleProductEvaluationVO.setEvaluateContent(spEvaluationDto.getContent());
                } else {
                    saleProductEvaluationVO.setEvaluateContent(CONTENT_STR_INIT);
                }
                saleProductEvaluationVO.setCreateTime(sdf.format(spEvaluationDto.getCreateTime()));
                saleProductEvaluationVO.setSaleProductScore(Float.valueOf(spEvaluationDto.getProductStar().toString()));
                List<EvaluationImageVo> evaluateImages = new ArrayList<EvaluationImageVo>();
                if (!ObjectUtils.isNullOrEmpty(spEvaluationDto.getSaleProductEvaluationImageProfileDtos())) {
                    for (SaleProductEvaluationImageProfileDto ImageProfileDto : spEvaluationDto
                            .getSaleProductEvaluationImageProfileDtos()) {
                        EvaluationImageVo evaluationImageVo = new EvaluationImageVo();
                        if (!StringUtils.isEmpty(ImageProfileDto.getAppPicPath())) {
                            evaluationImageVo.setImageUrl(StringUtils.toFullImageUrl(ImageProfileDto.getAppPicPath()));
                            evaluateImages.add(evaluationImageVo);
                        }
                    }
                }
                saleProductEvaluationVO.setEvaluateImages(evaluateImages);
                UserDto userDto = userService.loadUserByNameAndType(spEvaluationDto.getUserName(),
                        SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
                if (!ObjectUtils.isNullOrEmpty(userDto) && !ObjectUtils.isNullOrEmpty(userDto.getUserProfileDto())) {
                    saleProductEvaluationVO.setUserImageUrl(userDto.getUserProfileDto().getUserImageUrl() == null ? ""
                            : StringUtils.toFullImageUrl(userDto.getUserProfileDto().getUserImageUrl()));
                }
                if (spEvaluationDto.getAnonymityEvaluate()
                        .equals(SystemContext.UserDomain.STOREEVALUATIONANONYMITYEVAL_YES)) {
                    saleProductEvaluationVO.setUserName(ANONYMITY_STR);
                } else {
                    saleProductEvaluationVO
                            .setUserName(spEvaluationDto.getUserName().replaceAll("(\\d{3})(\\d{4})\\d{4}", "$1$2****"));
                }
                saleProductEvaluationVOList.add(saleProductEvaluationVO);
            }
        }

        return super.encapsulatePageParam(page, saleProductEvaluationVOList, AppMsgBean.MsgCode.SUCCESS, "获取品牌列表成功");
    }

    /**
     * 获取商品评价内容信息接口
     * 
     * @Description 获取商品评价内容信息接口
     * @param req
     *            request请求
     * @param resp
     *            response响应
     * @return ResultParamModel
     */
    @RequestMapping(value = "/product/getevaluationsummary")
    @ResponseBody
    public ResultParamModel getevaluationsummary(HttpServletRequest req, HttpServletResponse resp) {
        GetEvaluationParam getEvaluationParam = super.getEntityParam(req, GetEvaluationParam.class);
        Integer saleProductId = getEvaluationParam.getSaleProductId();// 店铺Id
        List<SaleProductEvaluationDto> saleProductEvaluationDtoList = saleProductEvaluationService
                .listSaleProductEvaluationBysaleProductId(saleProductId);

        List<EvaluationSummaryVO> evaluationSummaryVOList = new ArrayList<EvaluationSummaryVO>();
        EvaluationSummaryVO allEva = new EvaluationSummaryVO(WebConstants.ALL_EVALUATION_TYPENAME,
                WebConstants.ALL_EVALUATION_TYPE, 0);
        EvaluationSummaryVO positiveEva = new EvaluationSummaryVO(WebConstants.POSITIVE_EVALUATION_TYPENAME,
                WebConstants.POSITIVE_EVALUATION_TYPE, 0);
        EvaluationSummaryVO moderateEva = new EvaluationSummaryVO(WebConstants.MODERATE_EVALUATION_TYPENAME,
                WebConstants.MODERATE_EVALUATION_TYPE, 0);
        EvaluationSummaryVO negativeEva = new EvaluationSummaryVO(WebConstants.NEGATIVE_EVALUATION_TYPENAME,
                WebConstants.NEGATIVE_EVALUATION_TYPE, 0);
        EvaluationSummaryVO photoEva = new EvaluationSummaryVO(WebConstants.PHOTO_EVALUATION_TYPENAME,
                WebConstants.PHOTO_EVALUATION_TYPE, 0);
        if (!ObjectUtils.isNullOrEmpty(saleProductEvaluationDtoList)) {
            for (SaleProductEvaluationDto spEvaluationDto : saleProductEvaluationDtoList) {
                if (SystemContext.UserDomain.STOREEVALUATIONSTATUS_YES.equals(spEvaluationDto.getShowStatus())) {
                    allEva.setSummaryCount(allEva.getSummaryCount() + 1);// 全部评价
                    if (SystemContext.UserDomain.SALEPRODUCTEVALUATIONPHOTOFLAG_YES
                            .equals(spEvaluationDto.getUploadPhotoFlag())) {
                        photoEva.setSummaryCount(photoEva.getSummaryCount() + 1);// 有图
                    }
                    if (spEvaluationDto.getProductStar() >= 4) {// 好评
                        positiveEva.setSummaryCount(positiveEva.getSummaryCount() + 1);
                    }
                    if (spEvaluationDto.getProductStar() <= 1) {// 差评
                        negativeEva.setSummaryCount(negativeEva.getSummaryCount() + 1);
                    }
                    if (spEvaluationDto.getProductStar() == 2 || spEvaluationDto.getProductStar() == 3) {// 中评
                        moderateEva.setSummaryCount(moderateEva.getSummaryCount() + 1);
                    }
                }

            }
        }
        evaluationSummaryVOList.add(allEva);
        evaluationSummaryVOList.add(positiveEva);
        evaluationSummaryVOList.add(moderateEva);
        evaluationSummaryVOList.add(negativeEva);
        evaluationSummaryVOList.add(photoEva);
        return super.encapsulateParam(evaluationSummaryVOList, AppMsgBean.MsgCode.SUCCESS, "获取品牌列表成功");
    }

    private String getSrcImagePathByThumb(String thumbImagePath) {
        if (ObjectUtils.isNullOrEmpty(thumbImagePath)) {
            return StringUtils.EMPTY;
        }
        int index = thumbImagePath.lastIndexOf(CommonConstants.BACKSLASH);
        String thumbImageName = thumbImagePath;
        String hostName = null;
        String srcImageName = null;
        if (index > 0) {
            thumbImageName = thumbImagePath.substring(index + 1);
            hostName = thumbImagePath.substring(0, index + 1);
        }
        index = thumbImageName.lastIndexOf(CommonConstants.THUMBNAILNAME_PREFFIX);
        if (index != -1) {
            srcImageName = thumbImageName.substring(index + CommonConstants.THUMBNAILNAME_PREFFIX.length());
        }
        if (ObjectUtils.isNullOrEmpty(srcImageName)) {
            return StringUtils.EMPTY;
        }
        if (!ObjectUtils.isNullOrEmpty(hostName)) {
            return hostName + srcImageName;
        }
        return srcImageName;
    }
}
