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
import com.yilidi.o2o.product.service.IAdvertisementService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.dto.AdvertisementDto;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.query.AdvertisementQuery;

/**
 * 广告Controller
 * 
 * @author: chenlian
 * @date: 2016年8月19日 下午5:05:52
 */
@Controller
@RequestMapping(value = "/operation")
public class AdvertisementController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    private static final String ADVERTISEMENT_PIC_RELATIVE_PATH_DEFAULT = "/pic/advertise";

    @Autowired
    private IAdvertisementService advertisementService;

    @Autowired
    private IProductService productService;

    /**
     * 分页获取广告信息列表
     * 
     * @param advertisementQueryDto
     *            广告查询DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/findAdvertisements")
    @ResponseBody
    public MsgBean findAdvertisements(@RequestBody AdvertisementQuery advertisementQuery) {
        try {
            logger.info("========= advertisementQuery : " + JsonUtils.toJsonStringWithDateFormat(advertisementQuery));
            if (!StringUtils.isEmpty(advertisementQuery.getStrStartTime())) {
                advertisementQuery.setStartTime(DateUtils.parseDate(advertisementQuery.getStrStartTime()));
            }
            if (!StringUtils.isEmpty(advertisementQuery.getStrEndTime())) {
                advertisementQuery.setEndTime(DateUtils.parseDate(advertisementQuery.getStrEndTime()));
            }
            YiLiDiPage<AdvertisementDto> yiLiDiPage = advertisementService.findAdvertisements(advertisementQuery);
            logger.info("========= yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询广告列表成功");
        } catch (Exception e) {
            logger.error("查询广告列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 根据id加载广告信息
     * 
     * @param id
     *            广告ID
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/loadByAdvertisementId")
    @ResponseBody
    public MsgBean loadById(@PathVariable Integer id) {
        try {
            if (null == id) {
                throw new IllegalArgumentException("无法获取广告ID");
            }
            AdvertisementDto advertisementDto = advertisementService.loadById(id);
            return super.encapsulateMsgBean(advertisementDto, MsgBean.MsgCode.SUCCESS, "获取广告信息成功");
        } catch (Exception e) {
            logger.error("获取广告信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 更新广告状态
     * 
     * @param id
     *            广告ID
     * @param status
     *            广告状态
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}-{status}/changeAdvertisementStatus")
    @ResponseBody
    public MsgBean changeAdvertisementStatus(@PathVariable("id") Integer id, @PathVariable("status") String status) {
        try {
            AdvertisementDto advertisementDto = new AdvertisementDto();
            advertisementDto.setId(id);
            advertisementDto.setModifyUserId(super.getUserId());
            advertisementDto.setModifyTime(DateUtils.getCurrentDateTime());
            advertisementDto.setStatusCode(status);
            advertisementService.updateById(advertisementDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "更新广告状态成功");
        } catch (Exception e) {
            logger.error("更新广告状态失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 根据广告类型编码加载广告信息
     * 
     * @param typeCode
     *            广告类型编码
     * @return MsgBean
     */
    @RequestMapping(value = "/{typeCode}/listByAdvertisementTypeCode")
    @ResponseBody
    public MsgBean listByTypeCode(@PathVariable String typeCode) {
        try {
            if (StringUtils.isEmpty(typeCode)) {
                throw new IllegalArgumentException("无法获取广告类型编码");
            }
            List<AdvertisementDto> advertisementDtos = advertisementService.listByTypeCode(typeCode);
            return super.encapsulateMsgBean(advertisementDtos, MsgBean.MsgCode.SUCCESS, "获取广告信息成功");
        } catch (Exception e) {
            logger.error("获取广告信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 修改广告
     * 
     * @param advertisementDto
     *            广告DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/updateAdvertisement")
    @ResponseBody
    public MsgBean updateAdvertisement(@RequestBody AdvertisementDto advertisementDto) {
        try {
            logger.info("advertisementDto : " + advertisementDto.toString());
            Integer id = advertisementDto.getId();
            if (null == id) {
                throw new IllegalArgumentException("无法获取需修改的主题ID");
            }
            Param advertisementNameParam = new Param.Builder("广告名称", Param.ParamType.STR_NORMAL.getType(),
                    advertisementDto.getAdvertisementName(), false).build();
            Param typeCodeParam = new Param.Builder("广告类型", Param.ParamType.STR_NORMAL.getType(),
                    advertisementDto.getTypeCode(), false).build();
            Param advertisementImageUrlParam = new Param.Builder("广告图片", Param.ParamType.STR_NORMAL.getType(),
                    advertisementDto.getImageUrl(), false).build();
            Param strStartTimeParam = new Param.Builder("广告开始有效时间", Param.ParamType.STR_DATE.getType(),
                    advertisementDto.getStrStartTime(), false).build();
            Param strEndTimeParam = new Param.Builder("广告结束有效时间", Param.ParamType.STR_DATE.getType(),
                    advertisementDto.getStrEndTime(), false).build();
            Param sortParam = new Param.Builder("组内排序", Param.ParamType.INTEGER_TYPE.getType(), advertisementDto.getSort(),
                    false).build();
            Param statusCodeParam = new Param.Builder("是否有效", Param.ParamType.STR_NORMAL.getType(),
                    advertisementDto.getStatusCode(), false).build();
            super.validateParams(advertisementNameParam, typeCodeParam, advertisementImageUrlParam, strStartTimeParam,
                    strEndTimeParam, sortParam, statusCodeParam);
            if (!StringUtils.isEmpty(advertisementDto.getBarCode())) {
                ProductDto productDto = productService.loadProductByBarCodeAndChannelCode(advertisementDto.getBarCode(),
                        null);
                if (ObjectUtils.isNullOrEmpty(productDto)) {
                    throw new IllegalArgumentException("商品条形码不存在！");
                }
            }
            advertisementDto.setStartTime(DateUtils.parseDate(advertisementDto.getStrStartTime()));
            advertisementDto.setEndTime(DateUtils.parseDate(advertisementDto.getStrEndTime()));
            advertisementDto.setModifyUserId(super.getUserId());
            advertisementDto.setModifyTime(DateUtils.getCurrentDateTime());
            advertisementService.updateById(advertisementDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改广告成功");
        } catch (Exception e) {
            logger.error("修改广告失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 新增广告
     * 
     * @param advertisementDto
     *            广告DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/createAdvertisement")
    @ResponseBody
    public MsgBean createAdvertisement(@RequestBody AdvertisementDto advertisementDto) {
        try {
            logger.info("advertisementDto : " + advertisementDto.toString());
            Param advertisementNameParam = new Param.Builder("广告名称", Param.ParamType.STR_NORMAL.getType(),
                    advertisementDto.getAdvertisementName(), false).build();
            Param typeCodeParam = new Param.Builder("广告类型", Param.ParamType.STR_NORMAL.getType(),
                    advertisementDto.getTypeCode(), false).build();
            Param advertisementImageUrlParam = new Param.Builder("广告图片", Param.ParamType.STR_NORMAL.getType(),
                    advertisementDto.getImageUrl(), false).build();
            Param strStartTimeParam = new Param.Builder("广告开始有效时间", Param.ParamType.STR_DATE.getType(),
                    advertisementDto.getStrStartTime(), false).build();
            Param strEndTimeParam = new Param.Builder("广告结束有效时间", Param.ParamType.STR_DATE.getType(),
                    advertisementDto.getStrEndTime(), false).build();
            Param sortParam = new Param.Builder("组内排序", Param.ParamType.INTEGER_TYPE.getType(), advertisementDto.getSort(),
                    false).build();
            Param statusCodeParam = new Param.Builder("是否有效", Param.ParamType.STR_NORMAL.getType(),
                    advertisementDto.getStatusCode(), false).build();
            super.validateParams(advertisementNameParam, typeCodeParam, advertisementImageUrlParam, strStartTimeParam,
                    strEndTimeParam, sortParam, statusCodeParam);
            if (!StringUtils.isEmpty(advertisementDto.getBarCode())) {
                ProductDto productDto = productService.loadProductByBarCodeAndChannelCode(advertisementDto.getBarCode(),
                        null);
                if (ObjectUtils.isNullOrEmpty(productDto)) {
                    throw new IllegalArgumentException("商品条形码不存在！");
                }
            }
            advertisementDto.setStartTime(DateUtils.parseDate(advertisementDto.getStrStartTime()));
            advertisementDto.setEndTime(DateUtils.parseDate(advertisementDto.getStrEndTime()));
            advertisementDto.setCreateTime(DateUtils.getCurrentDateTime());
            advertisementDto.setCreateUserId(super.getUserId());
            advertisementService.save(advertisementDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "新增广告成功");
        } catch (Exception e) {
            logger.error("新增广告失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 上传广告图片到临时服务器
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/uploadAdvertisementImageTemp")
    @ResponseBody
    public MsgBean uploadAdvertisementImageTemp(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.ADVERTISEMENT_PIC_RELATIVE_PATH);
            fileRelativePath = StringUtils.isEmpty(fileRelativePath) ? ADVERTISEMENT_PIC_RELATIVE_PATH_DEFAULT
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
     * 删除广告相关临时图片
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/deleteAdvertisementTemp")
    @ResponseBody
    public MsgBean deleteAdvertisementTemp(HttpServletRequest req) {
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

}
