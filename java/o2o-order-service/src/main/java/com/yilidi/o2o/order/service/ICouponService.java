package com.yilidi.o2o.order.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.order.service.dto.CouponBasicInfoDto;
import com.yilidi.o2o.order.service.dto.CouponDto;
import com.yilidi.o2o.order.service.dto.CouponPackageDto;
import com.yilidi.o2o.order.service.dto.UserCouponDto;
import com.yilidi.o2o.order.service.dto.UserCouponInfoDto;
import com.yilidi.o2o.order.service.dto.query.CouponPackageQueryDto;
import com.yilidi.o2o.order.service.dto.query.CouponQueryDto;
import com.yilidi.o2o.order.service.dto.query.UserCouponQueryDto;

/**
 * 优惠券Service接口
 * 
 * @author: chenlian
 * @date: 2016年10月19日 上午11:53:56
 */
public interface ICouponService {

    /**
     * 新增优惠券包
     * 
     * @param couponPackageDto
     *            优惠券包DTO
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void saveCouponPackage(CouponPackageDto couponPackageDto) throws OrderServiceException;

    /**
     * 更新优惠券包
     * 
     * @param couponPackageDto
     *            优惠券包DTO
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void updateCouponPackage(CouponPackageDto couponPackageDto) throws OrderServiceException;

    /**
     * 根据ID查看优惠劵包详情
     * 
     * @param id
     *            优惠劵包ID
     * @return CouponPackageDto
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public CouponPackageDto loadCouponPackageById(Integer id) throws OrderServiceException;

    /**
     * 根据ID修改优惠劵包的状态，
     * 
     * @param id
     *            优惠劵包ID
     * @param state
     *            优惠劵包状态
     * @param modifyUserId
     *            修改人
     * @param modifyTime
     *            修改时间
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void updateCouponPackageStateById(Integer id, String state, Integer modifyUserId, Date modifyTime)
            throws OrderServiceException;

    /**
     * 分页获取优惠券包列表
     * 
     * @param couponPackageQueryDto
     *            优惠券包查询条件
     * @return YiLiDiPage<CouponPackageDto>
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public YiLiDiPage<CouponPackageDto> findCouponPackages(CouponPackageQueryDto couponPackageQueryDto)
            throws OrderServiceException;

    /**
     * 发放优惠券
     * 
     * @param couponDto
     *            优惠券DTO
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public Map<String, Object> saveForGrantCoupons(CouponDto couponDto) throws OrderServiceException;

    /**
     * 新增优惠券
     * 
     * @param couponDto
     *            优惠券DTO
     * @return int 优惠券ID
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public int saveCoupon(CouponDto couponDto) throws OrderServiceException;

    /**
     * 新增用户优惠券
     * 
     * @param userCouponDto
     *            用户优惠劵DTO
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void saveUserCoupon(UserCouponDto userCouponDto) throws OrderServiceException;

    /**
     * 为抢红包新增用户优惠券
     * 
     * @param userCouponDto
     *            用户优惠劵DTO
     * @param userRedEnvelopeActivityId
     *            用户红包活动ID
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void saveUserCouponForGrabRedEnvelope(UserCouponDto userCouponDto, Integer userRedEnvelopeActivityId)
            throws OrderServiceException;

    /**
     * 
     * 根据ID查找用户优惠劵
     * 
     * @param id
     *            用户优惠劵ID
     * @return UserCouponDto
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public UserCouponDto loadUserCouponById(Integer id) throws OrderServiceException;

    /**
     * 根据用户ID和优惠券查找用户优惠券信息
     * 
     * @param userId
     *            用户ID
     * @param conId
     *            优惠券ID
     * @return UserCouponDto
     * @throws OrderServiceException
     */
    public UserCouponDto loadUserCouponByUserIdAndConId(Integer userId, Integer conId) throws OrderServiceException;

    /**
     * 分页获取用户优惠劵使用记录列表
     * 
     * @param userCouponQueryDto
     *            用户优惠劵使用记录查询条件
     * @return YiLiDiPage<UserCouponInfoDto>
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public YiLiDiPage<UserCouponInfoDto> findUserCoupons(UserCouponQueryDto userCouponQueryDto) throws OrderServiceException;

    /**
     * 根据活动ID、优惠券ID获取用户优惠券列表信息
     * 
     * @param activityId
     *            活动ID
     * @param conId
     *            优惠券ID
     * @return List<UserCouponDto>
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public List<UserCouponDto> listUserCouponsByAIdAndCId(Integer activityId, Integer conId) throws OrderServiceException;

    /**
     * 根据活动ID、优惠券ID、用户ID、用户优惠劵状态获取用户优惠券列表信息
     * 
     * @param activityId
     *            活动ID
     * @param conId
     *            优惠券ID
     * @param userId
     *            用户ID
     * @param statusList
     *            用户优惠劵状态列表
     * @return List<UserCouponDto>
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public List<UserCouponDto> listUserCouponsByAIdAndCIdAndUIdAndStatus(Integer activityId, Integer conId, Integer userId,
            List<String> statusList);

    /**
     * 获取需定时更新状态的优惠券列表
     * 
     * @param userCouponQueryDto
     *            用户优惠劵状态列表
     * @return List<UserCouponDto>
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public List<UserCouponDto> listCouponsForNeedAutoUpdateStatus(List<String> statusList) throws OrderServiceException;

    /**
     * 
     * 根据ID查找优惠劵
     * 
     * @param id
     *            优惠劵ID
     * @return CouponDto
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public CouponDto loadCouponById(Integer id) throws OrderServiceException;

    /**
     * 根据ID修改用户优惠劵的状态，
     * 
     * @param id
     *            用户优惠劵ID
     * @param status
     *            用户优惠劵状态
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void updateUserCouponStatusById(Integer id, String status) throws OrderServiceException;

    /**
     * 根据用户优惠券ID列表修改用户优惠劵的状态，
     * 
     * @param userCouponIds
     *            用户优惠劵ID列表
     * @param status
     *            用户优惠劵状态
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void updateUseCouponById(List<Integer> userCouponIds, String status, Date useTime) throws OrderServiceException;

    /**
     * 如果优惠券没过期,根据用户优惠券ID列表修改用户优惠劵的状态，
     * 
     * @param userCouponIds
     *            用户优惠劵ID列表
     * @param status
     *            用户优惠劵状态
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void updateUserCouponStatusIfEffectiveByIds(List<Integer> userCouponIds, String status)
            throws OrderServiceException;

    /**
     * 获取抢红包活动所需的优惠券列表
     * 
     * @param activityStartDate
     *            抢红包活动开始有效时间
     * @return List<CouponBasicInfoDto>
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public List<CouponBasicInfoDto> listCouponsForRedEnvelopeActivity(Integer conPackId) throws OrderServiceException;

    /**
     * 根据状态分页获取用户优惠劵列表(状态有效无效根据时间计算)
     * 
     * @param userId
     *            用户ID
     * @param currentTime
     *            当前时间
     * @param userCouponStatus
     *            userCouponStatus,0-无效,1-有效
     * @param pageNo
     *            当前页数
     * @param pageSize
     *            页数大小
     * @return 用户优惠券列表
     * @throws OrderServiceException
     */
    public YiLiDiPage<UserCouponInfoDto> findUserCouponsByRealTimeStatus(Integer userId, Date currentTime,
            Integer userCouponStatus, Integer pageNo, Integer pageSize) throws OrderServiceException;

    /**
     * 获取用户有效的优惠券总数量
     * 
     * @param userId
     *            用户ID
     * @param currentTime
     *            当前时间
     * @return 用户有效优惠券数量
     * @throws OrderServiceException
     *             订单域服务异常
     */
    public Integer getValidUserCouponCountByUserId(Integer userId, Date currentTime) throws OrderServiceException;

    /**
     * 获取用户有效可用的优惠券列表
     * 
     * @param userId
     *            用户ID
     * @param currentTime
     *            当前时间
     * @return 有效可用的优惠券列表
     * @throws OrderServiceException
     */
    public List<UserCouponInfoDto> listValidAndUsebleUserCoupons(Integer userId, Date currentTime)
            throws OrderServiceException;

    /**
     * 根据优惠券ID、用户ID 获取用户优惠券信息
     * 
     * @param userId
     *            用户ID
     * @param conId
     *            优惠券ID
     * @return UserCouponInfoDto
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public UserCouponInfoDto loadUserCouponByUserIdAndUserCouponId(Integer userId, Integer conId);

    /**
     * 获取有效的分享优惠券以金额分组列表
     * 
     * @param couponDto
     *            查询条件
     * @return 有效可用的优惠券列表
     * @throws OrderServiceException
     */
    public List<CouponBasicInfoDto> listCouponsForShareRule(Integer conPackId) throws OrderServiceException;

    /**
     * 分页获取优惠劵发放记录列表
     * 
     * @param userCouponQueryDto
     *            查询条件
     * @return MsgBean
     */
    public YiLiDiPage<CouponDto> searchGrantRecord(CouponQueryDto couponQueryDto) throws OrderServiceException;

    /**
     * 获取优惠券发放记录
     * 
     * @param vouPackId
     *            券包id
     * @param batchNo
     *            批次号
     * @return MsgBean
     */
    public CouponDto getCouponGrantRecord(Integer conPackId, String batchNo) throws OrderServiceException;

    /**
     * 获取优惠券包
     * 
     * @param vouPackId
     *            券包id
     * @param batchNo
     *            批次号
     * @return MsgBean
     */
    public List<CouponPackageDto> listAvailableCouponPackage(String grantWay) throws OrderServiceException;

    /**
     * 根据券包，批次号，发放方式获取优惠券
     * 
     * @param conPackId
     *            券包id
     * @param batchNo
     *            批次号
     * @param grantWay
     *            发放方式
     * @return MsgBean
     */
    public List<CouponDto> getCouponByPackIdBatchNoGrantWay(Integer conPackId, String batchNo, String grantWay)
            throws OrderServiceException;

    /**
     * 根据券包，批次号，发放方式获取优惠券
     * 
     * @param conPackId
     *            券包id
     * @param batchNo
     *            批次号
     * @param grantWay
     *            发放方式
     * @return MsgBean
     */
    public Map<String, Object> getCouponValid(CouponDto couponDto);

    /**
     * 查询注册送优惠券活动
     * 
     * @param nowTime
     *            当前时间
     */
    public List<CouponDto> getValidRegistUseCouponActive(Date nowTime);

    public YiLiDiPage<CouponDto> getCouponByGrantWay(CouponQueryDto couponQueryDto);

    /**
     * 发送买赠优惠券信息
     * 
     * @param orderNo
     *            订单编号
     * @param operationUserId
     *            操作用户ID
     * @param operationTime
     *            操作时间
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void sendBuyActivityCouponMessage(String orderNo, Integer operationUserId, Date operationTime)
            throws UserServiceException;

}
