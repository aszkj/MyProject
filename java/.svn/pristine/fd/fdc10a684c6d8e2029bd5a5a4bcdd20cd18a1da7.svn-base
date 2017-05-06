package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.StoreSubsidyCountInfoDto;
import com.yilidi.o2o.user.service.dto.StoreSubsidyRecordDto;
import com.yilidi.o2o.user.service.dto.query.StoreSubsidyRecordQuery;

/**
 * 
 * @Description:TODO(补贴商品设置服务接口类) 
 * @author:	llp
 * @date:	2015年11月10日 下午2:14:23 
 *
 */
public interface IStoreSubsidyRecordService {
	/**
	 * 保存订单补贴记录
	 * 
	 * @param recordDto 订单补贴记录
	 * @return 影响行数
	 */
	public void save(StoreSubsidyRecordDto recordDto)  throws UserServiceException;
	
	/**
	 * @Description  TODO(根据查询条件，分页查询所有的店铺补贴统计（商品差价补贴，优惠补贴，物流补贴，以及补贴订单总数）)
	 * @param query
	 * @return YiLiDiPage 分页数据
	 */
	public YiLiDiPage<StoreSubsidyCountInfoDto> findStoreSubsidyCountInfos(StoreSubsidyRecordQuery query) throws UserServiceException;
	
	/**
	 * 根据查询条件分页查询补贴明细记录（优惠，物流补贴明细）
	 * 
	 * @param query 查询条件对象
	 * @return Page<StoreSubsidyRecordDto> YiLiDiPage 分页数据
	 */
	public YiLiDiPage<StoreSubsidyRecordDto> findStoreSubsidyRecords(StoreSubsidyRecordQuery query) throws UserServiceException;

	/**
	 * @Description TODO(分页获取导出门店账本明细记录报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 */
	public List<StoreSubsidyRecordDto> listDataForExportStoreSubsidyRecord(StoreSubsidyRecordQuery query, Long startLineNum,
			Integer pageSize) throws UserServiceException;

	/**
	 * @Description TODO(获取报表数据的总记录数)
	 * @param query
	 */
	public Long getCountsForExportStoreSubsidyRecord(StoreSubsidyRecordQuery query) throws UserServiceException;
}
