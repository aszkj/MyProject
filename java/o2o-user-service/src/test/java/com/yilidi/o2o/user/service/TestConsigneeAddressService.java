package com.yilidi.o2o.user.service;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.user.service.dto.ConsigneeAddressDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestConsigneeAddressService {

    private Logger logger = Logger.getLogger(TestConsigneeAddressService.class);

    @Autowired
    private IConsigneeAddressService consigneeAddressService;

    @Test
    public void testSave() throws UserServiceException {
        try {
            ConsigneeAddressDto consigneeAddressDto = new ConsigneeAddressDto();
            consigneeAddressDto.setCustomerId(5);
            consigneeAddressDto.setProvinceCode("7");
            consigneeAddressDto.setCityCode("8");
            consigneeAddressDto.setCountyCode("9");
            consigneeAddressDto.setAddressDetail("上沙村88号");
            consigneeAddressDto.setDefaultFlag(SystemContext.UserDomain.CONSADDRDEFAULTFLAG_NO);
            consigneeAddressDto.setConsigneeName("张小龙");
            consigneeAddressDto.setPhoneNo("13631555688");
            consigneeAddressDto.setCreateUserId(8);
            consigneeAddressDto.setCreateTime(new Date());
            consigneeAddressDto.setStatus(SystemContext.UserDomain.CONSADDRSTATUS_OFF);
            consigneeAddressDto.setNote("我的常用收货地址");
            consigneeAddressService.save(consigneeAddressDto);
        } catch (Exception e) {
            logger.error("save异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Test
    public void testDeleteById() throws UserServiceException {
        try {
            Integer id = 2;
            consigneeAddressService.deleteById(id);
        } catch (Exception e) {
            logger.error("deleteById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Test
    public void testLoadById() throws UserServiceException {
        try {
            Integer id = 1;
            ConsigneeAddressDto consigneeAddressDto = consigneeAddressService.loadById(id, null);
            logger.info(JsonUtils.toJsonStringWithDateFormat(consigneeAddressDto));
        } catch (Exception e) {
            logger.error("loadById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Test
    public void testListByCustomerId() throws UserServiceException {
        try {
            Integer customerId = 5;
            List<ConsigneeAddressDto> consigneeAddressDtoList = consigneeAddressService.listByCustomerId(customerId);
            if (null != consigneeAddressDtoList && !consigneeAddressDtoList.isEmpty()) {
                for (ConsigneeAddressDto consigneeAddressDto : consigneeAddressDtoList) {
                    logger.info(JsonUtils.toJsonStringWithDateFormat(consigneeAddressDto));
                }
            }
        } catch (Exception e) {
            logger.error("listByCustomerId异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Test
    public void testUpdateByIdSelective() throws UserServiceException {
        try {
            ConsigneeAddressDto consigneeAddressDto = new ConsigneeAddressDto();
            consigneeAddressDto.setAddressId(1);
            consigneeAddressDto.setProvinceCode("10");
            consigneeAddressDto.setCityCode("11");
            consigneeAddressDto.setCountyCode("12");
            consigneeAddressDto.setAddressDetail("江汉路101号");
            consigneeAddressDto.setDefaultFlag(SystemContext.UserDomain.CONSADDRDEFAULTFLAG_YES);
            consigneeAddressDto.setConsigneeName("刘磊");
            consigneeAddressDto.setPhoneNo("18659965222");
            consigneeAddressDto.setStatus(SystemContext.UserDomain.CONSADDRSTATUS_ON);
            consigneeAddressDto.setNote("HAHAHAHAHAHA");
            consigneeAddressDto.setModifyUserId(8);
            consigneeAddressDto.setModifyTime(new Date());
            consigneeAddressService.updateByIdSelective(consigneeAddressDto);
        } catch (Exception e) {
            logger.error("updateByIdSelective异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Test
    public void testUpdateForStatus() throws UserServiceException {
        try {
            ConsigneeAddressDto consigneeAddressDto = new ConsigneeAddressDto();
            consigneeAddressDto.setAddressId(1);
            consigneeAddressDto.setStatus(SystemContext.UserDomain.CONSADDRSTATUS_OFF);
            consigneeAddressDto.setModifyUserId(8);
            consigneeAddressDto.setModifyTime(new Date());
            consigneeAddressService.updateByIdSelective(consigneeAddressDto);
        } catch (Exception e) {
            logger.error("updateForStatus异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Test
    public void testUpdateForDefaultFlag() throws UserServiceException {
        try {
            ConsigneeAddressDto consigneeAddressDto = new ConsigneeAddressDto();
            consigneeAddressDto.setAddressId(1);
            consigneeAddressDto.setDefaultFlag(SystemContext.UserDomain.CONSADDRDEFAULTFLAG_NO);
            consigneeAddressDto.setModifyUserId(8);
            consigneeAddressDto.setModifyTime(new Date());
            consigneeAddressService.updateForDefaultFlag(consigneeAddressDto);
        } catch (Exception e) {
            logger.error("updateForDefaultFlag异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

}