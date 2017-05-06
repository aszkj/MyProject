package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.ThemeColumnMapper;
import com.yilidi.o2o.product.model.ThemeColumn;
import com.yilidi.o2o.product.service.IThemeColumnService;
import com.yilidi.o2o.product.service.dto.ThemeColumnDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 专题栏目Service实现类
 * 
 * @author: chenlian
 * @date: 2016年9月10日 下午3:34:11
 */
@Service("themeColumnService")
public class ThemeColumnServiceImpl extends BasicDataService implements IThemeColumnService {

    @Autowired
    private ThemeColumnMapper themeColumnMapper;

    @Override
    public void save(Integer themeId, String themeColumnInfos, Integer userId) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(themeId)) {
                throw new IllegalArgumentException("参数themeId为空");
            }
            themeColumnMapper.deleteByThemeId(themeId);
            if (!StringUtils.isEmpty(themeColumnInfos)) {
                String channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
                Date createTime = DateUtils.getCurrentDateTime();
                Integer createUserId = userId;
                if (!themeColumnInfos.contains(",")) {
                    String[] productIdAndSortArray = themeColumnInfos.split(CommonConstants.DELIMITER_MULTIPLY);
                    Integer productId = Integer.parseInt(productIdAndSortArray[0]);
                    Integer sort = Integer.parseInt(productIdAndSortArray[1]);
                    ThemeColumn themeColumn = new ThemeColumn();
                    themeColumn.setThemeId(themeId);
                    // themeColumn.setProductId(productId);
                    // themeColumn.setChannelCode(channelCode);
                    themeColumn.setSort(sort);
                    themeColumn.setCreateTime(createTime);
                    themeColumn.setCreateUserId(createUserId);
                    themeColumnMapper.save(themeColumn);
                } else {
                    StringTokenizer st = new StringTokenizer(themeColumnInfos, ",");
                    while (st.hasMoreTokens()) {
                        String str = st.nextToken();
                        String[] productIdAndSortArray = str.split(CommonConstants.DELIMITER_MULTIPLY);
                        Integer productId = Integer.parseInt(productIdAndSortArray[0]);
                        Integer sort = Integer.parseInt(productIdAndSortArray[1]);
                        ThemeColumn themeColumn = new ThemeColumn();
                        themeColumn.setThemeId(themeId);
                        // themeColumn.setProductId(productId);
                        // themeColumn.setChannelCode(channelCode);
                        themeColumn.setSort(sort);
                        themeColumn.setCreateTime(createTime);
                        themeColumn.setCreateUserId(createUserId);
                        themeColumnMapper.save(themeColumn);
                    }
                }
            }
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "新增专题栏目出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public void deleteById(Integer id) throws ProductServiceException {
        String msg = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                msg = "id为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            themeColumnMapper.deleteById(id);
        } catch (Exception e) {
            msg = null == msg ? "根据ID删除专题栏目出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public void deleteByThemeId(Integer themeId) throws ProductServiceException {
        String msg = null;
        try {
            if (ObjectUtils.isNullOrEmpty(themeId)) {
                msg = "themeId为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            themeColumnMapper.deleteByThemeId(themeId);
        } catch (Exception e) {
            msg = null == msg ? "根据专题ID删除专题栏目出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public ThemeColumnDto loadById(Integer id) throws ProductServiceException {
        String msg = null;
        ThemeColumnDto themeColumnDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                msg = "id为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            ThemeColumn themeColumn = themeColumnMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(themeColumn)) {
                themeColumnDto = new ThemeColumnDto();
                ObjectUtils.fastCopy(themeColumn, themeColumnDto);
            }
            return themeColumnDto;
        } catch (Exception e) {
            msg = null == msg ? "根据专题栏目ID获取专题栏目出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public List<ThemeColumnDto> listByThemeId(Integer themeId) throws ProductServiceException {
        String msg = null;
        List<ThemeColumnDto> themeColumnDtos = null;
        try {
            if (ObjectUtils.isNullOrEmpty(themeId)) {
                msg = "themeId为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            List<ThemeColumn> themeColumns = themeColumnMapper.listByThemeId(themeId);
            if (!ObjectUtils.isNullOrEmpty(themeColumns)) {
                themeColumnDtos = new ArrayList<ThemeColumnDto>();
                for (ThemeColumn themeColumn : themeColumns) {
                    ThemeColumnDto themeColumnDto = new ThemeColumnDto();
                    ObjectUtils.fastCopy(themeColumn, themeColumnDto);
                    themeColumnDtos.add(themeColumnDto);
                }
            }
            return themeColumnDtos;
        } catch (Exception e) {
            msg = null == msg ? "根据专题ID获取专题栏目列表出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

}
