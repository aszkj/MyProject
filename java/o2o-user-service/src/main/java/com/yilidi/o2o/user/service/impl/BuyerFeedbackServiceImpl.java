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
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.BuyerFeedbackMapper;
import com.yilidi.o2o.user.model.BuyerFeedback;
import com.yilidi.o2o.user.model.query.BuyerFeedbackQuery;
import com.yilidi.o2o.user.service.IBuyerFeedbackService;
import com.yilidi.o2o.user.service.dto.BuyerFeedbackDto;
import com.yilidi.o2o.user.service.dto.query.BuyerFeedbackQueryDto;

/**
 * 用户反馈接口实现
 *
 * @author: zhangkun
 * @date: 2016年11月21日 下午3:05:40
 */
@Service("buyerFeedbackService")
public class BuyerFeedbackServiceImpl extends BasicDataService implements IBuyerFeedbackService {

    @Autowired
    private BuyerFeedbackMapper buyfeedbackMapper;

    @Override
    public void saveBuyerFeedback(BuyerFeedbackDto buyerFeedbackDto) throws UserServiceException {
        try {
            BuyerFeedback buyerFeedback = new BuyerFeedback();
            ObjectUtils.fastCopy(buyerFeedbackDto, buyerFeedback);
            buyfeedbackMapper.saveBuyerFeedback(buyerFeedback);
        } catch (Exception e) {
            logger.error("saveBuyerFeedback异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<BuyerFeedbackDto> getAllBuyerFeedback(BuyerFeedbackQueryDto buyerFeedbackQueryDto)
            throws UserServiceException {
        if (null == buyerFeedbackQueryDto.getStart() || buyerFeedbackQueryDto.getStart() <= 0) {
            buyerFeedbackQueryDto.setStart(1);
        }
        if (null == buyerFeedbackQueryDto.getPageSize() || buyerFeedbackQueryDto.getPageSize() <= 0) {
            buyerFeedbackQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
        }
        try {
            PageHelper.startPage(buyerFeedbackQueryDto.getStart(), buyerFeedbackQueryDto.getPageSize());
            BuyerFeedbackQuery buyerFeedbackQuery = new BuyerFeedbackQuery();
            ObjectUtils.fastCopy(buyerFeedbackQueryDto, buyerFeedbackQuery);
            Page<BuyerFeedback> page = buyfeedbackMapper.findAllBuyerFeedback(buyerFeedbackQuery);
            Page<BuyerFeedbackDto> pageDto = new Page<BuyerFeedbackDto>(buyerFeedbackQuery.getStart(),
                    buyerFeedbackQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<BuyerFeedback> buyerFeedbackList = page.getResult();
            BuyerFeedbackDto buyerFeedbackDto = null;
            String[] contentClassifys = null;
            if (!ObjectUtils.isNullOrEmpty(buyerFeedbackList)) {
                for (BuyerFeedback buyerFeedback : buyerFeedbackList) {
                    buyerFeedbackDto = new BuyerFeedbackDto();
                    ObjectUtils.fastCopy(buyerFeedback, buyerFeedbackDto);
                    if (!StringUtils.isEmpty(buyerFeedbackDto.getContentClassify())) {
                        contentClassifys = buyerFeedbackDto.getContentClassify().split(",");
                        String contentClassifyStr = "";
                        for (String contentClassify : contentClassifys) {
                            contentClassifyStr += (super.getSystemDictName(
                                    SystemContext.UserDomain.DictType.FEEDBACKTYPE.getValue(), contentClassify) + ",");
                        }
                        contentClassifyStr = contentClassifyStr.substring(0,contentClassifyStr.length()-1);
                        buyerFeedbackDto.setContentClassifysName(contentClassifyStr.toString());
                    }
                    pageDto.add(buyerFeedbackDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("getAllBuyerFeedback异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public BuyerFeedbackDto getBuyerFeedbackById(Integer id) throws UserServiceException {
        try {
            BuyerFeedbackDto buyerFeedbackDto = null;
            BuyerFeedback buyerFeedback = buyfeedbackMapper.getBuyerFeedbackById(id);
            if(!ObjectUtils.isNullOrEmpty(buyerFeedback)){
                buyerFeedbackDto = new BuyerFeedbackDto();
                ObjectUtils.fastCopy(buyerFeedback, buyerFeedbackDto);
            }
            return buyerFeedbackDto;
        } catch (Exception e) {
            logger.error("getBuyerFeedbackById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public boolean updateBuyerFeedback(BuyerFeedbackDto buyerFeedbackDto) throws UserServiceException {
        try {
            BuyerFeedback buyerFeedback = new BuyerFeedback();
            ObjectUtils.fastCopy(buyerFeedbackDto, buyerFeedback);
            int resultCode = buyfeedbackMapper.updateBuyerFeedback(buyerFeedback);
            if (resultCode > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            logger.error("updateBuyerFeedback异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportBuyerFeedback(BuyerFeedbackQueryDto buyerFeedbackQueryDto) throws UserServiceException {
        try {
            BuyerFeedbackQuery buyerFeedbackQuery = new BuyerFeedbackQuery();
            ObjectUtils.fastCopy(buyerFeedbackQueryDto, buyerFeedbackQuery);
            return buyfeedbackMapper.getCountsForExportBuyerFeedback(buyerFeedbackQuery);
        } catch (Exception e) {
            logger.error("getCountsForExportBuyerFeedback异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public List<BuyerFeedbackDto> listDataForExportBuyerFeedback(BuyerFeedbackQueryDto buyerFeedbackQueryDto,
            Long startLineNum, Integer pageSize) throws UserServiceException {
        try {
            BuyerFeedbackQuery buyerFeedbackQuery = new BuyerFeedbackQuery();
            ObjectUtils.fastCopy(buyerFeedbackQueryDto, buyerFeedbackQuery);
            List<BuyerFeedback> buyerFeedbackList = buyfeedbackMapper.getListForExportBuyerFeedback(buyerFeedbackQuery,
                    startLineNum, pageSize);
            List<BuyerFeedbackDto> buyerFeedbackDtoList = new ArrayList<BuyerFeedbackDto>();
            if (!ObjectUtils.isNullOrEmpty(buyerFeedbackList)) {
                BuyerFeedbackDto buyerFeedbackDto = null;
                for (BuyerFeedback buyerFeedback : buyerFeedbackList) {
                    buyerFeedbackDto = new BuyerFeedbackDto();
                    ObjectUtils.fastCopy(buyerFeedback, buyerFeedbackDto);
                    buyerFeedbackDtoList.add(buyerFeedbackDto);
                }
            }
            return buyerFeedbackDtoList;
        } catch (Exception e) {
            logger.error("listDataForExportBuyerFeedback异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

}
