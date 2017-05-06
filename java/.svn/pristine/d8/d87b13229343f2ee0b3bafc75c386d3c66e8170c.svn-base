/**
 * 文件名称：SaleProductServiceTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.SaleProductImageDto;
import com.yilidi.o2o.product.service.dto.SaleProductPriceDto;
import com.yilidi.o2o.product.service.dto.SaleProductProfileDto;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductServiceTest extends BaseServiceTest {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ISaleProductService saleProductService;

    // @Test
    // public void testSaveSaleProduct() throws ProductServiceException {
    //
    // SaleProductDto saleProduct = new SaleProductDto();
    // saleProduct.setStoreId(4);
    // saleProduct.setProductId(3);
    // saleProduct.setBrandCode("zxs");
    // saleProduct.setProductClassCode("Drink6");
    // saleProduct.setProductName("zxs饮料6");
    // saleProduct.setBarCode("11110000");
    // saleProduct.setAuditNote("好喝");
    // saleProduct.setMarketTime(new Date());
    // saleProduct.setAuditStatusCode("SALEPRODUCTAUDITSTATUS_PASSED");
    // saleProduct.setAuditTime(new Date());
    // saleProduct.setAuditUserId(1);
    // saleProduct.setCreateUserId(1);
    // saleProduct.setCreateTime(new Date());
    // //附加属性
    // SaleProductProfileDto saleProductProfileDto = new SaleProductProfileDto();
    // saleProductProfileDto.setContent("zxszxszxszxs");
    // saleProductProfileDto.setHotSaleFlag("1");
    // saleProductProfileDto.setProductOwner("一里递");
    // saleProductProfileDto.setProductSpec("100g/袋");
    // saleProductProfileDto.setSellPoint("好吃");
    // saleProduct.setSaleProductProfileDto(saleProductProfileDto);
    // //价格信息
    // SaleProductPriceDto saleProductPriceDto = new SaleProductPriceDto();
    // saleProductPriceDto.setSaleProductId(6);
    // saleProductPriceDto.setPromotionalPrice(7L);
    // saleProductPriceDto.setRetailPrice(8L);
    // saleProduct.setSaleProductPriceDto(saleProductPriceDto);
    // //图片信息
    // List<SaleProductImageDto> saveSaleProductImageDtos = new ArrayList<SaleProductImageDto>();
    // SaleProductImageDto saleProductImageDto = new SaleProductImageDto();
    // saleProductImageDto.setImageUrl("/home/zxs/drink.dmg1");
    // saleProductImageDto.setMasterFlag("1");
    // saleProductImageDto.setImageOrder(1);
    // saveSaleProductImageDtos.add(saleProductImageDto);
    //
    // SaleProductImageDto saleProductImageDto1 = new SaleProductImageDto();
    // saleProductImageDto1.setImageUrl("/home/zxs/drink.dmg2");
    // saleProductImageDto1.setMasterFlag("2");
    // saleProductImageDto1.setImageOrder(2);
    // saveSaleProductImageDtos.add(saleProductImageDto1);
    // saleProduct.setSaleProductImageDtos(saveSaleProductImageDtos);
    // saleProductService.saveSaleProduct(saleProduct,"IOS");
    // }

    // @Test
    // public void testSaveSaleProductBasicInfo() throws ProductServiceException {
    //
    // SaleProductDto saleProduct = new SaleProductDto();
    // saleProduct.setStoreId(1);
    // saleProduct.setProductId(1);
    // saleProduct.setBrandCode("zxs");
    // saleProduct.setProductClassCode("Drink");
    // saleProduct.setProductName("zxs饮料5");
    // saleProduct.setBarCode("11110000");
    // saleProduct.setAuditNote("好喝");
    // saleProduct.setMarketTime(new Date());
    // saleProduct.setAuditStatusCode("SALEPRODUCTAUDITSTATUS_PASSED");
    // saleProduct.setAuditTime(new Date());
    // saleProduct.setAuditUserId(1);
    // saleProduct.setCreateUserId(1);
    // saleProduct.setCreateTime(new Date());
    // //saleProduct.setEnabledFlag("SALEPRODUCTENABLEDFLAG_ON");
    // //saleProduct.setSaleStatus("SALEPRODUCTSALESTATUS_INIT");
    //
    // saleProductService.saveSaleProductBasicInfo(saleProduct);
    // }
    //
    // @Test
    // public void testLoadSaleProductByIdAndChannelCode() throws ProductServiceException {
    // SaleProductDto saleProduct = saleProductService.loadSaleProductByIdAndChannelCode(3,"IOS");
    // String jsonString = JsonUtils.toJsonStringWithDateFormat(saleProduct);
    // printInfo(jsonString + "WWWWWWWWWWWWWWWWWWWW");
    // logger.info(jsonString + "WWWWWWWWWWWWWWWWWWWWW");
    // }

    // @Test
    // public void testListSaleProduct() throws ProductServiceException {
    // SaleProductQuery saleProductQuery = new SaleProductQuery();
    // saleProductQuery.setChannelCode("IOS");
    // saleProductQuery.setPromotionalMaxPrice(8L);
    // saleProductQuery.setProductName("zxs");
    // List<SaleProductDto> saleProductList = saleProductService.listSaleProduct(saleProductQuery);
    // String jsonString = JsonUtils.toJsonStringWithDateFormat(saleProductList);
    // printInfo(jsonString + "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
    // logger.info(jsonString + "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
    // }

    @Test
    public void testUpdateSaleProduct() throws ProductServiceException {

        SaleProductDto saleProduct = saleProductService.loadSaleProductByIdAndChannelCode(4, null, null, "IOS");
        saleProduct.setSaleProductName("zxs饮料7");
        saleProduct.setAuditNote("好喝的VC啊啊啊");
        saleProduct.setMarketTime(new Date());
        saleProduct.setAuditStatusCode("SALEPRODUCTAUDITSTATUS_NOPASSED");
        saleProduct.setAuditTime(new Date());
        saleProduct.setAuditUserId(1);
        saleProduct.setEnabledFlag("2");
        saleProduct.setModifyUserId(1);
        saleProduct.setModifyTime(new Date());
        // 附加属性
        SaleProductProfileDto saleProductProfileDto = saleProduct.getSaleProductProfileDto();
        saleProductProfileDto.setContent("好大蛇");
        saleProductProfileDto.setHotSaleFlag("2");
        saleProductProfileDto.setProductOwner("一里递");
        saleProductProfileDto.setSaleProductSpec("250g/袋");
        saleProductProfileDto.setSellPoint("好吃");
        saleProduct.setSaleProductProfileDto(saleProductProfileDto);
        // 价格信息
        SaleProductPriceDto saleProductPriceDto = saleProduct.getSaleProductPriceDto();
        saleProductPriceDto.setPromotionalPrice(1L);
        saleProductPriceDto.setRetailPrice(2L);
        saleProduct.setSaleProductPriceDto(saleProductPriceDto);
        // 图片信息
        List<SaleProductImageDto> saveSaleProductImageDtos = saleProduct.getSaleProductImageDtos();
        SaleProductImageDto saleProductImageDto = saveSaleProductImageDtos.get(0);
        saleProductImageDto.setImageUrl("/home/zr/drink.dmg1");
        saleProductImageDto.setMasterFlag("1");
        saleProductImageDto.setImageOrder(1);
        saveSaleProductImageDtos.add(saleProductImageDto);

        SaleProductImageDto saleProductImageDto1 = saveSaleProductImageDtos.get(1);
        saleProductImageDto1.setImageUrl("/home/zr/drink.dmg2");
        saleProductImageDto1.setMasterFlag("1");
        saleProductImageDto1.setImageOrder(1);
        saveSaleProductImageDtos.add(saleProductImageDto1);
        saleProduct.setSaleProductImageDtos(saveSaleProductImageDtos);
        saleProductService.updateSaleProduct(saleProduct, "IOS");
    }
}
