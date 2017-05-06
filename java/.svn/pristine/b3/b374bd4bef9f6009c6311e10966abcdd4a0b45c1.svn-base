package com.yilidi.o2o.product.service.impl;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ProbabilityUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.proxy.ICouponProxyService;
import com.yilidi.o2o.order.proxy.dto.CouponProxyDto;
import com.yilidi.o2o.product.dao.ActivityMapper;
import com.yilidi.o2o.product.dao.RedEnvelopeActivityMapper;
import com.yilidi.o2o.product.dao.RedEnvelopeRewardMapper;
import com.yilidi.o2o.product.dao.UserRedEnvelopeActivityMapper;
import com.yilidi.o2o.product.model.Activity;
import com.yilidi.o2o.product.model.RedEnvelopeActivity;
import com.yilidi.o2o.product.model.RedEnvelopeReward;
import com.yilidi.o2o.product.model.UserRedEnvelopeActivity;
import com.yilidi.o2o.product.model.combination.RedEnvelopeActivityInfo;
import com.yilidi.o2o.product.model.query.RedEnvelopeActivityQuery;
import com.yilidi.o2o.product.service.IRedEnvelopeService;
import com.yilidi.o2o.product.service.dto.RedEnvelopeActivityDto;
import com.yilidi.o2o.product.service.dto.RedEnvelopeActivityFormDto;
import com.yilidi.o2o.product.service.dto.RedEnvelopeActivityInfoDto;
import com.yilidi.o2o.product.service.dto.RedEnvelopeRewardDto;
import com.yilidi.o2o.product.service.dto.UserRedEnvelopeActivityDto;
import com.yilidi.o2o.product.service.dto.query.RedEnvelopeActivityQueryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 红包Service实现类
 * 
 * @author: chenlian
 * @date: 2016年11月3日 上午11:12:39
 */
@Service("redEnvelopeService")
public class RedEnvelopeServiceImpl extends BasicDataService implements IRedEnvelopeService {

    @Autowired
    private RedEnvelopeActivityMapper redEnvelopeActivityMapper;

    @Autowired
    private RedEnvelopeRewardMapper redEnvelopeRewardMapper;

    @Autowired
    private UserRedEnvelopeActivityMapper userRedEnvelopeActivityMapper;

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private ICouponProxyService couponProxyService;
    
    @Override
    public Integer saveRedEnvelopeActivity(RedEnvelopeActivityDto redEnvelopeActivityDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityDto)) {
                throw new ProductServiceException("参数redEnvelopeActivityDto不能为空");
            }
            RedEnvelopeActivity redEnvelopeActivity = new RedEnvelopeActivity();
            ObjectUtils.fastCopy(redEnvelopeActivityDto, redEnvelopeActivity);
            redEnvelopeActivityMapper.save(redEnvelopeActivity);
            return redEnvelopeActivity.getId();
        } catch (Exception e) {
            logger.error("saveRedEnvelopeActivity异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateRedEnvelopeActivityById(RedEnvelopeActivityDto redEnvelopeActivityDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityDto)) {
                throw new ProductServiceException("参数redEnvelopeActivityDto不能为空");
            }
            RedEnvelopeActivity redEnvelopeActivity = new RedEnvelopeActivity();
            ObjectUtils.fastCopy(redEnvelopeActivityDto, redEnvelopeActivity);
            redEnvelopeActivityMapper.updateByIdSelective(redEnvelopeActivity);
        } catch (Exception e) {
            logger.error("updateRedEnvelopeActivityById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public RedEnvelopeActivityDto loadRedEnvelopeActivityById(Integer id) throws ProductServiceException {
        RedEnvelopeActivityDto redEnvelopeActivityDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("参数id不能为空");
            }
            RedEnvelopeActivity redEnvelopeActivity = redEnvelopeActivityMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(redEnvelopeActivity)) {
                redEnvelopeActivityDto = new RedEnvelopeActivityDto();
                ObjectUtils.fastCopy(redEnvelopeActivity, redEnvelopeActivityDto);
            }
            return redEnvelopeActivityDto;
        } catch (Exception e) {
            logger.error("loadRedEnvelopeActivityById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public RedEnvelopeActivityDto loadRedEnvelopeActivityByCurrentDateTime(Date currentDateTime)
            throws ProductServiceException {
        RedEnvelopeActivityDto redEnvelopeActivityDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(currentDateTime)) {
                throw new ProductServiceException("参数currentDateTime不能为空");
            }
            RedEnvelopeActivity redEnvelopeActivity = redEnvelopeActivityMapper.loadByCurrentDateTime(currentDateTime);
            if (!ObjectUtils.isNullOrEmpty(redEnvelopeActivity)) {
                redEnvelopeActivityDto = new RedEnvelopeActivityDto();
                ObjectUtils.fastCopy(redEnvelopeActivity, redEnvelopeActivityDto);
            }
            return redEnvelopeActivityDto;
        } catch (Exception e) {
            logger.error("loadRedEnvelopeActivityByCurrentDateTime异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public RedEnvelopeActivityDto loadRedEnvelopeActivityByGlobalActivityId(Integer globalActivityId)
            throws ProductServiceException {
        RedEnvelopeActivityDto redEnvelopeActivityDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(globalActivityId)) {
                throw new ProductServiceException("参数globalActivityId不能为空");
            }
            RedEnvelopeActivity redEnvelopeActivity = redEnvelopeActivityMapper.loadByGlobalActivityId(globalActivityId);
            if (!ObjectUtils.isNullOrEmpty(redEnvelopeActivity)) {
                redEnvelopeActivityDto = new RedEnvelopeActivityDto();
                ObjectUtils.fastCopy(redEnvelopeActivity, redEnvelopeActivityDto);
            }
            return redEnvelopeActivityDto;
        } catch (Exception e) {
            logger.error("loadRedEnvelopeActivityByGlobalActivityId异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<RedEnvelopeActivityInfoDto> findRedEnvelopeActivities(
            RedEnvelopeActivityQueryDto redEnvelopeActivityQueryDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityQueryDto)) {
                throw new ProductServiceException("参数redEnvelopeActivityQueryDto不能为空");
            }
            if (null == redEnvelopeActivityQueryDto.getStart() || redEnvelopeActivityQueryDto.getStart() <= 0) {
                redEnvelopeActivityQueryDto.setStart(1);
            }
            if (null == redEnvelopeActivityQueryDto.getPageSize() || redEnvelopeActivityQueryDto.getPageSize() <= 0) {
                redEnvelopeActivityQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            Page<RedEnvelopeActivityInfoDto> pageDto = new Page<RedEnvelopeActivityInfoDto>(
                    redEnvelopeActivityQueryDto.getStart(), redEnvelopeActivityQueryDto.getPageSize());
            RedEnvelopeActivityQuery redEnvelopeActivityQuery = new RedEnvelopeActivityQuery();
            ObjectUtils.fastCopy(redEnvelopeActivityQueryDto, redEnvelopeActivityQuery);
            PageHelper.startPage(redEnvelopeActivityQuery.getStart(), redEnvelopeActivityQuery.getPageSize());
            Page<RedEnvelopeActivityInfo> page = redEnvelopeActivityMapper
                    .findRedEnvelopeActivities(redEnvelopeActivityQuery);
            ObjectUtils.fastCopy(page, pageDto);
            List<RedEnvelopeActivityInfo> redEnvelopeActivityInfos = page.getResult();
            for (RedEnvelopeActivityInfo redEnvelopeActivityInfo : redEnvelopeActivityInfos) {
                RedEnvelopeActivityInfoDto redEnvelopeActivityInfoDto = new RedEnvelopeActivityInfoDto();
                ObjectUtils.fastCopy(redEnvelopeActivityInfo, redEnvelopeActivityInfoDto);
                Date currentDateTime = DateUtils.getCurrentDateTime();
                if (currentDateTime.before(redEnvelopeActivityInfo.getValidStartTime())) {
                    redEnvelopeActivityInfoDto.setStatus(SystemContext.ProductDomain.REDENVELOPEACTIVITYSTATUS_NOT_START);
                    redEnvelopeActivityInfoDto.setStatusName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.REDENVELOPEACTIVITYSTATUS.getValue(),
                            SystemContext.ProductDomain.REDENVELOPEACTIVITYSTATUS_NOT_START));
                }
                if (currentDateTime.after(redEnvelopeActivityInfo.getValidStartTime())
                        && currentDateTime.before(redEnvelopeActivityInfo.getValidEndTime())) {
                    redEnvelopeActivityInfoDto.setStatus(SystemContext.ProductDomain.REDENVELOPEACTIVITYSTATUS_STARTING);
                    redEnvelopeActivityInfoDto.setStatusName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.REDENVELOPEACTIVITYSTATUS.getValue(),
                            SystemContext.ProductDomain.REDENVELOPEACTIVITYSTATUS_STARTING));
                }
                if (currentDateTime.after(redEnvelopeActivityInfo.getValidEndTime())) {
                    redEnvelopeActivityInfoDto.setStatus(SystemContext.ProductDomain.REDENVELOPEACTIVITYSTATUS_END);
                    redEnvelopeActivityInfoDto.setStatusName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.REDENVELOPEACTIVITYSTATUS.getValue(),
                            SystemContext.ProductDomain.REDENVELOPEACTIVITYSTATUS_END));
                }
                List<RedEnvelopeRewardDto> redEnvelopeRewardDtoList = this.listRedEnvelopeRewards(
                        redEnvelopeActivityInfo.getId(), SystemContext.ProductDomain.REDENVELOPEREWARDSTATUS_VALID);
                if (!ObjectUtils.isNullOrEmpty(redEnvelopeRewardDtoList)) {
                    redEnvelopeActivityInfoDto.setRedEnvelopeRewards(redEnvelopeRewardDtoList);
                }
                pageDto.add(redEnvelopeActivityInfoDto);
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findRedEnvelopeActivities异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void saveRedEnvelopeReward(RedEnvelopeRewardDto redEnvelopeRewardDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(redEnvelopeRewardDto)) {
                throw new ProductServiceException("参数redEnvelopeRewardDto不能为空");
            }
            RedEnvelopeReward redEnvelopeReward = new RedEnvelopeReward();
            ObjectUtils.fastCopy(redEnvelopeRewardDto, redEnvelopeReward);
            redEnvelopeRewardMapper.save(redEnvelopeReward);
        } catch (Exception e) {
            logger.error("saveRedEnvelopeReward异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateRedEnvelopeRewardById(RedEnvelopeRewardDto redEnvelopeRewardDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(redEnvelopeRewardDto)) {
                throw new ProductServiceException("参数redEnvelopeRewardDto不能为空");
            }
            RedEnvelopeReward redEnvelopeReward = new RedEnvelopeReward();
            ObjectUtils.fastCopy(redEnvelopeRewardDto, redEnvelopeReward);
            redEnvelopeRewardMapper.updateById(redEnvelopeReward);
        } catch (Exception e) {
            logger.error("updateRedEnvelopeRewardById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public RedEnvelopeRewardDto loadRedEnvelopeRewardById(Integer id) throws ProductServiceException {
        RedEnvelopeRewardDto redEnvelopeRewardDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("参数id不能为空");
            }
            RedEnvelopeReward redEnvelopeReward = redEnvelopeRewardMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(redEnvelopeReward)) {
                redEnvelopeRewardDto = new RedEnvelopeRewardDto();
                ObjectUtils.fastCopy(redEnvelopeReward, redEnvelopeRewardDto);
            }
            return redEnvelopeRewardDto;
        } catch (Exception e) {
            logger.error("loadRedEnvelopeRewardById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<RedEnvelopeRewardDto> listRedEnvelopeRewards(Integer redEnvelopeActivityId, String rewardStatus)
            throws ProductServiceException {
        List<RedEnvelopeRewardDto> redEnvelopeRewardDtoList = null;
        try {
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityId)) {
                throw new ProductServiceException("参数redEnvelopeActivityId不能为空");
            }
            if (StringUtils.isEmpty(rewardStatus)) {
                throw new ProductServiceException("参数rewardStatus不能为空");
            }
            List<RedEnvelopeReward> redEnvelopeRewardList = redEnvelopeRewardMapper.listRedEnvelopeRewards(
                    redEnvelopeActivityId, rewardStatus);
            if (!ObjectUtils.isNullOrEmpty(redEnvelopeRewardList)) {
                redEnvelopeRewardDtoList = new ArrayList<RedEnvelopeRewardDto>();
                for (RedEnvelopeReward redEnvelopeReward : redEnvelopeRewardList) {
                    RedEnvelopeRewardDto redEnvelopeRewardDto = new RedEnvelopeRewardDto();
                    ObjectUtils.fastCopy(redEnvelopeReward, redEnvelopeRewardDto);
                    //获取券包id
                    if(redEnvelopeRewardDto.getRewardType().equals(SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_COUPON)){
                    	CouponProxyDto couponProxyDto = couponProxyService.loadCouponById(redEnvelopeRewardDto.getPrizeId());
                    	if(!ObjectUtils.isNullOrEmpty(couponProxyDto)){
                    		redEnvelopeRewardDto.setPackageId(couponProxyDto.getConPackId());
                    	}
                    }
                    redEnvelopeRewardDtoList.add(redEnvelopeRewardDto);
                }
            }
            return redEnvelopeRewardDtoList;
        } catch (Exception e) {
            logger.error("listRedEnvelopeRewards异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void saveWholeRedEnvelopeActivity(RedEnvelopeActivityFormDto redEnvelopeActivityFormDto)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityFormDto)) {
                throw new ProductServiceException("参数redEnvelopeActivityFormDto不能为空");
            }
            RedEnvelopeActivityDto redEnvelopeActivityDto = new RedEnvelopeActivityDto();
            redEnvelopeActivityDto.setActivityName(redEnvelopeActivityFormDto.getActivityName());
            redEnvelopeActivityDto.setValidStartTime(redEnvelopeActivityFormDto.getValidStartTime());
            redEnvelopeActivityDto.setValidEndTime(redEnvelopeActivityFormDto.getValidEndTime());
            redEnvelopeActivityDto.setInvokeProbability(redEnvelopeActivityFormDto.getInvokeProbability());
            redEnvelopeActivityDto.setRule(redEnvelopeActivityFormDto.getRule());
            redEnvelopeActivityDto.setCreateTime(redEnvelopeActivityFormDto.getCreateTime());
            redEnvelopeActivityDto.setCreateUserId(redEnvelopeActivityFormDto.getCreateUserId());
            Activity globalActivity = new Activity();
            globalActivity.setActivityName(redEnvelopeActivityFormDto.getActivityName());
            globalActivity.setActivityType(SystemContext.ProductDomain.ACTIVITYTYPE_REDENVELOPE);
            globalActivity.setCreateTime(redEnvelopeActivityFormDto.getCreateTime());
            globalActivity.setCreateUserId(redEnvelopeActivityFormDto.getCreateUserId());
            globalActivity.setUpdateUserId(redEnvelopeActivityFormDto.getCreateUserId());
            globalActivity.setUpdateTime(redEnvelopeActivityFormDto.getCreateTime());
            globalActivity.setStartTime(redEnvelopeActivityFormDto.getValidStartTime());
            globalActivity.setFinishTime(redEnvelopeActivityFormDto.getValidEndTime());
            activityMapper.save(globalActivity);
            redEnvelopeActivityDto.setGlobalActivityId(globalActivity.getId());
            Integer activityId = this.saveRedEnvelopeActivity(redEnvelopeActivityDto);
            String rewardInfos = redEnvelopeActivityFormDto.getRewardInfos();
            saveRewardInfos(activityId, rewardInfos, redEnvelopeActivityFormDto.getCreateTime(),
                    redEnvelopeActivityFormDto.getCreateUserId());
        } catch (Exception e) {
            logger.error("saveWholeRedEnvelopeActivity异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateWholeRedEnvelopeActivity(RedEnvelopeActivityFormDto redEnvelopeActivityFormDto)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityFormDto)) {
                throw new ProductServiceException("参数redEnvelopeActivityFormDto不能为空");
            }
            Integer activityId = redEnvelopeActivityFormDto.getActivityId();
            if (ObjectUtils.isNullOrEmpty(activityId)) {
                throw new ProductServiceException("需修改的红包活动ID不能为空");
            }
            RedEnvelopeActivityDto redEnvelopeActivityDto = this.loadRedEnvelopeActivityById(activityId);
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityDto)) {
                throw new ProductServiceException("需修改的红包活动不存在");
            }
            redEnvelopeActivityDto.setActivityName(redEnvelopeActivityFormDto.getActivityName());
            redEnvelopeActivityDto.setValidStartTime(redEnvelopeActivityFormDto.getValidStartTime());
            redEnvelopeActivityDto.setValidEndTime(redEnvelopeActivityFormDto.getValidEndTime());
            redEnvelopeActivityDto.setInvokeProbability(redEnvelopeActivityFormDto.getInvokeProbability());
            redEnvelopeActivityDto.setRule(redEnvelopeActivityFormDto.getRule());
            redEnvelopeActivityDto.setModifyTime(redEnvelopeActivityFormDto.getModifyTime());
            redEnvelopeActivityDto.setModifyUserId(redEnvelopeActivityFormDto.getModifyUserId());
            this.updateRedEnvelopeActivityById(redEnvelopeActivityDto);
            String rewardIds = redEnvelopeActivityFormDto.getRewardIds();
            String rewardInfos = redEnvelopeActivityFormDto.getRewardInfos();
            updateRewardInfos(activityId, rewardIds, rewardInfos, redEnvelopeActivityFormDto.getCreateTime(),
                    redEnvelopeActivityFormDto.getCreateUserId(), redEnvelopeActivityFormDto.getModifyTime(),
                    redEnvelopeActivityFormDto.getModifyUserId());
        } catch (Exception e) {
            logger.error("updateWholeRedEnvelopeActivity异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    private void saveRewardInfos(Integer activityId, String rewardInfos, Date createTime, Integer createUserId)
            throws ParseException {
        if (rewardInfos.contains(CommonConstants.DELIMITER_POUND)) {
            List<BigDecimal> probabilityList = new ArrayList<BigDecimal>();
            List<String> probabilityNums = null;
            StringTokenizer st = new StringTokenizer(rewardInfos, CommonConstants.DELIMITER_POUND);
            while (st.hasMoreTokens()) {
                StringTokenizer st1 = new StringTokenizer(st.nextToken(), CommonConstants.DELIMITER_COMMA);
                List<String> rewardInfoList = new ArrayList<String>();
                while (st1.hasMoreTokens()) {
                    rewardInfoList.add(st1.nextToken());
                }
                String winProbability = rewardInfoList.get(3);
                probabilityList.add(new BigDecimal(winProbability));
            }
            probabilityNums = ProbabilityUtils.getProbabilityNums(probabilityList);
            String[] rewardInfoArray = rewardInfos.split(CommonConstants.DELIMITER_POUND);
            for (int i = 0; i < rewardInfoArray.length; i++) {
                StringTokenizer st1 = new StringTokenizer(rewardInfoArray[i], CommonConstants.DELIMITER_COMMA);
                List<String> rewardInfoList = new ArrayList<String>();
                while (st1.hasMoreTokens()) {
                    rewardInfoList.add(st1.nextToken());
                }
                RedEnvelopeRewardDto redEnvelopeRewardDto = new RedEnvelopeRewardDto();
                String rewardType = rewardInfoList.get(0);
                redEnvelopeRewardDto.setRewardType(rewardType);
                if (SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_COUPON.equals(rewardType)
                        || SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_VOUCHER.equals(rewardType)) {
                    String prizeInfo = rewardInfoList.get(1);
                    String[] prizeInfoArray = prizeInfo.split(CommonConstants.DELIMITER_UNDERLINE);
                    Integer prizeId = Integer.parseInt(prizeInfoArray[0]);
                    redEnvelopeRewardDto.setPrizeId(prizeId);
                    Date prizeGrantTime = DateUtils.parseDate(prizeInfoArray[1]);
                    redEnvelopeRewardDto.setPrizeGrantTime(prizeGrantTime);
                    Integer releaseCount = Integer.parseInt(rewardInfoList.get(2));
                    redEnvelopeRewardDto.setReleaseCount(releaseCount);
                }
                String winProbability = rewardInfoList.get(3);
                redEnvelopeRewardDto.setRedEnvelopeActivityId(activityId);
                redEnvelopeRewardDto.setWinProbability(winProbability);
                redEnvelopeRewardDto.setProbabilityRandomNum(probabilityNums.get(i));
                Integer winCountLimit = Integer.parseInt(rewardInfoList.get(4));
                redEnvelopeRewardDto.setWinCountLimit(winCountLimit);
                redEnvelopeRewardDto.setRewardStatus(SystemContext.ProductDomain.REDENVELOPEREWARDSTATUS_VALID);
                redEnvelopeRewardDto.setCreateTime(createTime);
                redEnvelopeRewardDto.setCreateUserId(createUserId);
                this.saveRedEnvelopeReward(redEnvelopeRewardDto);
            }
        } else {
            StringTokenizer st = new StringTokenizer(rewardInfos, CommonConstants.DELIMITER_COMMA);
            List<String> rewardInfoList = new ArrayList<String>();
            while (st.hasMoreTokens()) {
                rewardInfoList.add(st.nextToken());
            }
            RedEnvelopeRewardDto redEnvelopeRewardDto = new RedEnvelopeRewardDto();
            String rewardType = rewardInfoList.get(0);
            redEnvelopeRewardDto.setRewardType(rewardType);
            if (SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_COUPON.equals(rewardType)
                    || SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_VOUCHER.equals(rewardType)) {
                String prizeInfo = rewardInfoList.get(1);
                String[] prizeInfoArray = prizeInfo.split(CommonConstants.DELIMITER_UNDERLINE);
                Integer prizeId = Integer.parseInt(prizeInfoArray[0]);
                redEnvelopeRewardDto.setPrizeId(prizeId);
                Date prizeGrantTime = DateUtils.parseDate(prizeInfoArray[1]);
                redEnvelopeRewardDto.setPrizeGrantTime(prizeGrantTime);
                Integer releaseCount = Integer.parseInt(rewardInfoList.get(2));
                redEnvelopeRewardDto.setReleaseCount(releaseCount);
            }
            String winProbability = rewardInfoList.get(3);
            redEnvelopeRewardDto.setRedEnvelopeActivityId(activityId);
            redEnvelopeRewardDto.setWinProbability(winProbability);
            List<BigDecimal> probabilityList = new ArrayList<BigDecimal>();
            probabilityList.add(new BigDecimal(winProbability));
            redEnvelopeRewardDto.setProbabilityRandomNum(ProbabilityUtils.getProbabilityNums(probabilityList).get(0));
            Integer winCountLimit = Integer.parseInt(rewardInfoList.get(4));
            redEnvelopeRewardDto.setWinCountLimit(winCountLimit);
            redEnvelopeRewardDto.setRewardStatus(SystemContext.ProductDomain.REDENVELOPEREWARDSTATUS_VALID);
            redEnvelopeRewardDto.setCreateTime(createTime);
            redEnvelopeRewardDto.setCreateUserId(createUserId);
            this.saveRedEnvelopeReward(redEnvelopeRewardDto);
        }
    }

    private void updateRewardInfos(Integer activityId, String rewardIds, String rewardInfos, Date createTime,
            Integer createUserId, Date modifyTime, Integer modifyUserId) throws ParseException {
        List<RedEnvelopeRewardDto> redEnvelopeRewardDtoList = this.listRedEnvelopeRewards(activityId,
                SystemContext.ProductDomain.REDENVELOPEREWARDSTATUS_VALID);
        if (StringUtils.isEmpty(rewardIds)) {
            if (!ObjectUtils.isNullOrEmpty(redEnvelopeRewardDtoList)) {
                for (RedEnvelopeRewardDto redEnvelopeRewardDto : redEnvelopeRewardDtoList) {
                    redEnvelopeRewardDto.setRewardStatus(SystemContext.ProductDomain.REDENVELOPEREWARDSTATUS_INVALID);
                    redEnvelopeRewardDto.setModifyTime(modifyTime);
                    redEnvelopeRewardDto.setModifyUserId(modifyUserId);
                    this.updateRedEnvelopeRewardById(redEnvelopeRewardDto);
                }
            }
            saveRewardInfos(activityId, rewardInfos, createTime, createUserId);
        } else {
            String[] rewardIdArray = rewardIds.split(CommonConstants.DELIMITER_COMMA);
            String[] rewardInfoArray = rewardInfos.split(CommonConstants.DELIMITER_POUND);
            if (rewardInfos.contains(CommonConstants.DELIMITER_POUND)) {
                List<BigDecimal> probabilityList = new ArrayList<BigDecimal>();
                List<String> probabilityNums = null;
                StringTokenizer st = new StringTokenizer(rewardInfos, CommonConstants.DELIMITER_POUND);
                while (st.hasMoreTokens()) {
                    StringTokenizer st1 = new StringTokenizer(st.nextToken(), CommonConstants.DELIMITER_COMMA);
                    List<String> rewardInfoList = new ArrayList<String>();
                    while (st1.hasMoreTokens()) {
                        rewardInfoList.add(st1.nextToken());
                    }
                    String winProbability = rewardInfoList.get(3);
                    probabilityList.add(new BigDecimal(winProbability));
                }
                probabilityNums = ProbabilityUtils.getProbabilityNums(probabilityList);
                for (int i = 0; i < rewardIdArray.length; i++) {
                    Integer rewardId = Integer.parseInt(rewardIdArray[i]);
                    String rewardInfo = rewardInfoArray[i];
                    StringTokenizer st1 = new StringTokenizer(rewardInfo, CommonConstants.DELIMITER_COMMA);
                    List<String> rewardInfoList = new ArrayList<String>();
                    while (st1.hasMoreTokens()) {
                        rewardInfoList.add(st1.nextToken());
                    }
                    RedEnvelopeRewardDto redEnvelopeRewardDto = this.loadRedEnvelopeRewardById(rewardId);
                    String rewardType = rewardInfoList.get(0);
                    redEnvelopeRewardDto.setRewardType(rewardType);
                    if (SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_COUPON.equals(rewardType)
                            || SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_VOUCHER.equals(rewardType)) {
                        String prizeInfo = rewardInfoList.get(1);
                        String[] prizeInfoArray = prizeInfo.split(CommonConstants.DELIMITER_UNDERLINE);
                        Integer prizeId = Integer.parseInt(prizeInfoArray[0]);
                        redEnvelopeRewardDto.setPrizeId(prizeId);
                        Date prizeGrantTime = DateUtils.parseDate(prizeInfoArray[1]);
                        redEnvelopeRewardDto.setPrizeGrantTime(prizeGrantTime);
                        Integer releaseCount = Integer.parseInt(rewardInfoList.get(2));
                        redEnvelopeRewardDto.setReleaseCount(releaseCount);
                    }
                    String winProbability = rewardInfoList.get(3);
                    redEnvelopeRewardDto.setWinProbability(winProbability);
                    redEnvelopeRewardDto.setProbabilityRandomNum(probabilityNums.get(i));
                    Integer winCountLimit = Integer.parseInt(rewardInfoList.get(4));
                    redEnvelopeRewardDto.setWinCountLimit(winCountLimit);
                    redEnvelopeRewardDto.setModifyTime(modifyTime);
                    redEnvelopeRewardDto.setModifyUserId(modifyUserId);
                    this.updateRedEnvelopeRewardById(redEnvelopeRewardDto);
                }
                if (!ObjectUtils.isNullOrEmpty(redEnvelopeRewardDtoList)) {
                    for (RedEnvelopeRewardDto redEnvelopeRewardDto : redEnvelopeRewardDtoList) {
                        Boolean isExist = false;
                        for (int i = 0; i < rewardIdArray.length; i++) {
                            Integer rewardId = Integer.parseInt(rewardIdArray[i]);
                            if (redEnvelopeRewardDto.getId().intValue() == rewardId.intValue()) {
                                isExist = true;
                                break;
                            }
                        }
                        if (!isExist) {
                            redEnvelopeRewardDto
                                    .setRewardStatus(SystemContext.ProductDomain.REDENVELOPEREWARDSTATUS_INVALID);
                            redEnvelopeRewardDto.setModifyTime(modifyTime);
                            redEnvelopeRewardDto.setModifyUserId(modifyUserId);
                            this.updateRedEnvelopeRewardById(redEnvelopeRewardDto);
                        }
                    }
                }
                if (rewardInfoArray.length > rewardIdArray.length) {
                    for (int i = rewardIdArray.length; i < rewardInfoArray.length; i++) {
                        StringTokenizer st1 = new StringTokenizer(rewardInfoArray[i], CommonConstants.DELIMITER_COMMA);
                        List<String> rewardInfoList = new ArrayList<String>();
                        while (st1.hasMoreTokens()) {
                            rewardInfoList.add(st1.nextToken());
                        }
                        RedEnvelopeRewardDto redEnvelopeRewardDto = new RedEnvelopeRewardDto();
                        String rewardType = rewardInfoList.get(0);
                        redEnvelopeRewardDto.setRewardType(rewardType);
                        if (SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_COUPON.equals(rewardType)
                                || SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_VOUCHER.equals(rewardType)) {
                            String prizeInfo = rewardInfoList.get(1);
                            String[] prizeInfoArray = prizeInfo.split(CommonConstants.DELIMITER_UNDERLINE);
                            Integer prizeId = Integer.parseInt(prizeInfoArray[0]);
                            redEnvelopeRewardDto.setPrizeId(prizeId);
                            Date prizeGrantTime = DateUtils.parseDate(prizeInfoArray[1]);
                            redEnvelopeRewardDto.setPrizeGrantTime(prizeGrantTime);
                            Integer releaseCount = Integer.parseInt(rewardInfoList.get(2));
                            redEnvelopeRewardDto.setReleaseCount(releaseCount);
                        }
                        String winProbability = rewardInfoList.get(3);
                        redEnvelopeRewardDto.setRedEnvelopeActivityId(activityId);
                        redEnvelopeRewardDto.setWinProbability(winProbability);
                        redEnvelopeRewardDto.setProbabilityRandomNum(probabilityNums.get(i));
                        Integer winCountLimit = Integer.parseInt(rewardInfoList.get(4));
                        redEnvelopeRewardDto.setWinCountLimit(winCountLimit);
                        redEnvelopeRewardDto.setRewardStatus(SystemContext.ProductDomain.REDENVELOPEREWARDSTATUS_VALID);
                        redEnvelopeRewardDto.setCreateTime(createTime);
                        redEnvelopeRewardDto.setCreateUserId(createUserId);
                        this.saveRedEnvelopeReward(redEnvelopeRewardDto);
                    }
                }
            } else {
                if (!ObjectUtils.isNullOrEmpty(redEnvelopeRewardDtoList)) {
                    for (RedEnvelopeRewardDto redEnvelopeRewardDto : redEnvelopeRewardDtoList) {
                        Boolean isExist = false;
                        for (int i = 0; i < rewardIdArray.length; i++) {
                            Integer rewardId = Integer.parseInt(rewardIdArray[i]);
                            if (redEnvelopeRewardDto.getId().intValue() == rewardId.intValue()) {
                                isExist = true;
                                break;
                            }
                        }
                        if (!isExist) {
                            redEnvelopeRewardDto
                                    .setRewardStatus(SystemContext.ProductDomain.REDENVELOPEREWARDSTATUS_INVALID);
                            redEnvelopeRewardDto.setModifyTime(modifyTime);
                            redEnvelopeRewardDto.setModifyUserId(modifyUserId);
                            this.updateRedEnvelopeRewardById(redEnvelopeRewardDto);
                        }
                    }
                }
                Integer rewardId = Integer.parseInt(rewardIdArray[0]);
                String rewardInfo = rewardInfoArray[0];
                StringTokenizer st = new StringTokenizer(rewardInfo, CommonConstants.DELIMITER_COMMA);
                List<String> rewardInfoList = new ArrayList<String>();
                while (st.hasMoreTokens()) {
                    rewardInfoList.add(st.nextToken());
                }
                RedEnvelopeRewardDto redEnvelopeRewardDto = this.loadRedEnvelopeRewardById(rewardId);
                String rewardType = rewardInfoList.get(0);
                redEnvelopeRewardDto.setRewardType(rewardType);
                if (SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_COUPON.equals(rewardType)
                        || SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_VOUCHER.equals(rewardType)) {
                    String prizeInfo = rewardInfoList.get(1);
                    String[] prizeInfoArray = prizeInfo.split(CommonConstants.DELIMITER_UNDERLINE);
                    Integer prizeId = Integer.parseInt(prizeInfoArray[0]);
                    redEnvelopeRewardDto.setPrizeId(prizeId);
                    Date prizeGrantTime = DateUtils.parseDate(prizeInfoArray[1]);
                    redEnvelopeRewardDto.setPrizeGrantTime(prizeGrantTime);
                    Integer releaseCount = Integer.parseInt(rewardInfoList.get(2));
                    redEnvelopeRewardDto.setReleaseCount(releaseCount);
                }
                String winProbability = rewardInfoList.get(3);
                redEnvelopeRewardDto.setWinProbability(winProbability);
                List<BigDecimal> probabilityList = new ArrayList<BigDecimal>();
                probabilityList.add(new BigDecimal(winProbability));
                redEnvelopeRewardDto.setProbabilityRandomNum(ProbabilityUtils.getProbabilityNums(probabilityList).get(0));
                Integer winCountLimit = Integer.parseInt(rewardInfoList.get(4));
                redEnvelopeRewardDto.setWinCountLimit(winCountLimit);
                redEnvelopeRewardDto.setModifyTime(modifyTime);
                redEnvelopeRewardDto.setModifyUserId(modifyUserId);
                this.updateRedEnvelopeRewardById(redEnvelopeRewardDto);
            }
        }
    }

    @Override
    public void saveUserActivity(UserRedEnvelopeActivityDto userRedEnvelopeActivityDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userRedEnvelopeActivityDto)) {
                throw new ProductServiceException("参数userRedEnvelopeActivityDto不能为空");
            }
            UserRedEnvelopeActivity userRedEnvelopeActivity = new UserRedEnvelopeActivity();
            ObjectUtils.fastCopy(userRedEnvelopeActivityDto, userRedEnvelopeActivity);
            userRedEnvelopeActivityMapper.save(userRedEnvelopeActivity);
        } catch (Exception e) {
            logger.error("saveUserActivity异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUserActivityById(UserRedEnvelopeActivityDto userRedEnvelopeActivityDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userRedEnvelopeActivityDto)) {
                throw new ProductServiceException("参数userRedEnvelopeActivityDto不能为空");
            }
            UserRedEnvelopeActivity userRedEnvelopeActivity = new UserRedEnvelopeActivity();
            ObjectUtils.fastCopy(userRedEnvelopeActivityDto, userRedEnvelopeActivity);
            userRedEnvelopeActivityMapper.updateById(userRedEnvelopeActivity);
        } catch (Exception e) {
            logger.error("updateUserActivityById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public Integer updateUserActivityByIdWithCountLimit(UserRedEnvelopeActivityDto record, Integer playCountLimit)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(record)) {
                throw new ProductServiceException("参数record不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(playCountLimit)) {
                throw new ProductServiceException("参数playCountLimit不能为空");
            }
            UserRedEnvelopeActivity userRedEnvelopeActivity = new UserRedEnvelopeActivity();
            ObjectUtils.fastCopy(record, userRedEnvelopeActivity);
            Integer affectedCount = userRedEnvelopeActivityMapper.updateByIdWithCountLimit(userRedEnvelopeActivity,
                    playCountLimit);
            return affectedCount;
        } catch (Exception e) {
            logger.error("updateUserActivityByIdWithCountLimit异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public Integer updateUserActivityByIdWithRedEnvelopeCount(Integer id) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("参数id不能为空");
            }
            Integer affectedCount = userRedEnvelopeActivityMapper.updateByIdWithRedEnvelopeCount(id);
            return affectedCount;
        } catch (Exception e) {
            logger.error("updateUserActivityByIdWithRedEnvelopeCount异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public UserRedEnvelopeActivityDto loadUserActivityById(Integer id) throws ProductServiceException {
        UserRedEnvelopeActivityDto userRedEnvelopeActivityDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("参数id不能为空");
            }
            UserRedEnvelopeActivity userRedEnvelopeActivity = userRedEnvelopeActivityMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(userRedEnvelopeActivity)) {
                userRedEnvelopeActivityDto = new UserRedEnvelopeActivityDto();
                ObjectUtils.fastCopy(userRedEnvelopeActivity, userRedEnvelopeActivityDto);
            }
            return userRedEnvelopeActivityDto;
        } catch (Exception e) {
            logger.error("loadUserActivityById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public UserRedEnvelopeActivityDto loadUserActivityByAIdAndUIdAndPDate(Integer redEnvelopeActivityId, Integer userId,
            Date playDate) throws ProductServiceException {
        UserRedEnvelopeActivityDto userRedEnvelopeActivityDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityId)) {
                throw new ProductServiceException("参数redEnvelopeActivityId不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(userId)) {
                throw new ProductServiceException("参数userId不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(playDate)) {
                throw new ProductServiceException("参数playDate不能为空");
            }
            UserRedEnvelopeActivity userRedEnvelopeActivity = userRedEnvelopeActivityMapper
                    .loadByActivityIdAndUserIdAndPlayDate(redEnvelopeActivityId, userId, playDate);
            if (!ObjectUtils.isNullOrEmpty(userRedEnvelopeActivity)) {
                userRedEnvelopeActivityDto = new UserRedEnvelopeActivityDto();
                ObjectUtils.fastCopy(userRedEnvelopeActivity, userRedEnvelopeActivityDto);
            }
            return userRedEnvelopeActivityDto;
        } catch (Exception e) {
            logger.error("loadUserActivityByAIdAndUIdAndPDate异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<RedEnvelopeActivityDto> listRedEnvelopeActivities() throws ProductServiceException {
        List<RedEnvelopeActivityDto> redEnvelopeActivityDtoList = null;
        try {
            List<RedEnvelopeActivity> redEnvelopeActivityList = redEnvelopeActivityMapper.listRedEnvelopeActivities();
            if (!ObjectUtils.isNullOrEmpty(redEnvelopeActivityList)) {
                redEnvelopeActivityDtoList = new ArrayList<RedEnvelopeActivityDto>();
                for (RedEnvelopeActivity redEnvelopeActivity : redEnvelopeActivityList) {
                    RedEnvelopeActivityDto redEnvelopeActivityDto = new RedEnvelopeActivityDto();
                    ObjectUtils.fastCopy(redEnvelopeActivity, redEnvelopeActivityDto);
                    redEnvelopeActivityDtoList.add(redEnvelopeActivityDto);
                }
            }
            return redEnvelopeActivityDtoList;
        } catch (Exception e) {
            logger.error("listRedEnvelopeActivities异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

}
