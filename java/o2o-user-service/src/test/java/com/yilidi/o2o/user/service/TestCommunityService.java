package com.yilidi.o2o.user.service;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.CommunityDto;
import com.yilidi.o2o.user.service.dto.CommunityStoreRelatedDto;
import com.yilidi.o2o.user.service.dto.query.CommunityQuery;
import com.yilidi.o2o.user.service.dto.query.CommunityStoreRelatedQuery;

public class TestCommunityService extends BaseServiceTest {

	@Autowired
	private ICommunityService communityService;

	@Test
	public void testSaveCommunity() throws UserServiceException {
		CommunityDto dto = new CommunityDto();
		dto.setName("测试小区1111");
		dto.setProvinceCode("GD");
		dto.setCityCode("SZ");
		dto.setCountyCode("NS");
		dto.setAddressDetail("qwqwererr");
		dto.setCreateUserId(1);
		dto.setCreateTime(new Date());
		dto.setLongitude("233");
		dto.setLatitude("234");
		communityService.save(dto);
		printInfo("----->success");
	}

	@Test
	public void testUpdateCommunity() throws UserServiceException {
		CommunityDto dto = new CommunityDto();
		dto.setId(3);
		dto.setName("测试12");
		dto.setModifyTime(new Date());
		dto.setModifyUserId(23);
		communityService.update(dto);
		printInfo("update----->success");
	}

	@Test
	public void testListCommunityByName() throws UserServiceException {
		List<CommunityDto> lists = communityService.listCommunityByName("测试");
		printInfo("--------->>>>>>>" + lists.size());

	}

	@Test
	public void testLoadById() throws UserServiceException {
		CommunityDto dto = communityService.loadById(1);
		printInfo("--------->>>>>>>" + dto);
	}

	@Test
	public void testFindCommunitys() throws UserServiceException {
		CommunityQuery communityQuery = new CommunityQuery();
		YiLiDiPage<CommunityDto> communityDtos = communityService.findCommunitys(communityQuery);
		printInfo("--------->>>>>>>" + communityDtos);
	}

	@Test
	public void testFindCommunityStores() throws UserServiceException {
		CommunityStoreRelatedQuery query = new CommunityStoreRelatedQuery();
		query.setCommunityId(2);
		query.setCurrentCloseDate(new Date());
		YiLiDiPage<CommunityStoreRelatedDto> communityStoreRelatedDtos = communityService.findCommunityStores(query);
		printInfo("--------->>>>>>>" + communityStoreRelatedDtos);
	}

	@Test
	public void testCancelRelatedById() throws UserServiceException {
		boolean a = communityService.cancelRelatedById(2, 1);
		printInfo("--------->>>>>>>" + a);
	}

}