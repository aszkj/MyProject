package com.yilidi.o2o.controller.operation.product;

import java.util.Date;
import java.util.List;
import java.util.Map;

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
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.service.IProductClassMapStoreTypeService;
import com.yilidi.o2o.product.service.IProductClassMappingService;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.dto.ProductClassDto;
import com.yilidi.o2o.product.service.dto.ProductClassMappingDto;
import com.yilidi.o2o.product.service.dto.ProductClassStoreTypeDto;
import com.yilidi.o2o.product.service.dto.StoreTypeProductClassDto;
import com.yilidi.o2o.product.service.dto.query.ProductClassQuery;

/**
 * 功能描述：产品类别控制器 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "/operation")
public class ProductClassController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IProductClassService productClassService;

    @Autowired
    private IProductClassMapStoreTypeService productClassMapStoreTypeService;

    @Autowired
    private IProductClassMappingService productClassMappingService;

    /**
     * 新增产品类别
     * 
     * @param productClassDto
     *            保存实体
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/saveProductClass")
    @ResponseBody
    public MsgBean saveProductClass(@RequestBody ProductClassDto productClassDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                String parentClassCode = productClassDto.getClassCode();
                // 生成产品类别编码
                String productClassCode = this.generateClassCode();
                productClassDto.setClassCode(productClassCode);
                productClassDto.setCreateUserId(super.getUserId());
                productClassDto.setCreateTime(new Date());
                productClassService.saveProductClass(productClassDto);
                // 建立分类关系映射
                String mapString = productClassDto.getClassCode() + "," + parentClassCode;
                productClassMappingService.saveProductClassMapping(mapString, this.getUserId(), new Date());
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品信息保存成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "需要保存产品类别参数为空");
            }
        } catch (Exception e) {
            logger.info("保存失败：产品类别保存失败" + e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 生成产品类别编码ClassCode(长度为20，yyyyMMddHHmmssSSS+3位随机数)
     * 
     * @return 20个字符的单号
     */
    private String generateClassCode() {
        StringBuffer sb = new StringBuffer();
        sb.append("PC");
        sb.append(DateUtils.formatDate(new Date(), "yyyyMMddHHmmssSSS"));
        sb.append(StringUtils.randomString(3));
        return sb.toString();
    }

    /**
     * 更新产品类别
     * 
     * @param productClassDto
     *            保存实体
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/updateProductClass")
    @ResponseBody
    public MsgBean updateProductClass(@RequestBody ProductClassDto productClassDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                productClassDto.setModifyUserId(super.getUserId());
                productClassDto.setModifyTime(new Date());
                productClassService.updateProductClass(productClassDto);
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品信息更新成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "需要更新产品类别参数为空");
            }
        } catch (Exception e) {
            logger.info("更新失败：产品类别更新失败" + e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 冻结产品类别
     * 
     * @param classCode
     *            冻结产品类别classCode
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{classCode}/freezeProductClass")
    @ResponseBody
    public MsgBean freezeProductClass(@PathVariable String classCode) {
        try {
            if (!ObjectUtils.isNullOrEmpty(classCode)) {
                String errorString = productClassService.updateStatusCodeById(
                        SystemContext.ProductDomain.PRODUCTCLASSSTATUS_OFF, classCode, super.getUserId(), new Date());
                if (!ObjectUtils.isNullOrEmpty(errorString)) {
                    return super.encapsulateMsgBean(errorString, MsgBean.MsgCode.FAILURE, "冻结产品类别失败");
                } else {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "冻结产品类别成功");
                }
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "需要冻结产品类别参数id为空");
            }
        } catch (Exception e) {
            logger.info("冻结失败：冻结产品类别失败" + e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 产品类别禁用和启用
     * 
     * @param param
     *            产品类别ID和禁用和启用标示
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{param}/updateProductClassStatus")
    @ResponseBody
    public MsgBean updateProductClassStatus(@PathVariable String param) {
        try {
            String typeString = "";
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] params = param.split(",");
                if (params[1].equals(SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON)) {
                    typeString = "启用";
                } else {
                    typeString = "禁用";
                }
                String errorString = productClassService.updateStatusCodeById(params[1], params[0], super.getUserId(),
                        new Date());
                if (!ObjectUtils.isNullOrEmpty(errorString)) {
                    return super.encapsulateMsgBean(errorString, MsgBean.MsgCode.FAILURE, "产品类别" + typeString + "失败");
                } else {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "产品类别" + typeString + "成功");
                }
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "产品类别参数为空" + typeString + "失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 启用产品类别
     * 
     * @param classCode
     *            启用产品类别classCode
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{classCode}/enableProductClass")
    @ResponseBody
    public MsgBean enableProductClass(@PathVariable String classCode) {
        try {
            if (!ObjectUtils.isNullOrEmpty(classCode)) {
                String errorString = productClassService.updateStatusCodeById(
                        SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON, classCode, super.getUserId(), new Date());
                return super.encapsulateMsgBean(errorString, MsgBean.MsgCode.SUCCESS, "启用产品类别成功");
            } else {
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "需要启用产品类别参数为空");
            }
        } catch (Exception e) {
            logger.info("更新失败：启用产品类别失败" + e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 删除产品类别
     * 
     * @param id
     *            参数classCode
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{id}/deleteProductClass")
    @ResponseBody
    public MsgBean deleteProductClass(@PathVariable Integer id) {
        try {
            if (!ObjectUtils.isNullOrEmpty(id)) {
                String errorString = productClassService.deleteProductClassById(id);
                if (!ObjectUtils.isNullOrEmpty(errorString)) {
                    return super.encapsulateMsgBean(errorString, MsgBean.MsgCode.FAILURE, "产品类别删除失败");
                } else {
                    logger.info("删除成功：删除产品类别信息成功");
                    return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "删除产品类别信息成功");
                }
            } else {
                logger.info("失败：删除产品类别ID为空");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "删除产品类别Id为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取产品类别
     * 
     * @param classCode
     *            参数classCode
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{classCode}/loadProductClass")
    @ResponseBody
    public MsgBean loadProductClass(@PathVariable String classCode) {
        try {
            if (!ObjectUtils.isNullOrEmpty(classCode)) {
                ProductClassDto productClassDto = productClassService.loadProductClassByClassCode(classCode, null);
                if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                    return super.encapsulateMsgBean(productClassDto, MsgBean.MsgCode.SUCCESS, "产品类别查询成功");
                } else {
                    logger.info("查询失败：产品类别信息不存在");
                    return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "产品类别不存在");
                }
            } else {
                logger.info("失败：查询产品类别编码为空");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "查询产品类别编码为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 查询一级产品类别列表（分页）
     * 
     * @param queryProductClass
     *            产品类别条件查询
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/findProductClassFirst")
    @ResponseBody
    public MsgBean findProductClassFirst(@RequestBody ProductClassQuery queryProductClass) {
        try {
            queryProductClass.setClassLevel(SystemContext.ProductDomain.PRODUCTCLASSSLEVEL_FIRST);
            YiLiDiPage<ProductClassDto> productClassPage = productClassService.findProductClass(queryProductClass);
            if (!ObjectUtils.isNullOrEmpty(productClassPage)) {
                return super.encapsulateMsgBean(productClassPage, MsgBean.MsgCode.SUCCESS, "产品一级类别分页列表查询成功");
            } else {
                logger.info("查询失败：产品一级类别分页列表不存在");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "产品一级类别分页列表不存在");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }


    /**
     * 查询产品一级类别列表
     * 
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/listProductClassFirst")
    @ResponseBody
    public MsgBean listProductClassFirst() {
        try {
            ProductClassQuery queryProductClass = new ProductClassQuery();
            queryProductClass.setClassLevel(SystemContext.ProductDomain.PRODUCTCLASSSLEVEL_FIRST);
            queryProductClass.setStatusCode(SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
            List<ProductClassDto> productClassList = productClassService.listProductClass(queryProductClass);
            if (!ObjectUtils.isNullOrEmpty(productClassList)) {
                return super.encapsulateMsgBean(productClassList, MsgBean.MsgCode.SUCCESS, "产品一级类别列表查询成功");
            } else {
                logger.info("查询失败：产品一级类别列表不存在");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "产品一级类别列表不存在");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取店铺类型与产品基础类别的映射关系
     * 
     * @param storeDictCode
     *            参数店铺类型字典编码storeDictCode
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{storeDictCode}/listBasicClassStoreType")
    @ResponseBody
    public MsgBean listBasicClassStoreType(@PathVariable String storeDictCode) {
        try {
            if (!ObjectUtils.isNullOrEmpty(storeDictCode)) {
                List<ProductClassStoreTypeDto> listProductClassStoreTypeDto = productClassMapStoreTypeService
                        .listBasicClassStoreType(storeDictCode, SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
                if (!ObjectUtils.isNullOrEmpty(listProductClassStoreTypeDto)) {
                    return super.encapsulateMsgBean(listProductClassStoreTypeDto, MsgBean.MsgCode.SUCCESS,
                            "店铺类型与产品基础类别的映射关系列表查询成功");
                } else {
                    return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "店铺类型与产品基础类别的映射关系列表不存在");
                }
            } else {
                logger.info("失败：店铺类型字典编码为空");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "店铺类型字典编码为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 保存店铺类型与产品基础类别的映射关系
     * 
     * @param mapString
     *            productClass字符串组和StoreType
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{mapString}/saveStoreTypeBasicClass")
    @ResponseBody
    public MsgBean saveStoreTypeBasicClass(@PathVariable String mapString) {
        try {
            if (!ObjectUtils.isNullOrEmpty(mapString)) {
                Map<String, Object> modelMsg = productClassMapStoreTypeService.saveProductClassStoreType(mapString, super.getUserId(), new Date());
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, (String)modelMsg.get("msg"));
            } else {
                logger.info("失败：店铺类型字典编码与产品基础类别的映射为空");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "店铺类型字典编码与产品基础类别的映射为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取产品一级类别与基础类别的映射关系
     * 
     * @param classCode
     *            一级类别编码
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{classCode}/listProductClassMapping")
    @ResponseBody
    public MsgBean listProductClassMapping(@PathVariable String classCode) {
        try {
            if (!ObjectUtils.isNullOrEmpty(classCode)) {
                List<ProductClassMappingDto> listProductClassMappingDto = productClassMappingService
                        .listProductClassMapping(classCode, SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
                if (!ObjectUtils.isNullOrEmpty(listProductClassMappingDto)) {
                    return super.encapsulateMsgBean(listProductClassMappingDto, MsgBean.MsgCode.SUCCESS,
                            "产品一级类别与基础类别的映射关系列表查询成功");
                } else {
                    return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "产品一级类别与基础类别的映射关系列表不存在");
                }
            } else {
                logger.info("失败：产品一级类别编码为空");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品一级类别编码为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 保存产品一级类别与基础类别的映射关系
     * 
     * @param mapString
     *            productClass字符串组和StoreType
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{mapString}/saveProductClassMapping")
    @ResponseBody
    public MsgBean saveProductClassMapping(@PathVariable String mapString) {
        try {
            if (!ObjectUtils.isNullOrEmpty(mapString)) {
                productClassMappingService.saveProductClassMapping(mapString, super.getUserId(), new Date());
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "产品一级类别与基础类别的映射关系列表映射关系保存成功");
            } else {
                logger.info("失败：产品一级类别与基础类别的映射关系列表映射关系为空");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "产品一级类别与基础类别的映射关系列表映射为空");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 根据下级classCode查上级分类
     * 
     * @return
     */
    @RequestMapping(value = "/{classCode}/getUpProductClassByClassCode")
    @ResponseBody
    public MsgBean getUpProductClassByClassCode(@PathVariable("classCode") String classCode) {
        if (StringUtils.isEmpty(classCode)) {
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "分类数据有误");
        }
        try {
            ProductClassDto productClassDto = productClassService.getUpProductClassByClassCode(classCode);
            if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                return super.encapsulateMsgBean(productClassDto, MsgBean.MsgCode.SUCCESS, "");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "未获取到下一级分类数据");
            }
        } catch (Exception e) {
            logger.info("根据下级classCode查上级分类数据异常");
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 根据上一级code所有查出下一级分类
     * 
     * @param productClassQuery
     * @return
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/{classCode}/getAllNextProductClassByUpCode")
    @ResponseBody
    public MsgBean getAllNextProductClassByUpCode(@PathVariable("classCode") String classCode) {
        if (StringUtils.isEmpty(classCode)) {
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "分类数据有误");
        }
        // 设置参数
        ProductClassQuery productClassQuery = new ProductClassQuery();
        if (StringUtils.isEmpty(classCode)) {
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据有误,请重试");
        }
        productClassQuery.setClassCode(classCode);
        try {
            List<ProductClassDto> productClassDtoList = productClassService
                    .getAllNextProductClassByUpCode(productClassQuery);
            if (!ObjectUtils.isNullOrEmpty(productClassDtoList)) {
                return super.encapsulateMsgBean(productClassDtoList, MsgBean.MsgCode.SUCCESS, "");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "未获取到下一级分类数据");
            }
        } catch (ProductServiceException e) {
            logger.info("获取到下一级分类数据异常");
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 根据当前classCode获取上级classCode及list
     * 
     * @param classCode
     * @return
     */
    @RequestMapping(value = "/{classCode}/getUpClassAndNextProductClassByClassCode")
    @ResponseBody
    public MsgBean getUpClassAndNextProductClassByClassCode(@PathVariable("classCode") String classCode) {
        if (StringUtils.isEmpty(classCode)) {
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "分类数据有误");
        }
        try {
            List<Map<String, Object>> productClassListMap = productClassService
                    .getUpClassAndNextProductClassByClassCode(classCode);
            if (!ObjectUtils.isNullOrEmpty(productClassListMap)) {
                return super.encapsulateMsgBean(productClassListMap, MsgBean.MsgCode.SUCCESS, "");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "未获取到相应分类数据");
            }
        } catch (Exception e) {
            logger.info("获取分类数据异常");
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 用于组装tree下一级节点
     * 
     * @param productClassQuery
     * @return
     */
    @RequestMapping(value = "/{classCode}/getAllNextTreeNode")
    @ResponseBody
    public MsgBean getAllNextTreeNode(@PathVariable String classCode) {
        // 设置参数
        ProductClassQuery productClassQuery = new ProductClassQuery();
        if (StringUtils.isEmpty(classCode)) {
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "数据有误,请重试");
        }
        productClassQuery.setClassCode(classCode);
        try {
            List<Map<String, Object>> mapList = productClassService.getAllNextTreeNode(productClassQuery);
            if (!ObjectUtils.isNullOrEmpty(mapList)) {
                return super.encapsulateMsgBean(mapList, MsgBean.MsgCode.SUCCESS, "");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "未获取到下一级节点数据");
            }
        } catch (ProductServiceException e) {
            logger.info("获取到下一级节点数异常");
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }

    }

    /**
     * 组装产品分类
     * 
     * @return
     */
    @RequestMapping(value = "/getAllProductClass")
    @ResponseBody
    public MsgBean getAllProductClass() {
        try {
            List<ProductClassDto> productClallDtoList = productClassService.getAllProductClass();
            if (!ObjectUtils.isNullOrEmpty(productClallDtoList)) {
                return super.encapsulateMsgBean(productClallDtoList, MsgBean.MsgCode.SUCCESS, "");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "未获取到下一级节点数据");
            }
        } catch (ProductServiceException e) {
            logger.info("组装产品分类异常");
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 根据店铺类型获取产品类型
     * 
     * @param storeType
     * @return
     */
    @RequestMapping(value = "/{storeType}/getProductClassByStoreType")
    @ResponseBody
    public MsgBean getProductClassByStoreType(@PathVariable("storeType") String storeType) {
        try {
            List<StoreTypeProductClassDto> storeTypeProductClassList = productClassService
                    .getProductClassByStoreType(storeType);
            if (!ObjectUtils.isNullOrEmpty(storeTypeProductClassList)) {
                return super.encapsulateMsgBean(storeTypeProductClassList, MsgBean.MsgCode.SUCCESS, "");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "未获取到下一级节点数据");
            }
        } catch (ProductServiceException e) {
            logger.info("获取到下一级节点数异常");
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }

    }

}