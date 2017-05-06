/**
 * 文件名称：SaleProductTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.product.model.SaleProduct;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductTest extends BaseMapperTest {

    protected Logger logger = Logger.getLogger(this.getClass());
    @Autowired
    private SaleProductMapper saleProductMapper;

    @Test
    public void testSaveSaleProduct() {
        SaleProduct saleProduct = new SaleProduct();
        saleProduct.setStoreId(1);
        saleProduct.setProductId(1);
        saleProduct.setBrandCode("zxs");
        saleProduct.setProductClassCode("Drink");
        saleProduct.setSaleProductName("zxs饮料");
        saleProduct.setBarCode("11110000");
        saleProduct.setAuditNote("好喝");
        saleProduct.setMarketTime(new Date());
        saleProduct.setAuditStatusCode("1");
        saleProduct.setAuditTime(new Date());
        saleProduct.setAuditUserId(1);
        saleProduct.setCreateUserId(1);
        saleProduct.setCreateTime(new Date());
        saleProduct.setEnabledFlag("SALEPRODUCTENABLEDFLAG_ON");

        saleProductMapper.saveSaleProduct(saleProduct);
    }

    @Test
    public void testSaveSaleProductSelective() {
        SaleProduct saleProduct = new SaleProduct();
        saleProduct.setStoreId(1);
        saleProduct.setProductId(1);
        saleProduct.setBrandCode("zxs");
        saleProduct.setProductClassCode("Drink");
        saleProduct.setSaleProductName("zxs饮料");
        saleProduct.setBarCode("11110000");
        saleProduct.setAuditNote("好喝");
        saleProduct.setMarketTime(new Date());
        saleProduct.setAuditStatusCode("1");
        saleProduct.setAuditTime(new Date());
        saleProduct.setAuditUserId(1);
        saleProduct.setCreateUserId(1);
        saleProduct.setCreateTime(new Date());

        saleProductMapper.saveSaleProduct(saleProduct);
    }

    @Test
    public void testLoadSaleProductById() {
        SaleProduct saleProduct = saleProductMapper.loadSaleProductBasicInfoById(2,null);
        String jsonString = JsonUtils.toJsonStringWithDateFormat(saleProduct);
        logger.info(jsonString + "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        printInfo(jsonString + "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
    }

    @Test
    public void testUpdateSaleProductById() {
        SaleProduct saleProduct = new SaleProduct();
        saleProduct.setId(2);
        saleProduct.setStoreId(2);
        saleProduct.setProductId(2);
        saleProduct.setBrandCode("zxs1");
        saleProduct.setProductClassCode("Drink");
        saleProduct.setSaleProductName("zxs饮料1");
        saleProduct.setBarCode("11110000");
        saleProduct.setAuditNote("好喝1");
        saleProduct.setMarketTime(new Date());
        saleProduct.setAuditStatusCode("1");
        saleProduct.setAuditTime(new Date());
        saleProduct.setAuditUserId(2);
        saleProduct.setCreateUserId(2);
        saleProduct.setCreateTime(new Date());
        SaleProduct saleProduct1 = saleProductMapper.loadSaleProductBasicInfoById(2,null);
        String jsonString1 = JsonUtils.toJsonStringWithDateFormat(saleProduct1);
        logger.info(jsonString1 + "前前前前前前前前前前前前");
        printInfo(jsonString1 + "前前前前前前前前前前前前");
        saleProductMapper.updateSaleProductBasicInfoById(saleProduct);
        SaleProduct saleProduct2 = saleProductMapper.loadSaleProductBasicInfoById(2,null);
        String jsonString2 = JsonUtils.toJsonStringWithDateFormat(saleProduct2);
        logger.info(jsonString2 + "后后后后后后后后后后后后");
        printInfo(jsonString2 + "后后后后后后后后后后后后");
    }

    @Test
    public void testUpdateAuditById() {
        SaleProduct saleProduct1 = saleProductMapper.loadSaleProductBasicInfoById(2,null);
        String jsonString1 = JsonUtils.toJsonStringWithDateFormat(saleProduct1);
        logger.info(jsonString1 + "前前前前前前前前前前前前");
        printInfo(jsonString1 + "前前前前前前前前前前前前");
        saleProductMapper.updateAuditById(2, "2", "修改审核状态测试", 1, new Date());
        SaleProduct saleProduct2 = saleProductMapper.loadSaleProductBasicInfoById(2,null);
        String jsonString2 = JsonUtils.toJsonStringWithDateFormat(saleProduct2);
        logger.info(jsonString2 + "后后后后后后后后后后后后");
        printInfo(jsonString2 + "后后后后后后后后后后后后");
    }

    @Test
    public void testLoadSaleProductByStoreIdAndProductId() {
        SaleProduct saleProduct1 = saleProductMapper.loadSaleProductBasicInfoByStoreIdAndProductId(1, 1,
                SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
        String jsonString1 = JsonUtils.toJsonStringWithDateFormat(saleProduct1);
        logger.info(jsonString1 + "前前前前前前前前前前前前");
        printInfo(jsonString1 + "前前前前前前前前前前前前");
    }

    @Test
    public void testListSaleProductByStoreId() {
        SaleProduct saleProduct = new SaleProduct();
        saleProduct.setStoreId(1);
        saleProduct.setAuditStatusCode("2");
        List<SaleProduct> saleProductList = saleProductMapper.listSaleProductByStoreId(saleProduct);
        String jsonString1 = JsonUtils.toJsonStringWithDateFormat(saleProductList);
        logger.info(jsonString1 + "EEEEEEEEEEEEEEEEEEE");
        printInfo(jsonString1 + "EEEEEEEEEEEEEEEEEEEE");
    }
}
