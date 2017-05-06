package com.yilidi.o2o.controller.operation.product;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.ISecKillSceneService;
import com.yilidi.o2o.product.service.dto.SecKillSceneDto;
import com.yilidi.o2o.product.service.dto.SecKillSceneRelateProductDto;
import com.yilidi.o2o.product.service.dto.query.SecKillSceneQueryDto;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 功能描述：秒杀场次http请求处理类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Controller("operationSeckKillSceneController")
@Scope("prototype")
@RequestMapping(value = "/operation")
public class SecKillSceneController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ISecKillSceneService secKillSceneService;
    @Autowired
    private IUserService userService;

    /**
     * 新增秒杀场次
     * 
     * @param secKillSceneDto
     *            秒杀场次信息
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillscene/create")
    @ResponseBody
    public MsgBean createSecKillScene(@RequestBody SecKillSceneDto secKillSceneDto) {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillSceneDto) || ObjectUtils.isNullOrEmpty(secKillSceneDto.getSceneName())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getRepeatType())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getStrStartTime())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "必填参数不能为空");
            }
            Integer userId = super.getUserId();
            if (ObjectUtils.isNullOrEmpty(userId)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "没有登录");
            }
            Date startTime = DateUtils.parseDate(secKillSceneDto.getStrStartTime(), CommonConstants.DATE_FORMAT_CURRENTTIME);
            secKillSceneDto.setCreateUserId(userId);
            secKillSceneDto.setUpdateUserId(userId);
            secKillSceneDto.setStartTime(startTime);
            secKillSceneService.save(secKillSceneDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "保存失败" : e.getMessage());
        }
    }

    /**
     * 搜索秒杀场次列表
     * 
     * @param secKillSceneQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillscene/search")
    @ResponseBody
    public MsgBean searchSecKillScene(@RequestBody SecKillSceneQueryDto secKillSceneQueryDto) {
        try {
            YiLiDiPage<SecKillSceneDto> secKillSceneDtoPage = secKillSceneService.findSecKillScenes(secKillSceneQueryDto);
            List<SecKillSceneDto> secKillSceneDtos = secKillSceneDtoPage.getResultList();
            if (!ObjectUtils.isNullOrEmpty(secKillSceneDtos)) {
                for (SecKillSceneDto secKillSceneDto : secKillSceneDtos) {
                    if (ObjectUtils.isNullOrEmpty(secKillSceneDto.getCreateUserId())) {
                        continue;
                    }
                    UserDto userDto = userService.loadUserById(secKillSceneDto.getCreateUserId());
                    if (!ObjectUtils.isNullOrEmpty(userDto)) {
                        secKillSceneDto.setCreateUserName(userDto.getUserName());
                    }
                }
            }
            return super.encapsulateMsgBean(secKillSceneDtoPage, MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "获取列表失败" : e.getMessage());
        }
    }

    /**
     * 编辑场次信息
     * 
     * @param secKillSceneDto
     *            场次信息
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillscene/edit")
    @ResponseBody
    public MsgBean editSecKillScene(@RequestBody SecKillSceneDto secKillSceneDto) {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillSceneDto) || ObjectUtils.isNullOrEmpty(secKillSceneDto.getActivityId())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getSceneName())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getRepeatType())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "必填参数不能为空");
            }
            if (!ObjectUtils.isNullOrEmpty(secKillSceneDto.getStrStartTime())) {
                secKillSceneDto.setStartTime(
                        DateUtils.parseDate(secKillSceneDto.getStrStartTime(), CommonConstants.DATE_FORMAT_CURRENTTIME));
            }
            secKillSceneDto.setUpdateUserId(super.getUserId());
            secKillSceneService.updateSelective(secKillSceneDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "编辑成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "编辑失败" : e.getMessage());
        }
    }

    /**
     * 获取场次详细信息
     * 
     * @param sceneId
     *            场次ID
     * @return 场次信息
     */
    @RequestMapping(value = "/seckillscene/detail/{sceneId}")
    @ResponseBody
    public MsgBean detailSecKillScene(@PathVariable("sceneId") Integer sceneId) {
        try {
            SecKillSceneDto secKillSceneDto = secKillSceneService.loadById(sceneId);
            return super.encapsulateMsgBean(secKillSceneDto, MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "操作失败" : e.getMessage());
        }
    }

    /**
     * 获取秒杀商品所关联的场次分页列表
     * 
     * @param secKillSceneQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillproductrelationscene/list")
    @ResponseBody
    public MsgBean listSecKillProductRelationScene(@RequestBody SecKillSceneQueryDto secKillSceneQueryDto) {
        try {
            YiLiDiPage<SecKillSceneDto> secKillSceneDtoPage = secKillSceneService
                    .findSecKillProductRelationScenes(secKillSceneQueryDto);
            List<SecKillSceneDto> secKillSceneDtos = secKillSceneDtoPage.getResultList();
            if (!ObjectUtils.isNullOrEmpty(secKillSceneDtos)) {
                for (SecKillSceneDto secKillSceneDto : secKillSceneDtos) {
                    if (ObjectUtils.isNullOrEmpty(secKillSceneDto.getCreateUserId())) {
                        continue;
                    }
                    UserDto userDto = userService.loadUserById(secKillSceneDto.getCreateUserId());
                    if (!ObjectUtils.isNullOrEmpty(userDto)) {
                        secKillSceneDto.setCreateUserName(userDto.getUserName());
                    }
                }
            }
            return super.encapsulateMsgBean(secKillSceneDtoPage, MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "获取列表失败" : e.getMessage());
        }
    }

    /**
     * 关联秒杀商品
     * 
     * @param secKillSceneRelateProductDto
     *            参数实体
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillscene/relateseckillproduct")
    @ResponseBody
    public MsgBean relateSecKillProduct(@RequestBody SecKillSceneRelateProductDto secKillSceneRelateProductDto) {
        try {
            secKillSceneService.updateRelateSecKillProduct(secKillSceneRelateProductDto, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "操作失败" : e.getMessage());
        }
    }

    /**
     * 解除关联秒杀商品
     * 
     * @param secKillSceneRelateProductDto
     *            参数实体
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillscene/releaseseckillproduct")
    @ResponseBody
    public MsgBean releaseSecKillProduct(@RequestBody SecKillSceneRelateProductDto secKillSceneRelateProductDto) {
        try {
            secKillSceneService.updateReleaseSecKillProduct(secKillSceneRelateProductDto, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "操作失败" : e.getMessage());
        }
    }

    /**
     * 失效场次关联秒杀商品
     * 
     * @param secKillSceneRelateProductDto
     *            参数实体
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillscene/invalidateseckillproduct")
    @ResponseBody
    public MsgBean invalidateSecKillProduct(@RequestBody SecKillSceneRelateProductDto secKillSceneRelateProductDto) {
        try {
            secKillSceneService.updateInvalidateSceneSecKillProduct(secKillSceneRelateProductDto, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "操作失败" : e.getMessage());
        }
    }

    /**
     * 有效场次关联秒杀商品
     * 
     * @param secKillSceneRelateProductDto
     *            参数实体
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillscene/validseckillproduct")
    @ResponseBody
    public MsgBean validSecKillProduct(@RequestBody SecKillSceneRelateProductDto secKillSceneRelateProductDto) {
        try {
            secKillSceneService.updateValidSceneSecKillProduct(secKillSceneRelateProductDto, super.getUserId());
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "操作失败" : e.getMessage());
        }
    }
}