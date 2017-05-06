package com.yilidi.o2o.controller.operation.product;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.CompressUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.product.service.IAuditProductBatchInfoService;
import com.yilidi.o2o.product.service.IAuditProductService;
import com.yilidi.o2o.product.service.dto.AuditProductBatchInfoDto;
import com.yilidi.o2o.product.service.dto.AuditProductBatchSaveDto;
import com.yilidi.o2o.product.service.dto.AuditProductDto;
import com.yilidi.o2o.product.service.dto.query.AuditProductBatchInfoQueryDto;
import com.yilidi.o2o.product.service.dto.query.AuditProductQueryDto;
import com.yilidi.o2o.report.imports.product.AuditProductReportImport;

/**
 * 数据包产品Controller
 * 
 * @author: chenlian
 * @date: 2016年12月14日 上午9:47:39
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/operation")
public class AuditProductController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    private static final String APPCHANNELCODE = SystemContext.UserDomain.CHANNELTYPE_ALL;

    private static final String STRCONTENTPIC = "contentPic";
    /**
     * 新增的待审核产品批次
     */
    private static final String BATCHNO_NEW =  "BATCHNO_NEW";
    /**
     * 正式产品修改后生成的待审核产品批次
     */
    private static final String BATCHNO_UPDATE =  "BATCHNO_UPDATE";

    @Autowired
    private IAuditProductBatchInfoService auditProductBatchInfoService;

    @Autowired
    private IAuditProductService auditProductService;

    @Autowired
    private AuditProductReportImport auditproductReportImport;

    /**
     * 数据包产品导入
     * 
     * @param req
     *            req
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping("/uploadAuditProduct")
    @ResponseBody
    public MsgBean uploadAuditProduct(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.PRODUCT_STANDARD_REPORT_IMPORT_RELATIVE_PATH);
            String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.EXCEL);
            AuditProductBatchSaveDto auditProductBatchSaveDto = new AuditProductBatchSaveDto(APPCHANNELCODE,
                    DateUtils.getCurrentDateTime(), super.getUserId());
            List<String> validateTipsList = auditproductReportImport.importExcel(filePathSub, auditProductBatchSaveDto);
            if (!ObjectUtils.isNullOrEmpty(validateTipsList)) {
                return super.encapsulateMsgBean(validateTipsList, MsgBean.MsgCode.FAILURE, "数据包产品导入失败");
            } else {
                logger.info("数据包产品导入成功");
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "数据包产品导入成功");
            }
        } catch (Exception e) {
            logger.error("数据包产品导入失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 上传产品图片压缩数据包到临时服务器
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/uploadImageCompressedDataPacket")
    @ResponseBody
    public MsgBean uploadImageCompressedDataPacket(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = "";
            String filePathSub = fileUploadUtils.uploadTempFile(items.get(0), fileRelativePath,
                    FileUploadUtils.UploadFileType.COMPRESSEDDATAPACKET);
            String uploadPath = StringUtils.defaultIfBlank(
                    SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.LOCAL_UPLOAD_FILE_BASE_PATH),
                    StringUtils.EMPTY);
            CompressUtils compressUtils = CompressUtils.getInstance();
            String fullPath = uploadPath + filePathSub;
            String ext = getExtensionName(fullPath);
            List<File> fileList = null;
            if (".zip".equals(ext.toLowerCase())) {
                fileList = compressUtils.unzip(fullPath, uploadPath);
            }
            if (".rar".equals(ext.toLowerCase())) {
                fileList = compressUtils.unrar(fullPath, uploadPath);
            }
            if (!ObjectUtils.isNullOrEmpty(fileList)) {
                for (File f : fileList) {
                    if (f.isDirectory() && !f.getPath().contains(STRCONTENTPIC)) {
                        File[] fileArray = f.listFiles();
                        if (!ObjectUtils.isNullOrEmpty(fileArray)) {
                            for (File fi : fileArray) {
                                if (!fi.isDirectory()) {
                                    File file = new File(fi.getPath().replaceAll(getExtensionName(fi.getPath()), ".jpg"));
                                    fi.renameTo(file);
                                }
                            }
                        }
                    }
                }
            }
            fileUploadUtils.deleteTempFile(filePathSub);
            return super.encapsulateMsgBean(filePathSub, MsgBean.MsgCode.SUCCESS, "上传文件成功");
        } catch (Exception e) {
            logger.error("上传文件失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    private String getExtensionName(String filename) {
        String ext = "";
        if ((filename != null) && (filename.length() > 0)) {
            int dot = filename.lastIndexOf('.');
            if ((dot >= 0) && (dot < (filename.length() - 1))) {
                ext = filename.substring(dot);
            }
        }
        return ext;
    }

    /**
     * 分页获取数据包产品批次信息列表
     * 
     * @param auditProductBatchInfoQueryDto
     *            数据包产品批次信息查询DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/findPacketProductBatchInfos")
    @ResponseBody
    public MsgBean findPacketProductBatchInfos(@RequestBody AuditProductBatchInfoQueryDto auditProductBatchInfoQueryDto) {
        try {
            auditProductBatchInfoQueryDto.setOrder("CREATETIME");
            auditProductBatchInfoQueryDto.setSort("DESC");
            auditProductBatchInfoQueryDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_PACKET);//查询数据包导入的批次
            YiLiDiPage<AuditProductBatchInfoDto> page = auditProductBatchInfoService
                    .findAuditProductBatchInfos(auditProductBatchInfoQueryDto);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "分页获取数据包产品批次信息列表成功");
        } catch (Exception e) {
            logger.error("分页获取数据包产品批次信息列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    /**
     * 分页获取待审核产品批次信息列表
     * 
     * @param auditProductBatchInfoQueryDto
     *            数据包产品批次信息查询DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/findAuditProductBatchInfos")
    @ResponseBody
    public MsgBean findAuditProductBatchInfos(@RequestBody AuditProductBatchInfoQueryDto auditProductBatchInfoQueryDto) {
        try {
            auditProductBatchInfoQueryDto.setOrder("CREATETIME");
            auditProductBatchInfoQueryDto.setSort("DESC");
            auditProductBatchInfoQueryDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_STANDARD);//查询新建或修改的产品批次
            YiLiDiPage<AuditProductBatchInfoDto> page = auditProductBatchInfoService
                    .findAuditProductBatchInfos(auditProductBatchInfoQueryDto);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "分页获取待审核产品批次信息列表成功");
        } catch (Exception e) {
            logger.error("分页获取待审核产品批次信息列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 删除数据包产品批次
     * 
     * @param param
     *            删除数据包产品批次相关参数
     * @return MsgBean
     */
    @RequestMapping(value = "/{param}/deleteAuditProductBatchInfos")
    @ResponseBody
    public MsgBean deleteAuditProductBatchInfos(@PathVariable String param) {
        try {
            List<String> submitStatusList = new ArrayList<String>();
            submitStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_NONE);
            @SuppressWarnings("unchecked")
            List<String> batchNos = StringUtils.parseList(param, CommonConstants.DELIMITER_COMMA, String.class);
            auditProductService.deleteAuditProductByBatchNoBatch(batchNos, submitStatusList);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "删除数据包产品批次成功");
        } catch (Exception e) {
            logger.error("删除数据包产品批次失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 分页获取数据包产品信息列表
     * 
     * @param auditProductQueryDto
     *            数据包产品信息查询DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/findPacketProducts")
    @ResponseBody
    public MsgBean findPacketProducts(@RequestBody AuditProductQueryDto auditProductQueryDto) {
        try {
            auditProductQueryDto.setOrder("MODIFYTIME");
            auditProductQueryDto.setSort("DESC");
            auditProductQueryDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_PACKET);
            YiLiDiPage<AuditProductDto> page = auditProductService.findAuditProducts(auditProductQueryDto);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "分页获取数据包产品信息列表成功");
        } catch (Exception e) {
            logger.error("分页获取数据包产品信息列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /**
     * 分页获取待审核产品信息列表
     * 
     * @param auditProductQueryDto
     *            数据包产品信息查询DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/findAuditProducts")
    @ResponseBody
    public MsgBean findAuditProducts(@RequestBody AuditProductQueryDto auditProductQueryDto) {
        try {
            auditProductQueryDto.setOrder("CREATETIME DESC,MODIFYTIME");
            auditProductQueryDto.setSort("DESC");
            auditProductQueryDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_STANDARD);
            YiLiDiPage<AuditProductDto> page = auditProductService.findAuditProducts(auditProductQueryDto);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "分页获取待审核产品信息列表成功");
        } catch (Exception e) {
            logger.error("分页获取待审核产品信息列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 根据数据包产品ID获取数据包产品信息
     * 
     * @param auditProductId
     *            数据包产品ID
     * @return MsgBean
     */
    @RequestMapping(value = "/{auditProductId}/loadAuditProduct")
    @ResponseBody
    public MsgBean loadAuditProduct(@PathVariable Integer auditProductId) {
        try {
            AuditProductDto auditProductDto = auditProductService.loadAuditProductById(auditProductId);
            if (ObjectUtils.isNullOrEmpty(auditProductDto)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据包产品不存在");
            }
            return super.encapsulateMsgBean(auditProductDto, MsgBean.MsgCode.SUCCESS, "根据数据包产品ID获取数据包产品信息成功");
        } catch (Exception e) {
            logger.error("根据数据包产品ID获取数据包产品信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 修改数据包产品信息
     * 
     * @param auditProductDto
     *            数据包产品信息DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/updatePacketProduct")
    @ResponseBody
    public MsgBean updatePacketProduct(@RequestBody AuditProductDto auditProductDto) {
        try {
            auditProductDto.setModifyUserId(super.getUserId());
            auditProductDto.setModifyTime(new Date());
            auditProductDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_PACKET);
            auditProductService.updateAuditProductBasicInfoById(auditProductDto, APPCHANNELCODE);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "修改数据包产品信息成功");
        } catch (Exception e) {
            logger.error("修改数据包产品信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    /**
     * 修改待审核产品信息
     * 
     * @param auditProductDto
     *            待审核产品信息DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/updateAuditProduct")
    @ResponseBody
    public MsgBean updateAuditProduct(@RequestBody AuditProductDto auditProductDto) {
        try {
            auditProductDto.setModifyUserId(super.getUserId());
            auditProductDto.setModifyTime(new Date());
            auditProductDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_STANDARD);
            auditProductService.updateAuditProductBasicInfoById(auditProductDto, APPCHANNELCODE);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "修改待审核产品信息成功");
        } catch (Exception e) {
            logger.error("修改待审核产品信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /**
     * 新增产品(非数据包导入)
     * 
     * @param auditProductDto
     *            产品信息DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/addAuditProduct")
    @ResponseBody
    public MsgBean addAuditProduct(@RequestBody AuditProductDto auditProductDto) {
        try {
            auditProductDto.setCreateUserId(super.getUserId());
            auditProductDto.setCreateTime(new Date());
            auditProductDto.setBatchNo(BATCHNO_NEW);
            auditProductDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_STANDARD);
            auditProductService.saveAuditProduct(auditProductDto, APPCHANNELCODE);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "新增产品成功");
        } catch (Exception e) {
            logger.error("新增产品失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    /**
     * 新增产品(非数据包导入)
     * 
     * @param auditProductDto
     *            产品信息DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/addAuditProductForUpdate")
    @ResponseBody
    public MsgBean addAuditProductForUpdate(@RequestBody AuditProductDto auditProductDto) {
        try {
            auditProductDto.setCreateUserId(super.getUserId());
            auditProductDto.setCreateTime(new Date());
            auditProductDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_STANDARD);
            auditProductDto.setBatchNo(BATCHNO_UPDATE);
            auditProductService.saveAuditProduct(auditProductDto, APPCHANNELCODE);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "新增产品成功");
        } catch (Exception e) {
            logger.error("新增产品失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 提交审核数据包产品
     * 
     * @param param
     *            提交审核相关参数
     * @return MsgBean
     */
    @RequestMapping(value = "/{param}/doSubmitAudit")
    @ResponseBody
    public MsgBean doSubmitAudit(@PathVariable String param) {
        try {
            String ids = null;
            String batchNo = null;
            String[] initAuditInfos = param.split(CommonConstants.DELIMITER_HR);
            if (initAuditInfos.length == 2) {
                ids = initAuditInfos[0];
                batchNo = initAuditInfos[1];
            }
            List<String> preAuditStatusList = new ArrayList<String>();
            preAuditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_AUDIT);
            preAuditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_INIT_AUDIT_REJECTED);
            preAuditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FINAL_AUDIT_REJECTED);
            Date currentTime = DateUtils.getCurrentDateTime();
            Date submitTime = currentTime;
            String auditStatus = SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_INIT_AUDIT;
            Integer modifyUserId = super.getUserId();
            Date modifyTime = currentTime;
            @SuppressWarnings("unchecked")
            List<Integer> idList = StringUtils.parseList(ids, CommonConstants.DELIMITER_COMMA, Integer.class);
            auditProductService.updateAuditStatusBySubmitBatch(batchNo, idList, preAuditStatusList, submitTime,
                    auditStatus, modifyUserId, modifyTime);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "提交审核数据包产品成功");
        } catch (Exception e) {
            logger.error("提交审核数据包产品失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 删除数据包产品
     * 
     * @param param
     *            删除数据包产品相关参数
     * @return MsgBean
     */
    @RequestMapping(value = "/{param}/deleteAuditProducts")
    @ResponseBody
    public MsgBean deleteAuditProducts(@PathVariable String param) {
        try {
            String ids = null;
            String batchNo = null;
            String[] initAuditInfos = param.split(CommonConstants.DELIMITER_HR);
            if (initAuditInfos.length == 2) {
                ids = initAuditInfos[0];
                batchNo = initAuditInfos[1];
            }
            List<String> auditStatusList = new ArrayList<String>();
            auditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_AUDIT);
            auditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_INIT_AUDIT_REJECTED);
            auditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FINAL_AUDIT_REJECTED);
            Date currentTime = DateUtils.getCurrentDateTime();
            Integer modifyUserId = super.getUserId();
            Date modifyTime = currentTime;
            @SuppressWarnings("unchecked")
            List<Integer> idList = StringUtils.parseList(ids, CommonConstants.DELIMITER_COMMA, Integer.class);
            auditProductService.deleteAuditProductByIdBatch(batchNo, idList, auditStatusList, modifyUserId, modifyTime);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "删除数据包产品成功");
        } catch (Exception e) {
            logger.error("删除数据包产品失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 初审数据包产品（通过）
     * 
     * @param id
     *            数据包产品ID
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/doInitAuditPass")
    @ResponseBody
    public MsgBean doInitAuditPass(@PathVariable String id) {
        try {
            String preAuditStatus = SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_INIT_AUDIT;
            Date currentTime = DateUtils.getCurrentDateTime();
            Date initAuditTime = currentTime;
            String auditStatus = SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_FINAL_AUDIT;
            Integer initAuditUserId = super.getUserId();
            Integer modifyUserId = super.getUserId();
            Date modifyTime = currentTime;
            String initAuditRejectReason = null;
            AuditProductDto auditProductDto = auditProductService.loadAuditProductById(Integer.valueOf(id));
            if (ObjectUtils.isNullOrEmpty(auditProductDto)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据包产品不存在");
            }
            auditProductService.updateAuditStatusByInitAudit(auditProductDto.getBatchNo(), Integer.valueOf(id),
                    preAuditStatus, auditStatus, initAuditUserId, initAuditTime, initAuditRejectReason, modifyUserId,
                    modifyTime);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "初审数据包产品成功");
        } catch (Exception e) {
            logger.error("初审数据包产品失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 初审数据包产品（不通过）
     * 
     * @param param
     *            初审相关参数
     * @return MsgBean
     */
    @RequestMapping(value = "/{param}/doInitAuditNoPass")
    @ResponseBody
    public MsgBean doInitAuditNoPass(@PathVariable String param) {
        try {
            Integer id = null;
            String initAuditRejectReason = null;
            String[] initAuditInfos = param.split(CommonConstants.DELIMITER_HR);
            if (initAuditInfos.length == 2) {
                id = Integer.valueOf(initAuditInfos[0]);
                initAuditRejectReason = initAuditInfos[1];
            } else {
                id = Integer.valueOf(initAuditInfos[0]);
            }
            String preAuditStatus = SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_INIT_AUDIT;
            Date currentTime = DateUtils.getCurrentDateTime();
            Date initAuditTime = currentTime;
            String auditStatus = SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_INIT_AUDIT_REJECTED;
            Integer initAuditUserId = super.getUserId();
            Integer modifyUserId = super.getUserId();
            Date modifyTime = currentTime;
            AuditProductDto auditProductDto = auditProductService.loadAuditProductById(id);
            if (ObjectUtils.isNullOrEmpty(auditProductDto)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据包产品不存在");
            }
            auditProductService.updateAuditStatusByInitAudit(auditProductDto.getBatchNo(), id, preAuditStatus,
                    auditStatus, initAuditUserId, initAuditTime, initAuditRejectReason, modifyUserId, modifyTime);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "初审数据包产品成功");
        } catch (Exception e) {
            logger.error("初审数据包产品失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 终审数据包产品（通过）
     * 
     * @param id
     *            数据包产品ID
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/doFinalAuditPass")
    @ResponseBody
    public MsgBean doFinalAuditPass(@PathVariable String id) {
        try {
            String preAuditStatus = SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_FINAL_AUDIT;
            Date currentTime = DateUtils.getCurrentDateTime();
            Date finalAuditTime = currentTime;
            String auditStatus = SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FINISHED;
            Integer finalAuditUserId = super.getUserId();
            Integer modifyUserId = super.getUserId();
            Date modifyTime = currentTime;
            String finalAuditRejectReason = null;
            AuditProductDto auditProductDto = auditProductService.loadAuditProductById(Integer.valueOf(id));
            if (ObjectUtils.isNullOrEmpty(auditProductDto)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据包产品不存在");
            }
            auditProductService.saveStandardProFromPacketProByFinalAuditPass(auditProductDto.getBatchNo(),
                    Integer.valueOf(id), preAuditStatus, auditStatus, finalAuditUserId, finalAuditTime,
                    finalAuditRejectReason, modifyUserId, modifyTime);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "终审数据包产品成功");
        } catch (Exception e) {
            logger.error("终审数据包产品失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 终审数据包产品（不通过）
     * 
     * @param param
     *            终审相关参数
     * @return MsgBean
     */
    @RequestMapping(value = "/{param}/doFinalAuditNoPass")
    @ResponseBody
    public MsgBean doFinalAuditNoPass(@PathVariable String param) {
        try {
            Integer id = null;
            String finalAuditRejectReason = null;
            String[] finalAuditInfos = param.split(CommonConstants.DELIMITER_HR);
            if (finalAuditInfos.length == 2) {
                id = Integer.valueOf(finalAuditInfos[0]);
                finalAuditRejectReason = finalAuditInfos[1];
            } else {
                id = Integer.valueOf(finalAuditInfos[0]);
            }
            String preAuditStatus = SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_FINAL_AUDIT;
            Date currentTime = DateUtils.getCurrentDateTime();
            Date finalAuditTime = currentTime;
            String auditStatus = SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FINAL_AUDIT_REJECTED;
            Integer finalAuditUserId = super.getUserId();
            Integer modifyUserId = super.getUserId();
            Date modifyTime = currentTime;
            AuditProductDto auditProductDto = auditProductService.loadAuditProductById(id);
            if (ObjectUtils.isNullOrEmpty(auditProductDto)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据包产品不存在");
            }
            auditProductService.updateAuditStatusByFinalAudit(auditProductDto.getBatchNo(), id, preAuditStatus,
                    auditStatus, finalAuditUserId, finalAuditTime, finalAuditRejectReason, modifyUserId, modifyTime);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "终审数据包产品成功");
        } catch (Exception e) {
            logger.error("终审数据包产品失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 分页获取初审数据包产品信息列表
     * 
     * @param auditProductQueryDto
     *            数据包产品信息查询DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/findPacketProductsForInitAudit")
    @ResponseBody
    public MsgBean findPacketProductsForInitAudit(@RequestBody AuditProductQueryDto auditProductQueryDto) {
        try {
            List<String> initAuditStatusList = new ArrayList<String>();
            initAuditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_INIT_AUDIT);
            initAuditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_INIT_AUDIT_REJECTED);
            auditProductQueryDto.setInitAuditStatusList(initAuditStatusList);
            auditProductQueryDto.setOrder("MODIFYTIME");
            auditProductQueryDto.setSort("DESC");
            auditProductQueryDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_PACKET);
            YiLiDiPage<AuditProductDto> page = auditProductService.findAuditProducts(auditProductQueryDto);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "分页获取初审数据包产品信息列表成功");
        } catch (Exception e) {
            logger.error("分页获取初审数据包产品信息列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 分页获取终审数据包产品信息列表
     * 
     * @param auditProductQueryDto
     *            数据包产品信息查询DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/findPacketProductsForFinalAudit")
    @ResponseBody
    public MsgBean findPacketProductsForFinalAudit(@RequestBody AuditProductQueryDto auditProductQueryDto) {
        try {
            List<String> finalAuditStatusList = new ArrayList<String>();
            finalAuditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_FINAL_AUDIT);
            finalAuditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FINAL_AUDIT_REJECTED);
            auditProductQueryDto.setFinalAuditStatusList(finalAuditStatusList);
            auditProductQueryDto.setOrder("MODIFYTIME");
            auditProductQueryDto.setSort("DESC");
            auditProductQueryDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_PACKET);
            YiLiDiPage<AuditProductDto> page = auditProductService.findAuditProducts(auditProductQueryDto);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "分页获取终审数据包产品信息列表成功");
        } catch (Exception e) {
            logger.error("分页获取终审数据包产品信息列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /**
     * 分页获取初审待审核产品信息列表
     * 
     * @param auditProductQueryDto
     *            待审核产品信息查询DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/findAuditProductsForInitAudit")
    @ResponseBody
    public MsgBean findAuditProductsForInitAudit(@RequestBody AuditProductQueryDto auditProductQueryDto) {
        try {
            List<String> initAuditStatusList = new ArrayList<String>();
            initAuditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_INIT_AUDIT);
            initAuditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_INIT_AUDIT_REJECTED);
            auditProductQueryDto.setInitAuditStatusList(initAuditStatusList);
            auditProductQueryDto.setOrder("MODIFYTIME");
            auditProductQueryDto.setSort("DESC");
            auditProductQueryDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_STANDARD);
            YiLiDiPage<AuditProductDto> page = auditProductService.findAuditProducts(auditProductQueryDto);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "分页获取初审数据包产品信息列表成功");
        } catch (Exception e) {
            logger.error("分页获取初审数据包产品信息列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 分页获取终审待审核产品信息列表
     * 
     * @param auditProductQueryDto
     *            待审核产品信息查询DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/findAuditProductsForFinalAudit")
    @ResponseBody
    public MsgBean findAuditProductsForFinalAudit(@RequestBody AuditProductQueryDto auditProductQueryDto) {
        try {
            List<String> finalAuditStatusList = new ArrayList<String>();
            finalAuditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_FINAL_AUDIT);
            finalAuditStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FINAL_AUDIT_REJECTED);
            auditProductQueryDto.setFinalAuditStatusList(finalAuditStatusList);
            auditProductQueryDto.setOrder("MODIFYTIME");
            auditProductQueryDto.setSort("DESC");
            auditProductQueryDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_STANDARD);
            YiLiDiPage<AuditProductDto> page = auditProductService.findAuditProducts(auditProductQueryDto);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "分页获取终审数据包产品信息列表成功");
        } catch (Exception e) {
            logger.error("分页获取终审数据包产品信息列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}