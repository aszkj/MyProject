package com.yilidi.o2o.controller.operation.product;

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
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.ISecKillProductService;
import com.yilidi.o2o.product.service.dto.SecKillProductDto;
import com.yilidi.o2o.product.service.dto.query.SecKillProductQueryDto;

/**
 * 功能描述：秒杀商品http请求处理类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Controller("operationSeckKillProductController")
@Scope("prototype")
@RequestMapping(value = "/operation")
public class SecKillProductController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ISecKillProductService secKillProductService;

    /**
     * 新增秒杀商品
     * 
     * @param secKillProductDto
     *            秒杀商品信息
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillproduct/create")
    @ResponseBody
    public MsgBean createSecKillProduct(@RequestBody SecKillProductDto secKillProductDto) {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillProductDto) || ObjectUtils.isNullOrEmpty(secKillProductDto.getProductId())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getSecKillProductPrice())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getDisplayOrder())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getSecKillCount())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getRemainCount())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getSecKillTime())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getQualifyType())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getLimitOrderCount())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "必填参数不能为空");
            }
            if (secKillProductDto.getLimitOrderCount() > secKillProductDto.getRemainCount()) {
                throw new ProductServiceException("允许秒中商品数量不能大于库存");
            }
            secKillProductDto.setCreateUserId(super.getUserId());
            secKillProductService.save(secKillProductDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "保存失败" : e.getMessage());
        }
    }

    /**
     * 搜索秒杀商品列表
     * 
     * @param secKillProductQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillproduct/combinationsearch")
    @ResponseBody
    public MsgBean combinationSearchSecKillProduct(@RequestBody SecKillProductQueryDto secKillProductQueryDto) {
        try {
            YiLiDiPage<SecKillProductDto> secKillProductPage = secKillProductService
                    .findSecKillProducts(secKillProductQueryDto);
            return super.encapsulateMsgBean(secKillProductPage, MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "查询列表失败" : e.getMessage());
        }
    }

    /**
     * 搜索秒杀商品列表
     * 
     * @param secKillProductQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillproduct/search")
    @ResponseBody
    public MsgBean searchSecKillProduct(@RequestBody SecKillProductQueryDto secKillProductQueryDto) {
        try {
            YiLiDiPage<SecKillProductDto> secKillProductPage = secKillProductService
                    .findSecKillProducts(secKillProductQueryDto);
            return super.encapsulateMsgBean(secKillProductPage, MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "查询列表失败" : e.getMessage());
        }
    }

    /**
     * 搜索秒杀商品列表(过滤场次已关联的秒杀商品)
     * 
     * @param secKillProductQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillproduct/excludescenerelate/search")
    @ResponseBody
    public MsgBean searchExcludeRelateSecKillProduct(@RequestBody SecKillProductQueryDto secKillProductQueryDto) {
        try {
            YiLiDiPage<SecKillProductDto> secKillProductPage = secKillProductService
                    .findExcludeSecKillSceneRelationSecKillProducts(secKillProductQueryDto);
            return super.encapsulateMsgBean(secKillProductPage, MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "查询列表失败" : e.getMessage());
        }
    }

    /**
     * 编辑秒杀商品信息
     * 
     * @param secKillProductDto
     *            秒杀商品信息
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillproduct/edit")
    @ResponseBody
    public MsgBean editSecKillScene(@RequestBody SecKillProductDto secKillProductDto) {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillProductDto) || ObjectUtils.isNullOrEmpty(secKillProductDto.getId())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getSecKillProductPrice())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getDisplayOrder())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getSecKillCount())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getRemainCount())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getSecKillTime())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getQualifyType())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getLimitOrderCount())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "必填参数不能为空");
            }
            if (secKillProductDto.getLimitOrderCount() > secKillProductDto.getRemainCount()) {
                throw new ProductServiceException("允许秒中商品数量不能大于库存");
            }
            secKillProductDto.setUpdateUserId(super.getUserId());
            secKillProductService.update(secKillProductDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "操作失败" : e.getMessage());
        }
    }

    /**
     * 获取秒杀商品详细信息
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillproduct/detail/{secKillProductId}")
    @ResponseBody
    public MsgBean detailSecKillScene(@PathVariable("secKillProductId") Integer secKillProductId) {
        try {
            SecKillProductDto secKillProductDto = secKillProductService.loadById(secKillProductId);
            return super.encapsulateMsgBean(secKillProductDto, MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "操作失败" : e.getMessage());
        }
    }

    /**
     * 秒杀商品列表,不包含该场次已关联的秒杀商品
     * 
     * @param secKillProductQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/seckillproduct/searchexcludescenerelationproduct")
    @ResponseBody
    public MsgBean searchExcludeSecKillSceneRelationSecKillProduct(
            @RequestBody SecKillProductQueryDto secKillProductQueryDto) {
        try {
            YiLiDiPage<SecKillProductDto> secKillProductPage = secKillProductService
                    .findSecKillProducts(secKillProductQueryDto);
            return super.encapsulateMsgBean(secKillProductPage, MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage() == null ? "查询列表失败" : e.getMessage());
        }
    }
}