package com.yilidi.o2o.controller.operation.user;

import java.util.Date;

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
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.IStoreProductSubsidySettingService;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.StoreProductSubsidySettingDto;
import com.yilidi.o2o.product.service.dto.query.StoreProductSubsidySettingQuery;

/**
 * @Description:TODO(商品补贴设置管理控制器)
 * @author: llp
 * @date: 2015年11月21日 下午11:12:48
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class ProductSubsidyController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IStoreProductSubsidySettingService storeProductSubsidySettingService;

    @Autowired
    private ISaleProductService saleProductService;

    /**
     * @Description TODO(查询门店用户补贴商品管理)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listProductSubsifySetting")
    @ResponseBody
    public MsgBean listProductSubsifySetting(@RequestBody StoreProductSubsidySettingQuery query) {
        try {
            YiLiDiPage<StoreProductSubsidySettingDto> page = storeProductSubsidySettingService
                    .findStoreProductSubsidySettings(query);
            logger.info("=========YiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询门店用户补贴商品记录成功");
        } catch (Exception e) {
            logger.error("查询门店用户补贴商品记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(查询门店商品管理)
     * @param query
     * @return
     */
    @RequestMapping(value = "/listStoreProducts")
    @ResponseBody
    public MsgBean listStoreProducts(@RequestBody StoreProductSubsidySettingQuery query) {
        try {
            // 有效的商品
            query.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
            YiLiDiPage<StoreProductSubsidySettingDto> page = storeProductSubsidySettingService.findStoreProducts(query);
            logger.info("=========YiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(page));
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询门店商品记录成功");
        } catch (Exception e) {
            logger.error("查询门店商品记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(删除门店补贴商品库设置)
     * @param query
     * @return
     */
    @RequestMapping(value = "/{id}/deleteSubsifyProduct")
    @ResponseBody
    public MsgBean deleteSubsifyProduct(@PathVariable("id") Integer id) {
        try {
            storeProductSubsidySettingService.deleteById(id);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "删除门店补贴商品记录成功");
        } catch (Exception e) {
            logger.error("删除门店补贴商品记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(批量删除门店补贴商品库设置)
     * @param param
     * @return
     */
    @RequestMapping(value = "/{param}/batchDeleteSubsifyProduct")
    @ResponseBody
    public MsgBean batchDeleteSubsifyProduct(@PathVariable("param") String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    storeProductSubsidySettingService.deleteById(Integer.valueOf(paramString));
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "批量删除门店补贴商品记录成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "批量删除门店补贴商品记录失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(添加门店商品到门店补贴商品设置库)
     * @param query
     * @return
     */
    @RequestMapping(value = "/{id}/addSubsifyProduct")
    @ResponseBody
    public MsgBean addSubsifyProduct(@PathVariable("id") Integer saleProductId) {
        try {
            SaleProductDto saleProductDto = saleProductService.loadSaleProductBasicInfoById(saleProductId, null);
            if (!ObjectUtils.isNullOrEmpty(saleProductDto)) {
                StoreProductSubsidySettingDto storeProductSubsidySettingDto = new StoreProductSubsidySettingDto();
                storeProductSubsidySettingDto.setSaleProductId(saleProductDto.getId());
                storeProductSubsidySettingDto.setStoreId(saleProductDto.getStoreId());
                storeProductSubsidySettingDto.setCreateUserId(super.getUserId());
                storeProductSubsidySettingDto.setCreateTime(new Date());
                storeProductSubsidySettingService.save(storeProductSubsidySettingDto);
            }
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "添加门店补贴商品记录成功");
        } catch (Exception e) {
            logger.error("添加门店补贴商品记录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(批量添加门店商品到门店补贴商品设置库)
     * @param param
     * @return
     */
    @RequestMapping(value = "/{param}/batchAddSubsifyProduct")
    @ResponseBody
    public MsgBean batchAddSubsifyProduct(@PathVariable("param") String param) {
        try {
            if (!ObjectUtils.isNullOrEmpty(param)) {
                String[] arrParam = param.split(",");
                for (String paramString : arrParam) {
                    SaleProductDto saleProductDto = saleProductService
                            .loadSaleProductBasicInfoById(Integer.valueOf(paramString), null);
                    if (!ObjectUtils.isNullOrEmpty(saleProductDto)) {
                        StoreProductSubsidySettingDto storeProductSubsidySettingDto = new StoreProductSubsidySettingDto();
                        storeProductSubsidySettingDto.setSaleProductId(saleProductDto.getId());
                        storeProductSubsidySettingDto.setStoreId(saleProductDto.getStoreId());
                        storeProductSubsidySettingDto.setCreateUserId(super.getUserId());
                        storeProductSubsidySettingDto.setCreateTime(new Date());
                        storeProductSubsidySettingService.save(storeProductSubsidySettingDto);
                    }
                }
                return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "批量添加门店补贴商品记录成功");
            } else {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "批量添加门店补贴商品记录失败");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}