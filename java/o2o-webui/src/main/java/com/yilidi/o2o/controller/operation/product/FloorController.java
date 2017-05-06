package com.yilidi.o2o.controller.operation.product;

import java.util.List;
import java.util.Map;

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
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.IFloorAdvertisementTypeService;
import com.yilidi.o2o.product.service.IFloorProductService;
import com.yilidi.o2o.product.service.IFloorService;
import com.yilidi.o2o.product.service.dto.FloorAdvertisementTypeDto;
import com.yilidi.o2o.product.service.dto.FloorDto;
import com.yilidi.o2o.product.service.dto.FloorProductInfoDto;
import com.yilidi.o2o.product.service.dto.ProductDto;

/**
 * 楼层Controller
 * 
 * @author: chenlian
 * @date: 2016年8月24日 下午3:11:46
 */
@Controller
@RequestMapping(value = "/operation")
public class FloorController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    private static final String FLOOR_PIC_RELATIVE_PATH_DEFAULT = "/pic/floor";

    @Autowired
    private IFloorService floorService;

    @Autowired
    private IFloorProductService floorProductService;

    @Autowired
    private IFloorAdvertisementTypeService floorAdvertisementTypeService;

    /**
     * 获取楼层信息列表
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/listFloors")
    @ResponseBody
    public MsgBean listFloors() {
        try {
            List<FloorDto> list = floorService.listFloors();
            logger.info("========= list : " + JsonUtils.toJsonStringWithDateFormat(list));
            return super.encapsulateMsgBean(list, MsgBean.MsgCode.SUCCESS, "获取楼层信息列表成功");
        } catch (Exception e) {
            logger.error("获取楼层信息列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 根据id加载楼层信息
     * 
     * @param id
     *            楼层ID
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/loadFloorById")
    @ResponseBody
    public MsgBean loadFloorById(@PathVariable Integer id) {
        try {
            if (null == id) {
                throw new IllegalArgumentException("无法获取楼层ID");
            }
            FloorDto floorDto = floorService.loadById(id);
            return super.encapsulateMsgBean(floorDto, MsgBean.MsgCode.SUCCESS, "获取楼层信息成功");
        } catch (Exception e) {
            logger.error("获取楼层信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 修改楼层
     * 
     * @param floorDto
     *            楼层DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/updateFloor")
    @ResponseBody
    public MsgBean updateFloor(@RequestBody FloorDto floorDto) {
        try {
            logger.info("floorDto : " + floorDto.toString());
            Integer id = floorDto.getId();
            if (null == id) {
                throw new IllegalArgumentException("无法获取需修改的主题ID");
            }
            Param floorNameParam = new Param.Builder("楼层名称", Param.ParamType.STR_NORMAL.getType(), floorDto.getFloorName(),
                    false).build();
            Param floorImageUrlParam = new Param.Builder("楼层icon", Param.ParamType.STR_NORMAL.getType(),
                    floorDto.getFloorImageUrl(), false).build();
            Param sortParam = new Param.Builder("楼层排序", Param.ParamType.INTEGER_TYPE.getType(), floorDto.getSort(), false)
                    .build();
            Param statusCodeParam = new Param.Builder("是否启用", Param.ParamType.STR_NORMAL.getType(),
                    floorDto.getStatusCode(), false).build();
            Param linkTypeParam = new Param.Builder("楼层跳转设置", Param.ParamType.STR_NORMAL.getType(), floorDto.getLinkType(),
                    false).build();
            super.validateParams(floorNameParam, floorImageUrlParam, sortParam, statusCodeParam, linkTypeParam);
            floorDto.setModifyUserId(super.getUserId());
            floorDto.setModifyTime(DateUtils.getCurrentDateTime());
            floorService.updateById(floorDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改楼层成功");
        } catch (Exception e) {
            logger.error("修改楼层失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 新增楼层
     * 
     * @param floorDto
     *            楼层DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/createFloor")
    @ResponseBody
    public MsgBean createFloor(@RequestBody FloorDto floorDto) {
        try {
            logger.info("floorDto : " + floorDto.toString());
            Param floorNameParam = new Param.Builder("楼层名称", Param.ParamType.STR_NORMAL.getType(), floorDto.getFloorName(),
                    false).build();
            Param floorImageUrlParam = new Param.Builder("楼层icon", Param.ParamType.STR_NORMAL.getType(),
                    floorDto.getFloorImageUrl(), false).build();
            Param sortParam = new Param.Builder("楼层排序", Param.ParamType.INTEGER_TYPE.getType(), floorDto.getSort(), false)
                    .build();
            Param statusCodeParam = new Param.Builder("是否启用", Param.ParamType.STR_NORMAL.getType(),
                    floorDto.getStatusCode(), false).build();
            Param linkTypeParam = new Param.Builder("楼层跳转设置", Param.ParamType.STR_NORMAL.getType(), floorDto.getLinkType(),
                    false).build();
            super.validateParams(floorNameParam, floorImageUrlParam, sortParam, statusCodeParam, linkTypeParam);
            floorDto.setCreateTime(DateUtils.getCurrentDateTime());
            floorDto.setCreateUserId(super.getUserId());
            floorService.save(floorDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "新增楼层成功");
        } catch (Exception e) {
            logger.error("新增楼层失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 上传楼层图片到临时服务器
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/uploadFloorImageTemp")
    @ResponseBody
    public MsgBean uploadFloorImageTemp(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.FLOOR_PIC_RELATIVE_PATH);
            fileRelativePath = StringUtils.isEmpty(fileRelativePath) ? FLOOR_PIC_RELATIVE_PATH_DEFAULT : fileRelativePath;
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
     * 删除楼层相关临时图片
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/deleteFloorTemp")
    @ResponseBody
    public MsgBean deleteFloorTemp(HttpServletRequest req) {
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
     * 保存楼层与产品的关联关系
     * 
     * @param floorId
     *            楼层ID
     * @param productIdAndSorts
     *            产品ID与组内排序连接字符串
     * @return MsgBean
     */
    @RequestMapping(value = "/{floorId}-{productIdAndSorts}/saveFloorProductRelations")
    @ResponseBody
    public MsgBean saveFloorProductRelations(@PathVariable("floorId") Integer floorId,
            @PathVariable("productIdAndSorts") String productIdAndSorts) {
        try {
            floorProductService.save(floorId, productIdAndSorts, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "保存楼层与产品的关联关系成功");
        } catch (Exception e) {
            logger.error("保存楼层与产品的关联关系失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 根据楼层查询信息获取其所关联的产品相关信息列表
     * 
     * @param floorProductInfoDto
     *            楼层与产品关联关系查询信息DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/listProductInfosByFloorId")
    @ResponseBody
    public MsgBean listProductInfosByFloorId(@RequestBody FloorProductInfoDto floorProductInfoDto) {
        try {
            logger.info("========= floorProductInfoDto : " + JsonUtils.toJsonStringWithDateFormat(floorProductInfoDto));
            List<ProductDto> productDtos = floorProductService.listProductInfosByFloorId(floorProductInfoDto);
            logger.info("========= productDtos : " + JsonUtils.toJsonStringWithDateFormat(productDtos));
            return super.encapsulateMsgBean(productDtos, MsgBean.MsgCode.SUCCESS, "根据楼层查询信息获取其所关联的产品相关信息列表成功");
        } catch (Exception e) {
            logger.error("根据楼层查询信息获取其所关联的产品相关信息列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取所有可选择关联的广告类型
     * 
     * @param id
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/listAllOptionalAdvertisementType")
    @ResponseBody
    public MsgBean listAllOptionalAdvertisementType(@PathVariable Integer id) {
        try {
            if (null == id) {
                throw new IllegalArgumentException("无法获取楼层ID");
            }
            FloorDto floorDto = floorService.loadById(id);
            if (null == floorDto) {
                throw new IllegalArgumentException("需关联广告类型的楼层不存在");
            }
            List<Map<String, String>> mapList = systemBasicDataInfoUtils
                    .getSystemDictInfoList(SystemContext.ProductDomain.DictType.ADVERTISEMENTTYPE.getValue());
            return super.encapsulateMsgBean(mapList, MsgBean.MsgCode.SUCCESS, "获取所有可选择关联的广告类型成功");
        } catch (Exception e) {
            logger.error("获取所有可选择关联的广告类型失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 保存楼层与广告类型关联关系
     * 
     * @param floorId
     * @param advertisementTypeCode
     * @return MsgBean
     */
    @RequestMapping(value = "/{floorId}-{advertisementTypeCode}/saveFloorAdvertisementTypeRelations")
    @ResponseBody
    public MsgBean saveFloorAdvertisementTypeRelations(@PathVariable("floorId") Integer floorId,
            @PathVariable("advertisementTypeCode") String advertisementTypeCode) {
        try {
            FloorAdvertisementTypeDto floorAdvertisementTypeDto = new FloorAdvertisementTypeDto();
            floorAdvertisementTypeDto.setFloorId(floorId);
            floorAdvertisementTypeDto.setAdvertisementTypeCode(advertisementTypeCode);
            floorAdvertisementTypeDto.setCreateTime(DateUtils.getCurrentDateTime());
            floorAdvertisementTypeDto.setCreateUserId(super.getUserId());
            floorAdvertisementTypeService.save(floorAdvertisementTypeDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "保存楼层与广告类型关联关系成功");
        } catch (Exception e) {
            logger.error("保存楼层与广告类型关联关系失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}
