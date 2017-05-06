package com.yilidi.o2o.product.service;

import java.util.Date;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.product.service.dto.StoreProductSubsidySettingDto;
import com.yilidi.o2o.product.service.dto.query.StoreProductSubsidySettingQuery;

/**
 * @Description:TODO(差价补贴商品的服务接口测试类) 
 * @author:	llp
 * @date:	2015年11月10日 下午3:49:48 
 *
 */
public class StoreProductSubsidySettingServiceTest extends BaseServiceTest {

	protected Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private IStoreProductSubsidySettingService storeProductSubsidySettingService;
	
	@Test
	public void testSaveStoreProductSubsidySetting() throws ProductServiceException {
		try{
			StoreProductSubsidySettingDto storeProductSubsidySettingDto = new StoreProductSubsidySettingDto();
			storeProductSubsidySettingDto.setSaleProductId(1);
			storeProductSubsidySettingDto.setCreateTime(new Date());
			storeProductSubsidySettingService.save(storeProductSubsidySettingDto);
		} catch (Exception e) {
			logger.error("SaveStoreProductSubsidySetting异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testDelStoreProductSubsidySettingById() throws ProductServiceException {
		try{
			Integer id = 1;
			storeProductSubsidySettingService.deleteById(id);
		} catch (Exception e) {
			logger.error("deleteById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testfindStoreProductSubsidySettings() throws ProductServiceException {
		try {
			StoreProductSubsidySettingQuery query = new StoreProductSubsidySettingQuery();
			query.setStart(1);
			query.setPageSize(8);
			query.setOrder("A.CREATETIME");
			query.setStoreName("公司");
			query.setSort("desc");
			YiLiDiPage<StoreProductSubsidySettingDto> page = storeProductSubsidySettingService.findStoreProductSubsidySettings(query);
			logger.info("pageSize: ------------> " + page.getPageSize());
			logger.info("pageNumber: ------------> " + page.getCurrentPage());
			logger.info("pageTotal: ------------> " + page.getPageCount());
			logger.info("count: ------------> " + page.getRecordCount());
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(page.getResultList()));
		} catch (Exception e) {
			logger.error("findStoreProductSubsidySettings异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
}
