package com.yilidi.o2o.order.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.order.service.dto.UserVoucherDto;
import com.yilidi.o2o.order.service.dto.UserVoucherInfoDto;
import com.yilidi.o2o.order.service.dto.VoucherBasicInfoDto;
import com.yilidi.o2o.order.service.dto.VoucherDto;
import com.yilidi.o2o.order.service.dto.VoucherPackageDto;
import com.yilidi.o2o.order.service.dto.query.UserVoucherQueryDto;
import com.yilidi.o2o.order.service.dto.query.VoucherPackageQueryDto;
import com.yilidi.o2o.order.service.dto.query.VoucherQueryDto;

/**
 * 抵用券Service接口
 * 
 * @author: chenlian
 * @date: 2016年10月27日 下午3:30:08
 */
public interface IVoucherService {

    /**
     * 新增抵用券包
     * 
     * @param voucherPackageDto
     *            抵用券包DTO
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void saveVoucherPackage(VoucherPackageDto voucherPackageDto) throws OrderServiceException;

    /**
     * 更新抵用券包
     * 
     * @param voucherPackageDto
     *            抵用券包DTO
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void updateVoucherPackage(VoucherPackageDto voucherPackageDto) throws OrderServiceException;

    /**
     * 根据ID查看抵用劵包详情
     * 
     * @param id
     *            抵用劵包ID
     * @return VoucherPackageDto
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public VoucherPackageDto loadVoucherPackageById(Integer id) throws OrderServiceException;

    /**
     * 根据ID修改抵用劵包的状态，
     * 
     * @param id
     *            抵用劵包ID
     * @param state
     *            抵用劵包状态
     * @param modifyUserId
     *            修改人
     * @param modifyTime
     *            修改时间
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void updateVoucherPackageStateById(Integer id, String state, Integer modifyUserId, Date modifyTime)
            throws OrderServiceException;

    /**
     * 分页获取抵用券包列表
     * 
     * @param voucherPackageQueryDto
     *            抵用券包查询条件
     * @return YiLiDiPage<VoucherPackageDto>
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public YiLiDiPage<VoucherPackageDto> findVoucherPackages(VoucherPackageQueryDto voucherPackageQueryDto)
            throws OrderServiceException;

    /**
     * 发放抵用券
     * 
     * @param voucherDto
     *            抵用券DTO
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void saveForGrantVouchers(VoucherDto voucherDto) throws OrderServiceException;

    /**
     * 新增抵用券
     * 
     * @param voucherDto
     *            抵用券DTO
     * @return int 抵用券ID
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public int saveVoucher(VoucherDto voucherDto) throws OrderServiceException;

    /**
     * 新增用户抵用券
     * 
     * @param userVoucherDto
     *            用户抵用劵DTO
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void saveUserVoucher(UserVoucherDto userVoucherDto) throws OrderServiceException;

    /**
     * 为抢红包新增用户抵用券
     * 
     * @param userVoucherDtoList
     *            用户抵用劵DTO列表
     * @param userRedEnvelopeActivityId
     *            用户红包活动ID
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void saveUserVoucherForGrabRedEnvelope(List<UserVoucherDto> userVoucherDtoList, Integer userRedEnvelopeActivityId)
            throws OrderServiceException;

    /**
     * 
     * 根据ID查找用户抵用劵
     * 
     * @param id
     *            用户抵用劵ID
     * @return UserVoucherDto
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public UserVoucherDto loadUserVoucherById(Integer id) throws OrderServiceException;

    /**
     * 分页获取用户抵用劵使用记录列表
     * 
     * @param userVoucherQueryDto
     *            用户抵用劵使用记录查询条件
     * @return YiLiDiPage<UserVoucherInfoDto>
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public YiLiDiPage<UserVoucherInfoDto> findUserVouchers(UserVoucherQueryDto userVoucherQueryDto)
            throws OrderServiceException;

    /**
     * 根据活动ID、抵用券ID获取用户抵用券列表信息
     * 
     * @param activityId
     *            活动ID
     * @param vouIds
     *            抵用券ID列表
     * @return List<UserVoucherDto>
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public List<UserVoucherDto> listUserVouchersByAIdAndVIds(Integer activityId, List<Integer> vouIds)
            throws OrderServiceException;

    /**
     * 根据活动ID、抵用券ID、用户ID、用户抵用劵状态获取用户抵用券列表信息
     * 
     * @param activityId
     *            活动ID
     * @param vouIds
     *            抵用券ID列表
     * @param userId
     *            用户ID
     * @param statusList
     *            用户抵用劵状态列表
     * @return List<UserVoucherDto>
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public List<UserVoucherDto> listUserVouchersByAIdAndVIdsAndUIdAndStatus(Integer activityId, List<Integer> vouIds,
            Integer userId, List<String> statusList);

    /**
     * 获取需定时更新状态的抵用券列表
     * 
     * @param userVoucherQueryDto
     *            用户抵用劵状态列表
     * @return List<UserVoucherDto>
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public List<UserVoucherDto> listVouchersForNeedAutoUpdateStatus(List<String> statusList) throws OrderServiceException;

    /**
     * 
     * 根据ID查找抵用劵
     * 
     * @param id
     *            抵用劵ID
     * @return VoucherDto
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public VoucherDto loadVoucherById(Integer id) throws OrderServiceException;

    /**
     * 根据ID修改用户抵用劵的状态，
     * 
     * @param id
     *            用户抵用劵ID
     * @param status
     *            用户抵用劵状态
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void updateUserVoucherStatusById(Integer id, String status) throws OrderServiceException;

    /**
     * 如果抵用券没过期,根据用户抵用券ID列表修改用户抵用劵的状态，
     * 
     * @param userVoucherIds
     *            用户抵用劵ID列表
     * @param status
     *            用户抵用劵状态
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void updateUserVoucherStatusIfEffectiveByVoucherIds(List<Integer> userVoucherIds, String status)
            throws OrderServiceException;

    /**
     * 获取抢红包活动所需的抵用券列表
     * 
     * @param activityStartDate
     *            抢红包活动开始有效时间
     * @return List<VoucherBasicInfoDto>
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public List<VoucherBasicInfoDto> listVoucherPackagesForRedEnvelopeActivity(Date activityStartDate)
            throws OrderServiceException;

    /**
     * 根据抵用券包ID和发放时间获取抵用券列表
     * 
     * @param vouPackId
     *            抵用券包ID
     * @param grantTime
     *            发放时间
     * @return List<VoucherDto>
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public List<VoucherDto> listVouchersByVouPackIdAndGrantTime(Integer vouPackId, Date grantTime)
            throws OrderServiceException;

    /**
     * 根据状态分页获取用户抵用劵列表(状态有效无效根据时间计算)
     * 
     * @param userId
     *            用户ID
     * @param currentTime
     *            当前时间
     * @param userVoucherStatus
     *            userVoucherStatus,0-无效,1-有效
     * @param pageNo
     *            当前页数
     * @param pageSize
     *            页数大小
     * @return 用户优惠券列表
     * @throws OrderServiceException
     */
    public YiLiDiPage<UserVoucherInfoDto> findUserVouchersByRealTimeStatus(Integer userId, Date currentTime,
            Integer userVoucherStatus, Integer pageNo, Integer pageSize) throws OrderServiceException;

    /**
     * 获取用户有效可用的抵用券列表
     * 
     * @param userId
     *            用户ID
     * @param currentTime
     *            当前时间
     * @return 有效可用的抵用券列表
     * @throws OrderServiceException
     */
    public List<UserVoucherInfoDto> listValidAndUsebleUserVouchers(Integer userId, Date currentTime)
            throws OrderServiceException;

    /**
     * 根据用户抵用券ID、用户ID 获取用户抵用券信息
     * 
     * @param userId
     *            用户ID
     * @param userVoucherId
     *            用户抵用券ID
     * @return UserVoucherInfoDto
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public UserVoucherInfoDto loadUserVoucherByUserIdAndUserVoucherId(Integer userId, Integer userVoucherId);
    /**
     * 获取用户有效的抵用券总数量
     * 
     * @param userId
     *            用户ID
     * @param currentTime
     *            当前时间
     * @return 用户有效抵用券数量
     * @throws OrderServiceException
     *             订单域服务异常
     */
    public Integer getValidUserVoucherCountByUserId(Integer userId, Date currentTime) throws OrderServiceException;

    /**
     * 
     * 分页查询抵用券发放记录
     * 
     * @param voucherDto
     *            发放抵用劵
     * @return MsgBean
     */
	public YiLiDiPage<VoucherDto> searchVoucherRecord(VoucherQueryDto voucherQueryDto);

	/**
     * 获取抵用券发放记录
     * 
     * @param vouPackId
     *            券包id
     * @param batchNo
     * 			  批次号
     * @return MsgBean
     */
	public VoucherDto getVoucherGrantRecord(Integer vouPackId, String batchNo);

	/**
     * 抵用券券包
     * 
     * @return MsgBean
     */
	public List<VoucherPackageDto> listAvailableVoucherPackage();

	/**
     * 获取注册送抵用券
     * 
     * @param nowTime
     *            当前时间
     */
	public List<VoucherDto> getValidRegistUsevoucherActive(Date nowTime);

	/**
	 * 使用抵用券
	 * @param userVoucherIdList
	 * @param uservoucherstatusUsed
	 * @param date
	 */
	public void updateUseVoucherById(List<Integer> userVoucherIdList, String uservoucherstatusUsed, Date date);
}
