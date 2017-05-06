package com.yilidi.o2o.controller.mobile.buyer.system;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.system.GetImageRotateParam;
import com.yilidi.o2o.appvo.buyer.product.AdvertisementVO;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.service.IAdvertisementService;
import com.yilidi.o2o.product.service.dto.AdvertisementDto;
import com.yilidi.o2o.product.service.dto.query.AdvertisementQuery;

/**
 * 图片轮播
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午9:32:37
 */
@Controller("buyerAdvertisementController")
@RequestMapping(value = "/interfaces/buyer")
public class AdvertisementController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IAdvertisementService advertisementService;

    /**
     * 
     * 获取轮播广告
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/system/getimagerotate")
    @ResponseBody
    public ResultParamModel getImageRotate(HttpServletRequest req, HttpServletResponse resp) {
        GetImageRotateParam getImageRotateParam = super.getEntityParam(req, GetImageRotateParam.class);
        String type = getImageRotateParam.getType(); // 广告类型
        AdvertisementQuery query = new AdvertisementQuery();
        Date currentTime = new Date();
        query.setTypeCode(type);
        query.setStartTime(currentTime);
        query.setEndTime(currentTime);
        query.setStatusCode(SystemContext.ProductDomain.ADVERTISEMENTSTATUS_PUBLISHED);
        List<AdvertisementDto> advertisementDtoList = advertisementService.list(query);
        List<AdvertisementVO> advertisementVoList = new ArrayList<AdvertisementVO>();
        for (int i = 0, size = advertisementDtoList.size(); i < size; i++) {
            AdvertisementDto advertisementDto = advertisementDtoList.get(i);
            AdvertisementVO advertisementVO = new AdvertisementVO();
            advertisementVO.setLinkType(ConverterUtils.toClienLinkType(advertisementDto.getLinkType()));
            advertisementVO.setLinkData(advertisementDto.getLinkData());
            advertisementVO.setTitleName(advertisementDto.getAdvertisementName());
            advertisementVO.setImageUrl(StringUtils.toFullImageUrl(advertisementDto.getImageUrl()));
            advertisementVoList.add(advertisementVO);
        }
        return super.encapsulateParam(advertisementVoList, AppMsgBean.MsgCode.SUCCESS, "获取轮播广告接口成功");
    }

}
