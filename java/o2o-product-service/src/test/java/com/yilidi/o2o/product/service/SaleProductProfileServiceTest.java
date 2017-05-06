/**
 * 文件名称：SaleProductProfileServiceTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.product.service.dto.SaleProductProfileDto;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductProfileServiceTest extends BaseServiceTest {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ISaleProductProfileService saleProductProfileService;

    @Test
    public void testSaveSaleProductProfile() throws ProductServiceException {
        SaleProductProfileDto saleProductProfileDto = new SaleProductProfileDto();
        saleProductProfileDto.setSaleProductId(6);
        saleProductProfileDto.setChannelCode("IOS");
        saleProductProfileDto.setContent("zxszxszxszxs");
        saleProductProfileDto.setHotSaleFlag("1");
        saleProductProfileDto.setProductOwner("一里递");
        saleProductProfileDto.setSaleProductSpec("100g/袋");
        saleProductProfileDto.setSellPoint("好吃");
        saleProductProfileDto.setCreateUserId(1);
        saleProductProfileDto.setCreateTime(new Date());
        saleProductProfileService.saveSaleProductProfile(saleProductProfileDto);
    }

    @Test
    public void testUpdateSaleProductProfile() throws ProductServiceException {
        SaleProductProfileDto saleProductProfileDto = new SaleProductProfileDto();
        saleProductProfileDto.setId(1);
        saleProductProfileDto.setContent("zrzrzrzrzrzr");
        saleProductProfileDto.setHotSaleFlag("2");
        saleProductProfileDto.setProductOwner("非一里递");
        saleProductProfileDto.setSaleProductSpec("250g/袋");
        saleProductProfileDto.setSellPoint("容量大超实惠");
        saleProductProfileDto.setModifyUserId(1);
        saleProductProfileDto.setModifyTime(new Date());
        saleProductProfileService.updateSaleProductProfile(saleProductProfileDto);
    }

    @Test
    public void testLoadSaleProductProfileById() throws ProductServiceException {

        SaleProductProfileDto saleProductProfileDto = saleProductProfileService
                .loadSaleProductProfileBySaleProductIdAndChannelCode(6, null, "IOS");
        String jsonString = JsonUtils.toJsonStringWithDateFormat(saleProductProfileDto);
        printInfo(jsonString + "WWWWWWWWWWWWWWWWWWWW");
        logger.info(jsonString + "WWWWWWWWWWWWWWWWWWWWW");

    }
}
