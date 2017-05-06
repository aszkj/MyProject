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
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.proxy.IOrderProxyService;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.StoreEvaluationMapper;
import com.yilidi.o2o.user.model.StoreEvaluation;
import com.yilidi.o2o.user.model.StoreEvaluationScore;
import com.yilidi.o2o.user.model.combination.StoreEvaluationInfo;
import com.yilidi.o2o.user.service.ISaleProductEvaluationService;
import com.yilidi.o2o.user.service.IStoreEvaluationService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.dto.SaleProductEvaluationDto;
import com.yilidi.o2o.user.service.dto.StoreEvaluationDto;
import com.yilidi.o2o.user.service.dto.StoreEvaluationScoreDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.query.StoreEvaluateQuery;

/**
 * 功能描述：门店评价数据层操作接口服务实现类 <br/>
 * 作者：llp <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("storeEvaluationService")
public class StoreEvaluationServiceImpl extends BasicDataService implements IStoreEvaluationService {
    @Autowired
    private StoreEvaluationMapper storeEvaluationMapper;
    @Autowired
    private IStoreProfileService storeProfileService;
    @Autowired
    private IOrderProxyService orderProxyService;
    @Autowired
    private ISaleProductEvaluationService saleProductEvaluationService;

    private static final Integer DATESTART = 3;// 随机时间3天前
    private static final Integer DATEEND = 30;// 随机时间30天内
    private static final String SYSTEMSALEORDERNO = "系统订单";// 系统评价订单号
    private static final Double STORESCORE_INIT = 5.0;
    private static final Integer STORESCORE_ROUNDSCALE = 0;//店铺评分保留的小数点位数

    @Override
    public void save(StoreEvaluationDto record) throws UserServiceException {
        try {
            StoreEvaluation storeEvaluation = new StoreEvaluation();
            ObjectUtils.fastCopy(record, storeEvaluation);
            if (StringUtils.isEmpty(storeEvaluation.getSaleOrderNo())) {
                storeEvaluation.setSaleOrderNo(SYSTEMSALEORDERNO);
            }
            this.storeEvaluationMapper.save(storeEvaluation);
            if (!storeEvaluation.getSaleOrderNo().equals(SYSTEMSALEORDERNO)) {
                orderProxyService.updateOrderStatusForAppraise(record.getSaleOrderNo(), record.getUserId());
            }
        } catch (Exception e) {
            logger.error("saveStoreEvaluation异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void saveForApp(StoreEvaluationDto storeEvaluationDto, List<SaleProductEvaluationDto> saleProductEvaluations)throws UserServiceException {
        try {
            if(!ObjectUtils.isNullOrEmpty(saleProductEvaluations)){
                for(SaleProductEvaluationDto saleProductEvaluationDto : saleProductEvaluations){
                    saleProductEvaluationService.saveForApp(saleProductEvaluationDto);
                }
            }
            this.save(storeEvaluationDto);
        } catch (Exception e) {
            logger.error("saveForApp异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void deleteById(Integer id) throws UserServiceException {
        try {
            storeEvaluationMapper.deleteById(id);
        } catch (Exception e) {
            logger.error("deleteById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateShowStatusById(Integer id, String showStatus) throws UserServiceException {
        try {
            StoreEvaluation storeEvaluation = new StoreEvaluation();
            storeEvaluation.setId(id);
            storeEvaluation.setShowStatus(showStatus);
            storeEvaluation.setCreateTime(new Date());
            storeEvaluationMapper.updateShowStatusById(storeEvaluation);
        } catch (Exception e) {
            logger.error("updateShowStatusById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public StoreEvaluationDto loadById(Integer id) throws UserServiceException {
        try {
            StoreEvaluation storeEvaluation = storeEvaluationMapper.loadById(id);
            StoreEvaluationDto storeEvaluationDto = null;
            if (null != storeEvaluation) {
                storeEvaluationDto = new StoreEvaluationDto();
                ObjectUtils.fastCopy(storeEvaluation, storeEvaluationDto);
            }
            return storeEvaluationDto;
        } catch (Exception e) {
            logger.error("loadById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public StoreEvaluationDto loadStoreEvaluationDetailById(Integer id) {
        try {
            StoreEvaluationInfo storeEvaluationInfo = storeEvaluationMapper.loadDetailById(id);
            StoreEvaluationDto storeEvaluationDto = null;
            if (null != storeEvaluationInfo) {
                storeEvaluationDto = new StoreEvaluationDto();
                ObjectUtils.fastCopy(storeEvaluationInfo, storeEvaluationDto);
            }
            return storeEvaluationDto;
        } catch (Exception e) {
            logger.error("loadStoreEvaluationDetailById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public List<StoreEvaluationDto> listStoreEvaluationByStoreId(Integer storeId) throws UserServiceException {
        try {
            List<StoreEvaluationInfo> storeEvaluationInfoList = storeEvaluationMapper.listByStoreId(storeId);
            List<StoreEvaluationDto> storeEvaluationDtos = null;
            if (!ObjectUtils.isNullOrEmpty(storeEvaluationInfoList)) {
                storeEvaluationDtos = new ArrayList<StoreEvaluationDto>();
                for (StoreEvaluationInfo storeEvaluationInfo : storeEvaluationInfoList) {
                    StoreEvaluationDto storeEvaluationDto = new StoreEvaluationDto();
                    ObjectUtils.fastCopy(storeEvaluationInfo, storeEvaluationDto);
                    storeEvaluationDtos.add(storeEvaluationDto);
                }
            }
            return storeEvaluationDtos;
        } catch (Exception e) {
            logger.error("listStoreEvaluationByStoreId异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<StoreEvaluationDto> findStoreEvaluations(StoreEvaluateQuery query) throws UserServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
                query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
            }
            if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
                query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());
            Page<StoreEvaluationInfo> page = storeEvaluationMapper.findStoreEvaluations(query);
            Page<StoreEvaluationDto> pageDto = new Page<StoreEvaluationDto>(query.getStart(), query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<StoreEvaluationInfo> storeEvaluationInfos = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(storeEvaluationInfos)) {
                for (StoreEvaluationInfo storeEvaluationInfo : storeEvaluationInfos) {
                    StoreEvaluationDto storeEvaluationDto = new StoreEvaluationDto();
                    ObjectUtils.fastCopy(storeEvaluationInfo, storeEvaluationDto);
                    pageDto.add(storeEvaluationDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findStoreEvaluations异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }
    
    @Override
    public List<StoreEvaluationDto> listDataExportStoreEvaluation(StoreEvaluateQuery query, Long startLineNum,
            Integer pageSize) throws UserServiceException {
        try {
            if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
                query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
            }
            if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
                query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
            }
            List<StoreEvaluationInfo> storeEvaluationInfos = storeEvaluationMapper.listDataForExportStoreEvaluation(query,
                    startLineNum, pageSize);
            List<StoreEvaluationDto> storeEvaluationDtos = new ArrayList<StoreEvaluationDto>();
            if (!ObjectUtils.isNullOrEmpty(storeEvaluationInfos)) {
                for (StoreEvaluationInfo storeEvaluationInfo : storeEvaluationInfos) {
                    StoreEvaluationDto storeEvaluationDto = new StoreEvaluationDto();
                    ObjectUtils.fastCopy(storeEvaluationInfo, storeEvaluationDto);
                    storeEvaluationDtos.add(storeEvaluationDto);
                }
            }
            return storeEvaluationDtos;
        } catch (Exception e) {
            logger.error("listDataExportStoreEvaluation异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportStoreEvaluation(StoreEvaluateQuery query) throws UserServiceException {
        try {
            if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
                query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
            }
            if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
                query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
            }
            return storeEvaluationMapper.getCountsForExportStoreEvaluation(query);
        } catch (Exception e) {
            logger.error("getCountsForExportStoreEvaluation异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void saveStoreEvaluationDtoBatch(List<StoreEvaluationDto> storeEvaluationDtoList) throws UserServiceException {
        logger.debug("storeEvaluationDtoList -> " + storeEvaluationDtoList);
        try {
            // 检查产品列表参数是否为空
            if (ObjectUtils.isNullOrEmpty(storeEvaluationDtoList)) {
                logger.error("saveStoreEvaluationDtoBatch => 需要保存的店铺评论列表参数为空");
                throw new UserServiceException("需要保存的店铺评论列表为空");
            }
            List<StoreEvaluationDto> list = new ArrayList<StoreEvaluationDto>();
            if (!ObjectUtils.isNullOrEmpty(storeEvaluationDtoList)) {
                for (StoreEvaluationDto storeEvaluationDto : storeEvaluationDtoList) {
                    if (!ObjectUtils.isNullOrEmpty(storeEvaluationDto)) {
                        StoreProfileDto existDto = storeProfileService.loadByStoreCode(storeEvaluationDto.getStoreCode());
                        if (existDto.getStoreName().equals(storeEvaluationDto.getStoreName())) {
                            storeEvaluationDto.setStoreId(existDto.getStoreId());
                            storeEvaluationDto.setSaleOrderNo(SYSTEMSALEORDERNO);
                            storeEvaluationDto.setSystemEvaluate(SystemContext.UserDomain.STOREEVALUATIONSYSTEMEVAL_YES);
                            storeEvaluationDto
                                    .setAnonymityEvaluate(SystemContext.UserDomain.STOREEVALUATIONANONYMITYEVAL_YES);
                            storeEvaluationDto.setShowStatus(SystemContext.UserDomain.STOREEVALUATIONSTATUS_YES);
                            storeEvaluationDto.setCreateTime(DateUtils.getLastMonth(new Date(), DATESTART, DATEEND));
                            list.add(storeEvaluationDto);
                        }
                    }
                }
                this.batchSaveStoreProfileDtoTemp(list);
            }
        } catch (UserServiceException e) {
            logger.error("将产品批量保存至临时表出错");
            throw new UserServiceException("异常：将产品批量保存至临时表出错");
        }
    }

    @Override
    public void batchSaveStoreProfileDtoTemp(List<StoreEvaluationDto> records) throws UserServiceException {

        try {
            if (ObjectUtils.isNullOrEmpty(records)) {
                logger.error("StoreEvaluationService.batchSaveStoreProfileDtoTemp => 需要保存的店铺评论列表参数为空");
                throw new UserServiceException("需要保存的店铺评论列表为空");
            }
            List<StoreEvaluation> list = new ArrayList<StoreEvaluation>();
            for (StoreEvaluationDto dto : records) {
                StoreEvaluation storeEvaluation = new StoreEvaluation();
                ObjectUtils.fastCopy(dto, storeEvaluation);
                list.add(storeEvaluation);
            }

            this.storeEvaluationMapper.batchSaveTemp(list);
        } catch (Exception e) {
            logger.error("saveStoreEvaluation异常", e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public boolean checkStoreInfoByStoreCode(String code, String storeName) throws UserServiceException {
        boolean isExist = false;
        try {
            StoreProfileDto existDto = storeProfileService.loadByStoreCode(code);
            if (!ObjectUtils.isNullOrEmpty(existDto) && storeName.equals(existDto.getStoreName())) {
                isExist = true;
            }
        } catch (Exception e) {
            logger.error("getBasicStoreInfoList异常", e);
            throw new UserServiceException(e.getMessage());
        }
        return isExist;
    }

    @Override
    public YiLiDiPage<StoreEvaluationDto> findStoreEvaluationTemps(StoreEvaluateQuery query) throws UserServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
                query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
            }
            if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
                query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());
            Page<StoreEvaluationInfo> page = storeEvaluationMapper.findStoreEvaluationTemps(query);
            Page<StoreEvaluationDto> pageDto = new Page<StoreEvaluationDto>(query.getStart(), query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);

            List<StoreEvaluationInfo> storeEvaluationInfos = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(storeEvaluationInfos)) {
                for (StoreEvaluationInfo storeEvaluationInfo : storeEvaluationInfos) {
                    StoreEvaluationDto storeEvaluationDto = new StoreEvaluationDto();
                    ObjectUtils.fastCopy(storeEvaluationInfo, storeEvaluationDto);
                    pageDto.add(storeEvaluationDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findStoreEvaluations异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public List<String> addAllTempStoreEvaluateToStandard(StoreEvaluateQuery query) throws UserServiceException {
        List<String> listError = new ArrayList<String>();
        try {
            List<StoreEvaluationInfo> storeEvaluationTemps = this.storeEvaluationMapper.liststoreEvaluationTemps(query);
            if (ObjectUtils.isNullOrEmpty(storeEvaluationTemps)) {
                listError.add("无有效数据");
                return listError;
            }
            this.storeEvaluationMapper.batchSaveTempToStandard(storeEvaluationTemps);
            List<Integer> ids = new ArrayList<Integer>();
            for (StoreEvaluationInfo storeEvaluationInfo : storeEvaluationTemps) {
                ids.add(storeEvaluationInfo.getId());
            }
            this.storeEvaluationMapper.deletestoreEvaluationTempsByIds(ids);
        } catch (Exception e) {
            logger.error("addAllTempStoreEvaluateToStandard异常", e);
            throw new UserServiceException(e.getMessage());
        }
        return listError;
    }

    @Override
    public void deleteAllStoreEvaluationTemps() throws UserServiceException {
        try {
            storeEvaluationMapper.deleteAllStoreEvaluationTemps();
        } catch (Exception e) {
            logger.error("deleteById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Float getAvgStoreScoreByStoreId(Integer storeId) throws UserServiceException {
        try {
            if (null == storeId) {
                throw new UserServiceException("查询店铺评分参数为空！");
            }
            Double avgScore = storeEvaluationMapper.getAvgStoreScoreByStoreId(storeId);
            if(ObjectUtils.isNullOrEmpty(avgScore)){
                avgScore = Double.valueOf(STORESCORE_INIT);
            }
            return ArithUtils.convertsToFloat(ArithUtils.round(avgScore,0));
        } catch (Exception e) {
            logger.error("getAvgStoreScore异常", e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public List<StoreEvaluationScoreDto> listStoreEvaluations(StoreEvaluateQuery query)throws UserServiceException {
        List<StoreEvaluationScore> list = storeEvaluationMapper.liststoreEvaluationScores(query);
        List<StoreEvaluationScoreDto> listStoreScoreDtos = new ArrayList<StoreEvaluationScoreDto>(); 
        if(!ObjectUtils.isNullOrEmpty(list)){
            for(StoreEvaluationScore storeEvaluationScore : list){
                StoreEvaluationScoreDto dto = new StoreEvaluationScoreDto();
                dto.setStoreId(storeEvaluationScore.getStoreId());
                
                Double avgScore = storeEvaluationScore.getStoreScore();
                avgScore = ArithUtils.round(avgScore,STORESCORE_ROUNDSCALE);//四舍五入
                dto.setStoreScore(ArithUtils.convertsToFloat(avgScore));
                listStoreScoreDtos.add(dto);
            }
        }
        return listStoreScoreDtos;
    }

}