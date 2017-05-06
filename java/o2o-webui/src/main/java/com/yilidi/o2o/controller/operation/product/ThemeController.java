package com.yilidi.o2o.controller.operation.product;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.StringUtils;
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
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.ISaleZoneService;
import com.yilidi.o2o.product.service.IThemeService;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.SaleZoneProductInfoDto;
import com.yilidi.o2o.product.service.dto.ThemeDto;
import com.yilidi.o2o.product.service.dto.query.ThemeQueryDto;

/**
 * 专题Controller
 * 
 * @author: chenlian
 * @date: 2016年8月19日 下午5:05:52
 */
@Controller
@RequestMapping(value = "/operation")
public class ThemeController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    private static final String THEME_PIC_RELATIVE_PATH_DEFAULT = "/pic/theme";

    private static final String THEME_SLOGAN_PIC_RELATIVE_PATH_DEFAULT = "/pic/themeslogan";

    @Autowired
    private IThemeService themeService;

    @Autowired
    private ISaleZoneService saleZoneService;

    /**
     * 分页获取专题信息列表
     * 
     * @param themeQueryDto
     *            专题查询DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/findThemes")
    @ResponseBody
    public MsgBean findThemes(@RequestBody ThemeQueryDto themeQueryDto) {
        try {
            YiLiDiPage<ThemeDto> yiLiDiPage = themeService.findThemes(themeQueryDto);
            logger.info("========= yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询专题列表成功");
        } catch (Exception e) {
            logger.error("查询专题列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 校验专题类型是否已被专题引用
     * @param dictCode  专题类型code
     * @return
     */
    @RequestMapping(value = "/{dictCode}/checkThemesByDictCode")
    @ResponseBody
    public MsgBean checkThemesByDictCode(@PathVariable String dictCode) {
        try {
            ThemeQueryDto themeQueryDto = new ThemeQueryDto();
            if(!StringUtils.isEmpty(dictCode)){
                themeQueryDto.setTypeCode(dictCode);
            }
            List<ThemeDto> themeDtos = themeService.listThemes(themeQueryDto);
            return super.encapsulateMsgBean(themeDtos.size(), MsgBean.MsgCode.SUCCESS, "校验成功");
        } catch (Exception e) {
            logger.error("校验失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 根据id加载专题信息
     * 
     * @param id
     *            专题ID
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/loadById")
    @ResponseBody
    public MsgBean loadById(@PathVariable Integer id) {
        try {
            if (null == id) {
                throw new IllegalArgumentException("无法获取专题ID");
            }
            ThemeDto themeDto = themeService.loadById(id);
            return super.encapsulateMsgBean(themeDto, MsgBean.MsgCode.SUCCESS, "获取专题信息成功");
        } catch (Exception e) {
            logger.error("获取专题信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 根据专题类型编码加载专题信息
     * 
     * @param typeCode
     *            专题类型编码
     * @return MsgBean
     */
    @RequestMapping(value = "/{typeCode}/loadByTypeCode")
    @ResponseBody
    public MsgBean loadByTypeCode(@PathVariable String typeCode) {
        try {
            if (StringUtils.isEmpty(typeCode)) {
                throw new IllegalArgumentException("无法获取专题类型编码");
            }
            ThemeDto themeDto = themeService.loadByTypeCode(typeCode);
            return super.encapsulateMsgBean(themeDto, MsgBean.MsgCode.SUCCESS, "获取专题信息成功");
        } catch (Exception e) {
            logger.error("获取专题信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 修改专题
     * 
     * @param themeDto
     *            专题DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/updateTheme")
    @ResponseBody
    public MsgBean updateTheme(@RequestBody ThemeDto themeDto) {
        try {
            logger.info("themeDto : " + themeDto.toString());
            Integer id = themeDto.getId();
            if (null == id) {
                throw new IllegalArgumentException("无法获取需修改的主题ID");
            }
            Param themeNameParam = new Param.Builder("专题名称", Param.ParamType.STR_NORMAL.getType(), themeDto.getThemeName(),
                    false).build();
            Param typeCodeParam = new Param.Builder("专题类型", Param.ParamType.STR_NORMAL.getType(), themeDto.getTypeCode(),
                    false).build();
            Param themeImageUrlParam = new Param.Builder("专题图片", Param.ParamType.STR_NORMAL.getType(),
                    themeDto.getThemeImageUrl(), false).build();
            Param sloganImageUrlParam = new Param.Builder("专题slogan", Param.ParamType.STR_NORMAL.getType(),
                    themeDto.getSloganImageUrl(), false).build();
            Param baseColorParam = new Param.Builder("专题底色", Param.ParamType.STR_NORMAL.getType(), themeDto.getBaseColor(),
                    false).build();
            super.validateParams(themeNameParam, typeCodeParam, themeImageUrlParam, sloganImageUrlParam, baseColorParam);
            // 判断typeCode唯一性
            ThemeDto tDto = themeService.loadByTypeCode(themeDto.getTypeCode());
            if (!ObjectUtils.isNullOrEmpty(tDto) && tDto.getId().intValue() != id.intValue()) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "该专题类型所属的专题已存在，请重新选择其它类型!");
            }
            themeDto.setModifyUserId(super.getUserId());
            themeDto.setModifyTime(DateUtils.getCurrentDateTime());
            themeService.updateById(themeDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改专题成功");
        } catch (Exception e) {
            logger.error("修改专题失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 新增专题
     * 
     * @param themeDto
     *            专题DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/createTheme")
    @ResponseBody
    public MsgBean createTheme(@RequestBody ThemeDto themeDto) {
        try {
            logger.info("themeDto : " + themeDto.toString());
            Param themeNameParam = new Param.Builder("专题名称", Param.ParamType.STR_NORMAL.getType(), themeDto.getThemeName(),
                    false).build();
            Param typeCodeParam = new Param.Builder("专题类型", Param.ParamType.STR_NORMAL.getType(), themeDto.getTypeCode(),
                    false).build();
            Param themeImageUrlParam = new Param.Builder("专题图片", Param.ParamType.STR_NORMAL.getType(),
                    themeDto.getThemeImageUrl(), false).build();
            Param sloganImageUrlParam = new Param.Builder("专题slogan", Param.ParamType.STR_NORMAL.getType(),
                    themeDto.getSloganImageUrl(), false).build();
            Param baseColorParam = new Param.Builder("专题底色", Param.ParamType.STR_NORMAL.getType(), themeDto.getBaseColor(),
                    false).build();
            super.validateParams(themeNameParam, typeCodeParam, themeImageUrlParam, sloganImageUrlParam, baseColorParam);
            // 判断typeCode唯一性
            ThemeDto tDto = themeService.loadByTypeCode(themeDto.getTypeCode());
            if (!ObjectUtils.isNullOrEmpty(tDto)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "该专题类型所属的专题已存在，请重新选择其它类型!");
            }
            themeDto.setCreateTime(DateUtils.getCurrentDateTime());
            themeDto.setCreateUserId(super.getUserId());
            themeService.save(themeDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "新增专题成功");
        } catch (Exception e) {
            logger.error("新增专题失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 上传专题图片到临时服务器
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/uploadThemeImageTemp")
    @ResponseBody
    public MsgBean uploadThemeImageTemp(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.THEME_PIC_RELATIVE_PATH);
            fileRelativePath = StringUtils.isEmpty(fileRelativePath) ? THEME_PIC_RELATIVE_PATH_DEFAULT : fileRelativePath;
            String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.IMAGE);
            logger.info("===========filePathSub : " + filePathSub);
            return super.encapsulateMsgBean(filePathSub, MsgBean.MsgCode.SUCCESS, "上传文件成功");
        } catch (Exception e) {
            logger.error("上传文件失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 上传专题slogan图片到临时服务器
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/uploadSloganImageTemp")
    @ResponseBody
    public MsgBean uploadSloganImageTemp(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.THEME_SLOGAN_PIC_RELATIVE_PATH);
            fileRelativePath = StringUtils.isEmpty(fileRelativePath) ? THEME_SLOGAN_PIC_RELATIVE_PATH_DEFAULT
                    : fileRelativePath;
            String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.IMAGE);
            logger.info("===========filePathSub : " + filePathSub);
            return super.encapsulateMsgBean(filePathSub, MsgBean.MsgCode.SUCCESS, "上传文件成功");
        } catch (Exception e) {
            logger.error("上传文件失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 删除专题相关临时图片
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/deleteThemeTemp")
    @ResponseBody
    public MsgBean deleteThemeTemp(HttpServletRequest req) {
        try {
            String tempPicPath = req.getParameter("tempPicPath");
            if (!ObjectUtils.isNullOrEmpty(tempPicPath)) {
                String[] arrParam = tempPicPath.split(",");
                for (String idString : arrParam) {
                    FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
                    fileUploadUtils.deleteTempFile(idString);
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "删除文件成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "删除文件失败");
            }
        } catch (Exception e) {
            logger.error("删除文件失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 保存专题与产品的关联关系
     * 
     * @param typeCode
     *            专区类型编码
     * @param productIdAndSorts
     *            产品ID与组内排序连接字符串
     * @return MsgBean
     */
    @RequestMapping(value = "/{typeCode}-{productIdAndSorts}/saveThemeProductRelations")
    @ResponseBody
    public MsgBean saveThemeProductRelations(@PathVariable("typeCode") String typeCode,
            @PathVariable("productIdAndSorts") String productIdAndSorts) {
        try {
            saleZoneService.save(typeCode, productIdAndSorts, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "保存专题与产品的关联关系成功");
        } catch (Exception e) {
            logger.error("保存专题与产品的关联关系失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 根据专区产品查询信息获取其所关联的产品相关信息列表
     * 
     * @param saleZoneProductInfoDto
     *            专区产品查询信息DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/listProductInfosByThemeTypeCode")
    @ResponseBody
    public MsgBean listProductInfosByThemeTypeCode(@RequestBody SaleZoneProductInfoDto saleZoneProductInfoDto) {
        try {
            logger.info(
                    "========= saleZoneProductInfoDto : " + JsonUtils.toJsonStringWithDateFormat(saleZoneProductInfoDto));
            List<ProductDto> productDtos = saleZoneService.listProductInfosByThemeTypeCode(saleZoneProductInfoDto);
            logger.info("========= productDtos : " + JsonUtils.toJsonStringWithDateFormat(productDtos));
            return super.encapsulateMsgBean(productDtos, MsgBean.MsgCode.SUCCESS, "根据专区产品查询信息获取其所关联的产品相关信息列表成功");
        } catch (Exception e) {
            logger.error("根据专区产品查询信息获取其所关联的产品相关信息列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}
