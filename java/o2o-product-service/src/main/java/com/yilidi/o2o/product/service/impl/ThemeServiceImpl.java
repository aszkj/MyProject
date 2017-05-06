package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.dao.ThemeMapper;
import com.yilidi.o2o.product.model.Theme;
import com.yilidi.o2o.product.model.query.ThemeQuery;
import com.yilidi.o2o.product.service.IThemeService;
import com.yilidi.o2o.product.service.dto.ThemeDto;
import com.yilidi.o2o.product.service.dto.query.ThemeQueryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 专题Service实现类
 * 
 * @author: chenlian
 * @date: 2016年8月19日 下午4:17:08
 */
@Service("themeService")
public class ThemeServiceImpl extends BasicDataService implements IThemeService {

    private static final String IMAGEFLAG_YES = "IMAGEFLAG_YES";

    @Autowired
    private ThemeMapper themeMapper;

    @Override
    public void save(ThemeDto themeDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(themeDto)) {
                throw new ProductServiceException("参数themeDto不能为空");
            }
            Theme theme = new Theme();
            ObjectUtils.fastCopy(themeDto, theme);
            themeMapper.save(theme);
            operateImage(themeDto.getImageFlagForThemeImage(), themeDto.getDelImageUrlForThemeImage(),
                    themeDto.getThemeImageUrl());
            operateImage(themeDto.getImageFlagForSloganImage(), themeDto.getDelImageUrlForSloganImage(),
                    themeDto.getSloganImageUrl());
        } catch (Exception e) {
            logger.error("save异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateById(ThemeDto themeDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(themeDto)) {
                throw new ProductServiceException("参数themeDto不能为空");
            }
            Theme theme = new Theme();
            ObjectUtils.fastCopy(themeDto, theme);
            themeMapper.updateByIdSelective(theme);
            operateImage(themeDto.getImageFlagForThemeImage(), themeDto.getDelImageUrlForThemeImage(),
                    themeDto.getThemeImageUrl());
            operateImage(themeDto.getImageFlagForSloganImage(), themeDto.getDelImageUrlForSloganImage(),
                    themeDto.getSloganImageUrl());
        } catch (Exception e) {
            logger.error("updateById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    private void operateImage(String imageFlag, String delImageUrl, String classImageUrl) throws ProductServiceException {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            if (!ObjectUtils.isNullOrEmpty(imageFlag) && IMAGEFLAG_YES.equals(imageFlag)) {
                fileUploadUtils.uploadPublishFile(classImageUrl);
            }
            if (!ObjectUtils.isNullOrEmpty(delImageUrl)) {
                fileUploadUtils.deletePublishFile(delImageUrl);
            }
        } catch (ProductServiceException e) {
            logger.error("operateImage异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public ThemeDto loadById(Integer id) throws ProductServiceException {
        ThemeDto themeDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("参数id不能为空");
            }
            Theme theme = themeMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(theme)) {
                themeDto = new ThemeDto();
                ObjectUtils.fastCopy(theme, themeDto);
                themeDto.setTypeCodeName(super.getSystemDictName(
                        SystemContext.ProductDomain.DictType.SALEZONETYPE.getValue(), themeDto.getTypeCode()));
                themeDto.setThemeImageFullUrl(StringUtils.toFullImageUrl(themeDto.getThemeImageUrl()));
                themeDto.setSloganImageFullUrl(StringUtils.toFullImageUrl(themeDto.getSloganImageUrl()));
            }
            return themeDto;
        } catch (Exception e) {
            logger.error("loadById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public ThemeDto loadByTypeCode(String typeCode) throws ProductServiceException {
        ThemeDto themeDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(typeCode)) {
                throw new ProductServiceException("参数typeCode不能为空");
            }
            Theme theme = themeMapper.loadByTypeCode(typeCode);
            if (!ObjectUtils.isNullOrEmpty(theme)) {
                themeDto = new ThemeDto();
                ObjectUtils.fastCopy(theme, themeDto);
                themeDto.setTypeCodeName(super.getSystemDictName(
                        SystemContext.ProductDomain.DictType.SALEZONETYPE.getValue(), themeDto.getTypeCode()));
                themeDto.setThemeImageFullUrl(StringUtils.toFullImageUrl(themeDto.getThemeImageUrl()));
                themeDto.setSloganImageFullUrl(StringUtils.toFullImageUrl(themeDto.getSloganImageUrl()));
            }
            return themeDto;
        } catch (Exception e) {
            logger.error("loadByTypeCode异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<ThemeDto> findThemes(ThemeQueryDto themeQueryDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(themeQueryDto)) {
                throw new ProductServiceException("参数themeQueryDto不能为空");
            }
            if (null == themeQueryDto.getStart() || themeQueryDto.getStart() <= 0) {
                themeQueryDto.setStart(1);
            }
            if (null == themeQueryDto.getPageSize() || themeQueryDto.getPageSize() <= 0) {
                themeQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            Page<ThemeDto> pageDto = new Page<ThemeDto>(themeQueryDto.getStart(), themeQueryDto.getPageSize());
            ThemeQuery themeQuery = new ThemeQuery();
            ObjectUtils.fastCopy(themeQueryDto, themeQuery);
            PageHelper.startPage(themeQuery.getStart(), themeQuery.getPageSize());
            Page<Theme> page = themeMapper.findThemes(themeQuery);
            ObjectUtils.fastCopy(page, pageDto);
            List<Theme> themes = page.getResult();
            for (Theme theme : themes) {
                ThemeDto themeDto = new ThemeDto();
                ObjectUtils.fastCopy(theme, themeDto);
                themeDto.setTypeCodeName(super.getSystemDictName(
                        SystemContext.ProductDomain.DictType.SALEZONETYPE.getValue(), themeDto.getTypeCode()));
                themeDto.setThemeImageFullUrl(StringUtils.toFullImageUrl(themeDto.getThemeImageUrl()));
                themeDto.setSloganImageFullUrl(StringUtils.toFullImageUrl(themeDto.getSloganImageUrl()));
                pageDto.add(themeDto);
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findThemes异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<ThemeDto> listThemes(ThemeQueryDto themeQueryDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(themeQueryDto)) {
                throw new ProductServiceException("参数themeQueryDto不能为空");
            }
            ThemeQuery themeQuery = new ThemeQuery();
            ObjectUtils.fastCopy(themeQueryDto, themeQuery);
            List<Theme> list = themeMapper.listThemes(themeQuery);
            List<ThemeDto> dtos = new ArrayList<ThemeDto>();
            for(Theme theme : list){
                ThemeDto themeDto = new ThemeDto();
                ObjectUtils.fastCopy(theme, themeDto);
                themeDto.setTypeCodeName(super.getSystemDictName(
                        SystemContext.ProductDomain.DictType.SALEZONETYPE.getValue(), themeDto.getTypeCode()));
                themeDto.setThemeImageFullUrl(StringUtils.toFullImageUrl(themeDto.getThemeImageUrl()));
                themeDto.setSloganImageFullUrl(StringUtils.toFullImageUrl(themeDto.getSloganImageUrl()));
                dtos.add(themeDto);
            }
            return dtos;
        }catch (Exception e) {
            logger.error("listThemesByDictCode异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

}
