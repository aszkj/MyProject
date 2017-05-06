package com.yilidi.o2o.controller.operation.product;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.StringUtils;
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
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.IProductBrandService;
import com.yilidi.o2o.product.service.dto.ProductBrandDto;
import com.yilidi.o2o.product.service.dto.query.ProductBrandQueryDto;

/**
 * 功能描述：品牌控制器 <br/>
 * 作者：xiasl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/operation")
public class ProductBrandController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());
    
    private static final String BRAND_PIC_RELATIVE_PATH_DEFAULT = "/pic/brand";


    @Autowired
    private IProductBrandService productBrandService;

    @RequestMapping(value = "/findProductBrandInfos")
    @ResponseBody
    public MsgBean ProductBrandInfos(@RequestBody ProductBrandQueryDto queryProductBrand) {
        try {
        	queryProductBrand.setOrder(DBTablesColumnsName.ProductBrand.DISPLAYORDER);
        	queryProductBrand.setSort(CommonConstants.SORT_ORDER_ASC+" ,MODIFYTIME DESC");
            YiLiDiPage<ProductBrandDto> page = productBrandService.findProductBrandInfos(queryProductBrand);
            if (!ObjectUtils.isNullOrEmpty(page)) {
                return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "品牌显示信息列表查询成功");
            } else {
                logger.info("查询失败：产品品牌信息列表不存在");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "品牌显示信息列表不存在");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /**
     * 新增品牌
     * 
     * @param productBrandDto
     *            保存实体
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/saveProductBrand")
    @ResponseBody
    public MsgBean saveProductBrand(@RequestBody ProductBrandDto productBrandDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(productBrandDto)) {
            	productBrandDto.setCreateUserId(super.getUserId());
            	productBrandDto.setCreateTime(new Date());
                productBrandService.saveProductBrand(productBrandDto);
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "品牌信息保存成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "需要保存品牌参数为空");
            }
        } catch (Exception e) {
            logger.info("保存失败：品牌保存失败" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 更新品牌
     * 
     * @param productBrandDto
     *            更新实体
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/updateProductBrand")
    @ResponseBody
    public MsgBean updateProductBrand(@RequestBody ProductBrandDto productBrandDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(productBrandDto)) {
            	productBrandDto.setModifyUserId(super.getUserId());
            	productBrandDto.setModifyTime(new Date());
                productBrandService.updateProductBrand(productBrandDto);
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "品牌信息更新成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "需要更新品牌参数为空");
            }
        } catch (Exception e) {
            logger.info("更新失败：品牌更新失败" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /**
     * 校验品牌名称是否已存在
     * 
     * @param brandName
     *            校验品牌名称是否已存在
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{brandName}/checkBrandNameIsExist")
    @ResponseBody
    public MsgBean checkBrandNameIsExist(@PathVariable("brandName") String brandName) {
        try {
                ProductBrandDto dto=productBrandService.getBrandByName(brandName);
                boolean flag = ObjectUtils.isNullOrEmpty(dto)?false:true;
                return super.encapsulateMsgBean(flag,MsgBean.MsgCode.SUCCESS, "品牌名称");
        } catch (Exception e) {
            logger.info("更新失败：品牌更新失败" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    /**
     * 校验品牌名称是否已存在
     * 
     * @param brandName
     *            校验品牌名称是否已存在
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{brandName}/checkBrandNameIsExistForCreateProduct")
    @ResponseBody
    public MsgBean checkBrandNameIsExistForCreateProduct(@PathVariable("brandName") String brandName) {
        try {
                ProductBrandDto dto=productBrandService.getBrandByName(brandName);
                boolean flag = ObjectUtils.isNullOrEmpty(dto)?false:true;
                if(!ObjectUtils.isNullOrEmpty(dto)){
                	if(dto.getStatusCode().equals(SystemContext.ProductDomain.PRODUCTBRANDSTATUS_OFF)){
                		flag = false;
                	}
                }
                return super.encapsulateMsgBean(flag,MsgBean.MsgCode.SUCCESS, "品牌名称");
        } catch (Exception e) {
            logger.info("更新失败：品牌更新失败" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /**
     * 品牌上下架
     * 
     * @param param
     *            品牌ID和上下架状态
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateStatusCode")
    @ResponseBody
    public MsgBean updateStatusCode(@PathVariable String param) {
        try {
            logger.info("更新实体传递参数：品牌信息" + param);
            Integer userId = super.getUserId();
            String typeString = "";
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] params = param.split(",");
                if (params[1].equals(SystemContext.ProductDomain.PRODUCTBRANDSTATUS_ON)) {
                    typeString = "下架";
                } else {
                    typeString = "上架";
                }
                productBrandService.updateStatusCodeByBrandCode(params[0], params[1],
                         userId, new Date());
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "品牌" + typeString + "成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "品牌" + typeString + "失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取品牌
     * 
     * @param productBrandId
     *            参数classCode
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{productBrandId}/loadProductBrand")
    @ResponseBody
    public MsgBean loadProductBrand(@PathVariable Integer productBrandId) {
        try {
        	ProductBrandDto productBrandDto = productBrandService.loadProductBrandById(productBrandId);
            if (!ObjectUtils.isNullOrEmpty(productBrandDto)) {
                return super.encapsulateMsgBean(productBrandDto, MsgBean.MsgCode.SUCCESS, "品牌查询成功");
            } else {
                logger.info("查询失败：品牌信息不存在");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "品牌不存在");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /**
     * 上传品牌logo图片到临时服务器
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/uploadBrandImageTemp")
    @ResponseBody
    public MsgBean uploadBrandImageTemp(HttpServletRequest req) {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            List<FileItem> items = fileUploadUtils.getUploadFiles(req);
            logger.info("items : " + items);
            String fileRelativePath = systemBasicDataInfoUtils
                    .getSystemParamValue(SystemContext.SystemParams.BRAND_PIC_RELATIVE_PATH);
            fileRelativePath = StringUtils.isEmpty(fileRelativePath) ? BRAND_PIC_RELATIVE_PATH_DEFAULT
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
     * 删除品牌logo相关临时图片
     * 
     * @param req
     *            参数req
     * @return MsgBean
     */
    @RequestMapping("/deleteBrandTemp")
    @ResponseBody
    public MsgBean deleteBrandTemp(HttpServletRequest req) {
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
     * 获取所有品牌（通用）
     * 
     * 
     * @return
     */
    @RequestMapping("/getAllBrandBasic")
    @ResponseBody
    public MsgBean getAllBrandBasic() {
        try {
            List<ProductBrandDto> brandDtoList = productBrandService.getAllBrandBasic();
            if (!ObjectUtils.isNullOrEmpty(brandDtoList)) {
                return super.encapsulateMsgBean(brandDtoList, MsgBean.MsgCode.SUCCESS, "");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "");
            }
        } catch (Exception e) {
            logger.error("加载品牌失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    

}