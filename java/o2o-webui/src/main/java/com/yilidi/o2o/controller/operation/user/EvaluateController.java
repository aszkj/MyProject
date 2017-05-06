package com.yilidi.o2o.controller.operation.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
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
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.model.ReportFileModel;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.report.export.user.SaleProductEvaluationReportExport;
import com.yilidi.o2o.report.export.user.StoreEvaluationReportExport;
import com.yilidi.o2o.report.imports.user.SaleProductEvaluateImport;
import com.yilidi.o2o.report.imports.user.StoreEvaluateImport;
import com.yilidi.o2o.user.service.ISaleProductEvaluationService;
import com.yilidi.o2o.user.service.IStoreEvaluationService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.SaleProductEvaluationDto;
import com.yilidi.o2o.user.service.dto.StoreEvaluationDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.query.SaleProductEvaluateQuery;
import com.yilidi.o2o.user.service.dto.query.StoreEvaluateQuery;

/**
 * @Description:TODO(门店/商品评价管理控制器)
 * @author: llp
 * @date: 2015年12月7日 下午2:56:43
 */
@Controller
@RequestMapping(value = "/operation")
public class EvaluateController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IStoreEvaluationService storeEvaluationService;

    @Autowired
    private IStoreProfileService storeProfileService;

    @Autowired
    private IUserService userService;

    @Autowired
    private ISaleProductEvaluationService saleProductEvaluationService;

    @Autowired
    private StoreEvaluationReportExport storeEvaluationReportExport;

    @Autowired
    private SaleProductEvaluationReportExport saleProductEvaluationReportExport;

    @Autowired
    private StoreEvaluateImport storeEvaluateImport;

    @Autowired
    private SaleProductEvaluateImport saleProductEvaluateImport;

    /**
     * @Description TODO(查询门店评价管理列表)
     * @param query
     * @return Page<StoreEvaluationDto>
     */
    @RequestMapping(value = "/listStoreEvaluations")
    @ResponseBody
    public MsgBean listStoreEvaluations(@RequestBody StoreEvaluateQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 评价时间
            query.setSort("DESC");
            YiLiDiPage<StoreEvaluationDto> page = storeEvaluationService.findStoreEvaluations(query);
            logger.info("Page<StoreEvaluationDto> : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询门店评价记录成功");
        } catch (Exception e) {
            logger.error("查询门店评价记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 保存店铺评论
     * 
     * @param storeEvaluationDto
     * @return
     */
    @RequestMapping(value = "/saveStoreEvaluation")
    @ResponseBody
    public MsgBean saveStoreEvaluation(@RequestBody StoreEvaluationDto storeEvaluationDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(storeEvaluationDto)) {
                if (null == storeEvaluationDto.getUserId()) {
                    // TODO
                    storeEvaluationDto.setUserId(super.getUserId());
                }
                storeEvaluationService.save(storeEvaluationDto);
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "店铺评论信息保存成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "需要保存店铺评论参数为空");
            }
        } catch (Exception e) {
            logger.info("保存失败：店铺评论保存失败" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 根据店铺名称获取店铺信息
     * 
     * @param storeName
     * @return
     */
    @RequestMapping(value = "/{storeName}/getStoreInfoByStoreName")
    @ResponseBody
    public MsgBean getStoreInfo(@PathVariable("storeName") String storeName) {
        try {
            if (StringUtils.isEmpty(storeName)) {
                throw new IllegalArgumentException("无法获取商家名称");
            }
            String storeId = "";
            List<StoreProfileDto> storeProfileDtos = storeProfileService.listStoreByName(storeName);
            if (!ObjectUtils.isNullOrEmpty(storeProfileDtos)) {
                storeId = storeProfileDtos.get(0).getStoreId().toString();
            }
            return super.encapsulateMsgBean(storeId, MsgBean.MsgCode.SUCCESS, "获取商家code成功");
        } catch (Exception e) {
            logger.error("获取商家id失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(根据用户名查询买家用户详情信息)
     * @param query
     * @return UserDto.id
     */
    @RequestMapping(value = "/{userName}/getBuyerUserByUserName")
    @ResponseBody
    public MsgBean getBuyerUserByUserName(@PathVariable("userName") String userName) {
        try {
            if (null == userName) {
                throw new IllegalArgumentException("无法获取用户名称");
            }
            List<UserDto> userDtos = userService.listBuyerUsersByUserName(userName);
            String userId = "";
            if (!ObjectUtils.isNullOrEmpty(userDtos)) {
                userId = userDtos.get(0).getId().toString();
            }
            return super.encapsulateMsgBean(userId, MsgBean.MsgCode.SUCCESS, "查询用户id成功");
        } catch (Exception e) {
            logger.error("查询用户id失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(查询门店评价详细信息)
     * @param query
     * @return StoreEvaluationDto
     */
    @RequestMapping(value = "/{id}/loadStoreEvaluationDetail")
    @ResponseBody
    public MsgBean loadStoreEvaluationDetail(@PathVariable("id") Integer id) {
        try {
            StoreEvaluationDto storeEvaluationDto = storeEvaluationService.loadStoreEvaluationDetailById(id);
            StoreProfileDto storeProfileDto = storeProfileService.loadByStoreId(storeEvaluationDto.getStoreId());
            if (!ObjectUtils.isNullOrEmpty(storeProfileDto)) {
                storeEvaluationDto.setStoreUserName(storeProfileDto.getUserName());
            }
            logger.info("storeEvaluationDto : " + JsonUtils.toJsonStringWithDateFormat(storeEvaluationDto));
            return super.encapsulateMsgBean(storeEvaluationDto, MsgBean.MsgCode.SUCCESS, "查询门店商品记录成功");
        } catch (Exception e) {
            logger.error("查询门店商品记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(删除门店评价)
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/deleteStoreEvaluation")
    @ResponseBody
    public MsgBean deleteStoreEvaluation(@PathVariable("id") Integer id) {
        try {
            storeEvaluationService.deleteById(id);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "删除门店评价记录成功");
        } catch (Exception e) {
            logger.error("删除门店评价记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(修改门店评价显示状态(显示，不显示)，修改操作)
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}-{showStatus}/updateStoreEvaluationShowStatus")
    @ResponseBody
    public MsgBean updateStoreEvaluationShowStatus(@PathVariable("id") Integer id,
            @PathVariable("showStatus") String showStatus) {
        try {
            Param idTemp = new Param.Builder("评论ID", Param.ParamType.STR_INTEGER.getType(), id, false).build();
            Param showStatusTemp = new Param.Builder("评论显示状态", Param.ParamType.STR_NORMAL.getType(), showStatus, false)
                    .build();
            super.validateParams(idTemp, showStatusTemp);
            storeEvaluationService.updateShowStatusById(id, showStatus);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改门店评价显示状态成功");
        } catch (Exception e) {
            logger.error("修改门店评价显示状态失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(查询商品评价管理列表)
     * @param query
     * @return Page<SaleProductEvaluationDto>
     */
    @RequestMapping(value = "/listSaleProductEvaluations")
    @ResponseBody
    public MsgBean listSaleProductEvaluations(@RequestBody SaleProductEvaluateQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 评价时间
            query.setSort("DESC");
            YiLiDiPage<SaleProductEvaluationDto> page = saleProductEvaluationService.findSaleProductEvaluations(query);
            logger.info("Page<SaleProductEvaluationDto> : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询商品评价记录成功");
        } catch (Exception e) {
            logger.error("查询门店评价记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(查询商品评价详细信息)
     * @param query
     * @return SaleProductEvaluationDto
     */
    @RequestMapping(value = "/{id}/loadSaleProductEvaluationDetail")
    @ResponseBody
    public MsgBean loadSaleProductEvaluationDetail(@PathVariable("id") Integer id) {
        try {
            SaleProductEvaluationDto saleProductEvaluationDto = saleProductEvaluationService
                    .loadSaleProductEvaluationDetailById(id);
            logger.info("StoreEvaluationDto : " + JsonUtils.toJsonStringWithDateFormat(saleProductEvaluationDto));
            return super.encapsulateMsgBean(saleProductEvaluationDto, MsgBean.MsgCode.SUCCESS, "查询商品评价详细记录成功");
        } catch (Exception e) {
            logger.error("查询商品评价详细记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(删除商品评价)
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/deleteSaleProductEvaluation")
    @ResponseBody
    public MsgBean deleteSaleProductEvaluation(@PathVariable("id") Integer id) {
        try {
            saleProductEvaluationService.deleteById(id);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "删除商品评价记录成功");
        } catch (Exception e) {
            logger.error("删除商品评价记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(修改商品评价显示状态(显示，不显示)，修改操作)
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}-{showStatus}/updateSaleProductEvaluationShowStatus")
    @ResponseBody
    public MsgBean updateSaleProductEvaluationShowStatus(@PathVariable("id") Integer id,
            @PathVariable("showStatus") String showStatus) {
        try {
            Param idTemp = new Param.Builder("评论ID", Param.ParamType.STR_INTEGER.getType(), id, false).build();
            Param showStatusTemp = new Param.Builder("评论显示状态", Param.ParamType.STR_NORMAL.getType(), showStatus, false)
                    .build();
            super.validateParams(idTemp, showStatusTemp);
            saleProductEvaluationService.updateShowStatusById(id, showStatus);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改商品评价显示状态成功");
        } catch (Exception e) {
            logger.error("修改商品评价显示状态失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出产品评论列表)
     * @param query
     * @return MsgBean
     */
    @RequestMapping("/exportSaleProductEvaluation")
    @ResponseBody
    public MsgBean exportSaleProductEvaluation(@RequestBody SaleProductEvaluateQuery query) {
        try {
            query.setOrder("A.CREATETIME");
            query.setSort("DESC");
            ReportFileModel reportFileModel = saleProductEvaluationReportExport.exportExcel(query, "产品评论记录统计报表");
            logger.info("SaleProductEvaluation : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "产品评论记录统计报表导出成功");
        } catch (Exception e) {
            logger.error("产品评论记录统计报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(导出门店评论列表)
     * @param query
     * @return MsgBean
     */
    @RequestMapping("/exportStoreEvaluation")
    @ResponseBody
    public MsgBean exportStoreEvaluation(@RequestBody StoreEvaluateQuery query) {
        try {
            query.setOrder("A.STOREID DESC,A.CREATETIME");
            query.setSort("DESC");
            ReportFileModel reportFileModel = storeEvaluationReportExport.exportExcel(query, "门店评论记录统计报表");
            logger.info("StoreEvaluation : " + JsonUtils.toJsonStringWithDateFormat(reportFileModel));
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "门店评论记录统计报表导出成功");
        } catch (Exception e) {
            logger.error("门店评论记录统计报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 批量门店评论导入报表
     * 
     * @param req
     *            req
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/uploadToTempForStoreEvaluate")
    @ResponseBody
    public MsgBean uploadToTempForStoreEvaluate(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.PRODUCT_STANDARD_REPORT_IMPORT_RELATIVE_PATH);
            String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.EXCEL);
            // 导入临时店铺评论报表
            StoreEvaluationDto productTempBatchSaveDto = new StoreEvaluationDto();
            productTempBatchSaveDto.setUserId(super.getUserId());
            productTempBatchSaveDto.setUserName(super.getUserName());
            List<String> validateTipsList = storeEvaluateImport.importExcel(filePathSub, productTempBatchSaveDto);
            if (!ObjectUtils.isNullOrEmpty(validateTipsList)) {
                return super.encapsulateMsgBean(validateTipsList, MsgBean.MsgCode.FAILURE, "评论店铺导入报表失败");
            } else {
                logger.info("导入报表成功");
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "导入报表成功");
            }
        } catch (Exception e) {
            logger.error("导入报表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 临时表店铺评论
     * 
     * @param req
     *            req
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/listStoreEvaluateTemps")
    @ResponseBody
    public MsgBean findStoreEvaluateTemps(@RequestBody StoreEvaluateQuery query) {
        try {
            query.setOrder("A.CREATETIME"); // 评价时间
            query.setSort("DESC");
            YiLiDiPage<StoreEvaluationDto> page = storeEvaluationService.findStoreEvaluationTemps(query);
            logger.info("Page<StoreEvaluationDto> : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询门店评价临时记录成功");
        } catch (Exception e) {
            logger.error("查询门店评价临时记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 将所有的导入的临时店铺评论添加到标准库
     * 
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/addAllTempStoreEvaluateToStandard")
    @ResponseBody
    public MsgBean addAllTempStoreEvaluateToStandard(@RequestBody StoreEvaluateQuery query) {
        try {
            List<String> error = storeEvaluationService.addAllTempStoreEvaluateToStandard(query);
            return super.encapsulateMsgBean(error, MsgBean.MsgCode.SUCCESS, "添加到标准库成功");
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 将所有的导入的临时店铺评论添加到标准库
     * 
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/addAllTempSaleProductEvaluateToStandard")
    @ResponseBody
    public MsgBean addAllTempSaleProductEvaluateToStandard(@RequestBody SaleProductEvaluateQuery query) {
        try {
            List<String> error = saleProductEvaluationService.addAllTempSaleProductEvaluateToStandard(query);
            return super.encapsulateMsgBean(error, MsgBean.MsgCode.SUCCESS, "添加到标准库成功");
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 将所有的临时店铺评论删除
     * 
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/deleteAllTempStoreEvaluate")
    @ResponseBody
    public MsgBean deleteAllTempStoreEvaluate() {
        try {
            storeEvaluationService.deleteAllStoreEvaluationTemps();
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "清理临时库成功");
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 上传文件到临时服务器
     * 
     * @param req
     *            参数req
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/uploadSaleProductEvaluationTemp")
    @ResponseBody
    public MsgBean uploadSaleProductEvaluationTemp(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.SALEPRODUCTEVALUATION_PIC_RELATIVE_PATH);
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
     * 删除临时服务器文件
     * 
     * @param req
     *            参数req
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/deleteSaleProductEvaluationTemp")
    @ResponseBody
    public MsgBean deleteSaleProductEvaluationTemp(HttpServletRequest req) {
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
     * 保存商品评论
     * 
     * @param saleProductEvaluationDto
     * @return
     */
    @RequestMapping(value = "/saveSaleProductEvaluation")
    @ResponseBody
    public MsgBean saveSaleProductEvaluation(@RequestBody SaleProductEvaluationDto saleProductEvaluationDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(saleProductEvaluationDto)) {
                if (null == saleProductEvaluationDto.getUserId()) {
                    // TODO
                    saleProductEvaluationDto.setUserId(super.getUserId());
                    saleProductEvaluationDto.setUserName(super.getUserName());
                }
                saleProductEvaluationService.save(saleProductEvaluationDto);
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "商品评论保存成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "需要保存商品评论参数为空");
            }
        } catch (Exception e) {
            logger.info("保存失败：商品评论保存失败" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 店铺评论导入报表
     * 
     * @param req
     *            req
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/listSaleProductEvaluationTemps")
    @ResponseBody
    public MsgBean findSaleProductEvaluationTemps(@RequestBody SaleProductEvaluateQuery query) {

        try {
            query.setOrder("A.CREATETIME"); // 评价时间
            query.setSort("DESC");
            YiLiDiPage<SaleProductEvaluationDto> page = saleProductEvaluationService.findSaleProductEvaluationsTemps(query);
            logger.info("Page<SaleProductEvaluationDto> : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询商品临时评价记录成功");
        } catch (Exception e) {
            logger.error("查询门店评价记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 批量门店评论导入报表
     * 
     * @param req
     *            req
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/uploadToTempForSaleProductEvaluation")
    @ResponseBody
    public MsgBean uploadToTempForSaleProductEvaluation(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.PRODUCT_STANDARD_REPORT_IMPORT_RELATIVE_PATH);
            String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.EXCEL);
            // 导入临时商品评论报表
            SaleProductEvaluationDto saleProductEvaluationTempBatchSaveDto = new SaleProductEvaluationDto();
            saleProductEvaluationTempBatchSaveDto.setUserId(super.getUserId());
            saleProductEvaluationTempBatchSaveDto.setUserName(super.getUserName());
            List<String> validateTipsList = saleProductEvaluateImport.importExcel(filePathSub,
                    saleProductEvaluationTempBatchSaveDto);
            if (!ObjectUtils.isNullOrEmpty(validateTipsList)) {
                return super.encapsulateMsgBean(validateTipsList, MsgBean.MsgCode.FAILURE, "评论商品评论导入报表失败");
            } else {
                logger.info("导入报表成功");
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "导入报表成功");
            }
        } catch (Exception e) {
            logger.error("导入报表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 将所有的导入的临时店铺评论添加到标准库
     * 
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/deleteAllTempSaleProductEvaluation")
    @ResponseBody
    public MsgBean deleteAllTempSaleProductEvaluation() {
        try {
            saleProductEvaluationService.deleteAllSaleProductEvaluationTemps();
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "清理成功");
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}
