package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.product.proxy.dto.SaleProductProxyDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.SaleProductEvaluationMapper;
import com.yilidi.o2o.user.model.SaleProductEvaluation;
import com.yilidi.o2o.user.model.combination.SaleProductEvaluationInfo;
import com.yilidi.o2o.user.service.ISaleProductEvaluationService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.dto.SaleProductEvaluationDto;
import com.yilidi.o2o.user.service.dto.SaleProductEvaluationImageProfileDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.query.SaleProductEvaluateQuery;

/**
 * Service
 * @Description:(商品评价数据层操作接口服务实现类)
 * @author: llp
 * @date: 2015年12月7日 下午2:19:37
 */
@Service("saleProductEvaluationService")
public class SaleProductEvaluationServiceImpl extends BasicDataService implements ISaleProductEvaluationService {
	@Autowired
	private SaleProductEvaluationMapper saleProductEvaluationMapper;
	@Autowired
	private IProductProxyService productProxyService;
	@Autowired
    private IStoreProfileService storeProfileService;
	private static final String SYSTEMSALEORDERNO = "系统订单";//系统评价订单号
	private static final String IMAGEFLAG_YES = "IMAGEFLAG_YES";
	private static final Integer DATESTART = 3;//随机时间3天前
	private static final Integer DATEEND = 30;//随机时间30天内
	@Override
	public void save(SaleProductEvaluationDto record) throws UserServiceException {
		try {
			SaleProductEvaluation saleProductEvaluation = new SaleProductEvaluation();
			ObjectUtils.fastCopy(record, saleProductEvaluation);
			String photoUrl = this.getPhotoUrl(record);
			saleProductEvaluation.setPhotoUrl(photoUrl);
			if(photoUrl.length()>0){
				saleProductEvaluation.setUploadPhotoFlag(SystemContext.UserDomain.SALEPRODUCTEVALUATIONPHOTOFLAG_YES);
			}else{
				saleProductEvaluation.setUploadPhotoFlag(SystemContext.UserDomain.SALEPRODUCTEVALUATIONPHOTOFLAG_NO);
			}
			if(StringUtils.isEmpty(saleProductEvaluation.getSaleOrderNo())){
				saleProductEvaluation.setSaleOrderNo(SYSTEMSALEORDERNO);
			}
			if(StringUtils.isEmpty(saleProductEvaluation.getContent())){
				saleProductEvaluation.setContent("");
			}
			if(SystemContext.UserDomain.STOREEVALUATIONSYSTEMEVAL_YES.equals(saleProductEvaluation.getSystemEvaluate())){
				saleProductEvaluation.setAnonymityEvaluate(SystemContext.UserDomain.STOREEVALUATIONANONYMITYEVAL_YES);
			}
			
			if(!StringUtils.isEmpty(record.getStoreItems()) && !"AllStores".equals(record.getStoreItems())){
				String[] storeIdArr = record.getStoreItems().split("_");
				int r =0;
				for(int i=0;i<storeIdArr.length;i++){
					if(!StringUtils.isEmpty(storeIdArr[i])){
						saleProductEvaluation.setStoreId(Integer.valueOf(storeIdArr[i]));
						List<Integer> ProductIds = new ArrayList<Integer>();
						ProductIds.add(record.getProductId());
						List<SaleProductProxyDto> list=productProxyService.listSaleProductByProductIdsAndStoreId(ProductIds,SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON,
			                    SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE,Integer.valueOf(storeIdArr[i]));
						if(!ObjectUtils.isNullOrEmpty(list)){
							saleProductEvaluation.setSaleProductId(list.get(0).getId());
							saleProductEvaluation.setSaleProductName(list.get(0).getSaleProductName());
							saleProductEvaluation.setBarCode(list.get(0).getBarCode());
						}else{
							continue;
						}
						if(r!=0){
							saleProductEvaluation.setCreateTime(DateUtils.getLastMonth(new Date(),3,30));
						}
						this.saleProductEvaluationMapper.save(saleProductEvaluation);
						r++;
						String[] purl = photoUrl.split(";");
						if(purl.length>0){
							for(int j = 0;j<purl.length;j++)
							if(!StringUtils.isEmpty(purl[j])){
								operateImage(IMAGEFLAG_YES, null,
										purl[j]);
							}
						}
					}
				}
			}else if(!StringUtils.isEmpty(record.getStoreItems()) && "AllStores".equals(record.getStoreItems())){
				List<Integer> storeIds =  productProxyService.listStoreIdsByProductId(
						SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON,
						SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE, record.getProductId());
				if(ObjectUtils.isNullOrEmpty(storeIds)){
					throw new UserServiceException("saleProductEvaluation save 方法查询storeId异常");
				}
				int r =0;
				for(Integer storeId:storeIds){
					saleProductEvaluation.setStoreId(storeId);
					List<Integer> ProductIds = new ArrayList<Integer>();
					ProductIds.add(record.getProductId());
					List<SaleProductProxyDto> list=productProxyService.listSaleProductByProductIdsAndStoreId(ProductIds,SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON,
		                    SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE,storeId);
					if(!ObjectUtils.isNullOrEmpty(list)){
						saleProductEvaluation.setSaleProductId(list.get(0).getId());
						saleProductEvaluation.setSaleProductName(list.get(0).getSaleProductName());
						saleProductEvaluation.setBarCode(list.get(0).getBarCode());
					}else{
						continue;
					}
					if(r!=0){
						saleProductEvaluation.setCreateTime(DateUtils.getLastMonth(new Date(),3,30));
					}
					this.saleProductEvaluationMapper.save(saleProductEvaluation);
					r++;
				}
				String[] purl = photoUrl.split(";");
				if(purl.length>0){
					for(int j = 0;j<purl.length;j++)
					if(!StringUtils.isEmpty(purl[j])){
						operateImage(IMAGEFLAG_YES, null,
								purl[j]);
					}
				}
				
			}else{
				throw new UserServiceException("saleProductEvaluation save storeId为空");
			}
		} catch (Exception e) {
			logger.error("saveStoreEvaluation异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	

	@Override
	public void saveForApp(SaleProductEvaluationDto saleProductEvaluationDto) {
		try {
			SaleProductEvaluation saleProductEvaluation = new SaleProductEvaluation();
			ObjectUtils.fastCopy(saleProductEvaluationDto, saleProductEvaluation);
				if (!ObjectUtils.isNullOrEmpty(saleProductEvaluationDto.getStoreId())) {
					saleProductEvaluation.setStoreId(saleProductEvaluationDto.getStoreId());
					SaleProductProxyDto saleProductProxyDto = productProxyService.loadById(saleProductEvaluationDto.getSaleProductId());
					if (!ObjectUtils.isNullOrEmpty(saleProductProxyDto)) {
						saleProductEvaluation.setSaleProductName(saleProductProxyDto.getSaleProductName());
						saleProductEvaluation.setBarCode(saleProductProxyDto.getBarCode());
					}else{
						throw new UserServiceException("评价的商品不存在或数据异常！");
					}
					this.saleProductEvaluationMapper.save(saleProductEvaluation);
				}
		} catch (Exception e) {
			logger.error("saveStoreEvaluation异常", e);
			throw new UserServiceException(e.getMessage());
		}
		
	}
	
	public String getPhotoUrl(SaleProductEvaluationDto record){
		StringBuffer photoUrl = new StringBuffer("");
		if(!ObjectUtils.isNullOrEmpty(record.getFirstAppImageProfileDto())){
			if(!StringUtils.isEmpty(record.getFirstAppImageProfileDto().getAppPicPath())){
				photoUrl.append(record.getFirstAppImageProfileDto().getAppPicPath()+";");
			}
		}
		if(!ObjectUtils.isNullOrEmpty(record.getSecondAppImageProfileDto())){
			if(!StringUtils.isEmpty(record.getSecondAppImageProfileDto().getAppPicPath())){
				photoUrl.append(record.getSecondAppImageProfileDto().getAppPicPath()+";");
			}
		}
		if(!ObjectUtils.isNullOrEmpty(record.getThirdAppImageProfileDto())){
			if(!StringUtils.isEmpty(record.getThirdAppImageProfileDto().getAppPicPath())){
				photoUrl.append(record.getThirdAppImageProfileDto().getAppPicPath()+";");
			}
		}
		if(!ObjectUtils.isNullOrEmpty(record.getFouthAppImageProfileDto())){
			if(!StringUtils.isEmpty(record.getFouthAppImageProfileDto().getAppPicPath())){
				photoUrl.append(record.getFouthAppImageProfileDto().getAppPicPath()+";");
			}
		}
		if(!ObjectUtils.isNullOrEmpty(record.getFiveAppImageProfileDto())){
			if(!StringUtils.isEmpty(record.getFiveAppImageProfileDto().getAppPicPath())){
				photoUrl.append(record.getFiveAppImageProfileDto().getAppPicPath()+";");
			}
		}
		return photoUrl.toString();
	}
	@Override
	public void deleteById(Integer id) throws UserServiceException {
		try {
			saleProductEvaluationMapper.deleteById(id);
		} catch (Exception e) {
			logger.error("deleteById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void updateShowStatusById(Integer id, String showStatus) throws UserServiceException {
		try {
			SaleProductEvaluation saleProductEvaluation = new SaleProductEvaluation();
			saleProductEvaluation.setId(id);
			saleProductEvaluation.setShowStatus(showStatus);
			saleProductEvaluation.setCreateTime(new Date());
			saleProductEvaluationMapper.updateShowStatusById(saleProductEvaluation);
		} catch (Exception e) {
			logger.error("updateShowStatusById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Override
	public SaleProductEvaluationDto loadById(Integer id) throws UserServiceException {
		try {
			SaleProductEvaluation saleProductEvaluation = saleProductEvaluationMapper.loadById(id);
			SaleProductEvaluationDto saleProductEvaluationDto = null;
			if (null != saleProductEvaluation) {
				saleProductEvaluationDto = new SaleProductEvaluationDto();
				ObjectUtils.fastCopy(saleProductEvaluation, saleProductEvaluationDto);
			}
			return saleProductEvaluationDto;
		} catch (Exception e) {
			logger.error("loadById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public SaleProductEvaluationDto loadSaleProductEvaluationDetailById(Integer id) throws UserServiceException {
		try {
			SaleProductEvaluationInfo saleProductEvaluationInfo = saleProductEvaluationMapper.loadDetailById(id);
			SaleProductEvaluationDto saleProductEvaluationDto = null;
			if (null != saleProductEvaluationInfo) {
				saleProductEvaluationDto = new SaleProductEvaluationDto();
				ObjectUtils.fastCopy(saleProductEvaluationInfo, saleProductEvaluationDto);
				if(!StringUtils.isEmpty(saleProductEvaluationDto.getPhotoUrl())){
					String[] arr = saleProductEvaluationDto.getPhotoUrl().split(";");
					List<SaleProductEvaluationImageProfileDto> photoList = new ArrayList<SaleProductEvaluationImageProfileDto>();
					for(int i =0;i<arr.length;i++){
						if(!StringUtils.isEmpty(arr[i])){
							SaleProductEvaluationImageProfileDto img = new SaleProductEvaluationImageProfileDto();
							img.setAppPicPath(arr[i]);
							img.setAppFullPicPath(StringUtils.toFullImageUrl(arr[i]));
							photoList.add(img);
						}
					}
					saleProductEvaluationDto.setSaleProductEvaluationImageProfileDtos(photoList);
				}
			}
			return saleProductEvaluationDto;
		} catch (Exception e) {
			logger.error("loadSaleProductEvaluationDetailById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<SaleProductEvaluationDto> listSaleProductEvaluationBysaleProductId(Integer saleProductId)
			throws UserServiceException {
		try {
			List<SaleProductEvaluationInfo> saleProductEvaluationInfos = saleProductEvaluationMapper
					.listBySaleProductId(saleProductId);
			List<SaleProductEvaluationDto> saleProductEvaluationDtos = null;
			if (!ObjectUtils.isNullOrEmpty(saleProductEvaluationInfos)) {
				saleProductEvaluationDtos = new ArrayList<SaleProductEvaluationDto>();
				for (SaleProductEvaluationInfo saleProductEvaluationInfo : saleProductEvaluationInfos) {
					SaleProductEvaluationDto saleProductEvaluationDto = new SaleProductEvaluationDto();
					ObjectUtils.fastCopy(saleProductEvaluationInfo, saleProductEvaluationDto);
					saleProductEvaluationDtos.add(saleProductEvaluationDto);
				}
			}
			return saleProductEvaluationDtos;
		} catch (Exception e) {
			logger.error("listSaleProductEvaluationBysaleProductId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public YiLiDiPage<SaleProductEvaluationDto> findSaleProductEvaluations(SaleProductEvaluateQuery query) throws UserServiceException {
		try {
			if (null == query.getStart() || query.getStart() <= 0) {
				query.setStart(1);
			}
			if (null == query.getPageSize() || query.getPageSize() <= 0) {
				query.setPageSize(CommonConstants.PAGE_SIZE);
			}
			if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
				query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
				query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
			}
			PageHelper.startPage(query.getStart(), query.getPageSize());
			Page<SaleProductEvaluationInfo> page = saleProductEvaluationMapper.findSaleProductEvaluations(query);
			Page<SaleProductEvaluationDto> pageDto = new Page<SaleProductEvaluationDto>(query.getStart(),
					query.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<SaleProductEvaluationInfo> saleProductEvaluationInfos = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(saleProductEvaluationInfos)) {
				for (SaleProductEvaluationInfo saleProductEvaluationInfo : saleProductEvaluationInfos) {
					SaleProductEvaluationDto saleProductEvaluationDto = new SaleProductEvaluationDto();
					ObjectUtils.fastCopy(saleProductEvaluationInfo, saleProductEvaluationDto);
					if(!StringUtils.isEmpty(saleProductEvaluationDto.getPhotoUrl())){
						String[] arr = saleProductEvaluationDto.getPhotoUrl().split(";");
						List<SaleProductEvaluationImageProfileDto> photoList = new ArrayList<SaleProductEvaluationImageProfileDto>();
						for(int i =0;i<arr.length;i++){
							if(!StringUtils.isEmpty(arr[i])){
								SaleProductEvaluationImageProfileDto img = new SaleProductEvaluationImageProfileDto();
								img.setAppPicPath(arr[i]);
								img.setAppFullPicPath(StringUtils.toFullImageUrl(arr[i]));
								photoList.add(img);
							}
						}
						saleProductEvaluationDto.setSaleProductEvaluationImageProfileDtos(photoList);
					}
					pageDto.add(saleProductEvaluationDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("findSaleProductEvaluations异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Override
	public YiLiDiPage<SaleProductEvaluationDto> findSaleProductEvaluationsTemps(SaleProductEvaluateQuery query) throws UserServiceException {
		try {
			if (null == query.getStart() || query.getStart() <= 0) {
				query.setStart(1);
			}
			if (null == query.getPageSize() || query.getPageSize() <= 0) {
				query.setPageSize(CommonConstants.PAGE_SIZE);
			}
			if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
				query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
				query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
			}
			PageHelper.startPage(query.getStart(), query.getPageSize());
			Page<SaleProductEvaluationInfo> page = saleProductEvaluationMapper.findSaleProductEvaluationsTemps(query);
			Page<SaleProductEvaluationDto> pageDto = new Page<SaleProductEvaluationDto>(query.getStart(),
					query.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<SaleProductEvaluationInfo> saleProductEvaluationInfos = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(saleProductEvaluationInfos)) {
				for (SaleProductEvaluationInfo saleProductEvaluationInfo : saleProductEvaluationInfos) {
					SaleProductEvaluationDto saleProductEvaluationDto = new SaleProductEvaluationDto();
					ObjectUtils.fastCopy(saleProductEvaluationInfo, saleProductEvaluationDto);
					if(!StringUtils.isEmpty(saleProductEvaluationDto.getPhotoUrl())){
						String[] arr = saleProductEvaluationDto.getPhotoUrl().split(";");
						List<SaleProductEvaluationImageProfileDto> photoList = new ArrayList<SaleProductEvaluationImageProfileDto>();
						for(int i =0;i<arr.length;i++){
							if(!StringUtils.isEmpty(arr[i])){
								SaleProductEvaluationImageProfileDto img = new SaleProductEvaluationImageProfileDto();
								img.setAppPicPath(arr[i]);
								img.setAppFullPicPath(StringUtils.toFullImageUrl(arr[i]));
								photoList.add(img);
							}
						}
						saleProductEvaluationDto.setSaleProductEvaluationImageProfileDtos(photoList);
					}
					pageDto.add(saleProductEvaluationDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("findSaleProductEvaluations异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<SaleProductEvaluationDto> listDataExportSaleProductEvaluation(SaleProductEvaluateQuery query,
			Long startLineNum, Integer pageSize) throws UserServiceException {
		try {
			if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
				query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
				query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
			}
			List<SaleProductEvaluationInfo> saleProductEvaluationInfos = saleProductEvaluationMapper
					.listDataForExportSaleProductEvaluation(query, startLineNum, pageSize);
			List<SaleProductEvaluationDto> saleProductEvaluationDtos = new ArrayList<SaleProductEvaluationDto>();
			if (!ObjectUtils.isNullOrEmpty(saleProductEvaluationInfos)) {
				for (SaleProductEvaluationInfo saleProductEvaluationInfo : saleProductEvaluationInfos) {
					SaleProductEvaluationDto saleProductEvaluationDto = new SaleProductEvaluationDto();
					ObjectUtils.fastCopy(saleProductEvaluationInfo, saleProductEvaluationDto);
					if(!StringUtils.isEmpty(saleProductEvaluationDto.getPhotoUrl())){
						String[] arr = saleProductEvaluationDto.getPhotoUrl().split(";");
						List<SaleProductEvaluationImageProfileDto> photoList = new ArrayList<SaleProductEvaluationImageProfileDto>();
						for(int i =0;i<arr.length;i++){
							if(!StringUtils.isEmpty(arr[i])){
								SaleProductEvaluationImageProfileDto img = new SaleProductEvaluationImageProfileDto();
								img.setAppPicPath(arr[i]);
								img.setAppFullPicPath(StringUtils.toFullImageUrl(arr[i]));
								photoList.add(img);
							}
						}
						saleProductEvaluationDto.setSaleProductEvaluationImageProfileDtos(photoList);
					}
					saleProductEvaluationDtos.add(saleProductEvaluationDto);
				}
			}
			return saleProductEvaluationDtos;
		} catch (Exception e) {
			logger.error("listDataExportSaleProductEvaluation异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Long getCountsForExportSaleProductEvaluation(SaleProductEvaluateQuery query) throws UserServiceException {
		try {
			if (StringUtils.isNotEmpty(query.getStartCreateTime())) {
				query.setStartCreateTime(query.getStartCreateTime() + StringUtils.STARTTIMESTRING);
			}
			if (StringUtils.isNotEmpty(query.getEndCreateTime())) {
				query.setEndCreateTime(query.getEndCreateTime() + StringUtils.ENDTIMESTRING);
			}
			return saleProductEvaluationMapper.getCountsForExportSaleProductEvaluation(query);
		} catch (Exception e) {
			logger.error("getCountsForExportSaleProductEvaluation异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	private void operateImage(String imageFlag, String delImageUrl, String classImageUrl)
			throws ProductServiceException {
		try {
			FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
			if (!ObjectUtils.isNullOrEmpty(imageFlag) && IMAGEFLAG_YES.equals(imageFlag)) {
				fileUploadUtils.uploadPublishFile(classImageUrl);
			}
			if (!ObjectUtils.isNullOrEmpty(delImageUrl)) {
				fileUploadUtils.deletePublishFile(delImageUrl);
			}
		} catch (ProductServiceException e) {
			logger.error("operateImage异常", e);
			throw new ProductServiceException(e.getMessage());
		}
	}

	@Override
	public void deleteAllSaleProductEvaluationTemps() throws UserServiceException {
			try {
				saleProductEvaluationMapper.deleteAllSaleProductEvaluationTemps();
			} catch (Exception e) {
				logger.error("deleteById异常", e);
				throw new UserServiceException(e.getMessage());
			}
		
	}
	@Override
	public void saveSaleProductEvaluationDtosBatch(List<SaleProductEvaluationDto> saleProductEvaluationDtoList)throws UserServiceException {
		logger.debug("saleProductEvaluationDtoList -> " + saleProductEvaluationDtoList);
        try {
            // 检查产品列表参数是否为空
            if (ObjectUtils.isNullOrEmpty(saleProductEvaluationDtoList)) {
                logger.error("SaleProductEvaluationService.saveSaleProductEvaluationDtosBatch => 需要保存的产品评论列表参数为空");
                throw new UserServiceException("需要保存的产品评论列表为空");
            }
            List<SaleProductEvaluationDto> list = new ArrayList<SaleProductEvaluationDto>();
            if (!ObjectUtils.isNullOrEmpty(saleProductEvaluationDtoList)) {
                for (SaleProductEvaluationDto saleProductEvaluationDto : saleProductEvaluationDtoList) {
                    if (!ObjectUtils.isNullOrEmpty(saleProductEvaluationDto)) {
                    	StoreProfileDto existDto = storeProfileService.loadByStoreCode(saleProductEvaluationDto.getStoreCode());
                    	if(existDto.getStoreName().equals(saleProductEvaluationDto.getStoreName())){
                    		SaleProductProxyDto saleProductDto = productProxyService.loadSaleProductInfoByStoreIdAndBarCode(existDto.getStoreId(), existDto.getStoreName(), saleProductEvaluationDto.getBarCode(), saleProductEvaluationDto.getSaleProductName());
                    		if(ObjectUtils.isNullOrEmpty(saleProductDto)){
                    			continue;
                    		}
                    		saleProductEvaluationDto.setSaleProductId(saleProductDto.getId());
                    		saleProductEvaluationDto.setStoreId(existDto.getStoreId());
                    		if(StringUtils.isEmpty(saleProductEvaluationDto.getSaleOrderNo())){
                    			saleProductEvaluationDto.setSaleOrderNo(SYSTEMSALEORDERNO);
                    		}
                    		saleProductEvaluationDto.setCreateTime(DateUtils.getLastMonth(new Date(),DATESTART,DATEEND));
                    		list.add(saleProductEvaluationDto);
                    	}
                    }
                }
                this.batchSaveSaleProductEvaluationTemp(list);
            }
        } catch (UserServiceException e) {
            logger.error("将产品评论批量保存至临时表出错");
            throw new UserServiceException("异常：将产品评论批量保存至临时表出错");
        }
	}

	@Override
	public void batchSaveSaleProductEvaluationTemp(List<SaleProductEvaluationDto> records) throws UserServiceException {
		 
		 try {
			 if (ObjectUtils.isNullOrEmpty(records)) {
	             logger.error("StoreEvaluationService.batchSaveStoreProfileDtoTemp => 需要保存的商品评论列表参数为空");
	             throw new UserServiceException("需要保存的商品评论列表为空");
	         }
			 List<SaleProductEvaluationDto> list = new ArrayList<SaleProductEvaluationDto>();
			 for(SaleProductEvaluationDto dto :records){
				 SaleProductEvaluationDto saleProductEvaluation = new SaleProductEvaluationDto();
				ObjectUtils.fastCopy(dto, saleProductEvaluation);
				list.add(saleProductEvaluation);
			 }
			this.saleProductEvaluationMapper.batchSaveTemp(list);
			} catch (Exception e) {
				logger.error("batchSaveSaleProductEvaluationTemp异常", e);
				throw new UserServiceException(e.getMessage());
			}
		
	}

	@Override
	public List<String> addAllTempSaleProductEvaluateToStandard(SaleProductEvaluateQuery query)
			throws UserServiceException {
		List<String> listError = new ArrayList<String>();
		try {
			List<SaleProductEvaluationInfo> saleProductEvaluationTemps  = this.saleProductEvaluationMapper.listSaleProductEvaluationTemps(query);
			if(ObjectUtils.isNullOrEmpty(saleProductEvaluationTemps)){
				listError.add("无有效数据");
				return listError;
			}
			this.saleProductEvaluationMapper.batchSaveTempToStandard(saleProductEvaluationTemps);
			List<Integer> ids = new ArrayList<Integer>();
			for(SaleProductEvaluationInfo saleProductEvaluationInfo : saleProductEvaluationTemps){
				ids.add(saleProductEvaluationInfo.getId());
			}
			this.saleProductEvaluationMapper.deleteSaleProductEvaluationTempsByIds(ids);
			} catch (Exception e) {
				logger.error("addAllTempStoreEvaluateToStandard异常", e);
				throw new UserServiceException(e.getMessage());
			}
		return listError;
	}
}