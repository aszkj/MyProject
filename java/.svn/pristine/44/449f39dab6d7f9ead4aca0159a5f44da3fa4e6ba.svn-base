package com.yilidi.o2o.controller.warehouse.user;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.WarehouseBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;

/**
 * 微仓请求处理类
 * 
 * @author: chenb
 * @date: 2016年7月7日 上午11:48:28
 */
@Controller("warehouseStoreController")
@RequestMapping(value = "/warehouse")
public class StoreController extends WarehouseBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IStoreProfileService storeProfileService;
    @Autowired
    private IProductClassService productClassService;

    /**
     * 获取当前微仓信息
     * 
     * @param warehouseId
     * @return MsgBean
     */
    @RequestMapping(value = "/store/getinfo")
    @ResponseBody
    public MsgBean getWarehouseBasicInfo() {
        try {
            StoreProfileDto warehouseBasicInfo = storeProfileService.loadBasicStoreInfo(super.getStoreId(), null);
            if (null == warehouseBasicInfo) {
                throw new IllegalArgumentException("该微仓不存在");
            }
            warehouseBasicInfo.setFullAddress(systemBasicDataInfoUtils.getAddressPrefix(warehouseBasicInfo.getProvinceCode(),
                    warehouseBasicInfo.getCityCode(), warehouseBasicInfo.getCountyCode())
                    + warehouseBasicInfo.getAddressDetail());
            return super.encapsulateMsgBean(warehouseBasicInfo, MsgBean.MsgCode.SUCCESS, "获取微仓的基本信息成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取微仓下的商品基本类别列表
     * 
     * @return String
     * @throws ProductServiceException
     */
    @RequestMapping(value = "/store/listproductclass")
    @ResponseBody
    public MsgBean listProductClassByStoreType() {
        try {
            List<HashMap<String, String>> productClassList = productClassService.listProductClassByStoreType(
                    SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE, SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
            if (!ObjectUtils.isNullOrEmpty(productClassList)) {
                return super.encapsulateMsgBean(productClassList, MsgBean.MsgCode.SUCCESS, "指定店铺类型下的商品基本类别列表查询成功");
            } else {
                logger.info("查询失败：指定店铺类型下的商品基本类别列表不存在");
                return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, "指定店铺类型下的商品基本类别列表不存在");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}
