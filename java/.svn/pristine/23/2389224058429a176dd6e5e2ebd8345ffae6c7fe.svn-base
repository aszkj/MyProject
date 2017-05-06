package com.yilidi.o2o.user.service;

import java.util.Arrays;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;

public class TestStoreProfileService extends BaseServiceTest {

	@Autowired
	private IStoreProfileService storeProfileService;

	// 添加门店信息
	@Test
	public void testSave() throws UserServiceException {
		StoreProfileDto storeProfileDto = new StoreProfileDto();
		storeProfileDto.setMobile("13787654321");
		storeProfileDto.setAddressDetail("豪方花园");
		storeProfileDto.setBusinessHoursBegin("09:00:00");
		storeProfileDto.setBusinessHoursEnd("19:00:00");
		storeProfileDto.setStoreName("金牌店铺2");
		storeProfileDto.setProvinceCode("1");
		storeProfileDto.setCityCode("2");
		storeProfileDto.setCountyCode("3");
		storeProfileDto.setCommunityIds(Arrays.asList(1,2,3));
		storeProfileDto.setStoreStatus("OPEN");
		storeProfileService.save(storeProfileDto);
	}
	
	// 修改门店信息
	@Test
	public void testUpdate() throws UserServiceException {
		StoreProfileDto storeProfileDto = new StoreProfileDto();
		storeProfileDto.setId(3);
		storeProfileDto.setMobile("13788999988");
		storeProfileDto.setAddressDetail("3号楼");
		storeProfileDto.setBusinessHoursBegin("09:00:00");
		storeProfileDto.setBusinessHoursEnd("19:00:00");
		storeProfileDto.setStoreName("黄金店铺3");
		storeProfileDto.setProvinceCode("1");
		storeProfileDto.setCityCode("2");
		storeProfileDto.setCountyCode("3");
		storeProfileDto.setCommunityIds(Arrays.asList(1,2,3));
		storeProfileDto.setStoreStatus("OPEN");
		storeProfileDto.setContact("B女士");
		storeProfileService.update(storeProfileDto);
	}

	@Test
	public void testLoadById() throws UserServiceException {
		StoreProfileDto dto = storeProfileService.loadById(2);
		printInfo(dto);
	}
}